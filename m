Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10AA407CDF;
	Mon, 20 Jul 2026 19:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576595; cv=none; b=lNmCm7aDuGNPDYXfW5H0oFSIiL5qE41P/3xhriAKR7Aqt3U2SNWXjbbKdI6xnl8/0UlPLCzgB/A+n3SbeYovhhxSe570h55qlUuMlfGS1nm3zfnKmoD+zye/b9rF+fWb9yZN+sCYD1jV3oiYog2gbSPiiIBldqTCXNthqVhoSzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576595; c=relaxed/simple;
	bh=74ds1yjJJnXxK+pQwI5nGM6LJeP5zq63cq79OZNK0qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMhCpUU/XJu7Ajr8ePAzfjmaJ3abkHYcAVULp4yIPiwkBtWvn1J/vZN/U+/dpk7FBWuWb53lSvdi4vJ7a4GVTdKIxDX0gZhx8L7Mk5oC1DnMdcPlbeqME3le31Q/Ifxnnw55W0DLrkcBsko8dMvhpnadeF1SkLZk9soYrBRpRJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ajEiJgnw; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ajEiJgnw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784576593; x=1816112593;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=74ds1yjJJnXxK+pQwI5nGM6LJeP5zq63cq79OZNK0qI=;
  b=ajEiJgnw53hUPU3Ajqdb/w2ZcyfFP+pYp6OPhPtT4uv/vUwZ+uy8PjzJ
   S8xbv99qwmjS935aqkBZjne1gCqUv14QZf4wnq9V6Bp3iXk9xtSpxKVJa
   rgWCXl5RCoht2Wxw2BQpp40Zg/I2xAiub4bfF+rxyuRydXxeKaLCnARG2
   Md3gTZUmm5ymunQif1bFJ9G3Ri4u6TXJdewtFaj/IiokJhyxjoQg3Ujuu
   7FzrTqCcq/WHS1V9jMnKBIaoGM4O85fvmReSIvXY2FEBWaYQ2AicRq2Xh
   PHrLcpSfddEk9gXMt0Qq0vvwYBg1r0XHTo6RasDi/hIj5r5+UhYR5qqeV
   g==;
X-CSE-ConnectionGUID: b+40qe3sSlCDsxgcHNZ4+Q==
X-CSE-MsgGUID: srC+BZiERyWV6V8mFbEDRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85044054"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="85044054"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 12:43:12 -0700
X-CSE-ConnectionGUID: 9VF7ceKvR1G9raqaGHyRww==
X-CSE-MsgGUID: 9gLfs4CdTVG0UPsWjUs1lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="261112870"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.175])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 12:43:09 -0700
Date: Mon, 20 Jul 2026 22:43:06 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jacques Nilo <jnilo@free.fr>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH tty v7 2/2] serial: 8250: Revert "drop lockdep annotation
 from serial8250_clear_IER()"
Message-ID: <al56Smrak4OZKh7s@ashevche-desk.local>
References: <20260720135407.3925-1-john.ogness@linutronix.de>
 <20260720135407.3925-3-john.ogness@linutronix.de>
 <20260720140312.M_LGafRy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720140312.M_LGafRy@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 20, 2026 at 04:03:12PM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-07-20 16:00:04 [+0206], John Ogness wrote:
> > The 8250 driver no longer depends on @oops_in_progress and
> > will no longer violate the port->lock locking constraints.
> > 
> > This reverts commit 3d9e6f556e235ddcdc9f73600fdd46fe1736b090.
> 
> If needed, could this be please replaced with
>   3d9e6f556e235 ("serial: 8250: drop lockdep annotation from serial8250_clear_IER()")
> 
> instead the bare number, please?

IIRC this is a requirement for stable that they will able to find the reverts
without having a Fixes tags.


On top of that we may add the standard format into the commit message.

-- 
With Best Regards,
Andy Shevchenko


