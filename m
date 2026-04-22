Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4BB27732;
	Wed, 22 Apr 2026 08:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776847619; cv=none; b=ujVVnV8H0VnBBAuZr5Kvu77wStZsUM7I67h+acV5Pw+7I25xgy4bNCj4qAEyHUJ2ntSaCWia8TvlTv1erWmT8flt6gpPuT+nsnLe3DEsrVZ8C4/zaz1yNWmQy4Q6FFY4yvXPfjfRbjzt3yqBRUeitkEtzaHXiPfj1ap6zAGDbLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776847619; c=relaxed/simple;
	bh=vM9sm12mnI72E842Q8bydmFKMswrt99MkGPaRQhHRH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRzAuJ43DvJV29EadufvUcTcRcerNDKzdmLEKIUDGk4oG+eFhuKPQXUebAxpWhNX1akgIniHvSW/+h8Fl8e5qfMtFoyEbBQBv6oESfuQPO8pjljuZk3tMZJqzQ4phzv9LuEE4qIOI5D3ItAmLnhyr1zXagFdCqjSNJ8ssWQ6q0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jR91IguD; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jR91IguD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776847618; x=1808383618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vM9sm12mnI72E842Q8bydmFKMswrt99MkGPaRQhHRH0=;
  b=jR91IguDOPt9YmIV2ySc3bxkgvNryNWpnDHLodJ5OI+C9VGLMGgL6qE8
   as24z0F1i5YrI9eWAgymi6t0YFXsqxcMoynh/XQ3VUSX158A1Amzk528M
   6re6XbHe1Vv757xpx6MDw/klk5si/wcvx0/yiBI928sbpeeDAqjpjZEoQ
   Ls7NHFqV51oItRiZR1ddCJF62GO3N49ua7JrhEXf5fzAg987TA+xpLMXH
   aMt7712M56dfkT48Psk0Ne8FcOoZsntQuJL57DAIH/y0P6Bqpp+zVjdtZ
   CjsJIO6QufWYxACPdg4cVEJNYMQRh0pQRGZYQBH/7ggu7NRLwutYtTqCi
   g==;
X-CSE-ConnectionGUID: wjyQhf3RQ3yX/o9pB2K7TA==
X-CSE-MsgGUID: DtIRg3xZTWmO1JNI/woJrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77862003"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77862003"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 01:46:58 -0700
X-CSE-ConnectionGUID: 65oSOmPBSSis/42Og0oeyw==
X-CSE-MsgGUID: o6aT+++ZQ2ijp07hj/FQ0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="231410362"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 01:46:54 -0700
Date: Wed, 22 Apr 2026 11:46:51 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jia Wang <wangjia@ultrarisc.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
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
Subject: Re: [PATCH v3 2/2] serial: 8250_dw: Use a fixed CPR value for
 UltraRISC DP1000 UART
Message-ID: <aeiK-350Uozq3pVa@ashevche-desk.local>
References: <20260421-ultrarisc-serial-v3-0-3d7f09c2420e@ultrarisc.com>
 <20260421-ultrarisc-serial-v3-2-3d7f09c2420e@ultrarisc.com>
 <979c9543-3ea0-25de-f97b-9c6d2fa3ac61@linux.intel.com>
 <177681947637.2697678.10937675549830278979.b4-reply@b4>
 <aeiKsv3bFPJ94InI@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aeiKsv3bFPJ94InI@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 11:45:44AM +0300, Andy Shevchenko wrote:
> On Wed, Apr 22, 2026 at 08:57:56AM +0800, Jia Wang wrote:

...

> > Just to confirm: since you mentioned that the preparatory patch moving
> > the DW_UART register defines is already in place, I don't need to move
> > them again, correct?
> > 
> > I will update my patch to use the DW_UART_CPR_* macros and
> > FIELD_PREP_CONST() accordingly, and I’m happy to add a separate patch in
> > the next revision to convert the Renesas .cpr_value as well.
> 
> My understanding that you want to send a patch series of 3 patches:
> - moving DW_UART_CPR_* values from C-file to h-file
> - modify existing Renesas case

- DT binding for new HW (patch 1 of this series)

> - add support for your HW (this patch in updated form)

And I forgot that you have a DT binging one... So 4 patches after all.

-- 
With Best Regards,
Andy Shevchenko


