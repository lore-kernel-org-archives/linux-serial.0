From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] serial: bfin_5xx: drop unused "line" variable
Date: Wed, 27 Oct 2010 01:04:32 -0400
Message-ID: <1288155872-10639-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:53605 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751132Ab0J0FEX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Oct 2010 01:04:23 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: uclinux-dist-devel@blackfin.uclinux.org

A recent clean up deleted the usage of this var, but not the decl.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/serial/bfin_5xx.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/bfin_5xx.c b/drivers/serial/bfin_5xx.c
index a9eff2b..0774ae9 100644
--- a/drivers/serial/bfin_5xx.c
+++ b/drivers/serial/bfin_5xx.c
@@ -959,7 +959,6 @@ bfin_serial_verify_port(struct uart_port *port, struct serial_struct *ser)
  */
 static void bfin_serial_set_ldisc(struct uart_port *port, int ld)
 {
-	int line = port->line;
 	unsigned short val;
 
 	switch (ld) {
-- 
1.7.3.2

