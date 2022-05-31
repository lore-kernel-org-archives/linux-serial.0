Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE951C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 31 May 2022 04:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243828AbiEaEeb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 31 May 2022 00:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243795AbiEaEeb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 31 May 2022 00:34:31 -0400
Received: from freecalypso.org (freecalypso.org [195.154.163.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0FC814B4;
        Mon, 30 May 2022 21:34:28 -0700 (PDT)
Received: by freecalypso.org (Postfix, from userid 1001)
        id 8CAB637401A9; Tue, 31 May 2022 04:33:56 +0000 (UTC)
From:   "Mychaela N. Falconia" <falcon@freecalypso.org>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        mychaela.falconia@gmail.com
Subject: [PATCH v2 0/6] serial ports: add ability to suppress raising DTR & RTS
 on open
Message-Id: <20220531043356.8CAB637401A9@freecalypso.org>
Date:   Tue, 31 May 2022 04:33:56 +0000 (UTC)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There exist serial-attached specialty hardware devices, both RS-232
and USB-serial, in which DTR and/or RTS modem control outputs have
been repurposed for non-standard uses.  Many people will argue that
such devices shouldn't exist because they go against RS-232 standards,
but they exist primarily for reasons of practicality and economics.
If someone has an end application that consists of a data-leads-only
UART (TxD & RxD only, no flow control or modem control) plus one or two
ad hoc control lines (could be thought of as GPIOs, but unidirectional
from the host to the target), it is far more practical and economical
to repurpose otherwise unused DTR & RTS control lines in the already
given serial interface than to build extra hardware interfaces at
extra cost for the purpose of conveying the needed custom signaling.

As just one example, consider a device that consists of a data-leads-only
UART and two control buttons, Button1 and Button2.  Telling designers
of such specialty hw and their user communities that they should run a
second (or third, if there already is a second) separate serial port
to their target, and put an extra processor in the device that would
listen on that extra serial port and interpret ASCII '1' as a Button1
command, ASCII '2' as a Button2 command is a non-starter, when they
can instead wire up the circuit such that a pulse on RTS triggers
Button1 and a pulse on DTR triggers Button2.

Unfortunately such specialty hw applications were not considered back
in 1970s and 80s when UNIX serial port handling behaviour was codified
into standards, and it so happened that the standard POSIX/SUS
behaviour of automatically and unconditionally asserting both DTR and
RTS on serial port open is incompatible with specialty hw devices in
which these signals are repurposed for non-standard uses.

Changing standard serial port behaviour is not possible, hence the
only way to add support for non-standard hw devices is to implement
some completely optional, OS-specific mechanism by which an application
can ask the OS to override standard behaviour on a per-port basis
prior to opening the ttyXX serial device.

In 2021-04 FreeBSD 13.0 became the first Unix-style OS that makes it
possible for specialty applications to open a serial port (both
traditional PC serial ports and USB-serial are supported) without ever
asserting DTR & RTS.  However, the specific way in which this feature
is implemented in FreeBSD depends on their /dev/ttyXX.init devices,
which for better or worse do not exist in Linux.  Therefore, a
functionally comparable Linux implementation (giving the same
in-the-end capability to users) would have to make use of some other
OS-specific trick, this time Linux-specific.

The present patch series implements the desired capability and
functionality in Linux, providing two ways to mark a particular serial
device as subject to special non-standard operation:

1) For both "hard" serial ports (serial_core) and USB-serial, there is
   a new boolean sysfs attribute attached to the tty device.  Writing
   1 into this attribute activates the special mode of suppressing
   DTR & RTS on open, writing 0 restores standard operation.  In the
   present version of this patch series, this sysfs atttribute is
   named nordy - this name was chosen by Johan Hovold in late 2020.
   I personally dislike this choice of name, but I defer to more
   senior kernel developers and maintainers on the final choice of
   name, and will be happy to rename to whatever is chosen.  To end
   users, it is functionality that matters, not the name.

2) In the present day, it will often be the case that the user-visible
   interface to the specialty hw device is USB rather than RS-232, with
   a USB-serial converter chip integrated internally inside the custom
   device that repurposes its DTR and RTS outputs.  In such hardware
   situations, the EEPROM-assigned custom USB VID:PID on the USB-serial
   device identifies the hw product as a whole, including the part that
   repurposes DTR & RTS, rather than just the USB-serial converter part.
   At times when the described situation does hold and there does exist
   a custom USB VID:PID that explicitly and umambiguously identifies
   the device as one that requires the non-standard behaviour, then it
   is only proper that whenever support is added to a USB-serial driver
   to recognize the custom USB ID in question, a quirk should be
   applied at the same time, setting the flag for the required
   non-standard operation.

Changes from v1 to v2:

* Fix the notation for authorship attribution, making it clear that
  Johan Hovold is the author of 3 out of 6 patches in this series.

* Revert sysfs atttribute name to Johan's original choice of nordy,
  pending community consensus on the choice of name.

* For the 3 patches that originate from Johan, revert all commit
  comments to his original wording.

Johan Hovold (3):
  tty: add port flag to suppress ready signalling on open
  serial: core: add sysfs attribute to suppress ready signalling on open
  USB: serial: add sysfs attribute to suppress ready signalling on open

Mychaela N. Falconia (3):
  serial: core: fully suppress raising DTR & RTS on open if nordy is set
  USB: serial: ftdi_sio: pass port to quirk port_probe functions
  USB: serial: ftdi_sio: add support for FreeCalypso DUART28C adapter

 Documentation/ABI/testing/sysfs-tty |  7 ++++++
 drivers/tty/serial/serial_core.c    | 28 ++++++++++++++++++++++-
 drivers/tty/tty_port.c              |  2 +-
 drivers/usb/serial/bus.c            | 35 +++++++++++++++++++++++++++--
 drivers/usb/serial/ftdi_sio.c       | 45 ++++++++++++++++++++++++++++++-------
 drivers/usb/serial/ftdi_sio_ids.h   |  1 +
 include/linux/tty_port.h            | 11 +++++++++
 7 files changed, 117 insertions(+), 12 deletions(-)

-- 
2.9.0

base-commit: 25e02ba60f0fbe65ba07553b5b2b8867726273c4
