Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EAC3B2A0;
	Mon, 27 Oct 2025 12:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761567511; cv=none; b=DuFgXvZNhDSrU7Z5WsD0uXJ+tjcaDTgQbhTcdHd/HnFap3X6dgxlzlczoQ3rwa+G5Kfr/uS2v+9ZmrmdSFLz/D1QlJvCk0+UYdINIAV6cNlEcSXmFzSPVZ67VOOs1KMQgdqzZrPmWmZtV/0X/WuqFP5HkIl4D27DvLXg44XsvCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761567511; c=relaxed/simple;
	bh=jSMUJ01jbQTdHNlkrS59ZHn2Td3oVwfkYwi2NcZNsEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwrYafZ4/rH6K+QZ7CWO82DyP/nELAfhmJfHmjDwGc++0TBqMEKRfDfNaB6+TmYWaI9p9XgRFOEY9AM7F+iN50/9+XeGF/r/41Gxc0px4uO56rAFULzX9LvT1E+5Z/JlpUu5vgfpmk4zUHrE3+hZHjGI6a8LtXvq1SExyUT23nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oFTFSmxE; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oFTFSmxE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761567510; x=1793103510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jSMUJ01jbQTdHNlkrS59ZHn2Td3oVwfkYwi2NcZNsEA=;
  b=oFTFSmxEtQXKe1FiNI8okuy/2hmQKSM22969QmVylj/TpffiEwmSpESg
   VTcKxsmK9nZGk/za8AfN/UIOfAHiM0SN1nEZ4rvNA82da5nN53xS6MPb2
   lvS4GligbwQtYlpaSAe5E1s0TlpS74L3dcGWqtOzhuWZDkdl9RZObr2dO
   w+yGoxq138YjcYQcgkKLBa/7qch/3us3ESSCPgkg9FYH/nr4Bc6bwpk+d
   6RsfCQYiovN3/pjHtMq8hz2etxYYlVa7P7IIk4QXCSWwqNn1JAbQvuV+l
   PNW00GkOTZhVVyra02ubF0O9ZyKFITrhzgxQLWSm5XFaILaCgKwlY1wNv
   g==;
X-CSE-ConnectionGUID: 5EYFriyjQzGCwoF5XWd3Rg==
X-CSE-MsgGUID: CBMB89TwQd2lkaeXhdsbcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62849847"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="62849847"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 05:18:29 -0700
X-CSE-ConnectionGUID: eb6x04A7RBqpukzejRs5zA==
X-CSE-MsgGUID: owMYikzfSlmOIGc7tBU1Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="215680289"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.5])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 05:18:27 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vDMB6-000000030bb-34Gp;
	Mon, 27 Oct 2025 14:18:24 +0200
Date: Mon, 27 Oct 2025 14:18:24 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <parker@finest.io>
Cc: Wilken Gottwalt <wilken.gottwalt@posteo.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH] tty: serial: 8250: exar: fix kernel warning in
 default_setup function
Message-ID: <aP9jEDtIFIzihGYa@smile.fi.intel.com>
References: <aIiDf31HzRBGuMN2@monster.localdomain>
 <2025072929-distant-hardener-0e75@gregkh>
 <20250730130348.082ad53d@posteo.net>
 <aJJ49CSBqGZM_b1Y@smile.fi.intel.com>
 <20250813130629.03832804@posteo.net>
 <20250813091900.7d4e4e89.parker@finest.io>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813091900.7d4e4e89.parker@finest.io>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 13, 2025 at 09:30:47AM -0400, Parker Newman wrote:
> On Wed, 13 Aug 2025 11:06:31 +0000
> Wilken Gottwalt <wilken.gottwalt@posteo.net> wrote:

...

> I can try to get this done in the next few weeks if this makes sense to 
> everyone. I can test the 8250_exar driver and potentially can find a 8250_pci
> based card but I don't think I have access to anything that uses 8250_pci1xxxx.

Dunno if I missed this series, but if not, I think it makes sense to go this way.

-- 
With Best Regards,
Andy Shevchenko


