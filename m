Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEAE14A0BC
	for <linux-serial@vger.kernel.org>; Thu, 25 Apr 2024 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714063235; cv=none; b=H+H4nw20TPjj8H/IxKMr8QsWmMACSslb/kQFPGDj2EPnvPWao1ZLSFzn3HQPtnFuECFvNzhBOZX6eUAvmZFq7GeyGaIoMbHwHO8IYX+DC24eoSKbw95Phsrp2EYB2mmI7BQX8OOBZh6qHcsS3YhDchmPmB25IKOF7uKOK0Tj/Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714063235; c=relaxed/simple;
	bh=I0I9OjDY6ZUYLhQWHYC4HdS5DXN9XX3/1jiMOmIL9iY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jF9z3XqGwEK22D3ioHNeIBh+m23IHe6N56dNRI35SIfsIxwnbFzBDtFZ9BYM3AJcyyuoqQwOERRDYLVr2VEyDwKkTdJYBFoDqoOsb+F4tHoyKeEO2TRR9WejRLEhHbGWpVG0ljoQOHqrdbf4NNup/MtLQvMKrkRPFMk6B4oLIVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jeCTfEM1; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jeCTfEM1"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso1372413276.2
        for <linux-serial@vger.kernel.org>; Thu, 25 Apr 2024 09:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714063231; x=1714668031; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=on0OXtQXZAF4hN5oeel24iXAsrlaEJyKDQRWWo0Y57k=;
        b=jeCTfEM1GEAUxWddBeDx90ztJGb4g+1SI+T7H7M2QRs4ek4l2GN3Ucg2XM5HCPZY51
         /aWjYM82FgiJH5QgsUXgi/30l+wWyYduud93Y6YqoZe+p0P/ktHmrXuGxtUEwTvq8HFV
         ksT6YGcUo/2tjliuDR5HbqpGn69Kr6DysGp2zuSw3jYJfAXwLQRK7CJ9lenzG61ceSKs
         zDmpvGZ4KwxRIXEjkjGXCbqR7KnFic0iesolCCgRSSfc8FurxfNkbmy2d5fZcuUpg7bz
         vScelWXfdXjRbwv/v8bmjo9nUdr0CyAgr2NDtZf104gAPsP7M/m1TEKdmV5Rqismtvh5
         5LAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714063231; x=1714668031;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=on0OXtQXZAF4hN5oeel24iXAsrlaEJyKDQRWWo0Y57k=;
        b=lS8seClvPDEz3wodKRoYSVvYj2TStcPwWU/QVKFMnNfENlfM8IQ3Zldvln80vKLBR4
         hPyHr/oDyxJH9yO9dnWWS+BYS5D66L1QSj8eAL2FZkT3Ur5bKT1MX/6uI6f/Xy6ZUIeW
         hsEc5pW0YC4y5uZSLFVtqDDti6285GP/na2N8VbM3P30SyCaIpQm40ZrBQaIFDEbDfps
         YVzHtqJdOo2RH0SZBufZQGn/UOyjmqCYwH0Xgx8UM9vo0VnqqYu0+MScD37MIP7e0Av6
         caWqByAeFMEkrOgGTl2HrAv3UY0JPilKpY5NFqcrAWTjlPj7EaTeBuoC1yoOKgE4h9HC
         BuZA==
X-Forwarded-Encrypted: i=1; AJvYcCU5Pur0pexEUF3qG1zchGZOq8TGfTyqPzNvdPmY51q+31OVNH2VQbu1xcZZjZtKBTrjW1aQoETESUw5ScWPv3nHuDavvueinPhRtpMx
X-Gm-Message-State: AOJu0YwYGZ/wi+zu+ZeolBUFkglJRaw74Bog2uYPI5Ag1Vd+Y2rWGwNZ
	ZCZTMOi1WD8y386mD/I4aSnuzMv3LEi2bKADuk8F3e5MNSZYhNQTkjsHnxBJJJEr3GH205VtK9l
	UXUTVxwHucR2md7IIKYWb+AuydCIffmt8+L/QIw==
X-Google-Smtp-Source: AGHT+IFRDwfaHEmXM8hJbg1JGB6lXNf5vDJAZiG9Em8ssKQctqcosbRFy7Xmc+whUbdbZzEUxpYTm7GpckYnJLSaZWg=
X-Received: by 2002:a05:6902:2413:b0:dcc:2f09:4742 with SMTP id
 dr19-20020a056902241300b00dcc2f094742mr166378ybb.51.1714063231005; Thu, 25
 Apr 2024 09:40:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425070936.547100-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240425070936.547100-1-claudiu.beznea.uj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 25 Apr 2024 18:39:55 +0200
Message-ID: <CAPDyKFrC1HbUtnnGhJEG-fUH-DNw7En5Was6D=dND=tmFET7fA@mail.gmail.com>
Subject: Re: [RFT PATCH v2] serial: core: Call device_set_awake_path() for
 console port
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, tony@atomide.com, 
	andriy.shevchenko@linux.intel.com, l.sanfilippo@kunbus.com, 
	tglx@linutronix.de, geert+renesas@glider.be, peng.fan@nxp.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-pm@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Apr 2024 at 09:09, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> In case the UART port is used as a console, no_console_suspend is
> available in bootargs and UART port is part of a software-controlled power
> domain we need to call device_set_awake_path(). This lets the power
> domain core code know that this domain should not be powered off
> during system suspend. Otherwise, the UART port power domain is turned off,
> nothing is printed while suspending and the suspend/resume process is
> blocked. This was detected on the Renesas RZ/G3S SoC while adding support
> for power domains.
>
> Based on code investigation, this issue is present on other SoCs (e.g.,
> Renesas R-Mobile A1 [1], IMX8QXP [2]) and different SoCs have particular
> implementation to handle it. Due to this the patch added the call of
> device_set_awake_path() in uart_suspend_port() instead of having it in
> the platform specific UART driver.
>
> [1] https://elixir.bootlin.com/linux/v6.9-rc5/source/drivers/pmdomain/renesas/rmobile-sysc.c#L116
> [2] https://elixir.bootlin.com/linux/v6.9-rc5/source/drivers/pmdomain/imx/scu-pd.c#L357
>
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

At least conceptually this makes perfect sense to me. If it's the
correct place to put it, I trust others to know. Nevertheless, feel
free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>
> Changes in v2:
> - used device_set_awake_path() instead of device_set_wakeup_path()
> - moved the support in uart_suspend_port() to make it generic for
>   other drivers
> - fixed typos in commit description
> - updated the commit description to reflect the new changes and the fact
>   that support may be applied to other SoCs
> - added Suggested-by tag; this was initially proposed by Ulf to move it
>   in the serial driver then Geert propose to have it more generic in
>   uart_suspend_port()
>
>
>  drivers/tty/serial/serial_core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index d8d797a7a1e3..6270baab668c 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -2409,6 +2409,7 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
>                         uport->ops->stop_rx(uport);
>                         uart_port_unlock_irq(uport);
>                 }
> +               device_set_awake_path(uport->dev);
>                 goto unlock;
>         }
>
> --
> 2.39.2
>
