Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA9F38A733;
	Wed, 29 Apr 2026 10:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777459320; cv=none; b=UBr6MIS+zCpc13u0DbfnovxltTmA5MXigfwYdWNVXHJsEb+m+dbwYDg02HKVVwUcgBl2zeBeMP1Ph3Wish7Xpwl16Mzh05zslPcu8+vBEcWebMSQVhDT09YLbBIWDRC3J3M8vdpsoE2bXRhSffXMhlj8r6IgIN8BV6WeCyr8VRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777459320; c=relaxed/simple;
	bh=trmwBBkDWpO0fSOMjuM/vf1YShwF5t0TrTPuiUZYNA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ow7hJuWQQYBgj6g17rRtV0JiB+XZylNzOKLaG1708t9GOKnhPm2Lgkz7T/sKkMHXfcRB6nn4bP7wWOsNlq6/HnyHNNqSLGacJ93vuQHht3AjIaCQyuXrryrSAJsioSCMF/EUBWOk7zRz6Z3uHZxbwjah6fanBYy24/0VN3kkuQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U6cLAl90; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U6cLAl90"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777459319; x=1808995319;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=trmwBBkDWpO0fSOMjuM/vf1YShwF5t0TrTPuiUZYNA0=;
  b=U6cLAl90641CJoBONJhdnIv+XqOFEnzfdFlc7Ci5eY3DweRDrdb2BLEC
   I9TicppPtCUb1oF9aLLJx8BgEqAa/KY6RqTIHzrzQ1EFZ1zm9vcUScIiR
   Lq8mSIbRQqYHw7BdXHMqXRj+urH1a08EPIyTA+Rss61/aIMgV/nuWgEfs
   la3jQdrv/WAOXYud0tyNRRanMs3HmJPQshecPLDpRhI+SDe649+Si8ebr
   o0JlG/7wg9bgZ7TAx8ijUx3+ixiW/xExDC1b6U65nzlqna8tphHI+tmmy
   M+VhUsqXW4wtE2hHaeHWUSQIDF/5N3kWw1eMVkYi32owGds3SqaBkhOBk
   A==;
X-CSE-ConnectionGUID: JuFuVqDyQK23FEHU2wdLUA==
X-CSE-MsgGUID: zgQQpPsBTOKDq/UIbqb/QA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="95804153"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="95804153"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 03:41:59 -0700
X-CSE-ConnectionGUID: krg+Q5ibSZ+1BXRewDGTRA==
X-CSE-MsgGUID: Yi3C6kuIQjan3QijMyh2Yw==
X-ExtLoop1: 1
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 03:41:55 -0700
Date: Wed, 29 Apr 2026 13:41:52 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Jia Wang <wangjia@ultrarisc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/4] serial: 8250_dwlib: move DesignWare register
 definitions to header
Message-ID: <afHgcBOV-CveGNTG@ashevche-desk.local>
References: <20260429-ultrarisc-serial-v6-0-b2c852e0c4c3@ultrarisc.com>
 <20260429-ultrarisc-serial-v6-1-b2c852e0c4c3@ultrarisc.com>
 <36efd2f5-d050-c613-77bf-dc651a94a586@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36efd2f5-d050-c613-77bf-dc651a94a586@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 01:38:44PM +0300, Ilpo Järvinen wrote:
> On Wed, 29 Apr 2026, Jia Wang wrote:

> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

There is v7 already...

-- 
With Best Regards,
Andy Shevchenko


