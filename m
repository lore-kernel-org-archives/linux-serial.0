Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB06C4361B
	for <linux-serial@archiver.kernel.org>; Thu, 10 Dec 2020 13:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09F4323D57
	for <linux-serial@archiver.kernel.org>; Thu, 10 Dec 2020 13:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388777AbgLJNA4 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Dec 2020 08:00:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:50642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387551AbgLJNA4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Dec 2020 08:00:56 -0500
Date:   Thu, 10 Dec 2020 14:01:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607605215;
        bh=rTo9eetkSdm+KSFjwedHWy4XZCWRCFqMFGM9FGLKmrE=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=QnEyvwhkTC5cFbHjDbQDzFgWHNOL1OvdSIvNrK9YuQoXll0d3hsOpaK33Po70dhu8
         TZAME3F6ZZEIQEPC6cWn/DzVA8o2expRaTTVCDsjY18ts6Bv1+GESpKpEfC12Vijk5
         5wASxs3EHqWXPrGW3BsilrJWIDXx/zWZ8ka4M8nI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maarten Brock <m.brock@vanmierlo.com>
Cc:     Mychaela Falconia <mychaela.falconia@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] tty: add flag to suppress ready signalling on open
Message-ID: <X9IcKoofq+2iGZn7@kroah.com>
References: <20201202113942.27024-1-johan@kernel.org>
 <X9Dficb8sQGRut+S@kroah.com>
 <CA+uuBqYTzXCHGY8QnP+OQ5nRNAbqx2rMNzLM7OKLM1_4AzzinQ@mail.gmail.com>
 <6b81cca21561305b55ba8f019b78da28@vanmierlo.com>
 <X9H9i98E1Gro+mDP@kroah.com>
 <3fc3097ce1d35ce1e45fa5a3c7173666@vanmierlo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fc3097ce1d35ce1e45fa5a3c7173666@vanmierlo.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Dec 10, 2020 at 01:05:15PM +0100, Maarten Brock wrote:
> On 2020-12-10 11:50, Greg Kroah-Hartman wrote:
> > On Thu, Dec 10, 2020 at 11:41:24AM +0100, Maarten Brock wrote:
> > > Hello Mychaela,
> > > 
> > > On 2020-12-09 23:49, Mychaela Falconia wrote:
> > > > Greg K-H wrote:
> > > >
> > > > > I think we need more review for the rest of the series.  This does
> > > > > change the way serial ports work in a non-traditional way (i.e. using
> > > > > sysfs instead of terminal settings).
> > > >
> > > > But the problem is that the current status quo is fundamentally broken
> > > > for those hardware devices in which DTR and/or RTS have been repurposed
> > > > for something other than modem and flow control.  Right now whenever a
> > > > "cold" (never previously opened) serial port is opened for the first
> > > > time, that open action immediately and unstoppably asserts both DTR
> > > > and RTS hardware outputs, without giving userspace any opportunity to
> > > > say "no, please don't do it".  Yes, this behaviour is codified in a
> > > > bunch of standards that ultimately trace back to 1970s Original UNIX,
> > > > but just because it is a standard does not make it right - this
> > > > Unix/POSIX/Linux "standard" serial port behaviour is a bug, not a
> > > > feature.
> > > 
> > > I agree. And an application not configuring the required handshakes,
> > > but
> > > still relying on them is an equal bug.
> > > 
> > > > But if there exist some custom hw devices out there that are in the
> > > > same predicament as my DUART28 adapter, but are different in that they
> > > > are classic old-fashioned RS-232 rather than integrated USB-serial,
> > > > with no place to assign a custom USB ID, *then* we need a non-USB-ID-
> > > > dependent solution such as Johan's sysfs attribute or O_DIRECT.
> > > 
> > > Any device with a classic old-fashioned RS-232 has probably already
> > > solved this in another way or is accepted as not working on Linux.
> > > 
> > > And then there is also the device tree (overlay?) through which a
> > > quirk
> > > like this can be communicated to the kernel driver. Not sure if this
> > > could help for a plug-and-play device like on USB.
> > > 
> > > > > So I want to get a bunch of people
> > > > > to agree that this is ok to do things this way now before taking this
> > > > > new user-visible api.
> > > 
> > > Personally, I would prefer the VID:PID to enforce the quirk and an
> > > O_DIRECT (or other) flag used on open() as general backup plan. To
> > > me a sysfs solution seems illogical.
> > 
> > The "problem" of a vid:pid is that for usb-serial devices, that only
> > describes the device that does the conversion itself, NOT the serial
> > device the converter is plugged into that cares about these types of
> > line-wiggling.
> > 
> > Just like you would not want to classify all devices that met the PCI
> > serial class signature for this type of thing either, there is nothing
> > special about USB here other than it happens to be a common transport
> > for these signals these days.
> > 
> > thanks,
> > 
> > greg k-h
> 
> This is true for a generic USB-UART board or cable, but not for a
> dedicated PCB where both the USB-UART chip and the special connection
> are implemented and which has a dedicated VID:PID different from any
> generic one. In this case the VID:PID describes the whole board.

Companies/devices lie about vid:pid all the time, wait until your
specific vid:pid is repurposed for some other device and then what
happens?  :)

> If the line-wiggling requirement is created behind some sort of
> connector (real RS-232 DB9/DB25 or CMOS pin header or whatever)
> then the problem is the same as for an 8250 on any other bus. For
> this situation I would prefer the O_DIRECT flag on open().

O_DIRECT is an interesting hack, has anyone seen if it violates the
posix rules for us to use it on a character device like this?

thanks,

greg k-h
