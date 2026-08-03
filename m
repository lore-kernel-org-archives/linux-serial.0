Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E011037F00F
	for <linux-serial@vger.kernel.org>; Mon,  3 Aug 2026 07:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785742058; cv=pass; b=qnkS/OtRMcRatb931UgZ5S03dtXMipu7YMnG5OELe/qJfTiKY5UrWXQLfldWlRmJQ3scn3jtGkmApqhG6zkeV8GpilY44lYNKnpubOPCoVIyQjSrA/IPExGjPg8R4ypVe4uvDy5FlUe9vwTDYf3rosKpqBFnvFlLiu/8N4qDEOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785742058; c=relaxed/simple;
	bh=kXHYPMbqHhxZ2Bbg5ee9lOit3eJTvkjCVWut30bWrOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udoXWM0dhpBFA/wzFUM+MdqHJR+dxpdsKvXSQ6d2J2a6JYnw67wHdIwNy3DgqiiFHVq1ptbt+BUzRW8yl09S92VQEhGqE5VY2/RQcokMKryWKjg+QaFYdVNNsauoFn5fUJUFLcoDA60H+58kGRFGINubIBLhkM8H0uqyo0UjDIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QS8fHU0t; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QS8fHU0t"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c15e03c2763so572433966b.0
        for <linux-serial@vger.kernel.org>; Mon, 03 Aug 2026 00:27:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785742055; cv=none;
        d=google.com; s=arc-20260327;
        b=PSWHZo3GA0miEfMc8ksC9wKFSLs5reAbNXgEdPMkbCar9BFHHa4hnAUZ2bu5ACmBbq
         p27xdi3XR8V1gHY6xF7dP/icu2T0lpEpX9AYZeogr+bGfGwR74ynVTPi5JcGsYNlHYx2
         HcNV6jWRdbhhASZ3QweqVBDg0/PYEG7madyArip2rdCLaAQ1QfHjGH67unQm41K5yiZR
         w4ivF1QNSo+riGKwVjy+AnlncSRFVDvaT1yC5m4xwc2CooV7ZHKBzAkFnvpLj+y+pJRz
         bnHFj3LqzXENAsMFNZG9V0Y/AwVq1JbLDlXEEJFUhiLEVk+WOIABK+oQYaBqJu7AHwsD
         WX1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u8RsB0DfrasoaF+839/FtCWf9dC8Vqh/Xb0MjvE5i+I=;
        fh=VFK1gKv25ibgvQ3L2jTrOGnbL92OE860qkPBZdko9Mo=;
        b=UasnaKy+UjvUeoBuHP+bgB/5YPvN4ESH+jEbO6FGdA+FyfZ1r0Th1UR4jP9SC7hOII
         7wKOo7f8syPWg5fNqosTdlYlbbiy/KYJDEzdhoyCkiCOFZNOPoPIW3i2X4oGSEaw0QqG
         39bwE8KgziPkWqXHrw+FOSpx3ivNhoIlCj6aYIpuRp33r530AsiEJBTloREsExH/byQ/
         /5TNWcpssi2NRbfQRETdLvqJU4/r6jc890wRWTiLX4shILqqZno1EYzF95zKDsmSkm8C
         lhAZG7MVU+QBcd2emz9tVTPjm0nBrzpCgUCQlsYxHk4XLfHLJeE5F1fs+N8CVLOAWBmF
         nVQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785742055; x=1786346855; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u8RsB0DfrasoaF+839/FtCWf9dC8Vqh/Xb0MjvE5i+I=;
        b=QS8fHU0teZELsUhwnxyHrmbvs76JdrAPsHAY5lshfkD3C1zsT8gU2Y+pv4Fp0uFVOn
         zkn+r/M87m8tXiUIQq6U4XuSouPfyCzh9zTQ6diy+VydkvuCzWCC/LCJGkLH5YgcEL2Q
         /wDygZPzC5LLU2eP6QCskG51Y8vfWQZQzWDaGoY5EeO9y3zJivLOA60Ck1vZNRzmTfO6
         yTACYrkI0RDy7q7EKMoS77XTqlSt48vCedzvauMoL+yMO/OItWKyTY/2GDUFHGQwGPIM
         FFbIJaPj9+2i3GQMPSjc7NRXz7HXpLSDKb9KRBxr9uUVRME2Z5rFSuvDurDJiaxwI/US
         HqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785742055; x=1786346855;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u8RsB0DfrasoaF+839/FtCWf9dC8Vqh/Xb0MjvE5i+I=;
        b=OtmxeCHI2CMuPbuLXaJNmRPIhVH3SCA522pmazeTMUqJ1mFdfF/L+zb9mKyTlyvisJ
         tdUs+Q2MYnhKPqwSGq9ZOpznM8e+kP0VhajGDRvvfHAqlF+eG7ZCOdB/JZGhR0imqEhf
         XBuUBbTb17WPKrWXCvqWseVALLSYoLwrpNQGixsuWt3I844H0yTk7ccKBC63kTLCfLLZ
         DCUPjtpcFWbMe9mZabcM2VjnCZj0nMqA8F3c5Z2mS+vBEuv2YjWTAe982cHxN6Qx4M29
         W2Jg3OM6fIyY9pa1+pzLpMzhyx6FQ1VEWpbQyPXvM4tMlj1rf5sWigmQturOle0xo75h
         Ax0A==
X-Forwarded-Encrypted: i=1; AHgh+RrvRZ6Es90Hk0Y3kxhqHcXrjx3SpoN0ISoFNVMyiXZFoPbP9ExUdfzW+vsnW0xtjtATeZOnUpg+jOFoG+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/9GAXrd/RMy97B5ZrfIIMWfv2UEhPg9YElixfRC3Q7YWdW2ZM
	sFhIitH5goHgnRObZkKJbstpl3LktYzAWM+1+DpMQWj8C+VaXJS0jwEjhl3p+2RMdYmhr1bSCnr
	dpWEWFABp6edGIoc7xaqjb2yC2haxPI0=
X-Gm-Gg: AR+sD12UI63GOeq8Ff0WWempWxpN1m3TSw9Pb9jtjqVXa/LNWaXD3thWzGdd5NnXgua
	3fpVjDsl9PkcUZYp5f3OuKp5b11QI7ySu5MYKgR08lEQXfl0XU7BQQ7r7vGDYreesQbC2fJYuf1
	wC/WSBbf9/4EHOgMO3CZC9ujYivz7O0U4aaQKXvlhhn99TKjWaNHZm3j6bqVKFWfssXi8rsNGsw
	ODQKkMrczXUvRL72GpKajWF/Yb7QSQJb0WRgPok5jSkncHx59Wpy9PnT6DoKaWqMle5rQgMdCxG
	OPju9K5rQevpNN3VTQfLhPQ6mL6uR2UxQeIr68tpTmm7AVBlymTYbWMO+MKtUJ5Z7TKxva+nc64
	bIyyhEaYjmz83RoZBLNhIgdJu19ovvBSeFsxIEw6gkV6SkjrrU+b8y4eztZac1H581BSF0/iaed
	hL0Gfl3dX5r/EnYn6BvmSug8FrNI8xt9mkyTtXxzeOAb0ah8We4pu6CSgGjARNjqY=
X-Received: by 2002:a17:906:f582:b0:c15:f40f:1593 with SMTP id
 a640c23a62f3a-c1fe7bdb221mr569287666b.16.1785742054971; Mon, 03 Aug 2026
 00:27:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731074820.735619-1-crescentcy.hsieh@moxa.com>
 <20260731074820.735619-9-crescentcy.hsieh@moxa.com> <CAHp75VdL71oE-E85fOLbz36bhs3EKg1iL_vtNP+TQzek5PNqnQ@mail.gmail.com>
 <7a4900a7-bd31-46ee-81ee-d597899a34de@kernel.org>
In-Reply-To: <7a4900a7-bd31-46ee-81ee-d597899a34de@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 3 Aug 2026 10:26:58 +0300
X-Gm-Features: AUfX_mw4rWnw9uYGTSb-CE5kdl1EAkJqML4F17R_S8lCO02h3sSSnkQMxglGs5Y
Message-ID: <CAHp75VdSqLZo+XYr_V6QO-yMUJCvd5+8hKSkHDsNQWFF=KXERQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/14] serial: 8250_mxpcie: speed up TX using
 memory-mapped FIFO window
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Crescent Hsieh <crescentcy.hsieh@moxa.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, FangpingFP.Cheng@moxa.com, 
	Epson.Chiang@moxa.com, EddieSY.Lin@moxa.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 7:46=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> wr=
ote:
>
> On 02. 08. 26, 11:10, Andy Shevchenko wrote:
> > On Fri, Jul 31, 2026 at 10:49=E2=80=AFAM Crescent Hsieh
> > <crescentcy.hsieh@moxa.com> wrote:
> >>
> >> The MUEx50 UART provides a memory-mapped TX FIFO data window along wit=
h
> >> a TX FIFO level counter.
> >>
> >> Fill the TX FIFO in bulk via the MMIO FIFO window based on available
> >> FIFO space, using uart_port_tx_limited() for the common serial-core TX
> >> handling.
> >
> > ...
> >
> >> +static void mxpcie8250_tx_chars(struct uart_8250_port *up)
> >> +{
> >> +       struct uart_port *port =3D &up->port;
> >> +       unsigned int offset =3D 0;
> >> +       unsigned char c;
> >> +
> >> +       uart_port_tx_limited(port, c, port->fifosize - serial_in(up, M=
OXA_PUART_TX_FIFO_CNT),
> >> +                            true,
> >> +                            serial_out(up, MOXA_PUART_TX_FIFO_MEM + o=
ffset++, c),
> >> +                            ({}));
> >> +}
> >
> > At least three randomly chosen drivers use the empty tx_done, perhaps
> > it's time to have a helper that embeds this ugly piece in it and hides
> > from the driver?
>
> I haven't tried, can we make the helper a variadic macro?

Since it's last argument it can be done with the variadic, but you can
also reconsider the others from the same group (the wrappers on top of
__uart_port_tx() call) to regroup argument list to make more than a
single optional argument. This can mimic the case of
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/li=
b/kstrtox.h#n21
where two optional arguments are possible.


--=20
With Best Regards,
Andy Shevchenko
