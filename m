Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC46C54EE9
	for <linux-serial@archiver.kernel.org>; Tue, 13 Sep 2022 07:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiIMHVM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 13 Sep 2022 03:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiIMHVK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Sep 2022 03:21:10 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560B643E54
        for <linux-serial@vger.kernel.org>; Tue, 13 Sep 2022 00:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663053667; x=1694589667;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+Vq/wmkyQWXBQwaEvzku+JjmbEwbZhYT8W59cGcTNF4=;
  b=LUDLpkckCwbVfavCAfFY+HwDusWaFyPnlXl3vosiZSJRw+z8GJE2rfJE
   p42uaS8D2N4VAdNlgd9EjNEBOncaz0Do7dcgnGqSiejvss5py7+g+c/DF
   lfAPPHGAkLx4nZqpsBaEMVo1FsjrY9/U07Rma/ZnDftcOrG7nYzEIYmkO
   rEDbuJRZJc2fxHR/USsIIJfP4dAI0SuaNBFxcUHHBMg1ZZxHz5Bl0RB7a
   prD3jA0U22cK5mAK+e4azJyN0RrD9aYBwOdG9zPuoz2OuVxzCmboVd8ET
   +v8/p5tXdt+UVgFaJExpvFzuFCvuYyDCWNzqnVuCDaVl4j68dvgdbC7bs
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="295650401"
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="295650401"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 00:21:07 -0700
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="646809765"
Received: from calabres-mobl.ger.corp.intel.com ([10.252.47.42])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 00:21:04 -0700
Date:   Tue, 13 Sep 2022 10:20:58 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fugang Duan <fugang.duan@nxp.com>,
        Sherry Sun <sherry.sun@nxp.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: Re: [PATCH] serial: fsl_lpuart: Reset prior to registration
In-Reply-To: <72fb646c1b0b11c989850c55f52f9ff343d1b2fa.1662884345.git.lukas@wunner.de>
Message-ID: <1d78424-e7e9-9379-3c61-ac268cb9b3c@linux.intel.com>
References: <72fb646c1b0b11c989850c55f52f9ff343d1b2fa.1662884345.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-955925912-1663053666=:16933"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-955925912-1663053666=:16933
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Sun, 11 Sep 2022, Lukas Wunner wrote:

> Since commit bd5305dcabbc ("tty: serial: fsl_lpuart: do software reset
> for imx7ulp and imx8qxp"), certain i.MX UARTs are reset after they've
> already been registered.  Register state may thus be clobbered after
> user space has begun to open and access the UART.
> 
> Avoid by performing the reset prior to registration.
> 
> Fixes: bd5305dcabbc ("tty: serial: fsl_lpuart: do software reset for imx7ulp and imx8qxp")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v5.15+
> Cc: Fugang Duan <fugang.duan@nxp.com>
> Cc: Sherry Sun <sherry.sun@nxp.com>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-955925912-1663053666=:16933--
