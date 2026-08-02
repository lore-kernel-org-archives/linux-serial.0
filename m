Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D96B390601
	for <linux-serial@vger.kernel.org>; Sun,  2 Aug 2026 08:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785659799; cv=pass; b=FU7lvOyx4bRRMAicBjvsn35Ykipz2U1LCDb20TuQxLlGDfq2I2wOVifEVy9HMpf80hKLNIHmnYb0jxUbKHhoxx+Awohg54HikA9DWKnF4vDWZbv6rFOSPUfxLNQ1oXJ/MRf4slt7qbpZWsR8uSMyMIuSrrlBAMJ6Eh+gFNBLk1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785659799; c=relaxed/simple;
	bh=pnKb6Sa8ETizOjrkgPBq2W8MvSkGCFx+S5fnitv3f9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRARFDiAZbfnPyCuOOTXBtHxdHUy6kNlQe1YoLKn9sTgkJ8S11rH1+i5ZjsilrsGbjcIcNLzBVAYzjzAJV3tWw7iyE09J3y7KzADBgw/2OQiJpA4OwRzumVKwlqpHYdqzlbbekTEJOmzTT+k/I8FjrkQbUjjv+wPqnuEfnJvxZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LX/JIWhU; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LX/JIWhU"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a0a4aa99bdso2269844a12.1
        for <linux-serial@vger.kernel.org>; Sun, 02 Aug 2026 01:36:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785659796; cv=none;
        d=google.com; s=arc-20260327;
        b=CFxPR/NuXYlAz1p2HRsc5astnnalzHFRnTWcVt8B4IqF2zCWcinO9qPf1FXkfgelQq
         FDL0YprbPPmo3Rzm7qNpHeAX3HtXgRpGuUmQ2l0RhLwvaezIE/oROL9ZA6i79W0iXkT2
         LLUypaTrgp/7PRUhZcIRkGGkdtyFsD2RKIPGKCjsXgOnxplQJUE7SQSQ4IViY9lY0+sq
         MK4QyjBtWjfoQoXrx4QJOYWI+GfTZFSBJRN+6HFEsg1ELFbBCr85bV2IoXKxE6pEzsHV
         PdR1nrXTVPCBH1+iwab7eyCdVpsDJMJf5o9ykfl3ezzv43aIhE96vdlLwrMKl40z26Rz
         t18g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ydlFqI2pV9TZGygA5cA5Y+Tnh5/uDxFV5Kmmu48b610=;
        fh=J4uaQCiGCSZFV1uT6jxYhaFILiDh1QHL7eUDFzb8t4w=;
        b=Pow574zUn4vpcBci/FlwgTusEntTeyuIyhFh9BGkEkGvHlM4G84J3kYUq6yjJU1/Zy
         JcRkATyBI5m6CQV94qXlAEw8GtRf1a/71tVvSS+xUV8hK5XSyZQoD5qhJsTVJYO/TeS0
         Ox8ubA3eDYFk/1yNl0B5aQEBX0RXiqc5NtMS3EJHi5NDK9Iy5BU1MDx/1Bpl3kgXVlFG
         TcQzHutG4WTULlKBkCpQPxqaKuL40TNUxUGZRT2SiuKr9KaISBSiOv1C0LIV6kHOd+Vq
         8btE28j88mkKwCk6vRNmqnBQ7aCDsP4tITN+RN15snbpLd36vUvXrKOZ2p5ytKGQmqvn
         cxig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785659796; x=1786264596; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ydlFqI2pV9TZGygA5cA5Y+Tnh5/uDxFV5Kmmu48b610=;
        b=LX/JIWhUb8+2zkK+9FZmYM8PqMOBj52+iHfB0NE11GPB+lx2K2tnnVX23V+VjdSZ9l
         NH/O5fBfhGFv0dpr99fFpVT5CYjIAWhb7DizPmweJbOL+PzmBoNdB/XYVc6MbowUwPYZ
         nitCArP/pYvLQMKKdajNQ49gjSckcZVrSmyG9RWgGCXL+07YLPZtapg809SHplkMNh98
         KhiaCDjXpxcV8rMEZDMhLb7rdF2x82VoX1HRZkc1IXVoEFX9CMiqjmGY/CJj1V8iVdk3
         aeRdz4q4SbmT9TVEQK1HqB7R/D/nKGdzJDnmJCUYNCfEeUxnytHc2XPSSYVPrhNlndHt
         09nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785659796; x=1786264596;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ydlFqI2pV9TZGygA5cA5Y+Tnh5/uDxFV5Kmmu48b610=;
        b=PTSWVcE1jQIBC7vPjwWHMbpTX5ImJyX48Exx6zkqg7l7MhLtrrN6E8jdXnVbfVKIEV
         Vji+bPWVJq6RMZvMmgG6f1E+RF5BIakttlegW4luIK9upaAlEzZZwbf2InMh39i5ZdW3
         iZAPwZaa0Bi+oSibmUE4yYSVLPuTm8016HhwHQgWSVwLGsBvOkjPHooJhatYDjif79Sj
         qfyyQZz7eM5yPY7w3jfDQl7zfc9Dyf3T7cldMh4K8NYXwHV6KSuR+kNF7aWDnQFLlZLD
         fNek2Wgk6feX4IhpNRr2YdZWo3S8neNYs8nHZhxbJTLeRiU/SNRs16HNjwEVSfyp/QGY
         QbLw==
X-Forwarded-Encrypted: i=1; AHgh+Rq0jiBffjiBDVpuJnQsqMspFKHvTROHJooyC1MULeMDOB4h9eU1s0HemJgXANf4U4RR1TyHQr35qZeZ0zA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZVonjLL8pzwse9w3KrBI6P2AJGEE73gXeT5meH4BZRGU9mAaz
	RrxeO2XhKIG5OrPFMNwnB2o/CL7KLez2GQ4p5BJlEnh5LDlq5OaFFBEJhN0i5OHm7oTFiowp2N9
	B5NP9Sx+EHEnOtrGv+epzSp38BRthQ/o=
X-Gm-Gg: AR+sD10202RHBTYn8vKaNEAXIFKjmgP6QLqDfiTj/ekVtlhMP7eqHwTuAnMYlnM9r/6
	3BuQDh+up7DcpVFua5mvpn1iSzhRp5eeZg0zfnG+F9z2K5HiznN/2bIM+ca9vNFMEGheS4g8ik/
	3Qr9qEkIhOX8E/x/gj249MVv3P0+hmW2SyzCYPJ9TQuaiZ9KDsoCwxegmP4RejaDJgKRYW3FF0M
	dFTFst8NnId/85W4rB+12jX7sbBdSlHVnInN1e3okCvLQReK03+i7PKYszmP0QpMX3yqv8EsyTE
	cvxlZVXwifUg68lgcvH6aAczz4K5knzV3RbadWofwk0SidO2M2lrjd7LNBjIaF+tyEaoHx+K1q6
	YNh0Bj7OwrILOWBZwUykKdeULaIKBEM+MA8+mvleIqHLNsjyO2H46BBkujCMnqLasLqmoU26eGc
	Z5Cmap6lZHQmmpP8LDIX5PThZPQHI8BLoSmkZ2NxSPNNQgVwpZzIxwsyiUd4z/ytc=
X-Received: by 2002:a17:907:5c9:b0:c16:2f5d:6153 with SMTP id
 a640c23a62f3a-c1fe8109ccfmr388760666b.20.1785659795544; Sun, 02 Aug 2026
 01:36:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731074820.735619-1-crescentcy.hsieh@moxa.com> <20260731074820.735619-2-crescentcy.hsieh@moxa.com>
In-Reply-To: <20260731074820.735619-2-crescentcy.hsieh@moxa.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 2 Aug 2026 11:35:59 +0300
X-Gm-Features: AUfX_my1sLfA25R3hPlQTuancfaLbvwKj8-pkmGBpIVON1OtnQ1tEWe3LOhicSI
Message-ID: <CAHp75VeSXOrNNHOBTnrjAx+rpZHQJOt2BekLZaRM--hO18PyHw@mail.gmail.com>
Subject: Re: [PATCH v5 01/14] serial: 8250: split Moxa PCIe serial board
 support out of 8250_pci
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	FangpingFP.Cheng@moxa.com, Epson.Chiang@moxa.com, EddieSY.Lin@moxa.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 10:49=E2=80=AFAM Crescent Hsieh
<crescentcy.hsieh@moxa.com> wrote:
>
> The Moxa PCIe multiport serial boards are currently handled as part of
> 8250_pci.c. In preparation for adding Moxa-specific UART features and
> optimizations, move the Moxa PCIe implementation into a dedicated
> driver.
>
> This introduces drivers/tty/serial/8250/8250_mxpcie.c and wires it up
> via Kconfig and Makefile, while preserving the existing probe flow and
> device IDs.
>
> This change was suggested during earlier reviews by Andy Shevchenko [1][2=
].
>
> No functional change intended.

...


> +static unsigned int mxpcie8250_get_supp_rs(unsigned short device)
> +{
> +       switch (device & MOXA_DEV_ID_IFACE_MASK) {

For the sake of consistency this can be FIELD_GET() as well.

> +       case 0x0000:
> +       case 0x0600:
> +               return MOXA_SUPP_RS232;
> +       case 0x0100:
> +               return MOXA_SUPP_RS232 | MOXA_SUPP_RS422 | MOXA_SUPP_RS48=
5;
> +       case 0x0300:
> +               return MOXA_SUPP_RS422 | MOXA_SUPP_RS485;
> +       default:
> +               return 0;
> +       }
> +}

...

> +static void mxpcie8250_init_board(struct pci_dev *pdev, struct mxpcie825=
0 *priv)
> +{
> +       void __iomem *bar2_base =3D priv->bar2_base;
> +       unsigned short device =3D pdev->device;
> +       u8 cval;
> +
> +       /* Initial terminator */
> +       if (device =3D=3D PCI_DEVICE_ID_MOXA_CP114EL ||
> +           device =3D=3D PCI_DEVICE_ID_MOXA_CP118EL_A) {
> +               iowrite8(0xff, bar2_base + MOXA_GPIO_DIRECTION);
> +               iowrite8(0x00, bar2_base + MOXA_GPIO_OUTPUT);
> +       }
> +       /*
> +        * Enable hardware buffer to prevent break signal output when sys=
tem boots up.
> +        * This hardware buffer is only supported on Mini PCIe series.
> +        */
> +       if (mxpcie8250_is_mini_pcie(device)) {
> +               /* Set GPIO direction */
> +               cval =3D ioread8(bar2_base + MOXA_GPIO_DIRECTION);
> +               cval |=3D MOXA_GPIO_PIN2;

And FIELD_MODIFY() here...

> +               iowrite8(cval, bar2_base + MOXA_GPIO_DIRECTION);
> +               /* Enable low GPIO */
> +               cval =3D ioread8(bar2_base + MOXA_GPIO_OUTPUT);
> +               cval &=3D ~MOXA_GPIO_PIN2;

...and here.

> +               iowrite8(cval, bar2_base + MOXA_GPIO_OUTPUT);
> +       }
> +}

...

But I'm okay with this, the above can be amended later on.

--=20
With Best Regards,
Andy Shevchenko
