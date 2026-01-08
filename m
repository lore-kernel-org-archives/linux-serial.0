Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0DE30FC10
	for <linux-serial@vger.kernel.org>; Thu,  8 Jan 2026 18:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767896402; cv=none; b=qhwWgyq/erSZrcQ8AM9R4o65h4Xqzw9IKccSiel7l+jdvkcDzuqAt5iB2IBxv/BRerEC+syIJMy+xqlx1QPwdGYLGH1CfT+ydOWkSy73voEk/hwEoPltt26AkSIofi535VFuwoz2qZ0XL21NcysJcBW6b6P/5oLplJssONVO/ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767896402; c=relaxed/simple;
	bh=kENMl9cHYpFg5tlCTn7MwoBrfZVZFFqg7J7R9sd/27o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GGgQH8pWtFCxMhlxaQYUu/PU8/FmftSHOK70W3o+Zbax4IxdOlut19KxsGK6B/mK8cY54g27arSxwFbeNFiKm8Q6PPEQ0ZujVf3LJjaRpK8L4IQsc98KSV5rSkLskBMijQMbviwrDGnrp4oDCii+9Z3+zlnek3iRD1zbr3SbLIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=YsCWkTYF; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YsCWkTYF"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-450be85b7d9so2244188b6e.0
        for <linux-serial@vger.kernel.org>; Thu, 08 Jan 2026 10:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1767896399; x=1768501199; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ohc2giVuVn3JULq4s35HjI1BOKvAGS8MZPmPZF1eTvM=;
        b=YsCWkTYFBf9/aCLQWbMt9Spv9n/prPSzRG1xyK6y7FPy0Czm5vypPMnq1X4bqLdD4v
         4aE0UcroXSXzO47rmWkYx0BzsS8oEX9jJgRCv2sGlSKQcZek13aVTJrUl3hjQ58TpVH6
         hiiWb0IiumIoXW5dWRZ2iPeMR8UPSiFp9znw3yi+zE8rqHkhyaBo2uIOVKCm4Wr8ehz5
         cP7lceHgjPHCei1p7lHIkB1RWBAGso7r2PTucbBqMwciLviQr9Xoz6mIubq6TlJwHvuK
         9HPaECD3yAsZJN4rMlNNb5bjbgBvBXG7Y6k+l8x93wNhl9vc4snV4Yg5d/KH7mx6yg8j
         Uyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767896399; x=1768501199;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ohc2giVuVn3JULq4s35HjI1BOKvAGS8MZPmPZF1eTvM=;
        b=t3v4rohsNNYWpZiGsGiOoBOgIt/9L/PLPA4h/soVzYn2LFKvBt8F21IRy0HFFAXdQG
         bhYzjnMzl5lx1d+wz9znx3p6dkbq36la6VW38jwzJ13g55FEEmZxqHZ5Y4nA5XOHWFH7
         6s987aoEI1dF7tf2dCM/O/JcimcdFR3AsEyYi9bJj9rHvFhyRkmHEuQYPf5Auz+xs0Wo
         ClSzbY1xB/msa+i9MgkuYsib8sIeo4Z5AhC9MPTFDeuZF+pf7da00lZgtbiUI2VYREug
         jYEPjZ6moQyQi1IgY9rSGCFN/dtkRDhsjpmzTe+pCJY5vm6JwRUJkB73/RgyQO7IPFHO
         YG6A==
X-Forwarded-Encrypted: i=1; AJvYcCWi0edJ4EF8FeU4+iXj0fZQTZ9Eri80392owL/ltPJnAnmziTjVnDvITqJITfLCA0G6OuX6q0rd0MQszDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvdE/rNmhdHPZPtCsFxDlKwojMoh1zXEr+2Kg0qkJftsekTqb/
	IFHJpICOENdgYbssCwXxrgqWw7TUOi+3y+lBsRla8FkqHgSDEIUlV2Pb9UpOsGVwqS4=
X-Gm-Gg: AY/fxX6fZKhkcc3AMlYaZWqQn1dhHjYRojbvpj5AfZ4cPbMFw9KsB6dmvXkANM5iNrP
	MfHBFApU14HZsi5UVgqUoJzGdF59SOxVLWcoXryMiX6MycL6JxCU7eyNoiS07ptYoP0dkK7BBni
	njT6H2Pq3E+7r/5j23hAf884VXa9RQ+NL5Pj5JsqG2twMMh5HyG5Tpsdxclwh8IipzfEGlrQAr4
	14f8qvksaXNwGPKx9uB5rBXQhbPd4QBfA8wkNN3E3dfBVSp9hwHbBjU/smmUdFwSYD+RikRR6+D
	K3HGLMvfMxvW4FaLaD9138WAJYUKqSwK8KSlKWwIiz1MKPg2L02pdi4axbnGAipGX/QtQE7yC1F
	kmnGPVO09oYE0nZ+u9jJAVjojPtowAUOE0NyOdw8xRlCXDXnSD+NaSfCSn2HO/OTgG/yi9Lqd57
	qvdRc7AJ6BKf28viOl4oW6Jn9TMBw=
X-Google-Smtp-Source: AGHT+IG+bYw5aa5qXAocgfxdFotOTyw3i8NWk0A08WmZ4RTMKQzSHU4xstgqw3nYJD/MtZ0mMoVZ9w==
X-Received: by 2002:a05:6808:6508:b0:453:746a:c61c with SMTP id 5614622812f47-45a6bf00314mr3342680b6e.66.1767896399198;
        Thu, 08 Jan 2026 10:19:59 -0800 (PST)
Received: from [100.64.0.1] ([170.85.11.86])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e2e8fb1sm3613666b6e.21.2026.01.08.10.19.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 10:19:58 -0800 (PST)
Message-ID: <77f9a001-7f0a-4c29-abcb-501e875da117@sifive.com>
Date: Thu, 8 Jan 2026 12:19:56 -0600
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/11] riscv: dts: spacemit: add initial device tree of
 SpacemiT K3 SoC
To: Guodong Xu <guodong@riscstar.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Conor Dooley
 <conor@kernel.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
 Andrew Jones <ajones@ventanamicro.com>, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 spacemit@lists.linux.dev, linux-serial@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <anup@brainfault.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
 Yangyu Chen <cyy@cyyself.name>
References: <20260108-k3-basic-dt-v3-0-ed99eb4c3ad3@riscstar.com>
 <20260108-k3-basic-dt-v3-10-ed99eb4c3ad3@riscstar.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20260108-k3-basic-dt-v3-10-ed99eb4c3ad3@riscstar.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-01-08 6:26 AM, Guodong Xu wrote:
> SpacemiT K3 is equipped with 8 X100 cores, which are RVA23 compliant.
> Add nodes of uarts, timer and interrupt-controllers.
> 
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> ---
> v3: Remove "supm" from the riscv,isa-extensions list.
> v2: Remove aliases from k3.dtsi, they should be in board DTS.
>     Updated riscv,isa-extensions with new extensions from the extensions.yaml
> ---
>  arch/riscv/boot/dts/spacemit/k3.dtsi | 548 +++++++++++++++++++++++++++++++++++
>  1 file changed, 548 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/k3.dtsi b/arch/riscv/boot/dts/spacemit/k3.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..be9335fba32cb9e81915b2b91cf08c55a5e96809
> --- /dev/null
> +++ b/arch/riscv/boot/dts/spacemit/k3.dtsi
> [...]
> +
> +		simsic: interrupt-controller@e0400000 {
> +			compatible = "spacemit,k3-imsics","riscv,imsics";

style: missing space after comma

> +			reg = <0x0 0xe0400000 0x0 0x00200000>;
> +			interrupt-controller;
> +			#interrupt-cells = <0>;
> +			msi-controller;
> +			#msi-cells = <0>;
> +			interrupts-extended = <&cpu0_intc 9>, <&cpu1_intc 9>,
> +					      <&cpu2_intc 9>, <&cpu3_intc 9>,
> +					      <&cpu4_intc 9>, <&cpu5_intc 9>,
> +					      <&cpu6_intc 9>, <&cpu7_intc 9>;
> +			riscv,num-ids = <511>;
> +			riscv,num-guest-ids = <511>;
> +			riscv,hart-index-bits = <4>;
> +			riscv,guest-index-bits = <6>;
> +		};
> +
> +		saplic: interrupt-controller@e0804000 {
> +			compatible = "spacemit,k3-aplic", "riscv,aplic";
> +			reg = <0x0 0xe0804000 0x0 0x4000>;
> +			msi-parent = <&simsic>;
> +			#interrupt-cells = <2>;
> +			interrupt-controller;
> +			riscv,num-sources = <512>;
> +		};

Does the chip also have M-mode IMSIC and APLIC instances? Those need to be
represented in the devicetree as well, for M-mode firmware to access them, just
like the CLINT below.

Regards,
Samuel

> +
> +		clint: timer@e081c000 {
> +			compatible = "spacemit,k3-clint", "sifive,clint0";
> +			reg = <0x0 0xe081c000 0x0 0x0004000>;
> +			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>,
> +					      <&cpu1_intc 3>, <&cpu1_intc 7>,
> +					      <&cpu2_intc 3>, <&cpu2_intc 7>,
> +					      <&cpu3_intc 3>, <&cpu3_intc 7>,
> +					      <&cpu4_intc 3>, <&cpu4_intc 7>,
> +					      <&cpu5_intc 3>, <&cpu5_intc 7>,
> +					      <&cpu6_intc 3>, <&cpu6_intc 7>,
> +					      <&cpu7_intc 3>, <&cpu7_intc 7>;
> +		};
> +	};
> +};
> 

