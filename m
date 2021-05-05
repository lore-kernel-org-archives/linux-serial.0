Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0B9C43617
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C22461401
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbhEEJVE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 May 2021 05:21:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:42072 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232507AbhEEJUk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 May 2021 05:20:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8006CB272;
        Wed,  5 May 2021 09:19:41 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Johan Hovold <johan@kernel.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH 29/35] USB: serial: digi_acceleport, simplify digi_chars_in_buffer
Date:   Wed,  5 May 2021 11:19:22 +0200
Message-Id: <20210505091928.22010-30-jslaby@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210505091928.22010-1-jslaby@suse.cz>
References: <20210505091928.22010-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

"if"'s true branch in digi_chars_in_buffer returns. So there is no need
for "else" and indented code. Remove this else and shift the code to the
left.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org
---
 drivers/usb/serial/digi_acceleport.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
index 19ee8191647c..0c4d611621c2 100644
--- a/drivers/usb/serial/digi_acceleport.c
+++ b/drivers/usb/serial/digi_acceleport.c
@@ -1050,12 +1050,11 @@ static unsigned int digi_chars_in_buffer(struct tty_struct *tty)
 			priv->dp_port_num, port->bulk_out_size - 2);
 		/* return(port->bulk_out_size - 2); */
 		return 256;
-	} else {
-		dev_dbg(&port->dev, "digi_chars_in_buffer: port=%d, chars=%d\n",
-			priv->dp_port_num, priv->dp_out_buf_len);
-		return priv->dp_out_buf_len;
 	}
 
+	dev_dbg(&port->dev, "digi_chars_in_buffer: port=%d, chars=%d\n",
+		priv->dp_port_num, priv->dp_out_buf_len);
+	return priv->dp_out_buf_len;
 }
 
 static void digi_dtr_rts(struct usb_serial_port *port, int on)
-- 
2.31.1

