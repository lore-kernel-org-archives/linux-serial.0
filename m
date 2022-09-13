Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF30C54EE9
	for <linux-serial@archiver.kernel.org>; Tue, 13 Sep 2022 08:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiIMIWt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 13 Sep 2022 04:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbiIMIWQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Sep 2022 04:22:16 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2813F201AE
        for <linux-serial@vger.kernel.org>; Tue, 13 Sep 2022 01:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663057335; x=1694593335;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NIUaTvQJFIXCaSxXMrQtp7xnwIzxTlgqZrOpOVbWHcE=;
  b=majICuM544IILJYw/MDqeD8g+mzT2RgbnDyR1/a/bNHu9tz7JvclFYko
   TOLjfvs974sAV4EAzepH4qTrd8HV1cGR/+pscM1VVsAqiCrnRQ84gvVXO
   CBXEbeqmwi2CI3UgUNwMazdGGJ/+BFId3Qao5cAeHeP+XVF9wl4TPkwLD
   ElWnOklRzrVYYjbOIE1JoUcDmCLsrtpG9cInWvfxdS9gZL0cby/p4iJQN
   l6GH7MrJ0zOvRj5SBITO2GUx2ekoJHJ2HlLQuIvsDvBWs1njQXTYB2EuZ
   1OTPS5iTsiD5+qoggrfhVo98JPlMdT2PI4rZHDEjm8dTFP9MrGSv3InZb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="324321442"
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="324321442"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 01:22:14 -0700
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="678465426"
Received: from calabres-mobl.ger.corp.intel.com ([10.252.47.42])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 01:22:12 -0700
Date:   Tue, 13 Sep 2022 11:22:10 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Golle <daniel@makrotopia.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: Re: [PATCH] serial: ar933x: Deassert Transmit Enable on
 ->rs485_config()
In-Reply-To: <5b36af26e57553f084334666e7d24c7fd131a01e.1662887231.git.lukas@wunner.de>
Message-ID: <8dd36d39-f976-494-b2a7-b6883f609250@linux.intel.com>
References: <5b36af26e57553f084334666e7d24c7fd131a01e.1662887231.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1672615295-1663057334=:16933"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1672615295-1663057334=:16933
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Sun, 11 Sep 2022, Lukas Wunner wrote:

> The ar933x_uart driver neglects to deassert Transmit Enable when
> ->rs485_config() is invoked.  Fix it.
> 
> Fixes: 9be1064fe524 ("serial: ar933x_uart: add RS485 support")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v5.7+
> Cc: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1672615295-1663057334=:16933--
