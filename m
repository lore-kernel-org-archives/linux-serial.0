Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D700BC54EBC
	for <linux-serial@archiver.kernel.org>; Thu, 12 Jan 2023 15:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240487AbjALPw3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Jan 2023 10:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240538AbjALPv4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Jan 2023 10:51:56 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05046C2B6
        for <linux-serial@vger.kernel.org>; Thu, 12 Jan 2023 07:40:36 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 99CF1402C3;
        Thu, 12 Jan 2023 15:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673538019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MnhE5SVciJ/SbPnM39oaaCSkXi4rJk4SInUK6g88A8I=;
        b=gdU4kPBcKFOlGDDkfqP770eiIQG6FQMGlIw9Oyx/L1ICoITOsvbS/4bp/+fghEwhzlgHrr
        rYIo28C87h7Yus+MmP5RHkuVRzIWlMIMV9jCpyQKU0ahtsQoLgOW6HKgiWxkS00YaB1TI2
        qOMeWM9kS897ZqqcSJ5NOFhTmjCmIRA=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1B84C2C141;
        Thu, 12 Jan 2023 15:40:19 +0000 (UTC)
Date:   Thu, 12 Jan 2023 16:40:16 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
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
Subject: Re: [PATCH] tty: serial: kgdboc: fix mutex locking order for
 configure_kgdboc()
Message-ID: <Y8Ap4B75PNy5/lHo@alley>
References: <20230111145110.1327831-1-john.ogness@linutronix.de>
 <Y77imoYMaZZZz28x@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y77imoYMaZZZz28x@alley>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed 2023-01-11 17:23:55, Petr Mladek wrote:
> On Wed 2023-01-11 15:57:10, John Ogness wrote:
> > Several mutexes are taken while setting up console serial ports. In
> > particular, the tty_port->mutex and @console_mutex are taken:
> > 
> >   serial_pnp_probe
> >     serial8250_register_8250_port
> >       uart_add_one_port (locks tty_port->mutex)
> >         uart_configure_port
> >           register_console (locks @console_mutex)
> > 
> > In order to synchronize kgdb's tty_find_polling_driver() with
> > register_console(), commit 6193bc90849a ("tty: serial: kgdboc:
> > synchronize tty_find_polling_driver() and register_console()") takes
> > the @console_mutex. However, this leads to the following call chain
> > (with locking):
> > 
> >   platform_probe
> >     kgdboc_probe
> >       configure_kgdboc (locks @console_mutex)
> >         tty_find_polling_driver
> >           uart_poll_init (locks tty_port->mutex)
> >             uart_set_options
> > 
> > This is clearly deadlock potential due to the reverse lock ordering.
> 
> Great catch!
> 
> > Since uart_set_options() requires holding @console_mutex in order to
> > serialize early initialization of the serial-console lock, take the
> > @console_mutex in uart_poll_init() instead of configure_kgdboc().
> > 
> > Since configure_kgdboc() was using @console_mutex for safe traversal
> > of the console list, change it to use the SRCU iterator instead.
> > 
> > Add comments to uart_set_options() kerneldoc mentioning that it
> > requires holding @console_mutex (aka the console_list_lock).
> > 
> > Fixes: 6193bc90849a ("tty: serial: kgdboc: synchronize tty_find_polling_driver() and register_console()")
> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
> 
> > --- a/drivers/tty/serial/kgdboc.c
> > +++ b/drivers/tty/serial/kgdboc.c
> > @@ -189,15 +190,6 @@ static int configure_kgdboc(void)
> >  	if (kgdboc_register_kbd(&cptr))
> >  		goto do_register;
> >  
> > -	/*
> > -	 * tty_find_polling_driver() can call uart_set_options()
> > -	 * (via poll_init) to configure the uart. Take the console_list_lock
> > -	 * in order to synchronize against register_console(), which can also
> > -	 * configure the uart via uart_set_options(). This also allows safe
> > -	 * traversal of the console list.
> > -	 */
> > -	console_list_lock();
> > -
> >  	p = tty_find_polling_driver(cptr, &tty_line);
> >  	if (!p) {
> >  		console_list_unlock();
> 
> This console_list_unlock() should be removed here as well.

This seems to be the only problem. Otherwise, the patch looks good to
me.

After removing the superfluous console_list_unlock():

Reviewed-by: Petr Mladek <pmladek@suse.com>

John, would you mind to send v2, please?

Best Regards,
Petr
