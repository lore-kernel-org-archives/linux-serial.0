Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71862C04A95
	for <linux-serial@archiver.kernel.org>; Wed, 28 Sep 2022 11:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbiI1Lis (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 28 Sep 2022 07:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbiI1Lir (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 28 Sep 2022 07:38:47 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01406D4
        for <linux-serial@vger.kernel.org>; Wed, 28 Sep 2022 04:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664365126; x=1695901126;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5DRFrlF4Waqe5GLQeILPF5DiW4AquWFtyr6mIKN0ncE=;
  b=lEgEnyQYkFwXpAFN3W/z07byEr2WKYjgNSoeUr/pnUIB9ADW1CTwUSPE
   qvl3nmGsNBeFweuBJsJEthrW3J5tTuH06cQ74YjIPqi11UHoVLl1x8lKt
   U8wh5M2u0u78UarUbYrN2U54MEDtbYpTFMvOzFlqK4LKYhxFh9pxpFCqd
   vbirKXlKyM85u5OxyvjkSXlRFkrxYL6Bo7K67hoKGoPJGCgqUbSgsB52Z
   x7PPM4tTJRkAGkBX16K1KLFxCfpPhJd0/Yyw/lM3cwyK5hOZ645Qyc/tX
   3afQT00jOvHYLngx091X5tb1wVLYagxGsacfSHvqKWqd57Lt5QgYn32Am
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="284710876"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="284710876"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 04:38:45 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="655099065"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="655099065"
Received: from kjurkiew-mobl.ger.corp.intel.com ([10.251.211.248])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 04:38:42 -0700
Date:   Wed, 28 Sep 2022 14:38:40 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Su Bao Cheng <baocheng.su@siemens.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: Re: [PATCH] serial: 8250: 8250_omap: Support native RS485
In-Reply-To: <b9f5e4b01f10bb692fc78df668f686dd33d8c036.1664279959.git.lukas@wunner.de>
Message-ID: <42986e92-d12e-bfde-2f5c-f580c113c3b@linux.intel.com>
References: <b9f5e4b01f10bb692fc78df668f686dd33d8c036.1664279959.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 27 Sep 2022, Lukas Wunner wrote:

> Recent TI Sitara SoCs such as AM64/AM65 have gained the ability to
> automatically assert RTS when data is transmitted, obviating the need
> to emulate this functionality in software.
> 
> The feature is controlled through new DIR_EN and DIR_POL bits in the
> Mode Definition Register 3.  For details see page 8783 and 8890 of the
> AM65 TRM:  https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf
> 
> Tested-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: Su Bao Cheng <baocheng.su@siemens.com>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Nishanth Menon <nm@ti.com>

> @@ -1335,10 +1387,7 @@ static int omap8250_probe(struct platform_device *pdev)
>  	up.port.shutdown = omap_8250_shutdown;
>  	up.port.throttle = omap_8250_throttle;
>  	up.port.unthrottle = omap_8250_unthrottle;
> -	up.port.rs485_config = serial8250_em485_config;
>  	up.port.rs485_supported = serial8250_em485_supported;
> -	up.rs485_start_tx = serial8250_em485_start_tx;
> -	up.rs485_stop_tx = serial8250_em485_stop_tx;
>  	up.port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
>  
>  	ret = of_alias_get_id(np, "serial");
> @@ -1377,6 +1426,14 @@ static int omap8250_probe(struct platform_device *pdev)
>  			 DEFAULT_CLK_SPEED);
>  	}
>  
> +	if (priv->habit & UART_HAS_NATIVE_RS485) {
> +		up.port.rs485_config = omap8250_rs485_config;
> +	} else {
> +		up.port.rs485_config = serial8250_em485_config;
> +		up.rs485_start_tx = serial8250_em485_start_tx;
> +		up.rs485_stop_tx = serial8250_em485_stop_tx;
> +	}

I guess .rs485_supported shouldn't be equal in both cases?

Somehow I feel this hw rs485 + em485 fallback setup might become a common 
pattern so adding some helper for it might be warranted (dwlib already has 
a similar if construct).

-- 
 i.

