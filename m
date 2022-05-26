Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2061AC433F5
	for <linux-serial@archiver.kernel.org>; Thu, 26 May 2022 08:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244897AbiEZI0I (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 26 May 2022 04:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiEZI0F (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 26 May 2022 04:26:05 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCD9C1EF7;
        Thu, 26 May 2022 01:26:04 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id y141so1682078ybe.13;
        Thu, 26 May 2022 01:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=cF4F8fR9RrLCIQgZCm7I0h1IGLH3ZvWS9O1N9K+Bhcc=;
        b=J9owjAjNOol3qvL5fD+FxkvWvvyyr+fiKj7zP3vK75HA/GCrK7W11JyqnBi5ZYFVpk
         OPzoeeDMcwCL6BHvgHHOjMTARiBVYRJPYeVRrytgasE2ujRVr6LbO1L9a07jaJ/Tp1cx
         soAnUj1Gori1RT2qxbN/jQFit0h1AJluuAEyHnkbvH5DTfbmIeveVtK5c99giLBtvQdG
         9r2gJPnCczkdRXWFedOT+vROpPdVx6aIp5Zpp0r6uAL71JO8et2JHA2KjNBcBkTe8gA2
         WVmBfLMykaOKiEDGecR89P6YhukXLAY6BRkNke5yfY3dVARrA7XLoQzFp+MDuUfLQBoy
         rwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=cF4F8fR9RrLCIQgZCm7I0h1IGLH3ZvWS9O1N9K+Bhcc=;
        b=wLRAb0aVot9eyZorpxCWy4UJK9/IrwkHeo57OC3tVq7GEZ0gYjrWOBRWSvb52zXxVp
         cUfxb53SYRtctR6hzlEaq+s6mg220ZA9UtlM4wCaUF/fiaKXmLQdoozJVI3WMCEPoZxa
         kUnPW22758eXgGVLHCBxMjthJFLK9DFSi2bOzuHR3ScFOi07HBQBjacduXcQi9PJYrhO
         qUB1yTTOJCyBhMc7elT4JEJ0Ct+FppMPLjeHg7UK8cLFjp5XSq1cMuBgMbj2pYPSuson
         H1RqdfVJXNeMsvbZxU3iOvubEWiciHpNlNOIZ+Y0HVNvQEOe+BwBHC3N2z5HSAnAqsS2
         WMYA==
X-Gm-Message-State: AOAM5333H8IvLf8xuc1A8GLC06LJxTvD/i9doQ8tmKNSYKG/7r3qrtHR
        OGKSTOjYnKd6pq4sRSlMFGwns08hlrUXygelidXfo6hQ
X-Google-Smtp-Source: ABdhPJxFrXUPBbpkcE38MScAMAlvnteEOgB59zBjsulMMo/RVSVP+6slaOR6NvJf0UOWtB9QL3SRibyz3h5P4yLLHrM=
X-Received: by 2002:a25:ada5:0:b0:64f:59d3:960e with SMTP id
 z37-20020a25ada5000000b0064f59d3960emr27762448ybi.401.1653553564005; Thu, 26
 May 2022 01:26:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:7aa7:0:0:0:0 with HTTP; Thu, 26 May 2022 01:26:03
 -0700 (PDT)
From:   Mychaela Falconia <mychaela.falconia@gmail.com>
Date:   Thu, 26 May 2022 00:26:03 -0800
Message-ID: <CA+uuBqZWHy80_kV30jmXiGpohyuxHa1obPGpi-oOWsAbufBZ5g@mail.gmail.com>
Subject: Revisiting unwanted auto-assertion of DTR & RTS on serial port open
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello Linux serial and usb-serial maintainers,

I am the hardware engineer who fought here unsuccessfully a year and a
half ago to add Linux support for serial hardware devices in which DTR
and/or RTS modem control signals have been repurposed for non-standard
uses.  On such hw devices it is very often the case that DTR and RTS
may be asserted ONLY when explicitly requested by specialized
userspace applications that go with the hw (by way of TIOCMBIS ioctl,
often followed by a delay and TIOCMBIC to produce a pulse), and NOT at
any other times - in particular, it must be possible to open the
serial port for byte Rx/Tx communication with the target device
_without_ that open syscall unstoppably asserting DTR & RTS right
there and then.  Here is the previous round of discussion:

https://lore.kernel.org/linux-serial/X8iuCXYhOBVMGvXv@localhost/T/

I am now revisiting this issue and making another attempt to get this
capability added to Linux.  The new development is that I have tested
the corresponding feature in FreeBSD, and found it to work correctly -
thus FreeBSD is now the first (and so far only) Unix-style OS in the
world that features an actually working, usable fix for the 1970s UNIX
design bug of unstoppably asserting DTR & RTS on serial port open.
Wouldn't it be good for Linux to follow suit?

The feature in question was added to FreeBSD quite recently:

https://reviews.freebsd.org/D20031

The above link was provided by Johan here a year and a half ago, in
the previous round of this battle.  However, only now I have had a
chance to test FreeBSD's implementation on actual hardware, and
confirm that it actually works as required for signal-repurposing hw
applications.

The diff that appears on the FreeBSD review page above only adds one
new termios flag, CNO_RTSDTR added to cflags.  Johan was proposing
implementing a similar new termios flag in Linux - however, there is a
crucial difference between what Johan was proposing for Linux vs what
is actually implemented in FreeBSD, and it's the difference between
usable and unusable.

FreeBSD's counterpart to Linux ttyUSBx is ttyUx or cuaUx devices.
However, FreeBSD also has .init and .lock devices which don't exist in
Linux, and it's the .init device that makes their newly added
CNO_RTSDTR feature actually work in a usable manner.  If you have a
serial device that absolutely does not tolerate unwanted assertions of
DTR/RTS, not even for one nanosecond, under FreeBSD you can make it
work as follows (using cuaU0 as example here):

Step 1: open /dev/cuaU0.init (the .init suffix is crucial) and perform
the ioctl setting CNO_RTSDTR on this initial-state device.  This step
can be done with stty command.  These .init devices have the special
property that opening one does NOT cause modem control lines to be
asserted, unlike the regular ttyXX or cuaXX device.

Step 2: once the previous step is done, you can open the regular
/dev/cuaU0 device for communication, and no unwanted DTR/RTS assertion
will happen.

Johan's proposal for Linux was superficially similar: he proposed
adding a similar new termios flag.  But because Linux does not have
any counterpart to FreeBSD's .init devices, a termios flag won't work
for this purpose in Linux, it would create a chicken-and-egg problem:
one would need to open the serial port first in order to set the
termios flag, and this very act would cause DTR & RTS to be asserted,
causing irreparable damage: electrocution, setting off explosives, use
your imagination for how these signals could be wired to do highly
damaging actions.

Out of various methods that were discussed here a year and a half ago,
only the sysfs approach would produce a user capability match to what
FreeBSD now provides.  The termios flag idea is a dead end, unless
this community feels that FreeBSD's ttyXX.init and ttyXX.lock should
also be replicated in Linux in full.  Another sensible way would be to
define a new open flag, such as O_NODTR, or reuse/abuse an existing
flag like O_DIRECT which currently does nothing for tty devices - but
people have objected that this approach would be limited to custom
userspace programs, precluding the use of echo, cat etc.

I now argue for the sysfs attribute approach.  Johan had a patch (he
made it, but didn't fight for it because he really preferred the
termios flag instead) adding a /sys/class/tty/ttyXXX/nordy attribute -
setting this attribute to 1 would suppress automatic assertion of DTR
and RTS on serial port open.  One could argue that a better name for
this new sysfs attribute would be something like
/sys/class/tty/ttyXXX/manual_dtr_rts - but I'll be happy no matter how
it's named, as long as the essential functionality remains.

This sysfs attribute would produce the same fundamental workflow as
currently exists in FreeBSD.  In FreeBSD one needs to open
/dev/cuaXX.init, do the necessary ioctl, then close that fd and open
another path (/dev/cuaXX) to do the actual serial communication.  With
the proposed sysfs attribute, the same fundamental workflow will apply
here: open the sysfs path, do the necessary attribute write, then
close the sysfs fd and open /dev/ttyXXX for the actual communication.
In both cases the preliminary step (/dev/cuaXX.init in FreeBSD, sysfs
path in my proposal for Linux) can be done from the shell, or it can
be incorporated into custom userspace sw that works with the custom hw
device.

I can dig up Johan's old patch adding the nordy attribute, update it
for current HEAD, and formally resubmit it - would the maintainers be
agreeable to such course?

Sincerely,
Mychaela Falconia (she/her)
Custom hardware design engineer,
designing hw specifically for use with FOSS operating systems
