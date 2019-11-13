Return-Path: <SRS0=6WdS=ZF=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC81C432C3
	for <linux-serial@archiver.kernel.org>; Wed, 13 Nov 2019 22:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7531A206F0
	for <linux-serial@archiver.kernel.org>; Wed, 13 Nov 2019 22:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573683967;
	bh=IaZwQoupZ1O2UE0fYS2yhW1U2yOjOwRsRTRJvyJ4II0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IsJrn5W91KCX1+m9ZaTbNLo6M3H/LEXIYn8sKO+WeonV8LFKq0vDa23RXEFJu5JYX
	 xy2JJ5XVbUHRMzQ6ZqtPuDe2bUn7zwVQ5qY8Vgrk8RviolqP9vjkcIEI3NYNni+Chr
	 N3ohXkjkVuEDGJ1h8ldI3z/p5z+94YdL0R4ySriw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfKMW0G (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 13 Nov 2019 17:26:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:50676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbfKMW0F (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 13 Nov 2019 17:26:05 -0500
Received: from localhost (unknown [61.58.47.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9D2E206EE;
        Wed, 13 Nov 2019 22:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573683966;
        bh=IaZwQoupZ1O2UE0fYS2yhW1U2yOjOwRsRTRJvyJ4II0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W+smA6JpBdW6av1PQUQrHOHYmTu3Lt9VqF+bOEGEshrj6kastp5BScK5aoe/ZIlGM
         wvtBebpeX4/VcDRN+KeFAjUJKmJhFBgloyjQg0YwDE/lvvfr5BCyDVzTglTCVTkhSS
         X1XKDvuWzarVLU7gXJwOsd3freV2exV5xD9p9w7Q=
Date:   Thu, 14 Nov 2019 06:26:02 +0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     shubhrajyoti.datta@gmail.com, linux-serial@vger.kernel.org,
        jacmet@sunsite.dk, git@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCHv5] serial-uartlite: Remove ULITE_NR_PORTS macro
Message-ID: <20191113222602.GA5302@kroah.com>
References: <1573646408-392094-1-git-send-email-shubhrajyoti.datta@gmail.com>
 <20191113153846.GW11035@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113153846.GW11035@localhost>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Nov 13, 2019 at 04:38:46PM +0100, Johan Hovold wrote:
> On Wed, Nov 13, 2019 at 12:00:08PM +0000, shubhrajyoti.datta@gmail.com wrote:
> > From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> > 
> > This patch is removing ULITE_NR_PORTS macro which limits number of
> > ports which can be used. Every instance is registering own struct
> > uart_driver with minor number which corresponds to alias ID (or 0 now).
> > and with 1 uart port. The same alias ID is saved to
> > tty_driver->name_base which is key field for creating ttyULX name.
> > 
> > Because name_base and minor number are setup already there is no need to
> > setup any port->line number because 0 is the right value.
> > 
> > Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> > ---
> > v4: patch addition
> > v5: Merge the patch so that all the patches compile
> 
> Greg, 
> 
> Please do not merge this. This is a hack which really needs to be
> reconsidered as I've pointed before
> 
> 	 https://lkml.kernel.org/r/20190523091839.GC568@localhost
> 
> I suggest you also drop the first two patches that you applied to
> tty-testing earlier today.

Oops, my fault, will go drop all of these, thanks.

> Shubhrajyoti, please keep on CC with these changes. I'll try to review
> this again and get back to you shortly.

I think we should also revert all the previous changes as well, as you
have pointed out.  This driver needs a good overhaul, but not in this
way :(

thanks,

greg k-h
