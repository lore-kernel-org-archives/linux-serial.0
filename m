Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A411D63C6;
	Tue,  5 Nov 2024 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730813606; cv=none; b=OSI9Eaxg6cQ84GPYcXv1jmLpf6BFaLa+aF728CX/IyMkJvf2YJDaTS2VNx03UkOZ55GsSrhcTD2/C5LszO5m/tpzCkeKnPPZKu8s//Ymft9ARKah2u58Yba2tSVqGynZ60QM9g20CbUpsVIx/FPjqjh4Lgda0E1Kwu4jqoj3Jo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730813606; c=relaxed/simple;
	bh=ZfBfd3utH5fUj2d21rZC/jQ+ZTHQNpW9dd2J7Q6Qexw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PacQrYVheWsvJ3jGGxhfVDnjagYOGlKIZA8wLICUeS3lrAVkhKnQGd2/EWuI5BjR13kHYBGOeu4jL3qyUwMMZD7QPbh8rM1ISnbXI2Lqhh1fmEB+lxWzPVseiUTho9LOQKk6Y5qiAdMQjbdcTeQV7VZFXX1dYf84V1ALGDYz5iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bu1qnb1a; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bu1qnb1a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1730813604; x=1762349604;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZfBfd3utH5fUj2d21rZC/jQ+ZTHQNpW9dd2J7Q6Qexw=;
  b=bu1qnb1aPUgSV+SYSMBI6IyzJYpEuGORzfRFp843jYevS1WZSrLwQZt+
   xYGashGdB2THulKpBGgDsCvfQQjO02OjrsUmadqcZD0e11hw2X30DX5A0
   WN87DGU+oiMMorNQX3g4HBdE+cLCOhgQTLYG+5VoAQ1GzmDaDVd2M/KWl
   bueTT8IdIYucfCN6IeIXZFx4VEFBsWOwYJ7OuqGX6Gwnyy7upBECUDQ/j
   Z6q8fjif76yEKcVF+J8fW3yC2ivbETrgBmBtzbDZ6ahsNuPDWIKmcaLLt
   DJnV495IxCKUFn84TVg+4eTQZt1jOdTxQpcVrx2qcsYdLn/wJuMGJWSQU
   w==;
X-CSE-ConnectionGUID: eAALYus2R3+DR7TSlO2+qA==
X-CSE-MsgGUID: IVBMUznwT+26g+nP8tI3jw==
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="34412050"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Nov 2024 06:33:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Nov 2024 06:32:43 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 5 Nov 2024 06:32:40 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <mihai.sain@microchip.com>
CC: <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<gregkh@linuxfoundation.org>, <hari.prasathge@microchip.com>,
	<jirislaby@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<nicolas.ferre@microchip.com>, <richard.genoud@bootlin.com>, Andrei Simion
	<andrei.simion@microchip.com>
Subject: Re: [PATCH] tty: atmel_serial: Use devm_platform_ioremap_resource()
Date: Tue, 5 Nov 2024 15:31:56 +0200
Message-ID: <20241105133155.67025-1-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105131946.22449-1-mihai.sain@microchip.com>
References: <20241105131946.22449-1-mihai.sain@microchip.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

On 05.11.2024 15:19, Mihai Sain wrote:
> Simplify the request port function by using a single call
> to devm_platform_ioremap_resource().
> 
> This will also enhance the printing from /proc/iomem:
> 
> cat /proc/iomem | grep flexcom ; cat /proc/iomem | grep serial
> 
> f0004000-f00041ff : f0004000.flexcom flexcom@f0004000
> f8020000-f80201ff : f8020000.flexcom flexcom@f8020000
> f0004200-f00043ff : f0004200.serial serial@200
> f8020200-f80203ff : f8020200.serial serial@200
> fffff200-fffff3ff : fffff200.serial serial@fffff200
> 
> Signed-off-by: Mihai Sain <mihai.sain@microchip.com>

Hi,

Tested-by: Andrei Simion <andrei.simion@microchip.com>

Best Regards,
Andrei

> ---
>  drivers/tty/serial/atmel_serial.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 09b246c9e389..e1107f14ec98 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -2419,17 +2419,11 @@ static void atmel_release_port(struct uart_port *port)
>  static int atmel_request_port(struct uart_port *port)
>  {
>  	struct platform_device *mpdev = to_platform_device(port->dev->parent);
> -	int size = resource_size(mpdev->resource);
> -
> -	if (!request_mem_region(port->mapbase, size, "atmel_serial"))
> -		return -EBUSY;
>  
>  	if (port->flags & UPF_IOREMAP) {
> -		port->membase = ioremap(port->mapbase, size);
> -		if (port->membase == NULL) {
> -			release_mem_region(port->mapbase, size);
> -			return -ENOMEM;
> -		}
> +		port->membase = devm_platform_ioremap_resource(mpdev, 0);
> +		if (IS_ERR(port->membase))
> +			return PTR_ERR(port->membase);
>  	}
>  
>  	return 0;
> 
> base-commit: 2e1b3cc9d7f790145a80cb705b168f05dab65df2
