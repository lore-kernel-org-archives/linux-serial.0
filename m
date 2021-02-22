Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62128C433E0
	for <linux-serial@archiver.kernel.org>; Mon, 22 Feb 2021 15:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2366D64E20
	for <linux-serial@archiver.kernel.org>; Mon, 22 Feb 2021 15:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhBVPfG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Feb 2021 10:35:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:58782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230308AbhBVPes (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Feb 2021 10:34:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3E3564E15;
        Mon, 22 Feb 2021 15:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614008045;
        bh=PLUfrsiT9LoAuts3la+Ahf95p3/mGYFq6w0gm3p1IFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ei1+fIXqC4GMoOkPfJQnXIeXDu5tv0qTfsWXVxOV5atyN2wagYcBMyHepnIRNOTzk
         xxj8Nf6xZpYSzeRZco98zZKdMDrX1aq6qHpUCs9Hjj+CGJbkJXU1GCq5HToftfYsuj
         WPcw7klEnC20qHBpbmUourlwv9jEiJhzvmU8HB96LA3GrZEQ2GgoHS86TD2AkU/Llm
         8IfhdvibUAvssVr+gqxKG+kALB+J2xyNvrv9R6G+FmV/mNDYU0cQ1O75eepmh4NKDa
         8PaJl7jkL3Jwveygi2x1pM7hAPwHwtw8BgPDAJ6sNM5/TvJDBzt9DyCY/bgkDCk/07
         TUpncDdiQH+rA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lEDE4-00061D-U1; Mon, 22 Feb 2021 16:34:21 +0100
Date:   Mon, 22 Feb 2021 16:34:20 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "Michael G. Katzmann" <michaelk@IEEE.org>
Cc:     charles-yeh@prolific.com.tw, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Charles Yeh <charlesyeh522@gmail.com>,
        Joe Abbott <jabbott@rollanet.org>
Subject: Re: non-standard baud rates with Prolific 2303 USB-serial
Message-ID: <YDPO/JprcDTaPmR4@hovoldconsulting.com>
References: <3aee5708-7961-f464-8c5f-6685d96920d6@IEEE.org>
 <dc3458f1-830b-284b-3464-20124dc3900a@IEEE.org>
 <YDNwxtDxd7JntAXt@hovoldconsulting.com>
 <e2dcc839-3b43-2c80-6ad1-2d97e639b46a@IEEE.org>
 <YDOvLseYXaUHs0lS@hovoldconsulting.com>
 <fb1489c2-b972-619b-b7ce-4ae8e1d2cc0f@IEEE.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb1489c2-b972-619b-b7ce-4ae8e1d2cc0f@IEEE.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Feb 22, 2021 at 09:53:39AM -0500, Michael G. Katzmann wrote:
> On 2/22/21 8:18 AM, Johan Hovold wrote:
> 
> I tried hardcoding buf[6-0] in pl2303_set_termios as
> 
> a8 a6 01 80 00 02 07 and got a bitrate of ~200kb 
> 
> so, no these settings do not work in my case (or I missunderstood your
> instructions 8-))

Thanks for testing (and that was with 0xa8 in byte 0, right?)

So it seems we have three devices with bcdDevice 0x0300 encoding the
divisors in slightly different ways and that are all still supported by
the vendor's Windows driver.

Unless Prolific are willing to shed some light on this, I guess someone
needs to try to figure out how the Windows driver determines which
encoding to use.

Is your device supposedly also a PL2303 TA? Could you post the output of
lsusb -v for completeness?

Johan
