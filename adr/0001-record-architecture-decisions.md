# ADR-0001: Record architecture decisions

| | |
|---|---|
| **Status** | Accepted |
| **Date** | _(fill in)_ |
| **Deciders** | _(your name)_, Technology Analyst |
| **Consulted** | Priya Raman (IT Manager) |
| **Supersedes** | — |
| **Superseded by** | — |

---

## Context

The Northgate cloud migration will involve a large number of decisions over fourteen
months — which region, which compute model, which database platform, how identity is
federated, how integrations are built, what disaster recovery pattern is affordable.

Two problems arise if these are not recorded.

**The first is institutional.** Six months after a decision is made, nobody remembers
why. A new team member, or the same team member in a different frame of mind, questions
a design choice. Without a record, the discussion restarts from scratch, or worse, the
decision gets reversed without anyone realising which constraint originally drove it.
Northgate already has a live example of this: nobody can explain why the ClinicSchedule
database sits on separate physical hardware from the web tier, and nobody can explain
the NTFS permission structure on the file server, because the people who decided are gone.

**The second is quality.** Being required to write down the options you rejected and the
consequences you accepted changes how you decide. A decision that cannot survive being
written down is usually a decision that has not been thought through.

There is a well-established lightweight format for this — the Architecture Decision
Record, popularised by Michael Nygard — that costs about twenty minutes per decision.

## Decision

We will record every architecturally significant decision as a numbered Architecture
Decision Record in `adr/`, using the template in `adr/0000-adr-template.md`.

**A decision is architecturally significant if it is expensive or disruptive to reverse.**
Choosing Azure SQL Database over Managed Instance is significant. Choosing a VM name is not.

Rules:

- ADRs are numbered sequentially and never renumbered
- ADRs are **immutable once accepted**. A decision that changes is not edited — a new ADR
  is written that supersedes it, and both are updated with a cross-reference. The history
  of how thinking changed is part of the value.
- Every ADR must record the options that were **rejected** and why
- Every ADR must record **negative consequences**. An ADR with no downsides is not a
  decision record, it is a justification, and a reviewer will read it as one.
- ADRs are written in plain language and are readable by someone who was not in the room
- Design documents link to the ADRs that produced their decisions rather than repeating
  the reasoning

## Consequences

**Positive.**
- Decisions become auditable. When the Privacy Officer asks why patient data is in
  Canada Central, there is a dated document with the reasoning.
- Onboarding is faster. Reading the ADR log is the fastest way to understand a system.
- The act of writing improves the decision.
- The ADR log is a durable artifact that outlives any individual on the project.

**Negative.**
- Roughly twenty minutes of overhead per decision.
- There is a judgement call about what counts as significant, and it will sometimes be
  made wrongly in both directions.
- Discipline is required. An ADR log that stops in month three is worse than none, because
  it implies the recorded decisions are current when they are not.

**Mitigation.** ADRs are written at the point of decision, not retrospectively at the end
of a phase. Writing an ADR after the fact produces a rationalisation rather than a record.

## Alternatives considered

**Record decisions in the solution architecture document.** Rejected. A single evolving
document loses history — you see the current state but not what was rejected or when
thinking changed.

**Record decisions in meeting minutes.** Rejected. Minutes are chronological and
unsearchable by topic. Nobody reads them six months later.

**Do not record decisions.** Rejected. This is the current Northgate practice and its
cost is directly visible in the current state assessment.

## References

- Michael Nygard, *Documenting Architecture Decisions* (2011)
- `adr/0000-adr-template.md`
