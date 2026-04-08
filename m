Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4364228CA9;
	Wed,  8 Apr 2026 13:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775654562; cv=none; b=dU1nZuAFFKgAvN4ZEdrLxfkAFJmSBQAo6jG2Myb9AfTapgDAG6S8ru/+olNpB4o9H2Q0Rjr5ngI7yRP4aGJRoh9r4XnWUicsGTbChtScRuyL+VPRYnDyc744cNUuJfNqi+VgV8jeg4l46HDWurFYnWk3xdWCNlDmew8b75mEcG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775654562; c=relaxed/simple;
	bh=J29XLJRA28eBXxHTx/pC3Rh8pizb71b5qFqjzHKzGA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEuWNiD5PmpL5CAGrUH62nIuvqIYdo/MxPTD/opeSN0FtFn2CQaO0GH2GJkmKhtvVKagnfmPqRFzDMsnGdq6kILTNxFMO86Ykk7O0QlADjlLjSl7Bu2788Nuz8KXrhAfoQWh4RaTG6HmZV6QZeiX/KJTp6TiAMcwDOctVvaOQeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ey7RNjQi; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ey7RNjQi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775654561; x=1807190561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J29XLJRA28eBXxHTx/pC3Rh8pizb71b5qFqjzHKzGA8=;
  b=Ey7RNjQiajpR+9R0KkZzWe74rBpshHSN2aIKWzq0p1tSy9pypN5tKgeS
   T7SgGXCZ6uQKLthB3/QPjdIVcK4eAJV3UClTJrp/uUigAT9vZdYBZYA2f
   +xzWbu9T8cF1fbdmlKvLb89zDaZv7SFSVpcQN6MQSpwroic0AlAhpMtk+
   Mo0D0G2VqG/UfMCPbOOYDE81Fo9CE4+xGrtihc4opPvmz5ngGmGJP+76g
   bNQC2S+Uvv4l8w/5tnoRNE5w7DfHmiXdwRIcFKetk5orYv3LRWmKEG9wx
   AM1RgQcsruucwzjCpnYo5+gHslCP9VE7ez35LgwW1fJqh+0BYdx5mAkuX
   w==;
X-CSE-ConnectionGUID: 2jMFxzkDTLeiPviWy+dp2w==
X-CSE-MsgGUID: tH+F71TWTNyBSlCaVybMHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="80231404"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="80231404"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 06:22:40 -0700
X-CSE-ConnectionGUID: 94Z9PfgTTaq1a/zGP39X3g==
X-CSE-MsgGUID: +mV19kwNTeOpOZtQO56EDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="251615153"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.72])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 06:22:38 -0700
Date: Wed, 8 Apr 2026 16:22:35 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Zhaoyang Yu <23120469@bjtu.edu.cn>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, kees@kernel.org,
	fourier.thomas@gmail.com, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, gszhai@bjtu.edu.cn, 2426767509@qq.com
Subject: Re: [PATCH] tty: serial: pch_uart: add check for dma_alloc_coherent()
Message-ID: <adZWm7GxCU_-T0zc@ashevche-desk.local>
References: <20260408072421.831-1-23120469@bjtu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408072421.831-1-23120469@bjtu.edu.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 08, 2026 at 03:24:21PM +0800, Zhaoyang Yu wrote:

> Add a check for dma_alloc_coherent() failure to prevent a potential
> NULL pointer dereference in dma_handle_rx(). Properly release DMA
> channels and the PCI device reference using a goto ladder if the
> allocation fails.

Looks like it deserves a Fixes tag.

Also ideally this driver should be converted to one of 8250 cases.
The latter has already DMA support. Note, if you are going this
direction, I have the hardware to test.

-- 
With Best Regards,
Andy Shevchenko


