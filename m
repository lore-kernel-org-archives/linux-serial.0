Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E09C28D13
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE50464E76
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241521AbhCCCQ5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Mar 2021 21:16:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:39912 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1835888AbhCBGYp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Mar 2021 01:24:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 983A4B02A;
        Tue,  2 Mar 2021 06:22:19 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 24/44] tty: nozomi, remove useless debug prints
Date:   Tue,  2 Mar 2021 07:21:54 +0100
Message-Id: <20210302062214.29627-24-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302062214.29627-1-jslaby@suse.cz>
References: <20210302062214.29627-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

These are either commented out or can be printed by tracing mechanisms.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/nozomi.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index 1ec975d66528..9a2d78ace49b 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -777,7 +777,6 @@ static int receive_data(enum port_type index, struct nozomi *dc)
 	int i, ret;
 
 	size = __le32_to_cpu(readl(addr));
-	/*  DBG1( "%d bytes port: %d", size, index); */
 
 	if (tty && tty_throttled(tty)) {
 		DBG1("No room in tty, don't read data, don't ack interrupt, "
@@ -1308,8 +1307,6 @@ static int nozomi_card_init(struct pci_dev *pdev,
 	int ndev_idx;
 	int i;
 
-	dev_dbg(&pdev->dev, "Init, new card found\n");
-
 	for (ndev_idx = 0; ndev_idx < ARRAY_SIZE(ndevs); ndev_idx++)
 		if (!ndevs[ndev_idx])
 			break;
@@ -1443,8 +1440,6 @@ static void tty_exit(struct nozomi *dc)
 {
 	unsigned int i;
 
-	DBG1(" ");
-
 	for (i = 0; i < MAX_PORT; ++i)
 		tty_port_tty_hangup(&dc->port[i].port, false);
 
@@ -1609,8 +1604,6 @@ static int ntty_write(struct tty_struct *tty, const unsigned char *buffer,
 	struct port *port = tty->driver_data;
 	unsigned long flags;
 
-	/* DBG1( "WRITEx: %d, index = %d", count, index); */
-
 	if (!dc || !port)
 		return -ENODEV;
 
@@ -1736,8 +1729,6 @@ static int ntty_ioctl(struct tty_struct *tty,
 	struct port *port = tty->driver_data;
 	int rval = -ENOIOCTLCMD;
 
-	DBG1("******** IOCTL, cmd: %d", cmd);
-
 	switch (cmd) {
 	case TIOCMIWAIT: {
 		struct async_icount cprev = port->tty_icount;
@@ -1763,7 +1754,6 @@ static void ntty_unthrottle(struct tty_struct *tty)
 	struct nozomi *dc = get_dc_by_tty(tty);
 	unsigned long flags;
 
-	DBG1("UNTHROTTLE");
 	spin_lock_irqsave(&dc->spin_mutex, flags);
 	enable_transmit_dl(tty->index % MAX_PORT, dc);
 	set_rts(tty, 1);
@@ -1780,7 +1770,6 @@ static void ntty_throttle(struct tty_struct *tty)
 	struct nozomi *dc = get_dc_by_tty(tty);
 	unsigned long flags;
 
-	DBG1("THROTTLE");
 	spin_lock_irqsave(&dc->spin_mutex, flags);
 	set_rts(tty, 0);
 	spin_unlock_irqrestore(&dc->spin_mutex, flags);
-- 
2.30.1

