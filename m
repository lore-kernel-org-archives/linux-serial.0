From: Mark Salter <msalter@redhat.com>
Subject: [PATCH] Revert "tty: serial: pl011: add ttyAMA for matching pl011 console"
Date: Thu, 16 Mar 2017 12:51:34 -0400
Message-ID: <20170316165134.1501-1-msalter@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <linux@armlinux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-serial@vger.kernel.org

This reverts commit aea9a80ba98a0c9b4de88850260e9fbdcc98360b.

It completely breaks PL011 SPCR support (a console=ttyAMA0 is
required to get a console even with a valid SPCR table).

Aleksey Makarov also noticed this:

  https://lkml.org/lkml/2017/3/1/324

and he is working on a more generalized patch to fix the original
"double printing" problem which this reverted patch was trying to
fix.

  https://lkml.org/lkml/2017/3/15/223

So, let's revert the broken patch and live with the double printing
until Aleksey's patch gets upstream.

Signed-off-by: Mark Salter <msalter@redhat.com>
---
 drivers/tty/serial/amba-pl011.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 8789ea4..a81631f 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2373,9 +2373,8 @@ static int __init pl011_console_match(struct console *co, char *name, int idx,
 	if (strcmp(name, "qdf2400_e44") == 0) {
 		pr_info_once("UART: Working around QDF2400 SoC erratum 44");
 		qdf2400_e44_present = true;
-	} else if (strcmp(name, "pl011") != 0 || strcmp(name, "ttyAMA") != 0) {
+	} else if (strcmp(name, "pl011") != 0)
 		return -ENODEV;
-	}
 
 	if (uart_parse_earlycon(options, &iotype, &addr, &options))
 		return -ENODEV;
-- 
2.9.3
