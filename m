Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998E12D321A;
	Tue, 24 Jun 2025 14:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774329; cv=none; b=VAORIai9T1210yFZXtlEFrYoe5OuHt3yaEhcsBjspX7Yww63Rt4T95eHuYhhPI35eaZ/BVS1mYbor6D4fzYBF08cr/nVVmxW50GxLOJ2KfsukNJGNsFeeC9tbiXuRavLT+8GUTrkI/H2nZrZgf+o/6hrlcxsUA+lXWQRqjTUrK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774329; c=relaxed/simple;
	bh=4dm738puZ65QLTh1P55lsRhIe1MAbrJwqSEKF9VP3/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBnURJ8q/+Wzi0iz5xnIDKShQFsiIlm3b/iulrXTezTZOHjl8j4UEYsr+AkURFOLIekd3DVnDoGzpfzNZsIC0977EbI3aptm/tlSsvGGBrZQcLfJg0YfL+vZrWHn10Yscc13PuAG8zhA3gDFAVDccpitjae7M+BORhdHtiuzbyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J+EBbfyl; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J+EBbfyl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750774328; x=1782310328;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4dm738puZ65QLTh1P55lsRhIe1MAbrJwqSEKF9VP3/o=;
  b=J+EBbfylPT8duSwa7tNGfo5Xv6RHFo4mLMeJruvWRl2PcoVnKUH6MhVH
   m1GmwwJPKwia3IwOMHhY+C+TKp9EtdWbp1BP222ekRzA4ZaR5s3jKdqW5
   OhERNdpRfLvdgIIJ5sOf9S1Jx1M9Y+jQG/BXRi4b8NCFX3TGkZk2049aP
   1zFvKl+UNF9li9FEvdcPrRMSq9WrNkzuYJiKDD2oEMkc2NeJB3hV1cT3t
   5UlUDd8KFUDlLHUtkBtnTnFJNI4WTnmX6O32VYECgfzJapPXvjHGE9ijf
   HmScgwl+SFojH2yJh59Ardw4RAeNTIXvVFuUQFKy5rtcITjh125nwEUyM
   g==;
X-CSE-ConnectionGUID: Fq5CM6gmQ+eNNZY3JpS9rA==
X-CSE-MsgGUID: QsiHW7CsTCmpJyfc1tNqPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="53150686"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="53150686"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 07:12:07 -0700
X-CSE-ConnectionGUID: 8ZOIuYKkQGymaEdHLXfZnw==
X-CSE-MsgGUID: gMcqmGEqSQKlAZAVTf9w6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="152092947"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 24 Jun 2025 07:12:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 58B6E224; Tue, 24 Jun 2025 17:12:04 +0300 (EEST)
Date: Tue, 24 Jun 2025 17:12:04 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v2 3/5] serial: 8250: rename lsr_TEMT, iir_NOINT to
 lowercase
Message-ID: <aFqyNIQMED6ora95@black.fi.intel.com>
References: <20250624080641.509959-1-jirislaby@kernel.org>
 <20250624080641.509959-4-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624080641.509959-4-jirislaby@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jun 24, 2025 at 10:06:39AM +0200, Jiri Slaby (SUSE) wrote:
> There are already variables like 'iir_noint1' and 'iir_noint2'. Follow
> the preexisting lowercase naming of variables. So s/lsr_TEMT/lsr_temt/
> and 'iir_NOINT' likewise.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


