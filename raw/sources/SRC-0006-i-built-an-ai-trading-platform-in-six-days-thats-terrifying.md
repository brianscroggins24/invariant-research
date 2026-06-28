---
title: "I Built an AI Trading Platform in Six Days. That’s Terrifying"
source: "https://www.bloomberg.com/opinion/articles/2026-04-28/ai-trading-bots-are-creating-a-major-financial-risk?utm_campaign=trueanthem&utm_content=view&utm_medium=social&utm_source=instagram&embedded-checkout=true"
author:
  - "[[Darri Eythorsson]]"
published: 2026-04-28
created: 2026-06-27
description: "A few weeks ago, I sat down at my laptop and built a trading platform. It connects to three financial exchanges. It ingests news from RSS feeds, web searches, Reddit and Twitter. It uses a large language model to analyze markets, estimate probabilities and decide when the price is wrong. It sizes positions using the Kelly criterion. It manages risk across a portfolio. It routes orders intelligently across venues."
tags:
  - "clippings"
---
![How long until there’s nothing but bots?](https://assets.bwbx.io/images/users/iqjWHBFdfxIU/iBhRDQ.CKYDk/v1/2000x1333.webp)

How long until there’s nothing but bots? Photographer: Michael M. Santiago/Getty Images

A few weeks ago, I sat down at my laptop and built a trading platform. It connects to three financial exchanges. It ingests news from RSS feeds, web searches, Reddit and Twitter. It uses a large language model to analyze markets, estimate probabilities and decide when the price is wrong. It sizes positions using the [Kelly criterion](https://www.investopedia.com/articles/trading/04/091504.asp). It manages risk across a portfolio. It routes orders intelligently across venues.

The platform runs around the clock without supervision. It is a production-grade system spanning 50 modules — exchange connectors, risk management, natural-language analysis, order routing, portfolio tracking, etc. It trades prediction markets like Polymarket and Kalshi.

I built it in six days.

I should tell you what I do for a living. I’m a computational hydrologist. I study rivers, snowmelt and glacier mass balance. I have a Ph.D. in Arctic environmental science. I have never traded anything in my life.

I am telling you this because it terrifies me.

The tools I used are available to anyone with a laptop and a monthly subscription. I built my platform using Anthropic’s Claude Code, a terminal-based AI coding agent. I described what I wanted in plain language. The AI wrote the code. I reviewed, directed and iterated. Less than a week later I had a system that, five years ago, would have been the core intellectual property of a funded fintech startup with a team of eight.

According to a March 2026 [survey](https://newsletter.pragmaticengineer.com/p/ai-tooling-2026) of 906 developers by The Pragmatic Engineer, a Substack newsletter by software engineer Gergely Orosz, 71% of those regularly using AI coding agents use Claude Code. SemiAnalysis [estimates](https://newsletter.semianalysis.com/p/claude-code-is-the-inflection-point) that 4% of all public code contributions on GitHub are already authored by it; it’s projected to reach 20% by year’s end.

The effects are already visible in financial markets. Fourteen of Polymarket’s 20 most profitable accounts [are reportedly bots](https://www.financemagnates.com/trending/prediction-markets-are-turning-into-a-bot-playground/). More than 30% of wallets on the platform are operated by AI agents, according to analytics platform [LayerHub, based on CoinDesk’s data.](https://www.coindesk.com/tech/2026/03/15/ai-agents-are-quietly-rewriting-prediction-market-trading)

And virtually every one of these systems is built on the same few foundation models. If not Claude, they likely use OpenAI’s GPT, which shares substantially overlapping training data and reasoning patterns.

Thousands of people, independently building autonomous trading agents in days, all powered by the same small family of AI models, all deploying across the same markets. This is not hypothetical. It is happening now.

So, why does this scare me?

The institutions charged with safeguarding financial stability have identified the risk in principle. The [Financial Stability Board](https://www.fsb.org/2024/11/fsb-assesses-the-financial-stability-implications-of-artificial-intelligence/), the [Bank for International Settlements](https://www.bis.org/speeches/sp260126.htm) and [the Bank of England](https://www.bankofengland.co.uk/financial-stability-in-focus/2025/april-2025) have all warned that widespread use of common AI models could increase market correlations and amplify stress.

Jonathan Hall of the BoE’s Financial Policy Committee has [warned](https://www.bankofengland.co.uk/speech/2024/may/jon-hall-speech-at-the-university-of-exeter) of an emerging “monoculture” in which the financial incentive to use alternative models disappears entirely. A new San Francisco Fed [paper](https://www.frbsf.org/research-and-insights/publications/system-research-new-york-fed/2026/04/artificial-intelligence-monetary-policy-framework-perspective-cyclical-transmission-structural-transition-financial-stability/) uses the phrase “model monocultures” directly, warning they could heighten systemic vulnerabilities.

The problem is that while these warnings are right about the diagnosis, they are wrong about the patient.

The BoE’s own Financial Policy Committee, in an April [assessment](https://www.bankofengland.co.uk/financial-policy-committee-record/2026/april-2026), concluded that the financial system “has not yet adopted more advanced forms of AI, such as generative or agentic AI, in a manner that would present systemic risk” — but acknowledged that risks are “likely to increase, potentially rapidly.”

The committee asked regulators to undertake further work on agentic AI in financial markets. This is the sharpest assessment any major institution has produced. It is also, precisely, the blind spot: The committee is monitoring whether *regulated firms* have adopted agentic AI. It is not monitoring whether thousands of unregulated individuals have built and deployed it independently.

These reports assume that the relevant actors are banks — regulated entities with compliance departments and reporting obligations. The [FSB recommends](https://www.fsb.org/2025/10/monitoring-adoption-of-artificial-intelligence-and-related-vulnerabilities-in-the-financial-sector/) “periodic surveys” and “regulatory reporting” to monitor AI adoption. These are tools designed for a world where you can count the participants.

That world no longer exists. The actors driving correlated AI behavior in financial markets are software engineers, data scientists, Ph.D. students and, well, hydrologists. We have no reporting obligations. No compliance departments. No capital requirements. No circuit breakers. We are invisible to every monitoring framework.

Prediction markets are the proving ground, not the endgame. The same AI coding tools and foundation models deployed on Polymarket are being adopted across foreign exchange, equities and credit markets. Electronic execution accounts for roughly 70% of spot FX activity, with algorithmic systems handling a growing share of that flow.

The barrier that once separated retail hobbyists from institutional-grade trading infrastructure has collapsed. The dynamics I am describing scale directly — as will the risks on a global scale.

Consider a mid-sized economy — Turkey, Brazil, South Africa — carrying fiscal deficits that are defensible by nuanced analysis but look concerning to pattern-matching systems. The country announces an ambiguous budget revision. Thousands of AI agents, running on similar foundation models, simultaneously downgrade their assessment of the country’s creditworthiness.

These agents are not coordinating. They do not know each other exists. But they reach the same conclusion at the same time, because they think in the same way. They begin unwinding positions. B==ond yields s==pike. The currency drops. Other agents detect the volatility and reduce exposure. Spreads of credit default swaps widen. All of this happens in minutes.

The central bank convenes — in a room, with humans, who need to read briefings and reach consensus — while the market has already moved to crisis pricing. By the time they announce intervention, the agents have priced in the intervention, modeled its inadequacy, and moved further.

The agents may be wrong. The initial event may have been genuinely ambiguous. A diverse group of human analysts might have split. But because thousands of AI agents converged on the same interpretation fast enough to change the underlying reality, their wrong assessment becomes self-fulfilling.

Hence a manageable fiscal adjustment becomes a sovereign funding crisis — not because the fundamentals demanded it, but because the machines agreed.

This is different from the Asian crisis of 1997 or the European sovereign debt crisis of 2010. Those were driven by human herds that moved slowly enough to leave intervention points. Agentic herds move at machine speed. There are no gaps. Each decision in the chain is rational.

The aggregate outcome is a system that nobody designed, nobody governs, and that concentrates correlation risk in a way no previous financial technology has achieved. This is a tragedy of the commons, except the commons is global financial stability.

What distinguishes this moment from previous waves of algorithmic trading is primarily the barrier to entry. High-frequency trading required co-located servers and Ph.D. physicists. Quantitative hedge funds required millions in capital. What I demonstrated is that a single person with no relevant background can build a competitive autonomous trading system in less time than it takes to process a mortgage application.

The number of agents in financial markets will not grow linearly. It will grow exponentially. And each agent increases the systemic correlation, because they all descend from the same small family of models.

Is this takeover by the bots inevitable? Perhaps, but there are concrete steps that could be taken now to try to stem the risk. First, AI companies should be required to monitor and disclose the extent to which their models are used for autonomous financial trading. They have the data. They can see the API calls. They are the only actors with visibility into the scale of the swarm.

Second, exchanges should implement correlation-aware circuit breakers — systems that detect when order flow is driven by agents using the same underlying models, and pause trading when that correlation exceeds safe thresholds. Traditional circuit breakers are set off by price movement. The new generation must detect correlated AI behavior before the price moves.

Third, regulators should create a mandatory registration framework, coordinated across major financial jurisdictions, for autonomous trading systems, regardless of capital deployed. A bot trading $10,000 contributes to correlation risk the same way one trading $10 million does.

Finally, small open economies — the Icelands, the New Zealands, the Singapores — should begin building resilience now: larger reserves, pre-negotiated emergency liquidity facilities, and contingency plans for disconnecting sovereign debt markets from automated trading during detected cascades. They cannot reform the global system, but they can prepare for its failures.

I will keep running my trading bot. But I am under no illusion that my edge will last. It’s likely that within a year, prediction markets will be almost entirely machine-versus-machine. Within three years, it will be the same for most liquid financial markets globally. Within five, we will either have adapted our institutions to govern autonomous AI agents making financial decisions at machine speed — or we will have learned the cost of not doing so.

I study rivers. I know something about how small flows become floods. The water is rising.

**More From Bloomberg Opinion:**

- Anthropic’s Mythos [Is a Wake-up Call](https://www.bloomberg.com/opinion/articles/2026-04-15/anthropic-mythos-ai-is-a-wake-up-call-for-everyone-not-just-banks?srnd=undefined) For Everyone, Not Just Banks: Parmy Olson
- SoftBank [Is Going All In](https://www.bloomberg.com/opinion/articles/2026-04-19/ipo-hopes-softbank-is-going-all-in-on-openai-but-at-what-cost?srnd=undefined) on OpenAI, But at What Cost?: Shuli Ren
- AI [Is Coming](https://www.bloomberg.com/opinion/articles/2026-04-22/ai-is-coming-for-our-aging-parents-ready-or-not) for Our Aging Parents, Ready or Not: Catherine Thorbecke

**Want more Bloomberg Opinion?** **OPIN \<GO>** **. Or you can subscribe to** [**our daily newsletter**](https://www.bloomberg.com/account/newsletters/opinion-today)**.**

*(Corrects 19th paragraph of article published April 28 to say electronic execution accounts for roughly 70% of spot FX activity.)*