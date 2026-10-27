Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793114035;
	b=aL8S/i7A8o91JrYPz3MJzY47HaV0wfDRpgxoIClKl6D6km8jLN34nSo+JyAp+r47vbe3
	 Qbytrdl7AY6vvzb8yFylqdL/o8PmBe5aKsl1+psgZS0zWO6NDxMC/NZy6/UPHHYxyur7t
	 LN1TzVZ9NdRWiqN4h34U9NFwl+SWiJTIXLLNs7/A5A96upedCcDVKZBYgdXnVOajugc0o
	 qlVpdbEzmWI4Wff0LFloaqDQA2MyX52OZ/ciOC6ZGDGALTAqyLwKqjgwWuu3+v656dSDo
	 E5Fqb8RFq4mPn4S8du4x+jAc5dv/2u7x9mrVz2jAgGVlXrGNNcpfXxyp+QpOO0Vnriw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114035;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=TYOVvhZyaUbVZFgAIc/egQ1z+khkcesoyhUa579dsZ8=;
	b=JmZ4h6P/1eN5rPIc4sqV4LWaqY7w6Ufx0dgjKujmJl3CKk+Zg1o4zvEOsZUe0pfzuHSC
	 OIb2ua+36cWvp0hrLKUu9uYlPFWMs11ZIlawj7Mxk1k4ysqx21nXAfgRjHZlbCl4EDzhc
	 V5PlTApJGBEUUQmnxCue+7xrV13O2+i8SnWQtpnT6gmP/IhAHl5uuHicrn4GeHvux8ioz
	 AAjJkVI7DcmlLwuARyRX2JVn6s395FeOxiTTYEFdyEsnj0cyzCzpjnSE9Eco2eb56Xixj
	 qMMcsWWTOUTzvtY6mxlpabUhO43NNQpagwkIwEw15hb8zjJXWtv4rTTzqg6CNR/NKBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bU2jy0ce;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846E2606A31F;
	Tue, 27 Oct 2026 15:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 846E2606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bU2jy0ce
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793114035; x=1824650035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nRi+oew+ldnegelRFFSjs3YHGuqmu3x5mEIberG1vWs=;
  b=bU2jy0cePFOrDtJQq2Vp9gSku8uNQ6r5TH5HbpTPbG+QYH8qRkhCuvEy
   aZeBR3bSo9KN7tjZVk8/Ju1KMGEbJQAxOuE7rk84Ct8N33Q6MR2qS3Qll
   PjZeEEV5WhfeqRwk9k9+6N9vSIbo14JNW2ZnG1qP+zSkKlRkkPHjLaSbZ
   64pxFBN13Oh+dgcjLgJffRxjaLAmLs7OarVDwv91/BJcnoNIRv5DDbgs5
   TJHoD7FysUYbP+NCUHTUK0oR0ocfMBY28W3+DWUHvDINNO0lr0ngyY1eF
   luHOXMw04uhd7vz/qBioAyfpQJCfzPBn51z+BPFQfh1FCCUw36+T8S3QR
   A==;
X-CSE-ConnectionGUID: fqo/QmdUR8+2daesaCIIpQ==
X-CSE-MsgGUID: 6hYJEHNdRpyP9+S7llsr+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1829010"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1829010"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 08:13:54 -0700
X-CSE-ConnectionGUID: kh/UND/zTOijhbG1BjDaRQ==
X-CSE-MsgGUID: KbuS6scPQWKi92eahLZ93A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4608083"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 08:13:46 -0700
Date: Tue, 27 Oct 2026 17:13:44 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Joshua Rogers <linux@joshua.hu>,
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
	linux-serial@vger.kernel.org, stable <stable@kernel.org>
Subject: Re: [PATCH 10/24] serial: 8250: pericom: validate port offset
 against BAR length
Message-ID: <auC_qCiP6qQtlLMq@ashevche-desk.local>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-10-99b0202ae546@linuxfoundation.org>
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
In-Reply-To: <20261027-tty-llm-v1-10-99b0202ae546@linuxfoundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 27, 2026 at 12:06:36PM +0100, Greg Kroah-Hartman wrote:
> 
> The fourth port on 4-port Pericom devices uses offset 0x38 instead of
> the linear 0x18, but maxnr is computed assuming uniform 8-byte spacing.
> A malicious PCI device with an undersized BAR could cause I/O access
> outside the assigned resource. Check that offset + 8 fits within the BAR
> before registering each port.

...

>  		unsigned int offset = (i == 3 && nr == 4) ? 0x38 : i * 0x8;
>  
> +		if (offset + 8 > pci_resource_len(pdev, bar))

For the consistency's sake 0x8?

> +			break;
> +
>  		uart.port.iobase = pci_resource_start(pdev, bar) + offset;

-- 
With Best Regards,
Andy Shevchenko


