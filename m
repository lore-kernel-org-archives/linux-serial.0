From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH] tty: serial: pl011: add ttyAMA for matching pl011 console
Date: Wed,  1 Feb 2017 15:46:38 +0000
Message-ID: <1485963998-921-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, Aleksey Makarov <aleksey.makarov@linaro.org>
List-Id: linux-serial@vger.kernel.org

Commit c7cef0a84912 ("console: Add extensible console matching") added
match() method to struct console which allows the console to perform
console command line matching instead of (or in addition to) default
console matching (ie., by fixed name and index).

Commit ad1696f6f09d ("ACPI: parse SPCR and enable matching console")
introduced support for SPCR as matching console.

Commit 10879ae5f12e ("serial: pl011: add console matching function")
added the match method for pl011 console which checks for the console
string to be "pl011"

Now on a platform which has both SPCR in the ACPI tables and ttyAMA in
the command line, the ttyAMA is chosen as "selected console" but it
doesn't pass the matching console method which results in CON_CONSDEV
not being set on the "selected console".

As a result of that, the bootconsole(SPCR in the above case) is not
unregistered and all the beginning boot messages are seen twice.

This patch adds "ttyAMA" so that it's considered to match pl011 console.

Fixes: 10879ae5f12e ("serial: pl011: add console matching function")
Cc: Russell King <linux@armlinux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: Aleksey Makarov <aleksey.makarov@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/tty/serial/amba-pl011.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 963c2e5feedd..533b18d4a587 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2340,7 +2340,7 @@ static int __init pl011_console_match(struct console *co, char *name, int idx,
 	resource_size_t addr;
 	int i;

-	if (strcmp(name, "pl011") != 0)
+	if (strcmp(name, "pl011") != 0 || strcmp(name, "ttyAMA") != 0)
 		return -ENODEV;

 	if (uart_parse_earlycon(options, &iotype, &addr, &options))
--
2.7.4
