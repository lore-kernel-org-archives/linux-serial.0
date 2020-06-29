Return-Path: <SRS0=FCDA=AK=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AA2C433E1
	for <linux-serial@archiver.kernel.org>; Mon, 29 Jun 2020 21:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38A7D2063A
	for <linux-serial@archiver.kernel.org>; Mon, 29 Jun 2020 21:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593466900;
	bh=NgETdEp/TPGsMKNJQFJucR9ZSygTH08g48sTzqUJy8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QLdzNr+Ra0u9om/FdzsM2Zdr6pS4Ijli2aE7AdbjnqwYch7o0X6oZzNr18eHnbJQK
	 CAoVXCQgUZJ77ch8wnEP2W/yoRRa4rusarHD1mK7ZhrkYggSOInNx3q3H3ycbIKaFr
	 q7OPz9zbtfhUwfrj9i9sRWHeYiqorB2nTIH1UL8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403751AbgF2Vlg (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:41:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgF2SkR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9501723370;
        Mon, 29 Jun 2020 08:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593420062;
        bh=NgETdEp/TPGsMKNJQFJucR9ZSygTH08g48sTzqUJy8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VfCp9hE0U1V55QP8CtGkrKq/7ClTTCkOVeDpojaZzjd7aUXx+6pITg+YyxFaYu4jr
         naHIJq0reLlZHSS6rTDqZoD6oWcAgnDmap4zDCam+du0CHBSo+I67WBnoXL2IzwO6f
         66sWli0Vhn6A4ZyHu6XwMOh6ciaE6hDAN4crXajo=
Date:   Mon, 29 Jun 2020 10:40:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     sean.wang@mediatek.com, robh+dt@kernel.org, jslaby@suse.com,
        robert.jarzmik@free.fr, arnd@arndb.de, p.zabel@pengutronix.de,
        joel@jms.id.au, david@lechnology.com, jan.kiszka@siemens.com,
        heikki.krogerus@linux.intel.com, hpeter@gmail.com, vigneshr@ti.com,
        matthias.bgg@gmail.com, tthayer@opensource.altera.com,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Steven Liu <steven.liu@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH v4] tty: serial: don't do termios for BTIF
Message-ID: <20200629084051.GA1234189@kroah.com>
References: <78efa2b1e2599deff4d838b05b4054ec5ac2976a.1592595601.git.sean.wang@mediatek.com>
 <20200627141222.GC1901451@kroah.com>
 <20200629082927.GA3703480@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629082927.GA3703480@smile.fi.intel.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jun 29, 2020 at 11:29:27AM +0300, Andy Shevchenko wrote:
> On Sat, Jun 27, 2020 at 04:12:22PM +0200, Greg KH wrote:
> > On Sat, Jun 20, 2020 at 03:59:14AM +0800, sean.wang@mediatek.com wrote:
> > > From: Sean Wang <sean.wang@mediatek.com>
> > > 
> > > Bluetooth Interface (BTIF) is designed dedicatedly for MediaTek SOC with
> > > BT in order to be instead of the UART interface between BT module and Host
> > > CPU, and not exported to user space to access.
> > > 
> > > As the UART design, BTIF will be an APB slave and can transmit or receive
> > > data by MCU access, but doesn't provide termios function like baudrate and
> > > flow control setup.
> > > 
> > > Even LCR on offset 0xC that is just a FAKELCR
> > > a. If FAKELCR[7] is equaled to 1, RBR(0x00), THR(0x00), IER(0x04)
> > >    will not be readable/writable.
> > > 
> > > b. If FAKELCR is equaled to 0xBF, RBR(0x00), THR(0x00), IER(0x04),
> > >    IIR(0x08), and LSR(0x14) will not be readable/writable.
> > > 
> > > So adding a new capability 'UART_CAP_NTIO' for the unusual unsupported
> > > case.
> > > 
> > > The bluetooth driver would use BTIF device as a serdev. So the termios
> > > still function would be called in kernelspace from ttyport_open in
> > > drivers/tty/serdev/serdev-ttyprt.c.
> 
> > > +#define UART_CAP_NTIO	(1 << 18)	/* UART doesn't do termios */
> > 
> > Naming is hard.  I will never remember what "NTIO" is, how about we make
> > it explicit:
> > 	define UART_CAP_IGNORE_TERMIOS
> > 
> > And the _CAP_ name is getting out of hand, this isn't a "capability",
> > it's a "quirk for this port" but that's a battle to worry about later...
> 
> For quirks we have a separate field in struct uart_port. Perhaps that can be used?

That would be much nicer, if possible.

thanks,

greg k-h
