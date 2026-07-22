Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AD72ECE86
	for <linux-serial@vger.kernel.org>; Wed, 22 Jul 2026 23:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784764687; cv=none; b=VEB69n4a8hIZ7cVturfD9lePch05m9fkBRQ0hfzw1+pO2Z9rJ8fb5s6zrU4JK4X3iNL3tbLVhb5iNkHzEFyrvLtirxZFkNYU7RJ89wyGeKsamVVNtI3sSxSTRtgb9UiGZkaHLOOZSOwCOuj6Ykipq6I7D/N0z1iG6GjQykHxe90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784764687; c=relaxed/simple;
	bh=35drW2DGwE6r9AD1bRPA9cvY3KZK2JVIMd9EV0LS8ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQf1uAZP6lQTe7gOR/D1j+8WqWU0cjYH3ACVrSGE/KoCaMs5gfnj2PvRCG/AGd+HkFa3DV4YfaWCrEgV/9TDOA8Aa5k7qB5JS9PCSCMZ8+HuGJksH1X/4k14yott+2OeIjnd3PaLvmINzuBbXj34S0k4kWGgJFSfCGKc4yClf4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fGn9lESZ; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fGn9lESZ"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cbb85186d43so40850a12.3
        for <linux-serial@vger.kernel.org>; Wed, 22 Jul 2026 16:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784764685; x=1785369485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fvcmYZzoXJ2+AFhLmq8yWDeYXcFpMi5b7436MW8Ch78=;
        b=fGn9lESZxZ1dgvDiQX7LFBPYYyT96CDX8eZ+GajVybtvs8PqGfhlW91ggKfXXoZZpg
         m5eGpjvyHGGYUB8lN3LRbFAfd67GbegJIgqMRnl8n5fg8KlZSqPoRHCKSDQI2f7smhbd
         y4WAhELjfbYcAc7na1qcMv9LcU7V/NjOp/3r0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784764685; x=1785369485;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fvcmYZzoXJ2+AFhLmq8yWDeYXcFpMi5b7436MW8Ch78=;
        b=P9g2r/tOlaZsM/VrKeqda22uscSLwN7C6DAiuK/BPnlzHyQS2SLTHOQSrojFJKO3Nh
         EhZpWnHFPkAqh/sKcGFlBmSamrCfwtmXTPg4dDvHEYP5x6KSPbRP2y5vGSRpl2ERw/aA
         1WAMdwkNdJtLcMTjYXSYDLw7Q2fTkbPuk9JHyS3iyYVbanQ/OQiUT5O9iWnzRnT2bpM9
         Zal47+Rv7cFU3vKHkKud9rJNMix/5axb/lUIEUq2VspMrlHsfAwdh5xEbQd1+ZQM2uao
         ae2AWy7B8/0WI1jyJWZmyHhXiwcUHeO3boTbKrmWU5C1hlxXfRZcWwoe6e79wAkBiJaO
         HaKQ==
X-Forwarded-Encrypted: i=1; AHgh+RpgZk7oNe8nqjUzJHnnJyMpivzJGw+rsAsGEpCcxtrmWY3cGERWmCPattVl5BrlXlqWijv5Cn7YDezRIYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU3cak/+c9N+Ox/JrbMn3LfMjtw3QSo1sSOL6kOVqdMVSvNzv7
	fNK0OIapmdxiKoO7GPK2h4oGlqgiOdJHs/Thp8J8eGxmS01WrhTA0e6h9c9uQpA37A==
X-Gm-Gg: AR+sD11xSrGzCdWjFp8LKkDjurfw7wUtOcNpAR+M9opWe6jAiIPa8ZqVYKPBVp7ItMy
	4EasBHi8hVmQnde/fZNNSwXgNpSshpqDEe4aR8fxgWdcfr3RgddQmEO92yZ1UMcPirRR+a+3OaQ
	lJE3ze9qjwWyDMzwZzs9sr7EcYNXD5u5Ko8bN8ESiEIw/2bu8LhHnGdxUfDC6pLKe66/AqQPTq1
	6oy5D3NGNWOtPKRYKw1EVHgRWarFWKck2Ry0dR3wq49oiWmJDj31+AwUEoXKnKaiz/Xz1m/ORXt
	i2jLOmABDS8MRU6xnisH9zN66s/VDdYhRiFw/rbxxSVXqkZgiYDNW/HCju6YGffrVMZS9G+GEzw
	E19FvyhsP8r4q0WuRNC0BXxFOKyHqyQLyA0bVTM6JAPtL7YQ69/p5Apwr9/0gxyiWeTV/3L6enC
	IWj7mnQ7dIc7OH/EwdeLRP7+C/cuAiVWPBbqDATKWN
X-Received: by 2002:a05:6a21:e8c:b0:3a2:7ef4:81df with SMTP id adf61e73a8af0-3c44affc928mr723987637.26.1784764685561;
        Wed, 22 Jul 2026 16:58:05 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:f3fd:a899:78ad:64d4])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-3147df09a9dsm12945475eec.19.2026.07.22.16.58.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 16:58:04 -0700 (PDT)
Date: Wed, 22 Jul 2026 16:58:02 -0700
From: Brian Norris <briannorris@chromium.org>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Linus Walleij <linusw@kernel.org>,
	Drew Fustini <fustini@kernel.org>, Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
	soc@lists.linux.dev, Douglas Anderson <dianders@chromium.org>,
	Juan Yescas <jyescas@google.com>, RD Babiera <rdbabiera@google.com>,
	William McVicker <willmcvicker@google.com>, kernel-team@android.com
Subject: Re: [PATCH v2 0/5] Add Laguna/Tensor G5 SoC and Frankel, Blazer &
 Mustang boards
Message-ID: <amFZCkt1EXtOjOYW@google.com>
References: <20260722-contrib-pg-pixel10-initial-dts-v2-0-3abae9717feb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722-contrib-pg-pixel10-initial-dts-v2-0-3abae9717feb@linaro.org>

On Wed, Jul 22, 2026 at 10:55:51AM +0100, Peter Griffin wrote:
> Hi folks,
> 
> This series adds initial basic support for Laguna (Tensor G5 SoC)
> found in Frankel (Pixel 10), Blazer (Pixel 10 Pro) and Mustang (Pixel
> 10 Pro XL) phones.

...

>       arm64: defconfig: enable Tensor G5 SoC family

I'm not able to apply this one cleanly in my tree, although resolving
the context conflict is trivial.

> 
>  Documentation/devicetree/bindings/arm/google.yaml  |  48 ++-
>  .../bindings/serial/snps-dw-apb-uart.yaml          |   1 +
>  MAINTAINERS                                        |   1 +
>  arch/arm64/Kconfig.platforms                       |   8 +
>  arch/arm64/boot/dts/Makefile                       |   1 +
>  arch/arm64/boot/dts/google/Makefile                |   6 +
>  arch/arm64/boot/dts/google/lga-blazer.dts          |  15 +
>  arch/arm64/boot/dts/google/lga-frankel.dts         |  16 +
>  arch/arm64/boot/dts/google/lga-mustang.dts         |  15 +
>  arch/arm64/boot/dts/google/lga-pixel-common.dtsi   |  23 ++
>  arch/arm64/boot/dts/google/lga.dtsi                | 423 +++++++++++++++++++++
>  arch/arm64/configs/defconfig                       |   1 +
>  12 files changed, 539 insertions(+), 19 deletions(-)
> ---
> base-commit: 17c7841d09ee7d33557fd075562d9289b6018c90

I don't find this base commit in Linus's tree. I only found it in
linux-next after fetching this hash directly -- it's a linux-next tag
from 20260507? Seems like an odd old choice. Might be worth refreshing
your base.

Apart from that and a small note on patch 4, it works for me:

Tested-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Brian Norris <briannorris@chromium.org>

Thanks!

> change-id: 20260710-contrib-pg-pixel10-initial-dts-49f5ec657b66
> 
> Best regards,
> -- 
> Peter Griffin <peter.griffin@linaro.org>
> 
