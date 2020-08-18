Return-Path: <SRS0=mq3J=B4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8058AC433E1
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 08:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64F5E20825
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 08:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgHRI5A (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:57:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:37654 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbgHRI46 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Aug 2020 04:56:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AB2A0ABF4;
        Tue, 18 Aug 2020 08:57:21 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/8] tty: n_gsm, eliminate indirection for gsm->{output,error}()
Date:   Tue, 18 Aug 2020 10:56:48 +0200
Message-Id: <20200818085655.12071-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

gsm->output and ->error are set only to gsmld_output and gsm_error,
respectively. Call these functions directly and remove error and output
function pointers from struct gsm_mux completely.

Note: we need a forward declaration of gsmld_output now.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_gsm.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 0a29a94ec438..10f8fc07f23c 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -222,11 +222,8 @@ struct gsm_mux {
 	u8 received_fcs;
 	u8 *txframe;			/* TX framing buffer */
 
-	/* Methods for the receiver side */
+	/* Method for the receiver side */
 	void (*receive)(struct gsm_mux *gsm, u8 ch);
-	void (*error)(struct gsm_mux *gsm, u8 ch, u8 flag);
-	/* And transmit side */
-	int (*output)(struct gsm_mux *mux, u8 *data, int len);
 
 	/* Link Layer */
 	unsigned int mru;
@@ -366,6 +363,8 @@ static const u8 gsm_fcs8[256] = {
 #define INIT_FCS	0xFF
 #define GOOD_FCS	0xCF
 
+static int gsmld_output(struct gsm_mux *gsm, u8 *data, int len);
+
 /**
  *	gsm_fcs_add	-	update FCS
  *	@fcs: Current FCS
@@ -587,7 +586,7 @@ static void gsm_send(struct gsm_mux *gsm, int addr, int cr, int control)
 		WARN_ON(1);
 		return;
 	}
-	gsm->output(gsm, cbuf, len);
+	gsmld_output(gsm, cbuf, len);
 	gsm_print_packet("-->", addr, cr, control, NULL, 0);
 }
 
@@ -687,7 +686,7 @@ static void gsm_data_kick(struct gsm_mux *gsm, struct gsm_dlci *dlci)
 			print_hex_dump_bytes("gsm_data_kick: ",
 					     DUMP_PREFIX_OFFSET,
 					     gsm->txframe, len);
-		if (gsm->output(gsm, gsm->txframe, len) < 0)
+		if (gsmld_output(gsm, gsm->txframe, len) < 0)
 			break;
 		/* FIXME: Can eliminate one SOF in many more cases */
 		gsm->tx_bytes -= msg->len;
@@ -2128,7 +2127,6 @@ static int gsm_activate_mux(struct gsm_mux *gsm)
 		gsm->receive = gsm0_receive;
 	else
 		gsm->receive = gsm1_receive;
-	gsm->error = gsm_error;
 
 	spin_lock(&gsm_mux_lock);
 	for (i = 0; i < MAX_MUX; i++) {
@@ -2378,7 +2376,6 @@ static int gsmld_attach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
 	int ret, i;
 
 	gsm->tty = tty_kref_get(tty);
-	gsm->output = gsmld_output;
 	ret =  gsm_activate_mux(gsm);
 	if (ret != 0)
 		tty_kref_put(gsm->tty);
@@ -2438,7 +2435,7 @@ static void gsmld_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 		case TTY_BREAK:
 		case TTY_PARITY:
 		case TTY_FRAME:
-			gsm->error(gsm, *dp, flags);
+			gsm_error(gsm, *dp, flags);
 			break;
 		default:
 			WARN_ONCE(1, "%s: unknown flag %d\n",
-- 
2.28.0

