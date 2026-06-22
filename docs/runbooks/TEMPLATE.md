
# Runbook Template

## Purpose

Describe what this runbook is used for.

Example:
This runbook is used when a service is unavailable, unstable, or behaving unexpectedly.

## Symptoms

Describe how the problem appears.

Examples:
- Application returns errors
- Service is not responding
- Deployment failed
- Container keeps restarting
- High latency or timeouts

## Impact

Describe what is affected.

Questions to answer:
- Is this production, staging, or local?
- Are users affected?
- Is there business impact?
- Is there SLA risk?
- Is data processing or deployment blocked?

## Initial Checks

List the first things to verify before making changes.

Examples:
- Check recent deployments or configuration changes
- Check service status
- Check logs
- Check CPU, memory, disk usage
- Check network connectivity
- Check environment variables or secrets


## Likely Causes

List possible root causes.

Examples:

Wrong configuration
Missing environment variable
Expired or missing secret
Disk full
Service dependency unavailable
Failed deployment
Permission issue
Network/DNS issue
Application bug
Fix / Recovery Steps

## Describe the safe recovery process.

Example structure:

Confirm the affected service/environment.
Check logs and identify the error.
Verify recent changes.
Apply the safest fix or rollback.
Restart only if necessary and approved.
Validate the service after the fix.
Communicate status to the team.
Validation

## Describe how to confirm that the issue is resolved.

Examples:

Health endpoint returns 200 OK
Logs no longer show errors
Pipeline/deployment succeeds
Pod/container is stable
Users or dependent services can access the application
Prevention

## Describe how to reduce the chance of this happening again.

Examples:

Add monitoring or alerting
Improve health checks
Add pipeline validation
Improve documentation

## Commands

```bash
# Check service status
systemctl status <service-name>

# Check logs
journalctl -u <service-name> --since "30 minutes ago"

# Check disk
df -h

# Check memory
free -h

# Check processes
ps aux | grep <process-name>

# Check HTTP endpoint
curl -v http://localhost:5000/health

Add resource limits
Rotate or validate secrets
Add rollback procedure
Notes

Add anything specific to this system, environment, or project.
