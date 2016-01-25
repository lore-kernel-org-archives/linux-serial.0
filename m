From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH] serial: imx: fix dcd interrupt firing during probe
Date: Mon, 25 Jan 2016 09:50:33 -0800
Message-ID: <d2768fb8b08ac6ab71fc4e20582a0fd4@agner.ch>
References: <1451531565-1233-1-git-send-email-marcel.ziswiler@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1451531565-1233-1-git-send-email-marcel.ziswiler@toradex.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, =?UTF-8?Q?Petr_=C5=A0tetiar?= <ynezz@true.cz>, Lucas Stach <l.stach@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

Hi Marcel,

[also added Lucas]

On 2015-12-30 19:12, Marcel Ziswiler wrote:
> Continuing on the Apalis iMX6 mainlining work started by Petr =C5=A0t=
etiar I
> noticed that it only boots when rebooting from NXP's downstream 3.14.=
28
> kernel or mainline otherwise (e.g. when cold booted) I did not get an=
y
> serial debug output at all. Enabling earlyprintk I got the following:
>=20
> [    1.136806] INFO: trying to register non-static key.
> [    1.136871] 2020000.serial: ttymxc0 at MMIO 0x2020000 (irq =3D 25,
> base_baud =3D 5000000) is a IMX
> [    1.150651] the code is fine but needs lockdep annotation.
> [    1.150653] turning off the locking correctness validator.
> [    1.150664] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.4.0-rc6-
> next-20151223-00002-g6008f30-dirty #27
> [    1.150668] Hardware name: Freescale i.MX6 Quad/DualLite (Device
> Tree)
> [    1.150675] Backtrace:
> [    1.150701] [<c010c45c>] (dump_backtrace) from [<c010c654>]
> (show_stack+0x18/0x1c)
> [    1.150722]  r7:00000000 r6:c0d20848 r5:00000000 r4:00000000
> [    1.150739] [<c010c63c>] (show_stack) from [<c03dadcc>]
> (dump_stack+0x8c/0xa4)
> [    1.150760] [<c03dad40>] (dump_stack) from [<c016b60c>]
> (__lock_acquire+0x1d88/0x1eb4)
> [    1.150774]  r7:00000000 r6:c0d063f8 r5:c155f834 r4:e503bc20
> [    1.150785] [<c0169884>] (__lock_acquire) from [<c016bf54>]
> (lock_acquire+0x74/0x94)
> [    1.150803]  r10:c0d6eb5e r9:e597b300 r8:00000019 r7:00000001
> r6:00000001 r5:60000193
> [    1.150808]  r4:00000000
> [    1.150821] [<c016bee0>] (lock_acquire) from [<c08d49d4>]
> (_raw_spin_lock_irqsave+0x40/0x54)
> [    1.150834]  r7:000052c8 r6:c0481470 r5:40000193 r4:e503bc10
> [    1.150852] [<c08d4994>] (_raw_spin_lock_irqsave) from [<c0481470>=
]
> (imx_rxint+0x20/0x2a4)
> [    1.150862]  r6:00000000 r5:000052d0 r4:e503bc10
> [    1.150874] [<c0481450>] (imx_rxint) from [<c0482540>]
> (imx_int+0x170/0x1f4)
>=20
> Debugging a little further I noticed this actually happening after
> calling devm_request_irq() during serial_imx_probe() even before
> uart_add_one_port() did initialise the spin_lock acquired in
> imx_rxint(). Turns out the data carrier detect interrupt fired
> immediately upon requesting interrupts. This patch fixes this by
> explicitly disabling data carrier detect before requesting interrupts=
=2E

I actually hit a very similar issue on the Colibri iMX6 and hence looke=
d
into this too. In our downstream tree, I fixed it in imx_startup, which
is probably the wrong place actually...

>=20
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>=20
> ---
>=20
>  drivers/tty/serial/imx.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 9362f54c..b1588f9 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -2032,6 +2032,11 @@ static int serial_imx_probe(struct platform_de=
vice *pdev)
>  		 UCR1_TXMPTYEN | UCR1_RTSDEN);
>  	writel_relaxed(reg, sport->port.membase + UCR1);
> =20
> +	/* Disable data carrier detect before requesting interrupts */
> +	reg =3D readl_relaxed(sport->port.membase + UCR3);
> +	reg &=3D ~(UCR3_DCD);
> +	writel_relaxed(reg, sport->port.membase + UCR3);
> +

Note that UCR3_DCD has a different meaning in DCE mode. As a DCE, the
bit should be kept 1 (we assume that the carrier is detected by
default...)

The dte_mode bit should be initialized at that point, hence just making
that code conditional should account for that.

What I also noticed is that the RI signal suffers the very same issue.
We do not use the signal on our Colibri board, but we should disable
that interrupt too.
