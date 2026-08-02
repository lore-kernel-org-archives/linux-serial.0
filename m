Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484913932EF
	for <linux-serial@vger.kernel.org>; Sun,  2 Aug 2026 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785661292; cv=pass; b=E+GwFTe8Mo5webawPqBkKNGWm8e+1f1n95Ym95PVT7X8kvOLVvNYWMxFa/mW1WyUiluSlC9W4oL90Z49BWvY1R559lPKbRd4bH1LTNeBn0i6EVjYmt+xySWLqAjLuxc3cvC7okdzLAKg6nZ+g4GRPRBr9FAbadnqT2FFZgZf1ZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785661292; c=relaxed/simple;
	bh=0ApRXQessALkCTJQQVqafLYiBcK+l3IfSsS+mczQhTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LVGzbrzDqtEVHsd9SoCftzfZIKP55N/3uu9L5MPvWoyNHEn316Ge6OQhvvVYVwrFZVD9I7UqhzMyQX5Uo+J/266jrLNXagtKurZJLstrj4ZoDrmTHnf9yL92FO0HYnBZ80fmXgZCdXgMqoHsPI1x0XisdRV0ALYUo+x0VKP3Fd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QD1d9DY2; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QD1d9DY2"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c15d47266baso290564966b.3
        for <linux-serial@vger.kernel.org>; Sun, 02 Aug 2026 02:01:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785661289; cv=none;
        d=google.com; s=arc-20260327;
        b=eZt3LH3E/30TT2yLa86x1fwmBedStQiBR/Cm3prBBl35ixl49WB6pkYq0tTsVpjWPh
         UlGh0h+T3XoQjP0v13Ze/84MO8RR0hqIVUgVwC+EmkBR6fZwGlFIAISKMupUcuYwxpwj
         A9nUgiHX41Q5KYYw5SiqQgeyeXrOp6/zWhxV47rfH2zCZfj+F6VfIOesWDxgMMwKDxFL
         nTsZImsRIn6PZr3WJjAN0Lq9D6/edOmZKhFGHM+mL6GWw69rn2xsat9bEaYVweBnMC2F
         HppsmrDKX6M4iLSdO5LqTKCR7aV2FaJbeE6FKiPW9ktPehGoEhKSgjpqjgZQRgXNrtpO
         i6lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DPyEgzlJ00hQfauHDDb2McuthEqPs8Ftb8QiCj/26w0=;
        fh=mI27GAAmjEqZW+Va0iMtZqTErgY2Iwe1ObgtIVyacbY=;
        b=fRBXYusyvkq2drTMHJGFyv7aIFW4qA8h+ji/9pHcG8pnONXmx3Ii+rhIy58f7ChLiy
         S1/gml59Dlup7RKeCEuDRbFSdTcBG1db36RVRZHdQzPkmjkVHiShbKJi486gY5oVr9TO
         QNWxWS1ue8QTdTvZYPZ87c4X33WdQUxtfLEuKSwbiYwPrGlwbOBBU0OHA88cXvh2V7L3
         WkJDSUnqsyzf8puC3VVy7ZzGGTabEfsJ9mn+Ow4kEzQcKDx1PIprQwFbfpvHICTcceFN
         mitZuntrlBXN5YErTXfPs5C0PPrFo11t2GVC3+i4bwCZcKGemkHlJOEoTsjkJYFBoVs/
         tkPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785661289; x=1786266089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DPyEgzlJ00hQfauHDDb2McuthEqPs8Ftb8QiCj/26w0=;
        b=QD1d9DY2ynjH3/TfxqfQr0cFLVz/IlPACyWzgxzc35YA8vNdtiDVL39i6yk2tg26aj
         j/WyVGwgsQBCk0VNwUn+JB/g/m6ya6YCYLle70u1UJHF0Q64ZZNlyeq5C6JKoDShlFzB
         0akkkIkRIstQytBQvX8pzhtTL0CIljOMNpGOHWUndT//1NSmspQFzbOSQXg6ElHM2cSf
         SYtsfQ1QOP6LlaCNw4Q4j3N7XXNTQAnKHe3OWOp4TVIJjlPO0nZa959pWcG0ymRqUz/4
         TKQ3B5kH7e/6xMy7DLGXN/IDKTVVbg2XrdNIrsZjocNR48mub3AE0EYTwbLInPlilZzA
         Mhog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785661289; x=1786266089;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DPyEgzlJ00hQfauHDDb2McuthEqPs8Ftb8QiCj/26w0=;
        b=O5oAhBAT/kQy7YWVIndLFshf5e3R3bHSRMJNn6vU6vPIY39KI8HMVaLpGYlnvss2R8
         gdyP0WR3/CL9+eTiifK5IiHJPWP5tLWhohO5/fvlhMq7toLpmFX0jO/WgxB32f1WxFV4
         z39YOUgWVZiLud59+azanRxnkoEP00hpl9RXaYSi56et1qaUlTSDd3Elto1Cv/i+AJvR
         IloPm8SdCieO2gLmoRfL50PWY84hAWzDmRFrNuMwPnPpi+qUjJ023v3Ru9ouyH/R5M4x
         Q5/v3PKKmrySXwLkwpWh/9jMoXp7ur3X5MSWTbcZhERHIDQyS0omPGg5HcSSsLKz9K6v
         nifg==
X-Forwarded-Encrypted: i=1; AHgh+Rr2oNMQ2pmBKhg8r07VbgIQUplNVl8ZFa0Cfzr/hZyAUIOEv3yYhroS8y1D7BljE/t0RsU8mndiXlIXrgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXKSGaJ31gEjGEszIgJulXBwolh36qHLDRXovTexRb1G/8M1TR
	eu04cWVL65M+CczIPeFsWiXUCmZkw+1cUpoprK6MMh3bbYT/tJtZGwsYarvpaXX8X9usqQJ2M3W
	j4B7qFVBsIqtDvHSUCUuxCMmhK9cNIJk=
X-Gm-Gg: AR+sD127cHBR/XVbaMsLJZ/NwDol3pmEi898ReufMwqacX3ytqfnsraWGZFlnC+gCNS
	DS1uGf6dWQ/kwczesHGf+ZPlt+5mP5UxJNh4vgRud+pr6pfQzt73s9sroRsL4/f8pZYtmn97Gpi
	jAV8jn4iLWExUVvyOYbvbIoPC/GpdIfGQkR9Q56DkcqfVYWnMOPgI/IREPyVElO0lC7Fv3G2d/m
	iDQo1zbH76A7mVLfjLI6q9nXEq/0jmcAj73+C5CthXoyYBP1KcenWY79n/l6sWLvPUpwH2eVZei
	8kCnovbfF0fEeulfOCxyhbl13L9v3HdKJtXeyk0VhhGhkL+Zl1kHcYEHxc8EDhaIuDWy1WIwjOZ
	p6E1eEs8o8Z1Ocwv9ilF8t7/vZiSDYLnnnOFibE4dWWGnI/vMqpV7ph9ZLwFPC3jOVjJL6LwJ7V
	z1ufBJ3xzFCxEo4wqt54/TalBmz2SB8luti1wXLAQcs5sHgRHxozrL5mLZ3E63GKk=
X-Received: by 2002:a17:906:a56:b0:c15:db5c:7127 with SMTP id
 a640c23a62f3a-c1fe7ef209emr384001666b.20.1785661289206; Sun, 02 Aug 2026
 02:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731074820.735619-1-crescentcy.hsieh@moxa.com> <20260731074820.735619-6-crescentcy.hsieh@moxa.com>
In-Reply-To: <20260731074820.735619-6-crescentcy.hsieh@moxa.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 2 Aug 2026 12:00:53 +0300
X-Gm-Features: AUfX_mx56Oa9r9jMywfTm_LL5eGxrEzGlqqA2KzTy4GyzMPFjepU740N-bCyR3U
Message-ID: <CAHp75VfviLtGzGX25j_-xzPtrRQgF7kpCAP2pcvQOjUWM3ZVDA@mail.gmail.com>
Subject: Re: [PATCH v5 05/14] serial: 8250_mxpcie: offload XON/XOFF flow
 control to MUEx50 hardware
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	FangpingFP.Cheng@moxa.com, Epson.Chiang@moxa.com, EddieSY.Lin@moxa.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 10:49=E2=80=AFAM Crescent Hsieh
<crescentcy.hsieh@moxa.com> wrote:
>
> The MUEx50 UART can handle in-band software flow control (XON/XOFF)
> directly in hardware.
>
> Program the on-chip XON/XOFF characters from termios settings and enable
> the corresponding MUEx50 flow control modes when IXON or IXOFF is
> requested. Provide throttle and unthrottle callbacks so RX can be
> stopped and resumed cleanly.

...

>  #define MOXA_PUART_EFR_AUTO_RTS                        BIT(6)
>  #define MOXA_PUART_EFR_AUTO_CTS                        BIT(7)
>  #define MOXA_PUART_EFR_RX_FLOW_MASK            GENMASK(1, 0)
> +#define MOXA_PUART_EFR_RX_FLOW_DISABLED                0x0
> +#define MOXA_PUART_EFR_RX_FLOW_XON2_XOFF2      0x1
> +#define MOXA_PUART_EFR_RX_FLOW_XON1_XOFF1      0x2
> +#define MOXA_PUART_EFR_RX_FLOW_COPY_TX         0x3
>  #define MOXA_PUART_EFR_TX_FLOW_MASK            GENMASK(3, 2)

> -

^^^

> +#define MOXA_PUART_EFR_TX_FLOW_DISABLED                0x0
> +#define MOXA_PUART_EFR_TX_FLOW_XON2_XOFF2      0x1
> +#define MOXA_PUART_EFR_TX_FLOW_XON1_XOFF1      0x2
> +#define MOXA_PUART_EFR_TX_FLOW_RESERVED                0x3
> +

^^^

Why is this blank line changed? What happened?

> +#define MOXA_PUART_XON1                0x0B
> +#define MOXA_PUART_XON2                0x0C
> +#define MOXA_PUART_XOFF1       0x0D
> +#define MOXA_PUART_XOFF2       0x0E


--=20
With Best Regards,
Andy Shevchenko
