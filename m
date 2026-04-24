Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE143914EE;
	Fri, 24 Apr 2026 11:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777029904; cv=none; b=kZ2tONJdSlQDEeh4dTpGhi1y42G8oW7V7D1dBPzRex2SCoHYfcGrtY0TRcPjFGxlITtCarlBd40GuF45ae9Js7B9dxK5BvJg1p+qGWJEbGMTaoiQyU75Ugkvjdg8cJTMmfK9HpZf1KwBwGQQ2JSlFH4IHHY8u39fs0tu/vWeGis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777029904; c=relaxed/simple;
	bh=EvVCgq2o+wtnzfrT7T2sZ9ngKIcZzp+62/TtTInqJRE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YQO9V/vSMCrZtNH4Q7hE4ZkvZcvXkaRQxFymXSqaqkikueQkHKyx3t93eovImi8c8yRrxiKPWoBuIe6EStSau1gg3MxEKHavEcIFa3WiSnQ7NR1hmzpBrdlpeHgoPQ76rWoTrhXpFqCiCO2T2othJmzp55pB0gq6gb+V4Dsqyvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fgosXvzh; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fgosXvzh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777029903; x=1808565903;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=EvVCgq2o+wtnzfrT7T2sZ9ngKIcZzp+62/TtTInqJRE=;
  b=fgosXvzh6Ldw4MEBOXpuv6buw9WFOi/iLO+XqvpP/qrdWLTyytRfI5re
   BsXvsPWF6oUevZ7lqsmr5HJ9UxEspiwjakOlyH2ADAFUO8HFXTX0VKzqp
   WLrQX0I+ggQ4tYklfTQPYq2Mbz4QG/T3xZ1dz9HHxIZ7uzJm1lNWaQlak
   XsFTZax/GFbmVDr0wqU/q5jP7TT6hqlQ3R2u2YmCIfp2QlEbPynlJGhI5
   W2Ci8TQHRdRyz8oYkKO5L56HPd/umnL6Yhhd9KjJhmDqooCp3pnXWpExM
   zqhqwkP45NiZxZvJqtbbfB72bKqwJS1OxD05YHv4KeJ8ZV/WxP1qElP6O
   w==;
X-CSE-ConnectionGUID: F5cqkgwhQ0WKj4au+EGlmQ==
X-CSE-MsgGUID: GQ25U8PdT6iwCgG4lOb08Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="81870016"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="81870016"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 04:25:02 -0700
X-CSE-ConnectionGUID: M43y2bLkR2WrvapCQQDW9A==
X-CSE-MsgGUID: vkJnjbhCTzikSXv9rh1fjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="232837947"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.120])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 04:24:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 24 Apr 2026 14:24:57 +0300 (EEST)
To: Hugo Villeneuve <hugo@hugovil.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 0/9] serial: add new I/O type for SPI and I2C bus
 devices
In-Reply-To: <20260423-tty-upio-v1-0-baf82d3b86d1@dimonoff.com>
Message-ID: <43a17428-e5a4-41ad-a904-cd9ec6ad2962@linux.intel.com>
References: <20260423-tty-upio-v1-0-baf82d3b86d1@dimonoff.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1498380334-1777029897=:958"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1498380334-1777029897=:958
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 23 Apr 2026, Hugo Villeneuve wrote:

> Hello,
> this patch series add a new I/O type for serial devices on a SPI/I2C bus.
>=20
> These changes are based on a suggestion [1] made by Ilpo J=C3=A4rvinen du=
ring
> past sc16is7xx driver patches review.

Hehe, I didn't even recall suggesting this (nor why) :-).

I like this series. Some, relatively minor, comments on the individual=20
patches. Thanks for looking into solving this properly.

--=20
 i.

> I decided to use UPIO_BUS/SERIAL_IO_BUS names but maybe other names would
> be more appropriate:
>    UPIO_SBUS   / SERIAL_IO_SBUS
>    UPIO_SERBUS / SERIAL_IO_SERBUS
>    UPIO_EXT    / SERIAL_IO_EXT
>    UPIO_CUSTOM / SERIAL_IO_CUSTOM
>    UPIO_REGMAP / SERIAL_IO_REGMAP  /* Maybe not always true in future? */
>    ...
>=20
> Tested on a imx6 board with two SC16is752 using SPI mode, and a dummy
> device-tree entry for a MAX3100:
>   dmesg -t | grep "base_baud"
>     2020000.serial: ttymxc0 at MMIO 0x2020000 (irq =3D 197, base_baud =3D=
 5000000) is a IMX
>     21e8000.serial: ttymxc1 at MMIO 0x21e8000 (irq =3D 198, base_baud =3D=
 5000000) is a IMX
>     spi1.0: ttySC0 (irq =3D 165, base_baud =3D 1500000) is a SC16IS752
>     spi1.0: ttySC1 (irq =3D 165, base_baud =3D 1500000) is a SC16IS752
>     spi3.0: ttySC2 (irq =3D 37, base_baud =3D 1500000) is a SC16IS752
>     spi3.0: ttySC3 (irq =3D 37, base_baud =3D 1500000) is a SC16IS752
>     spi3.1: ttyMAX0 (irq =3D 0, base_baud =3D 0) is a MAX3100
> Note that before these patches, max3100 silently failed in uart_configure=
_port()
> because membase/iobase/mapbase were zero.
>
> For max310x and SC16is7xx in i2c mode, tested only that driver is properl=
y
> registered by using i2c-stub.
>=20
> Also tested on a custom board with a Renesas RZ/G2L cpu (sh-sci driver) t=
o
> confirm there is no regression:
>   dmesg -t | grep "base_baud"
>     1004b800.serial: ttySC0 at MMIO 0x1004b800 (irq =3D 35, base_baud =3D=
 0) is a scif
>     1004bc00.serial: ttySC1 at MMIO 0x1004bc00 (irq =3D 40, base_baud =3D=
 0) is a scif
>=20
> Maybe some of the patches could be merged together, but for now I decided
> to keep them separate to help the review process.
>=20
> Thank you.
>=20
> [1] https://lore.kernel.org/lkml/2936e18f-44ea-faed-9fa0-2ddefe7c3194@lin=
ux.intel.com/raw
>=20
> ---
> Hugo Villeneuve (9):
>       serial: core: add uart_iotype_mmio/legacy_io helper functions
>       serial: core: use uart_iotype_*() to simplify code
>       serial: 8250: use uart_iotype_*() to simplify code
>       serial: core: fix indentation/alignment
>       serial: core: add new I/O type for SPI and I2C bus devices
>       serial: core: prevent irrelevant I/O infos display for UPIO_BUS
>       serial: sc16is7xx: use new UPIO_BUS as iotype
>       serial: max310x: use new UPIO_BUS as iotype
>       serial: max3100: use new UPIO_BUS as iotype
>=20
>  drivers/tty/serial/8250/8250_port.c |  33 ++--------
>  drivers/tty/serial/max3100.c        |   1 +
>  drivers/tty/serial/max310x.c        |   9 +--
>  drivers/tty/serial/sc16is7xx.c      |   9 +--
>  drivers/tty/serial/serial_core.c    | 121 ++++++++++++++++++++----------=
------
>  include/linux/serial_core.h         |   5 ++
>  include/uapi/linux/serial.h         |   1 +
>  7 files changed, 83 insertions(+), 96 deletions(-)
> ---
> base-commit: 2e68039281932e6dc37718a1ea7cbb8e2cda42e6
> change-id: 20260423-tty-upio-c8b66a0a593e
>=20
> Best regards,
>=20
--8323328-1498380334-1777029897=:958--
