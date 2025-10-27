Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D007C218AD1;
	Mon, 27 Oct 2025 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575618; cv=none; b=NyRhOcnKq7BKIDDmu2W+Fh30cDQ3z0BQxOsMgMdpEGoh7lLbueM27jXN6ISNFzTWyAarMAc82UFwwdIYQQ9xAUR8Ze3rlQbiQw1LtrB2rDhetDX/OLqkTa40l2jwb6xmoxhxlochcBn7yBe1PZZGbKxKOAnVSLaGp+7Ste+XiOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575618; c=relaxed/simple;
	bh=bMc3esueoQ5qBWht/5IT5nVMT2CBMHmUBOS1ilHRCzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVB0TmRYMKeXoEDcuM8Zkev4PlkiusQ91PbibZ2UWTZ7ze2v1vzufXyBxiareWknudhAUxGNyqe8Wus5c8FbgXX7c7vsEVS/SSocdf76DitHww/YVpNk43SpJwQVp9n83DBX2cBzfIxIAbAkDlB+hZRv/rlxUH713Fsl+L1SYjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RUaRuVcA; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RUaRuVcA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761575616; x=1793111616;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bMc3esueoQ5qBWht/5IT5nVMT2CBMHmUBOS1ilHRCzY=;
  b=RUaRuVcAZ9dZljkodgKscPPmlpZc9iQ1qqPA5MeJ/nbfKG6zYdp2N5dO
   6J/bEtOyxnfLX2Sp1FBtFckHpk/SSDCfjxOgDNNCG5bodjTo81bKgnqlH
   +G/4DEKRn5hyJivrgiNkOfW/V8XNxM4MbC6n8eb100VJoDZfSg+ZcU9Qn
   dXuDO2QQ425zBdEX4TctiaEEQw+RbP76i0I2sywdFPaSxUclFtW6n/Syg
   DgjCisLd2N/ZH0vjIGJVh+AYcWtouO3BOqUdLbGW05lylrBimKrKAlNot
   pH8yOYUcEZtj68+I6EDhVsEs2Y8eKd8tiUjGuY1SeRp1EpxpHWNoeTcsb
   A==;
X-CSE-ConnectionGUID: Qb09Y7CRTISuIL1alWibYw==
X-CSE-MsgGUID: Fz1BpY09Ssa6NLki/EFkeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63561998"
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="63561998"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 07:33:36 -0700
X-CSE-ConnectionGUID: 4Wo957xSQiSqxLWcvSkKTA==
X-CSE-MsgGUID: a4XnVK2bSmOoMyS1BaAAiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="208672436"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.5])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 07:33:35 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vDOHr-000000032Mw-4985;
	Mon, 27 Oct 2025 16:33:31 +0200
Date: Mon, 27 Oct 2025 16:33:31 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <pnewman@connecttech.com>
Cc: Parker Newman <parker@finest.io>,
	Wilken Gottwalt <wilken.gottwalt@posteo.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] tty: serial: 8250: exar: fix kernel warning in
 default_setup function
Message-ID: <aP-Cu09U2bann0Ck@smile.fi.intel.com>
References: <aIiDf31HzRBGuMN2@monster.localdomain>
 <2025072929-distant-hardener-0e75@gregkh>
 <20250730130348.082ad53d@posteo.net>
 <aJJ49CSBqGZM_b1Y@smile.fi.intel.com>
 <20250813130629.03832804@posteo.net>
 <20250813091900.7d4e4e89.parker@finest.io>
 <aP9jEDtIFIzihGYa@smile.fi.intel.com>
 <QB1PPF121146BA5CAAA303D604C459B01F0BFFCA@QB1PPF121146BA5.CANPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <QB1PPF121146BA5CAAA303D604C459B01F0BFFCA@QB1PPF121146BA5.CANPRD01.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 27, 2025 at 12:31:21PM +0000, Parker Newman wrote:
> Hi Andy,
> Florian ended up implementing this fix in this patch before I had a chance to look at it: 
> https://lore.kernel.org/linux-serial/20250930072743.791580-1-fe@dev.tdt.de/
> 

Right, but refactoring as you suggested may also be welcome!

> This issue should be solved 😊.

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com> 
> Sent: October 27, 2025 8:18 AM

> On Wed, Aug 13, 2025 at 09:30:47AM -0400, Parker Newman wrote:
> > On Wed, 13 Aug 2025 11:06:31 +0000
> > Wilken Gottwalt <wilken.gottwalt@posteo.net> wrote:

...

> > I can try to get this done in the next few weeks if this makes sense 
> > to everyone. I can test the 8250_exar driver and potentially can find 
> > a 8250_pci based card but I don't think I have access to anything that uses 8250_pci1xxxx.
> 
> Dunno if I missed this series, but if not, I think it makes sense to go this way.

-- 
With Best Regards,
Andy Shevchenko


