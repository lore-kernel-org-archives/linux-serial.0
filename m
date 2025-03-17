Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E95D215046;
	Mon, 17 Mar 2025 07:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742196321; cv=none; b=A65C3k8eeM79EoHfyAh2/DCxdIu8IIbV+/j7lLoVVgVIP1E9XNvrptbYCPNWiyplb55ARN7eyvhqclG5LYUzm8owH++AoGD1Q2ZOrXqTD9OmHDcAEYK8NG7GNfaeII3Hk7dIVACWDhcE6rOsF0eNyQXYRbn54t8KdX5u8YbH8mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742196321; c=relaxed/simple;
	bh=SQ3aQHK/R5aXylk6u6ADSjtXUE05/8nCsoOT8V+akm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVN5DESLgOqzMozAQIO7fnr+KT8c1Ngo6lumzbWotnyi4LH8LZdQJQbmE7mjRIl64+DP06QRjyg4X8eZQz8lH4Ogfr5unIa1EWgk/IbHxBz3KLNuPNXLzgACg2s1AVhH7VsBDyp5TmCtH/V68es+NI8ShTV4UsIiMNrwHskg5c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ck7xdoP+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ck7xdoP+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742196321; x=1773732321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SQ3aQHK/R5aXylk6u6ADSjtXUE05/8nCsoOT8V+akm4=;
  b=ck7xdoP+QVzBp3364q6IaQoYpYHsI/MV8wbGwpi9GHAQ8tafUpuOd04G
   huOzsn2jwSNtLsKRm9vQyz5aOL8a/xiMeH9PMWQswV4uGs0fsNrc5Q43u
   R9CqjeSUFJo3ugn/klLNvCS9/KqZGedeUkWCZkeXQi1M4cGERpl2CRvNM
   74q1EhFpYs6e7R4P1HE33Ej6Jfltgyee9g0D9+NxlzSx1FBmAwOYuJ/u0
   jX/dc+kteOf32jqhJmUqv1oh0YheOpAu0KfkpOJkmsaTTlgHeDK8Qv8Tp
   YT6akpqdTeI+72BlcdcQjJPN3ZdPOq1fC2pAbRh4RiL4tqIoCABVAu5DU
   Q==;
X-CSE-ConnectionGUID: Cno9N1Q+Ta2hsdNzZ7caBQ==
X-CSE-MsgGUID: uaN2QaytRGa5Uy8E733n4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="43188043"
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="43188043"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 00:25:20 -0700
X-CSE-ConnectionGUID: i//2C4NgRiiadOgXf6NCKg==
X-CSE-MsgGUID: vw7g2Wb0Q/KEQCPvdmooOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="152783901"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 00:25:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tu4qZ-00000003Em6-3ZjI;
	Mon, 17 Mar 2025 09:25:15 +0200
Date: Mon, 17 Mar 2025 09:25:15 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v2 27/31] serial: 8250: use serial_port_in/out() helpers
Message-ID: <Z9fOW2eZ4bEdlOzu@smile.fi.intel.com>
References: <20250317070046.24386-1-jirislaby@kernel.org>
 <20250317070046.24386-28-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317070046.24386-28-jirislaby@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 17, 2025 at 08:00:42AM +0100, Jiri Slaby (SUSE) wrote:
> There are serial_port_in/out() helpers to be used instead of direct
> p->serial_in/out(). Use them in various 8250 drivers.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com> # 8250_dw

We also discussed adding some comments. Would you like to send an additional
patch or do you rely on me adding them?

-- 
With Best Regards,
Andy Shevchenko


