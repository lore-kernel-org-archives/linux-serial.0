Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28421FDA94;
	Thu, 20 Feb 2025 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740065025; cv=none; b=WqHFDFGGKFa+eCRQmRTcWKhn1Ez9jzX4sewuVXkxPElCmlgjfhrNcbnQM4E9dN1hw9UYkw0yGUfySbYesY+qI5NmuGrgLWvlsi4gWrDz64c6H828d35Yiu9Xok4L1qzQkVSW0/ij5yZRj5pnsoJ9AxuMlm4lFzw+fS5xjSKKEPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740065025; c=relaxed/simple;
	bh=nTFKtOjkpt8whIdbOEj5tkvfkIRkCZEcbPHfxP7t6So=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaCrv1NGBMuvlHVFNwIHH5/5jegi/ELDywqAaaHwcdziIcWfddW66eNQCwcVz5UVSSPJNZnt2nfOlkYkmOBAQ2PUQ1Wr1FgaHY7HgtIWKGcM7y5z+zDTNAzVfp76qFrncaACQd8gdYS3wMKXuVzPKGwxo8jvo9bAEx19YBeL3Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QNITCZaG; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QNITCZaG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740065024; x=1771601024;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nTFKtOjkpt8whIdbOEj5tkvfkIRkCZEcbPHfxP7t6So=;
  b=QNITCZaGFPyJ/PCYIKxjdkhS5R+KOBE1Ei5rvV2OiWBsz/b3irH7/oMk
   lPxCVcX/sq9CPB0fkDjB3bgdYbiegNZjvmRtyO5430MvzcD5ZedVqKhTL
   +oX3Sf09AjyEW8fdkiLBSv4FYw+2zO0AHmDRdWDNbbo/mghop0NqloMdf
   ubB1xdc871IDTFvFBvrZ+kS1r/Ky+nEM0o6TSFu2Jdv9PM5n6UpZ8wdgC
   LkkeontxY0b9ATWDXyfBm737qW/lzYA0YkkLPraW8AXhgdV6YYd3rjum4
   TEb8jhC5SRUI8rrmgk9lw9o3BMXXsi+HIoNcCRfEx74MEcRqkibSBxGnQ
   w==;
X-CSE-ConnectionGUID: ClvMaAPeQS+rTWDuResYEA==
X-CSE-MsgGUID: j1gFIVK/TtuvQNnlf9YXGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="51838349"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="51838349"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 07:23:42 -0800
X-CSE-ConnectionGUID: KuJfWvMNTaWdKG51NSC4ew==
X-CSE-MsgGUID: SqanJce5Q02NiPoCTdrYow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="145963160"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 07:23:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tl8Ol-0000000DNFF-1gS6;
	Thu, 20 Feb 2025 17:23:35 +0200
Date: Thu, 20 Feb 2025 17:23:35 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 26/29] serial: 8250: use serial_in/out() helpers
Message-ID: <Z7dI9-mTl820lyY-@smile.fi.intel.com>
References: <20250220111606.138045-1-jirislaby@kernel.org>
 <20250220111606.138045-27-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220111606.138045-27-jirislaby@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 20, 2025 at 12:16:03PM +0100, Jiri Slaby (SUSE) wrote:
> There are serial_in/out() helpers to be used instead of direct
> p->serial_in/out(). Use them in various 8250 drivers.

Okay, I have checked all calls, and I think to avoid possible issues
we need to add a few comments here and there, see below.

But first of all, can we actually use serial_port_in()/serial_port_out()
in the cases where we have already a pointer to uart_port?

...

Here we should add a comment like

/*
 * This function is being called as part of the uart_port::serial_out()
 * routine. Hence it must not call serial_out() on itself against
 * the modified registers here, i.e. LCR.
 */

> static void dw8250_force_idle(struct uart_port *p)
> {
> 	struct uart_8250_port *up = up_to_u8250p(p);
> 	unsigned int lsr;

Here we should add a comment like

	/*
	 * The following call currently performs serial_out()
	 * against the FCR register. Because it differs to LCR
	 * there will be no dead loop, but if it ever gets
	 * modified, we might need a new custom version that
	 * avoids infinite recursion.
	 */

> 	serial8250_clear_and_reinit_fifos(up);

...

On top of this function we need to add the same comment as on top of
dw8250_force_idle() above.

>  static void dw8250_check_lcr(struct uart_port *p, int offset, int value)

...

The rest is legit as we shouldn't use those in the ->serial_in()/->serial_out().

-- 
With Best Regards,
Andy Shevchenko


