Return-Path: <SRS0=HSIU=4I=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC6AC11D07
	for <linux-serial@archiver.kernel.org>; Thu, 20 Feb 2020 12:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBCD82467B
	for <linux-serial@archiver.kernel.org>; Thu, 20 Feb 2020 12:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582202727;
	bh=R4MR6DVkT9fI4lVE6MAadw5/IsujVCI32gaUZVMdTWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PWEDiaR0Ns6ZLQZlJCHJ9XFhOz0lcV3SFp5+XBOPhDgpJNd5Vljp2iN9M7wx0BVnh
	 ppFwJ/iFaIUtoPcIEHU7m2+a1+TI4oZuV+ga3uxEbQZL6BROxxIaQxg9gI3La7grAg
	 Z1JTh3AU1+Dx6W7KM7QbkM4NVDMXEobtYM2xRrD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgBTMp0 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 Feb 2020 07:45:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:43944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727931AbgBTMp0 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Feb 2020 07:45:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6733924670;
        Thu, 20 Feb 2020 12:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582202725;
        bh=R4MR6DVkT9fI4lVE6MAadw5/IsujVCI32gaUZVMdTWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DtYaGpnYgHUa37yk9rSh7s9Ucg37EdokQNeKuf+WeP7OJs/OWD6tGWi2zzmcf6DSL
         2NY3OGx2Cju2fueAvkEpOBX3Gr+o+rFwCbQBHVaHpju6wiv03HxWeOc1zeAy9wre+L
         t/iWoAOuH/YmU/CfDKq71hWBQBImSZb8B3NK8mpk=
Date:   Thu, 20 Feb 2020 13:45:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/24] n_hdlc: convert debuglevel use to pr_debug
Message-ID: <20200220124523.GA3386763@kroah.com>
References: <20200219084118.26491-1-jslaby@suse.cz>
 <20200219084118.26491-3-jslaby@suse.cz>
 <f3bac52dffc9e5402eb6c6106256dffaf550ee90.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3bac52dffc9e5402eb6c6106256dffaf550ee90.camel@perches.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Feb 19, 2020 at 04:20:33AM -0800, Joe Perches wrote:
> On Wed, 2020-02-19 at 09:40 +0100, Jiri Slaby wrote:
> > With pr_debug we have a fine-grained control about debugging prints. So
> > convert the use of global debuglevel variable and tests to a commonly
> > used pr_debug. And drop debuglevel completely.
> > 
> > This also implicitly adds a loglevel to the messages (KERN_DEBUG) as it
> > was missing on most of them.
> []
> > diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
> []
> > @@ -310,11 +306,9 @@ static int n_hdlc_tty_open (struct tty_struct *tty)
> >  {
> >  	struct n_hdlc *n_hdlc = tty2n_hdlc (tty);
> >  
> > -	if (debuglevel >= DEBUG_LEVEL_INFO)	
> > -		printk("%s(%d)n_hdlc_tty_open() called (device=%s)\n",
> > -		__FILE__,__LINE__,
> > -		tty->name);
> > -		
> > +	pr_debug("%s(%d)%s() called (device=%s)\n",
> > +			__FILE__, __LINE__, __func__, tty->name);
> 
> Perhaps remove all the __FILE__ and __LINE__ arguments as
> dynamic debug could emit module and __LINE__ when necessary.

That can be a set of follow-on patches.  This patch is fine as-is for
now.

thanks,

greg k-h
