Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793102273;
	b=eekwuHXNk63Hs0QAM1trLxfk4voL9X4GsBkXix1DD08ykdT3PRQFkU/UQEe8AabNLQLt
	 2ZCBiYXG26dHS8bwrU2ukOK8zRH8bKam0HixfgZnrbzav2Dnyyq91+2oEzTn0a+mrn5gd
	 6cdvXRa6T2XJvukqxNuDGhUPudDB7e82TfwXgm1vaftKVrrND+VREpWEkiwbdI6i5F94o
	 fbkEJ3vz4aZ3BxZPFx5fI0ewhIRC5qCCASc4dvUnzWaHb0KdXPMmE8H2KpVRm96vVkkx+
	 c2XkYWYQHctCKOwUotMliA0eaeMgCw6S2Nnd2KjN9n5MHMfwxNXtuKHI7BNwGoZUflA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793102273;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=2cu82rx5fiphikN/Vk+jUaL/N03EGA9W6I/mCSMf4Gs=;
	b=qZgKQn+qjIPjURJEgUFVp2wQFxs5U9UvER36i8WrQHds+6d22ofqOivqRK75ujDCbUW9
	 nXVvB3iOntIdTe2v8GzO2o0Q/4q1lqDKcaHyc8EiCUb7OH1DJRXnEUOP1jLg7eOrbSz4I
	 sb3GsUe70/g5KWooQ7aCKvk0NuRjzQd00AVoPIMYiKjQu2SaUVvchRrvCpCQWDrJKjts+
	 l7I1emAVN75JERohBtFojKelV8+1KTiSv1OkvtHLpCN10OQTI7DbBlppxEeaYXOWlj+sm
	 I1CBbFF7xx6wVaOuYzuvZs66HhyePNS7hEySr9XInc3KzcuNqtXb9orNu+oW8S64Xjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nI7kpECR;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F8D606A31A;
	Tue, 27 Oct 2026 11:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14F8D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nI7kpECR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793102272; x=1824638272;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ubZAb9zJvoWNoMVwCd+QomG3MwEYUpWX4/US8bXSPVE=;
  b=nI7kpECRSzucyQ+LWFXQlZyW+n8MJcN540DS0N6HPLrRHpNA/2+wJcpE
   O/QTqVD3iFYL7PjWs/aUBtx9mDcSrqWmBTxyB7wiribwnYLwa5PmzK3SI
   9YTY+aqSX8v7+LHnN2+Q/pSzTlYaRgHxIYBjCWlHzhqx5RWkmmm3Y6ZXK
   cvjjP4xV2M/d1j54XjShnLE1qrAPgnZ1PGjXl3OokF7ZsczdTtWXEaJQ/
   tPoG2k11+YmA5FoGDKZm3KoYY99jsayWM7HSD2RGHJR8w9+P93mwx6DK/
   m8fEgyMPrvAPNlq/dWvfSk5WbkEHKq7S2Zh5bezW7bY6xUq+k9A6oN7Da
   A==;
X-CSE-ConnectionGUID: dkEPfsJwQWOz4iRjEb23Yw==
X-CSE-MsgGUID: 1u27nKFLQwOooxtnNfeIHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1689543"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1689543"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 04:57:51 -0700
X-CSE-ConnectionGUID: dts9eYvHQYOuuPhdOdURHQ==
X-CSE-MsgGUID: jOYaDZveRoGiaBz18PtKsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4484504"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 04:57:39 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Oct 2026 13:57:36 +0200 (EET)
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
Subject: Re: [PATCH 06/24] serial: 8250: add bounds check for line array in
 setup_serial()
In-Reply-To: <20261027-tty-llm-v1-6-99b0202ae546@linuxfoundation.org>
Message-ID: <c4410d96-0507-6ad2-30fa-2dab91f04441@linux.intel.com>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org> <20261027-tty-llm-v1-6-99b0202ae546@linuxfoundation.org>
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

The prefix could be less generic.

On Tue, 27 Oct 2026, Greg Kroah-Hartman wrote:

> From: Joshua Rogers <linux@joshua.hu>
> 
> setup_serial() writes to info->line[info->ndev] without verifying that
> ndev is within the array bounds. A malformed PCMCIA card with a large

Yeah right... Are the "malformed" ones only ones remaining... :-)

> I/O window can cause info->multi to exceed 4, leading to out-of-bounds
> writes past the line[4] array and corruption of adjacent struct members.
> 
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: stable <stable@kernel.org>
> Signed-off-by: Joshua Rogers <linux@joshua.hu>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/serial/8250/serial_cs.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/serial_cs.c b/drivers/tty/serial/8250/serial_cs.c
> index 5dcd1544e478..8bd88f3d6d86 100644
> --- a/drivers/tty/serial/8250/serial_cs.c
> +++ b/drivers/tty/serial/8250/serial_cs.c
> @@ -349,6 +349,11 @@ static int setup_serial(struct pcmcia_device *handle, struct serial_info *info,
>  {
>  	struct uart_8250_port uart;
>  
> +	if (info->ndev >= ARRAY_SIZE(info->line)) {
> +		dev_err(&handle->dev, "no room for more serial ports\n");
> +		return -EINVAL;
> +	}
> +
>  	memset(&uart, 0, sizeof(uart));
>  	uart.port.iobase = iobase;
>  	uart.port.irq = irq;
> 
> 

-- 
 i.

