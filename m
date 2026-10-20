Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792485396;
	b=rvfj4COpDvcZFFfyS8H54MenfJE9wkKAto9fTp+GWGfwpT11L20TUyluSOSlrFnbSIEu
	 zKyBr/WQi6+uOvTTZE/wWeVKvVtyK3QorA9HpLMFALo9M8NAI8lUBymvWemZgPrQJ5I8f
	 PAbetnvjB7MzLnLvX7VkiO1esI++C4xyM9iirDNf4lrFiQ2R+1aJVAlQBzghd73vmeIBd
	 pOYeqqGsKliu93O5QDZTUNl21Dqfs6xtDtxV4+TQnC3sKrahsW0ipf+ivhHlc+G+ABLEa
	 5nJbN8+qySycH/pLgGbI6S/dwTx1goD6HFtc/LT/xvPvi98B6/wyA4jakgmkWJomL1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792485396;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=22y+5juPWrN/VuUPPX8ILqIV9NFhSiiV1mnmbGgPo50=;
	b=n3bIjIdneBlcg/wRhdIIT7SGCoR9fy4YomKgZOfi5X19Y/J3grWNFud78Ed1u06j+dcu
	 193Jd1fhbSIOavQgaNoxBYi+LUMd2zgGhGiyZNGBxBrkbIgzxogQCP9UvjPu6m2PmgC2M
	 WIoyUhlWPmFkTi/zH9HVkyY0UG3lpUAaPteRItEpDDlv8E3bk1UXLNIiR7u72/7D3XXgC
	 TR8UY3p40LRcqs4GPQ77DcexlFyR0TvtaxAOSjTAcvbOwR40ILorNmegSV1ze+TR6qbK0
	 vKKt8rtj3CC9mY19bWHZYlPu2RVfsDqwBlLH9F8dcVyW7uvYblQeOKqAhKYXKAuEJgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.217.50
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9144606A31B
	for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2026 08:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9144606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7c33cc572e6so343996137.1
        for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2026 01:36:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792485395; x=1793090195;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=22y+5juPWrN/VuUPPX8ILqIV9NFhSiiV1mnmbGgPo50=;
        b=eu+dNsWKJWD9gs0qrTKJhDsTwb1AZpUGc5AUw9vDPjU8IioLAh1sXuKCFuaUe6ARZR
         gnsBA6ATKQCPkMYrXC5aqupRN7gj06CmGCEhGqL0gDj9d61CU/f1ie3tUJUOPmqq3t6n
         s3nYPZOiCKSXjNw93YnbAVwkmOrhchrlPA0jTorMIDi3cHg3o2VDEDz6B4zx4RtpiIJ2
         ktQB/F98NxBOgAXPq9dQyYtQFBbxsb35sMhxyLmh3Habw+ALDJKJbBPXPpl6kgYHMK+L
         jsIMqezIXhqGWbxANxYOH6kUWt+QY3v/UbRMK30Sm4OGy7NuKhCPlXmKuc8lSv4OI2/J
         X52w==
X-Forwarded-Encrypted: i=1; AKwUvBxjnLXoq2daxYX5789fgPHGAguHE8eex+HZfDmvme8+6UTtQQi9fHmXomSYNA2dTB9rIDo6ztgLcsMmye8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5kFEids5nIVRN/Fa1gqiHEqG2LHy2X+X091bCcXYxaEGcL3zK
	HEdVYdU88j0PJz1tHGxxyBAs50Vhrxc2wKaTmjUKO6pa/i9QA1w2JUXOTVchBGDX69k=
X-Gm-Gg: AYBFou0fFbUEh5qHYSHWRcHvyBufvmMbgW7RrfnpL+kOfzWKs6/wnmIG8Quuy9ovSwh
	QAKk1PFdWHNTgHDYI15ZqPbdvU7HOVs3ioZ4lOBW4iSAfSxvrH4RLpbX648TVDSN3g0/OOCd4I1
	jFFjIBy1RHrlGoHtijkpnEDqazbRuHKEzjvXxmLY2sf+Xi+lv+Ll/fPXPnYDsJz+nGOqJALfVXR
	keogYdH2Ox7SNc+7l/h7hAy5jP03jWYJaBXDSaeBwL1RgTqdBtgdVunYYCORdWD/usCgmrtb5FJ
	D2S/CPq4AmO9k9U0ZmAgepVHJ4lVsVFwWc1cj2YZWdAgXukGZ5TIi6OZRIfm5Mm6JYH6eqWZwea
	8FBDCDFYK6ZSvl8obM+wo1JBS5LwyFYmV7dpTp9OLegNYoZNmOM87EzpefRY0iqqhGDo/nk37nR
	a5BhECdWuCXT8ZxhCLm28eRprtNFkxo+vNUzmk+T+WNaPyFJX17w+LADO58ra+oCsuAn9ub4vxj
	esvtOf0VhfDG0ABG+d4rnc/EEVrxFBrLwTKoLY/Csl3ygqQkFo=
X-Received: by 2002:a67:f581:0:b0:7cc:373d:8f9d with SMTP id ada2fe7eead31-7cc7bcda30bmr272346137.31.1792485394746;
        Tue, 20 Oct 2026 01:36:34 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-990bb25e8c8sm2413251241.2.2026.10.20.01.36.32
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 01:36:33 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5eadea8f0edso187780e0c.1
        for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2026 01:36:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw37LugFIP6/Fi9iBypjHeup6RtG2fybIXJi/zzTPvZNhACiYezN/zLLf1cOljk8RuBiZLAVeJKOJPC4cY=@vger.kernel.org
X-Received: by 2002:a05:6122:8019:20b0:5ea:a09b:39cc with SMTP id
 71dfb90a1353d-5eadccde839mr253998e0c.19.1792485392657; Tue, 20 Oct 2026
 01:36:32 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019170139.473808-1-biju.das.jz@bp.renesas.com> <20261019170139.473808-4-biju.das.jz@bp.renesas.com>
In-Reply-To: <20261019170139.473808-4-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Oct 2026 10:36:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVJAYL7L8q0ShxF8vJ-nhmyCiTgTNLJxLv9wLcshLfLGQ@mail.gmail.com>
X-Gm-Features: AclHuK-f5PxeHKGz-JsdxG5WRVgKsmMVDA3pua2BFWop-pdvR8thY-1maktQwAQ
Message-ID: <CAMuHMdVJAYL7L8q0ShxF8vJ-nhmyCiTgTNLJxLv9wLcshLfLGQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] serial: sh-sci: Skip TDxE status clear for PORT_SCI
To: Biju <biju.das.au@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Au Dang <au.dang.jx@renesas.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Frank Li <Frank.Li@nxp.com>, 
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Mon, 19 Oct 2026 at 19:01, Biju <biju.das.au@gmail.com> wrote:
> From: Au Dang <au.dang.jx@renesas.com>
>
> On PORT_SCI, the TDxE (Transmit Data Empty) flag in SCxSR is cleared
> automatically by hardware when data is written to TDR. Clearing it
> again from software via clear_SCxSR() generates a spurious TXI
> interrupt, which causes the last character to be transmitted twice.
>
> Skip the clear_SCxSR() call for PORT_SCI in sci_transmit_chars() and
> sci_poll_put_char(), as the hardware already handles it after each TDR
> write.
>
> Signed-off-by: Au Dang <au.dang.jx@renesas.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -913,7 +913,8 @@ static void sci_poll_put_char(struct uart_port *port, unsigned char c)
>         } while (!(status & SCxSR_TDxE(port)));
>
>         sci_serial_out(port, SCxTDR, c);
> -       s->ops->clear_SCxSR(port, SCxSR_TDxE_CLEAR(port) & ~SCxSR_TEND(port));
> +       if (s->type != PORT_SCI)
> +               s->ops->clear_SCxSR(port, SCxSR_TDxE_CLEAR(port) & ~SCxSR_TEND(port));

Is this issue present on both classic SCI and RZ RSCI?
s->ops->clear_SCxSR() points to either sci_clear_SCxSR() or
rsci_clear_CFC(). The former already has an internal check for
PORT_SCI, the latter has not. So probably it should be handled there.

>  }
>  #endif /* CONFIG_CONSOLE_POLL || CONFIG_SERIAL_SH_SCI_CONSOLE ||
>           CONFIG_SERIAL_SH_SCI_EARLYCON */
> @@ -1049,7 +1050,8 @@ static void sci_transmit_chars(struct uart_port *port)
>                 port->icount.tx++;
>         } while (--count > 0);
>
> -       s->ops->clear_SCxSR(port, SCxSR_TDxE_CLEAR(port));
> +       if (s->type != PORT_SCI)
> +               s->ops->clear_SCxSR(port, SCxSR_TDxE_CLEAR(port));
>
>         if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>                 uart_write_wakeup(port);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
