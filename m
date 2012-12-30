From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH V2 1/3] serial: rp2: New driver for Comtrol RocketPort 2
 cards
Date: Sun, 30 Dec 2012 12:59:59 +0100
Message-ID: <1356868799.4821.8.camel@deadeye.wl.decadent.org.uk>
References: <bd10fdeead3e321db2bb291c0b722203@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-GXd/kd0tnOAAFIbm61Hn"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43467 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754513Ab2L3MAQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 30 Dec 2012 07:00:16 -0500
In-Reply-To: <bd10fdeead3e321db2bb291c0b722203@localhost>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: alan@linux.intel.com, gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org, dwmw2@infradead.org


--=-GXd/kd0tnOAAFIbm61Hn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2012-12-29 at 23:23 -0800, Kevin Cernekee wrote:
[...]
> --- /dev/null
> +++ b/drivers/tty/serial/rp2.c
[...]
> +static struct uart_ops rp2_uart_ops =3D {

const?

[...]
> +static void rp2_fw_cb(const struct firmware *fw, void *context)
> +{
> +	struct rp2_card *card =3D context;
> +	resource_size_t phys_base;
> +	int i, rc =3D -ENOENT;
> +
> +	if (!fw) {
> +		dev_err(&card->pdev->dev, "cannot find '%s' firmware image\n",
> +			RP2_FW_NAME);
> +		goto no_fw;
> +	}
[...]
> +no_fw:
> +	complete(&card->fw_loaded);
> +
> +	/*
> +	 * rp2_fw_cb() is called from a workqueue long after rp2_probe()
> +	 * has already returned success.  So if something failed here, we
> +	 * need to manually yank the device.  This calls rp2_remove().
> +	 */
> +	if (rc)
> +		device_release_driver(&card->pdev->dev);
[...]

The driver can be unbound and then re-bound immediately after this
function calls complete().  This will then unbind it a second time!

Is it really necessary to unbind here?

Ben.

--=20
Ben Hutchings
It is easier to change the specification to fit the program than vice versa=
.

--=-GXd/kd0tnOAAFIbm61Hn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAUOAsv+e/yOyVhhEJAQox7Q//S8tqf1P3YdKUX0DzJeBwOSq3sEJqhobf
ZjpETs58YmqnQVxP11gzzz4068T1OKUrmgtWYwmFmJ/ERoisaPHNikoyk7CCIT1L
t7gSr8ixgj9FmC+5fR0u0IPqqgbLskhB7F1yGS++OVso6h2HsHbTdUOQcXXfC4T3
gq8qjgAJ9OmXcRfnWZorxfGbHRz55o9ATipGPQ7oI3eOQCGdLAd70OCydTC7kRM4
SuDaBRWx+sTGDiRVTwWzavDO1sYZfaT/ofzNmF3NaNBq9NO9kveUXEv25SIF1lac
iwxeu2erqaFBZiI+MrLwmC7JQny1SfB+gHPGkjYHcWlPFHZGUS+nRjTRW5ys98Fj
s6GlmsRnhsE1DV3i2JG1Zu7a5EEuhhNUdJD7Gte9Fwp2fkFAifagFwePfJtt9OLH
dGsMEwLNVbj1yYhG0dF8dGs1hA6tWsRG+UmYnxwgx9P5Mnj4D/xmPMmRV7NDDFn4
sdeZekWsUCIj7lcYaK1V9N+SOGxCf9fDGZovZVuxXe2skTiGtmy/Q7+ULYOtOvK4
StldJlKRuYF18SfzVtVA19CjS0DCAl+ymYVFId9b9a67pEyXWOEfaXXukr8HVPcV
qYmtBGemsmi+nRhiPtiE6hgeG7YxTuvlCw/huNO+Lzi/Xyv0d1m/nrgi8Tv0QniX
y+6IxXawAjU=
=Yt/c
-----END PGP SIGNATURE-----

--=-GXd/kd0tnOAAFIbm61Hn--
