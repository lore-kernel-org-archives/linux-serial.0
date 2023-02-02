Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77A9C61DA4
	for <linux-serial@archiver.kernel.org>; Thu,  2 Feb 2023 13:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjBBN7L (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Feb 2023 08:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjBBN7K (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Feb 2023 08:59:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C828D431
        for <linux-serial@vger.kernel.org>; Thu,  2 Feb 2023 05:59:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A798B8240B
        for <linux-serial@vger.kernel.org>; Thu,  2 Feb 2023 13:59:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA6DC4339E;
        Thu,  2 Feb 2023 13:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675346345;
        bh=eiOpgmYE9Qx2kvkXgFydGk8ijP5XpELRA22P1whzCXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sSQk7VbOg2xbaL581svhjciBZDOP86d2bVPcbzoZhSd4oXrLZ4mzNLp4fH95WT6y/
         VNk+G4UGlireW+88V6vIg90x4GREk7/Hi4cfxHka3T/miuyap9V/ph1IqZoFLjpm2O
         zQWic19TL24crmJODTRmPvxriDfRw2Sr56qOZyIw=
Date:   Thu, 2 Feb 2023 14:59:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        kernel@pengutronix.de
Subject: Re: [PATCH] serial: 8250: Fix mismerge regarding serial_lsr_in()
Message-ID: <Y9vBp5FDi5leXQyA@kroah.com>
References: <20230202104501.264686-1-u.kleine-koenig@pengutronix.de>
 <f157ed1b-3856-7ac9-f054-265536ba3b3@linux.intel.com>
 <20230202120428.fo5fswdwki46vnjz@pengutronix.de>
 <af49e8f-6c1b-39fa-923e-f0a99edab17c@linux.intel.com>
 <20230202134057.v6mjwvbrxdvfackb@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230202134057.v6mjwvbrxdvfackb@pengutronix.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Feb 02, 2023 at 02:40:57PM +0100, Uwe Kleine-König wrote:
> Hello Ilpo,
> 
> On Thu, Feb 02, 2023 at 02:09:38PM +0200, Ilpo Järvinen wrote:
> > On Thu, 2 Feb 2023, Uwe Kleine-König wrote:
> > > On Thu, Feb 02, 2023 at 01:26:08PM +0200, Ilpo Järvinen wrote:
> > > > I don't know if Fixes tag is appropriate here. This fixes the mismerge 
> > > > yes, however, the removed line itself seems harmless so there's no real 
> > > > problem to fix.
> > > 
> > > It might make a difference if LSR_SAVE_FLAGS != p->lsr_save_mask.
> > 
> > But currently lsr_save_mask always has at least LSR_SAVE_FLAGS bits so 
> > that OR is no-op.
> 
> Oh indeed. So it's even more harmless than I thought. Thanks.
> 
> @gregkh: I don't feel strong about the Fixes line, drop it if you prefer
> to not have it.

I'll drop it, thanks!

greg k-h
