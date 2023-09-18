Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14338CD3424
	for <linux-serial@archiver.kernel.org>; Mon, 18 Sep 2023 07:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240192AbjIRHap (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 Sep 2023 03:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240334AbjIRHam (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Sep 2023 03:30:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7EE1AC
        for <linux-serial@vger.kernel.org>; Mon, 18 Sep 2023 00:30:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2CBC43391;
        Mon, 18 Sep 2023 07:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695022225;
        bh=5FTGLCl/DqDOKzwQ4oC8693fKzWrhbmjNEecagXj4gA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nwPhvycaItGDoy2vTyVvVdEfr7h8povrXJAtq0j+nQxqiKjFd20HYiuQJqo+hBR/H
         aXGNbX2uP9vZJ1kBxeNiQ9LrJV+u/mDteegv6/UXXwGwrX1SlaVN2u7e/7EXx/Kv/y
         n5hFTqZtU/ITPbkQTx0G2MsS9pz5AmMRqhl8EBq8=
Date:   Mon, 18 Sep 2023 09:30:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthew Howell <matthew.howell@sealevel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        jeff.baldwin@sealevel.com, james.olson@sealevel.com,
        ryan.wenglarz@sealevel.com, darren.beeson@sealevel.com,
        linux-serial@vger.kernel.org, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH V5 1/2] serial: exar: Revert "serial: exar: Add support
 for Sealevel 7xxxC serial cards"
Message-ID: <2023091836-distract-lend-e606@gregkh>
References: <a804d136-4865-f528-6434-68a7358d7606@sealevel.com>
 <ZQNZJwJoad0EkIYL@smile.fi.intel.com>
 <15c38a1b-65ed-54db-c973-0ae995e201d4@sealevel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15c38a1b-65ed-54db-c973-0ae995e201d4@sealevel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Sep 14, 2023 at 03:51:26PM -0400, Matthew Howell wrote:
> On Thu, 14 Sep 2023, Andy Shevchenko wrote:
> > On Thu, Sep 14, 2023 at 08:28:47AM -0400, Matthew Howell wrote:
> > > From: Matthew Howell <matthew.howell@sealevel.com>
> > >
> > > Hardware ID of Sealevel 7xxxC cards changed prior to release. This has rendered 14ee78d5932a redundant.
> > 
> > Too long line.
> > 
> > > Revert "serial: exar: Add support for Sealevel 7xxxC serial cards"
> > >
> > > This reverts commit 14ee78d5932afeb710c8305196a676a715bfdea8.
> > >
> > > Link: https://lore.kernel.org/all/72b3e74e-ced6-784c-01e0-8a851326a203@sealevel.com/T/
> > > Fixes: 14ee78d5932a ("Add support for Sealevel 7xxxC serial cards")
> > > Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
> > 
> > The patch 1 and patch 2 have not been linked via email, so mail archives and
> > mail clients do not see this as a thread. I suggest to use `git send-email` for
> > patches. With --thread option (which I believe should be default) it chains
> > the mails it sends.
> 
> I have not seen any way to setup git send-mail with this email as git 
> send-email seems to lack OAUTH2. If you can set it up with OAUTH2 & O365  
> I have not been able to find any documentation or guides on how to do 
> this.

If you are using mutt, just respond to the first patch with the second
one.  Otherwise our tools really don't like dis-joined patch series and
I have to dig them out by hand :(

I'll do so for this one, but in the future, please fix up.

thanks,

greg k-h
