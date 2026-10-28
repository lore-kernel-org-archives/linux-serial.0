Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793177885;
	b=i5CbRwqXFq0NRekH+YYdITD5B/YHGOytWFtxbKQnBqwCIwgX5NN5EnMVgeewR+3K9teO
	 /hpkGAcMPnCE/P1VmZOwYE1Xn9SOZS4xw37x31fMSQ+ZPB8ApGpZFCos2NPuPQjPCWn0e
	 OfAJ6iI7//TYvxw3Ng1iuY9cY72mkF3umxAf5iLtiq4lPIyWdx705wS/6IFxt1EsVV+BA
	 cTFJpk6gReY7sQ9WvYmRTuaGhnxj7GhpQ/ttR2iaYulTEKN8ihzXt8Kdb/wZnZxbGiQar
	 Wxdhns2wXRgdwCSj3WyByMI5fZqMOKwhwmTPecuiYvKSFMAatCZnfWAqA33eMybmTog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793177885;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=EJ7Z+DXqwpBs0APZvJA/IZJ4OngEnsNSB+12lQvmza4=;
	b=2sAbnxQ9ftFrd8mA3SHoPhGsNaTS49tXQFfhtKGrwDU4+Q3tmUvsAcTSS8o+NW6wFao5
	 idZyb6ia7Lm/rXGfkUvMl98tZ5RPRbAN9YywRePj7hmH/oP1nurYFxZ8uJXwj30aehh5T
	 JcTxmYicZKzYdIje2H+Z1jtUioRjGmNfXMtpywIzSGh7kU63EADC0mPDp7+2Pf+X0YmJ2
	 oWBvgiZc85YNH9gKp54LRArqbL7u2HSzP73N4fWaj61Fa21f+KL3nYYqJoqHg3XGhB7Xz
	 8fKqFwm0ilM15tKG5PENfboK3W8CHVRj/qVeCr5lJic4f9LJM5HyDDLoTPaFh9HdeIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dnrJry4B;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C75C606A31D;
	Wed, 28 Oct 2026 08:58:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C75C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dnrJry4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793177886; x=1824713886;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cYnJPVOVbiZhyIBKRnFKEfVptxYDHCJ4de3GBgpopYA=;
  b=dnrJry4B/KvkBsNF7/zU9xhLLKrKfkkRXz5kqzFWyWiabDjmBYD/KvSf
   C0bGiadOPjbkBx2FnTVm+obTwuH08juGVW8ohxz1IaJjC5AUo8HTMle5i
   zopeTpZqOerv86VmBM20tduZVnNFTzyZ/EGkET/1mNNzVeMFpUK+rQB2t
   JuBlJ9BYPGsOmdewkInVuSB9H5A0gtP2rdzkV/QfQaHcNuzDESIgN2TSs
   MpQjC3jcXD81nojh7NnsmvqeWIo+dTK9OqwmawlhbZYRJCVI1nYLyt4K+
   FiQgdngbtC/1kJv6utkszp3hFzuRo6EsSeicvALiE1NhIYiuDapiXbAjy
   w==;
X-CSE-ConnectionGUID: 1XC+ImUbSZeIzVEVFsJQhg==
X-CSE-MsgGUID: NL4323cDTyC/jaPI9A2kqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1772251"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1772251"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 01:58:05 -0700
X-CSE-ConnectionGUID: O0nImqLRSqC4VzHbFI5x2g==
X-CSE-MsgGUID: WgEnrFX4RMyfe5iMBsJ3dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="5175559"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.156])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 01:57:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 28 Oct 2026 10:57:53 +0200 (EET)
To: James Hilliard <james.hilliard1@gmail.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
    Samuel Holland <samuel@sholland.org>, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, devicetree@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v4 4/5] serial: 8250_dw: configure the Allwinner H616
 UART
In-Reply-To: <CADvTj4pquJ=WV3UuQc1PxazSWh48cPi9jY5G7nNORgvyV0-Dww@mail.gmail.com>
Message-ID: <70cf350e-21e4-75d9-1b02-803f68747b0b@linux.intel.com>
References: <20261027-submit-h616-uart-fifo-v1-v4-0-d37e018fd0a6@gmail.com> <20261027-submit-h616-uart-fifo-v1-v4-4-d37e018fd0a6@gmail.com> <c8668925-efec-da4c-193c-5e85c5bbcf15@linux.intel.com>
 <CADvTj4pquJ=WV3UuQc1PxazSWh48cPi9jY5G7nNORgvyV0-Dww@mail.gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1806327667-1793177873=:1157"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1806327667-1793177873=:1157
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 28 Oct 2026, James Hilliard wrote:

> On Wed, Oct 28, 2026 at 2:39=E2=80=AFAM Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > On Tue, 27 Oct 2026, James Hilliard wrote:
> >
> > > H616 has 256-byte transmit and receive FIFOs, but its optional Design=
Ware
> > > component parameter register reads as zero. Generic 16550 probing lea=
ves
> > > the port using the 16-byte FIFO configuration and its trigger-level t=
able.
> > >
> > > Keep PORT_16550A and describe H616's fixed 256-byte FIFO depth in pla=
tform
> > > data. Use common Allwinner setup helpers to configure the transmit lo=
ad
> > > and receive trigger table from that depth.
> > >
> > > Derive the receive thresholds from the documented 1-byte, quarter-ful=
l,
> > > half-full and FIFO-depth-minus-two mapping. On H616 these are 1, 64, =
128
> > > and 254 bytes; the normal 16550A half-full FCR setting selects 128 by=
tes.
> > >
> > > Build the threshold table during setup and use the shared 8250 conver=
sion
> > > helper to select the nearest lower threshold for sysfs writes.
> >
> > You do that, I can see from the patch, but I came to read this changelo=
g
> > to understand "why"?? You provide zero reasoning for this design decisi=
on.
> >
> > Since you fifosize is constant as well, so what benefit building it on =
the
> > fly servers?
>=20
> The intent is to keep the FIFO depth as the single platform-data input
> and derive the thresholds from the common Allwinner mapping. Other sunxi
> integrations using that mapping could then supply a different FIFO depth
> without duplicating the threshold table.
>
> Building the table once also lets get_rxtrig() and the shared
> bytes-to-FCR helper use the same derived values.

Okay, but it would be nice to mention that then in the changelog as the=20
justification.

> > > Serialize trigger changes with termios and hold a runtime PM referenc=
e
> > > while programming FCR, preserving the FIFO contents. Propagate runtim=
e
> > > resume errors before changing either the FCR shadow or the hardware.
> > >
> > > Advertise automatic flow control so CRTSCTS enables MCR.AFCE. The
> > > DesignWare termios path selects hardware CTS handling, so the capabil=
ity
> > > must be present for the corresponding hardware control to be enabled.
> > >
> > > Select the fixed configuration through the platform setup callback.
> > > H616 has debug-divisor and RS485 control registers at the offsets use=
d to
> > > detect DesignWare hardware RS485 and fractional-divisor support. Avoi=
d
> > > those probes and retain the BUSY-safe integer divisor hook and softwa=
re
> > > RS485 handling.
> > >
> > > Use the existing SKIP_SET_RATE quirk to keep the UART clock enabled d=
uring
> > > termios changes. Its clock is a gate on the shared APB2 source, rathe=
r than
> > > an independent baud-rate generator.
> > >
> > > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > > ---
> > >  drivers/tty/serial/8250/8250_dw.c | 94 +++++++++++++++++++++++++++++=
++++++++++
> > >  1 file changed, 94 insertions(+)
> > >
> > > diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8=
250/8250_dw.c
> > > index 1351523f0c47..2f156c01c5a1 100644
> > > --- a/drivers/tty/serial/8250/8250_dw.c
> > > +++ b/drivers/tty/serial/8250/8250_dw.c
> > > @@ -19,6 +19,7 @@
> > >  #include <linux/io.h>
> > >  #include <linux/lockdep.h>
> > >  #include <linux/module.h>
> > > +#include <linux/mutex.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/pm_runtime.h>
> > >  #include <linux/property.h>
> > > @@ -63,6 +64,7 @@
> > >  struct dw8250_platform_data {
> > >       u8 usr_reg;
> > >       u32 cpr_value;
> > > +     unsigned int fifo_size;
> > >       unsigned int quirks;
> > >       void (*setup)(struct uart_port *p);
> > >  };
> > > @@ -81,6 +83,7 @@ struct dw8250_data {
> > >       unsigned int            in_idle:1;
> > >
> > >       u8                      no_int_count;
> > > +     u8                      rxtrig_bytes[UART_FCR_R_TRIG_MAX_STATE]=
;
> > >  };
> > >
> > >  static inline struct dw8250_data *to_dw8250_data(struct dw8250_port_=
data *data)
> > > @@ -657,6 +660,89 @@ static void dw8250_octeon_setup(struct uart_port=
 *p)
> > >       dw8250_setup_dma(p);
> > >  }
> > >
> > > +/* The trigger is the masked, unshifted FCR receive trigger field. *=
/
> > > +static unsigned int dw8250_sunxi_rxtrig_bytes(struct uart_port *p, u=
nsigned int trigger)
> > > +{
> > > +     switch (trigger) {
> > > +     case UART_FCR_TRIGGER_1:
> > > +             return 1;
> > > +     case UART_FCR_TRIGGER_4:
> > > +             return p->fifosize / 4;
> > > +     case UART_FCR_TRIGGER_8:
> > > +             return p->fifosize / 2;
> > > +     default:
> > > +             return p->fifosize - 2;
> > > +     }
> > > +}
> > > +
> > > +static int dw8250_sunxi_get_rxtrig(struct uart_port *p)
> > > +{
> > > +     struct dw8250_data *data =3D to_dw8250_data(p->private_data);
> > > +     struct uart_8250_port *up =3D up_to_u8250p(p);
> > > +
> > > +     guard(uart_port_lock_irqsave)(p);
> > > +
> > > +     return data->rxtrig_bytes[UART_FCR_R_TRIG_BITS(up->fcr)];
> > > +}
> > > +
> > > +static int dw8250_sunxi_set_rxtrig(struct uart_port *p, unsigned cha=
r bytes)
> > > +{
> > > +     struct dw8250_data *data =3D to_dw8250_data(p->private_data);
> > > +     struct uart_8250_port *up =3D up_to_u8250p(p);
> > > +     int fcr, ret;
> > > +
> > > +     fcr =3D serial8250_bytes_to_fcr(data->rxtrig_bytes, bytes);
> > > +     if (fcr < 0)
> > > +             return fcr;
> > > +
> > > +     guard(mutex)(&p->state->port.mutex);
> > > +
> > > +     PM_RUNTIME_ACQUIRE_IF_ENABLED(p->dev, pm);
> > > +     ret =3D PM_RUNTIME_ACQUIRE_ERR(&pm);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     guard(uart_port_lock_irqsave)(p);
> > > +
> > > +     up->fcr &=3D ~UART_FCR_TRIGGER_MASK;
> > > +     up->fcr |=3D fcr;
> > > +     /* Changing the trigger alone preserves the FIFO contents. */
> > > +     serial_port_out(p, UART_FCR, up->fcr);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static void dw8250_sunxi_setup_rxtrig(struct uart_port *p)
> > > +{
> > > +     struct dw8250_data *data =3D to_dw8250_data(p->private_data);
> > > +
> > > +     /* Allwinner RX thresholds differ from the standard 16550A tabl=
e. */
> > > +     for (unsigned int i =3D 0; i < ARRAY_SIZE(data->rxtrig_bytes); =
i++)
> > > +             data->rxtrig_bytes[i] =3D dw8250_sunxi_rxtrig_bytes(p, =
i << UART_FCR_R_TRIG_SHIFT);
> >
> > FIELD_PREP(UART_FCR_TRIGGER_MASK, i)
> >
> > For clarity, it might be useful to split it into two lines using an
> > intermediate variable.
> >
> > > +     p->get_rxtrig =3D dw8250_sunxi_get_rxtrig;
> > > +     p->set_rxtrig =3D dw8250_sunxi_set_rxtrig;
> > > +}
> > > +
> > > +static void dw8250_sunxi_setup(struct uart_port *p)
> > > +{
> > > +     struct dw8250_data *data =3D to_dw8250_data(p->private_data);
> > > +     struct uart_8250_port *up =3D up_to_u8250p(p);
> > > +
> > > +     p->type =3D PORT_16550A;
> > > +     p->flags |=3D UPF_FIXED_TYPE;
> > > +     p->fifosize =3D data->pdata->fifo_size;
> > > +     up->tx_loadsz =3D p->fifosize;
> > > +     up->capabilities =3D UART_CAP_FIFO | UART_CAP_NOTEMT | UART_CAP=
_AFE;
> > > +
> > > +     dw8250_sunxi_setup_rxtrig(p);
> > > +
> > > +     /* Use software RS485 with the Allwinner register layout. */
> > > +     p->rs485_config =3D serial8250_em485_config;
> > > +     p->rs485_supported =3D serial8250_em485_supported;
> > > +     up->rs485_start_tx =3D serial8250_em485_start_tx;
> > > +     up->rs485_stop_tx =3D serial8250_em485_stop_tx;
> > > +}
> > > +
> > >  static int dw8250_probe(struct platform_device *pdev)
> > >  {
> > >       struct uart_8250_port uart =3D {}, *up =3D &uart;
> > > @@ -878,6 +964,13 @@ static const struct dw8250_platform_data dw8250_=
dw_apb =3D {
> > >       .usr_reg =3D DW_UART_USR,
> > >  };
> > >
> > > +static const struct dw8250_platform_data dw8250_h616_data =3D {
> > > +     .usr_reg =3D DW_UART_USR,
> > > +     .fifo_size =3D 256,
> > > +     .quirks =3D DW_UART_QUIRK_SKIP_SET_RATE,
> > > +     .setup =3D dw8250_sunxi_setup,
> > > +};
> > > +
> > >  static const struct dw8250_platform_data dw8250_octeon_3860_data =3D=
 {
> > >       .usr_reg =3D OCTEON_UART_USR,
> > >       .quirks =3D DW_UART_QUIRK_OCTEON,
> > > @@ -929,6 +1022,7 @@ static const struct dw8250_platform_data dw8250_=
tda54 =3D {
> > >
> > >  static const struct of_device_id dw8250_of_match[] =3D {
> > >       { .compatible =3D "snps,dw-apb-uart", .data =3D &dw8250_dw_apb =
},
> > > +     { .compatible =3D "allwinner,sun50i-h616-uart", .data =3D &dw82=
50_h616_data },
> > >       { .compatible =3D "cavium,octeon-3860-uart", .data =3D &dw8250_=
octeon_3860_data },
> > >       { .compatible =3D "marvell,armada-38x-uart", .data =3D &dw8250_=
armada_38x_data },
> > >       { .compatible =3D "renesas,rzn1-uart", .data =3D &dw8250_renesa=
s_rzn1_data },
> > >
> > >
> >
> > --
> >  i.
> >
>=20

--=20
 i.

--8323328-1806327667-1793177873=:1157--
