Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB7C34DCC4
	for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763737252; cv=none; b=K5XkKPWSWri+dSrkE+LHyCGbffw+IhD4bUpq81ds/D3yRcr2irLLxwksfzGGst/tHnbubsIHPXNHhz8yFyyWFPYuwhVIzlA2E+MpsxyyrZMGE+/KSPWeblmCRxA/5JuinjYDwVHRm/AGNEUXNf0fcKME/5YFRhlGdqTGYshc/tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763737252; c=relaxed/simple;
	bh=AQNOKwHB3UBl9g7sRvqDiWCcJTkwnsBUkpIpk6Wat1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pmr+x1EOZJ1caRzpGcEB42BKzCRHktEA80Cusq/j8mh3vWenlrvNAVK6Ihzn6PCo5BRJ+3ACuCfS+taM5vV2/QAB0ojbQRZYoN6ILA/UzIwszJQk2MuSjRCgEtaEe0zF9wxqpaF296sFXc4JWH2UVTZvHMehshaElgcTlbDLmxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5dfc2a9b79fso735177137.0
        for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 07:00:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763737249; x=1764342049;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjPFQIGsOb/05+Tcv+1sJFrvUE64bOGGUtXswPEQksg=;
        b=hFSnZyTHjJZt8OStIqqYgg/Jy7FE3sBHnhEqmPDKSDiZ9ChI0hN2x3Ek34RoxtKXnP
         YD9TlAz1+cmYLG91NJB5VhNeUpsWA8NMvuYFJMj6hjkEuPifkcgb4iAtS1LAhT7rHk7F
         EKxpDo/0v58sHsOHZTOfjltYkSDASL2Dvsj/yXdNAkrAAHa6e9yXAW+mBcQsKkfuG+PD
         LWpEZIOSvxJjdIj5riFnfvzeW7K2MW6+g0CLWUGlIACmoYh27aVV/y5kxbcY6Lsop2eU
         arC8ii7yezUeUT/Cf9kqowpnmymMqtnt3mXmxpB0EbqlkFjCUB2iUuCMlnyPH0c9r7v+
         N0tw==
X-Forwarded-Encrypted: i=1; AJvYcCV57s/YlLBwvB8mzAv5gFn7MLIaJLtpD5iK3nQbjv8PmP6Clq7h3BGDlMa5P+71QGqN4+5t0TFLb4j+ZEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKKbRQyqNClP0FIfgPs9KOuKrVX4XzcfZI6rpnJRWuyboWmhNL
	jmzLeNBJx7ULF+5nLHGlcCD+9IzmJKCrZVG2CrrSuTzQfrYchQdC/gHvscnONQia
X-Gm-Gg: ASbGncshQi/4D8SokO9O0oUWfPfGqmx5bEAxmqFnAuCiY73rPBK7W9B+I9QdFSfaqSs
	VfEL85H1wAG7gkX+syf0HVDSOCkdurFRcAzKQ+Z9SDqYcwUVUt6VefF9p9r7jwdvnd2wrULnsgu
	pJXMS+6DbEJDQfY9hHjmszyPJjMRnIsju6lbPFAPDlJd8i7stHyrYvg9QHu/wAXGuNsns99P4YC
	c+CkHqO3bNlfrOWEnZ5PyrU7u/QnvAMnesNK8JSk6J/U3jQ3WqAefCJfRpwSNx4mFWOOpTYsVRK
	tM5U+5SwLbKYXFrcCLhNCl31yAtFhuerB+iivaI+P91Jl+JqGFxkqlG4C8d7fvOxgsRst/6cMc8
	z71Bhp7x0eQIR9auz3WFlZPpBN0HJJm6K0Z9rjWWPeet2qHMRKHSlzh9NtyuxggdGgK3M7mMuHG
	1Ug6sJ5dR918m0wjSOy0C2D/yaZqW1RwYvGBOw0DCNz/7PU4OC
X-Google-Smtp-Source: AGHT+IGBCbTXEcjCS38Ng+tYNjumEmKyXJMDdP27KW6xdQuKxDmTzV0L5tExht1QvafvMOVjHWUs5Q==
X-Received: by 2002:a05:6102:4487:b0:5df:af0f:30a1 with SMTP id ada2fe7eead31-5e1de43093amr714987137.31.1763737248176;
        Fri, 21 Nov 2025 07:00:48 -0800 (PST)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93c5621ca4asm2515055241.5.2025.11.21.07.00.45
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 07:00:46 -0800 (PST)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5dd88eef2f3so791030137.3
        for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 07:00:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+sUJO/Df+dMwYxGcN/qh3rMr/SJXdBgCFgYPVcLuofzKXGBglYDdjxKcEQbeMe2yhwjwVtSRNYFuP3jU=@vger.kernel.org
X-Received: by 2002:a05:6102:d92:b0:5db:f850:b1de with SMTP id
 ada2fe7eead31-5e1de3c0ef2mr643479137.25.1763737245110; Fri, 21 Nov 2025
 07:00:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114105201.107406-1-biju.das.jz@bp.renesas.com> <20251114105201.107406-6-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251114105201.107406-6-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 21 Nov 2025 16:00:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVZUA5CAtAkcpcfwN+kM85kWPDD88+pNO8jfVoVxvuSyA@mail.gmail.com>
X-Gm-Features: AWmQ_bmonK_A1Tk_afThFkax5A8T6CT_PRaXgFElQ-qoD63LPaFf7VsWtVh5eAA
Message-ID: <CAMuHMdVZUA5CAtAkcpcfwN+kM85kWPDD88+pNO8jfVoVxvuSyA@mail.gmail.com>
Subject: Re: [PATCH v3 05/13] serial: rsci: Drop unused TDR register
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
> Drop the unused TDR register-related macros.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/tty/serial/rsci.c
> +++ b/drivers/tty/serial/rsci.c
> @@ -35,12 +35,6 @@ MODULE_IMPORT_NS("SH_SCI");
>  #define RDR_FPER               BIT(11) /* FIFO Parity Error */
>  #define RDR_RDAT_MSK           GENMASK(8, 0)
>
> -/* TDR (Transmit Data Register) */
> -#define TDR_MPBT               BIT(9)  /* Multiprocessor Transfer */

Might be useful, one day. But all other bits do not have defines yet anyway.

> -#define TDR_TDAT_9BIT_LSHIFT   0
> -#define TDR_TDAT_9BIT_VAL      0x1FF
> -#define TDR_TDAT_9BIT_MSK      (TDR_TDAT_9BIT_VAL << TDR_TDAT_9BIT_LSHIFT)

I agree this is rather useless.

> -
>  /* CCR0 (Common Control Register 0) */
>  #define CCR0_SSE               BIT(24) /* SSn# Pin Function Enable */
>  #define CCR0_TEIE              BIT(21) /* Transmit End Interrupt Enable */

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
