NCS := ncs
SYSLOG_LISTENER_PORT := 20514


.PHONY: all build start stop clean syslog-udp-listener syslog-tcp-listener


all: build

build: $(NCS)

$(NCS):
	ncs-setup --dest $@
	cp ncs.conf $@

start: $(NCS)
	(cd $(NCS); ncs -c ncs.conf)
	@echo "ncs started"

# Don't fail target if ncs isn't running and can't be stopped
stop:
	ncs --stop && echo "ncs stopped" || echo "ncs not running"

syslog-udp-listener:
	nc -l -u -p $(SYSLOG_LISTENER_PORT)

syslog-tcp-listener:
	nc -l -t -p $(SYSLOG_LISTENER_PORT)

clean:
	rm -rf $(NCS)
