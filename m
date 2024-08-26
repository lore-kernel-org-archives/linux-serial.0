Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC3480027;
	Mon, 26 Aug 2024 05:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724652000; cv=none; b=Iu/w36OII//i8aEp99e4u8AQp+u1b8mArL9JG4xHSIuzbbhDs2/tcjoPneNBq4KPf9cvG+fdXwT5zvVCrxp9R7Jd3FPfLuT60Cx46OC32lDxQlQAdL/argnVBl9LRTk+AyGneh4HkEkNS/PN0iiatx+PLQYp4mSMzrAcew6ldUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724652000; c=relaxed/simple;
	bh=gwPC1PQuLbmGGEoj2L86IgnR3bAMfnC2ZsSKA6aNxgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oyjcg0Jh5ddLBLxL5h1hFjYyG6xCl4/wYzGMUWD2T9/ZXnZauAa848W3s3I9pf66NajMauVa9dwnZhLHy64DFneXyqrIRD4ldvPnrwWpl5vzJJX17X8tAuiudjmh/SYDm7JID4lkDFQ4LTE7w0i4+UVPliFJsXXX0phLrLGQCMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZxgzt9t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZxgzt9t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F95C4DDE1;
	Mon, 26 Aug 2024 05:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724651999;
	bh=gwPC1PQuLbmGGEoj2L86IgnR3bAMfnC2ZsSKA6aNxgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UZxgzt9t6AJLxZSGRafeIrUPvOi2Zm4UWjzQJArD2Tkw7gYTFtxyCXNO5NJSJR65n
	 t/WmhalthFYqJuaBPfCMwbKZpXG9zjq63jtHMycczrT0pYWb+S2xD+JyK6NroPTlob
	 l1/yFJrzM6WrZazrfwf4Dtqdqdx5TR5lZCQYozBA3uuvRCochukTHKRGCMdDmRRZkE
	 rJQ0B/y7ShKcSmOj6l5oyFpCQ+M60o0xtZSQq5LU8t2U/Ge010Ctyc2IRByGvUhUA9
	 CiXplAEL8hMzVYT9I53qmUnRm+ybyDBlFODxRsFKFmxV/+XJ1XGzu+HY0m1AHvnoZs
	 73P/MSdg84ZRw==
Date: Mon, 26 Aug 2024 07:59:55 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: zhenghaowei@loongson.cn
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name, 
	p.zabel@pengutronix.de, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, loongarch@lists.linux.dev
Subject: Re: [PATCH v3 1/3] dt-bindings: serial: Add Loongson UART controller
Message-ID: <7346m2dmduzdrhzmhlnms24bltoczbajfxfh6wcxxplzydqskc@2xey7pdc24t3>
References: <20240826024705.55474-1-zhenghaowei@loongson.cn>
 <20240826024705.55474-2-zhenghaowei@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240826024705.55474-2-zhenghaowei@loongson.cn>

On Mon, Aug 26, 2024 at 10:47:03AM +0800, zhenghaowei@loongson.cn wrote:
> From: Haowei Zheng <zhenghaowei@loongson.cn>
> 
> Add Loongson UART controller binding with DT schema format using
> json-schema.
> 
> Signed-off-by: Haowei Zheng <zhenghaowei@loongson.cn>
> ---
>  .../bindings/serial/loongson,uart.yaml        | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/loongson,uart.yaml
> 
> Changes in V2:
> 
> - Correct the schema formatting errors.
> 
> - file name changed from 'loongson-uart.yaml' to 'loongson,ls7a-uart.yaml'
> 
> - Replace 'loongson,loongson-uart' with 'loongson,ls7a-uart'.
> 
> Changes in V3:
> 
> - Change the filename from 'loongson,ls7a-uart.yaml' to 'loongson,uart.yaml'.
> 
> - Drop newly defined features: fractional-division, rts-invert, dtr-invert,
>   cts-invert and dsr-invert.
> 
> - Add three specific SoC: 'loongson,ls7a-uart', 'loongson,ls3a5000-uart' and 
>   'loongson,ls2k2000-uart'.
> 
> - Drop 'LOONGSON UART DRIVER' description in MAINTAINERS.
> 
> diff --git a/Documentation/devicetree/bindings/serial/loongson,uart.yaml b/Documentation/devicetree/bindings/serial/loongson,uart.yaml
> new file mode 100644
> index 000000000000..19a65dd5be9f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/loongson,uart.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/loongson,uart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson UART
> +
> +maintainers:
> +  - Haowei Zheng <zhenghaowei@loongson.cn>
> +
> +allOf:
> +  - $ref: serial.yaml
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - loongson,ls7a-uart

Quick look tells me there is no such soc like ls7a. If there is such,
please point me to the DTSI.


> +          - loongson,ls3a5000-uart
> +          - loongson,ls2k2000-uart
> +      - items:
> +          - enum:
> +              - loongson,ls2k1000-uart
> +              - loongson,ls2k0500-uart
> +          - const: loongson,ls7a-uart

Just use real SoC names.

> +      - items:
> +          - enum:
> +              - loongson,ls2k1500-uart
> +          - const: loongson,ls2k2000-uart
> +      - items:
> +          - enum:
> +              - loongson,ls3a6000-uart
> +          - const: loongson,ls3a5000-uart

Best regards,
Krzysztof

