From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/4] tty/serial: at91: prevent null dereference in
 tasklet function
Date: Tue, 7 Jan 2014 19:44:53 -0800
Message-ID: <20140108034453.GA8664@kroah.com>
References: <cover.1389090437.git.nicolas.ferre@atmel.com>
 <69b33ebdc9427b5c036b4ba09151ae88c14a30f4.1389090437.git.nicolas.ferre@atmel.com>
 <20140108011137.GA13590@kroah.com>
 <CAJjB1qLDd6JFb4LwD5iokg5=O8Bwp5MkKsrr45QDodZkZrx75g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJjB1qLDd6JFb4LwD5iokg5=O8Bwp5MkKsrr45QDodZkZrx75g@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Mark Roszko <mark.roszko@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Leilei Zhao <leilei.zhao@atmel.com>, mdeneen@gmail.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Tue, Jan 07, 2014 at 08:52:34PM -0500, Mark Roszko wrote:
> This patch I was somewhat hesitant to pushing to Atmel when I did the=
 other two
> patches.

Then why did you?  :)

> The main issue is the use of systemd causes the serial driver to some=
how get
> out of sync on startups randomly. i.e. on one bootup it's fine, and o=
n other
> it'll kernel panic.=A0
> It occurs because systemd causes the startup and shutdown driver ops =
to be
> fired in rapid succession.=A0

How does systemd cause this?  Is this when the serial port is being use=
d
as a console or something else?

> Every single service start message causes the _startup callback first=
, then the
> message prints and _shutdown callbacks fires.=A0

So something is opening and closing the port quickly?  That should be
easy to test without systemd.

Any console involved?

> And a kernel panic always occurs somewhere during the service status =
output,
> never before when it's just the kernel startup and never after once s=
ystemd
> finishes and getty for example takes over.=A0
>=20
> The stacktrace looked like this:
> Unable to handle kernel NULL pointer dereference at virtual address 0=
0000088
> pgd =3D c0004000
> [00000088] *pgd=3D00000000
> Internal error: Oops: 17 [#1] ARM
> Modules linked in: autofs4
> CPU: 0 =A0 =A0Not tainted =A0(3.6.9-yocto-standard #1)

3.6.9 is _very_ old, loads of things have happened in the tty layer
since then, can you duplicate this on 3.12 or 3.13-rc?


> PC is at tty_wakeup+0x8/0x58
> LR is at atmel_tasklet_func+0x238/0x80c
> pc : [<c01efd84>] =A0 =A0lr : [<c0208fc0>] =A0 =A0psr: a00f0013
> sp : df84ff28 =A0ip : 00000000 =A0fp : 00000100
> r10: c05d1ec0 =A0r9 : 04208040 =A0r8 : c05d1e80
> r7 : 0000000a =A0r6 : 00000000 =A0r5 : dedf7c00 =A0r4 : 00000000
> r3 : dedf7c00 =A0r2 : 00000000 =A0r1 : 600f0013 =A0r0 : 00000000
> Flags: NzCv =A0IRQs on =A0FIQs on =A0Mode SVC_32 =A0ISA ARM =A0Segmen=
t kernel
> Control: 10c53c7d =A0Table: 3fb0c059 =A0DAC: 00000015
> Process ksoftirqd/0 (pid: 3, stack limit =3D 0xdf84e2f0)
> Stack: (0xdf84ff28 to 0xdf850000)
> ff20: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 c05e4378 dedf7c00 00000000 =
c0208fc0 c05aa458 df8496b0
> ff40: df849680 c05aa458 df8496b0 c00394a8 c0039420 c05a8d04 00000000 =
00000000
> ff60: 0000000a c05d1e80 04208040 c05d1ec0 00000100 c001fd34 00000009 =
00000018
> ff80: df84e000 c001f60c df84ffbc c03f8e60 00000013 00000006 00000000 =
c05d1e80
> ffa0: df84e000 00000000 00000013 00000000 00000000 00000000 00000000 =
c001f728
> ffc0: df84bf3c 00000000 c001f6c0 c0030870 00000000 00000000 00000000 =
00000000
> ffe0: df84ffe0 df84ffe0 df84bf3c c00307f0 c000e348 c000e348 fff73fbf =
3fbeffff
> [<c01efd84>] (tty_wakeup+0x8/0x58) from [<c0208fc0>] (atmel_tasklet_f=
unc+0x238/
> 0x80c)
> [<c0208fc0>] (atmel_tasklet_func+0x238/0x80c) from [<c001fd34>]
> (tasklet_action+0x70/0xa8)
> [<c001fd34>] (tasklet_action+0x70/0xa8) from [<c001f60c>] (__do_softi=
rq+0x90/
> 0x144)
> [<c001f60c>] (__do_softirq+0x90/0x144) from [<c001f728>] (run_ksoftir=
qd+0x68/
> 0x104)
> [<c001f728>] (run_ksoftirqd+0x68/0x104) from [<c0030870>] (kthread+0x=
80/0x90)
> [<c0030870>] (kthread+0x80/0x90) from [<c000e348>] (kernel_thread_exi=
t+0x0/0x8)
> Code: e8bd8070 c05ac0b8 e92d4070 e1a04000 (e5903088)
> ---[ end trace 15b8a9aeaf7b457f ]---
>=20
>=20
> Testing wise I originally used a BUG_ON statement in atmel_tasklet_fu=
nc to
> panic before the null deference hit. BUG_ON confirmed that tty was NU=
LL at the
> very start of the tasklet being called.=A0

And did you test that this patch actually fixed it?

> The atmel_shutdown function should be killing the tasklet (after patc=
h "Handle
> shutdown more safely") and does disable interrupts so I've been at a =
loss at
> where the race condition was occurring that a tasklet could escape be=
yond
> shutdown.

Are you sure you aren't just racing with shutdown?  Need a lock
somewhere?

greg k-h
