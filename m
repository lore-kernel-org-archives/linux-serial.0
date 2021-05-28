Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089FEC47087
	for <linux-serial@archiver.kernel.org>; Fri, 28 May 2021 09:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD0196128B
	for <linux-serial@archiver.kernel.org>; Fri, 28 May 2021 09:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhE1J3N (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 28 May 2021 05:29:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:53466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235378AbhE1J3M (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 May 2021 05:29:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3777A61183;
        Fri, 28 May 2021 09:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622194057;
        bh=wEKgUhy1noH/DWf/UECfwPZ27i7cewO59uvqN5vyxcQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i14Jvr0HSOTGnrFLN+kqX2IrlN6fNluJlDPMuevjYrVJopSQ1vJ4Bv9SsjmnNO6ZB
         nxHZuGfXFqEJP9fHWFHE4yzbzsBjB9rSVOqS9U2uxsM/oLt12/LP7TbBmXl6AQO5mw
         4R6LqLWS9Hd7HS65umMCNHr1AX7eIXhNiyoFVO/c=
Date:   Fri, 28 May 2021 11:27:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moriis Ku <saumah@gmail.com>
Cc:     linux-serial@vger.kernel.org, jason_lee@sunix.com,
        taian.chen@sunix.com
Subject: Re: [PATCH] serial:Add SUNIX SDC serial port driver
Message-ID: <YLC3hzsgOJ1lWhlm@kroah.com>
References: <20210528092307.5950-1-saumah@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528092307.5950-1-saumah@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 28, 2021 at 05:23:07PM +0800, Moriis Ku wrote:
> From: Morris Ku <saumah@gmail.com>
> 
> SUNIX SDC serial port driver.
> 
> Cc: Jason Lee <jason_lee@sunix.com>
> Cc: Taian Chen <taian.chen@sunix.com>
> Signed-off-by: Morris Ku <saumah@gmail.com>
> ---
>  8250_sdc.c | 519 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 519 insertions(+)
>  create mode 100644 8250_sdc.c

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You sent multiple patches, yet no indication of which ones should be
  applied in which order.  Greg could just guess, but if you are
  receiving this email, he guessed wrong and the patches didn't apply.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for a description of how
  to do this so that Greg has a chance to apply these correctly.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
