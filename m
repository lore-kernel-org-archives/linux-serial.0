Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795084178;
	b=ygPIQLmYgREJ4anj6t4V+DceJJxHrvzkaCXMMO6pUQ6X9Uc1a44lEIO9vVkOBREE8FSA
	 nD6L4hunupiW0BdQkr0Y048gHnaRDGcxl88VmDh8ntrBeXLr17lrZBRIU6rBJHfaGMb+U
	 BHFA6RP0O41ofFWfS2AKtYHOUJveBdPj/Az7Gt68ibnI8qt0PoKyhGC4ambXjgbZLRpxC
	 XEOsUaS7LMAYm373sNg6dX/I28D2KfY6gXL51AxtfBHrSORqianLw+dz2Y5ZN9ybfCTPG
	 uEOpgty9ZRpZId0QWgSqsVB/BNFKVEPr48QCZ3sE713fc4VVtG4VbdFMu9dsdjovxdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795084178;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=dUSNnRZL1irG1RiGj+Z8r6wLhmGb7tyTO4JuEMlYrRU=;
	b=WUD4W1XaaLi6u7apk55AImUWf7/U1AJ2HJNYjml1s4aC3+n72oMo1PsKuyvIaHqiTTVl
	 y1mngfIrGfjebwrK3tiqA+XwJi/avC1lwrFBrLIWDazXtfrZ6S3OCOOJUVzQBYjHTZ/vT
	 y1nTWWvCqClRokjLVMXTga+pHpJRbzQVF09PaT3scssRprmzK5YAEAVnZ5dy8ZeIf0myA
	 D3b2pULpZ4agxzataMkOybk/2fLLwUjO1hYdE88771XN4B/N2X0ieA69PRnrGRZXOoR7S
	 FfdOAPDj2A2qkZOSzD7mPIN2WS4f/2B+VI6ooMPD1IM0qkNiUfEQQEzxvYTe0yEjGEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QeuDAEbS;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8F5606A320;
	Thu, 19 Nov 2026 10:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F8F5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QeuDAEbS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795084178; x=1826620178;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xlfDxzEZtd4xvDMcGxhAWOaHGccCW55yOUxKu6tohL8=;
  b=QeuDAEbSuLO6EWoFuRe2puh6/eY+kmGhp9/yDankziOetgZHgNWqAuZ0
   i/3jGi3nWhlsL61pMyokZ7mRHxmL0mbfgpW6//zHXnuwxlGjwAAdw51jV
   Pju/kysFAOB0gEPqT7V4feK9vInXv1HFs5Gsa6nSCMXexQBZazTPZRfAL
   KgPsW7+sGqzXBR3LvLlMs8ZBm+APwFpOkkWNRvtvV4kmPwiHtS4DcPUen
   prA2Hg/YS1gSSZSi6fZ4xpdjIblfHxhxPMIFKcgj/YnkyNIQJt5JXXazB
   QpGB1QjEGrMxxMpx7++HrnfAXdAdpHXu93CI/lnL3AA4UMvbabWteEsEc
   g==;
X-CSE-ConnectionGUID: pWRcAB8HSqGznSPW+usWsA==
X-CSE-MsgGUID: ZUHAY4G7RVG80gWG99Y7hQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3847465"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3847465"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 02:29:38 -0800
X-CSE-ConnectionGUID: 0nWMvIVPTG64FSxYgTh2vw==
X-CSE-MsgGUID: hH96snwBTV6ImwKrhzd1ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="12355092"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 02:29:35 -0800
Date: Thu, 19 Nov 2026 12:29:32 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Dan Williams <djbw@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	dmaengine@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v10 4/7] dmaengine: dw: use virt-dma for descriptor and
 callback ownership
Message-ID: <av7PjEXWiWpp1LR6@ashevche-desk.local>
References: <20261119-submit-dw-dma-synchronize-v1-v10-0-3a737597a0d1@gmail.com>
 <20261119-submit-dw-dma-synchronize-v1-v10-4-3a737597a0d1@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119-submit-dw-dma-synchronize-v1-v10-4-3a737597a0d1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 19, 2026 at 03:01:38AM -0700, James Hilliard wrote:
> The status getter can invoke a client's completion callback while polling
> the hardware. An 8250 RX timeout calls it with the port lock held, and the
> callback takes that same lock. Termination also lacks a synchronization
> hook to wait for callbacks already detached from the channel's queues.
> 
> Use virt-dma for transaction queues, cookie completion and callback
> delivery. Keep the active transaction and hardware state under vc.lock.
> Polling still processes RAW.XFER and advances software-LLP blocks, so
> clients such as catpt can complete transfers with the controller interrupt
> masked. Client callbacks run only from the per-channel virt-dma tasklet.
> 
> An 8250 RX timeout consumes the transfer length minus the reported
> residue. On a bus error, source reads do not establish how many bytes
> reached the destination. Credit only whole blocks whose completion the
> driver observed while advancing a software-linked transfer. For a
> hardware-linked transfer, treat the whole buffer as unconfirmed.
> 
> Report the abort and the same residue to result callbacks and status
> pollers, even after another transfer completes. Reserve the error record
> during preparation, when clients can still handle allocation failure.
> Use the normal virt-dma submission path; neither submission nor fault
> reporting needs to allocate. Keep only failed cookies after descriptor
> release, until the cookie is reused or the channel is released.
> 
> Submit only the first block of each transaction to virt-dma. Its child
> LLIs remain on the driver's hardware-chain list and are freed together
> after the callback returns. Keep the controller tasklet for hardware
> event processing and error recovery.
> 
> Complete cookies under vc.lock before handing descriptors to the callback
> tasklet. Complete terminated cookies in submission order without invoking
> their callbacks, so a concurrent termination cannot advance the completed
> cookie past an older completion that later moves it backwards. Newly
> submitted transactions become eligible to start when issue_pending()
> moves them to the issued queue.
> 
> Implement device_synchronize with vchan_synchronize(), which drains only
> the selected channel's callbacks. DMAengine calls it before releasing
> channel resources. Exclude the controller tasklet while clearing channel
> configuration and powering down, and let a pending run return without
> register access after the last channel has been released.
> 
> This implements the callback deferral proposed by Serge Semin using the
> shared infrastructure suggested by Andy Shevchenko.

...

> Link: https://lore.kernel.org/r/20240911184710.4207-3-fancer.lancer@gmail.com
> Link: https://lore.kernel.org/r/avrHOJ-fVZOO32bI@ashevche-desk.local

Same issue. And I think I have told you about it a few times before.

-- 
With Best Regards,
Andy Shevchenko


