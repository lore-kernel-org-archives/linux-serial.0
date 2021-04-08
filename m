Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C949C433ED
	for <linux-serial@archiver.kernel.org>; Thu,  8 Apr 2021 15:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F22361151
	for <linux-serial@archiver.kernel.org>; Thu,  8 Apr 2021 15:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbhDHPfn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 8 Apr 2021 11:35:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231480AbhDHPfm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Apr 2021 11:35:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10D11610A3;
        Thu,  8 Apr 2021 15:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617896131;
        bh=Lzr9PbMX2sOWLz1c3qQAnuCyMDmH57bdFvXG7zYRQ30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AbI5TeXhSQ/1NitsWMx0gSMQhyWT2+PFJ2EKvJLdXCEkK3l9j34/lXhmWT+Z8HMfX
         zZUXpz0vRVWlO4+B3hMM7l1JGXmw5AeOR8sicmPwOTAm+nv9bhEDlcCjYEckkA5UQk
         0Gin7hmtpaxx5SKFh521P+kvCS02oEFX2klRb1FbGrf/CHsQS776VTWucRyocLZ1iy
         OCKcwrseApj2SgkRUVBqWRD4Yjq5KxSehIUzs5WEaJ5Y0IbfcEOwtlIpwksIkUfnmq
         pzgcCEYpObUgGX1dxcWCEENEaOekEAko2wfMkpy4Akj2Jfow6YBd4EpqYlXqmuzTPZ
         9YGS6JFX4bjUA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lUWgo-0004aK-5t; Thu, 08 Apr 2021 17:35:26 +0200
Date:   Thu, 8 Apr 2021 17:35:26 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Michael G. Katzmann" <michaelk@IEEE.org>
Cc:     charles-yeh@prolific.com.tw, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Charles Yeh <charlesyeh522@gmail.com>,
        Joe Abbott <jabbott@rollanet.org>
Subject: Re: non-standard baud rates with Prolific 2303 USB-serial
Message-ID: <YG8ivp+UtMU2NLwa@hovoldconsulting.com>
References: <780b9aa6-890d-47fd-d6b2-cd9a39f7634a@IEEE.org>
 <YDUiuLtwRkZ0D0Mi@hovoldconsulting.com>
 <f63df659-6cdf-bba6-f892-1012b98f82e2@IEEE.org>
 <YDUp0tIThOZSTHJt@hovoldconsulting.com>
 <93584ae4-665e-1e67-01e0-cc53f987bee4@IEEE.org>
 <YDUysZY90FfVhrHK@hovoldconsulting.com>
 <4edfb35f-ed81-bade-daee-38a1d7a60a7d@IEEE.org>
 <YDaHEtQCGkiM/pad@hovoldconsulting.com>
 <2162ce18-32e9-e54c-f266-47febdea11f1@IEEE.org>
 <YDdi7NcnzgQDMzZH@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDdi7NcnzgQDMzZH@hovoldconsulting.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Michael,

On Thu, Feb 25, 2021 at 09:42:20AM +0100, Johan Hovold wrote:
> On Wed, Feb 24, 2021 at 01:13:39PM -0500, Michael G. Katzmann wrote:
> > On 2/24/21 12:04 PM, Johan Hovold wrote:
> > > Perhaps you can even figure out how to poll for an empty TX FIFO from
> > > it, unless Charles is able to provide some details on that separate
> > > matter?
> > 
> > I presume from the code below, that when the device is closed, all
> > data waiting to send is clobbered (if so, so the problem is the driver
> > and not the device)
> > 
> > I would have thought that the driver should drain the buffers. I can
> > see that this might be a problem if there is flow control (it may
> > never drain) but the current method seems pretty brutal.
> 
> We do; the code below isn't called until after we've waited for the
> buffers to drain (driver buffers + device FIFO).
> 
> I'll provide a patch so that you can extend the timeout for draining the
> driver buffers (defaults to 30 s), but the main problem is that we don't
> know how to query the PL2303 FIFO fill level.

I've added generic support to USB serial for setting the closing_wait
parameter through TIOCSSERIAL (e.g. setserial) so that you can change
the default 30 second timeout also with pl2303:

	https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/commit/?h=usb-next&id=01fd45f676f1b3785b7cdd5d815f9c31ddcd9dd1

With the 4k driver buffer and two bulk-out URBs with 256 bytes of data
each you need to set the timeout to something like 420 seconds at 110
bps to allow those buffers to drain (when not using flow control).

On top of that there's the 256 byte device FIFO, which we not yet know
how to query. At 110 bps that one takes about 23 seconds to drain, but
as I mentioned elsewhere we cap the time-based delay at 2 seconds
currently.

Charles, is there a way to check if the device transmit FIFO has
emptied?

Johan
