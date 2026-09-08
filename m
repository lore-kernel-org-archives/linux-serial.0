Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1DE599A3C;
	Tue,  8 Sep 2026 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788889771; cv=none; b=Hk9Gmrx8CNCFFwVsJRGKUQxlRH9/uIHtRKrJiVkT8XcL+iTZx6Ip+lvVJb8CDAeOQUwvFqMEaU+JlfLv/9vAs/9/NN+9mG8SUIkBmCFnv/zVyxFlBCI3+/94oqln9P9ZxdxLSuzKDSSPlX50RG37y2qV7XxVgDupAUTPQp6lDk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788889771; c=relaxed/simple;
	bh=zfZJ8L24GBbiC3D8vqw/xzHvGlAJGCjQzD3bh8D6Myg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FskAPjOAfFFXl6H32mKWy3gqe82TU/DLO65s04Q2IfGSsSjmREx9ll4UeHTU1N2w51vraQD3BIsLXBoXxUUx2rnz5yXokdLa4U+ZypTbxVyVjstvXb6V/ulBAH0h6WHOL1f7XP9LR4uuUyRcHCSV+RKrrO76MKaD0eZTHF3w4c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qr/i5GWX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qr/i5GWX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BCA41F00A3A;
	Tue,  8 Sep 2026 17:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788889769;
	bh=zfZJ8L24GBbiC3D8vqw/xzHvGlAJGCjQzD3bh8D6Myg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qr/i5GWX7SxP5X/hPJYB7j39mtUQMqybMTKdk7ZktBf3R/Hs8vhoE5Oktd14PVpof
	 yTSFd6cD8E1BRXxWjMR3czBLvjeUz9l4DCUr9by6KuAHpbMTMru5aXVG/WEros4eG9
	 iv6hWVCKelStCxFJW+MzXgXUtDvOTDe1uhNZWZ4iiVKdZBYT2OrW/8+ICjbJZSqQl/
	 Tv3ymsk4U+W357q5ZXLN2U5HOumpZuNvkEvHw7Qh12G3Q15HFt7/0ryYtuK1ZtkDtX
	 BLEaSlhh5gWu9n3CuBHLBy/EfmHXlnJsIlXonDrR7agPRQVF0xdHP+NOOoSdz7O/FQ
	 +gwuQKrcDXNfQ==
Date: Tue, 8 Sep 2026 18:49:25 +0100
From: Conor Dooley <conor@kernel.org>
To: zjzhao@edatec.cn
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: serial: Document WK2xxx SPI UART
Message-ID: <20260908-user-follow-58ec6bb137e4@spud>
References: <20260908103129.58085-1-zjzhao@edatec.cn>
 <20260908103129.58085-2-zjzhao@edatec.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2c5sD+SQtTSQSR3t"
Content-Disposition: inline
In-Reply-To: <20260908103129.58085-2-zjzhao@edatec.cn>

--2c5sD+SQtTSQSR3t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 08, 2026 at 06:31:28PM +0800, zjzhao@edatec.cn wrote:
> From: Zi Jie Zhao <zjzhao@edatec.cn>
>=20
> Add a DT binding for the WK2xxx SPI to UART bridge ICs (WK2124, WK2132,
> WK2168, WK2202 and WK2204) from Chengdu Weikai Microelectronics (WKmic).
> Describe each UART channel with a serial@N child node carrying its serial
> and RS-485 properties. Register the wkmic vendor prefix based on the vend=
or
> website http://www.wkmic.com/.
>=20
> Differentiate compatible strings by channel count and
> register availability. Account for missing hardware flow-control and
> RS-485 registers on WK2132 and WK2202. Reject serial@2 and serial@3 on the
> two-channel members.
>=20
> Require the standard clocks property for the single external reference
> clock used by the chips.
>=20
> Signed-off-by: Zi Jie Zhao <zjzhao@edatec.cn>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--2c5sD+SQtTSQSR3t
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaqBKpQAKCRB4tDGHoIJi
0lrIAP9AeviOBZjovLtQ7Gw0L+gnjThIJFjPahSfUMgEY2bQpQEA5Y2feeQlwBTo
pLe+dhGYtcMdGmQcDrJCAePuIM/4Hw0=
=/yw0
-----END PGP SIGNATURE-----

--2c5sD+SQtTSQSR3t--
