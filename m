Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97461A6835
	for <linux-serial@vger.kernel.org>; Thu,  2 Jul 2026 21:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783027492; cv=none; b=X1H+fsQSEB2k3/5IJ0704Opdic1kcii4VWxChDP4nB2gkAiMAXx7O7ooDs9Uv6HHGP5MH/A33ssII2Wj+FK/et5o4kYstT1tfXTgTvE5o/EVgrbTy7w9BBUq4gBvGvHM2b+nXzQPI3TQxeNVLeB9Ds9d9hoWEy1lXTxXxW2v++E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783027492; c=relaxed/simple;
	bh=tutK9aVv6wDMoypPC6ASut9M/kbWxEMMP22VzGHD/XA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HFCM+roWFgZs1KlkrxDzY2uz//R1KPEJMtr8YNaUWZFGafzdfygJyIAnR8vw/ZKx3ylCznjXHd0mrXiIlhnc8pO8U4PyxCf7UvNmIzS+NIViHH7/vXvo4DV/0VbvDu9M2SRSyPR54KUe6PDRR8zs4qtlvpyzVUoyMyt+khnDl5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kauWVhsF; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kauWVhsF"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493c7902f47so6789985e9.1
        for <linux-serial@vger.kernel.org>; Thu, 02 Jul 2026 14:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783027489; x=1783632289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3oR0aFt8SpkVD78ykDsKLCS727d/d5i0zEQfOpOvAs=;
        b=kauWVhsFUjL3EEQA0ZURZphRxk4k5/wds1/1EfP+CQyYyayHBrS+CmxREHPGBHmoo0
         FqPJDl5nuCbglMi+z7yOB3UQse/tKPD57TBhzm5l8TZjKv+HZNh8qv6eWdZFc4dLz0K4
         oquoMGWHsWikCAHbtfWxK9/aL8SJt3dsceCTiyXp9qV6odiEtphBZpGZ+CLw00xC0Zak
         yZM1zfNsL/fEey5Ufi71ISJvfSRr299P5LL0P7Ww2ohnU6qUTngKFa8oaRIi8+5f+9BE
         TAGi+PexV86vyTcKgIwnznH/ct/CCWhW3rl758xoS8/x6JVEZyKNwD+kfyItU0L6Z/XF
         2J5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783027489; x=1783632289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W3oR0aFt8SpkVD78ykDsKLCS727d/d5i0zEQfOpOvAs=;
        b=KkLwFlhFyV8a5S3QdCwLb8vaDu8ZN93Rk8yMadoMCe2/s5KpVlF/RlExHyk6bTatio
         m+teFTtK9mVT74ZnKyFU8B08HeucH9/dUJ1gHlqpIvboF2UMUr2zOQrIXugg1knai0IT
         i+1j45DtLP2VLyBjhMsY2ruuvOJw/9rSj5UuogSQr/hX8cpPLGQPAtElxg4cZShjEzV5
         dELLsWXBrbeaT1IP6j6Nqym4uwbGO0ibb4V6+CHU3mAkWMiM1nnplCg8Qwzge+GdsRma
         qu1JxLmmbALfeYDCRi+4GzKZ0hqpEhe7E1yk2jh5IA2IRXhYxAWiQWy42ecuFQ8CWYQw
         PiZg==
X-Forwarded-Encrypted: i=1; AFNElJ93m6xVRgyTQWBGzwtT1/+TNasImhl8hiEnGII26ZjsndU9WnmhUo8EY+b7irVu6rpGY6G+10AazZ/nqWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYGvodjd8L408IZD5GkwOWYbYqZK0HYxFBr8LnRkryTPBElAsG
	9OnDMR4//eX/qe+gUJ1qVhD4E7NasCKbltGI+w5Tw/vK0tUlMr4qfmka
X-Gm-Gg: AfdE7clIiK1sqhe/Lmmu59yeEEXwQFeI2QscO2fsfnBWowoSRzfmaD1PwMVwifhpZL8
	5Gvuvm9iaiJKopzO1W6/a9q5B0Px3Qybnc6ZySvlO0qYfu3B7MnBpRes7P9gAvwFEcu7F0XFL4w
	VgxYyZ1IiZj6pmEY2Y35kuFBEZfkFBJWWP6WPbWvB90kOt0jmIxB02sxu93UO0gA1li87P/FdQt
	OnPCUpvFaZHA63CAydEN2Ib64vr9lterT+EVrjjgeFTR9h6wzigyXH8RUMBbvkEhVJAj4gGnIWv
	ZMiUw25aEsYRM+Kc343E7Q27lxpPWelCRC40RcaDtoMXriWyhIYhvfiYgI/Ab4F51xtJS4ZDsQH
	6Z/ca4poVdeG/VjrTAFLXWcHVJBmh0cjvGTMIzemnsy8szKN8ww7KhHsh/aoPbld+elDGnxxv7X
	EO7t3ZzPM7A5dNmWSWiZq1H78Z8K0nVNlK/aXKmiWIP5Xn+w==
X-Received: by 2002:a05:600d:848c:20b0:493:c83b:50d7 with SMTP id 5b1f17b1804b1-493c83b5113mr30887675e9.6.1783027488836;
        Thu, 02 Jul 2026 14:24:48 -0700 (PDT)
Received: from pumpkin (host-92-21-50-228.as13285.net. [92.21.50.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c637568dsm80011885e9.4.2026.07.02.14.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 14:24:48 -0700 (PDT)
Date: Thu, 2 Jul 2026 22:24:46 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Maarten Brock <Maarten.Brock@sttls.nl>
Cc: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>, Crescent Hsieh
 <crescentcy.hsieh@moxa.com>, "linux-serial@vger.kernel.org"
 <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "jirislaby@kernel.org"
 <jirislaby@kernel.org>, "hvilleneuve@dimonoff.com"
 <hvilleneuve@dimonoff.com>, "tobias.gannert@ziehl-abegg.de"
 <tobias.gannert@ziehl-abegg.de>, "joachim.knorr@ziehl-abegg.de"
 <joachim.knorr@ziehl-abegg.de>
Subject: Re: [PATCH 2/2] serial: sc16is7xx: set TX FIFO trigger level to
 half FIFO to prevent underruns
Message-ID: <20260702222446.0e06a21c@pumpkin>
In-Reply-To: <GV2PR05MB11941819970EF65A5770A4AE783F52@GV2PR05MB11941.eurprd05.prod.outlook.com>
References: <GV2PR05MB1194183F888F21065CC596F3D83EC2@GV2PR05MB11941.eurprd05.prod.outlook.com>
	<418f9ae5-8827-475c-b465-1271a784fbf1.bc56e27e-ecd8-43ae-bb87-75bfd472a28d.88efbd1d-67dc-430a-adbe-b90700d161bb@emailsignatures365.codetwo.com>
	<20260701164056.951230-1-paultyson.mbewe@ziehl-abegg.de>
	<20260701184144.62bac61e@pumpkin>
	<GV2PR05MB11941819970EF65A5770A4AE783F52@GV2PR05MB11941.eurprd05.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 2 Jul 2026 12:17:01 +0000
Maarten Brock <Maarten.Brock@sttls.nl> wrote:

> > From: David Laight <david.laight.linux@gmail.com>
> > Sent: Wednesday 1 July 2026 19:42
> >=20
> > On Wed, 1 Jul 2026 18:40:56 +0200
> > Paul Mbewe <paultyson.mbewe@ziehl-abegg.de> wrote:
> >  =20
> > > Hi David, Maarten,
> > >
> > > I rechecked this with ftrace, and I think the right explanation is
> > > narrower than my v1 commit message.
> > >
> > > The underrun trace shows the SC16IS7xx refill path running with the
> > > hardware TX FIFO already empty while the tty xmit FIFO still had data
> > > queued, for example:
> > >
> > > =C2=A0 sc16is7xx delayed refill: line=3D0 txlvl=3D64 pending=3D172
> > >
> > > So the conclusions for me are:
> > >
> > > =C2=A0 - The driver can catch up if the FIFO is only partially draine=
d when
> > > =C2=A0=C2=A0=C2=A0 the THRI path runs. TXLVL will report more than th=
e nominal trigger
> > > =C2=A0=C2=A0=C2=A0 amount and the driver can write more bytes.
> > >
> > > =C2=A0 - Once TXLVL is 64, the FIFO has already emptied and the TX ga=
p has
> > > =C2=A0=C2=A0=C2=A0 already occurred. =20
> >=20
> > Right, but there must be something happening after the previous time the
> > fifo was filled that makes this one happen too late.
> > Either the hardware ISR was very late or it didn't schedule the thread.
> >=20
> > Thinks.....
> > Maybe you are getting a fifo empty interrupt (rather than the fifo thre=
shold)
> > interrupt, with the threshold one getting lost.
> > So what happens if the threshold is reached while the threaded ISR is s=
till
> > running?
> > When that happens the ISR needs to loop, either in software or by re-en=
abling
> > a level-sensitive interrupt so that another hardware interrupt happens
> > immediately. =20
>=20
> The loop is already present in sc16is7xx_irq() with=20
> do { ... } while (keep_polling);

That loop also processes multiple interrupt sources.

I've been looking at the code (but don't have the data sheet).
I'd look at what:
	sc16is7xx_port_read(port, SC16IS7XX_TXLVL_REG);
returns both at the bottom of sc16is7xx_handle_tx() and much later
when the IER is re-written by the other work item.
You might find trace_printf() useful - writes into the ftrace buffer.

Did ftrace show you a hardware interrupt at the time when the fifo would
have been expected to have 8 free entries?
Also how many byte times later was the interrupt (real and threaded) that
found the fifo empty?

I also noticed that the code re-enabled the tx interrupt at the end of
the threaded isr - is this actually needed? or is it just there because
the same code is called to send the first buffer.
If this is needed then it is possible that it won't generate an interrupt
if the fifo already has enough space.

There is also a question of how the hardware interrupt itself is handled.
I think there will be a single level-sensitive output from the device
itself.
This will trigger the hardware interrupt which then schedules the threaded
isr, but the hardware interrupt has to be masked until the threaded isr
finishes.
When the hardware interrupt is re-enabled you need the hardware ISR
to run if the irq line is still (or again) asserted.
If that is edge triggered things will go wrong in the way you are seeing.

	David


>=20
> > I'm not at all sure how that works with threaded ISR on the SPI interfa=
ce.
> > Especially since you really don't want to read any more SPI registers
> > than absolutely necessary (you need to avoid PCIe reads as well!).
> >=20
> > For a 'normal' ethernet driver rx path it is important to check the next
> > rx ring entry a second time after enabling the hardware interrupt.
> > Otherwise you miss a wakeup.
> > I think you are getting (effectively) the same problem.
> >=20
> > You might need to use (say) ktime_get_ns() to work out how many bytes
> > were transmitted between the fifo space being read and the end of the
> > fifo writes to see if you need to do a second refill.
> > (Or, rather, to detect that you definitely don't need to do one.)
> >=20
> > With the threshold set to 32 it is much less likely that it will be hit
> > during the fifo writes, so you are much less likely to lose an interrup=
t.
> > But scheduling delays could still make it happen.
> >=20
> > 	David
> >  =20
> > >
> > > =C2=A0 - The v1 explanation was wrong to describe a 32-free-space tri=
gger as
> > > =C2=A0=C2=A0=C2=A0 increasing the per-interrupt refill window. It doe=
s not. With the
> > > =C2=A0=C2=A0=C2=A0 default trigger, the FIFO has about 56 character t=
imes left when THRI
> > > =C2=A0=C2=A0=C2=A0 fires; with a 32-free-space trigger, it has about =
32 character times
> > > =C2=A0=C2=A0=C2=A0 left.
> > >
> > > =C2=A0 - As Maarten pointed out, the benefit is the other side of the
> > > =C2=A0=C2=A0=C2=A0 trade-off: the refill event rate is reduced by 4x,=
 from roughly
> > > =C2=A0=C2=A0=C2=A0 1 refill per 8 transmitted bytes to 1 refill per 3=
2 transmitted bytes.
> > >
> > > =C2=A0 - On the tested SPI-backed system, that lower refill rate redu=
ces the
> > > =C2=A0=C2=A0=C2=A0 IRQ/SPI load enough to avoid the observed underrun=
s.
> > >
> > > The change is limited to SPI-attached parts so the I2C case is
> > > unaffected.
> > >
> > > For v2 I will:
> > >
> > > =C2=A0 - rework the commit message around Maarten's trade-off calcula=
tion:
> > > =C2=A0=C2=A0=C2=A0 4x fewer TX refill events, at the cost of reducing=
 the time-to-empty
> > > =C2=A0=C2=A0=C2=A0 margin from 56 to 32 character times;
> > > =C2=A0 - limit the TX trigger change to SPI-backed SC16IS7xx devices;
> > > =C2=A0 - leave the RX trigger level unchanged. =20
>=20
> I see no reason to limit this to SPI or to the transmit case only.
>=20
> > > If maintainers would prefer this to be board-configurable instead, I =
can
> > > look at a follow-up DT binding/property, but I would prefer to keep v2
> > > focused on the TX/SPI case.
> > >
> > > Thanks,
> > > Paul =20
>=20
> Further, I think this should be combined with this recent patch proposal =
from Crescent Hsieh:
> [PATCH v2 14/15] serial: 8250: allow UART drivers to override rx_trig_byt=
es handling
>=20
> which introduces a way to set/get the rxtrig count per port. A similar th=
ing can be added for txtrig.
>=20
> Kind regards,
> Maarten Brock
>=20

