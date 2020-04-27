Return-Path: <SRS0=JuT/=6L=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688D3C54FD0
	for <linux-serial@archiver.kernel.org>; Mon, 27 Apr 2020 16:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42CB02080C
	for <linux-serial@archiver.kernel.org>; Mon, 27 Apr 2020 16:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h89b6fSs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgD0QqY (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgD0QqY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Apr 2020 12:46:24 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BF7C03C1A7
        for <linux-serial@vger.kernel.org>; Mon, 27 Apr 2020 09:46:23 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s10so21390804wrr.0
        for <linux-serial@vger.kernel.org>; Mon, 27 Apr 2020 09:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AFi2Ya3qM5IG+jnvqV1yuZyqNjUjwvEPZevqNfZVj0Y=;
        b=h89b6fSsTBUeL/XipyElSwPh022ivI7iy5S/qxb+B/YEFMXucgbgOPMaB5I8zHmo3G
         LRWpG0yPHRoPm6hWulcNTa8EZpmSU1ehlxrUGamES39kPwX8I0j/A+0KZg7hPbEs+0ks
         HANPmqjxSzMVM627SPxh1zTvoq9vHdnqsYVlJLIsHlzUsz3AmLrZdNJaY2bMEyz4RN+E
         NUpREb4sDwp8b2vh1zjq7PTy4S4t+pYLtsg99Q5g3VduUeMbXnv7Nu100uduQeC6sixW
         KMe2/BjTYwmqPbUi0wUvp7QccKp6gT4ao065bGV2099c9BJ1ORrE1ANzXHHED1u/7sCf
         qvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AFi2Ya3qM5IG+jnvqV1yuZyqNjUjwvEPZevqNfZVj0Y=;
        b=j6CqHDlI8sZuChlIKxaliq138r3RFlPwsdJ/f2xEvGBIdkZw8yBrte+EeKDWFhoDrv
         /4h9ZsBh+BL8qO/xWOPgSlhBmnl6j4pQYDxkxMhn0KfP8s4MMeWo4igpWU5uixNMAClw
         o8JuYoZ0GdqGCBXJT62or46VsZU7QyuouUc0W7pXfrE/lLb8NeWDb9+3R8Farwl1htKS
         hL8pb/6q94Sbu6LwB4AwrLTHRf6NnMsyRuHIHwCtbRya/vssME8flgFtMJLNMFtrA2+6
         WcVSvMbBwtlTVIxYjxTOOtwV6AvayViS7NfDq4vsqoG07t+OlkFKf6SVHBqSJcZX9HaI
         IMOg==
X-Gm-Message-State: AGi0PuZ2T+ruevBOngsppMdATy5J9bVtBk4oDzgUYxmHS0HNusfs460Y
        TuZw8XIz4+z59lHAd5JQNR8EMg==
X-Google-Smtp-Source: APiQypJ51FxUeaZo6yUU8t+LqTak9jj4U50akJER7m2MFUmNuUtXtokVlL35B4R3u3x89HQbdmY3Ng==
X-Received: by 2002:adf:e944:: with SMTP id m4mr27910229wrn.366.1588005982418;
        Mon, 27 Apr 2020 09:46:22 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id x18sm21079430wrs.11.2020.04.27.09.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 09:46:21 -0700 (PDT)
Date:   Mon, 27 Apr 2020 17:46:19 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     jason.wessel@windriver.com, gregkh@linuxfoundation.org,
        kgdb-bugreport@lists.sourceforge.net, mingo@redhat.com,
        hpa@zytor.com, bp@alien8.de, linux-serial@vger.kernel.org,
        agross@kernel.org, tglx@linutronix.de, frowand.list@gmail.com,
        bjorn.andersson@linaro.org, jslaby@suse.com,
        catalin.marinas@arm.com, corbet@lwn.net, will@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>, Juergen Gross <jgross@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/9] Documentation: kgdboc: Document new
 earlycon_kgdboc parameter
Message-ID: <20200427164619.kw4mihmoxmxzjk66@holly.lan>
References: <20200421211447.193860-1-dianders@chromium.org>
 <20200421141234.v2.7.I7d5eb42c6180c831d47aef1af44d0b8be3fac559@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421141234.v2.7.I7d5eb42c6180c831d47aef1af44d0b8be3fac559@changeid>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Apr 21, 2020 at 02:14:45PM -0700, Douglas Anderson wrote:
> The recent patch ("kgdboc: Add earlycon_kgdboc to support early kgdb
> using boot consoles") adds a new kernel command line parameter.
> Document it.
> 
> Note that the patch adding the feature does some comparing/contrasting
> of "earlycon_kgdboc" vs. the existing "ekgdboc".  See that patch for
> more details, but briefly "ekgdboc" can be used _instead_ of "kgdboc"
> and just makes "kgdboc" do its normal initialization early (only works
> if your tty driver is already ready).  The new "earlycon_kgdboc" works
> in combination with "kgdboc" and is backed by boot consoles.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> Changes in v2: None
> 
>  .../admin-guide/kernel-parameters.txt         | 20 +++++++++++++++++++
>  Documentation/dev-tools/kgdb.rst              | 14 +++++++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f2a93c8679e8..588625ec2993 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1132,6 +1132,22 @@
>  			address must be provided, and the serial port must
>  			already be setup and configured.
>  
> +	earlycon_kgdboc=	[KGDB,HW]
> +			If the boot console provides the ability to read
> +			characters and can work in polling mode, you can use
> +			this parameter to tell kgdb to use it as a backend
> +			until the normal console is registered. Intended to
> +			be used together with the kgdboc parameter which
> +			specifies the normal console to transition to.
> +
> +			The the name of the early console should be specified
> +			as the value of this parameter. Note that the name of
> +			the early console might be different than the tty
> +			name passed to kgdboc. If only one boot console with
> +			a read() function is enabled it's OK to leave the
> +			value blank and the first boot console that implements
> +			read() will be picked.

There's no need for the "If only one boot console with a read()
funcuiton is enabled" here,

Seeing this in alphabetic order in this patch it also crosses my mind
that kgdboc_earlycon might be a better name so that is sorts closer
to the other kgdb options. This is a kgdboc feature that uses earlycon
not an earlycon feature that uses kgdboc.


> +
>  	earlyprintk=	[X86,SH,ARM,M68k,S390]
>  			earlyprintk=vga
>  			earlyprintk=sclp
> @@ -1190,6 +1206,10 @@
>  			This is designed to be used in conjunction with
>  			the boot argument: earlyprintk=vga
>  
> +			This parameter works in place of the kgdboc parameter
> +			but can only be used if the backing tty is available
> +			very early in the boot process.
> +

I wonder if pragmatic advice is more useful:

  For early debugging via a serial port see earlycon_kgdboc instead.

>  	edd=		[EDD]
>  			Format: {"off" | "on" | "skip[mbr]"}
>  
> diff --git a/Documentation/dev-tools/kgdb.rst b/Documentation/dev-tools/kgdb.rst
> index d38be58f872a..c0b321403d9a 100644
> --- a/Documentation/dev-tools/kgdb.rst
> +++ b/Documentation/dev-tools/kgdb.rst
> @@ -274,6 +274,20 @@ don't like this are to hack gdb to send the :kbd:`SysRq-G` for you as well as
>  on the initial connect, or to use a debugger proxy that allows an
>  unmodified gdb to do the debugging.
>  
> +Kernel parameter: ``earlycon_kgdboc``
> +-------------------------------------
> +
> +If you specify the kernel parameter ``earlycon_kgdboc`` and your serial
> +driver registers a boot console that supports polling (doesn't need
> +interrupts and implements a nonblocking read() function) kgdb will attempt
> +to work using the boot console until it can transition to the regular
> +tty driver specified by the ``kgdboc`` parameter.
> +
> +Normally there is only one boot console (especially that implements the
> +read() function) so just adding ``earlycon_kgdboc`` on its own is
> +sufficient to make this work.  If you have more than one boot console you
> +can add the boot console's name to differentiate.
> +

I think we need an example here. The example in the patch header for
the previous patch was useful (at least for me).


Daniel.
