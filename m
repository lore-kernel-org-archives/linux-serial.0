Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.82.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794192611;
	b=3vkooLCVkuvqmQhduh0ioaYjXpx0sMOE6TlpEffobGAjVth/TGwQOom8wya4E+ajOiQD
	 t+dAhGRKBl8jY3rfWHFozzgNuXxH24vMAv4mJ2r451gjnd+vLpU89hiWMOiwiRwfKa0Nt
	 bl1AS+UqtRsNiip5rMmjHEM4rRfdvhAjd2lWqqvXccrZaqysTft7/7uDyLtPfIO66TLX1
	 PV6co9Zj7UhfTZSFItMk+4+QYtyu9pceAz3UqIj5OX2sTMqWELeMkRtfkMrhpe4V30Fcs
	 PBWFxvIdRmICH+qDXDeyMGIP9/MIWbpRxU2xRtaLHb9pZsQk9Z2/j3dZTcKQbfv5E/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794192611;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ed7qSEh0MYcYsCSvjaeOTvgwKguOiXkGsv7GSaDrJYQ=;
	b=14FqNePWly3Yz2PEhCRvm5vt4YNhrtTz5HgwLxRF5v5Fcj4ZBr5Od3+gAF22q8RdpxWf
	 6LKlr8yD9AiWjHr37VW1y7/CCs30UXcRCnRfI4dN49wzsa5TXzuZBqO2e5nQZHerI0/hX
	 KblGzRzwjUl7eRfwYkgZL53PSTIYXOdldGwxJt7940Xm3E25RHOgeFzRUg0jXqr/0GSGq
	 lNFDe3tZ3areBwAegO3TpW51rOqsC5AwWfrfOaE8aXOVYh1s0v30DMdOfRhIHhAZV0Jz2
	 k/UOgjQOEmj+R363Xe/99YRXO46FF3yqcYQxB0hlaDjTsPOFhRFnGmk0KfhOJ68nFFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spacemachines.com;
	spf=pass smtp.mailfrom=spacemachines.com;
	dkim=pass header.d=spacemachines-com.20260707.gappssmtp.com header.i=@spacemachines-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="ILww/xj7";
	arc=fail smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D053606A321
	for <linux-serial@vger.kernel.org>; Mon,  9 Nov 2026 02:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D053606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spacemachines.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spacemachines.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spacemachines-com.20260707.gappssmtp.com header.i=@spacemachines-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ILww/xj7
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-36ff9c9da34so708735eec.1
        for <linux-serial@vger.kernel.org>; Sun, 08 Nov 2026 18:50:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794192610; cv=none;
        d=google.com; s=arc-20260327;
        b=gMBJ+bh5+ftWERnvbq7hEZb0dPTujCP0L7FxbPJKREaEeQnl/FfLoYxfaraMyP0SHL
         dc1joWlAygjD2cmSn1xuQOx10kGULQZPMgOQjByxd1Bz8tTczgMM0UVOwydMibzNhq9B
         GYBadgeKlMVsU1QXCY++L50rQknhpLU46PssPXhgPCokH7q0N2Sawlw3q4p+vCAgEjC3
         cXoiYXU9jL/5OHXaNP9Nvq3uMF2SNuErYYyu6LHGACMM/eEB5l4GlWM/EBwBCi9oYuo0
         LYlw5KBAA6+sOuL0y7BiZWuSzHsHI3snvOeOgJj3lEPR3+Xk0FPdagyd0+Fyb2G01k7q
         kQyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ed7qSEh0MYcYsCSvjaeOTvgwKguOiXkGsv7GSaDrJYQ=;
        fh=Gx6wiB5X8iXrAdXYJfI1PujcaB8gRYoqErrZHfI1wkE=;
        b=mYCYYaMOa/m8MBGRrmBDil+8YcIbOvk//1K/iP0/465pJ7PMAonDFQFxQ+MuY66aua
         lRh+vdOoFGyq/RIRCEVq89BdV9si+nVm7cEKdHWACan4FijIAxCelbOj5xdvyA9q1rKJ
         VIsrzL6uOka+TAA63ad4x8WqCb2E4L66xHo7di8hs8X/KeDfn/MrlHBHyosQE342PzYg
         ndy8PZdoQYY72tIgmVzKmdLLK+fuMkuRSNOjWjn1uShHTpcN/kyzRnXyG7JoAS+LRy3Q
         +DDPViFk8K4w0BOLRhv8n8sysLDWeZl/wsn+f+p4tZsh8MSDvGnp+HYCXzClxQfGOlXu
         SHkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spacemachines-com.20260707.gappssmtp.com; s=20260707; t=1794192610; x=1794797410; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ed7qSEh0MYcYsCSvjaeOTvgwKguOiXkGsv7GSaDrJYQ=;
        b=ILww/xj7Xp3Hs4hWMpGlZDMA45MuHuRp7Ipq58oF5l0mbLOZqesuXhF665BfF9E4AZ
         GYmh5WB3sKwWpNZ/ezUO0PaM/8pgWL5R+HgDwghrPsONKKRJkUsH2Ghz+H6Kb/56iaMz
         7jkCjhYFAeHfnBrQRZEHf9shrfVul3oIQBDK4vbU4AFbz88u0tuedCpNf0eZE6aMqy0B
         KOM0mtWX84JxVM+zeDlrKw7D0sMCMoyUjsiO/K4iDy+lCywxvLxj2XVGvEliSRCP9N4l
         bfJoas6JHUf5UwxjsrtGyn19Xo97S8ccWIpjh8bs02zBw8PnoqL95m5jYnBJnaOXy5ML
         OlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794192610; x=1794797410;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ed7qSEh0MYcYsCSvjaeOTvgwKguOiXkGsv7GSaDrJYQ=;
        b=QXQzkMpd7c4f8UshMefzq+X+Z7+buguAzK/l5Fa16ZgbKAzAQ5/q2uIrawPFKGCCVf
         fSozvMoUsYOtHNgf+F6wykv5jBAR+LLe9GGBLy3i/Olu8ZmilJzqYxXYoEhHhwSjVHdS
         Y/+q0Sva5vetbhdvMJSe0l92cSFaRcf7bq7xCIt8Qb3HvvEzyBoH4+94wBb4Omai4Ft5
         wfq2i17Xa/eNVYi2mgKR5wqhtzwIR2UvFq6cqxeyePopActAz+niCN4RWbrEjMxUQIHq
         uc9JMz6uwgpxJQhE+rLnPh/V5p/WDEgcjQEabkNLmxneTTcBdnCjp/dmDtsHRXiXdYfB
         glfA==
X-Forwarded-Encrypted: i=1; AL+hErGmea7VaGbzDDXx0LtY8UV5GJATEwUdklVggjQElCCrdtfjU1C6NCWDyfvienJAmXdy7YNePjTFCdPC3sE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+KIVp9H/qiFnPH3HoWXEJpLj8tLcM8Sv7y9EikXfC20ImC023l
	XnUJLakqPIsNJSi19k4XKUrgkHDwnfv1gXNd4TWSLuso7wsMJYcRhZOey1VHNRBl0LKuZ9tVi1K
	SICPB3Ltv9JxLEsYWdsBsvGyHKZ+sZ41v2/s1OYO4vw==
X-Gm-Gg: AYBFou1jwdkAkxhiiCLOQ2T4DDHeR8bJ+/2XL3nCtR4N4BafadRBUcAaW9f6p9c3kDj
	uNCYts+BZsrgbHAr/WqDiYyj46KfLFt0AWb9IZTnWuxEZ3DbsIh7Fnx59BJqczepB+qZImIE0EG
	wnk5eeXlmpqczgyy9ovQiwpxlfU6hwEr55dvKyg774mG166Wh0PJBaS3z5P3nj4WoyJUl0iSW/V
	DPYYCUHvudbVKacxhq77ST3YfLbgLPX4vwnBmTfm73wQqdOnp+jhEHLkKZyltlVYLM6dMgStK1k
	UiUn+6ZZ3RRYTXbbN3l6As0OzcqULyDkB9v9Dv3/oNJqoQir/EUg37LdQxUNKPMzxsCY+S9sv0b
	ZX2sm+NM3fmvoCBu1oDScbErEP4vY+/wZh0fRLQ==
X-Received: by 2002:a05:7301:f29:b0:36e:b3e6:ebe7 with SMTP id
 5a478bee46e88-37256bf3a85mr5778794eec.26.1794192610085; Sun, 08 Nov 2026
 18:50:10 -0800 (PST)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103-core16550-rs485-v1-0-6d15ebe1e5b9@spacemachines.com>
 <20261103-core16550-rs485-v1-2-6d15ebe1e5b9@spacemachines.com> <20261104-aqueduct-caregiver-1513775dd0f8@spud>
In-Reply-To: <20261104-aqueduct-caregiver-1513775dd0f8@spud>
From: Kohei Otsuka <kohei@spacemachines.com>
Date: Mon, 9 Nov 2026 13:49:58 +1100
X-Gm-Features: AclHuK_TaLU_humEBm6TAF3Q-YezCM8lbSJnIvWc-8zfqGYMOgplq9g4PPOrSlU
Message-ID: <CADMKYUBHCG3h4tGuDTZUyrLSK1UJmDZvTAvVtmZchtPBTy2WwA@mail.gmail.com>
Subject: Re: [PATCH 2/2] serial: 8250_of: drop RS-485 RTS on Microchip Core16550
To: Conor Dooley <conor@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lubomir Rintel <lkundrak@v3.sk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, conor.dooley@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 3:28=E2=80=AFAM Conor Dooley <conor@kernel.org> wrot=
e:
>
> On Tue, Nov 03, 2026 at 11:11:32AM +1100, Kohei Otsuka wrote:
> > Core16550, a 16550-compatible UART for Microchip FPGAs, interrupts on
> > THRE but not on TEMT. When the last character moves from the FIFO into
> > the shift register, the THRE interrupt calls __stop_tx(), which finds
> > TEMT clear and, without UART_CAP_NOTEMT, returns to wait for a TEMT
> > interrupt that never comes. RTS, and with it the RS-485 driver enable,
> > then stays asserted after the frame, and receive interrupts, disabled
> > for the half-duplex transmission, stay off.
> >
> > Set UART_CAP_NOTEMT for nodes compatible with "microchip,core16550",
> > so em485 drops RTS from its stop timer one frame time (plus 1/7) after
> > THRE, as it does for DesignWare UARTs.
> >
> > Set UART_CAP_FIFO as well: with the capabilities already non-zero,
> > serial8250_do_startup() no longer fills in the PORT_16550A default,
> > and without UART_CAP_FIFO serial8250_clear_fifos() does nothing, so
> > the RX FIFO is not flushed at the end of a half-duplex transmission.
> >
> > Link: https://github.com/linux4microchip/meta-mchp/issues/5
>
> It's worth noting that in that GitHub link I pointed out that the time I
> recall this core being used they required changes to the baud rate logic
> in the driver and that there were differences between how the baud rate
> is actually determined from the input clock:
> | The docs for core16550 say:
> |
> | This block takes the input PCLK and divides it by a programmed value (f=
rom 1 to 216 =E2=80=93 1). The result
> | is divided by 16 to create the transmission clock (BAUDOUT)
> |
> | whereas ns16550a docs say:
> |
> | The UART includes a programmable baud rate generator
> | that is capable of dividing the timing reference clock input
> | by divisors of 1 to (216-1 ), and producing a 16 x clock for
> | driving the internal transmitter logic. Provisions are also included to=
 use this 16 x clock to drive the receiver logic.
>
> Kohei reported not being affected by this, but I figured it was worth
> mentioning.

Thanks for flagging it. As I read the two quotes, they describe the
same arithmetic: Core16550 divides PCLK by the divisor and then by 16,
and the 16550 divides its reference clock by the divisor to get a 16x
clock. Both give baud =3D clk / (16 * divisor), which is what the 8250
driver programs.

That matches what we see. With PCLK at 50 MHz, the driver programs a
divisor of 27 for 115200 (115741 baud, +0.47%), and all four ports
exchange data cleanly with external USB-RS485 and USB-RS422 adapters.
They wouldn=E2=80=99t if the core divided differently.


>
> Cheers,
> Conor.
>
> > Signed-off-by: Kohei Otsuka <kohei@spacemachines.com>
> > ---
> >  drivers/tty/serial/8250/8250_of.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/825=
0/8250_of.c
> > index b41ca604083f..2f1f505501a2 100644
> > --- a/drivers/tty/serial/8250/8250_of.c
> > +++ b/drivers/tty/serial/8250/8250_of.c
> > @@ -278,6 +278,15 @@ static int of_platform_serial_probe(struct platfor=
m_device *ofdev)
> >       if (port8250.port.fifosize)
> >               port8250.capabilities =3D UART_CAP_FIFO;
> >
> > +     /*
> > +      * Core16550 has no TEMT interrupt: without UART_CAP_NOTEMT the e=
m485
> > +      * code waits for one after the last THRE interrupt and never dro=
ps RTS.
> > +      * Set UART_CAP_FIFO too, because a non-zero value stops
> > +      * serial8250_do_startup() filling in the PORT_16550A default.
> > +      */
> > +     if (of_device_is_compatible(ofdev->dev.of_node, "microchip,core16=
550"))
> > +             port8250.capabilities |=3D UART_CAP_FIFO | UART_CAP_NOTEM=
T;
> > +
> >       /* Check for TX FIFO threshold & set tx_loadsz */
> >       if ((of_property_read_u32(ofdev->dev.of_node, "tx-threshold",
> >                                 &tx_threshold) =3D=3D 0) &&
> >
> > --
> > 2.53.0
> >



--=20


Kohei Otsuka
Satellite Flight Software Team Lead

  koheio@spacemachines.com   spacemachines.com

 UTS Tech Lab, 36-38 Lord Street, Botany NSW 2019
