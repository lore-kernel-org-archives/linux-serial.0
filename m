Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.133.224.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793200211;
	b=RvxUp2Vg5MdI8V6s12P6OxVNEqNxZuJBZnNoM9efLmp9+cdRfoAAj2rakay9zeATZd07
	 00K117WTtIaFN60U5yqhoM7rjjoBBwpUTkBwQEmG+Rif/CcEQVDiJEOVuu/JmNLCQrWLt
	 39ebkZJrWJkw95y0ES/eY4tyyGA2ZxoNFHVXbr8NWoUQDvWynf3gPJ8mQjLaildKeskwA
	 mYCqm3W0ct2TE9uN2n1konuZMIa0bMBCsA3ZeGR3T+bgUZ16JXigY8a6bQ/zBX+ODoKB/
	 7zWmV0NMKh1SapkCD3nkoCQfdl+dJ2n5NUBfyZn7oOUDlucqwBefjsHVwwrh5vLwH9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793200211;
	h=DMARC-Filter:Received:Received:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:User-Agent:MIME-Version:Content-Type;
	bh=it0aWYcxVyMH+Yaw+DOI3m65BoQLOCv36mpGakAjT4I=;
	b=ql4YXSpDQAPUk9ENTQomL1nw/oMLlyAJSMIOYeqOOI3CywE26NDlA7Uy1H7GDmH619M5
	 hrwWlFjqZXAfGy9O0fG4C+DWLf/b3scbPIPeoj3GF5ygBjB+r5RBkQJQpt2anhLaPH3W/
	 8XaPzeNmeqA5aW8zVQHQxVP0MeL4QB34muHdV33rXubrPDKJ22s/9QJDSBZwLPTSe3niH
	 xXlFuH4IcjQlv0y0LDPcz0d4Ri4flPD32jtplZzSYqZwvkiEBHafjmSaj5vEruQGAEqRH
	 kWHRZgh0BMnCbo/8YSUpjpdUaBn+g4GSW7nz0v4aZy59+K+a48rV9MljScrd7L70pMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=orcam.me.uk;
	spf=none smtp.mailfrom=orcam.me.uk;
	arc=none smtp.remote-ip=78.133.224.34
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0073F606A321;
	Wed, 28 Oct 2026 15:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0073F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 72A4A9200B3; Wed, 28 Oct 2026 16:10:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 6ACBA92009E;
	Wed, 28 Oct 2026 15:10:02 +0000 (GMT)
Date: Wed, 28 Oct 2026 15:10:02 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Cameron Williams <cang1@live.co.uk>
cc: Jiri Slaby <jirislaby@kernel.org>, Joshua Rogers <linux@joshua.hu>, 
    Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
    Tony Lindgren <tony@atomide.com>, Rafael Gago Castano <rgc@hms.se>, 
    Florian Fainelli <f.fainelli@gmail.com>, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Peter Hurley <peter@hurleysoftware.com>, 
    Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
    Crescent Hsieh <crescentcy.hsieh@moxa.com>, Frank Li <Frank.Li@nxp.com>, 
    Sherry Sun <sherry.sun@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
    Pengutronix Kernel Team <kernel@pengutronix.de>, 
    Fabio Estevam <festevam@gmail.com>, 
    Manivannan Sadhasivam <mani@kernel.org>, Olof Johansson <olof@lixom.net>, 
    =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
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
    Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org, 
    linux-serial@vger.kernel.org, 
    =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>, 
    Marnix Rijnart <marnix.rijnart@iwell.eu>, stable <stable@kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 11/24] serial: 8250: cap OxSemi Tornado UART count against
 BAR size
In-Reply-To: <GVXPR02MB12019B3EB555B0F744F294A3EC46F2@GVXPR02MB12019.eurprd02.prod.outlook.com>
Message-ID: <alpine.DEB.2.21.2610281437390.42255@angie.orcam.me.uk>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org> <20261027-tty-llm-v1-11-99b0202ae546@linuxfoundation.org> <alpine.DEB.2.21.2610271300480.42255@angie.orcam.me.uk>
 <GVXPR02MB12019B3EB555B0F744F294A3EC46F2@GVXPR02MB12019.eurprd02.prod.outlook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
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

On Wed, 28 Oct 2026, Cameron Williams wrote:

> >   Not sure how this interferes with Brainboxes devices, support for which
> > seems not to have been fully merged given that pci_oxsemi_tornado_p() does
> > not let PCI_VENDOR_ID_INTASHIELD devices through.  Cameron?
> 
> The Oxford cards all work even though not explicitly mentioned in
> pci_oxsemi_tornado_p(). The cards all report 16K for BAR0, so I would assume
> this patch should not cause any issues?

 Thanks for checking.  I got confused: pci_oxsemi_tornado_p() filters 
ENDRUN and OXSEMI devices, and likely should for MAINPINE too, since they 
wildcard-match their device IDs in `pci_serial_quirks', but INTASHIELD 
devices are listed with an individual device ID each and are let through.  
So we're good here after all.

  Maciej
