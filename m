Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6505C28CFB
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62C9764E76
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240645AbhCCCQp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Mar 2021 21:16:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:39916 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1835890AbhCBGYp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Mar 2021 01:24:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3FE4CB02E;
        Tue,  2 Mar 2021 06:22:20 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH 28/44] tty: vcc, remove useless tty checks
Date:   Tue,  2 Mar 2021 07:21:58 +0100
Message-Id: <20210302062214.29627-28-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302062214.29627-1-jslaby@suse.cz>
References: <20210302062214.29627-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

All these functions are called with a valid tty pointer, no need to
check that.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 drivers/tty/vcc.c | 45 ---------------------------------------------
 1 file changed, 45 deletions(-)

diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index a6cdbd170a61..04a792749816 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -726,11 +726,6 @@ static int vcc_open(struct tty_struct *tty, struct file *vcc_file)
 {
 	struct vcc_port *port;
 
-	if (unlikely(!tty)) {
-		pr_err("VCC: open: Invalid TTY handle\n");
-		return -ENXIO;
-	}
-
 	if (tty->count > 1)
 		return -EBUSY;
 
@@ -764,11 +759,6 @@ static int vcc_open(struct tty_struct *tty, struct file *vcc_file)
 
 static void vcc_close(struct tty_struct *tty, struct file *vcc_file)
 {
-	if (unlikely(!tty)) {
-		pr_err("VCC: close: Invalid TTY handle\n");
-		return;
-	}
-
 	if (unlikely(tty->count > 1))
 		return;
 
@@ -796,11 +786,6 @@ static void vcc_hangup(struct tty_struct *tty)
 {
 	struct vcc_port *port;
 
-	if (unlikely(!tty)) {
-		pr_err("VCC: hangup: Invalid TTY handle\n");
-		return;
-	}
-
 	port = vcc_get_ne(tty->index);
 	if (unlikely(!port)) {
 		pr_err("VCC: hangup: Failed to find VCC port\n");
@@ -830,11 +815,6 @@ static int vcc_write(struct tty_struct *tty, const unsigned char *buf,
 	int tosend = 0;
 	int rv = -EINVAL;
 
-	if (unlikely(!tty)) {
-		pr_err("VCC: write: Invalid TTY handle\n");
-		return -ENXIO;
-	}
-
 	port = vcc_get_ne(tty->index);
 	if (unlikely(!port)) {
 		pr_err("VCC: write: Failed to find VCC port");
@@ -895,11 +875,6 @@ static int vcc_write_room(struct tty_struct *tty)
 	struct vcc_port *port;
 	u64 num;
 
-	if (unlikely(!tty)) {
-		pr_err("VCC: write_room: Invalid TTY handle\n");
-		return -ENXIO;
-	}
-
 	port = vcc_get_ne(tty->index);
 	if (unlikely(!port)) {
 		pr_err("VCC: write_room: Failed to find VCC port\n");
@@ -918,11 +893,6 @@ static int vcc_chars_in_buffer(struct tty_struct *tty)
 	struct vcc_port *port;
 	u64 num;
 
-	if (unlikely(!tty)) {
-		pr_err("VCC: chars_in_buffer: Invalid TTY handle\n");
-		return -ENXIO;
-	}
-
 	port = vcc_get_ne(tty->index);
 	if (unlikely(!port)) {
 		pr_err("VCC: chars_in_buffer: Failed to find VCC port\n");
@@ -941,11 +911,6 @@ static int vcc_break_ctl(struct tty_struct *tty, int state)
 	struct vcc_port *port;
 	unsigned long flags;
 
-	if (unlikely(!tty)) {
-		pr_err("VCC: break_ctl: Invalid TTY handle\n");
-		return -ENXIO;
-	}
-
 	port = vcc_get_ne(tty->index);
 	if (unlikely(!port)) {
 		pr_err("VCC: break_ctl: Failed to find VCC port\n");
@@ -976,11 +941,6 @@ static int vcc_install(struct tty_driver *driver, struct tty_struct *tty)
 	struct tty_port *port_tty;
 	int ret;
 
-	if (unlikely(!tty)) {
-		pr_err("VCC: install: Invalid TTY handle\n");
-		return -ENXIO;
-	}
-
 	if (tty->index >= VCC_MAX_PORTS)
 		return -EINVAL;
 
@@ -1015,11 +975,6 @@ static void vcc_cleanup(struct tty_struct *tty)
 {
 	struct vcc_port *port;
 
-	if (unlikely(!tty)) {
-		pr_err("VCC: cleanup: Invalid TTY handle\n");
-		return;
-	}
-
 	port = vcc_get(tty->index, true);
 	if (port) {
 		port->tty = NULL;
-- 
2.30.1

