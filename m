Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E0C27C17D;
	Fri, 11 Apr 2025 19:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744400686; cv=none; b=UvXVJmxwt/MJ/TvveWgXe8WflJrfCVvrUmaja4OOe5fAxU6Zu9jfMt6IayUAECUKs/45oWGEoHDrUt2kSnX9q7b4lJrxERISzqvAiftFIFuUDu3hK4fop3Q8lqyEKPDXt3sqIkeRXyzq7kyzTdkcx+jiE2ifgyXkOWAN/sl6bJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744400686; c=relaxed/simple;
	bh=cvWYMueTnNI052lI0vphIrO8EfCwUMaz1n9lCvWw0Iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vb8MDcb4Q3fySF5afaPDoOEp0pEf6/Ia+O4QOKNGZPB6tIrMTnKstNjW5OO4K9YoWeJLneVjb7jBikTeBCOkA0u3AQWFk2J3ANzbAJnZPQoo6fCbQBD22OyQwVu0xXKzDjjstdYCn3n6BbAydOCok/o4kkdNIxk/k21Zb/yXkjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RowKJqHV; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RowKJqHV"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac73723b2d5so468353166b.3;
        Fri, 11 Apr 2025 12:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744400683; x=1745005483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ixNsTL0ouXPTlyTlApyKLv+63+cCzL/+fZpquEKOP2o=;
        b=RowKJqHVbLE5kDXprHeUXnPRF6MIqlsFaVwnV5Nnm7rhnz2J3PfVA88whBN1rrDjmN
         ufF9m8tkPiwSn9/2048/fcdnEL2G51pOkLlwclosc6xFM5JAnp4TQZEUbEIC5/cOvHWS
         ORrwU70cP8cG1OW3UyNIHihscuK632yTFCWf0OQMmKUyB1U46ZrpAsQ2w2CFKsS6UlVI
         mooz+Np9ASpLwCPrAB4xG1XBqa2G31Z3gBHhd9NZi823Na8kF6e3mBivxxAIKTEe//C6
         KErdgtdFUyGdWwTvlzt/So5b04nrvMpxL+uqhU8cDAuPKoEEYMuiUhDYo9Bx1mScl7Ap
         YIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744400683; x=1745005483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ixNsTL0ouXPTlyTlApyKLv+63+cCzL/+fZpquEKOP2o=;
        b=II89z9hbDdIkFTMn1hWqdrN/Qh9dDOEu1lKxhoUrm1pIGITy+ipw7zIdcugDY7/2YF
         0mQisEi5XJ9s7ubdJxxH6odcDDW5brorJH1uxgwO3Zs9oxgxhTRHuIFbWbs3CEBEhZY+
         BkIJW8KeKZ/KF5HCGGW70Oytbclf83UiwYY6qdEV5WSANb5PNAJsxQZs/1CnNx/MNoUU
         Ryrbaf1jBs1p+aBCu6A+Yohw1W0YP/Xoqa7K7TJOMaWy5S56BxbepgB44qMsiFjUMVR+
         +7GCEcKEju/DYUQQs30OH2PoMyAHsJ+urBfOW5829gQPNLuRFtBYj12b0EUD/pgvyDfQ
         zzPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYEKQa+3kNfWOarH4vSZvpZmYXyfbPq4C0r6ccnZkA4+cvXG+UrH0saLV8WcxMs5LJ3PSGD6fcBgo+FPKw@vger.kernel.org, AJvYcCUi76v90+5ftXLDq5E2LB9vmQvXCO1FLf38bO8opAn3WFY4nWVGZjrDp2qY8uJWfthl4YAsOHYg32HVHNTx@vger.kernel.org, AJvYcCV4iKH83YKNRYXK4PVDVTE67fi4VbGU9WNJMmV2Lyv4nVNiI8+/Iq3DsLAfWE60eEvJSXfO349Szim3@vger.kernel.org
X-Gm-Message-State: AOJu0YwaiROf9pHZwUO/E5kIm9NX0UkLB8/lfX3DcqHEtHL9n/mm3Omj
	CR7pFkAWBWuE8x70i1RdoxTwtSmVwzyqaZeFI+ez/geu8+WX2f/uOWzYGIt7ik5zY2TGbNMtyxE
	GUVn//aTTtCvahNYfaAQoGSCgmGU=
X-Gm-Gg: ASbGnctFaD3fXP/j69Yh5x8EEFBeBcor5SJ/WIWFI6QR+Uo+20Hyepkq7mpV8+Zo6iV
	3q6w+jzjvS0inZS2J67a0KU1b/DgXvUCdC8ciuIqLwcOl5ASlfFIADXdMUAolaGN2q5gOhH51/7
	QLvqqeeX7JzuCvCoNRf+3pjQ==
X-Google-Smtp-Source: AGHT+IFzcDH1iaEP6q1tsygbT4d9IKEyZV6bQHQY47gKw2g34rXwdM4yQe80wOvA0/o3z03M9J4E9lW/QhfczrM+cos=
X-Received: by 2002:a17:907:720d:b0:aca:96a5:9861 with SMTP id
 a640c23a62f3a-acad3491f59mr366210666b.20.1744400682645; Fri, 11 Apr 2025
 12:44:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411154419.1379529-1-elder@riscstar.com> <20250411154419.1379529-4-elder@riscstar.com>
 <Z_ltyAO-OBzl0adV@surfacebook.localdomain> <a3b2d0cc-c055-4cf0-9e03-3ea73041642a@riscstar.com>
In-Reply-To: <a3b2d0cc-c055-4cf0-9e03-3ea73041642a@riscstar.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 11 Apr 2025 22:44:06 +0300
X-Gm-Features: ATxdqUFkskQhMsG1Fkk7AzvcChX0YXHgUTejwz7OwkLd792_lQxr49tcIoE0XwA
Message-ID: <CAHp75VchEcpP67oPC8xD+tYrY_A0BGSJqK=1au939-W60_qQoQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] serial: 8250_of: manage bus clock in suspend/resume
To: Alex Elder <elder@riscstar.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, dlan@gentoo.org, 
	benjamin.larsson@genexis.eu, bastien.curutchet@bootlin.com, 
	andriy.shevchenko@linux.intel.com, u.kleine-koenig@baylibre.com, 
	lkundrak@v3.sk, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, 
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 10:36=E2=80=AFPM Alex Elder <elder@riscstar.com> wr=
ote:
> On 4/11/25 2:30 PM, Andy Shevchenko wrote:
> > Fri, Apr 11, 2025 at 10:44:18AM -0500, Alex Elder kirjoitti:
> >> Save the bus clock pointer in the of_serial_info structure, and use
> >> that to disable the bus clock on suspend and re-enable it on resume.

...

> >>      if (!port->uartclk) {
> >> -            struct clk *bus_clk;
> >> -
> >> -            bus_clk =3D devm_clk_get_optional_enabled(dev, "bus");
> >> -            if (IS_ERR(bus_clk)) {
> >> -                    ret =3D dev_err_probe(dev, PTR_ERR(bus_clk), "fai=
led to get bus clock\n");
> >> +            info->bus_clk =3D devm_clk_get_optional_enabled(dev, "bus=
");
> >> +            if (IS_ERR(info->bus_clk)) {
> >> +                    ret =3D dev_err_probe(dev, PTR_ERR(info->bus_clk)=
,
> >> +                                        "failed to get bus clock\n");
> >>                      goto err_pmruntime;
> >>              }
> >>
> >>              /* If the bus clock is required, core clock must be named=
 */
> >> -            info->clk =3D devm_clk_get_enabled(dev, bus_clk ? "core" =
: NULL);
> >> +            info->clk =3D devm_clk_get_enabled(dev, info->bus_clk ? "=
core" : NULL);
> >>              if (IS_ERR(info->clk)) {
> >>                      ret =3D dev_err_probe(dev, PTR_ERR(info->clk), "f=
ailed to get clock\n");
> >
> > While the first patch against this file looks okay now, this one inheri=
ts the
> > same problem (seems like not enought thinking about the code representa=
tion).
> >
> > Instead of rewritting half of the lines you just introduced (which is a=
lso a
> > bad practice), add a one-liner that assigns a field to the local variab=
le.
>
> So you want me to re-spin this again so that I use the local variable?

Yes.

> I understand what you're saying based on ease of review,

No, not only review. Here the main issue is ping-pong between patches.
If you know ahead that these lines should be changed, do it from the
start. But I understand the need to have separate changes for
logically different pieces. That's why

> but this
> is a simple patch

It doesn't matter how simple it is.

> and the change is very understandable, and the
> code is no more or less clear when using the local variable.

See above.

> >>                      goto err_pmruntime;


--=20
With Best Regards,
Andy Shevchenko
