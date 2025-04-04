Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4494A24
	for <linux-serial@vger.kernel.org>; Fri,  4 Apr 2025 02:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743733899; cv=none; b=gftQrvnulQDyCP+4dIo03RjT++pJTuaZ7Un602lLZpnFxqOo5jQuxHbNp4boDwrB/4aTPJzdsVLwyCHmQvqp240R3hfXzo7n5K3dyBb6aAqFWCyZkltYzqGOOZ5Tdw/Vr6WBLqfrG3mFzqbkw2gfeq7u8cMynrUUSxXt1rKXFqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743733899; c=relaxed/simple;
	bh=yHnZZpVl1yzU+3RWun8o5eoI7/TawRiNwZfiH6mye8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sPhOLIEOE1GrmnOSiOaZDh3zOBYI8n2mluWogqOJQmlUGFhXeqtc5hXuQu+VcG3nXRledrd4Q8iIZt3HVp5GmV8qC0tJ7K7pKJb5amp4MVYhjXSeZ+d69Q5klIOhieFBzY7jPYiSSYfE5OptnMoVXQNP2kNR9H5H1NKdZRlOgSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VD2B2AyH; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VD2B2AyH"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-60406de9cbfso377369eaf.3
        for <linux-serial@vger.kernel.org>; Thu, 03 Apr 2025 19:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1743733897; x=1744338697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2whIQD8KdpXADYPhBRKVcLNwmLnu/yZ5sYtE7xk5RY=;
        b=VD2B2AyH5K3prI08Y98N6edl03rwk7kEGj0okk6eRw1SE3bRkC43z5NzbsUR6gIaHN
         KcYorkJsl2A2u6PpvaiI7III3456VgCdgz90ZDobgR7zTRmFYHz6JdyMhZpxhhdKJQnz
         ZFcoq+yF26yKf3t80KKay3OfKfadK2a+V+QEjs2NdDY/0xeG1X3SNG+nw7n/l1o0OAFU
         HqJv6HQHDpvbkRJF0SQZRa3eiIPCtj4Pf9NuAUntzc2++SzQbQQRbiGPfII7rS8y7OtR
         d3VuX+rIzxtcAv9SqkcxZLqbffc6uxgpjWkpY9yQ5piUcigEq+KYfB308aznHvj7Ufg0
         hl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743733897; x=1744338697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2whIQD8KdpXADYPhBRKVcLNwmLnu/yZ5sYtE7xk5RY=;
        b=lx6qUNFGBZZPexEaT2rfgLuirij6RbOOhzfaqc7nVVruaNCFMty+wAPrOCF2Obcduo
         X9MnedaZ1GC4cq5LH2d/3soLBFrw1IvwCcJW12Xwd0/TW2R4etr2HPEfWjRHNscPfSIj
         GAkOiBKeqkdPkqw291Flq49fWPmPh90OzbJFidDF0p/yR7A0BIfeKUMoj7xTxhdiOn3p
         GRg5tL6E+s63FuYhM87UHnxEy30XqIyF2Lx11zZGZacbV6GHT5pZUW6ZnSBGsg9MjGx5
         bKIwQ3v2D5CK+HqW6q1PwWfyG+FYs/fU7uBuqvg8IKA8TRPIXCgxyU9U2Sceb/cC5IfO
         n2ug==
X-Forwarded-Encrypted: i=1; AJvYcCVdzDfTj8HSjM/G3g0UzSMb7d/wQNWXD6HAR2kKEwZuRNadYIJ7n1JDj4aKRiGGl8emaxSFlK+W3fCkbrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlMhnxrZxkiI+l5tE/yK8kJeUYvhgbku2WSn8Xln0MyvGV8kNp
	uwHJUtpRZMM1PKZZkzWdl8PoKpxZBwf9QHT5Tcib3mUEYE/btG1skOCD3HEhiZ83RiT/+r7Rzwm
	E+zrIPuxsMu1xMKF0y/yCD1ZUggL9EVYgz6ADXg==
X-Gm-Gg: ASbGncv0kPbZy1ujVNY342PfGBM9DwHycgMrTTVOSTYVSCUKW2JvzwsOQQB5UUU+53I
	mk0wBsaS+hA2o9FlAKx6tV9WMQLPE8J/NfAObJTdF2iVShtfsBNz+sC/z/u40trwTm0XI5Pvbo/
	SLH+BKfx/q0b1LZQQphymhybY5HD9t
X-Google-Smtp-Source: AGHT+IH9gl4q75ltH2ZFe+KffjOAddtz44brumjLnokrgaEk7wAc7CLc6OwNvkK4AiXGIFpHGB8pVkw0ICZfkYYHRh0=
X-Received: by 2002:a05:6820:2220:b0:603:f973:1b1 with SMTP id
 006d021491bc7-604154d63fdmr798732eaf.0.1743733896559; Thu, 03 Apr 2025
 19:31:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403090336.16643-1-cuiyunhui@bytedance.com>
 <Z-5yr2mFaDt8kxC-@smile.fi.intel.com> <Z-51629pjyiZUIVy@smile.fi.intel.com>
In-Reply-To: <Z-51629pjyiZUIVy@smile.fi.intel.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 4 Apr 2025 10:31:25 +0800
X-Gm-Features: AQ5f1JploVvIX48e4bc9-Zvy4Mr-665fzaSUUegXQUAC-gU9ajtwKPkYszaiBXk
Message-ID: <CAEEQ3w=xVNuSN-4tHx6ir-i+huN8m1JXgJz672=WHAVBqcP+TA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] serial: 8250: fix panic due to PSLVERR
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	john.ogness@linutronix.de, pmladek@suse.com, arnd@arndb.de, 
	namcao@linutronix.de, benjamin.larsson@genexis.eu, schnelle@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Thu, Apr 3, 2025 at 7:50=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Apr 03, 2025 at 02:36:16PM +0300, Andy Shevchenko wrote:
> > On Thu, Apr 03, 2025 at 05:03:36PM +0800, Yunhui Cui wrote:
>
> A couple of more questions here:
> 1) what is the DW IP version and where did you get the PSLVERR_RESP_EN
> parameter from?
> 2) what is the setting of the UART_16550_COMPATIBLE parameter?

1): Refer to: https://www.synopsys.com/dw/ipdir.php?c=3DDW_apb_uart

2): data->uart_16550_compatible =3D=3D 0

>
> > > When the PSLVERR_RESP_EN parameter is set to 1, the device generates
> > > an error response if an attempt is made to read an empty RBR (Receive
> > > Buffer Register) while the FIFO is enabled.
> > >
> > > In serial8250_do_startup, calling serial_port_out(port, UART_LCR,
> >
> > serial8250_do_startup()
> >
> > > UART_LCR_WLEN8) triggers dw8250_check_lcr(), which invokes
> > > dw8250_force_idle() and serial8250_clear_and_reinit_fifos(). The latt=
er
> > > function enables the FIFO via serial_out(p, UART_FCR, p->fcr).
> > > Execution proceeds to the dont_test_tx_en label:
> > > ...
> > > serial_port_in(port, UART_RX);
> > > This satisfies the PSLVERR trigger condition.
> > >
> > > Because another CPU(e.g., using printk) is accessing the UART (UART
> >
> > printk()
> >
> > > is busy), the current CPU fails the check (value & ~UART_LCR_SPAR) =
=3D=3D
> > > (lcr & ~UART_LCR_SPAR), causing it to enter dw8250_force_idle().
> > >
> > > To resolve this issue, relevant serial_port_out operations should be
> >
> > serial_port_out()
> >
> > > placed in a critical section, and UART_RX data should only be read
> > > when the UART_LSR DR bit is set.
> >
> > The last one is made in the common code, are you sure that all supporte=
d UARTs
> > will be okay with such a change?
> >
> > > Panic message:
> >
> > Please, read this
> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html#=
backtraces-in-commit-messages
> > and act accordingly.
> >
> > > [    0.442336] Oops - unknown exception [#1]
> > > [    0.442337] Modules linked in:
> > > [    0.442339] CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Tainted: G       =
 W          6.12.13-00102-gf1f43e345877 #1
> >
> > Is it still reproducible on v6.14 (and soon v6.15-rc1)?
> >
> > > [    0.442342] Tainted: [W]=3DWARN
> > > [    0.442343] epc : dw8250_serial_in32+0x1e/0x4a
> > > [    0.442351]  ra : serial8250_do_startup+0x2c8/0x88e
> > > [    0.442354] epc : ffffffff8064efca ra : ffffffff8064af28 sp : ffff=
8f8000103990
> > > [    0.442355]  gp : ffffffff815bad28 tp : ffffaf807e36d400 t0 : ffff=
af80804cf080
> > > [    0.442356]  t1 : 0000000000000001 t2 : 0000000000000000 s0 : ffff=
8f80001039a0
> > > [    0.442358]  s1 : ffffffff81626fc0 a0 : ffffffff81626fc0 a1 : 0000=
000000000000
> > > [    0.442359]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : ffff=
ffff81626fc0
> > > [    0.442360]  a5 : ffff8f800012d900 a6 : 000000000000000f a7 : 0000=
00000fc648c1
> > > [    0.442361]  s2 : 0000000000000000 s3 : 0000000200000022 s4 : 0000=
000000000000
> > > [    0.442362]  s5 : ffffffff81626fc0 s6 : ffffaf8085227000 s7 : ffff=
ffff81073c58
> > > [    0.442363]  s8 : 0000000000500000 s9 : ffffaf80851a5a60 s10: ffff=
af80851a5a60
> > > [    0.442365]  s11: ffffffff80e85980 t3 : ffffaf807e324600 t4 : 0000=
000000000002
> > > [    0.442365]  t5 : 0000000000000003 t6 : ffffaf80804cf072
> > > [    0.442366] status: 0000000200000120 badaddr: 0000000000000000 cau=
se: 0000000000000013
> > > [    0.442368] [<ffffffff8064efca>] dw8250_serial_in32+0x1e/0x4a
> > > [    0.442371] [<ffffffff8064af28>] serial8250_do_startup+0x2c8/0x88e
> > > [    0.442373] [<ffffffff8064b514>] serial8250_startup+0x26/0x2e
> > > [    0.442375] [<ffffffff806428a2>] uart_startup+0x13a/0x308
> > > [    0.442377] [<ffffffff80642aa4>] uart_port_activate+0x34/0x50
> > > [    0.442378] [<ffffffff8062ab6a>] tty_port_open+0xb4/0x110
> > > [    0.442383] [<ffffffff8063f548>] uart_open+0x22/0x36
> > > [    0.442389] [<ffffffff806234b4>] tty_open+0x1be/0x5e6
> > > [    0.442396] [<ffffffff802f2d52>] chrdev_open+0x10a/0x2a8
> > > [    0.442400] [<ffffffff802e7ab6>] do_dentry_open+0xf6/0x34e
> > > [    0.442405] [<ffffffff802e9456>] vfs_open+0x2a/0xb4
> > > [    0.442408] [<ffffffff80300124>] path_openat+0x676/0xf36
> > > [    0.442410] [<ffffffff80300a58>] do_filp_open+0x74/0xfa
> > > [    0.442412] [<ffffffff802e9900>] file_open_name+0x84/0x144
> > > [    0.442414] [<ffffffff802e99f6>] filp_open+0x36/0x54
> > > [    0.442416] [<ffffffff80a01232>] console_on_rootfs+0x26/0x70
> > > [    0.442420] [<ffffffff80a0154e>] kernel_init_freeable+0x2d2/0x30e
> > > [    0.442422] [<ffffffff8099c730>] kernel_init+0x2a/0x15e
> > > [    0.442427] [<ffffffff809a7666>] ret_from_fork+0xe/0x1c
> > > [    0.442430] Code: e022 e406 0800 4683 0c15 691c 872a 96bb 00d5 97b=
6 (439c) 851b
> > > [    0.442432] ---[ end trace 0000000000000000 ]---
> > > [    0.442434] Kernel panic - not syncing: Fatal exception in interru=
pt
> > > [    0.442435] SMP: stopping secondary CPUs
> > > [    0.451111] ---[ end Kernel panic - not syncing: Fatal exception i=
n interrupt ]---
> >
> > Fixes tag?
> > Cc to stable@?
> >
> > ...
> >
> > >     /*
> > >      * Now, initialize the UART
> > >      */
> >
> > + Blank line.
> >
> > > +   uart_port_lock_irqsave(port, &flags);
> > >     serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
> > >
> > > -   uart_port_lock_irqsave(port, &flags);
> > >     if (up->port.flags & UPF_FOURPORT) {
> > >             if (!up->port.irq)
> > >                     up->port.mctrl |=3D TIOCM_OUT1;
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Thanks,
Yunhui
