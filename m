Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BD9C54EBD
	for <linux-serial@archiver.kernel.org>; Fri, 13 Jan 2023 02:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjAMCct (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Jan 2023 21:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbjAMCcs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Jan 2023 21:32:48 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22C25D6A2
        for <linux-serial@vger.kernel.org>; Thu, 12 Jan 2023 18:32:47 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id s3so12672520pfd.12
        for <linux-serial@vger.kernel.org>; Thu, 12 Jan 2023 18:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kOmM1boioYg8LFtWAWs33j4bBuyb4KtgIsQ+w3Q1Nec=;
        b=Ms+uSdJMIWu+6/rPfkBxkXAr7MPZBipnJfzVJqCmg773hVvxRx+OKl/7d0nRAxXsTX
         oJrqG0gxih/ylYXorRI2xrOT6BC9zp2wrZANpID7nHNl7KGadbiX7PDfPfrpxIEmncPH
         +KS+1pR7XE/gs4blQKXKoaKeorMh34AzE1BA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOmM1boioYg8LFtWAWs33j4bBuyb4KtgIsQ+w3Q1Nec=;
        b=MO8lBr8BDOAmxgWtxzvGXaYfIuREVqbOzaot9OiMYVddN4fRk5LiwGbbTLiwmjjsVK
         tsCzzf+BeEbfQYcIxlQwcmBNrMRJSYDonvp9d/1dyAUrE4t1MGj4BAiMXSJEqUu8v00T
         tpiktMhtJY0mcPfdFeLdxxp2tu0J3R1BUwlrMpv5xIJb6edOFE9awmbQWuhhBbqcI/Bd
         uIL/r6WcW1Nb4vd6LVBIk1iTiAfpt8gwqJo8l/+AK2ch+U5/bz8YhE2XsqrnbFVOIDIi
         brm+Yl9T9z8BKYZmnAqQcPt+Mf8JlTfyPbQw57TOv4z+azXRLG1qAySP1OZ51n9q2sc9
         N8oQ==
X-Gm-Message-State: AFqh2kp2MD3PFQdjL7NKa8Rv3YVGghh0fRgwEb8Q63XFkmZ7hR9m4PnQ
        s1X9lVyRc4tyI+00g9I32GpHBeWqGKXM2rGg
X-Google-Smtp-Source: AMrXdXtDHCAjBbBXjeoIpHmcmPAFTDOvNbFwRTgswr8/FoRJEOP33+VktonH7fugm95/k2TxfeSk3A==
X-Received: by 2002:a62:e703:0:b0:577:7cfb:a896 with SMTP id s3-20020a62e703000000b005777cfba896mr8682396pfh.31.1673577167232;
        Thu, 12 Jan 2023 18:32:47 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id y22-20020aa78f36000000b00562677968aesm12568828pfr.72.2023.01.12.18.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 18:32:46 -0800 (PST)
Date:   Fri, 13 Jan 2023 11:32:41 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: serial: kgdboc: fix mutex locking order for
 configure_kgdboc()
Message-ID: <Y8DCyU0v0OUqArab@google.com>
References: <20230111145110.1327831-1-john.ogness@linutronix.de>
 <Y77imoYMaZZZz28x@alley>
 <Y8Ap4B75PNy5/lHo@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8Ap4B75PNy5/lHo@alley>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On (23/01/12 16:40), Petr Mladek wrote:
> On Wed 2023-01-11 17:23:55, Petr Mladek wrote:
> > On Wed 2023-01-11 15:57:10, John Ogness wrote:
> > > Several mutexes are taken while setting up console serial ports. In
> > > particular, the tty_port->mutex and @console_mutex are taken:
> > > 
> > >   serial_pnp_probe
> > >     serial8250_register_8250_port
> > >       uart_add_one_port (locks tty_port->mutex)
> > >         uart_configure_port
> > >           register_console (locks @console_mutex)
> > > 
> > > In order to synchronize kgdb's tty_find_polling_driver() with
> > > register_console(), commit 6193bc90849a ("tty: serial: kgdboc:
> > > synchronize tty_find_polling_driver() and register_console()") takes
> > > the @console_mutex. However, this leads to the following call chain
> > > (with locking):
> > > 
> > >   platform_probe
> > >     kgdboc_probe
> > >       configure_kgdboc (locks @console_mutex)
> > >         tty_find_polling_driver
> > >           uart_poll_init (locks tty_port->mutex)
> > >             uart_set_options
> > > 
> > > This is clearly deadlock potential due to the reverse lock ordering.
[..]
> > > -	console_list_lock();
> > > -
> > >  	p = tty_find_polling_driver(cptr, &tty_line);
> > >  	if (!p) {
> > >  		console_list_unlock();
> > 
> > This console_list_unlock() should be removed here as well.
> 
> This seems to be the only problem. Otherwise, the patch looks good to
> me.

Good catch.

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
