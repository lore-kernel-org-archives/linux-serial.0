From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 4/5] drivers/tty: make serial/mpsc.c driver explicitly
 non-modular
Date: Fri, 9 Oct 2015 15:38:32 +0200
Message-ID: <20151009133832.GA19165@ulmo>
References: <1440020889-12120-1-git-send-email-paul.gortmaker@windriver.com>
 <1440020889-12120-5-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1440020889-12120-5-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2015 at 05:48:08PM -0400, Paul Gortmaker wrote:
> The Kconfig for this driver is currently:
>=20
> config SERIAL_MPSC
>         bool "Marvell MPSC serial port support"
>=20
> ...meaning that it currently is not being built as a module by anyone.
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
>=20
> Since module_init translates to device_initcall in the non-modular
> case, the init ordering remains unchanged with this commit.
>=20
> We leave some tags like MODULE_AUTHOR for documentation purposes.
>=20
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-serial@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  drivers/tty/serial/mpsc.c | 36 +++---------------------------------
>  1 file changed, 3 insertions(+), 33 deletions(-)
>=20
> diff --git a/drivers/tty/serial/mpsc.c b/drivers/tty/serial/mpsc.c
> index 82bb6d1fe23b..edb32e3f1e84 100644
> --- a/drivers/tty/serial/mpsc.c
> +++ b/drivers/tty/serial/mpsc.c
> @@ -55,8 +55,6 @@
>  #define SUPPORT_SYSRQ
>  #endif
> =20
> -#include <linux/module.h>
> -#include <linux/moduleparam.h>
>  #include <linux/tty.h>
>  #include <linux/tty_flip.h>
>  #include <linux/ioport.h>
> @@ -2108,24 +2106,8 @@ static int mpsc_drv_probe(struct platform_device *=
dev)
>  	return rc;
>  }
> =20
> -static int mpsc_drv_remove(struct platform_device *dev)
> -{
> -	pr_debug("mpsc_drv_exit: Removing MPSC %d\n", dev->id);
> -
> -	if (dev->id < MPSC_NUM_CTLRS) {
> -		uart_remove_one_port(&mpsc_reg, &mpsc_ports[dev->id].port);
> -		mpsc_release_port((struct uart_port *)
> -				&mpsc_ports[dev->id].port);
> -		mpsc_drv_unmap_regs(&mpsc_ports[dev->id]);
> -		return 0;
> -	} else {
> -		return -ENODEV;
> -	}
> -}
> -
>  static struct platform_driver mpsc_driver =3D {
>  	.probe	=3D mpsc_drv_probe,
> -	.remove	=3D mpsc_drv_remove,
>  	.driver	=3D {
>  		.name	=3D MPSC_CTLR_NAME,
>  	},

I don't think this is right. The driver can always be unbound from the
device via sysfs, in which case it will now leak resources and leave
behind a dangling UART port.

Thierry

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWF8NVAAoJEN0jrNd/PrOhPpoP/0tQoKRQFNpbWWSNvn6W2goq
MSXRXilRpU5tUXh+Kq1zT3d7rxvuOyGLB8ZNI2LWgeehTWstn1OA6nJ2XddUAJ2O
tG8CtFznDsiV620rhSGu+GMwpXPcb4IOND/WYbb9MxMt7ewdEHEyAuWoz2xozgjp
ZSdyTKo84yLpwDByFK9ALZ5QrHwXGcLaauM2X8tDBfNbLx4sOnKkNvyNBEvjlzbI
AZ7kKLaMmhiI36cKTuLVHsR/GLP3Qlj3rMb1A+x+L651zTkoJcLPvCMesByIE68+
kZkOtjGyCFQEfnElDrvW2Uz3v/QgQ+39rFhafhPom9Hk562AlD3fEYjO0iLNgCYG
csmEOFNhLTQ3tiT80F2Gu3X0As5CUIgr/eoxxfdjcdJdk2aT+oZx1F4oAjcnndXT
hdbBtr382gZ9N5XVmqJlKoPCBGN3ReN8UuRgfd1VqMfu7+gwerF6Ak2DM3/kE59y
4O0+e1R+hgyktS7BfYvI8gVipDMqHMW4N+CGVSBAbVQCTqty7sttUCEwlA+35iLz
qREAL/IkQ31Ncrxm/rUGtYJo4vBLNM+5WbcYHwqjTmhSuaZMABD45TpJKJ4QhDjf
lhzZUmyIDFsb0CJmIpSQeRZMvVLULDjSoF14hkUnzTTjQYpOWi2gNYQ/YBogWjCX
r9Z/ui0/RAD3Kh/YhNER
=I+tt
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
