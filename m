Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B04D4A689C;
	Thu,  8 Oct 2026 14:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791468549; cv=none; b=rIbyX12osj1SQ4J6r/8UJPJnpM4R2YC6TRervXqS3FJPiAA1OQ92YIMb/dcvgb9tTXM7h3vuU2KOMOeUnrw0BlQjs9PzV3SFGK30krgbr6P40bkVbGGz3WNZoN/6uhMvmBu1eglqjjPLtMd6xShsU8R+5zfOHLa0kj1K7GT+Jpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791468549; c=relaxed/simple;
	bh=oM5auXyuwmnVcDTrwBD6PW+dlLO6v83bTYCx3Rxxdso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0A5X1yii3Kv6wZR9n00Mp12I5GjA7h6mZSOyiP4cZ+yfdL9kQNDCLylmH4kFTgXouloIUc1kv9hEu2pH81Y4sn8b+ShGWV116wYrwJrH5vAMlabkNw4nyvGbeROn2MiEXhm+G0FtSjzgPOTRVjUAKBjR4NWtPcYr8OCHx0Gz48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6biZtrM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6biZtrM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92711F000FF;
	Thu,  8 Oct 2026 14:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791468547;
	bh=/tzAXBMD0lsbju9z6QnZ2iMBJT8XPqLA/qjwrIhecMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c6biZtrM+lhSbEpYGGyf5l1sjO1/gz/Ybz/WPC4Wo1RWZixJcXPz3Py/jotUTCgBR
	 hNIWeC4KwQq5q5vfJSxzyj4C8ErUrRrvDyLq7udCvcTTB+DE4f7zsGu7GFa1Hh52GK
	 RyJ7MgwIM4lYzg6qt3Frrdq40y5D5lY+vGgLbjsLFKwBu+dXyVPV/0t/jhbsXMMLLl
	 zPjKhztK8TBsH3/SUQRaJeSr7Gc2oV/+puPGQJ6m/Dm9cAUU7ypPUk6elD3aq8uhk+
	 0nQEZmaSYGaYeab0T95jQNgokdOVXDvWqCKRbv1brMybo8X5j9mxlJZHmt2sicz9+E
	 a7jZVz+WdZBYA==
Date: Thu, 8 Oct 2026 21:49:07 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: serial: snps-dw-apb-uart: Add Synaptics
 sl2610 uart
Message-ID: <asefUxK90dlGkW8a@xhacker>
References: <20261005151918.25259-1-jszhang@kernel.org>
 <20261007-450d3d9a4f4a2c07cc088067@squawk>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261007-450d3d9a4f4a2c07cc088067@squawk>

On Wed, Oct 07, 2026 at 02:04:05PM +0100, Conor Dooley wrote:
> On Mon, Oct 05, 2026 at 11:19:18PM +0800, Jisheng Zhang wrote:
> > Add the compatible for the UARTs of the Synaptics SL2610, which are
> > compatible with the Synopsys DesignWare APB UART.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> > 
> > since v1:
> >  - use sl2610 instead of sl261x
> >  - send as a separate patch
> > 
> >  .../devicetree/bindings/serial/snps-dw-apb-uart.yaml | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> > index 664305de4986..a40f2737e71b 100644
> > --- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> > +++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> > @@ -34,7 +34,16 @@ allOf:
> >        properties:
> >          resets:
> >            minItems: 2
> > -    else:
> > +
> > +  - if:
> > +      not:
> > +        properties:
> > +          compatible:
> > +            contains:
> > +              enum:
> > +                - starfive,jh7110-uart
> > +                - syna,sl2610-uart
> 
> Is the number of uart resets on this device variable?

Yes, some uarts have only 1 reset, while others have two resets.

> 
> > +    then:
> >        properties:
> >          resets:
> >            maxItems: 1
> > @@ -80,6 +89,7 @@ properties:
> >                - starfive,jh7100-hsuart
> >                - starfive,jh7100-uart
> >                - starfive,jh7110-uart
> > +              - syna,sl2610-uart
> >                - ultrarisc,dp1000-uart
> >            - const: snps,dw-apb-uart
> >        - const: snps,dw-apb-uart
> > -- 
> > 2.53.0
> > 


