Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28737C4332F
	for <linux-serial@archiver.kernel.org>; Mon,  7 Nov 2022 14:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbiKGOQ5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 7 Nov 2022 09:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiKGOQs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 Nov 2022 09:16:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E011D0ED;
        Mon,  7 Nov 2022 06:16:47 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667830606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UHuP0rbZWQQBzSmPTErQb30w1r8OemTOVXxBtKXD5zo=;
        b=iNt4WLybeNZ2mg/QU8nQRgYO3eRwjEe4TxpxeuViKZgOFqSLGdnxpB4EIHsbH38cw2h6Am
        kJVDUMhcmDfKwlcQItq60yXQiAM46j6B9Q30Uv+BDFud70sS99pVRWZsqjhTRdLZ1dBaFE
        UfhdVUIkj1KudfH6d1vG5YHIMtg+leLFlBPIIrj+Gzw03dt7+TXN3UcBPcTVmJ5kf31YVr
        G7mFekiqU9lb9lIMsaNunxvcSejZoGuF85W8nc+Rx/+O+XVwv+c9/Iu0yNjb2pkjvKZEFG
        FDPXkYTRkDp2Ifzzr8b9XUdgb2olC4aoS/elsnnplXFO8y8GhZMrmHrHM2DqiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667830606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UHuP0rbZWQQBzSmPTErQb30w1r8OemTOVXxBtKXD5zo=;
        b=vWTVUpf3xvuqVwTe/KNxkvP7t8I4roXjMftkB13FmomVHEj3IjzCEpCFORfE4FT8CtCEsX
        KCLNz75VQR2R8iBg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Subject: [PATCH printk v3 12/40] tty: serial: kgdboc: document console_lock usage
Date:   Mon,  7 Nov 2022 15:22:10 +0106
Message-Id: <20221107141638.3790965-13-john.ogness@linutronix.de>
In-Reply-To: <20221107141638.3790965-1-john.ogness@linutronix.de>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

kgdboc_earlycon_init() uses the console_lock to ensure that no consoles
are unregistered until the kgdboc_earlycon is setup. This is necessary
because the trapping of the exit() callback assumes that the exit()
callback is not called before the trap is setup.

Explicitly document this non-typical console_lock usage.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/tty/serial/kgdboc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index e76f0186c335..5be381003e58 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -530,6 +530,14 @@ static int __init kgdboc_earlycon_init(char *opt)
 	 * Look for a matching console, or if the name was left blank just
 	 * pick the first one we find.
 	 */
+
+	/*
+	 * Hold the console_lock to guarantee that no consoles are
+	 * unregistered until the kgdboc_earlycon setup is complete.
+	 * Trapping the exit() callback relies on exit() not being
+	 * called until the trap is setup. This also allows safe
+	 * traversal of the console list and race-free reading of @flags.
+	 */
 	console_lock();
 	for_each_console(con) {
 		if (con->write && con->read &&
-- 
2.30.2

