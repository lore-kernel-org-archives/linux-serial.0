Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1680C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 16 Nov 2021 08:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DE7161B49
	for <linux-serial@archiver.kernel.org>; Tue, 16 Nov 2021 08:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbhKPIb1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 16 Nov 2021 03:31:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:40608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232018AbhKPIbX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 16 Nov 2021 03:31:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2411861B96;
        Tue, 16 Nov 2021 08:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637051306;
        bh=GsBEHnqMkjDCb+qHzdBsRXrv5he05mH+4kVgyqKMjk8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T98FoSSh997hGZHvamWNnRPIFS2BkzQEG5SWPzWrBPd5/KUvsyiWQq+Q5KRrKsSEE
         9nHxjgTstXFQjGpZLzZjYJEH0vOFN6Jjp5ycx1qSMktmwZ1AcTkSYiaFfHntRvSQki
         6y+Ja9osT+s3s6tL70ucsuXx82XFIc1kw7wRjL34=
Date:   Tue, 16 Nov 2021 09:28:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jochen Mades <jochen@mades.net>
Cc:     "sistik@3ksolutions.sk" <sistik@3ksolutions.sk>,
        linux-serial@vger.kernel.org
Subject: Re: Extending serial port linux driver to toggle RS485 direction pin
 (GPIO)
Message-ID: <YZNrqFGjTbu77b/n@kroah.com>
References: <731e2516-9703-8c9a-7e56-e7e7b362de94@mades.net>
 <YYGKbfvFki8VN4HN@kroah.com>
 <236176398.157022.1637045032216@webmail.strato.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <236176398.157022.1637045032216@webmail.strato.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Tue, Nov 16, 2021 at 07:43:52AM +0100, Jochen Mades wrote:
> Hi Greg, Hi Ivan,
> 
> as would like to extend the RS485 behavior on my raspberry PI I did some "deep-diving" into the amba-pl011 driver and soon recognized the missing hardware support to detect "FIFO empty". Googling around I found the following patch, describing exactly my problem:
> https://lore.kernel.org/linux-arm-kernel/20200107072831.GB1014453@kroah.com/T/
> 
> As I'm not familiar with your processes, I kindly ask you where I can find the patched sources of this Soft-Rs485-Amba driver and if it is planned to be intergrated in a future kernel release?

I do not remember if these patches have been resubmitted or not, check
the current kernel tree for details.

If not, then obviously they need to be fixed up based on the review
comments made.

thanks,

greg k-h
