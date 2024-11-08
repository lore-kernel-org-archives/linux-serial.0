Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B45C8CE;
	Fri,  8 Nov 2024 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731072041; cv=none; b=kcpAjMnX/87sKxEnSLB0WLWVFcKuYbi63g3Ge3HfksxPa5rlAqQke3Q2eeO0OJION+Uf4b2YX2HktH+Q0+vIeLSMibROEAuR1yiAX/xx9wx1w8bdCRSMdoU67gBVO27A7/ourzarkCtU5iGUePTXz/CvPsJmfhq3/t5KdCupKvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731072041; c=relaxed/simple;
	bh=q+UMqKv74gpz3voF8S2P7kWDpsQDIqMFOF8q2PGUw10=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JIXxr+G9eMwysV2pG1OPOtWucJK8j+QhavdRId9ZdREHPQ6osm3rXVjn7SzS82UW9mVSGyf8b8JKYIxEx03CHVQheSdw5rq/V2moGERG59YSeRZ8CWXzemazJ1RWRnBcwyolk1wARKJ/YO46/s0mCUIckwWWEePIg6VBgiBNrWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PdcYG0J7; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PdcYG0J7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731072040; x=1762608040;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q+UMqKv74gpz3voF8S2P7kWDpsQDIqMFOF8q2PGUw10=;
  b=PdcYG0J7iMVKyXKo6Dl4KA0xZ1u3Z+pdspTzNACwh7QmsDTdbp5sHhFU
   pA6viOopVBWPfAbmemfFoOn974iddSg0lgvzmNNcIhZ8wZM8VmKAgaRZR
   pTnbgI0y7a23gKrSVU5jD/IQQynbnouPVMYSLP9rvrbeqQtCCYW6eKjdV
   KffOhWHHOOt/aEWoBMbv3xCGGIpTWJLSIq7kBocEUGaCVh3PV2KvGDAJ3
   yur9QjeRHjtxgTwLqbljtqarZRTvQfHZeUZXXGfb5h6gCNUJcFQTgk9Pm
   5QYZI9XMgG3wqf611ufFXdF63eGmlSYMKPhzm/+f6FYpla/EG+Llzo8GW
   w==;
X-CSE-ConnectionGUID: PvurtoTEQ2WlLblVte8kjQ==
X-CSE-MsgGUID: 2BBk/xFWRYWcMYKhM1xQig==
X-IronPort-AV: E=Sophos;i="6.12,138,1728975600"; 
   d="scan'208";a="34056474"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Nov 2024 06:20:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Nov 2024 06:20:21 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 8 Nov 2024 06:20:19 -0700
Message-ID: <743af86d-e7ad-4698-b7a4-d75cf46f00d7@microchip.com>
Date: Fri, 8 Nov 2024 14:20:29 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mfd: at91-usart: make it selectable for ARCH_LAN969X
Content-Language: en-US, fr-FR
To: Robert Marko <robert.marko@sartura.hr>, <mturquette@baylibre.com>,
	<sboyd@kernel.org>, <lee@kernel.org>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <luka.perkov@sartura.hr>
References: <20241108112355.20251-1-robert.marko@sartura.hr>
 <20241108112355.20251-2-robert.marko@sartura.hr>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20241108112355.20251-2-robert.marko@sartura.hr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 08/11/2024 at 12:22, Robert Marko wrote:
> LAN969x uses the AT91 USART IP so make it selectable for ARCH_LAN969X.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   drivers/mfd/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index ae23b317a64e..f280ba28d618 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -138,7 +138,7 @@ config MFD_AAT2870_CORE
>   config MFD_AT91_USART
>          tristate "AT91 USART Driver"
>          select MFD_CORE
> -       depends on ARCH_AT91 || COMPILE_TEST
> +       depends on ARCH_AT91 || ARCH_LAN969X ||COMPILE_TEST
>          help
>            Select this to get support for AT91 USART IP. This is a wrapper
>            over at91-usart-serial driver and usart-spi-driver. Only one function
> --
> 2.47.0
> 
> 

