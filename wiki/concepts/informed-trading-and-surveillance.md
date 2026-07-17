---
page_id: CONCEPT-0005
title: Informed Trading and Surveillance
page_type: concept
status: reviewed
created_at: 2026-07-17
updated_at: 2026-07-17
sources:
  - SRC-0036
  - SRC-0037
  - SRC-0039
related_pages:
  - CONCEPT-0004
  - STRATEGY-0002
  - CONCEPT-0002
  - CONCEPT-0003
  - PLATFORM-0001
tags:
  - informed-trading
  - surveillance
  - anomalies
  - insider-trading
  - prediction-markets
---

# Informed Trading and Surveillance

## Purpose

Synthesize the reviewed evidence on anomaly screens, informed trading, and surveillance limits. This page keeps empirical screens, legal analysis, and policy recommendations separate so that suspicious behavior is not converted into a legal finding.

## Scope and Terminology

- Anomalous or suspicious trading is a screening label, not proof of illegal conduct.
- Informed trading is used in the reviewed papers as a descriptive category for trades that appear to use information advantages; it is not a legal conclusion by itself.
- Surveillance refers to identifying patterns for review, not to proving liability or identity.
- The reviewed sources do not justify collapsing wallet, account, and human identity into one object.

## Empirical Screening

- `SRC-0039` builds a composite score from bet-size anomalies, profitability, pre-event timing, and directional concentration to flag suspicious wallet-market pairs. [CLM-0164] [CLM-0165]
- The paper validates the screen with monotonic win-rate patterns, permutation tests, and an aggregate profit measure across profitable wallet-market pairs. [CLM-0168]
- `SRC-0039` also presents case studies that illustrate how informational advantages may appear in prediction markets. [CLM-0166]

## What the Screen Does and Does Not Prove

- `SRC-0039` states that it cannot observe an entire portfolio position, may miss multiple blockchain identifiers, and may be looking at a profitable trade that is only one leg of a larger strategy or hedge. [CLM-0167]
- The same limitation statement says the authors cannot rule out coincidental patterns rather than material nonpublic information. [CLM-0167]
- Repository synthesis: a high anomaly score is evidence for review, not proof of insider trading, illegality, or a stable trader identity.

## Identity and Clustering Limits

- `SRC-0036` aggregates by wallet address and warns that some traders may operate multiple wallets, so wallet-level measurements can fragment a single actor's activity. [CLM-0143]
- `SRC-0037` likewise treats account-level skill as a statistical category rather than a direct one-account-one-human mapping. [CLM-0153]
- Repository synthesis: surveillance should treat account, wallet, and human identity as related but not identical units.

## Legal and Policy Framing

- `SRC-0039` concludes that classical and misappropriation theories of securities fraud do not map cleanly onto prediction-market event contracts and that Rule 180.1 is narrower than SEC Rule 10b-5 in critical respects. [CLM-0169]
- The same paper argues for platform-level registration, surveillance obligations, contract-level rules targeting high-risk information channels, and an extended misappropriation theory for decentralized platforms. [CLM-0170]
- That analysis is doctrinal and policy-oriented; it is not current compliance advice and it does not settle the legal status of every future trading pattern.

## What This Synthesis Establishes

- Prediction-market surveillance requires lower-bound anomaly screening plus careful identity limits.
- Case-study evidence and statistical screens can support a review pipeline without proving culpability.
- Legal framing and empirical screening are distinct evidence classes and should remain separate in downstream synthesis.

## What This Synthesis Does Not Establish

- It does not establish that every suspicious trade is illegal.
- It does not establish that a profitable trade proves insider status.
- It does not establish that current doctrine already resolves prediction-market surveillance questions.
- It does not establish a deterministic identification rule for individual humans or firms.

## Related Pages

- [Market Accuracy and Price Discovery](../concepts/market-accuracy-and-price-discovery.md)
- [Prediction Market Mechanics](../concepts/prediction-market-mechanics.md)
- [Arbitrage and Execution Risk](../strategies/arbitrage-and-execution-risk.md)
- [Polymarket](../platforms/polymarket.md)
- [Kalshi](../platforms/kalshi.md)

## Sources and Claims

- `SRC-0036`: [CLM-0143]
- `SRC-0037`: [CLM-0153]
- `SRC-0039`: [CLM-0164], [CLM-0165], [CLM-0166], [CLM-0167], [CLM-0168], [CLM-0169], [CLM-0170]
