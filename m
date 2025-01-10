Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8C018A6DF;
	Fri, 10 Jan 2025 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736501588; cv=none; b=DKnYdX3TYGQ1rEy/KrP55RCPMn9EmAo5gEJU9wKKVim6T4ZiAHgEPxUMSecSOjjOmM7QYIE3L869whCmlOF2wmRNM7PAPORePHS1X93ERNSdmLQFv8St1tBFcNnQ/TjWsGxtnzopRa/Te7Wbz4FX8iHddVOU5MQdUUhKKlb20FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736501588; c=relaxed/simple;
	bh=jjJ7LK5O+a7pYF2qmcJDXghsWjUlHsE0YcIU+H6coOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=r0PfadBAgiOhIiEIVrkjOCeu9CWGlJojUrY1kYJmsYreclEthYYS8uVZjXQbxHQto0hrCbLSOvzX66qCAII4V0dZ0rDeJ1XtDGIOGVrc/8JG1qN7SQVXronclR1nqiJSpZyjx9Z1uGkLLKkBMdfVI68NfXnpfkfqEaSzdHlVsyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=upKouFj0; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="upKouFj0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1736501586; x=1768037586;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jjJ7LK5O+a7pYF2qmcJDXghsWjUlHsE0YcIU+H6coOk=;
  b=upKouFj02PSpL/YkfS5W3Z56CTMTJeFbLnNoi5UV2bS0UeVv2IUKfmDf
   CP7goCSbHizMYHPw2ZdyuBfElIHR/zFuizmAqFFuKY12HLNRfi0LrHgRw
   mg6S98ZGd+Gpnqj1ssve0yXIQnsVZy3zY55CZ1J3xWPSf0+EMKbLQTtKM
   dv/ZWxhPqs9uU52l7vrfixysk/3ss9/p+RSyyS45gN6IipPqKXqrGvLEC
   vyhm71+2JIqk2IPCPiwEvjgAF6viI2aeZHBZ9p/kuT0Fw/YeYDGhHQRrK
   7qQan06LaH08upip1qFBEVNMoLqlsIawSxDzhM0WjCzDkBvPvCZOYJC8q
   A==;
X-CSE-ConnectionGUID: ZmCJLco0SampymAgwNXOYA==
X-CSE-MsgGUID: CJCEpP1XR9CmnO67I8eFbQ==
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="36822340"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2025 02:33:05 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 Jan 2025 02:32:35 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 10 Jan 2025 02:32:33 -0700
Message-ID: <d6449ca2-8d68-4007-805d-0f71d2cea681@microchip.com>
Date: Fri, 10 Jan 2025 10:32:46 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: atmel_serial: Use of_property_present() for
 non-boolean properties
To: "Rob Herring (Arm)" <robh@kernel.org>, Richard Genoud
	<richard.genoud@bootlin.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20250109182053.3970547-1-robh@kernel.org>
Content-Language: en-US, fr-FR
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20250109182053.3970547-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 09/01/2025 at 19:20, Rob Herring (Arm) wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> The use of of_property_read_bool() for non-boolean properties is
> deprecated in favor of of_property_present() when testing for property
> presence.
> 
> As of_property_present() returns a boolean, use that directly
> and simplify the code a bit while we're here.

Indeed! Thanks Rob.

Reviewed-by: Nicolas Ferre <nicolas.ferre@microchip.com>


> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>   drivers/tty/serial/atmel_serial.c | 18 ++++--------------
>   1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 0cf05ac18993..f44f9d20a974 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -1727,26 +1727,16 @@ static void atmel_init_property(struct atmel_uart_port *atmel_port,
> 
>          /* DMA/PDC usage specification */
>          if (of_property_read_bool(np, "atmel,use-dma-rx")) {
> -               if (of_property_read_bool(np, "dmas")) {
> -                       atmel_port->use_dma_rx  = true;
> -                       atmel_port->use_pdc_rx  = false;
> -               } else {
> -                       atmel_port->use_dma_rx  = false;
> -                       atmel_port->use_pdc_rx  = true;
> -               }
> +               atmel_port->use_dma_rx = of_property_present(np, "dmas");
> +               atmel_port->use_pdc_rx = !atmel_port->use_dma_rx;
>          } else {
>                  atmel_port->use_dma_rx  = false;
>                  atmel_port->use_pdc_rx  = false;
>          }
> 
>          if (of_property_read_bool(np, "atmel,use-dma-tx")) {
> -               if (of_property_read_bool(np, "dmas")) {
> -                       atmel_port->use_dma_tx  = true;
> -                       atmel_port->use_pdc_tx  = false;
> -               } else {
> -                       atmel_port->use_dma_tx  = false;
> -                       atmel_port->use_pdc_tx  = true;
> -               }
> +               atmel_port->use_dma_tx = of_property_present(np, "dmas");
> +               atmel_port->use_pdc_tx = !atmel_port->use_dma_tx;
>          } else {
>                  atmel_port->use_dma_tx  = false;
>                  atmel_port->use_pdc_tx  = false;
> --
> 2.45.2
> 

