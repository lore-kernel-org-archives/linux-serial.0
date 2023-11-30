Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GxOXH515"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE2493
	for <linux-serial@vger.kernel.org>; Thu, 30 Nov 2023 06:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701355439; x=1732891439;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3guT14zXZgHgtlJbknS7mtsNt8acV2zJJEJZDMIWO5U=;
  b=GxOXH515W7H56heADnIl9NznD60LrHng4DH4gEIP8byGgmt0Ma1Vp347
   Emt+6cKTF3//F+PrFh76psuO4tqCU8UOjdv3z5LtH7ijuUBowo3VlUCdM
   JXYYntYArnVL+K5qXvYmScKuWqOjIteQq3p7GWu7jqWsOdV6+3mh+KKCO
   enJRnryrTtbwd3m/NCfsOYnnjxxP2a1uPC48wzBfcsQM+9PaZy/Vpsujf
   neKvXM8PRrr7pggoJ8J2FR5FKe7fL65uQVWau6ctO3zb713qaP/uVPOuy
   6MmqVQYsavqX070ZwvORQ2DWklAuopyD5QTeVws7utUdKucsZqGipgi41
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="479533908"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="479533908"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 06:43:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="892822837"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="892822837"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 06:43:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1r8iGg-00000000ivX-0CO3;
	Thu, 30 Nov 2023 16:43:54 +0200
Date: Thu, 30 Nov 2023 16:43:53 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Michael C. Pratt" <mcpratt@pm.me>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial <linux-serial@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Wander Lairson Costa <wander@redhat.com>,
	Vamshi Gajjela <vamshigajjela@google.com>
Subject: Re: [PATCH] serial/8250: Set fifo timeout with uart_fifo_timeout()
Message-ID: <ZWifqZVMMmlb1gGD@smile.fi.intel.com>
References: <20231125063552.517-1-mcpratt@pm.me>
 <ZWS-pSDFMh0xx5Bv@smile.fi.intel.com>
 <HPbnILrnlwSUYDSVm3nL_lHYYxueg4aCdoUL3rHZTk3qLuY05GzBCibJS7GBFolJi7Mr4egmTPxjWYt3TGbQ8N9ate8rRvdq31z9BL04sVY=@pm.me>
 <26d2d26-7ead-b62-4636-bb34da636cf0@linux.intel.com>
 <K3H2WOa7QgWaXO0vxUfZ5xkrSQTQ0dGkbXyDUIJMyygCRXENxrhHwuh9sL3pKBVVd0fHH_zT-yaWgAYHjHlqsepWxwZt3IGd5zjcrSrzhIk=@pm.me>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <K3H2WOa7QgWaXO0vxUfZ5xkrSQTQ0dGkbXyDUIJMyygCRXENxrhHwuh9sL3pKBVVd0fHH_zT-yaWgAYHjHlqsepWxwZt3IGd5zjcrSrzhIk=@pm.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Nov 30, 2023 at 09:52:19AM +0000, Michael C. Pratt wrote:
> On Tuesday, November 28th, 2023 at 07:22, Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:

...

> With the pre-git-history git repo from archive.org, I have traced the 
> first instance of the comment ".02 seconds of slop" to Linux 2.1.15.

Side note: Add a remote to the history.git by History group from kernel.org
(it's tag based, but allow you to browse deep to Linux 0.01):

history git://git.kernel.org/pub/scm/linux/kernel/git/history/history.git (fetch)

$ git log --oneline --no-merges 0.10
fa1ec1000cf9 (tag: 0.10) Linux 0.10 (November 11, 1991 ???)
bb441db1a90a Linux-0.01 (September 17, 1991)

-- 
With Best Regards,
Andy Shevchenko


