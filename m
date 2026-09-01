Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196F337E5EA;
	Tue,  1 Sep 2026 09:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788253225; cv=none; b=CQIp0rbqD+Sq9r3BGdWRkh82TfAnPysdlQn6g7+EBYIqZyWLdo3Pd4R1wrxrlUI4rGGLmItXNOYI6JxVsTl5HFxUgnXupUfSojLL9ZLr/YIRowdquh88OqlEdOk1/SNGpx0936Hw7AMSSnxVDp8bvKh+JS5lHWY5mCCTyluEi2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788253225; c=relaxed/simple;
	bh=jhKnp48MumRxrJSL6BBAENzeNFA+doX003JwTMrUgbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SP2Ufe8iKSUeo2LbDjeYTy3+lAxpG8Z3Ic5QOvefcwjlAnk8cLDz8Ai7RQQ0nd+ThCzfV8nfrvvF5tD5e7uN/fkP3fjbkYjh8dclX+th2SAtJYLh8GQpfeWG2YGOWRjVz5VdrdNYMn12arZbowaO+hxIJgQ2Dz1oCyhTi+qvMak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mibMU2Fi; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mibMU2Fi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788253225; x=1819789225;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jhKnp48MumRxrJSL6BBAENzeNFA+doX003JwTMrUgbg=;
  b=mibMU2FiPvKyI5serBdqqk//uWwoIuHcPJGcD03gFUoqZh664O7zSP/n
   +oc7/YSuCF7oqiyMA9OQoEKc7qdkd4EFV1712hZeby3AgKl20zemSK5/Q
   SnBdTiQJ7bq4CAjBoKrntQvwc+A7a546OBKmHe5t98lnpre8DfFCsJhNm
   YhvfjH2ltnlYjnUWu+liIh0Bdy9JdvTb26+OXMgIZhSwQzA+w6d579jCV
   Ngjucu3VdQMCy5axeJdfZF8cwoIXxk5uZh9P+oaL2lDeeT7UT1qpjUfCb
   6kebVh4CmT5YcdWMeA0ibCbtI3JuHnrByZtQbHHKvaw4mHX+LxCmaYZUW
   g==;
X-CSE-ConnectionGUID: FRWHl7zIS1ecb0HOEnm7DQ==
X-CSE-MsgGUID: bpkL65orSi6PAjQDdaFQfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88882673"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="88882673"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 02:00:24 -0700
X-CSE-ConnectionGUID: xaz8KOwEQeSoAjCHRyJ4kg==
X-CSE-MsgGUID: L5kC+/SSSU+ErZzCuJqk+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="272825160"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.222])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 02:00:21 -0700
Date: Tue, 1 Sep 2026 12:00:19 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	Lukas Wunner <lukas@wunner.de>,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] serial: 8250_mxpcie: only unregister the ports
 that were registered
Message-ID: <apaUI8OdGQZ_dJ5O@ashevche-desk.local>
References: <20260901041519.114737-1-lilinmao@kylinos.cn>
 <20260901041519.114737-3-lilinmao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901041519.114737-3-lilinmao@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 01, 2026 at 12:15:18PM +0800, Linmao Li wrote:
> When serial8250_register_8250_port() fails the loop stops and the probe
> keeps the ports registered so far, like pciserial_init_ports() in
> 8250_pci.c this driver was split from.  What the split lost is that
> function's priv->nr: mxpcie8250_remove() walks all num_ports entries,
> but the ones the loop never reached keep the zero devm_kzalloc() left
> there, and the one that failed keeps a negative error code.
> 
> serial8250_unregister_port() checks neither, so removal unregisters
> line 0 - a port this driver does not own - and indexes
> serial8250_ports[] with a negative line number.
> 
> Record how many ports were registered and unregister only those.

...

>  struct mxpcie8250 {

>  	unsigned int supp_rs;
>  	unsigned int num_ports;
> +	unsigned int nr;	/* ports actually registered */

I would make it indented with the below comments.
But no need to resend for this. It's not critical at all.

>  	void __iomem *bar1_base; /* UART registers (MMIO) */
>  	void __iomem *bar2_base; /* UIR / GPIO / CPLD (IO) */
>  	struct mxpcie8250_port port[] __counted_by(num_ports);

-- 
With Best Regards,
Andy Shevchenko


