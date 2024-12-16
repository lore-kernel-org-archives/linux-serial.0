Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDD01B5EB5;
	Mon, 16 Dec 2024 20:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381075; cv=none; b=I8pj6IiHa1BHTSD8kanfhqNQQQZ8HeqpH1jIvyFPOROh+WWnTgyrk1IcRFGidnw0j5zozQK/CmvBEYpDeNzme94vG1qdB3A82IUQkEkmX9wl5mGRRlqJVHVasQlXlwRJZLWd/YIs8XpNlZyZ4nQa7GA/Z6w8bja92dxxw2s41Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381075; c=relaxed/simple;
	bh=Pkvx0M9D0fbKwirjbkaHxTSIUhen2l88ORjCv5hvUoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsAZ6/go2E0oNo05h90eHgDOl4FC0QEdSsYd7h7k0+XeDDwLxzug7twkVcoIWADP0DLB8aWJ94gfjlcN97CBO9E1vodXTNlEjMrtpU3z65IDbk/nSAbqCwz1rSEjzB0RXtZX3uWB4Mmy2ytaT3RDIjfYIquJxW2ChXci+gPEufI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hAHKF13t; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hAHKF13t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734381073; x=1765917073;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pkvx0M9D0fbKwirjbkaHxTSIUhen2l88ORjCv5hvUoM=;
  b=hAHKF13twcJg/+ZeILZ/+NWNw6Le9OhEolLAZ+AkDfQJVId8jI97CR+w
   FB/f/JTefIeAp+H/OPY4qcbrvt/+cqLh7xJv1BmBP/QX/iK3dpcWOg7Ea
   ue6z6GO8VhwcVCX0mr+Sp7h1cgc9qB9gy4cV8wayaYSq5skMsR1lgLbSz
   hnVnVG51rk6Bx2bltEE2aSzlxc0VxX7UAq945mSeocf1fm3a74hL5AWpZ
   X+0EuSxzCH05hRrFBnAf40+6eC2GL4mo1kX3r81AUxqWIpcyCfvX/V+d5
   Kh7OEpZpgUhNWcySTX7uhadUPJRG7DJf2XvsCZDVlA8XXGD/w07uFnRqn
   w==;
X-CSE-ConnectionGUID: f5HMsoOETRyuP/1D63MMmA==
X-CSE-MsgGUID: fMm5AsQZQESheFTI/sK7Bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34941442"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="34941442"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 12:31:12 -0800
X-CSE-ConnectionGUID: Jjx8HbKYTXmGwj3h8du9Rg==
X-CSE-MsgGUID: FCSGRj5ST6aM54yqDK7URQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="102396460"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 12:31:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tNHkA-00000008j00-0iq0;
	Mon, 16 Dec 2024 22:31:06 +0200
Date: Mon, 16 Dec 2024 22:31:05 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Peter Collingbourne <pcc@google.com>
Subject: Re: [PATCH tty-next v1 1/4] serial: 8250: Use @ier bits to determine
 if Rx is stopped
Message-ID: <Z2COCeWqyauMYYyk@smile.fi.intel.com>
References: <20241216171244.12783-1-john.ogness@linutronix.de>
 <20241216171244.12783-2-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216171244.12783-2-john.ogness@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Dec 16, 2024 at 06:18:41PM +0106, John Ogness wrote:
> Commit f19c3f6c8109 ("serial: 8250_port: Don't service RX FIFO if
> throttled") uses @read_status_mask (bit UART_LSR_DR) to determine
> if Rx has been stopped. However, the bit UART_LSR_DR is not
> managed properly in @read_status_mask for all Rx stop/start
> situations and is therefore not suitable for this purpose.
> 
> Use the UART_IER_RLSI and UART_IER_RDI bits in @ier instead, as
> this is already common in 8250-variants and drivers.

Hmm... IER is Interrupt Enable Register, so it has been programmed to the value
we control, on the opposite the LSR is Line Status Register and defines status
on the line at the moment of reading. Can you elaborate how your change is correct
substitute?

-- 
With Best Regards,
Andy Shevchenko


