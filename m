Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0F11FFC56;
	Mon,  7 Apr 2025 14:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744036495; cv=none; b=nZ0TovukCpcmbWoTEeIpm9yFhMU02V42moI2f6J8kEvFKDXnmDIHRSc/QC/Nohzt4QRnjksf0wutrWJvvUoUNdLbZ+R4x1z+PiSotL/5ZDLqOGfSE9lehWX4MyQa7f7sCxYKfmJ8mrH1oBIp8LnGP0mlpLtMAqjSvMvtJM6A+U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744036495; c=relaxed/simple;
	bh=mPfDokFbtrpEzwu28b96t1De3SwmgWOtlS5X+EEio8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqUr0nghiLZSwI4+dH5OGFAU7tHEs7uknL8WgLnzoZuuz8ZXTHf3OxKTqJGNh+B3gIxK6dVtpV8InwWfj0EPBK69Jjbl8UuPGnR42seiZfLULX/UQzdEWaVXQXR62ct+XZDhVn7r8md3pAAfEFCVvGwpQTcUzlG2BxyY082QhBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TSg4TTXw; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TSg4TTXw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744036494; x=1775572494;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mPfDokFbtrpEzwu28b96t1De3SwmgWOtlS5X+EEio8M=;
  b=TSg4TTXw4H3gtXC3ve2eVNs5LaiWDraLQXyy4K3yMyofspJlWyMihC1e
   NB3Pxe62LqQaB0DsAzM4mGzg/v1JCwASsdEeUpp0bqyjUlZ5tYFpcyyY+
   2Fq8RVLbw/1rkGYqR23LQezwMO4MekHsHzwKWPZb3NU6nfQZD63ZnvzzG
   QZffarAXjS29Y+mRbPehawc04R6gZjoJM4b9m+j167dcedhKUwZ/hnZ1B
   dDdlLGSDZ3IXjsVMzksO3ZV+WO/xj0QpVmPCTEQqWItVPwHvemVgS3Wo1
   p6RgVQNgKWzNgztXSMpLfiJLcnKoQBGcVXVy1QQBnd4ebpECVPOZnyNAz
   g==;
X-CSE-ConnectionGUID: rolpRxQcToa4RIa5Ob2diQ==
X-CSE-MsgGUID: m4D6AP0dRk6Qa5cIR0B5Bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="55615744"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="55615744"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 07:34:54 -0700
X-CSE-ConnectionGUID: pF7tAaSRSCOyGFm9TDhqKw==
X-CSE-MsgGUID: oNznucgdRduhwCI2TsI85Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="132946660"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 07:34:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u1nYk-0000000A63p-3JCB;
	Mon, 07 Apr 2025 17:34:46 +0300
Date: Mon, 7 Apr 2025 17:34:46 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	john.ogness@linutronix.de, pmladek@suse.com, arnd@arndb.de,
	namcao@linutronix.de, benjamin.larsson@genexis.eu,
	schnelle@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [External] Re: [PATCH] serial: 8250: fix panic due to PSLVERR
Message-ID: <Z_PihtUPLNILrnca@smile.fi.intel.com>
References: <20250403090336.16643-1-cuiyunhui@bytedance.com>
 <Z-5yr2mFaDt8kxC-@smile.fi.intel.com>
 <Z-51629pjyiZUIVy@smile.fi.intel.com>
 <CAEEQ3w=xVNuSN-4tHx6ir-i+huN8m1JXgJz672=WHAVBqcP+TA@mail.gmail.com>
 <Z--yqlI0cRnixWpy@smile.fi.intel.com>
 <CAEEQ3wmMymsLZGvomkUth_rczdUaHxeDjCV8Vm6P44RpjVzZQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3wmMymsLZGvomkUth_rczdUaHxeDjCV8Vm6P44RpjVzZQA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 07, 2025 at 09:00:22PM +0800, yunhui cui wrote:
> On Fri, Apr 4, 2025 at 6:21 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Apr 04, 2025 at 10:31:25AM +0800, yunhui cui wrote:
> > > On Thu, Apr 3, 2025 at 7:50 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Thu, Apr 03, 2025 at 02:36:16PM +0300, Andy Shevchenko wrote:
> > > > > On Thu, Apr 03, 2025 at 05:03:36PM +0800, Yunhui Cui wrote:
> > > >
> > > > A couple of more questions here:
> > > > 1) what is the DW IP version and where did you get the PSLVERR_RESP_EN
> > > > parameter from?
> > > > 2) what is the setting of the UART_16550_COMPATIBLE parameter?
> > >
> > > 1): Refer to: https://www.synopsys.com/dw/ipdir.php?c=DW_apb_uart
> >
> > I don't understand this. I asked about version of the IP, I have datasheets
> > already for many of them, I can't find PSLVERR_RESP_EN there, that's why the
> > question.
> 
> You can check the link:
> https://iccircle.com/static/upload/img20240313113905.pdf for the
> relevant introduction.

This is helpful, thank you!

-- 
With Best Regards,
Andy Shevchenko


