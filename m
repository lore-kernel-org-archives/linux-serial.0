Received: from mail-ua2-f43.google.com (mail-ua2-f43.google.com [74.125.226.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777003C09E8
	for <linux-serial@vger.kernel.org>; Sun, 27 Sep 2026 12:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790512001; cv=none; b=W0ecjAmg7s1lzbYkBUv+h/IO+ZOGa3ey7pmGtRFr+bgLzYF4mzfuvIh06xU6/4GIJmlwuHPFHJeITdy+2chuzuiT6ifknNKIxYvzjlUIyChwh3UsIOV5ToGLek1GXwqk0ox/3fRkwWKlxHeV0AqudYfxXC5pc/2CQLjZNUyxjYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790512001; c=relaxed/simple;
	bh=oNop5lBDeiAxiJltt4clkQ90VfgPeUptu2EMaN8H1Qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jd0albFYumgVq7QYLh9X+B2XdEgW1fne8CFmlmNGIfHFsUiHjcHnnCHk0Ee8WTX0wjjTm1sROAaPK0OraTcLBnFzVnoDYVylhY63zGltnPE5HsglhgjabjU/0OUNOKHkMSePeyyz8QcRGuRxJ0thqxXmV9NJQBhAY6HnslCUGgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.226.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua2-f43.google.com with SMTP id a1e0cc1a2514c-982dd15d169so1377635241.2
        for <linux-serial@vger.kernel.org>; Sun, 27 Sep 2026 05:26:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790511998; x=1791116798;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rItpLa2n9MiIOqmyRK+ap1Hs0buU9Shrp4pBeop1lGE=;
        b=KcdMFtJ2RaOKKZu+zhIFpmEG4AHAAIXIS/KovHo+eDc6eiTffcEdMayFxyexzFw8lU
         4wRo6Qbr+FatdjAX4Juzt0EyzWd6h8FfUowrSbDYZtLIPs6MU7BxhAKRNgmBgWaP0rjl
         xaX0zYKZTlkoyUbA+2DGLQHplSHj12vznME+TjKR0rFnNkHLeN2oHVM0Ado+iJ98xDyq
         MMBXo4LbpzVFy5Fszc+koPBipE2JppaqDm37MKHDf0fJ2BAOP6fPAgnNF2fDqkGglhaf
         qoW6ZEaIQyhJm8neBK57cLYmR8xTjx/ygpFubHiL8pGWG4J3gzsKHhznHA9BOJ93N5St
         wbYg==
X-Forwarded-Encrypted: i=1; AKwUvBwE8X0zjcb/p2daOUSYDq+R34vMFZJdXimVvOvbFN6LMDLP244oTGg2jysfYEN8Usqpfj/SgZQWJjdvJCM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKf9gcFJvDNAvzQ52E8QxlfkhHKU4hFVLMn7WojVZ+NbSBZvR70
	Iyi94aA9WX8w9sn2E7QAgQrRcN15j0LAAK9yVYLlgeO9xjfMejrKcI6FaPTPf/Y2
X-Gm-Gg: AYBFou1HG7+7dQGMM2j/9ual5PoPolBoEqFYajq/eJO+vfmAS8pkwptZxhqy+II9ned
	kGiUHzYDD8+GZuJn5EuYgEnHfl7ZeGKHFaod9bKBopcS9H9sk7NJe9gi5vPrvR9r2hUbWFytgc6
	qd1Bca7+cBLijM5xNiMGhFmzOP+cb7lRBwnFzhPKWhR8X5u45zYOoKNYKfQCz1jLsLqSwyeI/xw
	wPxWHVgeC1hSMKcvs9Kc077V4HH0lqlrXgRUfTh/RXJQwu5Hh9UzZ1LFBd+qaJVsNhkZdy1ty8q
	6HGPffLQt8scXxfcMPj5tFi5vuPzDv7yPhCNDni3xcoba9wzVWdArcDOsjf1ZvqAdqwY5h2SdQ1
	SLeRM5vC3/FJXt5LO3/SVYtgw0SImOCaROZs8DChdJes2ONtOp/HhG+aUCVCsaD8MzHiYNcy2+L
	Lr5tCPiE+P2XwlzBThEwJWS/Jth6MtUgych6EvDuGg+RrvmDxxICD2i0TWleqc+cHVJXK5mE2J0
	PLkd68Ix1d2BeN667rOfydOD5VoH4AmdGgaYg==
X-Received: by 2002:a05:6102:f97:b0:7b5:8fd9:27e2 with SMTP id ada2fe7eead31-7b58fd945d2mr257270137.12.1790511998376;
        Sun, 27 Sep 2026 05:26:38 -0700 (PDT)
Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com. [74.125.226.204])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9889b08af71sm2470503241.5.2026.09.27.05.26.37
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2026 05:26:37 -0700 (PDT)
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-982dd15d169so1377628241.2
        for <linux-serial@vger.kernel.org>; Sun, 27 Sep 2026 05:26:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwWuAA5M8N9HpZkM59/TE99I/mHtiOWsLgC0pwHvTaf5lB332jnBdzB0xvlhWv+TSUu2Q1f5kkyCunRvEc=@vger.kernel.org
X-Received: by 2002:a05:6102:534a:b0:7a0:f7cc:5045 with SMTP id
 ada2fe7eead31-7af1be75fa3mr4441712137.9.1790511996983; Sun, 27 Sep 2026
 05:26:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731094402.741645-3-thorsten.blum@linux.dev>
In-Reply-To: <20260731094402.741645-3-thorsten.blum@linux.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 27 Sep 2026 14:26:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXfst6urDAoSKQgbjB0j0vU7c0v=WM-gOe93iBEb0Li=w@mail.gmail.com>
X-Gm-Features: AclHuK-UFiGOvR6vAhEVwRBFXl5YC0sr-Pa_dOlgtOwpSCPiLeaSpNnlvcyuv28
Message-ID: <CAMuHMdXfst6urDAoSKQgbjB0j0vU7c0v=WM-gOe93iBEb0Li=w@mail.gmail.com>
Subject: Re: [PATCH 1/2] m68k/serial: Use generic BASE_BAUD in asm/serial.h
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	"open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Jul 2026 at 11:44, Thorsten Blum <thorsten.blum@linux.dev> wrote:
> Include asm-generic/serial.h and use the generic BASE_BAUD definition
> instead of redefining it.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/arch/m68k/include/asm/serial.h
> +++ b/arch/m68k/include/asm/serial.h
> @@ -7,15 +7,7 @@
>   *
>   */
>
> -
> -/*
> - * This assumes you have a 1.8432 MHz clock for your UART.
> - *
> - * It'd be nice if someone built a serial card with a 24.576 MHz
> - * clock, since the 16550A is capable of handling a top speed of 1.5
> - * megabits/second; but this requires the faster clock.
> - */
> -#define BASE_BAUD ( 1843200 / 16 )
> +#include <asm-generic/serial.h>
>
>  /* Standard COM flags (except for COM4, because of the 8514 problem) */
>  #ifdef CONFIG_SERIAL_8250_DETECT_IRQ

It would be good if this BASE_BAUD 8250-ism could be removed from
drivers/tty/serial/earlycon.c.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
