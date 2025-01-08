Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E991FBEAF;
	Wed,  8 Jan 2025 13:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736343399; cv=none; b=tIMGTnHTG333PHwTtnEs92ODGqz1L+ELw/vWcDMCXRqr+T17+Wmzq7yEhlyjPRm/NEpsA1rRG6Ij8H2EjAVYOubdHTXYyTnU/mUxf63K7JeAlwz6AbAVYubb7gyuk+zsoyqbNLajk3ut4YOrmBZ2Ue+543ckTi90f2XB/ZQs0CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736343399; c=relaxed/simple;
	bh=Y+Cs5xbgf/BL3TuDrL23bogHa42BatxpXamUv7gZeDA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+NIU8ND6OwrBzqY9+bZPm4LNwxCWea1ryAZx8vXQ4NKFhFRmmjfrojuDdLaPXil2ypL8SMg7XemlESNvJR9tCz/jyGcxUzCQS2iUgDRXTihhQJaZCdXVrAMp/j/w3CFVO0fuUe9pz00qqWwR4z+FT2S2vT83W05Ce1UxX1FkMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=P9W6ZwlC; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="P9W6ZwlC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1736343398; x=1767879398;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y+Cs5xbgf/BL3TuDrL23bogHa42BatxpXamUv7gZeDA=;
  b=P9W6ZwlC+vmpH+DQhCQqcOL3y22A7/lbeKPGaDUv30jA0R6d8xKCJPTO
   k/Y89zThdHyPvCPCa/q80kQGJVJvjXFDEZXCVKfUwMF38xS/nEnEv5Gly
   fNkktYFr42uIAHdzwjMrKcooD98BGpYYtt/pj/zfxJ+DucneDCqnlCTt7
   cDIP9pJEMkusPmOOqxbbpFD2uc6i9rkvfHDdDBOlqDwg0HdFucSf0n1Z3
   I7f36plRvFsx0yjJxXqrOsnSH+QYpq06PXjejH8DRPIpfeCr6Kp4seUX/
   Ijr43e5L5d9XXb39pCdZVtbysdaiiAM//F9cXt2IZLbkWlErMBNmVdOUP
   g==;
X-CSE-ConnectionGUID: YYc78GS+T4KIxstOKUdH/A==
X-CSE-MsgGUID: AMoFRzCVSmGHmJlOpcnucA==
X-IronPort-AV: E=Sophos;i="6.12,298,1728975600"; 
   d="scan'208";a="36301300"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jan 2025 06:36:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 Jan 2025 06:35:39 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 8 Jan 2025 06:35:37 -0700
Date: Wed, 8 Jan 2025 13:35:36 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Robert Marko <robert.marko@sartura.hr>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <lee@kernel.org>,
	<gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <arnd@kernel.org>,
	<lars.povlsen@microchip.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<luka.perkov@sartura.hr>, Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH v3 2/3] mfd: at91-usart: make it selectable for
 ARCH_LAN969X
Message-ID: <20250108133536.wlecqn362bt6nfmo@DEN-DL-M70577>
References: <20250108131045.40642-1-robert.marko@sartura.hr>
 <20250108131045.40642-2-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250108131045.40642-2-robert.marko@sartura.hr>

> LAN969x uses the AT91 USART IP so make it selectable for ARCH_LAN969X.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Acked-by: Lee Jones <lee@kernel.org>
> ---
> Changes in v3:
> * Pickup Acked-by from Lee
> 
> Changes in v2:
> * Pickup Acked-by from Nicolas
> 
>  drivers/mfd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 6b0682af6e32..ef32ac5ed75d 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -138,7 +138,7 @@ config MFD_AAT2870_CORE
>  config MFD_AT91_USART
>         tristate "AT91 USART Driver"
>         select MFD_CORE
> -       depends on ARCH_AT91 || COMPILE_TEST
> +       depends on ARCH_AT91 || ARCH_LAN969X ||COMPILE_TEST

You fixed the missing whitespace before COMPILE_TEST in 3/3, but it seems like
you are missing it here too.

>         help
>           Select this to get support for AT91 USART IP. This is a wrapper
>           over at91-usart-serial driver and usart-spi-driver. Only one function
> --
> 2.47.1
> 
