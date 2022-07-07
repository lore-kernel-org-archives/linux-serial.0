Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9056C43334
	for <linux-serial@archiver.kernel.org>; Thu,  7 Jul 2022 16:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbiGGQGT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Jul 2022 12:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiGGQGS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Jul 2022 12:06:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1822331372
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 09:06:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDF15B82298
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 16:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C777C3411E;
        Thu,  7 Jul 2022 16:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657209975;
        bh=7DAuKIBQVOOBfGbhxSwiABTDHg8AGFpsH7ZrEwBeqlU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0NEBeYN/r13XRgqJQqZq//8r4D/IPYd1Fx2+DZkk03ipDyd7Ud8mFKsnR2BQJtPjC
         FiqhFWbknbawUBzuuelBNMwGCiZAPJeCNpXh3183m3O6O/yQt77pahYNy0Kd0Imx6i
         MdX0MgVGno9fV1/6hX4TLZe5N0tQEVbSi7lDPhjs=
Date:   Thu, 7 Jul 2022 18:06:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     linux-serial@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH 4/7] USB: serial: ftdi_sio: Do not reset baudrate to 9600
 on error
Message-ID: <YscEdEUWc14G7GR+@kroah.com>
References: <20220707145354.29705-1-kabel@kernel.org>
 <20220707145354.29705-5-kabel@kernel.org>
 <Ysb3cotx1FFyiaES@kroah.com>
 <20220707175235.2cdb6f9a@dellmb>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220707175235.2cdb6f9a@dellmb>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jul 07, 2022 at 05:52:35PM +0200, Marek Behún wrote:
> On Thu, 7 Jul 2022 17:10:42 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Thu, Jul 07, 2022 at 04:53:51PM +0200, Marek Behún wrote:
> > > From: Pali Rohár <pali@kernel.org>
> > > 
> > > On failure to set new baudrate, reset baudrate to the previous value
> > > (as is done by other serial drivers) instead of resetting to 9600.  
> > 
> > Where is it mandated that this is correct?  Why not keep the existing
> > functionality?  Did you just break systems that tried to set invalid
> > values and ended up with 9600 as a default?
> 
> Pali says all other drivers keep previous value on failure. He got
> frustrated when working with FTDI devices because they behaved
> differently.

That's fine, but again, you are changing user-visible behavior here, so
you need a real justification for it and be aware that it might break
people's workflow.

thanks,

greg k-h
