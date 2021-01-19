Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFA6C10F07
	for <linux-serial@archiver.kernel.org>; Tue, 19 Jan 2021 18:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46C6E23109
	for <linux-serial@archiver.kernel.org>; Tue, 19 Jan 2021 18:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbhASO61 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 19 Jan 2021 09:58:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:41002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404937AbhASMel (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 Jan 2021 07:34:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A52D2310E;
        Tue, 19 Jan 2021 12:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611059632;
        bh=nhLuurJSrgADMg3lBfOTeTfYMIf5bFMG7UNgaXRHqZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XMFySzbpHGeNgMMesjH9tuaLgO7p7bI6r5Eg9KF5YH4R+v+FeIvF8htdqA9C2hk2z
         cZjZWaTyWQz+PWPcYgAX5FxSUAUWHtx8YqgpkkHPXhTgJonIU8FKqtiPzqPIIGRgc4
         GEfcF2bkYGSR4csEKZpOTayWgH0Mz+4RHeu7OT/w=
Date:   Tue, 19 Jan 2021 13:33:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Al Cooper <al.cooper@broadcom.com>
Cc:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/2] serial: 8250: Add new 8250-core based Broadcom
 STB driver
Message-ID: <YAbRrSSNkzcvGSL3@kroah.com>
References: <20210115211543.33563-1-alcooperx@gmail.com>
 <20210115211543.33563-3-alcooperx@gmail.com>
 <YAXJRDhS1HXeYaZz@kroah.com>
 <CAGh=XABU=jdLWo8AfSBZPwn+_gDfCNN07cg9a58nxknjjyEfxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGh=XABU=jdLWo8AfSBZPwn+_gDfCNN07cg9a58nxknjjyEfxg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jan 18, 2021 at 03:32:57PM -0500, Al Cooper wrote:
> On Mon, Jan 18, 2021 at 12:45 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Jan 15, 2021 at 04:15:43PM -0500, Al Cooper wrote:
> > > Add a UART driver for the new Broadcom 8250 based STB UART. The new
> > > UART is backward compatible with the standard 8250, but has some
> > > additional features. The new features include a high accuracy baud
> > > rate clock system and DMA support.
> > >
> > > The driver will use the new optional BAUD MUX clock to select the best
> > > one of the four master clocks (81MHz, 108MHz, 64MHz and 48MHz) to feed
> > > the baud rate selection logic for any requested baud rate.  This allows
> > > for more accurate BAUD rates when high speed baud rates are selected.
> > >
> > > The driver will use the new UART DMA hardware if the UART DMA registers
> > > are specified in Device Tree "reg" property. The DMA functionality can
> > > be disabled on kernel boot with the argument:
> > > "8250_bcm7271.disable_dma=Y".
> >
> > Shouldn't that be on a per-device basis, and not a per-driver basis?
> 
> There is only one instance of the UART DMA hardware and it gets muxed
> to just one of the possible UARTS.

But the driver doesn't know/care about that, it binds to any device that
matches it.  per-module/driver flags are not a good idea.

> > And why would you want to disable this, if you have support for this in
> > the DT?  Why not just rely on the DT setting?
> 
> The DMA feature is used when the UART is connected to a Bluetooth
> controller and the BAUD rate is typically 2-3Mbs. The ability to
> easily disable DMA is very useful when debugging BT communication
> problems in the field. DT settings could also be used to disable DMA,
> but knowing the correct modifications to the "reg" and "reg-names"
> properties is a lot more complicated.

So this is a debug-only option?  If so, why not just make it a debugfs
file then?  No need to clutter up a module parameter for this mess.

thanks,

greg k-h
