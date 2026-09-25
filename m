Received: from mail-ed2-f34.google.com (mail-ed2-f34.google.com [74.125.228.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5541B368950
	for <linux-serial@vger.kernel.org>; Fri, 25 Sep 2026 18:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362275; cv=pass; b=QdCvzCwkS63oNFP+kGwJJ+F35MQHj3OolItuS61UYO49D3L40oKM80cTahAGPShDe8GR11fl6oUMZ3eGyczB7KPdYlP4SAv0leMdPawFp4QlbiX5EMZMUrlLZc6Bx2+UdLvaLxtq4b1Mhr4kN63NZBTlbikcrzRzpJiF9s+jE+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362275; c=relaxed/simple;
	bh=0ZW1klAV+bg/UtUuvdW4thDQoRHPPeEDu1FKYQD3LhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFYkLXF+/OdxdI145llWySYvJy/UPNFukPc/5h4lfSExG5kRQzA4Lq2175ONdgGGvVeBDI2xMb2ALRM08Ex1lQXL+vz/OLXHteZzmWEBqqNfoTa4ewE04p6VhEl5fBrqLoCM9NMOv8eFrvs38qf/oNZVfmxOIe8RIOcTydOKwgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8Z0fCNN; arc=pass smtp.client-ip=74.125.228.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8Z0fCNN"
Received: by mail-ed2-f34.google.com with SMTP id 4fb4d7f45d1cf-6aab5dae09fso1953252a12.0
        for <linux-serial@vger.kernel.org>; Fri, 25 Sep 2026 11:51:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790362272; cv=none;
        d=google.com; s=arc-20260327;
        b=psanL9gvvUV25bqFL5r0iDCqG026yizetUg5d+P6Q9+4Bj2Wud/99kZE0Z89ggm/zM
         Xp6TLjlZsSPyO3RFERJK4B42fYmKSr7Dx0F9b8caYfCxDFN8aWlNP8oiTVyvGcDfqHQe
         +oOLLuU/nRpkiBxfmzNu5uAh/jQsdSc5vNL9jhrIyABwe6aeTvRWrbflTjt5wLDCxhWz
         wPPlkHnpoU2pXQt0wZ/008b/eDlIf7YWMdx3K3nseWvlOuRFYiXSTiOCGoPbafkld0lH
         88QTFiN6+aq+gA9ovEHggBsk/hL8zCAwUYXGQTcsZ7DHeFhtBMJHp2/73DorNn7jK6m5
         xLkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3fDgAQ8vv+eWpPhr95k88YrPm3PM1EltEIBx166mNc4=;
        fh=/QP+n2O4Hyc4wPS4zFFRlhIZQ4uvqm/l12+HjjpmfsY=;
        b=nOsh1i30QJIPX0Lj0V26a75cNTCb9hEBkTSZ9LSN/CylVdhsYlAe4F0FiQALAJAiqA
         pxeIoButC+T7IiIU8WBx1llws7yVZZtbbS6O0+7zfhPQr1q8xV57DgemR3LYVfh4WFyb
         YLRjxZsb/DdIS/d/guk6agvXzT6HUbf7yEsWAV2QszJ2jN4cWnNOk+08+ShkzEA8McZl
         NN0i0CaxfKgQpbGMnUcaPnIzkYFhRYl1pFbpI6ZTQ8xzLixldh1peS7tLP3h9aqqEuG6
         U2NRfxi7OlB8cPQFIKXCtUuP2WdPrwj+zhPy6NlcOsivRqwgQe9m40MgUA8babGFDKvE
         fIRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790362272; x=1790967072; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3fDgAQ8vv+eWpPhr95k88YrPm3PM1EltEIBx166mNc4=;
        b=M8Z0fCNNi+m9mH+d1g/WcwerAF+fN/RDCKm7JfpTYF0Bz8MuqzyL0odNTgIcM7/4E+
         LmTE3Gsj1/o/0csWFOYpqSE0+lelLUS4Sri4FeCXIZlcMm6915dAxbmoCHTHACheujCY
         90AOH/yg/WZWuMdhmwvWZdxNNIVDzg6GZI+/eCBrjHebZP5k4PGhOyrPdcDPZE1dYiH7
         kGl6tNPIQ0Yt7a43XVDCC4CZoxvUHGv6IhsZ+Ew9RQ+sSfeavqKrwBPndtIpOC/MDrw9
         YQCJj/CypBxKQjUm0bfokOTzwrueeQMoTOM+9MPD3jcEZnOK/U/p3OUVxs3YubL6hVL7
         OuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790362272; x=1790967072;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3fDgAQ8vv+eWpPhr95k88YrPm3PM1EltEIBx166mNc4=;
        b=1DLhxf7QWQo4Elb3m2p5ED0ucmxZ5prO2KiJcV+yqowufvdU+C8U0e5fQKSVSr4QCk
         BzOvP3QzIGLXdcgWHQ7FZBmLEEz2CrNsBp/KmoTaHF9eqHDfXOL52wGT3nmGRyXwyUV5
         FTqxrm8nmbbOyWb9zph3rxti+6lQUi+PeqJLH6ZOoIA6NSaHiuZKXDT+KgKPuRJiAXbZ
         XuntrVDRh+gFrTj8VJrJcTvL/SL5EjcJAJwyJhDrs/o2JuDVnE2SUK6hAss4YsCNswot
         pMYDATuLXsMUOiL+gpq+Fb5RRLP7xor6/Xq1ujgUqgMNRaawJ/WykuzLAF/4aYoKmAA7
         M1bA==
X-Gm-Message-State: AFuF++kw8PIXuCmpwstGG3LFQFr11pudIpf2hE4Qqk75X/SEmMF7/+aL
	XPwifSZaZETTOKqKQy4m6ZXBwJ8SO01/0pNX9hC1HAxrdXwzuCyLactWFIvjEfrIDoGng2Gd54f
	bAgqD1VAD6RBGhhixEviUSRsuwt4H+oaicA==
X-Gm-Gg: AYBFou06SyBKdT5D6a3SYj66dOs40AuWMqmvWVfu733sEUog+zHuKJZdDPtJX2p6Sq2
	EeUD6QlOcdDqRCL6QFDNrdZIIMczvjysK5fo0jXFrTAxx0zAcsHR3BareHsrRGN8PSJ1nDe8QJM
	Y8/WQuD7jCAccujb4IGm3qWWJlpYpCJ7FUF/8nhtg0FVi/x+JG66H+D+Ms4EFZE+BooYG7B3XBF
	krRiUgGkuXcLTbaH/GPBsu7A7Ae8+96/PlB7idg7l9uMb8JSAdWe4PxXEGFxCZMLJ9/6oWQziz1
	vk4y5wXx9GT2+uIXiSXLyBkuQ9wcuvFOxzy7PQgykgJkfANAj08egJfw1OGLK/agqniumyZ3qt3
	3xOH5wlWRed/KxGHmkAsFQYECgAj7sgz6F93H9jxTvHgCzbzktztf8G3X1lLF7649+7iluoa8U+
	FJLM+VLu+nKXBXXTmxIMG0XGGWVGV2ZkuABEjFNVWkMXbW/cczpMCEV9IhllQCmmdVuw==
X-Received: by 2002:a05:6402:5019:b0:6aa:734a:a081 with SMTP id
 4fb4d7f45d1cf-6aac8f72887mr6109550a12.24.1790362272215; Fri, 25 Sep 2026
 11:51:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925182504.54976-1-rosenp@gmail.com> <20260925183307.8F8961F00893@smtp.kernel.org>
In-Reply-To: <20260925183307.8F8961F00893@smtp.kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 25 Sep 2026 11:50:59 -0700
X-Gm-Features: AclHuK9--1gx1aOuNuMKs7axbVuTUfXkQu_UxAVZzFV_LrvK3kE5iMk876yZj-4
Message-ID: <CAKxU2N9e1D8aq0_oo3D05T2NEgscE7um6zYmAoQ1X9rXOMLPFg@mail.gmail.com>
Subject: Re: [PATCH] serial: ucc_uart: Use platform IRQ helper
To: sashiko-reviews@lists.linux.dev
Cc: linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 11:33=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] probe deferral: leak of async firmware load due to platform_get_=
irq() ordering
> --
>
> commit 887c64b890c9273da1e7e1715e89bca754adbfb0
> Author: Rosen Penev <rosenp@gmail.com>
>
> serial: ucc_uart: Use platform IRQ helper
>
> This commit updates the driver to use platform_get_irq() instead of
> irq_of_parse_and_map() to obtain the IRQ. The IRQ lookup is moved earlier
> in the probe function to simplify error handling and explicitly handle
> probe deferral.
>
> > diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uar=
t.c
> > index 6b7dcbbacd13d..c3c83a59dcce7 100644
> > --- a/drivers/tty/serial/ucc_uart.c
> > +++ b/drivers/tty/serial/ucc_uart.c
> > @@ -1238,6 +1238,7 @@ static int ucc_uart_probe(struct platform_device =
*ofdev)
> >       struct uart_qe_port *qe_port =3D NULL;
> >       struct resource res;
> >       u32 val;
> > +     int irq;
> >       int ret;
> >
> >       /*
> > @@ -1247,6 +1248,10 @@ static int ucc_uart_probe(struct platform_device=
 *ofdev)
> >       if (ret)
> >               return ret;
> >
> > +     irq =3D platform_get_irq(ofdev, 0);
> > +     if (irq < 0)
> > +             return irq;
> > +
>
> [Severity: High]
> If platform_get_irq() returns -EPROBE_DEFER here, does this leak the
> asynchronous firmware load initiated by the preceding call to
> soft_uart_init()?
That's pre-existing.
>
> Looking at soft_uart_init(), an async load is triggered like this:
>
>     ret =3D request_firmware_nowait(THIS_MODULE,
>                                   FW_ACTION_UEVENT, filename, &ofdev->dev=
,
>                                   GFP_KERNEL, &ofdev->dev, uart_firmware_=
cont);
>
> Since the async firmware load is not cancelled on probe deferral, the pro=
be
> will eventually be retried and will call soft_uart_init() a second time.
>
> Could this lead to duplicated asynchronous firmware loads and concurrent
> execution of qe_upload_firmware() upon probe retry, potentially causing
> data races or hardware state corruption?
>
> Would it make sense to move platform_get_irq() even earlier in the
> probe function, before soft_uart_init(), to prevent this probe deferral
> side effect?
Yes
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925182504.54=
976-1-rosenp@gmail.com?part=3D1
