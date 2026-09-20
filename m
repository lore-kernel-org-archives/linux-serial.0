Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23BC47CA61
	for <linux-serial@vger.kernel.org>; Sun, 20 Sep 2026 22:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789943093; cv=none; b=ERy640ArIzYBOI+0fv/OoJm0ZRsUZyRi5TyEY/qW54oGUxt7jAhonXwQ4MAuW6WalQlL4cY+fluTvgiTIS3PNDQ6sA4QsCKv+SUBZRTcUw2mmVHvOR3Ul7iX+8rn97x+fvZBbfIsKsjXiLEhMALHQn62Jw7v1A3198GCalXDrJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789943093; c=relaxed/simple;
	bh=WUPInYN4PL/yK9hW5R5yIfO87gDLK/c9FX+2yDiavu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tjQKuGEGJAtUwY9tFRPotXyVnr0AqzcnOeApuCNTXq3qgnLrOO8/b+4Vl3HYWgvzh5m7hO0edttLmm0I83qyWL8W+bFRqVM8e+fmfqDPYMkJMFS75i8g04uGc/iSCKFFodjIv3oTlkO42ghrnDC9lmIkgJ4mCxyuMRRoyqPSQn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZdIrP5z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZdIrP5z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8611F00901
	for <linux-serial@vger.kernel.org>; Sun, 20 Sep 2026 22:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789943090;
	bh=WUPInYN4PL/yK9hW5R5yIfO87gDLK/c9FX+2yDiavu8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bZdIrP5zvfwLap8QfgPC6COgqkkxn0Rp0hb4PQKz9GA5pE0+W/gBasPcsR/EvdFSt
	 UXm6945/ajbswS+4XQ+4dx7fZeirRuIc+eZIGHIAumn/joKyaWlX0hyYa+o71uUG10
	 AIdFA1c7JncyvouIlGceLHUvQwE3Cf+5H3xPuexO1N/xCbK2b8EjoGGNqBgV16XJTs
	 MFWpLEeSjom1yw8Bz/I9F2JDOetHNwbGFCMbEnrt8GPy2HiXcaLxcva//65OIZKiBq
	 C2P5cn1+tlcTLioHtUKEGVz/r7KfY7fmx+OnX+W2CU8cI5BaUMibP55Z3XY37kQhmZ
	 ENLiItDcfxrmg==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f16c81so2015645e87.2
        for <linux-serial@vger.kernel.org>; Sun, 20 Sep 2026 15:24:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxHXYaDmdIqh1eN5KmATUX1+jRziRkzaivNCOV3L+NqlMIT/TI7lHFRnv82pr9RBBsLaWgAhAg0VZ46aX4=@vger.kernel.org
X-Gm-Message-State: AFuF++lQa5wr44DkL4ZsLkr8UxAsEQlEk4pk+6CxV0JmLB76CsHDPPGW
	kGeMh2UCE45jlJIZ+hAVVax01PC2tVHwNWLxk+LZrazKyif6naNv+FY+OL6oD1wvgmaTOh6pFm8
	EM/P/AiW3kTl6+ez2nkUISh12KElfShw=
X-Received: by 2002:a05:6512:4023:b0:5b6:1a7c:fd96 with SMTP id
 2adb3069b0e04-5b8c197532bmr2591380e87.60.1789943089466; Sun, 20 Sep 2026
 15:24:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-cv75-v5-v7-0-3297d3fbc9c0@ambarella.com> <20260915-cv75-v5-v7-11-3297d3fbc9c0@ambarella.com>
In-Reply-To: <20260915-cv75-v5-v7-11-3297d3fbc9c0@ambarella.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 21 Sep 2026 00:24:34 +0200
X-Gmail-Original-Message-ID: <CAD++jLmbK8AHth2qQ6O-Yh8m4_8uKL1cJdNFqBjnP1ssUe3+Pw@mail.gmail.com>
X-Gm-Features: AcwNN1WFNRVHMkwoIIIv3cjD7Ln9bstVj0LBZyLRdnKTtq0jQLXH6pVRP5eDyRQ
Message-ID: <CAD++jLmbK8AHth2qQ6O-Yh8m4_8uKL1cJdNFqBjnP1ssUe3+Pw@mail.gmail.com>
Subject: Re: [PATCH v7 11/15] gpio: pl061: add Ambarella register-layout variant
To: longzhao@ambarella.com
Cc: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Jerome Brunet <jbrunet@baylibre.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Long Zhao <zl020895@163.com>, 
	Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 1:15=E2=80=AFPM Long Zhao via B4 Relay
<devnull+longzhao.ambarella.com@kernel.org> wrote:

> From: Long Zhao <longzhao@ambarella.com>
>
> Add a 32-bit, 32-line layout with DAT/DIR/IS/IBE/IEV/IE/MIS/IC plus
> MASK and ENABLE. Probe unmasks the bank and enables the controller.
> IRQ type changes also clear the pending bit. This derivative does not
> need write-after-direction or system suspend save/restore.
>
> Match the part with designer AMBA_VENDOR_AMBARELLA (JEP106 identity
> 0x68, bit 7 set) and part number 0x061.
>
> Signed-off-by: Long Zhao <longzhao@ambarella.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
