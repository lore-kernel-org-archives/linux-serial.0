Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822F772631;
	Fri, 23 Jan 2026 22:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769205921; cv=none; b=uVpKviuSpYzvRyyClL5wtFi+j24S5E0iUHN5xWK9aaeFSmZp+rSU1van1aVmWjAVuesgvl46nD4ZsgugwpuXE8FlHElLXTH93FVM3dM26deeUZsc6iFZ+mQZ2aSuLWYkxYgy4hJFki1Ap5YMTRpuOcI4hloTU0eeZhGGgd+BEw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769205921; c=relaxed/simple;
	bh=VmjzkoC3eH+h0dArfqgmnR1yMf7HY3lkUF8meobDtlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzDVTn0MeOFYMdtvIrAXJenbXtQy0IDtpt/+tRalkcPAjV5ZmBAllMktBWqehTGQTeJ1wSzFcISTcAtxI/s+z41HE+d7PO9gjQT8WvXdIIXOfA6idgWL2T0axT/pLzszNXxNtHML+1uoceoYLuXvumFtkNoGFwKw4dD2v1gEAGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UrHBcPks; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UrHBcPks"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769205919; x=1800741919;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VmjzkoC3eH+h0dArfqgmnR1yMf7HY3lkUF8meobDtlE=;
  b=UrHBcPkscXhuY76HC2pP3+XhvA2Gn6evq3xiG9BI/bUD1pOqKUFrT83Y
   vP9w0PHPQL+vYkiL0uC3brg1Mb+3Dm4oldHXzdhwU5NLMEbhtOmteJvjZ
   jHOgxtCf/HSQdbiKjB2GV101PN1pfFDj2lH3X2FUwzb1avqjE43+gMl2D
   YZQrtoF0cAB/NT8WovUEh0yBzvOtt75Mzbw7qwbwCuQIVmEUWCnBAFDWq
   yXVIMZi25h7txrSEQ2W6+D3j901TnZMvIbsz/Pq56yCkvOI8TDl6TJ5gz
   STtqh7yTxY+dxPbXxt9N2VEtU2FbE9wPA4VBytq0CMQgJ298ki6RqfbvB
   A==;
X-CSE-ConnectionGUID: 9vbpnBKVTRCq3LmdnjyPCQ==
X-CSE-MsgGUID: I3isLPQ6Skas0eNOl67ChA==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="69659705"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="69659705"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 14:05:19 -0800
X-CSE-ConnectionGUID: M31zFIRcR5e6Bt7DaGVdDQ==
X-CSE-MsgGUID: eoM+cRpzQ6iVOqA6uBu5Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="230088997"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 14:05:15 -0800
Date: Sat, 24 Jan 2026 00:05:13 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	qianfan Zhao <qianfanguijin@163.com>,
	Adriana Nicolae <adriana@arista.com>, linux-kernel@vger.kernel.org,
	"Bandal, Shankar" <shankar.bandal@intel.com>,
	"Murthy, Shanth" <shanth.murthy@intel.com>
Subject: Re: [PATCH 3/6] serial: 8250_dw: Rework dw8250_handle_irq() locking
 and IIR handling
Message-ID: <aXPwmfqPlUkI2zuw@smile.fi.intel.com>
References: <20260123172739.13410-1-ilpo.jarvinen@linux.intel.com>
 <20260123172739.13410-4-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260123172739.13410-4-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 23, 2026 at 07:27:36PM +0200, Ilpo Järvinen wrote:
> dw8250_handle_irq() takes port's lock multiple times with no good
> reason to release it in between and calls serial8250_handle_irq()
> that also takes port's lock.
> 
> As serial8250_handle_irq() takes port's lock itself, create
> serial8250_handle_irq_locked() that allows caller to hold port's lock
> across the call. Take port's lock only once in dw8250_handle_irq() and
> call serial8250_handle_irq_locked() directly.

Sounds to me that the latter can be split to a prerequisite patch.

> As IIR_NO_INT check in serial8250_handle_irq() was outside of port's
> lock, it has to be done already in dw8250_handle_irq().
> 
> DW UART can, in addition to IIR_NO_INT, report BUSY_DETECT (0x7) which
> collided with the IIR_NO_INT (0x1) check in serial8250_handle_irq()
> (because & is used instead of ==) meaning that no other work is done by
> serial8250_handle_irq() during an BUSY_DETECT interrupt.
> 
> This allows reorganizing code in dw8250_handle_irq() to do both
> IIR_NO_INT and BUSY_DETECT handling right at the start simplifying
> the logic.

...

> +#include <linux/bitfield.h>
> +#include <linux/bits.h>

+ cleanup.h

>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>

...

> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c

>  #include <linux/ioport.h>
>  #include <linux/init.h>
>  #include <linux/irq.h>

> +#include <linux/lockdep.h>

I would still keep more order.

>  #include <linux/console.h>
>  #include <linux/gpio/consumer.h>

Giving the context we have, the better place for a new inclusion is somewhere
here.

>  #include <linux/sysrq.h>

(Also perhaps sorting headers in a separate patch helps with finding better
 places for the future inclusions?)

...

> +EXPORT_SYMBOL_GPL(serial8250_handle_irq_locked);

Wondering if we can start exporting with a namespace...

-- 
With Best Regards,
Andy Shevchenko


