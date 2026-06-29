Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D124F3DD50B;
	Mon, 29 Jun 2026 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782746128; cv=none; b=lmjxQmARg9tYzE5a2R25l5z3PIgCYe0b2dzl24ZgDNC1rzDasw5MxTzKUdYHeCShMBr+748t0C7CkYwdhX6QOimSdw4PBsD9e8TLm5LSytlBtPYyBCjfjaLFhLTjbwTq2K3MmgqedjEFDXe7OZ3WSdaQ+mmMXPvqne0FLX/O9R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782746128; c=relaxed/simple;
	bh=3D/bLRtu5swlceavMhcjt3rFJNDysuN3FnLH3kl6/3U=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=g6kUbC/LdqdQgaqHtVtbPWvYNiMdNqtrxNBIRh6/L0AkBXVDuyd5WX1PQW8BtfB1s0pnhhyxZe520E5KoX8c0rK6v+/SnFD9V2QzEZKB4yefqizntlZEk1PSNjLEBhZ5OGpbzXrKS+3iU2Dvda6mejx9Pvrp1VExUBXZ9e7yeEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PxeMZRxI; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PxeMZRxI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782746126; x=1814282126;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3D/bLRtu5swlceavMhcjt3rFJNDysuN3FnLH3kl6/3U=;
  b=PxeMZRxIIYRudmn5zWTGhmYYR71zh3SfW0b9DcAYCK61j1yF8gPIGCwo
   YsX4e3QCYBi6PD9R+DDaV+/syT+OKVTKNMjatWp23QELkUne8coOKTQqC
   7Uucl9scuTkeWaQazqY01nAxDAlT/XMKBV4Tw6ZjWc4IkoSyar5TaBRnZ
   itYPvFY+WLHrcNLHx1bNlGSAzoFQX3s6cEg0vioybpphogE52H9ekGMFP
   /59Nq9KJwfWU+BtmtZAJYKBdiipPv9dDvDKeuPtwYaBAs+x3v3Z3CRavV
   7HZi4boXKTDVi3BF5/uj11kil5/GA4FQNIEfXEwKRD1dGRSD2Q6bSBx6d
   w==;
X-CSE-ConnectionGUID: a1r7MgPdTqGkr/W4GgWCRg==
X-CSE-MsgGUID: yu/hJC+uS7Wj9GrzTZZCWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="94591403"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="94591403"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 08:14:09 -0700
X-CSE-ConnectionGUID: VaF/AHjFS1ebEP/zZGrs+Q==
X-CSE-MsgGUID: zxx4DEP5Tkid2A+3QdOxrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="282055539"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.42])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 08:14:05 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 29 Jun 2026 18:14:02 +0300 (EEST)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: Yicong Yang <yang.yicong@picoheart.com>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, geshijian@picoheart.com, 
    yangyang.8776@picoheart.com, yanligen@picoheart.com
Subject: Re: [PATCH] serial: 8250_dw: Prefer SRBR in bogus RX timeout workaround
 if available
In-Reply-To: <akKHoQOr2Vq9CA1Z@ashevche-desk.local>
Message-ID: <60c05ab5-c805-dd78-1b6b-9c78ee7d7148@linux.intel.com>
References: <20260629075510.32854-1-yang.yicong@picoheart.com> <akKHoQOr2Vq9CA1Z@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 29 Jun 2026, Andy Shevchenko wrote:

> On Mon, Jun 29, 2026 at 03:55:10PM +0800, Yicong Yang wrote:
> > The DW uart could get into the cases where a bogus RX timeout
> > interrupt is asserted but no available data. This could be
> > workaround by doing a bogus read.
> > 
> > Currently the driver's using the standard RBR (receive buffer
> > register) for this bogus read. However the reading of RBR
> > in this case is allowed to raise a hardware error if vendor
> > choose to implement in this way (our platform). It's also
> > allowed to do the bogus read using SRBR (shadow RBR) for
> > workaround which won't raise the hardware error. So change
> > to use the SRBR to workaround the issue if it's available.
> 
> ...
> 
> >  /* Offsets for the DesignWare specific registers */
> > +#define DW_UART_SRBR_0	0x0c /* Shadow Receive Buffer Register */
> 
> Is this a name per DesignWare databook for UART? I mean that _0 part.

They have 16 consecutive registers for it. There isn't underscore in the 
databook but n is apparently part of the name.

-- 
 i.

