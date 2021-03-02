Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95286C4332B
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4176C6023B
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348270AbhCCCRM (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Mar 2021 21:17:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:39622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1835903AbhCBGZY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Mar 2021 01:25:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CF6DEB066;
        Tue,  2 Mar 2021 06:22:22 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 44/44] tty: make everyone's write_room return >= 0
Date:   Tue,  2 Mar 2021 07:22:14 +0100
Message-Id: <20210302062214.29627-44-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302062214.29627-1-jslaby@suse.cz>
References: <20210302062214.29627-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The tty line disciplines don't expect tty_operations::write_room to
return negative values. Fix the five drivers which violate this.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/staging/gdm724x/gdm_tty.c | 2 +-
 drivers/tty/ipwireless/tty.c      | 4 ++--
 drivers/tty/n_gsm.c               | 2 +-
 drivers/tty/vcc.c                 | 2 +-
 drivers/usb/serial/mos7720.c      | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
index 6e813693a766..0ccc8c24e754 100644
--- a/drivers/staging/gdm724x/gdm_tty.c
+++ b/drivers/staging/gdm724x/gdm_tty.c
@@ -188,7 +188,7 @@ static int gdm_tty_write_room(struct tty_struct *tty)
 	struct gdm *gdm = tty->driver_data;
 
 	if (!GDM_TTY_READY(gdm))
-		return -ENODEV;
+		return 0;
 
 	return WRITE_SIZE;
 }
diff --git a/drivers/tty/ipwireless/tty.c b/drivers/tty/ipwireless/tty.c
index 1836746991b5..99bb2f149ff5 100644
--- a/drivers/tty/ipwireless/tty.c
+++ b/drivers/tty/ipwireless/tty.c
@@ -235,10 +235,10 @@ static int ipw_write_room(struct tty_struct *linux_tty)
 
 	/* FIXME: Exactly how is the tty object locked here .. */
 	if (!tty)
-		return -ENODEV;
+		return 0;
 
 	if (!tty->port.count)
-		return -EINVAL;
+		return 0;
 
 	room = IPWIRELESS_TX_QUEUE_SIZE - tty->tx_bytes_queued;
 	if (room < 0)
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index da10e975829f..9e12f9cb1a98 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3048,7 +3048,7 @@ static int gsmtty_write_room(struct tty_struct *tty)
 {
 	struct gsm_dlci *dlci = tty->driver_data;
 	if (dlci->state == DLCI_CLOSED)
-		return -EINVAL;
+		return 0;
 	return TX_SIZE - kfifo_len(&dlci->fifo);
 }
 
diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index 3106df98558a..0a3a71e14df4 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -878,7 +878,7 @@ static int vcc_write_room(struct tty_struct *tty)
 	port = vcc_get_ne(tty->index);
 	if (unlikely(!port)) {
 		pr_err("VCC: write_room: Failed to find VCC port\n");
-		return -ENODEV;
+		return 0;
 	}
 
 	num = VCC_BUFF_LEN - port->chars_in_buffer;
diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
index 701dfb32b129..bb3d39307d93 100644
--- a/drivers/usb/serial/mos7720.c
+++ b/drivers/usb/serial/mos7720.c
@@ -1042,7 +1042,7 @@ static int mos7720_write_room(struct tty_struct *tty)
 
 	mos7720_port = usb_get_serial_port_data(port);
 	if (mos7720_port == NULL)
-		return -ENODEV;
+		return 0;
 
 	/* FIXME: Locking */
 	for (i = 0; i < NUM_URBS; ++i) {
-- 
2.30.1

