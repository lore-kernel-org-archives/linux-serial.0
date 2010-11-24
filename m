From: kyle cronan <kyle@pbx.org>
Subject: how to debug dropped bytes?
Date: Wed, 24 Nov 2010 11:10:44 -0600
Message-ID: <AANLkTimwDEQdSodUT3b6kPTPZHrb9zcnMY9jG4FKaqjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:53388 "HELO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755691Ab0KXRLT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 24 Nov 2010 12:11:19 -0500
Received: by mail-bw0-f42.google.com with SMTP id 13so50306bwz.15
        for <linux-serial@vger.kernel.org>; Wed, 24 Nov 2010 09:10:49 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi all,

Can anyone suggest how to go about debugging an issue involving bytes
being dropped by the usbserial and serial8250 drivers?  I have an i686
architecture machine running 2.6.35 that needs to speak to two
different serial devices, one connected to the onboard 16550 and the
other connected via USB to an FTDI chip.  I am not using hardware flow
control.

Both devices drop bytes even at low bit rates (19200 on both ports).
They do so in a somewhat predictable manner.  On one of these ports
all my program has to do is read a 65-byte packet each second, and
what I see is that the packet almost always comes in at 64 bytes,
sometimes 63.  At first I suspected that a bug in my code was to
blame, but I can see the same behavior by just running 'cat
/dev/ttyUSB0 | hexdump -C'.  Packets come in a single byte short, and
then every 20 seconds or so I lose an additional byte.  It's similar
behavior for /dev/ttyS0, according to what I've seen in the logs
written out by my program.

The fact that two totally different drivers are involved makes me
think maybe there is some other device driver that has a very
long-running ISR?  Just a guess- I'm not too familiar with such
things.  I read about a program called irqtune, which I thought about
trying, but it looks like that is very old.  By the way, some of the
other device drivers in use on this system are: r8169, ath9k,
snd_hda_intel (loaded but not used) and udlfb (DisplayLink framebuffer
running xorg).  The chipset is an 82801GBM and CPU is Intel Atom
Diamondville.

Nothing of interest from the kernel log.  Oh, and, I don't know if
this means anything, but I also experienced dropped packets a few
months back, when I briefly decided to try switching from Ubuntu to
plain Debian.  The problem went away when I went back to Ubuntu.  Even
when I booted it up with the Debian kernel, which I thought was very
strange.  And now this problem is back.  Back then it was with
different hardware, although also Intel Atom.

Suggestions appreciated very much.
Thanks,
Kyle
