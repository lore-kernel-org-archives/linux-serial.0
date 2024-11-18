Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2133719C54B;
	Mon, 18 Nov 2024 14:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731939298; cv=none; b=gkvWpxu4RKf7SDXIdg1/il4nzY/K64u2FlqmImE1CPx30CqJaWYH3JFSNM94a/0+oCnkj1Up9ThNGigNR5f2RxpXzsKKS0AxwP8ovqPrXAdmDI1ve7GemQ0oZSHtNXiWqFPVSt492A1d760E+RqNqOsnt9u12IB38XYIzdOtVEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731939298; c=relaxed/simple;
	bh=GpI8lRABSdwbFRSzHGnkl6CDaoqumg8eqpp6Bxfw5fg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Qq5nJs6zpg1Ppd0m3fCBz0G8jSW/hdznNnmeG6Qy8W58EN1bWOsvbaNEwOIYRrt6GXSp7Frbsx4w+lcCwocQX9aEGxZVmjNgK4BkPtRBeX3MqiZFTYkC46bc4Dm8rdfHU5HB+N7aVvURCtpdzZMh3WWAuM1AaSN85nWsGOP4szI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DbvXGSlZ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DbvXGSlZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731939296; x=1763475296;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GpI8lRABSdwbFRSzHGnkl6CDaoqumg8eqpp6Bxfw5fg=;
  b=DbvXGSlZDQYjtW7DaYC2fzo4yoa7zEALG8ga3jUmFwf0JhnRZi2B5GIT
   S9SfqsPOQp7g1q3FL+SBzVtSwAo/TNLef8OoWuRGwAjYL+ECBjGD8WDFp
   AeNTizjjPb/VFNwXjgg+Gt5dRASu54ARgIThuTw0KqNILm/+r3LWUmvRu
   B1VyX5stbGyaMU3w6HdT4ecWOW0hs9nTRPwz3vmYsaTk8V9eXdOxswn98
   Y5jGuim+AIX1MtMy2dNn47h4xtxxG8tJzC4L4bLmWfovL4Vht5KOBdYww
   fG2LNGj6ho1nYL2hC3o9d8x9R9vOaF1GJcKVez9jImJH8IhlUQH3kq6zt
   Q==;
X-CSE-ConnectionGUID: MbrCVx2dRxezyTwhxKJyeg==
X-CSE-MsgGUID: 2lVmVBp+RamXnB9PH39MeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="42536356"
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="42536356"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 06:14:26 -0800
X-CSE-ConnectionGUID: QAK2gS4ASq++OiWGQ1jlbQ==
X-CSE-MsgGUID: iVZFi8/dTVKAAN86aZsUMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="89261282"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.193])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 06:14:24 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 18 Nov 2024 16:14:20 +0200 (EET)
To: Borislav Petkov <bp@alien8.de>
cc: linux-serial <linux-serial@vger.kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: serial 00:06: Runtime PM usage count underflow!
In-Reply-To: <20241116170727.GCZzjRT5WGcOMKFDYq@fat_crate.local>
Message-ID: <ca76fb23-013d-9745-188b-b519096aa784@linux.intel.com>
References: <20241116170727.GCZzjRT5WGcOMKFDYq@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1024098145-1731939260=:933"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1024098145-1731939260=:933
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 16 Nov 2024, Borislav Petkov wrote:

> Hi folks,
>=20
> got a box here which says:
>=20
> [    4.654361] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    4.660820] 00:06: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200=
) is a 16550A
> [    4.668313] printk: legacy console [ttyS0] disabled
> [    4.676903] serial 00:06: Runtime PM usage count underflow!
> [    4.677175] serial 00:06: disabled
> [    4.677264] serial 00:06: unable to assign resources
> [    4.677356] serial 00:06: probe with driver serial failed with error -=
16
> [    4.677923] printk: legacy console [ttyS0] disabled
>=20
> Any suggestions?
>=20
> I'd like to use the serial cable to catch dmesg but somehow the driver do=
esn't
> like the chip...

I think "Runtime PM usage count underflow!" is not related to the probe=20
problem you're seeing. Nonetheless, this patch might solve the underflow:

--
[PATCH 1/1] tty: serial: 8250: Fix another runtime PM usage counter underfl=
ow

The commit f9b11229b79c ("serial: 8250: Fix PM usage_count for console
handover") fixed one runtime PM usage counter balance problem that
occurs because .dev is not set during univ8250 setup preventing call to
pm_runtime_get_sync(). Later, univ8250_console_exit() will trigger the
runtime PM usage counter underflow as .dev is already set at that time.

Call pm_runtime_get_sync() to balance the RPM usage counter also in
serial8250_register_8250_port() before trying to add the port.

Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/=
8250_core.c
index 5f9f06911795..68baf75bdadc 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -812,6 +812,9 @@ int serial8250_register_8250_port(const struct uart_825=
0_port *up)
 =09=09=09uart->dl_write =3D up->dl_write;
=20
 =09=09if (uart->port.type !=3D PORT_8250_CIR) {
+=09=09=09if (uart_console_registered(&uart->port))
+=09=09=09=09pm_runtime_get_sync(uart->port.dev);
+
 =09=09=09if (serial8250_isa_config !=3D NULL)
 =09=09=09=09serial8250_isa_config(0, &uart->port,
 =09=09=09=09=09=09&uart->capabilities);
--=20
2.39.5

--8323328-1024098145-1731939260=:933--
