Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFD7188015;
	Sat, 18 Jan 2025 19:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737228535; cv=none; b=BJgwU8u0CYwld+glOmnVfLJ8H/LfoYOnnYF8GgBAgHqrQRbhmg56vE8U2X8hc3QomP0KtZ7bJzIDDHESxTZftbvqx2DEDF0Ny+5pIoiVA1Cjs/7iPRg6DyWXt+2V8OcHc6semZY1m91sMY2FdMYPr8hBta71ZXRelQYKzbc21Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737228535; c=relaxed/simple;
	bh=rCSgGJdMvkixqinErQDMDfsHyN7+HLNCn1BGYlbBRa8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FUIZLmxbq65QVAjRAuCNWmYGfgiPsjeGjscSNUWLeW1G7fqkj16X8mSblFJnArWpC4lnRf2ItYT4MNC79YZQLmcQbjVztf+Tqej4Na+ACTyDdsplZlU0NdQVjTgnidnNx9hwRPQ1S927hqPCYykKXPWvRTaT268sCS/FgBlIsVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=euOh3Ny7; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="euOh3Ny7"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 2D1F1941A5C4;
	Sat, 18 Jan 2025 20:28:50 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id FNOwplArG6Ke; Sat, 18 Jan 2025 20:28:50 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 04DF9941A5C5;
	Sat, 18 Jan 2025 20:28:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com 04DF9941A5C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1737228530; bh=H0M0hSkBnDR8T+NN65miux2gc3ZSjTHoFhzPdzxyyvo=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=euOh3Ny7862VWguQTUdEj0bCbTDlnwA7lsG9wwl2xTj8ogs/oqew7GITB060E5vtQ
	 SLlFeYRtmvoXJYHxnQRH8caS4Ly5m8piWvCSJzhGketsQ50mQNkze7jsdb/qlxfAlh
	 aZ+AuFP0A2NYATy1bDAB5/rueUItgu2u7CfrdhXMlFn50h6M336C/X2HNfh3SQuhZ9
	 7dihOTAuhwkqx9XjqiaZsZZYrHYWqurK/HTkQzlxR/czOgprcq5jYUvwAdbkId5U/r
	 87kTVy9WE48zgUw45yBcR8ObhOWpnIhW59MtQpqusLZSZVTjBSrVEY/II44CcHkDgv
	 UIdqzC6ShItBA==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id uDBPNRwsGnDi; Sat, 18 Jan 2025 20:28:49 +0100 (CET)
Received: from lt-278851.systec.local (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id B041E941A5C4;
	Sat, 18 Jan 2025 20:28:49 +0100 (CET)
Date: Sat, 18 Jan 2025 20:28:49 +0100 (CET)
From: Andre Werner <andre.werner@systec-electronic.com>
Reply-To: Andre Werner <andre.werner@systec-electronic.com>
To: Greg KH <gregkh@linuxfoundation.org>
cc: Andre Werner <andre.werner@systec-electronic.com>, jirislaby@kernel.org, 
    hvilleneuve@dimonoff.com, andy@kernel.org, linux-kernel@vger.kernel.org, 
    linux-serial@vger.kernel.org, lech.perczak@camlingroup.com
Subject: Re: [External Email] Re: [PATCH v2] serial: sc16is7xx: Extend IRQ
 check for negative values
In-Reply-To: <2025011855-ashen-gigantic-f832@gregkh>
Message-ID: <2ba9bd72-f391-7590-d309-c1c2ecc5ce78@systec-electronic.com>
References: <20250117171822.775876-1-andre.werner@systec-electronic.com> <2025011855-ashen-gigantic-f832@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463794929-166577447-1737228529=:774377"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463794929-166577447-1737228529=:774377
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Dear Greg,

> On Fri, Jan 17, 2025 at 06:18:22PM +0100, Andre Werner wrote:
> > Fix the IRQ check to treat the negative values as No IRQ.
> >
> > Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
> > ---
> > V2:
> > There are no changes to the patch itself. The previous patch submissi=
on
> > had a very weird structure within the discussion thread:
> > https://lkml.org/lkml/2025/1/16/398
> > This is simply a new thread opened for better handling.
> > ---
> >  drivers/tty/serial/sc16is7xx.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16=
is7xx.c
> > index 7b51cdc274fd..560f45ed19ae 100644
> > --- a/drivers/tty/serial/sc16is7xx.c
> > +++ b/drivers/tty/serial/sc16is7xx.c
> > @@ -1561,7 +1561,7 @@ int sc16is7xx_probe(struct device *dev, const s=
truct sc16is7xx_devtype *devtype,
> >  	/* Always ask for fixed clock rate from a property. */
> >  	device_property_read_u32(dev, "clock-frequency", &uartclk);
> >
> > -	s->polling =3D !!irq;
> > +	s->polling =3D (irq <=3D 0);
> >  	if (s->polling)
> >  		dev_dbg(dev,
> >  			"No interrupt pin definition, falling back to polling mode\n");
> > --
> > 2.48.0
> >
> >
>
> What commit id does this "fix"?

104c1b9dde9d859dd01bd2d71a2755a2fae43e15

https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?h=3D=
tty-next&id=3D104c1b9dde9d859dd01bd2d71a2755a2fae43e15

>
> thanks,
>
> greg k-h
>

Regards,
Andr=E9
---1463794929-166577447-1737228529=:774377--
