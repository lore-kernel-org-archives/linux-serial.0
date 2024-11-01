Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F39E4087C;
	Fri,  1 Nov 2024 08:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730449273; cv=none; b=SUHd2iSb/ACdf9Q9P/ne6z/s/xNDEWcknXEVZ4k8avaRyGnno1d2SRKSIhxmkGO16lKDbgV811yI0YezPCCop3iTeONIs/7F/OjaOwBiDPCVTrFWHsu6BpEUj1Y5a6uU27wNkWBk7QrSXcQmDVVMC0aN3n3lD9/gLiax8nuQEfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730449273; c=relaxed/simple;
	bh=eyJwrokSMsPWNQHEJjZgXQVUKoFDYYrFRhHCNZeBKS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJjzx13gr/CakvhtbnnSLqlJx5foDqrvkt/RRGciblbQh6pAULBaKmwdDcTRVojUxBGxibCn23q5ZpKx/BKS1ObxSNc96O3jmaRL/wOB6bLE0pRhxH1WVXJGajvxo8cnd+ZK6lJBIGoblwkRxgZ4G1G+Q1igXVInSlJQRfNk7JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WHbOET3d; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WHbOET3d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730449271; x=1761985271;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eyJwrokSMsPWNQHEJjZgXQVUKoFDYYrFRhHCNZeBKS0=;
  b=WHbOET3dt4eRoSpHJDSbXLnm572W68g6TMVmh3iGih3wfkXk3lGg41nU
   flRUVZx+GSCrRu/xPntvu7eXZnDlZ8WD3V+43AQ15G84a8T8Bz3eVV/Dd
   U81RTGkkKUaHkdBLNGLIU/4LkCBdX831knx7ccFIB4AbLnktG0/WeHiwZ
   bdaLxkz/BXd/jF3rOxHomfPIXyINYACncwkHFZOuCglogmQ+NJXrZeuSr
   ZoVcQgkRk4umFetmC8ox7iWY+IGi+vc/DmQK2eDd6BUB+R4Xt28u9dSHH
   gc9rD6MljV+tx02Cghcg47aSBzpOEbf7A7NX+u+57l0GugVXcntieoP4j
   A==;
X-CSE-ConnectionGUID: ufCoy3GuTA67kDWKCC8GEw==
X-CSE-MsgGUID: RF/KsryoTj6lolHomsvF3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="30427082"
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="30427082"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 01:21:10 -0700
X-CSE-ConnectionGUID: u1mnmM+iTBS0L+Gpvf5ZaA==
X-CSE-MsgGUID: IvApd8t4QEqXkTYXKr/g+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="87440619"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 01:21:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t6mtz-00000009xcs-2cHj;
	Fri, 01 Nov 2024 10:21:03 +0200
Date: Fri, 1 Nov 2024 10:21:03 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: John Ogness <john.ogness@linutronix.de>,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rengarajan S <rengarajan.s@microchip.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Wander Lairson Costa <wander@redhat.com>
Subject: Re: [PATCH tty-next v3 1/6] serial: 8250: Adjust the timeout for
 FIFO mode
Message-ID: <ZySPb5wvuqrQE48l@smile.fi.intel.com>
References: <20241025105728.602310-1-john.ogness@linutronix.de>
 <20241025105728.602310-2-john.ogness@linutronix.de>
 <837a7ecd-be29-4865-9543-cb6f7e7e46e7@kernel.org>
 <alpine.DEB.2.21.2410310349450.40463@angie.orcam.me.uk>
 <84sesclkqx.fsf@jogness.linutronix.de>
 <alpine.DEB.2.21.2411010102150.40463@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2411010102150.40463@angie.orcam.me.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Nov 01, 2024 at 01:24:53AM +0000, Maciej W. Rozycki wrote:
> On Thu, 31 Oct 2024, John Ogness wrote:

>  I don't expect any 550 clone to work in a different manner, but I find
> the TI manual particularly unambiguous and well-written, and also old
> enough for the 550 to be the state of the art rather than just legacy.

Oh, one is living in the ideal world... :-)

-- 
With Best Regards,
Andy Shevchenko


