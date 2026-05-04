Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899303DEFFF
	for <linux-serial@vger.kernel.org>; Mon,  4 May 2026 15:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777907953; cv=pass; b=tcFj3u8i/9KhyWXtlOX1tqC9ZadKQYBMULDTzafUY0T0oL7ZLGHS/0ssEAJ9j3iVfC1eZD16hTMRy4hEO3VWoO4pOKo/LL3xrbPHqAMP/hU0Z/87phGRZANzLgSEP0TwqlV4+LGanJAo7kCsp0qEgnmXOxWNGW1oHvE7iH9N2wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777907953; c=relaxed/simple;
	bh=ZMbHpig7HFhIFNfY2C37/rHi/H14u42MxiWPKpv0Eyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8i5dtxVPjIr/L4AzBw9opAYbdxiT9tx8c3iYjhzOSRxrtgteFuliwpND1LaUcipjPhJERjlWa+uwG6pwvkkOlsKWCh11Y8kcNLGjeiYR358gyCjOORgppgJN896LMkz2NargS924kfQfOP57zKj8WtyDRG6vOFeGM21if11Vdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMuNuHC0; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMuNuHC0"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ba699316b42so596696666b.3
        for <linux-serial@vger.kernel.org>; Mon, 04 May 2026 08:19:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777907951; cv=none;
        d=google.com; s=arc-20240605;
        b=X3pNIVCtYEphNtDeTwH32vRr56Z6ARJ8/wov+xhukKvCz/ieYuwPpEyjmnG9M9xiQB
         IXryHcGUQ3OJ3Of3FO0DKjD0HBgQ/OaFMab4OE6PGPgBtaTZf93RR0atTFFy+w5LSHfu
         H8HNtilRgKkK/1aEOWvt7/X0hjzRrXdfVCgEiNqTGma+iegi1bZeAqcl7d38kqRm3Jzn
         689k2C0vZxrGTnZ7e15XFoxpatRz7tVp3cZl7xqYYpExlL0Ln+h5mcfEmtReK+IA9kTE
         gLxchrdiTfdqTkMssNT+QKwocUdAstM65uz7MXnbZfipmTZsD+lTtYBb4rpdSvHfzEaK
         B3SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sR6s6xje1I8uKwoMEEkBMIAQrYnQftw10FZMdgwBaCY=;
        fh=DrCbyMMiI7QLpKZzY+MyL8KE1tyMqeIsZEm7QlFda4Y=;
        b=eNx1D9r7u+3l9nrxdcntEufvNSW8CzMDo6R9EUo7wZKEghOZlmZX8cxPZ18l5XIqUF
         mepdqTyOgW5k/rXZR75h3u87Tzq/741P6w70aj3Bh6dfPFjrqXUb3eiRWS40wKRLaeb+
         HJanXyAXq8UR3XSuofRnZdndMAHZPbs8/oc7lly8Fdmi0GahD/HhTwtK0vXfN97mG10Y
         rUeue1Wn7x5x/ajD6DBUve8fqNtghohYsxnLOzLb1qHrcuh0FSCXKavmS4FbRhJcfXdc
         RrGw1ehrAmk25eT7LB/oWBmYBWRFaaQk9rzSX+QncEVcBQ0Mo+HB1DXrmcGWAtF+WAeX
         IPyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777907951; x=1778512751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sR6s6xje1I8uKwoMEEkBMIAQrYnQftw10FZMdgwBaCY=;
        b=SMuNuHC0IecLovydhzr3zDYUlJBei/Mm0JOzBvKLWfiAZGHuYZxdsfBXiEXmP92PHv
         Kw0xcis9DbSvEwU9e423lvxuX5o+0/tyb8OV/1DA9GP5l7igutLbVWQSw3ogWPrZBhep
         Nym+H45DM1dVTbOx5v45GnUeNuvWnC99E8MRt4uRKwkuSRhUxInazVGjtq0wQhmJAjL1
         ch1bYBqsk9l3S9Gl3r3eMmX2SogOdfySw+vz3+p1GBtwMB00PAlCflLEKU/LI4rQGWzE
         AtEcKF547Po/c7RUh7WOKEjI5iXSpYwoKld4BL0FbgwMUrxFH5beneod5p7XwuxN9dkH
         1iZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777907951; x=1778512751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sR6s6xje1I8uKwoMEEkBMIAQrYnQftw10FZMdgwBaCY=;
        b=Y15qhWMH/IZDyx4kShNSbcR5x22boJU+vuEmkcOmL/PNHAf2x+smHxkM/RATsiPafa
         i8bmRsWvJjpkSpuhv7Ig7CmJvPErV/Djk99x2aCGgtvlFo3VlQ4+iY0/kggUj23rr4s6
         CabFTZK1L1S0WAJleQUfcL6P+zo55u53/v/6hpQN2hgJoxYYF42lcEiOWp0n0wAjCtR3
         pxR4gbIXni6gre0hnWtxnl+Cpaaql3PqJs1KKbdORJxMutk6QFlbR0EEIuNYSHh4DIUx
         WdJq7nZ9ZTp922py8W1g3A3KqTbdKbutjE6oHSQ56qANtwiJjTk97/BlAy3Zz/7jFJzL
         z6yA==
X-Forwarded-Encrypted: i=1; AFNElJ/TrbOb7G+SwYoAFeQ23HqniqU/UO1ZU37vaYGZZarxqSenTqz57YPQR3vZaq44zVWsr8Wc9PV8WjgB7ic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx46vDEZ/b3UdnsYKYGtAMZFrArxxwwl/V1Fmdt6f5/EFEgAByi
	7r0rSueNGIbwTAtDyiDsllgq5e38rPTnudysMgBgrPA7HTCdLa/GBVGKn9+2sk7UyoYrHud4Y3S
	d2LvHRW3a9oAlvf8TRM6/PtX5MAYrmCs=
X-Gm-Gg: AeBDietn1+YFfIBaczaKqnpspIXZXrRE25I2PKmLoPxQuJ7B3k7U/WFgFx9JcqxP9WL
	XdMRuW7rQUe3h5mG45pR4Nww8wTwfdSD99EKXH/K54c2oWCh/WBRgG/yt+N0TP85X8o+KuvySXN
	tIdloLMLxejHTi4BLgiKMczrZjvjOpnix6l9VtBizaEsb+ioEYbwhKjIRYOfH3T6XEgTLcqEyAM
	CSN+IWlC8+hXJeV2ZYcLj0y9gfGD7S/n8jB4bTqM8o/73RlMexTi/8tNo8JTOnwd1QKsru7hFC6
	hsN4M3RS3hiBAG0D5/PDEsXyzVKy37XjHEXx+xwGM8jaeWMdU9sQ5ycsDPD/t8RxoXJTfTqIVOC
	9gAB0RcQ4FXyhf96JKg==
X-Received: by 2002:a17:906:6a07:b0:bb8:b593:edba with SMTP id
 a640c23a62f3a-bbffbc69271mr544293966b.38.1777907950542; Mon, 04 May 2026
 08:19:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504084900.22380-1-crescentcy.hsieh@moxa.com> <20260504084900.22380-4-crescentcy.hsieh@moxa.com>
In-Reply-To: <20260504084900.22380-4-crescentcy.hsieh@moxa.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 4 May 2026 18:18:33 +0300
X-Gm-Features: AVHnY4JbnauNXZ7xFtJMmaJeyamgc09kMeUZKF36tDX_Nrf9a2djpsbLe8Ldkfg
Message-ID: <CAHp75Ve1u+kE+Xky6QRwgsWXoG4sU8ekNPVEXhieROi4vUhqzw@mail.gmail.com>
Subject: Re: [PATCH 03/15] serial: 8250_mxpcie: enable enhanced mode and
 program FIFO trigger levels
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, fangpingfp.cheng@moxa.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 11:49=E2=80=AFAM Crescent Hsieh
<crescentcy.hsieh@moxa.com> wrote:
>
> The MUEx50 UART provides an enhanced register set and programmable FIFO
> trigger levels for RX, TX, and flow control.
>
> Enable enhanced mode during port startup and program the MUEx50 FIFO
> trigger registers according to the configured port settings. Clear the
> programmed state again during shutdown to restore the default UART
> configuration.

...

> +static int mxpcie8250_startup(struct uart_port *port)
> +{
> +       struct uart_8250_port *up =3D up_to_u8250p(port);
> +       unsigned int i;
> +       int ret;
> +
> +       ret =3D serial8250_do_startup(port);
> +       if (ret)
> +               return ret;

This needs a good comment explaining the retry logic. Why do we even need t=
his?

> +       for (i =3D 0; i < 5; ++i)

for (unsigned int i ...)

> +               serial_out(up, UART_FCR, UART_FCR_CLEAR_RCVR | UART_FCR_C=
LEAR_XMIT);
> +
> +       serial_out(up, MOXA_PUART_EFR, MOXA_PUART_EFR_ENHANCED);
> +       serial_out(up, MOXA_PUART_SFR, MOXA_PUART_SFR_950);
> +
> +       serial_out(up, MOXA_PUART_TTL, 0);
> +       serial_out(up, MOXA_PUART_RTL, 96);
> +       serial_out(up, MOXA_PUART_FCL, 16);
> +       serial_out(up, MOXA_PUART_FCH, 110);
> +
> +       return 0;
> +}

--=20
With Best Regards,
Andy Shevchenko
