Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05203C433E0
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 08:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A073564EAE
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 08:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhCOInR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Mar 2021 04:43:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:32898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229657AbhCOImv (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Mar 2021 04:42:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6A9064E99;
        Mon, 15 Mar 2021 08:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615797770;
        bh=Oj1NwfKYwM20Bposoxu3OxqBpYFrBdbyrQHSHfV2Rm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cmpFiiV+khAf5fg3+S8hESCLv5fmmkd4mUwNoX37GZp/yBJUwIntl02whA1Q6/bbD
         ztkNxZQPccuFkdM8BnSiAT9Q7s1cRfAJf/tRBXDpWfYSYHtuadqEP9WZ+tXK3Q9v80
         Thg4BdeRIF5SODbGRicRB3QWVG3VCxBeDVmx9d51UVnKCQkUSPtNQGasCgYOi/TLXY
         1MGJdhCwHJ+MEz+BXcrHrxZ61/OaqbWLKX3E3iM97Km0uzXuyVCgWkeggnF+xce2wG
         kSqbWHPKRVqhxmu/EDv0wUWvoN8CGp5VF+vXLvWHyxNL4B6SwW64K4/L6dUDBcYG7F
         w262zsain7PSQ==
Received: from johan by xi with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lLioa-0000ri-8r; Mon, 15 Mar 2021 09:43:04 +0100
Date:   Mon, 15 Mar 2021 09:43:04 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 37/44] USB: serial/keyspan, drop unneeded forward
 declarations
Message-ID: <YE8eGI0G/c444N0K@hovoldconsulting.com>
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

Now applied.

Johan
