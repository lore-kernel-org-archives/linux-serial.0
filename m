Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4400CC433FE
	for <linux-serial@archiver.kernel.org>; Wed,  2 Nov 2022 07:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiKBHNB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 2 Nov 2022 03:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiKBHM7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 2 Nov 2022 03:12:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034EC20F5E;
        Wed,  2 Nov 2022 00:12:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9290F61808;
        Wed,  2 Nov 2022 07:12:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D94D3C433D6;
        Wed,  2 Nov 2022 07:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667373178;
        bh=8YSLrlTKEH/zZIjxkCCQNXWTZJ2rwxcYE+d26YpyZhE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GCHRTvzu2C+o/dTeJ1w2KnygFUzicLKPEmKXP8E6REFdfiHlRdHFNcSVW38NntkAe
         Yf2g0IIWpTQrIVg+Y3E4GePvAmVfVWOwc02ANBuInOB4m/rOY6u1e6oZirNQJWOelb
         Z6aUE5lXtjdRy1QOJWiS5GZhSXlYf7PWXyN0UOJQ=
Date:   Wed, 2 Nov 2022 08:09:32 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 0/6] RISC-V: stop selecting device drivers in Kconfig.socs
Message-ID: <Y2IXrD4FpXNmDDPk@kroah.com>
References: <20221005171348.167476-1-conor@kernel.org>
 <Y15nwXmn7rToJkH2@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y15nwXmn7rToJkH2@spud>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Oct 30, 2022 at 12:02:09PM +0000, Conor Dooley wrote:
> On Wed, Oct 05, 2022 at 06:13:43PM +0100, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> > 
> > As my RFC [0] series doing the symbol name changes has not yet reached
> > consensus, I've split out the removal of device driver selects into a
> > new series. I kept the plic as a direct select - although given how Maz
> > is treating the SiFive plic driver as the RISC-V plic driver, maybe that
> > should just be selected by default at an arch level...
> > 
> > I assume the individual patches can go via their subsystems & I'll
> > resubmit the arch/riscv patches a cycle later? I'm not in any rush.
> 
> Hey,
> 
> What's the story here with the two serial patches, they just waiting for
> an Ack? I think these are archived on the riscv patchwork, so if that is
> the case I'll unarchive them and mark as needing one.

Sorry for the delay, I'll take both of them through the tty/serial tree.

thanks,

greg k-h
