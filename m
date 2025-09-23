Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465BD18027
	for <linux-serial@vger.kernel.org>; Tue, 23 Sep 2025 09:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758621585; cv=none; b=nKwTUJ70a+BvJqRUAaIQ3wchYRP1Uq/9CR/3kHYOojycACsOkt5BxUCK6PgkbP4uMbVXzQNNlcjN6KrrkK3UfccJzbLEWa7CNGFz4b6KqtbYpQ4Z6HFN3Qz6b9B7UqrkvnNcUjx0IAfmktm2PtWly0v3dvtIE1jI2i+mwP1rnJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758621585; c=relaxed/simple;
	bh=UngJ0Rhljc1gSU7wLJptkJ9TDFmikWFZOGAOtnzQ0Ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JlqkcHX/zQPKNY31BQXvYGapDaU0QgA5X1YN2dBEvapoQvVTLudHuGc78zIJHvPLrspjZbQaPIwLgQoWbht0+bV+51uXfrqB0ooGxMatfhFk499ibrBMR+zmNsXIlX6iHsemWOQWRLdMgGpvy5Py/MwiVdBkV2PtO5rQQVeZkGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-8e936be1359so2298285241.0
        for <linux-serial@vger.kernel.org>; Tue, 23 Sep 2025 02:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758621582; x=1759226382;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rnoTjylvxrxdgkjV6WJ+aZ2BUNyHdjRUjdJqPB2kS9E=;
        b=kuPrSdL9ENt9cMaARN8uRBixyJx6gveaJ9SuXY6RF/aEBTKFVNgRXruaxv4Js62a/i
         TI14h1Hp+3G/aolwkGn3qQjD0EyRhxx4fjYNA/f1IhtGH9/NOl9+sC7W34Bwc1vH2qpy
         LK13CTai+n+9hblFILtTe0/s8qSAXXU848hgata0yvOUNbSlCA/AMpcbAxAbrAaipxkS
         /kc29FXZeWrHylI8qX/4b6GY9lMQbKLC9ioDeHfj7lT9zZvumSPsaFOZknRPHOw5OHib
         QKMqUTmgenIxXo60ib3yV9muoIzmhU6WmD8s5r0SA6d1tmCjDoos8mRlwd8RnF09abJI
         IDAA==
X-Forwarded-Encrypted: i=1; AJvYcCUIVYFxvqF5HJbkH819+CguSO77KbtnIbTNwkSboikzbfYlykjOl4XB6vAxqGgeNuWm8SZo3MT83kFT3Uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAJm2s+PQQ5cmeLjbE52aYvrLxOnyKn3IfFbCMCTH6XVe7nlGd
	iR0pnaqEyUa19lKPi+0jIqeMhIU67e4cYT6KTqeJMpsok9pucvKE8NkkBQ/pMzfJ
X-Gm-Gg: ASbGncuGhCZmfSmgrFpjTs9KvIszu3uz/AxaHVKdSbyx8yauN1K3oy1+V3zEmyuFU8J
	6z80O+JWk9OCWyNydBoTVHDtBEcyI4+blWTAMbJx5+DWy8D9YbdN2GvtwpGXc/Qn8ENjvAvJLyd
	SH+jzF7YeNqdGreqXmbkiCAnQ4lVtsPwrhVw4mt6+bhydjn6HzhJiYNL++dba6dWpAydiq7+06N
	5v9spUNXXC51d2hrtTn9HwoXtAvmmftJCpoGmFnwe0z+FwbduPpLRgqX2yZbLqRh3AKKzTMshER
	S7EsIW8JrsDz5vILU1BdG3wcd95RbQPkVA4WB1nVbJqR0OzxZXcVRduQqjOyvMQsvL6bG+xOjap
	LIb22VCdZKgh+wAeYL2xuGObfkEMdpbL0yzijZe0VKe/Em5W01Di068pIAq+0l8tdJQTRLTE=
X-Google-Smtp-Source: AGHT+IHcUv8aI2HA3QMc184MdMhKoQkUnrmzlgyIMptqNQgCkdw2+BxlCXTStxcIJJBc5g4NmHIQ2w==
X-Received: by 2002:a05:6122:2216:b0:54b:bea5:87ee with SMTP id 71dfb90a1353d-54bcb13b070mr564444e0c.7.1758621581833;
        Tue, 23 Sep 2025 02:59:41 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54a8d9f286asm2385132e0c.0.2025.09.23.02.59.41
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 02:59:41 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-55ae619545fso3385171137.0
        for <linux-serial@vger.kernel.org>; Tue, 23 Sep 2025 02:59:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqSOaXes8uGV/1x9jMcdHhw7FkOS75/HCjIxxUUnm/XaewirilIMBN4oi1/cW+P5UoGvSsng8WGLdxxpw=@vger.kernel.org
X-Received: by 2002:a05:6102:a4a:b0:59d:6be4:5b97 with SMTP id
 ada2fe7eead31-5a577be934amr649174137.5.1758621580798; Tue, 23 Sep 2025
 02:59:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923092846.74517-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <2025092311-espresso-collector-5f4d@gregkh>
In-Reply-To: <2025092311-espresso-collector-5f4d@gregkh>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Sep 2025 11:59:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU_UXyAaeriz8R0MO5SpWE_z4s8Ci6CEMFgVJr_XxDZzA@mail.gmail.com>
X-Gm-Features: AS18NWAf5t3cNSnr0jhWdIdKjaw8kVZxFdQZxsA5_eTxyzisEh79rb7MSnHdO50
Message-ID: <CAMuHMdU_UXyAaeriz8R0MO5SpWE_z4s8Ci6CEMFgVJr_XxDZzA@mail.gmail.com>
Subject: Re: [PATCH] serial: sh-sci: Add missing header guard
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Prabhakar <prabhakar.csengg@gmail.com>, Jiri Slaby <jirislaby@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Greg,

On Tue, 23 Sept 2025 at 11:51, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Sep 23, 2025 at 10:28:46AM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add header guard to sh-sci.h to prevent multiple inclusions of the
> > header file.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/tty/serial/sh-sci.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.h
> > index 951681aba586..22f877e2a17e 100644
> > --- a/drivers/tty/serial/sh-sci.h
>
> Why is this a .h file at all?  It's so small, why not just put it all in
> the .c file and then there's no need for it anymore.

Until commit e76fe57447e88916 ("sh: Remove old early serial console code
V2") in v2.6.33, it was also included by arch/sh/kernel/early_printk.c.
Those days are long gone, so the time has come for assimilation...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
