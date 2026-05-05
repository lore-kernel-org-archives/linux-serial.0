Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1027B32AAB2
	for <linux-serial@vger.kernel.org>; Tue,  5 May 2026 09:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777973188; cv=pass; b=q71GBhXgy0Y2mTlL4gGaZjcfcA6VT2rcKCsPOJiuZlqD2hzEqwvc7MJNxFyfHqibZbWKsD3ninJ9UuCAxSicXoIqN/DUrLuP5P7ccslbl9Q5ErTrrDQJiGBsq6GHuNHLwOoEJGy2f3RQWDz5oDSFuRo5j1vqKOTVOoUlCM2Egic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777973188; c=relaxed/simple;
	bh=oKvuQqtazDbRTJXuUL+tCRnhzB7TIToY/hObCiiVqsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=neg1G/1ng9UUDlsRc1Wp4LM2x55geMItGH8+7gRZDtcauaVRZ29yzvaTiiCkNdl1Keev+LZ4+Ct7dOaTS87YYu+ffdTH2H9X/7kYUoK6dyOJsRoKr4HvSWY2b9eP+DfFFet/fKXEDphE+WudR0SNYWxuzLi71vXla+VWxbwM4W8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a41kh09x; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a41kh09x"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bc2301be8ecso308116566b.3
        for <linux-serial@vger.kernel.org>; Tue, 05 May 2026 02:26:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777973185; cv=none;
        d=google.com; s=arc-20240605;
        b=XuOPYz4e3eq5EhrE5i/x9k3etEpZDc848RlNjnycx4hyXKLoeRSo8c6qsFUjkgXGz8
         WF0L0sOHwa4m04PHkqEne4dB4VVItzCvzsTMtbsKtUTtXbcgnMywOFQoKjtQu4RY/l04
         CwWC0qy7hxEmqwxyLzkKCSXwSN3uaGMqtJ0pVUVIBpbrYt+MSVa6aHdvy/bvfDtoND7R
         Mv22teipod5UBH+B1Q0mxEg6VTphBj0YVSr07zdHCGMRHPP7v3spO6TIDPKg64FSTrLp
         LMLwoMM6lCHHCvzuJ4CmHq81sbbfzGE3z0Zfmlg7sfaCkTjy5Q0DyisELM9TnOpn+keV
         HBYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U/+L7MzGj2JQfw4DqE8x8wMQfDyHHIzG0d1VTw/f5aw=;
        fh=6JOQGsarofeiYALLypa5ZlFzgT7FDBS+vfAcV4VGZ1k=;
        b=N4g6sspDwbdwPRf9MNfU6ry4NKyxY/v545zO/RD8jF4fP7DjBmFcOTbb7lEhafqMCj
         JyooTEkUgiqL+Kl1Y9+28pgSNt9rbzd+kgTYAquGk0GZ0U+cH7WsCt63Ivj+KeZrikoZ
         UAEA5wgesEHkIA69Hte4qedV0e3Kpd+p8AxXt6j8iQbs/+BR5uMh5wkx72OW1Lmt6rbi
         DfzMw2vRg7qdUCJlMbTevRH2l+GzQlonq/UhPW89mIcTPiHbagED+LIPIoYFABmCk9Un
         yAmkstKc6Z16Jwt3wH2ol+mXpolpULNLSk71cJg1MinWY7M/LDGPIhv0XkCgdI3IbOJD
         9HSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777973185; x=1778577985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/+L7MzGj2JQfw4DqE8x8wMQfDyHHIzG0d1VTw/f5aw=;
        b=a41kh09x5yZI+HY/lPoX3tR1sV82+yO1XDEi7byvdAay34/BDYd1IqwRZKHgHdMOgi
         8b/ZAqoxjn+fkRVTpVMZxszwPLqEXRsS+gEQvgQ1DDWLFWZ07coZFyH9NeilRAwKin/A
         YEqGw6W/6TTlChdHE2Keh1tWwojXH6cUDOjmt0F0SG/Rin6NYIELtQTyAxE+arIkLLvS
         xHWH0Tbz9bnNfNqwLByEbUwKenxezP2NTKOj9R+r6jJ8HORxpkX9YrNI1bNmcs9O0tnp
         uXIb49mazoZLV1B39mo8xVcGT7AHfvkG4KvbINfk3GyK/ZT9GyIoLl7HgJjqB9TIXg/Y
         kHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777973185; x=1778577985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U/+L7MzGj2JQfw4DqE8x8wMQfDyHHIzG0d1VTw/f5aw=;
        b=rKKeipjVYxIfkK2HwjzLVd+GthcGfXOR+mEyXqhtAn6RdAdsE/GB5f/tkIYGHoZNkp
         4LhOIGAhyWEsEDntYPR57KlVBhuBVS6bZa6OvcflHn9aGm4Txp6v583mmroaPbUo+uUa
         U5hLoTL8vVdfFY1K+XHnxOL7ZkMv14w4zgzQoVJ1S65Zdn+9/wfquMzwdpchNeAvtoP1
         979hdvNdCUzB/rD8g1sK3rlQJYeFr5nOj2maWkyWIGR/UdqahNqO4LdCoQHS+W4+1VRT
         Hrj3gQAs2L4oqbPnJjKF5HnLfAuN7Z8puFpi++Rt3M3Bjx/uDD/3a0BoMWQbzbS/U/3G
         3uxg==
X-Forwarded-Encrypted: i=1; AFNElJ9aJwO+eS6WVOdAuYswmO8acVd6+gBshntjGDTcopDN1EKM/f30sICOdrmXgQ06sW9UBb01c7o/QxTvsGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/BOxo4vOsVNKYY3G6OIambs/+NOkiDbR3c6080r/atG1L8xAK
	Ud5k3iZ6OiigOj8SpnKQlmVWDfN8TkcQNG6zEA7Dpiu8OE+BSJcxUL1qJYZiIVxHKQDpDQA5YFU
	1kqBarz2cmCMGluCgEUJTTbSckUiA2fk=
X-Gm-Gg: AeBDieuLThFuczkiPPmKpa3KdD1oM7p0KzX+jV7b++FJOGoRTCgUIEYmAsaxfJMqReB
	ShWKXOShXRtJ8fKiUYYjF22VmncJ9WdgaXhTl6a6zVyN19jICZKKQ6iJmFpD1mg/rE3j4cUOhHI
	a0HEs9BvXlDP6PMJ70N0sKWSJ9qqcmVAVJFh+/8IGu5HeRo8oUk+wMw8WBZBy011cxa8YBqyDTR
	miwz3GKmvw6ChSvcv7eX+ZEgfjE74cCfi6ifdxvpXI7JZb2ZmaXLCjg1G+SgCbirYkARNBzT7j1
	MVXpM4kug9rcVkO9+QjPGOE8u+323wnijOQ8HvZ4O6WLYBumS5WOtec+uI0qXHtCotcOa3K3hdE
	y2KA3Hc85uTlHeB6A6Gh5OP+yqLTs
X-Received: by 2002:a17:907:9606:b0:bbe:3f15:f480 with SMTP id
 a640c23a62f3a-bc411d2a156mr120149066b.39.1777973184980; Tue, 05 May 2026
 02:26:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504084900.22380-1-crescentcy.hsieh@moxa.com> <20260504084900.22380-14-crescentcy.hsieh@moxa.com>
In-Reply-To: <20260504084900.22380-14-crescentcy.hsieh@moxa.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 5 May 2026 12:25:47 +0300
X-Gm-Features: AVHnY4LckVQWZqPuq4BJt-1DjmreHqKKqco8etvq84TYgaS_EJ6MyXU0AgWYtnQ
Message-ID: <CAHp75VevDXTtRnq=d6ODVt9Xjw6ZZjdRX78zWRTFiFtuOrwkDw@mail.gmail.com>
Subject: Re: [PATCH 13/15] serial: 8250_mxpcie: add break support for RS485
 using MUEx50 features
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, fangpingfp.cheng@moxa.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 11:51=E2=80=AFAM Crescent Hsieh
<crescentcy.hsieh@moxa.com> wrote:
>
> On MUEx50, break signaling under RS485 requires a driver-specific
> sequence and cannot be handled correctly by the generic 8250 break
> implementation alone.
>
> Implement a mxpcie break_ctl callback that performs MUEx50-specific
> break handling when RS485 is enabled and fall back to the default 8250
> break handling for other modes.

...

> +       uart_port_lock_irqsave(port, &flags);

guard()() ?

> +
> +       if (break_state =3D=3D -1) {

> +               serial_out(up, UART_LCR, up->lcr | UART_LCR_DLAB);
> +               serial_out(up, UART_DLL, 0);
> +               serial_out(up, UART_DLM, 0);
> +               serial_out(up, UART_LCR, up->lcr);

Don't we have a helper doing this?
serial_dl_write()

> +               serial_out(up, MOXA_PUART_TX_FIFO_MEM, tx_byte);
> +
> +               sfr =3D serial_in(up, MOXA_PUART_SFR);
> +               serial_out(up, MOXA_PUART_SFR, sfr | MOXA_PUART_SFR_FORCE=
_TX);
> +
> +               up->lcr |=3D UART_LCR_SBC;
> +               serial_out(up, UART_LCR, up->lcr);
> +       } else {
> +               up->lcr &=3D ~UART_LCR_SBC;
> +               serial_out(up, UART_LCR, up->lcr);
> +
> +               sfr =3D serial_in(up, MOXA_PUART_SFR);
> +               serial_out(up, MOXA_PUART_SFR, sfr &=3D ~MOXA_PUART_SFR_F=
ORCE_TX);
> +
> +               serial_out(up, UART_FCR, UART_FCR_CLEAR_XMIT);
> +
> +               baud =3D tty_get_baud_rate(tty);
> +               quot =3D uart_get_divisor(port, baud);
> +               serial8250_do_set_divisor(port, baud, quot);
> +               serial_out(up, UART_LCR, up->lcr);
> +       }
> +       uart_port_unlock_irqrestore(port, flags);

--=20
With Best Regards,
Andy Shevchenko
