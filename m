Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8B3D2F5;
	Thu,  4 Jul 2024 14:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720102659; cv=none; b=gRsY1T/CK0jrp3hmQT4QDBLXLuR+JPTDCADgVQPlESD4y5CJCPI+tYpuyBxCEkMQpsQGioeXDJVILyu7cao2qvGQGgdc2xXEbBf05whpAnGrLpaEjEiHiWE3bjTHxJwDrWY/wey8/N8nP1DO3SK2gOicJObjhuwGuiZOme0jcAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720102659; c=relaxed/simple;
	bh=SusMqoQix19RFodccF+ktpMi/I4/Jwdyx6c19a7rm2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frbMYd0AyIbrO/ohZsop2XGQX+CYxQqFrmXUtOSDW+RLSjdtzn2vN/M/jQAy9V6OjGlmLGkdzHyUZTGj2yQe3L7ATU201UN/UdlwD4h4CbZe0MylSoj4eokmpWgj6l13MRHSpusnP8YzVtgIE9EzLg+LB2T6TMX58/wcBEeSlns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVW9hvGh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVW9hvGh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D02DC3277B;
	Thu,  4 Jul 2024 14:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720102658;
	bh=SusMqoQix19RFodccF+ktpMi/I4/Jwdyx6c19a7rm2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sVW9hvGhah5nixxTU7OuPnLSMWSdHN4ZlsVpGf7jARG4mwYV2VEQ6BxAgV1Dtzq1+
	 ULPw8uHgLPJyCcdg96j3HrkBk/oPAwK0qMKzI0nJPScqns+Y3s2FL1XqN1ev+I/M7I
	 TTEmBpGna7qBjqx3fXTeJEnmzBpZGCfvybDT4bNZXce7mR2J2qfhoVomHgcSsKFrd5
	 RL7ssrxm+lbuw0y2aAPK7Acehtwk52T6RNJgUYW2c/WxSRLgbXr4SAIbV1f4TXGMkE
	 tZCe/CE/IKayIGoegNxSYqg90Zi6kq278eiNHQwuM34McuPZ8wivV2xiemfvtldz8C
	 CLUxhh33YctWg==
Date: Thu, 4 Jul 2024 22:03:29 +0800
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
	Conor Dooley <conor.dooley@microchip.com>,
	Inochi Amaoto <inochiama@outlook.com>, linux-serial@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Meng Zhang <zhangmeng.kevin@spacemit.com>
Subject: Re: [PATCH v3 06/11] dt-bindings: serial: 8250: Add SpacemiT K1 uart
 compatible
Message-ID: <ZoarsYMNJRu1-_wn@xhacker>
References: <20240703-k1-01-basic-dt-v3-0-12f73b47461e@gentoo.org>
 <20240703-k1-01-basic-dt-v3-6-12f73b47461e@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240703-k1-01-basic-dt-v3-6-12f73b47461e@gentoo.org>

On Wed, Jul 03, 2024 at 02:55:09PM +0000, Yixun Lan wrote:
> Found SpacemiT's K1 uart controller is compatible with
> Intel's Xscale uart, but it's still worth to introduce a new compatible.

Per vendor's kernel source code, all the uarts support 64Bytes FIFO.
So if it's compatible with Xscale, it's a xscale uart 64 Bytes FIFO.
From this PoV, the uart isn't a Xscale but a mrvl pxa.

But I have one question: is the uart really a mrvl/intel pxa uart? or is just
reg programming compatible with pxa?

> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
>  Documentation/devicetree/bindings/serial/8250.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
> index 692aa05500fd5..0bde2379e8647 100644
> --- a/Documentation/devicetree/bindings/serial/8250.yaml
> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> @@ -111,7 +111,9 @@ properties:
>                - mediatek,mt7623-btif
>            - const: mediatek,mtk-btif
>        - items:
> -          - const: mrvl,mmp-uart
> +          - enum:
> +              - mrvl,mmp-uart
> +              - spacemit,k1-uart
>            - const: intel,xscale-uart
>        - items:
>            - enum:
> 
> -- 
> 2.45.2
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
