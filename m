Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A021729BDB1
	for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 13:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785502835; cv=none; b=WZRek2W8RAenPHFikO2mDnfaxelxtod1GtanCRo3b8mpA28HBMxuK1JF6pO+RFfZ+gdiZW9AeeLYF7nHrGc1Fvoy1W68FtjjOBtSr0xtTNbVWWz21z6ZDRUcRpI4ocDwYC6kwG92pIY9LlqCDSRlNTm/KpeUdzUI2W3iF1rGFSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785502835; c=relaxed/simple;
	bh=Wz2+xt6OGg0gqsPqbYf5fUQ+mbzW1aL5Crz52NjUhEo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FIIOxC4AyICBnn2uJaG9xHOJjOrHrd19ShXXcaaaowCw3rAqBlZn0bHLZpv3cOkuLanmSz05gldIbcUCaHa39NS+HlkR3d0uWv54/ZZU1l5JcfRHJWzmxuEFTQ/JbmzRlg++fyN0kDMeR7J414A5qsSwv5u7P9pUxGrPZTHmrcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=hR1pQo9d; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="hR1pQo9d"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 6452624002A
	for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 15:00:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1785502830;
	bh=jnDSIzsGoB+tAgiBdFTv9sYHQERzo4XunsAeyQsL3R4=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=hR1pQo9ddkSVjFogT4oFGgIg87NPOkbtFZOKIIb8jRgajY9pTw7vc6bl8dM7wkmLO
	 xyxCCz9lxt5N65DQbvz1RgNCTPKwP+rgXdhz95AK8Z3z2/pI7ZUhnFVRPtubd5mQAo
	 Ka8eyGuGS4m7o3IC2ZR1/5gSj/arGoRAhuN6iJH5QjDDaBXw5mQG25rNSBCMyvFptw
	 Sc34Fvkhi7vfUnN7vkcFSuh8fmmZ0WR++/WBE1RhLx6395eTDa/ujj05uU2U4Jvk3U
	 08PtNmD9MjFU0iW5kuUbXOBK/ij1tEfeiopDa+nbOlCILAvQwhNlC5hyv47dfqfz28
	 Krs4YVNfNW+VQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hBR4s2Rytz6tw1;
	Fri, 31 Jul 2026 15:00:29 +0200 (CEST)
Message-ID: <11b34a60b7f66379e66f4cff779acdccd3fd0c8d.camel@posteo.de>
Subject: Re: [PATCH 2/2] serdev: use tty_port_tty_get() in
 ttyport_write_buf() to prevent UAF
From: Markus Probst <markus.probst@posteo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-serial@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-kernel@vger.kernel.org, Joshua Rogers <linux@joshua.hu>, stable
	 <stable@kernel.org>
Date: Fri, 31 Jul 2026 13:00:30 +0000
In-Reply-To: <20260731-aisle-tty-serdev-v1-2-2401a3189327@linuxfoundation.org>
References: 
	<20260731-aisle-tty-serdev-v1-0-2401a3189327@linuxfoundation.org>
	 <20260731-aisle-tty-serdev-v1-2-2401a3189327@linuxfoundation.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-9ubk5P0CAZ1iIWTfmgD3"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-9ubk5P0CAZ1iIWTfmgD3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-07-31 at 10:06 +0200, Greg Kroah-Hartman wrote:
> From: Joshua Rogers <linux@joshua.hu>
>=20
> ttyport_write_buf() snapshots serport->tty as a raw pointer without
> taking a reference, while ttyport_close() can concurrently release the
> tty via tty_release_struct(), leading to a use-after-free. Use
> tty_port_tty_get() to obtain a reference-counted tty pointer, matching
> the pattern already used by ttyport_write_wakeup().
>=20
> Assisted-by: AISLE:Snapshot
> Cc: stable <stable@kernel.org>
> Signed-off-by: Joshua Rogers <linux@joshua.hu>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/serdev/serdev-ttyport.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/ser=
dev-ttyport.c
> index 48ce5b3f8308..4d37c8130dd7 100644
> --- a/drivers/tty/serdev/serdev-ttyport.c
> +++ b/drivers/tty/serdev/serdev-ttyport.c
> @@ -85,13 +85,21 @@ static const struct tty_port_client_operations client=
_ops =3D {
>  static ssize_t ttyport_write_buf(struct serdev_controller *ctrl, const u=
8 *data, size_t len)
>  {
>  	struct serport *serport =3D serdev_controller_get_drvdata(ctrl);
> -	struct tty_struct *tty =3D serport->tty;
> +	struct tty_struct *tty;
> +	ssize_t ret;
> =20
>  	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
>  		return 0;
> =20
> +	tty =3D tty_port_tty_get(serport->port);
> +	if (!tty)
> +		return 0;
> +
>  	set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
> -	return tty->ops->write(serport->tty, data, len);
> +	ret =3D tty->ops->write(tty, data, len);
> +	tty_kref_put(tty);
> +
> +	return ret;
>  }
> =20
>  static void ttyport_write_flush(struct serdev_controller *ctrl)

It should be the responsibility of the driver to ensure
`serdev_device_close` and `serdev_device_write_buf` are not called
concurrently.

This also applies to
- serdev_device_set_baudrate
- serdev_device_set_flow_control
- serdev_device_wait_until_sent
and more, which currently iirc even introduce a null pointer
dereference if called with the serdev device closed.

I don't see why `serdev_device_write_buf` needs special protection
here, which the other functions don't need for some reason.

As with the previous patch, this still makes sense for hardening.
With scope_guard being used,

Reviewed-by: Markus Probst <markus.probst@posteo.de>


Thanks
- Markus Probst


--=-9ubk5P0CAZ1iIWTfmgD3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmpsnGwbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSfK8P/jc0o5PydQM2Kze0GhXR
CNIpoB7VD4wyqMichSSRja7U3vkm/nMR7+HnGq6x4Kw8d5/YLptLsr7gXTtIY7o3
87KBY3PyGOt+nO2LgDjw/yh+Km+buX5WehVoDE6+c0PZQK0IvVq1gNZT57VoNmHG
DMp8PwtnbwcalHr90sNZC0+GEztipo94d5CsE+WF/8taUCLRikGipRn7jQx+uyr0
YyofhX73v0qo8zbcwydU3zxdmJBuxDf61XN1YspwIKaoWQe1nyw5r+g+O4flC+wH
p9wHQS+cSsHaSnoeZ/0icDqcq5g7IWWgYeoHynOAlXkz9ai5Wpy/LMJKngH50j0C
yLRkjVcu+88gr90PyUhRW0IBdQWHYG3HnrIJ4xFOcVn2Uo/Qk9xJ48sA2afoqou+
vM3/Km0UR3jWltfs5G05RURI0kPt9mD7J/83sjKcbQYKOjnYXcKaM6HcE63mFdPl
oqbWJ1YOmtwAytDQqHlpbrlRdPnEIJbkUI3mdDLODq5h6sqGg/ccAuoAAhIvc/2F
KHIjznXHihMKVs9XiZfbVlFFEmUxvRUnRm9cZZPAZYmzaI71BmjG/mk3f7XUL2vD
iI3ctoKhquLLB0LSJpOlTezxcoPMiHysswuUYP/9WdMs5L50ELxplF3KcpbGenoR
RcdKXdt6nkiuj9vxYJaYZSSo
=0LCx
-----END PGP SIGNATURE-----

--=-9ubk5P0CAZ1iIWTfmgD3--
