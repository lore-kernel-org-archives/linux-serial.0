Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A5EC433FE
	for <linux-serial@archiver.kernel.org>; Wed,  9 Dec 2020 22:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCF5A23A22
	for <linux-serial@archiver.kernel.org>; Wed,  9 Dec 2020 22:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgLIWu1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 9 Dec 2020 17:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgLIWu1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Dec 2020 17:50:27 -0500
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE13CC0613CF;
        Wed,  9 Dec 2020 14:49:46 -0800 (PST)
Received: by mail-vk1-xa43.google.com with SMTP id v3so756214vkb.1;
        Wed, 09 Dec 2020 14:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Nw2F3TO4qXLlOXNaIL05f3p7ZwjgZpZstEv6cH6me40=;
        b=l6So5OZR3DS1yrWLDtAT9aiF0EyoP57jfijafTFmfVcePIzDGm+PJFKnhuq1B0R5E3
         m+lV3cls8REGE14Mact9jIzEuV1FSkVvubXPEBlbCMNXwc8nFgqxihfPGyWfOHj6Qc6H
         0d3qR9894FAMryIR+asfZOVI9/niSPZsMWTbiBtp8P+TTHrY90GYTrjJ6wUX6v2qdSPZ
         wfV1+0wTtaIBuRKAQjqi3DFSdTSXznt/FJMPDSohgOQB86g/VGyt3uABpCnw5Otpo0O+
         bMU2daOK6SwzrrVKOsc+2J5DkVQ7jks/c5Xp4jMjGVLNjJ2V70eaScNB0f3SB45BeW7x
         87aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Nw2F3TO4qXLlOXNaIL05f3p7ZwjgZpZstEv6cH6me40=;
        b=M/m6zl1+4KgMnd3KTi+isZiVJs5/2whdna9K6CRGUutdhf0f7BuHuOfeexzUd+GoH1
         8Rvgh4sflQPO/sLFFWN76ZLKnXX0BLnX3r+iy2hLX+zDTClptdv8+7+1cZKDYAeAQHAs
         W7vGNEcmm1MFKZXAn4STeXMUeYF4OJTJ9HQKnu8KQlxzmzXBJ3lNcvmLNtO6hfA64EzM
         RgZ6DuBCiYzieNW6+P43q/IiAd15yMLTvH2oDWqRmaoRpK0gxlEnVz/EXE18onDSdUu2
         e/I58tBP+8cFFfTG5huXYWp4SyvWuFs3hGaNWmmK+2g1MMdRCG20en78rjKHcBU3UqAL
         7+hA==
X-Gm-Message-State: AOAM532mGWlRud8UdnoOQJT8VoKJB2MJorz+Uptn8FJQx1A8xfP7rGXO
        ftacptLoI6reuLzTwjZlFb7WiJ5RbFI5y46kR2LJAGPX
X-Google-Smtp-Source: ABdhPJy7qj8LlQfBBdpuED+rWEN9W86H5FwWOgnFzvgJ99/Dbm9hqPlCuXS8Ozj6dufVIXCrzRUHpech6tyFsBuHi7c=
X-Received: by 2002:a1f:36d4:: with SMTP id d203mr5006670vka.22.1607554185954;
 Wed, 09 Dec 2020 14:49:45 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab0:6ecb:0:0:0:0:0 with HTTP; Wed, 9 Dec 2020 14:49:45 -0800 (PST)
In-Reply-To: <X9Dficb8sQGRut+S@kroah.com>
References: <20201202113942.27024-1-johan@kernel.org> <X9Dficb8sQGRut+S@kroah.com>
From:   Mychaela Falconia <mychaela.falconia@gmail.com>
Date:   Wed, 9 Dec 2020 14:49:45 -0800
Message-ID: <CA+uuBqYTzXCHGY8QnP+OQ5nRNAbqx2rMNzLM7OKLM1_4AzzinQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] tty: add flag to suppress ready signalling on open
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Greg K-H wrote:

> I think we need more review for the rest of the series.  This does
> change the way serial ports work in a non-traditional way (i.e. using
> sysfs instead of terminal settings).

But the problem is that the current status quo is fundamentally broken
for those hardware devices in which DTR and/or RTS have been repurposed
for something other than modem and flow control.  Right now whenever a
"cold" (never previously opened) serial port is opened for the first
time, that open action immediately and unstoppably asserts both DTR
and RTS hardware outputs, without giving userspace any opportunity to
say "no, please don't do it".  Yes, this behaviour is codified in a
bunch of standards that ultimately trace back to 1970s Original UNIX,
but just because it is a standard does not make it right - this
Unix/POSIX/Linux "standard" serial port behaviour is a bug, not a
feature.

All operating systems are fundamentally middlemen between applications
and hardware.  If custom application A is specifically written to work
with custom hardware H, it is the operating system's job to allow A to
operate on H without unreasonable interference, NOT to tell A and H
that they should change their hw and/or app design to fit a given OS
worldview.

Furthermore, hardware engineers who design custom gadgets have a
natural right to reduce hardware cost by employing designs that are
simple and elegant in hw terms - they should NOT be forced to make hw
designs more complicated, more expensive, or less convenient for end
users in order to please an OS.  To put it another way, OSes and OS
maintainers need to see themselves as working for end users and their
hardware and applications, not the other way around.

Here is my situation: I needed a little hardware adapter that goes
from USB to one UART with full modem and flow control signals (8-wire
UART), one more UART with only data leads and no modem or flow control
(2-wire UART), and two non-serial control signals that would allow a
connected host computer to simulate PWON and RESET pushbutton presses.
The simplest and most elegant hardware solution was to use an FT2232x
chip from FTDI (either FT2232D or FT2232H, I chose the D version
because I didn't need USB high speed), wire up one channel for the
8-wire UART, wire up the other channel for the 2-wire UART, and then
repurpose the otherwise unused Channel B RTS & DTR outputs to drive
PWON and RESET pushbutton signals via an open drain buffer IC.

The entire hardware solution for driving my PWON and RESET signals
consists of a single buffer IC that measures 1.00x1.45 mm - an epitome
of hardware simplicity and elegance, I would argue.  If my target OS
was Windows, I wouldn't be having all these problems: under Windows
when you open a "cold" serial port (USB-serial converter just plugged
in, not previously opened) for the first time, that first-open action
does NOT jerk DTR or RTS modem control signals, instead they are left
alone - and the application program can then control and configure how
they should function subsequently.  But Linux is being a bad boy: when
the serial port is opened, DTR and RTS are immediately asserted, and
there is no way to prevent it other than by applying a local patch to
the kernel on your system.

I realize that changing the default first-open behaviour to leave DTR
and RTS alone instead of asserting them would not be acceptable.
There are lots of devices that require DTR and/or RTS to be asserted
for serial communication to work, and because the standard (however
poorly thought through) behaviour has always been to auto-assert these
signals on open, most standard serial applications rely on this
automatic assertion - almost no one does an explicit TIOCMBIS of DTR
and RTS after open.

Thinking as a hardware engineer, to me the most natural solution to
this Linux problem is to use a custom USB ID upon which a driver quirk
is then conditionalized.  All major USB-serial chips feature either a
built-in EEPROM or OTP configuration memory, or a provision for
connecting a board-level EEPROM.  One of the parameters set in this
hardware config EEPROM is the USB VID:PID which the USB-serial chip
will present itself as.  Furthermore, most USB-serial chip vendors (at
least FTDI and Silabs for sure) allow their customers (designers of
custom hw containing their chips) to obtain a custom PID out of that
chip vendor's USB VID, making it very very easy for custom USB-serial
boards to have custom USB IDs.

So I program the EEPROM on my custom DUART28 board with the custom USB
ID which FTDI officially allocated to me (thus this ID code absolutely
uniquely identifies my specific hardware and no other), and I prepare
a patch for the ftdi_sio driver which I thought would be
non-controversial: adding support for my new FT2232D-based device by
adding its custom USB ID to the ID code table, along with a quirk that
suppresses automatic assertion of DTR & RTS on open for the Channel B
ttyUSB device.  I thought my patch would be non-controversial: it is
simply adding support for a new hardware device which was not
previously supported by Linux at all, same as if I were adding an
entirely new driver, and has ZERO impact on any other hardware, any
other applications, any other users, any other anything - just support
for a new hw device with a special quirk and nothing more.

But Johan objects to simply merging my ftdi_sio driver patch by itself
because it is not a general solution, because it covers only one
specific hw device.  Johan proposed a more generalized solution that
would still satisfy me and the end users of my hardware because in the
end it still includes recognition of my custom USB ID, setting the
needed quirk flag upon seeing this ID - but now Johan's generalized
patch series is not acceptable either?  So what gives?

At the end of the day we have a situation where the creators of
Original UNIX have made a design mistake back in the 1970s, and this
design mistake persists to this day in all current Unix-style OSes
including Linux.  The design mistake in question is unconditionally
asserting DTR and RTS upon the first open of a previously cold serial
port.  This behaviour is harmless for most devices in which DTR and
RTS retain their standard RS-232 functions, but it is a killer for
those hw devices in which either or both signals have been repurposed
for something very different, some other function that does not
tolerate unwanted signal assertion.

Unix/POSIX/Linux OSes are at fault here, I argue, NOT hardware
engineers who build gadgets in which these signals are repurposed.
The physical hardware behaviour of a classic old-fashioned RS-232 DTE
port is that when the hardware powers up, the output voltage on DTR
and RTS lines goes from zero to -12 V, indicating negated state - it
never goes toward +12 V corresponding to asserted state, until and
unless software takes action to raise those signals.  Same deal with
modern USB-serial chips: when USB VBUS power is applied, DTR and RTS
outputs immediately go CMOS high (still corresponding to negated
state), or they remain tristated until enumeration, in which case
pull-up resistors solve the problem - but they *never* go into the
state of actively driving CMOS low (overriding pull-up resistors)
until and unless software sends the necessary USB control pipe
command.

Hardware engineers have every right to design gadgets that take
actions upon asserted DTR/RTS (CMOS low or RS-232 +12V), actions that
should not occur when not explicitly requested, and we the hardware
engineers feel justified in this stance because the state of CMOS low
or RS-232 +12V on DTR and RTS control lines never occurs in the
hardware on its own, this state only occurs upon software command -
thus we the hardware engineers have the right to ask OS maintainers to
provide a way to NOT send that software command until and unless the
user's application explicitly requests it.

If this design flaw had been noticed back in the 1970s and addressed
in some way, we wouldn't be having this discussion.  But here we are
almost a half-century later, and the problem is still unresolved.  So
how do we solve this problem now, after having ignored it for 45 y?
Simply changing the default action upon first open of a previously
cold serial port to not automatically assert DTR & RTS won't work:
plenty of devices (classic modems etc) require DTR and/or RTS to be
asserted for communication to work, and plenty of applications rely on
automatic assertion of these signals on the first open of a previously
cold serial port.  Adding configurable termios flags etc won't help
either: one needs to open a port in order to do ioctls on it, and if
that first open still raises DTR & RTS, then users of custom hw are
still screwed.

Thus we need some out-of-band mechanism.  There are only 3
possibilities:

1) Reusing/abusing some open flag like O_DIRECT, perhaps only for the
very first open, and then setting a termios or setserial flag to
change behaviour on subsequent opens;

2) A sysfs attribute like in Johan's proposed patch series;

3) ID-code-specific quirks in USB-serial chip drivers.

At this point an important question needs to be asked.  Johan mentioned
that the issue I am dealing with (needing some way to suppress unwanted
auto-assertion of DTR/RTS) has come up in the past in the context of
ham radio devices.  Does Johan or anyone else know what their physical
form factor and serial interface was/is?  Was it true old-fashioned
RS-232 such that the device could be connected to "any" serial port,
or was it a custom USB-interfaced board with an integrated USB-serial
chip?

If every non-standard serial port device currently in existence that
does not tolerate automatic assertion of DTR/RTS and requires the
changes we discussing takes the physical form of a custom circuit
board with a USB connector and a built-in USB-serial chip, with all
UART signals staying in the CMOS (or more likely LVCMOS) logic voltage
level domain without ever becoming old-fashioned RS-232, then the
whole argument about supporting "any" serial port becomes moot.  In
this case the simplest and least invasive solution is to assign custom
USB IDs to all such non-standard devices by way of their respective
EEPROMs, and support these custom USB ID devices with driver quirks -
no need for sysfs, no need for O_DIRECT, no need to touch any kernel
code at all outside of individual USB-serial chip drivers.

But if there exist some custom hw devices out there that are in the
same predicament as my DUART28 adapter, but are different in that they
are classic old-fashioned RS-232 rather than integrated USB-serial,
with no place to assign a custom USB ID, *then* we need a non-USB-ID-
dependent solution such as Johan's sysfs attribute or O_DIRECT.

> So I want to get a bunch of people
> to agree that this is ok to do things this way now before taking this
> new user-visible api.

So where and how are we going to find that bunch of people?  What
happens if no one gives a damn one way or another?  Neither I nor Johan
are proposing any change whatsoever to any existing behaviour or any
existing interfaces - simply providing a new option, such that if you
don't care about it and don't set it, absolutely nothing changes and
nothing is impacted in any way whatsoever.

If the concern is with the new sysfs interface or the proposed O_DIRECT
alternative, how about deferring those while allowing specific USB ID
support to go in first?  Right now there already exists at least one
piece of hardware actively supported by its manufacturer (my gadget)
that has a custom USB ID and requires the quirk - what is wrong with
adding support for this existing specific hw?  How about merging
Johan's patch that defines the NORDY flag in tty_port, merging the
ftdi_sio driver patch setting this flag for my custom USB ID, allowing
other hardware engineers in the same boat to submit similar quirk
patches for their affected custom hw with custom USB IDs, while
deferring the sysfs patches until there is a more pressing need for
quirky devices that have no custom USB IDs?

Sincerely,
Mychaela
