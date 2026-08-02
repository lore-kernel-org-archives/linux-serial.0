Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27C41F4181
	for <linux-serial@vger.kernel.org>; Sun,  2 Aug 2026 09:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785661875; cv=pass; b=hZEGLR7Gt0sUJWE1KeKo/wROP4H4IdiJivzqZ6ocE7UGk1dJpJjZcaSx2+vCefLWrnUjP2Vg39uGMwUZ82IXA+V3sNZkaflUm4v7iJp6DDWJ38l+xRaL3z+Hp1L9WgZJqwHxqq6G3yCc4/wy/VXa3t7xesYF+jQCNNlpet9rWlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785661875; c=relaxed/simple;
	bh=JGhue88wFshhbSUJGJ0KNYwoAdybRXWtV14ZppjwrDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B48mWzlv+/JXP2stLH9AiWIAXh8ExVhWwmPGdx/qL4Nn1CBMGS7vlKm3VrjVeb/5ZaiApG+VgCEgJnXDD1Eu7UmYce1UTzkgT/cJwvokQLpg2GEtyq2nk+Zv4pCveO7CJQk9dGcDodxRcxDiJXH09KVHdt4n9g60N41KhYrQem8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=og/QRam2; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="og/QRam2"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a082b3671fso3472142a12.3
        for <linux-serial@vger.kernel.org>; Sun, 02 Aug 2026 02:11:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785661872; cv=none;
        d=google.com; s=arc-20260327;
        b=JhUlmFsZVcFVfImI1/YLveu4KTtHxDUk8IFBp7NTsSYt0mTKqgUUIgJoiPholwjWcw
         F3NeAdgKGmM+BskA4p49H9b75v5594gNyek/80B3B74w4fkOq92U22WxTfKHGJhlSx6l
         tL606b2R0Q0K1D6/aUo0ogEZG0CwsBUr+Zm/8AblHMhCadJbI8f88liyuNxsMwL2u06w
         6RCj7NLP5iiE//6dYueI1m4RW97XsR0p56obCURfK01hq/+KJBstpKHqpt/2CRDtEANT
         ndOQ10900dtN4HuT+d67QnBFhw8Cskx1koG08PRmWDd7PdVy0ZXYL7gg2un/9c9+phi7
         /0hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hTtPjwcPKQDnspaH2ogA8TjpaLj2kEIPaVkl7YIYj7A=;
        fh=nCwXrnXCgJfu2gNk3rqprLVsqVjmj8dVcZdU1RngRWM=;
        b=BThHbFjNn+QZNnoxxa6FocNKLzRrLq1useQFT42YWOS2oHYbZSKFSYFKaDsxW0pxK5
         MctWsaVybQaTtEB+Fgbzwc0I74WPx7G1s7x+zKgej3hT2N8MVAhwHAye+d/j3+rJX0i/
         uyHJ8DOgsftdH0cBtkK/g+a83WBfmVrSSoXVVKc1o5zp2mWDyz+qSDhoEi4WM84agTEY
         WGpmuysPgrQg5z6M7HAx0tWqxM80tqqBMp7vYv2zjmB+1BkZ/wgDUdZtiAkYZmlZ5dXT
         jTFXWF92jAb6oR7lUUfaNo76azJBocQuHOGuRAwW8W//t+HQTjLi2HxFIhOOZd/IdRZo
         K/RQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785661872; x=1786266672; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hTtPjwcPKQDnspaH2ogA8TjpaLj2kEIPaVkl7YIYj7A=;
        b=og/QRam2pHWeIP8k5uHkTPSmwmAVzIjS1xQgvhMiEcEasGm6eBwYFvRji+1m1a73sM
         tletexMkKl5av922itKTmdfhTCOFsWJOuvohamUDEWB+JY1oe9Qj0vY72nbu13ipF6BP
         QKA7lkUfVj/Sa52QzFRgXBp39kf0jbrW7uL/EeN9Iiiq2FQEjrb+nOI9ACwv3E5XqJvX
         9IIp7IdSRZSHzcIqxRxb/WMk7t6gqlh5BnQsYAPpBICfxy5jljb7oyovrSEdCEP4bTN4
         xgSS6BLcrT36JAAEjCWzTPtObHvo8pepoBUp9hG7v9qIdBAMY9gzxMZZ3trIP52An6F3
         1LnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785661872; x=1786266672;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hTtPjwcPKQDnspaH2ogA8TjpaLj2kEIPaVkl7YIYj7A=;
        b=Z7+b9EAy0Jb4Jx42P4u6CbeiP/9jVsK/sAy+GN24oqngB8ytq1GSq/HOnbXWVsh3Nc
         dY/UY6NKeCwuyKNrXo2Ie/ovE3Gopt6qhb/raXjDrjuKyeo+WS2B3XKUHgcf4+BeVMr3
         b+oW4on6YrBgc7EKTJFF7z2NBADbVd3qIRVYCTHZfVdx0yxkxp9NtnkkwQZD246xeBRh
         +USc0ArVUcx5Q4US23yQdzZA3vDO1i8Up/19fUCJAD94t+RosnZnN0Byr+miG9KmYMkN
         QOPiHFjOykECbEqBaBZPEo9jyVzgGNV3YuYg70Yjqdgl79H8l4KwyJZetKOXe+icHOKo
         1djg==
X-Forwarded-Encrypted: i=1; AHgh+RojZtZKoG5sj9rRYWQFSpLo1ILo2Ifm2DCl0jLxKmZp1t/+E0nYhIG/gqV7+QZf9YlBRPqQuJ/Mm8/Q5Q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmqXkd5b4jVKVi0/eciwntL57Vp8P8CPQd4k+emAuMLyHXjhx0
	XiYA/Z5qi6mGHt46i4T6daLkOY9FlcArrizHJRrd4rap7EBQIBsGyz0E75n6/EKDHeqMKOdQo8L
	ImG9FcwWlF7n7QqN6zVgt4VImUHgSXuc=
X-Gm-Gg: AR+sD121s4ElccyFtELR0lDByisHkcUIHksDfggeBkgRYLK/VVtLXJcP5YaTSob/VJv
	beqT67q/gfFN3bSuPQbDniBgDpB0msOujXXwROsKBNQT57XmUIT8mG1BB98qq5Dz6tqgqxRk4+N
	II8sR/vfe14ns80kOBzyF00/6n/E4voadfy2CKgErHz5z2Hu1bGLh/shiwIRHsI5iGlXq262Mf/
	GUj5MQSMyISzUlP8Rf/X2C+nv6ftpcS0AzHYWXwCGeA9T3DEZoyQpvL3udzM4+BS2oi0OE5i33F
	TiyQusz/WDMPoOayJCpFrzV6/Wwu/8Tvqh1NjdX4yZXrweWzNC4mnKdXeB5FrDDbLU6JHb4sylJ
	lktpDsuzkpK0Zi9LovpxSxbovlbWcva7h01/KF8uuD8QllJJyhSKAhGuXcgj+IUxI0H6xk08pI5
	I4CG6zTTSbj4ttcXe+dEITTsxf7cu+R4R/uRCoXe7lcEjP+1SA/nUZDmJFy+CMBYg=
X-Received: by 2002:a17:907:6d29:b0:c16:3187:997e with SMTP id
 a640c23a62f3a-c1fe7eeb9d1mr425746666b.7.1785661871893; Sun, 02 Aug 2026
 02:11:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731074820.735619-1-crescentcy.hsieh@moxa.com> <20260731074820.735619-9-crescentcy.hsieh@moxa.com>
In-Reply-To: <20260731074820.735619-9-crescentcy.hsieh@moxa.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 2 Aug 2026 12:10:35 +0300
X-Gm-Features: AUfX_mxA95CyTzPw7NMf6IyOVpKpq4kwExvfbH0sts4viKY6yDkIw7JUjIfEkQs
Message-ID: <CAHp75VdL71oE-E85fOLbz36bhs3EKg1iL_vtNP+TQzek5PNqnQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/14] serial: 8250_mxpcie: speed up TX using
 memory-mapped FIFO window
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	FangpingFP.Cheng@moxa.com, Epson.Chiang@moxa.com, EddieSY.Lin@moxa.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 10:49=E2=80=AFAM Crescent Hsieh
<crescentcy.hsieh@moxa.com> wrote:
>
> The MUEx50 UART provides a memory-mapped TX FIFO data window along with
> a TX FIFO level counter.
>
> Fill the TX FIFO in bulk via the MMIO FIFO window based on available
> FIFO space, using uart_port_tx_limited() for the common serial-core TX
> handling.

...

> +static void mxpcie8250_tx_chars(struct uart_8250_port *up)
> +{
> +       struct uart_port *port =3D &up->port;
> +       unsigned int offset =3D 0;
> +       unsigned char c;
> +
> +       uart_port_tx_limited(port, c, port->fifosize - serial_in(up, MOXA=
_PUART_TX_FIFO_CNT),
> +                            true,
> +                            serial_out(up, MOXA_PUART_TX_FIFO_MEM + offs=
et++, c),
> +                            ({}));
> +}

At least three randomly chosen drivers use the empty tx_done, perhaps
it's time to have a helper that embeds this ugly piece in it and hides
from the driver?

--=20
With Best Regards,
Andy Shevchenko
