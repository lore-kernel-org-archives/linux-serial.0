Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB341FBEA8
	for <linux-serial@vger.kernel.org>; Sun,  2 Aug 2026 09:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785661476; cv=pass; b=KMUL4xWc7F8HFjkwWSI3uQScCF7EoDDCAHeHm9dZ1qy3B8Cy9lm6Xt6Y7pd59+YqizCwdXZwPlJxy98G5xomTYR8qy1GoitaGFDIOKBTvDLawd3Ho+md6E836Jbtqkrvi8G3LPoslWMypR6sYu4jcX1JYAjJfh7juIyIbph1WVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785661476; c=relaxed/simple;
	bh=Gn2xj3d9AlRMhMUC1PDhaeXbOWjPTQjyJ568IVmZX+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T2u7HTlzKmRbTQ1BCy/z/K5ri/tmtbuP7aeP4ZfWzZJm64pH/vMQs0G+p863pw0vosdDTpOT5NuF0yKuZM+OAq/3PKRM3B7sqGHKQ9QpKnhcJ928hjaiBsMD5R2ziAvaRSuN6u1neY7AqRP5mRv1INNP95V5+2vvVBsK+1wjiRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=km4HctiW; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="km4HctiW"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-69fab5a852cso3527988a12.0
        for <linux-serial@vger.kernel.org>; Sun, 02 Aug 2026 02:04:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785661474; cv=none;
        d=google.com; s=arc-20260327;
        b=iBpOv7KoGaz95WGh5IUBESOfYZ00zm14+QskxpxaHhp67JP+3KzDMbi+WPyuPiyXIF
         PFZS8NuSrtbwQNFkiYzyUPknHlwVnyr1QxnDhgmUOkp6OmnQbY4BWAvNFL2hyg+GuQRE
         zteK1/BxiTBJnjIb0UiNs5br1tmx6O6iXyU8rJqRlO3lyNHcgYPpg+6PJP7jPZszMjuf
         AZCS2Hl2G2Celm7A1uffnUH/NbTOUW/vAnLJ24/TqyI4dx267t3UIr5p5e8ksJZQGJGJ
         xeqKmWBMiI1VnaYidPm7QZ0cbrU9Mr/gw5efJNv9GLScXGljMq5Mh8Nhcb1Cj8sk24dF
         EQ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vzxhqmTXSlBa7lZuDynUhEDpCduT97pUtgnLKrM4qro=;
        fh=hcoN6i2eYUsd4kXpKjr5zvVENMmGc/v3rz8IzfIvbOY=;
        b=MyelaOW3gOEg9v07HOXUGA/bXdOuPolV8Md0tV0cXA6vK9Q84k0njlP8b2AGL3FHUA
         EJ5FKgeKFA6r6wApYH6ft63ONC7G95/ewhv++27aOPjym4uufd6DWSJNGZDVx2N+tmhG
         6+XTUFOis/ONeqR7+NpDr+nzRS5VclXXr1Vb+JM+BkyIVgvGtgdgYYts0vOAWiTpLRL1
         01e+VC33P1UGvX+vLn8FAq0RGfrjZjSpdlfG3x7zXAx0gwrfMYzkNnCtjNX9lWndPTGE
         g/Na1UXvwHq0gQBwMAPMaYUrLMwc28xz9xCOxRvvG5Itx/W/VZ38PR8eewcxxrJJYwPS
         uv2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785661474; x=1786266274; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vzxhqmTXSlBa7lZuDynUhEDpCduT97pUtgnLKrM4qro=;
        b=km4HctiWssBTLZhYD1V0m9hx4uC94xnECywTEUXMUIufYXflyk0Ww9gSpJ9Lh7FCgo
         GyfW4te2u4Ge/vfHWHWTXUDxMZE9rLVNUd49OeA6MWOrIJjkIiuGPUa+K7mNWyLQd9G0
         nXDAyZpUT8da9pBdec2W/R371t11SJuo7PEAq5VGwuV15lyaX8CtHJ1Dj/ySJWaAPJXx
         TtFyCRZNnKD4xm2xpXR1vJAWOD+Xb/PEkRTW3O2Xk9ECiJdi3mFNwh3uXTWa55sOmuHD
         lWfbjkLQ+3lMA0x0QkHOAZ0K65lkv/lMiutCe4gHMfo9jMuYcGuu0oBhwp6yP7tl8mbt
         xssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785661474; x=1786266274;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vzxhqmTXSlBa7lZuDynUhEDpCduT97pUtgnLKrM4qro=;
        b=p9jU2WBbCW2to2LnSfaVJJfOIym9Sg7YOGeWFsEunPS5DNUdTrBUbbPTR2FtfSRXAM
         iXAXzYqipdq9KHQZyfuoNwK27F0esevvLL+TMXZmwanRAPPkmtsY4etFVcgz7nsAy1ZY
         GZ4jhnphtDM7s2N1ZxBGIM6Wrsp98xA8fu2M0ngXcEfiU18YU4mGADVJ+JRjt8SgX5vE
         fp/qEpBsIrLY+g7p0Zy4g0aLL1PrADY9/4TooKCW6KkrMwR1bgtsK10W/szl5EDZov8Z
         dXoklCSl7MQwuVYVaRjH/Lay3kwzh74ldteawADYDldZYaZTseA+DPdw2S5WRxO7/3Vv
         zmlA==
X-Forwarded-Encrypted: i=1; AHgh+RrFh09gcAf/JvUzMjyUojartAgvzG8obdz//AbOjZ6ryN30GS+S9FFmi7Hp1Mt3S+FaathkymHZo0Icqak=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBc2iCmvXmlw6A5GaktsSaXE+UQFVJqMkRDXTYXSLdHa8C2AfF
	NYpoO/6tCBHsKG15bgqNpzzcxbLLZ+pFIAF5oamohQ8L9UIvqa5ys+RY+WgpegbT1Q0Jh4xE8Lq
	4JGKseWRYpNiQvFEzoJ2qnLncKBAxQwF2LQXZ
X-Gm-Gg: AR+sD123ZaNoO/kLr+f3lpxoBuauMtVHrP0SNfB58PKybMdJVCHQ/vpOUtzgCZzmVnv
	6W5x9Mf9qNugfTwgGVUM4VR/y3beiPUoTgkfys3KytFflmJmphAluHC13YcFhryo7dfYFSRgezt
	PJbUf4UsoxJyBkt9maXIht1BV5gfTlwH5E010iicOwA/yaLRoGiOUzh5kXfQvB8XTzOdRqFl0+o
	mrRa/Yc/5qR6WD2sfFrmcKrQyyg56LIpQOH9s/UTJ9DYEIz+9I6Jb5paU1LqG3K0jGnTsVvyLeQ
	ue3qRqtf0b/EWi3el7k3IcZ51lG/fFc+BaSx9W/xY8SAPjeu/ZYJFnbrMthEXcSW0tMSruGjNiZ
	kOmzc7/j60n4e8M6h76yGgOMK7nzT0BOqoaWFPyOKHsXjsT+neZQYf0fmxRuG+wR+hswQ0iCSWg
	A9GfzzBID0XCVGcXAHe56q1Fli/ADV1N3zsYFgNPkBX5SJaFKAmAueLGfDXBToYC1qvYHWpLFdE
	TY=
X-Received: by 2002:a17:906:f91a:b0:c1c:4752:b5fb with SMTP id
 a640c23a62f3a-c1fe7f3e45bmr343546566b.27.1785661473667; Sun, 02 Aug 2026
 02:04:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731074820.735619-1-crescentcy.hsieh@moxa.com> <20260731074820.735619-8-crescentcy.hsieh@moxa.com>
In-Reply-To: <20260731074820.735619-8-crescentcy.hsieh@moxa.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 2 Aug 2026 12:03:56 +0300
X-Gm-Features: AUfX_mzTzhhGpzhZDyP-t2pAd7ShpkIuwMJ1uSsbeqOvTNHvclV8Z8sUl9xhYpw
Message-ID: <CAHp75VfSVSEbn95i=UKBdHZNNEFfK7LpqFc54it8EjVVijA7Kw@mail.gmail.com>
Subject: Re: [PATCH v5 07/14] serial: 8250_mxpcie: speed up RX using
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
> The MUEx50 UART provides a memory-mapped RX FIFO data window along with
> an RX FIFO byte counter.
>
> When no break or error conditions are present, read received data in
> bulk via the MMIO FIFO window and push it to the tty layer in one
> operation. Fall back to the generic 8250 RX path for break and error
> handling.

...

> +static void mxpcie8250_rx_chars(struct uart_8250_port *up)
> +{
> +       struct uart_port *port =3D &up->port;
> +       struct tty_port *tport =3D &port->state->port;
> +       unsigned int count;
> +       u8 *buf;
> +
> +       count =3D serial_in(up, MOXA_PUART_RX_FIFO_CNT);
> +       count =3D min(count, port->fifosize);

You want to include minmax.h for this.

> +       count =3D tty_prepare_flip_string(tport, &buf, count);
> +       if (!count)
> +               return;
> +
> +       for (unsigned int i =3D 0; i < count; ++i)

i++ should be sufficient.

> +               buf[i] =3D serial_in(up, MOXA_PUART_RX_FIFO_MEM + i);
> +
> +       port->icount.rx +=3D count;
> +       tty_flip_buffer_push(tport);
> +}

--=20
With Best Regards,
Andy Shevchenko
