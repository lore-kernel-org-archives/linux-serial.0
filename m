Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCFB2032D
	for <linux-serial@vger.kernel.org>; Mon,  1 Dec 2025 02:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764556245; cv=none; b=JO163z7jzXzW1TqOvZvA2t7zy4Ajq7K6dseCH4+xBAwn24vHh37GnkHu53WuoBedTzBAodJ3YSZ/uOv59V8/g0mzWugdQfOlyLcsilrUgCrC5+9bfhlu2dZbu6/yPey3IsVATf5WhZlKTnHIMIjUFm0j5QUKCqNpwvOGUYvXMeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764556245; c=relaxed/simple;
	bh=8TTFxA1Z8YGkxKJrAg1/Wk2+ms9O2HuzncqUUUlszKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j5WfhHC460Ljo1TXc6N+pxNxZeEFiKJibCjT/HOlp0Pla9MYuLPQdHnRd55hjaWquWjnjbEZBSVqwUX4Z0Y1KCsWs2pcn9VzdJvCzTauVyiE2IhSSaY5/BLim7jKSyXDpFmUr33WLvdpdI3kuJ+hNytSiTfin6UGlARqQgyQ0nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5DRPkgA; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5DRPkgA"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b7697e8b01aso725789366b.2
        for <linux-serial@vger.kernel.org>; Sun, 30 Nov 2025 18:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764556242; x=1765161042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIzt+rcrGKAoIHfboRbefcrNfi1/4z1TfGEqhTkbB+M=;
        b=A5DRPkgA9EZIn2FI5z9RLIEy273GWuZIONvT44+aPyMx8+NujYFjFqbkmAExq/msg2
         /RtvsNfDyjR4E2QcpaE/sHa0oKM5hga/EZgvJfLv3cn8lheHMLtGNreO2L4wUs35gLxI
         XSx0hecZwYpXew+P3dlEGDealizH/DATH39HFjKPqYD3lw87jaWrV1ZJZupGrQXwnI8L
         2UeYcRDUgGxjo57zOdNZVrBFCNGsm/qgIbb0G7ZLiXPNelgKV5BOV5+smktUHKBiTFiD
         4cZmC4vhciNZJ3+T9X7aKMPZSsEeDkH61+bG4ZfsL1EecKZqe6XeywQ/77VCW/xNY1/X
         gHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764556242; x=1765161042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UIzt+rcrGKAoIHfboRbefcrNfi1/4z1TfGEqhTkbB+M=;
        b=pQiquNiHpEF5ydelharTLdMU/84eAZBO2XCSvimN1grSDl4tgKsbCThq4gZQPPO6kG
         eImmhzti3A1RApiLcU1WMTM6mjDYCvJGqb7IgZLkHNslufkBjZdXwUNXK2pyZREkmlVU
         7FfKs0cuKAjR2vSJaUbk4K7BUS8D3Zl/Rd6mxNyd11ub/K0Lei3pULiHq6bfzJ7jiNKH
         P+NFmrbP3EReZACf2T14g5cKZ8+tBZ367pdB6m9WyCwNsZ1kIJXgDUI2AkPjR+dxKtuQ
         f+ewZX0D9h1KOfJRcpL7msPmLEC+nkFR9mo649+/XW64CnuJ1DZ0KUMaSKAwKNIARx6q
         Vd4A==
X-Forwarded-Encrypted: i=1; AJvYcCWPWfPJwxCfLjSfpD9J6551iqCTXY9YhLwSmEXtlef8Jw0Y9s1Ssho1M3viJFE1hrsXZeZzw9gqakOCV5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG8YDM1cbHSWP8XUSTae9S7nH5AfeeIdWPFfNqEdAs1JgVneFt
	SaYfFCGhxXgoSaLIiydf48imgAIh2nAAWYhmGlyUr77ZzEeTHeSsx8SNrAgwn6ZABQSunLz5515
	IbFkIf0bLIkLUnzqhnuLuCglVTqSjkVQ=
X-Gm-Gg: ASbGncshnElWg9vMK2b+M3zJ+/4rEwBXFAiBVEDAn6lnqvXToG24aDFF68K2gAym7H7
	lmTGJizZW55REO6DOQj9VYOBYSkNyV/ZpuBTy65eHCoBFx5XhtnPbxQKj7A9XBQAhD2by0+WhQv
	4qNkYaO9Okurz2zYeVudmu1jExb7cMaBnZod2U5BBOnV7T0vQESNaOyOK2/dvsY4hNIidiJMBsK
	LKDWPPKLf4jhj7SwfX9KjfXkifFcBlVQpDLNe3++lRxLUVuSDxH0IdlnRVocn+9PAswE2CnjvXw
	kWYCiuX85uPMflpaSOEGR6q4deRzFPf9+o55GMRX++n/KIlGSUmG37A/H8Bpynq4LZ/a1UU=
X-Google-Smtp-Source: AGHT+IF7AS7yI07v/HQZBRrK0rnwJPde4EV9ZHBa+Spa1osFZgVMHtKzRlYkpqBzqGvFpQstBKmeNlTtwV1lstwBLdI=
X-Received: by 2002:a17:907:7b85:b0:b76:c498:d40f with SMTP id
 a640c23a62f3a-b76c498eb61mr2161204666b.4.1764556242022; Sun, 30 Nov 2025
 18:30:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com> <20251130104222.63077-28-crescentcy.hsieh@moxa.com>
In-Reply-To: <20251130104222.63077-28-crescentcy.hsieh@moxa.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 1 Dec 2025 04:30:06 +0200
X-Gm-Features: AWmQ_bkZJD9AURaQTLq6KTB8dv6udsT6KCuKD_RcjTCIqGcLcYnYT1aUt5cuO9c
Message-ID: <CAHp75Vd9+hE9y5JEm2_5WnrK1R2dySikYUdVn_J=e5bX=ZhV0Q@mail.gmail.com>
Subject: Re: [PATCH v1 27/31] serial: 8250: Allow dynamic extension of
 uart_port attr_group
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 12:45=E2=80=AFPM Crescent Hsieh
<crescentcy.hsieh@moxa.com> wrote:
>
> Currently, uart_port->attr_group can only reference a statically
> defined attribute_group, which prevents drivers from appending their
> own sysfs attributes.
>
> This enables drivers to inject custom sysfs entries without overriding
> the core-provided rxtrig interface.


> +       if (up->port.attr_group) {
> +               upp_attrs =3D up->port.attr_group->attrs;
> +
> +               while (upp_attrs[upp_attr_num])
> +                       upp_attr_num++;

> +               up->port.attr_group =3D kcalloc(1, sizeof(struct attribut=
e_group), GFP_KERNEL);

sizeof(*...)

No error check? And why calloc(1)? Shouldn't malloc() be enough?

> +               up->port.attr_group->attrs =3D kcalloc(upp_attr_num + 2, =
sizeof(struct attribute *), GFP_KERNEL);

sizeof(*)
Error check?

> +               for (i =3D 0; i < upp_attr_num; ++i)
> +                       up->port.attr_group->attrs[i] =3D upp_attrs[i];
> +
> +               if (conf_type->rxtrig_bytes[0])
> +                       up->port.attr_group->attrs[upp_attr_num] =3D &dev=
_attr_rx_trig_bytes.attr;
> +
> +               up->port.attr_group_allocated =3D true;
> +       } else {
> +               if (conf_type->rxtrig_bytes[0])
> +                       up->port.attr_group =3D &serial8250_dev_attr_grou=
p;
> +       }
>  }

...

> struct uart_port {

>         unsigned char           console_reinit;
>         const char              *name;                  /* port name */
>         struct attribute_group  *attr_group;            /* port specific =
attributes */
> +       bool                    attr_group_allocated;   /* whether attr_g=
roup is dynamic allocated */

Is this the best place? Have you run `pahole`?

>         const struct attribute_group **tty_groups;      /* all attributes=
 (serial core use only) */
>         struct serial_rs485     rs485;
>         struct serial_rs485     rs485_supported;        /* Supported mask=
 for serial_rs485 */

--=20
With Best Regards,
Andy Shevchenko
