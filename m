Return-Path: <SRS0=V5ud=4H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DDDC3404D
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81CED208E4
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgBSIl2 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:41:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:44346 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbgBSIl2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 03:41:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4DBCDAEC5;
        Wed, 19 Feb 2020 08:41:26 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 22/24] n_hdlc: add missing spaces after commas
Date:   Wed, 19 Feb 2020 09:41:16 +0100
Message-Id: <20200219084118.26491-22-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219084118.26491-1-jslaby@suse.cz>
References: <20200219084118.26491-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_hdlc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index d52bcfa7f8e4..7ae4347a946f 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -201,7 +201,7 @@ static void n_hdlc_tty_close(struct tty_struct *tty)
 		return;
 	}
 #if defined(TTY_NO_WRITE_SPLIT)
-	clear_bit(TTY_NO_WRITE_SPLIT,&tty->flags);
+	clear_bit(TTY_NO_WRITE_SPLIT, &tty->flags);
 #endif
 	tty->disc_data = NULL;
 
@@ -245,7 +245,7 @@ static int n_hdlc_tty_open(struct tty_struct *tty)
 	tty->receive_room = 65536;
 
 	/* change tty_io write() to not split large writes into 8K chunks */
-	set_bit(TTY_NO_WRITE_SPLIT,&tty->flags);
+	set_bit(TTY_NO_WRITE_SPLIT, &tty->flags);
 
 	/* flush receive data from driver */
 	tty_driver_flush_buffer(tty);
@@ -399,7 +399,7 @@ static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *data,
 	}
 
 	/* copy received data to HDLC buffer */
-	memcpy(buf->buf,data,count);
+	memcpy(buf->buf, data, count);
 	buf->count=count;
 
 	/* add HDLC buffer to list of received frames */
@@ -550,8 +550,8 @@ static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
 
 		/* Send the data */
 		tbuf->count = error = count;
-		n_hdlc_buf_put(&n_hdlc->tx_buf_list,tbuf);
-		n_hdlc_send_frames(n_hdlc,tty);
+		n_hdlc_buf_put(&n_hdlc->tx_buf_list, tbuf);
+		n_hdlc_send_frames(n_hdlc, tty);
 	}
 
 	return error;
@@ -586,14 +586,14 @@ static int n_hdlc_tty_ioctl(struct tty_struct *tty, struct file *file,
 	case FIONREAD:
 		/* report count of read data available */
 		/* in next available frame (if any) */
-		spin_lock_irqsave(&n_hdlc->rx_buf_list.spinlock,flags);
+		spin_lock_irqsave(&n_hdlc->rx_buf_list.spinlock, flags);
 		buf = list_first_entry_or_null(&n_hdlc->rx_buf_list.list,
 						struct n_hdlc_buf, list_item);
 		if (buf)
 			count = buf->count;
 		else
 			count = 0;
-		spin_unlock_irqrestore(&n_hdlc->rx_buf_list.spinlock,flags);
+		spin_unlock_irqrestore(&n_hdlc->rx_buf_list.spinlock, flags);
 		error = put_user(count, (int __user *)arg);
 		break;
 
@@ -601,12 +601,12 @@ static int n_hdlc_tty_ioctl(struct tty_struct *tty, struct file *file,
 		/* get the pending tx byte count in the driver */
 		count = tty_chars_in_buffer(tty);
 		/* add size of next output frame in queue */
-		spin_lock_irqsave(&n_hdlc->tx_buf_list.spinlock,flags);
+		spin_lock_irqsave(&n_hdlc->tx_buf_list.spinlock, flags);
 		buf = list_first_entry_or_null(&n_hdlc->tx_buf_list.list,
 						struct n_hdlc_buf, list_item);
 		if (buf)
 			count += buf->count;
-		spin_unlock_irqrestore(&n_hdlc->tx_buf_list.spinlock,flags);
+		spin_unlock_irqrestore(&n_hdlc->tx_buf_list.spinlock, flags);
 		error = put_user(count, (int __user *)arg);
 		break;
 
-- 
2.25.0

