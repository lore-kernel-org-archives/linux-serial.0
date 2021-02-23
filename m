Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCEEC433E6
	for <linux-serial@archiver.kernel.org>; Tue, 23 Feb 2021 16:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F268964E3F
	for <linux-serial@archiver.kernel.org>; Tue, 23 Feb 2021 16:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbhBWQOl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Feb 2021 11:14:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:37772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233514AbhBWQOi (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Feb 2021 11:14:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F96A64E3F;
        Tue, 23 Feb 2021 16:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614096835;
        bh=X7jJSpYpIlmkfxxrNGHU1k1r6tFSjeHHP8+BtWzUXaY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=feJp0gYxZDo2vBkRN0r6Dqj9Dk9nlfO27Ma13juDpnrsuPO4pqtbmuCRviXqkEez+
         QxDEQ7ttSJABwoFHEOiv5XNnwtFIHrvVfFPKBGmQgNo8j7jUe85SuiFpszowetbrd7
         qgQtassVtDNXY0GQOHQOXH1SrdDqDIA8B4N3VtbJlgGiNWC2MDWufxuhbwVxvMM1B5
         jLfYKMOLp27EByAOvFb5AvNspmQTbUf8FSfv7/N7ryKzDLLR7MeIvKvjRRq3nb4TEX
         tiDry/j3pUfbFf/rJL29mNTXCGmZoDGFOCtk7WP5Nl+OQIPswTtEXyOtAEBOo6J5kY
         4NjYOXugbnOIw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lEaKA-0004gN-DC; Tue, 23 Feb 2021 17:14:11 +0100
Date:   Tue, 23 Feb 2021 17:14:10 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "Michael G. Katzmann" <michaelk@IEEE.org>
Cc:     charles-yeh@prolific.com.tw, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Charles Yeh <charlesyeh522@gmail.com>,
        Joe Abbott <jabbott@rollanet.org>
Subject: Re: non-standard baud rates with Prolific 2303 USB-serial
Message-ID: <YDUp0tIThOZSTHJt@hovoldconsulting.com>
References: <YDNwxtDxd7JntAXt@hovoldconsulting.com>
 <e2dcc839-3b43-2c80-6ad1-2d97e639b46a@IEEE.org>
 <YDOvLseYXaUHs0lS@hovoldconsulting.com>
 <fb1489c2-b972-619b-b7ce-4ae8e1d2cc0f@IEEE.org>
 <YDPO/JprcDTaPmR4@hovoldconsulting.com>
 <0f9caf26-af58-13a9-9947-47bb646f505e@IEEE.org>
 <YDPS3AP63/PwmwJU@hovoldconsulting.com>
 <780b9aa6-890d-47fd-d6b2-cd9a39f7634a@IEEE.org>
 <YDUiuLtwRkZ0D0Mi@hovoldconsulting.com>
 <f63df659-6cdf-bba6-f892-1012b98f82e2@IEEE.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f63df659-6cdf-bba6-f892-1012b98f82e2@IEEE.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Feb 23, 2021 at 10:57:09AM -0500, Michael G. Katzmann wrote:
> On 2/23/21 10:43 AM, Johan Hovold wrote:
> > On Tue, Feb 23, 2021 at 09:58:47AM -0500, Michael G. Katzmann wrote:
> >> Is it that we are presuming that what Prolific is telling us is true
> >> and only Joe and I are actually measuring the data rate?  (i.e. why
> >> does the Prolific Windows driver set the values as Joe found ???)
> > I'm starting to think they've added some alternate baud rate encoding in
> > order to make life harder for the people pushing (or unknowingly buying)
> > counterfeit devices.
> >
> > As you say, why else would the Windows driver support this encoding?
> 
> I find that  'Halon;'s razor' is helpful in these situations...  I
> can't think that messing with people who use old teleprinters would be
> useful in protecting one's products 8-)

Heh, guess you're right.

> If Joe has some wireshark traces we can see if there are any vendor
> specific USB packets. If not I can try it (I'd be starting from
> scratch as I've only use wireshark on Linux).
> 
> I presume you can't see any differentiators in the normal USB
> identifiers that we can use. 

I only have an HXD (and a GC) here.

The HXD has bcdUSB as 1.10 unlike your TA with 2.00, but not sure that
helps.

> If someone has a device that works under the existing driver, it would
> be helpful to see if the modified scheme also works on those devices?
 
I tried with both of mine when Joe reported this and neither works with
the alternate scheme (and the GC turned out not to even support divisor
encoding).

Johan
