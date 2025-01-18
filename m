Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4ABA92F;
	Sat, 18 Jan 2025 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737220829; cv=none; b=tI+i2M2A8xQN/JHREiHd+2eQmvj9o6sjpK02eg2E0FEAVnVog4zstZHb4218gup0tQ/j8gQ9jCVqJqR88kXUaljLEcSE2fww184Lw7W3SEx1uWoNIcm6mUXzXOX+LoUyByLarwHlKf3cy2AKMrPjWIg2GGCHFfNw1HRykh3KORA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737220829; c=relaxed/simple;
	bh=ALrs/33NZ1esk7EZALqGOzi1tTuds98n+0tIZdYBnPQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AL94lIFg9JznD8RX0KTDCwW1OWjE3yktR9hf4GSWN+k5aYPbEkSy4MsuLszBPthJISleYw24pdkx7ZmW3/wOGYW6aWXqyVxDpdpnjObLxREUxyMPgHmP5nSBuq0Pn6QNkziKUjFeYoygrrZdPjO7iXWTVQbvfo11iVdmlQNJb4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=RhGssfAp; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="RhGssfAp"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 1AB19941A5C4;
	Sat, 18 Jan 2025 18:20:17 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 5--W_L56DrhN; Sat, 18 Jan 2025 18:20:17 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id E21F1941A5C5;
	Sat, 18 Jan 2025 18:20:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com E21F1941A5C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1737220816; bh=X/ZRCjtxOshx5LHw495N3TIxAHJhRR74amrE4dNPSv8=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=RhGssfAp4DOCP+nPYRAQNPFR3g9aVNJYxDndxkKa1RCP5hIl0wK0pEi8odwKuvDH3
	 rCvoQ2/5YHEgoZlChpePoKbW48C4tcHJUstoYiI98Lx8aGEcRH+cXyJlX2I6WHmu3j
	 cGvTEQ3qI1MsjbmEvAT5fm+MMFT0JbaRodf7KJp+Xvh6npTudipWOXbJM6seVY9hHU
	 3mTF9D3SWbZHg2MF2Ec6aKz1ljh/ynXpy4YH6CxvuSz8t9fZ5uiGgMM8ro7hNVhPoe
	 rx/Z9mYwPsNvc9mpEFQ5r8eqK5pH/FMWMvSq2iHXMKY8XzFMWvtc8HjTpM9LjmwLB4
	 Pc2kTfkcdqh3Q==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id ooe-U8vHWxoJ; Sat, 18 Jan 2025 18:20:16 +0100 (CET)
Received: from lt-278851.systec.local (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id 8E8F4941A5C4;
	Sat, 18 Jan 2025 18:20:16 +0100 (CET)
Date: Sat, 18 Jan 2025 18:20:16 +0100 (CET)
From: Andre Werner <andre.werner@systec-electronic.com>
Reply-To: Andre Werner <andre.werner@systec-electronic.com>
To: Maarten Brock <Maarten.Brock@sttls.nl>
cc: Andre Werner <andre.werner@systec-electronic.com>, 
    "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
    "jirislaby@kernel.org" <jirislaby@kernel.org>, 
    "hvilleneuve@dimonoff.com" <hvilleneuve@dimonoff.com>, 
    "andy@kernel.org" <andy@kernel.org>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, 
    "lech.perczak@camlingroup.com" <lech.perczak@camlingroup.com>
Subject: Re: [External Email] RE: [PATCH v2] serial: sc16is7xx: Extend IRQ
 check for negative values
In-Reply-To: <AS8PR05MB9810FA4CE091AD28EEE9B73683E52@AS8PR05MB9810.eurprd05.prod.outlook.com>
Message-ID: <23799bf9-c61b-f528-e0e5-03a96d232ecc@systec-electronic.com>
References: <20250117171822.775876-1-andre.werner@systec-electronic.com> <AS8PR05MB9810FA4CE091AD28EEE9B73683E52@AS8PR05MB9810.eurprd05.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463794929-674452180-1737220816=:774377"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463794929-674452180-1737220816=:774377
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dear Maarten,

> > -----Original Message-----
> > Fix the IRQ check to treat the negative values as No IRQ.
>
> It seems to me that this is a real fix and needs a Fixes tag.
> See below.
>
> > Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
> > ---
> > diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16=
is7xx.c
> > index 7b51cdc274fd..560f45ed19ae 100644
> > --- a/drivers/tty/serial/sc16is7xx.c
> > +++ b/drivers/tty/serial/sc16is7xx.c
> > @@ -1561,7 +1561,7 @@ int sc16is7xx_probe(struct device *dev, const s=
truct
> > sc16is7xx_devtype *devtype,
> >  	/* Always ask for fixed clock rate from a property. */
> >  	device_property_read_u32(dev, "clock-frequency", &uartclk);
> >
> > -	s->polling =3D !!irq;
> > +	s->polling =3D (irq <=3D 0);
>
> When irq>=3D0 these two lines above have a different outcome!
> irq=3D=3D0   =3D>   !!irq=3D=3Dfalse   <=3D>   (irq<=3D0)=3D=3Dtrue
> irq=3D=3D1   =3D>   !!irq=3D=3Dtrue   <=3D>   (irq<=3D0)=3D=3Dfalse

Thanks for the advice. I have not seen this all the time I looked at the
code. I accidentally forget to delete the second '!' as I did with the co=
de
tested at the embedded device. Thanks for the advice.

Should I need to submit this patch again with a Fixup prefix or what need=
s
to be done?

>
> >  	if (s->polling)
> >  		dev_dbg(dev,
> >  			"No interrupt pin definition, falling back to polling mode\n");
>
> Kind regards,
> Maarten
>

Regards,
Andr=C3=A9
---1463794929-674452180-1737220816=:774377--
