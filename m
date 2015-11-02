From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH -next] serial: etraxfs-uart: Fix crash
Date: Mon, 2 Nov 2015 16:39:50 +0100
Message-ID: <20151102153950.GX4931@pengutronix.de>
References: <1446431576-4385-1-git-send-email-linux@roeck-us.net>
 <20151102073755.GN4931@pengutronix.de>
 <56377350.7040005@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56377350.7040005@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Niklas Cassel <nks@flawful.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Nov 02, 2015 at 06:29:36AM -0800, Guenter Roeck wrote:
> On 11/01/2015 11:37 PM, Uwe Kleine-K=F6nig wrote:
> >Hello,
> >
> >On Sun, Nov 01, 2015 at 06:32:56PM -0800, Guenter Roeck wrote:
> >>Since commit 7d8c70d8048c ("serial: mctrl-gpio: rename init functio=
n"),
> >>crisv32 either do not build or crash as follows.
> >>
> >>Unable to handle kernel NULL pointer dereference
> >>Linux 4.3.0-rc7-next-20151101 #1 Sun Nov 1 11:41:28 PST 2015
> >>...
> >>Call Trace: [<c0004a0e>] show_stack+0x0/0x9e
> >>[<c004c0c0>] printk+0x0/0x2c
> >>[<c00059d4>] show_registers+0x14a/0x1c2
> >>[<c004c0c0>] printk+0x0/0x2c
> >>[<c0004b52>] die_if_kernel+0x7c/0x9e
> >>[<c0005346>] do_page_fault+0x32e/0x3e6
> >>[<c01dc59c>] of_get_property+0x0/0x2c
> >>[<c01e0558>] of_irq_parse_raw+0x12a/0x376
> >>[<c01dc59c>] of_get_property+0x0/0x2c
> >>[<c0053aca>] get_page_from_freelist+0x73e/0x856
> >>[<c01dc59c>] of_get_property+0x0/0x2c
> >>[<c0008912>] d_mmu_refill+0x10a/0x112
> >>[<c01b488c>] devm_kmalloc+0x40/0x56
> >>[<c01b47d0>] add_dr+0xc/0x1c
> >>[<c01b4800>] devm_add_action+0x2/0x4e
> >>[<c01abdbc>] mctrl_gpio_init_noauto+0x1c/0x76
> >>[<c01abf9e>] mctrl_gpio_init+0x22/0x110
> >
> >There should be a warning at compile time about mismatching paramete=
rs.
> >
> >>The function call in the etraxfs-uart driver was not renamed,
> >>possibly due to interference with commit 7b9c5162c182 ("serial:
> >>etraxfs-uart: use mctrl_gpio helpers for handling modem signals").
> >
> >Yes. BTW, 7b9c5162c182 looks broken, too, because the interrupt hand=
ling
> >is missing.
> >
>=20
> I can not comment on that; all I can say is that it works for me with=
 qemu.
What does "works for me" mean? You get output on the qemu console? Fine=
,
but that also works if you don't do any handshaking at all I guess.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
