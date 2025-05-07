Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370BC522A;
	Wed,  7 May 2025 02:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746583266; cv=none; b=UpPNqaEBJB5G634u95WFTuMKp1zeACgW098CnA7dMIKlr8PBmfOeiYCOGV2iv2oIwb1ADG8eOsst4HIQX5JSr6+Y2dJDsgUGHJa+m/c95V3LDBVmoTwzinYV5T/d3mf5miojR/aS5NBR3Z7tvJREenSyBhzZdHDyPETGcvv0z5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746583266; c=relaxed/simple;
	bh=VgNvse4H/eq2OujE04ZDZ9sBxsDAQBAPeSCn++qNUdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qOFz+/M6qE+yh3mK7G/Axb0ObdZlpsaE+PsJN8sDauvlGyOIUBUWTJJAAhQ0oIKdtKzIE8s7xn31ThONUU1Sg6uLU+u7g/PR8OKDRjjzr115G2uEFR4I9bjLOrbnGfhbQg98mgxUK2rsuHecTMO5IqXp+WvROiAsBgy//swPlvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvH8q1cH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvH8q1cH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941ADC4AF0B;
	Wed,  7 May 2025 02:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746583265;
	bh=VgNvse4H/eq2OujE04ZDZ9sBxsDAQBAPeSCn++qNUdw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kvH8q1cHU9ArVwtm7svXH4sEKgSJq2xKNK93D+IxlEtejoNnRRpGCL//rYCSKwLCB
	 rMKmfPl64IIFk18Sd2LWGSu/6WEYMfRCUVKyDkJbhUS62L/MVR0/v0A7Q7b544QNmC
	 w+tQPVVMrHYcMANmHZqrTUEQw0nUPYJun+o6gcs0dqMvHIKu+0tJhD7yA+Q16B9ZPJ
	 bhzHqZLJGx/9oc6dCRTToTIR3WVN804/eTBWCI/vkUgS4r9VryAqnKyL6MgKCT0sn+
	 jyqwAU/wTtnFoczmEjlVnmWKCio+YJvoWEXQFOUQqBl1t8Ob2PbPP3aOJnN2NzUFK3
	 aHeYPpJTRMVlA==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so1154529066b.3;
        Tue, 06 May 2025 19:01:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUKNYgVGCgCK64BM15zuOZ1v9Po9ulnyi8oXW16tpZipUE2xfRVosyoXnNh3SOD7QiHmd1vTFoUNtf@vger.kernel.org, AJvYcCWg99T0+6y0uKmnzZGsnaTjVhBu0Fu4rEq2wakoM7WE1iIDXSEMKcsjLs2ZSJvnkV1pgbJrKzuhk31+KQXl@vger.kernel.org, AJvYcCXJoGHYl3PUPwUWOa9Ua7T6fBvgTi449vChcK4tpk77Re4+bDSeEDveitZZWCTlAf0ZPFP72Nj8RxNtAlXk@vger.kernel.org
X-Gm-Message-State: AOJu0YwuT1uaGX8PYvxtA0HAxBcfRsKWhBX22eW5SbKeeTpt0hURZirA
	54pllSMbzQe9rqJUEED+NCaeoMC8w7p8AWB84diSXXzaRQ9t2O0IBMKJTd8Bjon+3gEQ53Kn3Is
	xB88h/YuIr3dbAnVPpZ+w6LCCkg==
X-Google-Smtp-Source: AGHT+IFiAj1U3tUkZvUUEVDNltfangwBzZ/T7uwjxTYdZcRTQVGly0mhbRkPnXukD/bEJ4ZRfAqpBpEO/PQuULnmuII=
X-Received: by 2002:a17:907:728f:b0:ac2:a473:4186 with SMTP id
 a640c23a62f3a-ad1e8ce60b2mr125905166b.34.1746583264066; Tue, 06 May 2025
 19:01:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506220044.2546706-1-robh@kernel.org> <20250506221751.t3iwqquzjgysjaai@pali>
 <CAL_Jsq+T-NZE1--VN7J2c5GbpG8d4nWpfceKE=ZGg3wfXn5iFQ@mail.gmail.com> <20250506225009.satvy4xjp2pq2h6p@pali>
In-Reply-To: <20250506225009.satvy4xjp2pq2h6p@pali>
From: Rob Herring <robh@kernel.org>
Date: Tue, 6 May 2025 21:00:52 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLVfdayMi=Sbe+LP5-4zvvR-tao3xEVVVB52SN-3S0DWw@mail.gmail.com>
X-Gm-Features: ATxdqUHeeIhWJFFr3u_6cfFYhKwfquu2Jxv_pOMIL7pn6lfEI2D6K-QY6iv1uGw
Message-ID: <CAL_JsqLVfdayMi=Sbe+LP5-4zvvR-tao3xEVVVB52SN-3S0DWw@mail.gmail.com>
Subject: Re: [PATCH] irq-names dt-bindings: serial: Convert
 marvell,armada-3700-uart to DT schema
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 5:50=E2=80=AFPM Pali Roh=C3=A1r <pali@kernel.org> wr=
ote:
>
> On Tuesday 06 May 2025 17:45:06 Rob Herring wrote:
> > On Tue, May 6, 2025 at 5:17=E2=80=AFPM Pali Roh=C3=A1r <pali@kernel.org=
> wrote:
> > >
> > > On Tuesday 06 May 2025 17:00:41 Rob Herring (Arm) wrote:
> > > > Convert the Marvell Armada-3700 UART binding to DT schema. It is a
> > > > straight-forward conversion.
> > > >
> > > > Drop the long deprecated single interrupt support.
> > > >
> > > > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > > > ---
> > > >  .../serial/marvell,armada-3700-uart.yaml      | 102 ++++++++++++++=
++++
> > > >  .../devicetree/bindings/serial/mvebu-uart.txt |  56 ----------
> > > >  MAINTAINERS                                   |   2 +-
> > > >  3 files changed, 103 insertions(+), 57 deletions(-)
> > > >  create mode 100644 Documentation/devicetree/bindings/serial/marvel=
l,armada-3700-uart.yaml
> > > >  delete mode 100644 Documentation/devicetree/bindings/serial/mvebu-=
uart.txt
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/serial/marvell,armad=
a-3700-uart.yaml b/Documentation/devicetree/bindings/serial/marvell,armada-=
3700-uart.yaml
> > > > new file mode 100644
> > > > index 000000000000..fa454337f06f
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/serial/marvell,armada-3700-=
uart.yaml
> > > > @@ -0,0 +1,102 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/serial/marvell,armada-3700-uart=
.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Marvell Armada-3700 UART
> > > > +
> > > > +maintainers:
> > > > +  - Pali Roh=C3=A1r <pali@kernel.org>
> > > > +
> > > > +description:
> > > > +  Marvell UART is a non standard UART used in some of Marvell EBU =
SoCs (e.g.
> > > > +  Armada-3700).
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - marvell,armada-3700-uart
> > > > +      - marvell,armada-3700-uart-ext
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  clocks:
> > > > +    maxItems: 1
> > > > +    description:
> > > > +      UART reference clock used to derive the baud rate. If absent=
, only fixed
> > > > +      baud rate from the bootloader is supported.
> > > > +
> > > > +  interrupts:
> > > > +    minItems: 2
> > > > +    items:
> > > > +      - description: UART sum interrupt (deprecated single-element=
 form)
> > > > +      - description: UART TX interrupt
> > > > +      - description: UART RX interrupt
> > >
> > > I think that this is wrong description and does not match the old txt
> > > description:
> >
> > It's correct that a single irq entry is deprecated, but I did say I
> > dropped that. So "(deprecated single-element form)" should be dropped
> > here.
> >
> > > - Must contain three elements for the standard variant of the IP
> > >   (marvell,armada-3700-uart): "uart-sum", "uart-tx" and "uart-rx",
> > >
> > > - Must contain two elements for the extended variant of the IP
> > >   (marvell,armada-3700-uart-ext): "uart-tx" and "uart-rx",
> >
> > Note that the descriptions don't really match this either. Expressing
> > it correctly makes the schema worse (using a oneOf) and doesn't
> > improve validation. We have interrupt-names correct, so I think it is
> > fine.
> >
> > Really, no one has cared for 6 years about this binding and converting
> > it, so I'm not going to spend a lot of time worrying about
> > descriptions. There's a 1000 more to do.
> >
> > Rob
>
> Sorry, but when I sent you some DT yaml changes, you have not responded
> for a year, even after periodic reminder. After this experience I have
> no reason to spend any more time on DT yaml as it makes no sense for me
> to work in my spare time on something which will ends in the trash.

If you send patches to the DT list, I pretty much guarantee I (or
another maintainer) have responded. You can check the status in PW[0].
If I've already acked/reviewed or they failed automated testing, then
generally I don't look at them again (because someone else is going to
apply them). Sorry, but that's all I can guarantee I'll get to with
the firehose of binding patches. As we speak, I've got 200 patches in
my queue. I don't see anything in lore[1] where I didn't respond under
those conditions.

Rob

[0] https://patchwork.ozlabs.org/project/devicetree-bindings/list/
[1] https://lore.kernel.org/all/?q=3Df%3Apali%40kernel.org+s%3Adt-bindings
