Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA69FC433FE
	for <linux-serial@archiver.kernel.org>; Mon, 30 May 2022 13:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237040AbiE3NbQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 30 May 2022 09:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237238AbiE3NaP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 30 May 2022 09:30:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1D3562C4;
        Mon, 30 May 2022 06:26:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42F60B80AE8;
        Mon, 30 May 2022 13:26:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A194C3411A;
        Mon, 30 May 2022 13:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653917211;
        bh=jQxRXVeofHNHJwXBNCoacrIHt+NDfKthlcM1Aw4nXmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vD8SBMIjmxM38Xn4OgWF+oRNE7kkCCqOEA/RtpNj4VpZMwBqSnuN8t4aXTDN2DLF2
         Kd+jrbeI7pQBZ6x5chNP8Ko4jHdzA3AiMwrz24iemd3kOWEwI+jSUDhcPEOldzAHV4
         GAhUz4VaspsGax0FgN5cAnxtA1u5gK6/1E1aFTZQ=
Date:   Mon, 30 May 2022 15:26:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Mychaela N. Falconia" <falcon@freecalypso.org>
Cc:     Johan Hovold <johan@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        mychaela.falconia@gmail.com
Subject: Re: [PATCH 0/6] serial ports: add ability to suppress raising DTR &
 RTS on open
Message-ID: <YpTGF1dh2RafcFT2@kroah.com>
References: <20220527222703.BA4D3374020E@freecalypso.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527222703.BA4D3374020E@freecalypso.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 27, 2022 at 10:27:03PM +0000, Mychaela N. Falconia wrote:
> Back in 1970s UNIX a poor design decision was made regarding serial port
> handling; this bad design has been codified into standards (POSIX, SUS)
> and persists into present-day Linux.

Odd that you state it this way, as this IS the RS-232 standard
requirement that was released in 1968, so codifying it into the POSIX
standard and using it in Linux today was a good thing so that we can use
Linux on hardware built for the standard.

To ignore the public, accepted, standard is to become an operating
system that does not follow the standard, which would not be a good
thing at all.

> In 2021 FreeBSD 13.0 became the
> first Unix-style OS to fix the problem; the present patch series aims
> to implement a similar solution in Linux.

Again, this is not a "problem", it is a "let us use these pins for
something that they were not designed to be used for" type of thing.
You are wanting to ignore the well known and very common standard of the
past 53 years because you wish to reuse a UART pin as a GPIO pin, which
is not any sort of standardized thing at all.

> The root of the problem is the POSIX/SUS-codified design decision to
> always automatically assert both DTR and RTS modem control signals on
> the initial open of a serial port, without giving userspace any ability
> to say "no, please don't do it".

Again, that is the standard, why wouldn't you want to do that?  To not
do that would be to break interoperability with millions of devices out
there (remember modems?)

> This design is flawed on a fundamental
> philosophical level: an OS kernel needs to provide a mechanism for
> applications to operate on hardware, rather than insert its own mind
> in the middle.  If a user wishes to open any kind of hardware device
> and perform arbitrary operations on that device, the kernel needs to
> allow this access unobstructed, provided that the user has the necessary
> permissions.  If the user is asking to merely open a hardware device,
> but the kernel refuses to provide such "simple open" access without
> mandatorily imposing some specific hardware action along with that
> open, this behaviour needs to be considered a defect, a design bug.

Again, this is not a design bug, but the requirement that the OS follow
the 50+ year old documented and accepted standard for this hardware
interface.  This is designed properly.

> Because the design bug is codified in POSIX, SUS etc, it cannot be
> simply fixed - a change to default behaviour would violate standards
> and break bazillion existing applications.  Instead the only possible
> solutions at this point in time have to take the form of creative
> workarounds - and by necessity, such creative workarounds should NOT
> be expected to be "pretty" or architecturally clean.  The
> architecturally-clean boat has sailed a few decades ago - in the
> present time, non-pretty workarounds are required.

Again, you are wanting a workaround for a limitation of your hardware
design, not a limitation of the RS-232 standard.  You are creating
non-compliant hardware and wish to control it in a way the hardware was
not originally intended to be controlled.

And that's fine, but don't speak of it as if we somehow messed up 53
years ago and no one has noticed it since then.  That's just
condencending to all of us who have maintained and worked with this
codebase and standard for these 50+ years.

On a personal note, I've been working on UARTs and RS-232 since "only"
1992 on a paid basis, and I have never heard of anyone objecting to this
portion of the RS-232 standard in a way to make it sound like it was
designed incorrectly this way.  But then again, I've only been doing
this for 30 years now, maybe I'm too new at this :)

> The solution implemented in FreeBSD relies on a feature of that OS
> which does not exist in Linux: initial-state devices.

Linux dropped those a long time ago for good reasons, let's not revisit
that design decision again please.

> There is also one other possibility: there exist some hardware devices
> in which a USB-serial converter chip and the application circuit behind
> that chip (which repurposes DTR & RTS for non-standard uses) are
> integrated into a single monolithic device, with a custom USB VID:PID
> identifying the hardware device as a whole.  Because they are custom
> ID codes not known at all to "naive" OS kernels, adding Linux support
> for any such hw device will necessarily require adding knowledge of
> that custom VID:PID to the appropriate USB-serial driver - and if it
> is *known* that this paricular hardware device is wired in such a way
> that requires the manual_rtsdtr flag to be set, then it makes the most
> sense for the USB-serial driver to set the flag in the device-specific
> quirk.  The present patch series adds support for one such device.
> 
> Mychaela N. Falconia (6):
>   tty: add port flag to suppress raising DTR & RTS on open
>   serial: core: add sysfs attribute to suppress raising DTR & RTS on
>     open
>   serial: core: fully suppress raising DTR & RTS on open if
>     manual_rtsdtr
>   USB: serial: add sysfs attribute to suppress raising DTR & RTS on open
>   USB: serial: ftdi_sio: pass port to quirk port_probe functions
>   USB: serial: ftdi_sio: add support for FreeCalypso DUART28C adapter

From what I recall with the original patch series, Johan is the author
of these, not you.  Rebasing and forwarding on is great, but please
never drop original authorship of patches, that's just rude, and in
some cases, ripe for legal worries.

Can you fix that all up, tone down the "this is all wrong" verbage, and
properly resend the series as a joined patch series (your emails are not
threaded properly at all and our tools can not find them correct, just
use 'git send-email' and that would solve it.) and then after the merge
window, I'll reconsider this series.

Also please document what has changed since Johan's original submission
to now, and why it should now be accepted when it was rejected then.

thanks,

greg k-h
