Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B65D190073;
	Wed,  5 Jun 2024 11:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717586537; cv=none; b=r/AsDrWkzzF6GNIKV6SqefKXqz73JafznY+IiRUURkgv6QDqNrq+et6FYdBwllE3RXHD/Wxa4Sw+wl7BZ+K+9kx2vSfO985sRT7o/PVKyva299O1U9iHxD6oywNdZNh0KAjQTvLS1ij+RzY9rlj6Jo6twk7gAxl754d9uRTayMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717586537; c=relaxed/simple;
	bh=UNxucJ0fLMRZzXcSIYnsT1GcEEQFVIFsyUAQ2JqKEjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DljgltfMkRAiDYXn3WdcBS7sF7+3a0vo9izowMxQJuVSZ0PwtffUlHcmDl1OJ21wi9hAv08S2rvxBeivAtvUu1afKE3Qsu4UfUWQngn+MAhUgEZt071FES3hsUTouWxrxWZZf9TvEeN5g3xDM/yp5MeJ/OvLV8XBFYzCV7GphT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E586jrdI; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E586jrdI"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57a3d21299aso6109897a12.2;
        Wed, 05 Jun 2024 04:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717586535; x=1718191335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNxucJ0fLMRZzXcSIYnsT1GcEEQFVIFsyUAQ2JqKEjw=;
        b=E586jrdIkKewU2UNiKmg2BCzVzzZqX6FIGx9roNO8eRcmEhn+jZg/0piCiTsnISq69
         NblWa6AXTHXOqy4tSBn79a9X76CqEwhyyHDCLothe6kt1dbMQEsj5dAu4n61AzT2tCF4
         BWy96UmTXpAPirV+AOBfYyzZBoJ5nIkVYyBLWrx+UN0/M0Gidelu8qVNZIaIyw0lHcqp
         ZFr7Eve4O6VzTybxYq0iN38500pa85Gduw2e5V0r7tfcbFYHzPmoT2sEh3nuAy1HBZLt
         Z7dvcQtBrKqrX8ML5gZVy4DK0nNbCeAkVrpT4cxqStmOGfd7sCmLdhwtF1y94cWQUJTM
         IP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717586535; x=1718191335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNxucJ0fLMRZzXcSIYnsT1GcEEQFVIFsyUAQ2JqKEjw=;
        b=YmRWO3YQzAqvrH0i8eQ0pon7UVfB06yMxC1N4QzQU4zeM8avsNQzuMFQvdENIY5K1c
         +ikUOBHJR+isODW81R7XbJVGFBUVdwRAKRNtpDciNwXpH0Wl9wHnQmg8oy2o6IEgc5W+
         ldrTlGeWNKe6yuWuz0++yXtRP8JqaPc/Z23cg9mJrGUPPYZhrkOQllvepbYxu9tKiI57
         Btvzf3y35oZSVh9YGmbfB2U6r2Rbq1BkA9YvgNl3ev2U9tbdCcEfSfj1fuJU2Ds0aqGF
         DCC52eBWAKYuNFrzmxIC8l111rTelOwcsnTCElQcpI1Xcwj6FqwHVU03odlxbWgs34lk
         fbUw==
X-Forwarded-Encrypted: i=1; AJvYcCVDA3+xHWGCj9qMknLA0wNFrwmPY9e+wYImlgF255NpSJBKbn5NWXB1nwwvk/hM8WpX42+ABTMMZceIdTtAmFsJJqgLC/u+ZCguxDtiFgea/a0xHaG+zQj/7G6i8nGtUh8muzytCM65OQ==
X-Gm-Message-State: AOJu0Yxe4daOJiqUX4io4WQl1CboYvdjBx7OS8ihUnJ2fsQwkCMWLXZs
	SgZU3TRnrJj7+dKPDkGTyBpzB7cN5l+qyIP6vZzwEW8gkif7ZRXVFRubsWScppNsFRHKDU36XNA
	SvCsi9ZIi06xY3HQk0KI2Sh4sYmE=
X-Google-Smtp-Source: AGHT+IGU9G9CJO9Rlxij8NI7bDmkAih02Oxc1qMqPPID3UfVivm5X3IGBnOrs14bB/JZ9DHOnSobxXr/insQIfhrw00=
X-Received: by 2002:a17:906:1c11:b0:a63:4e5a:a240 with SMTP id
 a640c23a62f3a-a699f34a8ecmr143715266b.6.1717586534537; Wed, 05 Jun 2024
 04:22:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604132726.1272475-1-hui.wang@canonical.com>
 <20240604132726.1272475-2-hui.wang@canonical.com> <20240604102323.b2a305fa03161df3c2eec16c@hugovil.com>
 <AS8PR05MB9810940582493046F2FBFDB983F92@AS8PR05MB9810.eurprd05.prod.outlook.com>
 <f56a2c59-9ae4-4d5c-8321-fff9639c5405@canonical.com> <AS8PR05MB98104348D77097F60396B82883F92@AS8PR05MB9810.eurprd05.prod.outlook.com>
In-Reply-To: <AS8PR05MB98104348D77097F60396B82883F92@AS8PR05MB9810.eurprd05.prod.outlook.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 5 Jun 2024 14:21:38 +0300
Message-ID: <CAHp75Ve3g+iOmzL4Z=oFaj+vtfTVdLBPKVwU2KKgFp4GtWmYEQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] serial: sc16is7xx: hard reset the chip if
 reset-gpios is defined in dt
To: Maarten Brock <Maarten.Brock@sttls.nl>
Cc: Hui Wang <hui.wang@canonical.com>, Hugo Villeneuve <hugo@hugovil.com>, 
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jirislaby@kernel.org" <jirislaby@kernel.org>, 
	"hvilleneuve@dimonoff.com" <hvilleneuve@dimonoff.com>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"andy@kernel.org" <andy@kernel.org>, 
	"lech.perczak@camlingroup.com" <lech.perczak@camlingroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 2:19=E2=80=AFPM Maarten Brock <Maarten.Brock@sttls.n=
l> wrote:
> > On 6/5/24 18:30, Maarten Brock wrote:
> > >> From: Hugo Villeneuve <hugo@hugovil.com>
> > >> Sent: Tuesday, 4 June 2024 16:23

<...>

> > >> Add function description from original comment "Reset device,
> > >> purging any pending irq / data", since the comment applies to both
> > >> hardware and software reset,
> > > No it does not (at this moment). See below.

...

> > > The problem here is that this only deasserts the reset if it were ass=
erted before.
> > > Nothing happens if it already was deasserted. This makes the delay al=
so pretty
> > > useless.
> > >
> > > To make this a proper reset pulse for the device you must first asser=
t the reset,
> > > then wait >3us, and finally deassert the reset.
> > >
> > > Maarten Brock
> > Hi Maarten,
> >
> > My understanding is when calling devm_gpiod_get_optional(dev, "reset",
> > GPIOD_OUT_LOW) and returning a valid (gpio_desc *), the flag
> > GPIOD_OUT_LOW guarantees the GPIO is set to output and low (assert the
> > reset pin).
>
> Ah, right. Sorry, I missed that.
> So GPIOD_OUT_LOW disregards the inversion from GPIO_ACTIVE_LOW.
> And gpiod_set_value_cansleep(reset_gpiod, 0) uses the inversion to make t=
he pin high.
> Looks fine to me now.

No, you used the correct terms "assert"/"deassert", the parameter
there is logical, means "deassert". It was differently in the legacy
GPIO APIs, which are almost gone.

--=20
With Best Regards,
Andy Shevchenko
