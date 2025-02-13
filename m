Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E43F208984
	for <linux-serial@vger.kernel.org>; Thu, 13 Feb 2025 07:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739432321; cv=none; b=OxjoeONSIwmDs6DgnNGzoqeoU36OASOr8b7V7Iej7lpQpeRp7zh8C06EzMPA9k7KQzxzsTxjQwPN7kmqg8wd0drQ7BeHGHwbyHstW7xYe5xrqFQphY/r7JaUJsWDjBEtbeHGGge5S4dX+t2oOIpA91OTXCioYDs+/zRP7pJB8bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739432321; c=relaxed/simple;
	bh=8jHSN2t8uUr6bZE59ZIgxIuRdzhSTrE+DV+sY0qnFvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Syc7ITA6g55HhbGW4Rx3R4icsi5LfihNtQQO9bLNnyP5ncReUOZ6hyx/DC/hBgVWR9MrOsRXfzVwcZXlmPgd7NWNi9IBTc+7W3rGCpQYrTskcBt4QZ8/Dc+kZkgRKBR4h2uvAjhs6tC8CcY0Rk58Qttp9PgO69MAKl0RFG3KONA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I8ix8+h5; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I8ix8+h5"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso93477566b.1
        for <linux-serial@vger.kernel.org>; Wed, 12 Feb 2025 23:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739432318; x=1740037118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vizM0Sdo+SZTTaKpC/1DIJWgscYtW1gDxvN+iGD1EdQ=;
        b=I8ix8+h5HXOpyihMVRUKJsDe3uarftXe8rpi/HxrHsqd0ty9rT6EJTAuH37ihdvqv0
         ecPxyOotLIJjY80eaYTkMR1q2QiSOhi6eYKuQJdhSsXCBb70o5mVUi0vFD57BKsokLhR
         4GR5TenRGEtIqLdU0HOYNIhdCnzlgQ9A6Kc+7lm3r82ig263n70k2h29O/EyuGqzHj/J
         UBbQE/ZAkgyKSuBx87BpPRv/0C8C63ArB8a4FM7lyf7rkVaSnktj7yRi+KgYe4/w6fEn
         oYWLev248td5hbl6OqUZ6L2/aNVOryDt6D9b07dSmVKStnOMEL7dpAW22isBoogtkRTp
         inyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739432318; x=1740037118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vizM0Sdo+SZTTaKpC/1DIJWgscYtW1gDxvN+iGD1EdQ=;
        b=UDjyWqGa6gr6Vf0m0r7akXruWwQCvMQlrdmV8UeFcEV60mOjb+ri7B6W4evkNgZ3i7
         Ey+eHFtNT31GddERCeQgZ1MdLQDTPezJ6TFI2jddOqXEguLVYuwV3qRzViLwayov8D5X
         nhxVsV03TJPrlREYgwUVLCPjUSwXkDkBBDKJvH9ngwXkDT6JitMIhhFFi5zJ87VwkJdG
         JZXDSPg21L0EV91Df0cQgoeIpDm8C7g9v4CpIPDirwx7WkKE+beYVpi08aofPbb7eHIn
         78aHXZMGlMmqljVdU14IqgyW1bVznZCv+BBANU7dgD7ZwreBZcLW3HBmXefnHwS5GvXf
         f1sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQuu0cQY4Ixl7lVXeNWKmxVrum00XIbo5MuAcE6Om3u1M+/5VWgFiP1VLmkOyHtgTehyGAz/SrGVrqmEo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3rFHYjn0oskoUIQvTptrgOcZMXmlNYZeUz55X1QFXc30ycDtv
	IsxdxoD5CxVXOR+YsA1vWDdveV6K5Si19Xdb4AkLBzQn9PCmuFZidKIv84yVs5c=
X-Gm-Gg: ASbGncvJGzT3PrwElPEh7xD0LUXoePEMVHATTf/5LsBXNEPXYctaNL16zHp/49BGhOj
	4sUv5xMt8yBcFIR31IY2C9Q29AyIn5xglZzJD+0vJtR89JkxsoouUcBvQyeTD7rH0cfuB4JOk+r
	MLV1H24Lt/QAzf05W7IgxEEld8GKB6YeRgYjjDhEcuWpjWYUx8fdeUgcHQstbAiOLFaTH4ODlh5
	HSe2A24/NPSaGDrePX4mu4D6e+Y8viV3EOsCgtAdxxSNF3MEgwZSVYj2P/I2YVYive1k5mST++T
	b3ocqKW5Efed7bjXlzVwP1IK
X-Google-Smtp-Source: AGHT+IHDPN30IeTPgZSQ6r4lGFgS4tkcB9qst37osdGIW9i7ciqPaXGYBjTXuWeMR8vFNohAyFOWCQ==
X-Received: by 2002:a17:907:1909:b0:aa6:ac9b:6822 with SMTP id a640c23a62f3a-ab7f3344473mr607557566b.12.1739432317767;
        Wed, 12 Feb 2025 23:38:37 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.124])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53259517sm75356766b.65.2025.02.12.23.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 23:38:37 -0800 (PST)
Message-ID: <40370a0e-775b-42e3-bb6c-8cacaa0482cf@linaro.org>
Date: Thu, 13 Feb 2025 07:38:35 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] arm64: dts: exynos990: define all PERIC USI nodes
To: Denzeel Oliva <wachiturroxd150@gmail.com>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, alim.akhtar@samsung.com, semen.protsenko@linaro.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
References: <20250212234034.284-1-wachiturroxd150@gmail.com>
 <20250212234034.284-4-wachiturroxd150@gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250212234034.284-4-wachiturroxd150@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/12/25 11:40 PM, Denzeel Oliva wrote:
> Universal Serial Interface (USI) supports three types of serial interface
> such as Universal Asynchronous Receiver and Transmitter (UART), Serial
> Peripheral Interface (SPI), and Inter-Integrated Circuit (I2C).
> Each protocols can be working independently and configured as one of
> those using external configuration inputs.
> 
> Exynos990 SoC defines 18 USI nodes in PERIC0/1 blocks.
> Nodes have different depths from 64-256 bytes.

for the reviewer's peace of mind you shall specify whether you tested at
least an i2c, uart and spi node.

> 
> Signed-off-by: Denzeel Oliva <wachiturroxd150@gmail.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos990.dtsi | 1693 +++++++++++++++++++++
>  1 file changed, 1693 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos990.dtsi b/arch/arm64/boot/dts/exynos/exynos990.dtsi
> index aa056fdae..22ec92a45 100644
> --- a/arch/arm64/boot/dts/exynos/exynos990.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos990.dtsi
> @@ -7,6 +7,7 @@
>  
>  #include <dt-bindings/clock/samsung,exynos990.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/soc/samsung,exynos-usi.h>
>  
>  / {
>  	compatible = "samsung,exynos990";
> @@ -248,6 +249,808 @@ sysreg_peric0: syscon@10420000 {
>  			clocks = <&cmu_peric0 CLK_GOUT_PERIC0_SYSREG_PCLK>;
>  		};
>  
> +		usi_uart: usi@105400c0 {
> +			compatible = "samsung,exynos990-usi", "samsung,exynos850-usi";
> +			reg = <0x105400c0 0x20>;
> +			samsung,sysreg = <&sysreg_peric0 0x1000>;
> +			samsung,mode = <USI_V2_UART>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			clocks = <&cmu_peric0 CLK_GOUT_PERIC0_TOP0_PCLK_4>,
> +				 <&cmu_peric0 CLK_GOUT_PERIC0_TOP0_IPCLK_4>;
> +			clock-names = "pclk", "ipclk";
> +			status = "disabled";
> +
> +			serial_0: serial@10540000 {
> +				compatible = "samsung,exynos990-uart",
> +					     "samsung,exynos8895-uart";
> +				reg = <0x10540000 0xc0>;
> +				interrupts = <GIC_SPI 391 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&uart0_bus>;
> +				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_TOP0_PCLK_4>,
> +					 <&cmu_peric0 CLK_GOUT_PERIC0_TOP0_IPCLK_4>;
> +				clock-names = "uart", "clk_uart_baud0";
> +				samsung,uart-fifosize = <256>;
> +				status = "disabled";

node properties shall be specified in a specific order. Follow similar
nodes that are already accepted, gs101 is one.

> +			};
> +		};
> +
> +		usi0: usi@105500c0 {

cut

> +
> +			hsi2c_0: i2c@10550000 {

cut

> +
> +			spi_0: spi@10550000 {

cut

> +			serial_2: serial@10550000 {

why not serial_0 since you're in USI0.

> +		};
> +
> +		usi_i2c_0: usi@105600c0 {
> +			compatible = "samsung,exynos990-usi", "samsung,exynos850-usi";
> +			reg = <0x105600c0 0x20>;
> +			samsung,sysreg = <&sysreg_peric0 0x1008>;
> +			samsung,mode = <USI_V2_I2C>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			clocks = <&cmu_peric0 CLK_GOUT_PERIC0_TOP0_PCLK_6>,
> +				 <&cmu_peric0 CLK_GOUT_PERIC0_TOP0_IPCLK_6>;
> +			clock-names = "pclk", "ipclk";
> +			status = "disabled";
> +
> +			hsi2c_1: i2c@10560000 {
> +				compatible = "samsung,exynos990-hsi2c",
> +					     "samsung,exynosautov9-hsi2c";
> +				reg = <0x10560000 0xc0>;
> +				interrupts = <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&hsi2c1_bus>;
> +				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_TOP0_IPCLK_6>,
> +					 <&cmu_peric0 CLK_GOUT_PERIC0_TOP0_PCLK_6>;
> +				clock-names = "hsi2c", "hsi2c_pclk";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};

shouldn't you define serial and SPI too?

> +		};
> +

cut

> +			spi_8: spi@108e0000 {
> +				compatible = "samsung,exynos990-spi";
> +				reg = <0x108e0000 0x30>;
> +				interrupts = <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&spi8_bus>;
> +				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_TOP0_PCLK_14>,
> +					 <&cmu_peric1 CLK_GOUT_PERIC1_TOP0_IPCLK_14>;
> +				clock-names = "spi", "spi_busclk0";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				fifo-depth = <256>;

that's a first. Does downstream define any SPI node with 256 bytes
FIFOs? Would you please point me to the downstream sources?

Cheers,
ta
