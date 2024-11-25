Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD5C197512;
	Mon, 25 Nov 2024 11:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732534004; cv=none; b=Is86v19kNgUvs0upUaoqToWoQiqVDkXI09wYtBbMEj6l2jkIvBzHAe8xPxALZcCFqhrtt/QvmnH480ClZg5lUJi7Rb7A93vBc7cp3jbtf30OJYI6ZsonE+VZ/nukO/rdNHg80BHAIOPDOz/LINCWONn6JZEmTqqYGLveYN+C7a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732534004; c=relaxed/simple;
	bh=SAmhCS5qACdbyhAPkjIMCCb3p3OfxfHbuOrSUE4TKKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5jMQp89KIhgIXc3JFcS3uxhBF37XFOm5YWr+8iFn2yl1xg3ggc/xVKN+kg8bmLT7xmMPR2VuDAlmQhV+k+3Y9Jr87WfuGeuc26uoaouCQrkiCQTqrnvx4I5oQT7/t1Wrki0JoZRnlBUCQQU7a6sttVsi99ynKKyc/c+BI5spb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IhmXnew/; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IhmXnew/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732534002; x=1764070002;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SAmhCS5qACdbyhAPkjIMCCb3p3OfxfHbuOrSUE4TKKk=;
  b=IhmXnew/1rCyrh0R53ZZoo5++bk7DZunftXDQrKnBhYF+G/P8p1FTyqh
   sKb1b1T8b0jEDMH8jPGZWSmKeLX6wAt9CvKJo8hld9y6h6UuJOjNuDgxD
   Z0GdXmQUL7smJKaZ9iUut3AjYhZOH5GTa4QihrSxV/RT213HtjlGnkJtS
   XlFeSdvrKYV0iXDKxeW0mpl6DAbP0GMDgoEUlm7+fp45wZnTeaVc+7r+i
   BA6w1ykRQU8XfFyZrrtimUQtLt5bf1+zYM/vF36+Jt4VoZjkFYlF6zLYP
   2QkVemUGwnZK4vRgJ8r7rcA2oGERfCGzGoMSgO0SZJcmJl03G+w5PcxMA
   Q==;
X-CSE-ConnectionGUID: Lf1rPBuZSgupDfM+RLPIQA==
X-CSE-MsgGUID: ibY9bQSqTWum8kAbbhZ8vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11266"; a="20224441"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="20224441"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 03:26:41 -0800
X-CSE-ConnectionGUID: NSLm0bmvQnqu+gHiMuKNPw==
X-CSE-MsgGUID: ax1ggI24SKaWSlF57sbfyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="91196429"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 03:26:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tFXEi-00000000jRD-1E8t;
	Mon, 25 Nov 2024 13:26:36 +0200
Date: Mon, 25 Nov 2024 13:26:35 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	Yang Yingliang <yangyingliang@huawei.com>
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
Message-ID: <Z0Re61Tk5lN2Xuxi@smile.fi.intel.com>
References: <20240405152924.252598-2-schnelle@linux.ibm.com>
 <38bf3b8b-81c4-42c9-902d-b5719f3881c5@roeck-us.net>
 <3b75b92805648577ed05ff221d0c56e381aa1c7c.camel@linux.ibm.com>
 <472eb22a-dcb1-4fbb-bf2c-a4173706bc7a@app.fastmail.com>
 <27685942-fb62-44c5-86ed-98beb547ffed@roeck-us.net>
 <744920ba-551c-466b-ac5c-2607b81261a0@app.fastmail.com>
 <Z0QtZky8Sr7qUW7v@smile.fi.intel.com>
 <00f5e842-3ee9-4d83-8836-0ff4f703fa3c@app.fastmail.com>
 <Z0RSZ-YD_BozMs1n@smile.fi.intel.com>
 <be43108e-4135-4927-ba58-141836fde6af@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be43108e-4135-4927-ba58-141836fde6af@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Nov 25, 2024 at 12:06:16PM +0100, Arnd Bergmann wrote:
> On Mon, Nov 25, 2024, at 11:33, Andy Shevchenko wrote:
> > On Mon, Nov 25, 2024 at 10:53:46AM +0100, Arnd Bergmann wrote:
> >> 
> >> This does however revert f4c23a140d80 ("serial: 8250:
> >> fix null-ptr-deref in serial8250_start_tx()") and
> >> might bring back the bug came from opening an
> >> uninitialized uart. On the other hand, I don't see
> >> why that doesn't also crash from accessing the invalid
> >> I/O port on the same architectures.
> >
> > AFAICS it does only partial revert, so I don't see how your patch
> > may break that.
> 
> I think it's a complete revert, it's just not entirely obvious
> since serial8250_setup_port() got split out by 9d86719f8769
> ("serial: 8250: Allow using ports higher than
> SERIAL_8250_RUNTIME_UARTS") and the original callsite got
> moved by your ffd8e8bd26e9 ("serial: 8250: Extract platform
> driver").

Ah, okay.

> What I suspect is going on with the f4c23a140d80 commit
> is the same bug I mentioned earlier in this thread, where
> __serial8250_isa_init_ports() just always registers
> 'nr_uarts' (CONFIG_SERIAL_8250_RUNTIME_UARTS) ports,
> unlike any other serial driver.

But the configuration can give less than old_serial_port contains.
See dozens of the explicit settings in the defconfigs.

> This used to be required before 9d86719f8769 ("serial:
> 8250: Allow using ports higher than SERIAL_8250_RUNTIME_UARTS"),
> but I don't see why this is still a thing now, other than
> for using setserial on i486-class PCs with nonstandard ISA
> ports.
> 
> On non-x86 machines, it only ever seems to create extra
> ports that are likely to crash the system if opened, either
> because they lack proper serial_in/serial_out callbacks,
> or because the default UPIO_PORT callbacks end up poking
> unmapped memory.
> 
> Do you see any reason why we can't just do the version below?

Perhaps we may do this way (it seems better to me than previous suggestions),
but it also needs to be carefully checked against those configurations that set
it explicitly.

...

If we go this way, it would be also nice to add a comment explaining that
this is module parameter (as it's done for those ones above).

> +unsigned int nr_uarts = ARRAY_SIZE(old_serial_port);;

...

>  	/*
> -	 * Set up initial ISA ports based on nr_uart module param, or else
> -	 * default to CONFIG_SERIAL_8250_RUNTIME_UARTS. Note that we do not
> -	 * need to increase nr_uarts when setting up the initial ISA ports.

> +	 * Set up initial ISA ports based on nr_uart module param. Note that 

Just in case it has a trailing whitespace.

> +	 * we do not need to increase nr_uarts when setting up the initial
> +	 * ISA ports.
>  	 */

-- 
With Best Regards,
Andy Shevchenko


