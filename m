Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7592FC89C
	for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763735428; cv=none; b=U8xIgJGS3fQult27io6uZdRSbeIMhqawju2AOYl9Zk5dUDFPSzYe6NyMTCMad/ih/jv7feTjjIHqybL5l1u3GkQQgEtUHH/Sbe66eOm7DzFkqdggwNnwkl6S9FUhv4IZNk7eL/DePRDWrodCPYg2kzWJudGQBeDksTWLOt7R37U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763735428; c=relaxed/simple;
	bh=Vujb9HN9zZcrTEbLtuAm29HUpoeOsJmlSQ2a/MNdF7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=duso9p171M9dksdWHr3OOWrZHwKSDxJYd385G5foboV2+U/vRA1u7T0LyosULSxUXj6GYPIPhS8vUBEYCalw+ks08M14N5Dq+YnjO/f/Iee5hr2TqM/N1WaFiyjeiWTuf9T2VXDqKj5pZIOacJF0U9EvzuxSB0gcQeuXUwMyEYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-559836d04f6so1429317e0c.0
        for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 06:30:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763735425; x=1764340225;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPWFRv4FW+wTpiYwHa18G5ivaGAWav/XZVG8NSWKkz0=;
        b=cblnxMkj2ztSnkdjidUun8/aUrnu9B9yhdVXUs2vptet4D4yjRaiQcOMLXJ2eS8gF2
         G3MsBVDeUOoL/08s6S55OLSVpR3yQYaVjP+YcEu/h9ygqyLzpXKZHyhX3liqEz1sS7JW
         RNZShB2XWZIaV7l5WD6oyfA3ODZVXZ4mVBBfwpjSQTJW7zdoSFiFTcTdGIn37iTNWzZC
         IS/wYkrtayOMIx1fOe1cfOuikPT1WXBsaaOrT423ituP3oOipbzvSt7kpc7yro5af/9c
         KiKG2G6XAOFpqdsSWryvfv0XqFkBHZrR9GXwCrbdNux5wG7EfOAu/rGs89ZTm7gYq9M0
         U8kQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiHaPT+tlK8Ijb2XbUYcNrTgpUMTjgmLFijyphKLbp/BHGmMqwHbq2pxTrfh+ZwrKw35wYm4Y+VBEiy2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVyQcMsX9rTpxog3gOPVo3aShf21g/lHyopLZe1EgEIXckzV6L
	myfBToqsqB2ygJ4PRz+R20LO625gVI1EQCT6urShJq1awvTWmSKixGVDUNZfXg+A
X-Gm-Gg: ASbGnctkMjS1At2vjKU6ZiDYUS8mSWcskhsw2xxNjoTgg+Puvla5+HZUuwbWw+htHaU
	pQbXV5dcjnX7P3Quu9VOgLtssqVOHSn1kcQz2k+ql1KrxWtsiqZp4sN85nnb4rkPutP7SAdz/OS
	+7Z0AyeAKhmsm7DbSWCC3wWDsfAmumzFez/ESaVS1EtyAiFkkpkcNUrMkb50aRNL22CqyDCnnFF
	bG2Jm51B7uCBk9v8MLz716S2IrpY/K93F51A7izYloKF+rx6ZJTGUpEsPxobEsJU3YRQcHPljXq
	qy6C4rQvkhLE9/9igSm76nXQYdqjqW3WaK3bBuSz2cLWir5JR2YY4HnUxQIgtanQU3bhXEjsw2b
	G4evWKkJIHyLhm19Qn5ri2G2se2wXZRiNEdu2ZR7+hasShnr8wCPjYPYAWYyglQHWdSFb6aB6Bl
	gk3Nvi0i/hqw2+TRZlx/tJv9i+cZq2K2Jr2sTJumzU/WjldRgo4gaw
X-Google-Smtp-Source: AGHT+IExgODXV+0COvJTjCnn5Tmr/j5mgfIl3bygk1VOHWH8wgLSIqnO9EAJELBTSxHA5U6DjQI62Q==
X-Received: by 2002:a05:6122:2893:b0:55b:1a3a:aae5 with SMTP id 71dfb90a1353d-55b8f00e3c4mr653500e0c.16.1763735424664;
        Fri, 21 Nov 2025 06:30:24 -0800 (PST)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b7f7763dfsm2318912e0c.13.2025.11.21.06.30.23
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 06:30:24 -0800 (PST)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-93518a78d0aso1040899241.3
        for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 06:30:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWB2QccFssOFR2zDQzZ7kxMhZ1Hu6DK6bO6/IZ/8QfYLb/LUmBHKjIsiDD47xhj4sjW4gfCY/Vms9gURDY=@vger.kernel.org
X-Received: by 2002:a05:6102:80a0:b0:5df:c4ec:660e with SMTP id
 ada2fe7eead31-5e1de1669eamr752738137.9.1763735422965; Fri, 21 Nov 2025
 06:30:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114101350.106699-1-biju.das.jz@bp.renesas.com> <20251114101350.106699-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251114101350.106699-3-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 21 Nov 2025 15:30:11 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXireT6xVeWBd_OhbhOt8iJceuYCChM8Smd5+msZaxoRg@mail.gmail.com>
X-Gm-Features: AWmQ_bm3gkDU9BNE71_fH23eymrJTQmeODetarHHlTS7DkHzMp75WvH3cD7OwLQ
Message-ID: <CAMuHMdXireT6xVeWBd_OhbhOt8iJceuYCChM8Smd5+msZaxoRg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] serial: sh-sci: Fix deadlock during RSCI FIFO
 overrun error
To: Biju <biju.das.au@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Nam Cao <namcao@linutronix.de>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Nov 2025 at 11:13, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> On RSCI IP, a deadlock occurs during a FIFO overrun error, as it uses a
> different register to clear the FIFO overrun error status.
>
> Cc: stable@kernel.org
> Fixes: 0666e3fe95ab ("serial: sh-sci: Add support for RZ/T2H SCI")
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v2->v3:
>  * Dropped overrun_clr from struct sci_port_params_bits
>  * All of the CFCLR_*C clearing bits match the corresponding
>    CSR_*status bits. So, reused the overrun mask for irq clearing.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
