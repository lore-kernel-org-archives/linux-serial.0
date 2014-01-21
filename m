From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH] serial: samsung: move clock deactivation below uart registration
Date: Tue, 21 Jan 2014 15:26:42 +0100
Message-ID: <2813762.7GxfVBIcrq@phil>
References: <201312050054.39327.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:49439 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754606AbaAUOz2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 21 Jan 2014 09:55:28 -0500
In-Reply-To: <201312050054.39327.heiko@sntech.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Chander Kashyap <chander.kashyap@linaro.org>

Hi Greg,

just wanted to ask about the state of this patch. I can see it in your =
branch=20
named "fixes" [0] but it seems it hasn't made its way into the kernel n=
either=20
during the 3.13-rcs or with your 3.14-pull [1].


Thanks
Heiko


[0] https://git.kernel.org/cgit/linux/kernel/git/gregkh/tty.git/log/?h=3D=
fixes
[1]=20
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/=
?id=3Dbcee63488ece9a0fca8be19951428a7b41001e66


Am Donnerstag, 5. Dezember 2013, 00:54:38 schrieb Heiko St=FCbner:
> Commit 60e93575476f (serial: samsung: enable clock before clearing pe=
nding
> interrupts during init) added handling of the controller clock during=
 init.
>=20
> On most systems this clock is also one of the baud_clock sources and
> possibly used by the earlycon and thus already enabled by the bootloa=
der.
>=20
> Therefore a gap exists between s3c24xx_serial_init_port disabling the
> clock and an attached console reenabling it, making the transition fr=
om
> earlycon to regular console possibly hang the system - as seen on my
> S3C2442 based Freerunner today.
>=20
> Therefore move the disabling of the clock from s3c24xx_serial_init_po=
rt
> below the uart port registration, effectively creating an overlap and
> keeping the clock running non-stop if the console wants to grab this =
port.
>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/tty/serial/samsung.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsun=
g.c
> index c1af04d..9cd706d 100644
> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -1209,7 +1209,6 @@ static int s3c24xx_serial_init_port(struct
> s3c24xx_uart_port *ourport,
>=20
>  	/* reset the fifos (and setup the uart) */
>  	s3c24xx_serial_resetport(port, cfg);
> -	clk_disable_unprepare(ourport->clk);
>  	return 0;
>  }
>=20
> @@ -1287,6 +1286,13 @@ static int s3c24xx_serial_probe(struct
> platform_device *pdev) uart_add_one_port(&s3c24xx_uart_drv,
> &ourport->port);
>  	platform_set_drvdata(pdev, &ourport->port);
>=20
> +	/*
> +	 * Deactivate the clock enabled in s3c24xx_serial_init_port here,
> +	 * so that a potential re-enablement through the pm-callback overla=
ps
> +	 * and keeps the clock enabled in this case.
> +	 */
> +	clk_disable_unprepare(ourport->clk);
> +
>  #ifdef CONFIG_SAMSUNG_CLOCK
>  	ret =3D device_create_file(&pdev->dev, &dev_attr_clock_source);
>  	if (ret < 0)

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
