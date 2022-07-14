Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CF4C43334
	for <linux-serial@archiver.kernel.org>; Thu, 14 Jul 2022 15:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240188AbiGNPYQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Jul 2022 11:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240126AbiGNPYM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Jul 2022 11:24:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E5010A7
        for <linux-serial@vger.kernel.org>; Thu, 14 Jul 2022 08:24:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83F0761F21
        for <linux-serial@vger.kernel.org>; Thu, 14 Jul 2022 15:24:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DBF9C34114;
        Thu, 14 Jul 2022 15:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657812250;
        bh=12wahynDNQXAkFaEanorzhPPbwrIKHbQmEhzJNjAm2A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E42aa5mgWchHBlwHvHSgoAlkFfooS0vg8miMLP0ZomDH6LjWssZunEWffkPWrvMu+
         9nSnaQ2Op9Tc0QlLvRpNmv+jllwkSmrKrwwgt0DILbSapp2B78LGo9Cx7k7BeeZ5AO
         NHcO2M0qKl27fcWCGMJv8qwT6vwzPmTUkeKuXSVU=
Date:   Thu, 14 Jul 2022 17:24:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shenwei Wang <shenwei.wang@nxp.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH V1 1/1] serial: fsl_lpuart: zero out parity bit
 in CS7 mode
Message-ID: <YtA1EiZ35t5LOA3O@kroah.com>
References: <20220708195800.325933-1-shenwei.wang@nxp.com>
 <YtAouJ0aaZsdCzV/@kroah.com>
 <AM9PR04MB82744674CA0015303AE7B5ED89889@AM9PR04MB8274.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR04MB82744674CA0015303AE7B5ED89889@AM9PR04MB8274.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jul 14, 2022 at 03:11:35PM +0000, Shenwei Wang wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Thursday, July 14, 2022 9:31 AM
> > To: Shenwei Wang <shenwei.wang@nxp.com>
> > Cc: linux-serial@vger.kernel.org
> > Subject: [EXT] Re: [PATCH V1 1/1] serial: fsl_lpuart: zero out parity bit in CS7
> > mode
> > 
> > Caution: EXT Email
> > 
> > On Fri, Jul 08, 2022 at 02:58:00PM -0500, shenwei.wang@nxp.com wrote:
> > > The LPUART hardware doesn't zero out the parity bit on the received
> > > characters. This behavior won't impact the use cases of CS8 because
> > > the parity bit is the 9th bit which is not currently used by software.
> > > But the parity bit for CS7 must be zeroed out by software in order to
> > > get the correct raw data.
> > >
> > > Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> > 
> > What commit id does this fix?
> 
> The issue should have been there since the driver was written. As the CS7 mode was rarely used, we didn't notice the problem in the driver before.

So should this be backported to older stable kernels?

thanks,

greg k-h
