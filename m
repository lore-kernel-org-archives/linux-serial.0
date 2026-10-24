Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792847519;
	b=04nkEvfLq4MyNxlHAxUfVg2HtZmf7W1KcXfwnCnpbLApfvwGWnSXLPaED0s3vajwfNoN
	 2/SzGX+JbvG22O8MwFBxHoK1cpmfREwU/iSarKU1B59WrPvuBMouJuJ3SiMYGw08MCYZa
	 ro29kqyqrc3w2Jaznrdyd4pVPtUTbObGb1pvLBMHTmuF4PhIWNwP8ipHWQb38zK7DIdo2
	 wNPcTfw+7kZHiyY88wzeMrmxT0hMf3sddwQhT2rT7ubyiNZ/9vy15fvEzZKsjhCPXpVM4
	 pQOC7R0T8Y7x7Dk0ppdlxq6pwD/hjAv4gNo7hSeC3pbGfO/3pGQ2tgS058Bk0BHhw5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792847519;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP;
	bh=Iv3dSry8ogl8b6c7rH4YrBtBHXy5H/q98FiU+OoQmhY=;
	b=38oczmhkOYldxpXTxXKqkMby+++kLxcqY7xRv3p/fZldU3nD8Yal8xPOBuc5XvaZzHck
	 d05wnomHdVzgO86u2noV6JFNI+xYsACx01GLTtCxlCb7MqcwpG8KpMVfRfcgWlLaaf+Uq
	 Lss4sIqob/jw/Z5mTAPmK/dk7GwpvcXJazqbwn4L3eYx5qXtiFCAGeQxz5sIIiBsvO4Bw
	 1+HfldDgSfSdP8FENdx+gnpy0uPGTnzfPkARXjSHQHtcc1qutqEqgXFqxZYwNQcrJvez0
	 jxDx4vUSdfvGjJfWGGX7DAP70BFB91JRAtJP9PJ4wE5AKFbuN9eGRtSKBNZr8UoN76Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=FUsVZk+2;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58EC606A31E
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 13:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A58EC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=FUsVZk+2
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id E7E53240109
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 15:11:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1792847516;
	bh=Iv3dSry8ogl8b6c7rH4YrBtBHXy5H/q98FiU+OoQmhY=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=FUsVZk+2uFc5gnxYgfTk8xPLsVV0MbrvuFRu7PB/2o86jX4dq9+BR8UqAvIJwDBIe
	 tmIW+nEWl1HiUxbE5ztWrB/Uy/+Tx8mzi9G5XiNtbzkxcJk2JqDkqUbn4vmw5gt1a5
	 36QtUid1Rs6xv3gqp/CNVDmR3VygoM7SJ4RnFqK5KXK+uNg2G9Etst/yhnyeFnnOTT
	 KrxcnrOGN4eE5CUQazqw+FyUDM0xAoXrQqT5vZXycmlg9B/0aES84Iju7V+2bdygzH
	 wOOwW8w8p1eVvyL/U0403v2o7t5JptVZlDODmQcIyLoC1pPGvr6uGkR5oiYLE6PTd5
	 4xwY4mkWn+qyw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jBgJr07Rwz9rxN;
	Sat, 24 Oct 2026 15:11:55 +0200 (CEST)
Message-ID: <3cb4f43b2fc95c348f0646edce338064ec7add69.camel@posteo.de>
Subject: Re: [PATCH v5 3/3] platform/x86:
 lenovo-yoga-tab2-pro-1380-fastcharger: Bind through normal serdev matching
From: Markus Probst <markus.probst@posteo.de>
To: ChunAn Wu <an.wu@canonical.com>, linux-serial@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, hansg@kernel.org, ilpo.jarvinen@linux.intel.com, 
	mpearson-lenovo@squebb.ca, derekjohn.clark@gmail.com
Date: Sat, 24 Oct 2026 13:11:56 +0000
In-Reply-To: <5e70a181599ada304c6aa6589cc61662f1a8d710.1792831564.git.an.wu@canonical.com>
References: <cover.1792831564.git.an.wu@canonical.com>
	 <5e70a181599ada304c6aa6589cc61662f1a8d710.1792831564.git.an.wu@canonical.com>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-cnwEvQ0BMpxM4kJfOKJQ"
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


--=-cnwEvQ0BMpxM4kJfOKJQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-10-24 at 20:04 +0800, ChunAn Wu wrote:
> The software-node-backed serdev client cannot be matched through ACPI or
> device tree and is force-attached to its driver.
>=20
> Pass the modalias to serdev_device_add() and give the serdev driver a
> matching id_table, so that the serdev core binds the two through normal
> matching. Deferred probing is then handled by the driver core, so the
> -EAGAIN translation is no longer needed.
>=20
> A failing serdev probe no longer propagates out of the platform probe;
> as for any other bus, the client is simply left unbound.
>=20
> Signed-off-by: ChunAn Wu <an.wu@canonical.com>
> ---
>  .../lenovo/yoga-tab2-pro-1380-fastcharger.c   | 25 +++++++------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c=
 b/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
> index 8551ab4d2c7d..d0bd9d4e3137 100644
> --- a/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
> +++ b/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
> @@ -219,11 +219,17 @@ static int yt2_1380_fc_serdev_probe(struct serdev_d=
evice *serdev)
>  	return 0;
>  }
> =20
> +static const struct serdev_device_id yt2_1380_fc_serdev_id[] =3D {
> +	{ KBUILD_MODNAME },
> +	{ }
> +};
> +
>  static struct serdev_device_driver yt2_1380_fc_serdev_driver =3D {
>  	.probe =3D yt2_1380_fc_serdev_probe,
>  	.driver =3D {
>  		.name =3D KBUILD_MODNAME,
>  	},
> +	.id_table =3D yt2_1380_fc_serdev_id,
>  };
> =20
>  static const struct pinctrl_map yt2_1380_fc_pinctrl_map[] =3D {
> @@ -260,25 +266,12 @@ static int yt2_1380_fc_pdev_probe(struct platform_d=
evice *pdev)
>  	/* The fwnode is a managed node, so it will be auto-put on serdev_devic=
e_put() */
>  	fwnode_handle_get(dev_fwnode(&serdev->dev));
> =20
> -	ret =3D serdev_device_add(serdev);
> +	ret =3D serdev_device_add(serdev, KBUILD_MODNAME);
>  	if (ret) {
>  		serdev_device_put(serdev);
>  		return dev_err_probe(&pdev->dev, ret, "adding serdev\n");
>  	}
> =20
> -	/*
> -	 * serdev device <-> driver matching relies on OF or ACPI matches and
> -	 * neither is available here, manually bind the driver.
> -	 */
> -	ret =3D device_driver_attach(&yt2_1380_fc_serdev_driver.driver, &serdev=
->dev);
> -	if (ret) {
> -		/* device_driver_attach() maps EPROBE_DEFER to EAGAIN, map it back */
> -		serdev_device_remove(serdev);
> -		return dev_err_probe(&pdev->dev,
> -				     (ret =3D=3D -EAGAIN) ? -EPROBE_DEFER : ret,
> -				     "attaching serdev driver\n");
> -	}
> -
>  	/* So that yt2_1380_fc_pdev_remove() can remove the serdev */
>  	platform_set_drvdata(pdev, serdev);
>  	return 0;
> @@ -305,8 +298,8 @@ static int __init yt2_1380_fc_module_init(void)
>  	int ret;
> =20
>  	/*
> -	 * serdev driver MUST be registered first because pdev driver calls
> -	 * device_driver_attach() on the serdev, serdev-driver pair.
> +	 * serdev driver MUST be registered first so that the serdev device
> +	 * created by the pdev probe binds to it via the id_table match.
>  	 */
NIT: I think the order doesn't matter anymore, since it will bind
regardless whether driver or device is registered/added first. I think
you can remove the comment.

Reviewed-by: Markus Probst <markus.probst@posteo.de>

Thanks
- Markus Probst



>  	ret =3D serdev_device_driver_register(&yt2_1380_fc_serdev_driver);
>  	if (ret)



--=-cnwEvQ0BMpxM4kJfOKJQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmrcrpsbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSHwAQALQOE9nZFnHYee2suLio
jVAK4rNPY5jgMlsrJVYXByghGLZ8sub3MRK3J79DheNb5D+L2p2Z4GVtXzytYSfw
FIAaFS7P2ASxUQgwbfqrS0+FXx3M535LFoDPL88xgghQl+AZMgtWBAMwTecWBZlY
CaYejJC21HVrxijILtOF5cg38ZvgQ7Gyap4eJ4c4J113JzcrBGQsGGrFs/h2WxoC
7oVFCbXEEjVqi9fD8eoYlcJQ2vhotzYd1OYGEGcAecCsmtl3ZkN9tpc6MKNVtJrz
MnGnh48JMxP89td9SHs5oCjgXLJ6feMNuNF0a9h+O52lm95DS9XZ8yoIzUoet+FQ
xI25uGzp6r3JdTB7SmCoE4SPh8+MTMwtQIeJJ8intqKDgI0N4WkGM5MoKV7gMsvJ
JtPvZeVafHKuREnnimD7B5IdtXZedF+g7jUFO3/OY4gV2BYhGdWcMayggN0FvcIl
fDGFR1BIdwup87JZd2fdqDLfSpgzrsWz2UjKxHSry24pfxTKXQFNyPYwJp1a3ueC
Bo8oI0vYDMFxJFomgvtuTTkxJNtOo5MmhmIR47wGzxMhPLmLE1elrp1ui9Dsb2ie
OaXSzk8KCgdCLe80pMs452d69K07SiZbll0tMYCZfJZPKeoawgrKtrpA7UauEu8d
/Ky+q3nQ9FEhQljJlCBwCTRR
=XPcs
-----END PGP SIGNATURE-----

--=-cnwEvQ0BMpxM4kJfOKJQ--
