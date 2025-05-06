Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9634B1E7D;
	Tue,  6 May 2025 22:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746571813; cv=none; b=ZvWF1OdMe9/9pPj/uIohOjC6ktKoGhpWeqPfmP8Qs2tq+o2PaGLCSghIH5Ke5qKbS24jit+vDZv2MzYWEm2CFrSF8vrUqiYY2iRGUCPFaw9SG5ulmaSOAW+/NWcEbMrgMEj5dk91v9qC6gokZkBth92qIVZu+hmvraOWi6H4Tas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746571813; c=relaxed/simple;
	bh=nPQNJ+LuQ8mhvDIA3ucQ+VnXnX/LY5R7tvENgHvp0GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kc4pzrzqhsikApgaJmO/2Nb5jbIbGMtM33mHcXOh/BWmqh6Lr1DkCQwY4RO2iWDPxs+nNGGFu4JiTI3gqSkM7cS2PzC2DQi2JmFpKNv9BovIxP2AlOa5kgzEwNljUBar3uP/gevQ4EprUn0gzLWva7mg5fyswRBK5ZVlqk207dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvTadQ3d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvTadQ3d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB72C4CEE4;
	Tue,  6 May 2025 22:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746571813;
	bh=nPQNJ+LuQ8mhvDIA3ucQ+VnXnX/LY5R7tvENgHvp0GA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gvTadQ3dUolqM0RZqFtGVvan3ciSjW1UmeEzmcbhOr6SR06VOgIajifI4tVMN7kwS
	 WoqdKqwk/cBYMO22Nos7QHgLiDbyaDFZjm5g4SOG/WbaubNKbJuEWE9tWNPQFdtAby
	 GG/lSkX4yR8EHth/X0qA/UAliueHZE9Lwxvr9ulWHI4BWQ2e/t05kj29LICUqNDONQ
	 pqeAQq9n3pzX4z+xOo5BmNAD9IriHuRJ61ovy/DhUn5UBgtK762/0lJkvJ/KzeFM8L
	 edAGvzS0k3cPxrt3xJ/84/l5FY0oYiJAa2VuCjlgDK0ShtevfcvfTArWC9DrKF8Bor
	 Gu559R1GrLmLw==
Received: by pali.im (Postfix)
	id C82A067E; Wed,  7 May 2025 00:50:09 +0200 (CEST)
Date: Wed, 7 May 2025 00:50:09 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] irq-names dt-bindings: serial: Convert
 marvell,armada-3700-uart to DT schema
Message-ID: <20250506225009.satvy4xjp2pq2h6p@pali>
References: <20250506220044.2546706-1-robh@kernel.org>
 <20250506221751.t3iwqquzjgysjaai@pali>
 <CAL_Jsq+T-NZE1--VN7J2c5GbpG8d4nWpfceKE=ZGg3wfXn5iFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+T-NZE1--VN7J2c5GbpG8d4nWpfceKE=ZGg3wfXn5iFQ@mail.gmail.com>
User-Agent: NeoMutt/20180716

On Tuesday 06 May 2025 17:45:06 Rob Herring wrote:
> On Tue, May 6, 2025 at 5:17 PM Pali Rohár <pali@kernel.org> wrote:
> >
> > On Tuesday 06 May 2025 17:00:41 Rob Herring (Arm) wrote:
> > > Convert the Marvell Armada-3700 UART binding to DT schema. It is a
> > > straight-forward conversion.
> > >
> > > Drop the long deprecated single interrupt support.
> > >
> > > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > > ---
> > >  .../serial/marvell,armada-3700-uart.yaml      | 102 ++++++++++++++++++
> > >  .../devicetree/bindings/serial/mvebu-uart.txt |  56 ----------
> > >  MAINTAINERS                                   |   2 +-
> > >  3 files changed, 103 insertions(+), 57 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/serial/marvell,armada-3700-uart.yaml
> > >  delete mode 100644 Documentation/devicetree/bindings/serial/mvebu-uart.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/serial/marvell,armada-3700-uart.yaml b/Documentation/devicetree/bindings/serial/marvell,armada-3700-uart.yaml
> > > new file mode 100644
> > > index 000000000000..fa454337f06f
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/serial/marvell,armada-3700-uart.yaml
> > > @@ -0,0 +1,102 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/serial/marvell,armada-3700-uart.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Marvell Armada-3700 UART
> > > +
> > > +maintainers:
> > > +  - Pali Rohár <pali@kernel.org>
> > > +
> > > +description:
> > > +  Marvell UART is a non standard UART used in some of Marvell EBU SoCs (e.g.
> > > +  Armada-3700).
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - marvell,armada-3700-uart
> > > +      - marvell,armada-3700-uart-ext
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    maxItems: 1
> > > +    description:
> > > +      UART reference clock used to derive the baud rate. If absent, only fixed
> > > +      baud rate from the bootloader is supported.
> > > +
> > > +  interrupts:
> > > +    minItems: 2
> > > +    items:
> > > +      - description: UART sum interrupt (deprecated single-element form)
> > > +      - description: UART TX interrupt
> > > +      - description: UART RX interrupt
> >
> > I think that this is wrong description and does not match the old txt
> > description:
> 
> It's correct that a single irq entry is deprecated, but I did say I
> dropped that. So "(deprecated single-element form)" should be dropped
> here.
> 
> > - Must contain three elements for the standard variant of the IP
> >   (marvell,armada-3700-uart): "uart-sum", "uart-tx" and "uart-rx",
> >
> > - Must contain two elements for the extended variant of the IP
> >   (marvell,armada-3700-uart-ext): "uart-tx" and "uart-rx",
> 
> Note that the descriptions don't really match this either. Expressing
> it correctly makes the schema worse (using a oneOf) and doesn't
> improve validation. We have interrupt-names correct, so I think it is
> fine.
> 
> Really, no one has cared for 6 years about this binding and converting
> it, so I'm not going to spend a lot of time worrying about
> descriptions. There's a 1000 more to do.
> 
> Rob

Sorry, but when I sent you some DT yaml changes, you have not responded
for a year, even after periodic reminder. After this experience I have
no reason to spend any more time on DT yaml as it makes no sense for me
to work in my spare time on something which will ends in the trash.
