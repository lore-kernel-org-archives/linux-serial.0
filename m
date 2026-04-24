Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBA531F98A;
	Fri, 24 Apr 2026 11:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777029189; cv=none; b=Ww6o49ue9w4/0V7Q7gmwZL4EB+X/nnO3kjuSjmTblMymxCS8hkbxC+Ott9MsNSdtvGS6dly+Xk70W06D6Vhv/bHvn8TvWKiDO/+ppkDfIeF1XUDBVet888fRdkSUE5Hj3Qf+sUQH80ZKX6o9RdV2hPDThPu7Xz2ML27T9ZGKcGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777029189; c=relaxed/simple;
	bh=FSJFGbvZjT6STWIkJ/8L2rFBb+CmXIHXXm9QMCB7Ytk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nHBzpu8mBlo9ja+UIPeswe/8WvYCGw2FXhVy4CaAcYWQuALmN04Cvhlx3WZoep0hMtLuXqPhI+ftrTdO8KAY26BJXq0Z60DYPqJdGCl+F3XUjMWmrChhw5utQRW357b8rrdRoidbQpEaAFC8A07dz6VnM8J+5/6rOVoG8ulMoaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NzIaxYeQ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NzIaxYeQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777029188; x=1808565188;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FSJFGbvZjT6STWIkJ/8L2rFBb+CmXIHXXm9QMCB7Ytk=;
  b=NzIaxYeQP7CoERIMiI7Bbcw9HOnGA0U0qi0SZWR4/11Cj1ohjawh6hdD
   JgERAApKQgYiLSmx6qDulE4JOWk+DmJ+QF2z4NI6ZwxTW/v5HnhLon8ZA
   /EHPEgKuUeaeJQ++Zdl7+PBgzfPfQEcQj/qNRxD4dciRzsF8yhvKJjGpW
   Y/sNbOD/Ck6I4CNYH7PO5GJCEtTw1Y8fwqO9PFj0Ln35NyGHRHa2yJCPb
   Edjjip1zGtgppsL+SORUX3h1PVk9FZEjOhzAhL/TVIfvDnqvHgPlllezr
   OF6bi96tuE1qpKzBunVxjaqZDz8m/R8+3aZ5Y584/Hbq9S6ZnsoTqWCCt
   w==;
X-CSE-ConnectionGUID: gp+/C2/qSsykq48f4z65Sw==
X-CSE-MsgGUID: imw/8NmhR0ezTt/3oPoFjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="89470396"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="89470396"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 04:13:07 -0700
X-CSE-ConnectionGUID: E6nZn7E/RQquBITm7XsulA==
X-CSE-MsgGUID: YaIyuxJ3Tmmeggy3gP89ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="234720486"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.120])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 04:13:05 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 24 Apr 2026 14:13:02 +0300 (EEST)
To: Hugo Villeneuve <hugo@hugovil.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 2/9] serial: core: use uart_iotype_*() to simplify code
In-Reply-To: <20260423-tty-upio-v1-2-baf82d3b86d1@dimonoff.com>
Message-ID: <716918cf-b240-43cc-a702-9b3d94dc75d2@linux.intel.com>
References: <20260423-tty-upio-v1-0-baf82d3b86d1@dimonoff.com> <20260423-tty-upio-v1-2-baf82d3b86d1@dimonoff.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 23 Apr 2026, Hugo Villeneuve wrote:

> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Make use of new functions uart_iotype_mmio() and uart_iotype_legacy_io()
> to simplify and improve code readability.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  drivers/tty/serial/serial_core.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index b1cf45a8fc854cd97e349ff077d83b42e3ef8b16..fc273f8f9e75de89dca1ac1aca3589567bcf8a18 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3221,23 +3221,17 @@ bool uart_match_port(const struct uart_port *port1,
>  {
>  	if (port1->iotype != port2->iotype)
>  		return false;
> -
> -	switch (port1->iotype) {
> -	case UPIO_PORT:
> -		return port1->iobase == port2->iobase;
> -	case UPIO_HUB6:
> -		return port1->iobase == port2->iobase &&
> -		       port1->hub6   == port2->hub6;
> -	case UPIO_MEM:
> -	case UPIO_MEM16:
> -	case UPIO_MEM32:
> -	case UPIO_MEM32BE:
> -	case UPIO_AU:
> -	case UPIO_TSI:
> +	else if (uart_iotype_mmio(port1->iotype))
>  		return port1->mapbase == port2->mapbase;
> -	default:
> +	else if (uart_iotype_legacy_io(port1->iotype))
> +		if (port1->iobase != port2->iobase)
> +			return false;
> +		else if (port1->iotype == UPIO_HUB6 && port1->hub6 != port2->hub6)

I suggest placing the entire hub6 related check (including the iobase 
check) into own function in 8250_hub6.c and add a stub for the case when 
hub6 code is not even built into kernel into 8250.h.

> +			return false;
> +		else
> +			return true;
> +	else
>  		return false;
> -	}
>  }
>  EXPORT_SYMBOL(uart_match_port);
>  
> 
> 

-- 
 i.

