Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F43C433DB
	for <linux-serial@archiver.kernel.org>; Fri,  8 Jan 2021 14:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9042022A99
	for <linux-serial@archiver.kernel.org>; Fri,  8 Jan 2021 14:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbhAHOL1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 8 Jan 2021 09:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbhAHOL0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 8 Jan 2021 09:11:26 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1BBC0612F4;
        Fri,  8 Jan 2021 06:10:46 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id 6so14685374ejz.5;
        Fri, 08 Jan 2021 06:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1nJeF0Qm75ArKvLXNJY1ZwCCv3tl4AeKTF2NJqbUljE=;
        b=nr8NhgHOTk1yj0Xb35+2HmT/bPGwV8v9uvl1fJ3irWurZRHEjydxBikcsMFu9KP0wO
         +cp4tpvemCVsnCcY7jT+BQeDYnb2XnnLbrMy7NBrxtOjoSDqsQl906BBBCdF5akayvik
         t1NNfIfxd0CkZTEZwQnaiWQ1osa1086JzTQOcP95oAQDuyIxx6/7s1mW63a6yWIQtt75
         eum5PjoAwXtaXVJCu3I7Ltu4aIBQG+b/94ANzkd57+qd/qn6HAupiPXKEWGkZlWoSVGR
         s3fq/AA0D4KAM/wuthWHfxqNTid7XWeAewmdo2Pi+tzmTbKnLuYaL3GKB3fznsp7WsZ7
         /EYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1nJeF0Qm75ArKvLXNJY1ZwCCv3tl4AeKTF2NJqbUljE=;
        b=otsFHoByQtZfAp+WTUEXe5wvorXqRXXRKm/dMgCdUe2WVGB8rVFV0Wkoj1m8yRdVTQ
         qc92xuL0RY5F/WvKy2330M6seIl2md/lZUfbJGZ8HQsedrHXFDo4UEyitRluHf7M8V//
         rpYxf2WCpGXYJgw//mAlPx+a9vtZ8pCypk6R3JUMvWXDxr8bi3Wqk+gab1PdmNcfkQve
         wwxGnG0PIcwpl81APbkRdAgurrLADGQtJAQMhtXiwDrItlSd4xbNIbw5Om9XaNMn//wt
         4xHHtwrBYIdCqLLVnAyfme4BPx/pF6eBCPeN1OnMA9Lqr3hI7pUSDF4Z6bg/j1jvFS5s
         SpBw==
X-Gm-Message-State: AOAM533mWuQt6Esgg9B5ZQwiFaAkTuQjgztP3OYurhvK40Ck8SF2aAuK
        tJztu7yvThEnF+fMpchmNbc=
X-Google-Smtp-Source: ABdhPJyK4whluGdOyfhathde42YwE2i0ytkSh9A0RpUvvHVR8A0RgL+u/O3AJf3eeOiTA4AD50n5Vg==
X-Received: by 2002:a17:906:1197:: with SMTP id n23mr2769028eja.359.1610115044816;
        Fri, 08 Jan 2021 06:10:44 -0800 (PST)
Received: from ubuntu2004 ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id e27sm3588390ejm.60.2021.01.08.06.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 06:10:43 -0800 (PST)
Date:   Fri, 8 Jan 2021 16:10:40 +0200
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] tty: serial: owl: Add support for kernel debugger
Message-ID: <20210108141040.GA1081858@ubuntu2004>
References: <036c09732183a30eaab230884114f65ca42ca3b9.1609865007.git.cristian.ciocaltea@gmail.com>
 <X/cm1+wVQpoXj5Xr@kroah.com>
 <20210107181604.GA427955@BV030612LT>
 <02c664f5-8107-7757-2e20-c446a0458539@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02c664f5-8107-7757-2e20-c446a0458539@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jan 08, 2021 at 08:58:38AM +0100, Jiri Slaby wrote:
> On 07. 01. 21, 19:16, Cristian Ciocaltea wrote:
> > Hi Greg,
> > 
> > Thank you for the review!
> > 
> > On Thu, Jan 07, 2021 at 04:20:55PM +0100, Greg Kroah-Hartman wrote:
> > > On Tue, Jan 05, 2021 at 07:02:02PM +0200, Cristian Ciocaltea wrote:
> > > > Implement 'poll_put_char' and 'poll_get_char' callbacks in struct
> > > > 'owl_uart_ops' that enables OWL UART to be used for kernel debugging
> > > > over serial line.
> > > > 
> > > > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > 
> > [...]
> > 
> > > > +
> > > > +static void owl_uart_poll_put_char(struct uart_port *port, unsigned char ch)
> > > > +{
> > > > +	while (owl_uart_read(port, OWL_UART_STAT) & OWL_UART_STAT_TFFU)
> > > > +		cpu_relax();
> > > 
> > > Unbounded loops?  What could possibly go wrong?
> > > 
> > > :(
> > > 
> > > Please don't do that in the kernel, put a max bound on this.
> > 
> > I didn't realize the issue since I had encountered this pattern in many
> > other serial drivers, as well: altera_uart, arc_uart, atmel_serial, etc.
> > 
> > > And are you _SURE_ that cpu_relax() is what you want to call here?
> > 
> > I'm thinking of replacing the loop with 'readl_poll_timeout_atomic()',
> > if that would be a better approach.
> 
> It might be better, yes. Either way, if you add a bound to the loop, you
> definitely need a more precise timing, so ndelay/udelay instead of
> cpu_relax.

I will use 1-5 us for the timing, but I'm not quite sure about the
overall timeout - 10 ms would suffice?

Thanks,
Cristi

> thanks,
> -- 
> js
