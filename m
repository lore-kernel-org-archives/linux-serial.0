Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793114601;
	b=eatfjWB3dePjy7I6486OXokyf3K+ZV90uQ32CLhgwJuunXC09DQ/4CQRJAYBw31AhIAO
	 vjXgZZKn1awAbpyl8yjNVsyaiEoxUTUlB754JYQXlR37EUP/PUZKy3FabTBR6tKPa79Bb
	 dAaauuVXILQLBcTF7BEp9eaamglWJyrr5ZlA2kSRdXeVn2OPp/qIn0p9gBvfQWVtRCwBz
	 gs9/CVQHCIGEso6KYLsz1HONtbK0NF3PrwCyXGeYFTzCi0VVqziLf1P1DcsxJT88dbTuC
	 yE+0oLbKwCmmx/lRyKcXnSlOPSpdEBRNRGhGZCaHfATtSPALAOHWymAmnUHjfIjmgDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114601;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=wqTW5eTLzbgYPXbkTuyZQ7p9zaoW2WLVbhLcVYdeqgw=;
	b=YCFSDBXYsTHB5yx8PBf278E3alOIJwW5ubdKqN85ENzBdfISrU9EJtFObQabHcPDe2+m
	 du4rhbSVBs+WQnszQhSQMCJzwKobexLmRVM0TcMVUrBTDrwKnL7INYIWsBWmiJGG6HzVd
	 NO3XJmoFzGZiFwtvehB78QuBxbU51B6KlZrEWmf6LV1aCIq+s14ulr0NHWTXgfpaozjNv
	 gA172oqW4XKW3fsctiYXzt5HMJYbOP5L6/NrUTyU3lAeDDhPrhC+OKKzyUp5oDlJoSPKw
	 JhINnkN5CNYm2BBxcIHJd0xV384LbdKPN+8am1gtur4lvnTpOMHf2/HUFjz8otFj2zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=V8QtwVFd;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BF0606A31D;
	Tue, 27 Oct 2026 15:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31BF0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=V8QtwVFd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793114602; x=1824650602;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QZU9Erid2AbAVbMMs7RGv9CtNwfMoNhnG6Wd1G+COvU=;
  b=V8QtwVFdjeV6GKiglK2ELOLqL+UpZupmTT8zdj3uP624TWjR8dR2R8hP
   h2NOb4evHgZrdfBld8EkkLFvXbu7syD96cBPzIBWcLfPfRtCVgazwPQ/+
   hU15TZ7lcsoUsIJHAYzv9hsXNuonh6KXscBM/bSxJeF63z25kO7cseEvV
   2qY2duHcOmb8JlIByT20Y/Hfn6OoJY/V6YlhKNFmomm69jGYnnlFdUWhc
   cqyvLLipy4dvw2ONpzorkkUvK+N92oZduGLPyl9yaedwuYXbMjFWtTupo
   W/SbEbmZ5TEFLJbXth97/40mlyTggvDoJcrd5lZVA0BLQr5ooXEc2wdqs
   A==;
X-CSE-ConnectionGUID: Qsnr+WJuR6+Ods9ZsK/5WQ==
X-CSE-MsgGUID: YA4zx6c5SPqBWVWpcEsqrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1704143"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1704143"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 08:23:21 -0700
X-CSE-ConnectionGUID: jsJrVQlqReqx45Xefcis2g==
X-CSE-MsgGUID: HrpjYzA9RQWU1oghDg3yEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4534177"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 08:23:11 -0700
Date: Tue, 27 Oct 2026 17:23:09 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Cameron Williams <cang1@live.co.uk>,
	Jiri Slaby <jirislaby@kernel.org>, Joshua Rogers <linux@joshua.hu>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Tony Lindgren <tony@atomide.com>, Rafael Gago Castano <rgc@hms.se>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Peter Hurley <peter@hurleysoftware.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	Frank Li <Frank.Li@nxp.com>, Sherry Sun <sherry.sun@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Olof Johansson <olof@lixom.net>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
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
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Marnix Rijnart <marnix.rijnart@iwell.eu>,
	stable <stable@kernel.org>
Subject: Re: [PATCH 11/24] serial: 8250: cap OxSemi Tornado UART count
 against BAR size
Message-ID: <auDB3QMuEGeNpaIk@ashevche-desk.local>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-11-99b0202ae546@linuxfoundation.org>
 <alpine.DEB.2.21.2610271300480.42255@angie.orcam.me.uk>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2610271300480.42255@angie.orcam.me.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 27, 2026 at 02:29:21PM +0000, Maciej W. Rozycki wrote:
> On Tue, 27 Oct 2026, Greg Kroah-Hartman wrote:
> 
> > pci_oxsemi_tornado_init() reads the UART count from device-controlled
> > BAR0 memory without validation, allowing a malicious device to report up
> > to 255 ports. Cap the device-reported count against what actually fits
> > in the BAR using the Tornado register layout.
> 
>  Hmm, what is "a malicious device" supposed to be, a broken chip?

Carefully reconstructed malicious device in FPGA that gets connected via
Thunderbolt. This is real vector of attacks (assuming the Thunderbolt side is
misconfigured to automatically authorise anything connected to it).

IRL I don't believe it would ever happen as the result of this attack most
likely would be minor if any.

...

> static int pci_oxsemi_tornado_init(struct pci_dev *dev)
> {
> 	u8 __iomem *p;
> 	unsigned long deviceID;
> 	int number_uarts = -ENXIO;

> 	if (!pci_oxsemi_tornado_p(dev) || pci_resource_len(dev, 0) < 8)
> 		return -ENXIO;
> 
> 	p = pci_iomap(dev, 0, 5);

Why not 8 instead of 5?

> 	if (p == NULL)
> 		return -ENOMEM;

This is so interesting... For MMIO it gives a page, I don't see how it can go
outside the boundaries. For port based IO I think it can't be less than 4 for
sure (due to PCI bits to interpret) and most likely can't be less than 8. But
I have a weak memory of PCI specifications.

> 	deviceID = ioread32(p);
> 	/* Tornado device */
> 	if (deviceID == 0x07000200) {
> 		number_uarts = ioread8(p + 4);
> 		pci_dbg(dev, "%d ports detected on %s PCI Express device\n",
> 			number_uarts,
> 			dev->vendor == PCI_VENDOR_ID_ENDRUN ?
> 			"EndRun" : "Oxford");
> 		if (number_uarts < 1)
> 			number_uarts = -ENXIO;
> 	}
> 	pci_iounmap(dev, p);
> 	return number_uarts;
> }
> 
> with the FL_REGION_SZ_CAP flag set for the relevant entries, and possibly 
> setting ->num_ports to 0 too since we need to determine that at run time.
> 
>  Not sure how this interferes with Brainboxes devices, support for which 
> seems not to have been fully merged given that pci_oxsemi_tornado_p() does 
> not let PCI_VENDOR_ID_INTASHIELD devices through.  Cameron?

-- 
With Best Regards,
Andy Shevchenko


