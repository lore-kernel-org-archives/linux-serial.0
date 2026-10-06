Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680F91FA272;
	Tue,  6 Oct 2026 18:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791310732; cv=none; b=sxpp6t7KLsdZGFG8urHSFEfDqlS0BxGSAN6r884FJmGqTnF3M5zCOTqQ09Vn1D3/V5qLV3gNLT48d9nz8w0Dy4+cKf0LQSJ+stp8re4gSB/He11ku0alJdbgu7mU7ZtVT6miBNiI6K0We2sryDbOR+ulrtt8UZxvYJnirXgN2OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791310732; c=relaxed/simple;
	bh=/1jvqU0pxZtHMzui3uatVwH7EuX5H87X5savjjrgesU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=r18hhbvVHsbaEVfs5zw2QtTAQrJL+2AgYh8+74DYhH6lXCcDl9sodKMSBb5NRGEsEkDsMbSlZMzrZtdDLanecz1ZFC9xov9t293ZC9kmNwM5fyC6XiHudyBXJ27Mt41hRROcRZzz4Ggxdi6JxA/asq2w/+qf/2MhkGW1EYy4f/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5XQ6Zzf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5XQ6Zzf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCCCE1F0089B;
	Tue,  6 Oct 2026 18:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791310731;
	bh=/1jvqU0pxZtHMzui3uatVwH7EuX5H87X5savjjrgesU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h5XQ6Zzffgpp9teERcvv4DvzBnaRmkV6TOqRPAvx8l/srFTNQT6TjzRaDx+FK4wO5
	 lBizLMHj3o9mro4agN24B2ehpwi/xEdjMaEFNEQFdhK+rDt370c9CINL42/Troygsj
	 qo54EkHQKQ/TLBoBSn+hsu+adf2G4nMZhidLm63tOf4s4aNkrrB8PSJ+lD2yNaXea2
	 i+MwLxosngnvM2wnzY+s7RaeThrpVzSLudbKvS3oEiewBr4TQFEBLD4Uv2TWYc3U1/
	 SgbCi5tLOyRM/u0GXlMXHb2aUCM8xwUfhyO91FL9yU77C48xgno3qdLfzC5dSk4PvY
	 xXEAYt1IUr6HA==
Message-ID: <sashiko-outbox-162329@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 01/10] dt-bindings: vendor-prefixes: Add Securifi
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: conor+dt@kernel.org, robh@kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20261006-b4-cs75xx-v2-1-b7d6e1e24d44@gmail.com>
References: <20261006-b4-cs75xx-v2-0-b7d6e1e24d44@gmail.com>
 <20261006-b4-cs75xx-v2-1-b7d6e1e24d44@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 18:18:50 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> Securifi Ltd. makes the Almond series of touchscreen Wi-Fi routers.
> Add a vendor prefix for it.
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006-b4-cs75xx-=
v2-0-b7d6e1e24d44@gmail.com?part=3D1

