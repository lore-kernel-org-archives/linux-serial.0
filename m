Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F9523C511;
	Thu, 12 Jun 2025 13:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749735236; cv=none; b=dPveYG1I3Kser9GNlnpxifgKY2u1q6anumeB9AE91i9jV5esAdd8q1w7top/GFbeNwH/Ua6kJNC4FI92VdekqeTsxAALh+6T6ABGhXbrVWaXeBnKLGz9a23BdsjL7JXWqIlo1OprkQVBbfN2ERKbayH5CenxTNKld0g2uSGjo78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749735236; c=relaxed/simple;
	bh=bdb9LtT3INJ2a+afM77uCeHvvb4maVgfYaghkxMbZMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFnrSpKzWPtrzsc9D9cLT0ZGBBYLw8pKJb82byDXQW3FRSObQ5+NtTMqav0F3R7cBx7DRyWQDg4wXGyqYUKf2VeZFfalujLJaKp+TWBFiFsPPv+4oEotPPRVTRUv/T8yD1n7BvLWDNVdWRYdxEWmQuZs55OVb55PD5yjCq000h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G5Cn19Rk; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G5Cn19Rk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749735236; x=1781271236;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bdb9LtT3INJ2a+afM77uCeHvvb4maVgfYaghkxMbZMw=;
  b=G5Cn19RkFtLyPu3sMJyAq71qzSPMZJj5lqToPU8pxjAxrQEvjbBGMgXe
   8uBPG9b1VcJJ70hJXL5k8/XwdCggE+hXRbnrRIQiGrDlT97fyuqoGNo7D
   +/sa9kGLK7AZOSU1s7Xd/yyLA0atQApSDv4RvFJO01FqC/CjqDQkgw+65
   wLBuo/cHLEMV6nN6Z/GZnD/Yvl60+yWQVhHOT1WybCdJ+FP43XyaptS5s
   ezMjIui0GsKmfvF6G99EgWENv6KGOMRqClBhUxt5xFfPue7WJfTVUh1Ad
   LmlH7WyMohOq5OYNXUVajOPXjvR0VbQrl/NK+vKYu1DithSE/LUOiDvzL
   w==;
X-CSE-ConnectionGUID: NScrW77QTsKy9WbPW7kDGQ==
X-CSE-MsgGUID: XpOkeNRkRF+Etcg4cnLL5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="74448335"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="74448335"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 06:33:55 -0700
X-CSE-ConnectionGUID: typpU7OkR8Wqck2yRVVc0Q==
X-CSE-MsgGUID: a3rBX2C/QVeqsIl6KyuLkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="147406514"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 06:33:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uPi3z-00000005xfe-0jFz;
	Thu, 12 Jun 2025 16:33:51 +0300
Date: Thu, 12 Jun 2025 16:33:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-serial <linux-serial@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 23/33] serial: 8250: extract serial8250_set_efr()
Message-ID: <aErXPu2YTXxMcg4p@smile.fi.intel.com>
References: <20250611100319.186924-1-jirislaby@kernel.org>
 <20250611100319.186924-24-jirislaby@kernel.org>
 <2b9d3171-6a71-ad9e-8a73-f07487f0ad6b@linux.intel.com>
 <451ac044-6e91-4895-a5b3-cb30396436e5@kernel.org>
 <3bf97628-fb30-4298-bfd4-1ec819a43340@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bf97628-fb30-4298-bfd4-1ec819a43340@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 12, 2025 at 12:04:27PM +0200, Jiri Slaby wrote:
> On 12. 06. 25, 12:01, Jiri Slaby wrote:
> > The question is whether we need the code or we can drop it 8-).
> 
> As it is now, we could drop UPF_EXAR_EFR altogether, right?

Let me check. It might be that there is a lurking regression nobody reported so far.

-- 
With Best Regards,
Andy Shevchenko


