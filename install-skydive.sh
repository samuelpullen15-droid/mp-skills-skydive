#!/bin/bash
# mp-skills-skydive installer — usage: install-skydive.sh <eng|research|content>
ROLE="${1:-content}"
REPO_DIR="$HOME/workspace/mp-skills-skydive"
SKILLS_DST="$HOME/.pi/agent/skills"
mkdir -p "$SKILLS_DST"
[ -d "$REPO_DIR" ] || git clone --depth 1 --filter=blob:none https://github.com/samuelpullen15-droid/mp-skills-skydive "$REPO_DIR"
cd "$REPO_DIR" || exit 1

ENG="implement implement-spec to-spec to-tickets wayfinder triage retro ask-matt grill-with-docs code-review codebase-design diagnosing-bugs domain-modeling improve-codebase-architecture prototype research tdd-pocock pr wizard"
RESEARCH="research grill-me writing-for-agents triage to-questionnaire"
CONTENT="writing-for-agents handoff"

case "$ROLE" in
  eng) LIST="$ENG" ;;
  research) LIST="$RESEARCH" ;;
  content) LIST="$CONTENT" ;;
  *) echo "role must be eng|research|content"; exit 1 ;;
esac

count=0; missing=""
for s in $LIST; do
  found=""
  for b in engineering productivity misc; do
    [ -d "skills/$b/$s" ] && cp -r "skills/$b/$s" "$SKILLS_DST/" && count=$((count+1)) && found=1 && break
  done
  [ -z "$found" ] && missing="$missing $s"
done
echo "installed $count skills for role: $ROLE"
[ -n "$missing" ] && echo "MISSING:$missing"
