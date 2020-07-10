Return-Path: <SRS0=t8aj=AV=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53E0C433E0
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jul 2020 12:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6241720748
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jul 2020 12:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcfI5OID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgGJMFz (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Jul 2020 08:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgGJMFy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Jul 2020 08:05:54 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7826C08C5CE;
        Fri, 10 Jul 2020 05:05:53 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o18so5771679eje.7;
        Fri, 10 Jul 2020 05:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bEKr9dbJtmbvZ+rJsIuI8GI1mXKrS8nKUmNOMtGVWjk=;
        b=FcfI5OIDqZScIzkKzb0ZJU2yN4ZrpAgmkplv+yBbLjhkcAvWhoLaFS8tVf9446Cpn6
         oO2GTwiG5+hlwM6Bch6B+1oF+Ea25nTKTQmKYjZUX/R/IsMrR5Sl8Gq83BrcLkqMymcA
         bnlGA70NFIer8w6jJ90/E6aRIBy3dP+OypBsVHe8tjFd+9nE9iKbsTxHIrfbTx/cH9K/
         BZZ+VvN6FF+Qzl5vPSIjEwUjkVUU72Tokln49NRcyA767A1WueILnQmJOME5x5Y3/al9
         hsgU+6zqXBXpJNiY50MXIqZUo5GtJkCiiuri4lgrSGeKjav03yeoPe9dpEOstYCdV/Jk
         FSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bEKr9dbJtmbvZ+rJsIuI8GI1mXKrS8nKUmNOMtGVWjk=;
        b=dLJ9WgQcwUnI0utqMm5Hi62eNUK8xqIobfBjJjMRF5WdogQ+GRj4vbi5q2RE+rXAFd
         GDiO3APJXAvUj+XVDlJ7d2UUxlZRNf3kEnfr9zVH1tw0R5lAZrs6x2YNCFg2karhv4Ra
         o6YnCOnPhE3twM5mrnTs0CXMKm73CLQ6AJT7dxtgRe5//PLFkdbKaXQlE3qcV1bGihjr
         7Tu6nZZ4IWDqOhWG0OjVoO9r+rLxZrmvduoCzM50a982NOBNJU2/c28kQKIeC0Ccyzn+
         3B+3d9omS1QnJq0mTAGUAfxDEQROreWduF/P3JQp/4ec9oE8lS6vdTOf68X4PNu51wV1
         rfYw==
X-Gm-Message-State: AOAM531lh+sUPclEPNgxIjBl1aJ0lS2Qjs7DmGfLHhs8l4wLVEKQF9Qx
        ttBmWj6grA+ty/od8e/Ivjw=
X-Google-Smtp-Source: ABdhPJz1iCqheRbCE5aOpUzM8RcqYE6DlFWc8YWxT0t59CFmQF8oFulh6fPsawfQwWwC4maM8uGT9w==
X-Received: by 2002:a17:906:194b:: with SMTP id b11mr54746825eje.28.1594382752559;
        Fri, 10 Jul 2020 05:05:52 -0700 (PDT)
Received: from BV030612LT ([188.24.137.55])
        by smtp.gmail.com with ESMTPSA id cw19sm3552701ejb.39.2020.07.10.05.05.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Jul 2020 05:05:51 -0700 (PDT)
Date:   Fri, 10 Jul 2020 15:05:49 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org
Subject: Re: [PATCH 1/1] tty: serial: owl: Initialize lock before registering
 port
Message-ID: <20200710120549.GA11293@BV030612LT>
References: <89f6393934fc6d493f8b9e87c1a6e916642b6a18.1590749143.git.cristian.ciocaltea@gmail.com>
 <20200529113419.GA1631227@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529113419.GA1631227@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 29, 2020 at 01:34:19PM +0200, Greg Kroah-Hartman wrote:
> On Fri, May 29, 2020 at 02:06:47PM +0300, Cristian Ciocaltea wrote:
> > Running a lockdep-enabled kernel leads to the following splat when
> > probing the owl-uart driver:
> > 
> > [    1.271784] b0124000.serial: ttyOWL2 at MMIO 0xb0124000 (irq = 22, base_baud = 1500000) is a owl-uart
> > [    1.281226] INFO: trying to register non-static key.
> > [    1.286179] the code is fine but needs lockdep annotation.
> > [    1.291648] turning off the locking correctness validator.
> > [    1.297125] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.7.0-rc7+ #70
> > [    1.303462] Hardware name: Generic DT based system
> > [    1.308268] [<80111d3c>] (unwind_backtrace) from [<8010c9b8>] (show_stack+0x10/0x14)
> > [    1.316003] [<8010c9b8>] (show_stack) from [<805016b4>] (dump_stack+0xb4/0xe0)
> > [    1.323218] [<805016b4>] (dump_stack) from [<80182dec>] (register_lock_class+0x25c/0x8f4)
> > [    1.331391] [<80182dec>] (register_lock_class) from [<8017ee34>] (__lock_acquire+0xb4/0x2ee4)
> > [    1.339901] [<8017ee34>] (__lock_acquire) from [<8018291c>] (lock_acquire+0x424/0x4c8)
> > [    1.347813] [<8018291c>] (lock_acquire) from [<808597b0>] (_raw_spin_lock_irqsave+0x54/0x68)
> > [    1.356242] [<808597b0>] (_raw_spin_lock_irqsave) from [<80582e94>] (uart_add_one_port+0x384/0x510)
> > [    1.365276] [<80582e94>] (uart_add_one_port) from [<8058b4d0>] (owl_uart_probe+0x1bc/0x248)
> > [    1.373621] [<8058b4d0>] (owl_uart_probe) from [<8059c0e4>] (platform_drv_probe+0x48/0x94)
> > [    1.381874] [<8059c0e4>] (platform_drv_probe) from [<805997c4>] (really_probe+0x200/0x470)
> > [    1.390123] [<805997c4>] (really_probe) from [<80599c80>] (driver_probe_device+0x16c/0x1bc)
> > [    1.398461] [<80599c80>] (driver_probe_device) from [<80599f18>] (device_driver_attach+0x44/0x60)
> > [    1.407317] [<80599f18>] (device_driver_attach) from [<8059a078>] (__driver_attach+0x144/0x14c)
> > [    1.416000] [<8059a078>] (__driver_attach) from [<805978ac>] (bus_for_each_dev+0x5c/0xb4)
> > [    1.424162] [<805978ac>] (bus_for_each_dev) from [<8059896c>] (bus_add_driver+0x118/0x204)
> > [    1.432410] [<8059896c>] (bus_add_driver) from [<8059ae6c>] (driver_register+0xbc/0xf8)
> > [    1.440405] [<8059ae6c>] (driver_register) from [<80c1fd24>] (owl_uart_init+0x20/0x40)
> > [    1.448313] [<80c1fd24>] (owl_uart_init) from [<801021d8>] (do_one_initcall+0x184/0x3a4)
> > [    1.456399] [<801021d8>] (do_one_initcall) from [<80c01100>] (kernel_init_freeable+0x264/0x2e4)
> > [    1.465085] [<80c01100>] (kernel_init_freeable) from [<80850a88>] (kernel_init+0x8/0x110)
> > [    1.473249] [<80850a88>] (kernel_init) from [<80100114>] (ret_from_fork+0x14/0x20)
> > [    1.480800] Exception stack(0xee8bdfb0 to 0xee8bdff8)
> > [    1.485841] dfa0:                                     00000000 00000000 00000000 00000000
> > [    1.494002] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > [    1.502162] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> > [    1.508914] printk: console [ttyOWL2] enabled
> > 
> > The locking issue occurs in uart_configure_port() when trying to
> > guard the call to set_mctrl().
> > 
> > uart_add_one_port() should normally initialize the spinlock via
> > uart_port_spin_lock_init(), but it never happens because the port is
> > detected as a console and, as a consequence, the spinlock is expected
> > to be already initialized.
> > 
> > The commit a3cb39d258ef
> > ("serial: core: Allow detach and attach serial device for console")
> > changed the lock initialization logic to assume the spinlock is
> > initialized even if the console is not enabled.
> > 
> > Therefore, initialize the lock explicitly in owl_uart_probe(), before
> > attempting to invoke uart_add_one_port().
> > 
> > Fixes: a3cb39d258ef ("serial: core: Allow detach and attach serial device for console")
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > ---
> >  drivers/tty/serial/owl-uart.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
> > index c149f8c30007..c2fa2f15d50a 100644
> > --- a/drivers/tty/serial/owl-uart.c
> > +++ b/drivers/tty/serial/owl-uart.c
> > @@ -705,6 +705,8 @@ static int owl_uart_probe(struct platform_device *pdev)
> >  	owl_uart_ports[pdev->id] = owl_port;
> >  	platform_set_drvdata(pdev, owl_port);
> >  
> > +	spin_lock_init(&owl_port->port.lock);
> > +
> >  	ret = uart_add_one_port(&owl_uart_driver, &owl_port->port);
> >  	if (ret)
> >  		owl_uart_ports[pdev->id] = NULL;
> 
> Ugh, another one :(
> 
> Thanks for this, will queue this up now.
> 
> greg k-h

Hi Greg,

I think this was mistakenly omitted from the inclusion in v5.8, or
has it been postponed for v5.9?

Thanks,
Cristi
