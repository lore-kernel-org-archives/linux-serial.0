Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795124734;
	b=vxbIm6vvTw+5SpbXw00XVcoO8YkMlsLrcVRg/62df1rcqWEEzAXIQi9+gJiR3BMFXot3
	 oBtnqgcC+jVAOtu3Va6OpGnaTt1/LsgCI3M7wbu+VAFnqzMTMHESVaLeNb7lnqSKs2oVY
	 T5EWzn/4L4IkCvUkW6Hg4/w7WTgsXsHt21Ol+mIXubRXES/URTShsm6kr1KgLRrC66KAa
	 vFekJzdcreorgKRmoJscT/h3u1WjiGPZHRv9CP4jMtlKnp3CnIbJpnqzD6nsMzk46Iad/
	 gGqian63UJX28TOn0Hq4JSLbkIG9jR28fG5xw1Nsx2j19HCFYiDbpX/CQUIAQr95CQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795124734;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=b/rLIiPcJIv2oJafYx5oqUZCgHug4h8Glz1Sr93GiLo=;
	b=rQibhehRDUvLkUwpN/OJH0Mqx+2+YQx8tg70EctTSEFsLhXJfhK3jmpAWfYyHSBW+TMf
	 DNDN7Qsw+BJl/q54Fsz2xBNd9fqHf/WXkbEDs/WRCD6YPgzpzr+HPiLeSt3NbXiKTAY0C
	 aK2HYK2RF2NwPX3nALcL4YYhWH5LtxvWOHtfY7AId4C4z4DKLTirgtlpdC19ZaLoNDZmv
	 JKcPnnjxS5KyZZBMtzLw963wZRhFPfwitUvJLSvGwqpk2ONEQTjQxnh/RlL7pGkfcE4Ni
	 3Ku+5Tb28q6wtL9IyHUJXK706LJR6EDzeVOjImBa6NoZKmLZE7Vf/GnNlPucrIZGArg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n6AWI2rD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A46606A324;
	Thu, 19 Nov 2026 21:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n6AWI2rD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69ED31F000C0;
	Thu, 19 Nov 2026 21:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795124733;
	bh=b/rLIiPcJIv2oJafYx5oqUZCgHug4h8Glz1Sr93GiLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n6AWI2rDTjq5SgdmGXKS46OkCsOx2nNV+E43CbCWI6oYrTEmavWLKV+TeSpiKNGvn
	 7h9qxUiHz4mvv8CCU8HixVhiWsY+aVz6kNwKqdQY7F5VZGMIRBrG0gc78n0Z5S8TUm
	 W+r0w6pGatCAw61qxRztYNmQ6khxtvMse0XTHKB2yNGT1I11lEC9+n+g7l63AZApDx
	 BRvv2e2WGQE94SOUGamRAgZyqtMOJYa65cBrLUdI6OtzZY/izZ/oHQmlnyild4pPqc
	 MUp7HK9UxHhJDeePDicUePQVQwSE6OgvNGnmTRois6w5aoJU3xkgyX4k/RsJm0IkKO
	 UWfHkVJRFGh8w==
Date: Thu, 19 Nov 2026 15:45:32 -0600
From: Rob Herring <robh@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: serial: 8250: Add dedicated
 Loongson-2K3000 UART compatible
Message-ID: <20261119214532.GA757146-robh@kernel.org>
References: <cover.1793776192.git.zhoubinbin@loongson.cn>
 <c194b5248184779da500476281fd411fc80a98d6.1793776192.git.zhoubinbin@loongson.cn>
 <sashiko-outbox-196836@kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-196836@kernel.org>

On Wed, Nov 04, 2026 at 07:52:04AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] dt-bindings: serial: 8250: duplicate ns16550a fallback block for ls2k3000
> --
> 
> commit 71974153fe22bc00d365059be9198364c9cfaa86
> Author: Binbin Zhou <zhoubinbin@loongson.cn>
> 
> dt-bindings: serial: 8250: Add dedicated Loongson-2K3000 UART compatible
> 
> This commit documents the loongson,ls2k3000-uart compatible string with
> ns16550a as a fallback so the driver can distinguish the Loongson-2K3000 UART
> from earlier Loongson UARTs that require MCR/MSR signal inversion.
> 
> > diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
> > index 01abd39509a7a..33c13c48ed56e 100644
> > --- a/Documentation/devicetree/bindings/serial/8250.yaml
> > +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> > @@ -196,6 +196,9 @@ properties:
> >                - loongson,ls2k2000-uart
> >            - const: loongson,ls2k1500-uart
> >            - const: ns16550a
> > +      - items:
> > +          - const: loongson,ls2k3000-uart
> > +          - const: ns16550a
> 
> [Severity: Low]
> This isn't a bug, but properties:compatible in
> Documentation/devicetree/bindings/serial/8250.yaml already has a two-item
> block with const: ns16550a as the fallback that includes the other base
> Loongson UART compatibles:
> 
>       - items:
>           - enum:
>               ...
>               - loongson,ls2k0500-uart
>               - loongson,ls2k1500-uart
>           - const: ns16550a
> 
> Could loongson,ls2k3000-uart be added to that existing enum instead of adding
> a separate two-item block?

Sashiko is correct. Please address this comment.

And please answer sashiko comments before the maintainers have to.

Rob
