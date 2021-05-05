Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAA8C433B4
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02125613C7
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhEEJ1B (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 May 2021 05:27:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231993AbhEEJ1B (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 May 2021 05:27:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BA43613C7;
        Wed,  5 May 2021 09:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620206764;
        bh=WMVXzxYqtphTvEeb3kL+MaJiqEFOJWVhVbuoTOit89Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JP2c0IV85CZ0IL+fCyz2VPudi2BPhHk64HKF/SJLfnNptMCGIvdIsksTtUkVM5Sj1
         Xx/mIDUNQb6v5T2LWvuFjf/0muNqBad4yjp27qwgFRS6neVmMPl7EaNHgS4T1bgV6G
         iN6fK7d4+0ufiDpW4hORM5kOAgsz2vUPfGiJwbio=
Date:   Wed, 5 May 2021 11:26:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/35] tty: remove broken r3964 line discipline
Message-ID: <YJJkqQeU77quqWox@kroah.com>
References: <20210505091928.22010-1-jslaby@suse.cz>
 <20210505091928.22010-2-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505091928.22010-2-jslaby@suse.cz>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, May 05, 2021 at 11:18:54AM +0200, Jiri Slaby wrote:
> Noone stepped up in the past two years since it was marked as BROKEN by
> commit c7084edc3f6d (tty: mark Siemens R3964 line discipline as BROKEN).
> Remove the line discipline for good.
> 
> Three remarks:
> * we remove also the uapi header (as noone is able to use that interface
>   anyway)
> * we do *not* remove the N_R3964 constant definition from tty.h, so it
>   remains reserved.
> * in_interrupt() check is now removed from vt's con_put_char. Noone else
>   calls tty_operations::put_char from interrupt context.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>  arch/powerpc/configs/ppc6xx_defconfig |    1 -
>  drivers/char/Kconfig                  |   13 -
>  drivers/tty/Makefile                  |    1 -
>  drivers/tty/n_r3964.c                 | 1283 -------------------------
>  drivers/tty/vt/vt.c                   |    2 -
>  include/linux/n_r3964.h               |  175 ----
>  include/uapi/linux/n_r3964.h          |   99 --
>  7 files changed, 1574 deletions(-)
>  delete mode 100644 drivers/tty/n_r3964.c
>  delete mode 100644 include/linux/n_r3964.h
>  delete mode 100644 include/uapi/linux/n_r3964.h

Oh yes, thank you!  I guess no one really cares about this anymore,
thanks for removing it.

greg k-h
