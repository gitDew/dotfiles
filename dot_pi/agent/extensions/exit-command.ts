/**
 * Exit Command Extension
 *
 * Adds an /exit command that works the same as /quit:
 * requests a graceful shutdown of pi.
 */

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export default function (pi: ExtensionAPI) {
	pi.registerCommand("exit", {
		description: "Exit pi cleanly (same as /quit)",
		handler: async (_args, ctx) => {
			ctx.shutdown();
		},
	});
}
