Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4291241F5F3;
	Fri,  4 Sep 2026 06:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788505028; cv=none; b=Kx+3TFy0r/Ak98gdPTg5UX1Dc2IlalPYSaP7SDUM7D5f+Bhahsd8Mo5lM4lb9BYVAZ9g2qzuuc2+BgBdiELJSd4sUa9TzouPEOKX5sVKXi9XR71PPLrveTcpBbEDpdr/bGj/FHpBJ8KwWLSau9ZEjn+RiSpv3BMmeFLNJ4H1+JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788505028; c=relaxed/simple;
	bh=1OXbOTVOgbzSk6WqVSDI7tsvaTpT7OEITmfX/7JbiU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TWF7ha7n5E8mW9hDMICP+5B8Aqb56g94HE+eMvO/Q5Q5CJXgSSMdyp4qS6WDsTvgLRIImHDEs49lbhs0Q1oll6/ZFIP9H2zFg0YvTnO2kGt6YDPQLJ6VzbEWJkoILbrFhCPyUv/PI+N3/68jS+dY/uOwyY05POmx5eEIfmLtILY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjNoU2Jw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjNoU2Jw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422A11F00A3D;
	Fri,  4 Sep 2026 06:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788505027;
	bh=/sOczCSoHOlT5c06wsTlPTIte1oRtUDVyQl+NgtAFt8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TjNoU2JwL8y2+0F62yHdqpIyzm5bhJm64/7EhYO2sohFwqbUFPq9Xo8QrSKicnLcF
	 jDppBHEU61TwAFaCOm7qQpmTlNgHqsUvKfoGZEvYnTLUomZxDFPf7s95yc5B+KrLOl
	 n+IP+rdMc6btudxyRnionbpVBjHmCLBILGCYXKrOkvDXMmeBtSnu/sExfpLib2Gqh5
	 BnHpF+17yHfKcv1Cqz4pqYf/riICFKnR8RSBRn1FJII8wJYN/jIhVictNURZ/a/oaU
	 GMqzBn6NS/CG0HFcKcjDjh278k6FPD9lxmrL7g+KL/GdA9cwvae/PwdIgd5l58qSdU
	 HGJEvy5+QHNEQ==
Message-ID: <46d21889-6b52-4c09-8f77-7c08dba93777@kernel.org>
Date: Fri, 4 Sep 2026 08:56:53 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/13] Ambarella CV75 SoC minimal bring-up
To: Jerome Brunet <jbrunet@baylibre.com>,
 Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Cc: Long Zhao <longzhao@ambarella.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Long Zhao <zl020895@163.com>, Lee Jones <lee@kernel.org>,
 mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
 <1jwlt1ld6c.fsf@starbuckisacylon.baylibre.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <1jwlt1ld6c.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/09/2026 08:54, Jerome Brunet wrote:
> On ven. 04 sept. 2026 at 14:38, Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org> wrote:
>>
>>  .../devicetree/bindings/arm/ambarella.yaml         |  24 +
>>  .../bindings/clock/ambarella,cv75-rct.yaml         |  64 ++
>>  .../devicetree/bindings/gpio/pl061-gpio.yaml       |  32 +-
>>  Documentation/devicetree/bindings/mfd/syscon.yaml  |   1 +
>>  .../bindings/pinctrl/ambarella,cv75-pinctrl.yaml   | 239 +++++++
>>  .../bindings/serial/snps-dw-apb-uart.yaml          |   1 +
>>  .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
>>  MAINTAINERS                                        |  14 +
>>  arch/arm64/Kconfig.platforms                       |   6 +
>>  arch/arm64/boot/dts/Makefile                       |   1 +
>>  arch/arm64/boot/dts/ambarella/Makefile             |   3 +
>>  arch/arm64/boot/dts/ambarella/cv75-evk.dts         |  30 +
>>  arch/arm64/boot/dts/ambarella/cv75.dtsi            | 177 +++++
>>  arch/arm64/configs/defconfig                       |   1 +
>>  drivers/clk/Kconfig                                |   1 +
>>  drivers/clk/Makefile                               |   1 +
>>  drivers/clk/ambarella/Kconfig                      |  13 +
>>  drivers/clk/ambarella/Makefile                     |   6 +
>>  drivers/clk/ambarella/ccu-cv75.c                   | 296 ++++++++
>>  drivers/clk/ambarella/ccu_common.c                 |  60 ++
>>  drivers/clk/ambarella/ccu_common.h                 |  25 +
>>  drivers/clk/ambarella/ccu_mux_div.c                | 234 +++++++
>>  drivers/clk/ambarella/ccu_mux_div.h                |  35 +
>>  drivers/clk/ambarella/ccu_pll.c                    | 421 ++++++++++++
>>  drivers/clk/ambarella/ccu_pll.h                    |  70 ++
>>  drivers/gpio/Kconfig                               |   2 +
>>  drivers/gpio/gpio-pl061.c                          | 342 +++++----
>>  drivers/gpio/gpio-regmap.c                         |  24 +-
>>  drivers/pinctrl/Kconfig                            |  15 +
>>  drivers/pinctrl/Makefile                           |   2 +
>>  drivers/pinctrl/pinctrl-ambarella-cv75.c           | 561 +++++++++++++++
>>  drivers/pinctrl/pinctrl-ambarella.c                | 761 +++++++++++++++++++++
>>  drivers/pinctrl/pinctrl-ambarella.h                |  50 ++
>>  drivers/tty/serial/8250/8250_dw.c                  |  34 +
>>  include/dt-bindings/clock/ambarella,cv75-rct.h     |  15 +
>>  include/linux/amba/bus.h                           |   1 +
>>  include/linux/gpio/regmap.h                        |  13 +
>>  37 files changed, 3439 insertions(+), 138 deletions(-)
> 
> That is a lot of stuff mixed into a single series that could easily split

Well, not easily, because each split patchset would rely on non-existing
CONFIG which could trigger warnings.

Contributors follow here the correct and documented process of new SoC
platform, I don't get why now only this patchset has to be split...


Best regards,
Krzysztof
