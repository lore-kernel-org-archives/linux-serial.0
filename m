Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4BC1AF0B7;
	Wed, 29 Jan 2025 10:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738145527; cv=none; b=shnPFBJv1rRNvx+jdza7KvbHUHbLjoNnzPypXgnfcitjmQfrwaau0IPOaTgRFPeKZ/5jwGiZJaKk2xyatFPkovweMZeHLI2hsxF1brWvDVQiNVV57i9aYGfwE6+muIMUzfVvtVhXlzwLEUD0biHCF9dcD7qtm4BkVQLJGYZpGsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738145527; c=relaxed/simple;
	bh=lwpO7PNCaMK4XSaIdcUENjOc29JySu1q3MC0ZNh/nD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tS0hflieKj8I165OcYNqpHLWuVbVpqBM2L02PwjE3WAF+kz5DfG6BFFJPmCYRcRJbhPOgihG0HD22Oxv8Rz7QOrCoRD1RA6A3GeG+ZHEbp+S9kcYfzZRseWWUyvBTeXBf4/2jBFuE0Nesb01TuaoU1bD+Lm52PKRs36bIJUPWcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gd0sseaZ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gd0sseaZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738145526; x=1769681526;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lwpO7PNCaMK4XSaIdcUENjOc29JySu1q3MC0ZNh/nD8=;
  b=gd0sseaZyuFHpQTMnjgphQHuGt5xDjl5Md9PWlTwpHGexfxK7gryShxb
   h/UaRCyK8vhbGS9+cZZKCZ80heOm+94RTKyKtA3F+LHdRZFavhf03LICc
   AKwuqWuIlbjPH0i+mpMNBxeneel7Gfyv8wx+hFk0BsOsk/luf/ETvnPa5
   hq5NOSv18BjPzP0A66rHZtLvdXLVHbn+Ydx7syC6+d96ivYKPdRjv4CEQ
   FnemLwcoTO7s+7DMC39gCph8bXGfiXwhqz7d+JA8sbdcXhqr+3tuA2v6v
   Z0nJ2aBjTvobzrCXKWhKGYYmAMjNY8w9ZqJaSVqNqliD1x413fS0ns0gN
   A==;
X-CSE-ConnectionGUID: Bzt5D8ZrRQKOod3vOeUcxQ==
X-CSE-MsgGUID: 8X00qrU7SdeVA4ecuuG9gw==
X-IronPort-AV: E=McAfee;i="6700,10204,11329"; a="38559410"
X-IronPort-AV: E=Sophos;i="6.13,243,1732608000"; 
   d="scan'208";a="38559410"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 02:12:05 -0800
X-CSE-ConnectionGUID: irVLMjNnSriAwxDXwVV8cw==
X-CSE-MsgGUID: q/vBOH0pRrOMhulNU5EtPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,243,1732608000"; 
   d="scan'208";a="114018129"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 02:11:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1td535-00000006LKG-2oWb;
	Wed, 29 Jan 2025 12:11:55 +0200
Date: Wed, 29 Jan 2025 12:11:55 +0200
From: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
To: Kartik Rajput <kkartik@nvidia.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, "robh@kernel.org" <robh@kernel.org>,
	"robert.marko@sartura.hr" <robert.marko@sartura.hr>,
	"arnd@kernel.org" <arnd@kernel.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"hvilleneuve@dimonoff.com" <hvilleneuve@dimonoff.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"schnelle@linux.ibm.com" <schnelle@linux.ibm.com>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 2/2] serial: tegra-utc: Add driver for Tegra UART Trace
 Controller (UTC)
Message-ID: <Z5n-6z6SOSZy-BMW@smile.fi.intel.com>
References: <20250128064633.12381-1-kkartik@nvidia.com>
 <20250128064633.12381-3-kkartik@nvidia.com>
 <Z5nTm9UniwCgGNOY@smile.fi.intel.com>
 <101d68c9789ef774c242d038a51b35113e6fbcc0.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <101d68c9789ef774c242d038a51b35113e6fbcc0.camel@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jan 29, 2025 at 08:04:27AM +0000, Kartik Rajput wrote:
> On Wed, 2025-01-29 at 09:07 +0200, Andy Shevchenko wrote:
> > On Tue, Jan 28, 2025 at 12:16:33PM +0530, Kartik Rajput wrote:

...

> > > +     ret = of_property_read_u32(np, "current-speed", &tup-
> > > >baudrate);
> > 
> > Why not clock-frequency? But if needed, add this to the above
> > mentioned API as
> > I know more than one driver may utilise this.
> 
> "current-speed" is to specify the baudrate at which the UTC is
> operating. Not sure if "clock-frequency" is the ideal property for this
> as we are not configuring any clocks in the driver.

I didn't say anything about configuring clocks. The clock-frequency property is
standard way to provide a functional frequency of the UART (usually some MHz
crystal) which you can divide by the known HW coefficients and get the baud rate
(but yes, I agree that this is HW-dependent and needs to be thought through).

> Also, to add this in uart_read_port_properties() would require updating
> uart_port stucture to store the baudrate value. Would this be fine?

Sure, it requires some members to be defined beforehand.

> Asking because I do not see termios related configurations stored in
> uart_port structure.

Yeah, the only one is uartclk. But again, if you need current-speed to be
parsed, consider doing this in the uart_read_port_properties() and saving
as uartclk in the known way.
Technically it's possible to add a new member to uart_port, but it has
a lot of downsides as I can see: additional memory, added ambiguity to
how parse uartclk and current speed if they both are defined.

-- 
With Best Regards,
Andy Shevchenko


