Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C6D1DB34C
	for <linux-serial@vger.kernel.org>; Thu, 23 Oct 2025 02:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761185460; cv=none; b=Vk1YrMT1/wXcDLp7bTJ8wIG7nADq306USMnAKE0zDKSZ9SLe80aqGJ2EE5w9o4otTul8t5oax7nEPrcbCYkXfYXGVJsdzufdlbyNqrE28OQepL0PR3wElfWKhlDA3en/qOd6zbEj88jjXRYqbjM6KL8pCVZ09kIT353g2iBbEZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761185460; c=relaxed/simple;
	bh=LK/MCU545iyIlJWNJBzuC2+l7bxB3Gjk5BZcNhGZT8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LwlAuOjCMWzzb+YVE12o62GEYQLF50SQqNg5lG1qao5JA2XT8sufSxZcLdC2bUx7bBKeTd79pdxZhYKeMOFnXrfKU76WtSPaSANTZ0vDfr+7PMxKL0NetZGfJZgL6SoaskpQLR+UJnwC8Jgw1dwa6r1HCON6IOLdhe8bX0DCWqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkUoTsaJ; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkUoTsaJ"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-33bcf228ee4so298379a91.1
        for <linux-serial@vger.kernel.org>; Wed, 22 Oct 2025 19:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761185458; x=1761790258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQXqtV/1uWQfXNewiRPXkUhRGITyK5eGr00S9JX7C5g=;
        b=dkUoTsaJp29Fc5639V+e+Fgu9ZJGD1dyn7MxQrj6sJjFGEM1xifjpnRqPozZf1R+NV
         fAKiwjH7ra4wmQaTFzhLiuB1v9gkSNXCSmJXjB+JcUsTUTEaf9mBaBgI9bqAI4N+PZTg
         eftCfzhO6t+NfejE4soQNgAj74o8uJIlU0hpl+L1X1rqm0EJBQBPhbE9lFdcsXPtduq9
         h2RayMWVaK3FJl0obUj1R88Gp3v/4VoLFVoc+I0so7/STO/MDD5Y72W//ukuaBoRv48i
         vI3QV8j8+8hzzdMMSlbWVKaoM7co1ksujhx9GG1G7WvIve96pcltvg+o7hYxipNXmdKB
         yJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761185458; x=1761790258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQXqtV/1uWQfXNewiRPXkUhRGITyK5eGr00S9JX7C5g=;
        b=Dh/fuIWfHnHQ3uJtlnqqaErLbl/mlB5BwxHDy/oOK12b+JWORY1bA8WUPQjrKf4EqV
         JsHz4HzdzExJsfdTAGGdYvBhflnm3Qfprpyj5JB4I0VKdEBLD0ly+JBs6ERo4U8oRiue
         2EsLisNErtCW7ex/1AswCW1F+Wvff8iutwzKw0iwurSUeUlbBINFU+3KRE+KXWyDL9TC
         GqW8pwnZyq9hbc59u3xZfRcwCTk8xc9rYp5zPo7I+AHAn2s+3Qa9v5BCFCq8uV4f+w/Y
         u6b09yvNTivqBjH+Ree0D5wAW1okz6I62y3mf0lt1aCjqE6f8r7EY8liXpAt60ss4Q2R
         ve2w==
X-Forwarded-Encrypted: i=1; AJvYcCXzKveWsOwb8fnSbI5EEeXeyBTBe5nKmg1krQujsg24+fd1Gzc4fDqcSq9/acJkgj0Cq3MhIRs3Q42HwUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4sf/t8YYecjFm8wC60Y5HcJHE3zcTcdb1YGf8iMg6TiSHRM8D
	lbgwI2czGRHu0FJly7KvIB29d6wcFM+tyZZCYk8IWqIbHRxG463qzy0e5mrbwvC7BgxRrsXa13j
	+NiG0q15YgN4woA40h8/hrAS3wp2PwkU=
X-Gm-Gg: ASbGncvgM8R/KCbD5ENsPUip4/mp/iQs8wuWuOuuSfql1g15BHgWf1WDxE05qNTrG8i
	BNPqM8pjHOCwgzPp/09AhWD5fKqBixGYa78kzoZ8bzwlSLkwtSdfZ64R3bTExsAtL39FdQpqKOX
	S3koaJWmeG98bLtHZTZWzw54ONlOJ4sjnq7ZhJH0wWGCgMVPPjXDpOISDzLI61yCn/HfZfuFtwr
	9nWGiXNafKfWOF5SrEE44ydp5K8MGjZ32p6Vrc/3fviOn3U35QK51qxv5HlDA==
X-Google-Smtp-Source: AGHT+IH0vgBI91tHVmBwxye51nmDErzeihIRXQW2MwwIIZ/u/A9ulgOV+5Q8k6m6BkEHOHQMF8a53huNM7TMY2ohlXs=
X-Received: by 2002:a17:90b:5386:b0:329:cb75:fef2 with SMTP id
 98e67ed59e1d1-33bcf85b45amr24269278a91.3.1761185457572; Wed, 22 Oct 2025
 19:10:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022030840.956589-1-Wenhua.Lin@unisoc.com> <CAAfSe-uq6GszSLgtM+UBuwJ6V1Bt0_1Ard8cb6e9MMCsdpJPqw@mail.gmail.com>
In-Reply-To: <CAAfSe-uq6GszSLgtM+UBuwJ6V1Bt0_1Ard8cb6e9MMCsdpJPqw@mail.gmail.com>
From: wenhua lin <wenhua.lin1994@gmail.com>
Date: Thu, 23 Oct 2025 10:10:46 +0800
X-Gm-Features: AS18NWDwNTU8arpSWNZRlcaFyHSGcyZrjd-l2OixTO1dXJxN-NI627aQSmAOdvo
Message-ID: <CAB9BWhdKd93kJxPJv10X5uZ00O8d5NugoehX3_QtjmXQOMhDig@mail.gmail.com>
Subject: Re: [PATCH] serial: sprd: Return -EPROBE_DEFER when uart clock is not ready
To: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Wenhua Lin <Wenhua.Lin@unisoc.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Cixi Geng <cixi.geng@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>, Zhaochen Su <Zhaochen.Su@unisoc.com>, 
	Zhirong Qiu <Zhirong.Qiu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 2:55=E2=80=AFPM Chunyan Zhang <zhang.lyra@gmail.com=
> wrote:
>
> On Wed, 22 Oct 2025 at 11:09, Wenhua Lin <Wenhua.Lin@unisoc.com> wrote:
> >
> > In sprd_clk_init(), when devm_clk_get() returns -EPROBE_DEFER
> > for either uart or source clock, we should propagate the
> > error instead of just warning and continuing with NULL clocks.
> >
> > Currently the driver only emits a warning when clock acquisition
> > fails and proceeds with NULL clock pointers. This can lead to
> > issues later when the clocks are actually needed. More importantly,
> > when the clock provider is not ready yet and returns -EPROBE_DEFER,
> > we should return this error to allow deferred probing.
> >
> > This change adds explicit checks for -EPROBE_DEFER after both:
> > 1. devm_clk_get(uport->dev, uart)
> > 2. devm_clk_get(uport->dev, source)
> >
> > When -EPROBE_DEFER is encountered, the function now returns
> > -EPROBE_DEFER to let the driver framework retry probing
> > later when the clock dependencies are resolved.
> >
> > Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> > ---
> >  drivers/tty/serial/sprd_serial.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd=
_serial.c
> > index 8c9366321f8e..092755f35683 100644
> > --- a/drivers/tty/serial/sprd_serial.c
> > +++ b/drivers/tty/serial/sprd_serial.c
> > @@ -1133,6 +1133,9 @@ static int sprd_clk_init(struct uart_port *uport)
> >
> >         clk_uart =3D devm_clk_get(uport->dev, "uart");
> >         if (IS_ERR(clk_uart)) {
> > +               if (PTR_ERR(clk_uart) =3D=3D -EPROBE_DEFER)
> > +                       return -EPROBE_DEFER;
> > +
>
> You are making this clock mandatory, sprd_serial driver could work as
> serial ports for logs output without this "uart" clock.

Hi chunyan:
   Thank you very much for your review.
   This clock is actually mandatory now=EF=BC=8Csome SPRD project use defau=
lt 26M clock,
   some new SPRD project use default 24M clock.  If driver can't parse
this clock correctly,
   driver will configure wrong baudrate and make the log garbled.

Thanks

>
> >                 dev_warn(uport->dev, "uart%d can't get uart clock\n",
> >                          uport->line);
> >                 clk_uart =3D NULL;
> > @@ -1140,6 +1143,9 @@ static int sprd_clk_init(struct uart_port *uport)
> >
> >         clk_parent =3D devm_clk_get(uport->dev, "source");
> >         if (IS_ERR(clk_parent)) {
> > +               if (PTR_ERR(clk_parent) =3D=3D -EPROBE_DEFER)
> > +                       return -EPROBE_DEFER;
> > +
> >                 dev_warn(uport->dev, "uart%d can't get source clock\n",
> >                          uport->line);
> >                 clk_parent =3D NULL;
> > --
> > 2.34.1
> >
