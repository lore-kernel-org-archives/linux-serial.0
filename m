Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6664126982E;
	Thu, 13 Feb 2025 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455162; cv=none; b=V8w9NMBR+Y8F6XGPGvVmIX4RLflQNQlUc4AKDdQtQPAFKS1fF+aUJrl54DD7jjxL7HXbt53fjsVy3qGTXvakaltjcFg3UNA7HTazdzEH2fgXeXcZqy3J4VrMGMZsvEHntenD+XKH7Jo8gXU5yyOz3M12g2NmVSJx60zvu3zUL8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455162; c=relaxed/simple;
	bh=M1wZSTlysra8qn4RUhjimztIhsfk5rrbCEkwkFbEduw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pozEgjl6/0VaPEG+PzdaFfq/s+xiqh7qxw+agIuUJHdIG8UGfKBMFBWadjr1wI458qbkSwGu5L3yUDq//NacBGcTnq0zc4bbWL/cM9H4E/NZTParX9NU0jx2olHhv2UU8Q93/+hpETRx03dP8/EwYQRUUFo9P5ZGd7YIZhVOfPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QcbxM6gz; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QcbxM6gz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739455161; x=1770991161;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M1wZSTlysra8qn4RUhjimztIhsfk5rrbCEkwkFbEduw=;
  b=QcbxM6gzLdZcDa3Cj95Tdky/avqRrgx9NQPOUgmETW/gRwBzaGIi1Oi3
   i/darvnPpVVe7HMpRzl5FtEDDUjQOYtJtapaqLfnqR+FJm2lcevuz1uJw
   +0ZWeFreuxu8xqVZX7WvafUV8Xde4T2ZLtPBBiOWhEXNiqJ6GKKA50Q0R
   ccAyrPWZqRDSZ+xX3Huqf11aHCAl5VQBhFiEAoCnKDgX3x9704C/Ycy8U
   PrdQocdZOTlAP1Qx3u9COe+aEERzDlvgEKpxnkagvQA0HL+0eokb1LfTX
   YbXipuv+oz0V8za9YWhfWylxogz1YERizmZq/kZOjlYlR/B9XOJyYAdBb
   Q==;
X-CSE-ConnectionGUID: ktMyIf2jSxadjndoJt1k5g==
X-CSE-MsgGUID: tty55IUPQGiRTP0rAEm5/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="43807187"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="43807187"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 05:59:20 -0800
X-CSE-ConnectionGUID: QT0KT4bSRIu59xZB+6WNGQ==
X-CSE-MsgGUID: gVufrTrsREyvbArL7qnigw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="118236766"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 05:59:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tiZkI-0000000BBEX-1KDE;
	Thu, 13 Feb 2025 15:59:14 +0200
Date: Thu, 13 Feb 2025 15:59:14 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kartik Rajput <kkartik@nvidia.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, thierry.reding@gmail.com,
	jonathanh@nvidia.com, hvilleneuve@dimonoff.com, arnd@kernel.org,
	geert+renesas@glider.be, robert.marko@sartura.hr,
	schnelle@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v6 2/2] serial: tegra-utc: Add driver for Tegra UART
 Trace Controller (UTC)
Message-ID: <Z636stK76iRkubEV@smile.fi.intel.com>
References: <20250213125612.4705-1-kkartik@nvidia.com>
 <20250213125612.4705-3-kkartik@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213125612.4705-3-kkartik@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 13, 2025 at 06:26:12PM +0530, Kartik Rajput wrote:
> The Tegra264 SoC supports the UART Trace Controller (UTC), which allows
> multiple firmware clients (up to 16) to share a single physical UART.
> Each client is provided with its own interrupt and has access to a
> 128-character wide FIFO for both transmit (TX) and receive (RX)
> operations.
> 
> Add tegra-utc driver to support Tegra UART Trace Controller (UTC)
> client.

LGTM now, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


