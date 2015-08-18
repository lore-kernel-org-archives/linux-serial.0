From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] Revert "serial: imx: remove unbalanced clk_prepare"
Date: Tue, 18 Aug 2015 16:33:58 -0700
Message-ID: <20150818233356.GA4494@localhost.localdomain>
References: <1439912592-14779-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0609878349200000709=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1439912592-14779-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: kernel@pengutronix.de, gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--===============0609878349200000709==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2015 at 12:43:12PM -0300, Fabio Estevam wrote:
> This reverts commit 9e7b399d6528eac33a6fbfceb2b92af209c3454d.
>=20
> Commit ("9e7b399d6528ea") causes the following warning and sometimes
> also hangs the system:
>=20
> ------------[ cut here ]------------
>  WARNING: CPU: 0 PID: 0 at kernel/locking/mutex.c:868 mutex_trylock+0x20c=
/0x22c()
>  DEBUG_LOCKS_WARN_ON(in_interrupt())
>  Modules linked in:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.2.0-rc7-next-20150818-00001-g=
14418a6 #4
> Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> Backtrace:=20
> [<80012f08>] (dump_backtrace) from [<800130a4>] (show_stack+0x18/0x1c)
> r6:00000364 r5:00000000 r4:00000000 r3:00000000
> [<8001308c>] (show_stack) from [<807902b8>] (dump_stack+0x88/0xa4)
> [<80790230>] (dump_stack) from [<8002a604>] (warn_slowpath_common+0x80/0x=
bc)
> r5:807945c4 r4:80ab3b50
> [<8002a584>] (warn_slowpath_common) from [<8002a6e4>] (warn_slowpath_fmt+=
0x38/0x40)
> r8:00000000 r7:8131100c r6:8054c3cc r5:8131300c r4:80b0a570
> [<8002a6b0>] (warn_slowpath_fmt) from [<807945c4>] (mutex_trylock+0x20c/0=
x22c)
> r3:8095d0d8 r2:8095ab28
> [<807943b8>] (mutex_trylock) from [<8054c3cc>] (clk_prepare_lock+0x14/0xf=
4)
> r7:8131100c r6:be3f0c80 r5:00000037 r4:be3f0c80
> [<8054c3b8>] (clk_prepare_lock) from [<8054dbfc>] (clk_prepare+0x18/0x30)
> r5:00000037 r4:be3f0c80
> [<8054dbe4>] (clk_prepare) from [<8036a600>] (imx_console_write+0x30/0x24=
4)
> r4:812d0bc8 r3:8132b9a4
>=20
> To reproduce the problem we only need to let the board idle for something
> like 30 seconds.

hmmm.. I really did not see this one. Looking at the code looks like we
could be atomic in some of the uart console callbacks.

For this one:

Reviewed-by: Eduardo Valentin <edubezval@gmail.com>

Did you try the runtime pm patch on your end?

BR,

>=20
> Tested on a imx6q-sabresd.
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/tty/serial/imx.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index fe3d41c..d0388a0 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1631,12 +1631,12 @@ imx_console_write(struct console *co, const char =
*s, unsigned int count)
>  	int locked =3D 1;
>  	int retval;
> =20
> -	retval =3D clk_prepare_enable(sport->clk_per);
> +	retval =3D clk_enable(sport->clk_per);
>  	if (retval)
>  		return;
> -	retval =3D clk_prepare_enable(sport->clk_ipg);
> +	retval =3D clk_enable(sport->clk_ipg);
>  	if (retval) {
> -		clk_disable_unprepare(sport->clk_per);
> +		clk_disable(sport->clk_per);
>  		return;
>  	}
> =20
> @@ -1675,8 +1675,8 @@ imx_console_write(struct console *co, const char *s=
, unsigned int count)
>  	if (locked)
>  		spin_unlock_irqrestore(&sport->port.lock, flags);
> =20
> -	clk_disable_unprepare(sport->clk_ipg);
> -	clk_disable_unprepare(sport->clk_per);
> +	clk_disable(sport->clk_ipg);
> +	clk_disable(sport->clk_per);
>  }
> =20
>  /*
> @@ -1777,7 +1777,15 @@ imx_console_setup(struct console *co, char *option=
s)
> =20
>  	retval =3D uart_set_options(&sport->port, co, baud, parity, bits, flow);
> =20
> -	clk_disable_unprepare(sport->clk_ipg);
> +	clk_disable(sport->clk_ipg);
> +	if (retval) {
> +		clk_unprepare(sport->clk_ipg);
> +		goto error_console;
> +	}
> +
> +	retval =3D clk_prepare(sport->clk_per);
> +	if (retval)
> +		clk_disable_unprepare(sport->clk_ipg);
> =20
>  error_console:
>  	return retval;
> --=20
> 1.9.1
>=20

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJV08DeAAoJEMLUO4d9pOJW4s8IAJyVt775qzdfwRn4/nc8teX9
X3+jlRpJtEBo4URXLFBWJfHB3U4oz3oMsqovGkGGopR950X0TGBiGWZXl095FxAw
ql7kwRuCXQhJAiMRz5M4gOjT9XWAVpOYnYz9qsYnGvzGSfWA306UhO+qhwQUySg5
Dz4vPCqyueI7ngvWnX8xs7pZa7x5q55aOiE9z2DJmIFRAqD+E1gamO3US9og7Ud+
LKzX/LMZlUMxxwUNe8QteUuHYPPolvMl2JV584hJR+F+eSjAVW9iC++UWIJEuDtc
VPhPJP6s0uKp7JL0KFjP3pVqR2qVSQw5NHbYb5DaCymISAtM5787OqHgNHUQmxw=
=k068
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--


--===============0609878349200000709==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0609878349200000709==--
