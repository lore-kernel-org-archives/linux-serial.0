Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7A6ECDFA1
	for <linux-serial@archiver.kernel.org>; Wed, 26 Oct 2022 11:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbiJZLZL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 26 Oct 2022 07:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbiJZLZL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Oct 2022 07:25:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6CA24F38
        for <linux-serial@vger.kernel.org>; Wed, 26 Oct 2022 04:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666783509; x=1698319509;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YgrV1sBDIXIze/KqPnEoPrjNcVaLo2zXIWH/ThhY+rc=;
  b=acxgpdX+4fQKnqu4f3nTJN7xtqCjqlilDUBcAasWQ7g8trtcxPxHpf4Q
   O0tYxUK7od5+0msYGA9RScELfUvhj98bj+BWus9mlnerY60xgE8Nq3T6C
   Ph+icE8iexwC/0lWUBkWfEA6G1xPiZbnh1XX1Pqoc1gYy0mBGO1sGrYZU
   Hdzh8ud5TXIYfvLZfl3/wPHreJNORLDy1DEdB4nn7tRgiill1fY0XeN1D
   orgF8vybELANSG+wkNOKFmqcKvZRC834AkMx1V5KueOiAITPxUhXLOAFE
   daBwzJKWprKe2RQWJXWJLCAzIfc9fAcVqIsM81f0HxVpKHZj629hfae6g
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="291225599"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="291225599"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 04:25:08 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="877152856"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="877152856"
Received: from sgohier-mobl.ger.corp.intel.com ([10.252.54.78])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 04:25:07 -0700
Date:   Wed, 26 Oct 2022 14:25:05 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Martin_Hundeb=F8ll?= <martin@geanix.com>
cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 4/4] tty: 8250: update description of RUNTIME_PORTS
 / nr_uarts
In-Reply-To: <20221025073944.102437-4-martin@geanix.com>
Message-ID: <f29eb4e-7ed5-ab81-6924-d599dea8a08d@linux.intel.com>
References: <20221025073944.102437-1-martin@geanix.com> <20221025073944.102437-4-martin@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1650418825-1666783508=:9482"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1650418825-1666783508=:9482
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 25 Oct 2022, Martin Hundebøll wrote:

> The 8250 module has been updated allow configurations with zero builtin
> UART ports, so change the description of the parameter to reflect that.
> 
> Signed-off-by: Martin Hundebøll <martin@geanix.com>
> ---
> 
> Change since v2:
>  * new patch
> 
>  drivers/tty/serial/8250/8250_core.c |  3 ++-
>  drivers/tty/serial/8250/Kconfig     | 10 +++++-----
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index a8fbc2325244..3d8bf0296080 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -1257,7 +1257,8 @@ module_param_hw(share_irqs, uint, other, 0644);
>  MODULE_PARM_DESC(share_irqs, "Share IRQs with other non-8250/16x50 devices (unsafe)");
>  
>  module_param(nr_uarts, uint, 0644);
> -MODULE_PARM_DESC(nr_uarts, "Maximum number of UARTs supported. (1-" __MODULE_STRING(CONFIG_SERIAL_8250_NR_UARTS) ")");
> +MODULE_PARM_DESC(nr_uarts, "Number of built-in (non-discoverable) UARTs to initialize. (1-"
> +		_MODULE_STRING(CONFIG_SERIAL_8250_NR_UARTS) ")");

This fails to build. You have dropped the second underscore for some 
reason.

Shouldn't that 1- be also changed to 0- ?

-- 
 i.


>  
>  module_param(skip_txen_test, uint, 0644);
>  MODULE_PARM_DESC(skip_txen_test, "Skip checking for the TXEN bug at init time");
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index d0b49e15fbf5..65ef03553146 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -191,15 +191,15 @@ config SERIAL_8250_NR_UARTS
>  	  via hot-plug, or any ISA multi-port serial cards.
>  
>  config SERIAL_8250_RUNTIME_UARTS
> -	int "Number of 8250/16550 serial ports to register at runtime"
> +	int "Number of built-in (non-discoverable) UARTs to initialize at boot time"
>  	depends on SERIAL_8250
>  	range 0 SERIAL_8250_NR_UARTS
>  	default "4"
>  	help
> -	  Set this to the maximum number of serial ports you want
> -	  the kernel to register at boot time.  This can be overridden
> -	  with the module parameter "nr_uarts", or boot-time parameter
> -	  8250.nr_uarts
> +	  Set this to the maximum number of built-in (non-discoverable) serial
> +	  ports you want the kernel to initialize at boot time.  This can be
> +	  overridden with the module parameter "nr_uarts", or boot-time
> +	  parameter 8250.nr_uarts
>  
>  config SERIAL_8250_EXTENDED
>  	bool "Extended 8250/16550 serial driver options"
> 
--8323329-1650418825-1666783508=:9482--
