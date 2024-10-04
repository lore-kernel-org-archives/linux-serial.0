Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB471D8A1D
	for <linux-serial@vger.kernel.org>; Fri,  4 Oct 2024 19:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728069816; cv=none; b=C3kYtpr/QJBkbG+Vd3HwEPWMbOuD4emtsCDnJliKM/6cGwu2TzIEO+dHtjyaLlJu4tTJF5Ft6vkiMbOCqfHBNun6E0jg8Xgq3aM56PuY5EYiBhqGPBRRZZY/WgdHVQ4lM02fsYzdcR6476LBd3AjIQRe9lcLPD/E2IiYENadgIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728069816; c=relaxed/simple;
	bh=LIHBlJDrk0SjV7GfXmASvYTBduv7AtQJsAwnpPnT7E4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mavtu4QY7Kr1uyVv+NNTyLiwZUrV5cWL0YvoiBsgz3Dup+T/3HpiAAER1K7y4XZAQJcoW3dOrmFKyYP8pM/0xfSxJlpSPm8jHkNCb/kryvpq816qhPcVegvbKAW1QcA0BBScxmYxufON5SIb3gcjbpewFWoC+WLRb7jxVtFuW4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=baylibre.com; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71de9e1f431so813847b3a.3
        for <linux-serial@vger.kernel.org>; Fri, 04 Oct 2024 12:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728069813; x=1728674613;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HVP6wZY3TdnTPrvNs2XHPwde52TP9y357r9JHUGOqcY=;
        b=wz4dzxMOFnopBO6rs0JFHwsyhUuMcPvtbDhipj1G9x+QQZumE+FtSdESKT20oyNMbQ
         AzzTYcFNB+4D3STlGfw+R4d2hjVQyNC9j+1jsxwgP+sdN03WMsWzXVE9IIrkbBVB9zXN
         GslRiCc9lZ35LHXKPq911Lua/FmiFrZQ28plYGNvt0bS70HoWbqzi/0VdmomDhIAGUMi
         pk/5N8aGC5Z+muv4o/UgraHL7pfARdw5nNadvYo8TRwC3vVxiah0fGTgGzg75Fb0A25g
         v5n0rJDySvl/RJZc6fAH3XTYtGwqpQ3UpQpHCmUfRk5rl/ya4Qj2zOSXPCB3JF0Z4o4M
         pHgQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5s2IWYuWbSwXvIQqypm3eMJ8xjf3YNiq7cQ3Xa1MpaMuN8MJaw00iva9lo3hOZ8ZV0le/1yMDSxLh0ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP5ZCSG3/FIsmQn0BLLh3G8ZlF2PARL6bXRkiInEfjLohPe7pa
	OsKOhMJFzzyr5okuzZoa/qXbghrz1P5G2dQSw0DLukFPEsAtcij4w/Dbrsukf1I=
X-Google-Smtp-Source: AGHT+IFY/GbIjby5jeGcx5GC4nUtT59Yfq73X+l91j/pZJ2Qxem06oYk62q7xSsFfvdY7BpnYHgWWQ==
X-Received: by 2002:a05:6a00:3d0b:b0:714:17b5:c1d9 with SMTP id d2e1a72fcca58-71de239e82dmr6207456b3a.1.1728069812981;
        Fri, 04 Oct 2024 12:23:32 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d47990sm219412b3a.138.2024.10.04.12.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 12:23:32 -0700 (PDT)
From: Kevin Hilman <khilman@kernel.org>
To: Thomas Richard <thomas.richard@bootlin.com>, Greg KH
 <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, tony@atomide.com, linux-serial@vger.kernel.org,
 gregory.clement@bootlin.com, u-kumar1@ti.com, d-gole@ti.com,
 thomas.petazzoni@bootlin.com
Subject: Re: [PATCH] serial: 8250_omap: Set the console genpd always on if
 no console suspend
In-Reply-To: <3fbe606e-fb0e-4ff8-924b-a8bbe046ee4b@bootlin.com>
References: <20231017130540.1149721-1-thomas.richard@bootlin.com>
 <7hzfplplfs.fsf@baylibre.com> <2024081318-litigator-slinky-8f0b@gregkh>
 <7ha5hgpchq.fsf@baylibre.com>
 <b8faffb0-7ae6-4f20-a8fb-34222535b623@bootlin.com>
 <3fbe606e-fb0e-4ff8-924b-a8bbe046ee4b@bootlin.com>
Date: Fri, 04 Oct 2024 12:23:31 -0700
Message-ID: <7ha5fjlljg.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thomas Richard <thomas.richard@bootlin.com> writes:

[...]

> I finally found the culprit.
> Just adding the GENPD_FLAG_ACTIVE_WAKEUP flag by default caused the
> panic, even without the call of device_set_wakeup_path().
>
> With some debug, I found that the wakeup_path of all my uarts (even
> other uarts not used by the console) was set.
> So the corresponding power domains were not powered off [1].
> Consequently they are not powered on during the resume [2].
>
> But on my platform (J7200), the SoC is fully off during suspend-to-ram.
> Even if a power domain is not powered off by Linux, at the end all the
> SoC is off.
> And if Linux doesn't power off a power domain, it doesn't power on it.

OK, so the core of the problem is here.  The SoC firmware is going to
power of the domain during system-wide suspend, no matter what Linux
tries to do.  So there's a fundamental disconnect between what Linux
thinks is the state of the power domain and the actual hardware state.
I'm not sure how to work around that other than if the firmware is
always going to power off the domain, then GENPD_FLAG_ACTIVE_WAKEUP=20
cannot be used for that domain, since it's effectively ignored.

> The wakeup_path of all my uarts is set here [3] because devices are
> wakeup capable [4].

Ok, but now This behavior is now changed in v6.12-rc1[6] (introduced by
this[7] series.)  Now, UARTs default to wakeup capable (not enabled),
and wakeups are only enabled if the DT property `wakeup-source` is used.

This should at least allow you to focus on only UARTs that are intended
as wakeup sources for the platform, instead of the current (pre v.6.12) beh=
avior=20
where all UARTs default to wakeup-enabled.

Kevin

> It was added by commit 8512220c5782d [5].
> If I remove the wakeup_path modification (diff at the end of the email),
> Th=C3=A9o's proposal works well. But it's probably too rough, and I have =
no
> idea about the impact on other platforms.
>
> If you have an idea to fix correctly this wakeup_path issue, please let
> me know :)
>
> [1]
> https://elixir.bootlin.com/linux/v6.11/source/drivers/pmdomain/core.c#L13=
72
> [2]
> https://elixir.bootlin.com/linux/v6.11/source/drivers/pmdomain/core.c#L14=
27
> [3]
> https://elixir.bootlin.com/linux/v6.10.10/source/drivers/base/power/main.=
c#L1687
> [4]
> https://elixir.bootlin.com/linux/v6.11/source/drivers/tty/serial/8250/825=
0_omap.c#L1526
> [5]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D8512220c5782d

[6] https://elixir.bootlin.com/linux/v6.12-rc1/source/drivers/tty/serial/82=
50/8250_omap.c#L1525
[7] https://lore.kernel.org/all/20240807141227.1093006-1-msp@baylibre.com/
