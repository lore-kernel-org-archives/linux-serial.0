Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA62C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 16 Nov 2021 14:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B609161C12
	for <linux-serial@archiver.kernel.org>; Tue, 16 Nov 2021 14:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237409AbhKPOYZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 16 Nov 2021 09:24:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:40526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237365AbhKPOYR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 16 Nov 2021 09:24:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D56D461C12;
        Tue, 16 Nov 2021 14:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637072479;
        bh=YTZ+zbwkt1hDyj5s4lVOdtoEYNgWgeLp6RYeAXL0occ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AbsXGZazgE7lGzTylT209quVYIEnAOPiiKBKhkRi9wm+OK74nwj3fIerEtFHTjXDn
         c4ApkBljHtbhM4FnLqw685hoYYp6CYYp4G22XNnOmbiRAErMyT7NC7bvtbFa5O2g/W
         vpBvKp8MzquvyxV/qCKM4ELE2Fdr8GUsKD57egXA=
Date:   Tue, 16 Nov 2021 15:21:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jochen Mades <jochen@mades.net>
Cc:     "sistik@3ksolutions.sk" <sistik@3ksolutions.sk>,
        linux-serial@vger.kernel.org
Subject: Re: Extending serial port linux driver to toggle RS485 direction pin
 (GPIO)
Message-ID: <YZO+Xe9ht2cxkUw8@kroah.com>
References: <731e2516-9703-8c9a-7e56-e7e7b362de94@mades.net>
 <YYGKbfvFki8VN4HN@kroah.com>
 <236176398.157022.1637045032216@webmail.strato.com>
 <YZNrqFGjTbu77b/n@kroah.com>
 <1972392418.278738.1637063239577@webmail.strato.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1972392418.278738.1637063239577@webmail.strato.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Nov 16, 2021 at 12:47:19PM +0100, Jochen Mades wrote:
> 
> > I do not remember if these patches have been resubmitted or not, check
> > the current kernel tree for details.
> > 
> > If not, then obviously they need to be fixed up based on the review
> > comments made.
> > 
> > thanks,
> > 
> > greg k-h
> 
> In the current kernel tree there is nothing to find about these patches.
> Do you know about any alternatives?

Try taking those patches and reworking them to work for you and submit
them yourself.

> P.S.: is this the posting style you prefer?

Yes please, but please include all relevant information.  Remember, some
of us get thousands of emails a day.

thanks,

greg k-h
