Return-Path: <SRS0=D0ei=4Y=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119DBC10F00
	for <linux-serial@archiver.kernel.org>; Sat,  7 Mar 2020 08:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE352073D
	for <linux-serial@archiver.kernel.org>; Sat,  7 Mar 2020 08:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583571092;
	bh=XHkhJ9roLn4BQH0RujkrIRY5Fa5VCdkj7MpWailNw9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rqDb5sVX7MAaBPDJXOKFHwz8QeLb7pDFSIJWd7v3vhAbiIwg9dYLmp0JRxYNisHud
	 SJxFY+5Aiqs9th2f0Y30Slnjmhp0hi5nIL8LfwvIskav0xyTe3XiUmo3i6e+ENViwq
	 DEZuRvgRMVmJDdR2l4Ay0DCkhQ25+E9mAbeu8D3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgCGIvc (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 7 Mar 2020 03:51:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:42108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgCGIvc (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 7 Mar 2020 03:51:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDB902070A;
        Sat,  7 Mar 2020 08:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583571090;
        bh=XHkhJ9roLn4BQH0RujkrIRY5Fa5VCdkj7MpWailNw9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jSTLOQa5HR5biwsuxQJQxCY1r4JeMeUWlRVlevIuxnnwWaDPnxfiHy8H2rWjQbUcI
         +8wTupJx+OzEdzUUDucm0W0TUlaTv12wApm7FQ0zBS7vs5x2X5OllXafJGzrbyvtp+
         Si3BKFGeCvF8Qe3jYUWEYhIa2zxhXj/Ws8uE/XKw=
Date:   Sat, 7 Mar 2020 09:51:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     vincent.chen@sifive.com, jslaby@suse.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] tty: serial: Add CONSOLE_POLL support to SiFive UART
Message-ID: <20200307085127.GA3878075@kroah.com>
References: <1583224900-25824-1-git-send-email-vincent.chen@sifive.com>
 <mhng-cf4b7d3b-9841-44a1-9ffd-ac7f4cdeb75d@palmerdabbelt-glaptop1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-cf4b7d3b-9841-44a1-9ffd-ac7f4cdeb75d@palmerdabbelt-glaptop1>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Mar 06, 2020 at 10:13:56AM -0800, Palmer Dabbelt wrote:
> On Tue, 03 Mar 2020 00:41:40 PST (-0800), vincent.chen@sifive.com wrote:
> > Add CONSOLE_POLL support for future KGDB porting.
> > 
> > Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> > ---
> >  drivers/tty/serial/sifive.c | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> > 
> > diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
> > index d5f81b98e4d7..acdbaca4de36 100644
> > --- a/drivers/tty/serial/sifive.c
> > +++ b/drivers/tty/serial/sifive.c
> > @@ -818,6 +818,29 @@ static int __init sifive_serial_console_setup(struct console *co, char *options)
> >  	return uart_set_options(&ssp->port, co, baud, parity, bits, flow);
> >  }
> > 
> > +#ifdef CONFIG_CONSOLE_POLL
> > +static int sifive_serial_poll_get_char(struct uart_port *port)
> > +{
> > +	struct sifive_serial_port *ssp = port_to_sifive_serial_port(port);
> > +	char is_empty, ch;
> > +
> > +	ch = __ssp_receive_char(ssp, &is_empty);
> > +	if (is_empty)
> > +		return NO_POLL_CHAR;
> > +
> > +	return ch;
> > +}
> > +
> > +static void sifive_serial_poll_put_char(struct uart_port *port,
> > +					unsigned char c)
> > +{
> > +	struct sifive_serial_port *ssp = port_to_sifive_serial_port(port);
> > +
> > +	sifive_serial_console_putchar(port, c);
> > +	__ssp_wait_for_xmitr(ssp);
> 
> So we still have that TX watermark bug in the SiFive UARTs.  If this function
> is supposed to wait until the word is actually out on the line then this isn't
> sufficient, but if it's just supposed to wait until the next write won't block
> then this is fine.
> 
> I'm not really a serial person, so mabye someone else knows?  For those
> unfamiliar with the issue, there's a pretty good description in the patch to
> fix it
> 
>    https://github.com/sifive/sifive-blocks/pull/90
> 
> Poking around we don't have any PRE_RATE_CHANGE hook, so I'm going to take a
> whack at adding one -- not really related to this patch, though.

I do have to drop this patch from my tree, as it breaks the build, so it
needs to be redone anyway :(

thanks,

greg k-h
