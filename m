Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF8537F72F;
	Thu, 24 Sep 2026 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790258992; cv=none; b=Q+sijBKdNBpOOAxouHPHPJ7Oe2BYfsLGs8XkbVpnHTBignWjBEWf/pgipy7SJyofwvdRG9cXY1/LIAG0lGvIQRq7GTnWbP7gFta2LhUvHvnN6SwNh6moNLhtt0qHa9TcBNi4Tq1SuwAe5klUxeL4ow4wMyQdoG5Fo8h5tLHIac4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790258992; c=relaxed/simple;
	bh=qmudZkLU3y2eB9AF20M5NWcb805vn2pIDkdPZYgefvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zr9jiVnEhsPugg9cSppFcNL3G2rx0Opc2OwR7yUDVkSuSKIffjgKfK7Ogr145nKnLbirP7xHBHzbwxCms6QQsDfM6CaLveVyssjxtVyx7HTLdfwK8tASkQGDZjM3r/JaeDujkXnhPms0V3tXXBJnQM/Ulm/U+wid+EfvtFKhMNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XI/qYiJE; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XI/qYiJE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790258989; x=1821794989;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qmudZkLU3y2eB9AF20M5NWcb805vn2pIDkdPZYgefvU=;
  b=XI/qYiJEYlU33z83BtgM3bj0m75a1wnfcndfXxAiBaoYJV47gy9wKJjc
   2fwpjgzRBSWubmAM6B3S5MffUQcn5Lxc7qTNx7ULHEpiywcveOZ4L9B13
   Nt58f9kONz1cRw45IafM5gmFg/WGph54LSokjbyZ4BvsqFwcoOi5DK4zn
   aeTguGPCk6VXCTdiXXrIFiQBL0Ah+CrbYYPXXc+uaikfNLQa1t4a3dWL0
   bDVFlNPPBnA0bh2/p+fTPX4d99ZGVaJsR7gVPT5dgLHMY035cG/HmjD1q
   OavFmwPxHjSYMVN/Nea1J3IUNZi/aFz8OcLlhDfx+IoIloEzpyeJ59rEr
   Q==;
X-CSE-ConnectionGUID: II88SuwNQjqahOzZ2BkDIA==
X-CSE-MsgGUID: pSGqU5NIQbakp/2HhzgOvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="91136565"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="91136565"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 07:09:48 -0700
X-CSE-ConnectionGUID: Eueu/XtoTVq6U3pNjO4tjQ==
X-CSE-MsgGUID: mhCt5k8VQoujcrhULBFUFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="311951219"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.199])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 07:09:46 -0700
Date: Thu, 24 Sep 2026 17:09:43 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Malathi A <malathi.a2000@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] serial: 8250_uniphier: Use devm_clk_get_enabled()
Message-ID: <arUvJyvChXXcasSu@ashevche-desk.local>
References: <20260917040511.103232-1-malathi.a2000@gmail.com>
 <97e4ab26-b147-4cf4-97f9-307903f14e61@socionext.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97e4ab26-b147-4cf4-97f9-307903f14e61@socionext.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 24, 2026 at 06:07:37PM +0900, Kunihiko Hayashi wrote:
> On 2026/09/17 13:05, Malathi A wrote:
> > uniphier_uart_probe() enables priv->clk by hand and is then responsible
> > for disabling it again on every error path. It misses one: when
> > uart_read_port_properties() fails the function returns directly, leaving
> > the clock prepared and enabled. The neighbouring path, taken when
> > serial8250_register_8250_port() fails, does call clk_disable_unprepare(),
> > which shows the leak is an oversight rather than intent.
> > 
> > Rather than adding another manual unwind, switch to
> > devm_clk_get_enabled() so the clock is released by devres. That removes
> > the error path entirely, along with the explicit disables in the
> > register failure path and in uniphier_uart_remove().
> > 
> > The clock is still disabled and re-enabled by hand across system sleep,
> > which stays balanced: only SET_SYSTEM_SLEEP_PM_OPS is used, so the
> > device cannot be unbound while suspended and devres always sees an
> > enabled clock at detach.

...

> I'm a bit concerned about the error path in uniphier_uart_resume().
> The clock may have been disabled in uniphier_uart_suspend(), and
> clk_prepare_enable() can fail when trying to enable it again.
> 
> In that case, wouldn't devres try to disable an already disabled
> clock on detach?

Isn't there is a guarantee that the .remove() is called with PM runtime on and
get, meaning it's called with the enabled clock? But if not the case, we might
use PM runtime force operations (resume and suspend in the respective cases.

-- 
With Best Regards,
Andy Shevchenko


