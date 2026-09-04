Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1025744C66D
	for <linux-serial@vger.kernel.org>; Fri,  4 Sep 2026 22:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788561571; cv=none; b=MwatjYuCKECZ0A1tHNlL/ftsE9mrPJs5wEXhXVw4v+L4G21ybf+kblhRhm4tMnM8eMF2h0j+eWwm8Z1OE4+frftnWnEVkf82/u+LGav5P5MtQjnytDwH8OY+xSLW6NuiVyRwqV3ZCELfhU2XTEDcul1B5VjghyWiErG+3v4sK8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788561571; c=relaxed/simple;
	bh=llV8+t5XVFTw1AVjhesFZp1A/YnFQGo0lCxhv7P61wE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g1SbqXxM9lbuNNWIAaSp3Ov0LjxdLezh855vycvDAzVVsjWyhlaYb+pYEUnJJfVp6ZAcuXT7Vz9LJ6uTDlowRyAh5DpRBmAT7PFCvjLEeXX/mN1PFI418o+t6XBUFkZJ9pPj7AYdMNiizjWxnIHkBHpjgKtkFFKls7Cfdnkinbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmQSKZ88; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmQSKZ88"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD1F1F01564
	for <linux-serial@vger.kernel.org>; Fri,  4 Sep 2026 22:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788561568;
	bh=llV8+t5XVFTw1AVjhesFZp1A/YnFQGo0lCxhv7P61wE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TmQSKZ88V4EGqJifsEp+kZ1YixheuM0ONQhC6ST5IL01g+nhibxZhhf862xYvGKiH
	 zsL6NdJqRE+8cN1+VwhP5RbcocJ2qECR7DnI8Iv+IHuT7vV9bFqiv6IxNyNxc7AnKC
	 jvnCWfirZFg+sfpoGgMmQfw5FMbvxJKL8jrVzg6wCknRaHWEIQW+26xRLPkPp6IIA0
	 1Ij41r0fZpIF5xen12KtRMK1loX6JFhp82ACkNDplK8bRD363CGaVx4pITobwiNhEO
	 UkWhB7Xwkr33bWh7UYYSA9OPrUsRBgpEwUZDefYoz68AWWve8POgu7uDBwiSMOKzcx
	 qryaovYBoxAsg==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b6036e9c70so1222664e87.1
        for <linux-serial@vger.kernel.org>; Fri, 04 Sep 2026 15:39:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzMFBIJbA+3t1/3QNcXaFoVBogFlgfquswpoXZ/NQEn8DPk2efp3MMG91dyIIpo4o+I62S6DSulwC4HNrA=@vger.kernel.org
X-Gm-Message-State: AFuF++mFPvhuAvxY8403ksXAIhsh5x3uFoK/KqAohxsTMLX01aNM2dOs
	j3qWBUfgN/i6aoCr0Lz1tXv25QDM7jJ0C+SIyPSg0xzXMeGVhuku0iAsCH9YdKnL1KiWkFb9WQ8
	u4+fhjzd0cdD5S/MnzpzSI0Y7fSmEv/c=
X-Received: by 2002:a05:6512:6186:b0:5b6:1a7c:3b with SMTP id
 2adb3069b0e04-5b61a7c02e6mr1037141e87.62.1788561566902; Fri, 04 Sep 2026
 15:39:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com> <20260904-cv75-v5-v6-1-e918514cb3b1@ambarella.com>
In-Reply-To: <20260904-cv75-v5-v6-1-e918514cb3b1@ambarella.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 5 Sep 2026 00:39:15 +0200
X-Gmail-Original-Message-ID: <CAD++jLm3KLqaQZFsb2Yu0pERjCfrskL=x3arMtrY3Gq6X4rgZg@mail.gmail.com>
X-Gm-Features: AcwNN1WuNL_yJJgNrKZTtl_t_1Ngwep6ljsejiCgS8bZ3EgANbDs_npxnarBzq8
Message-ID: <CAD++jLm3KLqaQZFsb2Yu0pERjCfrskL=x3arMtrY3Gq6X4rgZg@mail.gmail.com>
Subject: Re: [PATCH v6 01/13] dt-bindings: arm: add Ambarella CV75 platforms
To: longzhao@ambarella.com
Cc: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Long Zhao <zl020895@163.com>, 
	Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 8:39=E2=80=AFAM Long Zhao via B4 Relay
<devnull+longzhao.ambarella.com@kernel.org> wrote:

> From: Long Zhao <longzhao@ambarella.com>
>
> Add the Ambarella vendor prefix and CV75 EVK board compatible for the
> initial SoC bring-up.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Long Zhao <longzhao@ambarella.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
