Return-Path: <SRS0=hg1Z=A4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8E2C433E1
	for <linux-serial@archiver.kernel.org>; Fri, 17 Jul 2020 09:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C765A20768
	for <linux-serial@archiver.kernel.org>; Fri, 17 Jul 2020 09:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594978910;
	bh=3P5+AyVNskrxYLDlSXLyoFZTXKhqdDYxp32pzPXURok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ko+gm7BwllILrO5kHenWZPX4wOx1LfFNQpJDqZaNh6/yaJkAfHWRpPHuHCfkLQ6B1
	 UqrfoCkLn8jlmVQooFjIQl1bDz4o2XJVAboDqvhfz2CknfS1XkE5gwxhfA+pEA0Qcu
	 jtwN84EdV5SmaLGN+Ku7JkhlMmuJNPeF2cEV8px4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbgGQJlu (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 17 Jul 2020 05:41:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgGQJlu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 17 Jul 2020 05:41:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 231212070E;
        Fri, 17 Jul 2020 09:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594978909;
        bh=3P5+AyVNskrxYLDlSXLyoFZTXKhqdDYxp32pzPXURok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EPtqwdXInaBZVSxUF3pVIvu6tZNcp60BImLOJK8mexCvHCJOgaUI53wjnRqUcpvoM
         KhHi/tbVIb0lwcBg4n8oX6q0xjelff0Z/WQ3+sXo4eGrsbs3FnMFkVrCPedpao0GhA
         d+6rtioxA+JRVwau4Yc8Br+P/eXtxZcZ79QxmOlI=
Date:   Fri, 17 Jul 2020 11:41:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andy Duan <fugang.duan@nxp.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "jslaby@suse.com" <jslaby@suse.com>
Subject: Re: [EXT] Re: [PATCH tty/serial v2 1/1] tty: serial: imx: enable imx
 serial console port as module
Message-ID: <20200717094141.GA2420692@kroah.com>
References: <20200717081827.3417-1-fugang.duan@nxp.com>
 <20200717085812.GA1457960@kroah.com>
 <AM6PR0402MB3607DFDA5CB9ACD8E9E578F3FF7C0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR0402MB3607DFDA5CB9ACD8E9E578F3FF7C0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jul 17, 2020 at 09:33:20AM +0000, Andy Duan wrote:
> From: Greg KH <gregkh@linuxfoundation.org> Sent: Friday, July 17, 2020 4:58 PM
> > On Fri, Jul 17, 2020 at 04:18:27PM +0800, Fugang Duan wrote:
> > > GKI kernel requires drivers built as modules including console driver,
> > > so add the support that imx serial console driver can be built as
> > > module.
> > >
> > > The changes of the patch:
> > > - imx console driver can be built as module.
> > > - move out earlycon code to separated driver like imx_earlycon.c,
> > >   and imx earlycon driver only support build-in.
> > >
> > > v2:
> > >  - fix kbuild error
> > >
> > > Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
> > > ---
> > >  drivers/tty/serial/Kconfig        | 18 +++++++----
> > >  drivers/tty/serial/Makefile       |  1 +
> > >  drivers/tty/serial/imx.c          | 37 ++---------------------
> > >  drivers/tty/serial/imx_earlycon.c | 50
> > > +++++++++++++++++++++++++++++++
> > >  4 files changed, 66 insertions(+), 40 deletions(-)
> > >
> > > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > > index 780908d43557..dabd06ca9b66 100644
> > > --- a/drivers/tty/serial/Kconfig
> > > +++ b/drivers/tty/serial/Kconfig
> > > @@ -502,20 +502,28 @@ config SERIAL_IMX
> > >         can enable its onboard serial port by enabling this option.
> > >
> > >  config SERIAL_IMX_CONSOLE
> > > -     bool "Console on IMX serial port"
> > > -     depends on SERIAL_IMX=y
> > > +     tristate "Console on IMX serial port"
> > > +     depends on SERIAL_IMX
> > >       select SERIAL_CORE_CONSOLE
> > > -     select SERIAL_EARLYCON if OF
> > >       help
> > >         If you have enabled the serial port on the Freescale IMX
> > > -       CPU you can make it the console by answering Y to this option.
> > > +       CPU you can make it the console by answering Y/M to this option.
> > >
> > > -       Even if you say Y here, the currently visible virtual console
> > > +       Even if you say Y/M here, the currently visible virtual
> > > + console
> > >         (/dev/tty0) will still be used as the system console by default, but
> > >         you can alter that using a kernel command line option such as
> > >         "console=ttymxc0". (Try "man bootparam" or see the
> > documentation of
> > >         your bootloader about how to pass options to the kernel at
> > > boot time.)
> > >
> > > +config SERIAL_IMX_EARLYCON
> > > +     bool "Earlycon on IMX serial port"
> > > +     depends on OF
> > > +     select SERIAL_EARLYCON
> > > +     default y
> > 
> > Only put "default y" if you can not boot a machine without this.
> > Otherwise leave the default line off, it will be 'n' and can be selected if a user
> > wants that.
> > 
> > That should be the case here, please change this.
> 
> I will change it to "default n" in next version, thanks.

No, just remove the line, the default is 'n' with no default specified.

thanks,

greg k-h
