Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8251632DF
	for <linux-serial@vger.kernel.org>; Fri, 11 Jul 2025 02:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752200370; cv=none; b=BbLAQiys0QqbMwygqjmKQI7WSiYp64R836rz98+sPZwLIY9+itT3tPqK1TuRB6A5rlz2yUn5q/vA868evqD2aX/uXbWE9hIVLVQVm3B4pmshh8bYe2lqpYJKhjoI8wbIp1TNyGr8nb2YjsGz/UwF7CNyIJ2/21MA5kggzzVbZ/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752200370; c=relaxed/simple;
	bh=y4jCcuJN7yjOr2y3cVPXJ+KAMqtUM1NbU0hlYIYhLMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WL5fiBKxa9Jj+6yggNC1mTYpPQRM8caYp09cqQV4tFPA3t+DLuEPTYsF38TYbuvHn1CHH5e6hNapM3MHUW5Lr+FvGRXWxp4aKSCDD/C+zDqALHfOfcXXrkFtwAfhoaiDiW/uTKmWSeIpLgsp40scsXENVS8X0iRWCSQRYuHOq6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=czD+YZ4O; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="czD+YZ4O"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-40ad1f7c23bso965048b6e.2
        for <linux-serial@vger.kernel.org>; Thu, 10 Jul 2025 19:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1752200368; x=1752805168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LguYWqKU69s8fXl+FAzLjDH/VFGVUbcH34uXEnvqnA=;
        b=czD+YZ4Og7rcEYzX78IQFVIEmFmxyFmKllaVmoCvFSxG62wcF8+7rJlGMnM8tezkJM
         3JvUJ2il+Z9ud0FX3cyWL3e1mrcTljkjvaL4lFvkZWNmaXiYUTd4LS+LH2BL7FbcY0t1
         MArj91zZQALa/TkLw0VPzHFJby/4H9awlWXjFcY9XSeybGNtE3bPNV7yj6mb2sF7Vv1A
         larPhjm/5b+ldI+qO8UQF/XThJ2UJSJ8Kq/xJju5x3XUFlqbZuUmoUOE1AxYSX2hTIbA
         q3esIf/HOwM94sRyuWH/1/iIkiqR6V41ZixzTxY12zYTTNcf7TdU+jYHAbMRrT71oaSn
         pPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752200368; x=1752805168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LguYWqKU69s8fXl+FAzLjDH/VFGVUbcH34uXEnvqnA=;
        b=ep4OAQ/0h79yGAPWbPrw8fExMmLV6zVDjASdP0HC/aNkz15EcHNuv50MXWkUdYThEm
         8KSHWZdwtJZYb2AC7TvhbjHOIb+F1mVWdphFPtjVijNRSfUyNJhgj/wUB6s2o/1hiQpL
         asFlM/orZf+LLpxmKCviK5pzxyNC/GCOMudNMuwG68v2VuzTFxMfiHg/vmMuVvfaSC4g
         XyjN+fe1GALtCp1l+LrIfYyENoAOzY62S7aqyCZbcwBiMfUIpbulsdk4AWKbnKB7N4mw
         /uHgiLvv3PRmjb8lO9MGrRYmspoI7l0eqgnxxjJ1CvzJ9XrLj+f6eSBr2UP0+014YOex
         Zy3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVrjwrQWOJYvrq09Ellyy/thL6NXznSGpRs0LIWG0Zl+t6AVNHfraYVjWkrJkcXnG9m9+f0wwL7YIytxOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVza6nit12H2I4tpZbO/Za6P9UjgmOjllxMiY0mezbTxI/vSgk
	D0RrXnPy4ee62oR+jS5gY/FEMEygdf4JAo7hMzXLuCn2XRiveN93eiHX6iz09WWJQM3QTblKfs2
	cDa03Rp03eKhi69Zc55s16rUrKexaIdyhN//pUBchjQ==
X-Gm-Gg: ASbGncviMARfQhf2AK2gkf7+lBEp2y8xGS2LanLqy32ySJq/116IDAYAJ1gOEBjcwIW
	w/pKhZvmwf4bWxDzlc6ym8NDDBzkJ2DRgT9HVXeQO2Pk0TKl8s9tdtHinT7pyRRncTZu7gGDmS2
	SH/tv8ys+O3IbnXjLg/M135Cu2fsmllYlYpJZGTk1a1UOu6TzPOomQ6hYaHdiuhpHK2a8KuylT4
	wL243A4PQ==
X-Google-Smtp-Source: AGHT+IFBh7LzTFN9rD6gbXHF6ywmERfYcfitKd7WVxt6xE3tRn5i23AvprpdjVhHYknMIA3w2g9HGwRoOBZcHNEc3MQ=
X-Received: by 2002:a05:6808:16aa:b0:40b:1222:8fd8 with SMTP id
 5614622812f47-41539f925c2mr885406b6e.35.1752200367955; Thu, 10 Jul 2025
 19:19:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610092135.28738-1-cuiyunhui@bytedance.com>
 <20250610092135.28738-3-cuiyunhui@bytedance.com> <CAEEQ3w=pUPEVOM4fG6wr06eOD_uO6_ZBzORaG1zhtPswD8HLNQ@mail.gmail.com>
 <84cyauq2nc.fsf@jogness.linutronix.de>
In-Reply-To: <84cyauq2nc.fsf@jogness.linutronix.de>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 11 Jul 2025 10:19:16 +0800
X-Gm-Features: Ac12FXxBhZNNUH-29Cczmz3xlktD2RZw1X21GwvxVue8j6YX6ffOS8u3DsWgqNU
Message-ID: <CAEEQ3w==dO2i+ZSsRZG0L1S+ccHSJQ-aUa9KE638MwnBM4+Jvw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v9 2/4] serial: 8250_dw: fix PSLVERR on RX_TIMEOUT
To: John Ogness <john.ogness@linutronix.de>
Cc: arnd@arndb.de, andriy.shevchenko@linux.intel.com, 
	benjamin.larsson@genexis.eu, gregkh@linuxfoundation.org, 
	heikki.krogerus@linux.intel.com, ilpo.jarvinen@linux.intel.com, 
	jirislaby@kernel.org, jkeeping@inmusicbrands.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	markus.mayer@linaro.org, matt.porter@linaro.org, namcao@linutronix.de, 
	paulmck@kernel.org, pmladek@suse.com, schnelle@linux.ibm.com, 
	sunilvl@ventanamicro.com, tim.kryger@linaro.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi John,

On Mon, Jun 23, 2025 at 4:32=E2=80=AFPM John Ogness <john.ogness@linutronix=
.de> wrote:
>
> Hi Yunhui,
>
> On 2025-06-23, yunhui cui <cuiyunhui@bytedance.com> wrote:
> >> The DW UART may trigger the RX_TIMEOUT interrupt without data
> >> present and remain stuck in this state indefinitely. The
> >> dw8250_handle_irq() function detects this condition by checking
> >> if the UART_LSR_DR bit is not set when RX_TIMEOUT occurs. When
> >> detected, it performs a "dummy read" to recover the DW UART from
> >> this state.
> >>
> >> When the PSLVERR_RESP_EN parameter is set to 1, reading the UART_RX
> >> while the FIFO is enabled and UART_LSR_DR is not set will generate a
> >> PSLVERR error, which may lead to a system panic. There are two methods
> >> to prevent PSLVERR: one is to check if UART_LSR_DR is set before readi=
ng
> >> UART_RX when the FIFO is enabled, and the other is to read UART_RX whe=
n
> >> the FIFO is disabled.
> >>
> >> Given these two scenarios, the FIFO must be disabled before the
> >> "dummy read" operation and re-enabled afterward to maintain normal
> >> UART functionality.
> >>
> >> Fixes: 424d79183af0 ("serial: 8250_dw: Avoid "too much work" from bogu=
s rx timeout interrupt")
> >> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> >> Cc: stable@vger.kernel.org
> >> ---
> >>  drivers/tty/serial/8250/8250_dw.c | 10 +++++++++-
> >>  1 file changed, 9 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/82=
50/8250_dw.c
> >> index 1902f29444a1c..082b7fcf251db 100644
> >> --- a/drivers/tty/serial/8250/8250_dw.c
> >> +++ b/drivers/tty/serial/8250/8250_dw.c
> >> @@ -297,9 +297,17 @@ static int dw8250_handle_irq(struct uart_port *p)
> >>                 uart_port_lock_irqsave(p, &flags);
> >>                 status =3D serial_lsr_in(up);
> >>
> >> -               if (!(status & (UART_LSR_DR | UART_LSR_BI)))
> >> +               if (!(status & (UART_LSR_DR | UART_LSR_BI))) {
> >> +                       /* To avoid PSLVERR, disable the FIFO first. *=
/
> >> +                       if (up->fcr & UART_FCR_ENABLE_FIFO)
> >> +                               serial_out(up, UART_FCR, 0);
> >> +
> >>                         serial_port_in(p, UART_RX);
> >>
> >> +                       if (up->fcr & UART_FCR_ENABLE_FIFO)
> >> +                               serial_out(up, UART_FCR, up->fcr);
> >> +               }
> >> +
> >>                 uart_port_unlock_irqrestore(p, flags);
> >>         }
> >>
> >> --
> >> 2.39.5
> >
> > Any comments on this patch?
>
> I do not know enough about the hardware. Is a dummy read really the only
> way to exit the RX_TIMEOUT state?
>
> What if there are bytes in the TX-FIFO. Are they in danger of being
> cleared?
>
> From [0] I see:
>
> "Writing a "0" to bit 0 will disable the FIFOs, in essence turning the
>  UART into 8250 compatibility mode. In effect this also renders the rest
>  of the settings in this register to become useless. If you write a "0"
>  here it will also stop the FIFOs from sending or receiving data, so any
>  data that is sent through the serial data port may be scrambled after
>  this setting has been changed. It would be recommended to disable FIFOs
>  only if you are trying to reset the serial communication protocol and
>  clearing any working buffers you may have in your application
>  software. Some documentation suggests that setting this bit to "0" also
>  clears the FIFO buffers, but I would recommend explicit buffer clearing
>  instead using bits 1 and 2."
>
> Have you performed tests where you fill the TX-FIFO and then
> disable/enable the FIFO to see if the TX-bytes survive?

Sorry, I haven't conducted relevant tests. The reason I made this
modification is that it clearly contradicts the logic of avoiding
PSLVERR. Disabling the FIFO can at least prevent the Panic() caused by
PSVERR.

>
> John Ogness
>
> [0] https://en.wikibooks.org/wiki/Serial_Programming/8250_UART_Programmin=
g

Thanks,
Yunhui
