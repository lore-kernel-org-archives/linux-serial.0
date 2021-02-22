Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC665C433DB
	for <linux-serial@archiver.kernel.org>; Mon, 22 Feb 2021 13:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80CC264DE9
	for <linux-serial@archiver.kernel.org>; Mon, 22 Feb 2021 13:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhBVNVI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Feb 2021 08:21:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:35678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231429AbhBVNTD (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Feb 2021 08:19:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC8E064DE9;
        Mon, 22 Feb 2021 13:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613999902;
        bh=LpfbMjpV7u/zvEEqjzs85NmoChmWc6GDwNKgZCrBLbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j0tWtN8cnhX+czxlRxykgyXUWnTJiX87CohV/GnALUjS4umRWFzTnu2kZDpEE8+Is
         09PK4DM98jxFhPsGEYgQdqwOP235S0s4ZZR9G+6bxli/fPnD3NQwW3zKCdsjGPVJBt
         VCtHK7upilYldyYlMarDvbcuvhQgTDLnZTD95Bdqms1OS52CtoQrV0DX+sP11sg+0V
         E0gl+j5wDxJYVBki2PVtn4xfFu2tV9k1Y5QMNMUXfycbhmsACkpN+4kzXIY1eWQtp0
         CuxBksyMWRcezdGkpwpGOgPDuPbhO8557MxZiAbmcgijDXISlSjeloqnXWHcEu5OXM
         0GisOprAFbQNg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lEB6k-0005Yc-5k; Mon, 22 Feb 2021 14:18:38 +0100
Date:   Mon, 22 Feb 2021 14:18:38 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "Michael G. Katzmann" <michaelk@IEEE.org>
Cc:     charles-yeh@prolific.com.tw, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Charles Yeh <charlesyeh522@gmail.com>,
        Joe Abbott <jabbott@rollanet.org>
Subject: Re: non-standard baud rates with Prolific 2303 USB-serial
Message-ID: <YDOvLseYXaUHs0lS@hovoldconsulting.com>
References: <3aee5708-7961-f464-8c5f-6685d96920d6@IEEE.org>
 <dc3458f1-830b-284b-3464-20124dc3900a@IEEE.org>
 <YDNwxtDxd7JntAXt@hovoldconsulting.com>
 <e2dcc839-3b43-2c80-6ad1-2d97e639b46a@IEEE.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2dcc839-3b43-2c80-6ad1-2d97e639b46a@IEEE.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Feb 22, 2021 at 07:39:42AM -0500, Michael G. Katzmann wrote:
> On 2/22/21 3:52 AM, Johan Hovold wrote:
> > Does your updated algorithm also result in 110 baud (8n1) being encoded
> > as:
> >
> > 	a8 a6 01 80 00 02 07
> >
> > And are you using some official Prolific Windows driver or something
> > that came with the device?
> 
> Johan,
> 
>   On Windows I did not install a new driver. It was recognized by the
> system and uses the Microsoft provided Prolific driver Ver 3.8.38.2.

Thanks for confirming. Then this sounds like something which Prolific
should be very well aware of.

> On windows everything looks fine (no sign of distress (i.e. no yellow
> caution triangle)).
> 
> Where should I look for the encoding (a8 a6 01 80 00 02 07) ? (110bd
> encodes as 80 00 C3 54 using the algorithm I described))

That was the encoding used by Joe's device (same driver I think) for
110n81.

It may not work with your device, but 0x10000 could just be a
2-prescaler bit:

	32 * 12*10^6 / (2 * 0x6a8 * 4^5) = ~110.03521126760563380282

where as you would have:

	32 * 12*10^6 / (0x354 * 4^6) = ~110.03521126760563380282

Could you try hardcoding 0x1a6a8 and and see if you end up with 110 bd?

> > I tried asking Prolific about this but I'm still not sure whether these
> > are official chips or counterfeit. 0x0300 is supposed to be a PL2303TA
> > and Prolific claims that the current driver is working fine with these
> > so we'd need to key off something more than just bcdDevice.

Johan
