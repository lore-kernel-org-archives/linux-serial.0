Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EED321D5BE;
	Fri,  7 Mar 2025 15:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741362943; cv=none; b=C6G8W40lu/S2M23rfJJPEVwbQluOgFjxb0GeHG4bNLg2EVrI44DXHZHpqIp4Dz26AcAjVw0X4AOYT7XUhN4ZPC50PcUHrFH4vWQXfQ9jh+9c7dE0DGxljf9Nvn+sifKkPzLM0Y+uF20lo0ggZWnow2ZnVA5ouX4nm/W2ed8DT1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741362943; c=relaxed/simple;
	bh=RuMvtaW1d4WXmWnoVBWNYqp3QXUaMXIuol3d+mQwQxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfs9mMWCp68YSmiBk/C1LzEoDw23avq43WjvfCg72EC+w0On3xmHzHQl7QbAkkC66CWykK3zhQGqVXnJ+9FtkdQogTNXf0sWeb2aTElDUkeSQxOF87TnEwdxw6wmfl1BJjpOSfjbMbYV/co4CTA9drPlJmvalPB5duha8r5RKL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTe3f3Dv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTe3f3Dv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE09C4CED1;
	Fri,  7 Mar 2025 15:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741362942;
	bh=RuMvtaW1d4WXmWnoVBWNYqp3QXUaMXIuol3d+mQwQxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XTe3f3DvsiL0Ghx969nc5i+tlIbM7u5h0M3ynR+PZopKzbCP5vw942SmkVcW0W3Oe
	 VG+fmCFooZoRPnqMBT5stUa/acY7XLkSQdzuCzmUZonnxIk9d7IMqq5chhF2veaJ3G
	 TY/1qSxrb02IoSOaLkcD6hdNCiHf+zZCdLgVY3C5U8vgNiuVr2vURmWrzzgt+c1P6A
	 WgmAH8jsAF0FeezmgtzQYhfCVn1E64KD2at5c+yKmfoSZuayvE+kvL2UCZxHkbkZP8
	 GZzEo6QQ88aww8wzT8Jp68wSlSMazfl6pRNQgqR6J18sc5k06VUQXskutF5BDwppcA
	 3JvOYJZEqjNhA==
Date: Fri, 7 Mar 2025 15:55:37 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fugang Duan <fugang.duan@nxp.com>,
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>,
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	imx@lists.linux.dev
Subject: Re: [PATCH] dt-bindings: serial: fsl-lpuart: support i.MX94
Message-ID: <20250307-satirical-washday-5ac15a6980d2@spud>
References: <20250306171052.244548-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gLJbNM/LIicxX3Ye"
Content-Disposition: inline
In-Reply-To: <20250306171052.244548-1-Frank.Li@nxp.com>


--gLJbNM/LIicxX3Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06, 2025 at 12:10:51PM -0500, Frank Li wrote:
> Add compatible string "fsl,imx94-lpuart" for the i.MX94 chip, which is
> backward compatible with i.MX8ULP. Set it to fall back to
> "fsl,imx8ulp-lpuart".
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--gLJbNM/LIicxX3Ye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8sW+QAKCRB4tDGHoIJi
0tNjAQCnBgS8XwdKznNKPINg5H0qzt2RWJvieQaj1HllU5gb7QEAlSAfqMLMvXja
KJo/kGK+9PlYCf20Ilb1Q8q6FNopQQ4=
=WFNI
-----END PGP SIGNATURE-----

--gLJbNM/LIicxX3Ye--
