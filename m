Return-Path: <SRS0=BK0i=5J=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3074C4332B
	for <linux-serial@archiver.kernel.org>; Tue, 24 Mar 2020 11:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7603420786
	for <linux-serial@archiver.kernel.org>; Tue, 24 Mar 2020 11:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbgCXLVZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 Mar 2020 07:21:25 -0400
Received: from foss.arm.com ([217.140.110.172]:60962 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727266AbgCXLVY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 Mar 2020 07:21:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D17E31B;
        Tue, 24 Mar 2020 04:21:24 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 404F53F792;
        Tue, 24 Mar 2020 04:21:23 -0700 (PDT)
Date:   Tue, 24 Mar 2020 11:21:16 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH] tty: serial: make SERIAL_SPRD depends on ARM or ARM64
Message-ID: <20200324112115.GA10018@lakrids.cambridge.arm.com>
References: <20200324064949.23697-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324064949.23697-1-zhang.lyra@gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Mar 24, 2020 at 02:49:49PM +0800, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> kbuild-test reported an error:
> 
>   config: mips-randconfig-a001-20200321 ...
>   >> drivers/tty/serial/sprd_serial.c:1175: undefined reference
>   to `clk_set_parent'
> 
> Because some mips Kconfig-s select CONFIG_HAVE_CLK but not CONFIG_COMMON_CLK,
> so it's probably that clk_set_parent is missed for those configs.
> 
> To fix this error, this patch adds dependence on ARM || ARM64
> for SERIAL_SPRD.

From the above, isn't the real dependency COMMON_CLOCK?

Mark.

> 
> Fixes: 7ba87cfec71a ("tty: serial: make SERIAL_SPRD not depend on ARCH_SPRD")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  drivers/tty/serial/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index b43dce785a58..417f7e45a3f8 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1444,6 +1444,7 @@ config SERIAL_MEN_Z135
>  config SERIAL_SPRD
>  	tristate "Support for Spreadtrum serial"
>  	select SERIAL_CORE
> +	depends on ARM || ARM64 || COMPILE_TEST
>  	help
>  	  This enables the driver for the Spreadtrum's serial.
>  
> -- 
> 2.20.1
> 
