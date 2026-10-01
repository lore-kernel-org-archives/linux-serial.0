Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CBC2F0C7E;
	Thu,  1 Oct 2026 12:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859020; cv=none; b=T0bQgS1vqDswa3fcKmMdIR+KSbwDK2dPxCiOKyH5RETS+CsN5QehUzqUdCXn2pd5t1VJqAJVqYbiG6x7cM1vV0gfJchV7VLkRUWwQxWA9bum6omHhdd+xgrUlUV5u3v0fN0mrBYCG0YcTsihF3gFnbxztHJzNu8wST4jiHxlLPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859020; c=relaxed/simple;
	bh=1ZZUVQqa95CA+sh9eTntOauCQpBDHkmxUkTZoTksI0k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YJL7v4MADv8qy4Zj4tnP0QPD1SK3ThDttwbuLIMl51HTWo+2YE5xn6g1W7M/0YeUSlnp5qmNAeTp+LI9wWKyngf5Lw5w6U+vsZQzUxeQo0XJzECgfEUt1055AsILuH2Z6//QRl+3BkJptyebKEkzmKUXZB3QLJPw3bQgNBat8w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJd7HXvO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJd7HXvO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D91891F00898;
	Thu,  1 Oct 2026 12:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790859018;
	bh=1ZZUVQqa95CA+sh9eTntOauCQpBDHkmxUkTZoTksI0k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JJd7HXvODxkr3P5gUXj1WHDxg6chItZ2IBfyF6UuWYjQPQxOwtpGmSVFtUsJio/Gb
	 7Ehk+2WedTQo0FnXOUxqFYe/eFWG/gDigLIbY2rfl/8K0tomUU6JBRlown2itWxbID
	 zb+LLQhgWBCP9UsFtLgJeoka0vpP3G2ao/GROtktY2T6hxYmc72bmrZR/Oh+R57O4A
	 cbOZ2ZxuEtj0FvDGVatk+VSBeiKayma6QOjDQ3YPxUnYkkLi9BhBXfooUrKGpyCemo
	 7KCxA1G7B32JaYtJMjRWaNAvj8jmbhbk7c6UnYPMLHRjf5nTYUbg9Zaw4zFXd8KQr9
	 Jq8GlhRHEm3rQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 04/15] dt-bindings: gpio: pl061: add Ambarella CV75
 variant
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Zhao" <longzhao@ambarella.com>
Cc: conor+dt@kernel.org, mfd@lists.linux.dev, lee@kernel.org, linux-clk@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20261001-cv75-v5-v9-4-486cc289a4b8@ambarella.com>
References: <20261001-cv75-v5-v9-0-486cc289a4b8@ambarella.com>
 <20261001-cv75-v5-v9-4-486cc289a4b8@ambarella.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 12:50:17 +0000
Message-Id: <20261001125017.D91891F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Long Zhao <longzhao@ambarella.com>
>=20
> The CV75 GPIO banks sit on the AMBA PrimeCell bus but are not
> register-compatible with the ARM PL061. Each bank is 32-bit and 32
> lines, with extra mask/enable registers, so arm,pl061 must not be used
> as a fallback compatible.
>=20
> The AMBA core matches the PL061 driver by PrimeCell ID, not by the DT
> compatible string. These blocks do not implement the standard PL061 ID
> (0x00041061) in the ID registers, so arm,primecell-periphid is required
> and is fixed to 0x000e8061; the driver uses that ID to select the
> Ambarella layout. gpio-ranges is required because each bank is a slice
> of the SoC pinctrl pin space.
>=20
> Signed-off-by: Long Zhao <longzhao@ambarella.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-cv75-v5-v9=
-0-486cc289a4b8@ambarella.com?part=3D4

