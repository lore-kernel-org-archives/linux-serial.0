Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF2534D4DF
	for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 14:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763736845; cv=none; b=Hmfp3+WakZOU3y4Q48i3wjW3cNym7oQu1J5I8swWFaAN4oGV1LTTEpXJmh9wG/R0Cc02ITeYePXInr4pi0wLrllrIK3s3B4ocMz+c08k/OYz6uwNSXbz7SsP3/u0pDdiAMaBJK1GdsB0iuTPRdxtIXs99d02teHW9jlrqR781PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763736845; c=relaxed/simple;
	bh=/i7nXXYJ/S35e1DDoqCsekWeTret9cPBtAsRNgYtitk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BW5FLuNQZDkvowKIoGpzBZqIVoFLJNB7orjnA+06e9ewGdGXAGX592LnqP+feXKdae7T3R+aheYWheuVngZIxZuDf7kpXdN6Gxx9FAN3ozqES4eeHsI7ZPM+/3IWXADCjTPbB8iSlKMS4d3lDAlUOYH0ytjlK/q0i8EhoZLsliU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-93720fd0723so634028241.2
        for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 06:54:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763736839; x=1764341639;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1emL/2BfYYpJgkMipS6IyfAGtl5eimxGIDnmxM+aDY=;
        b=k982PNUUN3+0cbv8Ej88ifreVVFoLWZ9ntvwxY0PL9EKm7gQV1+PbueCPe9ZV29gXS
         gkcTvTA7MPNXavV9qQ4jsP9FxXiaRfo6JB0CWyU3hfdBpYLap1SOgeTrWEmtIuhsAzZ+
         JT5EIE8JEO1A/H4CvTyqXOQshIfXb7PaCX48v8Ltf916y92CcQm1ItYIH910E3yYxQi7
         oipQwK0C13h5sMkwVh5dp4hIo9AxUV7Rwtig4SZsIOGxa0ipoSaENovMadoY4ySiJTmG
         XrJaOvRCEuGcm+HFQ6wjVqipyCe5l7u0DdQ++Bs7b5kWazEjP5Fo06SYk8Cnl5MmoHwn
         nlQg==
X-Forwarded-Encrypted: i=1; AJvYcCU+LUeR0gaZCz5HWHyegd7mUeX9ti1gFlUdv2EuxpIEfwjODk5Um51afXuuNPrGsKero7kJ5GD//ogJpVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpFtsr3sD0IJIwjhI2i5jkuEenfgRteGrKZOzWBE6bupp8o8D3
	QO1z4ytfcRm3VvoH2rodYKA6nchvuWVt55TJgE5+EYKeHynCaWNh/pSLbAkCqjf2
X-Gm-Gg: ASbGncseKSrxUU4e9vda/VFQPHFIOsV8BROxaRG634DjjivjdcHLdqwFJwTe+AWVFXR
	HcIOLjLAi0KusJ8gnw/7EbolBbQ+EHHgvGQGiXabCXVKRIgaM2+qtM7f8MRbvvbQtJosLbclsgQ
	7qt1ivWYtRn6KlkOyKwHHxQ84LHccHO9U/thJF4/SrhZczwdoPOUlDUv3MSOQiV5wvrWk1CaPA2
	HtK8MhrinEuMIKB/skpfCWrBTXKOxKpqdt5uH1TPTpTI05BCkawojroT2n3Kes/kqitgVjCtOOo
	f0Vqeulr8eJ0jevvCJMWQ6uBFb/gQOjT1KyVT4SIQOEvk0U+GVqS+5kTLjCezCKGeR9h6B4iMP5
	2Znp8dp1IROwC+93twUQLAmW+EyvWVOn63Ad7gXTyHp6TlhGIkcxFqOuign0Mqgza7mDrElX5js
	HIATP7NTz68b92NS2GyMjf86YIhln7guTEafzqKakLPI/SHLnDJZKflXbiDqc=
X-Google-Smtp-Source: AGHT+IEqoibiaaiG8DnD3cFopntdiqpQyxNL4PpOKBqwxBmaa9K1tW9JiiALhYJ7SFpWptDj/vwgNw==
X-Received: by 2002:a05:6102:5805:b0:5db:e721:8624 with SMTP id ada2fe7eead31-5e1de13744emr645347137.1.1763736839387;
        Fri, 21 Nov 2025 06:53:59 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93c5621d03asm2219849241.6.2025.11.21.06.53.58
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 06:53:58 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5e186858102so746616137.0
        for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 06:53:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVot+5LdHYfK0/NjwL3LltAqJy1uhPaXK3y4rqwk5/rtiKhd+H0Keu4aSlkCupGqwsR4B0cITJBdb3WmL0=@vger.kernel.org
X-Received: by 2002:a05:6102:2914:b0:5d3:fecb:e4e8 with SMTP id
 ada2fe7eead31-5e1de13755dmr737744137.5.1763736838284; Fri, 21 Nov 2025
 06:53:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114105201.107406-1-biju.das.jz@bp.renesas.com> <20251114105201.107406-4-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251114105201.107406-4-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 21 Nov 2025 15:53:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVBoRtm8ULLfUK_cVECfx47tRArNHFyYD0C+B7MM9Mneg@mail.gmail.com>
X-Gm-Features: AWmQ_bleERgqdogMt-KCM4u2kemacgqay0PsYPcAY6PFTObuXA-J-VDhL_sWOrI
Message-ID: <CAMuHMdVBoRtm8ULLfUK_cVECfx47tRArNHFyYD0C+B7MM9Mneg@mail.gmail.com>
Subject: Re: [PATCH v3 03/13] serial: sh-sci: Drop extra lines
To: Biju <biju.das.au@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Nov 2025 at 11:52, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Shorten the number lines in sci_init_clocks() by fitting the error
> messages within an 100-character length limit.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
