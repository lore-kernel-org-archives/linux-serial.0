From: slack@slackware.ru
Subject: problems with serial driver
Date: Mon, 2 Sep 2002 13:55:22 +0400 (MSD)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0209021345330.21930-100000@scil.sinp.msu.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: alan@redhat.com
Cc: linux-serial@vger.kernel.org


Hi!
I've got some problems with serial communication.
So, connecting 2 serial ports via the cable (tested on several fast
computers with
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A)
No IRQ conflicts (pure computers without additional boards).
1. Starting receiver, sender: all is OK.
2. Starting sender, receiver: sometimes OK, sometimes I've got damaged
data. Sometimes - IRQ overruns (losting NULL pointer etc). Kernel down.

Progs are very simple: send/receive (like in HOWTO). So,
operations are intensive. Installation of some
usleeps before read() from port solves the problem.
Kernels are up to 2.4.18 and on modern up to 2.5.17.
(newer are not tested).

