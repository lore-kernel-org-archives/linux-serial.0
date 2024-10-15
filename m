Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B1A15099D;
	Tue, 15 Oct 2024 11:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992081; cv=none; b=fwzddyZs+EPMnuZUO9lGzVIMpjFNGa/t9PFJ9MlU31JDBh2sLj6MrlRQv+gaSUdYGp4eDsNI7Sa8DH+QEqTJyqtlYqatU/XY2Vk2s8CJ+S001J3SFmj7rgyqgC+dlsvvYqYLrjCKiF3irD686IXsR0zBrkLzfIjkkb5R9HzOpJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992081; c=relaxed/simple;
	bh=QQ5YIhldVyNwIwAkOJehyVg5fvH4Y/bF5BwZEh4dw2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfawJDtcnaf/O5NnEpLkeuA7W+cHzSvVvpIIHlodZzit4xQwzB7CIx5rs4Pf0zZ3ealFmvEd+WGP8T43D3FCCcGmw6OlygsGLscSHfylkKzEUe68pSJDSW/Bh09K1BF4lnq83EufGn8AQB7gt4M9/zfr9zB1Afpb0yRvTNUn0ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L5Q0OswE; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L5Q0OswE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728992080; x=1760528080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QQ5YIhldVyNwIwAkOJehyVg5fvH4Y/bF5BwZEh4dw2A=;
  b=L5Q0OswEQrZtscwOaWu9hbtuTkIenWl0Sk3ZDVo999MmGO7tg/g/PIQX
   RArTkDexryrBIsItX0SsTRXA5J9RodjuoJqLFTBK+XCC9HizavSXAAxSD
   LpIF9FufqL0F087kpfq22PbZC4ey1Cd7OA/SvQR5TtQU7qtTZmmnCYm/q
   d5GweydUzr+Pt2t1AZwvaq1+wMTy2LbtBjyJzgKo6klcUjQmVhg3LNVJq
   sB+MM+vLRV+ceT9FoBPZDlmbUzalHRXUEtMPbhfr9SQmHiLTzyzxy2W1C
   vfLTy2f7tbYBy0lMHW+uk01I0A8awlIoixsd6d6vTdfBI8utO1TLexkPT
   w==;
X-CSE-ConnectionGUID: 7g2GMlWbQaGZjWExOjYAiw==
X-CSE-MsgGUID: MypAoUM6TxaUPFWC2TX6hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="38933972"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="38933972"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 04:34:40 -0700
X-CSE-ConnectionGUID: aDq4v7IAQlKN3BvHFnTo+g==
X-CSE-MsgGUID: uBeHfze4QbexSbsA0OX6bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="82916412"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 04:34:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t0fov-00000003Fds-1u6y;
	Tue, 15 Oct 2024 14:34:33 +0300
Date: Tue, 15 Oct 2024 14:34:33 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Omer Faruk BULUT <m.omerfarukbulut@gmail.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, pmladek@suse.com,
	paulmck@kernel.org, john.ogness@linutronix.de, tony@atomide.com,
	arnd@arndb.de, u.kleine-koenig@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/2] 8250_core.c : Global variable shouldn't be
 initialized to NULL
Message-ID: <Zw5TSaN9BGyNwrsT@smile.fi.intel.com>
References: <20241014180415.2365-1-m.omerfarukbulut@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014180415.2365-1-m.omerfarukbulut@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Oct 14, 2024 at 09:04:15PM +0300, Omer Faruk BULUT wrote:
> I check it with checkpatch. Then remove the NULL part.

checkpatch may be false positive. Please, add a better analysis
that it's fine to do a such cleanup. Note, this variable is _not_
static.

...

> -const struct uart_ops *univ8250_port_base_ops = NULL;
> +const struct uart_ops *univ8250_port_base_ops;

Is it guaranteed to be NULL for non-static variables? If so,
we want to know the details.

>  struct uart_ops univ8250_port_ops;

-- 
With Best Regards,
Andy Shevchenko


