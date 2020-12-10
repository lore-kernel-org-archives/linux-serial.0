Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B34C4361B
	for <linux-serial@archiver.kernel.org>; Thu, 10 Dec 2020 19:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0591D23D9A
	for <linux-serial@archiver.kernel.org>; Thu, 10 Dec 2020 19:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390512AbgLJTAb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Dec 2020 14:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390545AbgLJTAX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Dec 2020 14:00:23 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADB8C0613D6;
        Thu, 10 Dec 2020 10:59:42 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id s85so3437982vsc.3;
        Thu, 10 Dec 2020 10:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DvqgseqJIArFNGH9KA39R1/fYgkYodoKH/XDLdpeHgM=;
        b=qeFwKbLoC+L4EW5tfW1vD4Lw0uapKkwbNE4L6SaDqrkn3jBv7ljp//dyvX4VOwtess
         aUj3cgIYksNn62bJbc77axWeX2JV2YOvsozo6suLvwZkJUfeaNkBX38doEnz/SHbOVGR
         X9ozVka0HxyjMddfqJVoUhARcxNvy0cWGggL98BCOYflNcr4wx7cLdOEIqxKBCKOQtWb
         nta0e+kKFMcnU2FiQzRR9qo9+NMe9Eoc/5fs5/+v5Ri/YRywh9mE0rQV2zz3NU1c91L2
         iHmaNyAL/kKZaqmPnjFH8lxLTSgo8Uxr8KpIdqlM60Awx9ebLlmhfOnPvCWh20/NOBJn
         1XTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DvqgseqJIArFNGH9KA39R1/fYgkYodoKH/XDLdpeHgM=;
        b=KeBeh21dpx/WLVM3rNt8ZkAhk+YOrZfx6iGWZOnd5SvC/z7d2Kgevb3UChRtUzsLXN
         5J+H9OjaddQ3qq14Yr0HbWEZq6F761XX7RTpE+CmeWCor+zo36BzUW2ZSE7/fSRLvNX8
         BM8DtMAb5bEefbeky/seftZ9t2s/RP7yK/iMUYCakEkBFFre257Ezv6YHkfckFQS3Ef6
         RtTj5P+3tWYd9NBAVVlSsxmaX7tqhYbFgWDEt15COXecY/tjGrPl97PE8KSMCw4vlU/9
         upSs6StFoKMqMK1DNHpAdNfz9sB8hK40wmcWyhymoTITyIeFyBjBskGyLpBEW2O7r3r7
         8WNQ==
X-Gm-Message-State: AOAM531++WtOqAdcgOpoA786R0FhgNydBHchW7cE0WynhT77CWG/Hieg
        eqLfVsLs4yA7rmSAEOtUXqvsHRcMenR4jqMfeahjted1hyo=
X-Google-Smtp-Source: ABdhPJz6rYqNTuM6g6BDV1p5H1+eJmum1HoVYMKg1A0f6YvTkl7kK4BKySqI2eH0oLOQYucWwDSdlgRPIklwseXwE0Q=
X-Received: by 2002:a05:6102:d1:: with SMTP id u17mr11024632vsp.8.1607626782052;
 Thu, 10 Dec 2020 10:59:42 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab0:6ecb:0:0:0:0:0 with HTTP; Thu, 10 Dec 2020 10:59:41
 -0800 (PST)
In-Reply-To: <X9IcKoofq+2iGZn7@kroah.com>
References: <20201202113942.27024-1-johan@kernel.org> <X9Dficb8sQGRut+S@kroah.com>
 <CA+uuBqYTzXCHGY8QnP+OQ5nRNAbqx2rMNzLM7OKLM1_4AzzinQ@mail.gmail.com>
 <6b81cca21561305b55ba8f019b78da28@vanmierlo.com> <X9H9i98E1Gro+mDP@kroah.com>
 <3fc3097ce1d35ce1e45fa5a3c7173666@vanmierlo.com> <X9IcKoofq+2iGZn7@kroah.com>
From:   Mychaela Falconia <mychaela.falconia@gmail.com>
Date:   Thu, 10 Dec 2020 10:59:41 -0800
Message-ID: <CA+uuBqaNcKadyLRyufm+6HUHXcs7o0rtgw84BrHc7Jq9PauV8Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] tty: add flag to suppress ready signalling on open
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Maarten Brock <m.brock@vanmierlo.com>,
        Johan Hovold <johan@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Greg K-H wrote:

> Thanks for the long response, but I think you have to realize that
> creating a new api for something that has been "how things work" since
> the 1970's should not be taken lightly.  No matter if it was a bug or
> not, changing user-visable behavior is not a trivial thing.

But I am NOT asking to change any user-visible behaviour on any
existing hardware made by anyone other than me, instead I am merely
asking to mainline a simple purely additive patch that adds support
for my custom FTDI device with a custom USB ID, to spare my users the
pain of applying that same patch locally on their own systems.

As a secondary objective, I am also contributing my thoughts toward a
generic solution for potential other affected devices that don't have
the luxury of a custom PCB with a fully embedded USB-serial chip - but
that one is more theoretical at the moment.

> What we
> come up with here has to stand the test of time of being able to be
> supported properly for the next 40+ years.

And how do we achieve this goal if the total number of people in the
world who care in any way at all can be counted on one hand?

Maarten Brock wrote:

> I agree. And an application not configuring the required handshakes, but
> still relying on them is an equal bug.

This comment can be interpreted in at least two different ways.  Are
you referring to:

1) Mainstream existing applications that expect DTR and/or RTS to be
asserted on open without doing any explicit TIOCMBIS,

or

2) My fc-host-tools programs (fc-loadtool, fc-xram, rvinterf etc) that
operate on the second UART of my DUART28C adapter, expect to NOT have
auto-assertion of DTR/RTS on open, but rely on my custom USB ID and
the ftdi_sio driver patch that goes with it to suppress this auto-
assertion, without doing any explicit TIOCMBIC.

If you are referring to 1, it is difficult to fault the authors of
those applications, as they had every right to depend on the behaviour
that had been codified in numerous official standards like POSIX.  Or
if you are referring to 2, what other choice do I have?  With existing
unpatched Linux kernels of every currently existing version, it is
*impossible* to prevent DTR & RTS auto-assertion immediately on open
of a tty device, thus applying a patch to the kernel (or at least to
the ftdi_sio driver in my case) is the *only* way to make my hardware
work with Linux.  Doing a TIOCMBIC after open won't help, as it will
be too late if the kernel already asserted DTR & RTS and thus caused
an unwanted deep reset.

> Any device with a classic old-fashioned RS-232 has probably already
> solved this in another way or is accepted as not working on Linux.

If someone built such a device for their own personal enjoyment rather
than for commercial sale, and needed to get it working with Linux, I
suspect that person most likely applied a local patch to the kernel
on their own system, likely implementing something similar to what is
being discussed in this thread.

> And then there is also the device tree (overlay?) through which a quirk
> like this can be communicated to the kernel driver.

This method should indeed work for embedded boards that feature some
kind of SoC where one or more native UARTs on that SoC need the quirk
applied to them.  But I don't have any such use cases, so let's defer
this approach until and unless there is at least one person in the
world who does.

> Not sure if this
> could help for a plug-and-play device like on USB.

I don't see how this method can be useful at all for devices that
connect to a standard (non-embedded) PC or laptop, whether USB or
RS-232.

> Personally, I would prefer the VID:PID to enforce the quirk and an
> O_DIRECT (or other) flag used on open() as general backup plan. To
> me a sysfs solution seems illogical.

A sysfs solution could work as a sort of poor man's substitute for a
VID:PID-driven quirk: instead of a driver quirk in the kernel, there
is a udev rule that detects a particular USB-serial device (perhaps
based on textual manuf/product strings as opposed to VID:PID) and sets
the needed sysfs flag.  But then if we are talking about a special
USB device as opposed to generic serial as in RS-232 etc, then I argue
for a driver quirk: if the device has a custom VID:PID, a patch to the
driver is needed in any case just to recognize that custom ID, so why
not support the custom hw device properly by setting the quirk bit
right there and then?  Seen in this light, the sysfs approach indeed
makes little sense.

OTOH, if we are talking about RS-232 or similarly interfaced devices
which the user plugs into any random serial port (PC native, or a
random off-the-shelf USB-serial cable), then there is really nothing
that a udev rule can key onto, it is just a user plugging in some
serial device and then running custom userspace apps on it.  In this
case asking the user to 'echo' something from the shell into /sys/blah
prior to running her userspace app seems illogical indeed, and asking
userspace app programmers to implement an equivalent sysfs write
internally is equally awkward.  For this non-custom-USB-ID scenario I
thus agree that the O_DIRECT approach would be better - in this case
the userspace app programmer simply needs to add this one flag to
their open call, a trivial one line change.

> > [Greg's objection to USB VID:PID quirks]
>
> This is true for a generic USB-UART board or cable, but not for a
> dedicated PCB where both the USB-UART chip and the special connection
> are implemented and which has a dedicated VID:PID different from any
> generic one. In this case the VID:PID describes the whole board.

Maarten's understanding is fully correct here: my DUART28C adapter is
a custom PCB that contains both the FT2232D USB-serial chip *and* the
special wiring whereby Channel B RTS & DTR outputs are repurposed into
CTL1 & CTL2 non-serial-related open drain control outputs, and my
custom VID:PID of 0x0403:0x7152 uniquely identifies this complete
custom-functionality PCB, not just the FT2232D part of it.

> If the line-wiggling requirement is created behind some sort of
> connector (real RS-232 DB9/DB25 or CMOS pin header or whatever)
> then the problem is the same as for an 8250 on any other bus. For
> this situation I would prefer the O_DIRECT flag on open().

I agree.

Greg K-H wrote:

> Companies/devices lie about vid:pid all the time,

Wait, are you accusing *me* of lying?  PID range 0x7150 through 0x7157
out of FTDI's VID 0x0403 has been officially allocated by FTDI (please
feel free to confirm with FTDI, no need to take my word blindly) to
Falconia Partners LLC, which is *my* company - Falconia is my last
name.  Therefore, any accusation of lying in connection with any
VID:PID in this range, including DUART28C VID:PID of 0x0403:0x7152, is
an accusation of lying against me personally, which I take very
seriously.

> wait until your
> specific vid:pid is repurposed for some other device and then what
> happens?  :)

Let's break it down:

1) I do have an idea for a future hw product that could indeed reuse
DUART28C VID:PID - however, the reason for reusing the same USB ID is
that the potential product in question would have exactly the same
wiring inside and require the exact same handling from Linux, i.e.,
suppress automatic DTR/RTS assertion on Channel B, but retain standard
behaviour on Channel A.

2) If I were to reuse the same USB ID for a different hw product that
should NOT receive the exact same quirk treatment, it would be 100% my
fault and I would have no right to run to OS maintainers complaining,
or even to sell such product, I would argue.

3) If some other party illegally squats on a PID out of FTDI's VID
range which FTDI officially allocated to me, and then comes to Linux
maintainers with a complaint however many years from now, whoever will
be the maintainer at that time will be able to check with FTDI, get an
official answer as to whom that PID rightfully belongs to, and that
will be the resolution.

> O_DIRECT is an interesting hack, has anyone seen if it violates the
> posix rules for us to use it on a character device like this?

According to open(2) Linux man page, O_DIRECT does not come from POSIX
at all, instead it is specific to Linux, FreeBSD and SGI IRIX.  Thus
it seems like there aren't any POSIX rules to be violated here.

If we go with O_DIRECT, what semantics are we going to implement?
There are 3 possibilities that come to mind most readily:

1) O_DIRECT applies only to the open call in which this flag is set,
and suppresses DTR/RTS assertion on that open.  If someone needs to do
multiple opens with DTR/RTS suppression being required every time,
then they need to include O_DIRECT every time.

2) O_DIRECT applies not only immediately, but also sets a latched flag
whereby all subsequent opens continue to suppress auto-assertion
without requiring O_DIRECT every time.  This approach by itself runs
counter to the generic Unix way of doing things, but it may be OK if
there is also some ioctl to explicitly set or clear the latched flag.

3) O_DIRECT applies only to the open call in which it is set, no
built-in latching, but there is also some ioctl to control a flag
enabling or disabling DTR/RTS auto-assertion on subsequent opens.

My vote would be to implement 1 first, for reasons of utmost
simplicity, both interface and implementation, and then possibly
implement 3 at some later time if and when someone actually needs that
extra bit of complexity.

A strong argument can be made that if someone repurposed DTR and/or
RTS signals on a serial port for some very different non-standard
purpose, then they will almost certainly be writing their own custom
userspace sw to talk to that serial port, as opposed to using standard
existing userspace sw, hence asking them to include a non-standard
flag on every open of their serial port shouldn't be too burdensome.

M~
