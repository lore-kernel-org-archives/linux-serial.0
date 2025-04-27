Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7874A19DF6A
	for <linux-serial@vger.kernel.org>; Sun, 27 Apr 2025 11:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745752688; cv=none; b=IDxG0mRZrFxxj7COYFkIaimvI7jb2AeU6wDoYNYCPCDNgdXptelw+pICuv+9ghKWQdCU4l24xWdg3qKBxmKGHAi3O1l3YP2qU9nc9Ok2JAwv4ILD5J504A8O2/320fTDDrEMK/G06dkz8PRknJMIuENADryfy8DM9U0UGH3jz9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745752688; c=relaxed/simple;
	bh=eHhA5tnc+faC6C/bJ5+HpYMF0LeEZc76OZByQLRSITo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bn+S85s+4jdl2SV9K0r4AXQx5j2/XlBeC17SwyNEEiPYf/o4K5eyjhr8JBh/HMjbl58cJdnAO/o1i3BZRSSi5EjaUF0fsg8LC4K9JKR3Fr/6lSASo8GPNTlOFGuQuXX3tC1umQkI4Esb/2ICLrCXjDOEaqzUX1IszwdBYOgWBso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fqOsPg0I; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fqOsPg0I"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-605ff8aa9d2so961644eaf.0
        for <linux-serial@vger.kernel.org>; Sun, 27 Apr 2025 04:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1745752685; x=1746357485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MprAgNPWqGJ7CHG6RWipvBG6sPPJFir2MiaXJK5t8Ec=;
        b=fqOsPg0I4lQ79ZaRg24VyPvNY0jGQTTbU6hXTXNbV+ronr+PTDnzedtLIOwtr2deEt
         Z98wS56l55KV2hOFskhlXMZX7rumRG0/DCo5tQTLntiBZmW2czemNXlZG6+3lXodl6IZ
         VMC1juWXjoCiZ2+TFZ7eZsafxZ1+Vj9dbuQDBYAr1Ndl8Sz5GDZ/kiDEMf7+hfZuiK0I
         NoNzwgBedILUiPtvhhKfgvlddWZPbRGRMXF25psugvbJDMnFLHrpQxPOM4elkUJi1TKP
         KKYbUDL/hZme99Qc+GUQb56WklF4JG9eIEk58xa1wlWX9eWmkiB2v3LnPg+YJd3LEHnQ
         fFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745752685; x=1746357485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MprAgNPWqGJ7CHG6RWipvBG6sPPJFir2MiaXJK5t8Ec=;
        b=oh3PwBdqOXHdBRTHOyC90zjIhyG+4avD3j5F0t9C+LXyEl1pgQB6ZsKBpA2cS9LDDK
         6c8oVSL0bb8ufVQIv+ePks+NxZsBAIVG4Ktnx4JBndctgI1ciXDFeWMrlQ4mjpfzC3+7
         +C1p9t6n4XR87pguZk4/ejiV5nx69OJ0fa7qJBo2IOB3d1L5dnIpPfZ3cgrHJLu8Wlgk
         EhMr739hlOVQVxrlLTM0mv19JCbVvi2ucW4ROdBigUhSk5FOqVPX716HUVMayriPEJG5
         C7lUX58PlfCbVm/O4YL56xLOJwLUJ1xXE2uxf6Yv9jVp2EIJEKS9M+BQdmceqoxu5dqU
         o4VQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSfKe2bXKfvc+Hqt9d8lKktR0SGD/dl2b4LYR54rJCQL0jbM+jh2qWeuJ9Kuuq16QJoJ9/RTy2qp0VVgE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy22Ohhgr6ttXh0ArsSG3s40cGf5D2ullkSPqnmZ7CgkF76J3pG
	BFkJFY66sa7m68mPKAut3SZ1OBW+DfuEUGE4JQC6DodjrSaCO6eZSEY0njoRqTCUmZsagiDEl3p
	iRyTfiQMTKlJxG2xKeHtfZSAoMv00tiTS61M/vQ==
X-Gm-Gg: ASbGncsLfNzfq4uo5uWA3QMxlitZ0tAN46vYikrjoVF1WB954Sek7UhCpksxjrY130/
	Z7QfxG+bfA6ZS5YCGuTjXkiCctz5n6hw5WpbakupMjFDCvM0NxaL/eYR5jPfjw3Dfyl3YI/3AQx
	HaSyFxIi/DIdZWvqGxIMW9drdodz69hbxfuQ/5B/E=
X-Google-Smtp-Source: AGHT+IG8fZxwzHNuZuL5P2Cv7KAs0gI3eNFTOYs+RhBLwnkpjnoQB1qDpHKnfQqP0F4gpRdFEEwyCpU317ouvssDGqY=
X-Received: by 2002:a05:6820:c83:b0:604:9c9b:d096 with SMTP id
 006d021491bc7-60658f242e1mr3557749eaf.4.1745752685422; Sun, 27 Apr 2025
 04:18:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425062425.68761-1-cuiyunhui@bytedance.com>
 <20250425062425.68761-4-cuiyunhui@bytedance.com> <57d75d55-81e3-445f-a705-e8c116281515@kernel.org>
 <9d4e7002-48fe-4fa0-8e23-7c2160419910@kernel.org>
In-Reply-To: <9d4e7002-48fe-4fa0-8e23-7c2160419910@kernel.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Sun, 27 Apr 2025 19:17:53 +0800
X-Gm-Features: ATxdqUGrND2eWKgTBQAFuWZ7ZU2WztQbLWkJMVgxrAn4tCVQU7wPRICwW2BvD3A
Message-ID: <CAEEQ3w=MOSU2mNo8qq8qz9KE9M0Zb55xeS9aw1263osXtP+8SA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v4 4/4] serial: 8250_dw: fix PSLVERR on RX_TIMEOUT
To: Jiri Slaby <jirislaby@kernel.org>
Cc: arnd@arndb.de, andriy.shevchenko@linux.intel.com, 
	benjamin.larsson@genexis.eu, gregkh@linuxfoundation.org, 
	heikki.krogerus@linux.intel.com, ilpo.jarvinen@linux.intel.com, 
	jkeeping@inmusicbrands.com, john.ogness@linutronix.de, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	markus.mayer@linaro.org, matt.porter@linaro.org, namcao@linutronix.de, 
	paulmck@kernel.org, pmladek@suse.com, schnelle@linux.ibm.com, 
	sunilvl@ventanamicro.com, tim.kryger@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi js,


On Fri, Apr 25, 2025 at 2:43=E2=80=AFPM Jiri Slaby <jirislaby@kernel.org> w=
rote:
>
> On 25. 04. 25, 8:41, Jiri Slaby wrote:
> > On 25. 04. 25, 8:24, Yunhui Cui wrote:
> >> In the case of RX_TIMEOUT, to avoid PSLVERR, disable the FIFO
> >> before reading UART_RX when UART_LSR_DR is not set.
> >>
> >> Fixes: 424d79183af0 ("serial: 8250_dw: Avoid "too much work" from
> >> bogus rx timeout interrupt")
> >> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> >> ---
> >>   drivers/tty/serial/8250/8250_dw.c | 13 ++++++++++++-
> >>   1 file changed, 12 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/
> >> serial/8250/8250_dw.c
> >> index 07f9be074b4b..1e364280a108 100644
> >> --- a/drivers/tty/serial/8250/8250_dw.c
> >> +++ b/drivers/tty/serial/8250/8250_dw.c
> >> @@ -273,6 +273,7 @@ static int dw8250_handle_irq(struct uart_port *p)
> >>       unsigned int quirks =3D d->pdata->quirks;
> >>       unsigned int status;
> >>       unsigned long flags;
> >> +    unsigned char old_fcr;
> >
> > No more unsigned char, please. Use u8.
> >
> >> @@ -288,9 +289,19 @@ static int dw8250_handle_irq(struct uart_port *p)
> >>           uart_port_lock_irqsave(p, &flags);
> >>           status =3D serial_lsr_in(up);
> >> -        if (!(status & (UART_LSR_DR | UART_LSR_BI)))
> >> +        if (!(status & (UART_LSR_DR | UART_LSR_BI))) {
> >> +            /* To avoid PSLVERR, disable the FIFO first. */
> >> +            if (up->fcr & UART_FCR_ENABLE_FIFO) {
> >> +                old_fcr =3D serial_in(up, UART_FCR);
>
> Wait, read(FCR) actually means read(IIR). FCR is write only. Or is DW
> special in this?

Indeed, the valid bits of the FCR are write-only. It seems that here
we can only do serial_out(up, UART_FCR, up->fcr); What do you think?

>
> >> +                serial_out(up, UART_FCR, old_fcr & ~1);
> >
> > s/1/UART_FCR_ENABLE_FIFO/
> >
> >> +            }
> >> +
> >>               (void) p->serial_in(p, UART_RX);
> >> +            if (up->fcr & UART_FCR_ENABLE_FIFO)
> >> +                serial_out(up, UART_FCR, old_fcr);
> >> +        }
> >> +
> >>           uart_port_unlock_irqrestore(p, flags);
> >>       }
> >
> >
>
> --
> js
> suse labs
>

Thanks,
Yunhui
