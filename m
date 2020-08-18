Return-Path: <SRS0=mq3J=B4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6043C433DF
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 11:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FA3B206DA
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 11:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597750999;
	bh=usmfjuKyMHfX6KvZ1abtP2KSf349aqo4sVQLXIkJjsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vCNjXciqEk06WwMJq/HIh/j3GsGVR8KtiLpq9gE96sH6KFvCXWbflyKHzE3HVqbF0
	 P9deY9P9R6BKncEzc5uQXyU6RvHoyM+JE8AoY7vEjbacLEKodKzZcigQHYo9MGD0Y4
	 9d45tFRmY41rlYcWYRcMJFjAp4PnsSOaSAvO4ayI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgHRLnS (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Aug 2020 07:43:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbgHRLnS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Aug 2020 07:43:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10FBF206DA;
        Tue, 18 Aug 2020 11:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597750997;
        bh=usmfjuKyMHfX6KvZ1abtP2KSf349aqo4sVQLXIkJjsU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=18g4PfPtxhjt65zoA7BhbuFp/4u5zqTUPkjVygU9s76jFu0lv4ImVNrK2DLHdJ2HW
         wr6krFvIaYVYsZLwsNbgTrWoPcd9TmHEQFDCiYHs0RGOUC3pjQ6Bct2ttUZtc6C8an
         aKlSYUa6quZRLATROJcIYgyB0rTUQUBUPzFRkrQ8=
Date:   Tue, 18 Aug 2020 13:43:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/16] vt: declare xy for get/putconsxy properly
Message-ID: <20200818114341.GA343779@kroah.com>
References: <20200818085706.12163-1-jslaby@suse.cz>
 <20200818085706.12163-2-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818085706.12163-2-jslaby@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Aug 18, 2020 at 10:56:52AM +0200, Jiri Slaby wrote:
> That is:
> 1) call the parameter 'xy' to denote what it really is, not generic 'p'
> 2) tell the compiler and users that we expect an array:
>    * with at least 2 chars (static 2)
>    * which we don't modify in putconsxy (const)
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>  drivers/tty/vt/vt.c       | 10 +++++-----
>  include/linux/selection.h |  4 ++--
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 8f283221330e..a0da7771c327 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -4769,17 +4769,17 @@ unsigned short *screen_pos(const struct vc_data *vc, int w_offset, int viewed)
>  }
>  EXPORT_SYMBOL_GPL(screen_pos);
>  
> -void getconsxy(const struct vc_data *vc, unsigned char *p)
> +void getconsxy(const struct vc_data *vc, unsigned char xy[static 2])

I didn't realize we could do "[static 2]" in the kernel now, is that
thanks to the bump of the minimum gcc version?  If so, nice!

thanks,

greg k-h
