Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4691F099B;
	Mon,  7 Apr 2025 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744036640; cv=none; b=dI1r5P1TmAD8jdl4a9C/rUFWWIWrj9nIasa/8Pd9yiaog6nvCRLxz/0rIcY9MqCOmq1RGG97OjbmJCEbYHzhSXGesYeWVB88Lzax9q0E+PzoJ5hA8r8Hw7aofuO/trpItO+uPi4g6goDY5U0RsL6OTQI9Y8jV4fl7rgTuQtAuNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744036640; c=relaxed/simple;
	bh=v4nDRa7lWcmrrI6YZ0FZLDNlAJZzHt+gpJgfHuv74eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZD1mv3MtYKP+wI5aAeYXreDcCIR8Ysow6VeTNPlKmKjW3n3SkQFOh8mxIaQ8+Ly0k6V4nD7R1Jy+WUBu5Tm7/8cC+lxN/rjq0wIDXSPtm320w1QOn1MwT51DRmSl97HMn6CAQzOh3S3Lm+5sNLD9Y52qApri5V+JI5zjKP81APc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IawprRAr; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IawprRAr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744036638; x=1775572638;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=v4nDRa7lWcmrrI6YZ0FZLDNlAJZzHt+gpJgfHuv74eA=;
  b=IawprRArnIKGeCSHfR6ENdLdYIFzpqhiwuKnS7tO4qhoy6YlXFl0sV74
   tR3v+0x/nfVBZcuyKvsI1s1wiJlf/zYvcete6LzL9UHqjqvNJqwaCZsU2
   AAYyv0pPMip4behu/MCwfLePL8oBokxYjl4Pcsr9E4WeIxTxmZ5ix3ObG
   5Gk8wCcpjseQMWMVW7adQfk9BBCj6Z4YF0wu44iVaAVfwUcccsoNSjAVy
   28QvfEUXL5Jlh0F1natnD1cktkghezVBIj4ksoFHAQYUKkxvUijyMerX0
   eI0dkK3TGeY79VY3ABBGGVP9a8lTyKqdABl9US9iYMTlblf7tfU0LRjlr
   w==;
X-CSE-ConnectionGUID: 6OdMghnIQVqtrDHo7R4+aA==
X-CSE-MsgGUID: RqK6fgq0QduiDfDxXrDnnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56406335"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="56406335"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 07:37:18 -0700
X-CSE-ConnectionGUID: p7k5PKY1Tn66D/PlOx035A==
X-CSE-MsgGUID: po8wnZS4SpGQbDmOFodl8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="128305914"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 07:37:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u1nb6-0000000A65i-0dEa;
	Mon, 07 Apr 2025 17:37:12 +0300
Date: Mon, 7 Apr 2025 17:37:11 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	john.ogness@linutronix.de, pmladek@suse.com, arnd@arndb.de,
	namcao@linutronix.de, benjamin.larsson@genexis.eu,
	schnelle@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [External] Re: [PATCH] serial: 8250: fix panic due to PSLVERR
Message-ID: <Z_PjF88N7oAqr-N_@smile.fi.intel.com>
References: <20250403090336.16643-1-cuiyunhui@bytedance.com>
 <Z-5yr2mFaDt8kxC-@smile.fi.intel.com>
 <CAEEQ3wkWmfkq06iyhxs32pyTUp7Mm=UD-dYen_9H5kHnsJe10g@mail.gmail.com>
 <Z--7Wm_erf5U2xMl@smile.fi.intel.com>
 <CAEEQ3w=VVU=5a3VcrSpFXM5fOgWsM+-Y52FUdRK+w2bjr2ypfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3w=VVU=5a3VcrSpFXM5fOgWsM+-Y52FUdRK+w2bjr2ypfw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 07, 2025 at 09:22:08PM +0800, yunhui cui wrote:
> On Fri, Apr 4, 2025 at 6:58 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Apr 04, 2025 at 10:44:09AM +0800, yunhui cui wrote:
> > > On Thu, Apr 3, 2025 at 7:36 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Thu, Apr 03, 2025 at 05:03:36PM +0800, Yunhui Cui wrote:

...

> > > > > To resolve this issue, relevant serial_port_out operations should be
> > > >
> > > > serial_port_out()
> > >
> > > Okay.
> > >
> > > > > placed in a critical section, and UART_RX data should only be read
> > > > > when the UART_LSR DR bit is set.
> > > >
> > > > The last one is made in the common code, are you sure that all supported UARTs
> > > > will be okay with such a change?
> > >
> > > This change enhances code robustness without being intrusive.
> >
> > It is intrusive as it touches the core part affecting basically
> > _all_ of the 8250-based drivers.
> >
> > Yes, it's small, but still it needs to be done carefully with commit message
> > pointing out to the other 8250 datasheets to show that this is _not_ DW
> > specific change.
> 
> serial8250_clear_fifos is already part of the serial8250_do_startup
> process. The purpose of adding it to the critical section is to
> prevent the FIFO from being cleared while the UART is in use.
> 
> Similarly, serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
> 
> It is a correct logic to check if the data is ready before reading,
> which prevents the FIFO from being enabled by other CPUs before
> executing serial_port_in(port, UART_RX).

Yes, I understand what you are doing there, my question is about possible
side-effects on non-DW (non-Synopsys) IPs.

-- 
With Best Regards,
Andy Shevchenko


