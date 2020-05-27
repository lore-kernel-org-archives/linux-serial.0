Return-Path: <SRS0=pZl0=7J=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E0EC433DF
	for <linux-serial@archiver.kernel.org>; Wed, 27 May 2020 07:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F05E320C56
	for <linux-serial@archiver.kernel.org>; Wed, 27 May 2020 07:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590566168;
	bh=bZIirAmpiGuqFhImuidBeKEkuGqmy+azz9K1A09JtMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cpgab5t0FMi34sw/n8OSujE+eUW0mXDk/jtrvJbSk0VfJou8HIZjNlFu98itLYr2p
	 Wku6pRAGbMrAJbiL82qXEBx5iBkHrg/gL/JOjkNHnuPA/Cbq6ZbEaClLSmmrbbZz0r
	 uJ75s/xsTugpF3qze8mXkCekwmAJUHuYi9GhDvo8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387552AbgE0H4H (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 27 May 2020 03:56:07 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35784 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387566AbgE0H4H (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 27 May 2020 03:56:07 -0400
Received: by mail-lj1-f195.google.com with SMTP id c11so25587060ljn.2
        for <linux-serial@vger.kernel.org>; Wed, 27 May 2020 00:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UYSwRqyIuSQLXzgHbexnHEtP7o+bjSyMWu1nDj6YOm8=;
        b=ke0oAoVKO6ERAv6GdKbqtUqik1oqmQJbrilwIQA26bBM1X91Mg4lIVN16FGuqlHG2o
         6L1mp9ClTTq40BePyvdkNet8liiYcsAJyYpEODTVkS1Lv36ABoBSrj30ln2YQRXgAqgf
         lWielYsHOd/+a3IHcKfjKvtY7Wa1n68eaaZOh8Py5YyC2awmvShhiB691NJ3r9BBprUy
         ePyiu3FR/zhtBA7Kwdyu4Tk8GzMIHusFILbh/pGH22Z8ZXjCPbNfDeNpRnwooartTxsl
         fZ8gmUkavObbrcc6nr3sg0gzXhHgV4RMEscJzj1zyB76/MKN4c0X6aAuSCyRcJrduZZL
         Fk7g==
X-Gm-Message-State: AOAM533KXQQXrZMginskmAq6tGnqBjyv7WuT6P/hYVJy1o3tfRGP6AH0
        4GNANgYpq6XJOwK1EHZYQjI=
X-Google-Smtp-Source: ABdhPJzrmdNZMdhFcI0EnhOXGe+nOK9S5aa8zAJj1coOTyCAo4MlmPMKy+xSf2FF4QZ7ql6kNP0cKQ==
X-Received: by 2002:a2e:9818:: with SMTP id a24mr2356937ljj.161.1590566162486;
        Wed, 27 May 2020 00:56:02 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id q15sm625168lfc.44.2020.05.27.00.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 00:56:01 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1jdquo-0003lp-Ba; Wed, 27 May 2020 09:55:54 +0200
Date:   Wed, 27 May 2020 09:55:54 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Denis Ahrens <denis@h3q.com>
Cc:     linux-serial@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] 16C950 UART enable Hardware Flow Control
Message-ID: <20200527075554.GG5276@localhost>
References: <BACA4F76-3D51-4854-894B-2E69272B5676@h3q.com>
 <20200525082750.GB5276@localhost>
 <B7715399-667F-4DB7-A19D-4CB037ECE64A@h3q.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B7715399-667F-4DB7-A19D-4CB037ECE64A@h3q.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

[ Adding Pavel who disabled EFR at one point to CC. ]

On Mon, May 25, 2020 at 07:49:54PM +0200, Denis Ahrens wrote:
> 
> 
> > On 25. May 2020, at 10:27, Johan Hovold <johan@kernel.org> wrote:
> > 
> > On Sun, May 24, 2020 at 06:31:44PM +0200, Denis Ahrens wrote:
> >> From: Denis Ahrens <denis@h3q.com>
> >> 
> >> Enable Automatic RTS/CTS flow control for the 16C950 UART in Enhanced Mode
> >> like described in the Data Sheet Revision 1.2 page 28 and 29.
> >> 
> >> Without this change normal console output works, but everything putting
> >> a little more pressure on the UART simply overruns the FIFO.
> >> 
> >> Signed-off-by: Denis Ahrens <denis@h3q.com>
> >> ---
> >> 
> >> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> >> index f77bf820b7a3..024235946f4d 100644
> >> --- a/drivers/tty/serial/8250/8250_port.c
> >> +++ b/drivers/tty/serial/8250/8250_port.c
> >> @@ -2168,7 +2168,9 @@ int serial8250_do_startup(struct uart_port *port)
> >>                serial_port_out(port, UART_LCR, 0);
> >>                serial_icr_write(up, UART_CSR, 0); /* Reset the UART */
> >>                serial_port_out(port, UART_LCR, UART_LCR_CONF_MODE_B);
> >> -               serial_port_out(port, UART_EFR, UART_EFR_ECB);
> >> +               serial_port_out(port, UART_EFR, UART_EFR_ECB |
> >> +                                               UART_EFR_RTS |
> >> +                                               UART_EFR_CTS);
> >>                serial_port_out(port, UART_LCR, 0);
> >>        }
> > 
> > This doesn't look right as you're now enabling automatic flow control
> > for everyone.
> > 
> > Try adding this to set_termios() instead when enabling flow control.
> 
> The part in set_termios() is never reached because the UART_CAP_EFR
> capability was removed ca. 10 years ago. The code fails to preserve
> the UART_EFR_ECB bit which is in the same register as UART_EFR_CTS.
> Also for some reason UART_EFR_RTS is not set.

The EFR capability was added by commit 7a56aa45982b ("serial: add
UART_CAP_EFR and UART_CAP_SLEEP flags to 16C950 UARTs definition") and
then removed half a year later by commit 0694e2aeb81 ("serial: unbreak
billionton CF card") -- you should mention that in the commit message
too.

I guess you need to determine how to enable this feature without
breaking something else.

> So lets fix the code instead of disabling a feature.
> 
> I could write a patch which adds UART_CAP_EFR back to the 16C950 and
> fixes the code in set_termios only for the 16C950. I would also add
> another line which adds RTS hardware flow control only for the 16C950.

Nah, auto-RTS should probably have been enabled from the start.

And just make sure not clear any other bits in that register when
updating the flow-control settings for example by reading it back first.

> The change would look like this:
> (I will write another mail with a real patch if I get the OK)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index f77bf820b7a3..ac7efc43b392 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -122,8 +122,7 @@ static const struct serial8250_config uart_config[] = {
>                 .fifo_size      = 128,
>                 .tx_loadsz      = 128,
>                 .fcr            = UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
> -               /* UART_CAP_EFR breaks billionon CF bluetooth card. */
> -               .flags          = UART_CAP_FIFO | UART_CAP_SLEEP,
> +               .flags          = UART_CAP_FIFO | UART_CAP_EFR | UART_CAP_SLEEP,
>         },
>         [PORT_16654] = {
>                 .name           = "ST16654",
> @@ -2723,13 +2722,18 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
>  
>         if (up->capabilities & UART_CAP_EFR) {
>                 unsigned char efr = 0;
> +               if (port->type == PORT_16C950)
> +                       efr |= UART_EFR_ECB;
>                 /*
>                  * TI16C752/Startech hardware flow control.  FIXME:
>                  * - TI16C752 requires control thresholds to be set.
>                  * - UART_MCR_RTS is ineffective if auto-RTS mode is enabled.
>                  */
> -               if (termios->c_cflag & CRTSCTS)
> +               if (termios->c_cflag & CRTSCTS) {
>                         efr |= UART_EFR_CTS;
> +                       if (port->type == PORT_16C950)
> +                               efr |= UART_EFR_RTS;
> +               }
>  
>                 serial_port_out(port, UART_LCR, UART_LCR_CONF_MODE_B);
>                 if (port->flags & UPF_EXAR_EFR)
> 

Johan
