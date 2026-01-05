Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F9B2C08D5
	for <linux-serial@vger.kernel.org>; Mon,  5 Jan 2026 16:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767631934; cv=none; b=eLC4NprF0IMlLf6ZljtPqbpAZ9SKvWtE+4CChKQya/qn3Jt8U2bF9fTvXYFU16oMROy0smmx3reEVgsZV9ctYhAbX+9cBXtoDUrd4lSkgbvL2WcX1GEJhMsxSVM6IdhPEjsXiDAyn0NipMSqh/EmOU4WjLnOh8PWN/HIbbftcog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767631934; c=relaxed/simple;
	bh=Lee2l5H9jRuz9Pj5Y1XHu77EPjq3Tlz9bPc1JXNhHKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQAyNbsOZcKDYqXINYOhttD/NJc5dMvo67baTjaJXkmUevO0h4a/3g2GQD21u9yZYXJLEFwUaEs/7UHVrWkZnqQ1r3iytDhv9HqTWvEtW7MxD8cXAb7NWMpw2W/ovJDoqaC3DQUE/R8Ia1iNSeucAMZBUAN2Jsc/TwZ5rDjT29s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-943d0cafe77so40729241.3
        for <linux-serial@vger.kernel.org>; Mon, 05 Jan 2026 08:52:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767631928; x=1768236728;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mf82+8wIkoTt9ksc/iCgUDKQDKPefP4klNppZqKBRek=;
        b=YcBpG0wMIhCy9XMuoB3dF7ApAfcHbviJ+gRB9NpQXbvAPV7Z09Hg4qzhPL6254UsYq
         xiBRoOInKPSmT+XhM8hDwej5FOXfObw4CgUDdZgJeIYRSjqeV9geY2QyNbrjNhYpchkW
         Y1K9/VPOD4GOgZJ26XhZyIJ4uw9ZP3MmHla3MJVGQ9A/fHLx39Hvv2KHMG0S2Vt1jmlk
         1zr00SZCw9hxJBpVXSdVuzSqavEd3rxcqtsqgMFvILWGhvfWPmxZDoZzmNhws/pUIKGT
         iapgEWzpU02NaYz3kw48vMM3/18FfkCNquEsO6yIZwmx7PDpfGzDBVLzVgdCsxU53NgV
         aFhw==
X-Forwarded-Encrypted: i=1; AJvYcCUey/9+QkU6KrnrN8izP6fc5AWUC8yCaSCLOrYGsz7T0aw+Gu8CDsarLoA/wWY3mElf2GHYMye9ufaZrOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNzRpbyTy+z0MVJOKpJdO1uubJ+iqTDsH6ZoC1A+gabERmF+d0
	siVSsJLX3l+c9kVvXkYsq59Qt5Ec847TuQtaL9iP7oFT46MNBmtu2O1jrYc3BjMd
X-Gm-Gg: AY/fxX4pAEoBZPpNeBRIliO0nJFC4LiNJxG8yRupei5CQj4dvspTxb21TSESxv+ZlSI
	UrC6knn4WKqpoU2HpvybrV1csOGgKqB3J86a6IRuSYo3TwNwWUbZn7dSc/6ay3u16fS+EdymrL9
	/6NXuEQb8x+HrwiFFBl2dincIy4v/sYt5ytQoC4hxh8PzkBVogHHV4G04gqUjqIh+Iv1FqSSfUX
	FNvJxcvV+1j2/TGvvfq019/h0cfua9+f5XiYRkZsqrPoUNpwV2JYSYEh/ohZfa7xOTQuakHyWto
	jW0ZN7wQVFZTPO67btMNdOxk++QHbyQ1cXacSZpTV8FrH8ejvLiggsGurgULtkSLehY9wUj1EgL
	3pqzLtDYEveNunQi5J0El+tn+umgnEmNpxxFFq8PB7CvQvo5QZIuDOTFp4RSCGAd20M//T2E2xP
	pFhlqvUTs3zp1kuAuKh4+rv//QPlbBLCpZOs8ij8UsQeJskBVr
X-Google-Smtp-Source: AGHT+IFUo/AhVSsx7aonV+N6ldftKVLDIT5dPiSMemMQOc9/0g+Jjq+OBe8rLcquypryXW3Hn4eGcQ==
X-Received: by 2002:a05:6102:2c07:b0:5e5:6eee:8ae7 with SMTP id ada2fe7eead31-5ec7432588amr19915137.2.1767631928422;
        Mon, 05 Jan 2026 08:52:08 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-944119e04f3sm18761241.1.2026.01.05.08.52.07
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 08:52:08 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5e19e72c2a7so26132137.3
        for <linux-serial@vger.kernel.org>; Mon, 05 Jan 2026 08:52:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWrnJdg8fGwecg98NBPPhwh9a6RtO48q+H4K34pNM6CvVOsjDEoXTOin4h39Fp9iWOcB5vzS/w4QRtAAm0=@vger.kernel.org
X-Received: by 2002:a05:6102:26cb:b0:5df:ac57:b0ea with SMTP id
 ada2fe7eead31-5ec7436ccb4mr16414137.10.1767631927699; Mon, 05 Jan 2026
 08:52:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251227202509.2084000-1-rdunlap@infradead.org> <20251227202509.2084000-5-rdunlap@infradead.org>
In-Reply-To: <20251227202509.2084000-5-rdunlap@infradead.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 5 Jan 2026 17:51:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXmO0+WpMfBusFDjeD6Zqmm=UU+1X9RdRojckMd_HVzLQ@mail.gmail.com>
X-Gm-Features: AQt7F2ptE1SWLCu_bO6NxmaiZ3sYlXIENma9nRpd6T74eBambR9GCUEWhNSqSco
Message-ID: <CAMuHMdXmO0+WpMfBusFDjeD6Zqmm=UU+1X9RdRojckMd_HVzLQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] serial: SH_SCI: improve "DMA support" prompt
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Fugang Duan <fugang.duan@nxp.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Randy,

On Sat, 27 Dec 2025 at 21:25, Randy Dunlap <rdunlap@infradead.org> wrote:
> Having a prompt of "DMA support" suddenly appear during a
> "make oldconfig" can be confusing. Add a little helpful text to
> the prompt message.
>
> Fixes: 73a19e4c0301 ("serial: sh-sci: Add DMA support.")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Thanks for your patch!

> --- linux-next-20251219.orig/drivers/tty/serial/Kconfig
> +++ linux-next-20251219/drivers/tty/serial/Kconfig
> @@ -671,7 +671,7 @@ config SERIAL_SH_SCI_EARLYCON
>         default ARCH_RENESAS
>
>  config SERIAL_SH_SCI_DMA
> -       bool "DMA support" if EXPERT
> +       bool "DMA support on SuperH SCI(F)" if EXPERT

Perhaps reword to "Support for DMA on SuperH SCI(F)", to match
the surrounding options?

>         depends on SERIAL_SH_SCI && DMA_ENGINE
>         default ARCH_RENESAS

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
