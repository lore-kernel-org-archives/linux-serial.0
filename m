Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792514534;
	b=blqf0WqoNngskPwE2BdEL+xVdO5f6C8tckZBQSAKmnaGOCm2aKWWBqn2JVQA3dJP0Les
	 jSFvO/oZr54+nhVjPf689Ui6hYsZKWyZrBWBGPrZqqgSPucRrKVBGchuriv7xs2CKIUdc
	 MCwFHCE25sichWACZAtZ+dKPWQm8sNycRGx65qxgJnf9V/4OhVpO8ajggg5yY4Sd3nS7B
	 yG+um2hn6C+b/zSFxpamHYTXJHeIejl+CX2bmNIvbqYqV+2z8ntDXwSIIsGUAiv+Zj+H0
	 H6Bm4217pFs4ODxds0wrhEeydm469sli7fIsXpUHm0nNBEJVB5ikrTSjpFhOrUhknxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514534;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP;
	bh=SZ6fQ9l12w1SY1Xw56BhMQcvbpp4csO06hvUUeW3Yjo=;
	b=scS6+5Ba8hboaCEfXo+qaIksSKnkfPZGxA5Ak5j1xrXIr128xm0cA23Q4Wk+ca5lLP3k
	 cYBouMY6SEGokTkjvVfkLSEtAAQIaw0axwGkGjVchnAE2ogu3v5MbNCXPTYNRQzQ+Y+fe
	 YOpehHO7H7cMxlW9vlpdxUMx5OZqAuoqVOA9tgek6aKs6Tsh7GAI3nEt4jjCaOQLrcbd/
	 ziklNNzgWmmVoR41NSgQpWEigjHUZSgeHrV1uRgdB5GIvPx2wLyj2yhcHmx1t0+SBLodH
	 D2cnSJko+XuccnvHKoz/GTdsFNgdyzm2JHHIkhGitlINQBIAic1K3HdfN7GS5c11F+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=dTFGljrn;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A64606A31A
	for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2026 16:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33A64606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=dTFGljrn
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 99EF1240103
	for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2026 18:42:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1792514531;
	bh=SZ6fQ9l12w1SY1Xw56BhMQcvbpp4csO06hvUUeW3Yjo=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=dTFGljrnbR5jGvySk6o9DeaNGbx264gzTSBPuJxXRmy8gAigXtuEityxZDJrF1LHt
	 nQNslpY0XA5PHi6zlSKmNFNM7nDWr66PDgEzH3+zzQSgXMkc1RHmBsBfqHwpo7wTWN
	 QKPf/4SB/wMpo2oa8i0Ni/NrZFWa0aNXXLVvIZkpG9KqMhTOXq+RmhngtxAcCk2MSW
	 VIKC4ImFwB+qnXO+G8WlKmsk4ku8z3thCb+LOUkr13VTrOnuybwG+VTIJLedOa7Jfd
	 2Q2a2wtogIx2lWnWosK8asjwkwEpadsJlJ4t+sA5+KFzb9+za/QguTtuxjiooTRfWD
	 PrAy8rgv9pH4A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4j8J9H0F84z9rxL;
	Tue, 20 Oct 2026 18:42:10 +0200 (CEST)
Message-ID: <8e4ca13d3e8acd5d649bd4c7357e5da0785ba6b3.camel@posteo.de>
Subject: Re: [PATCH] serdev: handle devices without an ACPI or device tree
 node
From: Markus Probst <markus.probst@posteo.de>
To: ChunAn Wu <an.wu@canonical.com>, linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Date: Tue, 20 Oct 2026 16:42:11 +0000
In-Reply-To: <20261019054513.1966382-1-an.wu@canonical.com>
References: <20261019054513.1966382-1-an.wu@canonical.com>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-iAepJNnpOUv/YQAiGSfh"
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


--=-iAepJNnpOUv/YQAiGSfh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-10-19 at 13:45 +0800, ChunAn Wu wrote:
> Some drivers, such as dell-uart-backlight, manually instantiate serdev
> clients without an ACPI companion or device tree node.
>=20
> For these devices, both modalias helpers return -ENODEV. This makes the
> modalias sysfs read fail and suppresses the device add uevent, even
> though the device is registered and bound to its driver.
>=20
> Return success with no modalias when neither metadata source exists.
> Devices with ACPI or device tree metadata keep their existing alias
> generation and error handling.
>=20
> Signed-off-by: ChunAn Wu <an.wu@canonical.com>
> ---
>  drivers/tty/serdev/core.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index 7500efcdfc21..366c6d906233 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -26,11 +26,26 @@
>  static bool is_registered;
>  static DEFINE_IDA(ctrl_ida);
> =20
> +static bool serdev_device_has_modalias_node(const struct device *dev)
> +{
> +	if (ACPI_COMPANION(dev))
> +		return true;
> +
> +	return dev->of_node && !dev_of_node_reused(dev);
> +}
> +
>  static ssize_t modalias_show(struct device *dev,
>  			     struct device_attribute *attr, char *buf)
>  {
>  	int len;
> =20
> +	/*
> +	 * Serdev devices instantiated by a driver instead of by firmware have
> +	 * no node to derive a modalias from, which is not an error.
> +	 */
> +	if (!serdev_device_has_modalias_node(dev))
> +		return 0;
> +
>  	len =3D acpi_device_modalias(dev, buf, PAGE_SIZE - 1);
>  	if (len !=3D -ENODEV)
>  		return len;
> @@ -51,6 +66,9 @@ static int serdev_device_uevent(const struct device *de=
v, struct kobj_uevent_env
> =20
>  	/* TODO: platform modalias */
> =20
> +	if (!serdev_device_has_modalias_node(dev))
> +		return 0;
> +
>  	rc =3D acpi_device_uevent_modalias(dev, env);
>  	if (rc !=3D -ENODEV)
>  		return rc;
>=20
> base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907

There is a todo comment:
/* TODO: platform modalias */

Resolving this should also fix your issue.

Also keep it closer to
- platform_uevent in drivers/base/platform.c
- modalias_show in drivers/base/platform.c

and avoid the extra `serdev_device_has_modalias_node` function.

Please also address the similar todo comment in `serdev_device_match`
in the same process.

Thanks
- Markus Probst


--=-iAepJNnpOUv/YQAiGSfh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmrXmeIbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPS4IMQALUOlmpUV/IgTXsGhkua
MOCzf/Xc9mo7Gb5L5tfDogt+crB6+6VSu8yOMfuwn07wdQLpFFntfqHCb6T/emhe
WLE+5Bm04S10Obrj+4Z3hJ9W7ugmjFENqukSz4xzRjXtzCT6FxbpLbJ5gTXAf2zc
bsMjKNsokeTJp7nBwXfEgHE7GpWmgkYTot4153XrMkuvYg9LBY5TsHX7B9/po58P
5w0oVvO+Zg7Mvv7w/bnlUgMgPXO3vKFwQp9Jxf17qjmR6mJipaJipW3ge7kL75V6
5SdVrmrW1rCMivscCcHNo8M7NjYWR+M0b4ypc0J41VWc8CGAtDC4kCptUe4mJ20S
5vctCpzihPkAP9NchSYe35uyl0Px2t4xRIpQoQO2B9/7Teb5HRH3/9HnakS44hQA
FdKTuSU4g7Kr4GnKb4/M31wkKvE0uRds9bGZnu3xXUNkYCjE5oJCVaMn7ibMo5Yy
MAnvP3+lipp9vrKSUVSI1E3J8QuqXFK7utuj2tMNBqr69bk6vGTWGpXj/VLwrkrk
4LvW+5xiXJqmrDbvAhV0mxFy07SDDgvF3V87EOzlFDvYvh7crnI/090UwawG5vEc
qlNjSWm8bBrJSxsVZh8ouuRQsp4AyB8unNJUSsBnAkq+imcwAPnYPthkpOaBycNi
ijVH5qF9wuzOzuW0pPbMK2UP
=PRsN
-----END PGP SIGNATURE-----

--=-iAepJNnpOUv/YQAiGSfh--
