Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16538F6B;
	Fri, 23 Aug 2024 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724435976; cv=none; b=XzmtkjTIYr3oZLxGZZfi7MPpfdjgMg1Dnu5pdRurxXWs9VARXCMLcsWFspeJLbb2NPnx414ugpLuk5KALzItkc5HSjUcrAM3+jujP/n/+CHxn9XUaYfcJkjH6xlA4Cgtg1kM3QOxW1LyQXPWcZ4XAm5ZinZsKIUjP9bME82vD3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724435976; c=relaxed/simple;
	bh=iuIrOXmtyg8nSKD4Cb/rTg5D9ty27V+8hU5rG7y9h4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JiT1rvCV95wT81Dx0U0/wHOCGy02yhr+8XECuAe6K4f86p9amtCVNLhJN8WTYE8uShDUtlXcPBJnUvUMV18l2I2tpfcXY1zLlBqEl8NH8jN6taC+nxVd+lMJ98W+8iGytPVg6GKwxv04GbzakOjFwCFNaKj93yeoodEPeVAC84A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsrySR33; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsrySR33"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so320009566b.1;
        Fri, 23 Aug 2024 10:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724435973; x=1725040773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fN5FZjGc/Ma9BSW/s6M5/plXev0WIRsR3amu0H9Pa1M=;
        b=XsrySR33G6DoYpQP0aQ1OodLz2a744lerKP70SGFRIPiB8IThKs9Mw95mMA68I7F2L
         7rC+5Qy6KEFPPuQQzzXqkKCt6vxJ85TuAYJp5UCRtsPfD+A9x+8eM84DRsDhnbwBSMSg
         PKYUuFIqicbuE50XOgbzeXXyCV2MMqLOXgTlazhFKM+cZGej+ISCvjL2/MKkhHUMNLYB
         +NbFbhSYwYrPwwGpMqOzrmCvoL27LDH8i5bGtem09Zeo9kO6eHMqPmnlQZpq7JTWVw7m
         lFwJWOU5v9yQT5LvgZ/GeOCu3nKl6wjLhsqKUwSGS2iHEcSB5aZABAUok15PZLlwTqJG
         NlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724435973; x=1725040773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fN5FZjGc/Ma9BSW/s6M5/plXev0WIRsR3amu0H9Pa1M=;
        b=J+Nlt5EgZgw8RQpRHiWSeB6o5kUAH+2yVwC2DPkg0cB91WOOrMeTjVvY0vPVw2lMH0
         q/CCh8hr7rAZpt//LFeA9+nOUji84MfxIDm/1HM2jCu8Ad/zq347rndPngrwnGCB0D5q
         3OuFwmBrRTPsNscG18g69lGlwxUFxlpTCA6j0XifCfyKcLrNTjx5Isktf0NYZBTiKDlx
         Mso2T/6qKRSb34h2NLVJ4DBYoXflZYTweh3GOUDu9U6FdyupqjwQgNhKssO2E8avvOHX
         VVmFc8KJG3WZeI/tyJVOSKoiK7CkEM0EhC29JHOYZY3H0W1x1BzxUF/+P89zcmijzPm5
         eFYA==
X-Forwarded-Encrypted: i=1; AJvYcCWC+ml9HuEXlgR+auUqUQQCM7jH2cIyzn/xikF1uLXq+cnNPyP3JAcaIWHeM0pi8erZMgjZw8eQI/HltYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqjqruVGM/0Ho0qLz0r4VsxqjgCWwvsMPCDbtmREpqooqXN5IH
	e6N6drgl1MXns+sPXpMSOveuhRePStmPI14CJNrV5sn4bGyLSGhA+jkWE6aDCxtgQGJhIYUD399
	mJmih9fB3LIBep7uFejeI0kS5p6I=
X-Google-Smtp-Source: AGHT+IFJVh7gDpAqq/5aZUkFu4I1rIGXzIzFh2Ybqb/2YJDfMzVuZIiLUTf7koddK7M3IM3poWcvfrluk40Dv9kQOv8=
X-Received: by 2002:a17:907:efcb:b0:a86:7adb:b327 with SMTP id
 a640c23a62f3a-a86a530135dmr212593566b.40.1724435972980; Fri, 23 Aug 2024
 10:59:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7deb753f-bf86-47ce-89bf-8277aca4293e@camlingroup.com> <fbd8debf-46ab-407a-beda-43e083bffee7@camlingroup.com>
In-Reply-To: <fbd8debf-46ab-407a-beda-43e083bffee7@camlingroup.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 23 Aug 2024 20:58:56 +0300
Message-ID: <CAHp75VeqOV7GEqMs6fMi2Fax-97zt+ykEXaptng=pi_BDKU5Bg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] serial: sc16is7xx: convert bitmask definitions to
 use BIT() macro
To: Lech Perczak <lech.perczak@camlingroup.com>
Cc: linux-serial@vger.kernel.org, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, Andy Shevchenko <andy@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <k.drobinski@camlintechnologies.com>, 
	=?UTF-8?Q?Pawe=C5=82_Lenkow?= <pawel.lenkow@camlingroup.com>, 
	Kirill Yatsenko <kirill.yatsenko@camlingroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 7:55=E2=80=AFPM Lech Perczak
<lech.perczak@camlingroup.com> wrote:
>
> Now that bit definition comments were cleaned up, convert bitmask
> definitions to use BIT() macro for clarity.
> Convert SC16IS7XX_IIR_* bitmask constants, to use GENMASK() macro, where
> applicable - while at that, realign comments.
> Compose SC16IS7XX_LSR_BRK_ERROR_MASK using aforementioned constants,
> instead of open-coding it, and remove now unneeded comment.

comments

...

>  /* IIR register bits */
> -#define SC16IS7XX_IIR_NO_INT_BIT       (1 << 0) /* No interrupts pending=
 */
> -#define SC16IS7XX_IIR_ID_MASK          0x3e     /* Mask for the interrup=
t ID */
> -#define SC16IS7XX_IIR_THRI_SRC         0x02     /* TX holding register e=
mpty */
> -#define SC16IS7XX_IIR_RDI_SRC          0x04     /* RX data interrupt */
> -#define SC16IS7XX_IIR_RLSE_SRC         0x06     /* RX line status error =
*/
> -#define SC16IS7XX_IIR_RTOI_SRC         0x0c     /* RX time-out interrupt=
 */
> -#define SC16IS7XX_IIR_MSI_SRC          0x00     /* Modem status interrup=
t
> -                                                 * - only on 75x/76x
> -                                                 */
> -#define SC16IS7XX_IIR_INPIN_SRC                0x30     /* Input pin cha=
nge of state
> -                                                 * - only on 75x/76x
> -                                                 */
> -#define SC16IS7XX_IIR_XOFFI_SRC                0x10     /* Received Xoff=
 */
> -#define SC16IS7XX_IIR_CTSRTS_SRC       0x20     /* nCTS,nRTS change of s=
tate
> -                                                 * from active (LOW)
> -                                                 * to inactive (HIGH)
> -                                                 */
> +#define SC16IS7XX_IIR_NO_INT_BIT       BIT(0)          /* No interrupts =
pending */

> +#define SC16IS7XX_IIR_ID_MASK          GENMASK(5,1)    /* Mask for the i=
nterrupt ID */

This is okay, but the rest of the bit combinations are better to have
to be plain numbers as usually they are listed in this way in the
datasheets. Note as well that 0x00 is a valid value which you can't
express using BIT() or GENMASK() (and this is usually the main point
to *not* convert them to these macros).

> +#define SC16IS7XX_IIR_THRI_SRC         BIT(1)          /* TX holding reg=
ister empty */
> +#define SC16IS7XX_IIR_RDI_SRC          BIT(2)          /* RX data interr=
upt */
> +#define SC16IS7XX_IIR_RLSE_SRC         GENMASK(2,1)    /* RX line status=
 error */
> +#define SC16IS7XX_IIR_RTOI_SRC         GENMASK(3,2)    /* RX time-out in=
terrupt */
> +#define SC16IS7XX_IIR_MSI_SRC          0x00            /* Modem status i=
nterrupt
> +                                                        * - only on 75x/=
76x
> +                                                        */
> +#define SC16IS7XX_IIR_INPIN_SRC                GENMASK(5,4)    /* Input =
pin change of state
> +                                                        * - only on 75x/=
76x
> +                                                        */
> +#define SC16IS7XX_IIR_XOFFI_SRC                BIT(4)          /* Receiv=
ed Xoff */
> +#define SC16IS7XX_IIR_CTSRTS_SRC       BIT(5)          /* nCTS,nRTS chan=
ge of state
> +                                                        * from active (L=
OW)
> +                                                        * to inactive (H=
IGH)
> +                                                        */

...

> +#define SC16IS7XX_LSR_BRK_ERROR_MASK   (SC16IS7XX_LSR_OE_BIT | \
> +                                       SC16IS7XX_LSR_PE_BIT | \
> +                                       SC16IS7XX_LSR_FE_BIT | \
> +                                       SC16IS7XX_LSR_BI_BIT)

It's better to start from the next line

#define SC16IS7XX_LSR_BRK_ERROR_MASK     \
        (SC16IS7XX_LSR_OE_BIT | ...


--=20
With Best Regards,
Andy Shevchenko
