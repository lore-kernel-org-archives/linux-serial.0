Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEBADF5C;
	Wed, 28 May 2025 02:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748399200; cv=none; b=UiXxESE29jrWZlVzvTQs1UGfv2YAA9RwJaZKtVlF0unfJ5Ip/GFMWrzg26ZipyneySzCp2OymuQV72WJC3PlIrdKslmufij3KvuRMdkXlVgdxajXmCb3dlegeHmLFqR4eLvyK4cGEUjwRVVOInvV+PY65XZvVqsr0Ce6+I5Y9KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748399200; c=relaxed/simple;
	bh=vfulN77fTygHJL04EB4mEbOCA/3jWIfOkUggo54Gx8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvt0UsHwE6hABD0QxMm4SgiPNJw1udpKG+QdDMqTsct3U+s34zfHTStTzZFhGdH8kaDIEl6W7qp6I5tzkerNFxyELEZ/j2rfKclsQ6eC2PUwyE5at48afcP6e/fzGfYvG+yStrSOrRb5rPwMaSsc5cpn4UlBf+EAd7VFz6FcfYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=F50S5oMe; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="F50S5oMe"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 1E8B925EBB;
	Wed, 28 May 2025 04:26:29 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4PY_1hSbsrZz; Wed, 28 May 2025 04:26:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1748399188; bh=vfulN77fTygHJL04EB4mEbOCA/3jWIfOkUggo54Gx8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F50S5oMeEn8XHycWt54tQ0SU7fGgPg8XC6Cfl7T1xUpGstB4ecDYDDjqAsAXLTrw3
	 Qrajm/+I7mdep+OOk5/2P64CEU2M2IQsUEDvy0hDL8vlH1kwS+S6o3kr7KD/KUP1yC
	 +0+BoYFtmGmOlaX0ThHgMaDqYM9XWWrk1N9mt9cOlIBwOwHa2ZV5nCwWNY4+eRLYsD
	 PApm3NQ60kPAtedOiLMrvVCqJ4lrHy7DCvFtki71aPt8JjKJ6n8BK446p6nOGKP06T
	 2e+NJIBFyOYiMeyDlK62xZKFE4wgUOPuVlSJ6rr8oDl8MziLKkm2sVcFLKzerAsnGo
	 dG0tZVC3dg2Og==
Date: Wed, 28 May 2025 02:25:56 +0000
From: Yao Zi <ziyao@disroot.org>
To: Conor Dooley <conor@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: 8250: Make clocks and
 clock-frequency exclusive
Message-ID: <aDZ0NPg2UCVZisk2@pie.lan>
References: <20250524105602.53949-1-ziyao@disroot.org>
 <20250527-polio-snooze-c05aafc1e270@spud>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527-polio-snooze-c05aafc1e270@spud>

On Tue, May 27, 2025 at 04:24:11PM +0100, Conor Dooley wrote:
> On Sat, May 24, 2025 at 10:56:02AM +0000, Yao Zi wrote:
> > The 8250 binding before converting to json-schema states,
> > 
> >   - clock-frequency : the input clock frequency for the UART
> >   	or
> >   - clocks phandle to refer to the clk used as per Documentation/devicetree
> > 
> > for clock-related properties, where "or" indicates these properties
> > shouldn't exist at the same time.
> > 
> > Additionally, the behavior of Linux's driver is strange when both clocks
> > and clock-frequency are specified: it ignores clocks and obtains the
> > frequency from clock-frequency, left the specified clocks unclaimed. It
> > may even be disabled, which is undesired most of the time.
> 
> That sounds like an issue in the driver itself, no? If the clock phandle
> is present it sounds like the driver should be claiming the clock
> whether a frequency is specified or not. If so, that should be fixed
> whether this patch gets applied or not.

Agree.

> > 
> > But "anyOf" doesn't prevent these two properties from coexisting, as it
> > considers the object valid as long as there's at LEAST one match.
> > 
> > Let's switch to "oneOf" and disallows the other property if one exists,
> > exclusively matching the original binding and avoid future confusion on
> > the driver's behavior.
> 
> Have you checked whether or not there are devices that have both
> in-tree? If there are, can you fix them up as part of the change, rather
> than adding new warnings.

Had taken a brief search, seems all UARTs ship both clock-frqeuency and
clocks properties are snps,dw-apb-uart variants, which are not related
to the generic 8250 binding. So I think it shouldn't cause new warnings.

> > 
> > Fixes: e69f5dc623f9 ("dt-bindings: serial: Convert 8250 to json-schema")
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > ---
> >  Documentation/devicetree/bindings/serial/8250.yaml | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
> > index dc0d52920575..4322394f5b8f 100644
> > --- a/Documentation/devicetree/bindings/serial/8250.yaml
> > +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> > @@ -45,9 +45,13 @@ allOf:
> >                    - ns16550
> >                    - ns16550a
> >      then:
> > -      anyOf:
> > -        - required: [ clock-frequency ]
> > -        - required: [ clocks ]
> > +      oneOf:
> > +        - allOf:
> 
> Why is the allOf needed here? Does
> oneOf:
>   - required: foo
>   - required: bar
> not work? There's a bunch of bindings doing that, so not sure why it
> doesn't work in your case.

Oops, you're right, it does work here and emits an "... is valid under
each of ..." error. Will change to this form in v2.

> Cheers,
> Conor.
> 
> > +            - required: [ clock-frequency ]
> > +            - properties: { clocks: false }
> > +        - allOf:
> > +            - required: [ clocks ]
> > +            - properties: { clock-frequency: false }
> >  
> >  properties:
> >    compatible:
> > -- 
> > 2.49.0
> > 

Best regards,
Yao Zi
