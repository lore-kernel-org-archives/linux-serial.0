Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F12E3C5848;
	Mon, 31 Aug 2026 07:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788161558; cv=none; b=tlW4SsllXKcBPdA4pUILW1UlWaZyzXHGWusVpUG3pUnIiZyTUuxiAS9GvjQ239HEfXeNXd3OtZwYR1kVlcQZH8ESS+laNf2UrHK6ig/ta91SQD/9opvyrA9k5ZrlljNke9C2uuzZPnIHhzig2HHztkw3SxnajojRTAHnfbn+K0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788161558; c=relaxed/simple;
	bh=0N1rgXgHf09DO9EAlnqYl9uNiSxR30hkyV3WKM02KU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mq0xS8RtX2PITUVQ2SoZrXzYSNViH5fVm/kHUl4aVrtfDCgMndwNA487HiwoWbbBUSrEaH+LBMURoLCIlTu4Pvj0b6A7yxpvBZLdy/6jBBUBtm2tQp52SJrMJ6M8meV8UVVkq1BcyuMipk60oE1F6JOlCw4mVOh52T72KEDkESk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IiiiQCf6; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IiiiQCf6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788161557; x=1819697557;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0N1rgXgHf09DO9EAlnqYl9uNiSxR30hkyV3WKM02KU0=;
  b=IiiiQCf69QHAReS2RFcTMhs7EhG/nrfcLm+n9EksbSwmD+GkJbsikcJd
   CgGNoUVPA7AfZ6mVEObywjfk2oezt8wuz4uNWFex/ChUjs4chKTEsNbG6
   2FKozLRIGpAxKiM+ggaA+lepVtkc261ihKBGaI7pdCX70t90OiOMMHfNQ
   lzBg4G3cIeWptp6ECxpRZ4Lgc3LhaaiJA6CcpP2dNnqsoso/MgK1L2GFN
   04Y6IdL4ufWG3jBAfVWo3Zs+hUg0ZK+X1U1volx21fDlDGTANSBcMLZRP
   dpd/XF7bQinLMWRnYlR6nQq7oU3TjM5qPQ3ISojvGs/2WIb8UGXdMVxaW
   w==;
X-CSE-ConnectionGUID: Uu2IKeDAQWKpmazizRQJ7g==
X-CSE-MsgGUID: j2hGR6lASSGizskgDJ0/CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88684729"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="88684729"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 00:32:36 -0700
X-CSE-ConnectionGUID: lcE0xSgJQ52Hwm9yUN8hWg==
X-CSE-MsgGUID: IC/Uq6JeRmGEotTVYwm0VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="264434673"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 00:32:34 -0700
Date: Mon, 31 Aug 2026 10:32:32 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tate Whiteberg <whiteberg@arista.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 1/2] serial: 8250: export and rename wait_for_xmitr()
Message-ID: <apUuEHzKEBreO9JB@ashevche-desk.local>
References: <20260828175733.1650267-1-whiteberg@arista.com>
 <20260828175733.1650267-2-whiteberg@arista.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828175733.1650267-2-whiteberg@arista.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 28, 2026 at 05:57:27PM +0000, Tate Whiteberg wrote:
> Export wait_for_xmitr() and rename it to follow naming convention.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


