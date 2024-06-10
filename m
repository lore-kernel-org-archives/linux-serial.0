Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDE514F9FF
	for <linux-serial@vger.kernel.org>; Mon, 10 Jun 2024 22:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718058398; cv=none; b=gUH8GR4VE2J/pHeTO1flgKmIG8EQcXb7Ygf9ph3hfMevhuigYEM9vu1vxRd/sZxcvYon2TOhAMF+o+GsV1AqkL2SPamh+7RY31hK0zz25dQ2GvVatuomBqBiE2SLlr+qgqfk3sN/b7nyDvnYjIuOdE0RQNVAPj2j/CDav52sdKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718058398; c=relaxed/simple;
	bh=UkdMo81OPxibP5QWCa3Q4ea2Hnlk2bNprAdwi0u0DcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=haIQ4euuaw9YTtMIPMYAx7o3mRV+K5mGmFKxXaIS67smyGtdV5ueQnyvph62QbxF3ev3accBkh1iwdtcWg1O6M4+FEuQ/38Xgsj50k8Pj9AB5/zFHuOXAucTsML8lwYmvQibgQ7mE+HMYS+TMWLQDiA7ogEvtn+QSqw74WsZX+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XyEZ9u1w; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XyEZ9u1w"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-62a145e0bb2so55291147b3.0
        for <linux-serial@vger.kernel.org>; Mon, 10 Jun 2024 15:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718058393; x=1718663193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KvmBLiFSEfvE3RppHoP2rx6eSDtIOM7lvuped6LOb5g=;
        b=XyEZ9u1wY/AQ+iyKr+Go/9jGA1pO2qf67YL+tEMV3AlBuUjqLvPVGQnJ9BTpAvAeOo
         Wb6W6s6t9XQNNFmKdRAhG98hOysGqWOWg/KJzuycRBZsC1rZRqEN6y8Us/0uZhf+vxbw
         +h0aD/GKPdvCyLGAVCWNZuNB+HNG8Mr/SaKz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718058393; x=1718663193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KvmBLiFSEfvE3RppHoP2rx6eSDtIOM7lvuped6LOb5g=;
        b=J4Vn3SiOmf7gKszBz9lTLrFb8E9LT0Q2xV8VL+yVXZhCCJyuxuAIqbyKeN8xMQ8grj
         nCpdNItlc33lznCgTOYqnx5/tbJKh1L7Bc3EJSXMK7FBANad6kuLqjzf7nfoxdQwv6cz
         gXgaBIstf42wo9wmCHJg940C619Oe9PJZqctkgdkb3DumQdxH2ikNYBlIa9Gfh3ISHk5
         HvOLapU6FJOF51dbBQeFZDV/Utpvw5s2CGAuK0Nqn7uGY+3fLkMZMm2YmTBzLHPvmcHC
         auB0oXa5z4qN7jS7guQd0BEJicyE7LxzEJX9NyggGiccOKuJP4LE+sgueG7SdEQ2sY51
         R8SQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7XP4XfphtB6tVn3H6N+Ekjj5vtQ29GotwULXzFloNv/5oWUT80e6Z8Vh9At7CSlewaX+HB8XC7N9/wMUnjHPE6G5Jplz76PvWiLkW
X-Gm-Message-State: AOJu0YxKkoF7nCgVJq+FdPKu1fFXXUviWhlC9p2hnrYIt0n98RTdSLld
	/YdAZj5iGCTc8mkcL+6tWY1q89aSb2OBAp12OC3k/Ge2WP97Efh5pbyXX4+DDfgK2TWxy2LMwVk
	=
X-Google-Smtp-Source: AGHT+IFyqT9CL736mco7zpt1w1G1L2Wt1BsgGXrnMVZCApQrG9OPiwZNSzRZJytRRH906mfAZLE/tA==
X-Received: by 2002:a0d:eb8e:0:b0:615:3996:5c86 with SMTP id 00721157ae682-62cd55d1179mr107039377b3.21.1718058392275;
        Mon, 10 Jun 2024 15:26:32 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b08c25d7a7sm998576d6.41.2024.06.10.15.26.31
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 15:26:31 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-44056f72257so122201cf.0
        for <linux-serial@vger.kernel.org>; Mon, 10 Jun 2024 15:26:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUrF1vlZCqIglHvL5GBusv5//Kd7qypXN02sQ0JMhSMAmKYQErkfy5Qo2ynP/ivak6DOVn1bIIrkyikKQoRrorqkYS4v7gSn3Uh9YRj
X-Received: by 2002:a05:622a:2990:b0:441:4be3:8644 with SMTP id
 d75a77b69052e-4414be38780mr17231cf.1.1718058391072; Mon, 10 Jun 2024 15:26:31
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604160123.2029413-1-dianders@chromium.org>
 <20240604090028.v3.2.I3e1968bbeee67e28fd4e15509950805b6665484a@changeid> <554749d5-5709-c740-b05d-bd4957d1e8d0@linux.intel.com>
In-Reply-To: <554749d5-5709-c740-b05d-bd4957d1e8d0@linux.intel.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 10 Jun 2024 15:26:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VLa1pZv1gy7WONzThopx6RXf_8Uh3L0wCWdY6_Mo1KTA@mail.gmail.com>
Message-ID: <CAD=FV=VLa1pZv1gy7WONzThopx6RXf_8Uh3L0wCWdY6_Mo1KTA@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] serial: qcom-geni: Fix the timeout in qcom_geni_serial_poll_bit()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-arm-msm@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-serial <linux-serial@vger.kernel.org>, John Ogness <john.ogness@linutronix.de>, 
	Yicong Yang <yangyicong@hisilicon.com>, Tony Lindgren <tony@atomide.com>, 
	Stephen Boyd <swboyd@chromium.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 7, 2024 at 12:50=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> > +     /*
> > +      * This function is used to poll bits, some of which (like CMD_DO=
NE)
> > +      * might take as long as it takes for the FIFO plus the temp regi=
ster
> > +      * on the geni side to drain. The Linux core calculates such a ti=
meout
> > +      * for us and we can get it from uart_fifo_timeout().
> > +      *
> > +      * It should be noted that during earlycon the variables that
> > +      * uart_fifo_timeout() makes use of in "uport" may not be setup y=
et.
> > +      * It's difficult to set things up for earlycon since it can't
> > +      * necessarily figure out the baud rate and reading the FIFO dept=
h
> > +      * from the wrapper means some extra MMIO maps that we don't get =
by
> > +      * default. This isn't a big problem, though, since uart_fifo_tim=
eout()
> > +      * gives back its "slop" of 20ms as a minimum and that should be
> > +      * plenty of time for earlycon unless we're running at an extreme=
ly
> > +      * low baud rate.
> > +      */
> > +     timeout_us =3D jiffies_to_usecs(uart_fifo_timeout(uport));
>
> Hi,
>
> While this is not exactly incorrect, the back and forth conversions nsecs
> -> jiffies -> usecs feels somewhat odd, perhaps reworking
> uart_fifo_timeout()'s return type from jiffies to e.g. usecs would be
> preferrable. As is, the jiffies as its return type seems a small obstacle
> for using uart_fifo_timeout() which has come up in other contexts too.

Sure. I'll change it to "ms" instead of "us". We don't need the
fidelity of "us" here given that the function is adding 20 ms of slop
anyway so might as well return ms so that callers don't need to do so
much math and don't need to work with u64.

This means that I'll have to add a "* USEC_PER_MSEC" in my driver, but
it still feels like the more correct thing to do. It also has the nice
side effect of allowing the driver to remove the awkward
"DIV_ROUND_UP(timeout_us, 10) * 10" because we know that the timeout
will always be a proper multiple.

I'll also add a new function with the _ms suffix instead of changing
the old one. The suffix makes it clear to the caller what the unit of
the returned value is and we might as well leave the old wrapper
there--otherwise we just need to move the jiffies conversion into the
existing callers.
