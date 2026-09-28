Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E71636B920
	for <linux-serial@vger.kernel.org>; Mon, 28 Sep 2026 21:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790632056; cv=none; b=DQfZgY4WE2lEjjgNIq1SAEeuGkBHvrR6UZrGCnG+BKMHODoiC8ADceF2/qOSF0oXreJEnyu2t0ByoJbTAEWym+Kx32HM+dMeNo71DsxzBisTPdiurMoSD6z+hDyONm/GYJz46DN+ikzH/BHUbujlQlFpgmEeD0hEu6Gd0zuKTYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790632056; c=relaxed/simple;
	bh=cHVVXQSmQCe8MN7vhG0q79L3UDgJ1uy4smBQYk+d77U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjFdp6q6MXDvDDCPr96OAI9VlaaKs4r9gCpX3oBXIqSMln+nUMrINoWrFyDpcB8/FokAlyPBNAPREiHLojgwPcAdz5p8P8fgYvvc6/NqSubaKuOeVvvKuuizN24ps57Ld+XDCmGsWXg7zH7LSLbgm54ooMGnMxy65H7YlmWtC4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BZ/iANhA; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BZ/iANhA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790632054; x=1822168054;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cHVVXQSmQCe8MN7vhG0q79L3UDgJ1uy4smBQYk+d77U=;
  b=BZ/iANhARTHdbLzXAxepOe3U8WdJwD16tscxSKl9Vp9NoB4iX5JxRE84
   gp1ECBUF1oIl5BQNujTzw/Nh9Kzko//ROExnSu8NanT0pULTdPsmKEkPB
   XvzT98G8i1tluPQerBt2k80/1QYD9FD92X8rjw+qxEo+JUyfKO1sMxSKg
   8EBP3px459uejMsk+tMEbCJXrC5qV/ZOe8e9doGTRdEaPgWkyHLn0D4kp
   lg3gPOaV4kjkhSlckc/pTZ0S4gNhnEtx7SYAresv77SoRGmFLsh0WSwTr
   QuhokWQcs3tbGkm8R+kmXfV2ETl64TCM8HOvqtJhNWUdz5XVCJPmhN0IC
   A==;
X-CSE-ConnectionGUID: acoUFF2FRb+zZ1RDKFOxNA==
X-CSE-MsgGUID: UbJinWIbTMSpkAuataCXzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="101866383"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="101866383"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 14:47:33 -0700
X-CSE-ConnectionGUID: DN3xsq7gSleOn57j8VO7bA==
X-CSE-MsgGUID: IbUqZtjjSsus8JgtEashEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="301458571"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.42])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 14:47:31 -0700
Date: Tue, 29 Sep 2026 00:47:28 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Gaosheng Cui <cuigaosheng1@huawei.com>
Cc: lujialin4@huawei.com, gregkh@linuxfoundation.org, jirislaby@kernel.org,
	hvilleneuve@dimonoff.com, kmehltretter@gmail.com,
	john.ogness@linutronix.de, tony@atomide.com,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH -next,v3] serial: core: fix NULL/dangling port_dev on
 failed re-register
Message-ID: <arrgcE9hdhv_-GBi@ashevche-desk.local>
References: <20260928113456.3118750-1-cuigaosheng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928113456.3118750-1-cuigaosheng1@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 28, 2026 at 07:34:56PM +0800, Gaosheng Cui wrote:

> serial8250_unregister_port() removes a port and then re-registers it
> against the legacy serial8250 device when that device is still
> present, ignoring the return value of uart_add_one_port(). When the
> re-register fails, the error path of serial_core_register_port()
> removes the port device but leaves port->port_dev dangling (or NULL
> if the port device allocation itself failed). serial8250 matches
> ports on ->dev, so such half-registered slots still reach
> serial_core_unregister_port() on the next unbind:
> 
>   Oops: general protection fault ... SMP KASAN PTI
>   KASAN: null-ptr-deref in range [0x40-0x47]
>   RIP: serial_core_unregister_port+0xe5/0xa00
>     serial8250_unregister_port+0x103
>     serial8250_remove+0x61
>     device_release_driver_internal+0x38c
>     unbind_store+0xd1
>     kernfs_fop_write_iter+0x329
>     vfs_write+0x5d0
>     ksys_write+0xf7
>     do_syscall_64+0xdd
>     entry_SYSCALL_64_after_hwframe+0x77

Submitting Patches is clear about bloated backtraces in the commit message.

> Fix the error path to clear port->port_dev, and bail out of
> serial_core_unregister_port() when port_dev is NULL. Read
> port->port_dev under port_mutex, like all of its writers.

> Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
> Assisted-by: GLM-5.3 OpenCode # fault analysis and fix rework

Assisted-by: LLM

> Signed-off-by: Cui GaoSheng <cuigaosheng1@huawei.com>

-- 
With Best Regards,
Andy Shevchenko


