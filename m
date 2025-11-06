Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230582BE7A0;
	Thu,  6 Nov 2025 16:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445765; cv=none; b=jLbljy8yzZ8n9Tlazq6FVhF/c5lHZ90C/sRWvAGetek+phf6JoL1VU+srIN7Vno/JcbPHdRgKiVvxW1Y4zC15w5Q2QuS0UOmbYqgxyTKE9yx9cmk4zR0VxpWNFIBpJT9BQU48ahMaCa1Ht1VQSiPHxb68TG5BQQykUZ6nc94RfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445765; c=relaxed/simple;
	bh=b5NjfIh7V82zIt3vw9pQOtHhUVI8qruT0une6EWtqoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooy0M7jLMfLk66xzzmyU/BOLDwJxJeB/4alRlmbzxW4CJqo6ulP7kzZbeUC4nQpkb6+hPdaIc7bIVwPlD9OUka4VcBEK5z2vI8YtsMAaN3HQVcis6+UMIPqrGXa4vNx9lExBIuCJYfgu/jj4J1rRtDf6Db5e/OH7C4qkbcGwdv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cv7qwF+p; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cv7qwF+p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762445763; x=1793981763;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b5NjfIh7V82zIt3vw9pQOtHhUVI8qruT0une6EWtqoY=;
  b=cv7qwF+p6o1FcMSAVD+/yu2pxLn0j7VVzd+3eQxqsbFhAcd6caxf/n7V
   F5KGZSH8jmAv4YlV1Wowe3fUP+/GMukmBaLElPhjoaHJrqvY7hsi4qwDE
   8+bPr40Qq7gE6zzBCnoQ6qCf1hP+BmuoMgNS8g3h4D1XlzOxeLo0G5NFs
   X7j8+XbLmS4voiOKPZl1192BVNPoQCoMfGEB5pBWaiBw6die1qUoOWG7C
   NKIoUUKirexgUO/qPeCFlxEGqfsAoHvl4C+APbN93+pw3Y05fXssZXxXi
   oOLoybXz40EnTyDSTRSSUu4hQ3ks4dJWmtShpTUmniUAhWkjo5mxV4yLp
   g==;
X-CSE-ConnectionGUID: 8e3fr5b6SEG5h4QODbEcIQ==
X-CSE-MsgGUID: rOXeDlqJTs6sMjtqQY4CnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="74878616"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="74878616"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 08:16:03 -0800
X-CSE-ConnectionGUID: aWNAUm6ZTU2V/cYXz90utg==
X-CSE-MsgGUID: gbG672PRScS1mHKnebf/nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="191892276"
Received: from abityuts-desk.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.224])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 08:16:00 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vH2eT-00000006BwL-1sPs;
	Thu, 06 Nov 2025 18:15:57 +0200
Date: Thu, 6 Nov 2025 18:15:57 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Alex Davis <alex47794@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	linux-serial@vger.kernel.org
Subject: Re: [Regression] depmod fails on kernel 6.17.1 rc1
Message-ID: <aQzJveMYT6O3EHeK@smile.fi.intel.com>
References: <CADiockCvM6v+d+UoFZpJSMoLAdpy99_h-hJdzUsdfaWGn3W7-g@mail.gmail.com>
 <20251106160235.GBaQzGm8W2Gt_VMy-s@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106160235.GBaQzGm8W2Gt_VMy-s@fat_crate.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 06, 2025 at 05:02:35PM +0100, Borislav Petkov wrote:
> Lemme add a whole bunch of relevant ppl to Cc.

Thanks!

> So I'm seeing this with an allmodconfig build too:
> 
> depmod: ERROR: Cycle detected: 8250 -> 8250_base -> 8250
> depmod: ERROR: Found 2 modules in dependency cycles!

I'm surprised it took so long to people to start complaining.

So, some of those are modules? Can you share the

	grep 8250 .config

part?

> make[6]: *** [scripts/Makefile.modinst:132: depmod] Error 1
> make[5]: *** [Makefile:1917: modules_install] Error 2
> make[4]: *** [Makefile:2140: run-command] Error 2
> make[3]: *** [debian/rules:66: binary-image] Error 2
> dpkg-buildpackage: error: make -f debian/rules binary subprocess returned exit status 2
> make[2]: *** [scripts/Makefile.package:126: bindeb-pkg] Error 2
> make[1]: *** [/home/amd/kernel/linux/Makefile:1643: bindeb-pkg] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
> 
> That's 6.17.7
> 
> On Sun, Oct 05, 2025 at 09:40:28PM -0400, Alex Davis wrote:
> > When running make modules_install on linux 6.17. with the attached
> > .config, I get the following error:
> > 
> >   DEPMOD  /lib/modules/6.17.1-rc1
> > depmod: ERROR: Cycle detected: 8250 -> 8250_base -> 8250
> > depmod: ERROR: Cycle detected: serial_mctrl_gpio
> > depmod: ERROR: Found 2 modules in dependency cycles!
> > make[2]: *** [scripts/Makefile.modinst:132: depmod] Error 1
> > make[1]: *** [/spare/linux/linux-6.17/Makefile:1917: modules_install] Error 2
> > make: *** [Makefile:248: __sub-make] Error 2
> > 
> > This also happens with 6.17; it does not happen with 6.16.x.

-- 
With Best Regards,
Andy Shevchenko


