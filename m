Return-Path: <SRS0=xWBg=BY=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F17BC433DF
	for <linux-serial@archiver.kernel.org>; Fri, 14 Aug 2020 11:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66F70207DA
	for <linux-serial@archiver.kernel.org>; Fri, 14 Aug 2020 11:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rlhTnBiZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgHNL3o (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Aug 2020 07:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgHNL3n (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Aug 2020 07:29:43 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD329C061384;
        Fri, 14 Aug 2020 04:29:43 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d22so4429329pfn.5;
        Fri, 14 Aug 2020 04:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fXOinOaTouuyiTu5KQ5LuIo8RHDIe9EoPbZlWHPA1JU=;
        b=rlhTnBiZ8K2eBbck5IB3aNnAR5FTPR0KAiW+6tR9Im9zHxo+6GlmB5fjSp1V7+Pj6S
         J2osKBlMlu44c79JAYMheyH+o5Go2q8xjFrEqgapm23dQeIXe/r6mdnCW3fC/1A68gnA
         Dq9dQTs5mfjueofG2+JZasPg70UY2SjR4AB0KMsVs30CWyNs949vyllcQIxGAcZwZzJ1
         ndvJHpSgCy7hZZSvfLeivmCyu5h57E+MoCEoSGoUo+J2FRJtfzbPQkUXEvHApMVgEOV2
         /FpKhhLFLNYK/VBiQx08st4iBlciCwlZFPj1hMU+S4laOVufJMNzljOoiya84WKyjVOQ
         gTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fXOinOaTouuyiTu5KQ5LuIo8RHDIe9EoPbZlWHPA1JU=;
        b=Vokh9IR6eF+gmngYfrHabczKy6n7qI9Md0waR0WaqJKeaqRRpHLPgqcWHDv9jA478E
         uOc4EM7ZF0HqbIVaHu1DND0pTwHL9Z7VoGO7LOiIO0M8zGn6GLsWYIB6qqkw7x9pFTNw
         XObX6kadedGJNpBdaykKV3aakFGrPkEK9EWK8AB6Aoenb6AunXQiMvhPlKkwUg3PwabY
         lKOIxbPqwFjePzSONYT+IjUfcVhVfQjqV0JsKeFcfDHCTEdXdkM8+ZGo85tzJD/SkQG7
         ILaOnCV2Ez0Py2/L9e/YutWyRsHOS1ZY8ghF01TJUGN2a4gxNEAac405Jh80EnVb+3Qi
         d+Vw==
X-Gm-Message-State: AOAM533FKs/VZoTpgD0GEMa/N91ACVIiJRi92uoD1Yw63wDlmK8sa72o
        JPNFvfXq3jpPVduEG4dvNQ0=
X-Google-Smtp-Source: ABdhPJzn9QLZpKp4csa5TzJLh8t2TQR9+PJQAkQl7G2w8uBxX2ZL2hYKEud9Pj0mESc9RQHy3lTomQ==
X-Received: by 2002:a63:1a51:: with SMTP id a17mr1409425pgm.309.1597404583242;
        Fri, 14 Aug 2020 04:29:43 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id o192sm9642743pfg.81.2020.08.14.04.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 04:29:42 -0700 (PDT)
Date:   Fri, 14 Aug 2020 20:29:40 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tony Lindgren <tony@atomide.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Raul Rangel <rrangel@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] uart:8250: change lock order in serial8250_do_startup()
Message-ID: <20200814112940.GB582@jagdpanzerIV.localdomain>
References: <20200814013802.357412-1-sergey.senozhatsky@gmail.com>
 <20200814095928.GK1891694@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814095928.GK1891694@smile.fi.intel.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On (20/08/14 12:59), Andy Shevchenko wrote:
> > ---
> >  drivers/tty/serial/8250/8250_port.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> > index 09475695effd..67f1a4f31093 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -2275,6 +2275,11 @@ int serial8250_do_startup(struct uart_port *port)
> >  
> >  	if (port->irq && !(up->port.flags & UPF_NO_THRE_TEST)) {
> >  		unsigned char iir1;
> 
> > +		bool irq_shared = up->port.irqflags & IRQF_SHARED;
> 
> I'm wondering why we need a temporary variable? This flag is not supposed to be
> changed in between, can we leave original conditionals?

No particular reason. We can keep the original (long) ones, I guess.

> Nevertheless I noticed an inconsistency of the dereference of the flags which
> seems to be brough by dfe42443ea1d ("serial: reduce number of indirections in
> 8250 code").
>
> I think we can stick with newer:
>
> 		if (port->irqflags & IRQF_SHARED)

I'll take a look.

	-ss
