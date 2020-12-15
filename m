Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BA2C4361B
	for <linux-serial@archiver.kernel.org>; Tue, 15 Dec 2020 14:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FB072250F
	for <linux-serial@archiver.kernel.org>; Tue, 15 Dec 2020 14:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgLOOhs (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Dec 2020 09:37:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:46622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728806AbgLOOhn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Dec 2020 09:37:43 -0500
Date:   Tue, 15 Dec 2020 15:38:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1608043022;
        bh=0MW59xayUlnEgpJX7Fys1hfJvfvJiLiI8yadDLYEJFw=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=GSIasKJYp7aY/7dGwXmUl0xC2QAkxRTv+lIYu3dGenJnsQV4GDCDYTC1lf6ufFS9H
         gBKZ2b/n2WagO9MfWT2V5yWEMruEO8Hwz+MEcRSDAn8L94Qr73KBcdtsVytJYmO7L8
         rSlv9f3oHBh9ekK+ZPGYjUEcrDDcIunvJzgF0yfE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Ji-Ze Hong <hpeter@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: R: R: [PATCH v1] serial: 8250_fintek: Print Fintek chip name
Message-ID: <X9jKTZoX9Se+Ghn/@kroah.com>
References: <20201214131445.954822-1-f.suligoi@asem.it>
 <X9dr2IvOgPyhsalE@kroah.com>
 <ff8f6af85d27448d93d1220545f163be@asem.it>
 <X9i9RKAbpoR0F7Y+@kroah.com>
 <178bf34c76184d39b6b17d5e54133821@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178bf34c76184d39b6b17d5e54133821@asem.it>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Dec 15, 2020 at 02:06:09PM +0000, Flavio Suligoi wrote:
> Hi Greg,
> 
> 
> > > > > +		chip_name = "F81216H";
> > > > > +		break;
> > > > >  	case CHIP_ID_F81216:
> > > > > +		chip_name = "F81216";
> > > > >  		break;
> > > > >  	default:
> > > > >  		return -ENODEV;
> > > > >  	}
> > > > >
> > > > >  	pdata->pid = chip;
> > > > > +
> > > > > +	pr_info("%s%s%s Fintek %s\n",
> > > > > +		uart->port.dev ? dev_name(uart->port.dev) : "",
> > > > > +		uart->port.dev ? ": " : "",
> > > > > +		uart->port.name,
> > > > > +		chip_name);
> > > >
> > > > Drivers, if all goes well, should not print anything to the kernel
> > log.
> > > > This isn't ok.
> > > >
> > > > And even if it was, dev_info() would be the correct thing to do...
> > >
> > > Ok, too many information in the driver.
> > >
> > > But what do you think about the possibility to introduce
> > > a new additional field, in "serial8250_config" structure,
> > > such as "extra_name" or something like this:
> > >
> > > struct serial8250_config {
> > > 	const char		*name;
> > > 	const char		*extra_name;
> > > 	unsigned short	fifo_size;
> > > 	unsigned short	tx_loadsz;
> > > 	unsigned char	fcr;
> > > 	unsigned char	rxtrig_bytes[UART_FCR_R_TRIG_MAX_STATE];
> > > 	unsigned int	flags;
> > > };
> > >
> > > In this way, if required, each driver can fill this
> > > additional field, for example adding the name of
> > > the particular uart chip or other useful info.
> > >
> > > As result, for example, the "uart_report_port" function output
> > > could be something like this:
> > >
> > > 00:01: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A -
> > Fintek F81216AD
> > > 00:02: ttyS3 at I/O 0x2e8 (irq = 11, base_baud = 115200) is a 16550A -
> > Fintek F81216AD
> > >
> > > where the "extra_name", if not empty, is printed
> > > at the end of the line.
> > > For practical space reasons, the "extra_name" length
> > > can be limited to 16 chars.
> > 
> > Why?  What tool will use this, and why would userspace care about it?
> > 
> > What problem are you trying to solve here?
> 
> I try to explain my requirement:
> 
> we produce some x86 boards with multistandard RS232/422/485 ports
> and, to have this feature, in some of these boards, we use a
> Fintek uart or superIO.
> So this additional info "extra_name" can be useful for
> a quick check if the serial ports are multistandard or not,
> without any other investigations, but using only a simple command
> like:
> 
> dmesg| grep ttyS

But as they work the same, why does it matter?

Userspace should not care here.  Isn't there some other id you can
read/query for a hardware database tool to determine this?

Printing a random string to the kernel log is not a good way to do
hardware descriptions in a format that everyone can easily parse them :)

thanks,

greg k-h
