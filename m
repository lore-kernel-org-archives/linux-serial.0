Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D67F2F6928
	for <linux-serial@vger.kernel.org>; Fri,  9 Jan 2026 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767953552; cv=none; b=hEhI3y5PG0wKXeaqhHtpghMRnXP+PpYSjeipfc37c29w7kb9Ye6RE3a2jE4vVXvR2wy85CprbynNlxtDMXcGAYtOMhO+3bNoHC87u70iRf+0ufhVFrJn9O89ctKRvRRC7Z07j2FadV3B+/WCkXA04Xasl0eJM0I9eW1f20k3aIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767953552; c=relaxed/simple;
	bh=/T9YXxLBZhhcjEgy2U8F8hoAFjHAttxAaJCuCBXxuR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CMHWwXjIX6eb+hziBPMcd7BgrXQEyuvRQ167ijuQsmf2j6p2xaqPR9C8mC/YgbzJ0/r4NU9HX2evlntvAveZu0whIZyS7a0cM8bBqGd2cMC1BsyT0zuhdVDc67EW1lC6AioyNq0QqAuFjLw40CQWeLIqjB3ADh8s86gNYkJN5Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=mXjM7V5r; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="mXjM7V5r"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-646b8d2431dso3461431d50.2
        for <linux-serial@vger.kernel.org>; Fri, 09 Jan 2026 02:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1767953549; x=1768558349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5UnQ4+RbLH5hA9T1G883ptw/7Yo4vuW1qZZcpMJdJQ=;
        b=mXjM7V5ry1w65ABMrH6YYPbUU2yTaiC9SgPnBoSpzA9tdbLq/HPJ13F8bPOcx3sdPM
         YKJWZE8eRCuOxJsmo2RZ6JxkKeo+GCGpdkL12hpTSzFe9bJq3UnAgpd1A+9eFriZOGqU
         /V7LOPfNz1yT7AQbwuUsdxCAMAs5LigeLNuiRg9jAU1bzCfPRFd11EFoafhBHbyaGYGv
         v+LSCXyCyukvqEjP1eWpwiSfxCot2KZ2IW+aWLmgr7wqpeBRFVkSdVGssT791bxrNoo7
         t4BV+sg0PARd4wMq/w8cL8qa7ghf7JBw8ggIbVUOJct5v+EI8zJIC7gwMlJj1LLkF/9F
         NznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767953549; x=1768558349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e5UnQ4+RbLH5hA9T1G883ptw/7Yo4vuW1qZZcpMJdJQ=;
        b=LRDD0AEbKG3YxuTRUVgJhSs9IABKdtwnvW8+dvVy20nko2X2IbWZy0oL5EarFX4ADO
         ItO1ZohyZUH/wPUCDRXVOtPh0fjhwKOEyuIXh/kllE9ExQecWCIMcf6p2/a8gIFsDq3I
         8hramCry1YPdcwAXS9vByXoMyl3h4x0wVflQLh1DRiiqZbuX1BTn2kV9DSWE66zax2tu
         ZM2yanS4i+9Cr5jITQWZ+IqpTseUKdH/6KtmNXIQfSwbWkr8dX5Pt5kY9GaVQ/5ipSg8
         QVN6V02G7oSwV9Cc3hEwrbQRDmu1mDDAyB/qS0XKqjQy7uBraVml+QIh41HgkkO2V3/N
         0nSw==
X-Forwarded-Encrypted: i=1; AJvYcCXcaKkztvrSeEqjspeoZNBYgIy0m2cNzt9SgMXv28aldwmv0HOkO9Ig4EwCJtDZhPjHzXI47rxxILIIQgM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy627LxPH6ABeXvlw06MRikuDeyhcjmRBYUn6unxJv9Z2ER0kJJ
	F22VAe67ooMSxXHItUp6xsc2RDWLoC7+bBEbOBXdHZAcGVwCawmSXYoMFuhgl3TDFd3BR9PNc8z
	CUE5S0mDW9IdLbfRQj6UOrAoFgGIUHW1k1s2pbe0tlA==
X-Gm-Gg: AY/fxX66s1MLfpesimbwgo7t6wexHSix9mA4z2BQ5l2yOZ5HSTyo5jZ9e3KDJYHZ/Dq
	YVn7buxOSlaV5TEjycCiufuq0VaGATc7R07HUYyFUbef94QhaC+IczQatPCRqYXHs6x+TwexxGl
	zbR5C5wGJ3Gz5oN/ruDoGYmiNnfDfFGt/VRdDtjFfjdVXacs4TwEs60mCGB8NsJM88aY7eC1mKL
	kPAZsez129EC5cFn7QrBjopBgl54hIsZ8LnvXP+qLi19LV6xL5EzCc29U4D5jDQNyE7atXOeJYj
	2I59631+gAFQEfA3TEJOhfjwr1qeMmcrHXSmsYLvfPk=
X-Google-Smtp-Source: AGHT+IHwjyG2gHAKynms5yLd8dsoBN0TrT6WXnJJkvqrEPM5Oh9NnNxT58LAnnyarsoeqkwGZZAXFc3fOBsckE359B8=
X-Received: by 2002:a05:690e:1488:b0:640:d255:2d75 with SMTP id
 956f58d0204a3-64716c5ff62mr7691411d50.48.1767953549269; Fri, 09 Jan 2026
 02:12:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108-k3-basic-dt-v3-0-ed99eb4c3ad3@riscstar.com>
 <20260108-k3-basic-dt-v3-5-ed99eb4c3ad3@riscstar.com> <20260109033608-GYA3681@gentoo.org>
In-Reply-To: <20260109033608-GYA3681@gentoo.org>
From: Guodong Xu <guodong@riscstar.com>
Date: Fri, 9 Jan 2026 18:12:17 +0800
X-Gm-Features: AQt7F2ruyJZja2_iA58MgeCUcAeuWdBMOblJYXEsXdoTwjRnAKOiZA60duu51-A
Message-ID: <CAH1PCMYCLweVJ8WG2VY0jAk6UBuGA138urgfZV9+0fVeqmbbEw@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] dt-bindings: riscv: spacemit: add K3 and
 Pico-ITX board bindings
To: Yixun Lan <dlan@gentoo.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Samuel Holland <samuel.holland@sifive.com>, 
	Anup Patel <anup@brainfault.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, Yangyu Chen <cyy@cyyself.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Conor Dooley <conor@kernel.org>, 
	Heinrich Schuchardt <xypron.glpk@gmx.de>, Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>, 
	Andrew Jones <ajones@ventanamicro.com>, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	spacemit@lists.linux.dev, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Yixun

On Fri, Jan 9, 2026 at 11:36=E2=80=AFAM Yixun Lan <dlan@gentoo.org> wrote:
>
> Hi Guodong,
>
> On 20:25 Thu 08 Jan     , Guodong Xu wrote:
> > Add DT binding documentation for the SpacemiT K3 SoC and the board Pico=
-ITX
> > which is a 2.5-inch single-board computer.
> >
> > Signed-off-by: Guodong Xu <guodong@riscstar.com>
> > ---
> > v3: No change.
> > v2: Use one-blank-space between name and email address.
> > ---
> >  Documentation/devicetree/bindings/riscv/spacemit.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/riscv/spacemit.yaml b/Do=
cumentation/devicetree/bindings/riscv/spacemit.yaml
> > index 9c49482002f768cd0cc59be6db02659a43fa31ce..fe62971c9d1f4a7470eabc0=
e84e8a747f84baf0d 100644
> > --- a/Documentation/devicetree/bindings/riscv/spacemit.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/spacemit.yaml
> > @@ -9,6 +9,7 @@ title: SpacemiT SoC-based boards
> >  maintainers:
> >    - Yangyu Chen <cyy@cyyself.name>
> >    - Yixun Lan <dlan@gentoo.org>
> > +  - Guodong Xu <guodong@riscstar.com>
> >
> sort by alphabet letter of first name?

Thanks for the review comments.
Sure, I can do that.

>
> >  description:
> >    SpacemiT SoC-based boards
> > @@ -26,6 +27,9 @@ properties:
> >                - xunlong,orangepi-r2s
> >                - xunlong,orangepi-rv2
> >            - const: spacemit,k1
> > +      - items:
> ..
> > +          - const: spacemit,k3-pico-itx
> if DT mainainer has no objection, I'd suggest to change to enum
>              - enum:
>                  - spacemit,k3-pico-itx
>
> although single enum is effectively equivalent to const, but easy for
> adding more boards in future (no change to previous code)..
>

Ok, I see your point. I can find there are other yaml files doing the same
style. If no other objection, I will change it to enum in next version.

BR,
Guodong Xu

> > +          - const: spacemit,k3
> >
> >  additionalProperties: true
> >
> >
> > --
> > 2.43.0
> >
>
> --
> Yixun Lan (dlan)
