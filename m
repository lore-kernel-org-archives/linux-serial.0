Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793790625;
	b=BlU3MHdcODEnFRBDu8CsdSuqshIgRvUuR1NqM2F+uCqhZ2AzCWc3fLesHSHE8hWyjSc6
	 LYhxr7dq67WsENY2chKAoKWSJzy1lg+cTMTP4tiI+p7FRbIjGxN5O28PWgkD4zQkxC4rZ
	 7kiQxWBE2yiHdfaotJrkbeN6jmskllb9FkXoLqVKjv/dlE1WZ8CvNacDQynf5tNN7erCC
	 4yTEyiVPztuY8C9QjfA5p+2wDhs2K6RFHuCl20eNSylYtBaniqzA6V06cjrEj8h3AP6Kv
	 skO038veMRT2/HQnt3hQAU/XFJ3pN+cFhPGc5KWAbvmjsDFImrUXInBAR4WiXaEVNaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793790625;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=RWmAnQFAwcDgMD4QSAxSQ6IEhxz4PTQr1GmoYyDd32k=;
	b=crUwf5H0Lww4Da4GEdxjtTOrU0wvLBpg2CoW/nnaqtzWxzwIn2O0gNMRa2MBf6GTaX32
	 ENgNPhRIm0Yj0scX3XhP/AyPrJHC/+Uoc0gjGLEaei12kTyODI5WwjMZ8BFRnHNSXR9WG
	 Y7N1SDTlU+TUjUUbpCLb6SP5ofl29bdIIwsr5o2eFkNBjaXu5M2SK2DK0j/RJlZzlxyBS
	 I++SPQGpmO52dZxrMYN46QVj029Vb4ODj9HA0U568CeoQOX4JCD7M575BSjnWv5EHuNf0
	 mKzpnVcMjWYNJDH7rgbSfENJG3U7/50u/37SpYc7jENS3mOmB13T1c+Uogj9tuj3qHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DvYyLQ0K;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A26D606A328;
	Wed,  4 Nov 2026 11:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A26D606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DvYyLQ0K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793790624; x=1825326624;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A5BGL88tXyzuSsMiqipz8eLRoqaEGjr0doKL7tQxGe8=;
  b=DvYyLQ0KlW9DQqN0hPZgsXlu/2et0SeVZPRFCWaczIGbfQs/XYN5UZhj
   +fJ9Qo4n/MKAY9/MvEivjBjpCXldGK6OvmEgZOZ8hltA2k0puuvzARbGp
   aNls1fmXg2SqBh1diJwG5ekM3k4kdtIX6bFnwu+pIpV0jjdjeedmawfmX
   KJbmbAxrHJq7qCofHUl0O3++B7rVDQOUKCmAZ8yuo5Mz4MIms6vlw5waO
   IAg/MCfDFKn/6M7BBJF2wxa4qu61//19OCshmX/o9YKWJ/0hAoEwIzJwC
   gmIYBUMCAYwC+bmuwlyskaCdjBytp5S+RffAbbHWM8XyYaEyvadMiJLjM
   g==;
X-CSE-ConnectionGUID: o3G/6nmUS/mAk+wz/wl/qA==
X-CSE-MsgGUID: /nrYIljqQiWwReUlUtRyLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2438350"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2438350"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 03:10:24 -0800
X-CSE-ConnectionGUID: qzWTsHXnTLCDUbjXtBGBZg==
X-CSE-MsgGUID: weYVXld8R4mBJhSyxXSIDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6794066"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 03:10:21 -0800
Date: Wed, 4 Nov 2026 13:10:18 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Johan Hovold <johan@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 2/2] serial: core: Don't clobber the baud rate on
 hangup via B0
Message-ID: <ausSmrErzTXfKNGU@ashevche-desk.local>
References: <alpine.DEB.2.21.2611030057510.15685@angie.orcam.me.uk>
 <alpine.DEB.2.21.2611032050590.15685@angie.orcam.me.uk>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2611032050590.15685@angie.orcam.me.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 03, 2026 at 10:07:58PM +0000, Maciej W. Rozycki wrote:
> Requesting hangup via the B0 baud rate has this nasty side effect of 
> clobbering the previously set rate for the port unless it happens to be 
> 9600bps or the port minimum rate if higher.  Consequently if there's a 
> consumer still active at the other end, then it receives corrupt data 
> from any other producers outputting messages to the port, such as 
> init(8) or the kernel console.
> 
> There doesn't appear to be any particular reason for this clobbering 
> other than that we have been doing it since 2.1.131, so take a saner 
> approach and keep track of the most recently set baud rate and then use 
> it whenever hangup has been requested.
> 
> There is one issue however with serial8250_console_restore(), possibly 
> called from the NMI context on some platforms, in which case there is a 
> concurrency issue owing to `port->mutex' not being held by the function.  
> Consequently `port->hup_speed' could be written midway through an update 
> being made by a termios call, causing the value saved to clobber the 
> baud rate programmed into hardware with a later B0 rate selection.
> 
> Handle it by renaming uart_get_baud_rate() to uart_get_baud_rate_save() 
> and giving the function an extra `save' parameter to control whether or 
> not to have the baud rate saved in `port->hup_speed' that is returned by 
> the function.  Then use that parameter to suppress saving when called by 
> serial8250_console_restore(), observing that the call is only ever made 
> to restore the baud rate most recently set.  Any concurrent interrupted 
> termios call, once it has been passed control again, will then program 
> hardware consistently with the value it may have written already or will 
> otherwise write to `port->hup_speed'.
> 
> In the unlikely case `port->hup_speed' is zero where the B0 rate has 
> been requested as the first one since the system boot for a non-console 
> device, resort to the current default of max(min, 9600).

All lines above (except the last ones in the paragraphs) have a single trailing
white space. Usually checkpatch warns at this.

>  /**
> - * uart_get_baud_rate - return baud rate for a particular port
> + * uart_get_baud_rate_save - return baud rate for a particular port

Now it also saves it, so

 * uart_get_baud_rate_save - return and save baud rate for a particular port

>   * @port: uart_port structure describing the port in question.
>   * @termios: desired termios settings
>   * @old: old termios (or %NULL)
>   * @min: minimum acceptable baud rate
>   * @max: maximum acceptable baud rate
> + * @save: whether to save the baud rate chosen
>   *
>   * Decode the termios structure into a numeric baud rate, taking account of the
> - * magic 38400 baud rate (with spd_* flags), and mapping the %B0 rate to 9600
> + * magic 38400 baud rate (with spd_* flags), and mapping the %B0 rate to the
> + * previously saved rate provided by @port, or if this is unset, then 9600
>   * baud or min argument, whichever is greater.
>   *
>   * If the new baud rate is invalid, try the @old termios setting. If it's still
>   * invalid, clip to the nearest chip supported rate.
>   *
>   * The @termios structure is updated to reflect the baud rate we're actually
> - * going to be using. Don't do this for the case where B0 is requested ("hang
> - * up").
> + * going to be using, except where %B0 is requested ("hang up"). Likewise the
> + * @port structure, except where @save is %false.
>   *
>   * Locking: caller dependent
>   */

...

>  		if (baud == 0)
> -			baud = max(min, 9600);
> +			baud = (port->hup_speed ?
> +				port->hup_speed : max(min, 9600));

Outer parentheses are redundant. Also use Elvis.

			baud = port->hup_speed ?: max(min, 9600);

-- 
With Best Regards,
Andy Shevchenko


