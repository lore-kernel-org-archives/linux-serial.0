Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F02C433E0
	for <linux-serial@archiver.kernel.org>; Wed, 24 Feb 2021 17:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C36D264F08
	for <linux-serial@archiver.kernel.org>; Wed, 24 Feb 2021 17:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbhBXRFD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 Feb 2021 12:05:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:48292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235826AbhBXREk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Feb 2021 12:04:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D6AA64DE9;
        Wed, 24 Feb 2021 17:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614186238;
        bh=dKtTod7AMNOj8VyrPu/VStlFGSLA/9lc6ZVb5L7HTTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u4yqNzGZzcUxwJur0NMxm+g8c3OJvXW5KwFnKgmmg8MkwHmsQgVS53z7LPH5G9MXm
         HLwghxYGPeTitCjx2amNn5bN5BTAv9Csm9yu9szuNmsA4+EZDqiC0jJYx2c8U3zWOr
         paf2RhsEojtgNyQd/b8L1z/rZ2eYjkFVbrvoRs548jYPaYdlxhX42ytYKDEY+Xdmxn
         IKkUiVOWUPuMnJcBI9KUZlWaigZLoDBdn6Dgp9+ALbXZaNEoEB58s++Mt7fBshU/Dq
         1t+/T0YUPcA48swTCHxc4jCLRzk9RtSyeU2rOblcL4KFXdgpQNJYyozK+uoavTkxE3
         2GoKr+OYn4aOw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lExaE-0006kj-7G; Wed, 24 Feb 2021 18:04:18 +0100
Date:   Wed, 24 Feb 2021 18:04:18 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "Michael G. Katzmann" <michaelk@IEEE.org>
Cc:     charles-yeh@prolific.com.tw, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Charles Yeh <charlesyeh522@gmail.com>,
        Joe Abbott <jabbott@rollanet.org>
Subject: Re: non-standard baud rates with Prolific 2303 USB-serial
Message-ID: <YDaHEtQCGkiM/pad@hovoldconsulting.com>
References: <YDPO/JprcDTaPmR4@hovoldconsulting.com>
 <0f9caf26-af58-13a9-9947-47bb646f505e@IEEE.org>
 <YDPS3AP63/PwmwJU@hovoldconsulting.com>
 <780b9aa6-890d-47fd-d6b2-cd9a39f7634a@IEEE.org>
 <YDUiuLtwRkZ0D0Mi@hovoldconsulting.com>
 <f63df659-6cdf-bba6-f892-1012b98f82e2@IEEE.org>
 <YDUp0tIThOZSTHJt@hovoldconsulting.com>
 <93584ae4-665e-1e67-01e0-cc53f987bee4@IEEE.org>
 <YDUysZY90FfVhrHK@hovoldconsulting.com>
 <4edfb35f-ed81-bade-daee-38a1d7a60a7d@IEEE.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4edfb35f-ed81-bade-daee-38a1d7a60a7d@IEEE.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Feb 23, 2021 at 02:15:06PM -0500, Michael G. Katzmann wrote:
> On 2/23/21 11:52 AM, Johan Hovold wrote:
> > On Tue, Feb 23, 2021 at 11:30:41AM -0500, Michael G. Katzmann wrote:
> >> On 2/23/21 11:14 AM, Johan Hovold wrote:
> >>> I only have an HXD (and a GC) here.
> >>>
> >>> The HXD has bcdUSB as 1.10 unlike your TA with 2.00, but not sure that
> >>> helps.
> >> Sound promising .. why do you think this is this not reliable?
> > Perhaps it is. Perhaps even bcdDevice of 3.00 is enough (includes some
> > older variants that the TA replaced supposedly). Not sure anyone ever
> > tried the current scheme on those older models.
> >
> > Charles, could you post the output of "lsusb -v" for your PL2303TA? And
> > did you verify that you actually got 110 Bd with the current Linux
> > driver?
> >
> > Johan
> 
> Here is the USB packet capture from Wireshark oon Windows 10 when:
> 
> 1) plugging in pl2303 (packets 18-393)
> 
> 2) setting the device wia cmd line to 110/even/7 bits/2 stop (packets 393-690)
> 
> (device is on port 1.7)
> 
> https://drive.google.com/file/d/17TkV9JB2iFNdr4LvRftBnV3_DgITGvUH/view?usp=sharing
> 
> There are orders of magnitude more traffic than in Linux!

Thanks, I'm sure this will come in handy, but I haven't had time to dig
into it myself yet.

Best case, all TAs need the alternate encoding, but Charles seems to
suggest it isn't that easy and in which case the answer probably lies in
these traces.

Perhaps you can even figure out how to poll for an empty TX FIFO from
it, unless Charles is able to provide some details on that separate
matter?

Johan
