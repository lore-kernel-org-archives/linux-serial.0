Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAA9C433F5
	for <linux-serial@archiver.kernel.org>; Fri, 27 May 2022 22:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354816AbiE0Wgt (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 27 May 2022 18:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354808AbiE0Wgq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 27 May 2022 18:36:46 -0400
Received: from freecalypso.org (freecalypso.org [195.154.163.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94CE24BE4;
        Fri, 27 May 2022 15:36:44 -0700 (PDT)
Received: by freecalypso.org (Postfix, from userid 1001)
        id BA4D3374020E; Fri, 27 May 2022 22:27:03 +0000 (UTC)
From:   "Mychaela N. Falconia" <falcon@freecalypso.org>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        mychaela.falconia@gmail.com
Subject: [PATCH 0/6] serial ports: add ability to suppress raising DTR & RTS
 on open
Message-Id: <20220527222703.BA4D3374020E@freecalypso.org>
Date:   Fri, 27 May 2022 22:27:03 +0000 (UTC)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Back in 1970s UNIX a poor design decision was made regarding serial port
handling; this bad design has been codified into standards (POSIX, SUS)
and persists into present-day Linux.  In 2021 FreeBSD 13.0 became the
first Unix-style OS to fix the problem; the present patch series aims
to implement a similar solution in Linux.

The root of the problem is the POSIX/SUS-codified design decision to
always automatically assert both DTR and RTS modem control signals on
the initial open of a serial port, without giving userspace any ability
to say "no, please don't do it".  This design is flawed on a fundamental
philosophical level: an OS kernel needs to provide a mechanism for
applications to operate on hardware, rather than insert its own mind
in the middle.  If a user wishes to open any kind of hardware device
and perform arbitrary operations on that device, the kernel needs to
allow this access unobstructed, provided that the user has the necessary
permissions.  If the user is asking to merely open a hardware device,
but the kernel refuses to provide such "simple open" access without
mandatorily imposing some specific hardware action along with that
open, this behaviour needs to be considered a defect, a design bug.

Because the design bug is codified in POSIX, SUS etc, it cannot be
simply fixed - a change to default behaviour would violate standards
and break bazillion existing applications.  Instead the only possible
solutions at this point in time have to take the form of creative
workarounds - and by necessity, such creative workarounds should NOT
be expected to be "pretty" or architecturally clean.  The
architecturally-clean boat has sailed a few decades ago - in the
present time, non-pretty workarounds are required.

The solution implemented in FreeBSD relies on a feature of that OS
which does not exist in Linux: initial-state devices.  In FreeBSD
each ttyXX device also has a corresponding ttyXX.init device node;
the purpose of this .init device is to set the initial termios state
that will apply every time the regular ttyXX device is opened.
Furthermore, these .init devices have an additional property: opening
an init device does not raise modem control signals, unlike opening
of regular tty devices.  Having these init devices already available
(implemented a long time ago for unrelated reasons) made it possible
for FreeBSD to implement the option of suppressing automatic assertion
of DTR & RTS on open by way of a simple termios flag: they defined a
new termios flag CNO_RTSDTR (added to cflags) which needs to be set
on the /dev/ttyXX.init or /dev/cuaXX.init device _before_ opening
/dev/ttyXX or /dev/cuaXX for actual serial communication.

However, because Linux does not have any equivalent to FreeBSD's
/dev/ttyXX.init devices, FreeBSD's CNO_RTSDTR solution cannot be
copied to Linux verbatim.  A naive approach of copying FreeBSD's
termios flag and expecting users to set it on the regular /dev/ttyXX
device (lacking /dev/ttyXX.init) would not work: the act of opening
/dev/ttyXX for the purpose of setting the flag would in itself
assert DTR & RTS, which on some hardware devices can cause irreparable
harm to the user.  Instead the closest thing that can be implemented
in Linux would be a sysfs attribute attached to tty<x> serial devices,
and this sysfs approach is what the present patch series implements.

With this approach, a serial device control application (typically
developed together with the custom hw device in which DTR and RTS
are repurposed for non-standard uses) that seeks to support both
Linux and FreeBSD can treat both OSes in a unified manner, using
an abstraction function to hide the small difference between the two.
An application can implement an abstraction function like
set_initial_rtsdtr_mode(bool autoraise) with only the guts of this
function different between Linux and FreeBSD: the Linux version
would open /sys/class/tty/ttyXX/manual_rtsdtr and write into that
attribute file, whereas the FreeBSD version would open /dev/ttyXX.init
and set or clear CNO_RTSDTR termios flag.

It needs to be emphasized that the present patch series is a purely
additive change, merely adding a new optional mode of operation that
needs to be explicitly invoked by those users who desire it.  There
is NO change to any existing serial port behaviour or to anything
else pre-existing: until and unless a user explicitly writes into
the new /sys/class/tty/ttyXX/manual_rtsdtr attribute and sets it to 1,
absolutely nothing changes, exactly zero impact.

There is also one other possibility: there exist some hardware devices
in which a USB-serial converter chip and the application circuit behind
that chip (which repurposes DTR & RTS for non-standard uses) are
integrated into a single monolithic device, with a custom USB VID:PID
identifying the hardware device as a whole.  Because they are custom
ID codes not known at all to "naive" OS kernels, adding Linux support
for any such hw device will necessarily require adding knowledge of
that custom VID:PID to the appropriate USB-serial driver - and if it
is *known* that this paricular hardware device is wired in such a way
that requires the manual_rtsdtr flag to be set, then it makes the most
sense for the USB-serial driver to set the flag in the device-specific
quirk.  The present patch series adds support for one such device.

Mychaela N. Falconia (6):
  tty: add port flag to suppress raising DTR & RTS on open
  serial: core: add sysfs attribute to suppress raising DTR & RTS on
    open
  serial: core: fully suppress raising DTR & RTS on open if
    manual_rtsdtr
  USB: serial: add sysfs attribute to suppress raising DTR & RTS on open
  USB: serial: ftdi_sio: pass port to quirk port_probe functions
  USB: serial: ftdi_sio: add support for FreeCalypso DUART28C adapter

 Documentation/ABI/testing/sysfs-tty | 10 +++++++++
 drivers/tty/serial/serial_core.c    | 30 ++++++++++++++++++++++++-
 drivers/tty/tty_port.c              |  2 +-
 drivers/usb/serial/bus.c            | 36 +++++++++++++++++++++++++++--
 drivers/usb/serial/ftdi_sio.c       | 45 ++++++++++++++++++++++++++++++-------
 drivers/usb/serial/ftdi_sio_ids.h   |  1 +
 include/linux/tty_port.h            | 11 +++++++++
 7 files changed, 123 insertions(+), 12 deletions(-)

-- 
2.9.0

base-commit: 25e02ba60f0fbe65ba07553b5b2b8867726273c4
