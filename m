Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E201F216E24
	for <linux-serial@vger.kernel.org>; Sun, 27 Jul 2025 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753620934; cv=none; b=Ku/jAgg2DrOKRU12h2hIgf6hy4ZnPXcISreqrBeQkVtljFQA7D15ILIZ3ICJbDHlcdiOqv+idyYs/qK/gX7gBXF8t3F/80drYcnoHVFC2Bj/k1Odn0H+WYv0wbaHgtVkcwSVoeETt+6R0ICjz9TdXLhwezyFr8siNpWANEmKZN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753620934; c=relaxed/simple;
	bh=BQ/JpxXpuSy7PbBgcydNfVF2w4td5TfhH0Fzlc5REsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KfU/DKc3e2ouGBxt0hqBypvWFMQSiL9OBHUKTgjFVNjEMGAwTWHkN65TwtUGHQ5N6KR4GygoaqG+FOpSqQ2JNoFnXByYi3srVwYQs8FQDjd/BuEiWLLtvL8NlqxKP/3bD0HXwgFYRrdVwYzHzztmTCZoytA3z928ER5tFkNq2HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=c0uvMYtE; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="c0uvMYtE"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6150be62be4so1575992a12.0
        for <linux-serial@vger.kernel.org>; Sun, 27 Jul 2025 05:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1753620931; x=1754225731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMxifAIqWO9udZ2NZ9E8Ene5GRXydyVi9Idk6pBIlxA=;
        b=c0uvMYtEJFdVp+74ymehaYZDUS3V+nzKzazfRjmJE/+EjM/hG0j+ExWD5KtIVAt4q8
         WpIU1wLnfTY9d6P1VCdHTl72WRScOnUW06Oa9K2VQ2YkVRWOsHkHu/l2ayLPgvHOp1jE
         Z43U+D9AzbHIwn58Yw1mJfIgYZjM8O7z7pQENFkXfsyVgJoaiBp4+cgM0LX9S36ykbjx
         D7vQwOPooQhha+KSrhae+b76IU8DJME/6pehdSOtQacsxeYuvK66Pc6gs9V2C8A3yPY8
         MmDhdskiPqiQ2ao0Gw1vJq4x8kRY13jiIYoVu5ihckQrjba6bM7Lq3ND51FZgPP5Btbj
         lvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753620931; x=1754225731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMxifAIqWO9udZ2NZ9E8Ene5GRXydyVi9Idk6pBIlxA=;
        b=m8cjKOSsz/1I/Pm5rT5iO3COYiWv6/W5et6WS+0JHCdSbGj9r/Qhxc2KcnPPX170mX
         EiMYJlySeTIZHTSECyRPrQaMBXUfojOT0gB5MEXddCUEXzaA607Pv+dJlUx7NhnRI/Ku
         J2/wrZyQgXMXDCKq6fEnEbImsbKsFP74SxhMNzKQf9UzYqkFGXHj0csRKQHsq6xztX1Q
         Z7TWAzJm4q2ZqYEO6pVRdB52/ONVFOh76nQGQfyjm9U9Z0pkY6p4mz5ns9dQTNmXv3yb
         M2b24hxd729Ka/zAiZDPvFdyY9Qb1x7ObVyGmb3nDbJhSP8yvCy3uCSWFJZ5pP1RIQz1
         u8CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrDGbPuMuqcnEAWv1uZ5MBWi2Wvtf88B9/7U0+1+g6X6xNtZuKyLtoq2sZnurzfrIaTFoPydwolQ4RhQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT/sJatEiDycI4//2Mi1sdNnEqafWTahc6UzE5CrIHXaSXPJB9
	jMgp+Y2oEiAdrgzLvamKBxGTDqbl4TDWK7oWCyuT4w0no/i3qk5KuGJ5TITRnWp38pZBiY5ooyh
	+0hnpEDQpDs0kecwxhKxHbQPp0NHcQLSnksJAjTDOGQ==
X-Gm-Gg: ASbGncu2noktjMO+Nikr958cbFieeWQQzPiXHM6/RwTnDuabIN/rrpOhiYd5EnFxPaM
	fcWDyfTB5YlTrQlg3sVPhLHfpXOIMxBh6X1gwtmjbKl30C3XHkC6JvC9JadffwUg4jGXpADJUW6
	7EjkNjlTT66NZnXRkoa8frkDOcbatBQhHjx3v5Su64SeQS7q7bOahW4d+3Y+FiSp4BNMzv5JzCG
	ji6Pw==
X-Google-Smtp-Source: AGHT+IFVYv/O72cHjaH5k5VUlfobYK4W+S80N+a/c4/0HwzwQr74guF3QvQjE4eDoMLi3m7pid4RHeYV0xM1EOGkTOc=
X-Received: by 2002:a17:907:3d12:b0:ae6:eff6:165c with SMTP id
 a640c23a62f3a-af619601218mr939373066b.48.1753620930791; Sun, 27 Jul 2025
 05:55:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702183856.1727275-5-robert.marko@sartura.hr>
 <175325995961.1695705.8338983998485530536.b4-ty@kernel.org> <20250724100442.GX11056@google.com>
In-Reply-To: <20250724100442.GX11056@google.com>
From: Robert Marko <robert.marko@sartura.hr>
Date: Sun, 27 Jul 2025 14:55:19 +0200
X-Gm-Features: Ac12FXzmHtBtU7jmLL2NxVGb2Ntptau88LQnJUIPvAdvZ644oi9yAP7lpOAawqY
Message-ID: <CA+HBbNGscSseYHT36FqazfH_BXZi9zKdbPkroJGby7Vd+=ZJSA@mail.gmail.com>
Subject: Re: (subset) [PATCH v8 04/10] mfd: at91-usart: Make it selectable for ARCH_MICROCHIP
To: Lee Jones <lee@kernel.org>
Cc: linux@armlinux.org.uk, nicolas.ferre@microchip.com, 
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, 
	catalin.marinas@arm.com, will@kernel.org, olivia@selenic.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, vkoul@kernel.org, 
	andi.shyti@kernel.org, broonie@kernel.org, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, arnd@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-serial@vger.kernel.org, 
	o.rempel@pengutronix.de, daniel.machon@microchip.com, luka.perkov@sartura.hr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 12:04=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> On Wed, 23 Jul 2025, Lee Jones wrote:
>
> > On Wed, 02 Jul 2025 20:36:02 +0200, Robert Marko wrote:
> > > LAN969x uses the Atmel USART, so make it selectable for ARCH_MICROCHI=
P to
> > > avoid needing to update depends in future if other Microchip SoC-s us=
e it
> > > as well.
> > >
> > >
> >
> > Applied, thanks!
> >
> > [04/10] mfd: at91-usart: Make it selectable for ARCH_MICROCHIP
> >         commit: ef37a1e2485724f5287db1584d8aba48e8ba3f41
>
> Reverted as it caused issues in -next.
>
> https://lore.kernel.org/all/20250724115409.030d0d08@canb.auug.org.au/

Hi Lee,
This patch depends on the first 3 patches in the series, which have
not yet been merged.

Regards,
Robert
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
