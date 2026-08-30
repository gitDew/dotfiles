import type { ExtensionAPI, ExtensionContext } from "@earendil-works/pi-coding-agent";

const LONG_CONTEXT_THRESHOLD = 272_000;

function formatTokens(tokens: number): string {
	if (tokens < 1_000) return `${tokens}`;
	if (tokens < 1_000_000) return `${Math.round(tokens / 1_000)}K`;
	return `${(tokens / 1_000_000).toFixed(1)}M`;
}

function updateContextStatus(ctx: ExtensionContext): void {
	if (!ctx.hasUI) return;

	const usage = ctx.getContextUsage();
	if (!usage || usage.tokens === null) {
		ctx.ui.setStatus("context-status", "? CTX");
		return;
	}

	const tokens = usage.tokens;
	const text =
		tokens > LONG_CONTEXT_THRESHOLD
			? `${formatTokens(tokens)} CTX > 272K`
			: `${formatTokens(tokens)} CTX`;

	ctx.ui.setStatus(
		"context-status",
		tokens > LONG_CONTEXT_THRESHOLD
			? ctx.ui.theme.fg("error", text)
			: ctx.ui.theme.fg("dim", text),
	);
}

export default function (pi: ExtensionAPI) {
	pi.on("session_start", (_event, ctx) => {
		updateContextStatus(ctx);
	});

	// This runs when user, assistant, and tool-result messages are finalized.
	// For a new user message, Pi's context usage includes its estimated size.
	pi.on("message_end", (_event, ctx) => {
		updateContextStatus(ctx);
	});

	pi.on("turn_end", (_event, ctx) => {
		updateContextStatus(ctx);
	});

	pi.on("session_compact", (_event, ctx) => {
		updateContextStatus(ctx);
	});
}
