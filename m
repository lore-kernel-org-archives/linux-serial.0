Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ry9Vsx+X"
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F65DD6C
	for <linux-serial@vger.kernel.org>; Mon, 11 Dec 2023 14:00:35 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50c02628291so5249268e87.0
        for <linux-serial@vger.kernel.org>; Mon, 11 Dec 2023 14:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702332033; x=1702936833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DO+nyfi2K4OSqpRKBzov3KLKX0ti76DlsnoVE34DwM=;
        b=Ry9Vsx+XQSabBKuS+XB/P1KP99X88yn97FaD03VPCUg8Zym9rA7IgaD20Ko7nRjFYP
         1IjDxV1RLjNL4Of2LlYXPx5WuXh7WUazYgCnhNPPCWIqSlmxs4SloBu+9XIPos/+6hVe
         lawIElf+Stn1rVYs6xuGK17ywCO3lSP9sXUp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702332033; x=1702936833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1DO+nyfi2K4OSqpRKBzov3KLKX0ti76DlsnoVE34DwM=;
        b=tQZzmwiSAW2jSUuFfvFnRdzTZJq39EonBtea4lDf0AgmO3N0d+DiZxOduiDX8KG75L
         Vwx72xbVgQzomJPMYW0i0jb7YEImUQKgyrLLoKlzECgn8ODFLhReigddffp5DDQ30/OF
         09Legp9EWNkDTCw7DVG6np39w8XHMSu+gBGXn6Z4c6Eg4qXNfyjEnbFrf3juulTmcA7B
         E72u/kpg8V+oZmne8YML/XoBievxlim3GkkamLMLTXSuI6MnkhkViwGJbr4+ZFAtiaXc
         PUR/1wHCUsWjIzWecOqFSZmTDDY8OfY+lV6b3a6AkadidlW9oabFLrlrKizZLrmgOfFz
         BpwQ==
X-Gm-Message-State: AOJu0YwYAFSgW+OShbj/MSLROXJgJ6JpZEkLP52QFMCyqpzyto8qzu2K
	E9NC+Hpv32RXhn8KzlRDLkPEI1XucT5OGPNqFWXZm3W5
X-Google-Smtp-Source: AGHT+IEfeK4l7kpMyD3DPRnmqrqVB9Clmj0Vbvf4m+/kc+uBVSqOJFCq3XYy9/9PZy4MA9m7ll7vtw==
X-Received: by 2002:ac2:499e:0:b0:50b:edcb:98dc with SMTP id f30-20020ac2499e000000b0050bedcb98dcmr2279972lfl.128.1702332032741;
        Mon, 11 Dec 2023 14:00:32 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id m27-20020a50d7db000000b0054c0264a7fasm4197008edj.64.2023.12.11.14.00.25
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 14:00:26 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40c2db0ca48so5455e9.1
        for <linux-serial@vger.kernel.org>; Mon, 11 Dec 2023 14:00:25 -0800 (PST)
X-Received: by 2002:a05:600c:1e27:b0:40c:256f:756b with SMTP id
 ay39-20020a05600c1e2700b0040c256f756bmr256453wmb.2.1702332024792; Mon, 11 Dec
 2023 14:00:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208212845.1679621-1-michael@amarulasolutions.com>
 <CAD=FV=WthrukuM5e6VH4wKH0CQ5k08A_g_Ehpo-NsouxxCiibw@mail.gmail.com> <CAOf5uwmT3uFQhyTOkNDMana5na5jcKm81tdyeann2UnFwaQp5w@mail.gmail.com>
In-Reply-To: <CAOf5uwmT3uFQhyTOkNDMana5na5jcKm81tdyeann2UnFwaQp5w@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 11 Dec 2023 14:00:12 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WrBg9PuDW__pZbo5YNuWct17gcK4FF-xKeyxEOsw6Qag@mail.gmail.com>
Message-ID: <CAD=FV=WrBg9PuDW__pZbo5YNuWct17gcK4FF-xKeyxEOsw6Qag@mail.gmail.com>
Subject: Re: [RFC PATCH] tty: serial: kgdboc: Fix 8250_* kgd over serial
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Jason Wessel <jason.wessel@windriver.com>, 
	Daniel Thompson <daniel.thompson@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 11, 2023 at 1:42=E2=80=AFPM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> > 1. init_kgdboc() runs and registers the singleton kgdb "platform driver=
".
> >
> > 2. The platform driver's probe function, kgdboc_probe(), runs and
> > checks to see if the console is ready by looking at the return value
> > of configure_kgdboc(). If it's ready then we're good to go. If it's
> > not ready then we defer.
> >
> > So I think the bug here is that somehow the console looks "ready"
> > (because tty_find_polling_driver() can find it) but it isn't actually
> > ready yet (because it crashes). That's what you need to fix.
> >
>
> The polling driver look for uart and uart8250_core is registered and 4 fa=
ke uart
> are there but there are not still replaced by platform driver that can
> come later.
> The try_polling find it but it's the isa-8250 driver. It means that
> add_uart 8250 is
> not still happen

The 8250 driver is always a maze, so you might need to do a bunch of
digging. ...but it sure sounds like the console shouldn't be
registered until the correct ops are in place. That either means
getting the ops put in place earlier or deferring when the console is
registered...

-Doug
