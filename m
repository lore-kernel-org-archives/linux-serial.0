Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D944B1E4B;
	Wed,  7 May 2025 16:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746635602; cv=none; b=AlJ0HfJYGaJ2+1kcSwAr5jD/AteD3Ihh/mhASMQol8opFrvdIWbUKUe1T5CWxr/DHwlo1bDvRoBO5zsTIE1KIkQ+mGYV3dxXe+V9CbD6oI6jwfKjQTM41NCJLN2Dzk9cvIj5yn1wQEKGHQEyT0Nvdvfc624zLaMn1eXku6aLYQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746635602; c=relaxed/simple;
	bh=5PNsaUkEGcwl6bLcWpVgvynTWCnJdydaJWuyO6roJWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jzxG9il6SNaP0tv8br6e5gDqkv2iAoXESCad2vT4gDzMVr5vLUIvtgvyUAem9gelXO71a/xh4yBWVc59FtZSp9OS1i3kMgH5pD9FPyRzsOQMOXGMlAnRvOjYUinECjWoh5A4nC6090pWQtKjjj/ZZtqC5dbDNyqObu1R47Uogvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNeuv9i4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNeuv9i4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B81C4CEE2;
	Wed,  7 May 2025 16:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746635602;
	bh=5PNsaUkEGcwl6bLcWpVgvynTWCnJdydaJWuyO6roJWo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PNeuv9i4FW68lrdYEIH+OvkPUun2GCl+X5bZ8d6QTCI93nFrsrCwxh50EN+kCBmlw
	 mQCq5hjGlkHBeSI/DtB4qkLOeRO6XJEnBCDQvYV5SU9yHWchq0W1/WcjzwqjQQmeoM
	 gReuu6roxmtjr4SJPq+7+HX7Z/x9vBn6MR1xA8uZZS53z8Xiu4Ak+JGc+xCXXLgpAz
	 gy37jLwfjq4Iuko8jbQzuMcjfKUINz1h1pOmNM5Ueg9bEAktFG+36wnGDJJQ++BP/a
	 d25WpFMg67fiNJ+EXaPmzC3Pv+UmvEzoB0n8ZKTyOfZD602hSMnPcXtViyJZfYJLQH
	 6DzoXXb70/yeA==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso821066b.1;
        Wed, 07 May 2025 09:33:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUzvxunn98yAPU19+qjcjVXAEGAAMoVNAZeY74V7rS26ADxX/ZCmWvjQhl6TYmrggTIaLi2F20eKGMGbnpC@vger.kernel.org, AJvYcCV3/2/OzhEds31GPIi55Bg4AZH7H4F181OLxtx6tJQbgYzYMoFq0WZjVW52Gtf/lmMnOl/qQjXm5cHCBGi7@vger.kernel.org, AJvYcCWpARgmEPAskhFfOU6ZPDVGt0TQi5pdZNB93mbn4DDA4F1ItcqU1qvf6XF/MC7hnCgXzu9/R70++Eqr@vger.kernel.org
X-Gm-Message-State: AOJu0YzFavzO37A3rtjEqEZ0h7gbR8UN9V021ZkkOo5g2HRKL10uWXYV
	dhyXr5CI2ASyaiE6hOBncdO34Rvj1NFIrTWIslvbIKqir5p1j18XwwiDJYoNRoPt4t7vovRewq/
	FZqUR6R86ZYGjoQ0PjiAtKGFNqA==
X-Google-Smtp-Source: AGHT+IFbXKkluOPn99/o7gDALkGZlj3EQIAiAnWfyaoAaMejb4qqqHeuVh2Qnro+FLlcAyfNU+PnEPf3FfamJcZhNoQ=
X-Received: by 2002:a17:907:3e21:b0:ac7:f00d:52ec with SMTP id
 a640c23a62f3a-ad1e8d0db1bmr336967966b.58.1746635600709; Wed, 07 May 2025
 09:33:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506220016.2545637-1-robh@kernel.org> <20250507165447.7e340d47@donnerap.manchester.arm.com>
In-Reply-To: <20250507165447.7e340d47@donnerap.manchester.arm.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 7 May 2025 11:33:09 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKve4hXiR31ApMADEz3NqD_futjETWrPKEWz3tADsX7gA@mail.gmail.com>
X-Gm-Features: ATxdqUFg1sT4pwdyybWgm-K9_ztHsP0q9-QRdWfCP7CwDJwHRKdVQ4NBVzTsuSU
Message-ID: <CAL_JsqKve4hXiR31ApMADEz3NqD_futjETWrPKEWz3tADsX7gA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: serial: Convert arm,sbsa-uart to DT schema
To: Andre Przywara <andre.przywara@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 10:54=E2=80=AFAM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> On Tue,  6 May 2025 17:00:15 -0500
> "Rob Herring (Arm)" <robh@kernel.org> wrote:
>
> > Convert the Arm SBSA UART binding to DT schema. It is a straight-forwar=
d
> > conversion.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> >
> > ---
> >  .../bindings/serial/arm,sbsa-uart.yaml        | 38 +++++++++++++++++++
> >  .../bindings/serial/arm_sbsa_uart.txt         | 10 -----
> >  2 files changed, 38 insertions(+), 10 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/serial/arm,sbsa-u=
art.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/serial/arm_sbsa_u=
art.txt
> >
> > diff --git a/Documentation/devicetree/bindings/serial/arm,sbsa-uart.yam=
l b/Documentation/devicetree/bindings/serial/arm,sbsa-uart.yaml
> > new file mode 100644
> > index 000000000000..68e3fd64b1d8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/serial/arm,sbsa-uart.yaml
> > @@ -0,0 +1,38 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +---
> > +$id: http://devicetree.org/schemas/serial/arm,sbsa-uart.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ARM SBSA UART
> > +
> > +maintainers:
> > +  - Andre Przywara <andre.przywara@arm.com>
> > +
> > +description:
> > +  This UART uses a subset of the PL011 registers and consequently live=
s in the
> > +  PL011 driver. It's baudrate and other communication parameters canno=
t be
>
> He said "driver" in a binding document!! ;-) I think you can remove that
> part, or maybe rephrase it to say it could be supported by the same drive=
r
> that supports a PL011.

I know that's 'the rule', but I kind of think that's relevant in this
case. If we're looking for improvements, defining SBSA here might be
the place to start... But I'm not really as this is 1 of 1100
remaining I've had chatgpt to convert and then I fix all the issues.

Rob
