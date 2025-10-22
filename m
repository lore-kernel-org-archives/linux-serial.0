Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1CE2F28F9
	for <linux-serial@vger.kernel.org>; Wed, 22 Oct 2025 06:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761116158; cv=none; b=jIh/iIMkzqWcFA4CCD59r1D8O3dzrNf3EfgAkJT7R1KY8wgZ2vSd5PvC4pyz2xCxm3/flzEzcNbzIQtkg1F9tKvt5K3TgnX2zoGoo/ZRQCSmx5ORUOuwhQmbIopz5hrC1cs0J8UdHpBx/JcbVFZpKEZ8mXorE42vd13fBogDEjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761116158; c=relaxed/simple;
	bh=WkDEzB5N4V8tlJFRXR5ysA8N/DAcuP7R5T1XoyuKbJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wa17iMccoFNPX6YtgVtBP2BcstZFUcEZC+p7BkNEozArKQRLXWA9KY2mLGl/IUHCVbQrNkip+Alx0oKFRwIio1ARPkEygWmlJr+A1ZwNhqF3HBeW/gX3tny7yjGX7tSWnI8IMhl6L/7vrUJXhpY+bbDUlPGvkqoRRbK/9m3C5os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRm6jnI7; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRm6jnI7"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3c9975a3d6eso1333442fac.2
        for <linux-serial@vger.kernel.org>; Tue, 21 Oct 2025 23:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761116155; x=1761720955; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T+geXNLPoYT+g7n3ssTeMIPZBREGJuzg2Y1yRpcxjwI=;
        b=KRm6jnI7vvLFmAuj/rRP4uicZRWQYt7BKFYx3TAzNT7bHcAmJCzw2WZrJwd4dOHRC0
         9hIu7/hC9pgFhulagq6z/8pzMABp8a8zW63aHg9Yd3HLoc0j/A1Fo9YVAAwbvqGZhXFg
         vFZCT0K0wu+2pNukzBDIS7WpPdw7BUFo6Qfu5GLrH4uoqGIvWD5qCb9UdzbsHAaOsbjT
         paCdtDTWYa0gcEla2FBKD0NU9a5BCE4b/A6SfTlMW5vmKgcK33WzWhgIO2HA/4WwEypA
         GIyFmOhX7XP639gNKAKgMhxXDgFOg8F0Kjv70wM9zsarIacYm8pfE4hAqEE1tx4suaww
         oxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761116155; x=1761720955;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T+geXNLPoYT+g7n3ssTeMIPZBREGJuzg2Y1yRpcxjwI=;
        b=eI+Ven0Wfb/6SCz6mxc5GNlaSoTsIAWZ+nihEOxnnfs+DmCMecjDyaLjS8ffZnoGo8
         tEI/qqxlQOzGLQehAOpDQrXhlj8iMkJdGt3bg2XnQAp9qVrnzdmD5VLEGjh6Ip1BRaH5
         V6crOawnn9JteU7swGiQo+cKwLnenwRxEjyW2ye5ASQ2QZ6AzebZLnpvatsyLslAsWqf
         iFpFG/P+0glTPfbkPdPrUlqaFPaFkiwdVxrt5LVeeNaamXMkaytQS/zGuBgCgLtaQybV
         L12f6G8hr0U6PbaUuWdpZgP4Ttbebhy7Os/Ut29uoP1vOvlYW5HLzM6AoV9TP7sheXH+
         IRDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR2pVb3A3CGZ/GJr4yK54FFD+gyQ2AALseKbdnI0WVNbw+VClwSRYTEjxC4sInET/BxkTNkoRuZEKCo2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsfLw6kIrWKmztD/MD2Ri2YUrNJpNPJT2RZuiUYx5T2T8jliFB
	lODOgpAnd7aBMGTzZ65ygCILeN6wsutsMuZi2osjdoyQzGBR6RmO4ExABnX3Zg73mO+tXvl8uSn
	nH3S+yGs0I/Ehcl52ok0QhwU66SzCl3hVj9O3
X-Gm-Gg: ASbGnctGwAwiy7UhxLwG4YKEKJsKohSnMlINkbiEizDxMmYuDBtsg/kmxh2x33WIVXE
	KgHrj137HXnx0nJl76fAWAl8yI1zjrGoPVhcvzJi4iwZ2/KYGeQtf4JBmrB9H3oNqFQnyo7ytOF
	IvUo+b3C3Dnr73r2HJouqx6mEOdYxLaB9N3bQ9wz3mqA13TtF2QGzae7CqzqaZTlGohO8DRWuYm
	XPOlmHqiBnnF3I1UAFp6T8OMQW/AWGNhnCNeHi5nM+Mpiy6lEerJiDZLfTuzJfQ/Is4Uw==
X-Google-Smtp-Source: AGHT+IGwWUfJwaZxrSmSqwuOc1uIOsgsZY0s0HRs122BLbIZBBj56tnMVXEMMc5Eyr21rdDe3zOExr3hezrVk3Px2gw=
X-Received: by 2002:a05:6870:4e8c:b0:30b:cd02:297c with SMTP id
 586e51a60fabf-3c98d17dc37mr8955692fac.35.1761116155546; Tue, 21 Oct 2025
 23:55:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022030840.956589-1-Wenhua.Lin@unisoc.com>
In-Reply-To: <20251022030840.956589-1-Wenhua.Lin@unisoc.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Wed, 22 Oct 2025 14:55:17 +0800
X-Gm-Features: AS18NWBdi_EIGFjDegtPbIDhcO6RDB-JPNHUp1fKzjacRS6sWcnJcGCwsuuLi3E
Message-ID: <CAAfSe-uq6GszSLgtM+UBuwJ6V1Bt0_1Ard8cb6e9MMCsdpJPqw@mail.gmail.com>
Subject: Re: [PATCH] serial: sprd: Return -EPROBE_DEFER when uart clock is not ready
To: Wenhua Lin <Wenhua.Lin@unisoc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Cixi Geng <cixi.geng@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, wenhua lin <wenhua.lin1994@gmail.com>, 
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>, Zhaochen Su <Zhaochen.Su@unisoc.com>, 
	Zhirong Qiu <Zhirong.Qiu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Oct 2025 at 11:09, Wenhua Lin <Wenhua.Lin@unisoc.com> wrote:
>
> In sprd_clk_init(), when devm_clk_get() returns -EPROBE_DEFER
> for either uart or source clock, we should propagate the
> error instead of just warning and continuing with NULL clocks.
>
> Currently the driver only emits a warning when clock acquisition
> fails and proceeds with NULL clock pointers. This can lead to
> issues later when the clocks are actually needed. More importantly,
> when the clock provider is not ready yet and returns -EPROBE_DEFER,
> we should return this error to allow deferred probing.
>
> This change adds explicit checks for -EPROBE_DEFER after both:
> 1. devm_clk_get(uport->dev, uart)
> 2. devm_clk_get(uport->dev, source)
>
> When -EPROBE_DEFER is encountered, the function now returns
> -EPROBE_DEFER to let the driver framework retry probing
> later when the clock dependencies are resolved.
>
> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> ---
>  drivers/tty/serial/sprd_serial.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
> index 8c9366321f8e..092755f35683 100644
> --- a/drivers/tty/serial/sprd_serial.c
> +++ b/drivers/tty/serial/sprd_serial.c
> @@ -1133,6 +1133,9 @@ static int sprd_clk_init(struct uart_port *uport)
>
>         clk_uart = devm_clk_get(uport->dev, "uart");
>         if (IS_ERR(clk_uart)) {
> +               if (PTR_ERR(clk_uart) == -EPROBE_DEFER)
> +                       return -EPROBE_DEFER;
> +

You are making this clock mandatory, sprd_serial driver could work as
serial ports for logs output without this "uart" clock.

>                 dev_warn(uport->dev, "uart%d can't get uart clock\n",
>                          uport->line);
>                 clk_uart = NULL;
> @@ -1140,6 +1143,9 @@ static int sprd_clk_init(struct uart_port *uport)
>
>         clk_parent = devm_clk_get(uport->dev, "source");
>         if (IS_ERR(clk_parent)) {
> +               if (PTR_ERR(clk_parent) == -EPROBE_DEFER)
> +                       return -EPROBE_DEFER;
> +
>                 dev_warn(uport->dev, "uart%d can't get source clock\n",
>                          uport->line);
>                 clk_parent = NULL;
> --
> 2.34.1
>
