Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3B519E839;
	Fri, 14 Aug 2026 08:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786697632; cv=none; b=kXgx6J7Nak+D6KloqEw/50Zs775lxu9ieGX++9XWejTZ4oBnkNJgm1RbnKUAYiuiJJ9KVIoFs2Zefzmf9W03DLbAO/UwQuIamfXKvBQcUcbN5pfnXS+BeQaUimbSnxS0QF6N+e0ygmIH6n95h+jVHz2Qn5WSgv7wvXAoJJascxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786697632; c=relaxed/simple;
	bh=DnhcwNnwlcyKQ2spT5xCGOydkrovj/Cy+Ap2rn9VX5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzD0k4y0KdF8OwNfF95cHbWLaX6DOa3OTXihAFU1sFcsj9yszEmULI7ZU9lHt+epRGvb0FVh0TuePmHtUtQnV5g1xCHg7Z0zkskwtBK9VW+9wiKcCMFvcKKxkpGgXSIiDgKHL1ls+ZQLInnzjUPkzFgxdySmhGOgKAE0zWPWq6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBjFmEA9; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBjFmEA9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786697630; x=1818233630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DnhcwNnwlcyKQ2spT5xCGOydkrovj/Cy+Ap2rn9VX5I=;
  b=HBjFmEA9uT0qKZLXjtRhJ9rOFpI81UVt5/EOibxrKBBXUv/1RknOikPw
   OlsaX+DpX+gcot8S24GFgD1IxkAwcuDgTMhMWfZH+f2nog5r38gZphZKa
   4sX6sMOQSBQTMQUf7sxTgyyusXf/ZyD2GrIoDLQvNGBDAQXDvyEs+uR4d
   erIZQGLlM/BAgPno2FIeY+cQwvKpjWfvrYS0LUKjE7tQ+faiO7ldAA7HQ
   3y7u3FiM6C6wFD7wdJUGk6R8DjfJQKcMswGtdFQi5LjB8MJu22kxgj+gT
   8QtrUojKIZYMhIAcG7e1CAmfzOMpl187UOWkRoYb2gVIa2Q2/DLbKJKw4
   g==;
X-CSE-ConnectionGUID: A5wQ5rVkRf+0oTBO5SoU7Q==
X-CSE-MsgGUID: iNFKfznoRwuALTWyOY2kGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87039328"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="87039328"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 01:53:50 -0700
X-CSE-ConnectionGUID: Gk61uU6/T52dbWnh+K1DWA==
X-CSE-MsgGUID: mWDPMdVEQr2tOQ52mDVVjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="262420320"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.134])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 01:53:48 -0700
Date: Fri, 14 Aug 2026 11:53:45 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: longzhao@ambarella.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] serial: 8250_dw: add Ambarella CV75 quirks
Message-ID: <an7XmT5Wg_QeFwzk@ashevche-desk.local>
References: <20260813-cv75-v3-c-v3-0-9352b3fd6026@ambarella.com>
 <20260813-cv75-v3-c-v3-2-9352b3fd6026@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813-cv75-v3-c-v3-2-9352b3fd6026@ambarella.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 13, 2026 at 06:35:13PM +0800, Long Zhao via B4 Relay wrote:

> Add CV75 platform data with an ETOI IER mask and skip-set-rate so the
> DesignWare 8250 driver can drive the Ambarella UART for console use.

This is way too cryptic commit message, we need much more details.
What's wrong with HW implementation? Is it integration HW bug or some specific
case of the IP synthesis? What is happening when this patch is *not*
applied? Et cetera, et cetera...

-- 
With Best Regards,
Andy Shevchenko


