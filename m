Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17351745F2;
	Fri, 25 Oct 2024 14:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729865152; cv=none; b=EkcnooyVxRdn6bUi3n4U6slGFR5Olwp5h0FdUzXMjXc+oAGNcUty8FcF2VLSX2R0cbgoUd5mrS11IjTeQEy7y2tgrg9BgofqQHVJcjMfhgo5oQbDmLLXH3DEcd2aM6E3zM+s/wPKigq7OH3vAYEPdKKK1C0L9v0OygPWPDQUzk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729865152; c=relaxed/simple;
	bh=wqhg4s7Ml7mOVyzruSj/V45I5LEn4zfQdofaqnS+fM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQJb5WhZ3UrrCEbnAVl0AGAAuPqIvUFhWyfoYtqL+LOeiS/Qr8wR5MzMz5wqfqrV8i5utnycodUmnXaiDY6a6Ujuk6PSUm2VnRA9viBxTqHLKoXZzDbY3WJA7uZOpUffEfLI6jpXgcCrgUjdopegl8P5v6PK3omS72aTMYml0AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M6qE+qxE; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M6qE+qxE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729865151; x=1761401151;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wqhg4s7Ml7mOVyzruSj/V45I5LEn4zfQdofaqnS+fM0=;
  b=M6qE+qxEZcTpDkd+ipJxXiEpKZvQXMxCE14HoN6pYfRkFtXtYNWHrK4s
   AqoC5zTwcouA/QujtSEx2bfQSB0aJKnBV/zb6XQ2Ra6OXSOXwNQ/jpjYR
   Li734ucOvGd9iIEknmfFTBhCi3qYQ88lSQf/i2v0LUG2omZGKzwGmq9sS
   1/P8naegZSMZwgOEGeZx7TPyOaPx210oLq2I6UrY3Ggv8rTHKHN8qoW7l
   C6qQ1qRBIus3lTMAjcfWGlXS+aVGFPH524ubna2WUkX9m9covyvV8nPr6
   WQ8tJnN3xJKTU4JnS2whEZyXtV5OZWYSUIOtKZii4ZdH9QX6B/3LDNF9v
   A==;
X-CSE-ConnectionGUID: y1M9FE1PQJ2nMhXu/JT0mg==
X-CSE-MsgGUID: DosuVBNXQOaKH8bJJ+nlSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46998646"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46998646"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 07:05:51 -0700
X-CSE-ConnectionGUID: yah6Vnd1QWasxFFJulFt8Q==
X-CSE-MsgGUID: u1OLnqvHTcmw4EebCfgeWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="81760015"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 07:05:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t4Kwh-00000006vyK-2bXf;
	Fri, 25 Oct 2024 17:05:43 +0300
Date: Fri, 25 Oct 2024 17:05:43 +0300
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
Subject: Re: [PATCH tty-next v3 6/6] serial: 8250: Revert "drop lockdep
 annotation from serial8250_clear_IER()"
Message-ID: <Zxult8UK90H7z3KV@smile.fi.intel.com>
References: <20241025105728.602310-1-john.ogness@linutronix.de>
 <20241025105728.602310-7-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025105728.602310-7-john.ogness@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 25, 2024 at 01:03:28PM +0206, John Ogness wrote:
> The 8250 driver no longer depends on @oops_in_progress and
> will no longer violate the port->lock locking constraints.
> 
> This reverts commit 3d9e6f556e235ddcdc9f73600fdd46fe1736b090.

...

> +	/* Port locked to synchronize UART_IER access against the console. */

Nevertheless, the same comment about the one-liner comment style.
Do we need a period? Perhaps drop it here while at it?

-- 
With Best Regards,
Andy Shevchenko


