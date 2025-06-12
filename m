Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA1A29B79A;
	Thu, 12 Jun 2025 18:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749754494; cv=none; b=IdZdxOs7E4qc7m0Lzl0tGd9eWixW0FfoPrjy7LlBOxdMKzdaAhoFo/tCZCqFUOJzRHHR4cw6O6Ca6y25hbfc/FBwzsNJmJyyoNQk2uWRZwkx79w8Umu5UoYvn05hc/OnFjmQ5UJi3sxnjytd7UYzgFEqLkHK6rt0La/pOPK3e44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749754494; c=relaxed/simple;
	bh=lfePTXVUN2Ht8uLROUbSnk7CkJZjs5kA7w04NEe/MoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdnTqO/7EHuLh0j94XSKJ/0nl++HW3NitfpCX/AFOXM6ISnBRDhEvQqJ5LdC9nyDuBlKhBJeAQrMC18d5GdDlj1emGfU+GvcqUnszQq8UX7HhVH5U+2GnTpIxdzxPtuE8txQMZd7AYToU3pDKuIB4c5wwNVJ4Ii4TyFY5mvflik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D4WoitBO; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D4WoitBO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749754493; x=1781290493;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lfePTXVUN2Ht8uLROUbSnk7CkJZjs5kA7w04NEe/MoU=;
  b=D4WoitBOvLqINV3uqkDvkF29m4FIhk3L8E6i5nPQgzDCnYBvoi1XdFA1
   vAV7ZLxrnentCnUP2c0CWkJaPnzK3Sht3v6s+PniBNTu9P9RpM/Dh8kAJ
   i41uEMUkBsiM0bo/mrGB19o8Qib2ZdmGqkpma5VJMIDV6xRtG7QxLjgcU
   LvToTHgQgEp/J1a2zzxmEpnbpeAvE+NBVSeqlqcL/fWx4Jjr3OlY0TCpS
   4S97o5S+2DcVC7AodvMKfSBAyzL+UfpRjBTu/Bgbip0H0MQcqaAMVigmY
   mJyAzyn3twGFMNXfmtqp/IU290raL67+B+ZAfeNhgMlZ5zRy1qj5zWjlm
   w==;
X-CSE-ConnectionGUID: 378oEY2+QC2q9CbDj0SQfg==
X-CSE-MsgGUID: XjQpt+5VTbygjdXzyTBbsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="51937762"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="51937762"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 11:54:51 -0700
X-CSE-ConnectionGUID: 4tp7QYufS4mY9BeXxNb9bA==
X-CSE-MsgGUID: jB/ST098SDegAo3678fRvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="148506384"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 11:54:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uPn4Z-000000061bR-1nrM;
	Thu, 12 Jun 2025 21:54:47 +0300
Date: Thu, 12 Jun 2025 21:54:47 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-serial <linux-serial@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 23/33] serial: 8250: extract serial8250_set_efr()
Message-ID: <aEsid-cr1SwHJWV6@smile.fi.intel.com>
References: <20250611100319.186924-1-jirislaby@kernel.org>
 <20250611100319.186924-24-jirislaby@kernel.org>
 <2b9d3171-6a71-ad9e-8a73-f07487f0ad6b@linux.intel.com>
 <451ac044-6e91-4895-a5b3-cb30396436e5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <451ac044-6e91-4895-a5b3-cb30396436e5@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 12, 2025 at 12:01:29PM +0200, Jiri Slaby wrote:
> On 11. 06. 25, 14:58, Ilpo Järvinen wrote:
> > On Wed, 11 Jun 2025, Jiri Slaby (SUSE) wrote:

...

> > > +	if (port->flags & UPF_EXAR_EFR)
> > 
> > I wonder if it is possible to trigger this at all? Only 8250_exar.c sets
> > this flag and does not contain UART_CAP_EFR at all (nor uses
> > UPF_BOOT_AUTOCONF)??

The file indeed does not contain it, BUT it sets it implicitly (via port type).
So, this is not a dead code. Please, do not remove it.

If you find a good way how to move it to the 8250_exar.c, I will appreciate
that solution. Ideally 8250_port.c should be quirk-free module.

-- 
With Best Regards,
Andy Shevchenko


