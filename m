Received: from 0001.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490B349B5A8;
	Mon, 21 Sep 2026 13:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789996593; cv=none; b=QVKF33g7K9vtr/lVw+7hSk87+WfJm0/r8/IV3AwlJ2ONOik3EyrSLC3ioYAX2QT10RKJK8W3UeumdyhL+bLabO94wx4CaV3FuaffPw85NZX/Xl2/hdlAA+vIzqXlXZY0rKKDT9RCgKfUiUpgw14g5DrXFtmi2e3N7z0DawE5C8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789996593; c=relaxed/simple;
	bh=Vwy7iikQgD3bQ5BZWAePIlG229Fy30hLIygNDM0Q1Rw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=cKuw17a3BllW+dtf8yZ25QYDTbi0xOjT68IXXB+4jAPnrpM7DfWYWEnZtbFdqhrQKOdla3k/bsn3B4eApc64bvXT5TzgdjyB8dFZFCXZZax+IwHGLCWzN0aPhcNVeyvWJqW7g/15BggZDOWqdZ7+FDzhpGjA0yqS5RmDGq3XafA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=walle.cc; spf=pass smtp.mailfrom=walle.cc; dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b=QkziG/3J; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="QkziG/3J"
Received: from localhost (unknown [213.135.10.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 0178042D;
	Mon, 21 Sep 2026 15:16:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1789996590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DetP18Q3F5Qy8qOHacqW0nR2X6Tj/3bujsBkITQAtBA=;
	b=QkziG/3JtLzslZEjZyidfzcMcsDU1U2gHbWNCUb5Xa0LArR8od+VuLfz19G2/63zzisVJo
	fmF+OXlCfLPZkjRwHChfxIgq5PKReYjpZ9c3e8xyXgj5317/WFdinzHZOaxK3fC6Wv56Iz
	w7ArbFfiSHxWX3fASKQ8LHDm/Z9I0yyjz9TyCK5Wxv/ByaB0S3R6Ti2an6D6LzCJ/r2s2Z
	eaNkGOrZP9WrVqNwgrydhN7EH+D+YpbVRx7eX1YLYAkTM+xvA8ugZOCnNUIK4syKxzPnBp
	I78cTT1gf400oVtfXVFZlCaflwq5V10SaHwWX1FSm1vS7pEuAsoEw3CG6JEVeQ==
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=c9d24f83f23e2edfc9d90c2c898338cc459c7915a06afe5933f249ce504e;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 21 Sep 2026 15:16:27 +0200
Message-Id: <DLL0U0B337I6.AI24GMAN59FN@walle.cc>
Subject: Re: [PATCH v7 10/15] gpio: pl061: convert to gpio-regmap and a
 custom irqchip
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Michael
 Turquette" <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>,
 "Jerome Brunet" <jbrunet@baylibre.com>, "Linus Walleij"
 <linusw@kernel.org>, "Bartosz Golaszewski" <brgl@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Jiri Slaby"
 <jirislaby@kernel.org>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>, =?utf-8?q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, "Catalin Marinas"
 <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, "Long Zhao"
 <zl020895@163.com>, "Lee Jones" <lee@kernel.org>, <mfd@lists.linux.dev>,
 <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-serial@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
From: "Michael Walle" <michael@walle.cc>
To: <longzhao@ambarella.com>, "Arnd Bergmann" <arnd@arndb.de>, "Krzysztof
 Kozlowski" <krzk@kernel.org>, "Alexandre Belloni"
 <alexandre.belloni@bootlin.com>, <soc@lists.linux.dev>,
 <linux-arm-kernel@lists.infradead.org>
X-Mailer: aerc 0.20.0
References: <20260915-cv75-v5-v7-0-3297d3fbc9c0@ambarella.com>
 <20260915-cv75-v5-v7-10-3297d3fbc9c0@ambarella.com>
In-Reply-To: <20260915-cv75-v5-v7-10-3297d3fbc9c0@ambarella.com>

--c9d24f83f23e2edfc9d90c2c898338cc459c7915a06afe5933f249ce504e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Sep 15, 2026 at 1:15 PM CEST, Long Zhao via B4 Relay wrote:
> +	config.reg_dat_base =3D GPIO_REGMAP_ADDR(regs->dat);
> +	config.reg_set_base =3D GPIO_REGMAP_ADDR(regs->dat);
> +	config.reg_dir_out_base =3D regs->dir;

config.reg_dir_out_base =3D GPIO_REGMAP_ADDR(regs->dir);

--c9d24f83f23e2edfc9d90c2c898338cc459c7915a06afe5933f249ce504e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKcEABMJAC8WIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCarEuLBEcbWljaGFlbEB3
YWxsZS5jYwAKCRASJzzuPgIf+IxAAYCOUetYEj05vb5mcfKxxZcArWJOU9zLHL1r
Ce1TB0csezyqfYbCaGf0HO6KRvjd3lUBewa2+jLRtEnP71K1v/9VXbPr/fdO49oY
WoJLneVfRBsoGhZUcSmwv5KuL6L0u+4QRQ==
=Y/cv
-----END PGP SIGNATURE-----

--c9d24f83f23e2edfc9d90c2c898338cc459c7915a06afe5933f249ce504e--
