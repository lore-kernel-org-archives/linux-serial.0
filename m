Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D3AC6FD1C
	for <linux-serial@archiver.kernel.org>; Fri, 24 Mar 2023 11:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCXLsH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Mar 2023 07:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCXLsG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Mar 2023 07:48:06 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D6C272C
        for <linux-serial@vger.kernel.org>; Fri, 24 Mar 2023 04:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679658485; x=1711194485;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CXJq/GBiCyHzHxgLHwLLnYEQRI4JydW13S9/NiBPtZA=;
  b=aE8JZRqDjMKewtlqzb+CS8xmCuJuwaPDXqg519YY5BA6B1rv0U3VcE+5
   RQixy9Pj9sCrz43wjiBFnM1tRi4tuGkiokOpJnYD6YY7ifHSWWO/hl+p8
   CzxHcLqjDaGrybDIYwtlTS/9oAzxmI7rZ9EjCzHOF02nXUu0OBPXslqBJ
   b0n/ERPmfIi1YlblHOitxK73ZyD8Rc0CBkOQ7u8W/5hQtZwu2U0tgl+pz
   PdVNn07LXZlOIz33zG+6344GKrzO7iR2JtUFi3MM+DzKv38W8Y23oDKKO
   X/e8JFmj3XON3YVkFEYK8AfAKrfXf3pcXVsg5z//KKjkcYOTtYLbh59vD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="337263283"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="337263283"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 04:48:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="806648995"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="806648995"
Received: from dmendyk-mobl2.ger.corp.intel.com ([10.252.38.125])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 04:48:01 -0700
Date:   Fri, 24 Mar 2023 13:47:59 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
cc:     =?ISO-8859-2?Q?Tomasz_Mo=F1?= <tomasz.mon@camlingroup.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sergey Organov <sorganov@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Wahren <stefan.wahren@chargebyte.com>
Subject: Re: Regression: serial: imx: overrun errors on debug UART
In-Reply-To: <2c29454b-9369-4360-8eb4-c151f59460cb@i2se.com>
Message-ID: <d660e3cf-5686-d989-3b59-efe83ec9d590@linux.intel.com>
References: <2c29454b-9369-4360-8eb4-c151f59460cb@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 24 Mar 2023, Stefan Wahren wrote:

> Hi,
> 
> after switching to Linux 6.1.21 on our Tarragon board (i.MX6ULL SoC), we
> experience the following issues with the debug UART (115200 baud, 8N1, no
> hardware flow control):
> 
> - overrun errors if we paste in multiple text lines while system is idle
> - no reaction to single key strokes while system is on higher load
> 
> After reverting 7a637784d517 ("serial: imx: reduce RX interrupt frequency")
> the issue disappear.
> 
> Maybe it's worth to mention that the Tarragon board uses two additional
> application UARTs with similiar baud rates (9600 - 115200 baud, no hardware
> flow control) for RS485 communication, but there are no overrun errors (with
> and without the mention change).

This has come up earlier, see e.g.:

https://lore.kernel.org/linux-serial/20221003110850.GA28338@francesco-nb.int.toradex.com/

My somewhat uninformed suggestion: if the overrun problems mostly show up 
with console ports, maybe the trigger level could depend on the port 
being a console or not?


-- 
 i.

