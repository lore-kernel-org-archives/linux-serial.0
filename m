Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689B23F4138
	for <linux-serial@vger.kernel.org>; Tue,  4 Aug 2026 14:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785853620; cv=none; b=I9TLuXGTX+yuL5f0KKj5p2dgWUsnpXOxUbvGiN7RxmFS+3nx3zEDsXiJ/VkDq5XclQ/tiEsyCBkdgSniQQIleOc8wTza8KEM3XqWgQdMf4vkJyCt6jc1Ssf5wtSt23n/avaU/F492TJycUunMbhPl+KoGwgezGRmJtC0d6hMDMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785853620; c=relaxed/simple;
	bh=K3+B+5eE6S2uiHHWx/3yfNzyhgl+6YmMB0vp8+AJHgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1obOjIju5VaQ6LEdWFHmg4aPpQ+f0q+Rt+UPk7BKjP5sXDuVnmbkqCoaMEU7F41F9GTG8lRQWVpk1Hpr8oSDHeZ1qdx1eL1Wzf+oohrA+K4CHWAr1pr2LX4K8M7OIgPJaUUwkvcnjnRY/iO7l2E2Li3CQvu77HfVfhryUdWtng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-977258a75d9so2747464241.3
        for <linux-serial@vger.kernel.org>; Tue, 04 Aug 2026 07:26:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785853608; x=1786458408;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LZMYwkDRP4LF10uIoDgtiOh9lVdrDFonhS16oYjA+Wo=;
        b=lQpcZicc3oKdTTTRLNXJNruhVOMnKMpKmoZw/+cV7ttuDQU4FJmKLAmNX87yaR2JrM
         005ZSH75oRf5A1YPyGsMx3JRB2GQsmWjLxmmBiUrBT8LUEtopiXjLdzA4PlWu+J2c68a
         z1tSqUPHARaXFKUsrW6rpFg3wyL91ysiADGTZN2ar0ZeE5hog5I0HJX5ommwWu8lOT12
         iaHD2u/BShV7HMd+CeScRBcfLeEpYkKOH81H6mSSMoCY2hp+RPgfl2VErVN4ieKtOsAE
         9+Qh+1AIcappgmNtadFClrxIRExjiHaKoS+LryTQBw9DKGv51n3hFgreFhRPHpNKTuc7
         nCig==
X-Forwarded-Encrypted: i=1; AHgh+RoA/DIgW3QSga0osncpQnXQufIvK922TQXzxkAq+C5olT0cvKDoLr6zLrDzQim7Hadpxj0Xc+McokzcLO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbVkvFYE8SWpsD3b2R/HJ4llukGPtYitRkL0KpjefVZIJ7GT6V
	fWiBf+I+i05OcKuFOO5jj0qWjXqQby3iWGybpa6uHLBYYQKC2QH88Kt3L3vguJ20
X-Gm-Gg: AR+sD11AoPkjquqJchEAobsROrMKhTUdvcLvCBCfHHXqeDvhzYi2+lnlzUZNFVPDe9L
	811692L/r+Vxm1Yr6+6WlmfNTxt3H2Frf4bEEzxLUa+nHIIR8yWCq57tgTqRM02aZFK+Pg62AQ7
	TBrKJi4pOhzS89Hfe6oGuA2kQeoWUnj6cICFdzomTKvrP1McMynXG+FnxRZo8yYRjER+xrvfYz+
	9KjDeGkFALdqo+LZnul9cMud3F2vGCcr7ktmE1IGQ01PUu6ZjX17zHUz5Z5Yk6EbwMy2azykhgB
	ZndCM8M8oh+Qsy5jkJEcjscOhx4+UAbUHU7yCjbS2rvQdVnbV8iJOxpHJ0uwWkC8C1muoM64fpq
	uOcl6NU5f1bC0n2jWjXbgzALrR4zXBAaZfwQcn73PXkdZLqjv172U7ArlClaI5hty9A69o2Y8El
	aBzFpE1zYS7ZBWTW1si9z5suLz0uKx3CSeWlma1s2UECYE0E9sKMtPLM7amYwXQJiHUzA99A7/x
	AQMFrTW+o/BAGpxoYWkzOmqOsJkDg27qee0
X-Received: by 2002:a05:6102:fa5:b0:74a:b492:3a62 with SMTP id ada2fe7eead31-75b21e6b74emr10970246137.4.1785853607825;
        Tue, 04 Aug 2026 07:26:47 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9782c8e8724sm214728241.10.2026.08.04.07.26.45
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 07:26:46 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-973b676e5f5so2605646241.1
        for <linux-serial@vger.kernel.org>; Tue, 04 Aug 2026 07:26:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro7dds/jjo/37K+kXpOuxS7WyIyNXmhkyAZGuym676ZI4ZM6uZrlSu5QqEpetj096ULcmvd5Fp3+CV+Utk=@vger.kernel.org
X-Received: by 2002:a05:6102:6898:b0:737:e816:b26f with SMTP id
 ada2fe7eead31-75b23a65804mr12177111137.10.1785853605807; Tue, 04 Aug 2026
 07:26:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785832297.git.u.kleine-koenig@baylibre.com>
 <b90344819432e493f54d557ec06e734e3392724f.1785832297.git.u.kleine-koenig@baylibre.com>
 <20260804.230536.670060570505120005.anemo@mba.ocn.ne.jp>
In-Reply-To: <20260804.230536.670060570505120005.anemo@mba.ocn.ne.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 4 Aug 2026 16:26:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUyiGu7ArAVkFw5+3KH_rN0f+5GaiDwud9OnWaMM_DfSg@mail.gmail.com>
X-Gm-Features: AUfX_mzWn9arNJyFzdmPQLxwVDaYc8ha_ZQvnnH6mr89VTrSZKuPB8Fy29SgyFM
Message-ID: <CAMuHMdUyiGu7ArAVkFw5+3KH_rN0f+5GaiDwud9OnWaMM_DfSg@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] serial: txx9: Simplify knowing that .iotype is
 always UPIO_PORT
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: u.kleine-koenig@baylibre.com, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, hvilleneuve@dimonoff.com, john.ogness@linutronix.de, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	ilpo.jarvinen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Aug 2026 at 16:05, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> On Tue,  4 Aug 2026 10:57:54 +0200, Uwe Kleine-K=C3=B6nig (The Capable Hu=
b) <u.kleine-koenig@baylibre.com> wrote:
> > After the previous commit it's obvious that .iotype is always UPIO_PORT=
.
> > Simplify some functions accordingly.
>
> No, .iotype can be UPIO_MEM if early_serial_txx9_setup() was called from
> arch/mips/txx9/generic/setup.c.
>
> Please drop this patch from your series.

Indeed:

    serial_txx9: ttyS0 MMIO:0x0000000fff1ff300 (irq =3D 32, base_baud =3D
3125000) is a txx9
    ** 19695 printk messages dropped **
    pcistat:22b0(ReceivedMasterAbort)
    PCIERR interrupt at 0xffffffff80379aec
    [...]

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
