Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343C5137753;
	Tue, 16 Apr 2024 18:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293918; cv=none; b=b8GQpaoy2UJVUj0Xf4Bn4FURTn4BHFzbxz/hLpFjP7xoJDL2jeEpLbQBfPdASOuUxkPEY3usOMWsVRKo7TFg9n8zpRSwcKtl6NjJh7Hi5dfIuOOH1ow2VLQ+9dvlerr/MqEfBmmggKbU9Kk/uVa3DEFvsPJXeg9bs2vqKNedH6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293918; c=relaxed/simple;
	bh=8aks7pZpPQU+hw07GeHFVRYiu3MNvPTJQWMNAUMXbWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTew1/cqTMBcawcHT+pV9diVafqZtFJmczMavnOn8r2JSE/64nEQD47W36+kK6cIirxnVpAIZASsuuwas41ykgtuDxUs9X8w06CA7PUY9E47eBXMY2GLE9QhOasaduH+hQ2kXwrOEMvHM7bFYklpR9hF8WO53QDc92vJemAmxkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XfliuoNi; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XfliuoNi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713293917; x=1744829917;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8aks7pZpPQU+hw07GeHFVRYiu3MNvPTJQWMNAUMXbWE=;
  b=XfliuoNiifXTrleuFedToZDaz1acf360sw05lk6KXn5Bwk5jEaYcl0nO
   fP8YBwJEXdxgjCAOEXykDu1y637f9GxoyRTy7pxGO7fxPck0ChVp5Tz2N
   GFGIZxW8YMovDTDYDfLUaElISio7G8ijrNtoEoLPQaeqtv5Wq8cwEFARK
   DPI3DfwxBcKucpkrPHiDWBjjwA13JWMHpdQnkVRBpo1GJKBowZBr1H29s
   bTeg7fvmeYImuRVckNdw5P5vjM88G8AsJ1vZ1BloGMseGkTemGIvtM9dL
   dt5bqt9wH5W8ctaLakdbY2/a1RG19wmtDfuJHt2U4n4fXPP/zxMgs1ZTt
   Q==;
X-CSE-ConnectionGUID: 8+fnvlcFQjygcm+PK2AdGw==
X-CSE-MsgGUID: 0pDG+gG0Q1u6dRbKOuXDbQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="26265808"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="26265808"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 11:58:36 -0700
X-CSE-ConnectionGUID: rwYZ0Pp0RtGW7VKPEHxu1g==
X-CSE-MsgGUID: /AIjiDVRRQmHBFs3K2R75A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="27153913"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 11:58:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rwo0l-00000004nVD-2B6C;
	Tue, 16 Apr 2024 21:58:31 +0300
Date: Tue, 16 Apr 2024 21:58:31 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michael Pratt <mcpratt@pm.me>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Wander Lairson Costa <wander@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vamshi Gajjela <vamshigajjela@google.com>
Subject: Re: [PATCH v2 1/3] serial: core: Store fifo timeout again
Message-ID: <Zh7KV0FuM2B56J7w@smile.fi.intel.com>
References: <20240416182741.22514-1-mcpratt@pm.me>
 <20240416182741.22514-2-mcpratt@pm.me>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416182741.22514-2-mcpratt@pm.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 16, 2024 at 06:29:28PM +0000, Michael Pratt wrote:
> This is a partial revert of Commit f9008285bb69
> ("serial: Drop timeout from uart_port").
> 
> In order to prevent having to calculate a timeout
> for the fifo device during a write operation, if enabled,
> calculate it ahead of time and store the value of the timeout
> in a struct member of uart_port.

...

> +	if (port->fifosize > 1)
> +		port->timeout = uart_fifo_timeout(port);

	else
		port->timeout = port->frame_time;

?

>  }

-- 
With Best Regards,
Andy Shevchenko


