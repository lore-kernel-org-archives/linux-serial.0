Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792847023;
	b=VXVPn9GG3FqStCdaXC6fO+YuGVZRDw65jXOBN6a5EZ3sAfLmWcSnDpTG3DEGHQWOWlUL
	 XinlExU8Wdb5vx70mzqlDSJH6y6CSAq4uRNE6LlNR6ywzrog0Q5BQJN6sOcotF7viBLMz
	 vfrovai4pSybfhwtFjPe8gN6YtBafAiyifOONOgYzX2FRK7YolbAycXH6MdLcXT8Bop/k
	 RSdUIiWmfouQFUkcJmkGviF0CXOCxWamUICyktn3Ru57na/rS8eNYAARECQ9qLYR7YFHH
	 bxoUBdO4xT9KTE3zjZWI839gIlQYflSckH8b0UW5+U4lMPycA33u/ZB4R3ejvYR8WmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792847023;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP;
	bh=wV+mwirPcuzcvcwXaHVyYF02GmspO+0jpiSa+0m0aKM=;
	b=pQyzqlzGidiDYy+YiyIh7uhXZ/capaVLqtMn4oTpYPDZjUO0y7iN+VfiOVR7RQJ9VD3t
	 wmk0XgPhUgSxWILeDVj+1DpYJR8C0/sDbMZKpeyVYdJuLLJTvMg3J0Rs1X95sgpe2LcU4
	 UfR3SrKAVdaGn/c0zRuQgz3saQ90I3s4JONlYyYX51A1gxS9TncP5UwicemcIdY6w+PlJ
	 BsKQTl+7SBugmvjCgvK9SoP2/+k27sFG7vzi7LPxr5SCDbmNXx8jamUnMnvyDX5brO6Gd
	 PfblK6LP9tXiGDsJtM7qdFjvfFO9UGF4DDfTMxEdMRCAIIy0CdUj+fpvo+/A2D3h3hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=faJrWtcu;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFE7606A31D
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 13:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AFE7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=faJrWtcu
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 711A8240108
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 15:03:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1792847019;
	bh=wV+mwirPcuzcvcwXaHVyYF02GmspO+0jpiSa+0m0aKM=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=faJrWtcuftWi+ec5abTHS/c386XVWssy9hQa+9RDuS4Bpy2U/r+kVRLLb6gyQR97g
	 BYkBpcwlQuGj4BrWU3ok/1VyawwfJVci/7+wG/GFnghxMWu02ETWHaeJAR1ZXJW6dY
	 LvTElllgeK9GiSWI37q/r8nt3Igz94shJCdBklt+on9rgvab8GN8h/SdJC8azJAttT
	 EJx8YoPiyqCW1vG42C10WGFlMqAXDgOTGdUeDGd56KT3oppq7hJVtyuFRicXu0R1Kk
	 faYIyay6tZThJhjgXyAZVuv82bivYOiDWoiA+BcZO8F4nVimaD5gGsk2QswflRdJhY
	 aIajKEqi8N+5w==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jBg7F6X5Cz9rxS;
	Sat, 24 Oct 2026 15:03:37 +0200 (CEST)
Message-ID: <12665f80375091ced5d7586f4d63c91f5b07bf2a.camel@posteo.de>
Subject: Re: [PATCH v5 2/3] platform/x86: dell-uart-backlight: Bind through
 normal serdev matching
From: Markus Probst <markus.probst@posteo.de>
To: ChunAn Wu <an.wu@canonical.com>, linux-serial@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, hansg@kernel.org, ilpo.jarvinen@linux.intel.com, 
	mpearson-lenovo@squebb.ca, derekjohn.clark@gmail.com
Date: Sat, 24 Oct 2026 13:03:38 +0000
In-Reply-To: <4ac249174a529766e8fd69c39fc08dfa1572a650.1792831564.git.an.wu@canonical.com>
References: <cover.1792831564.git.an.wu@canonical.com>
	 <4ac249174a529766e8fd69c39fc08dfa1572a650.1792831564.git.an.wu@canonical.com>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-Z+RMlSZaBmgBKhLiJ1gT"
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-Z+RMlSZaBmgBKhLiJ1gT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-10-24 at 20:04 +0800, ChunAn Wu wrote:
> The driver creates a serdev client without firmware metadata and
> force-attaches its driver to it.
>=20
> Pass the modalias to serdev_device_add() and give the serdev driver a
> matching id_table, so that the serdev core binds the two through normal
> matching, then drop the manual attachment.
>=20
> The client now also reports a "serial:dell_uart_backlight" modalias to
> userspace instead of failing with -ENODEV. A failing serdev probe no
> longer propagates out of the platform probe; as for any other bus, the
> client is simply left unbound.
>=20
> Signed-off-by: ChunAn Wu <an.wu@canonical.com>
> ---
>  .../platform/x86/dell/dell-uart-backlight.c    | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/platform/x86/dell/dell-uart-backlight.c b/drivers/pl=
atform/x86/dell/dell-uart-backlight.c
> index f323a667dc2d..9b8ef91bb0a2 100644
> --- a/drivers/platform/x86/dell/dell-uart-backlight.c
> +++ b/drivers/platform/x86/dell/dell-uart-backlight.c
> @@ -325,11 +325,17 @@ static int dell_uart_bl_serdev_probe(struct serdev_=
device *serdev)
>  	return PTR_ERR_OR_ZERO(dell_bl->bl);
>  }
> =20
> +static const struct serdev_device_id dell_uart_bl_serdev_id[] =3D {
> +	{ KBUILD_MODNAME },
> +	{ }
> +};
> +
>  static struct serdev_device_driver dell_uart_bl_serdev_driver =3D {
>  	.probe =3D dell_uart_bl_serdev_probe,
>  	.driver =3D {
>  		.name =3D KBUILD_MODNAME,
>  	},
> +	.id_table =3D dell_uart_bl_serdev_id,
>  };
> =20
>  static int dell_uart_bl_pdev_probe(struct platform_device *pdev)
> @@ -354,7 +360,7 @@ static int dell_uart_bl_pdev_probe(struct platform_de=
vice *pdev)
>  	if (!serdev)
>  		return -ENOMEM;
> =20
> -	ret =3D serdev_device_add(serdev);
> +	ret =3D serdev_device_add(serdev, KBUILD_MODNAME);
>  	if (ret) {
>  		dev_err(&pdev->dev, "error %d adding serdev\n", ret);
>  		serdev_device_put(serdev);
> @@ -365,20 +371,10 @@ static int dell_uart_bl_pdev_probe(struct platform_=
device *pdev)
>  	if (ret)
>  		goto err_remove_serdev;
> =20
> -	/*
> -	 * serdev device <-> driver matching relies on OF or ACPI matches and
> -	 * neither is available here, manually bind the driver.
> -	 */
> -	ret =3D device_driver_attach(&dell_uart_bl_serdev_driver.driver, &serde=
v->dev);
> -	if (ret)
> -		goto err_unregister_serdev_driver;
> -
>  	/* So that dell_uart_bl_pdev_remove() can remove the serdev */
>  	platform_set_drvdata(pdev, serdev);
>  	return 0;
> =20
> -err_unregister_serdev_driver:
> -	serdev_device_driver_unregister(&dell_uart_bl_serdev_driver);
>  err_remove_serdev:
>  	serdev_device_remove(serdev);
>  	return ret;

Reviewed-by: Markus Probst <markus.probst@posteo.de>

Thanks
- Markus Probst

--=-Z+RMlSZaBmgBKhLiJ1gT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmrcrKkbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSsBYQAJoLYH06WoE+InUgXPCk
8lG1jm+bANEsbuwJraT7Alwwk2qJVUd6JB18OqKWk3jECEwqHTWSHLz9csGqaRzz
VNzBmO2+QqNf1O8C9SFMihhj3juJu/U0GLk0IwPeXIK3Yp3VeRrpjBAISbBGJGcb
06L9WqmKeJ4iZmO8Hulg6CWeI6oSryY0ad6XTKXhXWC3kEmF1tdjrsJqkXTtHdNF
Qgl7GA05ZTRYbkqm7AnBAvOJ0fYdNsm79JR7G0YzkL9IMvXWR3zv/9KAC1Lfj81h
2Vw/I11U3BvgnvIv4rCnQY9dmNXVr0DVRLx7XajBDTfHZkb5Xk8jOeovUmEXd1K7
kz493BPxo0X5YyvIKqnAGiC/5QiCIiDUlChztoHYHuqDkJ+MToCEYSr4RkL/V8Ea
Yu0+uG8DB1NlF5gSOlHAxDs8Rd3DpA+KPOG3/RtXZYfdud1tzoAb9ZRvZ+/ACV+2
YiJLqVYNyotFPdzqundWnCyinb1Lx+RvRt0sZ3tCIYBF0LJN6DooB4bsz/01kh+K
XsuXBNiGM0auD+D+tnCuM2v3VX0/aivaCeLtP2qAZqFdy6v1XO514GstzWL1ioqD
x9wnkHINrQFPIVb+8m9HvjAM+ykQPbkeVHAbMIfh2xh2Ps904X9W2u2R02ZL7osU
tna6I5TA1RefSlnRXz/PD1mT
=nWDx
-----END PGP SIGNATURE-----

--=-Z+RMlSZaBmgBKhLiJ1gT--
