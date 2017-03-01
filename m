From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v3] Revert "tty: serial: pl011: add ttyAMA for matching pl011 console"
Date: Wed,  1 Mar 2017 18:23:02 +0300
Message-ID: <20170301152304.29635-1-aleksey.makarov@linaro.org>
References: <20170301122602.30025-1-aleksey.makarov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170301122602.30025-1-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Russell King <linux@armlinux.org.uk>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>
List-Id: linux-serial@vger.kernel.org

The original patch makes the condition always true, so it is wrong.

It masks (but not fixes) the bug described in the commit message
but introduces a regression (no console is selected by SPCR)
in regular (no 'console=ttyAMA') case.

s/||/&&/ would not fix the problem as the root cause was identified
incorrectly.

This reverts commit aea9a80ba98a0c9b4de88850260e9fbdcc98360b.

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---

v3: fix commit message (Robin Murphy)
v2: add Signed-off-by:

 drivers/tty/serial/amba-pl011.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 8789ea423ccf..56f92d7348bf 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2373,7 +2373,7 @@ static int __init pl011_console_match(struct console *co, char *name, int idx,
 	if (strcmp(name, "qdf2400_e44") == 0) {
 		pr_info_once("UART: Working around QDF2400 SoC erratum 44");
 		qdf2400_e44_present = true;
-	} else if (strcmp(name, "pl011") != 0 || strcmp(name, "ttyAMA") != 0) {
+	} else if (strcmp(name, "pl011") != 0) {
 		return -ENODEV;
 	}
 
-- 
2.11.1
