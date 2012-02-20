From: Kalle Vahlman <kalle.vahlman@movial.com>
Subject: [PATCH] serial/amba-pl011: Return early in deadlock work-around if there is no tty
Date: Mon, 20 Feb 2012 08:07:04 +0200
Message-ID: <1329718024-23623-1-git-send-email-kalle.vahlman@movial.com>
Mime-Version: 1.0
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:46935 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751890Ab2BTGID (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 20 Feb 2012 01:08:03 -0500
Received: by mail-lpp01m010-f53.google.com with SMTP id d3so6432055lah.12
        for <linux-serial@vger.kernel.org>; Sun, 19 Feb 2012 22:08:02 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: stable@kernel.org, Kalle Vahlman <kalle.vahlman@movial.com>

The first amba port does not always have an attached tty, which will
result in a crash if the work-around is activated.

This seems to be the case for example on Snowball which has no modem
hw, which seems to be the main use-case for this work-around.
---
 drivers/tty/serial/amba-pl011.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 6800f5f..c3ffbed 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1061,6 +1061,10 @@ static void pl011_lockup_wa(unsigned long data)
 	int buf_empty_retries = 200;
 	int loop;
 
+	/* Exit early if there is no tty */
+	if (!tty)
+		return;
+
 	/* Stop HCI layer from submitting data for tx */
 	tty->hw_stopped = 1;
 	while (!uart_circ_empty(xmit)) {
-- 
1.7.1

