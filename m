Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC94BC77B7A
	for <linux-serial@archiver.kernel.org>; Tue, 30 May 2023 11:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjE3LUT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 30 May 2023 07:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjE3LUT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 30 May 2023 07:20:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27441D9;
        Tue, 30 May 2023 04:20:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE80062917;
        Tue, 30 May 2023 11:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA15DC433EF;
        Tue, 30 May 2023 11:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685445617;
        bh=cTSrXo17OxJMEg/viqIAtotQJ9pg1/100e11SFoN9t4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tfb+wCjfsdJoZ6gRw3MxwYZbumyEtAymr8i4eN79VquflgTL+VpldR/VlciQwnQP0
         EGhgFlfw5LLDkGZomJlP9xvFx7NMv/+urT9wyPVOtRyybgpmweUojiawAJvUT5yYNu
         xINkIOZJJZm2bhwAgOIpOOw+f0wYQYV+FySW6Ees=
Date:   Tue, 30 May 2023 12:20:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] serial: 8250: omap: convert to modern PM ops
Message-ID: <2023053059-swapping-dominoes-e9b3@gregkh>
References: <20230517202012.634386-1-arnd@kernel.org>
 <20230519054431.GV14287@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519054431.GV14287@atomide.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 19, 2023 at 08:44:31AM +0300, Tony Lindgren wrote:
> * Arnd Bergmann <arnd@kernel.org> [230517 20:20]:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The new uart_write() function is only called from suspend/resume code, causing
> > a build warning when those are left out:
> > 
> > drivers/tty/serial/8250/8250_omap.c:169:13: error: 'uart_write' defined but not used [-Werror=unused-function]
> > 
> > Remove the #ifdefs and use the modern pm_ops/pm_sleep_ops and their wrappers
> > to let the compiler see where it's used but still drop the dead code.
> 
> This looks good to me as an alternative for Geert's fix. If Geert's
> fix gets applied first, this needs to be rabased.

No need for rebase, it applied cleanly.

thanks,

greg k-h
