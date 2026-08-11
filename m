Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832F6332604
	for <linux-serial@vger.kernel.org>; Tue, 11 Aug 2026 06:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786430064; cv=none; b=VzjIta5EracjQ2Kf2lYvtlggvh1jFv9I2Iu5mdFS2MEfUto6mqqrOXQ0fHuWaFDspQsLWdJ37hdEhUVsEeRbA7Z/Zj7I6728cEWAzgc+hkhI0aThsyBitoxT8eJmEsoZR0S9KKI+BdErqe9xxRSpGd834VBodWtWQCLJvjfiXX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786430064; c=relaxed/simple;
	bh=ay7+68O8x2cBF4Jz5oOuWpIfM41H9XIbkcPKhL5H7SI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hb9xjF/fco35PR7zgEs/yz2VAm9ozw5MBqDi62yaQdgK8ntZ8A6rROLG3B4LYgDkBcszL1VwZAD9qyia4OQ7RmG2IJOpkjs+pmUzsPGCbIb9EthoYoiU5iNWbnRpEzc5M6CByNsbcvS+QlVa566WFt5AIn7FC7ItdFNrjubOcoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dksZ6Qkq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dksZ6Qkq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3631B1F00A3E
	for <linux-serial@vger.kernel.org>; Tue, 11 Aug 2026 06:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786430063;
	bh=e1YQyC/NokXrsQ80jPU5/6YvOMfgYZRaxyNCbf9juaU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dksZ6QkqiT5dR8JFwczVx5BndtH5ifhBobg9NfI9/4vrwOTvlPzvCBCvHOmjZb6JM
	 8p9JE2pXDD8u71bqmcO9lOgd0nuoeNALLijOuiHg08HX0KyMh374dzkNz0Z7L6XiiG
	 H0SvJS+t35TfQzJfjxqUT+vzQ3HARzzt/WTiAARqJu/8PyLsYFmsdzqhQ11bi3mpmd
	 lpNDcxq+zR3Zfj/GTux8AhKFt9M/DiMCpebXvgkZc9pgraTeBgCl/GIM4gls1uouKw
	 NblnHYAlOVSZHO8Xpj4zb7rUdWcvnyxmFbdn2/ZH0CdgduQHllnZ32/n2U+IkW03xR
	 mcGIQZ4w3FtaA==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39f1ac13687so17215281fa.0
        for <linux-serial@vger.kernel.org>; Mon, 10 Aug 2026 23:34:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqdAjIxZO0U6cR25kKo3tt8QKSwS/R86U/cl5TLUMKgb7qK6UZB3I1dt7B2ev6QTcFQsyOKMNqt74QEeck=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTV3YAz7oaFRT4wtsYt0w6GQoyWu/FNGdQTjbBS5Cg2ZMukdka
	kn2kT05Xt4aMNSz6AfI2fL4DvR+bkdTJFj7AwPJGU3apMgRbRCqO+l/1D+j0wO3hEiyEov4fZNa
	dfRRSku9y5Asp8S+paWx/CX/64e2/BPM=
X-Received: by 2002:a2e:bc81:0:b0:39c:93ff:3672 with SMTP id
 38308e7fff4ca-3a0f8cf8ad7mr1417531fa.9.1786430061943; Mon, 10 Aug 2026
 23:34:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810130635.1166626-1-mkmkl@google.com>
In-Reply-To: <20260810130635.1166626-1-mkmkl@google.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 11 Aug 2026 08:34:08 +0200
X-Gmail-Original-Message-ID: <CAD++jLnpZbmbZ_uQTS7pBdbmpvOZSy5+JsVP=Vb3HDhV8J-h4Q@mail.gmail.com>
X-Gm-Features: AUfX_myZkyC7FNKL5DsoG9WiVk43wg_NI_GO8iktSq0f0PjXO42A_A4Ez5jTirE
Message-ID: <CAD++jLnpZbmbZ_uQTS7pBdbmpvOZSy5+JsVP=Vb3HDhV8J-h4Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] pinctrl / 8250_dw: Allow drivers to keep init
 pinctrl state until first open
To: =?UTF-8?B?TWljaGHFgiBLYXJkYcWb?= <mkmkl@google.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Douglas Anderson <dianders@chromium.org>, Vic Huang <vich@google.com>, linux-gpio@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michal,

thanks for your patches!

On Mon, Aug 10, 2026 at 3:06=E2=80=AFPM Micha=C5=82 Karda=C5=9B <mkmkl@goog=
le.com> wrote:

> During device probe, pinctrl_bind_pins() binds pins to their "init" state
> if specified in Device Tree. When probe finishes, pinctrl_init_done()
> automatically transitions the pins from "init" to "default" state.
(...)
> 1. Patch 1 (pinctrl core):
>    Adds pinctrl_keep_init_state(dev). When called during probe,
>    pinctrl_init_done() opts out of the automatic "init" -> "default"
>    transition, allowing the driver to keep pins in the safe "init" state
>    upon probe completion. Updates Documentation/driver-api/pin-control.rs=
t.
>    Board configurations that do not define an "init" state are completely
>    unaffected.

I think this is the wrong approach to this problem.

You are changing the transition from "init" to "default" for all devices
on the entire system. What if this is not good for all devices?

I think the right approach is to create a new custom pin control
state for 8250dw, something like "active" or "online", and then
actively retrieve this state when the device goes online.
The "init" state can just be the exact same as "default",
or you can just define "default" to be what "init" is and skip
"init" altogether.

Pin control supports any kind of arbitrarily named custom
states.

In wherever the UART is actually opened:

#include <linux/pinctrl/consumer.h>

probe():
mydev->p =3D devm_pinctrl_get(dev);
mydev->pins_online_state =3D =3D pinctrl_lookup_state(dev->pins->p, "online=
");

open():
ret =3D pinctrl_select_state(dev->pins->p, mydev->pins_online_state);

close():
ret =3D pinctrl_pm_select_default_state(dev);

+ all error handling and stuff, see e.g. drivers/base/pinctrl.c for
good coding practice.

Yours,
Linus Walleij
