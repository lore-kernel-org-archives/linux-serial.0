Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5197B3F104F
	for <linux-serial@vger.kernel.org>; Thu,  1 Oct 2026 07:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790838252; cv=none; b=m179SfdVp7uwzMwsXxcV+ElZUCSJ8rOg7UFo/BbLm1JVDhaCwZ07F4YRAOh8znN10vCmF4Z6Oo0zpRIPmrqT0L0oXan1YnyI6Z6mAIbrAY2aAiwPk/mghSaUwYIx8uUZIAyEb/zIX8IQItRzb7goKV3Bj9KRuV4afniu2PJIFZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790838252; c=relaxed/simple;
	bh=wEN0e2H7/40ktw6SZv37khLK/vSI6EBRPCqKAg34jhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lwxW1Co8v5bQK3NG/SVnDHiJtJHZ/pEYhWTnGLsGufkg0xZHf1FYygk6cx7dPOQLvNUjnVdKbNu1DClm4sfGVUOoyg6UPuxc+B2+XWY3XKz3pPMJZQRvSeM2UccKF1BiA2DWNH7qYpB+5OxzgcaYndvpN8eOXNWhCWQ+g3NhBok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rag2NIga; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rag2NIga"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDED1F008BD
	for <linux-serial@vger.kernel.org>; Thu,  1 Oct 2026 07:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790838249;
	bh=wEN0e2H7/40ktw6SZv37khLK/vSI6EBRPCqKAg34jhs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Rag2NIgaLGE5+zLXWRj+vMIiBBSCcqDN/WT8xmBZ9nHFiVEs2z/YtTzC5yHrY0tG1
	 kNoVSCdt3xMdbcLIM3FYTafcIdDEixFTew1wrZgus+9IkwmEgFk5jey7/R8nW6G4y1
	 NyvcQe0/5Wkmn+m/57rSuvmFQ9F2ouJO1Z9L5nH66BHM+uS0MDtzLCizg0VTyeRcUl
	 UyPtU9ZqSXRQzl9yaoOBAn3EU8htUUsEKKD0gtfB5Zg4zin84yQto7shhfcqEx50ZH
	 Zz3TxgUxZM/Zpn5Sy8Hh/qCR0fuURqeLKbQ7zIphL3aS3cTuAreeImFLlOE4fFOVVC
	 XlFnieB76IgqA==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5ba43157c71so736824e87.3
        for <linux-serial@vger.kernel.org>; Thu, 01 Oct 2026 00:04:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwKDD6RKpdrSNaQwuNR7fPbGqtLiSPJBzSnrOQQX1QvOU0AFlKq8mlePXP9JJUdhIhTQw2fz0vGiecYQgI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLwApc2NAZPr6fmS4ChjDE112AAGx6EiBBDct2LloG8FaHBgcXU
	z6jmRj3gosRLm8x9+RnRHavvWEX6d6Pq6bozQZg2UOse5nbhilKqI7IyXTKSKO87D9pSapYuvgq
	UbYQe6F6sTRwN7cj8nAbauB+c89ZgzIE=
X-Received: by 2002:a05:6512:715:b0:5b8:edeb:5c27 with SMTP id
 2adb3069b0e04-5ba405ea48emr1230973e87.10.1790838248433; Thu, 01 Oct 2026
 00:04:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-cv75-v5-v8-0-282ff5d98dda@ambarella.com> <20260921-cv75-v5-v8-4-282ff5d98dda@ambarella.com>
In-Reply-To: <20260921-cv75-v5-v8-4-282ff5d98dda@ambarella.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 1 Oct 2026 09:03:53 +0200
X-Gmail-Original-Message-ID: <CAD++jLmKF5XxHsJX29sdXC_6JHKn-7HkE=N+TKtk5xODtQj3_w@mail.gmail.com>
X-Gm-Features: AclHuK8S_q-U5PRteYICZ8VGfGhkOd-OtdrQpaJ2DynuPN4AlXp-gJ1LMPWAi-g
Message-ID: <CAD++jLmKF5XxHsJX29sdXC_6JHKn-7HkE=N+TKtk5xODtQj3_w@mail.gmail.com>
Subject: Re: [PATCH v8 04/18] dt-bindings: pinctrl: add Ambarella CV75 pinctrl
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
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 6:23=E2=80=AFAM Long Zhao via B4 Relay
<devnull+longzhao.ambarella.com@kernel.org> wrote:

> From: Long Zhao <longzhao@ambarella.com>
>
> Document the CV75 pin controller binding using generic function and
> groups properties for pinmux configuration.
>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Long Zhao <longzhao@ambarella.com>

This patch 4/18 applied to the pinctrl tree.

Yours,
Linus Walleij
