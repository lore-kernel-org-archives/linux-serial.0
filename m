Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08730C43334
	for <linux-serial@archiver.kernel.org>; Mon,  4 Jul 2022 08:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbiGDIia (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 4 Jul 2022 04:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbiGDIi0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 4 Jul 2022 04:38:26 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BEFFD8
        for <linux-serial@vger.kernel.org>; Mon,  4 Jul 2022 01:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656923904; x=1688459904;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=W962Ct3D970/NvCoNDKu1gcgdHbWNvGsuWUnSLjHcko=;
  b=W/6u1vShbfSAQg/lXOuDTh0LwIiM9au12he1z1eqwDBqqv2XwqRy0b1u
   2VPYaTuiwZSPT/ukmV7QZNxzV/X4sLksrkFzFGIh+gG7u+Qo17Ojn8mpl
   gSlJ+rX0LwLEtniGbzg89t2On5GAeqZhjEXYiW/8A2kLf6szKvM+MZXK/
   6jL2itYV5/7zzCrDq7ZIadwHOY6z8nsX8iNR16lGrn55seQxAU3YNBFE3
   zjkSABQ4PI73olw2u5N+UwaUeUHrwXZamBaPiMptvszERDRXIITlIwUZV
   0/xHUAVpzF8j1eq636a72HY7qfYeyGO0EvjLF5A83mGoOzYRXZ8PAwVOD
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="347052708"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="347052708"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 01:38:15 -0700
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="649479221"
Received: from bclindho-mobl.ger.corp.intel.com ([10.252.49.27])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 01:38:12 -0700
Date:   Mon, 4 Jul 2022 11:38:07 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
cc:     kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-imx@nxp.com, linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] serial: 8250_fsl: Don't report FE, PE and OE twice
In-Reply-To: <251e5eb8-48f-6e4f-7256-959e86469582@linux.intel.com>
Message-ID: <bfced1c5-8952-8c1d-43a4-52c37985eea0@linux.intel.com>
References: <20220511093247.91788-1-u.kleine-koenig@pengutronix.de> <20220512012910.GB37988@windriver.com> <20220512061724.4guiyqa6vcdru4iw@pengutronix.de> <20220512154621.GC37988@windriver.com> <20220512161316.5pknsjgl6lb75vva@pengutronix.de>
 <4d72e94d-f527-976d-c1b7-2258bf14437@linux.intel.com> <20220524192315.cs7ry4bops45yyli@pengutronix.de> <251e5eb8-48f-6e4f-7256-959e86469582@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Uwe,

Just a small reminder that you might want to resubmit this as it is 
seemingly no longer on Greg's pending patches list.


-- 
 i.

