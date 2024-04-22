Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F881C6B7
	for <linux-serial@vger.kernel.org>; Mon, 22 Apr 2024 21:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713822869; cv=none; b=P3LyxizmHJCoMPJkgvuaxc4iyTUgsal7PfIsfzfVuJOx+ZfrjevfXfZbTmbrg6V9VzIpM5BlIFxf/ar7IHtLtKOD/m2B4DbtkYS4Sodb2ppHGD/n4Zs5RLfJb6Fosk28HQe5xTfM/PWwFPEbYNrWgHkHg9jd0+WPm9O4Es0NXN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713822869; c=relaxed/simple;
	bh=Cbt4igSSEOCM0YFndB3iSaxU9eb8wKebvbCilWGRQq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WNQREnkpW2Tn3Xcsr9G0sC6f12fwjOC+0mc+TmnnHqTz5eGLCtytPwDoW90UFFmPyTxZrwe+5r4/KV1pdexPPjTzVzOnrmxlY/ptF2CdrhFcq9OrIewFznPP5+qsF+gEw42AAOZewnpdvhJhu9mcYk8QkKqiOXUqTWd6pbseuIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YEhU+RcZ; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YEhU+RcZ"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78efd0fcec4so319977185a.1
        for <linux-serial@vger.kernel.org>; Mon, 22 Apr 2024 14:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713822866; x=1714427666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4TkjiOmnf7EkU2uUP7WyZ/U9eWwbiO9i0mpJYmLC7M=;
        b=YEhU+RcZ9DG2o7bbTF66ZGEe048wtODeAHs9XyalWF2RbKwputMXN8iO6AKtloNE2h
         w91eHwIG6eQck4zCHy2TtyZIn1XkQ27G/BuAhLRzlXmz6x93m7BuHDy9ehA753o6M+7l
         uEFucKm4ECEWoun3DuBvQN9DpWAaINC+Z5wL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713822866; x=1714427666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4TkjiOmnf7EkU2uUP7WyZ/U9eWwbiO9i0mpJYmLC7M=;
        b=aKiNrjF6EALFswDsNht70RD46DoAugENRf3cM2fsGk3flFnar0HLJlzk2Y9xak+wtO
         3xi13OjWkNM666YjoY+YHgJKtWy4GJjdGQT19TzHBeTLFGTM1EpTdzNqyMv0Znep9ftu
         1vM4evVBB6pZMvG9br2vwGzgftTWdYe64Rafs3T2DU1pJbzLgjw/k/YkUPulqhsj6YQE
         sN77qApbV64TlSR/DVGNmGWuytwiqieCmR0AuKnJgddAljj83swJmLFjeUJLePQqSinm
         fqqoiMVg+qiMqXnPnlCtCfE+VwakYAwH5MSolbY5bI/P55Or53OpvRMEw4KBdPYqQoyF
         Zw2A==
X-Forwarded-Encrypted: i=1; AJvYcCWOfiESVcRknTiuyEcKa9JGniweteN4RLA5ORI9TYlI2tbRmeO5dsPYXa6PH8LoezzLCytd7r6mY4au1BQ61u9QjnyAuQCrPNAm1BHs
X-Gm-Message-State: AOJu0Yz8T68vHjiq5RSM9Ljf32rrNyR5P/po9LOp/uPhYoGynxfIE/1R
	xqU4+OC2pCXfRfFl2QFNCcrSW4jC7PKwIMAioz2RZs2CBiSCgFNn1zPt/iYeabbjIXfF2ksBNz3
	zG18h
X-Google-Smtp-Source: AGHT+IE+YKGsl3OM0Y9sMX2xmywGKl8XuxMl/bX9tK6TiQZOiT+vGKMvwBKdj9PapavGjRNGcosBcA==
X-Received: by 2002:a05:620a:5583:b0:78e:fcf0:40a5 with SMTP id vq3-20020a05620a558300b0078efcf040a5mr12494490qkn.76.1713822866204;
        Mon, 22 Apr 2024 14:54:26 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id l22-20020a05620a0c1600b007907ef72e1dsm359286qki.36.2024.04.22.14.54.24
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 14:54:25 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-439b1c72676so60271cf.1
        for <linux-serial@vger.kernel.org>; Mon, 22 Apr 2024 14:54:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX7LJ/TckKm1101rNKXJ2veP5+nbWnk88vaD3Pk1tNbj8PvneRIGQd/1fjOW1JJbdfDo91Od4tOm1xk1cRwbzXIkflGCa1hjc7XgM+L
X-Received: by 2002:ac8:550d:0:b0:439:9aa4:41ed with SMTP id
 j13-20020ac8550d000000b004399aa441edmr95963qtq.16.1713822864486; Mon, 22 Apr
 2024 14:54:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419-kgdboc_fix_schedule_work-v1-1-ff19881677e5@linaro.org>
In-Reply-To: <20240419-kgdboc_fix_schedule_work-v1-1-ff19881677e5@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 22 Apr 2024 14:54:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UHt7Pm-qEBs7vtK0B0DCbu9YbU465OdpSKCYZVpNuOaA@mail.gmail.com>
Message-ID: <CAD=FV=UHt7Pm-qEBs7vtK0B0DCbu9YbU465OdpSKCYZVpNuOaA@mail.gmail.com>
Subject: Re: [PATCH] serial: kgdboc: Fix NMI-safety problems from keyboard
 reset code
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jason Wessel <jason.wessel@windriver.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, Liuye <liu.yeC@h3c.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 19, 2024 at 3:30=E2=80=AFAM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> Currently, when kdb is compiled with keyboard support, then we will use
> schedule_work() to provoke reset of the keyboard status.  Unfortunately
> schedule_work() gets called from the kgdboc post-debug-exception
> handler.  That risks deadlock since schedule_work() is not NMI-safe and,
> even on platforms where the NMI is not directly used for debugging, the
> debug trap can have NMI-like behaviour depending on where breakpoints
> are placed.
>
> Fix this by using the irq work system, which is NMI-safe, to defer the
> call to schedule_work() to a point when it is safe to call.
>
> Reported-by: Liuye <liu.yeC@h3c.com>
> Closes: https://lore.kernel.org/all/20240228025602.3087748-1-liu.yeC@h3c.=
com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  drivers/tty/serial/kgdboc.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index 7ce7bb1640054..adcea70fd7507 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -19,6 +19,7 @@
>  #include <linux/console.h>
>  #include <linux/vt_kern.h>
>  #include <linux/input.h>
> +#include <linux/irq_work.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/serial_core.h>
> @@ -48,6 +49,25 @@ static struct kgdb_io                kgdboc_earlycon_i=
o_ops;
>  static int                      (*earlycon_orig_exit)(struct console *co=
n);
>  #endif /* IS_BUILTIN(CONFIG_KGDB_SERIAL_CONSOLE) */
>
> +/*
> + * When we leave the debug trap handler we need to reset the keyboard st=
atus
> + * (since the original keyboard state gets partially clobbered by kdb us=
e of
> + * the keyboard).
> + *
> + * The path to deliver the reset is somewhat circuitous.
> + *
> + * To deliver the reset we register an input handler, reset the keyboard=
 and
> + * then deregister the input handler. However, to get this done right, w=
e do
> + * have to carefully manage the calling context because we can only regi=
ster
> + * input handlers from task context.
> + *
> + * In particular we need to trigger the action from the debug trap handl=
er with
> + * all its NMI and/or NMI-like oddities. To solve this the kgdboc trap e=
xit code
> + * (the "post_exception" callback) uses irq_work_queue(), which is NMI-s=
afe, to
> + * schedule a callback from a hardirq context. From there we have to def=
er the
> + * work again, this time using schedule_Work(), to get a callback using =
the

nit: schedule_work() (no capital "W").

> + * system workqueue, which runs in task context.

Thank you for the comment. It makes the double-jump through IRQ work
and then normal work clearer.


Other than the nit in the comment, this looks good to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
