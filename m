Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0C84CEE4D;
	Fri, 16 Oct 2026 13:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157540; cv=none; b=YeC1oZ1DpIJnr5JZJ2kLmWFbgkXKFjqPrmd9ljvl4ker6LdKPTOswlc7xbxou5RpEiwwdBt4++iPUxFXKvZsKKD3tWoEHjBApvstkX8wTQLKahHmceh2PLxCcQ6EtoHlApMa11SG7/8n2mGhZXRcIAjLFIk5FLfVJ7ktcs/QaJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157540; c=relaxed/simple;
	bh=4tww+20O5RpFk7JwnGATK7P/ns2O8SLs2ij/rA77nLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qo/ARt5jQk8Nfw8c63Wtx9a0z3r1Hy+jBSWJDNvKScmUJBku3YNVLtKSTmM3C6jclUAX8k/cgFUR5Zx9ytYi89hXXbFHaT0b1r0+XcIIPUFtYgoTNvN5cuoYSFlYwI+AamrK4CxUWw9DAaPZ1324i2AeLxeEGvZzLac7RfkI5/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E5Lc81/i; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E5Lc81/i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792157539; x=1823693539;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4tww+20O5RpFk7JwnGATK7P/ns2O8SLs2ij/rA77nLQ=;
  b=E5Lc81/iL0aEidFkxFagpCZPRxmBM3fxETztnED8BLc17E1c1lzdvT51
   0MMNLntGy36vy6TLu/Nzt+J5S3uYu3L28XLxEFso/9Atjdam5Yeq4555h
   vlBPDhtyf0XvUz5CLeH5LE/utd8ukdflSHtvNnr/kJFdy3m9U47GPyVsW
   MQxQfy2BLE42F2QL3gWYi88DGzfsS+je2qsj7GMVBbOKDV/55gn8qjIZ+
   CScvisVwkppkVnnnKsjF2wazy1/N2FIXV1OwQb3PpFZVEIf86Jq9i0MOu
   1lTkIZ0S6G/ytpzm+XbKOEpnw1quHDBYyJzvbuU9Dd6CDdBum638sMflL
   Q==;
X-CSE-ConnectionGUID: YYwTmP7FRSKmAt6U//tM2A==
X-CSE-MsgGUID: hNy5S0p8SKOZjNwtRD0Y5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="842672"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="842672"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 06:32:19 -0700
X-CSE-ConnectionGUID: NVBJKEN4SGaQqu0Yi8G49w==
X-CSE-MsgGUID: F+NQ+lOaROKub8UktRSdOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="3695412"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.35])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 06:32:16 -0700
Date: Fri, 16 Oct 2026 16:32:13 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH 1/2] tty: serial: remove hub6 multiport support
Message-ID: <atInXRlI1L9JXjMd@ashevche-desk.local>
References: <20261016130328.1037616-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016130328.1037616-1-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 16, 2026 at 02:59:47PM +0200, Arnd Bergmann wrote:

> hub6 support was added in linux-0.99 and the hardware was already old at
> the time, being discontinued in 1990. The code for it has always been a
> mess since it adds another dimension to the I/O addressing in the driver
> that has leaked into many individual files.
> 
> Hugo and Uwe have attempted several times this year alone to isolate
> the hub6 handling into the 8250_hub6.c file, but I feel that none of
> this has been a real improvement over the original standalone loadable
> module support.
> 
> Any machine that would have used this ISA card in practice is likely
> 30 to 40 years old, and with i486 support now removed, it is clearly
> safe to just kill this all off. The only bit that has to remain
> is the ioctl interface, to ensure the serial_struct field is always
> zero.

After reading patch 2/2 I noticed also a SERIAL_IO_HUB6 leftover. Most likely
it should stay as is until the user space gets rid of the use.

-- 
With Best Regards,
Andy Shevchenko


