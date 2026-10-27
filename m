Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104745;
	b=fc/fSI+JUOOVoN5CrrtEPAVU87savhVXMONpAnMItL0QGM1TJCTIvXDyyyfRCTToEBte
	 X78x3GXxOL7SmRLOEPcTbW3cmWWJ5SFa1+hYhtXXENC1Y6Jbh8dJQQ135352/unQxZosj
	 FwIYTa9FLbZSyVzmwwnBdHOoDP+VynRo/IG016Q3OGFd4+z/KzmmDrojL27ctB9TDhiNo
	 F/QFdHF60Sxn7KN5nLjPqm2mE9zhymKGy53tQn0P6p9N2jTxsOPBG70OFccH2MUfFdiJq
	 MoqAk5tXOeNVhiCmHzJKfgiFpMK4k8+mb0iC1gTCS9k1NvznQ75Eie+GPF1QRh13VIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104745;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=kq1E/vncfl9qdy0McCIiuol7fOFggMDBnOUQpdEQG04=;
	b=kDU9A/nOPV3TIix8EJWyOTPQq3bPRIB4zyt4yd3vs63XVTa1uN3aroxV2q5QcP2te2lc
	 N3d0uu/2F8WDBUlQDYSLXQdYhpTd5oSqCbDaN7Al5BnRS1JazF807MHfhXR+RaSEiVJce
	 /WKUa9GapyXSADlMHVKPQ93/OiOkjTMY7dzw5hgD7T62g57dXFtA0msLFN90suHL9BoMK
	 2WHRkE+KIBU2+lmp4O2ESBge0YnJS5V6eqTYfGuMD6HYJq6iCGTx2or9IJYSszqtUtDST
	 scz3h7bEDzuB8JWV5muunQBMOJr7XGSIn9HNggoWUNjh+9ofAJ2j0ORSeCyJvmvc+Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AbRbKsUy;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FFE606A339;
	Tue, 27 Oct 2026 12:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41FFE606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AbRbKsUy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793104744; x=1824640744;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=odNH/gGAYqnGtAYS7g9TAPVvmYCT7p6MhxBgVqnuSf4=;
  b=AbRbKsUy0kkJDgbNj8C+77dNateoYsXNXI2ij4WbdRGRuIZcC9jLvl25
   Bmw+n8n5Of1TQRL0DizydcA/iPyrd+XxeDvezIXqp2yseKLkYIapi4p/x
   LfW0m9jl2jhiG+efwSNn3BnALmjkqFGd3YDnR9buB/g1orpChgEkSwEkW
   MXRIZvmQamoPXDcfJuXZF9ian0WUMxOJpo8YM1fo5kbSC8m+uZIPkNZxP
   K9BrZTZhId4Hh8TyCgkykufyHa0Ds9K011vXf7JC9Vtdotd2XIYsDzbrm
   zkEdXci/vCNzfJizm4kvqnu/2v/+JluVNerCpU4WAeGFU0W7hJQciR7oU
   A==;
X-CSE-ConnectionGUID: HhUYjB5OQUqUAg47ALa6Mw==
X-CSE-MsgGUID: Re3E1WM3TIm8hctQzni9IQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1804633"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1804633"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 05:39:03 -0700
X-CSE-ConnectionGUID: OLOZxG60TkakwxXbCCvi1w==
X-CSE-MsgGUID: zOOz759LQwuICkEDwQrfSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4879613"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 05:38:54 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Oct 2026 14:38:49 +0200 (EET)
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>
cc: Joshua Rogers <linux@joshua.hu>, Chris Mason <mason@kernel.org>, 
    Josef Bacik <josef@toxicpanda.com>, Tony Lindgren <tony@atomide.com>, 
    Rafael Gago Castano <rgc@hms.se>, Florian Fainelli <f.fainelli@gmail.com>, 
    =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
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
Subject: Re: [PATCH 14/24] serial: 8250: ioc3: store registered line number
 in driver data
In-Reply-To: <20261027-tty-llm-v1-14-99b0202ae546@linuxfoundation.org>
Message-ID: <37ad6cbd-3a66-17d7-4221-3814a9ae7b90@linux.intel.com>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org> <20261027-tty-llm-v1-14-99b0202ae546@linuxfoundation.org>
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

> From: Joshua Rogers <linux@joshua.hu>
> 
> The registered line number returned by serial8250_register_8250_port()
> was stored only in the local variable 'line' and never saved into
> data->line, causing the remove path to always unregister line 0
> instead of the correct port.
> 
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: stable <stable@kernel.org>
> Signed-off-by: Joshua Rogers <linux@joshua.hu>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/serial/8250/8250_ioc3.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_ioc3.c b/drivers/tty/serial/8250/8250_ioc3.c
> index 088242de2eff..3ab50e04be45 100644
> --- a/drivers/tty/serial/8250/8250_ioc3.c
> +++ b/drivers/tty/serial/8250/8250_ioc3.c
> @@ -63,6 +63,7 @@ static int serial8250_ioc3_probe(struct platform_device *pdev)
>  	if (IS_ERR(uport))
>  		return PTR_ERR(uport);
>  
> +	data->line = line;
>  	platform_set_drvdata(pdev, uport);
>  	return 0;
>  }

Eh? Didn't Jiri just kill the entire line madness? In d6a0791098be 
("serial: 8250: make port operations work on struct uart_8250_port"):

-struct ioc3_8250_data {
-       int line;
-};

There's no "line" in the entire file anymore?!

On which commit you're basing these on? How was this tested??? ;-) ...I 
hope you're not just wasting our time by sending unfiltered LLM output to 
us.


-- 
 i.

