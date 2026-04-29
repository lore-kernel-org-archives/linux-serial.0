Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9CD22689C;
	Wed, 29 Apr 2026 10:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777459706; cv=none; b=ZUAZhLnp4vWh6ZpEvmECCzKaXWvPRbAczdHFunMGmWgC2f4w4tnl9GJfTW4DcJA0zbF8CJfMb1cOnWpLyU5bQCXRim+kjinS5HU/K3DNpz5TWZj1ctUOmiGwjE88RJck3rIPHUMgFxgAPSmzs6Woi/5loD1WFggudQlb2/mCtAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777459706; c=relaxed/simple;
	bh=/vAFIzaxy72CNwPreca6/xZ3kyhdOr3u8DIgfRUhjKA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ujiNpUD4lJaGTpCBngdsPRSx/X1BU1jPLJg9+MVntsITRIUZxIbjRGnLwvA7SzxW0edzq0cOgbOpzRh3P/A9hI5xQk1oDeFtfddXFIDJTMNQD2FFVHg5rl3w3tdgDiqMhs6F644h1AzMhs0vtDJJjc/IX39+dXx7c+Uv6fcrR8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XG2c6m1B; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XG2c6m1B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777459706; x=1808995706;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/vAFIzaxy72CNwPreca6/xZ3kyhdOr3u8DIgfRUhjKA=;
  b=XG2c6m1BAWJW+9Wj2TDIntfhF+8XwgP+as0xvirNVlIimmZfjUGzmG8H
   J6G81Jr6oCtH9c3dbIRV3l31HzgVwH6k2ZeNq/yHNWwY9Z7vR4wcNqXr5
   HEBvf5/pwuUaW/E0AhupMcOn7m2oENK5/E+SKucNJ/+jT75NFMFJ0LsAi
   +2rBlrglPj5rigAEzmDW4SgWcVr+Q4RMZsMBWMReCXSbtMtqON2PL6X/0
   KkEiPTn1M4WRxRrJTGx1rwLfuDyr2AYuLkW5NgxMGezvz/AHxeK7TRoEE
   bNiTnsv48sJG7qM0vHesXvteJW8scQO3yiAZLEEpgBYXZSjO5GRujLR5k
   g==;
X-CSE-ConnectionGUID: yiUPPNejTNy7g12pMvCoXA==
X-CSE-MsgGUID: z3unIgK7QS+rR0OycFLWTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="95804828"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="95804828"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 03:48:25 -0700
X-CSE-ConnectionGUID: rRKM1xTYTcSySZEb+EaBkA==
X-CSE-MsgGUID: JVX5r+3tSASiiZtwZcREBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="238558781"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.212])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 03:48:21 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 29 Apr 2026 13:48:17 +0300 (EEST)
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
Subject: Re: [PATCH v7 2/4] serial: 8250_dw: build Renesas RZN1 CPR value
 from DW_UART_CPR_* definitions
In-Reply-To: <20260429-ultrarisc-serial-v7-2-e475cce9e274@ultrarisc.com>
Message-ID: <013a17f8-ba6a-9a3f-ae5e-88bdaab02d23@linux.intel.com>
References: <20260429-ultrarisc-serial-v7-0-e475cce9e274@ultrarisc.com> <20260429-ultrarisc-serial-v7-2-e475cce9e274@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1552678780-1777459697=:966"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1552678780-1777459697=:966
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 29 Apr 2026, Jia Wang wrote:

> Replace the magic CPR value for Renesas RZ/N1 with a composition using
> DW_UART_CPR_* bit/field definitions and FIELD_PREP_CONST().
>=20
> Introduce a helper macro to convert a FIFO size (bytes) into the CPR
> FIFO_MODE field value, with BUILD_BUG_ON_ZERO() checks for alignment and
> bounds. Use it to replace the literal FIFO_MODE values in the RZN1.
>=20
> Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c    | 10 +++++++++-
>  drivers/tty/serial/8250/8250_dwlib.h |  8 +++++++-
>  2 files changed, 16 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/=
8250_dw.c
> index 467755bf0092..480f82d89856 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -937,7 +937,15 @@ static const struct dw8250_platform_data dw8250_arma=
da_38x_data =3D {
> =20
>  static const struct dw8250_platform_data dw8250_renesas_rzn1_data =3D {
>  =09.usr_reg =3D DW_UART_USR,
> -=09.cpr_value =3D 0x00012f32,
> +=09.cpr_value =3D FIELD_PREP_CONST(DW_UART_CPR_ABP_DATA_WIDTH, 2) |
> +=09=09     DW_UART_CPR_AFCE_MODE |
> +=09=09     DW_UART_CPR_THRE_MODE |
> +=09=09     DW_UART_CPR_ADDITIONAL_FEATURES |
> +=09=09     DW_UART_CPR_FIFO_ACCESS |
> +=09=09     DW_UART_CPR_FIFO_STAT |
> +=09=09     DW_UART_CPR_SHADOW |
> +=09=09     DW_UART_CPR_DMA_EXTRA |
> +=09=09     DW_UART_CPR_FIFO_MODE_FROM_SIZE(16),

Thanks for doing this, it's just so much better than the original. :-)

>  =09.quirks =3D DW_UART_QUIRK_CPR_VALUE | DW_UART_QUIRK_IS_DMA_FC,
>  };
> =20
> diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/82=
50/8250_dwlib.h
> index 2f26f9ecacbe..1fe52332e774 100644
> --- a/drivers/tty/serial/8250/8250_dwlib.h
> +++ b/drivers/tty/serial/8250/8250_dwlib.h
> @@ -6,6 +6,7 @@
> =20
>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
> +#include <linux/build_bug.h>
>  #include <linux/io.h>
>  #include <linux/types.h>
> =20
> @@ -68,8 +69,13 @@
>  #define DW_UART_CPR_DMA_EXTRA=09=09BIT(13)
>  #define DW_UART_CPR_FIFO_MODE=09=09GENMASK(23, 16)
> =20
> -/* Helper for FIFO size calculation */
> +/* Helpers for FIFO size calculation */
>  #define DW_UART_CPR_FIFO_SIZE(a)=09(FIELD_GET(DW_UART_CPR_FIFO_MODE, (a)=
) * 16)
> +#define DW_UART_CPR_FIFO_MODE_FROM_SIZE(size)=09=09=09\
> +=09(FIELD_PREP_CONST(DW_UART_CPR_FIFO_MODE,=09=09\
> +=09=09=09  BUILD_BUG_ON_ZERO((size) > 2048) +=09\
> +=09=09=09  BUILD_BUG_ON_ZERO((size) % 16) +=09\
> +=09=09=09  ((size) / 16)))

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.
--8323328-1552678780-1777459697=:966--
