Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4359F3C17
	for <linux-serial@vger.kernel.org>; Mon,  1 Dec 2025 02:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764555223; cv=none; b=DtPHS5/PLBKwSUujFr11kuhtVmSdKglAaApWCHQrzvtyiNWVAw2AJMiFPMegm2xrHzbgsvxx9lmCf+Lu9gvUJJhXELOU3KCvHztnGTLumby9Mo8gBt7yqBlCgAGBeTTXuFDROu7Llup8wnLTciF3yOVesPEEM3PPhx5e4RKi2iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764555223; c=relaxed/simple;
	bh=11IeFVlbQ0pqR3pEtOrlrD9IRgWiIEC8WIAdI7RCpmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fIh1bhm5c/V2t1688I2cg/YCJIjc5uuMmkpL4EqEsn4/4M0apT6J9GAUxeyLKKOf5Ecj/6t11WZlDlsli5oosu+PjqNNxv369MWCdHWxvcDBdc/Cye7LIKXI9x8TpnKt5r5vLb6YMZ65xsjNnN++Vi4QHgTqMUwPNhlFleDl7gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ci5gfeXa; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ci5gfeXa"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b734fcbf1e3so423956966b.3
        for <linux-serial@vger.kernel.org>; Sun, 30 Nov 2025 18:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764555220; x=1765160020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbT7NG5ivSdLUSfEa2aWWXXwemH+niDgVCOLmgjca7Q=;
        b=ci5gfeXaXf6ywTOQQuTpRMiNqSSD/tRBA1UokCTqI2FYUYUpWRyDI3IPPP+0F9p9bv
         Oqsvmr45oqFD8U9XqikTBzXHp2m2r+gq5npaUSD/oYCV+PMySabHBhHPWc9CGz53Id/g
         EKxXiPXa70SrOBglY1r/YWPRb2Ui4Acm8+cKW9Na3VMPNBfstukq5qbA0Z23UmGOqDdR
         pWCLRHgwn0q2+xNbNTkGZ6MZxQtQQQikes4O5bu6RJ+0BGy6xI1z3H5QjC1Xqq5yacwl
         dlpce9kvGxTAEIBtTLTHp4rKfM2KQGci+6MKPcTGYHaRtNIAzULq0wJolCzerBUENIVJ
         ik7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764555220; x=1765160020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HbT7NG5ivSdLUSfEa2aWWXXwemH+niDgVCOLmgjca7Q=;
        b=ZZB669z01rSkGFB/0j9xFBa8/67S1ymEbfQwvvGkEq5Jmvp/Y0KEkIR0K9yilzg2TP
         +giDroISZakQ2TlDaA/zMT0K7XA3CXn3CrSO5urLAS4fU2yuhv7BDbdVYaH70gWYoVcl
         WTdGa9hrTXQy6ZgOmT0PIjWkctUy+FvVcj3Azk43qw9sRE5q+cRN/SspK0Npzy/Aknmy
         xQoXvDkVL5o+kwR7QvG53e/BR4SjX30swhEMuHbg7Y8HTV5KWFBurK5r/2Gyo1Q4le9M
         5gtb3EUvXSnE1LIlRTxtjFM/pobzpBNIsAlF/Soq17fCeZ6SD3QL2p44uzUOJ37fUocE
         epoA==
X-Forwarded-Encrypted: i=1; AJvYcCW3GF60ES0x7tDOZsnqSYIRyERyRcE48xvpT/rfuv2/a99sGNmQIlWL+s373gA4TU/9jhJ4zL3ZdBGD8u4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWhJ62B97ckmilE6V7/69pzu4JiRKWZ5PDFXBGwPezrY/sFRHv
	o4ALlBMYL7+0glMEewf8nTC1Ktcwf0Pow9lNpb5qzPz80ekcVvWfeYiDaxvozIRqeL24+KR/sjW
	gmYxMZg0SzuA39RycUKJORCZs8MxbU4w=
X-Gm-Gg: ASbGncu/HBAa5Fu+0OtXPeGC/sUBnli+Ho+fvcrykF3zF17RwFK4VZnqM0ecTZSWIws
	wqWAuJh6FpF97XF1wn88Y6LA4TaYR0gamkoDFfwOfQJr5huKBcPm5wyBtIQz5n4oqs47fAx3P7x
	9GQRxluFA8hmT2SAp4e3gFyE43b22TPYQNGnVW/TM0r37cDjBdBMIwBiMSbFSO0Am5wOKhnI6SQ
	402fa0/MifNfIYgjH/jjOy6xMX25Jy91b2+x4NNGRY7Wzo2oMaiuesGwf4s/vxejn6Wxf8rPJdg
	RpYSqSMtOLuT59HePpxNIkQIcQoZEaJoL2EvWHCyWVFgdVsJlyjR1Z+0fsix4sWB7XJZHYQ=
X-Google-Smtp-Source: AGHT+IGWNMT5fc4JP6Isqs65VwOHr4gS6NzwSyHgWXq/b08KOhlr3OARYsU5rqbEsWtxUIGDMjZI5g/sTcWqjRiC1G4=
X-Received: by 2002:a17:907:6e9e:b0:b73:6d56:7459 with SMTP id
 a640c23a62f3a-b7671705640mr4398334266b.38.1764555220559; Sun, 30 Nov 2025
 18:13:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com> <20251130104222.63077-26-crescentcy.hsieh@moxa.com>
In-Reply-To: <20251130104222.63077-26-crescentcy.hsieh@moxa.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 1 Dec 2025 04:13:04 +0200
X-Gm-Features: AWmQ_bn-64hJJBEHihPchM-IhPEZyZlXth_vZU13_5KxByoQYSlYlomI32DlhoI
Message-ID: <CAHp75VdQ0mK_qJ9Cm1d+woWYFJVCJb0-Uwj1tKtG2QpW-7vQ1A@mail.gmail.com>
Subject: Re: [PATCH v1 25/31] serial: 8250_mxpcie: add basic GPIO helper functions
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 12:45=E2=80=AFPM Crescent Hsieh
<crescentcy.hsieh@moxa.com> wrote:
>
> Introduce a set of helper functions for accessing the on-board GPIO
> registers on Moxa PCIe serial devices. These cover:
>
> - Initializing all pins as outputs
> - Setting the direction of individual pins
> - Setting or clearing an output pin
> - Bulk set/get operations on OUTPUT and DIRECTION registers

> These functions do not change any existing behavior yet. They are added
> as a preparation step for follow-up patches that will make use of the
> GPIOs to control board-specific signals.

Then do not add them. We do not add the code without users. It might
be better for review (or worse ;-) but at the end of the day it needs
to be squashed with the user.

...

> +/**
> + * mxpcie8250_gpio_init() - GPIO initialization routine
> + * @iobar_addr:        The base address of the GPIO I/O region
> + *
> + * Initializes the GPIO direction. After calling this function, all GPIO
> + * pins will be set to output.

This is quite dangerous! Why not input? At bare minimum this needs a
good comment to explain why it's not a problem.

> + */
> +static void mxpcie8250_gpio_init(resource_size_t iobar_addr)
> +{
> +       /* Initialize all the GPIO pins into output state */
> +       outb(0xff, iobar_addr + MOXA_GPIO_DIRECTION);
> +}

...

Why is this not a drivers/gpio/gpio-moxa.c how it's done for Exar, for exam=
ple?

--=20
With Best Regards,
Andy Shevchenko
