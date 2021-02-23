Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634DAC433DB
	for <linux-serial@archiver.kernel.org>; Tue, 23 Feb 2021 16:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 121D161606
	for <linux-serial@archiver.kernel.org>; Tue, 23 Feb 2021 16:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbhBWQw1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Feb 2021 11:52:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:42524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231915AbhBWQw0 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Feb 2021 11:52:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1D3F64E61;
        Tue, 23 Feb 2021 16:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614099105;
        bh=eMrPfZ45f1kslps9cQ6Pq/QDF0YNzTrMUdC1uyr4tw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J7EjFxOCV/leUi57VQwGwr54yFXYE+0gfeqzucZDHiMTYt3rJptJ2s9o21yPw7MAd
         zpE0LxE58ZsR2dhta9c2tj9Rt0+jqI0s5ogTfZbVB8H3igF07w55gpo6W0OPJVmona
         aoQk/cPvGdzJNSv/4kYBItJUZEtI/OTTaiUfGm4LWsZlc/n211zemSz2dpFBZTe4aG
         lC04WJHISMOiLHsbaNeA6GIplnUn1ZIg/l8qUHuxWNUweHii1dltXwy5Ozn54yVKL4
         NIqZwo30jB8PxsSvEFJ8HjHn22jW/O75ZRQ0cHnsePLBsTNkTgnp/FWpyobrPkweFG
         xSqd3QZMgvUQg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lEaun-0006iZ-0s; Tue, 23 Feb 2021 17:52:01 +0100
Date:   Tue, 23 Feb 2021 17:52:01 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "Michael G. Katzmann" <michaelk@IEEE.org>
Cc:     charles-yeh@prolific.com.tw, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Charles Yeh <charlesyeh522@gmail.com>,
        Joe Abbott <jabbott@rollanet.org>
Subject: Re: non-standard baud rates with Prolific 2303 USB-serial
Message-ID: <YDUysZY90FfVhrHK@hovoldconsulting.com>
References: <YDOvLseYXaUHs0lS@hovoldconsulting.com>
 <fb1489c2-b972-619b-b7ce-4ae8e1d2cc0f@IEEE.org>
 <YDPO/JprcDTaPmR4@hovoldconsulting.com>
 <0f9caf26-af58-13a9-9947-47bb646f505e@IEEE.org>
 <YDPS3AP63/PwmwJU@hovoldconsulting.com>
 <780b9aa6-890d-47fd-d6b2-cd9a39f7634a@IEEE.org>
 <YDUiuLtwRkZ0D0Mi@hovoldconsulting.com>
 <f63df659-6cdf-bba6-f892-1012b98f82e2@IEEE.org>
 <YDUp0tIThOZSTHJt@hovoldconsulting.com>
 <93584ae4-665e-1e67-01e0-cc53f987bee4@IEEE.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93584ae4-665e-1e67-01e0-cc53f987bee4@IEEE.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Feb 23, 2021 at 11:30:41AM -0500, Michael G. Katzmann wrote:
> On 2/23/21 11:14 AM, Johan Hovold wrote:
> > I only have an HXD (and a GC) here.
> >
> > The HXD has bcdUSB as 1.10 unlike your TA with 2.00, but not sure that
> > helps.
> 
> Sound promising .. why do you think this is this not reliable?

Perhaps it is. Perhaps even bcdDevice of 3.00 is enough (includes some
older variants that the TA replaced supposedly). Not sure anyone ever
tried the current scheme on those older models.

Charles, could you post the output of "lsusb -v" for your PL2303TA? And
did you verify that you actually got 110 Bd with the current Linux
driver?

Johan
