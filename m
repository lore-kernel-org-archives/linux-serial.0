Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595722EBB99;
	Wed, 29 Apr 2026 10:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777459145; cv=none; b=nPXCE3MBFtuNH9PX00dgKsgHoK4qDXxhfEGrfLyE/f/LUCY7pUWHhZ8LDkykGLD52lz4TJu8/Ttc/fywfx0JAgA2aX3IWvFmAw4QQsbYebY9E5o++27wwKfBkgyHFj38Uly9NZG6NiaU7CBvd+RwbHiU/3LN3S8xEzIvvg5xMxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777459145; c=relaxed/simple;
	bh=wS2y88poNh8+M4OaCoMUd1vy4JEzXBX0q9rVHEytoM0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Wh7cK0OciYnytvRbavBFSQrhsafXEBINY84wHrstOR1ZesEPO9ehZpdIJs7KG/+3WCJ2mNqsQhZsxdB5i8nKYZE4h2Rwb11fjGIHjsVZ7BmMCvESYHn+2YYCrS03Sb3IBPC3wTt94ZoRYs4yru+1jX7scKbFDTgS+pzUhxHxG6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=naSzJRMe; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="naSzJRMe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777459144; x=1808995144;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wS2y88poNh8+M4OaCoMUd1vy4JEzXBX0q9rVHEytoM0=;
  b=naSzJRMeHeBwvmT/Hje4yQs/VH29j95NQ/ZkH6+5KrFvMBFayK90gP//
   8ZwZcVJmXbeyG1aaSU3Di2cwdZvVz81K/9NmUcS+BtDZHkMHlVRYtP5me
   b/Z9wqAhVjTMLMcEArMXkZMT8pzR7ouJLzY847NwXFC3vdsEo5klg1beU
   Lw75cTCFxlWi25dqsrddPb95f39lkoTx5v2Eahb1pIYghiuUqn+X2Zdx0
   trtDDCpIXDZcM59IDMyzH3pqI84ybKtu5JbrYg3QfiI1a/fROun6gVVlA
   G+Ootj/m2bf6l68yaIeZuyxoWqbat4C8uZRi+Nd6ZO1QDpx5C8SgMqZ2P
   A==;
X-CSE-ConnectionGUID: /zVEhDKgTNyeevQcf/lQ7g==
X-CSE-MsgGUID: KXuxG6P+SPutUzWcZhh1lA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="95803897"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="95803897"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 03:39:03 -0700
X-CSE-ConnectionGUID: Vg9DE7BVQtiBTtBDea3/Uw==
X-CSE-MsgGUID: Ti4RqAGnQv6MTrfg31swsw==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.212])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 03:38:55 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 29 Apr 2026 13:38:44 +0300 (EEST)
To: Jia Wang <wangjia@ultrarisc.com>
cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
    Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
    Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/4] serial: 8250_dwlib: move DesignWare register
 definitions to header
In-Reply-To: <20260429-ultrarisc-serial-v6-1-b2c852e0c4c3@ultrarisc.com>
Message-ID: <36efd2f5-d050-c613-77bf-dc651a94a586@linux.intel.com>
References: <20260429-ultrarisc-serial-v6-0-b2c852e0c4c3@ultrarisc.com> <20260429-ultrarisc-serial-v6-1-b2c852e0c4c3@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1401029749-1777459124=:966"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1401029749-1777459124=:966
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 29 Apr 2026, Jia Wang wrote:

> Move the DW_UART_* register offsets and CPR bit/field definitions from
> 8250_dwlib.c into 8250_dwlib.h so they can be shared by 8250_dw and
> 8250_dwlib users.
>=20
> Add an include guard for 8250_dwlib.h.
>=20
> Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c    | 11 ------
>  drivers/tty/serial/8250/8250_dwlib.c | 49 --------------------------
>  drivers/tty/serial/8250/8250_dwlib.h | 67 ++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 67 insertions(+), 60 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/=
8250_dw.c
> index 94beadb4024d..467755bf0092 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -34,22 +34,11 @@
> =20
>  #include "8250_dwlib.h"
> =20
> -/* Offsets for the DesignWare specific registers */
> -#define DW_UART_USR=090x1f /* UART Status Register */
> -#define DW_UART_DMASA=090xa8 /* DMA Software Ack */
> -
>  #define OCTEON_UART_USR=090x27 /* UART Status Register */
> =20
>  #define RZN1_UART_TDMACR 0x10c /* DMA Control Register Transmit Mode */
>  #define RZN1_UART_RDMACR 0x110 /* DMA Control Register Receive Mode */
> =20
> -/* DesignWare specific register fields */
> -#define DW_UART_IIR_IID=09=09=09GENMASK(3, 0)
> -
> -#define DW_UART_MCR_SIRE=09=09BIT(6)
> -
> -#define DW_UART_USR_BUSY=09=09BIT(0)
> -
>  /* Renesas specific register fields */
>  #define RZN1_UART_xDMACR_DMA_EN=09=09BIT(0)
>  #define RZN1_UART_xDMACR_1_WORD_BURST=09(0 << 1)
> diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/82=
50/8250_dwlib.c
> index b055d89cfb39..8859e66d2d71 100644
> --- a/drivers/tty/serial/8250/8250_dwlib.c
> +++ b/drivers/tty/serial/8250/8250_dwlib.c
> @@ -13,55 +13,6 @@
> =20
>  #include "8250_dwlib.h"
> =20
> -/* Offsets for the DesignWare specific registers */
> -#define DW_UART_TCR=090xac /* Transceiver Control Register (RS485) */
> -#define DW_UART_DE_EN=090xb0 /* Driver Output Enable Register */
> -#define DW_UART_RE_EN=090xb4 /* Receiver Output Enable Register */
> -#define DW_UART_DLF=090xc0 /* Divisor Latch Fraction Register */
> -#define DW_UART_RAR=090xc4 /* Receive Address Register */
> -#define DW_UART_TAR=090xc8 /* Transmit Address Register */
> -#define DW_UART_LCR_EXT=090xcc /* Line Extended Control Register */
> -#define DW_UART_CPR=090xf4 /* Component Parameter Register */
> -#define DW_UART_UCV=090xf8 /* UART Component Version */
> -
> -/* Receive / Transmit Address Register bits */
> -#define DW_UART_ADDR_MASK=09=09GENMASK(7, 0)
> -
> -/* Line Status Register bits */
> -#define DW_UART_LSR_ADDR_RCVD=09=09BIT(8)
> -
> -/* Transceiver Control Register bits */
> -#define DW_UART_TCR_RS485_EN=09=09BIT(0)
> -#define DW_UART_TCR_RE_POL=09=09BIT(1)
> -#define DW_UART_TCR_DE_POL=09=09BIT(2)
> -#define DW_UART_TCR_XFER_MODE=09=09GENMASK(4, 3)
> -#define DW_UART_TCR_XFER_MODE_DE_DURING_RE=09FIELD_PREP(DW_UART_TCR_XFER=
_MODE, 0)
> -#define DW_UART_TCR_XFER_MODE_SW_DE_OR_RE=09FIELD_PREP(DW_UART_TCR_XFER_=
MODE, 1)
> -#define DW_UART_TCR_XFER_MODE_DE_OR_RE=09=09FIELD_PREP(DW_UART_TCR_XFER_=
MODE, 2)
> -
> -/* Line Extended Control Register bits */
> -#define DW_UART_LCR_EXT_DLS_E=09=09BIT(0)
> -#define DW_UART_LCR_EXT_ADDR_MATCH=09BIT(1)
> -#define DW_UART_LCR_EXT_SEND_ADDR=09BIT(2)
> -#define DW_UART_LCR_EXT_TRANSMIT_MODE=09BIT(3)
> -
> -/* Component Parameter Register bits */
> -#define DW_UART_CPR_ABP_DATA_WIDTH=09GENMASK(1, 0)
> -#define DW_UART_CPR_AFCE_MODE=09=09BIT(4)
> -#define DW_UART_CPR_THRE_MODE=09=09BIT(5)
> -#define DW_UART_CPR_SIR_MODE=09=09BIT(6)
> -#define DW_UART_CPR_SIR_LP_MODE=09=09BIT(7)
> -#define DW_UART_CPR_ADDITIONAL_FEATURES=09BIT(8)
> -#define DW_UART_CPR_FIFO_ACCESS=09=09BIT(9)
> -#define DW_UART_CPR_FIFO_STAT=09=09BIT(10)
> -#define DW_UART_CPR_SHADOW=09=09BIT(11)
> -#define DW_UART_CPR_ENCODED_PARMS=09BIT(12)
> -#define DW_UART_CPR_DMA_EXTRA=09=09BIT(13)
> -#define DW_UART_CPR_FIFO_MODE=09=09GENMASK(23, 16)
> -
> -/* Helper for FIFO size calculation */
> -#define DW_UART_CPR_FIFO_SIZE(a)=09(FIELD_GET(DW_UART_CPR_FIFO_MODE, (a)=
) * 16)
> -
>  /*
>   * divisor =3D div(I) + div(F)
>   * "I" means integer, "F" means fractional
> diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/82=
50/8250_dwlib.h
> index 7dd2a8e7b780..2f26f9ecacbe 100644
> --- a/drivers/tty/serial/8250/8250_dwlib.h
> +++ b/drivers/tty/serial/8250/8250_dwlib.h
> @@ -1,11 +1,76 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
>  /* Synopsys DesignWare 8250 library header file. */
> =20
> +#ifndef _SERIAL_8250_DWLIB_H_
> +#define _SERIAL_8250_DWLIB_H_
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
>  #include <linux/io.h>
>  #include <linux/types.h>
> =20
>  #include "8250.h"
> =20
> +/* Offsets for the DesignWare specific registers */
> +#define DW_UART_USR=090x1f /* UART Status Register */
> +#define DW_UART_DMASA=090xa8 /* DMA Software Ack */
> +#define DW_UART_TCR=090xac /* Transceiver Control Register (RS485) */
> +#define DW_UART_DE_EN=090xb0 /* Driver Output Enable Register */
> +#define DW_UART_RE_EN=090xb4 /* Receiver Output Enable Register */
> +#define DW_UART_DLF=090xc0 /* Divisor Latch Fraction Register */
> +#define DW_UART_RAR=090xc4 /* Receive Address Register */
> +#define DW_UART_TAR=090xc8 /* Transmit Address Register */
> +#define DW_UART_LCR_EXT=090xcc /* Line Extended Control Register */
> +#define DW_UART_CPR=090xf4 /* Component Parameter Register */
> +#define DW_UART_UCV=090xf8 /* UART Component Version */
> +
> +/* Interrupt ID Register bits */
> +#define DW_UART_IIR_IID=09=09=09GENMASK(3, 0)
> +
> +/* Modem Control Register bits */
> +#define DW_UART_MCR_SIRE=09=09BIT(6)
> +
> +/* Line Status Register bits */
> +#define DW_UART_LSR_ADDR_RCVD=09=09BIT(8)
> +
> +/* UART Status Register bits */
> +#define DW_UART_USR_BUSY=09=09BIT(0)
> +
> +/* Transceiver Control Register bits */
> +#define DW_UART_TCR_RS485_EN=09=09BIT(0)
> +#define DW_UART_TCR_RE_POL=09=09BIT(1)
> +#define DW_UART_TCR_DE_POL=09=09BIT(2)
> +#define DW_UART_TCR_XFER_MODE=09=09GENMASK(4, 3)
> +#define DW_UART_TCR_XFER_MODE_DE_DURING_RE=09FIELD_PREP(DW_UART_TCR_XFER=
_MODE, 0)
> +#define DW_UART_TCR_XFER_MODE_SW_DE_OR_RE=09FIELD_PREP(DW_UART_TCR_XFER_=
MODE, 1)
> +#define DW_UART_TCR_XFER_MODE_DE_OR_RE=09=09FIELD_PREP(DW_UART_TCR_XFER_=
MODE, 2)
> +
> +/* Receive / Transmit Address Register bits */
> +#define DW_UART_ADDR_MASK=09=09GENMASK(7, 0)
> +
> +/* Line Extended Control Register bits */
> +#define DW_UART_LCR_EXT_DLS_E=09=09BIT(0)
> +#define DW_UART_LCR_EXT_ADDR_MATCH=09BIT(1)
> +#define DW_UART_LCR_EXT_SEND_ADDR=09BIT(2)
> +#define DW_UART_LCR_EXT_TRANSMIT_MODE=09BIT(3)
> +
> +/* Component Parameter Register bits */
> +#define DW_UART_CPR_ABP_DATA_WIDTH=09GENMASK(1, 0)
> +#define DW_UART_CPR_AFCE_MODE=09=09BIT(4)
> +#define DW_UART_CPR_THRE_MODE=09=09BIT(5)
> +#define DW_UART_CPR_SIR_MODE=09=09BIT(6)
> +#define DW_UART_CPR_SIR_LP_MODE=09=09BIT(7)
> +#define DW_UART_CPR_ADDITIONAL_FEATURES=09BIT(8)
> +#define DW_UART_CPR_FIFO_ACCESS=09=09BIT(9)
> +#define DW_UART_CPR_FIFO_STAT=09=09BIT(10)
> +#define DW_UART_CPR_SHADOW=09=09BIT(11)
> +#define DW_UART_CPR_ENCODED_PARMS=09BIT(12)
> +#define DW_UART_CPR_DMA_EXTRA=09=09BIT(13)
> +#define DW_UART_CPR_FIFO_MODE=09=09GENMASK(23, 16)
> +
> +/* Helper for FIFO size calculation */
> +#define DW_UART_CPR_FIFO_SIZE(a)=09(FIELD_GET(DW_UART_CPR_FIFO_MODE, (a)=
) * 16)
> +
>  struct dw8250_port_data {
>  =09/* Port properties */
>  =09int=09=09=09line;
> @@ -38,3 +103,5 @@ static inline void dw8250_writel_ext(struct uart_port =
*p, int offset, u32 reg)
>  =09else
>  =09=09writel(reg, p->membase + offset);
>  }
> +
> +#endif /* _SERIAL_8250_DWLIB_H_ */

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1401029749-1777459124=:966--
