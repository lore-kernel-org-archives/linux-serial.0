Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0B01B0109;
	Thu,  4 Jul 2024 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720102757; cv=none; b=XAIuEiBCB7gHTmAoMXvKnyX8ox50uHev/qLrcwrB+HctkNj0/JXdsg+cn/pKJoFfP62/ZVeFe6Ksnpc+vKHr4LATGKh3Lhu0AP6XrF+37uoYlnZ5KWElevbooX2BHoAy8pSfZbx4tK8IE9O+SXGNrR0wzb6xTcpEPyxgHz2CPWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720102757; c=relaxed/simple;
	bh=OwRVZY+f9veGOGoR06mRiZvZ/R/K4T/tjGiz7dFM/24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EG4BFmtXBFLJgwQ3qGRN3ryfDfUEPidcCEhDzQsMv6nc3BlBWpcV5Ilzo+YiVHCmm2huz2/g247bvaZS0P5rDcdhOX67JRo3xcpmqVdz1gya7AL3q7HXY6SpeqxdLk05Q+KvkfxmV8eWq+IjaBd5t64Gt6qG8MUTuC5BJcr9mBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbTclH35; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbTclH35"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71AE1C32781;
	Thu,  4 Jul 2024 14:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720102756;
	bh=OwRVZY+f9veGOGoR06mRiZvZ/R/K4T/tjGiz7dFM/24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hbTclH35SnvUdR4hFK5/Ro8n9I3duUwlcnH+GdPeTzb6igHteP2I2pKjkRze1turk
	 dQgOopkNNnnIGMgS3bkVFBXdupG7Lt21Eh8jIucIXUjt5Xi5TVXVQy8ZMQrfGkAgIr
	 Iu2ZM0oykY8fYBRFmNKfEgQFI1u/0Lb5CZBzhiguuVnQ0fnJcrbK4YJc/cc44ScpPR
	 ezveUi+K4inDtXVuCIGCYRSv/0pNKLidOJDqUnzXEQN3TsiQbfk+Mgo3Ly9W1j8POU
	 bDSQwhGeSEDYbD7TG/LzdnCCoWqdxUbk8eYdeW4debYK3+tXXXRireCuOUHSu0Z2/E
	 /tCSYACMDGPhQ==
Date: Thu, 4 Jul 2024 22:05:03 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Yixun Lan <dlan@gentoo.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>,
	Inochi Amaoto <inochiama@outlook.com>, linux-serial@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Meng Zhang <zhangmeng.kevin@spacemit.com>
Subject: Re: [PATCH v3 11/11] riscv: dts: spacemit: add uart1 node for K1 SoC
Message-ID: <ZoasDzbOfQjxk9QZ@xhacker>
References: <20240703-k1-01-basic-dt-v3-0-12f73b47461e@gentoo.org>
 <20240703-k1-01-basic-dt-v3-11-12f73b47461e@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240703-k1-01-basic-dt-v3-11-12f73b47461e@gentoo.org>

On Wed, Jul 03, 2024 at 02:55:14PM +0000, Yixun Lan wrote:
> Devices in 0xf000,0000 - 0xf080,0000 are reserved for TEE purpose,
> so add uart1 here but mark its status as reserved.

This patch doesn't deserve a seperate patch, it's better to fold it
into the dtsi one.

> 
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> 
> ---
> This patch can be folded into "riscv: dts: add initial SpacemiT K1 SoC device tree",
> if maintainer finds it's too trivial to have an independent patch..
> ---
>  arch/riscv/boot/dts/spacemit/k1.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
> index a076e35855a2e..fee8921513c1f 100644
> --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> @@ -372,5 +372,15 @@ clint: timer@e4000000 {
>  					      <&cpu6_intc 3>, <&cpu6_intc 7>,
>  					      <&cpu7_intc 3>, <&cpu7_intc 7>;
>  		};
> +
> +		sec_uart1: serial@f0612000 {
> +			compatible = "spacemit,k1-uart", "intel,xscale-uart";
> +			reg = <0x0 0xf0612000 0x0 0x100>;
> +			interrupts = <43>;
> +			clock-frequency = <14857000>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			status = "reserved"; /* for TEE usage */
> +		};
>  	};
>  };
> 
> -- 
> 2.45.2
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
