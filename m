Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385953BCD01
	for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785497948; cv=none; b=hYn2xTy1SBVawgI1Q33l9uDc8d3IXh4OhSTNQ4OJs4Mg6h0Z8oZue65o6I3QZKH4qIZWm8zrL4ok9NY1Fr0EBk4f6IIdnAaknGoxxvh64yh7+LaaE9DUtHLRH3Fg3W55nKRJEyTfqZsRbQimGIpt0cR27ub2Ue1fWJ/KYOL87eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785497948; c=relaxed/simple;
	bh=KOLBykeAPFk6L6p+4smR0z1PsZJQ+MnT44/IEKjXCAU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u3+yKEOTqkKuLap1spioyoJ5tnam2hnz8FIqSY/ZLGgvXZS78M/R4V03rjbJMFs2ho2DPUKUdEurvWIob90FNJRn8f9h4nf5W8qI2Jt+7yZE9h5pLj2a8JoInpDPSAXskuuTm3jS6F7bnqHudM0m87cvyAE3ikWR622ZXegXAwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=SvwVPi4N; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="SvwVPi4N"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 3352C240028
	for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 13:30:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1785497454;
	bh=37u93W7h8bnyNg/hOZE48Fk6JoHsbf6btPxhYdCANGA=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=SvwVPi4NOkZHqDhRoQLp18XsqpPVlXI/wfQ8rO45og1jZ97yTxJAEjRfvKOzS6R0Z
	 wpLjbe424aCfl5Zl8YGpY0vV7/qEtbZtXRpTDomGOUWak/ih4FntERnoZLvizlLdHd
	 klnNYB9A6NmAG3s5KElUEvdSPEiLmL3KFJOfTSQBs4rlXEHKdHMIGlj3IMOf1HnpY8
	 RrTYKyTDdocqn2EbxeP5hDiJ8SU3yLZPgEQG3FbhdxbI2J8cl3EpOOiMqQQmJ+1Izi
	 vgPtqjSltSlRV/+Nh7W9sSrWr9gViLkQnytA71p8p6QwVjul8UEELmbohAbD+unt89
	 WGd8gklHyIfhA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hBP5S67gyz6tsf;
	Fri, 31 Jul 2026 13:30:52 +0200 (CEST)
Message-ID: <edd75d5a4362e5c8e7b691f65768d1fedc30309a.camel@posteo.de>
Subject: Re: [PATCH 1/2] serdev: fix race between tty-port unregister and
 in-flight callbacks
From: Markus Probst <markus.probst@posteo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-serial@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-kernel@vger.kernel.org, Joshua Rogers <linux@joshua.hu>, stable
	 <stable@kernel.org>
Date: Fri, 31 Jul 2026 11:30:53 +0000
In-Reply-To: <20260731-aisle-tty-serdev-v1-1-2401a3189327@linuxfoundation.org>
References: 
	<20260731-aisle-tty-serdev-v1-0-2401a3189327@linuxfoundation.org>
	 <20260731-aisle-tty-serdev-v1-1-2401a3189327@linuxfoundation.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-EUFn1wPl5p1+FXr4nf96"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-EUFn1wPl5p1+FXr4nf96
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-07-31 at 10:06 +0200, Greg Kroah-Hartman wrote:
> From: Joshua Rogers <linux@joshua.hu>
>=20
> serdev_tty_port_unregister() clears port->client_data and frees the
> controller without synchronizing with in-flight flip buffer work.
> This can cause NULL pointer dereferences or use-after-free if
> ttyport_receive_buf() or ttyport_write_wakeup() runs concurrently.
>=20
> Add cancel_work_sync() to drain pending buffer work before clearing
> state, and add NULL checks for client_data in both callbacks as
> secondary hardening.
>=20
> Assisted-by: AISLE:Snapshot
> Cc: stable <stable@kernel.org>
> Signed-off-by: Joshua Rogers <linux@joshua.hu>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/serdev/serdev-ttyport.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/ser=
dev-ttyport.c
> index bab1b143b8a6..48ce5b3f8308 100644
> --- a/drivers/tty/serdev/serdev-ttyport.c
> +++ b/drivers/tty/serdev/serdev-ttyport.c
> @@ -26,9 +26,14 @@ static size_t ttyport_receive_buf(struct tty_port *por=
t, const u8 *cp,
>  				  const u8 *fp, size_t count)
>  {
>  	struct serdev_controller *ctrl =3D port->client_data;
> -	struct serport *serport =3D serdev_controller_get_drvdata(ctrl);
> +	struct serport *serport;
>  	size_t ret;
> =20
> +	if (!ctrl)
> +		return 0;
> +
> +	serport =3D serdev_controller_get_drvdata(ctrl);
> +
>  	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
>  		return 0;
> =20
> @@ -46,9 +51,14 @@ static size_t ttyport_receive_buf(struct tty_port *por=
t, const u8 *cp,
>  static void ttyport_write_wakeup(struct tty_port *port)
>  {
>  	struct serdev_controller *ctrl =3D port->client_data;
> -	struct serport *serport =3D serdev_controller_get_drvdata(ctrl);
> +	struct serport *serport;
>  	struct tty_struct *tty;
> =20
> +	if (!ctrl)
> +		return;
> +
> +	serport =3D serdev_controller_get_drvdata(ctrl);
> +
>  	tty =3D tty_port_tty_get(port);
>  	if (!tty)
>  		return;
> @@ -312,6 +322,7 @@ int serdev_tty_port_unregister(struct tty_port *port)
>  		return -ENODEV;
> =20
>  	serdev_controller_remove(ctrl);
> +	cancel_work_sync(&port->buf.work);
>  	port->client_data =3D NULL;
>  	port->client_ops =3D &tty_port_default_client_ops;
>  	serdev_controller_put(ctrl);

So why exactly does tty keep calling `receive_buf` and `write_wakeup`
with the tty port closed?

After `serdev_controller_remove` is called, the tty port should already
be closed by the drivers.

Thanks
- Markus Probst


--=-EUFn1wPl5p1+FXr4nf96
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmpsh1sbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSCaAP/2GkIU4D5R4IBzj1A0NO
YfYewKxajbkjyxRNQf1o+ccNdi5Ia6XE/JEIKo55rKQxkmRLI3w7q3AYrf2Lwg/V
N111MjRH57BnPjzlUPxcmZ/atMhnHuyLCrfgnP+eesib6HarDVHXkX7HkcuseFGZ
RwrZepRiUeSLYCzVSyz+BPevCVn9tgegwPQS7XMqo1ikeEdnU2NbLDjYkpwV96in
h7O6OK4C/gfOpHmBsS0jUtWNZyf/fLZYMKmIsppjg++yADXgKfQs6KnNWrS9cTkp
my4zIJdI7nwUbxN/SpZPF6EGs0uZV7BM7m8B72xyTJKCYvk4x9BkKdfyG34pefJU
+/tv4DcpOv/ue99ONcO0dg+8rCed0N34kU/UW5ceuInkV7uZ+XlTpVDFqVptlYtJ
a2xadVjX3wwBmulczlPqwUNx1HWCbHSsG8nksG+CPKfXX2GBzEa23G7HuNqEVp1N
u0P/Y+6dh3xr2sSvsiz7N0NDKqRw8+FPDhVMeqi8Hebtw4C7JdHrY63HSUcjA1wV
oE65t1fMlEUzSXuiurYU85XCJYT+phDtDwVOzv8rItQiK8f9c5mKvZ9XZc/pxPfX
VcylFnH7NKV3IryvDlji7Ys4p4o+0GeM+Ryq5Npwn2nTCQd1sLLP2sJ/hXj+tx8L
bM5DQWWaATJQ0QFFodb92s7p
=ujKB
-----END PGP SIGNATURE-----

--=-EUFn1wPl5p1+FXr4nf96--
