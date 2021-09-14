Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1321AC433EF
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 09:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F106F60295
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 09:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhINJMz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Sep 2021 05:12:55 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33660 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhINJMy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Sep 2021 05:12:54 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 26DEF220CA;
        Tue, 14 Sep 2021 09:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631610696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ijYycuxNzb4CZxioNn34Cm6B6LnK5yofNrdSgJwB/6U=;
        b=Q7S7WgrN/z+32+esom0vO4HjTORkKuxO1Ry0bZptLymWbsLzbayy1L5qoJT5sor57R79nx
        sXzU/XLo3b/1niib4dLAqE4MPdEBTARKs4Cct/dLLIxSjs568+F9zplvu6+vogV3DEep6i
        pgiEZ59l0+QMVgLvjhCRtzPf59tDDL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631610696;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ijYycuxNzb4CZxioNn34Cm6B6LnK5yofNrdSgJwB/6U=;
        b=E/aAU2iefykGLPkl3sdhMxoX0F2gqmyVsKK57rMU52jfCJsDiUN1NbWTMV1Ss4GPM+Ktaj
        CuA3POTYNLCdvpBQ==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 91BE2A3B98;
        Tue, 14 Sep 2021 09:11:35 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>
Subject: [PATCH 04/16] tty: make tty_ldisc_ops::hangup return void
Date:   Tue, 14 Sep 2021 11:11:22 +0200
Message-Id: <20210914091134.17426-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914091134.17426-1-jslaby@suse.cz>
References: <20210914091134.17426-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The documentation says that the return value of tty_ldisc_ops::hangup
hook is ignored. And it really is, so there is no point for its return
type to be int. Switch it to void and all the hooks too.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
---
 Documentation/driver-api/serial/tty.rst | 2 +-
 drivers/input/serio/serport.c           | 3 +--
 drivers/net/can/slcan.c                 | 3 +--
 drivers/net/ppp/ppp_async.c             | 3 +--
 drivers/net/ppp/ppp_synctty.c           | 3 +--
 drivers/net/slip/slip.c                 | 3 +--
 include/linux/tty_ldisc.h               | 2 +-
 sound/soc/codecs/cx20442.c              | 3 +--
 sound/soc/ti/ams-delta.c                | 3 +--
 9 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/Documentation/driver-api/serial/tty.rst b/Documentation/driver-api/serial/tty.rst
index dd972caacf3e..4b709f392713 100644
--- a/Documentation/driver-api/serial/tty.rst
+++ b/Documentation/driver-api/serial/tty.rst
@@ -58,7 +58,7 @@ close()			This is called on a terminal when the line
 hangup()		Called when the tty line is hung up.
 			The line discipline should cease I/O to the tty.
 			No further calls into the ldisc code will occur.
-			The return value is ignored. Can sleep.
+			Can sleep.
 
 read()			(optional) A process requests reading data from
 			the line. Multiple read calls may occur in parallel
diff --git a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
index 7fbbe00e3553..17eb8f2aa48d 100644
--- a/drivers/input/serio/serport.c
+++ b/drivers/input/serio/serport.c
@@ -244,7 +244,7 @@ static int serport_ldisc_compat_ioctl(struct tty_struct *tty,
 }
 #endif
 
-static int serport_ldisc_hangup(struct tty_struct *tty)
+static void serport_ldisc_hangup(struct tty_struct *tty)
 {
 	struct serport *serport = (struct serport *) tty->disc_data;
 	unsigned long flags;
@@ -254,7 +254,6 @@ static int serport_ldisc_hangup(struct tty_struct *tty)
 	spin_unlock_irqrestore(&serport->lock, flags);
 
 	wake_up_interruptible(&serport->wait);
-	return 0;
 }
 
 static void serport_ldisc_write_wakeup(struct tty_struct * tty)
diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index d42ec7d1bc14..012da4b8abe0 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -664,10 +664,9 @@ static void slcan_close(struct tty_struct *tty)
 	/* This will complete via sl_free_netdev */
 }
 
-static int slcan_hangup(struct tty_struct *tty)
+static void slcan_hangup(struct tty_struct *tty)
 {
 	slcan_close(tty);
-	return 0;
 }
 
 /* Perform I/O control on an active SLCAN channel. */
diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index 29a93d6bfe37..78ec1bcebc4f 100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -247,10 +247,9 @@ ppp_asynctty_close(struct tty_struct *tty)
  * Wait for I/O to driver to complete and unregister PPP channel.
  * This is already done by the close routine, so just call that.
  */
-static int ppp_asynctty_hangup(struct tty_struct *tty)
+static void ppp_asynctty_hangup(struct tty_struct *tty)
 {
 	ppp_asynctty_close(tty);
-	return 0;
 }
 
 /*
diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index af3e048695b6..c249db7c466a 100644
--- a/drivers/net/ppp/ppp_synctty.c
+++ b/drivers/net/ppp/ppp_synctty.c
@@ -245,10 +245,9 @@ ppp_sync_close(struct tty_struct *tty)
  * Wait for I/O to driver to complete and unregister PPP channel.
  * This is already done by the close routine, so just call that.
  */
-static int ppp_sync_hangup(struct tty_struct *tty)
+static void ppp_sync_hangup(struct tty_struct *tty)
 {
 	ppp_sync_close(tty);
-	return 0;
 }
 
 /*
diff --git a/drivers/net/slip/slip.c b/drivers/net/slip/slip.c
index 5435b5689ce6..8be9d0c351b5 100644
--- a/drivers/net/slip/slip.c
+++ b/drivers/net/slip/slip.c
@@ -907,10 +907,9 @@ static void slip_close(struct tty_struct *tty)
 	/* This will complete via sl_free_netdev */
 }
 
-static int slip_hangup(struct tty_struct *tty)
+static void slip_hangup(struct tty_struct *tty)
 {
 	slip_close(tty);
-	return 0;
 }
  /************************************************************************
   *			STANDARD SLIP ENCAPSULATION		  	 *
diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
index 4d1c128afbfa..b85d84fb5f49 100644
--- a/include/linux/tty_ldisc.h
+++ b/include/linux/tty_ldisc.h
@@ -199,7 +199,7 @@ struct tty_ldisc_ops {
 	void	(*set_termios)(struct tty_struct *tty, struct ktermios *old);
 	__poll_t (*poll)(struct tty_struct *, struct file *,
 			     struct poll_table_struct *);
-	int	(*hangup)(struct tty_struct *tty);
+	void	(*hangup)(struct tty_struct *tty);
 
 	/*
 	 * The following routines are called from below.
diff --git a/sound/soc/codecs/cx20442.c b/sound/soc/codecs/cx20442.c
index 13258f3ca9aa..1af0bf5f1e2f 100644
--- a/sound/soc/codecs/cx20442.c
+++ b/sound/soc/codecs/cx20442.c
@@ -252,10 +252,9 @@ static void v253_close(struct tty_struct *tty)
 }
 
 /* Line discipline .hangup() */
-static int v253_hangup(struct tty_struct *tty)
+static void v253_hangup(struct tty_struct *tty)
 {
 	v253_close(tty);
-	return 0;
 }
 
 /* Line discipline .receive_buf() */
diff --git a/sound/soc/ti/ams-delta.c b/sound/soc/ti/ams-delta.c
index ecd24d412a9b..b1a32545babd 100644
--- a/sound/soc/ti/ams-delta.c
+++ b/sound/soc/ti/ams-delta.c
@@ -330,10 +330,9 @@ static void cx81801_close(struct tty_struct *tty)
 }
 
 /* Line discipline .hangup() */
-static int cx81801_hangup(struct tty_struct *tty)
+static void cx81801_hangup(struct tty_struct *tty)
 {
 	cx81801_close(tty);
-	return 0;
 }
 
 /* Line discipline .receive_buf() */
-- 
2.33.0

