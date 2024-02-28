Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A693FBB5
	for <linux-serial@vger.kernel.org>; Wed, 28 Feb 2024 17:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142341; cv=none; b=tE3io2JtWlz760HYvdN64lld3PnUwVUeIMq/jGXw+lue5tXjyV2QygkQrCpoDNKzKDlTJiiYGSnzCj+OQ0Dnao9WRFewzdcvV+oqrCzT5dUVKR5ZhNHuDlgKnymn4u5otzOoKozuQMLKf93PfGa16ehQ/R/AnH6tRe67AdkPa1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142341; c=relaxed/simple;
	bh=pUaeyA1t/rs2uzTjJrQTsg5iLayiDuVVh8zG9dCZ9DU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qd603Qv6vby730FzSLT0eXxubBFTwXEX0lvtWTbQUEJHrbb8qlIxt1YBBpMwshcTLcrGwOUNoN9x+8Or03oa3daJiplLqY6SsEwIQ0ulsMemF8eHQ89mUCmzLNZ6pfrV0V4+GSQhIDyWkgdUyB8R/bRovGTJmNurEpA/riSS+AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FSGHRSdv; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FSGHRSdv"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512fab8cc6aso16e87.1
        for <linux-serial@vger.kernel.org>; Wed, 28 Feb 2024 09:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709142338; x=1709747138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sLd6gl83kt/yJiJj67OWnBmLsYqXa7Dtm6HPJ0SDlA=;
        b=FSGHRSdv2lNssb4d6zfbceXnDNsXAwsvCB9qIbg7TsTcVsKqL6ppwNStBuT5RVoCdT
         GU4BSAV6qjX0MS9euKkLxqUv7eljcQpfXe4AFxHdJWRizxJVfB3W1gMRBZlSUcshXknf
         bJF41RC+TemXmZ/KHyTIwBg5MrfgdEHMKrlmh+xpezBF/t0tK3A+NOoJpJX/M/6N9nZA
         Yutr8Qd51uaKm8x77ivUEvrTH8IrhHXGf8lLPCYN1b2mYiRv9Dw+81TDVkBoY4/eOWx+
         6iEluejMLVsQ50SU4HK3F30sa5LO6s5sBC0lhTsmfTpTb6x6iH3LbF88nySZA7zyfnE6
         CqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709142338; x=1709747138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+sLd6gl83kt/yJiJj67OWnBmLsYqXa7Dtm6HPJ0SDlA=;
        b=mGPnJf0magTTZc/hfnnIfpeaMITIMCx0AvDvwfiDEn2L8QHWXtQyFgk+t6uw/i/GIq
         qCcO+Py1kBIU9QbUjrLfxhTlBt1gdwxO0KHr2VOZEttNdzf8cYVRs3ryKKHeOtoQMVvA
         JSlUP25lXJEjdh98U1eqPI4/YPrCr301rSysoyTld8KQCM+fT4Gm5ziuagO0fHKCAzAR
         2S3gV44bL/eqvybv26Hk/ydgG4BnbGVHADQ6V0Ch7vPWmBT+oKilLs+NNhpfL8GY0T1x
         Klwo/r7PG7HNulpaSc5NVYGann/vOVziwIQ5nRxGaAAGKhJFBX3UnzvEUgfyCTgxbjEj
         PUVg==
X-Forwarded-Encrypted: i=1; AJvYcCVsre/oFSTUjKWWHbyf8KQXXvGS5mda4qAL+CVHi99mK3GAMGi0ZZG0CNUapq1lZtwyzKhaeUcwz+dE/M6VEEjSP6QomvRtXWl0/DqM
X-Gm-Message-State: AOJu0Yyxy+zQRgiNsuL05kiBwlEQUV7DPOiL4h2NIQXSXhKl4rqtBffy
	B+LtYabDs3LlFFV3NQQVSaYeEiTHMHbNniaekKL7p1oVyqc++cNI1gug/0GWpUZ2W4Jyo660l4l
	bjh2BBbLxw7Z7AilQoU/cMMHWKG0yRriLR93jOk0TJu5ORRMCgLr+e4ILfA==
X-Google-Smtp-Source: AGHT+IG/tXhJv1eez6FYw/IOUUcTdcY9BK5YkbVZ3YYCk/UxhnvEMI4/+5XTxSSgL7PAQRhIO5b0VcaX0P0pGnX31pU=
X-Received: by 2002:ac2:532a:0:b0:513:1e32:56c1 with SMTP id
 f10-20020ac2532a000000b005131e3256c1mr58368lfh.0.1709142337777; Wed, 28 Feb
 2024 09:45:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222111922.2016122-2-u.kleine-koenig@pengutronix.de>
 <CAMTSyjrKVL12CrXuqJhWydObhYfgLF=zKTE0U0LdzimTT6Sdsw@mail.gmail.com> <Zdy-X37encfcr9g7@smile.fi.intel.com>
In-Reply-To: <Zdy-X37encfcr9g7@smile.fi.intel.com>
From: VAMSHI GAJJELA <vamshigajjela@google.com>
Date: Wed, 28 Feb 2024 23:15:23 +0530
Message-ID: <CAMTSyjodFe0K_0h3R1d1JRYCHMnHhVCjhCSWRLGuzB46Gx+SVQ@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_dw: Emit an error message if getting the
 baudclk failed
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 10:07=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Feb 26, 2024 at 09:30:53PM +0530, VAMSHI GAJJELA wrote:
> > On Thu, Feb 22, 2024 at 4:50=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
>
> ...
>
> > >         if (data->clk =3D=3D NULL)
> > >                 data->clk =3D devm_clk_get_optional_enabled(dev, NULL=
);
> > >         if (IS_ERR(data->clk))
> > > -               return PTR_ERR(data->clk);
> > > +               return dev_err_probe(dev, PTR_ERR(data->clk),
> > > +                                    "failed to get baudclk\n");
> >
> > Not required IMO as the baudclk is optional,
>
> It adds verbosity to the cases when it's defined, but for some reason
> can't be retrieved.
ack
>
> > otherwise it might ask
> > for a similar change at apb_pclk.
>
> If you need so, yes. Send a patch.
Noted
>
> > Could you please provide some insight into the circumstances that lead
> > to encountering this error case?
> >
> > Also the check is for IS_ERR(data->clk), data-clk could be NULL aswell.
>
> Yes, and that's the case of everything is fine as the clock is optional.
> Do you see any problem with that check?
No problem here
>
> > I see any error should be caught at the following line, provided no
> > clock-frequency
> > ```
> > /* If no clock rate is defined, fail. */
> > if (!p->uartclk)
> >         return dev_err_probe(dev, -EINVAL, "clock rate not defined\n");
> > ```
>
> Not sure what you meant by this. Even if we ask for an optional clock,
> the error condition still might happen with many other reasons besides
> the absence of the clock.
I was looking for a reason that the author has encountered. Error condition
on an optional clock might also fail `p->uartclk =3D clk_get_rate` and resu=
lt
 "clock rate not defined\n" error.

>
> --
> With Best Regards,
> Andy Shevchenko
>
>
