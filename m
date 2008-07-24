From: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: [PATCHv2] cpm_uart: Fix break generation
Date: Thu, 24 Jul 2008 16:21:58 +0200
Message-ID: <200807241621.58719.laurentp@cse-semaphore.com>
References: <200806261338.19358.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailrelay005.isp.belgacom.be ([195.238.6.171]:36024 "EHLO
	mailrelay005.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751539AbYGXOWB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 24 Jul 2008 10:22:01 -0400
In-Reply-To: <200806261338.19358.laurentp@cse-semaphore.com>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linuxppc-dev@ozlabs.org
Cc: linux-serial@vger.kernel.org, galak@kernel.crashing.org, scottwood@freescale.com

When generating a break condition on a serial port, the CPM must be told
beforehand how long the break should be. Unfortunately, this information is
not available through the current serial break handling API. This patch works
around the problem by requesting a 32767 characters break followed by a 0
characters break after the requested duration. The CPM will stop the first
break when the second one is requested. This might not work with future CPM
revisions.
---
 drivers/serial/cpm_uart/cpm_uart_core.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index c29d87d..aa0a284 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -269,13 +269,19 @@ static void cpm_uart_break_ctl(struct uart_port *port, int break_state)
 {
 	struct uart_cpm_port *pinfo = (struct uart_cpm_port *)port;
+	u16 __iomem *brkcr = IS_SMC(pinfo) ? &pinfo->smcup->smc_brkcr
+				: &pinfo->sccup->scc_brkcr;
 
 	pr_debug("CPM uart[%d]:break ctrl, break_state: %d\n", port->line,
 		break_state);
 
-	if (break_state)
+	if (break_state) {
+		out_be16(brkcr, 32767);
 		cpm_line_cr_cmd(pinfo, CPM_CR_STOP_TX);
-	else
+	} else {
+		out_be16(brkcr, 0);
+		cpm_line_cr_cmd(pinfo, CPM_CR_STOP_TX);
 		cpm_line_cr_cmd(pinfo, CPM_CR_RESTART_TX);
+	}
 }
 
 /*
-- 
1.5.0

-- 
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
F +32 (2) 387 42 75
