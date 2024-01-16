Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23D51CD2D
	for <linux-serial@vger.kernel.org>; Tue, 16 Jan 2024 18:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705428815; cv=none; b=GPUKJFARYophPbqHYrDo7jbNt/eV+Dv2Z40+DKwxzN7o1zIqNPaQFWt7nPYN+pLYjoNB5P1NSdrreHler/uXBCKu5QIVG7l1dOs2Rd/wzHJi/bvBlOJvwLHFtd+5cwoKtm65dN9Va2GCtA6cGAIOUnvimba/VC6rwT0nLjnSE0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705428815; c=relaxed/simple;
	bh=VuJdDQsi3mmyRqeinzNAGN5yeAy5DGs8zpA7Gnrei2w=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=jc+ZJz484qZ07yOK6e1gAgZmQ9OxJPMxmf0Ogpfa+NgeeoNRrmv9IHRVc76ByMZd2NESNSsyEkKB5SGIH8uTpr6TFrfGAFLe90L3VA3aYIiE/Wch6RfeP4dECPTU8u3ePrF9F44UdeLMHuNusqHBVxvQQPMREjQvrYK2fLwQhSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KN2kb8mB; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KN2kb8mB"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3606eb704edso43359735ab.2
        for <linux-serial@vger.kernel.org>; Tue, 16 Jan 2024 10:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705428813; x=1706033613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjIZbfBCvKCg1WSRzAw5p1veNjGXMCanGfKSk9xh9uU=;
        b=KN2kb8mBtcScJ7fOGhTyOOYrUghJvGm49zenor5IQP5MDYAvZwb1fTTF5LGBqr1WLZ
         UtnESJZaHbdUjmIitRY4XS4BcTeZ7xbWXE+cmukEGSTPevcakCADSY9tx/EywqBT56JV
         ov+rbcAMMdmmT5pKrpstCoz7pkNOJq5AMu3sqnyWULTIK+6bYHHcUMo44wRS4SWLsJSz
         Xoejz5ngnkNO/mU6LY/c58O5o0E4ir9XNBRwGGQzDCUbkfZYuqhrdlNU8Qraypa7g4Ui
         NcuwF3cIvBMmfX88238gECs3O5OfRFvNsRLOfpNACI+QZad40somCo+Cbr0C6moC5i5c
         m2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705428813; x=1706033613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjIZbfBCvKCg1WSRzAw5p1veNjGXMCanGfKSk9xh9uU=;
        b=hT21gf4Xc9Ac7UqydIpAP/Ntf8pjKyM930SPiQ6/tlxgr4Qj6Jw6Ouq2PdrrJ3log/
         m6BVJ9hNUPqwC1Ca0o9hh4IPxvdLKQtherLM1t/vXUPotHGAOUyayJt1m1OI0RJbwOY0
         cA6S9t4KfpgcJmILSx2s2rFDCjfqfV0VsOMy1KJBVRgSbHwOhVVmy47Ciaw7jGfi7OFF
         CCOFqHz4+UXUFXMO/jl/v7nl1XMcPsr4glROzxqhtdleSRD8F768b3zBmQXIxFaW+Tq5
         Lml2U/6doNb9KPdEWuDoKTalkRVqom2R68HnIFIjDla0+o0oGrQAwFmAIYjykumfky+f
         i10Q==
X-Gm-Message-State: AOJu0YxpsmYO3C+d4ZLUdJACAOXe9ei5BETuIc93+a8OQ0UoZG5MEucs
	cThMvwQUXGRldXC7m6o8yHkCISxzSXNGzpnjrlpLZKAp++LMeg==
X-Google-Smtp-Source: AGHT+IHg5H35PYEEVlG5CAjQhp4Vgw+BUhaFLcX5a93zb87VvfJY7vry+G4Z8Xu/GiQMw/VBPGWw/29JhGAAebs2l4c=
X-Received: by 2002:a05:6e02:1248:b0:360:29f:b7a9 with SMTP id
 j8-20020a056e02124800b00360029fb7a9mr7406208ilq.3.1705428812938; Tue, 16 Jan
 2024 10:13:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110102102.61587-1-tudor.ambarus@linaro.org> <20240110102102.61587-5-tudor.ambarus@linaro.org>
In-Reply-To: <20240110102102.61587-5-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 16 Jan 2024 12:13:21 -0600
Message-ID: <CAPLW+4kMO=PMZn5Vntik6YYe+DnpYi7TEegG4D-EdGq2_ERwbQ@mail.gmail.com>
Subject: Re: [PATCH 04/18] tty: serial: samsung: sort headers alphabetically
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com, 
	willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 4:21=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
> Sorting headers alphabetically helps locating duplicates,
> and makes it easier to figure out where to insert new headers.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/tty/serial/samsung_tty.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsun=
g_tty.c
> index 74bc5151dad4..f37d6724bfe5 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -21,26 +21,27 @@
>   * BJD, 04-Nov-2004
>   */
>
> -#include <linux/dmaengine.h>
> +#include <linux/console.h>
> +#include <linux/clk.h>
> +#include <linux/cpufreq.h>
> +#include <linux/delay.h>
>  #include <linux/dma-mapping.h>
> -#include <linux/slab.h>
> +#include <linux/dmaengine.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
>  #include <linux/math.h>
>  #include <linux/module.h>
> -#include <linux/ioport.h>
> -#include <linux/io.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
> -#include <linux/init.h>
> +#include <linux/serial.h>
> +#include <linux/serial_core.h>
> +#include <linux/serial_s3c.h>
> +#include <linux/slab.h>
>  #include <linux/sysrq.h>
> -#include <linux/console.h>
>  #include <linux/tty.h>
>  #include <linux/tty_flip.h>
> -#include <linux/serial_core.h>
> -#include <linux/serial.h>
> -#include <linux/serial_s3c.h>
> -#include <linux/delay.h>
> -#include <linux/clk.h>
> -#include <linux/cpufreq.h>
> -#include <linux/of.h>
> +
>  #include <asm/irq.h>
>
>  /* UART name and device definitions */
> --
> 2.43.0.472.g3155946c3a-goog
>
>
