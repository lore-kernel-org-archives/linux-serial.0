Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56BE39936E
	for <linux-serial@vger.kernel.org>; Mon, 20 Apr 2026 18:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776709983; cv=none; b=Vgnk6wZIKEIMFaB+gUbZHzbvwJs+kgafQ+76XIEWCozyMdnQFt3HPbE7DxsUVMImxPqAUEdRyfY/LJjVLoVp94v3jLUJhm/yEg1O9naLBgVnlECyAwsWhWIdTelkhi3jxBxYv+D3HKEGh+KlEyUBU0FPYlfJgTeSh1xAW/u32t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776709983; c=relaxed/simple;
	bh=BmWXmTok3EkRRFF4YUgYMI99odp1jXZQZNNHh5obKsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnmXAovS2JA+4x6zok6RnkMo0dElOihhjYIQTYmf+bOvleAyU3eUBxyoGUhQGBvK2LeE+lAxGOnDL/ykEjcFEqx1VZ4bTt13zoS9z6WAte4866jcSYaEC29jrNClb1/k/9Gnrh4lLNoumu2Pn9yUMkIVPzRK+5W9vIVIR3i0BFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GyhtHc22; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GyhtHc22"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776709982; x=1808245982;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=BmWXmTok3EkRRFF4YUgYMI99odp1jXZQZNNHh5obKsU=;
  b=GyhtHc220MeoiFgP8gi3Trs1nY2c1lp5zT69rQ2MNx9PmA0OkveeJ8UG
   XrX1qNa3yjtWNr3QYsHuQjWrcRUB4e1UwvtnnsB5CbZiPhTbeCMm44ldJ
   pdfEA3VhyPniTWV8NIAYe2u+9exKuNQljtpSjXonqWHg5yJ73QWaWisPG
   oPOTzxoEJr3bq9ndeDY7i1ZrceFZbiKZzGBZAxHyirDsr6jab1Xg938W5
   0l9hqoOMD3FHvvDw+tN/GiUTeLFRsKW7B+yPNWSobMx1s03+GQVh0EaDL
   cdiqMN3tRtt8i8/GIOl/5c12+5zK4UBdpkGNLy/FOIEsLtNnlJTfCiOgV
   g==;
X-CSE-ConnectionGUID: g4Y5kaHaTc+vrgmKWl6yQQ==
X-CSE-MsgGUID: OAzn+vBEQd22xQXsdJYubg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77508490"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="77508490"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 11:33:02 -0700
X-CSE-ConnectionGUID: hHyMxPcmRom2rNUC6sXshw==
X-CSE-MsgGUID: bPt71HRnSyqAi4jCSz/PpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="235808267"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.90])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 11:33:00 -0700
Date: Mon, 20 Apr 2026 21:32:57 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_pci: Consistently define pci_device_ids
 using named initializers
Message-ID: <aeZxWbZJSGHy_C_5@ashevche-desk.local>
References: <20260420175648.1709935-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260420175648.1709935-2-u.kleine-koenig@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 20, 2026 at 07:56:48PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> ... and PCI device helpers.
> 
> The various struct pci_device_id were defined using a mixture of
> initialization by position and by name. Some use the PCI device helpers
> (like PCI_DEVICE and PCI_DEVICE_SUB) and others don't.
> 
> Consistently use named initializers, drop assignments of 0 by position
> for .class and .class_mask and use the PCI device helpers. Also use
> consistent line-breaks and positioning for opening and closing curly
> braces.
> 
> The secret plan is to make struct pci_device_id::driver_data an
> anonymous union (similar to
> https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylibre.com/)
> and that requires named initializers. But it's also a nice cleanup on
> its own.

Can we rather switch to PCI_DEVICE_DATA() and perhaps you would like to have
PCI_DEVICE_SUB_DATA() implemented in the similar way.

This will shorten a lot the lines, the

		PCI_DEVICE_SUB(PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V960,
			       PCI_SUBVENDOR_ID_CONNECT_TECH, PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_232),
		.driver_data = pbn_b1_8_1382400,

to, for example,

		PCI_DEVICE_SUB_DATA(V3, V960, CONNECT_TECH, BH8_232, pbn_b1_8_1382400),

(Yes, in some cases, I guess blacklist mostly, it might require to have a
 common definition in pci_ids.h for both or more drivers. Or something like
 8250_pci_ids.h in the drivers/tty/serial/8250/ if the global one seems too
 much.)

-- 
With Best Regards,
Andy Shevchenko


