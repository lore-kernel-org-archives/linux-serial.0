Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C25F1F755D;
	Fri, 25 Oct 2024 13:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864539; cv=none; b=VTvfQ1BCA604Iv+H93ILtBCA7BP7N2mmKpkr76bVWdNMdN/hrvQa81WbKlmdTKuz7/gCRyxfap8yfP2T6XNlqTG+9wTMleNVPYe0EwusjvyUDyQ9YjPqUKwfgX/N1iIARHMnZwy8eZleI5ZrrDslRbMWqfdAmjxR+hkQ/5CHRvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864539; c=relaxed/simple;
	bh=7E42lOiB7TAA4de6gL/ju50XyGsG6qAcwu0uhMa69Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlwE2D1jwhF8eS0ciD1LijACvtsjS43bJZ2CdOshUzlKQR8SdOmfK32VuDFFpRv15soWzzOpqcGhO/e0XgvxH58etNSC/Z5uooL1V9P4P8Z0XSW2Othp/JTJ6v5nxtVvU2ijUUUDRuRVoLm3ov7rA0qntuFS2y3iJE6lxLSa0Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KY+KdPn9; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KY+KdPn9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729864538; x=1761400538;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7E42lOiB7TAA4de6gL/ju50XyGsG6qAcwu0uhMa69Ow=;
  b=KY+KdPn9IJMqSRsabbmnJuZdVNWMm7cPy5/L9xQp0WuBlUTk7QmhvJcd
   FkxG5j+49+rX1aVUXxsh2C1rRxTCOM/IfwPJNsVK7R3K4sLtvTmihKRXz
   NkUmF0UDD3DG2M7a8SmH6+XXIAzVMUIskKO77J62b2ftO/wJexxvmNPkf
   HnQR+8rpa+NksxU8GjoumOxZS0XntV9t+lND5qGsSUduveLbbSbPus11P
   Wv7sLnKhaIWrjD7NNeJOU2vmdcjXY03NgihCP+uOSHNx5sfuvDusYCQzn
   Ay1QZaZ+QRDeSoF3r9MEsRbOvO2bIhiXKbwdEOmv8/kixQqzyV3mM93IN
   A==;
X-CSE-ConnectionGUID: I9tl+uZhQeWR5JXFmcZiFQ==
X-CSE-MsgGUID: bQlnmgOqS1SNrg9uF+Rzzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29664681"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29664681"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 06:55:37 -0700
X-CSE-ConnectionGUID: nEHhXynQQ72WgY7FicVp/A==
X-CSE-MsgGUID: XP6YgMZPRqWZIIonQulgPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="86028009"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 06:55:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t4Kmn-00000006vpK-2wiT;
	Fri, 25 Oct 2024 16:55:29 +0300
Date: Fri, 25 Oct 2024 16:55:29 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rengarajan S <rengarajan.s@microchip.com>,
	Peter Collingbourne <pcc@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH tty-next v3 3/6] serial: 8250: Split out rx stop/start
 code into helpers
Message-ID: <ZxujUWod6Cc58g7f@smile.fi.intel.com>
References: <20241025105728.602310-1-john.ogness@linutronix.de>
 <20241025105728.602310-4-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025105728.602310-4-john.ogness@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 25, 2024 at 01:03:25PM +0206, John Ogness wrote:
> The rx stop/start callbacks also disable/enable interrupts. This

disable/enable --> toggle ?

> is not acceptable for the console write callback since it must
> manage all interrupt disabling/enabling.

toggling ?

> Move the interrupt disabling/enabling/masking into helper

toggling and masking ?

> functions so that the console write callback can make use of
> the appropriate parts in a follow-up commit.
> 
> This is essentially refactoring and should cause no functional
> change.

Please, be consistent in the commit messages on how you apply terms Rx and Tx
(or TX and RX, but I think the former is more usual WRT UART). This applies
to the whole series.

Code wise looks fine to me
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


