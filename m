Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793300896;
	b=Emv5Sp2pGmVAbF/XHTZg18wQ9aummbL0W8d4WolYfqdrga+DZnS3i/h0W/XgFdI42PC8
	 VfWOGTqh4IJsDd6SGlS2VhPV50JxEnie0hMWjnIVgmTOvGgTNqtno4wRXhFYyljaEz5ad
	 OQVWFgtNStg5Hu3jEeHXVG/fNxFW7HCJvFkEmOlvPBGK/9IlZp55m5b4waj1sUox8Y2p2
	 oF1IqegTM6tZV7tMtUfee00BR+T5AX2CigjUjSBDxqUp2a3UX7mgtbDp1S6u+LgHh0dxa
	 z1V4dUGUPvgnUgG9YCFSyNvViYXyiggASA/Jy32JS6hVhQvXJFkt9luAmIjiKrJ/41A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793300896;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=u3pPXjv4Wwx+POQttN+7x1MDfExsUHeAJSF+oGYWqgM=;
	b=lM1WtFXw+bragzXFMsZVpETUyUPQjK4T4GCilgQwpAmzPVOyMYW82B/anlGXeaI+/vE0
	 eDUpZRtdJTiL3FfbSBdtmsdEDkgf2tR+bPj6c+UWqwf8RisswRe2ZsimYr3FlxsCgYn9f
	 qiyn6hcGh0JsHdznuHr6VhajccIx2nptcc3Z/clqa7358/Ss2rBMXqvOFnvwCEBuhEiWG
	 jTnmFQWDfe2E8BRWCXqjEIts/QNUWiiFqaeoKMfmSctCV/qK6LR3kupJr/fapSL8GY34+
	 uDMmmUDkfBE4fA1FJ18k/KcTpYbyNL5iFgA0Mt+aPyGTt29z7WcZRlg0mu4/P41kYOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yCAGxuYm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A1D606A32C
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 19:08:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71A1D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yCAGxuYm
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5eafa528803so6321e0c.1
        for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 12:08:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793300895; cv=none;
        d=google.com; s=arc-20260327;
        b=KIx5cKMx7x5RFynPYEGXIB57rMjVwOo9HcJUZX2fBfzadg7xtq9nNR6WMtNOFPaOyn
         d3ljXD/AKyxCWCwWRbSPArQXWtVgBgoYRr9SY/dLnbhQSmEBiYcsbMaVpIVuSrsiu7QU
         TPkTJ7K1PLgfUhBcv/m/ZHhum8leU7G+RaePw7UFiwty+moySCdofoL3PnJ8Vg93IXYZ
         8QO9E9pXLGF38Yq/cJiIbjbrkSsowB4JUQEG3y84g5yjwIuCuoahqY/DIGT4RR1PtYaJ
         P/xvIky5rRA62mFb8DKis5HplzNSQZYMi7pdpr8xT/zj5xzFLJ3+BpHEaVFN+FRINBvz
         Chbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u3pPXjv4Wwx+POQttN+7x1MDfExsUHeAJSF+oGYWqgM=;
        fh=HjjK9AuqIibi4IXW2Dea7+RFwhPRfN0kksJtFRyFiv8=;
        b=pvTX5u4PNZDeHVIiWulttW6Bg5P9+sDUxHun3Wa8qkUzwzRHnZaayonT3sxeuBOl3G
         HChdSVDyWNh0csYrFiRv+NB+/qDWPu00+lfL6zBsa5H0XctiKDYJiud8bkrsNmPyYDip
         mUAhiVS+t7F92rLkYAEvJ6laNgFeQwfguTNrU2BXW5694Lj4pvUwhPH86ShpTQMk474K
         KuG/bOuAlCI0EFWAjTYIgqQYiyEqSl+rCSUV+VDuHWAg/9BTqd/qb9853ZLXlqX56gWa
         aTGSXzuZSOdvK5wyykVUi/3FfN5DXry/K2boKkBGLCHTCuHD/VK0XvEmj+d4dG+nvb3Q
         lSGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793300895; x=1793905695; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u3pPXjv4Wwx+POQttN+7x1MDfExsUHeAJSF+oGYWqgM=;
        b=yCAGxuYmwrHIgmNv9ZiFwfNSpYDff3cIORj47ZcLMJc1M/JfIUPfFYJ0hgfFLheU5y
         k8+jCl1HJd8pxaAifNyTOo3nW/vfq8JV7w7a+1aWKDmS8As2p32MovbjXtCnATsdC/3U
         jdVBmjOs4X/8Qf4Y3CkbE128NmtvbpR7JtzhUUMW+dSysSKqFmF7VD0vO99xtRuYqJdF
         Tun6zrf+HCH22iD6Y9s0suAei1XujF6WsjdUEXeC1zL2GExoYD9pEwxZKMmHMhMYGH+g
         xM3O0+QHW8dBcPGN6lVsU5YYNy7Qqqr/NHfULULcnU2gJ5W00w9HQ+konuJ3NjwDgqf7
         HCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793300895; x=1793905695;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u3pPXjv4Wwx+POQttN+7x1MDfExsUHeAJSF+oGYWqgM=;
        b=V+mK+LfBd3p5qZlmUEap2ImmF1lXfr9IqZ2hsulqA8JB7szTVZmOpQLWSgVWyU28Ts
         cn+0O9EYGiYc2VIfb2U6UUv4gJqCzIgo5295JCyziaEHFNuSqjiD3Na0Jkm64yBkC+9b
         VJJpTUZERHVBf7aCbu2ppeQbv0jS3czIPzpgmIP6pnIKJ9sI8h3SSJKV+Vpa7y9zPfY0
         1s1X80aMmYD4fQdsb+X2sjdUJZav0uOAVv9JApxoffOUtH4PoaHF1xUuoPz6AqBhTFWQ
         UpGLJ/d7hOLVym5PGMlSt3YM0YbRd/znONtLT8StgUBiaZtAtPR3j2lOnsbtIXdUmhLq
         MeJw==
X-Forwarded-Encrypted: i=1; AKwUvByr5tzeTGJngWruzzksQPEc44lYz7MKk/yM+rVrQmWqxZkOoCDOBElWslNqG+sU1czjlfxDh4lQ++QRi9M=@vger.kernel.org
X-Gm-Message-State: AFq9FYJdWUCUnvJW5cjvTfRX0NtAca+Lw+3zALCOWvOJ52CNG5GYRgpI
	wK4PqSLI068ItopkpC5jBqTuoePIqpZJuCUlF0C3bRf3U4iOkddPC/xG2GJIO7ru2rsvoLbVq+Q
	KSdQB5pPqfBdmwhdaQHVYJPIu88DGd3c=
X-Gm-Gg: AYBFou3Lm1vEzquAkHglwQ6gq5ForaFxgJiUL0mlIdFaUUGeVJ1OYpDGnPE9sgSWSOM
	9sA+VAVioIl7jWYB5JO54WYQgpLmxFCuKWGVy7Vw2pXRReX7lx+uT55h4T+b2bHmp8S4qFIskxt
	8Np2gq0LPvoB9GaXGKV9qUAJRBG4hlvZLFaNEC3WvMsbonXT+baUH1qn/DOQ60+ev9BVbavR62E
	YifsnlzWRxcQeJ4fFIcWA5UbZCifUWxPSlvDqFf+PKiYsEu4BqbSR0sdnlppmdmO7gagRpMIM3/
	64gnqoDI7aBT7zHLg2vpCZK9l94Vzf+O56LUhCVhD9RH13Nlj8r3hU/g9X3dd9YU7CEfaXM4hmL
	+hJSoKZdb2mT4p263ATuUsZ4LOXhoKUwqDBl1Zm2QfPXCFzfcPo1yTcEsNkjIl9IKP5OjkrQop1
	9aZisTOSP2uzAXQFuKhco3kAG4MKe7V46zKKSEAEKt/irLmkLt7EEQ+VQvhTquCUcR3cQ1mmVYj
	bmTjvuuvO2TNmpn4rKH2xRPPpWo2g==
X-Received: by 2002:a05:6122:46a8:b0:5ce:ab22:1749 with SMTP id
 71dfb90a1353d-5ec6851cd7amr118633e0c.1.1793300895346; Thu, 29 Oct 2026
 12:08:15 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027-submit-h616-uart-fifo-v1-v4-0-d37e018fd0a6@gmail.com>
 <20261027-submit-h616-uart-fifo-v1-v4-4-d37e018fd0a6@gmail.com> <auHW9nkDqZUXeHNZ@ashevche-desk.local>
In-Reply-To: <auHW9nkDqZUXeHNZ@ashevche-desk.local>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 29 Oct 2026 13:08:03 -0600
X-Gm-Features: AclHuK-Rn80HNyPsHmS5HIf099B7rRnzpvWxOBqe3P7d4FosCUXTUKkW9AmBT7o
Message-ID: <CADvTj4o6N6sXk1YvYgMF6d5jyAGZCtyaZUe81ZP10qfhOPwd-g@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] serial: 8250_dw: configure the Allwinner H616 UART
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 5:05=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Oct 27, 2026 at 05:05:32PM -0600, James Hilliard wrote:
> > H616 has 256-byte transmit and receive FIFOs, but its optional DesignWa=
re
> > component parameter register reads as zero. Generic 16550 probing leave=
s
> > the port using the 16-byte FIFO configuration and its trigger-level tab=
le.
> >
> > Keep PORT_16550A and describe H616's fixed 256-byte FIFO depth in platf=
orm
> > data. Use common Allwinner setup helpers to configure the transmit load
> > and receive trigger table from that depth.
> >
> > Derive the receive thresholds from the documented 1-byte, quarter-full,
> > half-full and FIFO-depth-minus-two mapping. On H616 these are 1, 64, 12=
8
> > and 254 bytes; the normal 16550A half-full FCR setting selects 128 byte=
s.
> >
> > Build the threshold table during setup and use the shared 8250 conversi=
on
> > helper to select the nearest lower threshold for sysfs writes.
> >
> > Serialize trigger changes with termios and hold a runtime PM reference
> > while programming FCR, preserving the FIFO contents. Propagate runtime
> > resume errors before changing either the FCR shadow or the hardware.
> >
> > Advertise automatic flow control so CRTSCTS enables MCR.AFCE. The
> > DesignWare termios path selects hardware CTS handling, so the capabilit=
y
> > must be present for the corresponding hardware control to be enabled.
> >
> > Select the fixed configuration through the platform setup callback.
> > H616 has debug-divisor and RS485 control registers at the offsets used =
to
> > detect DesignWare hardware RS485 and fractional-divisor support. Avoid
> > those probes and retain the BUSY-safe integer divisor hook and software
> > RS485 handling.
> >
> > Use the existing SKIP_SET_RATE quirk to keep the UART clock enabled dur=
ing
> > termios changes. Its clock is a gate on the shared APB2 source, rather =
than
> > an independent baud-rate generator.
>
> ...
>
> > +     unsigned int fifo_size;
>
> This is should come from DT (based on the property or compatible),

On some Allwinner SoC's fifo size can come from the FIFO Clock
Control register[0].

>
> ...
>
> >       u8                      no_int_count;
> > +     u8                      rxtrig_bytes[UART_FCR_R_TRIG_MAX_STATE];
>
> Why do you need it here? Can it be provided via driver_data?
>
> ...
>
> > +/* The trigger is the masked, unshifted FCR receive trigger field. */
> > +static unsigned int dw8250_sunxi_rxtrig_bytes(struct uart_port *p, uns=
igned int trigger)
> > +{
> > +     switch (trigger) {
> > +     case UART_FCR_TRIGGER_1:
> > +             return 1;
> > +     case UART_FCR_TRIGGER_4:
> > +             return p->fifosize / 4;
> > +     case UART_FCR_TRIGGER_8:
> > +             return p->fifosize / 2;
> > +     default:
> > +             return p->fifosize - 2;
> > +     }
> > +}
>
> You don't need this, just provide a set of numbers directly.

In v5 I added FCC based fifo-size discovery for A523[0] which does
need to compute these values dynamically.

[0] https://lore.kernel.org/all/20261029-submit-h616-uart-fifo-v1-v5-7-53b4=
33aebbf8@gmail.com/

>
> --
> With Best Regards,
> Andy Shevchenko
>
>
