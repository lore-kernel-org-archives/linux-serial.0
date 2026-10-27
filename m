Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793115542;
	b=Y22GcrmrsMN3E3+1dgoLsuKQpEsW7HaGJFvl4I476AdaitIVgEuRJ3220NwFTLz6tMlp
	 o3diESzhxntO6eAGT70adFP85ZDAN21DKYCTSPr7AYtx1/2sPK0WWGzoXao/pR4q65oeh
	 dJKnq/iSz/gJvllBYNFYJ3ipL8zhlI9+ddJSJc4kzxRhKJCuUIma+rg+oaoh86TbZUbk/
	 VWJiwBIj+eM9rP0rYllcWy/c3n3i9YtCZXcWmOr6Ibz5HtlvpRzFfWO2+xZOpiSfmiyoz
	 cWxdjvx9OggXZmHpvOk6+TWMkpNiEKZG2pDLxHjV83NjY3HJPjMMKuQlsi43MC3ElFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115542;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=3ToaBSGbuB9Yrxbwe7FcW63zAdGOEncBQn32Zjyi4FM=;
	b=06ISBRGWmu/B8iGaHzbFuKMEiOIw5zmLtUkmLF998O6idF8cBa+EFmZjvscXDLQ9jvku
	 IcTnfkc0JYC1Ov2nNs1BFrsuSYVgLDsIJQEtlOriv0tIH3yYU/wolQFRDqxCWKhA2XZd9
	 aU5rRcEZ8vOzITKt2oIbDkijOgUh20MIuphLHzzBFXPkVhlf5A2GCQE20yohQYtJ8S7WU
	 glxdsxBwQcewcND6BYBqV5/fxQxqF00Bp2GjSpjGk4Eg/ON7GlAxaOXSqnuFTr8yQCNGs
	 WjE4AfJ7vLCTMtozJj6hRM3el4YrccEc1CjenBS7bonbQhoyC/tPmFe57CznHvq/pxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bLa3NeJm;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99116606A31F;
	Tue, 27 Oct 2026 15:39:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99116606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bLa3NeJm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793115541; x=1824651541;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=meU6BgcSSiUH529IdptdLUW4Ix7yXSj4DKsK9rgI/Tk=;
  b=bLa3NeJm0fux2aEN7OoxrWguozFQOnnuNMbiILKXZVuJzxC6uK08fbG3
   hBBxUzG2RXISuxsfRRISpK6b+HLh1z/2qDxwLtNqM9XFF5XQh4kqAqRmO
   EhlYzac+s+c+EOBujQuypVZTMg/HHz4Nr79FyB2kD2KNYhlLaUQrtwtWy
   1GzIPOBSrLSAWHC8n1G43Bmj9YyYwvaN5zf69CF+7ZBjhlY8nuUQj6OCn
   4/D9KIZ5rnpbVdx+0+sbuX/+YZ4aoX00kf30bRWtvayyhXlRHCk9F5k+7
   ZPmiPzWUyT6E6F/7I1+KoVFrIvA5z57FJ7cKUyJkKxxiWZHGQ6u5YP01i
   A==;
X-CSE-ConnectionGUID: HGtocSZLTAy3jx2D1KpFlg==
X-CSE-MsgGUID: lH3Stj88SeOx6SuqBBnH5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1818596"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1818596"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 08:38:27 -0700
X-CSE-ConnectionGUID: xN9ZqAOeTEuRkzWbDeg+qw==
X-CSE-MsgGUID: gEq44FMGTVKwxPK166bx4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="6330552"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 08:38:18 -0700
Date: Tue, 27 Oct 2026 17:38:15 +0200
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
	linux-serial@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Danilo Krummrich <dakr@kernel.org>, stable <stable@kernel.org>
Subject: Re: [PATCH 13/24] serial: 8250: dfl: validate MMIO resource size and
 regshift
Message-ID: <auDFZ-XliGAy1An4@ashevche-desk.local>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-13-99b0202ae546@linuxfoundation.org>
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
In-Reply-To: <20261027-tty-llm-v1-13-99b0202ae546@linuxfoundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 27, 2026 at 12:06:39PM +0100, Greg Kroah-Hartman wrote:

> The driver passes the DFL feature's raw MMIO resource to the 8250 core
> without verifying that the resource covers the full UART register
> window.  Add a regshift sanity check and validate that the MMIO resource
> is large enough for 8250 register accesses up to register 7 at the
> configured register spacing and access width.

Same comment as per previous patch. Take the bar size, take all data from FPGA,
validate against given limits.

-- 
With Best Regards,
Andy Shevchenko


