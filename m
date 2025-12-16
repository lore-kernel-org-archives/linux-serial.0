Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469963148B3
	for <linux-serial@vger.kernel.org>; Tue, 16 Dec 2025 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765895618; cv=none; b=puCQnRDyDwYxbqxdayT2AdEF5YHSrV1rZHzn+o5+/iXAyE1+zKCELRzkN7ZzIYTJVppWwaUjOPptph+SqdbqvH9I888TKUWjJapaGJNgAQU1MYldx4lhvCAtbLJyzbL1Yaa+cJWXyNiRfAJfblpZa4rGCHKZVTrOgE9LA8ZFOb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765895618; c=relaxed/simple;
	bh=QvQ962qcK05T0lZnvQI2FDYuFJBixe8oMpEBfbroE10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gNQLGgEVvjz5W/YyHeUgHfLVZjLi+6wd6VyyT/mxh2INKQpEZ1G2RjWQyciqYMX0rww8e1aGR0QjfljmkujE0/mntRApGHHuc9rW2odLKUNhiwBt+1VZIlAl0mqiU6Bu/jaQYRC2BJV4Npooyo1I/L33E6JKFS0ECoTVpgATl+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=kgTTFIhu; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="kgTTFIhu"
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 968213F66E
	for <linux-serial@vger.kernel.org>; Tue, 16 Dec 2025 14:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1765895613;
	bh=9ouNQ2G+BbmqznnUeDUFFC3dk1Z2drfKLGm7ohEM5u0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=kgTTFIhuR/Znn8WpH4EU4siI1iD0tDHemwOpGuc/yC96Al+9ZN6yN1ejIkdThN4rZ
	 1Tpc0ousCioQvjjaqCijxSg+XYITKJBSmz7lj86iyJPtx8wSMwPo1o9G36qRBA5XvJ
	 KhtUC7ZeYtpjXvkpl6SpnyVEHOaaedsxA/qBLJB5PWvauGmvt3W7jY1XBgbSVnjy1V
	 x2FGrFOA+ZkGzNdWp/EIbGFCQg+zkWAVWBEzNNl2e/e7cg79NIQIY96o5bIilpGMbS
	 DCyf7PquGh7syzWkib6rG4aFuNjL/GCgtS87Ii5KtJo44mjZHUgNONhZNimUyWZ/NY
	 pnPOKklJ4iJNKDQW5dofABENaO2xyHTVIoSqKXcCTikFzx7HiOzlh+MvBdPNWFP7rb
	 1bB2uOOLr3PxDT4G+3fs7GfoCsg5NdHPNCxlhMtmNF46hcLE4+tLhLkceHzohDIwuA
	 cyS0yIoUWm2gcF81uDZhCpkS9m9WaAIv0DWyY+vwXJL0sobYgoDpzQ80F5GQLUooG0
	 pGy+EBZiRINK59g0hUYyywYlggG7/nVYx80YxyF0/Mky9mHaVSgSGdlgqzW0kii66p
	 /wJBcNIs9HHF3VV6yxBMwQcrcBOLMwWMm3mAmXfgERxNz9Q0z5jIv7GX6BqWMGGEus
	 4359VUcgIux3OvNXqoZ8jSeM=
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b7ce2f26824so573166966b.1
        for <linux-serial@vger.kernel.org>; Tue, 16 Dec 2025 06:33:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765895613; x=1766500413;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ouNQ2G+BbmqznnUeDUFFC3dk1Z2drfKLGm7ohEM5u0=;
        b=MwUKPo2R1TbdAZpAErxMRiJ1/G6X/mFe3W2TzycWLZyaI7zs4BVpn+97Y2gmhWnI59
         kOB6zFIclcrYf2GjdR1TrVeitIGP7wu3NA3Ym54UZeKJxPa5bmkKR330qNpoJa4gdvKB
         AwEfYxvXd+fIN8E1HkOFYNwUgoS1hWBp7NiBx12urSRhZi3HcjzPy5agfbs/EDEjwXsh
         9SP7DTBSc+Vql1zvQVnIYnWwaXq9yPvbQiqGvdX9RGgtoUtqKVQ0R4Ps4dv6bQr4E1ry
         yCLZXPO5D7Ua8lKZyXFbWYDCIyMzuSicApVd0ZkLicVtq5oIWPS552GmnQCDeLoVjurb
         IW4A==
X-Forwarded-Encrypted: i=1; AJvYcCX1v1KuIOJ++cbvIEBU2Fbmhjxj6yQtkgg/pc7hjNEARx4uwwmepg6X5K3vTRnVamI/5SaWhrkYDygVj3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv0lN4ET5ybHP8qu5ueWXkugJlXkKGn1RGS2cmnzqguyFsReOF
	McR882ODlBB3jGXWARSV5AW/GrxnYp0d6Q6QqfF9K9Swps340JgPjc6VSUZtyLsbr6NO8VuHHcq
	87nrH+bzN2VuSVEk2iUBRlRHnCOGje0RRM0g5IKLhH73pOjV8uW9T47GqNf7sbSKdKIU2Ohg3vQ
	OW7inSgA==
X-Gm-Gg: AY/fxX7Ly2dmr2xD/Ds6BzQmR6GTu+WzwkO60JVDwafaAnOcJurrp97bPgi4lmoj0cQ
	eb3oNvwSqW+OKTEq+7EYUSm6FyV89aybqSOuQCaavtHH7X4kxKk4LdMwoM4/FhMfboGMwN3xIHg
	c1gvR9rUz0aN6qdbfTdwxVdJJP+jdydSEkYoj6CzNj+RQH44A87e1V9k1j/U/vPbI5Ke/hhQKKh
	le3yqFECVp5SSvU5FipDjzbdHebXx8KDryjF9NLvubHgY9rGt1HauZU4tjwgOlHLSucD+Y9vp31
	yfjWyB5YrwGH/l7p52yG+WFYtjYDJbi6aOGudn8LGp7onnQ5iPr37gOLm9pp5rEEpQlKDR5Sdov
	l9jkb6zz4t4A6rNZAWkgzP9mWeXqLCEEHJpKTtwF1vYTYe86TWSBg8yZqwYikHSe+qkpNcUzcR1
	PkVZX8pWA=
X-Received: by 2002:a17:907:96a6:b0:b7c:fe7c:e380 with SMTP id a640c23a62f3a-b7d236f7860mr1528081166b.13.1765895613035;
        Tue, 16 Dec 2025 06:33:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHFzNsGwKARkXS4ZtDItuBhnrQn1fUzZeAB6AToGes9YgJGJs29bqvEiQXmenKj6k0dHe4vw==
X-Received: by 2002:a17:907:96a6:b0:b7c:fe7c:e380 with SMTP id a640c23a62f3a-b7d236f7860mr1528076966b.13.1765895612514;
        Tue, 16 Dec 2025 06:33:32 -0800 (PST)
Received: from [192.168.103.125] (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7ff725efd8sm171981166b.27.2025.12.16.06.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 06:33:32 -0800 (PST)
Message-ID: <3c38ce9c-4259-4149-bf2c-a54e74c00a34@canonical.com>
Date: Tue, 16 Dec 2025 15:33:30 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] riscv: dts: spacemit: add SpacemiT K3 Pico-ITX board
 device tree
To: Guodong Xu <guodong@riscstar.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, spacemit@lists.linux.dev,
 linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Samuel Holland <samuel.holland@sifive.com>, Anup Patel
 <anup@brainfault.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
 Yangyu Chen <cyy@cyyself.name>
References: <20251216-k3-basic-dt-v1-0-a0d256c9dc92@riscstar.com>
 <20251216-k3-basic-dt-v1-8-a0d256c9dc92@riscstar.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20251216-k3-basic-dt-v1-8-a0d256c9dc92@riscstar.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/16/25 14:32, Guodong Xu wrote:
> K3 Pico-ITX is a 2.5-inch single-board computer equipted with a SpacemiT
> K3 SoC.
> 
> This minimal device tree enables booting into a serial console with UART
> output.
> 
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> ---
>   arch/riscv/boot/dts/spacemit/Makefile        |  1 +
>   arch/riscv/boot/dts/spacemit/k3-pico-itx.dts | 25 +++++++++++++++++++++++++
>   2 files changed, 26 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/Makefile b/arch/riscv/boot/dts/spacemit/Makefile
> index 95889e7269d1bae679b28cd053e1b0a23ae6de68..7e2b877025718113a0e31917eadf7562f488d825 100644
> --- a/arch/riscv/boot/dts/spacemit/Makefile
> +++ b/arch/riscv/boot/dts/spacemit/Makefile
> @@ -4,3 +4,4 @@ dtb-$(CONFIG_ARCH_SPACEMIT) += k1-milkv-jupiter.dtb
>   dtb-$(CONFIG_ARCH_SPACEMIT) += k1-musepi-pro.dtb
>   dtb-$(CONFIG_ARCH_SPACEMIT) += k1-orangepi-r2s.dtb
>   dtb-$(CONFIG_ARCH_SPACEMIT) += k1-orangepi-rv2.dtb
> +dtb-$(CONFIG_ARCH_SPACEMIT) += k3-pico-itx.dtb
> diff --git a/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
> new file mode 100644
> index 0000000000000000000000000000000000000000..0f9d04dd352f5331e82599285113b86af5b09ebe
> --- /dev/null
> +++ b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (c) 2025 SpacemiT (Hangzhou) Technology Co. Ltd
> + * Copyright (c) 2025 Guodong Xu <guodong@riscstar.com>
> + */
> +
> +#include "k3.dtsi"
> +
> +/ {
> +	model = "SpacemiT K3 Pico-ITX";
> +	compatible = "spacemit,k3-pico-itx", "spacemit,k3";
> +
> +	chosen {
> +		stdout-path = "serial0";
> +	};
> +
> +	memory@100200000 {
> +		device_type = "memory";
> +		reg = <0x1 0x00200000 0x3 0xffe00000>;

Shouldn't the reserved memory be described as no-map /reserved-memory 
nodes instead?

I would assume that 0x1,0000,0000 is the location of OpenSBI.
What is at 0x3,ffe0,0000?

Best regards

Heinrich

> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> 

