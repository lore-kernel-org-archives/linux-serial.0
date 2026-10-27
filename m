Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793135226;
	b=ecFBWfBinUBcZZpqm+9n1TRzybevpHqAaYoUUelEqKfohIZgoHoKOWTXrqVkIODd5/fi
	 W3dC0MOt9j0hDly2bdlU8qSu2RNvJ+e8NJMLBzaoezNfT7hI89ZNrh5z8/yLj7EbtO9Y2
	 LMQIHN//Ga8zzv2vYpOW4IX+AOwuA4pyFNjs3HBkFNnGlmyS6VCQqj0nhyt5o0CWREJr/
	 ElTccXTygwxftv8wIg6paKoM2htML0+UOv2YnZ/yCvRLbyYfSb5sRQ36LfI1y+xRy1uq9
	 gv3FN0+tu8lzekCxy9BS4lUMSoVLgjs/fIiLHqhSZP9u4FYludKzkl/ic9S3Ej/3t1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793135226;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=dhiQkFXajssFfdQm0/XVZOyaTKHqLvZL8I8B+3smf8I=;
	b=FZXWG6cOEpSHiNsTWT8KzisXUd8ap8lcc4EuG79Z4OUO0fFyk9ZnnZXPsPVYgsMMVnsy
	 EAzAR4ZJJBh3KYu1NjfSphOCSb2TMw47dBU56DuUyH1HVjdsqQsBUSLGk1PYbtpGHlZ9/
	 wBKW8t8s0PBxbwbBEpQRfJEh20N6GHp1ysAz1DKDk5OY+QsvAZsPRlS3slQsYdG+CboMM
	 uaLxS8GwuW5KLUXeDxCCT2M8kWmcdR7/yj1t86Ly5AAbI0zeukEyJ/rviFkVRD8kaSG8y
	 tXi6flaDJHYB7RliFm7gYtgwrlr+A3d2ORuAKAIQO3h+flAMjzj9wZUiM6AAal1Thhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ggcFAE+1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EBD606A31F;
	Tue, 27 Oct 2026 21:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ggcFAE+1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84D71F01828;
	Tue, 27 Oct 2026 21:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793135226;
	bh=dhiQkFXajssFfdQm0/XVZOyaTKHqLvZL8I8B+3smf8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ggcFAE+1D+RSsplxMrMS76Sbh4+yrOX72umRosL+KKVrS/wlX5TU/oJg3TTlBuH+Y
	 VGeQcDauUe4Yw7kK1twxV5Cna3gpWDuRHffkmswPkqD+fJwJ/KQftNRjyafciIJvzB
	 0ynSl4kEgnA6tAWrpYMwwqVRzn6TcqiPILynqSS+IFdQHPu37QmqzNXgLkS2zoL5Li
	 CxFZaJMfz38KwoKsAP7OAyLMOJBVZaSyYTFG4ZFxh7omeyoRfKVJM0SMxI2nZ2Iv+V
	 DZpZEp3YUJcE5XDiUfxZbR1huCJauGytyeSeaTMbCqD1v571LDKgZ+vsu8IkCiS8ND
	 CDg93Y0e2cqCQ==
Date: Tue, 27 Oct 2026 16:07:02 -0500
From: Rob Herring <robh@kernel.org>
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-m68k@lists.linux-m68k.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: serial: create binding for mcf-uart
Message-ID: <20261027210702.GA948124-robh@kernel.org>
References: <20261013120831.1046590-1-gerg@linux-m68k.org>
 <20261013120831.1046590-5-gerg@linux-m68k.org>
 <20261014-expensive-shrewd-nautilus-abcab6@quoll>
 <d256f39c-6ed5-409a-a7ed-224165d00521@linux-m68k.org>
 <CAMuHMdUcGt7RBc0d1A-8O1Dt71RL=epPgmnetj_4NGCPvCj9LA@mail.gmail.com>
 <73a8df68-17da-4275-bb9d-8a6272b754e6@linux-m68k.org>
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
In-Reply-To: <73a8df68-17da-4275-bb9d-8a6272b754e6@linux-m68k.org>

On Thu, Oct 15, 2026 at 11:14:26PM +1000, Greg Ungerer wrote:
> Hi Geert,
> 
> On 15/10/26 19:19, Geert Uytterhoeven wrote:
> > On Wed, 14 Oct 2026 at 14:56, Greg Ungerer <gerg@linux-m68k.org> wrote:
> >> On 14/10/26 21:24, Krzysztof Kozlowski wrote:
> >>> On Tue, Oct 13, 2026 at 10:07:02PM +1000, Greg Ungerer wrote:
> >>>> Create documentation for a new binding to support the Freescale ColdFire
> >>>> UART hardware block. This is found on pretty much all variants of the
> >>>> M68K derived Freescale ColdFire family of System-on-Chip devices.
> >>>>
> >>>> It is not compatible with any other known UARTs.
> >>>
> >>> You never tested this, so limited review.
> >>
> >> It is tested. It is working and running on multiple ColdFire platforms.
> >>
> >>>> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
> > 
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/serial/fsl,mcf-uart.yaml
> > 
> >>>> +properties:
> >>>> +  compatible:
> >>>> +    const: fsl,mcf-uart
> >>>
> >>> What is the SoC name? MCF? Compatibles must be specific (see writing
> >>> bindings doc).
> >>
> >> Yes. MCF = "Motorola ColdFire". It is the SoC prefix used for naming of all
> >> ColdFire parts (which is dozens of variants):
> >>
> >>    MCF5206
> >>    MCF5208
> >>    MCF5307
> >>    MCF54415
> >>    etc
> >>
> >> Even when Motorola became Freescale they stuck with MCF on all ColdFire parts.
> > 
> > I guess you want:
> > 
> >     items:
> >       - enum:
> >           - fsl,mcf5206
> >           - fsl,mcf5208
> >           - fsl,mcf5307
> >             [...]
> >       - const: fsl,mcf-uart
> > 
> > As no new (possibly incompatible) Coldfire parts will appear, a generic
> > fallback looks reasonable to me.
> 
> It will be a long list of variants - thanks Freescale. Quite a few of the SoC
> parts have sub-parts with different single digits, for example:
> 
>     mcf54410, mcf54415, mcf54416, mcf54417, mcf54118

I imagine all of those are just package or marketing differences. 
Freescale did not have the money to tapeout 5 different parts. Just 
using one compatible for all of them is fine. 

> At a quick count I can see about 42 variants. 
> I don't mind adding the full list if that is preferred.

Just add what you care about or know people use. I imagine that's a much 
smaller subset.

Probably not many users today of the 5272 I worked on which was designed 
for ISDN modems.

Rob
