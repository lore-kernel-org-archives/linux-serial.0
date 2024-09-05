Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7790119DFB9;
	Thu,  5 Sep 2024 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725545857; cv=none; b=Wl8/wQfk1F/rJixOwlgeeklOpvn5Mab/KdHpVMMOquTBDb3zhuYWdcJVg4XmwSbsZJNgLoZywVXxytCJ6JOL0rJXsStKIiATSAGvnz13AuiMunK1+767rBzQV2LOagle46xY7lQP2L4Vlwf04cyT+xJER2GntismcpFl9ZefTBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725545857; c=relaxed/simple;
	bh=9BBi/Zg7/2x89Qut/E++ANe43rMRcd/lBsTYheptkgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aL+Nz8ayIIiOkSGBaFD04ORC9jZ+oU6OQFpB4sB2EvG3pqrsk+hfzD5maj8zCkYsaGPbgdOTQA9I8/eTcRQ5+QFSMQaTgcdaocKPazqOJV/Ihex8t+DedETwKsK/lm1qlUhV2CGB4xhmObytTTscKDx2oGddCe6nCGlB9jbD1eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nOR8sf8A; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nOR8sf8A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725545856; x=1757081856;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9BBi/Zg7/2x89Qut/E++ANe43rMRcd/lBsTYheptkgs=;
  b=nOR8sf8ATwpW1lND5nAiOR081riXR/QoiF46Sq3UwKA5JzK3FAshvSmC
   PZEtCgcaZPeJJxXXbfrPBizqDUHZTEr5Ej6WpFYAzIgIlS1JdlEqvzXbb
   vMb3kPI6W4Yn6TFgjMWREb8TUEAMZduthUH2wWZU/YkPiNoVXNwBZyC7V
   WvedkiawQLi14T/HfnobtR2b0n68mVyKmLpypQghf5O5GnMHCUtRdnbSA
   sfNe4M5qeEOJhRKmSC2QK3BC9FUaDdmxLZhxoDEN6BG6/1+Whbjgehjtn
   cFAdyUf+hPSC1RU2VNRKIiUOKxkkEV95aZ6lmFdYHUl0mU+m7XjdnISr+
   g==;
X-CSE-ConnectionGUID: k8gV53DwRmG00aQR3d+ScQ==
X-CSE-MsgGUID: I2ilqzF9SbyS/saFYgGKrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="34932186"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="34932186"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 07:17:15 -0700
X-CSE-ConnectionGUID: wiasB9b+Shyr0vLZOviwCA==
X-CSE-MsgGUID: 7sU8rQyCRvCuEC/eBhflXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="65872768"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 07:17:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1smDIH-00000005Q4X-3aq6;
	Thu, 05 Sep 2024 17:17:05 +0300
Date: Thu, 5 Sep 2024 17:17:05 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Derek Barbosa <debarbos@redhat.com>
Subject: Re: [PATCH tty-next v1 0/2] convert 8250 to nbcon
Message-ID: <Ztm9YYFpCDh18u_Q@smile.fi.intel.com>
References: <20240905134719.142554-1-john.ogness@linutronix.de>
 <2024090554-mating-humiliate-292b@gregkh>
 <87cyli2nqo.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cyli2nqo.fsf@jogness.linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Sep 05, 2024 at 04:18:31PM +0206, John Ogness wrote:
> On 2024-09-05, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > On Thu, Sep 05, 2024 at 03:53:17PM +0206, John Ogness wrote:
> >> The recent printk rework introduced a new type of console NBCON
> >> that will perform printing via a dedicated kthread during
> >> normal operation. For times when the kthread is not available
> >> (early boot, panic, reboot/shutdown) the NBCON console will
> >> print directly from the printk() calling context (even if from
> >> NMI).
> >> 
> >> Futher details about NBCON consoles are available here [0].
> >
> > Really?  That link calls them "NOBKL", is that the same thing?
> 
> Sorry. Yes, they are the same thing. It was renamed because NOBKL did
> not look nice.
> 
> NBCON stands for "No BKL Console".

New Brave Console :-)

-- 
With Best Regards,
Andy Shevchenko


