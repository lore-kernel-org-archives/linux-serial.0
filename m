Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197B41DB37A;
	Thu, 16 Jan 2025 09:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737021170; cv=none; b=lH4/QmBq2emo5C8Aohg3XW16JGhSpYgXrgEGeR3g1wgUJ/wDghPF8WcPLp1Bz/3Rd5NZKq7s9/MpjH3LJhgan2o1GFOR0BPiHC9/tNg0Yf2KEc0WZavcvQ3xMyQ0aonk/5BLv3hdPiU+m4s345v1yMqA7260GH6lBV10X13L0oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737021170; c=relaxed/simple;
	bh=L2UUxOMGuGxG8GW4wzlKQJpoCFPkMzYKUeBHnoBd+Cg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ieuIRGzM0p68G2RzYJP9xD258BetNR5vwOsYCKT/mClL4WGiIzeiamcZRfVcyzWhAVXutInQ8JVkN7jB0VbfmaE7MYGISuSGIirRFl6fipnm+XA8xt2VeIv5craYpvcUA20A+EjEnnXBpCjf502ds62Y18RLKY0oH1Lfq9fF74A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=dIeuCZd/; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="dIeuCZd/"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id B2039941A5C2;
	Thu, 16 Jan 2025 10:52:44 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id qaM0QXtDYLc1; Thu, 16 Jan 2025 10:52:44 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 83EE7941A5C4;
	Thu, 16 Jan 2025 10:52:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com 83EE7941A5C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1737021164; bh=/62zQwBA6dRKBrqdB4W9H5JrlHzsBIGxUZl9CNsGqns=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=dIeuCZd/5W+QJzxFqzUyBaJCu+5mVgvsbx8MNDqz0nsp2jpFjkWLLM2ehB/UzG3Nw
	 GIBHjBHSOKk1MnafeNq2Cg0fmVYLu8BSK6Hz3rvzUCuVv5HnWc+oKdgfr05kusCTdg
	 369FeGVbhDDB0YZNU4VdzyDz32HKQIOPtn68ZqfQ5TWS/hRPkQrbB9i4YQpllGVuKI
	 f0CjspNBRwANEep1jiMveKbGxb2qzrM7WaxgiVGXl9UxOCEo/Lq6cTIjeqzsgyd8cd
	 jw736X4vIDmE2IA5jNq+xn7QnER8qSXVoxo2G7TozZ/ASvvjhZa31b0d2+YqUEvOoc
	 efKiG/HJ0QtTg==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 7cIdjsMQHuBk; Thu, 16 Jan 2025 10:52:44 +0100 (CET)
Received: from lt-278851.systec.local (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id 16C21941A5C2;
	Thu, 16 Jan 2025 10:52:44 +0100 (CET)
Date: Thu, 16 Jan 2025 10:52:43 +0100 (CET)
From: Andre Werner <andre.werner@systec-electronic.com>
Reply-To: Andre Werner <andre.werner@systec-electronic.com>
To: Jiri Slaby <jirislaby@kernel.org>
cc: Andre Werner <andre.werner@systec-electronic.com>, 
    gregkh@linuxfoundation.org, hvilleneuve@dimonoff.com, andy@kernel.org, 
    linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
    lech.perczak@camlingroup.com
Subject: Re: [External Email] Re: [PATCH v1] serial: sc16is7xx: Extend IRQ
 check for negative valus
In-Reply-To: <be1bc254-da95-47c2-b81c-e630c0f924b2@kernel.org>
Message-ID: <5556e4f7-79b1-af02-7456-fac9800a173f@systec-electronic.com>
References: <Z4jLU75SU53VGsRU@smile.fi.intel.com> <20250116093203.460215-1-andre.werner@systec-electronic.com> <be1bc254-da95-47c2-b81c-e630c0f924b2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463794929-1730979159-1737021164=:445428"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463794929-1730979159-1737021164=:445428
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Jan 2025, Jiri Slaby wrote:

> This is threaded weirdly.

Sorry for that.

>
> On 16. 01. 25, 10:32, Andre Werner wrote:
> > Fix the IRQ check to treat the negative values as No IRQ.
>
> Care to describe on what HW that can happen?

I have no example on that. In the previous thread it was mentioned that
it is not absolutely sure that the API is not called with negative values=
. Thus,
negative values shall also be treated as no IRQ.

>
> > Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
> > ---
> >   drivers/tty/serial/sc16is7xx.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16=
is7xx.c
> > index 7b51cdc274fd..560f45ed19ae 100644
> > --- a/drivers/tty/serial/sc16is7xx.c
> > +++ b/drivers/tty/serial/sc16is7xx.c
> > @@ -1561,7 +1561,7 @@ int sc16is7xx_probe(struct device *dev, const s=
truct
> > sc16is7xx_devtype *devtype,
> >    /* Always ask for fixed clock rate from a property. */
> >    device_property_read_u32(dev, "clock-frequency", &uartclk);
> >   -	s->polling =3D !!irq;
> > +	s->polling =3D (irq <=3D 0);
> >    if (s->polling)
> >     dev_dbg(dev,
> >      "No interrupt pin definition, falling back to polling mode\n");
>
>
> --
> js
> suse labs
>
>

Regards,

Andr=C3=A9
---1463794929-1730979159-1737021164=:445428--
