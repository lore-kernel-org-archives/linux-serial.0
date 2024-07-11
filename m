Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCFB16C877
	for <linux-serial@vger.kernel.org>; Thu, 11 Jul 2024 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720714196; cv=none; b=cC3TRYzYKkVvRlAbcUllWOkMWfVOc4Pb++sEMy75IIfoEkhMqw4zGeSV1Bx6JPg8d+4x9XDXhyNXHMiKLTRNKt3yqEoXhACKVIkm3BXDAA0i+qIb0r1NjIO4I0z/bA/9s7NOVmPqoQ/01QVfkE0M0ivdvg8gtRCos7F8UsClAQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720714196; c=relaxed/simple;
	bh=zM+Ke5l9OEdCHJOW1/P1QdkqIu1vBISkcX6wpQaLk+g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WVMH3VRRsGfua2MEEFdIIuxK1NTqkchCHKgaKU/Tnwa5KWqSGp5R5RcE72/1fwdhh7+d20g2FOJm6w1r9jOgVombihopazeFyGCer5aPADnNouOdlCejs3EqUy7zMy8W3Y0eL2FQqUIHm22bCdc5KDgyQ6Ob+U9t+UN8c59cHww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JJt0jpU6; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JJt0jpU6"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52ea7bdde68so1219434e87.0
        for <linux-serial@vger.kernel.org>; Thu, 11 Jul 2024 09:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720714192; x=1721318992; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V+gnxXD5w0/TDuHUdJYoIQAjZ8cTVQOFx7Ip+6Nfwlc=;
        b=JJt0jpU6dAMtc7moEtzWYDkfUPXhLkbRGJjUDxg5HO4/nGmbw1ZqqR12iTxmdpRl3y
         m5AfexgLnhnK+4GjSU3sOsdUqzqvnD45TEd40wVUvSzl+Zlkp4PGZwTXp0T3KE9N42z+
         QCp9aocFeMNgl16j7NI6jS2EFZfMFDoLrgxoUpdRsGer4r1SBlXDy26geLQHtHWZ+Dso
         QNw5jPmQlI7o3gmnYwwyM6nvtWcCPmFMZe/q9GzzE9ibcATM6MHVa17sRQnlWyHqux2K
         KaAmPoSJ+uWl8F8VhK7K7QHfu8qv5AndyGb1gNJBWJ77lmZ1lxfgKf5QIYLYSpYySfuV
         0Zow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720714192; x=1721318992;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V+gnxXD5w0/TDuHUdJYoIQAjZ8cTVQOFx7Ip+6Nfwlc=;
        b=NvMXVLlLe7LYImZEMeqIiLg2m+n/7u6PcnMXcGla73HBLj00giTf0LJoPAXJpYWOAx
         o/lNJugsky7+KjLbjvyMIVld6cmfb5ZnEAyjt0u1QEvbB+nvAUKDDDPMJ7UDv/8WB7wH
         bFQmtcfdE/h2VNw69zpQjVV7U5CKGD8VywDHD1NoWYOL9wbJceJMqvt4g4XJYcdAruko
         5fV3hVlY5jrPmRKQ2naXBOiC957pH0/T4uQkl9LPmlU4HslfAe7bCZVpUw8DFtUY3Rby
         Plsjge+TxkPZVApJRh5lkncqipTX7eW5Aa+Rfo3y7T9XrbxgwXarqLYG6bMi7nU+dKji
         PGQw==
X-Forwarded-Encrypted: i=1; AJvYcCWF8Zc4t2ed6eBMEz8MxUGMn14aMopa+3s2f73ZqmvatBrHfq1n1sFhxjwr1JWtVOh4Fm7fFYyEDw3fGRf2oZ51ycTnpHFyLEMyIYa+
X-Gm-Message-State: AOJu0YxaRwwwDeEdAiH8R3u7TsUYXD+j9uWuvFzmV2buHpqyhqIGyr8R
	ZV/SgbqiRezjjCytBPxqjyGPvd0RIWe6+xWCVjdSuM3EMqiKYyW2hE6OjaMB49c=
X-Google-Smtp-Source: AGHT+IEwHiyuX6inUi7hCZdVqelFPlqHibZJk0LuS0PKqcwVMYQzzwnNEb7uK5wA3NOBuGsylOhz6Q==
X-Received: by 2002:a05:6512:2109:b0:52c:e28f:4da6 with SMTP id 2adb3069b0e04-52eb99d1688mr4722454e87.51.1720714192520;
        Thu, 11 Jul 2024 09:09:52 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f741624sm119316495e9.41.2024.07.11.09.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 09:09:52 -0700 (PDT)
Message-ID: <e2f4a37e7c31d26449125a6265239c88162a1085.camel@linaro.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: serial: samsung: fix maxItems for
 gs101 & document earlycon requirements
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Peter Griffin <peter.griffin@linaro.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi
 <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, Michael
 Turquette <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>, Sam
 Protsenko <semen.protsenko@linaro.org>, Tudor Ambarus
 <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
 kernel-team@android.com, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org
Date: Thu, 11 Jul 2024 17:09:50 +0100
In-Reply-To: <CAL_JsqLsZAEx-c_12RPcR+HCjPcA_d12oKgZ7frX2Wo47sGTnA@mail.gmail.com>
References: 
	<20240710-gs101-non-essential-clocks-2-v3-0-5dcb8d040d1c@linaro.org>
	 <20240710-gs101-non-essential-clocks-2-v3-1-5dcb8d040d1c@linaro.org>
	 <CAL_JsqLsZAEx-c_12RPcR+HCjPcA_d12oKgZ7frX2Wo47sGTnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Rob,

On Thu, 2024-07-11 at 09:51 -0600, Rob Herring wrote:
> On Wed, Jul 10, 2024 at 7:29=E2=80=AFAM Andr=C3=A9 Draszik <andre.draszik=
@linaro.org> wrote:
> > --- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> > +++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> > @@ -145,6 +145,20 @@ allOf:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - samsung,uart-fifosiz=
e
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg-io-width: false
>=20
> blank line between properties

Do mean before clocks: below and before clock-names: below? We don't do tha=
t normally,
at least none of the bindings I looked at do that. Or did I misunderstand?

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description: |
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Not=
e that for earlycon to work, the respective ipclk and pclk need
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to =
be running! The bootloader normally leaves them enabled, but the
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ser=
ial driver will start handling those clocks before the console
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dri=
ver takes over from earlycon, breaking earlycon. If earlycon is
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 req=
uired, please revert the patch "clk: samsung: gs101: don't mark
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 non=
-essential (UART) clocks critical" locally first to mark them
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CLK=
_IS_CRITICAL and avoid this problem.
>=20
> That's a whole bunch of details that are Linux specific which have
> little to do with the binding.

You're right - I had been asked to add this to the binding and didn't consi=
der
that. I think I found a much better alternative in the meantime and this
description can go away.

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 2
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock-names:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - c=
onst: uart
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - c=
onst: clk_uart_baud0
>=20
> Which clock is pclk and ipclk?

uart is pclk, clk_uart_baud0 is ipclk.

> 'baud' would be sufficient for the
> name. 'clk_' and 'uart' are redundant because it's all clocks and they
> are all for the uart.

TBH, this patch is just following the existing style & names as already exi=
st for
various other SoCs in this same file. Furthermore, up until this patch the =
default
from this file applies, which is:

  clock-names:
    description: N =3D 0 is allowed for SoCs without internal baud clock mu=
x.
    minItems: 2
    items:
      - const: uart
      - pattern: '^clk_uart_baud[0-3]$'
      - pattern: '^clk_uart_baud[0-3]$'
      - pattern: '^clk_uart_baud[0-3]$'
      - pattern: '^clk_uart_baud[0-3]$'

so of course the existing gs101 DTs had followed this scheme. Other SoCs th=
at are
described in this same binding also keep the name as per the default in cas=
e
they limit the maximum number like this patch does.

Changing the name now would be a bit disruptive and make gs101 differ from =
other
Exynos SoCs in this respect, I'd rather not :-)


Cheers,
Andre'

