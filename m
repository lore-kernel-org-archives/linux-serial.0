Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793093998;
	b=plqM6OhB4qYs/pxWlaB0J8ZAtq04gOgs9543rHnDT/tV0RaYSHBMatqqFh10ShgXdw0Y
	 k6uc+J/C9CQ73PC3q1/8oG3iWOCKRMFe+7uTBLOSnv6qY66PkM0CiV5qVWh30J9SZneNj
	 Hdpd3yNYRtiZL93Uf/cFwjnAmxcW5Ap57A9wmLwciESLHazN6z9l7iO89pMtrcvsIZ2k0
	 8mhHnQ3UyORPijy6nn1mdsBdxp4yA1DRUaB4hhuaDaxccvQy8HQz1XpvUJcdQzIjvrv85
	 bRsgskeym5dJcm/1Aa0jOZ4itqL0Wd9yEUj9QboTld2n8X0Rwv4PSulo71x5ikD0yLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793093998;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4X+P1B6aE29va33Y1nOTBGckjA6+hBF4dxDZ8irecEY=;
	b=AhFk6vkuxE8wEyi2z2hDa6swuYZoOWRx2qNApoIRWkU6IZxET+fXoO9z4cuOo86BBaTI
	 XhEQp7krIwoi1Wxh5wv3EFbAK4U/Rp6DvmFOE8Gp2BW6vr68Dnea4+/o+UGmUj6FfTQwn
	 QvY1IjOmoNa5F+OYxajlHvghvv8qAHHMB+6Z06JIpHU1avqyzR5jWaiRRiegHFmQVPIJN
	 jK3YcDs8e85tUuofyW90/vP7UWM0lesSvcwS7yd7W62ZoUyDs3s2taezdSxnJ7CNqaJk3
	 WuDSaMa+rfJ6J3MmQOaISqxWbLPqhdqIBvoXtpjHRZFBltz2qR0w4/IfQLXlGWlUsXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jbgipqXk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.47
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34382606A320
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 09:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34382606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jbgipqXk
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7c3b75caad1so2447533137.0
        for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 02:39:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793093997; cv=none;
        d=google.com; s=arc-20260327;
        b=Q0bHUOT6z8vK+zICmevz/ExjsQ4I+t2u0uTdM/ZwLg5s8K4Jjo/XG124pBoC7crGi9
         ur+ww/2Ggrlo2zt9o9JTL9/G586eZy9NuSFLkL6DT5Vrp/ZgsfOWzc398EqeaUqiZcQF
         f3Om0JtJGaUcz3BuqNq0tF8i4YlsE1dHeNMdyWtRHYl2xfgUQOTkT3V7lcB0Vss6O959
         jnx8B8aS/lfksMBxlzPLexOcpUqB6MOQ69WfjeDrqxwW6fQiurvvpiEIcJ6xHgpOeaXd
         XoHFYN1B7BE3rspaWo8rnNspTCAfQ1+boDWF5Gx2bLPm8ngam/knd+5GooCxWsGPQwL/
         7Xsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4X+P1B6aE29va33Y1nOTBGckjA6+hBF4dxDZ8irecEY=;
        fh=O/pi0C+MSddbo7Wf7GXqwTfIKfgby5I7IzuokuT58Vw=;
        b=VLkvTTVLK0Mt/1t+KTUACrW6r8TX5Zht6l9ft4gC+m4jgfVmnQX31tHY6jf34m0rVo
         41ebqtNNhRVCq34iqklpaCtp87mWdDlI3wTsonoHINLVTrMZmasckiQjv7vrY63U9zfu
         BN+vfLsik9oGpetl7rJzqNcsosn/SKkUVTFpYRbdXrd9nWZm78gBeKv7QEoCU120e8Nz
         9wnO2oMnBdLiT+TH9Ywt9hVhl544ZUKnubs7C1hkuOMzYv0LVGzZZKGd8mf9z2RjPjuc
         bBJsxVjMYky9PwEOtAZZebsCErHNUVHChENuxl5WHQCm0JA8kSreEIJiiXraVNk4I+2U
         sKfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793093997; x=1793698797; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4X+P1B6aE29va33Y1nOTBGckjA6+hBF4dxDZ8irecEY=;
        b=jbgipqXk/6TNxEbvLlNc6gdZFS7gSzHiaIXUNfVVdN3q94F07nj9GzMabdiRQsRP+F
         o/XOGFypEw+wijhGjN7sQwjWm4BFklcLI3EBtfWyHhpoHYyUZDxdDMQdWr4JXihw3R58
         aHsrl0M0NfG9pSxGqRcD/Nj5Z+tc0m1rfTN0Y2sd+xO8Kck0FHRfCAXgRO8+J2Q0vNrS
         2iExoS6IytX97KV5mB7bJwKQm8JXIZn1GzCAUfz82AMiashJtm976jYvCEHFiaX2Zinr
         8VHyvlk4eUGocaj55+e67vOmZIT54wKJpIJJmqyE8/3zevjyHZDXFpv8mqRRBPiZ/LsY
         +WKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793093997; x=1793698797;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4X+P1B6aE29va33Y1nOTBGckjA6+hBF4dxDZ8irecEY=;
        b=czCMKrCnUeuDeQLH39Ocl/sKPnJLTdbkvJThXDK2LGh6EYNjU1gSZaDQrVZ5qpLiU+
         mWsMdpY5p7VLjgFUulo4KGoeouifz0sm/+tR1VwaFgaodZp3H6griQZFZC1Sd2bAjYhv
         7jQ+KAHFw+fDA4IPAbYPQjgf61yr21zbsvJBFVI0RB5BDB9a3MOw0v44z8AqAODhy6N+
         V0Hary/YaCR9usZJ2SH4lULnVuugANH1M36kdOMSDsUEyz7CukAZaQm9pebJ+w/pAFXO
         6rd2ekJ4HUygnhin8DJOskuLyZ6u0sB78FuY+fyk1+A+kokGiXP2WDxipf/AeaAs6lus
         g42g==
X-Forwarded-Encrypted: i=1; AKwUvBxS/gyIs2rzpLhxZq4OOcmIaXCaUu+rgQl9079LAMfCeLt7sb98zHyKDIKyUiOQxwFMZWPKf5MOk09v2Z8=@vger.kernel.org
X-Gm-Message-State: AFq9FYILIZDvLaR+qppHvASZsQFs74jiWGif9EGPmHFGubvNQD7lO+k0
	Bz2ycRkZJ2cAaqJgC6y30py8t9KzDNgVvLRJF3ANF42iJaF/tdsNFrctLzf3Xh+BaL/+EIxdxkr
	Bb/cVjQAxkaSqJx1M6PNbu5uiQRUdaCG5ULK/0j0=
X-Gm-Gg: AYBFou1xMbRLwLYJwSFEFlph2GWLjO62crzOZskUgxTW2yr8q9GhA5Pjx1FMFX+PCZF
	paZtDefyrWdyqGaPzeLc+46/ST2nCRjglMwPYDGlA0tR6yiM6QqqEik4ZMmWTIeOQ8LmPNJrU5j
	wUNKsI5udEnfFNbRZqjUZ57FRqgH72R35UYr0ANlqLxAbNtmPbsSRCpljSXYNYCXsWDsLeriEMZ
	4EKuYwdNk9BFWL7IJeMDn9dqL92ZxQPGfBoDnc7bo+AzHxvOrBpff0NKCy/cOIoKwXrMCVRK+Rr
	QNQNUbfWUXyaoNEI0CNJtTRW+phl9/yDIJnHDF+AZr9yMEp5VG+D//cW95PnK2E42vtGQRF/cXX
	QbbCKtYfHj6ZqAtaNonyHvyM889pJqGgTtp+hqNYVP6sKZo9NnDuVNJJL4PH8v1duTp984MjEMv
	LHzUVaWU2mncDD07f31l7Akr/7tKjmewFl++XvlY4u1SRVMhVo/S8L0MVoqJmhHzaYTAbJQ4q2l
	X3zFPUwF7WhzOn76plNj6XgA1/tzw==
X-Received: by 2002:a05:6102:c8f:b0:7c0:4d52:8cc9 with SMTP id
 ada2fe7eead31-7ce5cc8d55dmr2986698137.14.1793093997186; Tue, 27 Oct 2026
 02:39:57 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024-submit-h616-uart-fifo-v1-v3-0-286fc1b8c3c1@gmail.com>
 <20261024-submit-h616-uart-fifo-v1-v3-2-286fc1b8c3c1@gmail.com> <20261027-nifty-reliable-octopus-6cbac5@quoll>
In-Reply-To: <20261027-nifty-reliable-octopus-6cbac5@quoll>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 27 Oct 2026 03:39:45 -0600
X-Gm-Features: AclHuK-P2vZ9SIQ1kD5xtHOmSa1lugBkFh7TQdGZgeHlLBc3Sp6mnxkEd0joV1c
Message-ID: <CADvTj4qrBYSyT39=xK3_oGgHdFoSH=oyDvTtLCSzW=F9KAgi3Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: serial: snps-dw-apb-uart: add
 Allwinner H616
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 2:02=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Sat, Oct 24, 2026 at 02:22:24PM -0600, James Hilliard wrote:
> > The H616 UART has 256-byte transmit and receive FIFOs, but its DesignWa=
re
> > component parameter register does not report the FIFO depth. Its option=
al
> > register layout also differs from the generic DesignWare integration.
> >
> > Add a specific compatible for the integration and allow the standard
> > fifo-size property to describe the capacity. Require the documented
> > 256-byte size for H616, retaining snps,dw-apb-uart as a fallback.
> >
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> >  .../devicetree/bindings/serial/snps-dw-apb-uart.yaml    | 17 +++++++++=
++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.=
yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> > index e2ca126d58ba..0f8fd0485879 100644
> > --- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> > +++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> > @@ -13,6 +13,18 @@ allOf:
> >    - $ref: serial.yaml#
> >    - $ref: rs485.yaml#
> >
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: allwinner,sun50i-h616-uart
> > +    then:
> > +      properties:
> > +        fifo-size:
> > +          const: 256
> > +      required:
> > +        - fifo-size
>
> Why do you require fifo-size if is const? It is implied by the
> compatible.

H616 has a fixed depth, but other sunxi integrations have different
depths between UART instances. For example, D1 has 64-byte FIFOs on
UART0 and 256-byte FIFOs on UART1=E2=80=935.

Should I keep this explicit for consistency for all sunxi uarts?

>
> > +
> >    - if:
> >        properties:
> >          compatible:
> > @@ -60,6 +72,7 @@ properties:
> >            - const: renesas,rzn1-uart
> >        - items:
> >            - enum:
> > +              - allwinner,sun50i-h616-uart
> >                - anlogic,dr1v90-uart
> >                - brcm,bcm11351-dw-apb-uart
> >                - brcm,bcm21664-dw-apb-uart
> > @@ -120,6 +133,10 @@ properties:
> >        - const: tx
> >        - const: rx
> >
> > +  fifo-size:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: Transmit and receive FIFO capacity in bytes.
>
> Drop property, not used by any of the devices here.
>
> Best regards,
> Krzysztof
>
