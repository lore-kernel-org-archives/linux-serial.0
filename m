Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397E6175D21;
	Mon,  9 Sep 2024 09:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875646; cv=none; b=bAoOalX1Ynf4rhTv3PMy0w4epSV8RJrG+SdIlRFd72Wj+dTIU81HvHcC+z+wVUbv6LiECbzXbucRwO2f9LeUxAcbDv/uQMtJblx8vbabT/VRdEkkEtI/Bbh30eTVvPtFEY3kd9vcMn/qXUmWOfBssGK100bDMglLvYQg1o5cQ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875646; c=relaxed/simple;
	bh=nTtt63xtEzL0HIZ3KB72uhdfQ7X6mOcbDEDn3v89uBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hF52dC2TFVL/XZ3G9VGlzbQ4EU4BSVJwaK/xLAXrmGzQ6XcM5eodolgp4S64v1jHTrm2ZDsQf//4gj/2nBT+5LXwv32Gy3gNy/43eLndxylxCXYmTEJwYAOF7w7c4iBkFWERr8CBrM9mLC7HAYDapj6Lp7NFBk6uX4wKIG7H5N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aDcgu3E3; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aDcgu3E3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725875645; x=1757411645;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nTtt63xtEzL0HIZ3KB72uhdfQ7X6mOcbDEDn3v89uBE=;
  b=aDcgu3E3LgyvK5DJUR0MVO3St2jlowiNfsB1GZ88vgLEInAyeurZdlV4
   wreQTQHGSUlgneppkQOjgvg8h3px7+7bJwYP1Wxb7QBve9aKFTSuYEanH
   A9OM5Tik1M/xwjpixIQeyuF0LroSgty6A79m4nBjkMDAkJS0XSaVTSO8P
   tQIZFiLArfdksCstvqEgFppizaJRNxShwM2E+ZBmXc8w1QaXmF1zCuQHa
   HZAqBm0y4YsJMkYbBQG8lSmlLo3YEbbAdXjvgZVCOKdNc4s8fbI3H2cQR
   cglqbA6+ZHtTo/UdQ6zqB+VOJzipt5GchsJjGfy67h5B+v2P1YFidddMZ
   Q==;
X-CSE-ConnectionGUID: NcpSzqVVRtGONDRPiT2xug==
X-CSE-MsgGUID: hAqB5CaNRv6flgi6cAU2xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="47085008"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="47085008"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 02:54:04 -0700
X-CSE-ConnectionGUID: lWB3RRrORWybZJeunzPa3Q==
X-CSE-MsgGUID: qQ5Kuz+8SJ2OtGZIQC5m1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="70730433"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 02:54:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1snb5n-00000006k0v-07sM;
	Mon, 09 Sep 2024 12:53:55 +0300
Date: Mon, 9 Sep 2024 12:53:54 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH next v1 1/2] serial: 8250: Switch to nbcon console
Message-ID: <Zt7FstSsthuxtpEz@smile.fi.intel.com>
References: <87jzfod9f2.fsf@jogness.linutronix.de>
 <8734mbdwrf.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734mbdwrf.ffs@tglx>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Sep 07, 2024 at 10:39:00PM +0200, Thomas Gleixner wrote:
> On Fri, Sep 06 2024 at 18:44, John Ogness wrote:

...

> I'm 100% that this is just a problem of blindly sharing this with the
> regular uart code and not because there is a requirement. See what
> serial8250_console_setup() does at the end:
> 
>         if (port->dev)
>                 pm_runtime_get_sync(port->dev);
> 
> The corresponding put() is in serial8250_console_exit(). So there is
> absolutely zero reason for power management in the console write
> functions. It's the usual voodoo programming which nobody noticed
> because it did not immediately blow up in their face.

It might be historical, but yes, the above is for a reason.
And if somebody needs a kernel console to be shutdown, they should remove
it from the active consoles.

-- 
With Best Regards,
Andy Shevchenko


