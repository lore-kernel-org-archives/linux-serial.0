From: slack@slackware.ru
Subject: Re: problems with serial driver
Date: Tue, 3 Sep 2002 18:30:50 +0400 (MSD)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0209031820330.24809-100000@scil.sinp.msu.ru>
References: <010501c2535a$0fe62be0$294b82ce@connecttech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <010501c2535a$0fe62be0$294b82ce@connecttech.com>
List-Id: linux-serial@vger.kernel.org
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: alan@redhat.com, linux-serial@vger.kernel.org



On Tue, 3 Sep 2002, Stuart MacDonald wrote:

> From: <slack@slackware.ru>
> > 1. Starting receiver, sender: all is OK.
> > 2. Starting sender, receiver: sometimes OK, sometimes I've got damaged
> > data. Sometimes - IRQ overruns (losting NULL pointer etc). Kernel down.
> I'm not convinced this is a problem. The sender starts sending data
> right away, correct? Well, that data is discarded by the receiver port
> since it's not open for reading. The port knows it's not opened, and
> thus nobody is interested in the data coming in, so it drops it. This
> is correct behaviour.
It is clear. Not so clear, why it produces garbage when read from port, as
if it cannot sync with line.

> > Progs are very simple: send/receive (like in HOWTO). So,
> > operations are intensive. Installation of some
> > usleeps before read() from port solves the problem.
> > Kernels are up to 2.4.18 and on modern up to 2.5.17.
> Installation of usleep()s where? In the user space application? That
> shouldn't make a difference. Actually it should make it worse.
in the simple prog, that is doing read() from the port (intensive read).

for()
usleep();
read();
}
read OK.

for() {
// usleep()
read();
}
Garbage.

