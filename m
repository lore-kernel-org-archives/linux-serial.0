Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4BA2C15A5
	for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2026 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552114; cv=none; b=q/q99iWMXOHU2a5Eg+bl0lWSSp9hnZIEl5xrC3Bcte3OTUsUNqDTv+mXRJMfPwWbgW16f4ShLNVwcdjHACWYz416iERZLB6zvO2tg71OoinGHsDaxITtiq/a7ragYtQh5LnUPwWNQu2J6lNqbyxFy55hibhr9safne+VUlFlVS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552114; c=relaxed/simple;
	bh=jil58w9XnfCeytzYazk/rYFNKweL3bAGOGarBwmpMEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iu7JhRSZcz1+Y/1QyI0KLj0AL2ZCP5hPvhayL2pw4xEmTgtrnjUtZBiNKHIu6qtGpzKb5NY4av/KHLzV5H2PiSwYQmhGKWNEkC7UylrQMNCJ3dD+rhc3CmhGeuqRcuu1SBxmvYoJSxru5Sa3cJocHWhuhgHExIrD78hbyRO6n4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LunfvuBf; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LunfvuBf"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5bfb5e20a90so770957e0c.2
        for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2026 09:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786552112; x=1787156912; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jil58w9XnfCeytzYazk/rYFNKweL3bAGOGarBwmpMEE=;
        b=LunfvuBfpa7A3FNKYS9VzBcVXXjtjHwiWXSVXMn1HcZKrGQz63eBjS5eEDhQZpxrSw
         DmfQ4ECv2zn/0+aiqI4g6JKGPneQZyMSY5gfg3ZImi9mzX13kfLn1aO7IVWRpRjvgB0G
         y98TGQugCr5aelfG40fWZZGqgHfmslcoodfU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786552112; x=1787156912;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jil58w9XnfCeytzYazk/rYFNKweL3bAGOGarBwmpMEE=;
        b=jJP/qoAzXAvU+3Axv8+qryhTlPkCAmHnzGAs1c2HnLp/NoYzaO4228wR/Edrm+aJ3P
         S20RJpM//6LEit+cLcsrcxatljMZd3n67mFSZ/w3kw6jU3FaVIKLEWuzYyTTTJd+xC6o
         ZQz7oX2g/OBU3T1/0bTTHoccj8v5pmu3ilwqwjCPcGfkcpG2oz87BBqvrpcaVSzQH+Su
         KEfPNCYttVi05+y0mafyKKk+YDJ/1sunkcMvqwx6GoijHvmilI796eIhDs27nBA3H2Sa
         cmOWj5u7djjr9RH4zMst4OTon7cELnnMfBRn+ArzRhIv63rsstykejj6lFtjL+VSEFZ1
         LroQ==
X-Forwarded-Encrypted: i=1; AHgh+RowOrU8OZ/uwsnipOGzwffsxtkQpXkADT/MjK2+EOqhLg/hhICUsH/G9lA8q+TSFdfyKdAcvHHf+lP4YCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKnZaKYXz/SgJ6rUddbP5H8AMaoMMvWZzKLm0TdfRCzfF4gmZW
	+CZaJarlSIprgwhtUeBFEKIR9hagmDY+GUcwwm8AErg9MfEDYpveMeQUp4KeYSK8/U5CFQXgbGD
	IFww=
X-Gm-Gg: AR+sD12RdbkGDKfrV25dkuGrKkq55yKCcsT7xIl8JQxwLvu6sQQ7ynEcOGa0yS2KmjW
	f1QbzOZBipxcDTuGqhYNR42zi9tCQWwKf95TyWKe9KDKkovB/17VEbbiIo9iuCsP03tyN0E+N+D
	tfGsTYXV8GfVtdddk8rt+hZQg3vGrmyGrCnSIwhDCWep6WM2EV7oi9TpP0bVxMcNb9jEQkVYZDK
	f+pjZEkvOjuKT3u0BGlUdkdTBALzT6KgInV39zJMTGtjYtNeJp5XsWbggjlGnVsbydZayOb9To5
	omNu4DDEE15ikwsyOVPhnj705V8jRhLpBdAErmDqfzD47/hl4VaB/qdIPh94s+vm8TAnqxzQuhs
	agbpe9SliTjLcytljidvKsJIgO9T/0iDtdiBHmGCd/PIeLLm3fzXOxqkWec7cFrf3m60ee8wPmf
	7NNVD/GmG/TVgTEYGE9PHPXxFT61HFoaRSYIps25mLY/8Y2AVIrXrUiW9HgVYWcpKV6ynK4L1eP
	hKc2LoqtoGJa0swy2lmGVGH0r4=
X-Received: by 2002:a05:6122:d90:b0:5c2:c0de:d291 with SMTP id 71dfb90a1353d-5c501f08346mr853859e0c.9.1786552111947;
        Wed, 12 Aug 2026 09:28:31 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c45b71569csm1488203e0c.11.2026.08.12.09.28.29
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 09:28:30 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-74d55dac06eso598519137.3
        for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2026 09:28:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpD/wfWVrpDrxYdDMW0OTrINSjJSGvPMVfHDyTmVsJdWILiKe9G6vd1aRQP+U1l+rDcdKHB87p+yzZvmyE=@vger.kernel.org
X-Received: by 2002:a05:6102:644e:b0:729:affa:70fd with SMTP id
 ada2fe7eead31-76c8e92d8f7mr1626786137.8.1786552108665; Wed, 12 Aug 2026
 09:28:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810130635.1166626-1-mkmkl@google.com> <CAD++jLnpZbmbZ_uQTS7pBdbmpvOZSy5+JsVP=Vb3HDhV8J-h4Q@mail.gmail.com>
 <CAD=FV=UzV=G_XLoDZ4zq0ZPSQ3ttUDX9oBJUQrLYfUQ6v35nsg@mail.gmail.com>
 <CAD++jL=WmAJNotpxqQkE9Yf3COxMcj=afDVGB2zi+ZN+mRocAg@mail.gmail.com>
 <CAD=FV=UoZ=CoUdku5aaJr9uihxr0Q-Yj4UQeQtYeODMzku7LkA@mail.gmail.com>
 <CAD=FV=UMBrgiRNP7y=KaAcq9a0f4UvJn5HOK=JoYveRS6c8mRw@mail.gmail.com> <anwZ_h5ySXuGpM3B@ashevche-desk.local>
In-Reply-To: <anwZ_h5ySXuGpM3B@ashevche-desk.local>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 12 Aug 2026 09:28:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VbmszP-rj6ZMH2D0D+x54G2yihy2FmnughH124vK6J1A@mail.gmail.com>
X-Gm-Features: AUfX_mzqiZI5d7zshS6YofTXn3bchIAOdUEIGUdh9n229oWM8ECdvV8W5r8-YVQ
Message-ID: <CAD=FV=VbmszP-rj6ZMH2D0D+x54G2yihy2FmnughH124vK6J1A@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] pinctrl / 8250_dw: Allow drivers to keep init
 pinctrl state until first open
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linusw@kernel.org>, =?UTF-8?B?TWljaGHFgiBLYXJkYcWb?= <mkmkl@google.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Vic Huang <vich@google.com>, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 12, 2026 at 12:00=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> > What we need is we need to _assert_ chip select (make CS_N low) until
> > we know that the other side is powered.
>
> Isn't this dangerous? Some noise on the bus for whatever reason might pro=
duce
> undesired "communication".

I dunno about dangerous, but it's an extra hassle for software to get
right for sure.


> > ...we can't use the "opened" we've been talking about in UART because
> > there's no real idea of "open"ing a SPI bus. It's transaction
> > oriented.
>
> But any SPI message that is queued is basically an "open" stage. So, it s=
ounds
> like SPI core should change pin control states when message is queued and=
 when
> it's done. Like be coupled with runtime PM?

Certainly the SPI driver can change pin states between "bus idle" and
"message being sent". The SPI core can auto-runtime-pm the host and
the host can change between "idle" and "default" states. It all works
fine. The problem is that we have a 3rd state: remote device is
unpowered. The SPI core doesn't have this concept right now.


> > ...we can't use the normal "runtime pm" concept in SPI and start the
> > SPI bus in suspended state because the "runtime suspended" state of
> > the bus would want the chip select deasserted (CS_N high).
>
> Sounds like a PCB / electrical level of design issue. I would solve this
> by gating CS signal using power of the peripheral connected. Have you tal=
ked
> to your HW engineers about this problem?

Yup, this is often solved in hardware, but apparently not in our
hardware. Thus it becomes a "small matter of software". ;-) It looks
too late to change, in this case...


> > 2. Invent a "pwrseq" solution for SPI where we run a sequence of steps
> > (turning the regulator on) before probing the SPI bus, like other
> > "pwrseq" drivers. Of course, most of those are for "discoverable"
> > busses, but the idea of powering up a peripheral before probing the
> > bus it's on is similar. This seems an extreme amount of work.
>
> Btw, isn't there some development for the undiscoverable buses?

Right, "pwrseq" has been looked at for a bunch of busses, but I don't
think there's anything magical/generic that could just be applied to
SPI.


> > 3. Hack the "CS GPIO" to be controlled by the client. It looks like we
> > could fully move the GPIO (including the pinctrl in the DT) to the
> > client. Then the client could call spi_set_csgpiod() after it's turned
> > on the regulator. The client could have an "init" state for the GPIO
> > that keeps it low and then transition to "default" right before
> > calling spi_set_csgpiod().
>
> > Of everything, solution #3 doesn't seem terrible. I also still don't
> > totally hate the idea of extending the "init" state... Of course,
> > there's also some chance we can figure out other ways to get this
> > regulator turned on sooner.
>
> Yes, #3 seems okay, but wouldn't be even better to have some flag in
> SPI core or pin control on per message basis (see also above)?

It could certainly be interesting to add the "remote unpowered"
concept to the SPI core, where SPI device drivers could tell the SPI
core when they're powered or not and that could cause the SPI
controller driver to select a different pinctrl state. We'll have to
think about that when we're ready to upstream the driver for the
relevant SPI device...
