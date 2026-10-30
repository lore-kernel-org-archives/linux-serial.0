Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793379767;
	b=AhUAuQli2AqHJHkDkM6hv7FVaCBBaubH/g7vdAp0X9tkKG6mkRM1C24cRzmSsnCbHcmw
	 mqhH9Qic39MfzuNEz7n74tju/2Xx2TUdtdvsWlpRFP67YZIOFw3kDXypLGBwg7u79GAXu
	 ArHOAdvLIY6lG+iV4X1uhmeKEBzxMLYa+GtoUebHeyuJtxmPq3bSZGLCNEyYk2w1UoSNf
	 7Uwh0/769bX0DrplMp0jlwcVeSv6yAugOAUWw5gi+zhRd+vZAiqBhVcPCy9OY333jV+/8
	 kGrm8zO7QOxHgqZx8IztV8es/Y/nogl6u8T6G2BTTLjjyVSULhm1toMM7FJM6i9K9RQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793379767;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IQ/MHZMX5vmwMAGRIrdmx/PMBK9c4wP9Hplcv7IA9ME=;
	b=IxiHqJD5eDW4ndQ+qcqhWPVWm1+ZCIAlv4h7151o+U9lsT2UCGBFH8okAwKbJpyxuzN4
	 gPudK2knT5fctIP7d/841ta3uDLSk+hJa5+4QuEz6/PgnaVl28y6llVC8gQh8eMf+i83B
	 x9YkAnR7tmp36UgeuWefyjgoWt9pWN8belT9bRakWV5ycB/8woeLpmJ3h3COTHwWTDm2V
	 vNYnaU8y1GhWWjjXPKgFSEO+QizA9C4tudg6VeEXboxh1xXVwKo56Pi1Sdjgyk5HI2pau
	 2tLXbN1YG88D1Z1GBr8lEj1p4JMeVy78ZptXZhpi92igD/5ci2Y8BXddEgJ77AlyvJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZLaApgcp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA7E606A31D
	for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 17:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAA7E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZLaApgcp
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5eac7220e9cso385008e0c.3
        for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 10:02:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793379766; cv=none;
        d=google.com; s=arc-20260327;
        b=JRbzvoIafCj5xRwFN4O3qiIZZq7LsnHScjq+i5xeJ8US+6zXBe94mU2ILSnAnpIQgZ
         IFN25+bPoZyJElIS0WPtZ3g05csPUcqCcNmLSI5Mj+wklrrXqjP8tN9sqOFXDX83DQNJ
         fLKaLtPv4DP+nK2bPhJfr4O63tVy6r2vonGuMXEqLM5dSqWXzwCLtBkOolYJxLE0erGE
         5oZmy/UamgEjVBMW1Fv0dEMLabE8NeapdwbHXS8vzNAJ5qbXxO6He8Vkx+/1pPCMZZt2
         0sIJaRJr0NKNkXDM8LLzhv2ap4qdrtWgPQxFCrC/gmufZ1XwBSbBptq9d1ARL05SsdMj
         7Fcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IQ/MHZMX5vmwMAGRIrdmx/PMBK9c4wP9Hplcv7IA9ME=;
        fh=FO/JpgoaNSO4Mz9E6bpEEkane6w61NyUgi31bkYA8UU=;
        b=eqKJwF7jYpMxyYwqj0r2WgKtv8wTT9Jzsn9S/uF0gkdgQBo0IyIxOq2/njpJgy7jtW
         ky6/AnfgJ1CUB+hEbbI6z63CoJz8G5PjhVPXAAZL2QkqEyzyl0LRujWXiVZvKYFTj9WY
         sQunmn36rAhwVlRv15ZTvuyTa3+5lBsYQnMlyHOByJnR/BQUXZPKGRQHu5O3e/9kr0MU
         iEX5lTfK+KTzQ7xgF8l+FdCbZN3o3f7Oq84mGy/EpZwk1F0yw/UVkJfNYmomiB3COZ7t
         tHYXB9yHD+fmM8v/IcYiysDrPrr8Abuz382oWPoAe3LK2njZwNx7V1uI3vLeGpgVLQBm
         lxaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793379766; x=1793984566; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IQ/MHZMX5vmwMAGRIrdmx/PMBK9c4wP9Hplcv7IA9ME=;
        b=ZLaApgcpTb6qsf+r7KHQ1tlF9S/peMaWzKJpqnqaQOOlO1eReCQB1HjYCbLT7ivBKR
         84/HwSDuSzEjuF7PVIyPZX6ScbIs0beM91CpvvXqMgss3mnTups4097KxViIqVVZ1Y2v
         KrOxlOLGdEZaQSiQPKMyevCDpk/XUXDIQlhdYlWi2WSdyI4Aw4pfC22K1/VN7zguxRS0
         FTLEMOhGCY2i07xhEEeIN/gbVGlgXqyg1egGmPHbdrLFmcOnnOfG6JHjnVDVN9klUOQe
         PftOtyXKErf/jYWUgRThPW9uaSJAabTJJZ5hVOwbl/llyDE4s6JTniD0z5hIb6RrwMXI
         nv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793379766; x=1793984566;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IQ/MHZMX5vmwMAGRIrdmx/PMBK9c4wP9Hplcv7IA9ME=;
        b=S2q4wbd/ZwdZa5eLcWsx8ESQHI9Us8FkL4bAELXQNKrH+0ZJmLbFfXvfkf7//oiffK
         Vnzd6YJbsachlVVcWF7x8KbAEyqNWnheZMvDgcn1BHxGq4LuiO8/hfx4UcE/J0AVf/RZ
         5D1AeBNKSHM2FwaW2+u7rbWR9OgFqf3exVH8fqOm/2w/usdruI9p43rutLRSI5CgFqgZ
         ZAjZPcJFhIKoq53hxPuF/JmSLQGhWCwvVCACK9arTt+dfa0wdQqrJaKjS9umfqUeR3dq
         /ubcMv7oVGw4KoM0AKV+HpwCgE1vV4LYZySBSiItrDmm9NmtWRuFuCQU3+7eIntWD1d6
         LDMA==
X-Forwarded-Encrypted: i=1; AKwUvBzOCtmXsStGFjBbUXDokfSrrpCrNiIWjXXrzaZMNgcTcwC3UYtn6BqSZcxsfFvHuTjQcft76L5p77DaZLE=@vger.kernel.org
X-Gm-Message-State: AFq9FYK6A2t9hAVfnoekxDbIAxQFoZPmsspW7ebeCKi4Jz01o+Q/rP1z
	bdgXGyIi6jpTFlqJoX6wid7fs2QwUOuSM+sFtWrUnOZ6j2cWjiMWLrUQOWaboRlniFNZx1MaEqr
	6P/Nerr9scGnSmcO12ieI/ZeTGl1R1yM=
X-Gm-Gg: AYBFou1G8c6Tw84D60aiuRrozIyNKO14eZdL+WGXcyOzVDxYEVeWbcFwwY+98TZPDH0
	7ituCVNL26wDPpdK2X9xNiq+ae+YEnls6Tm2HgtXm6FbiEQw0oQ6JWuVLf2P5one5gECme+pQhf
	7eWm0w5YPGyi/CGcgTplwxim7YJTFug2fKxbi+NQdbXt7YqfySiRGwVAAFAGE7so+HiiLDxeAbY
	xFJYuBxRJ+GNA0JlVA9VQ+gJpMWJXNOXPDdU5dV6t06jJye9nVyFz98b0ZS9sg4F3k/XvJfKPGy
	uhUdIbjJY1ADUIfQBpBAduciB33J24nBykI4mzmNJqBgzcfvVl6Llurfg7OFzxwgqGjSxMDuMyB
	6DyVD3o4swHw8t2BtpXntOe6DCVSIWjk3i7+MNPaIur5uZCQNvElyKpCeMopzBz66eaHCFB8VUT
	tF1YezOw8gAEPOXBE8pcNCNDSLYa8+zw2ofSYlfaed5xiYkRYpJpF0e4mkwO2O4M67/dpDfMorW
	HRM/703DNvaCKscYuv5pTPv6nTixo8=
X-Received: by 2002:a05:6122:ec6:b0:5eb:8606:3425 with SMTP id
 71dfb90a1353d-5ec6882efe0mr1512064e0c.10.1793379764546; Fri, 30 Oct 2026
 10:02:44 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029-submit-h616-uart-fifo-v1-v5-0-53b433aebbf8@gmail.com>
 <20261029-submit-h616-uart-fifo-v1-v5-4-53b433aebbf8@gmail.com> <0809accd-0db3-c923-0396-2d45db7b0d82@linux.intel.com>
In-Reply-To: <0809accd-0db3-c923-0396-2d45db7b0d82@linux.intel.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 30 Oct 2026 11:02:33 -0600
X-Gm-Features: AclHuK93gSvxd_qQwj9Y21y4-X1MbcSsbMU0tWlNjMu02Pk-YVCZgJyAG1RMGJg
Message-ID: <CADvTj4r2Z_NEzTPAUpEj1VvKLhFMS1+EFA+8wMKZgXcx7NxsMQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] serial: 8250_dw: configure the Allwinner H616 UART
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-serial <linux-serial@vger.kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 3:51=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Thu, 29 Oct 2026, James Hilliard wrote:
>
> > H616 has 256-byte transmit and receive FIFOs, but its optional DesignWa=
re
> > component parameter register reads as zero. Generic 16550 probing leave=
s
> > the port using the 16-byte FIFO configuration and its trigger-level tab=
le.
> >
> > Keep PORT_16550A and describe H616's fixed 256-byte FIFO depth in platf=
orm
> > data. Use common Allwinner setup helpers to configure the transmit load
> > and receive trigger table from that depth.
> >
> > Derive the receive thresholds from the documented 1-byte, quarter-full,
> > half-full and FIFO-depth-minus-two mapping. On H616 these are 1, 64, 12=
8
> > and 254 bytes; the normal 16550A half-full FCR setting selects 128 byte=
s.
> >
> > Allwinner encodes these thresholds as fractions of the FIFO depth rathe=
r
> > than fixed byte counts.
>
> This feels repetitive wrt. the previous paragraph so I'd instead start
> the previous paragraph with this sentence.
>
> > Building a per-port table from that depth keeps
> > the mapping in one place for integrations with different FIFO sizes,
> > including those that report their depth through FCC. It also lets the
> > shared 8250 conversion helper select the nearest lower threshold for sy=
sfs
> > writes using the same table as the read callback.
>
> Instead of this long fragment of text, I'd just say something like this:
>
> Construct the RX trigger threshold array on the fly so that other fifo
> sizes can reuse the same mapping.
>
> > Serialize trigger changes with termios and hold a runtime PM reference
> > while programming FCR, preserving the FIFO contents. Propagate runtime
> > resume errors before changing either the FCR shadow or the hardware.
> >
> > Advertise automatic flow control so CRTSCTS enables MCR.AFCE. The
> > DesignWare termios path selects hardware CTS handling, so the capabilit=
y
> > must be present for the corresponding hardware control to be enabled.
> >
> > Select the fixed configuration through the platform setup callback.
> > H616 has debug-divisor and RS485 control registers at the offsets used =
to
> > detect DesignWare hardware RS485 and fractional-divisor support. Avoid
> > those probes and retain the BUSY-safe integer divisor hook and software
> > RS485 handling.
> >
> > Use the existing SKIP_SET_RATE quirk to keep the UART clock enabled dur=
ing
> > termios changes. Its clock is a gate on the shared APB2 source, rather =
than
> > an independent baud-rate generator.
> >
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> >  drivers/tty/serial/8250/8250_dw.c | 98 +++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 98 insertions(+)
> >
> > diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/825=
0/8250_dw.c
> > index a546cf2de7b6..3bc6735fc253 100644
> > --- a/drivers/tty/serial/8250/8250_dw.c
> > +++ b/drivers/tty/serial/8250/8250_dw.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/io.h>
> >  #include <linux/lockdep.h>
> >  #include <linux/module.h>
> > +#include <linux/mutex.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/property.h>
> > @@ -63,6 +64,7 @@
> >  struct dw8250_platform_data {
> >       u8 usr_reg;
> >       u32 cpr_value;
> > +     unsigned int fifo_size;
> >       unsigned int quirks;
> >       int (*setup)(struct uart_port *p);
> >  };
> > @@ -81,6 +83,7 @@ struct dw8250_data {
> >       unsigned int            in_idle:1;
> >
> >       u8                      no_int_count;
> > +     u8                      rxtrig_bytes[UART_FCR_R_TRIG_MAX_STATE];
> >  };
> >
> >  static inline struct dw8250_data *to_dw8250_data(struct dw8250_port_da=
ta *data)
> > @@ -652,6 +655,93 @@ static int dw8250_setup(struct uart_port *p)
> >       return dw8250_setup_dma(p);
> >  }
> >
> > +/* The trigger is the masked FCR receive trigger field, in register po=
sition */
> > +static unsigned int dw8250_sunxi_rxtrig_bytes(struct uart_port *p, uns=
igned int trigger)
> > +{
> > +     switch (trigger) {
> > +     case UART_FCR_TRIGGER_1:
> > +             return 1;
> > +     case UART_FCR_TRIGGER_4:
> > +             return p->fifosize / 4;
> > +     case UART_FCR_TRIGGER_8:
> > +             return p->fifosize / 2;
> > +     default:
> > +             return p->fifosize - 2;
> > +     }
> > +}
> > +
> > +static int dw8250_sunxi_get_rxtrig(struct uart_port *p)
> > +{
> > +     struct dw8250_data *data =3D to_dw8250_data(p->private_data);
> > +     struct uart_8250_port *up =3D up_to_u8250p(p);
> > +
> > +     guard(uart_port_lock_irqsave)(p);
> > +
> > +     return data->rxtrig_bytes[UART_FCR_R_TRIG_BITS(up->fcr)];
> > +}
> > +
> > +static int dw8250_sunxi_set_rxtrig(struct uart_port *p, unsigned char =
bytes)
> > +{
> > +     struct dw8250_data *data =3D to_dw8250_data(p->private_data);
> > +     struct uart_8250_port *up =3D up_to_u8250p(p);
> > +     int fcr, ret;
> > +
> > +     fcr =3D serial8250_bytes_to_fcr(data->rxtrig_bytes, bytes);
> > +     if (fcr < 0)
> > +             return fcr;
> > +
> > +     guard(mutex)(&p->state->port.mutex);
> > +
> > +     PM_RUNTIME_ACQUIRE_IF_ENABLED(p->dev, pm);
> > +     ret =3D PM_RUNTIME_ACQUIRE_ERR(&pm);
> > +     if (ret)
> > +             return ret;
> > +
> > +     guard(uart_port_lock_irqsave)(p);
> > +
> > +     up->fcr &=3D ~UART_FCR_TRIGGER_MASK;
> > +     up->fcr |=3D fcr;
> > +     /* Changing the trigger alone preserves the FIFO contents */
> > +     serial_port_out(p, UART_FCR, up->fcr);
>
> Hmm, the current do_serial8250_set_rxtrig() only takes tty port's mutex?
> Does it lack something it should be doing (RPM or taking port's lock)?

The tty-port mutex serializes against termios and port lifecycle
changes, but interrupt and RS485 timer paths do not take it. For
example, serial8250_em485_handle_stop_tx() takes the UART port lock
and can call serial8250_clear_and_reinit_fifos(), which restores FCR
from up->fcr. The generic sysfs setter can interleave with that
reset/restore sequence, allowing an old trigger value to be written
after the setter has updated the shadow and hardware.

Runtime PM is also missing from that path. The sysfs attribute can
be written while the TTY is closed, when DW runtime suspend has
disabled the UART clocks. Neither the generic setter nor the DW
register accessor acquires a runtime-PM reference.

The sunxi setter therefore takes the tty-port mutex, acquires the
runtime-PM reference, and then takes the UART port lock around the
shadow update and register write. Runtime resume happens before
taking the spinlock because it can sleep, and a resume failure
returns without changing either the shadow or hardware.

> I was going to suggest putting the actual FCR update into generic 8250
> code and lockdep asserting the required locks are held. But then noticed
> the taken locks seem do differ.

A shared helper for updating up->fcr and writing UART_FCR would make
sense with a UART-port-lock assertion. The generic caller would
still need the missing serialization and appropriate runtime-PM
handling; moving the register write alone would not provide either.

There is also a separate behavior difference: the generic setter
calls serial8250_clear_fifos(), whereas the sunxi setter only changes
the trigger bits, preserving buffered data. Keeping FIFO clearing
outside the shared update would let both callers retain their
existing behavior.

> > +     return 0;
> > +}
> > +
> > +static void dw8250_sunxi_setup_rxtrig(struct uart_port *p)
> > +{
> > +     struct dw8250_data *data =3D to_dw8250_data(p->private_data);
> > +
> > +     /* Allwinner RX thresholds differ from the standard 16550A table =
*/
> > +     for (unsigned int i =3D 0; i < ARRAY_SIZE(data->rxtrig_bytes); i+=
+) {
>
> Add include for ARRAY_SIZE()
>
> > +             unsigned int trigger =3D FIELD_PREP(UART_FCR_TRIGGER_MASK=
, i);
> > +
> > +             data->rxtrig_bytes[i] =3D dw8250_sunxi_rxtrig_bytes(p, tr=
igger);
> > +     }
> > +     p->get_rxtrig =3D dw8250_sunxi_get_rxtrig;
> > +     p->set_rxtrig =3D dw8250_sunxi_set_rxtrig;
> > +}
> > +
> > +static int dw8250_sunxi_setup(struct uart_port *p)
> > +{
> > +     struct dw8250_data *data =3D to_dw8250_data(p->private_data);
> > +     struct uart_8250_port *up =3D up_to_u8250p(p);
> > +
> > +     p->type =3D PORT_16550A;
> > +     p->flags |=3D UPF_FIXED_TYPE;
> > +     p->fifosize =3D data->pdata->fifo_size;
> > +     up->capabilities =3D UART_CAP_FIFO | UART_CAP_NOTEMT | UART_CAP_A=
FE;
> > +
> > +     dw8250_sunxi_setup_rxtrig(p);
> > +
> > +     /* Use software RS485 with the Allwinner register layout */
> > +     p->rs485_config =3D serial8250_em485_config;
> > +     p->rs485_supported =3D serial8250_em485_supported;
> > +     up->rs485_start_tx =3D serial8250_em485_start_tx;
> > +     up->rs485_stop_tx =3D serial8250_em485_stop_tx;
> > +
> > +     return 0;
> > +}
> > +
> >  static int dw8250_probe(struct platform_device *pdev)
> >  {
> >       struct uart_8250_port uart =3D {}, *up =3D &uart;
> > @@ -875,6 +965,13 @@ static const struct dw8250_platform_data dw8250_dw=
_apb =3D {
> >       .usr_reg =3D DW_UART_USR,
> >  };
> >
> > +static const struct dw8250_platform_data dw8250_h616_data =3D {
> > +     .usr_reg =3D DW_UART_USR,
> > +     .fifo_size =3D 256,
> > +     .quirks =3D DW_UART_QUIRK_SKIP_SET_RATE,
> > +     .setup =3D dw8250_sunxi_setup,
> > +};
> > +
> >  static const struct dw8250_platform_data dw8250_octeon_3860_data =3D {
> >       .usr_reg =3D OCTEON_UART_USR,
> >       .quirks =3D DW_UART_QUIRK_OCTEON,
> > @@ -926,6 +1023,7 @@ static const struct dw8250_platform_data dw8250_td=
a54 =3D {
> >
> >  static const struct of_device_id dw8250_of_match[] =3D {
> >       { .compatible =3D "snps,dw-apb-uart", .data =3D &dw8250_dw_apb },
> > +     { .compatible =3D "allwinner,sun50i-h616-uart", .data =3D &dw8250=
_h616_data },
> >       { .compatible =3D "cavium,octeon-3860-uart", .data =3D &dw8250_oc=
teon_3860_data },
> >       { .compatible =3D "marvell,armada-38x-uart", .data =3D &dw8250_ar=
mada_38x_data },
> >       { .compatible =3D "renesas,rzn1-uart", .data =3D &dw8250_renesas_=
rzn1_data },
> >
> >
>
> --
>  i.
>
