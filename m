Received: from 0001.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8CF48595C;
	Mon, 21 Sep 2026 12:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789994826; cv=none; b=NGmcZIyNElsMtLdkOXZRWMs0yePU4Sur7TB1ggaE80TOX+1ThVPDr401SQSr92lfbQ+Jlysj1neS7pF+37P5RQxTbjaqQeKHn/Ze4tLO2TvWYdPOULSSGMVbsjLdU5VYYefbnhsTTHOv7R+gVknhmIw78L0xlb05EMjDv0kEk80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789994826; c=relaxed/simple;
	bh=0BgkS0X3pfARD7xlPenzZAzHbcH+oYWC73YWsvir9Bw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=QEl96WB7ojyro4Tir7qjRlOCxplGCRn0VJbvZtBUlr0lPdzehkoXpo93JnjWblGBhvKu5q0lgkaSVRwNbBNkPxmdaTh6gDR9RwJIDijoZCNspp4PI0r+lgvOFHjLR9C3SqdFqZ2+TpgpN0w2p0lh2h5tZhFxE6huqzhcAt+w90g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=walle.cc; spf=pass smtp.mailfrom=walle.cc; dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b=16B29EEi; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="16B29EEi"
Received: from localhost (unknown [213.135.10.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 81CD85C;
	Mon, 21 Sep 2026 14:46:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1789994816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0BgkS0X3pfARD7xlPenzZAzHbcH+oYWC73YWsvir9Bw=;
	b=16B29EEiIN7cXTXUo7NzjnOQlc9Z/B6M+jzDkuHerC8x+2EwsiJsS5d5nS1yHEmfeEbpvX
	wMpidef3+45QsFe7iH9uztbUcXIYPB94b/lY6MKMn5dpk03jqcjmesWzIFi1x7iph9u5pK
	IVnASkXaOeu2pO6eM65U7QDhMRaquaPrnYEYX/krt+VF6Xdeu6ADFuyplkIy4lhO/FXL/c
	37yCEwV5A0agJWfclqLKBw4gQn9mbDNF6B1EARHjhVIr5VgRRC24V0oybA/z5PBzltYDpe
	riZh4xwzOn+IC7NyduPSQ29HGPTbD/o8oTtD+/O9Sjx1O6MvmZ3e6IJrBkPjyQ==
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=b0aecd10d4970feaedd7d33bf060515ea13a2a83f941c6cf988065fda9d0;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 21 Sep 2026 14:46:54 +0200
Message-Id: <DLL07DMYQ9EN.3I5OQJ93M8J1O@walle.cc>
Subject: Re: [PATCH v7 00/15] Ambarella CV75 SoC minimal bring-up
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
 <linux-kernel@vger.kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@oss.qualcomm.com>
From: "Michael Walle" <michael@walle.cc>
To: <longzhao@ambarella.com>, "Arnd Bergmann" <arnd@arndb.de>, "Krzysztof
 Kozlowski" <krzk@kernel.org>, "Alexandre Belloni"
 <alexandre.belloni@bootlin.com>, <soc@lists.linux.dev>,
 <linux-arm-kernel@lists.infradead.org>
X-Mailer: aerc 0.20.0
References: <20260915-cv75-v5-v7-0-3297d3fbc9c0@ambarella.com>
In-Reply-To: <20260915-cv75-v5-v7-0-3297d3fbc9c0@ambarella.com>

--b0aecd10d4970feaedd7d33bf060515ea13a2a83f941c6cf988065fda9d0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Sep 15, 2026 at 1:15 PM CEST, Long Zhao via B4 Relay wrote:
> This is a single unified series. Please apply via the SoC
> tree; subsystem maintainers are Cc'd for their pieces.

Well, not really. I wasn't CC'ed on any of the gpio-regmap patches.

-michael

--b0aecd10d4970feaedd7d33bf060515ea13a2a83f941c6cf988065fda9d0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKcEABMJAC8WIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCarEnPhEcbWljaGFlbEB3
YWxsZS5jYwAKCRASJzzuPgIf+JbDAYD5NzUis6sH68krurEUmfZHPET63flmrmwz
18rKy6cs6l45m6clXLvKPPfU15T+MEIBfR76IBYbqIHCrqRx0hg58wcEk/4iVesC
afNRcTi5Hg1HbPYc3TajUdBjsycsnRCLeQ==
=D+KD
-----END PGP SIGNATURE-----

--b0aecd10d4970feaedd7d33bf060515ea13a2a83f941c6cf988065fda9d0--
