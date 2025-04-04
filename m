Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C122E62B4
	for <linux-serial@vger.kernel.org>; Fri,  4 Apr 2025 02:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743734663; cv=none; b=SHP4hvCk2AEJYwI5hoZ7jpu+hfLRSaa46W/X7ffVbrf71ZzvthttYXikOKRwLJ5cYVqrVAQtECHqKpjR9/kuJTpPib+pqibBYOAOIRT+lhuelZsUE5GytQfZeHBuqkrnzNekR453+07BRNRyslccJ4XeakEu6Rs4e+ijqfHG/G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743734663; c=relaxed/simple;
	bh=hR/G0FoBsEMa/zy1eASMqgio0eJvUNvgFLMmAXwNYfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j4KOsexK/E99pnroUjvxmbH9r7nkeEvtzCcQOblgBb3GC4exGLJJuKoHMgVazIRAf1Bqg5QNitSCd0asF+0gNlFajpZjEkEwh9N8xy/+3pQl1ap4B+x5kFO6HUH+dPoxclEd2jN8LjFqBTuismTfULn15rX4tTlimVupuHsQtLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=R7NRae91; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="R7NRae91"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3fbaa18b810so509965b6e.2
        for <linux-serial@vger.kernel.org>; Thu, 03 Apr 2025 19:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1743734660; x=1744339460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3to4EZ4KOPkdFrVQMEvvFBf1MhlaFI8gIxRSmU8z08=;
        b=R7NRae9182RmulC4jrmiqPTHFeg62yT/CLgV7yLqjIIHKdhnImdG6xi9bL47UKYylO
         lrIy73B85KdwxedSTa5TzcFBJAOrg5RM4lS1Rk0wpQ4d8I7MNRb1Lo7SHp+PFwYw2t4z
         LHfgcYsTjxbAH8UOqEXBbY6Vvgj0LYSvMbr6Q8wXAPbheUXz/kVLL9SQh4d9S6GAIwOR
         nbHl7knntKBpZvnayWJXgp2dVhFvvTbfNvgt3ySdAcDuxCimmPOMlTo6iRRv7sdjyf7I
         BqW/3v/s1AND7wha0zIGA2IRDDo6RIJ+ivHDcNVtmoWM7G05pN3V4D9zm1hxbFVBhkI5
         uvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743734660; x=1744339460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3to4EZ4KOPkdFrVQMEvvFBf1MhlaFI8gIxRSmU8z08=;
        b=Eh2VjxcK68MjDF6kfcVlvWjeruzYoop/Tcx3vTXi8HMd0+2YOaVRK/Czcq2/cjjmKY
         ubBuOYLv/PdJiMyLM8P/Y4TatWprzc6n2FsZZ4CVKIS4fA9ZZePjlzNDfbEbKV46H2kP
         g11ypmxwuUtUfU/lOPBcDy9STkuu8PriSMgVL1cMjz6JzBaIFyMfK3zOyQH+zgR0FrlQ
         zBfgOTUfyuFrA+SkQMByyYGeDjb+Wlo1r8a6CT0kZulGNIOEkICW9fXIcDQzYaBsuQhN
         GuHI9hTzhYxi1TZBdhw3dt0dvrZ0aVfQt2+A3kuQzy54y/lp+hGhCXGfzwjMDnEL3Bsv
         YxwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhkTtSEG34wicMVPwhxnKH4q8mw+tcHHn6SfkMyx7vyCaq4snn1AwITAkSWEuZgeLfGVcyS/g4duXIe48=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKUVT+b61tOyuslWvEd6RSISIwLa0UTFUbd76fGSE43NeUmoSe
	kXSep4DkCj11zD/Ad+6dFVV+N2aJGy2YYDu2MGtA2vXPK6WNN8AiQ73XOL/TBt8y0GEDY0x4fvu
	+mlxGjBDA9ShbljSo2qmYFRdf/3S41HMbX/i9oA==
X-Gm-Gg: ASbGncudPJR2NEbRKSJfE6+FnVrwXgdTNkxB77yIktLxKa9EK6SldPkWwkXeS01oqrh
	ayVyOTh/0wEwI1hCZRiIKWesCE3O//aubhzI9uoxJ+pk9z3dfxxfX2iQEg2OnsWEga+DHK8vKd4
	FGTxs0RcvrbGkZoDTPVanOLXjPckOh
X-Google-Smtp-Source: AGHT+IFjvwlQt97TWXYvRTkX1MJds7QaL2P5+NCX3VHwMbmvGzcaH492Si95hFTBr5UpcQ4uIJdQ61s0Den342Lx99Q=
X-Received: by 2002:a05:6808:118a:b0:3f9:d5a2:89a6 with SMTP id
 5614622812f47-4004563d596mr951684b6e.35.1743734660528; Thu, 03 Apr 2025
 19:44:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403090336.16643-1-cuiyunhui@bytedance.com> <Z-5yr2mFaDt8kxC-@smile.fi.intel.com>
In-Reply-To: <Z-5yr2mFaDt8kxC-@smile.fi.intel.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 4 Apr 2025 10:44:09 +0800
X-Gm-Features: AQ5f1JqZlZYmfxf_2wHsUDMn4QlG0JCmAjQFmx6FdNX0KnxfsddxfxpJyEMyiCY
Message-ID: <CAEEQ3wkWmfkq06iyhxs32pyTUp7Mm=UD-dYen_9H5kHnsJe10g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] serial: 8250: fix panic due to PSLVERR
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	john.ogness@linutronix.de, pmladek@suse.com, arnd@arndb.de, 
	namcao@linutronix.de, benjamin.larsson@genexis.eu, schnelle@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Thu, Apr 3, 2025 at 7:36=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Apr 03, 2025 at 05:03:36PM +0800, Yunhui Cui wrote:
> > When the PSLVERR_RESP_EN parameter is set to 1, the device generates
> > an error response if an attempt is made to read an empty RBR (Receive
> > Buffer Register) while the FIFO is enabled.
> >
> > In serial8250_do_startup, calling serial_port_out(port, UART_LCR,
>
> serial8250_do_startup()
>
> > UART_LCR_WLEN8) triggers dw8250_check_lcr(), which invokes
> > dw8250_force_idle() and serial8250_clear_and_reinit_fifos(). The latter
> > function enables the FIFO via serial_out(p, UART_FCR, p->fcr).
> > Execution proceeds to the dont_test_tx_en label:
> > ...
> > serial_port_in(port, UART_RX);
> > This satisfies the PSLVERR trigger condition.
> >
> > Because another CPU(e.g., using printk) is accessing the UART (UART
>
> printk()

Okay.

>
> > is busy), the current CPU fails the check (value & ~UART_LCR_SPAR) =3D=
=3D
> > (lcr & ~UART_LCR_SPAR), causing it to enter dw8250_force_idle().
> >
> > To resolve this issue, relevant serial_port_out operations should be
>
> serial_port_out()

Okay.

>
> > placed in a critical section, and UART_RX data should only be read
> > when the UART_LSR DR bit is set.
>
> The last one is made in the common code, are you sure that all supported =
UARTs
> will be okay with such a change?

This change enhances code robustness without being intrusive.

>
> > Panic message:
>
> Please, read this
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#ba=
cktraces-in-commit-messages
> and act accordingly.

Okay, I'll update the next version to follow the guideline: 'Avoid
directly copying full dmesg output (e.g., timestamps, registers, and
stack dumps); instead, extract the critical call chain.'

>
> > [    0.442336] Oops - unknown exception [#1]
> > [    0.442337] Modules linked in:
> > [    0.442339] CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W=
          6.12.13-00102-gf1f43e345877 #1
>
> Is it still reproducible on v6.14 (and soon v6.15-rc1)?

This is not a consistently reproducible issue, but even without this
fix, I believe the issue still exists.

>
> > [    0.442342] Tainted: [W]=3DWARN
> > [    0.442343] epc : dw8250_serial_in32+0x1e/0x4a
> > [    0.442351]  ra : serial8250_do_startup+0x2c8/0x88e
> > [    0.442354] epc : ffffffff8064efca ra : ffffffff8064af28 sp : ffff8f=
8000103990
> > [    0.442355]  gp : ffffffff815bad28 tp : ffffaf807e36d400 t0 : ffffaf=
80804cf080
> > [    0.442356]  t1 : 0000000000000001 t2 : 0000000000000000 s0 : ffff8f=
80001039a0
> > [    0.442358]  s1 : ffffffff81626fc0 a0 : ffffffff81626fc0 a1 : 000000=
0000000000
> > [    0.442359]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : ffffff=
ff81626fc0
> > [    0.442360]  a5 : ffff8f800012d900 a6 : 000000000000000f a7 : 000000=
000fc648c1
> > [    0.442361]  s2 : 0000000000000000 s3 : 0000000200000022 s4 : 000000=
0000000000
> > [    0.442362]  s5 : ffffffff81626fc0 s6 : ffffaf8085227000 s7 : ffffff=
ff81073c58
> > [    0.442363]  s8 : 0000000000500000 s9 : ffffaf80851a5a60 s10: ffffaf=
80851a5a60
> > [    0.442365]  s11: ffffffff80e85980 t3 : ffffaf807e324600 t4 : 000000=
0000000002
> > [    0.442365]  t5 : 0000000000000003 t6 : ffffaf80804cf072
> > [    0.442366] status: 0000000200000120 badaddr: 0000000000000000 cause=
: 0000000000000013
> > [    0.442368] [<ffffffff8064efca>] dw8250_serial_in32+0x1e/0x4a
> > [    0.442371] [<ffffffff8064af28>] serial8250_do_startup+0x2c8/0x88e
> > [    0.442373] [<ffffffff8064b514>] serial8250_startup+0x26/0x2e
> > [    0.442375] [<ffffffff806428a2>] uart_startup+0x13a/0x308
> > [    0.442377] [<ffffffff80642aa4>] uart_port_activate+0x34/0x50
> > [    0.442378] [<ffffffff8062ab6a>] tty_port_open+0xb4/0x110
> > [    0.442383] [<ffffffff8063f548>] uart_open+0x22/0x36
> > [    0.442389] [<ffffffff806234b4>] tty_open+0x1be/0x5e6
> > [    0.442396] [<ffffffff802f2d52>] chrdev_open+0x10a/0x2a8
> > [    0.442400] [<ffffffff802e7ab6>] do_dentry_open+0xf6/0x34e
> > [    0.442405] [<ffffffff802e9456>] vfs_open+0x2a/0xb4
> > [    0.442408] [<ffffffff80300124>] path_openat+0x676/0xf36
> > [    0.442410] [<ffffffff80300a58>] do_filp_open+0x74/0xfa
> > [    0.442412] [<ffffffff802e9900>] file_open_name+0x84/0x144
> > [    0.442414] [<ffffffff802e99f6>] filp_open+0x36/0x54
> > [    0.442416] [<ffffffff80a01232>] console_on_rootfs+0x26/0x70
> > [    0.442420] [<ffffffff80a0154e>] kernel_init_freeable+0x2d2/0x30e
> > [    0.442422] [<ffffffff8099c730>] kernel_init+0x2a/0x15e
> > [    0.442427] [<ffffffff809a7666>] ret_from_fork+0xe/0x1c
> > [    0.442430] Code: e022 e406 0800 4683 0c15 691c 872a 96bb 00d5 97b6 =
(439c) 851b
> > [    0.442432] ---[ end trace 0000000000000000 ]---
> > [    0.442434] Kernel panic - not syncing: Fatal exception in interrupt
> > [    0.442435] SMP: stopping secondary CPUs
> > [    0.451111] ---[ end Kernel panic - not syncing: Fatal exception in =
interrupt ]---
>
> Fixes tag?
> Cc to stable@?

Okay.

>
> ...
>
> >       /*
> >        * Now, initialize the UART
> >        */
>
> + Blank line.

Okay.

>
> > +     uart_port_lock_irqsave(port, &flags);
> >       serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
> >
> > -     uart_port_lock_irqsave(port, &flags);
> >       if (up->port.flags & UPF_FOURPORT) {
> >               if (!up->port.irq)
> >                       up->port.mctrl |=3D TIOCM_OUT1;
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Thanks,
Yunhui
