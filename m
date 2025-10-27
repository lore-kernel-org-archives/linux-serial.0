Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4038A19ADBA;
	Mon, 27 Oct 2025 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761566306; cv=none; b=I88fnmQ+eIZoEEE35du80Og+kz+pHL8is62FolPov7W6KB1J1LyLmvNiefMB/82uKpHOx9GFO8iy0apKW1YlynYHAiaf1JaeZiwGls3lDdG6wY7QKjQUiKVppNMJLI5IEIfZbk4S7Txk5X6olE1IqxKomWNsrkWk/ONBScP19fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761566306; c=relaxed/simple;
	bh=w/UO/W68Cm10DsjF7HmKVRsaBa7OUUxkf2XREL2VF1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPE/Cmwyzoijid+Ojs2S7bCknJnfuNY1yKRorIGk78DuCGc4TkNEj7FqL0DdkvvgiHvy6fX64Z8ZqJ2bpl7yt0AKC5d3fUc6CKqLcgST/+QjEuhFtoRfC/SUv4NnVQItoBEoeKU4CUyJvK3jikBlTbo4OX4dKIQJJqGZLkTYCSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k5LuGWPl; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k5LuGWPl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761566304; x=1793102304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w/UO/W68Cm10DsjF7HmKVRsaBa7OUUxkf2XREL2VF1g=;
  b=k5LuGWPlsgy/fdSMd6sZH+PerC07Vwq7FiG9Rp+/SBUpOjyCGnAeXFG6
   92bwE58JLEmz/BSCfWYWUwS0y0O/w96BlD5JcM36scZ1VfDL+RMrMQFQt
   bPM3fUOwSYT/NlVliqNXS7m5z1Z+iy9IdYc4ssOtYBxhSuwmwTCgdzgCV
   gzfCmAcHQSVHvAdvmFTUVGolS8+1i7VWPkrG9jc1MptJ9bXuhjuc/9hLh
   2sZ2bm9zscCU9rpXcAgTMMAny0N8e7Rzd9S/aw5auzS1PpzcWfAJFcO3O
   XHlpJUvFeMRhs5oYfXb8ZJlJf1bMW/4IWVHBFU0I0ty25caafRGLmXjgr
   Q==;
X-CSE-ConnectionGUID: Xu3cbVkXTcGTfDocfnJQ7g==
X-CSE-MsgGUID: SRhH42SJRfW3/yFExppykw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67476464"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="67476464"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 04:58:24 -0700
X-CSE-ConnectionGUID: XiDPrFBpT6+HPgF0HooBvg==
X-CSE-MsgGUID: HFJZ4FlMTDaObE7SLFwubA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="184646604"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.5])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 04:58:21 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vDLre-000000030Kf-09Yn;
	Mon, 27 Oct 2025 13:58:18 +0200
Date: Mon, 27 Oct 2025 13:58:17 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Florian Eckert <fe@dev.tdt.de>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	pnewman@connecttech.com, angelogioacchino.delregno@collabora.com,
	peterz@infradead.org, yujiaoliang@vivo.com,
	Eckert.Florian@googlemail.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_exar: add support for Advantech 2 port card
 with Device ID 0x0018
Message-ID: <aP9eWRLzozuPtSv3@smile.fi.intel.com>
References: <20250924134115.2667650-1-fe@dev.tdt.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924134115.2667650-1-fe@dev.tdt.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 24, 2025 at 03:41:15PM +0200, Florian Eckert wrote:
> The Advantech 2-port serial card with PCI vendor=0x13fe and device=0x0018
> has a 'XR17V35X' chip installed on the circuit board. Therefore, this
> driver can be used instead of theu outdated out-of-tree driver from the
> manufacturer.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


