Return-Path: <SRS0=1VgQ=6Z=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAD6C47255
	for <linux-serial@archiver.kernel.org>; Mon, 11 May 2020 16:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA912206E6
	for <linux-serial@archiver.kernel.org>; Mon, 11 May 2020 16:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uv/YZnkN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbgEKQC3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 11 May 2020 12:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729556AbgEKQC3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 11 May 2020 12:02:29 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20D8C061A0C
        for <linux-serial@vger.kernel.org>; Mon, 11 May 2020 09:02:28 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id m12so13699473wmc.0
        for <linux-serial@vger.kernel.org>; Mon, 11 May 2020 09:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YJxLpJX62Fekaa+AoIWZZCIoU3KlFpvhoNLivrRXfy0=;
        b=uv/YZnkNB3ieOwzEoD7DCWpFpAn+e/KKj67tegbx5RTEoNCuSd/EAzBjup0e9sx0K8
         /mY90Bfv1qB2WQ4Yvi98RQtvi7IHohDApmRWP6Dk5I61Qa6Bm/uSvVKg8/JhOyBeXlE8
         nTATGRzTclMXnN4nzeAazZGf3P4ZP0h2F049N6/eaGWwhE30RlY9o2sM7ZWmFitx9uX/
         zPAGOX2FnmhjfBGWIIjjiZPeThZM2hYn5g0cnMbFaM0UDtrj17O5kMJkGq/CLQU4dqS7
         VPrG8ITNOqjV0naX6BbyG5ftg+IT3O1MBbW9rbj4/Apb/9es0DgNxSzA2HAEujAMiv0H
         kZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YJxLpJX62Fekaa+AoIWZZCIoU3KlFpvhoNLivrRXfy0=;
        b=EEkZaA1p0df8vVZKomdDCfi+4KtqDAMj46CqQbY3T2mNU8dWSlv9r0bpDRlzdVC6b+
         Lx5h3+r6CjjX93Tzf/QVHqBnxVyg5f3EEkxW9QmVMAWgASuw7ZGL93Gwp8bbpHHLoWrV
         6U6e7mNWZTsL4gR4YaUTCJ+jEUX1SKk8A8jDKpry+W4fZtqreV2VJHiXVcQ4TU1dmCWk
         fFMe49E+kJ/DkLa10Hx11hjGt24+y3HhCN8l0axhGKv/g2IyI/etSeQn8fVP5P0EyAMP
         A/ShLznfK7ABnogzzKwRLvu9Ph508IjQlkasCp43nYEFyD5K6Be+bGc+GUWjn9jv7q9q
         Y3lQ==
X-Gm-Message-State: AGi0PuasjcbtLO5daq9TKcEqj1WoxCBIFdhCgbJNk8bAFayR4Z1mg6er
        eQepqENnzwyiWKqRbpy3uMBS+Q==
X-Google-Smtp-Source: APiQypJf2L0prcQVNRJ7wp9Af8wHYgkMBEEqatM3HbAZY3RC7lUVWyWWeVTHGg5jc/YsIzU0qNqOgg==
X-Received: by 2002:a7b:c931:: with SMTP id h17mr34342830wml.105.1589212947333;
        Mon, 11 May 2020 09:02:27 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id v124sm27068657wme.45.2020.05.11.09.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 09:02:26 -0700 (PDT)
Date:   Mon, 11 May 2020 17:02:24 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     jason.wessel@windriver.com, gregkh@linuxfoundation.org,
        corbet@lwn.net, frowand.list@gmail.com, bjorn.andersson@linaro.org,
        linux-serial@vger.kernel.org, mingo@redhat.com, hpa@zytor.com,
        jslaby@suse.com, kgdb-bugreport@lists.sourceforge.net,
        sumit.garg@linaro.org, will@kernel.org, tglx@linutronix.de,
        agross@kernel.org, catalin.marinas@arm.com, bp@alien8.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/12] kgdboc: Remove useless #ifdef
 CONFIG_KGDB_SERIAL_CONSOLE in kgdboc
Message-ID: <20200511160224.cvelsmnpxc2ykgzb@holly.lan>
References: <20200507200850.60646-1-dianders@chromium.org>
 <20200507130644.v4.7.Icb528f03d0026d957e60f537aa711ada6fd219dc@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507130644.v4.7.Icb528f03d0026d957e60f537aa711ada6fd219dc@changeid>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, May 07, 2020 at 01:08:45PM -0700, Douglas Anderson wrote:
> This file is only ever compiled if that config is on since the
> Makefile says:
> 
>   obj-$(CONFIG_KGDB_SERIAL_CONSOLE) += kgdboc.o
> 
> Let's get rid of the useless #ifdef.
> 
> Reported-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
> 
> Changes in v4:
> - ("kgdboc: Remove useless #ifdef...") new for v4.
> 
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/tty/serial/kgdboc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index 519d8cfbfbed..2e9158fff976 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -380,7 +380,6 @@ static struct kgdb_io kgdboc_io_ops = {
>  	.post_exception		= kgdboc_post_exp_handler,
>  };
>  
> -#ifdef CONFIG_KGDB_SERIAL_CONSOLE
>  static int kgdboc_option_setup(char *opt)
>  {
>  	if (!opt) {
> @@ -409,7 +408,6 @@ static int __init kgdboc_early_init(char *opt)
>  }
>  
>  early_param("ekgdboc", kgdboc_early_init);
> -#endif /* CONFIG_KGDB_SERIAL_CONSOLE */
>  
>  module_init(init_kgdboc);
>  module_exit(exit_kgdboc);
> -- 
> 2.26.2.645.ge9eca65c58-goog
> 
