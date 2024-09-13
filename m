Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3941EEE4;
	Fri, 13 Sep 2024 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726250911; cv=none; b=Gg4K0av/CdEw2xYZ2II4P3LSF2wk1r90jYXUwrTFsslHuf1ML4+C6mGWyIEt/wdRln4xmOo3krB+txXLwhKs16mtHMNFKx+QGS+lJKDdF1ihB5QoKELkYnFBq0zWPo/BxGpSmSW63jOd2BX3sccCm9/lgfTFiEKltivGx9JmG84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726250911; c=relaxed/simple;
	bh=O/vZ0cRpU9sWRzCbTdMKZVE1tsqhfpDq8AQgxRA0/R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSmvL9C8ZeyyUL8s6NV4+H99rOPPy6NHKzpmFqHFJN2WpwkWA1Le6u6lrcrZRbXSHhHBhk5fC3/GOvVzSDq04y6+oqpnfyhYBgyRXlric3YEW/A+hyloZ86m0WwAAZ/smr0HadEgtyOGsAh/jPm9C5iTn5NiEl3VUM6U00a8cA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mG/nKQ4A; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mG/nKQ4A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726250910; x=1757786910;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O/vZ0cRpU9sWRzCbTdMKZVE1tsqhfpDq8AQgxRA0/R4=;
  b=mG/nKQ4AK2Q+FEjdRY2AxCXWs8QuzC1PswGyENJ3TdXUm/yMZZdBHMaf
   XY/VO69Bqw6OVkEnFQt2rRHteWfOaQuu3Q3PDUACUOxmI3ni90xkdnOjZ
   S3B7sbfldr1eAVNGnF5TcSngt1zrZnxQEK5+v84FmLWH0zLkvIdXfU+/f
   HH7G9UMp1/i76POqX2iwiu/uY+SPQxD4V+lTolk4VMbUREjjjc7s1ICWu
   T3dglLet9nbFNVW1erGcJ4n8r/CaE8GDyIN8A07euWZSykB+5MJv7Dphq
   YGrVKvMCo5DKTZmUU+KohWUx9FDk0i8hHjaMgoJ5iofpGtXAfUCKsv7nm
   g==;
X-CSE-ConnectionGUID: SgoAEyaETLGrlSh9QlMQUg==
X-CSE-MsgGUID: SgKmoIcBTyKQMbYTOc7afQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="35737975"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="35737975"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 11:08:30 -0700
X-CSE-ConnectionGUID: nxJqhmyUSJGW4JuW6+khsw==
X-CSE-MsgGUID: N4qcrbGxSKyG45FSdYJmxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="68249324"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 11:08:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1spAiW-00000008NlC-40KI;
	Fri, 13 Sep 2024 21:08:24 +0300
Date: Fri, 13 Sep 2024 21:08:24 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <parker@finest.io>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v1 6/6] serial: 8250_exar: Add select EEPROM_93CX6 in
 Kconfig
Message-ID: <ZuR_mK5LBTOf8SiL@smile.fi.intel.com>
References: <cover.1726237379.git.pnewman@connecttech.com>
 <b6444935804fb0e745d7f374cf2a0c9116a2b3e9.1726237379.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6444935804fb0e745d7f374cf2a0c9116a2b3e9.1726237379.git.pnewman@connecttech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 13, 2024 at 10:55:43AM -0400, Parker Newman wrote:
> From: Parker Newman <pnewman@connecttech.com>
> 
> Add "select EEPROM_93CX6" to config SERIAL_8250_EXAR to ensure
> eeprom_93cx6 driver is also compiled when 8250_exar driver is selected.

This should be done in the patch 4 when you started using the respective APIs.

-- 
With Best Regards,
Andy Shevchenko


