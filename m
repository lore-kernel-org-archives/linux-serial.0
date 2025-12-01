Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143693C17
	for <linux-serial@vger.kernel.org>; Mon,  1 Dec 2025 02:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764554614; cv=none; b=LnbNtLjA2qetvtfvEpbzb+QX01IZjsUPnm1e3+X1iaGFvhP9IYdm/yADCdFeX/CZqPp36SJ8dxcq3mC+KVQfpPU3lLwEz9mrL2wTGjin73d6W/epalPXnyuu+RlxGnuP3QK0aGjiAzLQBIKLMBnbGwSy/RzLb7sa2dEWI/Y2hX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764554614; c=relaxed/simple;
	bh=nEj8a1UWsV7gCaP46DoZqnni7PIr+99YvDkQWx24VyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXLYizR/oDeFINfukNvsaXR1tDKWEqPGdsNcNMpIOzdE0bLXnX4B1Ol5eLsu8ceh73at3KSBghG9T73mCmOp3b0qGOK9tRsLLCnlV6sTgKBHKFAV7olU1xu19Gx7MHydUrqXNAvzxWOHqr65dUoFSFdZ5OlvyeFrJCoGohywCYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdGJv2Fp; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdGJv2Fp"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b7291af7190so582440966b.3
        for <linux-serial@vger.kernel.org>; Sun, 30 Nov 2025 18:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764554610; x=1765159410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfBdUsZ2685l1CkDaGsjXieZcMX3iUwu9rWjgLN4HNA=;
        b=mdGJv2FpaQFb/gUV9vgB78RlJj2U3JZjQal5uaoKs3Cb/J3kUdiCEiEajBiETnO6pi
         Cuor9Zey5c3rWb0D9SVzV+39eGAz7jysjS8NNEb8pZ02NwqaB9PquB44wUUkDvntqosZ
         jox6x4JMKN7pL6na7tqIh6LuxGfc3Vh2udK5+y6wu5JEkpj8FyByWo5EVe5VB28SAqsw
         DdcfxTSWh46k8r4ji6BaLAgpEp8ZqnPpyzLTNa5faDLQDBJPYi66Y1g7BQE2nU61LDli
         j0Cn7vlLMpQ8QACB8ExfGzzS0eqj7h0lX140RlWt7Okg4N1C8NZ/pk7yt63fyqqt+EQz
         eXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764554610; x=1765159410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hfBdUsZ2685l1CkDaGsjXieZcMX3iUwu9rWjgLN4HNA=;
        b=ucwCEZIkCnerl199iNcn3CA+niLIfQKJ3F8MAu2A6EAmog4lLyJ0mBjqYbd8OI2Vnc
         xZwBaE2r76OrgKqiuN/Tc7bApSPfCh5ZQE1XdujnVV77jH6v/Yjc9FEg9/sATEjgLbDD
         foLQifS9AvBKEYKmpB4RibiGHctujDudKH2X/GzpTVk9v1dv5v0uM6j7OWQKkvGcH0Rd
         dRMqlip8mGq6spi1v39+YmkWnCSKyfmMVYuU9uRtfBv6M0qdXOApD/Q0RI99UDAIz9kZ
         XfCvIB0uPVwZTJTsM9ibGx5htFzaWsi3q60WpVjJkhVtddmzyBfxNoWN9sLn0VDhFqf2
         x1kg==
X-Forwarded-Encrypted: i=1; AJvYcCV8yZHW7nlV8WfsRhVD652efX2wPCqZp7cm1SSYpTnSMJLCb7nm39JndD0JyjwmW4NXUnKaMNQKsj3JN5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhNZ2hM3NlgPN2zQ4carhWkKn3c2yPasi9W1thYy7VOohtyPlA
	C4KfMq720iRmokvncbUpA9Qumz1H/xkfBpqIc5vSe8P+v625igsopfTQi0hFY203gzeeAAt5Ey1
	En7KVkfQ5ZyKNDQxKjOAjDWNhxznebiE=
X-Gm-Gg: ASbGncvUbw8dj+dAuFiMG0hTOHPJL8YKU4l2b/rrmmaJow/RppuViRx0YxMDRVRmX4s
	0C+nZ3zhCgjr5PNM52gxxcLJ9noTqJcScGKkMz61EDv3DBzldtcoMsIOMwyw4gSfI5oBDNl48Fb
	BpV7GlWClrmFUEDh4K1NVGUnvBBn5IMiC6Uc7oDeg2363+tfGs+U++3bQ5ab8BnTN3Lt/zjo7yZ
	s+VwhG5RKvMpB8qbdOLKtnCqqCGeZZvZUqpcuCLiZCmycxpmF+ss/ih+YqiYOkdLb//KlDGujKA
	6oHj64K73HUW5onBGf9eewqQEjbiSnBBGEPO5jM/rI0SA0iEyl8SJlSq82NDTdFF0+/mRKY=
X-Google-Smtp-Source: AGHT+IHpjQrmGOOiekX3KQ/uKfAb8+K6LxAQrgTmjjAsCb7rqPjV1fWN1E0ONcrQYW/7wxbWb0ybLBxDRLw2k5/SBaU=
X-Received: by 2002:a17:907:3f93:b0:b72:5a54:1713 with SMTP id
 a640c23a62f3a-b76718ab1cbmr4626441266b.58.1764554610219; Sun, 30 Nov 2025
 18:03:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com> <20251130104222.63077-22-crescentcy.hsieh@moxa.com>
In-Reply-To: <20251130104222.63077-22-crescentcy.hsieh@moxa.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 1 Dec 2025 04:02:54 +0200
X-Gm-Features: AWmQ_blzKP_nRLUHgCvw4pJcLGSm9EfNYdMAQhwctc5yN8KXhIkAITgUaHojZS8
Message-ID: <CAHp75VcPanVWaLi39Wf-pq8nA+xbeJUs=v1BACz-+Sns0BVyWg@mail.gmail.com>
Subject: Re: [PATCH v1 21/31] serial: 8250_mxpcie: implement rx_trig_bytes
 callbacks and persist per-port level
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 12:45=E2=80=AFPM Crescent Hsieh
<crescentcy.hsieh@moxa.com> wrote:
>
> This patch implements device-specific RX trigger handling for the
> rx_trig_bytes sysfs attribute by programming MOXA_PUART_RTL directly.
>
> Changes:
> - Add a per-port structure to persist both the registered line and the
>   RX trigger level, allowing the level to be restored on startup.
> - Implement uart_port callbacks:
>     - set_rxtrig(port, bytes): program MOXA_PUART_RTL and cache the value
>     - get_rxtrig(port):        read back MOXA_PUART_RTL
> - Use the cached RX trigger level during startup instead of a fixed
>   default, while keeping the initial default at 96 for backward
>   compatibility.
>
> With these callbacks in place, writes to rx_trig_bytes update the
> hardware-specific register immediately, and the selected threshold is
> preserved across open/close cycles.
>
> No functional change for other 8250 drivers.

...

>  static int mxpcie8250_startup(struct uart_port *port)
>  {
> +       struct pci_dev *pdev =3D to_pci_dev(port->dev);
> +       struct mxpcie8250 *priv =3D pci_get_drvdata(pdev);

It's a bit of a detour to simply use dev_get_drvdata() in an agnostic
way. With the above the code will need a change once the device uses
another bus.

>         struct uart_8250_port *up =3D up_to_u8250p(port);
>         int i, ret;

>  }

...

> +static int mxpcie8250_set_rxtrig(struct uart_port *port, unsigned char b=
ytes)
> +{
> +       struct uart_8250_port *up =3D up_to_u8250p(port);

> +       struct pci_dev *pdev =3D to_pci_dev(port->dev);
> +       struct mxpcie8250 *priv =3D pci_get_drvdata(pdev);

Ditto. Aslo locate the lines consistently with the other function
(usually in reversed xmas tree order).

> +       if (bytes > 128)
> +               return -EINVAL;
> +
> +       serial_out(up, MOXA_PUART_RTL, bytes);
> +       priv->port[port->port_id].rx_trig_level =3D bytes;
> +
> +       return 0;
> +}

...

> +static int mxpcie8250_get_rxtrig(struct uart_port *port)
> +{
> +       struct uart_8250_port *up =3D up_to_u8250p(port);

> +       int rx_trig_byte;

Seems a useless variable. Is there something in the next changes that
justifies its presence?

> +       rx_trig_byte =3D serial_in(up, MOXA_PUART_RTL);
> +
> +       return rx_trig_byte;
> +}

...

Also it seems that this change can be split to two:
- preparatory that moves just a line member to a new data structure
- this one which adds required features

--=20
With Best Regards,
Andy Shevchenko
