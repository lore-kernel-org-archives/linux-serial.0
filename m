Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C961BEF87;
	Fri,  4 Apr 2025 10:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743764323; cv=none; b=ma0r8uGLQlYyr9sAtHv+jqiqfWucoYzNhkWQy98k1TUNDQ4qp67YIAPfXQhj0DVdrWBUlPG1BI/NnH1TwZmiyCbbOuF8AczB6UmypwO4fGWihVQHaXu2+fs5Lri4n6XNKEAD9+zyK/1KDxM8o9JxhIBTRoT5WZZo4O357WbV/6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743764323; c=relaxed/simple;
	bh=29c4vSaKSvPKhmpFz7QIBmh4VQjlG7FqFr9hBMYD4o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4jYB3dWT9yqryosvKq/+i8Xdjugl9UgXpnOw4/yA86mVdpGLeRMdRw3DHGnW900K8b1/raQtw5774QrVeYveqkoRWkzaZNSGkh5dPNT4JMS7TYVAtPgdTpW8G7PiD91LTjRq2TnfKvm229XLPj6EzyjNz0vjC3vxzDnalrBYn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cj6F314W; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cj6F314W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743764322; x=1775300322;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=29c4vSaKSvPKhmpFz7QIBmh4VQjlG7FqFr9hBMYD4o4=;
  b=Cj6F314WKTCw4/2vzH0S/Xjbiaj3p7kTmvK6SrZpxP+JeDIM8ipuLeWK
   M2HHQ+r1xQJ+q7Rtc4QGZpXCuAoepwIPArjGzgEleK/9WhJezMfbBT3Wb
   D+/wISt31xc3+Zr+9t5C9i/9yeRsrvHk2tTilF0aw99hMuMB9Etp5w3No
   iWW9DO3V8Hr9GEb6q5eC3fKOnqSs1qqC5yTnN0OQ3Sq7SE7IhTghiNfnI
   D0iDvU+FtL3OSK7PZu2/+tLHaM6UnfWfObYmtaQ1WZuXducZ7hVb/CayK
   FAQAQxsjvwEyZVMryRl4l5zsQfxD9eUsJoLMRevjxmh86HQbUkVseRZx0
   A==;
X-CSE-ConnectionGUID: asJmgpF1ReaUNUiKqbxruQ==
X-CSE-MsgGUID: YREFAv6dTbC/QWqhCA5d9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="45340399"
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="45340399"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 03:58:41 -0700
X-CSE-ConnectionGUID: J2cMLxjEQwm59K7unQAKbA==
X-CSE-MsgGUID: 4LY1BBZSQfuxy7nPFwCyOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="132137250"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 03:58:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u0ekt-000000096iP-0isf;
	Fri, 04 Apr 2025 13:58:35 +0300
Date: Fri, 4 Apr 2025 13:58:34 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	john.ogness@linutronix.de, pmladek@suse.com, arnd@arndb.de,
	namcao@linutronix.de, benjamin.larsson@genexis.eu,
	schnelle@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [External] Re: [PATCH] serial: 8250: fix panic due to PSLVERR
Message-ID: <Z--7Wm_erf5U2xMl@smile.fi.intel.com>
References: <20250403090336.16643-1-cuiyunhui@bytedance.com>
 <Z-5yr2mFaDt8kxC-@smile.fi.intel.com>
 <CAEEQ3wkWmfkq06iyhxs32pyTUp7Mm=UD-dYen_9H5kHnsJe10g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3wkWmfkq06iyhxs32pyTUp7Mm=UD-dYen_9H5kHnsJe10g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 04, 2025 at 10:44:09AM +0800, yunhui cui wrote:
> On Thu, Apr 3, 2025 at 7:36 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Apr 03, 2025 at 05:03:36PM +0800, Yunhui Cui wrote:

...

> > > To resolve this issue, relevant serial_port_out operations should be
> >
> > serial_port_out()
> 
> Okay.
> 
> >
> > > placed in a critical section, and UART_RX data should only be read
> > > when the UART_LSR DR bit is set.
> >
> > The last one is made in the common code, are you sure that all supported UARTs
> > will be okay with such a change?
> 
> This change enhances code robustness without being intrusive.

It is intrusive as it touches the core part affecting basically
_all_ of the 8250-based drivers.

Yes, it's small, but still it needs to be done carefully with commit message
pointing out to the other 8250 datasheets to show that this is _not_ DW
specific change.

...

> > > Panic message:
> >
> > Please, read this
> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-messages
> > and act accordingly.
> 
> Okay, I'll update the next version to follow the guideline: 'Avoid
> directly copying full dmesg output (e.g., timestamps, registers, and
> stack dumps); instead, extract the critical call chain.'

and make it short, e.g. ~3-5 lines only.

-- 
With Best Regards,
Andy Shevchenko


