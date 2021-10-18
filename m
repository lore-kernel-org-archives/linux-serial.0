Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF29C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 18 Oct 2021 08:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDF0D6126A
	for <linux-serial@archiver.kernel.org>; Mon, 18 Oct 2021 08:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbhJRIpK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 Oct 2021 04:45:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:59034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230416AbhJRIpJ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Oct 2021 04:45:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67B9260F8F;
        Mon, 18 Oct 2021 08:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634546578;
        bh=LK7T2Y+xXd3P7ZwHhMtvsN3a/ih3NJOP2jLz2mCvW6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=umuUUtzB3n43PokrqJb9aK5B5iSSGOWySnOSKiv+A9czxLnbldn8yPjdYJfm5P2c/
         YhAjrO68/sODTSK+cgbzgX1iq4gYTm3tfKQTNIvkUGWIYN1ZmzlFRyQvBWPOcyyOpg
         39AdXvaxJECEaTNFfW2iqXH4rAO/6HcbzTqRLpmw=
Date:   Mon, 18 Oct 2021 10:42:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     linux-serial@vger.kernel.org, michals@xilinx.com,
        shubhrajyoti.datta@gmail.com, git-dev@xilinx.com
Subject: Re: [PATCH] uartlite: Update the default for the parameter
Message-ID: <YW0zj9XGTvLLp48G@kroah.com>
References: <20211018082000.607185-1-shubhrajyoti.datta@xilinx.com>
 <YW0zZVBLImlS4g1R@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW0zZVBLImlS4g1R@kroah.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Oct 18, 2021 at 10:42:13AM +0200, Greg KH wrote:
> On Mon, Oct 18, 2021 at 01:50:00PM +0530, Shubhrajyoti Datta wrote:
> > Update the default number of uarts.
> > The commit b44b96a060f3 changed the default from 16 to 1 change it back to 16.
> > 
> > Fixes: b44b96a060f3 (uartlite: Adding a kernel parameter for the number of uartlites)
> > 
> 
> No extra line here please.
> 
> Also, your subject is odd, please make it more obvious what is
> happening.
> 
> But nost importantly, _WHY_ are you making this change?  What happened
> since that commit was made that now we should have the default be 16?
> Previously that commit said the default should NOT be 16, and here you
> are changing it back.  What changed to require this?

Also, you failed to cc: the author of that commit, which isn't the most
kind thing to do.  Please do so when you resubmit this with the
requested changes.

thanks,

greg k-h
