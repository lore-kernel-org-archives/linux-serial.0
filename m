Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2DF2561DF;
	Tue, 25 Mar 2025 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742912635; cv=none; b=EgluMMiOEwN2hJhz/wY0rUkRK+UZrb5Uc0M4y+VY7i884g+efMxlSOB/H9a679zk0F4XxBr6dKicXmmvRv/HlkWQmYwNg8aq4hLTiKUWP3i4g6nN73DEzSOyVn/qEY7I1BLjgx9A0z1b5JHoIW0i3SWJOX9Rq3Zau+HDSKSb4eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742912635; c=relaxed/simple;
	bh=A5Y9q+sj+xv63PmhmZXY7unUr52JGT4ONdRmpXARiJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yw5hwmPerU88t9K7FrFK1iur2pffuur4NreUY45BwlcsOmNWn5Nt/mHNyG2kdJn/2Imyr7YMePElzFmFe5ZqXpnTd3oLvYOVO/FknozbIbsn/ElW+qBOMlZEkL4uXkd1ffU2iLTd7D6rFCrM/HA3yzUGgXExz1CwoZ7HvVjQ8SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErtODMo0; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErtODMo0"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac339f53df9so40147666b.1;
        Tue, 25 Mar 2025 07:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742912632; x=1743517432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04XYBl7miNVhZ3flP6SBngFKkvK6aKG1egjBY8qsqVw=;
        b=ErtODMo0lRQxIZxJrAAmznE4MDp3ym1YWJuRTmEqsZGq5R5gifryNy0JYHRTPNxyzD
         IaPe/lF9YV43Hkhot22c6H7QAFQhj8myhC0Lmeccpvo99yckhh7W79EcOzO5CHIxl8v8
         VSnlQnsYMElgz8d3EOONpsYIQE7vrIdp5uJQMrmNA77nZcNCom7VFuSEuhjUwfJzxM26
         5H+nmXLIwZwJ9xf6LyzyP0ZND49Qhax0KZb3NOOA9mM/IT4Yzra1xvTlePqWMWoIez98
         iIfVLaoMRYHLYVWVabS88lxNshf//Boe6OCpMzvI6iHinWFS+OB0pTkYo9rl0TNRcYy+
         WGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742912632; x=1743517432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04XYBl7miNVhZ3flP6SBngFKkvK6aKG1egjBY8qsqVw=;
        b=jQo5XurUgYwinEKpw1LXdzx6HKCk6TrYk0fwVG5RwL6EhUkw7lAW1PZ7hefLVXIx9J
         GO+NkJL22k5S3Uy79yxZSy2dUp8F0OdB8TFBsc9Klw3zig2MUjZi30Jk0iM+uJoebjVV
         Dm6SPuqF1fqx1ReLL9yILzAXIoXbsbOfPs4IxUkFSep7I4DtqMIlZqx2QTia/eqvMMtS
         ypLoDehiVu8rlLSOcpFv2UDdmWyT287a2VdPUzA7gz1ogkcUUk7phs4Gi9M2bOKP5urp
         MN6a/CMFebDnzdMAD8Qvj0ys32DbkXfEfKT+jwPYBegy3+MdDVFJUvsYEp7+iM41f7BH
         6ZVg==
X-Forwarded-Encrypted: i=1; AJvYcCV7rpwhsDKEVD6j8bz5SHh4eaj4shy+hw8uuRuPFMB6KH4w9lrzVq+w8u8GtQg0y42JEXuuZFtG4sz6@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Tldmh3QfsPsCGVC0XaSzmZonQMIz3wUyhEhgnfgmpXg134rq
	4wYKjtBeXhmtseuD4C7vRwu8byau59oIKueKfH2sysZPMoTmiUGqwyOGfBXygw52NF77D8K5TlQ
	ev7mx03/OZNDmfASnVplfY5l2NsQ=
X-Gm-Gg: ASbGncvXcv5xDKo8R5Q2H99re1UxmO5cPuFTJieQcFYJgAXJYw4jxR+P9IjHbAtVP15
	sgafk0yNsafHDbO4grIL76LUXcjr6wd7/VXnRmKnoD3xjiarrNi1jBBOLxNdGYF+l02fSvoM5NV
	0u/N4ZOi9MwLESgjgG/dTd7Ap8a0gP
X-Google-Smtp-Source: AGHT+IHY6Ms9Ji7K0jiu+JcLFnVz/Ot2Ljy2x2EQUC4gF1RIVIv7qpKjsXI3di2kSbmZB1qiGHmDo1NFuTBFdpQ1EeM=
X-Received: by 2002:a17:907:1b2a:b0:ac3:8987:5ca9 with SMTP id
 a640c23a62f3a-ac3f20dd210mr1714295166b.19.1742912631902; Tue, 25 Mar 2025
 07:23:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250209210241.2622309-1-benjamin.larsson@genexis.eu>
 <20250209210241.2622309-3-benjamin.larsson@genexis.eu> <Z98uumXXqj_opuTT@surfacebook.localdomain>
 <0c8bc7ae-cded-4b52-8965-f6e6487a06ed@genexis.eu>
In-Reply-To: <0c8bc7ae-cded-4b52-8965-f6e6487a06ed@genexis.eu>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 25 Mar 2025 16:23:15 +0200
X-Gm-Features: AQ5f1JqmipDFEFdEfcpXTqss84Le5MYwATrj6fY_9T4kO6v3Y2DVxkTkWrJB5pQ
Message-ID: <CAHp75Ve00HRvmLk9EwxAUEF6vsznpoRkAFcjwOHW_Sjp6qmnyQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] serial: Airoha SoC UART and HSUART support
To: Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	ansuelsmth@gmail.com, lorenzo@kernel.org, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 4:19=E2=80=AFPM Benjamin Larsson
<benjamin.larsson@genexis.eu> wrote:
> On 2025-03-22 22:42, Andy Shevchenko wrote:
> > Sun, Feb 09, 2025 at 10:02:41PM +0100, Benjamin Larsson kirjoitti:

...

> >>   drivers/tty/serial/8250/8250_port.c   | 26 +++++++++
> >> +     /*
> >> +      * Airoha SoCs have custom registers for baud rate settings
> >> +      */
> >> +     if (port->type =3D=3D PORT_AIROHA)
> >> +             airoha8250_set_baud_rate(port, baud, 0);
> >> +     if (port->type =3D=3D PORT_AIROHA_HS)
> >> +             airoha8250_set_baud_rate(port, baud, 1);
> > Why is this here? Please, make it stay in your module.
>
> I dont add an extra module I extend the already existing one.

We are trying hard to get rid of custom quirks in 8250_pci.c. That's
how a few 8250_*.c appeared during the past several years. Please,
follow the same approach.

...

> >> +config SERIAL_8250_AIROHA
> >> +     bool "Airoha UART support"
> > Why bool?
>
> Because it is just an extension of an existing module.

Please, make a new real module instead.

> >> +     depends on ARCH_AIROHA && OF && SERIAL_8250
> > What is the purpose of the OF dependency?
>
> I thought it was needed for dts support. I'll remove it.

It's a runtime dependency and not a compile time, right? So, there is
no impediment to compile test on the configurations that have
CONFIG_OF=3Dn.

--=20
With Best Regards,
Andy Shevchenko
