Return-Path: <SRS0=20mg=6P=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57901C47259
	for <linux-serial@archiver.kernel.org>; Fri,  1 May 2020 13:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F0A02054F
	for <linux-serial@archiver.kernel.org>; Fri,  1 May 2020 13:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zv2DUkeX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbgEAN44 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 1 May 2020 09:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730246AbgEANcH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 May 2020 09:32:07 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB93C061A0C
        for <linux-serial@vger.kernel.org>; Fri,  1 May 2020 06:32:06 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u127so6343571wmg.1
        for <linux-serial@vger.kernel.org>; Fri, 01 May 2020 06:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CwB8SxSSgbYRqBwwUAkIWpdYejHT7kvKRjFIv7ghtlc=;
        b=Zv2DUkeX0KLYIj51PZCGPiis13gH28irsAEo3T69bAM2sws/ALOnM9thSDsY6gT3V1
         oVXhXrxAjKRN23sgEFKZQ9pz9KA6bEthwgNAWdgX60GselC+r04QNerVpTnj14R9aODI
         raczwgYvDHF4z015qXs+dQh0HxLXopjDOY4daNDxMu6eJBsgMuwyBLAiAIgBPGhWVDCQ
         SMY3gVjIB4jSDTYghOJjk+nD6RFc0vycq9GbTlZUmtICrD/ImCajAjuHnoBMuTWeS0Ld
         /CasZuOzbRVvH4grnHn8i1jSu8PJWpkg12tu0QVgVg0Z/2PBSa0Bwa3VxQ0kBxd8zj0p
         rR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CwB8SxSSgbYRqBwwUAkIWpdYejHT7kvKRjFIv7ghtlc=;
        b=Fq0R8xlLJ+m4ckKfHvE4aPgMW25hnmQWG5UKfR1bETRvleGzYGxCPZZ12eqxTstXn/
         FPYZcy52DX05cS9dCX5OevFUJvdAD8kNOysNb07e6/GkgBpu53jIyt2ncsQS7WjCRWRG
         lZStwSFpoaOYBKu2/X6hM0ojiq45wjQLp6+qM838oCWqBWp5/zLBnZxQ2BlrZtzf1Hmk
         RO1cBH5Y79KyreMvp83ZR7rIRzOWM3DgKXSBraR7KaR/Qi6j2akrlkM9+mnLIMpFSoQN
         td2JVRdYz5pzJH7fdgZIlCe7XZXQiSZjdiJ3sX+b7txejam6vXNuRRnXTBrDKbgUkCSg
         PNoQ==
X-Gm-Message-State: AGi0PuZc8XZFAFrA5g3M4ZXFKQD58Fm0xJqpUbxhjSCPqm34d94Fde3i
        jFTK87SZK4TB9vfacur/IAhNMw==
X-Google-Smtp-Source: APiQypIM0zV3rCKxAnet9INB91hMWd5nvcSwEEe+HmDOGq2ZyIDIQqa7aRKUbOPSlWCxsUu5rhOjfA==
X-Received: by 2002:a1c:9d0d:: with SMTP id g13mr4251299wme.102.1588339924824;
        Fri, 01 May 2020 06:32:04 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id t17sm4293272wro.2.2020.05.01.06.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 06:32:03 -0700 (PDT)
Date:   Fri, 1 May 2020 14:32:02 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>, sumit.garg@linaro.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] kgdboc: Be a bit more robust about handling earlycon
 leaving
Message-ID: <20200501133202.GA2402281@wychelm.lan>
References: <20200430095819.1.Id37f71c69eb21747b9d9e2c7c242be130814b362@changeid>
 <20200501114943.ioetuxe24gi27bll@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501114943.ioetuxe24gi27bll@holly.lan>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 01, 2020 at 12:49:43PM +0100, Daniel Thompson wrote:
> On Thu, Apr 30, 2020 at 09:59:09AM -0700, Douglas Anderson wrote:
> > The original implementation of kgdboc_earlycon included a comment
> > about how it was impossible to get notified about the boot console
> > going away without making changes to the Linux core.  Since folks
> > often don't want to change the Linux core for kgdb's purposes, the
> > kgdboc_earlycon implementation did a bit of polling to figure out when
> > the boot console went away.
> > 
> > It turns out, though, that it is possible to get notified about the
> > boot console going away.  The solution is either clever or a hack
> > depending on your viewpoint.  ...or, perhaps, a clever hack.  All we
> > need to do is head-patch the "exit" routine of the boot console.  We
> > know that "struct console" must be writable because it has a "next"
> > pointer in it, so we can just put our own exit routine in, do our
> > stuff, and then call back to the original.
> 
> I think I'm in the hack camp on this one!
> 
>  
> > This works great to get notified about the boot console going away.
> > The (slight) problem is that in the context of the boot console's exit
> > routine we can't call tty_find_polling_driver().
> 
> I presume this is something to do with the tty_mutex?
> 
> 
> > We solve this by
> > kicking off some work on the system_wq when we get notified and this
> > works pretty well.
> 
> There are some problems with the workqueue approach.

... so did a couple of experiments to avoid the workqueue.

It occured to me that, since we have interfered with deinit() then the
console hasn't actually been uninitialized meaning we could still use it.
This does exposes us to risks similar to keep_bootcon but in exchange
there is no window where kgdb is broken (and no need to panic). 

My prototype is minimal but I did wonder about ripping out all the
code to defend against removal of the earlycon and simply keep the
earlycon around until a new kgdbio handler is installed.


Daniel.


diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 596213272ec3..05d58f9f38b1 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -46,6 +46,7 @@ static struct platform_device *kgdboc_pdev;
 #ifdef CONFIG_KGDB_SERIAL_CONSOLE
 static struct kgdb_io		kgdboc_earlycon_io_ops;
 struct console			*earlycon;
+static int                      (*earlycon_orig_exit)(struct console *con);
 #else /* ! CONFIG_KGDB_SERIAL_CONSOLE */
 #define earlycon NULL
 #endif /* ! CONFIG_KGDB_SERIAL_CONSOLE */
@@ -478,25 +479,28 @@ static void kgdboc_earlycon_put_char(u8 chr)
 	earlycon->write(earlycon, &chr, 1);
 }
 
-static void kgdboc_earlycon_pre_exp_handler(void)
+static int kgdboc_earlycon_deferred_exit(struct console *con)
 {
 	/*
-	 * We don't get notified when the boot console is unregistered.
-	 * Double-check when we enter the debugger.  Unfortunately we
-	 * can't really unregister ourselves now, so we panic.  We rely
-	 * on kgdb's ability to detect re-entrancy to make the panic
-	 * take effect.
-	 *
-	 * NOTE: if you're here in the lull when the real console has
-	 * replaced the boot console but our init hasn't run yet it's
-	 * possible that the "keep_bootcon" argument may help.
+	 * restoring the exit function ensures the earlycon is
+	 * deinitialized when/if we find a suitable tty
 	 */
-	if (earlycon && !is_earlycon_still_valid())
-		panic("KGDB earlycon vanished and nothing replaced it\n");
+	con->exit = earlycon_orig_exit;
+
+	return 0;
 }
 
 static void kgdboc_earlycon_deinit(void)
 {
+	if (!earlycon)
+		return;
+
+	if (earlycon->exit == kgdboc_earlycon_deferred_exit) {
+		earlycon->exit = earlycon_orig_exit;
+	} else if (earlycon->exit) {
+		earlycon->exit(earlycon);
+	}
+
 	earlycon = NULL;
 }
 
@@ -504,7 +508,6 @@ static struct kgdb_io kgdboc_earlycon_io_ops = {
 	.name			= "kgdboc_earlycon",
 	.read_char		= kgdboc_earlycon_get_char,
 	.write_char		= kgdboc_earlycon_put_char,
-	.pre_exception		= kgdboc_earlycon_pre_exp_handler,
 	.deinit			= kgdboc_earlycon_deinit,
 	.is_console		= true,
 };
@@ -562,6 +565,9 @@ static int __init kgdboc_earlycon_init(char *opt)
 		return 0;
 	}
 
+	earlycon_orig_exit = con->exit;
+	con->exit = kgdboc_earlycon_deferred_exit;
+
 	return 0;
 }
 early_param("kgdboc_earlycon", kgdboc_earlycon_init);
