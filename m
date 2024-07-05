Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367B01758D;
	Fri,  5 Jul 2024 06:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720162048; cv=none; b=KxPBD0NWv0ZsoYxGRuOkLtYAW6/s3XM5WiPoSm/0Op4T5SIwESAbV6CBx/kmoemO6e62jC2xfujjNGKcjQsuxmEUif7RY1TRDFmTOuzy061hoqWDA5PMUUB8DrCvArn3vLMesnJUBjk21aeC4IRD0HNxBMP3huYNXQlDP6dHLVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720162048; c=relaxed/simple;
	bh=zFbuTCd8s/f+WalxBRft3LY+kuvmciauhWVz5S7om+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2SJ4Sb93WRTsBfwcnkP4JnhAnsR9ZiRI8iPD72ypTALNHCl1JNRAQQJ6GgYawCfRGE8x3OvWOIRBWyeDWrS2eBeo34LG7mkld+xrcqsR/jDqs/fyLHtg7BNsbPvtC/SzbtYVUuVIEVg9THvBEX5Bm5JrMh166iwPwjbB+weQf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Date: Fri, 5 Jul 2024 06:47:21 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Jisheng Zhang <jszhang@kernel.org>
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
Message-ID: <20240705064721.GB3042186@ofsar>
References: <20240703-k1-01-basic-dt-v3-0-12f73b47461e@gentoo.org>
 <20240703-k1-01-basic-dt-v3-6-12f73b47461e@gentoo.org>
 <ZoarsYMNJRu1-_wn@xhacker>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoarsYMNJRu1-_wn@xhacker>


On 22:03 Thu 04 Jul     , Jisheng Zhang wrote:
> On Wed, Jul 03, 2024 at 02:55:09PM +0000, Yixun Lan wrote:
> > Found SpacemiT's K1 uart controller is compatible with
> > Intel's Xscale uart, but it's still worth to introduce a new compatible.
> 
> Per vendor's kernel source code, all the uarts support 64Bytes FIFO.
> So if it's compatible with Xscale, it's a xscale uart 64 Bytes FIFO.
yes, I agree

further question would how to implement specific support for spacemit's k1 SoC
one possible option to add a PORT_SPACEMIT compatible data to 8250_port.c - uart_config[]


> >From this PoV, the uart isn't a Xscale but a mrvl pxa.
see my previous comment, probably need further clarification/investigation..

> 
> But I have one question: is the uart really a mrvl/intel pxa uart? or is just
No, I'm unable to answer this, I'm not an employee of SpacemiT
All informations are based on public available source + docs..

> reg programming compatible with pxa?
> 
To my knowledge, it's compatible with pxa, but it would be great that vendor can clarify this

> > 
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Yixun Lan <dlan@gentoo.org>
> > ---
> >  Documentation/devicetree/bindings/serial/8250.yaml | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
> > index 692aa05500fd5..0bde2379e8647 100644
> > --- a/Documentation/devicetree/bindings/serial/8250.yaml
> > +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> > @@ -111,7 +111,9 @@ properties:
> >                - mediatek,mt7623-btif
> >            - const: mediatek,mtk-btif
> >        - items:
> > -          - const: mrvl,mmp-uart
> > +          - enum:
> > +              - mrvl,mmp-uart
> > +              - spacemit,k1-uart
> >            - const: intel,xscale-uart
> >        - items:
> >            - enum:
> > 
> > -- 
> > 2.45.2
> > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55
