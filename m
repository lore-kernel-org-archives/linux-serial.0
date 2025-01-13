Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D94422F156;
	Mon, 13 Jan 2025 13:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736773352; cv=none; b=C0Fz/RElxRsOCwIq4t9u39PHj/p3EAgAPi6yX4ofjIT/eNAOzV4pMkHtoQYbZHEJXX05CQuFNXFC69DfKmX78/Wi9IqV5ysFwu7qJMenWG/PWJ7sxkkCsA5Gfmef58c6EwA5M4Os1bUHJZa4jRcZn1sZWstmr/C8hNRa+dIEMUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736773352; c=relaxed/simple;
	bh=aqmu/qkjqlhGQv0Lis8wCSKZ/oaM4MH5pWfoNvpe6T4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=d+t1KFmqOD+GW/FztuYEN40f+GLdBEpC8ZjBwDq0SFvxtNPIZLDj65qDwCAVVob5rBFpCv7pvvf9KGsQTl5gRaDmkF3wimj9NytZeTBAX95WIy6f+a3aSZP+Q768xjJ4BXKru/XXKmClrKSpdU7l3ewP7gFZ4iRkH/6bNPwn6mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=Im9q1i+U; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="Im9q1i+U"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id C53A79400101;
	Mon, 13 Jan 2025 14:02:26 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id TW_d09oMz2ln; Mon, 13 Jan 2025 14:02:26 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 9BE4594016AA;
	Mon, 13 Jan 2025 14:02:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com 9BE4594016AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1736773346; bh=/5zRGO5vds9rfmPHMvEZh5mofeIUv2zJYgNyTxnkLSY=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=Im9q1i+UEMmilbbvt3zbh4isQrFCPYCoc5REM1cmUrcSBpmadkJlaNBRT50XxSH6L
	 nf+wzcgTrro593BuGgYf6HNXBgQ65tX+k3OgvY+tzg711iS5bXZj8AfVEQTnqWlEGD
	 5veilSKOoEIQPSAkUaxRwBcUibwcqkjjJVhNdJGTXMiAEuBg7ETCrb2/tq4as+Io5a
	 hrAR3EoTl5EHFZ1nXoEjfeYocQdUZw4VcLsX9fSWU4iMKaeA8pp7KdbcRgtTfc+KV1
	 UXJUzhv1UFFuJVt0hBVDia6gWMQLinyqb2PV2FTbpdT05KquWMfpRe4y5M6Aif26hk
	 NBQxLRTM4L9WA==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 7jcFuSWnzWFY; Mon, 13 Jan 2025 14:02:26 +0100 (CET)
Received: from lt-278851.systec.local (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id 3D8129400101;
	Mon, 13 Jan 2025 14:02:26 +0100 (CET)
Date: Mon, 13 Jan 2025 14:02:25 +0100 (CET)
From: Andre Werner <andre.werner@systec-electronic.com>
Reply-To: Andre Werner <andre.werner@systec-electronic.com>
To: Andy Shevchenko <andy@kernel.org>
cc: Andre Werner <andre.werner@systec-electronic.com>, 
    gregkh@linuxfoundation.org, jirislaby@kernel.org, hvilleneuve@dimonoff.com, 
    devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-serial@vger.kernel.org, lech.perczak@camlingroup.com, 
    krzk+dt@kernel.org, conor+dt@kernel.org, robh@kernel.org
Subject: Re: [External Email] Re: [PATCH v6 2/2] serial: sc16is7xx: Add
 polling mode if no IRQ pin is available
In-Reply-To: <Z4UMP1-0x25g1fX2@smile.fi.intel.com>
Message-ID: <6ccaf061-c3d7-c78a-17e3-f0b9642c412f@systec-electronic.com>
References: <20250113073030.15970-1-andre.werner@systec-electronic.com> <20250113073030.15970-2-andre.werner@systec-electronic.com> <Z4UMP1-0x25g1fX2@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463794929-1597953312-1736773346=:17662"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463794929-1597953312-1736773346=:17662
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Jan 2025, Andy Shevchenko wrote:

> On Mon, Jan 13, 2025 at 08:30:30AM +0100, Andre Werner wrote:
> > Fall back to polling mode if no interrupt is configured because there
> > is no possibility to connect the interrupt pin.
> > If "interrupts" property is missing in devicetree the driver
> > uses a delayed worker to pull the state of interrupt status registers=
.
>
> pull ? Hmm...

Ah ... poll ... sorry.

>
> ...
>
> > V6:
> > - Use polling mode for IRQ numbers <=3D 0 which encounter no valid IR=
Q
> >   were found/defined.
>
> Thanks, this part looks better now.
>
> ...
>
> > +static void sc16is7xx_poll_proc(struct kthread_work *ws)
> > +{
> > +	struct sc16is7xx_port *s =3D container_of(ws, struct sc16is7xx_port=
, poll_work.work);
> > +
> > +	/* Reuse standard IRQ handler. Interrupt ID is unused in this conte=
xt. */
>
> Period.

What do you expect here? Shall I add the period time from the define as
the dedicated value? I do not understand what I should add here in
detail.

>
> > +	sc16is7xx_irq(0, s);
> > +
> > +	/* Setup delay based on SC16IS7XX_POLL_PERIOD_MS */
>
> No period.

Or do you mean that I add the define only once and not add all used
places?

>
> > +	kthread_queue_delayed_work(&s->kworker, &s->poll_work,
> > +				   msecs_to_jiffies(SC16IS7XX_POLL_PERIOD_MS));
> > +}
>
> Please, go through the comments you added in the patch and use the styl=
e that
> is mostly used in the driver for the similar (one-line comment) situati=
ons.
>
> ...
>
> > +		/* Initialize kernel thread for polling */
>
> Again, no period.

Same here. Do you expect the value here or the name of the used define?

>
> --
> With Best Regards,
> Andy Shevchenko
>
>
>

Thanks in advance

Andr=E9
---1463794929-1597953312-1736773346=:17662--
