Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2BFD531;
	Mon, 15 Sep 2025 05:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757914424; cv=none; b=doNgBpRIcLp/MUKclUkqIshQeI04+D+vCEfyNvLz68JIj0Gzf80TvDEQysOm0MkV9SYES7TKhjzneAH5J/iXTxkc27op/cyy0pUK+l4LMYpxtfL19SDWcfpqPCJaO2a2ez5YL1kgI9ppHAielJdAFiSYEduHd8nhbTRSsoO1ywQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757914424; c=relaxed/simple;
	bh=YXiCg8kjOpduhsvq4Au0o9KWuuM1uRTLrpBMgK7e7x4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0Yv87X7jzyNoWRm9tpARSM/tUX7q2YGZ+USZ9zHwqIP7c3TGUNDOZA75mb/LmfBA1f4f8Y+ljpBRlUeeIgqun9DI8Sb7TVd75nmR7w422IICo3kBpGw7G+BVbXpMc+YWkD4XM3cK5Q9QODNjqp9O0+O28d9JZ7scYJsypVWfOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oibJ0v5b; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oibJ0v5b"
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58F5XNPw973598;
	Mon, 15 Sep 2025 00:33:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757914403;
	bh=agnB6R3GEZoRPtaNvh47f+HhUxJeIdo/7f5/fjJd0XA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=oibJ0v5b5D1cyErqQw36YAHi6SblrB//muJNeXtxcUKpC1anGWkTjfXbmBnGtkS0D
	 j42sIcYqsy3qPIF+wIDKqzTJf4mhqXGQqzckzATYilCfs4+DQ9O1/UQ+I4NFa74zCa
	 08kI1DmC3HSAnam/R/ku9s+B1dICrOZUcC1xRxLo=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58F5XNso505544
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 15 Sep 2025 00:33:23 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 15
 Sep 2025 00:33:22 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 15 Sep 2025 00:33:22 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58F5XLRL3507463;
	Mon, 15 Sep 2025 00:33:22 -0500
Date: Mon, 15 Sep 2025 11:03:21 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Kendall Willis <k-willis@ti.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <vishalm@ti.com>, <sebin.francis@ti.com>, <msp@baylibre.com>,
        <khilman@baylibre.com>, <a-kaur@ti.com>,
        <andriy.shevchenko@linux.intel.com>, <yujiaoliang@vivo.com>,
        <b-liu@ti.com>, <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v2 2/2] serial: 8250: omap: Support wakeup pinctrl state
 on suspend
Message-ID: <20250915053321.yradgpitr2tamd56@lcpd911>
References: <20250910-uart-daisy-chain-8250-omap-v2-0-e90d44c1a9ac@ti.com>
 <20250910-uart-daisy-chain-8250-omap-v2-2-e90d44c1a9ac@ti.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250910-uart-daisy-chain-8250-omap-v2-2-e90d44c1a9ac@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sep 10, 2025 at 16:23:32 -0500, Kendall Willis wrote:
> From: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> UART can be used as a wakeup source for am62 from suspend to ram states.
> To enable wakeup from UART am62 requires a wakeup flag being set in the

My preference would be to call it TI K3 AM62 family of SoCs.
am62 can mean very different things to different people.


> pinctrl.
> 
> If the device is marked as wakeup enabled, select the 'wakeup' pinctrl
> state on suspend and restore the default pinctrl state on resume.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Kendall Willis <k-willis@ti.com>
> ---

If you do end up respinning, include:

Reviewed-by: Dhruva Gole <d-gole@ti.com>


-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated
