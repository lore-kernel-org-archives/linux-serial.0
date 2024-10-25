Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7140D212177;
	Fri, 25 Oct 2024 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864276; cv=none; b=cQrHb6Eb5S3xEWoRtbTgVe8GrFrJDSgMc4IdaILxoPr53i61apAZ+SL27C5VpMTcvZQ6/nwtzNpI2duLvcTT/OD4HNkFYuwu2LVkbHpfmFX9YD3pWdjdTIP0y1KM11OEnRXvay00J9wvBsKCm/I++ev0QgvDUas9OUicNhI3goA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864276; c=relaxed/simple;
	bh=Wu7EvylJL4VQgi2fQLvllfTkyswJhFa1BfrDPsfeE/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgtNSFJ9Jrn1PDXENvfub3CoeGTXCKycZMucasfH+T3vSZl/I00wtnHACZvkJdT+7ZMlnVStMOdfAPtcQ2HfWBqvjgf+OP2WjGbc5IH+ceYA9Nx5XjILK1rci1g1JvpI5Pfwfm/qq1krFjxMFESbJDqGc7QxD5hJkCtGfJNrICk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DDL0A12A; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DDL0A12A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729864274; x=1761400274;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wu7EvylJL4VQgi2fQLvllfTkyswJhFa1BfrDPsfeE/E=;
  b=DDL0A12AWJ4MJhoF4fTwOvtEo2uq/DK+YlQNgrGKXDx9sU0yD6eR5L8D
   dAGDKUYRAih1NBYpc7YkF9EvEscVf4YAlu/8hxpIURam7AGBwvfkFiGyd
   ajhs9kaoKFkkAmOjgKVgnUsZsS7/zt8SVXlseqsXiH90r7ldQliVflFws
   XwUYY/XyVtb18+TzFgB4Kb68uyLXfXJYDbn7klam7kbjFxRFTWV5gYIh/
   HoFvRn7XUIpfoyBUsYlA5nIwOMWoGYbaU5I9c8ITMU9xtDyy+AWEnjLW3
   yKey//XyoO/bcMtOqyoQsJK3iN4tskZRSAXe9NBcD7UVZBLA6LTEv8ZMu
   g==;
X-CSE-ConnectionGUID: SMHDSjGiQwaDQ4RepFaUTw==
X-CSE-MsgGUID: /usbw4cpR++QUnGSSyP4Sg==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="28983998"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="28983998"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 06:50:50 -0700
X-CSE-ConnectionGUID: Te/ubDqWQiGCIcWeOCpdBA==
X-CSE-MsgGUID: 2RcdbdnSTLml6qAPZBvGuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="111755596"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 06:50:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t4Ki9-00000006vkd-3NAP;
	Fri, 25 Oct 2024 16:50:41 +0300
Date: Fri, 25 Oct 2024 16:50:41 +0300
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
	Serge Semin <fancer.lancer@gmail.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH tty-next v3 2/6] serial: 8250: Use high-level write
 function for FIFO
Message-ID: <ZxuiMdrGcsuPp8OG@smile.fi.intel.com>
References: <20241025105728.602310-1-john.ogness@linutronix.de>
 <20241025105728.602310-3-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025105728.602310-3-john.ogness@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 25, 2024 at 01:03:24PM +0206, John Ogness wrote:
> Currently serial8250_console_fifo_write() directly writes into the
> UART_TX register, rather than using the high-level function
> serial8250_console_putchar(). This is because
> serial8250_console_putchar() waits for the holding register to
> become empty. That would defeat the purpose of the FIFO code.

You can slightly reformat the above to make it less shaky in terms
of the efficiency of a line capacity usage.

Currently serial8250_console_fifo_write() directly writes into
the UART_TX register, rather than using the high-level function
serial8250_console_putchar(). This is because
serial8250_console_putchar() waits for the holding register
to become empty. That would defeat the purpose of the FIFO code.

> Move the LSR_THRE waiting to a new function
> serial8250_console_wait_putchar() so that the FIFO code can use
> serial8250_console_putchar(). This will be particularly important
> for a follow-up commit, where output bytes are inspected to track
> newlines.

> This is only refactoring and has no functional change.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


