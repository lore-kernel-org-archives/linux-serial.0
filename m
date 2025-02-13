Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E3621325A;
	Thu, 13 Feb 2025 10:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739444264; cv=none; b=a95eu/oCenK0QcxH9Y50CzDc+Zq0CBNCBlVurdNny5bmss+ahHGd9j4YACmTS9ZZTBaWkQbDN1bs4J7qXgWRQo7WkNIYZ17Tnvnc0lNqeZ4mbu/ecLImCktJQkex1C07MQcmIsh1xob8a3Xpwv1I3Hx3WXNIUmZ60xRjC8UfOPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739444264; c=relaxed/simple;
	bh=pyF2QmNloyMOS+ooiXdEaWxfi2Vx+bDKuVx6p+SkU6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYrqCLStKJteLbicCnhD1hWeahrb9TlxDGKMvvN/Oge1nNGF3bPAXtkWywqpw1LvmgoIcbtRHh4K+OnNZHSMh40Oe0GOrWC0tcLuJWzZY9Zt3gSsUZx9NqsFGCJaQIFspB+BKAU0gSSdGJaU/p0jFHNNe7OvoBV62o5yK266yXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ewD05as5; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ewD05as5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739444262; x=1770980262;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pyF2QmNloyMOS+ooiXdEaWxfi2Vx+bDKuVx6p+SkU6c=;
  b=ewD05as5swo7iwL2SqdBFwse7ftzTOb6b7CaO1cXbgNSyeEfkhwfnj1D
   Gy0pqBRwaSpTIOmWmcTgVDAwDG6ahj0lRPnOqdu6NPSzxg/rNnOA/hD92
   lPRYX1FAZx9+hPHbBi5dUTFS2L3+YKsOLdi8YdnxsYSE0mSEt/+b/VdHv
   6w83KXAMUMU4vLgu3l/TTu51bW+z571cOt42RxnlQbFI959u8PPTolpzH
   6EYUPB2Vh/LiGV69uFnrlGPCApNevTfpX9vWJki/+O4xkd4VZHkXWaLZd
   M6cvRAuwobBbiwYgqHeb8iGApwVvTedST6b/fG8pCLDYBVqLi/xrb7RXx
   Q==;
X-CSE-ConnectionGUID: lnH5xp24T1KyGOKkpRfm7w==
X-CSE-MsgGUID: qVNyYJJ8Sr+QUKYke6/7YA==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="57673742"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="57673742"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 02:57:41 -0800
X-CSE-ConnectionGUID: P9Bh1cBQShitd1WRAq7ksg==
X-CSE-MsgGUID: R1RQoslhSjeSCVtbJOXViQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="112974706"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 02:57:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tiWuV-0000000B8kk-0Vn6;
	Thu, 13 Feb 2025 12:57:35 +0200
Date: Thu, 13 Feb 2025 12:57:34 +0200
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
	"schnelle@linux.ibm.com" <schnelle@linux.ibm.com>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] serial: tegra-utc: Add driver for Tegra UART
 Trace Controller (UTC)
Message-ID: <Z63QHvayYRS0U8Ln@smile.fi.intel.com>
References: <20250212104132.61060-1-kkartik@nvidia.com>
 <20250212104132.61060-3-kkartik@nvidia.com>
 <Z6y5vRGyouZsQWyj@smile.fi.intel.com>
 <ec06322386adbf4404e2fbc5d7656e3465eb4320.camel@nvidia.com>
 <Z63Bk6sgQryG1pFK@smile.fi.intel.com>
 <88a54c9bf88dac0a3316224b08d0e2378e8fc6f0.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88a54c9bf88dac0a3316224b08d0e2378e8fc6f0.camel@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 13, 2025 at 10:11:36AM +0000, Kartik Rajput wrote:
> On Thu, 2025-02-13 at 11:55 +0200, andriy.shevchenko@linux.intel.com
> wrote:
> > On Thu, Feb 13, 2025 at 09:05:36AM +0000, Kartik Rajput wrote:
> > > On Wed, 2025-02-12 at 17:09 +0200, Andy Shevchenko wrote:
> > > > On Wed, Feb 12, 2025 at 04:11:32PM +0530, Kartik Rajput wrote:

...

> > > > > +     for (i = 0; i < len; i++) {
> > > > > +             if (!nbcon_enter_unsafe(wctxt))
> > > > > +                     break;
> > > > > +
> > > > > +             read_poll_timeout_atomic(tegra_utc_tx_readl, val,
> > > > > !(val & TEGRA_UTC_FIFO_FULL),
> > > > > +                                      0, USEC_PER_SEC, false,
> > > > > tup,
> > > > > TEGRA_UTC_FIFO_STATUS);
> > > > 
> > > > No error check?
> > > 
> > > I'm not sure about this. The case where the TX FIFO doesn't clear
> > > up,
> > > even after polling for 1 second, is highly unlikely, especially
> > > since
> > > there's no flow control involved here. Even if that did happen,
> > > writing
> > > to the TX FIFO should just result in an overflow, which is probably
> > > acceptable in this scenario.
> > 
> > Perhaps a warning (debug?) message in such a case?
> 
> I would prefer avoiding any prints in this function, as we are writing
> debug messages to the UART HW here.

Not every printf() goes to UART, but to your point the NBCON should solve that
issue to some extent. Of course, if the HW in a broken (unrecoverable) state,
nothing won't help.

> > > > > +             uart_console_write(&tup->port, wctxt->outbuf + i,
> > > > > 1,
> > > > > tegra_utc_console_putchar);
> > > > > +
> > > > > +             if (!nbcon_exit_unsafe(wctxt))
> > > > > +                     break;
> > > > > +     }

-- 
With Best Regards,
Andy Shevchenko


