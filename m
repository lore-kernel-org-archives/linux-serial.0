Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE7FC6FA82
	for <linux-serial@archiver.kernel.org>; Wed, 14 Sep 2022 13:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiINN5q (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Sep 2022 09:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiINN5p (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Sep 2022 09:57:45 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C3A7538B
        for <linux-serial@vger.kernel.org>; Wed, 14 Sep 2022 06:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663163864; x=1694699864;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cj4J2/QhYKjh+fpWJTQ7CSERoN9Hal4Uns0xvlUftWI=;
  b=MsW/Uiq4+y1OOalMhfO/1O8dc5Y5ui1zCOOQC+ppTUsExRY7kWwNrHjw
   361n+b0O2IkRolPhDBbuw6s2D/mQZyBDzY5cUU8Uvsmz4WqgF1d9fD1x4
   Mr8ASoqP1mTi9Lty6gh6EN51MTBOaeRyjw+tgZJYhB5jjyayOtFTKseuy
   YM1Sl+zuGdZmhtsO9QoSvAQhKfZRv2/5El6ZoNDn0zSybWLYKf8oTSrj9
   3M3j2UZMGK3zuvqN0EQIZmw1W6psibteVCrD8p8+nyZU5DZqQbFY/lXYz
   cCMIefbBpfmNyRHI1IkXto7NzNeTskVnVuL8VADX2oj144LlaympfApki
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="298433280"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="298433280"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 06:57:43 -0700
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="679056533"
Received: from kkomeyli-mobl4.amr.corp.intel.com ([10.252.46.196])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 06:57:41 -0700
Date:   Wed, 14 Sep 2022 16:57:39 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] serial: omap: Disallow RS-485 if rts-gpio is not
 specified
In-Reply-To: <f191dcca0d8ea03598c463fc0d3fba8941ff2275.1662888075.git.lukas@wunner.de>
Message-ID: <c86291b0-3a9-5cd9-fff7-6ae537ec6036@linux.intel.com>
References: <f191dcca0d8ea03598c463fc0d3fba8941ff2275.1662888075.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1962044770-1663163864=:1599"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1962044770-1663163864=:1599
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Sun, 11 Sep 2022, Lukas Wunner wrote:

> The serial-omap driver requires an rts-gpio for RS-485 to work.
> Historically it has allowed enabling RS-485 even if no rts-gpio was
> specified in the device tree.
> 
> That doesn't make any sense, so disable RS-485 on probe if rts-gpio is
> missing and disallow user space from enabling it.
> 
> Three NULL pointer checks for up->rts_gpiod can be dropped as a result,
> simplifying the driver slightly.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1962044770-1663163864=:1599--
