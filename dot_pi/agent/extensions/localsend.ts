import { readFile, readdir, stat } from "node:fs/promises";
import { homedir, tmpdir } from "node:os";
import { extname, join } from "node:path";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import type { ImageContent } from "@earendil-works/pi-ai";

const DIR = join(homedir(), "localsend");

const MIMES: Record<string, string> = {
	".jpg": "image/jpeg",
	".jpeg": "image/jpeg",
	".png": "image/png",
	".gif": "image/gif",
	".webp": "image/webp",
};

// Recursive, newest-first listing of regular files in DIR
async function filesByAge(dir: string): Promise<string[]> {
	const out: { path: string; mtime: number }[] = [];
	const walk = async (d: string): Promise<void> => {
		let entries;
		try {
			entries = await readdir(d, { withFileTypes: true });
		} catch {
			return;
		}
		for (const e of entries) {
			if (e.name.startsWith(".")) continue; // skip .DS_Store etc.
			const p = join(d, e.name);
			if (e.isDirectory()) {
				await walk(p);
			} else {
				try {
					out.push({ path: p, mtime: (await stat(p)).mtimeMs });
				} catch {
					// file vanished between readdir and stat
				}
			}
		}
	};
	await walk(dir);
	return out.sort((a, b) => b.mtime - a.mtime).map((f) => f.path);
}

// Leading args that select files: "2", "1 2", "1,3", "1-4".
// Everything after them is treated as the question.
function parseSelection(args: string): { indices: number[]; rest: string } {
	const tokens = args.trim().split(/\s+/).filter(Boolean);
	const indices: number[] = [];
	let i = 0;
	while (i < tokens.length) {
		const t = tokens[i];
		if (/^\d+$/.test(t)) {
			indices.push(Number.parseInt(t, 10));
		} else if (/^\d+(,\d+)+$/.test(t)) {
			for (const part of t.split(",")) indices.push(Number.parseInt(part, 10));
		} else if (/^\d+-\d+$/.test(t)) {
			const [a, b] = t.split("-").map((n) => Number.parseInt(n, 10));
			for (let n = Math.min(a, b); n <= Math.max(a, b); n++) indices.push(n);
		} else {
			break;
		}
		i++;
	}
	return { indices, rest: tokens.slice(i).join(" ") };
}

export default function (pi: ExtensionAPI) {
	pi.registerCommand("loc", {
		description: "Attach newest file(s) from ~/localsend (usage: /loc [n…] [question])",
		handler: async (args, ctx) => {
			const { indices, rest: question } = parseSelection(args);
			const picked = indices.length > 0 ? indices : [1];

			const files = await filesByAge(DIR);
			if (files.length === 0) {
				ctx.ui.notify("~/localsend is empty", "warning");
				return;
			}

			// Resolve indices (1 = newest) to unique paths
			const paths: string[] = [];
			for (const n of picked) {
				if (n < 1 || n > files.length) {
					ctx.ui.notify(`/loc ${n}: only ${files.length} file(s) in ~/localsend`, "warning");
					return;
				}
				if (!paths.includes(files[n - 1])) paths.push(files[n - 1]);
			}

			const images: ImageContent[] = [];
			const lines: string[] = [];
			for (const path of paths) {
				const ext = extname(path).toLowerCase();
				try {
					let image: ImageContent | undefined;
					if (MIMES[ext]) {
						image = {
							type: "image",
							data: (await readFile(path)).toString("base64"),
							mimeType: MIMES[ext],
						};
					} else if (ext === ".heic" || ext === ".heif") {
						// iPhone photos arrive as HEIC; providers only accept jpeg/png/gif/webp.
						// macOS sips converts to a temp JPEG.
						const out = join(
							tmpdir(),
							`localsend-${Date.now()}-${Math.random().toString(36).slice(2)}.jpg`,
						);
						const res = await pi.exec("sips", ["-s", "format", "jpeg", path, "--out", out]);
						if (res.code === 0) {
							image = {
								type: "image",
								data: (await readFile(out)).toString("base64"),
								mimeType: "image/jpeg",
							};
						} else {
							ctx.ui.notify(`sips failed on ${path}: ${res.stderr.trim() || res.stdout.trim()}`, "warning");
						}
					}
					if (image) {
						images.push(image);
						lines.push(`- ${path} (attached as image)`);
					} else {
						// Non-image: pi gets the path and can read it with its tools.
						lines.push(`- ${path}`);
					}
				} catch (err) {
					ctx.ui.notify(`Could not read ${path}: ${String(err)}`, "error");
					return;
				}
			}

			const fileList = `~/localsend files:\n${lines.join("\n")}`;
			const text = question ? `${question}\n\n${fileList}` : fileList;

			pi.sendUserMessage(
				images.length > 0 ? [{ type: "text", text }, ...images] : text,
				ctx.isIdle() ? undefined : { deliverAs: "followUp" as const },
			);
		},
	});
}
