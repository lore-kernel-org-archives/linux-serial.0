Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FE8C433EF
	for <linux-serial@archiver.kernel.org>; Thu,  5 May 2022 22:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343675AbiEEWiK (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 5 May 2022 18:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386356AbiEEWiI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 May 2022 18:38:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECCD6004D;
        Thu,  5 May 2022 15:34:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10B5E61E53;
        Thu,  5 May 2022 22:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5974AC385A4;
        Thu,  5 May 2022 22:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651790066;
        bh=Fjpze9p+LviKLUP0aU8SZtUfet1POQ58RsbqdrFG4aU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XwneceNDSaXq0hOFu7m5dCZ1neE5qHMCBgJzH3zC53YNIaSFbDNDny3OnGfu2GNJg
         XQanp2o4W4s0eA6VsGWPNCgBGEmW9HZo1YKXAoWwYvsJL2lfK441u05n2CtAU30dMk
         nVi/vU5qjS8pFdXl687zzS49PRYxHKyxY4WJA8EE=
Date:   Thu, 5 May 2022 22:48:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     linux-serial@vger.kernel.org, michal.simek@xilinx.com,
        jirislaby@kernel.org, git@xilinx.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] tty: xilinx_uartps: fixes and improvements
Message-ID: <YnQ4Ngu8xt7DBi5C@kroah.com>
References: <20220429081422.3630070-1-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429081422.3630070-1-shubhrajyoti.datta@xilinx.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 29, 2022 at 01:44:15PM +0530, Shubhrajyoti Datta wrote:
> Many of the stuff is reported by static analysis
> changes are 
> 
> - Update the copyright text
> - Check the return valuesof runtime and clock enable calls
> - Check the ignore_status in the isr 
> - Prevent writing to the fifo when controller is disabled.
> 
> Michal Simek (1):
>   xilinx: Update copyright text to correct format
> 
> Shubhrajyoti Datta (6):
>   tty: xilinx_uartps: Check the clk_enable return value
>   tty: xilinx_uartps: Add check for runtime_get_sync calls
>   tty: xilinx_uartps: Check clk_enable return type
>   tty: xilinx_uartps: Make the timeout unsigned
>   serial: uartps: Fix the ignore_status
>   serial: uartps: Prevent writes when the controller is disabled

Nit, why is the subject line prefix not unified here?  Shouldn't they
all be "tty: xilinx_uartps:" like 4 of them are?

Can you fix up and resend?

thanks,

greg k-h
