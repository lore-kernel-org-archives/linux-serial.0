Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F386FC5;
	Mon, 15 Sep 2025 05:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757913687; cv=none; b=L0CUB8xtui6k+DxfkE0kMLD39A4lnTy/ihwAqS7K3kbxfRTsJLtNp8EfzgwcCcDmf25YlwZd2kd2vKcKhSPosTH4ZrfurqHN6JSNzaGLysnnG8gm7Q3DgMzgNUCzAZTWoak1z9gthy+UqBvrWVZcWVa7cVr0aSINjqVCL/Ub9J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757913687; c=relaxed/simple;
	bh=+UY/gfySu69hMQFgHNwQXMNZNJ4TaUu2K4xu52VtoaU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A67+dvb8JQ7tQZKcX7CPDzEyAlUtOtexDqC8BTKt6pXU9T46Yu6i0ZEItI/aMHTG5GIGHkyFhqOtL8LeluyEgfXs587BFl8mHjiUX5lvE1W1zJSxfFf8kdv0faFpEbk8wZ2Nsq9SFdXWh4c6fbFjqv5nGu9D+O18+6f/oQWhjAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=A1n7fdgB; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="A1n7fdgB"
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58F5LBS01061404;
	Mon, 15 Sep 2025 00:21:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757913671;
	bh=6NEUtU7DgmrhHU882iRUuSe9qSjSXfl9iq3D5Mevz/Q=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=A1n7fdgBhAHo3HHF2HBlbm6kgIHLFqk0hg/+oN9aTXBQDG4/WST8DbA/Rwkuda8lo
	 LiBd8gpnHNjBLPgzko5RcGPSXcUADLuyx2SeLrt3nkEIWhy0UyNbq/fGrnRT66VMdW
	 ce8FvX6iqksmzkHdmyAbQdLMft8ah8lapkDkhZSs=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58F5LB8r3715428
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 15 Sep 2025 00:21:11 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 15
 Sep 2025 00:21:10 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 15 Sep 2025 00:21:10 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58F5L9EJ3188986;
	Mon, 15 Sep 2025 00:21:10 -0500
Date: Mon, 15 Sep 2025 10:51:08 +0530
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
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: 8250_omap: Add wakeup
 pinctrl state
Message-ID: <20250915052108.jk25w6kzidikumto@lcpd911>
References: <20250910-uart-daisy-chain-8250-omap-v2-0-e90d44c1a9ac@ti.com>
 <20250910-uart-daisy-chain-8250-omap-v2-1-e90d44c1a9ac@ti.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250910-uart-daisy-chain-8250-omap-v2-1-e90d44c1a9ac@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sep 10, 2025 at 16:23:31 -0500, Kendall Willis wrote:
> From: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> Pins associated with the 8250 omap unit can be the source of a wakeup in
> deep sleep states. To be able to wakeup, these pins have to be
> configured in a special way. To support this configuration add the
> default and wakeup pinctrl states.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Kendall Willis <k-willis@ti.com>
> ---
>  Documentation/devicetree/bindings/serial/8250_omap.yaml | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated
