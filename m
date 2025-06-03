Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88B272609
	for <linux-serial@vger.kernel.org>; Tue,  3 Jun 2025 01:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748915683; cv=none; b=RjtwHWoPCOKyBaISSG/s9M8yMpvHBFbCbiQ9Au9W/wlZY36oluhAfNpSYX7M5c3VUBW4jk30pYdXuy5G7DvoYi01i8HJg4leKKeaJYQfJIXefgVhAIeBabuaNigBLArLholTClHzOWa5C1lX3atnLWUlH4SW+RuRDwfFXJNnnsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748915683; c=relaxed/simple;
	bh=alGQUYdJ7trYc+bJw23IUMXpmOQ3ryN14Uf6s6Qh71Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ayoowAaqbt9i9Y0WkncOj+da2JUY1l4omgp2sTcwvbHLI+lYOpacRvEUlQ47D4CsWJyWhcOgx06ut03r7HtFBB0jKYUsUqYeni+nIeQAjTx+96mVuf+3jX1CoPcpQvJzhYpI7U0L3F3yA8Ldo0pUPkUSii53dmPVtdHmxy157x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ta0WeT5i; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ta0WeT5i"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2cc89c59cc0so3603021fac.0
        for <linux-serial@vger.kernel.org>; Mon, 02 Jun 2025 18:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748915680; x=1749520480; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pagyp+jy4clkriYFxGjoAVDUibh4LVZC+hrhARyI5s8=;
        b=Ta0WeT5iiQ5OH+9BslVuXv1ecPPVsP3FhBEpnD39kVZBmKeb0mKtMhhOh45+D58Hky
         sp26klPWJiVSoqGSrfZRPxWNJ3ZSPbZTlhFt2QNX73PsabJNiU5MVnGK6FaEG03H3n1M
         yN9f52EfE4xcZR4dLPS1NpNSCBF/dEusDWFsV11leWM2PxV3pYY20wisLpaGi3KkCNXo
         4hnaq4fPyFODSQdrglA8m2csnrnw7xoCogBrfZH3FO1b8EiiBf++2aQw7FfgYXAaYhJR
         oHO6N4u5nMq4gOlrBg60gzc0Xcfn+N2pJ5MShIq0KAbxtR9MYq521r37YiUYcPOfkNmG
         d5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748915680; x=1749520480;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pagyp+jy4clkriYFxGjoAVDUibh4LVZC+hrhARyI5s8=;
        b=gH8T/Rfuvq1Alma4JjccrJ9D+flI3M3wnogkzfnjJ5ZFzMfApsmnYzyvqwasDiOPOC
         N8OYM+DR40ejqtzm95vP87NGtAH4wypYyjdBQo1i10IF8mhnNAHX88wzUdtmdsHsaFeA
         UgazVN2fmDRD7MkVTrX8sZhb15LowKX3k4PFKlKcUAxwcLBAyu32A1hMDzyb078QmHBy
         JrZXLiWkt9lQQsX5jQp1PlQQMwMLoeW5T8EoxaAzW6uUTxnSV0xP9j1MRdWikwh5bA3U
         ZIjoUg4d7Y+sTGEX7heF31oy3avTmkrwdlpJwRf9PeLR8g2Xs1vVZi5bWLM6NnPjgZYI
         y+xg==
X-Forwarded-Encrypted: i=1; AJvYcCXXyAd49LBipFJu8NDXPgU5NcELbcTGu8lguK7lIG64d6s9NeV14NQlJhs3/t0mSYVg6CVP4aQynNy5hjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLGPCRseMPiQ9TStBB3uFlXgTu+8yy9RkViR7T3V7Mxwui2om9
	0rpe1vILLsKk1FK73V+DTUUyw3C/g29FrccwtUc26zin7E5XwClG67Srjp9UL1jUu7t5LdOOxAj
	7wgDt89iaMYdF6a3iIP9PRCa0l9dcoIv19GUst9TvI1GTwrcjRmeRUUA=
X-Gm-Gg: ASbGncsVTad5SurS9V6q6XA1egsC8awVks/wbjbRxRqxJZ39p7U3jP9A4bd4Jni30ly
	H+4catW0QB64Bi5RklxK9qn0uWXkq9zePZBmyPZjpVid+At3VmmmzpAvcBIAd1k13fZKOihRr1H
	PvHc/d8ESALHMi95C8QFXa1JlJonz8+vCWGhKOPgE=
X-Google-Smtp-Source: AGHT+IHokecYTXxG97x/iEYQEeVys4OUT+S2pF48txreKp9kEQYN3ckg6nwxD/UKwBZMIe1z4CBO6my3eb/78TGVGa0=
X-Received: by 2002:a05:6871:606:b0:2b8:608d:5dd1 with SMTP id
 586e51a60fabf-2e99e2b9aadmr335785fac.18.1748915680571; Mon, 02 Jun 2025
 18:54:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528062609.25104-1-cuiyunhui@bytedance.com>
In-Reply-To: <20250528062609.25104-1-cuiyunhui@bytedance.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 3 Jun 2025 09:54:29 +0800
X-Gm-Features: AX0GCFudggujZacN9nRMZj0f-WQ_kk_mz1M7j0wdjQFNq3HWDe6-bTmazI6qunI
Message-ID: <CAEEQ3wnEN0GVjmGTGoRa2eTGnKoQ2gp3okx8m_XcgiwMvGwzPg@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] serial: 8250: fix panic due to PSLVERR
To: arnd@arndb.de, andriy.shevchenko@linux.intel.com, 
	benjamin.larsson@genexis.eu, cuiyunhui@bytedance.com, 
	gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com, 
	ilpo.jarvinen@linux.intel.com, jirislaby@kernel.org, 
	jkeeping@inmusicbrands.com, john.ogness@linutronix.de, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	markus.mayer@linaro.org, matt.porter@linaro.org, namcao@linutronix.de, 
	paulmck@kernel.org, pmladek@suse.com, schnelle@linux.ibm.com, 
	sunilvl@ventanamicro.com, tim.kryger@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

Gentle ping. Any comments on this patchset?


On Wed, May 28, 2025 at 2:26=E2=80=AFPM Yunhui Cui <cuiyunhui@bytedance.com=
> wrote:
>
> When the PSLVERR_RESP_EN parameter is set to 1, the device generates
> an error response if an attempt is made to read an empty RBR (Receive
> Buffer Register) while the FIFO is enabled.
>
> In serial8250_do_startup(), calling serial_port_out(port, UART_LCR,
> UART_LCR_WLEN8) triggers dw8250_check_lcr(), which invokes
> dw8250_force_idle() and serial8250_clear_and_reinit_fifos(). The latter
> function enables the FIFO via serial_out(p, UART_FCR, p->fcr).
> Execution proceeds to the serial_port_in(port, UART_RX).
> This satisfies the PSLVERR trigger condition.
>
> When another CPU (e.g., using printk()) is accessing the UART (UART
> is busy), the current CPU fails the check (value & ~UART_LCR_SPAR) =3D=3D
> (lcr & ~UART_LCR_SPAR) in dw8250_check_lcr(), causing it to enter
> dw8250_force_idle().
>
> Put serial_port_out(port, UART_LCR, UART_LCR_WLEN8) under the port->lock
> to fix this issue.
>
> Panic backtrace:
> [    0.442336] Oops - unknown exception [#1]
> [    0.442343] epc : dw8250_serial_in32+0x1e/0x4a
> [    0.442351]  ra : serial8250_do_startup+0x2c8/0x88e
> ...
> [    0.442416] console_on_rootfs+0x26/0x70
>
> Fixes: c49436b657d0 ("serial: 8250_dw: Improve unwritable LCR workaround"=
)
> Link: https://lore.kernel.org/all/84cydt5peu.fsf@jogness.linutronix.de/T/
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  drivers/tty/serial/8250/8250_port.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index 6d7b8c4667c9c..07fe818dffa34 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2376,9 +2376,10 @@ int serial8250_do_startup(struct uart_port *port)
>         /*
>          * Now, initialize the UART
>          */
> -       serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
>
>         uart_port_lock_irqsave(port, &flags);
> +       serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
> +
>         if (up->port.flags & UPF_FOURPORT) {
>                 if (!up->port.irq)
>                         up->port.mctrl |=3D TIOCM_OUT1;
> --
> 2.39.5
>

Thanks,
Yunhui
