From: "Stuart MacDonald" <stuartm@connecttech.com>
Subject: Re: problems with serial driver
Date: Tue, 3 Sep 2002 10:56:17 -0400
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <010501c2535a$0fe62be0$294b82ce@connecttech.com>
References: <Pine.LNX.4.44.0209021345330.21930-100000@scil.sinp.msu.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: slack@slackware.ru, alan@redhat.com
Cc: linux-serial@vger.kernel.org

From: <slack@slackware.ru>
> 1. Starting receiver, sender: all is OK.
> 2. Starting sender, receiver: sometimes OK, sometimes I've got damaged
> data. Sometimes - IRQ overruns (losting NULL pointer etc). Kernel down.

I'm not convinced this is a problem. The sender starts sending data
right away, correct? Well, that data is discarded by the receiver port
since it's not open for reading. The port knows it's not opened, and
thus nobody is interested in the data coming in, so it drops it. This
is correct behaviour.

> Progs are very simple: send/receive (like in HOWTO). So,
> operations are intensive. Installation of some
> usleeps before read() from port solves the problem.
> Kernels are up to 2.4.18 and on modern up to 2.5.17.

Installation of usleep()s where? In the user space application? That
shouldn't make a difference. Actually it should make it worse.

..Stu


