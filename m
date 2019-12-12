Return-Path: <SRS0=BzPo=2C=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC7EC43603
	for <linux-serial@archiver.kernel.org>; Thu, 12 Dec 2019 10:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52BF206DA
	for <linux-serial@archiver.kernel.org>; Thu, 12 Dec 2019 10:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576147863;
	bh=byEiNgfaI1LH+aZ1bOMYTk8t7HJqddz1QFWkEQ6+lyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PJWzxy7wQcEGaJVdVLiLN8CfetZvrxIJf8n/kkXZ8zlmnOfXLtNjFd7w6UV7V1fca
	 yJOu1hHpvMvWBvMkVgSK/K5z2SkdwgMxzeUQQ9PqsKw6n4ncdm5QgTbF1VAl3Wuu4Z
	 gCla4dr7ohE+HtUNCVpkdu8k+XOz2pNabbVuVVlw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbfLLKvD (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Dec 2019 05:51:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:45040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728764AbfLLKvD (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Dec 2019 05:51:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A92220663;
        Thu, 12 Dec 2019 10:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576147861;
        bh=byEiNgfaI1LH+aZ1bOMYTk8t7HJqddz1QFWkEQ6+lyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1K7JrbYLWfehQ16c+hNnT3q0irWx4iAoFtJvdpqRaoaXtNPWzdmKH9BPAEJVf3fX4
         h1OOiYdO1tkd6eCvG0KEEfZnr3GkJLxIxoFQ618B2/D480BAdxeHUL1P9V9MIaxAl/
         dSlyofpK0tUuOCtHlns1E0uNnLSpNCoJBviirUyw=
Date:   Thu, 12 Dec 2019 11:50:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        shubhrajyoti.datta@gmail.com, linux-serial@vger.kernel.org,
        jacmet@sunsite.dk, git@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: Re: [PATCHv5] serial-uartlite: Remove ULITE_NR_PORTS macro
Message-ID: <20191212105059.GA1476206@kroah.com>
References: <1573646408-392094-1-git-send-email-shubhrajyoti.datta@gmail.com>
 <20191113153846.GW11035@localhost>
 <fbfa424b-6730-fae9-14bf-bf666e93ad28@xilinx.com>
 <20191203152738.GF10631@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203152738.GF10631@localhost>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Dec 03, 2019 at 04:27:38PM +0100, Johan Hovold wrote:
> On Fri, Nov 15, 2019 at 09:21:03AM +0100, Michal Simek wrote:
> > Hi Johan,
> > 
> > On 13. 11. 19 16:38, Johan Hovold wrote:
> > > On Wed, Nov 13, 2019 at 12:00:08PM +0000, shubhrajyoti.datta@gmail.com wrote:
> > >> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> > >>
> > >> This patch is removing ULITE_NR_PORTS macro which limits number of
> > >> ports which can be used. Every instance is registering own struct
> > >> uart_driver with minor number which corresponds to alias ID (or 0 now).
> > >> and with 1 uart port. The same alias ID is saved to
> > >> tty_driver->name_base which is key field for creating ttyULX name.
> > >>
> > >> Because name_base and minor number are setup already there is no need to
> > >> setup any port->line number because 0 is the right value.
> > >>
> > >> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> > >> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> > >> ---
> > >> v4: patch addition
> > >> v5: Merge the patch so that all the patches compile
> > > 
> > > Greg, 
> > > 
> > > Please do not merge this. This is a hack which really needs to be
> > > reconsidered as I've pointed before
> > > 
> > > 	 https://lkml.kernel.org/r/20190523091839.GC568@localhost
> > 
> > I think it is quite a good time to start to talk about it.
> > Over the time I am aware about only one issue related to one way how to
> > handle console which came recently. I was looking at it 2 weeks before
> > ELCE but I need to get back on this.
> > Anyway I am ready for discussion about it.
> > What was said so far is that we shouldn't add Kconfig option for number
> > of uarts. We could maybe hardcode any big number in the driver as is
> > done for pl011 but still it is limitation and wasting of space for
> > allocation structures which none will use.
> > Then I have done this concept and it was merged where struct uart_driver
> > is allocated for every instance separately and I really tried to get
> > feedback on this as we discussed some time ago.
> > 
> > Anyway we are where we are and if this needs to be fixed then please
> > tell me how you think that this should be solved.
> 
> As I told you back in May, registering one uart driver per physical
> port is precisely what should not be done. Just register a fixed number
> of lines like every other tty driver. And if you're worried about
> statically allocated memory, you need to address that in the tty layer
> and/or serial core instead of hacking every single uart driver to
> pieces.
> 
> Specifically, you could move the uart state allocation to port
> registration so that all drivers would benefit from this.
> 
> This is already causing way more trouble than it's worth, and the big
> number you mention above for pl011 is 14! In comparison, usb-serial
> currently supports 512 ports just fine by allocating state at
> registration.  
> 
> Greg, I reread some of the mails reachable through the above link and
> was reminded that this hack also made it into xilinx_uartps. That would
> need to be fixed/reverted as well.

If you have any specific git commit ids that I should revert, please let
me know.

thanks,
greg k-h
