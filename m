Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF7E1922EC;
	Wed,  5 Jun 2024 11:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717586411; cv=none; b=gHmVIG+Gx6HrmISKyxAKqIiXI+AKsWUkgjJ+B77zoBL+bDRxiZmlH4tKOyWkGVhqRLWl/EtuiCqxpV7j4MdHU8pyTW5uohWUKR/GuDdJE7KgGhodCMr63w/KZ+agkMYIDH/c5sB0DBDm0fCI9FqWZU3ZC8Gtb1EmNu8rGX5fevI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717586411; c=relaxed/simple;
	bh=M2XgPPI5kcHNSLARYmDeCIEvGQnWyYhOIqmHfd6Mnuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mc0wEJqnW2NAF5KGQKReOcnyTb7+T2sQ10AEr4XHUG2mrZrGQOh3ro5sSs/RyBM9G4akOj0jqHrqOkiaeWmF5pNeYlAelYnfoDPOj0fHE5A/Ir8HIuzHyOid72d6RE1I60SPfxlw63TbWRcqD6vt2nCshWywWNxae0fvi4w4MQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVks8zfI; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVks8zfI"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a68a9a4e9a6so461688266b.3;
        Wed, 05 Jun 2024 04:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717586408; x=1718191208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2XgPPI5kcHNSLARYmDeCIEvGQnWyYhOIqmHfd6Mnuw=;
        b=cVks8zfIE3yjp/f3mVlfmTD9jLTwxl84ZOUVRkm03VswcpiiBzcsLBZ9R8FWemtgEy
         sMLINmhVe+e3O92jfL8Y63g3xQrOpA9xC4SlCMDrM5WpgGlZR1nYGjg6wy7vOcldYR5x
         OyNEKMJ2V0QXxvrgpUwiVb/sTMv5ycqLeDklE0zoBIvsCw3m2GvApPr143AogKlY7VAx
         yvPVY0NgRtNyUmyqiQnZVy9Awy/nmJOib3MC0rqzYOJIF20CE+2xyjDEJgm0NuOV64Y0
         j9vuoGoACE27Z/ayqUXabW4HLClOgHWTLwXA2SMkktTQL8SAcGu9WLYgh0QQWKakJxGR
         zylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717586408; x=1718191208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2XgPPI5kcHNSLARYmDeCIEvGQnWyYhOIqmHfd6Mnuw=;
        b=EOzi2hop/+eiWjsdcgV2hlX2RiigYLbl92Ovt8ByVuas8TFGuG22mmab6nM6jrcueK
         jlJBxXPL8RbRFPCfq5iadbx1zrgq8RG6lsrN7F5BpJQxy3L7wJy58L+9ujS1BhzxHB6d
         IIq6Q8RUY1aZogwb5faXW9Wd3lW7jqSxTmyWYvaxBUC4lrWeAoh6oFEjRJxzOomylPIX
         xsIJMy6ZnxsSKuisyIUzp2E/6NLiJLfZuIvqadtAR62gDvAt6gVVB5PhuvwXtTGK08Ag
         JYHCsLb4D25gJ7UKkRdfCHm8uYfh68vhMkaE/263mRkMW2pt5cJtwZdINUqPWPszcky8
         jYwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqKrO2TCP8M5mKn3bBYQT6zFOA0CwvA/EkoFkgpX0VQg6ihzUkux+4+iU0sgeWQB5qk/o8xzGXDXyUKYHM44DOXoUO5pAGodUZjxrPlrx4AdYc8f8fJx3d0QMbSV5zkaS0MDQ9fCj+vA==
X-Gm-Message-State: AOJu0YzBtd98lKu04I4e9jdzrLqjl6+N/bXnJNVdO2QilZgSMXjyrNwu
	RGhq3jehvWKyXWNHSr9X1nX0o7c2DwfufbbU6QvHlkfn7rnmG3Hgta96tx6+B8A6BXz9MPkkLY+
	kBL6df8I5sbL2G38Ga+Nm2XFZjO4=
X-Google-Smtp-Source: AGHT+IE9fA07hz8gjgRCwsGUN2n4UgVaITYVgtS/9/vS2b9aNFjN/B/djHpm/tjR+uEdzHrUDcAElx6fV9zECQJb9TE=
X-Received: by 2002:a17:907:724d:b0:a6a:b1ce:7f2c with SMTP id
 a640c23a62f3a-a6ab1ce7ffamr122365666b.69.1717586408384; Wed, 05 Jun 2024
 04:20:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604132726.1272475-1-hui.wang@canonical.com>
 <20240604132726.1272475-2-hui.wang@canonical.com> <20240604102323.b2a305fa03161df3c2eec16c@hugovil.com>
 <AS8PR05MB9810940582493046F2FBFDB983F92@AS8PR05MB9810.eurprd05.prod.outlook.com>
 <f56a2c59-9ae4-4d5c-8321-fff9639c5405@canonical.com>
In-Reply-To: <f56a2c59-9ae4-4d5c-8321-fff9639c5405@canonical.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 5 Jun 2024 14:19:30 +0300
Message-ID: <CAHp75VfEONqGBx7xbOKtGcn5z3shzSyUt8WABJqq4yOnweAr3w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] serial: sc16is7xx: hard reset the chip if
 reset-gpios is defined in dt
To: Hui Wang <hui.wang@canonical.com>
Cc: Maarten Brock <Maarten.Brock@sttls.nl>, Hugo Villeneuve <hugo@hugovil.com>, 
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jirislaby@kernel.org" <jirislaby@kernel.org>, 
	"hvilleneuve@dimonoff.com" <hvilleneuve@dimonoff.com>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"andy@kernel.org" <andy@kernel.org>, 
	"lech.perczak@camlingroup.com" <lech.perczak@camlingroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 1:55=E2=80=AFPM Hui Wang <hui.wang@canonical.com> wr=
ote:
> On 6/5/24 18:30, Maarten Brock wrote:
> >> From: Hugo Villeneuve <hugo@hugovil.com>
> >> Sent: Tuesday, 4 June 2024 16:23

<...>

> >> Add function description from original comment "Reset device,
> >> purging any pending irq / data", since the comment applies to both
> >> hardware and software reset,
> > No it does not (at this moment). See below.

...

> > The problem here is that this only deasserts the reset if it were asser=
ted before.
> > Nothing happens if it already was deasserted. This makes the delay also=
 pretty
> > useless.
> >
> > To make this a proper reset pulse for the device you must first assert =
the reset,
> > then wait >3us, and finally deassert the reset.

> My understanding is when calling devm_gpiod_get_optional(dev, "reset",
> GPIOD_OUT_LOW) and returning a valid (gpio_desc *), the flag
> GPIOD_OUT_LOW guarantees the GPIO is set to output and low (assert the
> reset pin).

No, this is logical, not physical state. Maarten is correct. How did
you test this?

--=20
With Best Regards,
Andy Shevchenko
