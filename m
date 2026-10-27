Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106144;
	b=18kJxNsyyQDSqA+pRiboTtTdPiHcALpW0IQfKbPzUzk7RAmJdvhdS1HdPgBhihDfr3Tf
	 tW73o8bfWwZ3ygIEtOPVgJCJONRGUeMCmB8jf0z2VYavr8g1iOSW0PtNt9bnjY9froZdT
	 26usPNpeg4kIiTkH++9jEiR52/IysO+gJV2lTgKvcc1osmMeS8b5gW9gTKPiT8ZPrUct+
	 izMdGLTLE4imW+0SEJ7u68PHtquUa411foPFvBLnnPLfswhdn7EoyTll5kB9rZ7d5lvwd
	 q5pRtlXPw27G2GO+uytm8N3PSRF9+q/iU/W1KEiDiyH7g6+xtRD5tHJmD8tXOTxpRyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106144;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=QsIq+b+nVuNOBKkqFGt+6fJye72iwcODEcvP3kOjZcQ=;
	b=NEaCXRpXsSOqpUU0VNnMIF6eakFFKVwlj3CNusfkAfw/bPzLp82zEGgvYOb40P12+Ka5
	 eqkio1uDG/odoSqI3s5DDOBvPk6f2ivT+DtLs8bVbZDAglH2SbH+vN9yw1i/5ZHrgMNFA
	 4CDIrT73rECr9adGoQERoK0wWVQjr80jH38bVDv+vQAy7gl4+VOmkG1kxIS0nDgqkgjUN
	 BtzwfmroYqMOWiOVxzzVI0Y1zh6+j6G+IEiEsljvHf5nU526860RBe6Vmo47gJvtV4Fmg
	 QVifwOTGfIeyeFBCKwy2LV/2IO8A7E+L4V/DGrwejmz80I7kgEKWmdGyEShstRLM/sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FqY4LiyE;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9E0606A31B;
	Tue, 27 Oct 2026 13:02:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA9E0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FqY4LiyE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793106144; x=1824642144;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=oUSs0MPKdaL1ffVF0pRa19PxPpMZnnSfYMznFsOG0aA=;
  b=FqY4LiyELq+PO0YXiKKiNDwBNlLUHPmPa1Lds+vCMRV+ZFk1TNs+MhJR
   oWB6g/1fXgIPhAFvsq8oIG4aEvpy4TobDDLO2rPa2eecCrpEeDNIItfcL
   ynR6aVyBoXNDT3liZ1KiJa6SvJSIt2kTMb0gwfIKE/W+TDlQVUceg7Tz5
   n7BzsWvm4YGXNsFq5E/CjIdPfQq48GAIotSWKMGnO6RXowL/gh0nLAwOo
   sj5aR8azYh+3A3GhuJi5m7x8lYhvGLHJ41NZg/frrxs8kIwy+uMvKkjdj
   zGQJsBBBte1HKYUKNHoPTUjbYuODyUfe+sPUoRE83hgXZ6/dFRY3rY7OJ
   g==;
X-CSE-ConnectionGUID: WzOrIVnEQzCdP9qxHZfsuw==
X-CSE-MsgGUID: 5txX0X+zSLS3h5VoJO/9sA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1792049"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1792049"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 06:02:23 -0700
X-CSE-ConnectionGUID: FUeDrtKaSj65EplJX5DqFg==
X-CSE-MsgGUID: E49Qn/k/RWaF4SRweWQF4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4875837"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 06:02:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Oct 2026 15:02:07 +0200 (EET)
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Jiri Slaby <jirislaby@kernel.org>, Joshua Rogers <linux@joshua.hu>, 
    Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
    Tony Lindgren <tony@atomide.com>, Rafael Gago Castano <rgc@hms.se>, 
    Florian Fainelli <f.fainelli@gmail.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Peter Hurley <peter@hurleysoftware.com>, 
    Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
    Crescent Hsieh <crescentcy.hsieh@moxa.com>, Frank Li <Frank.Li@nxp.com>, 
    Sherry Sun <sherry.sun@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
    Pengutronix Kernel Team <kernel@pengutronix.de>, 
    Fabio Estevam <festevam@gmail.com>, 
    Manivannan Sadhasivam <mani@kernel.org>, Olof Johansson <olof@lixom.net>, 
    =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber@suse.de>, 
    Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
    Peter Griffin <peter.griffin@linaro.org>, 
    Alim Akhtar <alim.akhtar@samsung.com>, 
    Robert Baldyga <r.baldyga@samsung.com>, 
    Thomas Abraham <thomas.abraham@linaro.org>, 
    Kukjin Kim <kgene.kim@samsung.com>, 
    Patrice Chotard <patrice.chotard@foss.st.com>, 
    Srinivas Kandagatla <srini@kernel.org>, 
    Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
    Alexandre Torgue <alexandre.torgue@foss.st.com>, 
    Andy Shevchenko <andy.shevchenko@gmail.com>, 
    Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, 
    Al Cooper <alcooperx@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, stable <stable@kernel.org>
Subject: Re: [PATCH 24/24] serial: stm32: don't report a wakeup to a closed
 tty
In-Reply-To: <20261027-tty-llm-v1-24-99b0202ae546@linuxfoundation.org>
Message-ID: <aef066bc-1b1e-b1e8-97f5-6fa8c8d18940@linux.intel.com>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org> <20261027-tty-llm-v1-24-99b0202ae546@linuxfoundation.org>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 27 Oct 2026, Greg Kroah-Hartman wrote:

> From: Josef Bacik <josef@toxicpanda.com>
> 
> stm32_usart_interrupt() reports a wakeup interrupt as a wakeup event of
> tport->tty->dev.  That pointer is only set while the port is open.  The
> port of a console is not shut down by the last close: it stays
> initialized, so the wakeup interrupt is still enabled on suspend.  If
> the system is then woken up by the console, the handler dereferences a
> NULL pointer.
> 
> Take a reference to the tty, and leave the event out if there is none.
> 
> Fixes: 48a6092fb41f ("serial: stm32-usart: Add STM32 USART Driver")
> Cc: stable <stable@kernel.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> Cc: Peter Hurley <peter@hurleysoftware.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/serial/stm32-usart.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
> index ad06b760cfca..3bc2ce877585 100644
> --- a/drivers/tty/serial/stm32-usart.c
> +++ b/drivers/tty/serial/stm32-usart.c
> @@ -872,8 +872,15 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
>  		writel_relaxed(USART_ICR_WUCF,
>  			       port->membase + ofs->icr);
>  		stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_WUFIE);
> -		if (irqd_is_wakeup_set(irq_get_irq_data(port->irq)))
> -			pm_wakeup_event(tport->tty->dev, 0);
> +		if (irqd_is_wakeup_set(irq_get_irq_data(port->irq))) {
> +			struct tty_struct *tty = tty_port_tty_get(tport);
> +
> +			/* A console stays set up after the last close */
> +			if (tty) {
> +				pm_wakeup_event(tty->dev, 0);
> +				tty_kref_put(tty);
> +			}
> +		}

Could we like add a helper into serial core to do this tty wakeup dance? 
It is duplicated in quite many of these patches.


-- 
 i.

