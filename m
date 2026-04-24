Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685F53BD641;
	Fri, 24 Apr 2026 11:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777030752; cv=none; b=MbT1Sdy/oeeEZPgx2wJskHkwICVl7AaV4QlgeyGm9doTqivRv5h4dxaQ66qzzPt/g73r+0BLGdwQZ9AAZw/ul223KAVClZH5kQ5/mko7hCzSOPjJZ4YZy55lH6MdcdZ78FSBWNFIqVkMD5C2uTd//QxRJk4aGtXjk3bcaV4qQsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777030752; c=relaxed/simple;
	bh=D/JQitqjD6I5FjQx/yh8niVoP84MDIoT3P1quuCU+uI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mYMipHqAy3BcGF+dG4d+lxLhJY14U5iQ3LEqo9MSuH+++0wHru1y8lyRjP6ktjn45cLJA0gM8C9IR0QjDVGQVIEuZEh9a4u/GB5nPHm6hv4M+Sh30N/ceD38IdCzMRSvSWJ7UwviFUUGWLUMgBTOa+djGYxCoOX4KcV8FexRcXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DK4x1zke; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DK4x1zke"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777030751; x=1808566751;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=D/JQitqjD6I5FjQx/yh8niVoP84MDIoT3P1quuCU+uI=;
  b=DK4x1zkezZljV4J2CZKvUjoHU82s/RYCcHW9Ad0dQbvz//JiB+550pxG
   /dJbmDqC4XUbWjpOuIk03loGnzhLqYuhgayjfukEqT/jRsf+DGcDntC3J
   eBXrf0x+X3ZdHB6WpuZzwZKzZ30k3thNRagHeB0kp/pc6lA0Br9X3wJnl
   rnOVpU8r9UR3f48VM6j324LzoJOzComMVc15642tT2kC4/eLv4g+4wzWK
   sayYe5/G8e70nAFG0+bKR0uxqtyAg77YjZHuQM6Y24HBSxegQeuqthou+
   NvzuPjcAD8bqmWu64LfUkRwRU7AaInDmiMS/DYBjyuBgvaxin16pNwNo5
   g==;
X-CSE-ConnectionGUID: V7JM/r0vR325UgdqCZk5pw==
X-CSE-MsgGUID: Z4PqHkJmQySeD5aa1i1OWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="89392451"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="89392451"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 04:39:10 -0700
X-CSE-ConnectionGUID: 2TPjyhGPQZiAHJG0c9fjfw==
X-CSE-MsgGUID: NAKZQ8CkQNyEdV234s4Dyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="234724405"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.120])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 04:39:05 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 24 Apr 2026 14:38:56 +0300 (EEST)
To: Jia Wang <wangjia@ultrarisc.com>
cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
    Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
    Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/4] serial: 8250_dw: build Renesas RZN1 CPR value
 from DW_UART_CPR_* definitions
In-Reply-To: <20260424-ultrarisc-serial-v4-2-1765a0b4c4a0@ultrarisc.com>
Message-ID: <4548483c-cbba-899e-6b1a-1290d36b59cd@linux.intel.com>
References: <20260424-ultrarisc-serial-v4-0-1765a0b4c4a0@ultrarisc.com> <20260424-ultrarisc-serial-v4-2-1765a0b4c4a0@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 24 Apr 2026, Jia Wang wrote:

> Replace the magic CPR value for Renesas RZ/N1 with a composition using
> DW_UART_CPR_* bit/field definitions and FIELD_PREP_CONST().
> 
> Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index 467755bf0092..d3c2c9c84d9f 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -937,7 +937,15 @@ static const struct dw8250_platform_data dw8250_armada_38x_data = {
>  
>  static const struct dw8250_platform_data dw8250_renesas_rzn1_data = {
>  	.usr_reg = DW_UART_USR,
> -	.cpr_value = 0x00012f32,
> +	.cpr_value = FIELD_PREP_CONST(DW_UART_CPR_ABP_DATA_WIDTH, 2) |
> +		     DW_UART_CPR_AFCE_MODE |
> +		     DW_UART_CPR_THRE_MODE |
> +		     DW_UART_CPR_ADDITIONAL_FEATURES |
> +		     DW_UART_CPR_FIFO_ACCESS |
> +		     DW_UART_CPR_FIFO_STAT |
> +		     DW_UART_CPR_SHADOW |
> +		     DW_UART_CPR_DMA_EXTRA |
> +		     FIELD_PREP_CONST(DW_UART_CPR_FIFO_MODE, 0x01),

Hmm, maybe there should also be macro also for this one which takes the 
fifosize as input and converts it to CPR field vlaue (effectively, the 
macro is an inverse of DW_UART_CPR_FIFO_SIZE()). It would be more readable 
than the literal.

Also include BUILD_BUG_ON(!IS_ALIGNED(fifosize, 16) + bounds checks) 
inside that macro to catch invalid fifo sizes (+ don't forget the 
necessary headers for those two new things).


-- 
 i.

