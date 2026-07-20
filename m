Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB49449B0A;
	Mon, 20 Jul 2026 19:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576224; cv=none; b=Vv/h7TwxdIqAB6T7FduhBiu/vqUL4Dfq7/2Xd+zw6LXyeD2LQZu4zUljcTZ7LkSkwktpH+5QIQo5UdrS1W1Y3SFKfE/AKtaVqx+cU8+OHoKeLVQz6k6X6k2YsXNky4+C0Rqgh0ueTlCmda4U7JvAzBmhoIm6KnicUgSXFSjpr3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576224; c=relaxed/simple;
	bh=PC9JMkkzzrir5NNFvL6kl3BHBcC2cb77FOM8GCxVYXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hI5k7OjSJ6TKd+P4ziwalIbUWbixeOfJV6a8xW+FrZb/ArC+3NezuZOzN66jHzrWuUmWzx4/Wdp5gPUJCCdJKpU+nFAcpZDyLbBhJ7dyZ0EmKW4exjW7W3tt965Wht5FgH/bISHdONhbZlIKGV3aKdoRlvvdZiAfH6K1R7ZDx5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XVFDfMeD; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XVFDfMeD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784576223; x=1816112223;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PC9JMkkzzrir5NNFvL6kl3BHBcC2cb77FOM8GCxVYXU=;
  b=XVFDfMeD4e7XnOwrZs9PDcOPDFgWuHfh7uOEZJjMvlLG6hvPbWXXCKOw
   iXEOJic6xV3iLZEYbQzD4w4UxnrxF02RevoNvZjL3ENkdy8GTg1dejWw3
   GgOO+diB9T+GiuY8NVVrU3Zum8HSSURv78tvGzDVz0cMnm+HV0azTlgws
   3dbAtCXtL4FWGTuVyXpRyEB6UyH5oTepZvbKhtbBJFDryznxullVf2OWM
   H+eQu3vYZ745Xb3aJQz+UIMnOcZO/J6lwnjg3RAJmVy+7rVXB3dwDSMM0
   SWCZ447dO7dgidIURUzzNgQJqDVDA/oNNhMITqSf0w34F8HDSadoo4/KB
   g==;
X-CSE-ConnectionGUID: XmruqR41S+OEcEEowel0DA==
X-CSE-MsgGUID: MBHfjIT3R9GijkBJ+IZsnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="96679074"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="96679074"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 12:37:03 -0700
X-CSE-ConnectionGUID: FOV9C/4RRiWF+17O29kzuQ==
X-CSE-MsgGUID: pm+61YkURKeZV0xcxfxZ6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="295758801"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.175])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 12:37:01 -0700
Date: Mon, 20 Jul 2026 22:36:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: fix compile error with hub6_match_port()
 when compiled as a module
Message-ID: <al542h_1frk-XTZf@ashevche-desk.local>
References: <20260715153707.4181828-1-hugo@hugovil.com>
 <al5yTxizfIGibYZa@black.igk.intel.com>
 <20260720151140.70939799547c922b09670014@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720151140.70939799547c922b09670014@hugovil.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 20, 2026 at 03:11:40PM -0400, Hugo Villeneuve wrote:
> On Mon, 20 Jul 2026 21:09:03 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Wed, Jul 15, 2026 at 11:37:05AM -0400, Hugo Villeneuve wrote:

...

> > > +#include <linux/kconfig.h>
> > 
> > It's special header. It is always-included one, and hence here is a dup, please
> > drop this line.
> 
> Will do. I will also remove the one in max310x.c which was added by...
> me :)

Yes, please. You can find the similar dropping changes in the lore archive from
the last week, I sent a few. There is a pointer to the commit that makes that
possible.

-- 
With Best Regards,
Andy Shevchenko


