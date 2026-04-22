Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83AE361647
	for <linux-serial@vger.kernel.org>; Wed, 22 Apr 2026 07:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776841501; cv=none; b=AbQGUeWl5xk9xRGAhzlhIDIEtr1k+CdW5DsLVcIPfaL4Mdv3cI+pducmwoGL8BZz5izOSG3dvFifdib3YDqvpdZzsUYmuctlTG2EQ1rb5DnpzlmBhPPhzMszhnG5JAqSN3zsbgXTltpkgCduzDExjmsmryKXe2iy7T4VtNU3l3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776841501; c=relaxed/simple;
	bh=caBlDfLl+UaWCXVT/wSjHkxNWroEBNiNYGlokbHXKFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GTqNHtnERoqQJzj/T0fNPQ28mGw81Fqa9rW1xfrHgN+H/+lqjxTJyBDjthWQUzRHonSsWl4n+8xHGptQBhxh0vkO+QgMeOKLKVNqdlqAZHcdVhLXuRj9dlPurA02MglFnsDMLMWNFmHeJXeyDNywUoT4Fh6QM1X6U370IZhY4U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-56739adfa1aso3647345e0c.0
        for <linux-serial@vger.kernel.org>; Wed, 22 Apr 2026 00:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776841498; x=1777446298;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=liaRyWhpT9OCcw5airrCkAgKo3GVhO89vTayZKrLNrI=;
        b=dWKnPNBo2QG4rMpBcQMeTNDeZmJ3jYP85Yph2RQDsFumF7q8xc39LwY31f9p5u4MaF
         SZ+Ve9LCLH9lSeEKoskYg9tuCas6+xt7o+Uz7NKUrZ0RI6sK52QX4Vs4oWMddK7R1qk0
         T0g3qB5oU8Y7Ozia9nw269u4ULP27kypwZjZK2CoyXfAeThnXNSTyRToosHANKBm9QUZ
         0S2Gw25QkZKmXoFKYWXOZz5iqRggG3ruKvJ5bRG90P4oNvYMIDKr+JXc55GHPEyS5+VB
         M5GdNZ8c1FHwNccSvNXKJOAQGGOCoo6f5Ilq6y34fhOZB4M7jGgemap8swFZtUEe/sZa
         6bKA==
X-Forwarded-Encrypted: i=1; AFNElJ+adqCQk+HoxIL6vagL+9SJdrEDJYISqA/rcpWKMkdWNz+sZw18xB1Sc1DClfAf48GcUBvCKU5BPDCNwVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzngEkOtUTNzcZKYNpcIi/SnpS2U/KQc50kiXo34w0fFRK4/Kwd
	d9AsL3sWWyew4LmhlDTdGZ6vSXwGQe+ByrncZ8zxur9UP7nS6/6z4p8nMhsFyeOXqw0=
X-Gm-Gg: AeBDieuD3lPnefCHk5UcpNq5OZqsDN1dQKap9Mfjnl+aL9GjkDK8B+Ub2kuLYcIVd+e
	0BxVEkOpzgHUW8lDdq8vtHgEn+FmejcegNuIC6ANFbve/XEqHZ6if/un0AxBj/x9ddF4V80u7qk
	OfjwNXsej+PGylGQaN0XHS0Ja9pSwdLyBXMBqQbkth/2q+3ikWuT2D5JS3ZGvf+MYx4HbSG4HL2
	oGM8HjZR7ilWP/DRn92cqR8XCJcVposfgmZGv6QuThI7/H7g/wUL2n7dSFpohywxlYDkRvh1lih
	E/LgFpwM0YvmlYusru84R8wszHfyxxoHZ/+yHZgDC5sm3OfX9G8Iy5pGSikq6AOBM49tp1hK4XF
	cLMSmMXk17vjLqzfj6PppDy8gLU5s3TJWBqXDA7NDYDrtF++l7qsoY/tIXsgLCEFgReqmXGyBd3
	54cjHavCOLqHuwF79WSIBu3F89CpzWfXi8tGKHyqp7QHkl35q20TMqa1Y/IV7D6K1saZbPnHLUb
	RslJCE9x3/eCA==
X-Received: by 2002:a05:6122:4b82:b0:56d:451b:e4dd with SMTP id 71dfb90a1353d-56fa5a232c6mr10349254e0c.12.1776841498559;
        Wed, 22 Apr 2026 00:04:58 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa91bf120sm9783205e0c.3.2026.04.22.00.04.57
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 00:04:57 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-56efdc96b05so3270440e0c.1
        for <linux-serial@vger.kernel.org>; Wed, 22 Apr 2026 00:04:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8yCKO2lATsDFMxZiA12nxx6Q3eT723aOMXglfl2lAAD+MeaRQ43oNp5fEfM8Dnyf6LSoVJWEM3C3Sf9Yg=@vger.kernel.org
X-Received: by 2002:a05:6122:1347:b0:56b:815c:961d with SMTP id
 71dfb90a1353d-56fa5861c00mr10444199e0c.5.1776841497439; Wed, 22 Apr 2026
 00:04:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420140426.237865-1-biju.das.jz@bp.renesas.com> <20260420140426.237865-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260420140426.237865-3-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 22 Apr 2026 09:04:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXQi7eSZg71=01dYjpmgHRXS+L9hXZMN_dR-mtM6sLKNw@mail.gmail.com>
X-Gm-Features: AQROBzAmyxu2D2vKJPRl9CBrNtAxIhNRVSUNiYJ69sDUbK7osTPZ_P5v2qP_TKg
Message-ID: <CAMuHMdXQi7eSZg71=01dYjpmgHRXS+L9hXZMN_dR-mtM6sLKNw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] serial: sh-sci: Drop check for zero baud rate from uart_get_baud_rate()
To: Biju <biju.das.au@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Thierry Bultel <thierry.bultel.yh@bp.renesas.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Mon, 20 Apr 2026 at 16:04, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> On DT systems, a zero baud rate from uart_get_baud_rate() is not possible
> even earlycon derives its bit rate from chosen/stdout-path. The zero baud
> guard and its associated done label are therefore dead code. So remove it.
>
> Also drop the unused done label from rsci_set_termios().
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -2719,8 +2719,6 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
>                 max_freq = max(max_freq, s->clk_rates[i]);
>
>         baud = uart_get_baud_rate(port, termios, old, 0, max_freq / min_sr(s));
> -       if (!baud)
> -               goto done;
>
>         /*
>          * There can be multiple sources for the sampling clock.  Find the one

I am afraid you are missing that sh-sci is also used on SH, without DT?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
