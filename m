Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD1738F938
	for <linux-serial@vger.kernel.org>; Wed,  1 Apr 2026 07:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775029750; cv=none; b=FwNZy+eQD8Tf9lqMt019HDPcxkm9uSERDX+pNo59Hk9IEAAsbalnf44vDdF3gNQ6RsJPmZUxzLi5lhtEajQGkqCOm9npSKR8EHdw0sZ7mygvzY83sZvCRFegvslyP/GNiskYc2JJRBAh/j4WppCVw+MlbEvnQVe5tN9idBzQWqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775029750; c=relaxed/simple;
	bh=TrSvQHvFE1kdPPKToRvXLO/y68l8RTw2mwUihP6/Y90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sg9/MrT6nU07wdk+3rm0upHfmraTICRBn/dyoVDrAc8ZYwIxOHskYbfiXXnqhQ3VYnuKdN/MLW0FWv5sufbcp+czaukJaFecid5z8ZB0b9vkUlUlQEgCysHoK1tq1KsWC1j2Gi4O0BlsTah1CKlYQVTXKbK3Ti7tm2dwC/okpfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-604f1bfed92so5001911137.0
        for <linux-serial@vger.kernel.org>; Wed, 01 Apr 2026 00:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775029745; x=1775634545;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QViiKnClzREegw/7Mfy/6jKSPqR75a0GyutQdyIknIY=;
        b=eW2c9YjGatur0PgmO3hNvvbupqXjrAUTzH3Sw67c/IP6N1eMVYVJubnnboLSrSB1Bx
         6CaxoDk+PXi9+/F4CB3lyGBXfdEag8WKFoXkws18x80z0/hcAKgp5Sb7fYQxP33gBbYl
         AyRoEjh6mBzyyO6neDjYuGcWLXQ5V/fQLYWnppssWqcXqE80CI59mBbkNjDXGmqjq4AD
         pQpmQfDXMLk9HMdZuRr905kWuMM/SASQILsMYGls8rGjoq8DUeg3i1EGOv7w7L2tPm5u
         ZVH7N1EYsjplHr5eOSWBfsJCz+IUV7Vo5OwFrnvst7u8kHiPAG0WYSNz4LaJbsbWln9r
         7Gdw==
X-Forwarded-Encrypted: i=1; AJvYcCWuY51vQHiULwZA7LId7IYB/qbB4mt/8PXQ8CZyUSC+/2bNvBRYRzCuVaOPc5w7P+GiyNe439XMg6+PvhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym73g4dzxlCB8kQYCgk0gOV/y+2SnYOQNcHlJfLFz5gDUUR6ke
	TAntwM8Beg7CJNPZjQlfMT/twZWyXLdC+eHfsT734d40yJ8YbEaH4VuJJxGylGVW
X-Gm-Gg: ATEYQzyuew4BNd31ORXI+hk8NuB4Hk1jPxKbmlQPRrQGEHD+tH6IZMtLTC2aEuUXZxv
	wcyBdf43TozdTDtc7snAjIw3muQCMlk5OKd/uNwvmPh8SxIrlUT9kbnRQ5ddBKS/dCZrSHx/GUI
	2lGPfZ4bnda8tVsqfaor1D31n9r5NDuvVUkH0BV+GfORZua4KTjxM5pwu4DyZUFt2DL4pspUVKH
	Jy/OBDTJo79+264/i5cba9dOgKvU1WppoEp/3RLK53ITiv2PuvWniPcOrm6U/582JkSSXBf09Bn
	kRYL7IF9NYPddy83oKIH6z4DqKxPozo2g2Wh9lHOsz8tUnjx3NiGEz5xEFmRLR5a9UNtZwPM2ZX
	fFAKGFdpjq/gNyauV+W7U4/AZByh+ppBLdbgms2bT7jB/eJMPX0KFzEvQcHQ3onsDp2Ndg1ES1L
	2l0Ao9tqKzKwZTK4rjTp2i+S8KUUp8sa3p9OA/N3nOdjacsR8Ic7r6crT3QPMU
X-Received: by 2002:a05:6102:5494:b0:605:6615:d9dd with SMTP id ada2fe7eead31-60567d42645mr1012389137.3.1775029744884;
        Wed, 01 Apr 2026 00:49:04 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-605123e7e88sm14947168137.0.2026.04.01.00.49.03
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 00:49:04 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-602b7085a52so4105392137.3
        for <linux-serial@vger.kernel.org>; Wed, 01 Apr 2026 00:49:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXVru+CLvbAHLYhjH96EtOwarjVn5rtSQiAhJ/5d2SmIj+EneuIHEwLdY9P+AaqPkMqOSyZF94iLDfIasg=@vger.kernel.org
X-Received: by 2002:a05:6102:390e:b0:604:dfe1:39a7 with SMTP id
 ada2fe7eead31-60567e18859mr845568137.11.1775029743600; Wed, 01 Apr 2026
 00:49:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327130431.59481-1-tzimmermann@suse.de> <20260327130431.59481-5-tzimmermann@suse.de>
In-Reply-To: <20260327130431.59481-5-tzimmermann@suse.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 1 Apr 2026 09:48:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX1vUuKq-Q1-zA5tC5+LWap4osFJMqQ5pRJ373z++KQLQ@mail.gmail.com>
X-Gm-Features: AQROBzAbUUOUvvD9qjb80We-Rv00f545IFsCToqLfb7seW_x9Ac2xM40zkpv4T4
Message-ID: <CAMuHMdX1vUuKq-Q1-zA5tC5+LWap4osFJMqQ5pRJ373z++KQLQ@mail.gmail.com>
Subject: Re: [PATCH 04/10] lib/fonts: Clean up Makefile
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: deller@gmx.de, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	simona@ffwll.ch, sam@ravnborg.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Thomas,

On Fri, 27 Mar 2026 at 14:05, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Simplify the Makefile. Drop font-obj-y and sort the fonts by dictionary
> order. Done in preparation for supporting optional font rotation.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks for your patch, which is now commit 3f90ea78f5fe9495
("lib/fonts: Clean up Makefile") in fbdev/for-next.

> --- a/lib/fonts/Makefile
> +++ b/lib/fonts/Makefile
> @@ -1,23 +1,22 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Font handling
>
> -font-objs := fonts.o
> +font-y := fonts.o
>
> -font-objs-$(CONFIG_FONT_SUN8x16)   += font_sun8x16.o
> -font-objs-$(CONFIG_FONT_SUN12x22)  += font_sun12x22.o
> -font-objs-$(CONFIG_FONT_8x8)       += font_8x8.o
> -font-objs-$(CONFIG_FONT_8x16)      += font_8x16.o
> -font-objs-$(CONFIG_FONT_6x11)      += font_6x11.o
> -font-objs-$(CONFIG_FONT_7x14)      += font_7x14.o
> -font-objs-$(CONFIG_FONT_10x18)     += font_10x18.o
> -font-objs-$(CONFIG_FONT_PEARL_8x8) += font_pearl_8x8.o
> -font-objs-$(CONFIG_FONT_ACORN_8x8) += font_acorn_8x8.o
> -font-objs-$(CONFIG_FONT_MINI_4x6)  += font_mini_4x6.o
> -font-objs-$(CONFIG_FONT_6x10)      += font_6x10.o
> -font-objs-$(CONFIG_FONT_TER10x18)  += font_ter10x18.o
> -font-objs-$(CONFIG_FONT_TER16x32)  += font_ter16x32.o
> -font-objs-$(CONFIG_FONT_6x8)       += font_6x8.o
> +# Built-in fonts
> +font-$(CONFIG_FONT_10x18)     += font_10x18.o
> +font-$(CONFIG_FONT_6x10)      += font_6x10.o
> +font-$(CONFIG_FONT_6x11)      += font_6x11.o
> +font-$(CONFIG_FONT_6x8)       += font_6x8.o
> +font-$(CONFIG_FONT_7x14)      += font_7x14.o
> +font-$(CONFIG_FONT_8x16)      += font_8x16.o
> +font-$(CONFIG_FONT_8x8)       += font_8x8.o

Please sort the anonymous entries by increasing font size.

> +font-$(CONFIG_FONT_ACORN_8x8) += font_acorn_8x8.o
> +font-$(CONFIG_FONT_MINI_4x6)  += font_mini_4x6.o
> +font-$(CONFIG_FONT_PEARL_8x8) += font_pearl_8x8.o
> +font-$(CONFIG_FONT_SUN12x22)  += font_sun12x22.o
> +font-$(CONFIG_FONT_SUN8x16)   += font_sun8x16.o
> +font-$(CONFIG_FONT_TER10x18)  += font_ter10x18.o
> +font-$(CONFIG_FONT_TER16x32)  += font_ter16x32.o
>
> -font-objs += $(font-objs-y)
> -
> -obj-$(CONFIG_FONT_SUPPORT)         += font.o
> +obj-$(CONFIG_FONT_SUPPORT) += font.o

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
