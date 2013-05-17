From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH v2 1/5] tty: xuartps: Remove suspend/resume functions
Date: Fri, 17 May 2013 14:09:38 +0200
Message-ID: <51961E02.9020501@monstr.eu>
References: <1368467199-8702-1-git-send-email-soren.brinkmann@xilinx.com> <1368467199-8702-2-git-send-email-soren.brinkmann@xilinx.com>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2PCWAEBDEBAMGCOJONILT"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:33483 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754512Ab3EQMJs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 17 May 2013 08:09:48 -0400
Received: by mail-wi0-f180.google.com with SMTP id hn14so408747wib.13
        for <linux-serial@vger.kernel.org>; Fri, 17 May 2013 05:09:46 -0700 (PDT)
In-Reply-To: <1368467199-8702-2-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Soren Brinkmann <soren.brinkmann@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, Josh Cartwright <joshc@eso.teric.us>, Mike Turquette <mturquette@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, Stephen Warren <swarren@wwwdotorg.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2PCWAEBDEBAMGCOJONILT
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Greg,

can you please add this patch to your tree?
It is unrelated to clk changes which Soren sent.

Thanks,
Michal

On 05/13/2013 07:46 PM, Soren Brinkmann wrote:
> Currently Zynq does not support suspend/resume.
> The driver callbacks are never used or tested, broken and using the old=

> PM interface.
>=20
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.cz>
> Cc: linux-serial@vger.kernel.org
> ---
>  drivers/tty/serial/xilinx_uartps.c | 30 ------------------------------=

>  1 file changed, 30 deletions(-)
>=20
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xi=
linx_uartps.c
> index 4e5c778..b5f655d 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -1006,34 +1006,6 @@ static int xuartps_remove(struct platform_device=
 *pdev)
>  	return rc;
>  }
> =20
> -/**
> - * xuartps_suspend - suspend event
> - * @pdev: Pointer to the platform device structure
> - * @state: State of the device
> - *
> - * Returns 0
> - **/
> -static int xuartps_suspend(struct platform_device *pdev, pm_message_t =
state)
> -{
> -	/* Call the API provided in serial_core.c file which handles
> -	 * the suspend.
> -	 */
> -	uart_suspend_port(&xuartps_uart_driver, &xuartps_port[pdev->id]);
> -	return 0;
> -}
> -
> -/**
> - * xuartps_resume - Resume after a previous suspend
> - * @pdev: Pointer to the platform device structure
> - *
> - * Returns 0
> - **/
> -static int xuartps_resume(struct platform_device *pdev)
> -{
> -	uart_resume_port(&xuartps_uart_driver, &xuartps_port[pdev->id]);
> -	return 0;
> -}
> -
>  /* Match table for of_platform binding */
>  static struct of_device_id xuartps_of_match[] =3D {
>  	{ .compatible =3D "xlnx,xuartps", },
> @@ -1044,8 +1016,6 @@ MODULE_DEVICE_TABLE(of, xuartps_of_match);
>  static struct platform_driver xuartps_platform_driver =3D {
>  	.probe   =3D xuartps_probe,		/* Probe method */
>  	.remove  =3D xuartps_remove,		/* Detach method */
> -	.suspend =3D xuartps_suspend,		/* Suspend */
> -	.resume  =3D xuartps_resume,		/* Resume after a suspend */
>  	.driver  =3D {
>  		.owner =3D THIS_MODULE,
>  		.name =3D XUARTPS_NAME,		/* Driver name */
>=20


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



------enig2PCWAEBDEBAMGCOJONILT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGWHgIACgkQykllyylKDCF8DwCgm6sCltNDqIZorML3DDFvf7sS
hzkAnRfDYy2Lvon7tnPNDFhneKk9jO0W
=sjsH
-----END PGP SIGNATURE-----

------enig2PCWAEBDEBAMGCOJONILT--
