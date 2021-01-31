Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9F9C433DB
	for <linux-serial@archiver.kernel.org>; Sun, 31 Jan 2021 00:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9520364E15
	for <linux-serial@archiver.kernel.org>; Sun, 31 Jan 2021 00:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbhAaATA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 30 Jan 2021 19:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbhAaASr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 30 Jan 2021 19:18:47 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14900C061573;
        Sat, 30 Jan 2021 16:18:06 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id a31so4570704uae.11;
        Sat, 30 Jan 2021 16:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LyxFFAFS840E82I0+cdF3gYsmZ74+Y7Z/mexV0iCmX0=;
        b=j28VeCbZmFwCqgRbT4SIEjmtebnFqpjMATN8SsXoa4dANCNTzmv3ohA6PEW4Q7juIf
         on8Yoh/y8VQXYAzKCI4b3WZ5Xg5y8hVTKAaN1v6q3QpK3cpu6TUJEPmCHUbXcqtIQpry
         NHPxrMcNbBpZf6/ckl3vxUC0J0zj9MNzQVlDqB8tvk3YJfzYDhlggw/gMP5zqk6VCn8n
         rIqsJmiop/l+JlLnVsC92txtOWLxW7EEwNVWQmcZiIRZ2PyBQ8xSTMSTyJRR2K+o/IIU
         kPrFLANfbMJ0k87gb38kMr4rBLdb8RaUH3/wCAVrbVsOkDra+F7tCDVinPV9vrcXJGwB
         raug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LyxFFAFS840E82I0+cdF3gYsmZ74+Y7Z/mexV0iCmX0=;
        b=XLkIu0j8Qbzs6CT3Xcjo6K7OuScbGk/tbt/JEPtujpSuLMj0EWEaNh8u+w0TJEKzt2
         NGz+LGgcz8HjJyg3AP2YbTNchroHjF6a+z3yhAtGCe1qSLtt8NiNJzxSLHe4eOTn0UBC
         +2yrjryk+QxljuGOFeyw08fiaK+n9eyZQnfplKUk3BjvdSSdQsvfU9a+2HhuaR8FHsM9
         wcTe/OVm6lamSfbZu+kkRU1le3SmGr7AXbEPR4mtaWoYC6XiODaMchSVx6jwHpgC2pxD
         lyB8mH22G9ofNCKlh5lnL9Fg4IzuRrPsrnU/btduFFIbH3Z0AwMVABfNYmTuoO/It26K
         pe4A==
X-Gm-Message-State: AOAM532cmq++RrjQk+TmdEWIQ+QaJSy2+koJOQ1jHXqB/wvSfwBWiTYo
        HC9VCQoJUBSeB1C7h5nr8MgJeHuslVjLcXwE12w=
X-Google-Smtp-Source: ABdhPJwID8lICH2SxxgoMxY6bmW6TJot0+K5xbnTw6rKK5L5i4bW3pHJsILSRROW1cyuGrO619kO5W3Xw7dW4BBfqQ0=
X-Received: by 2002:a9f:37ca:: with SMTP id q68mr6317842uaq.114.1612052285154;
 Sat, 30 Jan 2021 16:18:05 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab0:3052:0:0:0:0:0 with HTTP; Sat, 30 Jan 2021 16:18:04
 -0800 (PST)
In-Reply-To: <YBPxG+i/ZLP8/wg1@hovoldconsulting.com>
References: <20201202113942.27024-1-johan@kernel.org> <X9Dficb8sQGRut+S@kroah.com>
 <CA+uuBqYTzXCHGY8QnP+OQ5nRNAbqx2rMNzLM7OKLM1_4AzzinQ@mail.gmail.com>
 <6b81cca21561305b55ba8f019b78da28@vanmierlo.com> <X9H9i98E1Gro+mDP@kroah.com>
 <3fc3097ce1d35ce1e45fa5a3c7173666@vanmierlo.com> <X9IcKoofq+2iGZn7@kroah.com>
 <CA+uuBqaNcKadyLRyufm+6HUHXcs7o0rtgw84BrHc7Jq9PauV8Q@mail.gmail.com>
 <X9d039qPr/LO/2R/@localhost> <CA+uuBqZgq4KRZsqGRKDUbKAcQxYr1XPhYDrjzMNfWMYgDX8Wfg@mail.gmail.com>
 <YBPxG+i/ZLP8/wg1@hovoldconsulting.com>
From:   Mychaela Falconia <mychaela.falconia@gmail.com>
Date:   Sat, 30 Jan 2021 16:18:04 -0800
Message-ID: <CA+uuBqaf7cDJcXPsba5qKG78sak0dF4aHHtKOpUMj-0zNS-hAQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] tty: add flag to suppress ready signalling on open
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maarten Brock <m.brock@vanmierlo.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Greg K-H wrote:

> our job is to make Linux work for everyone.

But as your refusal to accept the purely additive (zero impact on
anything other than specific hw in question) patch adding support for
a new hardware device clearly indicates, your job is NOT to make Linux
work for everyone, but rather for a smaller subset of "everyone"
*other than* hardware designers who come to the maintainers in good
faith, asking to mainline support for new hardware they just made.

Johan Hovold wrote:

> I couldn't find any such guarantee about the state of these pins when in
> output mode in the document you refer to, but that's besides the point.

The FTDI document in question shows when the pins in question
transition between actively driving outputs and tristate, making it
clear to hw engineers that the Hi-Z state must be handled gracefully,
practically meaning that pull-up resistors to the I/O voltage rail
need to the added.  But as one can trivially confirm with an
oscilloscope, the power-up transition is from tristate to driving
HIGH, not low - the *only* time when the chip will drive low on these
outputs is when the USB host explicitly commands it to, either by
turning on DTR/RTS in UART mode or by switching to one of the non-UART
modes in which these pins acquire different functions.

> First, there are other serial devices than those from FTDI.

The same principle applies to the initial power-up state of every
other reasonable UART chip on the planet.  Take the very original 8250
with good old +5V supply voltage - as you first apply power to the
chip, the DTR and RTS outputs will be TTL high (corresponding to
RS-232 inactive), and they *will not* drive low until and unless you
write into the Modem Control Register to change their state.

> Second,
> these lines can be in any state when the OS boots (e.g. set by a
> previous user or OS).

If the user is specifically working with a special hardware device
that does not tolerate DTR/RTS being randomly jerked around, it is
that user's responsibility to ensure that there is NO "previous user
or OS" anywhere in the picture.  Right now the only active use case
(active use case one meaning one with at least one live human actively
campaigning for it in the present time) is my DUART28C, and in this
active use case the USB-serial interface and the DTR/RTS-sensitive
hardware behind this interface are inseparably integrated (a single
PCB) into one special USB device.  This special USB device does not
exist at all to the host computer until the user plugs it in with the
intent of operating on it - so there is *no* "previous user or OS" to
talk about.

> In fact, we already do provide such a way and perhaps that is what we
> should use here. We can simply have the ftdi_sio driver not bind to
> your control interface, which isn't a serial interface to begin with
> anyway.
>
> Then you're free to use it in whatever way you prefer using libusb.

Not acceptable: even though DTR and RTS lines from FT2232D Channel B
are repurposed for a non-serial function, the main TxD & RxD lines on
that FT2232D channel do form a standard serial interface, and it needs
to work as such.

Your proposal to use libusb for all serial communication on the
secondary channel is unacceptable because it would require writing two
versions of every userspace program that needs to talk to the second
UART of the Calypso GSM chip: one special libusb-based version for use
with DUART28C, and the other standard /dev/ttyXXX version for every
other possible serial port to which the second UART of a Calypso GSM
chip can be connected, of which there is a great multitude.

One part that might not be obvious and probably needs clarification is
that the second UART of the Calypso GSM chip (made by TI, not me) is a
data-leads-only (TxD & RxD only) interface without any modem control
or even hw flow control capability, hence whenever it is connected to
any standard UART, that standard UART's modem control and flow control
signals are left unconnected - thus DTR and RTS outputs go nowhere.
"Standard" userspace software that talks to this UART interface (if
one can use the word "standard" for software that is specifically
written to speak the proprietary serial protocol of one particular
chip vendor) thus does absolutely nothing regarding DTR and RTS - does
not touch them in any way, beyond the kernel's automatic assertion on
open and negation on close.

My only innovation in the DUART28C adapter is to take these two
otherwise unused outputs and repurpose them for a different useful
function.  My userspace programs take -Pdtr and -Prts options that
cause these outputs to be pulsed; in the absence of these options
(when the very same userspace program is used to talk to the very same
TI chip going through a different hw path than my DUART28C), nothing
special is done with DTR or RTS, and the kernel's automatic diddling
of these lines poses no problem when they are unused and unconnected,
as happens with every standard serial port connected to a data-leads-
only UART on target hw.

But in any case, I give up now.  You have made it quite obvious that
there is nothing I can say or do to convince you to accept my patch
adding support for the DUART28C device, thus every user of this
hardware will have to keep applying the needed patch locally on their
own system for the rest of eternity.

The present DUART28 hardware is not an end user product, instead it is
an accessory supplied along with my GSM development boards.  The whole
setup involves multiple boards interconnected with ribbon cables, and
requires an ESD workstation (grounded mat and wrist strap) to use
safely, without destroying the hardware with ESD.  In other words, not
something that can be sold or given out to consumer-level people.

However, I am considering making an integrated USB-plug-in GSM modem
product, a gadget enclosed in a clear plastic box (hence no ESD
control measures needed from the user) with just a USB male-A
connector sticking out.  Internally the device will consist of the
USB-side circuit from DUART28 (FT2232D-based) connected directly to my
Calypso modem for GSM - Calypso has no native USB, just two UARTs.
This proposed device will be 100% compatible with current DUART28C and
will thus share the same custom USB ID - but unlike my current
development boards where everything is mostly modular, the boot
control interface of DUART28C will be absolutely required to operate
the new fully integrated modem gadget.  Hence we are going to have an
*end user* (as opposed to deep developers only) product that will
absolutely require my ftdi_sio patch in order to operate.

My earlier references to how Windows handles DTR and RTS were examples
for comparison - I am not a Windows programmer (the closest I come is
porting some programs from Windows to Linux, including programs that
talk via serial ports), I don't have a Windows version of any of my
programs for working with TI Calypso GSM gear, thus if I do produce
the end user gadget I am thinking about, it will be a product
specifically intended for Linux users.  And because you are refusing
to mainline my patch adding support for the hw in question, every user
will be expected to patch their kernel locally, regardless of how new
or old their kernel happens to be.  (If you were more reasonable, then
only old kernel users would need to apply the patch locally, whereas
new kernels from some point onward would just work out of the box -
but it is not to be, given your stance.)

Thus I am going to produce an end user product (a USB-plug-in GSM
modem similar to ubiquitous "data sticks", but with the special
distinction of fully published source code for GSM radio firmware)
specifically for Linux users, accompanied by freely-licensed
published-source userspace application software, rather than for users
of proprietary OSes like Windows where proprietary drivers and
applications are the expected norm.  But because you are refusing to
accept the hardware support patch which I submitted in good faith and
spent enormous amounts of mental and emotional energy defending and
justifying, I will have no option but to include a printed leaflet
with every piece of hardware explaining the following to the end users:

1) How to apply the needed ftdi_sio driver patch locally;

2) Links to these mailing list threads, showing that we as the
hardware vendor have really tried to do everything reasonable to work
with the mainline;

3) A suggestion for end users that they should direct their anger and
frustration at the specific maintainers who are refusing to accept the
simple new hw support patch.

Who knows, if you suddenly get hundreds of angry emails from end users
(not from me!) who are subjected to the pain of applying a local patch
solely because of your obstinence, perhaps you might budge then.

> https://reviews.freebsd.org/D20031

I admit that I don't know much about FreeBSD, but the following parts
from the above page caught my attention:

: This patch allows "stty -f /dev/ttyu9.init -rtsdtr" to prevent
: RTS and DTR from being asserted on open(), allowing these devices
: to be used without problems.

I draw your attention to the /dev/ttyu9.init device name - what exactly
does the .init part signify?

: .Pp
: If
: .Dv CNO_RTSDTR
: is set then the RTS and DTR lines will not be asserted when the device
: is opened.
: As a result, this flag is only useful on initial-state devices.

Does anyone know what is this "initial-state device" they are talking
about?  Is it perhaps a special logical device that only manipulates
software data structures in the kernel but does not touch the actual
hardware, such that opening the .init device for the stty operation
will *not* in itself cause the hardware lines to be jerked?  If it is
so, then FreeBSD has a much more fundamental feature (these "init state"
devices) which Linux lacks, and in this case my hardware should indeed
work with FreeBSD.

*If* the "initial state" devices in FreeBSD really do have the special
quality of only manipulating software (kernel) state without touching
the actual hardware, *then* despite the superficial similarity in
appearance (both using a termios flag and stty), what FreeBSD has done
is fundamentally different from what Johan has been proposing with his
version of termios flag idea.

Johan's idea is that it is perfectly OK to jerk DTR and RTS control
lines once for the stty operation.  I vehemently disagree with this
idea.  In many devices one of the lines can be wired as a reset - and
let's say your setup is part of a production environment where resetting
a live running system is not acceptable.  There is also the oft-cited
example of radios where DTR and/or RTS turns on the transmitter - now
suppose that radio is operating on some tightly regulated frequency
related to mission-critical services, and spurious out-of-protocol
transmissions are a big no-no.  In short, Johan's idea of it being OK
to jerk the control signals "just once" is NOT OK with me and never
will be, and I will continue to fight against this idea till my last
breath.

Sincerely,
Mychaela,
she/her/hers
