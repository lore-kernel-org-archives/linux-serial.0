Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB5647208B
	for <linux-serial@vger.kernel.org>; Mon, 21 Sep 2026 10:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986710; cv=none; b=MqIr9dNGBAyUiQ5YQWaYHI3qu69cH89tSZWpUNgbxvC9UQ3sOLr5Yk2Uc9ORRu/5wzo88wb4ZhvxrfykmW3W4Ou+b61vyhtywSMDacDjjK9ZS6BAdj/3JJXP9JncSscNZcgHQla3U5dd057kVHWP+wzbNKGXeMtp1YHskFRugy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986710; c=relaxed/simple;
	bh=wlyZp0Y8DtkcpxZgedsAGdv5R+a3YrLHF+oXTMTBElQ=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/VxvLB4Fy4/iM+ztMHhaH7Y8Gki1WV++4s9wkJWJamdeRMo4jhDb/Ttsc6zrAcIFP6zolfTITf+p6yzqPAo4p+2beS5kOnrC5OaHRD+lOC4cJ+EpcZ9kUXmZfZjt78+LKjUShi0c5mMhkdXK6Zk5vD0Uv28kKKtEDNMe8Y9+BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPU9tO8H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPU9tO8H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3781F00899
	for <linux-serial@vger.kernel.org>; Mon, 21 Sep 2026 10:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789986708;
	bh=wlyZp0Y8DtkcpxZgedsAGdv5R+a3YrLHF+oXTMTBElQ=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=VPU9tO8HyjXQg9hPxqUgoZx3O6CP8/01/4vHCoV9a260fK4Edl4qoUs+qxH+0w9mU
	 /5PbomemBtITMx8M4jPCzMgYYqXJj29ejgQxRuZ7nfDXRhpvSCnfAfq0PzVuwTrsSp
	 zXUnpRfk0O7lMWJs/JP+bvv+OxbUdcmSMVhRYtRNjZ/sYH00R643AQ46wExjKB8MVI
	 W+OaB1cE9LYQ94n+pR3PBMMrsDzAAic54alptXlheNRDRm6xKvkbXgplTsQR7wCyIs
	 DRqjS7+wMN3k2cvyOY5A49srIrlgWXZUGdYkRX2KSEmgR8Mpx84plERTRO3wh5SgAJ
	 5V5AHaHTG1cww==
Received: by mail-lr2-f33.google.com with SMTP id 38308e7fff4ca-3a2ff16c0e6so19216501fa.0
        for <linux-serial@vger.kernel.org>; Mon, 21 Sep 2026 03:31:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByLasG1ViwsxpiJriP7hdIb642bsXgXeMKnBkiA3zq/h6XmwBOzYmygjeuLGyBiHIYQqp5kQM5sjQAZslI=@vger.kernel.org
X-Gm-Message-State: AFuF++md0RUf/O6z++lwy8adSX3YSA3xYYbm8hgp/weACeUsUCJFkWAy
	oFYMKGk7kopoGJMxewftFN++CpUVjwdkES2TM7iKdvm8AXdGgM7hPoIKhIqNwgo9Gknii35f5lY
	9LpiS6sxSlVq+4po+8cr0kMsTVt/O6gydm9iIhGaLgw==
X-Received: by 2002:a2e:be8a:0:b0:3a3:74b7:fc0e with SMTP id
 38308e7fff4ca-3a5fc03636emr22688931fa.26.1789986706801; Mon, 21 Sep 2026
 03:31:46 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Sep 2026 06:31:45 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Sep 2026 06:31:45 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260921-cv75-v5-v8-0-282ff5d98dda@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-cv75-v5-v8-0-282ff5d98dda@ambarella.com>
Date: Mon, 21 Sep 2026 06:31:45 -0400
X-Gmail-Original-Message-ID: <CAMRc=Mf-0oLOPZsPboE0dzOGE2AzNE0LXmv9fcmgWO47FtGu1g@mail.gmail.com>
X-Gm-Features: AcwNN1UZiDNcMAJ4MNmlX-UMIL58DwmKhOHQm7KWs4DW0jTpzuluxkWRRETFZSo
Message-ID: <CAMRc=Mf-0oLOPZsPboE0dzOGE2AzNE0LXmv9fcmgWO47FtGu1g@mail.gmail.com>
Subject: Re: [PATCH v8 00/18] Ambarella CV75 SoC minimal bring-up
To: longzhao@ambarella.com
Cc: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Jerome Brunet <jbrunet@baylibre.com>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Long Zhao <zl020895@163.com>, 
	Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Sep 2026 06:23:19 +0200, Long Zhao via B4 Relay
<devnull+longzhao.ambarella.com@kernel.org> said:
> This series adds minimal Ambarella CV75 support for early bring-up with
> a serial console: DT bindings, RCT clocks, pinctrl, PL061 GPIO via
> gpio-regmap, 8250_dw UART quirks, ARCH_AMBARELLA, CV75 EVK DT, and
> MAINTAINERS.
>
> This is a single unified series. Please apply via the SoC
> tree; subsystem maintainers are Cc'd for their pieces.
>

As I said before: this brings in a lot of potentially conflicting code into
drivers/gpio/ so I'll need an immutable branch to pull or I can queue the GPIO
part myself and provide an immutable branch to other trees.

Bartosz
