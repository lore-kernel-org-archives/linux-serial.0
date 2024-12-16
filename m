Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEAC1D31AE;
	Mon, 16 Dec 2024 20:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381426; cv=none; b=M1R6eqp77cqtgXbWVu0BuCi5rmWq/4FcMKTVushdtWFARyJkdetfNx4D11GCWiADqZzBc6nJkqVywOdVA6w8k51ENHBsTrko3CyG68D+xwM+/QveHM1K47q7pMSDhbIaNzXHixnGnSIh6nNxF37m08T2q1fj19MIllB9gWiprTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381426; c=relaxed/simple;
	bh=+s5WsuG2cSdxPM6RC+zRZ7byGWKhk445/U/KEx/YmVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cORnt4dCQy2cm74Gn3MT6zr044L6XIp2PLq9K4pIq4XTeKWGRj/1/4XTe32408wm5lrcejRgXEhxvKS7+9b7L5EuFfp9BIjK+r/LVVcZ63ZAFK1gSr13TbAy3QQNhSIiuT3/0ANFu5Ugz9gdVhiLQn8KCbutLmaAnnIukwb+twM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A7OuRagN; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A7OuRagN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734381425; x=1765917425;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+s5WsuG2cSdxPM6RC+zRZ7byGWKhk445/U/KEx/YmVg=;
  b=A7OuRagNdf0t67mG8Jln77bvwvsjKqzoMpTe2GlK0k/Q9sozoR3ZiMI+
   hrnKRu78aNy8b0yWPF7rGaZ79q+kkHaK9OHQcnU1D9JOLScGHDjAn3a72
   BL4dPwpqjJFXOuH6CpV+C/2jH5hW7/8zqPFd9FPvXLRENc5hjmOLGsDA6
   wJDsp5zIVaTgwjQ5T7rsbadskR1ADJARKvRt1O3qkrGk8Wot2vxgl8+RF
   3+jlHIte+c/DL8UvMBjk0Tnlll+exlyZ/ClGx05ej+5kCRgwY6Sy2+ImK
   tNdA4uKtz4sKL/JxJjayihr4Ehp/KEpJccnElDwf0ZVWk1RGvuzOa3E6Y
   A==;
X-CSE-ConnectionGUID: +qMs3IJoShGyo7gkqZyX2A==
X-CSE-MsgGUID: FV1VkwPxQXOmjldUUoABlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34941875"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="34941875"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 12:37:04 -0800
X-CSE-ConnectionGUID: jk6xfrZfS8aIEW4wabNssA==
X-CSE-MsgGUID: 8MM5508vST+7/KiO1NBgBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="102397273"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 12:37:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tNHpo-00000008j5Z-3j4D;
	Mon, 16 Dec 2024 22:36:56 +0200
Date: Mon, 16 Dec 2024 22:36:56 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Peter Collingbourne <pcc@google.com>
Subject: Re: [PATCH tty-next v1 2/4] serial: 8250: Do not set UART_LSR_THRE
 in @read_status_mask
Message-ID: <Z2CPaOehREibSzVD@smile.fi.intel.com>
References: <20241216171244.12783-1-john.ogness@linutronix.de>
 <20241216171244.12783-3-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216171244.12783-3-john.ogness@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Dec 16, 2024 at 06:18:42PM +0106, John Ogness wrote:
> Since Linux 2.1.8 @read_status_mask is no longer used as a
> general control of which bits are used from the LSR register.

The curious ones may add history/history.git to their repo and run
`git show 2.1.8 -- drivers/char/serial.c` to see how it was done.

> Instead it has become an additional mask applied to
> @ignore_status_mask. Since UART_LSR_THRE is never set for
> @ignore_status_mask, it serves no purpose to set it for
> @read_status_mask. In fact, it propagates the misconception
> that @read_status_mask can be used as a general mask for LSR
> bits.

-- 
With Best Regards,
Andy Shevchenko


