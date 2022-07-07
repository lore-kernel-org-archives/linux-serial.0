Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7FAC433EF
	for <linux-serial@archiver.kernel.org>; Thu,  7 Jul 2022 15:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbiGGPuS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Jul 2022 11:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiGGPuS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Jul 2022 11:50:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D41225EB9
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 08:50:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C10B6B82263
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 15:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8DBC3411E;
        Thu,  7 Jul 2022 15:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657209014;
        bh=xAO72M25iYsZI3b2KhCEty5IBEAEuUFGppdDsVpUdkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gB7QemuR5oy5oB/Mo8E3R63PyDxeG9RLQJxhvZSJMJ2B8Wfdl8ehrrgIxIpbIwBU+
         PnktL6SB5CLG9rT1TSDpjs16juW5CKpR25fxaibaqpmXP3Whx6I3Uk4pDDJzwCvee8
         UcnOTEpn3/i//IamWFIiqGY0R4IMcPelH182RmX0=
Date:   Thu, 7 Jul 2022 17:50:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     linux-serial@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH 1/7] USB: serial: ftdi_sio: Fix divisor overflow
Message-ID: <YscAswiqWZw3WqDp@kroah.com>
References: <20220707145354.29705-1-kabel@kernel.org>
 <20220707145354.29705-2-kabel@kernel.org>
 <Ysb2ybllKsZ4/81Y@kroah.com>
 <20220707173753.7d321cac@dellmb>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220707173753.7d321cac@dellmb>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jul 07, 2022 at 05:37:53PM +0200, Marek Behún wrote:
> On Thu, 7 Jul 2022 17:07:53 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Thu, Jul 07, 2022 at 04:53:48PM +0200, Marek Behún wrote:
> > > From: Pali Rohár <pali@kernel.org>
> > > 
> > > Divisor in the register is a 17-bit wide number.
> > > Therefore we need to clamp it on overflow.  
> > 
> > Why, what is wrong with it overflowing, what will happen if it does?
> 
> The divisor register is 17-bits wide (14 bits integer part, 3 bits
> fractional). So suppose that we compute divisor 0x20001. Writing to
> the register puts 0x00001 there, cause the 17th bit gets discarded
> (since the register is 17-bits wide). Which will result in dividing by
> 1.

So worst case, if you have a broken device, is you will get the wrong
baudrate?  This isn't really a "bug" then, but just making things a bit
better if you have a crazy device?

> The best thing we can do if we overflow is put the maximum value to the
> divisor, to get the lowest baudrate possible.

Ok, so not a big deal.

> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > Tested-by: Marek Behún <kabel@kernel.org>
> > > ---
> > >  drivers/usb/serial/ftdi_sio.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)  
> > 
> > What commit does this fix?  Is it a bugfix?  Can this ever happen in a
> > device?  Should it be backported?.
> 
> It is a bugfix; it can happen (happened to Pali when he was trying some
> low baudrates); it should be backported.

Ok, then properly tag cc: stable please.

thanks,

greg k-h
