Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF679C433DB
	for <linux-serial@archiver.kernel.org>; Fri,  5 Mar 2021 10:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0EED64F6E
	for <linux-serial@archiver.kernel.org>; Fri,  5 Mar 2021 10:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhCEKK6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 5 Mar 2021 05:10:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:48640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230086AbhCEKKg (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 5 Mar 2021 05:10:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B81764F5B;
        Fri,  5 Mar 2021 10:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614939036;
        bh=sQJUXg0/iRhz8c6mjuijyXWDNM/W7C7VLNOrYX2GVbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CYjeg3NXH6muEdhd8Viw8B+hzFAWKBZFBhCrgOdmLDOBCWQKNVFzA30ZFf7kMyQQS
         Hnsr13hmJZuqF6Jt1i+qAegQY5Ju71rDOi4TrYFGGu1gkHjq9yH+w4SzRG/nyPYQsB
         vQp51QXIlhz388uF2HcrbMhG5P4o0hmqFKtdjlnBuUJ6sUZ4CZVzwl8Vs+Oqlty4HJ
         XiriYRbvgbySA95IEFTRKAHwiFmJ8DJ8e5TeMf2JYkDYqnF0mz6Os2FBCFBp8UjrVn
         amgBphEJX+4LTT+2LvikK+7sAcnfyd0rI6JXRzgsT6+5lDDLJY23t3jy3mg9hfjOft
         UgXmEwD8rVXfg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lI7Q3-0001JA-3M; Fri, 05 Mar 2021 11:10:51 +0100
Date:   Fri, 5 Mar 2021 11:10:51 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 37/44] USB: serial/keyspan, drop unneeded forward
 declarations
Message-ID: <YEIDq4n7eSagyY9F@hovoldconsulting.com>
References: <20210302062214.29627-1-jslaby@suse.cz>
 <20210302062214.29627-37-jslaby@suse.cz>
 <YD/gt/U2fzaV+yNh@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YD/gt/U2fzaV+yNh@kroah.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Mar 03, 2021 at 08:17:11PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Mar 02, 2021 at 07:22:07AM +0100, Jiri Slaby wrote:
> > Forward declarations make the code larger, harder to follow and rewrite.
> > Harder as the declarations are often omitted from global changes. Remove
> > forward declarations which are not really needed, i.e. when the
> > definition of the function is before its first use.
> > 
> > Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> > Cc: Johan Hovold <johan@kernel.org>
> > ---
> >  drivers/usb/serial/keyspan.c | 20 --------------------
> >  1 file changed, 20 deletions(-)
> 
> I'll let Johan take this through his tree:
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks, I'll pick these two up next week.

Jiri, was there ever a cover letter to this series? It took a while for
all 44 (!) patches to hit the lists (or my inbox), but I never could
figure out whether there was an overall theme to it that made you post
it all as a single series in the first place.

Johan
