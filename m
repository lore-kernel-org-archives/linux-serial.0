Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A217C2BB48
	for <linux-serial@archiver.kernel.org>; Mon, 14 Dec 2020 14:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFFCF22B47
	for <linux-serial@archiver.kernel.org>; Mon, 14 Dec 2020 14:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440118AbgLNOWP (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 14 Dec 2020 09:22:15 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40714 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440119AbgLNOWM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 Dec 2020 09:22:12 -0500
Received: by mail-lf1-f68.google.com with SMTP id m12so30496477lfo.7;
        Mon, 14 Dec 2020 06:21:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fJtEz9al1uekwzcPG8nGzE64cbHCld0XYyqWqe90Sj8=;
        b=VAogBM1Wcke/UI57k6teA+Ugday+UmK4/7aRi95cVkZuN6VEInyrmc8qipRq7LNMv1
         P9d5dJco7uG9zUx+mwFLCbbmcpli4Z2WVPANybpVCGZ/YwTDimRFKrLgHXIiHZMzEwR2
         q31EaVv7bxIh2kiRPGosml4Z69jsxg4EMxOclxT6KgPuyPcTTv439ovqd0gRovQzuwiC
         IVUNp6YrRjezIpeBT18uiiYPdNShOpb5gGJ+sOd46/Wcgn3aGeTQepYQW0Fsc6o5CcTl
         XpFaOw8YRuGiQoSsfLmGuqYWwj/zdksu9eWOQoGbBiwgFRngkr72qf7p6oz7BbhTiloP
         TFdQ==
X-Gm-Message-State: AOAM5327jGxZ2V6hipuVKNNDRnswKU7Y8Cr1oT8li2izl1BOuRcyhyJr
        aG5SKgV6KMJf8WAxQ3/0ceU=
X-Google-Smtp-Source: ABdhPJyizGMF7Fl3fVc2BrHPefV1R72r0AiHS/aa5AkNXWQTcDan1/S8tttH4g1+j4u4oTZ38enSnw==
X-Received: by 2002:a19:c882:: with SMTP id y124mr7548810lff.640.1607955684770;
        Mon, 14 Dec 2020 06:21:24 -0800 (PST)
Received: from xi.terra (c-b3cbe455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.203.179])
        by smtp.gmail.com with ESMTPSA id n23sm1843588lji.36.2020.12.14.06.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 06:21:23 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kooj1-0007pb-K6; Mon, 14 Dec 2020 15:21:19 +0100
Date:   Mon, 14 Dec 2020 15:21:19 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Mychaela Falconia <mychaela.falconia@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maarten Brock <m.brock@vanmierlo.com>,
        Johan Hovold <johan@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] tty: add flag to suppress ready signalling on open
Message-ID: <X9d039qPr/LO/2R/@localhost>
References: <20201202113942.27024-1-johan@kernel.org>
 <X9Dficb8sQGRut+S@kroah.com>
 <CA+uuBqYTzXCHGY8QnP+OQ5nRNAbqx2rMNzLM7OKLM1_4AzzinQ@mail.gmail.com>
 <6b81cca21561305b55ba8f019b78da28@vanmierlo.com>
 <X9H9i98E1Gro+mDP@kroah.com>
 <3fc3097ce1d35ce1e45fa5a3c7173666@vanmierlo.com>
 <X9IcKoofq+2iGZn7@kroah.com>
 <CA+uuBqaNcKadyLRyufm+6HUHXcs7o0rtgw84BrHc7Jq9PauV8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+uuBqaNcKadyLRyufm+6HUHXcs7o0rtgw84BrHc7Jq9PauV8Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Dec 10, 2020 at 10:59:41AM -0800, Mychaela Falconia wrote:

> Maarten Brock wrote:

> > Personally, I would prefer the VID:PID to enforce the quirk and an
> > O_DIRECT (or other) flag used on open() as general backup plan. To
> > me a sysfs solution seems illogical.
> 
> A sysfs solution could work as a sort of poor man's substitute for a
> VID:PID-driven quirk: instead of a driver quirk in the kernel, there
> is a udev rule that detects a particular USB-serial device (perhaps
> based on textual manuf/product strings as opposed to VID:PID) and sets
> the needed sysfs flag.  But then if we are talking about a special
> USB device as opposed to generic serial as in RS-232 etc, then I argue
> for a driver quirk: if the device has a custom VID:PID, a patch to the
> driver is needed in any case just to recognize that custom ID, so why
> not support the custom hw device properly by setting the quirk bit
> right there and then?  Seen in this light, the sysfs approach indeed
> makes little sense.
> 
> OTOH, if we are talking about RS-232 or similarly interfaced devices
> which the user plugs into any random serial port (PC native, or a
> random off-the-shelf USB-serial cable), then there is really nothing
> that a udev rule can key onto, it is just a user plugging in some
> serial device and then running custom userspace apps on it.  In this
> case asking the user to 'echo' something from the shell into /sys/blah
> prior to running her userspace app seems illogical indeed, and asking
> userspace app programmers to implement an equivalent sysfs write
> internally is equally awkward.  For this non-custom-USB-ID scenario I
> thus agree that the O_DIRECT approach would be better - in this case
> the userspace app programmer simply needs to add this one flag to
> their open call, a trivial one line change.

My reasons for proposing the NORDY sysfs interface *and* termios flag
are as follows:

 - The change should be minimal, but still support non-standard use of
   the modem control signals.

 - The interface should be compatible with using standard tools (e.g.
   echo and cat).

 - We control all other aspects of this (e.g. HUPCL) using termios and
   should continue to do so.

 - We cannot change the default behaviour so this NORDY flag needs to be
   disabled by default (i.e. hence the negation).

 - You cannot generally rely on the state of these lines before opening
   the port at least once, but for applications where this is possible
   and where even toggling them once is undesirable we *can* provide
   some out-of-band mechanism to change the default state of the NORDY
   flag (but we could also ignore this use case, keeping the status
   quo).

 - This could be an interface to control just the initial state of this
   flag after probe() or it can be used in parallel with the termios
   interface. The latter is what is implemented here.

 - As a bonus, using sysfs for this allows this feature to be used also
   before NORDY support has been added to the c libraries.

 - A sysfs interface also integrates well with udev and allows custom
   hardware that depend on this to be setup up once at boot regardless
   of whether an RS-232 or USB-serial interface is used.

Note that one of the BSDs recently added a termios flag with the same
semantics as the proposed NORDY which seems to suggest that this is
interface is indeed a natural one.

Side note: Also the Windows API has a setting for the state of these
lines *after* open (i.e. similar to a termios flag), and there are
reports of Windows users not expecting the lines to be raised on first
open (and behaviour changing between OS releases). For FTDI devices
there appears to be some driver-specific out-of-band mechanism in the
system properties for setting the default behaviour. Perhaps there's
also some general mechanism, I have no idea, I've never used this API.
But at least it doesn't seem to be as simple as Mychaela suggested
earlier, that Win32 got this right, for example, by never raising the
lines on open (by default).

> Greg K-H wrote:
> 
> > Companies/devices lie about vid:pid all the time,
> 
> Wait, are you accusing *me* of lying?  PID range 0x7150 through 0x7157
> out of FTDI's VID 0x0403 has been officially allocated by FTDI (please
> feel free to confirm with FTDI, no need to take my word blindly) to
> Falconia Partners LLC, which is *my* company - Falconia is my last
> name.  Therefore, any accusation of lying in connection with any
> VID:PID in this range, including DUART28C VID:PID of 0x0403:0x7152, is
> an accusation of lying against me personally, which I take very
> seriously.

Just chill, and then re-read what Greg wrote.

> > wait until your
> > specific vid:pid is repurposed for some other device and then what
> > happens?  :)

> > O_DIRECT is an interesting hack, has anyone seen if it violates the
> > posix rules for us to use it on a character device like this?
> 
> According to open(2) Linux man page, O_DIRECT does not come from POSIX
> at all, instead it is specific to Linux, FreeBSD and SGI IRIX.  Thus
> it seems like there aren't any POSIX rules to be violated here.

No, but we'd still be repurposing a flag which is used for something
entirely different.

> If we go with O_DIRECT, what semantics are we going to implement?
> There are 3 possibilities that come to mind most readily:
> 
> 1) O_DIRECT applies only to the open call in which this flag is set,
> and suppresses DTR/RTS assertion on that open.  If someone needs to do
> multiple opens with DTR/RTS suppression being required every time,
> then they need to include O_DIRECT every time.

This precludes using standard tools like echo/cat and terminal programs.

> 2) O_DIRECT applies not only immediately, but also sets a latched flag
> whereby all subsequent opens continue to suppress auto-assertion
> without requiring O_DIRECT every time.  This approach by itself runs
> counter to the generic Unix way of doing things, but it may be OK if
> there is also some ioctl to explicitly set or clear the latched flag.

Yeah, this is the worst option; you cannot even disable this feature
unless you provide an ioctl interface as well.
 
> 3) O_DIRECT applies only to the open call in which it is set, no
> built-in latching, but there is also some ioctl to control a flag
> enabling or disabling DTR/RTS auto-assertion on subsequent opens.

This would be my choice *if* we go this route.

> My vote would be to implement 1 first, for reasons of utmost
> simplicity, both interface and implementation, and then possibly
> implement 3 at some later time if and when someone actually needs that
> extra bit of complexity.

Option 1 is not generic enough, and essentially only allows for your
very specific use case (and not, for example, to suppress reset on open
when using various embedded boards with terminal programs/echo/cat).

> A strong argument can be made that if someone repurposed DTR and/or
> RTS signals on a serial port for some very different non-standard
> purpose, then they will almost certainly be writing their own custom
> userspace sw to talk to that serial port, as opposed to using standard
> existing userspace sw, hence asking them to include a non-standard
> flag on every open of their serial port shouldn't be too burdensome.

Not true, consider the various Arduino tinkerers, they may not even have
designed the reset circuit themselves.

Johan
