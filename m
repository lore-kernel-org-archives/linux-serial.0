Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="chVHorCM"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3E5D0;
	Wed, 13 Dec 2023 02:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702462738; x=1733998738;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Wzy3O+3NeLNA063iowAcF8LxoAE+r7jkheYRzoqABpk=;
  b=chVHorCMLiqDxUlx4CsoWoxABm0++TIb5g9KNemCmuF3qNWANUY6G2MC
   X4NOqepuMMFvvmBaSyPWO9/5vk4lZIxkm0We28l3scDrmPf+4DR9h3/xj
   uH3AnC36/VgXFKRROoG8JQuxWoINTnZg33pxmHZFmeEL9Af76Wu3iw66q
   ainJQc5PtsRV1Uvsz8tEX6Xi+sX/aMSTFdQCbYcfW94zdHKffO8aSvEzq
   gNw7kP/C0dm2ksvO1xTlpKasBPUFX7KVsIKmvui2JPea+XwsL8puHRStK
   Rgj6Uobh1EjkMZZdqKgcZ0EARAmXeM/z4+lGlWpFzEvpuJBbx5pFwbvpQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="385364199"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="385364199"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 02:18:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="17666056"
Received: from stetter-mobl1.ger.corp.intel.com ([10.252.50.95])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 02:18:55 -0800
Date: Wed, 13 Dec 2023 12:18:50 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Lino Sanfilippo <l.sanfilippo@kunbus.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, u.kleine-koenig@pengutronix.de, 
    shawnguo@kernel.org, s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com, 
    alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com, 
    hugo@hugovil.com, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, LinoSanfilippo@gmx.de, 
    Lukas Wunner <lukas@wunner.de>, p.rosenberger@kunbus.com, 
    stable@vger.kernel.org
Subject: Re: [PATCH v5 7/7] serial: 8250_exar: Set missing rs485_supported
 flag
In-Reply-To: <20231209125836.16294-8-l.sanfilippo@kunbus.com>
Message-ID: <acca4f3e-2763-655-9968-bbaa9920d289@linux.intel.com>
References: <20231209125836.16294-1-l.sanfilippo@kunbus.com> <20231209125836.16294-8-l.sanfilippo@kunbus.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-963407974-1702462740=:1903"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-963407974-1702462740=:1903
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Sat, 9 Dec 2023, Lino Sanfilippo wrote:

> The UART supports an auto-RTS mode in which the RTS pin is automatically
> activated during transmission. So mark this mode as being supported even
> if RTS is not controlled by the driver but the UART.
> 
> Also the serial core expects now at least one of both modes rts-on-send or
> rts-after-send to be supported. This is since during sanitization
> unsupported flags are deleted from a RS485 configuration set by userspace.
> However if the configuration ends up with both flags unset, the core prints
> a warning since it considers such a configuration invalid (see
> uart_sanitize_serial_rs485()).
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/tty/serial/8250/8250_exar.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> index 6085d356ad86..23366f868ae3 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -480,7 +480,7 @@ static int sealevel_rs485_config(struct uart_port *port, struct ktermios *termio
>  }
>  
>  static const struct serial_rs485 generic_rs485_supported = {
> -	.flags = SER_RS485_ENABLED,
> +	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND,
>  };
>  
>  static const struct exar8250_platform exar8250_default_platform = {
> @@ -524,7 +524,8 @@ static int iot2040_rs485_config(struct uart_port *port, struct ktermios *termios
>  }
>  
>  static const struct serial_rs485 iot2040_rs485_supported = {
> -	.flags = SER_RS485_ENABLED | SER_RS485_RX_DURING_TX | SER_RS485_TERMINATE_BUS,
> +	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND |
> +		 SER_RS485_RX_DURING_TX | SER_RS485_TERMINATE_BUS,
>  };
>  
>  static const struct property_entry iot2040_gpio_properties[] = {

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

(I assume you picked the correct flag among the two alternatives).

-- 
 i.

--8323329-963407974-1702462740=:1903--
