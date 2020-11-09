Return-Path: <SRS0=KjKo=EP=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5FBC2D0A3
	for <linux-serial@archiver.kernel.org>; Mon,  9 Nov 2020 07:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43845206CB
	for <linux-serial@archiver.kernel.org>; Mon,  9 Nov 2020 07:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgKIHix (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 Nov 2020 02:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgKIHix (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 Nov 2020 02:38:53 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C65C0613CF
        for <linux-serial@vger.kernel.org>; Sun,  8 Nov 2020 23:38:53 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kc1lH-0002lY-NQ; Mon, 09 Nov 2020 08:38:47 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kc1lG-0002kh-ND; Mon, 09 Nov 2020 08:38:46 +0100
Date:   Mon, 9 Nov 2020 08:38:44 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sam Nobs <samuel.nobs@taitradio.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-serial@vger.kernel.org, jun qian <hangdianqj@163.com>,
        Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] tty: serial: imx: fix potential deadlock
Message-ID: <20201109073844.5atunb5xr7elq55x@pengutronix.de>
References: <1604858095-12477-1-git-send-email-samuel.nobs@taitradio.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dmhwlv3br5s4zali"
Content-Disposition: inline
In-Reply-To: <1604858095-12477-1-git-send-email-samuel.nobs@taitradio.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--dmhwlv3br5s4zali
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2020 at 06:54:55AM +1300, Sam Nobs wrote:
> Enabling the lock dependency validator has revealed
> that the way spinlocks are used in the IMX serial
> port could result in a deadlock. Note that the configuration
> I'm using has the IRQs forced to run in threads via
> the kernel parameter threadirqs.
>=20
> Specifically, imx_uart_int() acquires a spinlock
> without disabling the interrupts, meaning that another
> interrupt could come along and try to acquire the same
> spinlock, potentially causing the two to wait for each
> other indefinitely.

That's because the console functions might be called with irqs off and
so in these functions the _irqsave variants are used for locking.

(In general not using spin_lock_irqsave but plain spin_lock in an irq
handler is fine iff there are no other functions taking the lock that
might run with irqs off.)

> Use spin_lock_irqsave() instead to disable interrupts
> upon acquisition of the spinlock.
>=20
> Signed-off-by: Sam Nobs <samuel.nobs@taitradio.com>
> ---
> Here's the lockdep splat for reference:
>=20
>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    WARNING: inconsistent lock state
>    5.4.46 #1 Not tainted
>    --------------------------------
>    inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
>    irq/26-30860000/992 [HC0[0]:SC0[2]:HE1:SE0] takes:
>    ffff00006671d098 (&port_lock_key){?...}, at: imx_uart_int+0x28/0x338
>    {IN-HARDIRQ-W} state was registered at:
>      lock_acquire+0xd0/0x288
>      _raw_spin_lock_irqsave+0x58/0x80
>      imx_uart_console_write+0x1e4/0x220
>      console_unlock+0x2ac/0x610
>      vprintk_emit+0x178/0x330
>      vprintk_default+0x48/0x58
>      vprintk_func+0xe4/0x248
>      printk+0x70/0x90
>      crng_fast_load+0x1c4/0x1c8
>      add_interrupt_randomness+0x348/0x3e8
>      handle_irq_event_percpu+0x50/0x98
>      handle_irq_event+0x4c/0xd0
>      handle_fasteoi_irq+0xe0/0x188
>      generic_handle_irq+0x34/0x50
>      __handle_domain_irq+0x98/0x108
>      gic_handle_irq+0xd4/0x178
>      el1_irq+0xbc/0x180
>      arch_cpu_idle+0x34/0x220
>      default_idle_call+0x40/0x4c
>      do_idle+0x254/0x268
>      cpu_startup_entry+0x28/0x48
>      rest_init+0x1b4/0x284
>      arch_call_rest_init+0x14/0x1c
>      start_kernel+0x48c/0x4bc
>    irq event stamp: 30
>    hardirqs last  enabled at (29): [<ffff800010b22a60>] _raw_spin_unlock_=
irq+0x38/0x70
>    hardirqs last disabled at (28): [<ffff800010b1b060>] __schedule+0xb0/0=
x770
>    softirqs last  enabled at (0): [<ffff8000100b28c0>] copy_process+0x8d8=
/0x19b0
>    softirqs last disabled at (30): [<ffff8000101343f8>] irq_forced_thread=
_fn+0x0/0xc0
>=20
>    other info that might help us debug this:
>     Possible unsafe locking scenario:
>=20
>           CPU0
>           ----
>      lock(&port_lock_key);
>      <Interrupt>
>        lock(&port_lock_key);
>=20
>     *** DEADLOCK ***
>=20
>    no locks held by irq/26-30860000/992.
>=20
>    stack backtrace:
>    CPU: 0 PID: 992 Comm: irq/26-30860000 Not tainted 5.4.46 #1
>    Hardware name: Tait i.MX8MM smarc-rcb (DT)
>    Call trace:
>     dump_backtrace+0x0/0x178
>     show_stack+0x24/0x30
>     dump_stack+0xdc/0x144
>     print_usage_bug+0x1c8/0x1e0
>     mark_lock+0x57c/0x740
>     __lock_acquire+0x684/0x16d0
>     lock_acquire+0xd0/0x288
>     _raw_spin_lock+0x44/0x58
>     imx_uart_int+0x28/0x338
>     irq_forced_thread_fn+0x40/0xc0
>     irq_thread+0x1ac/0x280
>     kthread+0x138/0x140
>     ret_from_fork+0x10/0x18
>=20
>  drivers/tty/serial/imx.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 1731d97..29ceaea 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -942,8 +942,9 @@ static irqreturn_t imx_uart_int(int irq, void *dev_id)
>  	struct imx_port *sport =3D dev_id;
>  	unsigned int usr1, usr2, ucr1, ucr2, ucr3, ucr4;
>  	irqreturn_t ret =3D IRQ_NONE;
> +	unsigned long flags =3D 0;
> =20
> -	spin_lock(&sport->port.lock);
> +	spin_lock_irqsave(&sport->port.lock, flags);

There was an earlier commit (c974991d2620419fe21508fc4529014369d16df7)
that changed spin_lock_irqsave to spin_lock under the assumption that in
the irq handler irqs are disabled. I added the author and the reviewer
of this patch to Cc.

To prevent the next person to think this can be converted to spin_lock
I'd like to have a comment here that tells about why we need the irqsave
variant.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--dmhwlv3br5s4zali
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+o8gEACgkQwfwUeK3K
7AmjQAf+P37dFbbkz3/T2uJYzMm8RnIgDY32my5ExaETDcEmPE67p5k9K8jVYv7n
hFSen9uqIltQVfSRczAMpifx3XOKiIYt6y/3lryBxTvrUGGCjiAs10GFDDUCNHbP
2QetELuqI6ROaxMGdxMLtGUs2vZ4BAWYgofxp13RD96/k/sluie/azsYUu3CgiGA
NKNZZnAjMH6u6driTSvkBgjXRH4iYdooNspUYd3X7W6U0bZoZdCYWHrjUW79ocwM
fefjljzXaUAXG7qXSXauYAea0xXdYm689PKBQCnQ81RC+r4OIgJbS0yCpfPVtYrX
29ztDL2MTz/0qrDZaIQSHenOG0i2wg==
=siug
-----END PGP SIGNATURE-----

--dmhwlv3br5s4zali--
