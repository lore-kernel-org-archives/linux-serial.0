Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44DF3242A9
	for <linux-serial@vger.kernel.org>; Tue,  5 May 2026 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777973712; cv=pass; b=l9nYxAts2eK+zloQznZQPIr3PQ3OSqhFW1kT6TWwbSsJOXYElg4kIKtS/wAI/eZDuQ2tZANwuL7IJk+PbVdxI9VgBvr6lzhH0jJ/BJ/cpvI0hhM+pBXDCgDOsij2gV/Xh2ehu1TZ1kjUPqDsDEZKRX8JSfKlPfNY2kjrXmu+F84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777973712; c=relaxed/simple;
	bh=XKZXsJdkBVvpHgzLbbLahrLN1Aw8apFLP/f/wXnEwfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jej+V9eCFpZ+irJy8PvJFf/b79xl7tLlGTlJD7h3SjZxynbGfHb4RcrWyLL2hLJBwfj3In94+uqtIZPSUT2tGkk4TPGNL5Ueg13vQH+nxE6Zv1jiSrLqyeObXkT/NttSATDDj4B2u8WJkxJJEG/NuzEswxWVsHm28ZoHT7nV5Gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1vmvrOd; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1vmvrOd"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a283c44478so6579212e87.3
        for <linux-serial@vger.kernel.org>; Tue, 05 May 2026 02:35:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777973709; cv=none;
        d=google.com; s=arc-20240605;
        b=GC53UPvtlchgS1wYa/I+RcfpaogoBYDiHsX3i+86rIvDiMUh1DGVQqZBFOLsMitdAo
         +sirHAQA7OhcMeUfP39see5ZVNcD3ay0EGfuwi66ybg0Dbb/uNvggsb2Mw1oTzzJ+6CH
         0tSQL2lwBjFSuHL9g3nYRk4T6WDlca33unEYDLjccdaJnvUaaazlC3KJEIZbgkY3jkzL
         5X53pTg8uH7nkLuHDjX9e/DSQ1ysneTTElmKlXrR8xzfqlp9kP9Xtp8qgG4CvyvdBv5m
         pPv72IUF6M4XH4slqh51QPDiz+d7ZcWLjHIV+HgzKhUk2J4zAJ4a6+QWVwNLSGONyOcA
         tq+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eWWCq4r6yLXQQ3AAWPXpmFFQ+jEiKA0I1c/R7syephE=;
        fh=dF5w7yichfYGE4G7firi+CpJmSwtXpAoWmoAm1GMsWQ=;
        b=TrO1SFK3Bb3ZawhRUjNgJC13F6B+WlsJLWsc0Yb6wnCYziWRB/Ra4VUusCDDZguj1D
         Gus/du0ACE29lW98LJx63NewXYNJBxDlJS41DiF10+Px3l4d+gX3d0s+jtc9iTIQTxoB
         pqFyggV1o6pBMMcwZdkHvFmVwx4MMSNaymKU+AHz3bQoIkP4cTFGtTalLCesi5MyYyNG
         KKnD4WqPgPrQtZ2txCh2/wLtHXHtUwvAoMYUciqd/nRgmOzpAS+QdFrisj0hrfHIhPqk
         wPvN0zYd153XMfJF3rNg7GRpkWeaG3jLaDoJL0DYkpeglPszTDviNOItXlXlqFxkw/iC
         FVAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777973709; x=1778578509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWWCq4r6yLXQQ3AAWPXpmFFQ+jEiKA0I1c/R7syephE=;
        b=V1vmvrOdcWDg9nwsgpu4YAfD8YSDp3a/zh+/9oBHtxvMnY4hgCsDEhrhr72GG8Mtet
         z7fSyeikY1A4RW/GbYQQax9PSLfotvyjUrYk+SVKYn7bPm6Q6cbopOecxPU9/NEGeF3I
         fetda9LIsbX09h8hN9XYc5NJ9ECC/OFouTub2YI301LvWWoF+ArEC6MafFDpNLmxYFcU
         YkQjLQAzMImUClXJmKgzpeV6tuMDPQtN4o+46muGFjQJkRyrfncqaz9fceL1+6JrfNPj
         8NdR1/0vSv/l0aNrhs99Vnu3MocYFKB4ck4YsIMDmQXJkvotogKm3mwt2j8uXBNEPk4j
         6C7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777973709; x=1778578509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eWWCq4r6yLXQQ3AAWPXpmFFQ+jEiKA0I1c/R7syephE=;
        b=l03GR8+0MtuyF7BjYbbpjYIYSdI3nVvPXVs+6nnAUwYjM6zC1z7D0p5mXgk1G7TXmA
         t7VkiB53teraXeVYVz6eP0xMs8zP6ZtN7HV8ZcwYL1sjiUy3O1d7ZbnM8Y1hx1fONUzr
         428LOFcFJXZDRkgqVTb9NX6oSp18nomeX2mCZkNDiiO3f0dNOESURaG/rt1X2vrQ+F2n
         4XwYOvOC0Guj1iqylkZNqYtKVK7Sx62NtcjHVXleqNu7IVBcT/GxeVB3QCylhxbJrQeI
         2T1HloJtXwhzwA6PP2wEeFBQGHGqJ/Dkrj5E+J1+YUAhnFfMdk9vu/GosBUt/PI/uOUv
         VvDQ==
X-Forwarded-Encrypted: i=1; AFNElJ+kX+AjSZ7eKZ3u88Pkarvpd4nR22maaGfE7acj6qGQleZdLE5VM1TaiRTT4eC0ycQQuHAbl/QuB4DA9Y4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPhkUPvVCUkULJa3ZK7VKchNMW3dyMz1D/HL989Z06OgF97Q3k
	WNL+VTONQK5e6SffufKVsxTHaELRsAgPY7lk1eF13Pf5CPaw3G9JIMAqK9onnhn+LX5sWBMrejG
	5AtDMVz5AVCq2ccBiWOfd28KXubtIzsE=
X-Gm-Gg: AeBDiesRnevbHJwwffnAlsKpJwxrCHsHj1SmaVEKF5pXFU4B+/eY9oeMHyEuL8aPZGM
	mbNjBVVX/x8pZQiYkm81ekT4VnkyRdNB8t1uyuDhGbeUtrdWZL1uBAGNo70YOXpxxTpGXXcKCSk
	w1LdnwkmXbKa0zXeg/xypj2nZqV2HGNxDwXe7BOKklUVf4NjVT9SKjWRUnQqD2K/r00anzMu337
	edgjPfq/i8GOV5FCWQBe4iIR/3hHcCySjrzfZ/QXQjTOjpa8ow3Z+f5ws1KuxfuE0q54g2/lLru
	lXSK9EzU70XHrCUs0cNjnfb5iwCG8SNmF2l0CZ3vaewChKtQU4zamRkKd56eJlLxtdHZj75JgE9
	O70L+qoYd2hBNmILvcQ==
X-Received: by 2002:a05:6512:3ca9:b0:5a8:52e0:7bc5 with SMTP id
 2adb3069b0e04-5a87f1f8801mr1086963e87.27.1777973708684; Tue, 05 May 2026
 02:35:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504084900.22380-1-crescentcy.hsieh@moxa.com> <20260504084900.22380-16-crescentcy.hsieh@moxa.com>
In-Reply-To: <20260504084900.22380-16-crescentcy.hsieh@moxa.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 5 May 2026 12:34:30 +0300
X-Gm-Features: AVHnY4Lh6yuTAm1bEHtM824L2f1HQz6zF45ioAYwLUxXV5zb-ob3jAdVrPJhMy8
Message-ID: <CAHp75Vc8gFOOg2U9uHWXpwZCZLTVYq1CjY2pw3Q0+cNjziSBKA@mail.gmail.com>
Subject: Re: [PATCH 15/15] serial: 8250_mxpcie: implement rx_trig_bytes
 callbacks via MUEx50 RTL
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, fangpingfp.cheng@moxa.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 11:51=E2=80=AFAM Crescent Hsieh
<crescentcy.hsieh@moxa.com> wrote:
>
> The MUEx50 UART exposes a programmable RX trigger level via the RTL
> register.
>
> Implement uart_port RX trigger set/get callbacks for the mxpcie driver
> and wire them up to the generic rx_trig_bytes sysfs interface. Store the
> configured trigger level in the per-port private data.

...

>  struct mxpcie8250_port {
>         int line;
> +       u8 rx_trig_level;
>         unsigned long event_flags;
>         struct uart_port *port;
>         struct work_struct work;

Whenever you add a member to or modify existing data structure, always
run `pahole` to check if the layout is good enough (or even the best
fit). Same applies to the whole series.

...

> +static int mxpcie8250_set_rxtrig(struct uart_port *port, unsigned char b=
ytes)
> +{
> +       struct mxpcie8250 *priv =3D dev_get_drvdata(port->dev);
> +       struct uart_8250_port *up =3D up_to_u8250p(port);
> +
> +       if (bytes > 128)

Magic! Should it be defined or already has been?

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
> +
> +       return serial_in(up, MOXA_PUART_RTL);

No need to have an intermediate pointer as you can simply use
serial_port_in(). Same applies to other places when the uart_8250_port
is not used otherwise.

> +}

...

> +               priv->port[i].rx_trig_level =3D 96;

As per above, this magic together with the above should be defined
somehow. And together they make more context to the reader.

--=20
With Best Regards,
Andy Shevchenko
