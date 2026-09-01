Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ED937D12F;
	Tue,  1 Sep 2026 09:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788253473; cv=none; b=F2X5DrqNd7Agpr4ZraogffVTY24IOFkGVm9MYcwfYSNr4txHJcrcWsHb1M98EPvpgyOWNN4rGlMGe41DXSFM0/xTaVNNm2zZl2r2i9ptnRwXwGcbdl+APS2M4Crnfki1A6w9Au1FcbjQhLC0FZfWk10kGibUEGvN9ZZphO/+8QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788253473; c=relaxed/simple;
	bh=eOAi17v6Yx81TaBUID7TWraTuslPto6OhDJSi5JpI50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SX5oHcYwxcOh4v+++V7Hu0gUZmX7YvyhllaiqMjnEQ6YRleo6i4XFmUD0OEhCUMyxqBP9rMwD+yS7q6+1Cftmkt5uOI2jMZmKcIQh/Hr9KTDhJEGYyKbExUGseBtb7lB9zvYUFdB2edXNXlM+QGDJW4c3f7+uo6Qy8s5SbtVyx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LA6WVxuI; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LA6WVxuI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788253472; x=1819789472;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eOAi17v6Yx81TaBUID7TWraTuslPto6OhDJSi5JpI50=;
  b=LA6WVxuINDWDDNYUwxcP8s6PNBMI4tMEpaSWmT1mbDuX3bRWzfwEM6wn
   gbuWAXWAbpu2pifkfBUPLy0AVNymLe28XFv8mtN/8gwhJE5mXYwNILntD
   oyClz5WD6ZgyyVvuJF68BIaKCfDa8d2gp6eKWHJ+9oIzem49Qf8vFXkRV
   p7hucrGTqOedX2kKdBSIkHfvtSDSH/wDRR3dA7IvO8he4YCBlmYkdrvXi
   sID57dxYCydjMikf/r6+7nBi6+m/EXRYz2qwalOBB/XIFpPgwgWtJ7WZw
   /CXdxDvpLk2ibRF094CW1VslUQDfn6LUwr+wpBCZof+fN70sRnrpAVyfq
   A==;
X-CSE-ConnectionGUID: wT0fVv+zSWCHf/NQj/cW6A==
X-CSE-MsgGUID: YkfCXe3LRlu5GM/BxvG56g==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="92491263"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="92491263"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 02:04:28 -0700
X-CSE-ConnectionGUID: nCiT6clSS3GTiepogiW+6g==
X-CSE-MsgGUID: sI9vXNqfR+GZU109RpFu3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="273223456"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.222])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 02:04:27 -0700
Date: Tue, 1 Sep 2026 12:04:23 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tate Whiteberg <whiteberg@arista.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 2/2] serial: 8250_mid: wait for LSR tx empty before
 setting termios
Message-ID: <apaVF6oy9qBOPiNa@ashevche-desk.local>
References: <20260831165911.2029839-1-whiteberg@arista.com>
 <20260831165911.2029839-3-whiteberg@arista.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831165911.2029839-3-whiteberg@arista.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 31, 2026 at 04:59:08PM +0000, Tate Whiteberg wrote:
> If mid8250_set_termios is called while data is still in transmission,
> the corresponding register updates will corrupt the transmission.
> 
> Fix this by locking the port and and waiting for the transmitter to
> empty before performing updates. It is necessary to wait for both
> UART_LSR_THRE and UART_LSR_TEMT to ensure the final character is sent.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


