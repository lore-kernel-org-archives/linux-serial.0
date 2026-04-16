Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AB439DBF2
	for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2026 10:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776335013; cv=pass; b=Ot19jXwnK2Vx5aweWeMYiLnHw4TC2dOxSMuuJGk0ZwshlOLrci99Et2syB9eCNXojmzbKJhvFPae9CqHyJDbK0KFNVRaq01TrqZIMvyONzICEqbR/euT0QF6Exd31MYyBOwDxLDSDbE5MgXp/LrT5LiymVuPjKR68MK0XdBBzKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776335013; c=relaxed/simple;
	bh=LbTzRS7v1RQTEFBbLZEgMN4JOcHAPPaG3nlUPacsRSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHGUdl9vBazFrZoYvIIQTByuOJ8pdQxICiFTq/09S5oBxxtzQoMpgun4MclFiBU3U8uUxRXNoXxye0YwVGpDLDNh9+99dAhmKKN5rpx8VrdfuiRXwP8JpOBcVra/aHnwKIYx2uPppLva1IFmmLlN4696JeEgVCzSgTBeNOe12/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9pFIaBS; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9pFIaBS"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-651b0eb2564so5711999d50.3
        for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2026 03:23:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776335011; cv=none;
        d=google.com; s=arc-20240605;
        b=Ey6zFXvngznfJLDVvGwQiugmF08COmMgWJqWyEy1i+hE2oi0bVKeXLmzmIX5U9OQlk
         XahD5TudJOxBAeUQj8T4A7AvrhU+vbs/ZuXkQA/TRzDaGdGAolTY0BROG08TR69szbuc
         m36OVO2cw56LkgqysM7Fcjzl6AyvyqLrkXQMAF9plGMVbFSTPS3wUql5ioZrfpfHx73W
         mj/h9Fe9tAg0oBKFr2J7JQ/ocmOjhJkoCtVrK0GHMQxtwZD9lUfaVlRt9R3fW8yypJut
         IeDTZPqZ21WbSkSlGCNEeK8OK0pU8sEuHoqqkSJaKbfKEcVsdRwlxMNyKql1MM2u07PS
         Ugfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LbTzRS7v1RQTEFBbLZEgMN4JOcHAPPaG3nlUPacsRSM=;
        fh=ti7CxfQwNY+XvIchcL46fx6txb7FxfyKPyKdighCo0A=;
        b=RXbF2WM3T47pDxh7LmQGoQP7vfu20L7dZoFk60wUYHpkfU9Qnhc76KHbGpTyFxMMvZ
         kqiiYCIxsTdR+lsaUNJlXRYkE5ZXhiH/Vy+IsT6ecNx41xGP5jGn+2AH0xuDxuLEAMPO
         FPwBo/nXiFhAGowvi1CUakyRD29orwxd4Y/SF0/sn5O67wbM85M4Mx0qt++ju5hUMz5+
         /VFlrjvp8f7sjBVtywpw88tCsdyS1ebHycEpS3gvMg5CVN0GwZnrBH29VSPiX9WxQNL6
         uEN1nWrgvADBenByyNQ0rUK1rTn2x2205FPzwaSHiTqHfwsVBE9HWMzd1aqBAYEcogrf
         MwDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776335011; x=1776939811; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LbTzRS7v1RQTEFBbLZEgMN4JOcHAPPaG3nlUPacsRSM=;
        b=H9pFIaBSWUfwB9RidOxbGZMjFRrZ/3N3NGzJFirU7eXnhdwofkOpDo0m/3CylWwzDn
         H6lrjwGi+0F9QzKMAUzMMsXtUKVpYa8nJSKb3xdJh71gS47aLZwpW+LxR/kpxLqwc3Cp
         7Pn+r0wBMUysPTz7duEDGI17GuEVcfEBEfthH2xZeAcrdnUFchKI8vBO0NrONHYyipq9
         l2v5u2XUSc53A4JHkQ4HIvXk5GLxJeOTdJFESJddXzS9csCeeQoK2tvp4i3t8nH4Gu7S
         yg4GhZuCRaJ548Vogbs6HzwdfGiKUJRZSYwESKncXr5BL2O48+ieaxINxhSUiW32uj0E
         jAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776335011; x=1776939811;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbTzRS7v1RQTEFBbLZEgMN4JOcHAPPaG3nlUPacsRSM=;
        b=bDykvRb9eUyqYsbHmHhDB5SxHFmhzVpmmmN5+ZfzUyj7CSJ4ayXpQjrlFnLkfWHAMo
         b5QfM8HlX3zZI1BcDrVxMA32+y/MmouqWEFBBjEcdZKJmMxfOKhxm1UeBGQxloXCZxlO
         3fRKSFxVvgjx7cl7GXjh+iQuhoUYpkxXljVhR8ZnyI/Ltp69sWmNzE55pwKJXkRxzVFE
         8Xp3HYnblaK80iFMc4QhmZtvUJ6zlJZqhll0nrdPKva3AgTnFCpaWds5RObQICQQmjo9
         IWsl40ksYBP0ja9LlLVPcqFuuhBGyemZB5V/1D1bDLSyP+wu5bV/P34Bx2S5q4iok/JZ
         bBjg==
X-Forwarded-Encrypted: i=1; AFNElJ91u3YfBzDX6gxN1Y9gogmflUnm7IqRdRsij2BxNEFLvPKvgzC32pZldxOU+dBWCUXdbrc3DZseza+PhlI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzl+2Ji4a0ZLsBJtdQt/UyrxjTe10b1EhfRS7u3hr/gEYDoAzS
	zoIouGg/K3M3mbghmAE1t8WdsopRcmmfneaMgeqJIzSvDh1MkTbnGuxR/moqFHbhYCYG7UYoBcS
	XiqUu45FVxqLtEMgkpREbfkVFtsAYg5o=
X-Gm-Gg: AeBDietT4990kr2iYf1lP+QrllSpbSumSOntbvp5kaJ4OJuG3qBX3HuQdQr8/KuPzvm
	sKLd3Ww9uRk6q+JQTfCQPIjKE523ehLQx8/g2SaV50oMZ+olzYiJOxXFGCeIPoPCpaVEJS+BQ8r
	dIVcf+mQnJE58FziKdnz3cZYuTqLfNz8IyCmUVdxAeBuoZ1fmYWIdwIdaH4jlmCItOSF2f7qsyB
	nQ0CmwBuvc3Pg6Z4D/8za1A/wquWMCBfhFBgU52y/WRzCrLckML2M8Ys7aQdJrYzAYZmld93ICH
	Xo+UzkrZriu4Y7JRjktx
X-Received: by 2002:a05:690e:4011:b0:651:c71d:8a74 with SMTP id
 956f58d0204a3-651c71d9744mr14382278d50.46.1776335011072; Thu, 16 Apr 2026
 03:23:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415183436.3763871-1-lgs201920130244@gmail.com>
 <463cec4f-a038-4bd0-90df-76e0ef48381c@kernel.org> <CANUHTR9toK-PS8qrTd-=ATpSi8xbnXmF87sfRaMDp_jG_eiVMg@mail.gmail.com>
In-Reply-To: <CANUHTR9toK-PS8qrTd-=ATpSi8xbnXmF87sfRaMDp_jG_eiVMg@mail.gmail.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 16 Apr 2026 18:23:17 +0800
X-Gm-Features: AQROBzDJwF5nR-YRaxJ0GiQSty_8vbImmxuQxj_nDAtrvfhqoyQZXUThlhF2q1Q
Message-ID: <CANUHTR8Hje-pP=7=2hLwkhPMb6cMWosDzdY4oLneFpH5-hfS-Q@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_accent: fix reference leak on failed device registration
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk@dyn-67.arm.linux.org.uk>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jiri,

Thanks.

On Thu, 16 Apr 2026 at 17:37, Guangshuo Li <lgs201920130244@gmail.com> wrote:
>
> Hi Jiri,
>
> Thanks for the review.
>
> On Thu, 16 Apr 2026 at 14:14, Jiri Slaby <jirislaby@kernel.org> wrote:
> >
> > Hi,
> >
> >
> > What reference exactly?
> I was referring to the device reference initialized by
> device_initialize() inside
> platform_device_register(). My reasoning was that when
> platform_device_add() fails, platform_device_register() returns the
> error directly and does not drop that reference on the failure path.
>
> >
> > How did you verify you did the right change?
>
> After my tool reported this case, I manually audited the relevant
> source code and
> checked the related core API definitions. However, I did miss the
> special handling needed for a static device in this case.
>
> > In particular, what does put_device() do on a static device, even
> > initialized, ie. with no device::release? Try it...
>
> Sorry, I should have considered and verified that
> more carefully before sending the patch.
>
> Thanks,
> Guangshuo

We are also discussing in another similar patch whether the
better fix, if any, should be in the API/core code rather than in
individual callers:

https://patchew.org/linux/20260415174159.3625777-1-lgs201920130244@gmail.com/

Thanks,
Guangshuo
