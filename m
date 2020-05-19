Return-Path: <SRS0=bJiX=7B=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD99CC433E1
	for <linux-serial@archiver.kernel.org>; Tue, 19 May 2020 19:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F9B620758
	for <linux-serial@archiver.kernel.org>; Tue, 19 May 2020 19:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U1v22pjd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgESTOx (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 19 May 2020 15:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgESTOw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 May 2020 15:14:52 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABA9C08C5C1
        for <linux-serial@vger.kernel.org>; Tue, 19 May 2020 12:14:50 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j5so667434wrq.2
        for <linux-serial@vger.kernel.org>; Tue, 19 May 2020 12:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wEq9P5HnCfUm9vk24Pjpsrg932s/fp+shOA9bBHZRYI=;
        b=U1v22pjdFEgh26Q4N8u+nq5aSkSji6AanM9ZXmU8FbY4MF7bqry7qJkOOpyirOvWAf
         T76R5DNl7HninB1H8gou4BB4vUBhGEHAGqrc9OL9Uxks65TuU54aRzTe3ytKGOTYYlGN
         YQE8z18HTvOBDcHd0uDpHEn92X6ru2QZ7rzpGMTWCSFGkzCl36SK/HWZmTDSniGdytln
         RzGeu8z3GlkkGyH+cypz1adDeSJf8AypJD6L+o/pgFDEQIKyDJAJk8kqxVB1ieD5v7cj
         G7O+SBYIbU6cee0ZUV9VZR+sOr5RfteCzNmOlDOaxyyxJU2BJAlyyFn73ZoodsFsce6z
         h9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wEq9P5HnCfUm9vk24Pjpsrg932s/fp+shOA9bBHZRYI=;
        b=BuUH7JmSUKqPmkQdt7z5iimp4yD1/nY4M1pDDtX2XetTGAIknSZAq3w92ey1fQFWVH
         xpEctStjrMq9vTTQWHmHapJmcllavLfhcry8IzHM1ttT22xc4e5zt0iz2AXnMOO5o2es
         AEqhLOHUsAtO0h5oXOa6h71ILbeOoTOfusZ+qI/Vmcy3mtfG7th8VkR+ufquHKKc5YkG
         D7kkzIvW5iwnC/3bPvNKUtf6pDnIxFipVNFWHsX32FO77lxaXwW28fEX07zKsfBt/DCo
         4bBDtPQTmLXbWWyGE3ummfCUSaR7FjFRHegrweDOY6/92z4MNQ8KPCvkk+Ro/G8pCciy
         CPlA==
X-Gm-Message-State: AOAM5321xKRgJ1Okj+H0DSc5rYw1LLaqONx6H8bzeg0ZYFbRyycaAIBf
        uwWVLk0sJMRuqy/8QayQZ8l5Gw==
X-Google-Smtp-Source: ABdhPJyQADGkHTqT9aWT/EdvTBmXbqG4ivJlWWFIusns8fU2Ap7T2kPHiX/RkUx6bu28om/YBrHVWg==
X-Received: by 2002:a05:6000:11ca:: with SMTP id i10mr453589wrx.10.1589915689318;
        Tue, 19 May 2020 12:14:49 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id v2sm464710wrn.21.2020.05.19.12.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 12:14:48 -0700 (PDT)
Date:   Tue, 19 May 2020 20:14:46 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-next@vger.kernel.org, sumit.garg@linaro.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] kgdboc: Disable all the early code when kgdboc is a
 module
Message-ID: <20200519191446.ybe2phdzac6vxyzx@holly.lan>
References: <20200519084345.1.I91670accc8a5ddabab227eb63bb4ad3e2e9d2b58@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519084345.1.I91670accc8a5ddabab227eb63bb4ad3e2e9d2b58@changeid>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, May 19, 2020 at 08:44:02AM -0700, Douglas Anderson wrote:
> When kgdboc is compiled as a module all of the "ekgdboc" and
> "kgdb_earlycon" code isn't useful and, in fact, breaks compilation.
> This is because early_param() isn't defined for modules and that's how
> this code gets configured.
> 
> It turns out that this was broken by commit eae3e19ca930 ("kgdboc:
> Remove useless #ifdef CONFIG_KGDB_SERIAL_CONSOLE in kgdboc") and then
> made worse by commit 220995622da5 ("kgdboc: Add kgdboc_earlycon to
> support early kgdb using boot consoles").  I guess the #ifdef wasn't
> so useless, even if it wasn't obvious why it was useful.  When kgdboc
> was compiled as a module only "CONFIG_KGDB_SERIAL_CONSOLE_MODULE" was
> defined, not "CONFIG_KGDB_SERIAL_CONSOLE".  That meant that the old
> module.
> 
> Let's basically do the same thing that the old code (pre-removal of
> the #ifdef) did but use "IS_BUILTIN(CONFIG_KGDB_SERIAL_CONSOLE)" to
> make it more obvious what the point of the check is.  We'll fix
> kgdboc_earlycon in a similar way.
> 
> Fixes: 220995622da5 ("kgdboc: Add kgdboc_earlycon to support early kgdb using boot consoles")
> Fixes: eae3e19ca930 ("kgdboc: Remove useless #ifdef CONFIG_KGDB_SERIAL_CONSOLE in kgdboc")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Thanks Doug. I've got this running though my build checks now (which
I have just noted an improvement for ;-) ) and will get it into
kgdb/for-next as soon as possible.


Daniel.


> ---
> 
>  drivers/tty/serial/kgdboc.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index 34b5e91dd245..fa6f7a3e73b9 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -43,9 +43,11 @@ static int			kgdb_tty_line;
>  
>  static struct platform_device *kgdboc_pdev;
>  
> +#if IS_BUILTIN(CONFIG_KGDB_SERIAL_CONSOLE)
>  static struct kgdb_io		kgdboc_earlycon_io_ops;
>  static struct console		*earlycon;
>  static int                      (*earlycon_orig_exit)(struct console *con);
> +#endif /* IS_BUILTIN(CONFIG_KGDB_SERIAL_CONSOLE) */
>  
>  #ifdef CONFIG_KDB_KEYBOARD
>  static int kgdboc_reset_connect(struct input_handler *handler,
> @@ -140,10 +142,19 @@ static void kgdboc_unregister_kbd(void)
>  #define kgdboc_restore_input()
>  #endif /* ! CONFIG_KDB_KEYBOARD */
>  
> -static void cleanup_kgdboc(void)
> +#if IS_BUILTIN(CONFIG_KGDB_SERIAL_CONSOLE)
> +static void cleanup_earlycon(void)
>  {
>  	if (earlycon)
>  		kgdb_unregister_io_module(&kgdboc_earlycon_io_ops);
> +}
> +#else /* !IS_BUILTIN(CONFIG_KGDB_SERIAL_CONSOLE) */
> +static inline void cleanup_earlycon(void) { }
> +#endif /* !IS_BUILTIN(CONFIG_KGDB_SERIAL_CONSOLE) */
> +
> +static void cleanup_kgdboc(void)
> +{
> +	cleanup_earlycon();
>  
>  	if (configured != 1)
>  		return;
> @@ -388,6 +399,7 @@ static struct kgdb_io kgdboc_io_ops = {
>  	.post_exception		= kgdboc_post_exp_handler,
>  };
>  
> +#if IS_BUILTIN(CONFIG_KGDB_SERIAL_CONSOLE)
>  static int kgdboc_option_setup(char *opt)
>  {
>  	if (!opt) {
> @@ -544,6 +556,7 @@ static int __init kgdboc_earlycon_init(char *opt)
>  }
>  
>  early_param("kgdboc_earlycon", kgdboc_earlycon_init);
> +#endif /* IS_BUILTIN(CONFIG_KGDB_SERIAL_CONSOLE) */
>  
>  module_init(init_kgdboc);
>  module_exit(exit_kgdboc);
> -- 
> 2.26.2.761.g0e0b3e54be-goog
> 
