Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E99221FCE
	for <linux-serial@vger.kernel.org>; Thu,  8 May 2025 11:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746705094; cv=none; b=KAQ9CNAjf9X32ABa8PBf36qmWPcA64Dnow1qEPqWwB7djfmzTMShrq/DN2BRqGq2OmsCBMyiVs/5zXlVfTz+zj8U68d1Hqd3PUFyVKLLPs/4O0Tu72TsgPapuOQvIx/2hHUQGdT8sXSAThU0SIwaY//XLN8oFKG94aB4o+wqgxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746705094; c=relaxed/simple;
	bh=23/gW6O8/EcPWIMJUwacOuC6l7XQzFUGi62o08QQk1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qrqSb72NG6OxBK5g1LySGrLXIApAfmNfQPVwgsqM3/RHkSi7L4AiZ2TrR9g/y3MZ+7L8iv0NpVAGJfGaF5DycC25RlcvbWxzxT1SH+lVpq5rKOyFm20MLUt49KipYd+2kq41KxLxZbj+VvD6VqSF1VZA1dME+JgDqFJxPtTXxlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kLHJXKEp; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kLHJXKEp"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-607dceb1afdso604209eaf.3
        for <linux-serial@vger.kernel.org>; Thu, 08 May 2025 04:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1746705091; x=1747309891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2uMQB/zfAyDPxualfujRpphgr5fivLU+Raz9eKvk5Y=;
        b=kLHJXKEpjWDPZSvA+Z9pT2yB4HWL0Hze2126UQ6raVQOqW9ds5gqOBqQiAjA0//6hy
         q8I3l7zm03IVxKI51Cbf4IvTgBm6se/0bWYDuJCskcm640Up2/rumprp1zAa0f2rC3ac
         khw+F+E10q7JbHCe5Kwjwq+iaMI7U7WKXjJtOkQN76UFSSAAX6ZecysQws6CleFZ+wqs
         uDM224MctcSj+EJlu/8bQGaX2volkQZqF6t++XZyfOVGz2114CIDZU12wXkBTdlaKJkG
         MHgt+vn6kJGGvuJw/0B1GY62pgksJu3vYBrgk5pWhfJY6sz3jJ1pEXTmh72TNygzp92g
         1yGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746705091; x=1747309891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2uMQB/zfAyDPxualfujRpphgr5fivLU+Raz9eKvk5Y=;
        b=Lw8mdfFia8BnzS56g0EalAh7YZknD0U3RceD0M/LLf5z5rDbnAHbAkUYioSGERRPfL
         FHczk8zfvDuSRRO1DIAm8aTRll3XJd3OgOuEXBnxgzZ8/F2AIKORiowBGWptd6XmnjhU
         M1CqgIX6HRqqcK77yevr3xcjW4CPNSbdGc0tdx0ANt7u/0eakWlKwsOw2vntBHfqDSMj
         YrkVmQTbfEGvkmw97QAWdj1Hn7KAGznH9P9gyzsTpi7QiDQAGpW7g4KqaVrDX2Sf72KX
         z7kKJfWhar1z1ENTDpqI/yd7Ww+c/l4jWAiFt0wdVBQ7J6IcFrMadMcBgKnvVAokpZpz
         2T0g==
X-Forwarded-Encrypted: i=1; AJvYcCXQh4tQIF0O7BXYFnYL3uyrEXGY2UFJkaQ3XNlejVyekitNOGseqkQmikdTmFvkQn0JODy0P4H4xEzAdTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywaz9LPJhZmNP/7f7rinpJOrGkTBR1cVkTNkXS6HP0OwXQIhg3A
	VUARTXeKF0f873dLMN9bUPShJDSw+MHwfRO4ilW+zq+Mrt6mxSdRCyRrbMzNJ1OQfkIKHGmhE42
	gPq8cQY8UQpWnjTs4J+bZo+cQGAItCPZhE+kzzw==
X-Gm-Gg: ASbGnctRMVCnhcU2IzYVHmbObQ0lA9FwgAdYjsSZa5QWr4C3YsGhpys2Z4h48j3ZNWe
	O9ur1YCGCTap58pIR91CbBqumTVR8ZoE1QgftT4HEgLHDWHHc1y/7GdsEnwQuDRYTGvM64YVG3I
	LWozT9S9aZY6wh8vSQOtXMAlQCKeMK/rvJijSf5WKqOJHGhQ==
X-Google-Smtp-Source: AGHT+IEWnrfNthxwW1WKKhtRQXLLNZNh1OTk/BJnVlELTIqIGgRl1UO5drmhIsnpuqCAfkaFMIHCz4uh1jNUJA4HsHQ=
X-Received: by 2002:a05:6820:1b1a:b0:606:6384:555c with SMTP id
 006d021491bc7-608339cb87cmr1559963eaf.8.1746705091056; Thu, 08 May 2025
 04:51:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506112321.61710-1-cuiyunhui@bytedance.com>
 <20250506112321.61710-4-cuiyunhui@bytedance.com> <85e57aad-c612-7f1a-03cf-cabd406a1c44@linux.intel.com>
In-Reply-To: <85e57aad-c612-7f1a-03cf-cabd406a1c44@linux.intel.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 8 May 2025 19:51:19 +0800
X-Gm-Features: ATxdqUHp4Q9mxWMOU3fCfs3Mec9TS7tAmMFp-ZlaXArE3cqVqt9rcz4i_WClnCg
Message-ID: <CAEEQ3wmc_QkhwvWP_yR8j5JbxeOLUDrAAot5VyL7+jjDydbD9A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 4/4] serial: 8250_dw: fix PSLVERR on RX_TIMEOUT
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: arnd@arndb.de, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	benjamin.larsson@genexis.eu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	heikki.krogerus@linux.intel.com, Jiri Slaby <jirislaby@kernel.org>, 
	jkeeping@inmusicbrands.com, john.ogness@linutronix.de, 
	LKML <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, 
	markus.mayer@linaro.org, matt.porter@linaro.org, namcao@linutronix.de, 
	paulmck@kernel.org, pmladek@suse.com, schnelle@linux.ibm.com, 
	sunilvl@ventanamicro.com, tim.kryger@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 Hi Ilpo,

On Tue, May 6, 2025 at 8:25=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> I think shortlog should include mention to "dummy read" to make it a
> bit more specific.
>
> On Tue, 6 May 2025, Yunhui Cui wrote:
>
> > In the case of RX_TIMEOUT, to avoid PSLVERR, disable the FIFO
>
> As with patch 2, please don't assume it is know to the reader how PSLVERR
> is triggered.
>
> > before reading UART_RX when UART_LSR_DR is not set.
>
> IMO, it would be better to explain the problem better first, something
> along these lines:
>
> DW UART can fire RX_TIMEOUT interrupt without data and remain in that
> state forever. dw8250_handle_irq() detects this condition by checking if
> UART_LSR_DR is not asserted when RX_TIMEOUT occurred, and if detected,
> performs a dummy read to kick DW UART out of this state.
>
> Performing dummy read from UART_RX is problematic because with ... it lea=
d
> to ...
>
> And only then explain the solution (disable FIFO for while performing of
> the dummy read).

Okay, thank you. It will be updated in the next version.

>
> >
> > Fixes: 424d79183af0 ("serial: 8250_dw: Avoid "too much work" from bogus=
 rx timeout interrupt")
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >  drivers/tty/serial/8250/8250_dw.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/825=
0/8250_dw.c
> > index f41c4a9ed58b..ffa8cb10b39c 100644
> > --- a/drivers/tty/serial/8250/8250_dw.c
> > +++ b/drivers/tty/serial/8250/8250_dw.c
> > @@ -288,9 +288,17 @@ static int dw8250_handle_irq(struct uart_port *p)
> >               uart_port_lock_irqsave(p, &flags);
> >               status =3D serial_lsr_in(up);
> >
> > -             if (!(status & (UART_LSR_DR | UART_LSR_BI)))
> > +             if (!(status & (UART_LSR_DR | UART_LSR_BI))) {
> > +                     /* To avoid PSLVERR, disable the FIFO first. */
> > +                     if (up->fcr & UART_FCR_ENABLE_FIFO)
> > +                             serial_out(up, UART_FCR, 0);
> > +
> >                       (void) p->serial_in(p, UART_RX);
> >
> > +                     if (up->fcr & UART_FCR_ENABLE_FIFO)
> > +                             serial_out(up, UART_FCR, up->fcr);
> > +             }
> > +
> >               uart_port_unlock_irqrestore(p, flags);
> >       }
> >
> >
>
> --
>  i.
>

Thanks,
Yunhui
