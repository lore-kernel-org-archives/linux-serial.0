Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA8CC4361B
	for <linux-serial@archiver.kernel.org>; Fri, 11 Dec 2020 16:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A82812310E
	for <linux-serial@archiver.kernel.org>; Fri, 11 Dec 2020 16:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgLKPxN (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 11 Dec 2020 10:53:13 -0500
Received: from fieber.vanmierlo.com ([84.243.197.177]:50316 "EHLO
        kerio9.vanmierlo.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2393274AbgLKPwn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 Dec 2020 10:52:43 -0500
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
        (authenticated user m.brock@vanmierlo.com)
        by kerio9.vanmierlo.com (Kerio Connect 9.3.0 patch 1) with ESMTPA;
        Fri, 11 Dec 2020 16:51:14 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 11 Dec 2020 16:51:14 +0100
From:   Maarten Brock <m.brock@vanmierlo.com>
To:     Mychaela Falconia <mychaela.falconia@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] tty: add flag to suppress ready signalling on open
In-Reply-To: <CA+uuBqaNcKadyLRyufm+6HUHXcs7o0rtgw84BrHc7Jq9PauV8Q@mail.gmail.com>
References: <20201202113942.27024-1-johan@kernel.org>
 <X9Dficb8sQGRut+S@kroah.com>
 <CA+uuBqYTzXCHGY8QnP+OQ5nRNAbqx2rMNzLM7OKLM1_4AzzinQ@mail.gmail.com>
 <6b81cca21561305b55ba8f019b78da28@vanmierlo.com>
 <X9H9i98E1Gro+mDP@kroah.com>
 <3fc3097ce1d35ce1e45fa5a3c7173666@vanmierlo.com>
 <X9IcKoofq+2iGZn7@kroah.com>
 <CA+uuBqaNcKadyLRyufm+6HUHXcs7o0rtgw84BrHc7Jq9PauV8Q@mail.gmail.com>
Message-ID: <d07aee24a9635af1589c7536ba9e1c61@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
User-Agent: Roundcube Webmail/1.3.3
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2020-12-10 19:59, Mychaela Falconia wrote:
> Maarten Brock wrote:
> 
>> I agree. And an application not configuring the required handshakes, 
>> but
>> still relying on them is an equal bug.
> 
> This comment can be interpreted in at least two different ways.  Are
> you referring to:
> 
> 1) Mainstream existing applications that expect DTR and/or RTS to be
> asserted on open without doing any explicit TIOCMBIS,
> 
> or
> 
> 2) My fc-host-tools programs (fc-loadtool, fc-xram, rvinterf etc) that
> operate on the second UART of my DUART28C adapter, expect to NOT have
> auto-assertion of DTR/RTS on open, but rely on my custom USB ID and
> the ftdi_sio driver patch that goes with it to suppress this auto-
> assertion, without doing any explicit TIOCMBIC.
> 
> If you are referring to 1, it is difficult to fault the authors of
> those applications, as they had every right to depend on the behaviour
> that had been codified in numerous official standards like POSIX.  Or
> if you are referring to 2, what other choice do I have?  With existing
> unpatched Linux kernels of every currently existing version, it is
> *impossible* to prevent DTR & RTS auto-assertion immediately on open
> of a tty device, thus applying a patch to the kernel (or at least to
> the ftdi_sio driver in my case) is the *only* way to make my hardware
> work with Linux.  Doing a TIOCMBIC after open won't help, as it will
> be too late if the kernel already asserted DTR & RTS and thus caused
> an unwanted deep reset.

I was referring to 1) And I still think that an application that 
*relies*
on handshakes working should configure the handshakes, even if POSIX
promises they should be set up.

>> Any device with a classic old-fashioned RS-232 has probably already
>> solved this in another way or is accepted as not working on Linux.
> 
> If someone built such a device for their own personal enjoyment rather
> than for commercial sale, and needed to get it working with Linux, I
> suspect that person most likely applied a local patch to the kernel
> on their own system, likely implementing something similar to what is
> being discussed in this thread.

A person might have done that, a company will probably just not support
Linux or do a redesign with a different solution.

>> Personally, I would prefer the VID:PID to enforce the quirk and an
>> O_DIRECT (or other) flag used on open() as general backup plan. To
>> me a sysfs solution seems illogical.
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

Or use your option 3) mentioned below: open with O_DIRECT, use ioctl to
set the sticky flag and close before starting the application.

>> O_DIRECT is an interesting hack, has anyone seen if it violates the
>> posix rules for us to use it on a character device like this?
> 
> According to open(2) Linux man page, O_DIRECT does not come from POSIX
> at all, instead it is specific to Linux, FreeBSD and SGI IRIX.  Thus
> it seems like there aren't any POSIX rules to be violated here.
> 
> If we go with O_DIRECT, what semantics are we going to implement?
> There are 3 possibilities that come to mind most readily:
> 
> 1) O_DIRECT applies only to the open call in which this flag is set,
> and suppresses DTR/RTS assertion on that open.  If someone needs to do
> multiple opens with DTR/RTS suppression being required every time,
> then they need to include O_DIRECT every time.
> 
> 2) O_DIRECT applies not only immediately, but also sets a latched flag
> whereby all subsequent opens continue to suppress auto-assertion
> without requiring O_DIRECT every time.  This approach by itself runs
> counter to the generic Unix way of doing things, but it may be OK if
> there is also some ioctl to explicitly set or clear the latched flag.
> 
> 3) O_DIRECT applies only to the open call in which it is set, no
> built-in latching, but there is also some ioctl to control a flag
> enabling or disabling DTR/RTS auto-assertion on subsequent opens.
> 
> My vote would be to implement 1 first, for reasons of utmost
> simplicity, both interface and implementation, and then possibly
> implement 3 at some later time if and when someone actually needs that
> extra bit of complexity.
> 
> A strong argument can be made that if someone repurposed DTR and/or
> RTS signals on a serial port for some very different non-standard
> purpose, then they will almost certainly be writing their own custom
> userspace sw to talk to that serial port, as opposed to using standard
> existing userspace sw, hence asking them to include a non-standard
> flag on every open of their serial port shouldn't be too burdensome.
> 
> M~

Option 3) looks best to me.

Maarten

