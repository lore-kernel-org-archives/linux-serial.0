Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328791802AB;
	Fri, 14 Feb 2025 06:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739513860; cv=none; b=T7yDo3fM/ia2lydtoOI7QChhdcXBF4eaYs00bCskrjM0HjvZE2jZPg3krLMjzxrLKtXz6kW959RTnqVsychhTOiv7W+c1nLSybG6uESs00XK8dDEcVSw7KghHo1Zdt2Scs96AiDPTvx2eB9CrhAG/HRt9NS1fCTuG+9sheefq1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739513860; c=relaxed/simple;
	bh=w25nGQtVxpWFNfJEW6tc8GMGWH8yPyXxGTlraUkS5FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5hSFCxEcB3FwkPzeK0F6/lIzm+YzAxsVQ6lfBCx2+/TcSRX0+/bHh8WjAsi8RqG70UCDp+wEwAzCihI3RvaKUUxGwKehydALy1u6RVaki4QbFo+pEpuZtsJ6qT/Ch6MisXZBhoa3nLtC/y6MaGbDxpiU1V5+HBQ4m3sEiWwCZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEqqZRoh; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEqqZRoh"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-51f405fce23so524825e0c.0;
        Thu, 13 Feb 2025 22:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739513858; x=1740118658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4sIcvxrX099LtAxbJT25rmi+yeCJ3k33A3mIelkkExA=;
        b=GEqqZRohimFNTPQ4qW5Jqedur6g0DIoYs4pbZBMKb5Bt64ZTt/skcQxVoy2vOqwgqP
         NVCD+Ky9EcyaaAovid9E3u+oyoaSYv2g5znReSjg+29f0tDA0/odAZ7iFoLQ6FErEtFk
         9HqnoCQXLJQBNytduKY737VL2oIQmOkVrWV41cnrmv0YPQLWwK+Moh1e7lOlk2I3SajK
         3B21FcMxEC0ylsHMLzdVgdppF4T8W/dWIzYkNsYbf0P8I7P7Smx3FUFzcyxgOEV27zeg
         b+zdkOlLu9mKxyFn1CSXz9yVPVZupq59YCdtme0PgLZY5FzZQ207MCkjdbd+872VuLvO
         4p/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739513858; x=1740118658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sIcvxrX099LtAxbJT25rmi+yeCJ3k33A3mIelkkExA=;
        b=MhuDQeIHSJFEb7DualpK+c4WvhZ1WEreXT3rNPfAACtQ8PSuvsc3v3knAeB4jdrrtB
         7Q7sp64+DgmmdthDfkoYg2/qeL/YBc8N4zUMNzBBrdqqf50z+jziluTYZhqvJcOsSioG
         sj9ecjgZ4bks2fDQ9d0TspZE4e6TFOvXHTkrvI6kVNnmJOR6120CS7/VSq7yAxkmsM5h
         YrRwc+Ws0dKH5/vq+ms7QSepqwT1XCG5vbioN0brkmK3BCbxqd1ZCBd5AYbUqqXjji3h
         B4o15g67BDUjHB3uYeGFsjI+cJ9QnMTRczkG82LyGeumfOd0IFHjrquWxzHx9Ir8h4ZE
         Bnhg==
X-Forwarded-Encrypted: i=1; AJvYcCU8rF17IMXQIA0JSaHJsgjETImdpfgSbZQw0vaVVwTODTW9K4XGII+ayWan43QtqM+gDLLTyPjyeZLE@vger.kernel.org, AJvYcCUjPxiYKiOhLTsKsFZyt08RYnUr+gCAWZIVFo8yiWpKLEI6X1MXwgbBWMf4cJsJOt3g0Jv9atKFwSjlkcxN@vger.kernel.org, AJvYcCWT+P2SDe0EXmbIHF4rh7xrGxrYVBYN0TebZW2UtSr17wlXmFudbwZ+yiuUw0ziIw2Cbi+5xRVPRjYagw+F@vger.kernel.org, AJvYcCXdNkdAWAONq4VEwAm3KpYQFnPHGj8mUXku+TNsend168Uy4KlfbktCzSNW2ks00NKgHOpYwcRP7iSS6wcGCPeiHB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwZ9H0TrngndxZO5yUyS+WegOLV9vGf6qyhT6efrBWQ1z13wJl
	qQbPHFGgVaGhgm/ekgk04UPcGbNjnewaHVui6to5Q0pbNlHxyRn1
X-Gm-Gg: ASbGncsp9gDUv4THdttGYA1pGHqRTx1MV5v8/QFzZGRnIsz3m9j4JErP/01BnkLziTa
	kiTOnNUJ8FikraLkdtMan8Rm7A30zlm8bhY9GYM9ZmN0oa9hvpERLO5tZhfLVWt5s6y7zl5Zy06
	WT0TZlTP7gCMTFgVrNDQ/HK/7VWaIhrBoX1xFYhYmz6J04IjujIZjGuGvKob2w0MvQ6aBH8FZ1f
	E7tL1Ki+D/b4ByHuSwuknm0XbqVJKXNda4G+VhYSti40WyAup4Moc9HGyUwv/k3J36saYwvb0Gt
	+roFycllziLxtmkQoAgBFxJ/8n61O8cMGwkiVWfp0lT+aiTmodVQU3igPWNptQ==
X-Google-Smtp-Source: AGHT+IHRLYoJKdwZm1YCd9aBf7aEL7V8Zsi2JM2MJI5ygyPB2inPNLw5h4kckPoKN1ULpGO4ZArePw==
X-Received: by 2002:a05:6122:8c0c:b0:51f:405e:866e with SMTP id 71dfb90a1353d-52077dbf86dmr3546146e0c.1.1739513857884;
        Thu, 13 Feb 2025 22:17:37 -0800 (PST)
Received: from droid-r8s ([38.44.237.182])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5207ab4fc73sm487086e0c.36.2025.02.13.22.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 22:17:37 -0800 (PST)
Date: Fri, 14 Feb 2025 06:17:30 +0000
From: Denzeel Oliva <wachiturroxd150@gmail.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: alim.akhtar@samsung.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
	robh@kernel.org, semen.protsenko@linaro.org,
	wachiturroxd150@gmail.com
Subject: Re: [PATCH v1 3/3] arm64: dts: exynos990: define all PERIC USI nodes
Message-ID: <Z67f+lDxISVubiJJ@droid-r8s>
References: <20250212234034.284-1-wachiturroxd150@gmail.com>
 <20250212234034.284-4-wachiturroxd150@gmail.com>
 <40370a0e-775b-42e3-bb6c-8cacaa0482cf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40370a0e-775b-42e3-bb6c-8cacaa0482cf@linaro.org>

On Thu, Feb 13, 2025 at 07:38:35AM +0000, Tudor Ambarus wrote:
> > +		usi_uart: usi@105400c0 {
> > +			compatible = "samsung,exynos990-usi", "samsung,exynos850-usi";
> > +			reg = <0x105400c0 0x20>;
> > +			samsung,sysreg = <&sysreg_peric0 0x1000>;
> > +			samsung,mode = <USI_V2_UART>;
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			ranges;
> > +			clocks = <&cmu_peric0 CLK_GOUT_PERIC0_TOP0_PCLK_4>,
> > +				 <&cmu_peric0 CLK_GOUT_PERIC0_TOP0_IPCLK_4>;
> > +			clock-names = "pclk", "ipclk";
> > +			status = "disabled";
> > +
> > +			serial_0: serial@10540000 {
> > +				compatible = "samsung,exynos990-uart",
> > +					     "samsung,exynos8895-uart";
> > +				reg = <0x10540000 0xc0>;
> > +				interrupts = <GIC_SPI 391 IRQ_TYPE_LEVEL_HIGH>;
> > +				pinctrl-names = "default";
> > +				pinctrl-0 = <&uart0_bus>;
> > +				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_TOP0_PCLK_4>,
> > +					 <&cmu_peric0 CLK_GOUT_PERIC0_TOP0_IPCLK_4>;
> > +				clock-names = "uart", "clk_uart_baud0";
> > +				samsung,uart-fifosize = <256>;
> > +				status = "disabled";
> 
> node properties shall be specified in a specific order. Follow similar
> nodes that are already accepted, gs101 is one.

Not all Exynos SoCs will follow the same order

> <&cmu_peric0 CLK_GOUT_PERIC0_TOP0_IPCLK_4>;

Is

GATE(CLK_GOUT_PERIC0_TOP0_IPCLK_4, "gout_peric0_top0_ipclk_4",
     "dout_peric0_uart_dbg",
     CLK_CON_GAT_GOUT_BLK_PERIC0_UID_PERIC0_TOP0_IPCLKPORT_IPCLK_4,
     21, 0, 0), [Mainline CLK]

You can find it in the cmucal-node.c driver downstream of the kernel. [0]

> > +			};
> > +		};
> > +
> > +		usi0: usi@105500c0 {
> 
> cut
> 
> > +
> > +			hsi2c_0: i2c@10550000 {
> 
> cut
> 
> > +
> > +			spi_0: spi@10550000 {
> 
> cut
> 
> > +			serial_2: serial@10550000 {
> 
> why not serial_0 since you're in USI0.

Because it is simply displayed in the exynos9830-usi.dtsi [1]

> > +		};
> > +
> > +		usi_i2c_0: usi@105600c0 {
> > +			compatible = "samsung,exynos990-usi", "samsung,exynos850-usi";
> > +			reg = <0x105600c0 0x20>;
> > +			samsung,sysreg = <&sysreg_peric0 0x1008>;
> > +			samsung,mode = <USI_V2_I2C>;
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			ranges;
> > +			clocks = <&cmu_peric0 CLK_GOUT_PERIC0_TOP0_PCLK_6>,
> > +				 <&cmu_peric0 CLK_GOUT_PERIC0_TOP0_IPCLK_6>;
> > +			clock-names = "pclk", "ipclk";
> > +			status = "disabled";
> > +
> > +			hsi2c_1: i2c@10560000 {
> > +				compatible = "samsung,exynos990-hsi2c",
> > +					     "samsung,exynosautov9-hsi2c";
> > +				reg = <0x10560000 0xc0>;
> > +				interrupts = <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>;
> > +				pinctrl-names = "default";
> > +				pinctrl-0 = <&hsi2c1_bus>;
> > +				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_TOP0_IPCLK_6>,
> > +					 <&cmu_peric0 CLK_GOUT_PERIC0_TOP0_PCLK_6>;
> > +				clock-names = "hsi2c", "hsi2c_pclk";
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				status = "disabled";
> > +			};
> 
> shouldn't you define serial and SPI too?

As shown in the node it only uses i2c which
corresponds to the exynos9830-usi.dts. [2]

> > +		};
> > +
> 
> cut
> 
> > +			spi_8: spi@108e0000 {
> > +				compatible = "samsung,exynos990-spi";
> > +				reg = <0x108e0000 0x30>;
> > +				interrupts = <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>;
> > +				pinctrl-names = "default";
> > +				pinctrl-0 = <&spi8_bus>;
> > +				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_TOP0_PCLK_14>,
> > +					 <&cmu_peric1 CLK_GOUT_PERIC1_TOP0_IPCLK_14>;
> > +				clock-names = "spi", "spi_busclk0";
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				fifo-depth = <256>;
> 
> that's a first. Does downstream define any SPI node with 256 bytes
> FIFOs? Would you please point me to the downstream sources?

Here :) [3]

> Cheers,
> ta

[0] https://github.com/ExtremeXT/android_kernel_samsung_exynos990/blob/69515fbb7a4395898c05a8624f76a12afbac11c5/drivers/soc/samsung/cal-if/exynos9830/cmucal-node.c#L2719
[1] https://github.com/pascua28/android_kernel_samsung_s20fe/blob/3be539e9cd22b89ba3cc8282945a0c46ff27341d/arch/arm64/boot/dts/exynos/exynos9830-usi.dtsi#L1954
[2] https://github.com/pascua28/android_kernel_samsung_s20fe/blob/3be539e9cd22b89ba3cc8282945a0c46ff27341d/arch/arm64/boot/dts/exynos/exynos9830-usi.dtsi#L170
[3] https://github.com/pascua28/android_kernel_samsung_s20fe/blob/3be539e9cd22b89ba3cc8282945a0c46ff27341d/arch/arm64/boot/dts/exynos/exynos9830-usi.dtsi#L1638
