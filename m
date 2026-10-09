Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D4E4BD797;
	Fri,  9 Oct 2026 11:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545167; cv=none; b=W92rE7TfAsDtkpkzSVp6SfJE7tY3H9pA1VyUErgnpdjGbGLptMtsUOPXn+EAsvG1kGBCw8EvcFzXiHYLzXa6bghT/zlA6TPzINXdYD0vHK/txyKxLnZPFyMybyw/4rrmojomU1n1p+622+j0ZNeX+wtIrJtfLzuxeVmRok8WEpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545167; c=relaxed/simple;
	bh=mzT+K+eQL75LGLi9oblAdn6AjqyK5IDMiYhZPm+w/7Q=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=URJxhNZS/L1245epQ+8Fxl5/mhv3Npgil9wvgFA53LKg2KsSRBVUYPv7+r5MUUtJUvdBe+MyrdFuhgiccmeZ5V2FyQv+zkVeG+6PWTpdhCRcbYcxzPv1gUeDvMH5AT5PaamnmDv4t+KkAvFEJmM5SL1FSPK36MsTnZVnBHpEesQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UWW1tT6O; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UWW1tT6O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791545155; x=1823081155;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mzT+K+eQL75LGLi9oblAdn6AjqyK5IDMiYhZPm+w/7Q=;
  b=UWW1tT6OLoPbkEb6v9mJXEWEWyvQNXdmq+OTYzIbYJ+R7t3Lw0n4JvCY
   MtIrwLhU/U8qlsOXdHlIHsB7ORF8Lhc+UFHZ2K+pJ8CnHVRl4Eh16Xtcu
   WkNb/FJfY3oVZCm7fthno3Y5uEpet1eLILKDojWlqvBL3tZmTRG5LkxI1
   ignzBeV0HxaLQGYfnowGM28n1Vz4flhgpYOCdFJUghHduEQLspzGl+46O
   aL2Em9iLakSRLVmJdpsegTybbHgVTdImwlDSWOxAT9nzFO0F5NsJnHEA7
   urELrmvoc1eCVbe9bJsUxiEwXCHQYJGDC3kVc53hRztoql8lR8M6KyTSx
   g==;
X-CSE-ConnectionGUID: K1LUrzt8TXCc/20Klg9I3g==
X-CSE-MsgGUID: HnV8HUfoSx2gTrMdrqB0pA==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="348816"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="348816"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 04:25:52 -0700
X-CSE-ConnectionGUID: ayzSbFgBSbKeacWaL4VXbA==
X-CSE-MsgGUID: mg624Yp9S9W+hHrkSirIfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="2092354"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.39])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 04:25:39 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 9 Oct 2026 14:25:36 +0300 (EEST)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
    Richard Cochran <richardcochran@gmail.com>, 
    Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Joel Stanley <joel@jms.id.au>, 
    Andrew Jeffery <andrew@codeconstruct.com.au>, 
    Ryan Chen <ryan_chen@aspeedtech.com>, 
    Billy Tsai <billy_tsai@aspeedtech.com>, 
    Florian Fainelli <florian.fainelli@broadcom.com>, 
    Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
    Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
    Al Cooper <alcooperx@gmail.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Paul Cercueil <paul@crapouillou.net>, 
    Matthias Brugger <matthias.bgg@gmail.com>, 
    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
    Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>, 
    "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
    Helge Deller <deller@gmx.de>, 
    Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>, 
    Thierry Reding <thierry.reding@kernel.org>, 
    Jonathan Hunter <jonathanh@nvidia.com>, 
    Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
    Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <kees@kernel.org>, 
    "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
    =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
    Netdev <netdev@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
    linux-rpi-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
    linux-mediatek@lists.infradead.org, linux-parisc@vger.kernel.org, 
    linux-tegra@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/3] serial: 8250: make port operations work on struct
 uart_8250_port
In-Reply-To: <dde18b78e0988a2c45e84c13938f1521e5c8b9f9.1791524724.git.jirislaby@kernel.org>
Message-ID: <9a08fb1a-1e2d-6477-06db-b201c8c425b4@linux.intel.com>
References: <cover.1791524724.git.jirislaby@kernel.org> <dde18b78e0988a2c45e84c13938f1521e5c8b9f9.1791524724.git.jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-736474618-1791545136=:8329"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-736474618-1791545136=:8329
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 9 Oct 2026, Jiri Slaby (SUSE) wrote:

> serial8250_register_8250_port() returns a line number and the other
> port operations (serial8250_unregister_port(), serial8250_suspend_port(),
> serial8250_resume_port()) accept it. Many drivers then convert the line
> back to the port using serial8250_get_port() anyway.
>=20
> Switch the interface to struct uart_8250_port:
> * serial8250_register_8250_port() now returns the registered port, or
> an ERR_PTR() on failure.
> * serial8250_unregister_port(), serial8250_suspend_port() and
> serial8250_resume_port() accept the port.
>=20
> Convert all users accordingly. Drivers store the port pointer instead
> of the line number. Several drivers kept a private struct only to hold
> the line (airoha, dfl, em, fsl, ioc3); these are dropped and the port
> is stored as drvdata directly.
>=20
> This also fixes two latent issues:
> * For a CIR port, serial8250_register_8250_port() used to return 0.
> Callers stored this as the line, so a later unregister/suspend/resume
> operated on ttyS0. Now the CIR port itself is returned.
> * 8250_acorn checked ports[i] > 0 on removal, so a port registered as
> line 0 was never unregistered.
>=20
> There are no more users of serial8250_get_port() outside of the 8250
> core, so drop its EXPORT.
>=20
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Assisted-by: LLM
> ---
> Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@kernel.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
> Cc: Ryan Chen <ryan_chen@aspeedtech.com>
> Cc: Billy Tsai <billy_tsai@aspeedtech.com>
> Cc: Florian Fainelli <florian.fainelli@broadcom.com>
> Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadc=
om.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: Al Cooper <alcooperx@gmail.com>
> Cc: "Ilpo J=C3=A4rvinen" <ilpo.jarvinen@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Paul Cercueil <paul@crapouillou.net>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Cc: Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> Cc: Thierry Reding <thierry.reding@kernel.org>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Kees Cook <kees@kernel.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: "Uwe Kleine-K=C3=B6nig (The Capable Hub)" <u.kleine-koenig@baylibre.c=
om>
> Cc: netdev@vger.kernel.org
> Cc: linux-serial@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-aspeed@lists.ozlabs.org
> Cc: linux-rpi-kernel@lists.infradead.org
> Cc: linux-mips@vger.kernel.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> ---
>  drivers/ptp/ptp_ocp.c                       | 36 +++++++++---------
>  drivers/tty/serial/8250/8250_acorn.c        |  5 ++-
>  drivers/tty/serial/8250/8250_airoha.c       | 22 +++--------
>  drivers/tty/serial/8250/8250_aspeed_vuart.c | 12 +++---
>  drivers/tty/serial/8250/8250_bcm2835aux.c   | 19 +++++-----
>  drivers/tty/serial/8250/8250_bcm7271.c      | 32 +++++++---------
>  drivers/tty/serial/8250/8250_core.c         | 37 +++++++------------
>  drivers/tty/serial/8250/8250_dfl.c          | 21 +++--------
>  drivers/tty/serial/8250/8250_dw.c           | 12 +++---
>  drivers/tty/serial/8250/8250_dwlib.h        |  2 +-
>  drivers/tty/serial/8250/8250_em.c           | 25 ++++---------
>  drivers/tty/serial/8250/8250_exar.c         | 21 +++++------
>  drivers/tty/serial/8250/8250_fsl.c          | 23 ++++--------
>  drivers/tty/serial/8250/8250_hp300.c        | 27 ++++++--------
>  drivers/tty/serial/8250/8250_ingenic.c      | 10 ++---
>  drivers/tty/serial/8250/8250_ioc3.c         | 25 ++++---------
>  drivers/tty/serial/8250/8250_keba.c         | 13 +++----
>  drivers/tty/serial/8250/8250_loongson.c     | 19 +++++-----
>  drivers/tty/serial/8250/8250_lpc18xx.c      | 10 ++---
>  drivers/tty/serial/8250/8250_lpss.c         | 21 ++++-------
>  drivers/tty/serial/8250/8250_men_mcb.c      | 13 +++----
>  drivers/tty/serial/8250/8250_mid.c          | 12 +++---
>  drivers/tty/serial/8250/8250_mtk.c          | 18 ++++-----
>  drivers/tty/serial/8250/8250_mxpcie.c       | 13 ++++---
>  drivers/tty/serial/8250/8250_ni.c           | 11 +++---
>  drivers/tty/serial/8250/8250_of.c           | 24 ++++++------
>  drivers/tty/serial/8250/8250_omap.c         | 41 +++++++++------------
>  drivers/tty/serial/8250/8250_parisc.c       | 13 +++----
>  drivers/tty/serial/8250/8250_pci.c          | 21 +++++------
>  drivers/tty/serial/8250/8250_pci1xxxx.c     | 40 ++++++++++----------
>  drivers/tty/serial/8250/8250_pericom.c      | 14 +++----
>  drivers/tty/serial/8250/8250_platform.c     | 22 +++++------
>  drivers/tty/serial/8250/8250_pnp.c          | 20 +++++-----
>  drivers/tty/serial/8250/8250_pxa.c          | 16 ++++----
>  drivers/tty/serial/8250/8250_tegra.c        | 19 +++++-----
>  drivers/tty/serial/8250/8250_uniphier.c     | 20 +++++-----
>  drivers/tty/serial/8250/serial_cs.c         | 14 +++----
>  include/linux/serial_8250.h                 |  8 ++--
>  38 files changed, 319 insertions(+), 412 deletions(-)
>=20
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 2802989e8494..609cee1d2c80 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -344,7 +344,7 @@ struct ptp_ocp_signal {
>  };
> =20
>  struct ptp_ocp_serial_port {
> -=09int line;
> +=09struct uart_8250_port *uport;
>  =09int baud;
>  };
> =20
> @@ -2629,7 +2629,7 @@ ptp_ocp_register_ext(struct ptp_ocp *bp, struct ocp=
_resource *r)
>  =09return err;
>  }
> =20
> -static int
> +static struct uart_8250_port *
>  ptp_ocp_serial_line(struct ptp_ocp *bp, struct ocp_resource *r)
>  {
>  =09struct pci_dev *pdev =3D bp->pdev;
> @@ -2657,9 +2657,11 @@ ptp_ocp_register_serial(struct ptp_ocp *bp, struct=
 ocp_resource *r)
>  =09struct ptp_ocp_serial_port *p =3D (struct ptp_ocp_serial_port *)r->ex=
tra;
>  =09struct ptp_ocp_serial_port port =3D {};
> =20
> -=09port.line =3D ptp_ocp_serial_line(bp, r);
> -=09if (port.line < 0)
> -=09=09return port.line;
> +=09struct uart_8250_port *uport =3D ptp_ocp_serial_line(bp, r);
> +=09if (IS_ERR(uport))
> +=09=09return PTR_ERR(uport);
> +
> +=09port.uport =3D uport;
> =20
>  =09if (p)
>  =09=09port.baud =3D p->baud;
> @@ -3804,7 +3806,7 @@ ptp_ocp_tty_show(struct device *dev, struct device_=
attribute *attr, char *buf)
>  =09 * as a device path (e.g., "/dev/ttyS4"), and adding a newline would
>  =09 * break those applications. Do not add a newline to this output.
>  =09 */
> -=09return sysfs_emit(buf, "ttyS%d", bp->port[(uintptr_t)ea->var].line);
> +=09return sysfs_emit(buf, "ttyS%d", bp->port[(uintptr_t)ea->var].uport->=
port.line);
>  }
> =20
>  static umode_t
> @@ -3821,7 +3823,7 @@ ptp_ocp_timecard_tty_is_visible(struct kobject *kob=
j, struct attribute *attr, in
>  =09dattr =3D container_of(attr, struct device_attribute, attr);
>  =09ea =3D container_of(dattr, struct dev_ext_attribute, attr);
>  =09port =3D &bp->port[(uintptr_t)ea->var];
> -=09return port->line =3D=3D -1 ? 0 : 0444;
> +=09return port->uport ? 0444 : 0;
>  }
> =20
>  #define EXT_TTY_ATTR_RO(_name, _val)=09=09=09\
> @@ -5287,9 +5289,9 @@ ptp_ocp_summary_show(struct seq_file *s, void *data=
)
> =20
>  =09seq_printf(s, "%7s: /dev/ptp%d\n", "PTP", ptp_clock_index(bp->ptp));
>  =09for (i =3D 0; i < __PORT_COUNT; i++) {
> -=09=09if (bp->port[i].line !=3D -1)
> +=09=09if (bp->port[i].uport)
>  =09=09=09seq_printf(s, "%7s: /dev/ttyS%d\n", ptp_ocp_tty_port_name(i),
> -=09=09=09=09   bp->port[i].line);
> +=09=09=09=09   bp->port[i].uport->port.line);
>  =09}
> =20
>  =09memset(sma_val, 0xff, sizeof(sma_val));
> @@ -5613,7 +5615,7 @@ ptp_ocp_device_init(struct ptp_ocp *bp, struct pci_=
dev *pdev)
>  =09spin_lock_init(&bp->lock);
> =20
>  =09for (i =3D 0; i < __PORT_COUNT; i++)
> -=09=09bp->port[i].line =3D -1;
> +=09=09bp->port[i].uport =3D NULL;
> =20
>  =09bp->pdev =3D pdev;
> =20
> @@ -5702,10 +5704,10 @@ ptp_ocp_phc_info(struct ptp_ocp *bp)
>  }
> =20
>  static void
> -ptp_ocp_serial_info(struct device *dev, const char *name, int port, int =
baud)
> +ptp_ocp_serial_info(struct device *dev, const char *name, struct uart_82=
50_port *port, int baud)
>  {
> -=09if (port !=3D -1)
> -=09=09dev_info(dev, "%5s: /dev/ttyS%-2d @ %6d\n", name, port, baud);
> +=09if (port)
> +=09=09dev_info(dev, "%5s: /dev/ttyS%-2d @ %6d\n", name, port->port.line,=
 baud);
>  }
> =20
>  static void
> @@ -5723,14 +5725,14 @@ ptp_ocp_info(struct ptp_ocp *bp)
>  =09ptp_ocp_phc_info(bp);
> =20
>  =09for (i =3D 0; i < __PORT_COUNT; i++) {
> -=09=09if (i =3D=3D PORT_NMEA && bp->nmea_out && bp->port[PORT_NMEA].line=
 !=3D -1) {
> +=09=09if (i =3D=3D PORT_NMEA && bp->nmea_out && bp->port[PORT_NMEA].upor=
t) {
>  =09=09=09bp->port[PORT_NMEA].baud =3D -1;
> =20
>  =09=09=09reg =3D ioread32(&bp->nmea_out->uart_baud);
>  =09=09=09if (reg < ARRAY_SIZE(nmea_baud))
>  =09=09=09=09bp->port[PORT_NMEA].baud =3D nmea_baud[reg];
>  =09=09}
> -=09=09ptp_ocp_serial_info(dev, ptp_ocp_tty_port_name(i), bp->port[i].lin=
e,
> +=09=09ptp_ocp_serial_info(dev, ptp_ocp_tty_port_name(i), bp->port[i].upo=
rt,
>  =09=09=09=09    bp->port[i].baud);
>  =09}
>  }
> @@ -5778,8 +5780,8 @@ ptp_ocp_detach(struct ptp_ocp *bp)
>  =09for (i =3D 0; i < 4; i++)
>  =09=09ptp_ocp_unregister_ext(bp->signal_out[i]);
>  =09for (i =3D 0; i < __PORT_COUNT; i++)
> -=09=09if (bp->port[i].line !=3D -1)
> -=09=09=09serial8250_unregister_port(bp->port[i].line);
> +=09=09if (bp->port[i].uport)
> +=09=09=09serial8250_unregister_port(bp->port[i].uport);
>  =09platform_device_unregister(bp->spi_flash);
>  =09platform_device_unregister(bp->i2c_ctrl);
>  =09if (bp->i2c_clk)
> diff --git a/drivers/tty/serial/8250/8250_acorn.c b/drivers/tty/serial/82=
50/8250_acorn.c
> index fb596262b9c7..d0696668493a 100644
> --- a/drivers/tty/serial/8250/8250_acorn.c
> +++ b/drivers/tty/serial/8250/8250_acorn.c
> @@ -8,6 +8,7 @@
>  #include <linux/types.h>
>  #include <linux/tty.h>
>  #include <linux/serial_core.h>
> +#include <linux/err.h>
>  #include <linux/errno.h>
>  #include <linux/ioport.h>
>  #include <linux/slab.h>
> @@ -31,7 +32,7 @@ struct serial_card_type {
> =20
>  struct serial_card_info {
>  =09unsigned int=09num_ports;
> -=09int=09=09ports[MAX_PORTS];
> +=09struct uart_8250_port *ports[MAX_PORTS];
>  =09void __iomem *vaddr;
>  };
> =20
> @@ -85,7 +86,7 @@ static void serial_card_remove(struct expansion_card *e=
c)
>  =09ecard_set_drvdata(ec, NULL);
> =20
>  =09for (i =3D 0; i < info->num_ports; i++)
> -=09=09if (info->ports[i] > 0)
> +=09=09if (!IS_ERR_OR_NULL(info->ports[i]))
>  =09=09=09serial8250_unregister_port(info->ports[i]);
> =20
>  =09kfree(info);
> diff --git a/drivers/tty/serial/8250/8250_airoha.c b/drivers/tty/serial/8=
250/8250_airoha.c
> index fe72a39561c2..44aeb427d5c8 100644
> --- a/drivers/tty/serial/8250/8250_airoha.c
> +++ b/drivers/tty/serial/8250/8250_airoha.c
> @@ -28,10 +28,6 @@
>  #define   UART_AIROHA_XYD_X=09GENMASK(31, 16)
>  #define   UART_AIROHA_XYD_Y=09GENMASK(15, 0)
> =20
> -struct airoha_8250_priv {
> -=09int line;
> -};
> -
>  #define UART_BRD_20M=09=090x0001
> =20
>  #define XINDIV_CLOCK=09=09(20 * HZ_PER_MHZ)
> @@ -119,7 +115,6 @@ static int airoha_8250_probe(struct platform_device *=
pdev)
>  {
>  =09struct uart_8250_port uart =3D { };
>  =09struct device *dev =3D &pdev->dev;
> -=09struct airoha_8250_priv *priv;
>  =09struct resource *res;
>  =09int ret;
> =20
> @@ -127,10 +122,6 @@ static int airoha_8250_probe(struct platform_device =
*pdev)
>  =09if (!res)
>  =09=09return dev_err_probe(dev, -EINVAL, "invalid address\n");
> =20
> -=09priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> -=09if (!priv)
> -=09=09return -ENOMEM;
> -
>  =09uart.port.dev =3D dev;
>  =09if (device_is_compatible(dev, "airoha,an7581-hsuart"))
>  =09=09uart.port.type =3D UART_PORT_AIROHA_HS;
> @@ -147,21 +138,20 @@ static int airoha_8250_probe(struct platform_device=
 *pdev)
>  =09if (ret)
>  =09=09return ret;
> =20
> -=09ret =3D serial8250_register_8250_port(&uart);
> -=09if (ret < 0)
> -=09=09return ret;
> +=09struct uart_8250_port *uport =3D serial8250_register_8250_port(&uart)=
;
> +=09if (IS_ERR(uport))
> +=09=09return PTR_ERR(uport);
> =20
> -=09priv->line =3D ret;
> -=09platform_set_drvdata(pdev, priv);
> +=09platform_set_drvdata(pdev, uport);
> =20
>  =09return 0;
>  }
> =20
>  static void airoha_8250_remove(struct platform_device *ofdev)
>  {
> -=09struct airoha_8250_priv *priv =3D platform_get_drvdata(ofdev);
> +=09struct uart_8250_port *uport =3D platform_get_drvdata(ofdev);
> =20
> -=09serial8250_unregister_port(priv->line);
> +=09serial8250_unregister_port(uport);
>  }
> =20
>  static const struct of_device_id airoha_8250_dt_ids[] =3D {
> diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/se=
rial/8250/8250_aspeed_vuart.c
> index 26fc0464f1cc..604e4946fd1d 100644
> --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
> +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> @@ -34,7 +34,6 @@
> =20
>  struct aspeed_vuart {
>  =09struct device=09=09*dev;
> -=09int=09=09=09line;
>  =09struct timer_list=09unthrottle_timer;
>  =09struct uart_8250_port=09*port;
>  };
> @@ -484,12 +483,13 @@ static int aspeed_vuart_probe(struct platform_devic=
e *pdev)
>  =09if (of_property_read_bool(np, "auto-flow-control"))
>  =09=09port.capabilities |=3D UART_CAP_AFE;
> =20
> -=09rc =3D serial8250_register_8250_port(&port);
> -=09if (rc < 0)
> +=09struct uart_8250_port *uport =3D serial8250_register_8250_port(&port)=
;
> +=09if (IS_ERR(uport)) {
> +=09=09rc =3D PTR_ERR(uport);
>  =09=09goto err_sysfs_remove;
> +=09}
> =20
> -=09vuart->line =3D rc;
> -=09vuart->port =3D serial8250_get_port(vuart->line);
> +=09vuart->port =3D uport;
> =20
>  =09rc =3D of_parse_phandle_with_fixed_args(
>  =09=09np, "aspeed,sirq-polarity-sense", 2, 0,
> @@ -553,7 +553,7 @@ static void aspeed_vuart_remove(struct platform_devic=
e *pdev)
> =20
>  =09timer_delete_sync(&vuart->unthrottle_timer);
>  =09aspeed_vuart_set_enabled(vuart, false);
> -=09serial8250_unregister_port(vuart->line);
> +=09serial8250_unregister_port(vuart->port);
>  =09sysfs_remove_group(&vuart->dev->kobj, &aspeed_vuart_attr_group);
>  }
> =20
> diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/seri=
al/8250/8250_bcm2835aux.c
> index 0609582a62f7..78b40bf1363b 100644
> --- a/drivers/tty/serial/8250/8250_bcm2835aux.c
> +++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
> @@ -37,12 +37,12 @@
>  /**
>   * struct bcm2835aux_data - driver private data of BCM2835 auxiliary UAR=
T
>   * @clk: clock producer of the port's uartclk
> - * @line: index of the port's serial8250_ports[] entry
> + * @uport: the underlying uart_8250_port
>   * @cntl: cached copy of CNTL register
>   */
>  struct bcm2835aux_data {
>  =09struct clk *clk;
> -=09int line;
> +=09struct uart_8250_port *uport;
>  =09u32 cntl;
>  };
> =20
> @@ -157,12 +157,12 @@ static int bcm2835aux_serial_probe(struct platform_=
device *pdev)
>  =09up.port.uartclk *=3D 2;
> =20
>  =09/* register the port */
> -=09ret =3D serial8250_register_8250_port(&up);
> -=09if (ret < 0) {
> +=09data->uport =3D serial8250_register_8250_port(&up);
> +=09if (IS_ERR(data->uport)) {
> +=09=09ret =3D PTR_ERR(data->uport);
>  =09=09dev_err_probe(&pdev->dev, ret, "unable to register 8250 port\n");
>  =09=09goto dis_clk;
>  =09}
> -=09data->line =3D ret;
> =20
>  =09return 0;
> =20
> @@ -177,7 +177,7 @@ static void bcm2835aux_serial_remove(struct platform_=
device *pdev)
>  {
>  =09struct bcm2835aux_data *data =3D platform_get_drvdata(pdev);
> =20
> -=09serial8250_unregister_port(data->line);
> +=09serial8250_unregister_port(data->uport);
>  =09clk_disable_unprepare(data->clk);
>  =09device_remove_software_node(&pdev->dev);
>  }
> @@ -217,12 +217,11 @@ MODULE_DEVICE_TABLE(acpi, bcm2835aux_serial_acpi_ma=
tch);
>  static bool bcm2835aux_can_disable_clock(struct device *dev)
>  {
>  =09struct bcm2835aux_data *data =3D dev_get_drvdata(dev);
> -=09struct uart_8250_port *up =3D serial8250_get_port(data->line);
> =20
>  =09if (device_may_wakeup(dev))
>  =09=09return false;
> =20
> -=09if (uart_console(&up->port) && !console_suspend_enabled)
> +=09if (uart_console(&data->uport->port) && !console_suspend_enabled)
>  =09=09return false;
> =20
>  =09return true;
> @@ -232,7 +231,7 @@ static int bcm2835aux_suspend(struct device *dev)
>  {
>  =09struct bcm2835aux_data *data =3D dev_get_drvdata(dev);
> =20
> -=09serial8250_suspend_port(data->line);
> +=09serial8250_suspend_port(data->uport);
> =20
>  =09if (!bcm2835aux_can_disable_clock(dev))
>  =09=09return 0;
> @@ -252,7 +251,7 @@ static int bcm2835aux_resume(struct device *dev)
>  =09=09=09return ret;
>  =09}
> =20
> -=09serial8250_resume_port(data->line);
> +=09serial8250_resume_port(data->uport);
> =20
>  =09return 0;
>  }
> diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/=
8250/8250_bcm7271.c
> index 5f1140f05150..ff75b0df41f4 100644
> --- a/drivers/tty/serial/8250/8250_bcm7271.c
> +++ b/drivers/tty/serial/8250/8250_bcm7271.c
> @@ -204,13 +204,12 @@ static const u32 brcmstb_rate_table_7278[] =3D {
>  };
> =20
>  struct brcmuart_priv {
> -=09int=09=09line;
>  =09struct clk=09*baud_mux_clk;
>  =09unsigned long=09default_mux_rate;
>  =09u32=09=09real_rates[ARRAY_SIZE(brcmstb_rate_table)];
>  =09const u32=09*rate_table;
>  =09ktime_t=09=09char_wait;
> -=09struct uart_port *up;
> +=09struct uart_8250_port *uport;
>  =09struct hrtimer=09hrt;
>  =09bool=09=09shutdown;
>  =09bool=09=09dma_enabled;
> @@ -839,8 +838,8 @@ static int brcmuart_handle_irq(struct uart_port *p)
>  static enum hrtimer_restart brcmuart_hrtimer_func(struct hrtimer *t)
>  {
>  =09struct brcmuart_priv *priv =3D container_of(t, struct brcmuart_priv, =
hrt);
> -=09struct uart_port *p =3D priv->up;
> -=09struct uart_8250_port *up =3D up_to_u8250p(p);
> +=09struct uart_8250_port *up =3D priv->uport;
> +=09struct uart_port *p =3D &up->port;
>  =09unsigned int status;
>  =09unsigned long flags;
> =20
> @@ -953,7 +952,6 @@ static int brcmuart_probe(struct platform_device *pde=
v)
>  {
>  =09struct resource *regs;
>  =09const struct of_device_id *of_id =3D NULL;
> -=09struct uart_8250_port *new_port;
>  =09struct device *dev =3D &pdev->dev;
>  =09struct brcmuart_priv *priv;
>  =09struct clk *baud_mux_clk;
> @@ -1083,14 +1081,12 @@ static int brcmuart_probe(struct platform_device =
*pdev)
>  =09=09}
>  =09}
> =20
> -=09ret =3D serial8250_register_8250_port(&up);
> -=09if (ret < 0) {
> +=09priv->uport =3D serial8250_register_8250_port(&up);
> +=09if (IS_ERR(priv->uport)) {
> +=09=09ret =3D PTR_ERR(priv->uport);
>  =09=09dev_err_probe(dev, ret, "unable to register 8250 port\n");
>  =09=09goto err;
>  =09}
> -=09priv->line =3D ret;
> -=09new_port =3D serial8250_get_port(ret);
> -=09priv->up =3D &new_port->port;
>  =09if (priv->dma_enabled) {
>  =09=09dma_irq =3D platform_get_irq_byname(pdev,  "dma");
>  =09=09if (dma_irq < 0) {
> @@ -1098,7 +1094,7 @@ static int brcmuart_probe(struct platform_device *p=
dev)
>  =09=09=09goto err1;
>  =09=09}
>  =09=09ret =3D devm_request_irq(dev, dma_irq, brcmuart_isr,
> -=09=09=09=09IRQF_SHARED, "uart DMA irq", &new_port->port);
> +=09=09=09=09IRQF_SHARED, "uart DMA irq", &priv->uport->port);
>  =09=09if (ret)
>  =09=09=09goto err1;
>  =09}
> @@ -1107,7 +1103,7 @@ static int brcmuart_probe(struct platform_device *p=
dev)
>  =09return 0;
> =20
>  err1:
> -=09serial8250_unregister_port(priv->line);
> +=09serial8250_unregister_port(priv->uport);
>  err:
>  =09brcmuart_free_bufs(dev, priv);
>  release_dma:
> @@ -1121,7 +1117,7 @@ static void brcmuart_remove(struct platform_device =
*pdev)
>  =09struct brcmuart_priv *priv =3D platform_get_drvdata(pdev);
> =20
>  =09debugfs_remove_recursive(priv->debugfs_dir);
> -=09serial8250_unregister_port(priv->line);
> +=09serial8250_unregister_port(priv->uport);
>  =09hrtimer_cancel(&priv->hrt);
>  =09brcmuart_free_bufs(&pdev->dev, priv);
>  =09if (priv->dma_enabled)
> @@ -1131,7 +1127,7 @@ static void brcmuart_remove(struct platform_device =
*pdev)
>  static int __maybe_unused brcmuart_suspend(struct device *dev)
>  {
>  =09struct brcmuart_priv *priv =3D dev_get_drvdata(dev);
> -=09struct uart_8250_port *up =3D serial8250_get_port(priv->line);
> +=09struct uart_8250_port *up =3D priv->uport;
>  =09struct uart_port *port =3D &up->port;
>  =09unsigned long flags;
> =20
> @@ -1144,7 +1140,7 @@ static int __maybe_unused brcmuart_suspend(struct d=
evice *dev)
>  =09port->mctrl &=3D ~TIOCM_RTS;
>  =09uart_port_unlock_irqrestore(port, flags);
> =20
> -=09serial8250_suspend_port(priv->line);
> +=09serial8250_suspend_port(up);
>  =09clk_disable_unprepare(priv->baud_mux_clk);
> =20
>  =09return 0;
> @@ -1153,7 +1149,7 @@ static int __maybe_unused brcmuart_suspend(struct d=
evice *dev)
>  static int __maybe_unused brcmuart_resume(struct device *dev)
>  {
>  =09struct brcmuart_priv *priv =3D dev_get_drvdata(dev);
> -=09struct uart_8250_port *up =3D serial8250_get_port(priv->line);
> +=09struct uart_8250_port *up =3D priv->uport;
>  =09struct uart_port *port =3D &up->port;
>  =09unsigned long flags;
>  =09int ret;
> @@ -1175,9 +1171,9 @@ static int __maybe_unused brcmuart_resume(struct de=
vice *dev)
>  =09=09=09return(-EBUSY);
>  =09=09}
>  =09=09brcmuart_init_dma_hardware(priv);
> -=09=09start_rx_dma(serial8250_get_port(priv->line));
> +=09=09start_rx_dma(up);
>  =09}
> -=09serial8250_resume_port(priv->line);
> +=09serial8250_resume_port(up);
> =20
>  =09if (priv->saved_mctrl & TIOCM_RTS) {
>  =09=09/* Restore RTS */
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/825=
0/8250_core.c
> index 11424fef7c08..6ca6b3bed80f 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -333,7 +333,6 @@ struct uart_8250_port *serial8250_get_port(int line)
>  {
>  =09return &serial8250_ports[line];
>  }
> -EXPORT_SYMBOL_GPL(serial8250_get_port);
> =20
>  static inline void serial8250_apply_quirks(struct uart_8250_port *up)
>  {
> @@ -600,13 +599,12 @@ int __init early_serial_setup(struct uart_port *por=
t)
> =20
>  /**
>   *=09serial8250_suspend_port - suspend one serial port
> - *=09@line:  serial line number
> + *=09@up: serial port
>   *
>   *=09Suspend one serial port.
>   */
> -void serial8250_suspend_port(int line)
> +void serial8250_suspend_port(struct uart_8250_port *up)
>  {
> -=09struct uart_8250_port *up =3D &serial8250_ports[line];
>  =09struct uart_port *port =3D &up->port;
> =20
>  =09if (uart_console(port)) {
> @@ -630,13 +628,12 @@ EXPORT_SYMBOL(serial8250_suspend_port);
> =20
>  /**
>   *=09serial8250_resume_port - resume one serial port
> - *=09@line:  serial line number
> + *=09@up: serial port
>   *
>   *=09Resume one serial port.
>   */
> -void serial8250_resume_port(int line)
> +void serial8250_resume_port(struct uart_8250_port *up)
>  {
> -=09struct uart_8250_port *up =3D &serial8250_ports[line];
>  =09struct uart_port *port =3D &up->port;
> =20
>  =09up->canary =3D 0;
> @@ -754,16 +751,16 @@ static void serial_8250_overrun_backoff_work(struct=
 work_struct *work)
>   *=09The port is then probed and if necessary the IRQ is autodetected
>   *=09If this fails an error is returned.
>   *
> - *=09On success the port is ready to use and the line number is returned=
=2E
> + *=09On success, the port is returned as ready to use.
>   */
> -int serial8250_register_8250_port(const struct uart_8250_port *up)
> +struct uart_8250_port *serial8250_register_8250_port(const struct uart_8=
250_port *up)
>  {
>  =09struct uart_8250_port *uart;
>  =09bool cons_flow;
>  =09int ret;
> =20
>  =09if (up->port.uartclk =3D=3D 0)
> -=09=09return -EINVAL;
> +=09=09return ERR_PTR(-EINVAL);
> =20
>  =09guard(mutex)(&serial_mutex);
> =20
> @@ -775,13 +772,13 @@ int serial8250_register_8250_port(const struct uart=
_8250_port *up)
>  =09=09 */
>  =09=09uart =3D serial8250_setup_port(nr_uarts);
>  =09=09if (!uart)
> -=09=09=09return -ENOSPC;
> +=09=09=09return ERR_PTR(-ENOSPC);
>  =09=09nr_uarts++;
>  =09}
> =20
>  =09/* Check if it is CIR already. We check this below again, see there w=
hy. */
>  =09if (uart->port.type =3D=3D PORT_8250_CIR)
> -=09=09return -ENODEV;
> +=09=09return ERR_PTR(-ENODEV);
> =20
>  =09/* Preserve specified console flow control. */
>  =09cons_flow =3D uart_cons_flow_enabled(&uart->port);
> @@ -901,16 +898,12 @@ int serial8250_register_8250_port(const struct uart=
_8250_port *up)
>  =09=09=09=09=09&uart->port);
>  =09=09if (ret)
>  =09=09=09goto err;
> -
> -=09=09ret =3D uart->port.line;
>  =09} else {
>  =09=09dev_info(uart->port.dev,
>  =09=09=09"skipping CIR port at 0x%lx / 0x%llx, IRQ %d\n",
>  =09=09=09uart->port.iobase,
>  =09=09=09(unsigned long long)uart->port.mapbase,
>  =09=09=09uart->port.irq);
> -
> -=09=09ret =3D 0;
>  =09}
> =20
>  =09if (!uart->lsr_save_mask)
> @@ -926,25 +919,23 @@ int serial8250_register_8250_port(const struct uart=
_8250_port *up)
>  =09=09uart->overrun_backoff_time_ms =3D 0;
>  =09}
> =20
> -=09return ret;
> +=09return uart;
> =20
>  err:
>  =09uart->port.dev =3D NULL;
> -=09return ret;
> +=09return ERR_PTR(ret);
>  }
>  EXPORT_SYMBOL(serial8250_register_8250_port);
> =20
>  /**
>   *=09serial8250_unregister_port - remove a 16x50 serial port at runtime
> - *=09@line: serial line number
> + *=09@uart: port
>   *
>   *=09Remove one serial port.  This may not be called from interrupt
>   *=09context.  We hand the port back to the our control.
>   */
> -void serial8250_unregister_port(int line)
> +void serial8250_unregister_port(struct uart_8250_port *uart)
>  {
> -=09struct uart_8250_port *uart =3D &serial8250_ports[line];
> -
>  =09guard(mutex)(&serial_mutex);
> =20
>  =09if (uart->em485) {
> @@ -957,7 +948,7 @@ void serial8250_unregister_port(int line)
>  =09=09uart->port.flags &=3D ~UPF_BOOT_AUTOCONF;
>  =09=09uart->port.type =3D PORT_UNKNOWN;
>  =09=09uart->port.dev =3D &serial8250_isa_devs->dev;
> -=09=09uart->port.port_id =3D line;
> +=09=09uart->port.port_id =3D uart->port.line;
>  =09=09uart->capabilities =3D 0;
>  =09=09serial8250_init_port(uart);
>  =09=09serial8250_apply_quirks(uart);
> diff --git a/drivers/tty/serial/8250/8250_dfl.c b/drivers/tty/serial/8250=
/8250_dfl.c
> index 475ca340948c..13d361ddfc4b 100644
> --- a/drivers/tty/serial/8250/8250_dfl.c
> +++ b/drivers/tty/serial/8250/8250_dfl.c
> @@ -27,10 +27,6 @@
>  #define DFHv1_PARAM_REG_LAYOUT_WIDTH=09GENMASK_ULL(63, 32)
>  #define DFHv1_PARAM_REG_LAYOUT_SHIFT=09GENMASK_ULL(31, 0)
> =20
> -struct dfl_uart {
> -=09int line;
> -};
> -
>  static int dfh_get_u64_param_val(struct dfl_device *dfl_dev, int param_i=
d, u64 *pval)
>  {
>  =09size_t psize;
> @@ -109,7 +105,6 @@ static int dfl_uart_probe(struct dfl_device *dfl_dev)
>  {
>  =09struct device *dev =3D &dfl_dev->dev;
>  =09struct uart_8250_port uart =3D { };
> -=09struct dfl_uart *dfluart;
>  =09int ret;
> =20
>  =09uart.port.flags =3D UPF_IOREMAP;
> @@ -123,24 +118,20 @@ static int dfl_uart_probe(struct dfl_device *dfl_de=
v)
>  =09if (dfl_dev->num_irqs =3D=3D 1)
>  =09=09uart.port.irq =3D dfl_dev->irqs[0];
> =20
> -=09dfluart =3D devm_kzalloc(dev, sizeof(*dfluart), GFP_KERNEL);
> -=09if (!dfluart)
> -=09=09return -ENOMEM;
> -
> -=09dfluart->line =3D serial8250_register_8250_port(&uart);
> -=09if (dfluart->line < 0)
> -=09=09return dev_err_probe(dev, dfluart->line, "unable to register 8250 =
port.\n");
> +=09struct uart_8250_port *uport =3D serial8250_register_8250_port(&uart)=
;
> +=09if (IS_ERR(uport))
> +=09=09return dev_err_probe(dev, PTR_ERR(uport), "unable to register 8250=
 port.\n");
> =20
> -=09dev_set_drvdata(dev, dfluart);
> +=09dev_set_drvdata(dev, uport);
> =20
>  =09return 0;
>  }
> =20
>  static void dfl_uart_remove(struct dfl_device *dfl_dev)
>  {
> -=09struct dfl_uart *dfluart =3D dev_get_drvdata(&dfl_dev->dev);
> +=09struct uart_8250_port *uport =3D dev_get_drvdata(&dfl_dev->dev);
> =20
> -=09serial8250_unregister_port(dfluart->line);
> +=09serial8250_unregister_port(uport);
>  }
> =20
>  #define FME_FEATURE_ID_UART 0x24
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/=
8250_dw.c
> index 0ab558230370..c259a940654f 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -774,9 +774,9 @@ static int dw8250_probe(struct platform_device *pdev)
>  =09=09up->dma =3D &data->data.dma;
>  =09}
> =20
> -=09data->data.line =3D serial8250_register_8250_port(up);
> -=09if (data->data.line < 0)
> -=09=09return data->data.line;
> +=09data->data.uport =3D serial8250_register_8250_port(up);
> +=09if (IS_ERR(data->data.uport))
> +=09=09return PTR_ERR(data->data.uport);

Add err.h.

> =20
>  =09platform_set_drvdata(pdev, data);
> =20
> @@ -792,7 +792,7 @@ static void dw8250_remove(struct platform_device *pde=
v)
> =20
>  =09pm_runtime_get_sync(dev);
> =20
> -=09serial8250_unregister_port(data->data.line);
> +=09serial8250_unregister_port(data->data.uport);
> =20
>  =09pm_runtime_disable(dev);
>  =09pm_runtime_put_noidle(dev);
> @@ -802,7 +802,7 @@ static int dw8250_suspend(struct device *dev)
>  {
>  =09struct dw8250_data *data =3D dev_get_drvdata(dev);
> =20
> -=09serial8250_suspend_port(data->data.line);
> +=09serial8250_suspend_port(data->data.uport);
> =20
>  =09return 0;
>  }
> @@ -811,7 +811,7 @@ static int dw8250_resume(struct device *dev)
>  {
>  =09struct dw8250_data *data =3D dev_get_drvdata(dev);
> =20
> -=09serial8250_resume_port(data->data.line);
> +=09serial8250_resume_port(data->data.uport);
> =20
>  =09return 0;
>  }
> diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/82=
50/8250_dwlib.h
> index ee7a07fac0f6..39fcb1b323ad 100644
> --- a/drivers/tty/serial/8250/8250_dwlib.h
> +++ b/drivers/tty/serial/8250/8250_dwlib.h
> @@ -80,7 +80,7 @@
> =20
>  struct dw8250_port_data {
>  =09/* Port properties */
> -=09int=09=09=09line;
> +=09struct uart_8250_port *uport;
> =20
>  =09/* DMA operations */
>  =09struct uart_8250_dma=09dma;
> diff --git a/drivers/tty/serial/8250/8250_em.c b/drivers/tty/serial/8250/=
8250_em.c
> index 32d077da076a..68c70f857e8d 100644
> --- a/drivers/tty/serial/8250/8250_em.c
> +++ b/drivers/tty/serial/8250/8250_em.c
> @@ -28,10 +28,6 @@
> =20
>  #define UART_HCR0_EM_SW_RESET=09BIT(7) /* SW Reset */
> =20
> -struct serial8250_em_priv {
> -=09int line;
> -};
> -
>  static void serial8250_em_serial_out_helper(struct uart_port *p, int off=
set,
>  =09=09=09=09=09    int value)
>  {
> @@ -151,12 +147,11 @@ static void serial8250_em_serial_dl_write(struct ua=
rt_8250_port *up, u32 value)
> =20
>  static int serial8250_em_probe(struct platform_device *pdev)
>  {
> -=09struct serial8250_em_priv *priv;
>  =09struct device *dev =3D &pdev->dev;
>  =09struct uart_8250_port up;
>  =09struct resource *regs;
>  =09struct clk *sclk;
> -=09int irq, ret;
> +=09int irq;
> =20
>  =09irq =3D platform_get_irq(pdev, 0);
>  =09if (irq < 0)
> @@ -166,10 +161,6 @@ static int serial8250_em_probe(struct platform_devic=
e *pdev)
>  =09if (!regs)
>  =09=09return dev_err_probe(dev, -EINVAL, "missing registers\n");
> =20
> -=09priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> -=09if (!priv)
> -=09=09return -ENOMEM;
> -
>  =09sclk =3D devm_clk_get_enabled(dev, "sclk");
>  =09if (IS_ERR(sclk))
>  =09=09return dev_err_probe(dev, PTR_ERR(sclk), "unable to get clock\n");
> @@ -180,7 +171,6 @@ static int serial8250_em_probe(struct platform_device=
 *pdev)
>  =09up.port.type =3D PORT_16750;
>  =09up.port.flags =3D UPF_FIXED_PORT | UPF_IOREMAP | UPF_FIXED_TYPE;
>  =09up.port.dev =3D dev;
> -=09up.port.private_data =3D priv;
> =20
>  =09up.port.uartclk =3D clk_get_rate(sclk);
> =20
> @@ -190,20 +180,19 @@ static int serial8250_em_probe(struct platform_devi=
ce *pdev)
>  =09up.dl_read =3D serial8250_em_serial_dl_read;
>  =09up.dl_write =3D serial8250_em_serial_dl_write;
> =20
> -=09ret =3D serial8250_register_8250_port(&up);
> -=09if (ret < 0)
> -=09=09return dev_err_probe(dev, ret, "unable to register 8250 port\n");
> +=09struct uart_8250_port *uport =3D serial8250_register_8250_port(&up);
> +=09if (IS_ERR(uport))
> +=09=09return dev_err_probe(dev, PTR_ERR(uport), "unable to register 8250=
 port\n");
> =20
> -=09priv->line =3D ret;
> -=09platform_set_drvdata(pdev, priv);
> +=09platform_set_drvdata(pdev, uport);
>  =09return 0;
>  }
> =20
>  static void serial8250_em_remove(struct platform_device *pdev)
>  {
> -=09struct serial8250_em_priv *priv =3D platform_get_drvdata(pdev);
> +=09struct uart_8250_port *up =3D platform_get_drvdata(pdev);
> =20
> -=09serial8250_unregister_port(priv->line);
> +=09serial8250_unregister_port(up);
>  }
> =20
>  static const struct of_device_id serial8250_em_dt_ids[] =3D {
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/825=
0/8250_exar.c
> index 836792e861bf..453e843b78ca 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -256,7 +256,7 @@ struct exar8250 {
>  =09struct exar8250_board=09*board;
>  =09struct eeprom_93cx6=09eeprom;
>  =09void __iomem=09=09*virt;
> -=09int=09=09=09line[];
> +=09struct uart_8250_port=09*uport[];
>  };
> =20
>  static inline void exar_write_reg(struct exar8250 *priv,
> @@ -1377,9 +1377,8 @@ static void pci_xr17v35x_exit(struct pci_dev *pcide=
v)
>  {
>  =09const struct exar8250_platform *platform =3D exar_get_platform();
>  =09struct exar8250 *priv =3D pci_get_drvdata(pcidev);
> -=09struct uart_8250_port *port =3D serial8250_get_port(priv->line[0]);
> =20
> -=09platform->unregister_gpio(port);
> +=09platform->unregister_gpio(priv->uport[0]);
>  }
> =20
>  static inline void exar_misc_clear(struct exar8250 *priv)
> @@ -1460,7 +1459,7 @@ exar_pci_probe(struct pci_dev *pcidev, const struct=
 pci_device_id *ent)
>  =09if (nr_ports =3D=3D 0)
>  =09=09return dev_err_probe(&pcidev->dev, -ENODEV, "failed to get number =
of ports\n");
> =20
> -=09priv =3D devm_kzalloc(&pcidev->dev, struct_size(priv, line, nr_ports)=
, GFP_KERNEL);
> +=09priv =3D devm_kzalloc(&pcidev->dev, struct_size(priv, uport, nr_ports=
), GFP_KERNEL);
>  =09if (!priv)
>  =09=09return -ENOMEM;
> =20
> @@ -1500,9 +1499,9 @@ exar_pci_probe(struct pci_dev *pcidev, const struct=
 pci_device_id *ent)
>  =09=09dev_dbg(&pcidev->dev, "Setup PCI port: port %lx, irq %d, type %d\n=
",
>  =09=09=09uart.port.iobase, uart.port.irq, uart.port.iotype);
> =20
> -=09=09priv->line[i] =3D serial8250_register_8250_port(&uart);
> -=09=09if (priv->line[i] < 0) {
> -=09=09=09dev_err_probe(&pcidev->dev, priv->line[i],
> +=09=09priv->uport[i] =3D serial8250_register_8250_port(&uart);
> +=09=09if (IS_ERR(priv->uport[i])) {
> +=09=09=09dev_err_probe(&pcidev->dev, PTR_ERR(priv->uport[i]),
>  =09=09=09=09"Couldn't register serial port %lx, type %d, irq %d\n",
>  =09=09=09=09uart.port.iobase, uart.port.iotype, uart.port.irq);
>  =09=09=09break;
> @@ -1519,7 +1518,7 @@ static void exar_pci_remove(struct pci_dev *pcidev)
>  =09unsigned int i;
> =20
>  =09for (i =3D 0; i < priv->nr; i++)
> -=09=09serial8250_unregister_port(priv->line[i]);
> +=09=09serial8250_unregister_port(priv->uport[i]);
> =20
>  =09/* Ensure that every init quirk is properly torn down */
>  =09if (priv->board->exit)
> @@ -1532,8 +1531,7 @@ static int exar_suspend(struct device *dev)
>  =09unsigned int i;
> =20
>  =09for (i =3D 0; i < priv->nr; i++)
> -=09=09if (priv->line[i] >=3D 0)
> -=09=09=09serial8250_suspend_port(priv->line[i]);
> +=09=09serial8250_suspend_port(priv->uport[i]);
> =20
>  =09return 0;
>  }
> @@ -1546,8 +1544,7 @@ static int exar_resume(struct device *dev)
>  =09exar_misc_clear(priv);
> =20
>  =09for (i =3D 0; i < priv->nr; i++)
> -=09=09if (priv->line[i] >=3D 0)
> -=09=09=09serial8250_resume_port(priv->line[i]);
> +=09=09serial8250_resume_port(priv->uport[i]);
> =20
>  =09return 0;
>  }
> diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250=
/8250_fsl.c
> index 649ae5c8304d..d4ba391e321b 100644
> --- a/drivers/tty/serial/8250/8250_fsl.c
> +++ b/drivers/tty/serial/8250/8250_fsl.c
> @@ -99,14 +99,9 @@ int fsl8250_handle_irq(struct uart_port *port)
>  EXPORT_SYMBOL_GPL(fsl8250_handle_irq);
> =20
>  #ifdef CONFIG_ACPI
> -struct fsl8250_data {
> -=09int=09line;
> -};
> -
>  static int fsl8250_acpi_probe(struct platform_device *pdev)
>  {
> -=09struct fsl8250_data *data;
> -=09struct uart_8250_port port8250;
> +=09struct uart_8250_port *uport, port8250;
>  =09struct device *dev =3D &pdev->dev;
>  =09struct resource *regs;
> =20
> @@ -148,23 +143,19 @@ static int fsl8250_acpi_probe(struct platform_devic=
e *pdev)
>  =09if (!port8250.port.membase)
>  =09=09return -ENOMEM;
> =20
> -=09data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> -=09if (!data)
> -=09=09return -ENOMEM;
> -
> -=09data->line =3D serial8250_register_8250_port(&port8250);
> -=09if (data->line < 0)
> -=09=09return data->line;
> +=09uport =3D serial8250_register_8250_port(&port8250);
> +=09if (IS_ERR(uport))
> +=09=09return PTR_ERR(uport);
> =20
> -=09platform_set_drvdata(pdev, data);
> +=09platform_set_drvdata(pdev, uport);
>  =09return 0;
>  }
> =20
>  static void fsl8250_acpi_remove(struct platform_device *pdev)
>  {
> -=09struct fsl8250_data *data =3D platform_get_drvdata(pdev);
> +=09struct uart_8250_port *uport =3D platform_get_drvdata(pdev);
> =20
> -=09serial8250_unregister_port(data->line);
> +=09serial8250_unregister_port(uport);
>  }
> =20
>  static const struct acpi_device_id fsl_8250_acpi_id[] =3D {
> diff --git a/drivers/tty/serial/8250/8250_hp300.c b/drivers/tty/serial/82=
50/8250_hp300.c
> index 59ec0c7377a1..c0227ec873c8 100644
> --- a/drivers/tty/serial/8250/8250_hp300.c
> +++ b/drivers/tty/serial/8250/8250_hp300.c
> @@ -27,7 +27,7 @@
>  #ifdef CONFIG_HPAPCI
>  struct hp300_port {
>  =09struct hp300_port *next;=09/* next port */
> -=09int line;=09=09=09/* line (tty) number */
> +=09struct uart_8250_port *uport;
>  };
> =20
>  static struct hp300_port *hp300_ports;
> @@ -157,8 +157,7 @@ int __init hp300_setup_serial_console(void)
>  static int hpdca_init_one(struct dio_dev *d,
>  =09=09=09=09const struct dio_device_id *ent)
>  {
> -=09struct uart_8250_port uart;
> -=09int line;
> +=09struct uart_8250_port *uport, uart;
> =20
>  #ifdef CONFIG_SERIAL_8250_CONSOLE
>  =09if (hp300_uart_scode =3D=3D d->scode) {
> @@ -177,9 +176,8 @@ static int hpdca_init_one(struct dio_dev *d,
>  =09uart.port.membase =3D (char *)(uart.port.mapbase + DIO_VIRADDRBASE);
>  =09uart.port.regshift =3D 1;
>  =09uart.port.dev =3D &d->dev;
> -=09line =3D serial8250_register_8250_port(&uart);
> -
> -=09if (line < 0) {
> +=09uport =3D serial8250_register_8250_port(&uart);
> +=09if (IS_ERR(uport)) {
>  =09=09dev_notice(&d->dev,
>  =09=09=09  "8250_hp300: register_serial() DCA scode %d irq %d failed\n",
>  =09=09=09  d->scode, uart.port.irq);
> @@ -188,7 +186,7 @@ static int hpdca_init_one(struct dio_dev *d,
> =20
>  =09/* Enable board-interrupts */
>  =09out_8(d->resource.start + DIO_VIRADDRBASE + DCA_IC, DCA_IC_IE);
> -=09dio_set_drvdata(d, (void *)line);
> +=09dio_set_drvdata(d, uport);
> =20
>  =09/* Reset the DCA */
>  =09out_8(d->resource.start + DIO_VIRADDRBASE + DCA_ID, 0xff);
> @@ -204,7 +202,6 @@ static int __init hp300_8250_init(void)
>  {
>  =09static int called;
>  #ifdef CONFIG_HPAPCI
> -=09int line;
>  =09unsigned long base;
>  =09struct uart_8250_port uart;
>  =09struct hp300_port *port;
> @@ -226,6 +223,7 @@ static int __init hp300_8250_init(void)
>  =09=09=09return -ENODEV;
>  =09=09return 0;
>  =09}
> +
>  =09/* These models have the Frodo chip.
>  =09 * Port 0 is reserved for the Apollo Domain keyboard.
>  =09 * Port 1 is either the console or the DCA.
> @@ -259,9 +257,8 @@ static int __init hp300_8250_init(void)
>  =09=09uart.port.membase =3D (char *)(base + DIO_VIRADDRBASE);
>  =09=09uart.port.regshift =3D 2;
> =20
> -=09=09line =3D serial8250_register_8250_port(&uart);
> -
> -=09=09if (line < 0) {
> +=09=09port->uport =3D serial8250_register_8250_port(&uart);
> +=09=09if (IS_ERR(port->uport)) {
>  =09=09=09dev_notice(uart.port.dev,
>  =09=09=09=09   "8250_hp300: register_serial() APCI %d irq %d failed\n",
>  =09=09=09=09   i, uart.port.irq);
> @@ -269,7 +266,6 @@ static int __init hp300_8250_init(void)
>  =09=09=09continue;
>  =09=09}
> =20
> -=09=09port->line =3D line;
>  =09=09port->next =3D hp300_ports;
>  =09=09hp300_ports =3D port;
> =20
> @@ -287,14 +283,13 @@ static int __init hp300_8250_init(void)
>  #ifdef CONFIG_HPDCA
>  static void hpdca_remove_one(struct dio_dev *d)
>  {
> -=09int line;
> +=09struct uart_8250_port *uport =3D dio_get_drvdata(d);
> =20
> -=09line =3D (int) dio_get_drvdata(d);
>  =09if (d->resource.start) {
>  =09=09/* Disable board-interrupts */
>  =09=09out_8(d->resource.start + DIO_VIRADDRBASE + DCA_IC, 0);
>  =09}
> -=09serial8250_unregister_port(line);
> +=09serial8250_unregister_port(uport);
>  }
>  #endif
> =20
> @@ -304,7 +299,7 @@ static void __exit hp300_8250_exit(void)
>  =09struct hp300_port *port, *to_free;
> =20
>  =09for (port =3D hp300_ports; port; ) {
> -=09=09serial8250_unregister_port(port->line);
> +=09=09serial8250_unregister_port(port->uport);
>  =09=09to_free =3D port;
>  =09=09port =3D port->next;
>  =09=09kfree(to_free);
> diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/=
8250/8250_ingenic.c
> index 94542fc143c2..8fedddeb38d9 100644
> --- a/drivers/tty/serial/8250/8250_ingenic.c
> +++ b/drivers/tty/serial/8250/8250_ingenic.c
> @@ -29,7 +29,7 @@ struct ingenic_uart_config {
>  struct ingenic_uart_data {
>  =09struct clk=09*clk_module;
>  =09struct clk=09*clk_baud;
> -=09int=09=09line;
> +=09struct uart_8250_port *uport;
>  };
> =20
>  static const struct of_device_id of_match[];
> @@ -297,9 +297,9 @@ static int ingenic_uart_probe(struct platform_device =
*pdev)
>  =09}
>  =09uart.port.uartclk =3D clk_get_rate(data->clk_baud);
> =20
> -=09data->line =3D serial8250_register_8250_port(&uart);
> -=09if (data->line < 0) {
> -=09=09err =3D data->line;
> +=09data->uport =3D serial8250_register_8250_port(&uart);
> +=09if (IS_ERR(data->uport)) {
> +=09=09err =3D PTR_ERR(data->uport);
>  =09=09goto out_disable_baudclk;
>  =09}
> =20
> @@ -318,7 +318,7 @@ static void ingenic_uart_remove(struct platform_devic=
e *pdev)
>  {
>  =09struct ingenic_uart_data *data =3D platform_get_drvdata(pdev);
> =20
> -=09serial8250_unregister_port(data->line);
> +=09serial8250_unregister_port(data->uport);
>  =09clk_disable_unprepare(data->clk_module);
>  =09clk_disable_unprepare(data->clk_baud);
>  }
> diff --git a/drivers/tty/serial/8250/8250_ioc3.c b/drivers/tty/serial/825=
0/8250_ioc3.c
> index 28e28076782b..0ddc5e24567b 100644
> --- a/drivers/tty/serial/8250/8250_ioc3.c
> +++ b/drivers/tty/serial/8250/8250_ioc3.c
> @@ -17,10 +17,6 @@
> =20
>  #define IOC3_UARTCLK (22000000 / 3)
> =20
> -struct ioc3_8250_data {
> -=09int line;
> -};
> -
>  static u32 ioc3_serial_in(struct uart_port *p, unsigned int offset)
>  {
>  =09return readb(p->membase + (offset ^ 3));
> @@ -33,20 +29,15 @@ static void ioc3_serial_out(struct uart_port *p, unsi=
gned int offset, u32 value)
> =20
>  static int serial8250_ioc3_probe(struct platform_device *pdev)
>  {
> -=09struct ioc3_8250_data *data;
> -=09struct uart_8250_port up;
> +=09struct uart_8250_port *uport, up;
>  =09struct resource *r;
>  =09void __iomem *membase;
> -=09int irq, line;
> +=09int irq;
> =20
>  =09r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  =09if (!r)
>  =09=09return -ENODEV;
> =20
> -=09data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> -=09if (!data)
> -=09=09return -ENOMEM;
> -
>  =09membase =3D devm_ioremap(&pdev->dev, r->start, resource_size(r));
>  =09if (!membase)
>  =09=09return -ENOMEM;
> @@ -67,19 +58,19 @@ static int serial8250_ioc3_probe(struct platform_devi=
ce *pdev)
>  =09up.port.mapbase =3D r->start;
>  =09up.port.serial_in =3D ioc3_serial_in;
>  =09up.port.serial_out =3D ioc3_serial_out;
> -=09line =3D serial8250_register_8250_port(&up);
> -=09if (line < 0)
> -=09=09return line;
> +=09uport =3D serial8250_register_8250_port(&up);
> +=09if (IS_ERR(uport))
> +=09=09return PTR_ERR(uport);
> =20
> -=09platform_set_drvdata(pdev, data);
> +=09platform_set_drvdata(pdev, uport);
>  =09return 0;
>  }
> =20
>  static void serial8250_ioc3_remove(struct platform_device *pdev)
>  {
> -=09struct ioc3_8250_data *data =3D platform_get_drvdata(pdev);
> +=09struct uart_8250_port *uport =3D platform_get_drvdata(pdev);
> =20
> -=09serial8250_unregister_port(data->line);
> +=09serial8250_unregister_port(uport);
>  }
> =20
>  static struct platform_driver serial8250_ioc3_driver =3D {
> diff --git a/drivers/tty/serial/8250/8250_keba.c b/drivers/tty/serial/825=
0/8250_keba.c
> index 5b791b6eefd0..c53ca05a57d7 100644
> --- a/drivers/tty/serial/8250/8250_keba.c
> +++ b/drivers/tty/serial/8250/8250_keba.c
> @@ -62,7 +62,7 @@ enum kuart_mode {
>  struct kuart {
>  =09struct keba_uart_auxdev *auxdev;
>  =09void __iomem *base;
> -=09unsigned int line;
> +=09struct uart_8250_port *uport;
> =20
>  =09unsigned int flags;
>  =09u8 capability;
> @@ -174,7 +174,6 @@ static int kuart_probe(struct auxiliary_device *auxde=
v,
>  =09struct uart_8250_port uart =3D {};
>  =09struct resource res;
>  =09struct kuart *kuart;
> -=09int retval;
> =20
>  =09kuart =3D devm_kzalloc(dev, sizeof(*kuart), GFP_KERNEL);
>  =09if (!kuart)
> @@ -250,12 +249,10 @@ static int kuart_probe(struct auxiliary_device *aux=
dev,
>  =09=09}
>  =09}
> =20
> -=09retval =3D serial8250_register_8250_port(&uart);
> -=09if (retval < 0)
> -=09=09return dev_err_probe(&auxdev->dev, retval,
> +=09kuart->uport =3D serial8250_register_8250_port(&uart);
> +=09if (IS_ERR(kuart->uport))
> +=09=09return dev_err_probe(&auxdev->dev, PTR_ERR(kuart->uport),
>  =09=09=09=09     "UART registration failed!\n");
> -=09kuart->line =3D retval;
> -
>  =09return 0;
>  }
> =20
> @@ -266,7 +263,7 @@ static void kuart_remove(struct auxiliary_device *aux=
dev)
>  =09if (kuart->flags & KUART_USE_CAPABILITY)
>  =09=09kuart_set_phy_mode(kuart, KUART_MODE_NONE);
> =20
> -=09serial8250_unregister_port(kuart->line);
> +=09serial8250_unregister_port(kuart->uport);
>  }
> =20
>  static const struct auxiliary_device_id kuart_devtype_aux[] =3D {
> diff --git a/drivers/tty/serial/8250/8250_loongson.c b/drivers/tty/serial=
/8250/8250_loongson.c
> index 19acb2c6b611..f65e0813d84a 100644
> --- a/drivers/tty/serial/8250/8250_loongson.c
> +++ b/drivers/tty/serial/8250/8250_loongson.c
> @@ -43,7 +43,7 @@ static const struct loongson_uart_ddata ls2k1500_uart_d=
ata =3D {
>  };
> =20
>  struct loongson_uart_priv {
> -=09int line;
> +=09struct uart_8250_port *uport;
>  =09struct clk *clk;
>  =09struct resource *res;
>  =09struct reset_control *rst;
> @@ -160,13 +160,12 @@ static int loongson_uart_probe(struct platform_devi=
ce *pdev)
>  =09if (ret)
>  =09=09return ret;
> =20
> -=09ret =3D serial8250_register_8250_port(&uart);
> -=09if (ret < 0) {
> +=09priv->uport =3D serial8250_register_8250_port(&uart);
> +=09if (IS_ERR(priv->uport)) {
>  =09=09reset_control_assert(priv->rst);
> -=09=09return ret;
> +=09=09return PTR_ERR(priv->uport);
>  =09}
> =20
> -=09priv->line =3D ret;
>  =09platform_set_drvdata(pdev, priv);
> =20
>  =09return 0;
> @@ -176,16 +175,16 @@ static void loongson_uart_remove(struct platform_de=
vice *pdev)
>  {
>  =09struct loongson_uart_priv *priv =3D platform_get_drvdata(pdev);
> =20
> -=09serial8250_unregister_port(priv->line);
> +=09serial8250_unregister_port(priv->uport);
>  =09reset_control_assert(priv->rst);
>  }
> =20
>  static int loongson_uart_suspend(struct device *dev)
>  {
>  =09struct loongson_uart_priv *priv =3D dev_get_drvdata(dev);
> -=09struct uart_8250_port *up =3D serial8250_get_port(priv->line);
> +=09struct uart_8250_port *up =3D priv->uport;
> =20
> -=09serial8250_suspend_port(priv->line);
> +=09serial8250_suspend_port(up);
> =20
>  =09if (!uart_console(&up->port) || console_suspend_enabled)
>  =09=09clk_disable_unprepare(priv->clk);
> @@ -196,7 +195,7 @@ static int loongson_uart_suspend(struct device *dev)
>  static int loongson_uart_resume(struct device *dev)
>  {
>  =09struct loongson_uart_priv *priv =3D dev_get_drvdata(dev);
> -=09struct uart_8250_port *up =3D serial8250_get_port(priv->line);
> +=09struct uart_8250_port *up =3D priv->uport;
>  =09int ret;
> =20
>  =09if (!uart_console(&up->port) || console_suspend_enabled) {
> @@ -205,7 +204,7 @@ static int loongson_uart_resume(struct device *dev)
>  =09=09=09return ret;
>  =09}
> =20
> -=09serial8250_resume_port(priv->line);
> +=09serial8250_resume_port(up);
> =20
>  =09return 0;
>  }
> diff --git a/drivers/tty/serial/8250/8250_lpc18xx.c b/drivers/tty/serial/=
8250/8250_lpc18xx.c
> index 6c0489c9c253..9002951db02b 100644
> --- a/drivers/tty/serial/8250/8250_lpc18xx.c
> +++ b/drivers/tty/serial/8250/8250_lpc18xx.c
> @@ -29,7 +29,7 @@ struct lpc18xx_uart_data {
>  =09struct uart_8250_dma dma;
>  =09struct clk *clk_uart;
>  =09struct clk *clk_reg;
> -=09int line;
> +=09struct uart_8250_port *uport;
>  };
> =20
>  static int lpc18xx_rs485_config(struct uart_port *port, struct ktermios =
*termios,
> @@ -160,13 +160,13 @@ static int lpc18xx_serial_probe(struct platform_dev=
ice *pdev)
>  =09uart.dma->rxconf.src_maxburst =3D 1;
>  =09uart.dma->txconf.dst_maxburst =3D 1;
> =20
> -=09ret =3D serial8250_register_8250_port(&uart);
> -=09if (ret < 0) {
> +=09data->uport =3D serial8250_register_8250_port(&uart);
> +=09if (IS_ERR(data->uport)) {
> +=09=09ret =3D PTR_ERR(data->uport);
>  =09=09dev_err(&pdev->dev, "unable to register 8250 port\n");
>  =09=09goto dis_uart_clk;
>  =09}
> =20
> -=09data->line =3D ret;
>  =09platform_set_drvdata(pdev, data);
> =20
>  =09return 0;
> @@ -182,7 +182,7 @@ static void lpc18xx_serial_remove(struct platform_dev=
ice *pdev)
>  {
>  =09struct lpc18xx_uart_data *data =3D platform_get_drvdata(pdev);
> =20
> -=09serial8250_unregister_port(data->line);
> +=09serial8250_unregister_port(data->uport);
>  =09clk_disable_unprepare(data->clk_uart);
>  =09clk_disable_unprepare(data->clk_reg);
>  }
> diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/825=
0/8250_lpss.c
> index c5257847a94c..115b97556360 100644
> --- a/drivers/tty/serial/8250/8250_lpss.c
> +++ b/drivers/tty/serial/8250/8250_lpss.c
> @@ -183,12 +183,8 @@ static int ehl_serial_setup(struct lpss8250 *lpss, s=
truct uart_port *port)
> =20
>  static void ehl_serial_exit(struct lpss8250 *lpss)
>  {
> -=09if (lpss->data.line < 0)
> -=09=09return;
> -
> -=09struct uart_8250_port *up =3D serial8250_get_port(lpss->data.line);
> -
> -=09up->dma =3D NULL;
> +=09if (lpss->data.uport)
> +=09=09lpss->data.uport->dma =3D NULL;
>  }
> =20
>  #ifdef CONFIG_SERIAL_8250_DMA
> @@ -332,8 +328,6 @@ static int lpss8250_probe(struct pci_dev *pdev, const=
 struct pci_device_id *id)
>  =09=09return ret;
> =20
>  =09lpss->board =3D (struct lpss8250_board *)id->driver_data;
> -=09/* for tests in lpss->board->exit() */
> -=09lpss->data.line =3D -1;
> =20
>  =09memset(&uart, 0, sizeof(struct uart_8250_port));
> =20
> @@ -361,11 +355,12 @@ static int lpss8250_probe(struct pci_dev *pdev, con=
st struct pci_device_id *id)
>  =09if (ret)
>  =09=09goto err_exit;
> =20
> -=09ret =3D serial8250_register_8250_port(&uart);
> -=09if (ret < 0)
> +=09struct uart_8250_port *uport =3D serial8250_register_8250_port(&uart)=
;
> +=09if (IS_ERR(uport)) {
> +=09=09ret =3D PTR_ERR(uport);

Add err.h

Some other cases had the include added so you might want to check all the=
=20
files you're adding IS_ERR/PTR_ERR() to if they already have err.h or not.

--
 i.
--8323328-736474618-1791545136=:8329--
