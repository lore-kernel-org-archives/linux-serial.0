Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F75DC433F5
	for <linux-serial@archiver.kernel.org>; Thu, 14 Apr 2022 09:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241050AbiDNJqS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Apr 2022 05:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241377AbiDNJqP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Apr 2022 05:46:15 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Apr 2022 02:43:50 PDT
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D976FF58
        for <linux-serial@vger.kernel.org>; Thu, 14 Apr 2022 02:43:50 -0700 (PDT)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202204140942419371152938ecbbfa72
        for <linux-serial@vger.kernel.org>;
        Thu, 14 Apr 2022 11:42:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=8TJTDkFvwacJ2R1wRt130Hsl5RodISpQLLwTdKZVIdE=;
 b=XxvLz8EqpMQz0WPsvNV5NwWatLjSpd+J4MFUaC2qrxcnb7iAmAzaVqZiqDxy7opYoFimv6
 1pYCPFZRYmiwc6Vd9Jcd8Mtg+qQqgntpDqn+GOU3wVECdMQ+GvzzYU8D7HFkT/o3icEn3Khr
 CMDSTA0gQ2FSaMBt+PD5OtCQeSyoc=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 04/20] tty: n_gsm: fix mux cleanup after unregister tty device
Date:   Thu, 14 Apr 2022 02:42:09 -0700
Message-Id: <20220414094225.4527-4-daniel.starke@siemens.com>
In-Reply-To: <20220414094225.4527-1-daniel.starke@siemens.com>
References: <20220414094225.4527-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

Internally, we manage the alive state of the mux channels and mux itself
with the field member 'dead'. This makes it possible to notify the user
if the accessed underlying link is already gone. On the other hand,
however, removing the virtual ttys before terminating the channels may
result in peer messages being received without any internal target. Move
the mux cleanup procedure from gsmld_detach_gsm() to gsmld_close() to fix
this by keeping the virtual ttys open until the mux has been cleaned up.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index f546dfe03d29..de97a3810731 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2479,7 +2479,6 @@ static void gsmld_detach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
 		for (i = 1; i < NUM_DLCI; i++)
 			tty_unregister_device(gsm_tty_driver, base + i);
 	}
-	gsm_cleanup_mux(gsm, false);
 	tty_kref_put(gsm->tty);
 	gsm->tty = NULL;
 }
@@ -2544,6 +2543,12 @@ static void gsmld_close(struct tty_struct *tty)
 {
 	struct gsm_mux *gsm = tty->disc_data;
 
+	/* The ldisc locks and closes the port before calling our close. This
+	 * means we have no way to do a proper disconnect. We will not bother
+	 * to do one.
+	 */
+	gsm_cleanup_mux(gsm, false);
+
 	gsmld_detach_gsm(tty, gsm);
 
 	gsmld_flush_buffer(tty);
-- 
2.25.1

