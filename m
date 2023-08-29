Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E896C83F17
	for <linux-serial@archiver.kernel.org>; Tue, 29 Aug 2023 03:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbjH2DxR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 28 Aug 2023 23:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235626AbjH2Dwu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 28 Aug 2023 23:52:50 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E57511B
        for <linux-serial@vger.kernel.org>; Mon, 28 Aug 2023 20:52:47 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9F54C8088;
        Tue, 29 Aug 2023 03:52:46 +0000 (UTC)
Date:   Tue, 29 Aug 2023 06:52:45 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Matthew Howell <matthew.howell@sealevel.com>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        ryan.wenglarz@sealevel.com, james.olson@sealevel.com
Subject: Re: [PATCH] serial: Revert serial: core: Fix serial core port id to
 not use port->line
Message-ID: <20230829035245.GF11662@atomide.com>
References: <98a891fd-5a1f-6568-a12c-28577126a42@sealevel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98a891fd-5a1f-6568-a12c-28577126a42@sealevel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

* Matthew Howell <matthew.howell@sealevel.com> [230828 20:41]:
> From: Matthew Howell <matthew.howell@sealevel.com>
> XR17V35X cards seemingly unable to register serial port. Confirmed on 
> Sealevel 7202C, 7204EC, and Exar XR17V352 reference board. 
> dmesg states: "Couldn't register serial port 0, irq 24, type 2, error -22"
> 
> I first identified the problem when I pulled down 6.6-rc1 and I was able 
> to trace it to d962de6ae51f9b76ad736220077cda83084090b1. I understand that this 
> commit is noted as being reverted in 1ef2c2df1199, but I was only able to 
> resolve the issue by reverting d962de6ae51f myself using this patch.

Thanks for the report. Do you maybe mean 6.5-rc1 instead of 6.6-rc1 above?

If so, I suspect the issue you are reporting got already fixed during the
-rc cycle for v6.5 kernel.

> I suggest reverting using this patch unless someone more knowledgeable 
> about what these changes actually do has a better suggestion.

Can you please test with v6.5 kernel? It has the two fixes below that
sounds like you may have been missing:

a4a79e03bab5 ("serial: core: Revert port_id use")
04c7f60ca477 ("serial: core: Fix serial core port id, including multiport devices")

Note how commit a4a79e03bab5 already did a partial revert of what you're
suggesting.

If you already have these two commits, then let's investigate further to
see what might be still wrong.

Regards,

Tony
