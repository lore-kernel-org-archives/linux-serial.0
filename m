Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A562C433EF
	for <linux-serial@archiver.kernel.org>; Fri,  1 Jul 2022 09:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbiGAJYU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 1 Jul 2022 05:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbiGAJYH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 Jul 2022 05:24:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B5C12746;
        Fri,  1 Jul 2022 02:24:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9FDE1B82959;
        Fri,  1 Jul 2022 09:24:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D00C3411E;
        Fri,  1 Jul 2022 09:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656667444;
        bh=Zvsd3QERLmTisrPZwjXFkTicJFaJSmHz03J/syrOPmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GtsQ0y2A54FRyfRMLtFMvAIErVDOFb+6sEyJD53QwiODKAfTvyBHUH/kwt3gQ08jA
         iitSShucotxmVM37/fljWulv7OsFHuHYjCUe4VbXJXugqzPatLzoDGWnwuUeIEJpaO
         a3MOdTZiZFqqkIT8cmOJG6J5NfokEbuNaI4DpqoM=
Date:   Fri, 1 Jul 2022 11:24:01 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Neal Liu <neal_liu@aspeedtech.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: Questions about usb to serial driver
Message-ID: <Yr69MTLQHcJBC6Ts@kroah.com>
References: <HK0PR06MB3202C7064582E6CB027237BC80BD9@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <Yr6fQbeo/FDrBmfU@kroah.com>
 <HK0PR06MB3202364874FC7283767C05D280BD9@HK0PR06MB3202.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK0PR06MB3202364874FC7283767C05D280BD9@HK0PR06MB3202.apcprd06.prod.outlook.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jul 01, 2022 at 08:57:51AM +0000, Neal Liu wrote:
> > -----Original Message-----
> > From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> > Sent: Friday, July 1, 2022 3:16 PM
> > To: Neal Liu <neal_liu@aspeedtech.com>
> > Cc: linux-usb@vger.kernel.org; linux-serial@vger.kernel.org
> > Subject: Re: Questions about usb to serial driver
> > 
> > On Fri, Jul 01, 2022 at 03:16:13AM +0000, Neal Liu wrote:
> > > Hi all,
> > >
> > > I have a question about USB-serial and I hope I can find the answer from
> > here.
> > > I'll be appreciated it if there is any feedback from you.
> > >
> > > My question is If I have a USB device controller (udc) and a uart
> > > controller (16550) independently in a SoC, is there any usb-serial drivers or
> > applications that could possible to support/connect:
> > > -	udc tx to uart rx
> > > -	uart tx to udc rx
> > >
> > > Any chance I can make this SoC as a usb-serial devices?
> > 
> > Sure, use the CONFIG_USB_CONFIGFS_SERIAL or CONFIG_USB_CONFIGFS_ACM
> > build options and hook your gadget up to the serial port in userspace and you
> > will have a very expensive usb-serial converter (there are very cheap chips that
> > do the same thing if you want to make a simpler
> > device.)
> > 
> > hope this helps,
> 
> Thanks Greg!
> 
> What the detail steps exactly for "hook your gadget up to the serial port in userspace"?
> Assume my system has:
> 1 system uart: ttyS0
> 1 uart: ttyS1
> 1 usb gadget cdc acm: ttyGS0
> 
> How to hook up ttyS1 to ttyGS0, so that I could communicate through below path.
> PC1 - usb interface - my SoC (ttyGS0 - ttyS1) - rs232 interface - PC2?

That's an exercise left for the reader to do, odds are you need a
userspace program that just copies the data back and forth.  Try it and
see!

greg k-h
