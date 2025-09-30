Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502D12367D9;
	Tue, 30 Sep 2025 11:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759231974; cv=none; b=g6g6/Cmsb6A+wRc70MQ9ZIlb0bGyi0p4Jn0eK/rMo1G7KNkAgUhI7ChvDvOrRAt3YNnw7JtTfbyguPCIA7xJvNofmndN3rcjYc3XYvooEH2OVDuL04UleHuFh28/8H2LBrVYcReC7JW2zNYeYO0ZgUES/2XmcYmM8eYje26yg9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759231974; c=relaxed/simple;
	bh=QNzQUuzt+n/Y8L5GRObqG6QhK8SEDKB46XoSHnMaC/w=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AsuEbYaV6plZuvOBZRHm5QWRu7CF3p9dZiaQsi6PkGcgsRc8pdkIgkm96cS57tZfbReI1vAu4QdbEYTirqgR0TmE3I1auZ/3ayOuwsooyJP9z5ozc9ub7HjyON+eKdsvnhlC1OI/XNeZBzuKJyNpfZKklVhi05oFTIl07mwf90Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mU7GCjxs; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mU7GCjxs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759231972; x=1790767972;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QNzQUuzt+n/Y8L5GRObqG6QhK8SEDKB46XoSHnMaC/w=;
  b=mU7GCjxsQle51rvCdibJY//GAtckyJeUfUus3xGTTqwGbkVdB5WgHVD4
   QZ31QvqYm+ntTM3dc4fJPE+jV/NAKBrtU7qGDFFhTgsPH0JvztWm2p2My
   Z/xmOqBkTi43E8/hVBwKcq/nLXeHTrWehrGya6xl9jtare0yruOAxt05I
   62L9v3UX6YUmqB5Q7knSFlJ/A7WRFNyvF82pgsUl0BxW24+hsRdlFL9Iz
   ffjFMnFVzFt+OTzSbumEdHWvDf0+0ZK2fn0/AwEPP/cf3INTl4Xa++DEI
   c7VZ8Th44Qtrw3ZWcrCOEqTUuDx2BnXrFm3uK5zJoV6+Pff1zuNHYYQaA
   w==;
X-CSE-ConnectionGUID: n3sCiNQhSMSZqMC7Sh08BA==
X-CSE-MsgGUID: SxLnmyPVQYqa8rrBgwecNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61398677"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61398677"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 04:32:52 -0700
X-CSE-ConnectionGUID: lCKdeSPgRXu1zLAhCVn4xA==
X-CSE-MsgGUID: 6EcawpvTQIaTPmRKJSOIdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="178076783"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.162])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 04:32:49 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 30 Sep 2025 14:32:45 +0300 (EEST)
To: Marnix Rijnart <marnix.rijnart@iwell.eu>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, regressions@lists.linux.dev
Subject: Re: [REGRESSION][PATCH] serial: 8250_pci: Fix broken RS485 for
 F81504/508/512
In-Reply-To: <20250923221756.26770-1-marnix.rijnart@iwell.eu>
Message-ID: <0ab2436f-5c0d-966f-7095-d281292c494c@linux.intel.com>
References: <20250923221756.26770-1-marnix.rijnart@iwell.eu>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 24 Sep 2025, Marnix Rijnart wrote:

> Commit 4afeced ("serial: core: fix sanitizing check for RTS settings")
> introduced a regression making it impossible to unset
> SER_RS485_RTS_ON_SEND from userspace if SER_RS485_RTS_AFTER_SEND is
> unsupported. Because these devices need RTS to be low on TX (fecf27a)
> they are effectively broken.
> 
> The hardware supports both RTS_ON_SEND and RTS_AFTER_SEND,
> so fix this by announcing support for SER_RS485_RTS_AFTER_SEND,
> similar to commit 068d35a.
> 
> Signed-off-by: Marnix Rijnart <marnix.rijnart@iwell.eu>

The Fixes tag is missing?

(And Cc stable tag will be necessary as well).

> ---
>  drivers/tty/serial/8250/8250_pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index 152f914c599d..a9da222bd174 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -1645,7 +1645,7 @@ static int pci_fintek_rs485_config(struct uart_port *port, struct ktermios *term
>  }
>  
>  static const struct serial_rs485 pci_fintek_rs485_supported = {
> -	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND,
> +	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND,
>  	/* F81504/508/512 does not support RTS delay before or after send */
>  };
>  
> 

-- 
 i.

