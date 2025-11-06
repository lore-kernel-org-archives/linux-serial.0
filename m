Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35192AD25;
	Thu,  6 Nov 2025 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762452045; cv=none; b=haUgKRVB8Wy+OtcXzuj8IGTu4D8zAz+WYzZdpsiPB4KwV3VN+5hswOMlCJCpKOtfHCbRdNpW0eKYYZGTMo6VQbENjxAiCgMU2sQhajv8WeX32Mw7ZxdR+bPQIRyaaj2D1hyX6pHdfPZC8eq56/7xt+RZ6yevwy5nCfTZZMAgsmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762452045; c=relaxed/simple;
	bh=ADhGBiYj8YWwqtFnyim68Cwy/3DupMspluG/EMWSVVg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MFhBRYZFj2eJW+QMlHZFsl2fETxlWXdbH8gREIFcNzkDNDK6II1b+ytt5ZUi6VwXjLVlyWnBAN8ceDaZzAz/ag6/3GvTfjo1q9lbQZ7uOo2jR8T4eKubzy5Z9kVd2IdwVE14Af151pYAmh3L6b68h9EeLnfF4enIvU3ck6TLwmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GiZwAM+n; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GiZwAM+n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762452043; x=1793988043;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ADhGBiYj8YWwqtFnyim68Cwy/3DupMspluG/EMWSVVg=;
  b=GiZwAM+nkAShOK02aw4SHLyuj491aGAqCm/nuW2t3JIHW+9SJRudxeXd
   77QO6ULbSumkYGoKOnqljJ3Epu4OOFN8vUnDYfdoQHlQRJBVeKdaSkQVn
   M6Ja0ek40qeT+AHAEtAyHV4WL5zoVYODiG6Buzo9rE0V9PEIRhl5TVQO5
   D/IIu9EVSGiUmr7TNYibl1jgK7RBrM5Zm78SgaWtH+MWsdFT3hPKc8tg9
   3h2MFkz40nPQpTerub789RqTzI412vp1BsaydGmnyIgsNWItV9M5Y5Uj0
   CB1QDJ1joPDkREbgL05u2WImR+ALMYVNObUAiVOe6sEcq5BTFbh6PFfVw
   w==;
X-CSE-ConnectionGUID: FtJQbuJeTTO2Wi6RNq6rwA==
X-CSE-MsgGUID: /3NRJTbnTtWnoGqg5ImmDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="82003906"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="82003906"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 10:00:42 -0800
X-CSE-ConnectionGUID: 89jO18aoRy2UQeicNgl4wg==
X-CSE-MsgGUID: drnuHqlARqCNz3yjhbU26g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="187767555"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.187])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 10:00:39 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 6 Nov 2025 20:00:36 +0200 (EET)
To: Alex Davis <alex47794@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>
cc: Borislav Petkov <bp@alien8.de>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, John Ogness <john.ogness@linutronix.de>, 
    linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [Regression] depmod fails on kernel 6.17.1 rc1
In-Reply-To: <3fe70726-80d6-a84a-4101-446fd8b49209@linux.intel.com>
Message-ID: <ddfbc4bf-658f-3eda-5b4f-f111ecd932f5@linux.intel.com>
References: <CADiockCvM6v+d+UoFZpJSMoLAdpy99_h-hJdzUsdfaWGn3W7-g@mail.gmail.com> <20251106160235.GBaQzGm8W2Gt_VMy-s@fat_crate.local> <aQzJveMYT6O3EHeK@smile.fi.intel.com> <20251106162436.GFaQzLxBW-_50ndwtr@fat_crate.local>
 <3fe70726-80d6-a84a-4101-446fd8b49209@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1187919288-1762452036=:981"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1187919288-1762452036=:981
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 6 Nov 2025, Ilpo J=E4rvinen wrote:

> On Thu, 6 Nov 2025, Borislav Petkov wrote:
>=20
> > On Thu, Nov 06, 2025 at 06:15:57PM +0200, Andy Shevchenko wrote:
> > > > So I'm seeing this with an allmodconfig build too:
> > =09=09=09       ^^^^^^^^^^^^
> > > > depmod: ERROR: Cycle detected: 8250 -> 8250_base -> 8250
> > > > depmod: ERROR: Found 2 modules in dependency cycles!
> > >=20
> > > I'm surprised it took so long to people to start complaining.
> > >=20
> > > So, some of those are modules? Can you share the
> > >=20
> > > =09grep 8250 .config
> > >=20
> > > part?
> >=20
> > See above.
>=20
> https://lore.kernel.org/all/87frc3sd8d.fsf@posteo.net/
>=20
> I wonder if 8250_rsa.o can be put into 8250_base.o where most of its=20
> callers are anyway?

This seems to resolve the build issue for me:

--
From: =3D?UTF-8?q?Ilpo=3D20J=3DC3=3DA4rvinen?=3D <ilpo.jarvinen@linux.intel=
=2Ecom>
Subject: [PATCH 1/1] serial: 8250: Fix 8250_rsa symbol loop

make allmodconfig build fails due to dependency loop:

  depmod: ERROR: Cycle detected: 8250 -> 8250_base -> 8250
  depmod: ERROR: Found 2 modules in dependency cycles!

Break dependency loop by moving 8250_rsa.o into 8250_base and by
passing univ8250_port_base_ops to univ8250_rsa_support() that can make
a local copy of it.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: Alex Davis <alex47794@gmail.com>
Fixes: b20d6576cdb3 ("serial: 8250: export RSA functions")
Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250.h          |  2 +-
 drivers/tty/serial/8250/8250_platform.c |  2 +-
 drivers/tty/serial/8250/8250_rsa.c      | 18 +++++++++---------
 drivers/tty/serial/8250/Makefile        |  2 +-
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.=
h
index 58e64c4e1e3a..bd294fbf0e65 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -322,7 +322,7 @@ static inline void serial8250_pnp_exit(void) { }
 #endif
=20
 #ifdef CONFIG_SERIAL_8250_RSA
-void univ8250_rsa_support(struct uart_ops *ops);
+void univ8250_rsa_support(struct uart_ops *ops, const struct uart_ops *cor=
e_ops);
 void rsa_enable(struct uart_8250_port *up);
 void rsa_disable(struct uart_8250_port *up);
 void rsa_autoconfig(struct uart_8250_port *up);
diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8=
250/8250_platform.c
index b27981340e76..fe7ec440ffa5 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -75,7 +75,7 @@ static void __init __serial8250_isa_init_ports(void)
=20
 =09/* chain base port ops to support Remote Supervisor Adapter */
 =09univ8250_port_ops =3D *univ8250_port_base_ops;
-=09univ8250_rsa_support(&univ8250_port_ops);
+=09univ8250_rsa_support(&univ8250_port_ops, univ8250_port_base_ops);
=20
 =09if (share_irqs)
 =09=09irqflag =3D IRQF_SHARED;
diff --git a/drivers/tty/serial/8250/8250_rsa.c b/drivers/tty/serial/8250/8=
250_rsa.c
index 40a3dbd9e452..d76d1be86625 100644
--- a/drivers/tty/serial/8250/8250_rsa.c
+++ b/drivers/tty/serial/8250/8250_rsa.c
@@ -14,6 +14,8 @@
 static unsigned long probe_rsa[PORT_RSA_MAX];
 static unsigned int probe_rsa_count;
=20
+static const struct uart_ops *core_port_base_ops;
+
 static int rsa8250_request_resource(struct uart_8250_port *up)
 {
 =09struct uart_port *port =3D &up->port;
@@ -67,7 +69,7 @@ static void univ8250_config_port(struct uart_port *port, =
int flags)
 =09=09}
 =09}
=20
-=09univ8250_port_base_ops->config_port(port, flags);
+=09core_port_base_ops->config_port(port, flags);
=20
 =09if (port->type !=3D PORT_RSA && up->probe & UART_PROBE_RSA)
 =09=09rsa8250_release_resource(up);
@@ -78,11 +80,11 @@ static int univ8250_request_port(struct uart_port *port=
)
 =09struct uart_8250_port *up =3D up_to_u8250p(port);
 =09int ret;
=20
-=09ret =3D univ8250_port_base_ops->request_port(port);
+=09ret =3D core_port_base_ops->request_port(port);
 =09if (ret =3D=3D 0 && port->type =3D=3D PORT_RSA) {
 =09=09ret =3D rsa8250_request_resource(up);
 =09=09if (ret < 0)
-=09=09=09univ8250_port_base_ops->release_port(port);
+=09=09=09core_port_base_ops->release_port(port);
 =09}
=20
 =09return ret;
@@ -94,15 +96,17 @@ static void univ8250_release_port(struct uart_port *por=
t)
=20
 =09if (port->type =3D=3D PORT_RSA)
 =09=09rsa8250_release_resource(up);
-=09univ8250_port_base_ops->release_port(port);
+=09core_port_base_ops->release_port(port);
 }
=20
-void univ8250_rsa_support(struct uart_ops *ops)
+void univ8250_rsa_support(struct uart_ops *ops, const struct uart_ops *cor=
e_ops)
 {
+=09core_port_base_ops =3D core_ops;
 =09ops->config_port  =3D univ8250_config_port;
 =09ops->request_port =3D univ8250_request_port;
 =09ops->release_port =3D univ8250_release_port;
 }
+EXPORT_SYMBOL_FOR_MODULES(univ8250_rsa_support, "8250");
=20
 module_param_hw_array(probe_rsa, ulong, ioport, &probe_rsa_count, 0444);
 MODULE_PARM_DESC(probe_rsa, "Probe I/O ports for RSA");
@@ -146,7 +150,6 @@ void rsa_enable(struct uart_8250_port *up)
 =09if (up->port.uartclk =3D=3D SERIAL_RSA_BAUD_BASE * 16)
 =09=09serial_out(up, UART_RSA_FRR, 0);
 }
-EXPORT_SYMBOL_FOR_MODULES(rsa_enable, "8250_base");
=20
 /*
  * Attempts to turn off the RSA FIFO and resets the RSA board back to 115k=
bps compat mode. It is
@@ -178,7 +181,6 @@ void rsa_disable(struct uart_8250_port *up)
 =09if (result)
 =09=09up->port.uartclk =3D SERIAL_RSA_BAUD_BASE_LO * 16;
 }
-EXPORT_SYMBOL_FOR_MODULES(rsa_disable, "8250_base");
=20
 void rsa_autoconfig(struct uart_8250_port *up)
 {
@@ -191,7 +193,6 @@ void rsa_autoconfig(struct uart_8250_port *up)
 =09if (__rsa_enable(up))
 =09=09up->port.type =3D PORT_RSA;
 }
-EXPORT_SYMBOL_FOR_MODULES(rsa_autoconfig, "8250_base");
=20
 void rsa_reset(struct uart_8250_port *up)
 {
@@ -200,7 +201,6 @@ void rsa_reset(struct uart_8250_port *up)
=20
 =09serial_out(up, UART_RSA_FRR, 0);
 }
-EXPORT_SYMBOL_FOR_MODULES(rsa_reset, "8250_base");
=20
 #ifdef CONFIG_SERIAL_8250_DEPRECATED_OPTIONS
 #ifndef MODULE
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Mak=
efile
index 513a0941c284..9ec4d5fe64de 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -7,7 +7,6 @@ obj-$(CONFIG_SERIAL_8250)=09=09+=3D 8250.o
 8250-y=09=09=09=09=09:=3D 8250_core.o
 8250-y=09=09=09=09=09+=3D 8250_platform.o
 8250-$(CONFIG_SERIAL_8250_PNP)=09=09+=3D 8250_pnp.o
-8250-$(CONFIG_SERIAL_8250_RSA)=09=09+=3D 8250_rsa.o
=20
 obj-$(CONFIG_SERIAL_8250)=09=09+=3D 8250_base.o
 8250_base-y=09=09=09=09:=3D 8250_port.o
@@ -15,6 +14,7 @@ obj-$(CONFIG_SERIAL_8250)=09=09+=3D 8250_base.o
 8250_base-$(CONFIG_SERIAL_8250_DWLIB)=09+=3D 8250_dwlib.o
 8250_base-$(CONFIG_SERIAL_8250_FINTEK)=09+=3D 8250_fintek.o
 8250_base-$(CONFIG_SERIAL_8250_PCILIB)=09+=3D 8250_pcilib.o
+8250_base-$(CONFIG_SERIAL_8250_RSA)=09+=3D 8250_rsa.o
=20
 obj-$(CONFIG_SERIAL_8250_CONSOLE)=09+=3D 8250_early.o
=20

base-commit: 719f3df3e113e03d2c8cf324827da1fd17a9bd8f
--=20
2.39.5

--8323328-1187919288-1762452036=:981--
