Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49922C2B9F4
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 09:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DD0661425
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 09:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhFYJkH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Jun 2021 05:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229902AbhFYJkH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Jun 2021 05:40:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C67F61409;
        Fri, 25 Jun 2021 09:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624613866;
        bh=4siVANfNk7+ayUce+FYOgvRV+e2gNQ33FZLXMhtPrmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IbaeOVmfbkoBid6qM3xM6D3k0iW1yI81BMqrTTvQ9IbGzbt9bYQPwpvkd1cGS4f1k
         uNol+mTz/PjpgXPmpMTPU3TomQZ+pdxBef1KuRBHHWGqEdG3LHQSdz0Hc3vxb8x/Gr
         Qe6/qcvsQM+8VezncU32iV9SRMHteRqb280AuIgY=
Date:   Fri, 25 Jun 2021 11:37:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moriis Ku <saumah@gmail.com>
Cc:     linux-serial@vger.kernel.org, jason_lee@sunix.com,
        taian.chen@sunix.com, morris_ku@sunix.com, edward.lee@sunix.com
Subject: Re: [PATCH] SUNIX SDC serial port driver
Message-ID: <YNWj50ypdQLOvgZ2@kroah.com>
References: <20210625093011.12659-1-saumah@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625093011.12659-1-saumah@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jun 25, 2021 at 05:30:11PM +0800, Moriis Ku wrote:
> From: Morris Ku <saumah@gmail.com>
> 
> Add support for SUNIX SDC serial port
> 
> Cc: Taian Chen <taian.chen@sunix.com>
> Cc: Morris Ku <morris_ku@sunix.com>
> Cc: Edward Lee <Edward.lee@sunix.com>
> Signed-off-by: Morris Ku <saumah@gmail.com>
> ---
>  8250_sdc.c | 410 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 410 insertions(+)
>  create mode 100644 8250_sdc.c
> 
> diff --git a/8250_sdc.c b/8250_sdc.c
> new file mode 100644
> index 0000000..3ec9ce7
> --- /dev/null
> +++ b/8250_sdc.c

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

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/email-clients.txt in order to fix this.

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
