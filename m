Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793377985;
	b=e6V1KIFhrX7HeIhcVc16Gn67jDNuvgmPyCKg2z3WuRKiPgIcszLhw2Iyk/YudqXzk12Y
	 PZeO5eN95KjVCu7O5kT+sF56LQP7I1GG9NLwNZIpXiSDQKEuq77LCFii0WLUHYOuzSWg9
	 qAS2xApKME98vovcTqdScJpWSutjvbr06/QrAAIclSG8GCfP6fcLkDNjBuSHZs8IX3DFl
	 aeKnFAL3Zkr8pBKZAw9aPzbXA3SaG2BGiHLnS5k6RXbPTX7iE5JHTn1r3yhS+INDpZm83
	 X0XX3jD61CpQjiTNMV8wB1oGdjToLyWWwtkYlwgZIFgHWJLMb/6DpgARTuWjOyC5tqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793377985;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Absm4V+vGVFm3z0L90Q3kfe36wXiy29rBEs36+SAYuw=;
	b=FLM/DEXLTP+WZZEulxvoVSEkrOMQ+sEl6z41SlgGRp2ZFd1VlGOgo5N7UXw3xeyzNdY+
	 lYbuTOAGK8O20Be/5XkLA8vzEg2aYfmtPcbzLAi6b16gRueAylCqyH2LuxPNtCRq1WMdb
	 7nwwTHJCJDoY7VXOOwoKmiUVq1bDf33Pt9/Dn5+X1ECHX6y2jw1BTZ3BBGTQ6OQhcWk5g
	 zy8siLTdJ02g6EddBvfgNcVVJMteJ/XpByblmB6OdhgTUEfsV+lAqng9y/agqUh1sHc8j
	 iyBtKXwptQbV7csrwQqXapoixUnqtX2/JtOMxHLNr7MUiYVjQmPbU+8NcA7rw4OCiZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ELhIbo32;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.49
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2023A606A31E
	for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 16:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2023A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ELhIbo32
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-9828fee1b4bso251493241.3
        for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 09:33:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793377983; cv=none;
        d=google.com; s=arc-20260327;
        b=O3OWqpN3ZPOWk7ocLZGVjMeTr/V8jrZJLPyCFiln7lStyO9QdPc9zApWvoAjstQtCX
         7E68WecrtYKSykSAt1Q9xqErguW4jZFtZ7L9oc9qherQonIBcxomyXVjTNYWs5SzX8Er
         ByJBLDL4OGMOis098xAtbIuOBUnKRlrcfDih4K64VKauom/eld8RETvXAnoy3gVjPGY1
         v/fCA24XXu7NIfR7huZaEGQDfJ9azhoKcpPGMsp0xql3M8/HYAE+1ipgwGJtkT2In5HG
         mMqWiXeUQ0By1jzFzj7WU3l0CMvw57T/QjRsvdd7ezDwQziOdSrSPmNh3GBJL8TOuULo
         S7DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Absm4V+vGVFm3z0L90Q3kfe36wXiy29rBEs36+SAYuw=;
        fh=5TtlccUbZLabHPls+gAhrFTRpLE8aVVXWY199s8XPY0=;
        b=emATCJW9OT7vLngW4AUggRuqCHsNwONyMLjLhykVKfB5W+Nj2nK4QovXEl1lmjKLYi
         8XXhD4m4dLRlcYVjVdBplT7cA8t6mEqCptADT1cAkMAE1ZW0ewxCBKhLB7yFbYPlKY0i
         NMYfnCwylkDrH5c+MNXrYTgQoDsHTYq0MbxEpQ63rt7Y0TsR4JG3oitxkY/5iOeverKr
         a2rgBw8b4DyCwbHRbwLsQSKscj/+5RplVR7rKFn+z0FpI3XnoLBq7cqEJIzZmc+2doEw
         GLum7F7acjV0pt7oJ+9PAhqwZvB47n8ohNXqrRLIMOVqOM9tqyOG9lQdxHqQ1Tkzqgrd
         tFbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793377983; x=1793982783; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Absm4V+vGVFm3z0L90Q3kfe36wXiy29rBEs36+SAYuw=;
        b=ELhIbo32xPOJqXn+rMnAbW7H61IOW7btHzv+iRpnqkVRYrJEFIbXLqqkuG7tTqvCSq
         x4qBHsp5RFAyDzeYNth7aUf0OQs0StVo8H+QOgczebKyfPy1ShJBEBT971dNHTUW5zWy
         PZSs8BQDDgHkVWfy2wZUpxQjtezgbhekOVaw9l0ib5HI0RdIVS7pJxWzPI0yHt0Uwn0f
         Dw/oFgZXUf3rGYQVteTRA0R5lWzBm2teyhwy1eOvLMtgkQwE+FDdkXAZClhEYNF1PVvP
         lwkm2aWwBTVqQrYglj0uHyoXb9aZ6uHH393OQJak3o7HSgcbZXIiM60YsYtI0PTDvnpQ
         lWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793377983; x=1793982783;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Absm4V+vGVFm3z0L90Q3kfe36wXiy29rBEs36+SAYuw=;
        b=SG/Ln2Zp+7sBbPjwsPSjjnG979tAyvE3kkQmmlk7yxR5o+H9/Qr51r4UsdUVw5sTU8
         1Us7SOiu6aYsBkrxAN14zhywOHytadyqgcLoP3518f/bIl2L/FGXzcEzPg1YE5jZjGy6
         cRVyDKdXUdTF7G0tBe3umsc0TOGv26dBjv/gtYRg75FGoZ0tB1eJpkLNKX5Otg76FX4X
         GCJfaATkXePU/S60rDFrkC7awP3JXhOSsAbOd3hj5cS3OYPoIvOZUmTvJQqCg2yUXWNm
         zpE+RxO/BUfSMzh17s5bLzzirCBoLk/FaTqENsfWeKAcTezrH+pu+zJBwe0IB56PhCMQ
         VCiw==
X-Forwarded-Encrypted: i=1; AKwUvBxndPe8LM2XWs6Gr8VRHOyghOoZlbG0o91FwRS13Ba/E/HDeZS9KYbkNLLHhYZfueeBomZiW2W/CECfSPc=@vger.kernel.org
X-Gm-Message-State: AFq9FYK0VKnejdx1lRhF8HtICyjhnUAq0OwersRw3Ls1sqOtrnF+o1Rt
	HkfPmS6kTQfRGlneyUB5KuihQMcLwsMJKwMTKFDv1D2eoAxipEafraVR9qcTmm/IFqnkcfAidwI
	t4hjI1JDcuV1BoBMMaRpTLxc6a8NmYj0=
X-Gm-Gg: AYBFou3D5YSwUb2Ig7ys8w3HVjM7qnzmY+5fyTA4zUWdMcueI/ETtkdHfQUmphyOwnu
	icKZyJuXLIJvPEZj9rwyhvlnPTiO/VhpNNK6qJX2Y/PsfJFfjGGtG+yKjYdrdJyXSEAhFBSKiH8
	WlWr2WNcN+DUgC701JNhHL+/vpHMVDU8F+JFwwqfKCjLMOGjeHOyrsfHnzrQCLAgT2VH80p7pbp
	VGqrS9fNiS3etNwLWM2Qoh1eAXN9AjkNmNVpo1GCfwkLGMPo6vxKB5rNfnrq/10AFaYHHgCxhCn
	nJuOt5wzP5a/yzLtMKFgjZqTi6bftAJjVqyrpsnoKri0qbRAJCKEa0C2k8gAqP8NOxul9wFwvZF
	ruAeI/3nILpo6NZ/Nxdbb65K9OgDmlyiRmkUOAqpUa/CJzzvf7YPDsoXH/hk2CTar1FAUzNHzlS
	HzLTN0/XGgFX4RPKVcmzUQMPFsPeQQUKAAlAdYQhIKH8jVagCRxaND1Chm5XuzSMHE16fYiWY/P
	25gJ6Q/UwCAEF0eSX6VeRmP4qCE5Q==
X-Received: by 2002:a05:6102:2c0f:b0:7a6:d11b:16ea with SMTP id
 ada2fe7eead31-7d0725528eamr1573062137.6.1793377982874; Fri, 30 Oct 2026
 09:33:02 -0700 (PDT)
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
 <20261029-submit-h616-uart-fifo-v1-v5-7-53b433aebbf8@gmail.com> <3d7af02e-4196-bb82-9579-467e88879021@linux.intel.com>
In-Reply-To: <3d7af02e-4196-bb82-9579-467e88879021@linux.intel.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 30 Oct 2026 10:32:51 -0600
X-Gm-Features: AclHuK9dYwyBnU9vyC-IBxpz7TsWhpjTcY4ZwN-3UTn5urI74GWhcbY5yqJONhY
Message-ID: <CADvTj4on8Kx2bW05sSp5uHCT=LCL1L1Jmh_cOo2TEnNdx-mU9w@mail.gmail.com>
Subject: Re: [PATCH v5 7/8] serial: 8250_dw: discover Allwinner A523 FIFO
 depths through FCC
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

On Fri, Oct 30, 2026 at 4:15=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Thu, 29 Oct 2026, James Hilliard wrote:
>
> > The A523 UART integration, also used by A527 and T527, has 64-byte FIFO=
s
> > on UART0 and 128-byte FIFOs on UART1 through UART7. Each controller rep=
orts
> > its TX/RX FIFO depth in bits 31:8 of the FIFO Clock Control register at
> > offset 0xf0. The field holds a byte count, not a logarithmic encoding.
> >
> > Read this field in the sunxi setup callback when platform data does not
> > provide a fixed FIFO size. A fixed size takes precedence, so H616 retai=
ns
> > its 256-byte configuration without accessing FCC. The probe has already
> > enabled the clocks and deasserted reset before invoking the callback.
> > Leave the FIFO clock-control bits untouched.
> >
> > Validate the depth before generating the RX trigger table or setting th=
e
> > transmit load. The quarter-full threshold must be positive and the
> > FIFO-depth-minus-two threshold must fit in the byte-sized table and RX
> > trigger API. Report an invalid depth and fail probe instead of generati=
ng
> > zero or truncated thresholds.
> >
> > Select this setup for the A523 compatible. Derive the transmit load and
> > RX threshold table from the discovered depth using the common sunxi
> > helpers. This handles the different FIFO sizes with one compatible and
> > one receive-trigger mapping.
> >
> > Like H616, this integration has Allwinner-specific debug-divisor and
> > RS485 registers overlapping the generic DesignWare feature probes. Use
> > the common sunxi PIO setup, BUSY-safe integer divisor programming and
> > software RS485 handling. Keep the APB clock gate enabled during termios
> > updates with SKIP_SET_RATE.
> >
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> >  drivers/tty/serial/8250/8250_dw.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/825=
0/8250_dw.c
> > index 3bc6735fc253..2ab91f479fc6 100644
> > --- a/drivers/tty/serial/8250/8250_dw.c
> > +++ b/drivers/tty/serial/8250/8250_dw.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/device.h>
> >  #include <linux/err.h>
> >  #include <linux/io.h>
> > +#include <linux/limits.h>
> >  #include <linux/lockdep.h>
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> > @@ -45,6 +46,10 @@
> >  #define RZN1_UART_xDMACR_8_WORD_BURST        (2 << 1)
> >  #define RZN1_UART_xDMACR_BLK_SZ(x)   ((x) << 3)
> >
> > +/* Allwinner FIFO Clock Control register */
> > +#define SUNXI_UART_FCC                       0xf0
> > +#define SUNXI_UART_FCC_FIFO_DEPTH            GENMASK(31, 8)
> > +
> >  /* Quirks */
> >  #define DW_UART_QUIRK_OCTEON         BIT(0)
> >  #define DW_UART_QUIRK_ARMADA_38X     BIT(1)
> > @@ -64,6 +69,7 @@
> >  struct dw8250_platform_data {
> >       u8 usr_reg;
> >       u32 cpr_value;
> > +     /* Fixed sunxi FIFO depth; zero selects discovery through FCC */
> >       unsigned int fifo_size;
> >       unsigned int quirks;
> >       int (*setup)(struct uart_port *p);
> > @@ -729,6 +735,16 @@ static int dw8250_sunxi_setup(struct uart_port *p)
> >       p->type =3D PORT_16550A;
> >       p->flags |=3D UPF_FIXED_TYPE;
> >       p->fifosize =3D data->pdata->fifo_size;
> > +     if (!p->fifosize) {
> > +             u32 fcc =3D dw8250_readl_ext(p, SUNXI_UART_FCC);
> > +
> > +             p->fifosize =3D FIELD_GET(SUNXI_UART_FCC_FIFO_DEPTH, fcc)=
;
> > +     }
> > +     /* The RX trigger table must contain positive, byte-sized thresho=
lds */
> > +     if (p->fifosize < 4 || p->fifosize - 2 > U8_MAX)
>
> One additional comment.
>
> What is the reason for this "byte-sized" limit? Is it Allwinner specific
> or perhaps the use of unsigned char in 8250 driver to store them?

It comes from the current 8250 software interface, not an Allwinner
hardware restriction. The per-port u8 threshold table is introduced by
this series, but the existing set_rxtrig() callback takes unsigned char
byte counts, and rx_trig_bytes sysfs writes are parsed with kstrtou8().
The existing per-UART-type threshold tables also use unsigned char.

> In the DW databook the CPR given fifosizes go all the way up to 2k. I'm
> not sure how large actual UARTs make them but applying the FCR formulas
> one could get > U8_MAX thresholds.

I haven't found an Allwinner UART documented as having a FIFO larger
than 256 bytes in the vendor manuals reviewed, and the BSP configurations
checked also stay within that size. With the Allwinner mapping, the
largest threshold for those depths is 254 bytes, so the current types
cover the hardware identified so far.

A larger FIFO could exceed that representation: a 512-byte FIFO would
need a 510-byte threshold, which would truncate to 254 in our u8 table.
The check prevents that truncation. It is a software limitation, not a
claim that Allwinner hardware cannot implement larger FIFOs.

> If it's just 8250 drivers type limitation, I think the comment should
> make that obvious the type could be changed as needed.

The comment should identify this as a limitation of the current
byte-count representation. Supporting larger thresholds would require
widening the new table and shared conversion helper, together with the
existing setter argument and sysfs input parsing. Widening just our
table would not allow those thresholds to be requested through the
current interface.


>
> --
>  i.
>
> > +             return dev_err_probe(p->dev, -EINVAL,
> > +                                  "invalid FIFO size %u\n", p->fifosiz=
e);
> > +
> >       up->capabilities =3D UART_CAP_FIFO | UART_CAP_NOTEMT | UART_CAP_A=
FE;
> >
> >       dw8250_sunxi_setup_rxtrig(p);
> > @@ -972,6 +988,12 @@ static const struct dw8250_platform_data dw8250_h6=
16_data =3D {
> >       .setup =3D dw8250_sunxi_setup,
> >  };
> >
> > +static const struct dw8250_platform_data dw8250_a523_data =3D {
> > +     .usr_reg =3D DW_UART_USR,
> > +     .quirks =3D DW_UART_QUIRK_SKIP_SET_RATE,
> > +     .setup =3D dw8250_sunxi_setup,
> > +};
> > +
> >  static const struct dw8250_platform_data dw8250_octeon_3860_data =3D {
> >       .usr_reg =3D OCTEON_UART_USR,
> >       .quirks =3D DW_UART_QUIRK_OCTEON,
> > @@ -1024,6 +1046,7 @@ static const struct dw8250_platform_data dw8250_t=
da54 =3D {
> >  static const struct of_device_id dw8250_of_match[] =3D {
> >       { .compatible =3D "snps,dw-apb-uart", .data =3D &dw8250_dw_apb },
> >       { .compatible =3D "allwinner,sun50i-h616-uart", .data =3D &dw8250=
_h616_data },
> > +     { .compatible =3D "allwinner,sun55i-a523-uart", .data =3D &dw8250=
_a523_data },
> >       { .compatible =3D "cavium,octeon-3860-uart", .data =3D &dw8250_oc=
teon_3860_data },
> >       { .compatible =3D "marvell,armada-38x-uart", .data =3D &dw8250_ar=
mada_38x_data },
> >       { .compatible =3D "renesas,rzn1-uart", .data =3D &dw8250_renesas_=
rzn1_data },
> >
> >
>
