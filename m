Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF865C433E6
	for <linux-serial@archiver.kernel.org>; Thu, 14 Jan 2021 09:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9BA123A21
	for <linux-serial@archiver.kernel.org>; Thu, 14 Jan 2021 09:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbhANJUg (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Jan 2021 04:20:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:46404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727861AbhANJUf (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Jan 2021 04:20:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71AD023A05;
        Thu, 14 Jan 2021 09:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610615995;
        bh=MGHLQvPn2A8eAEtsvTZxtNRJSiD2sGj/MGLhHjPZJtg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mIYej5JTSSpw6ytiKe2cPAYnaAXq1VU6BEohaLigWDTpu8wxSBnBDMZfw14uSnN8v
         OHQsVXHR9lpzAQy0JvRzLM6ECKYH4snhTn0iqZWbMjoXH9IIE7EcYptnh04OI3Ctlk
         L7BJDxPfilZBBlrsahsC3SFysJ428RqLPIt633ts=
Date:   Thu, 14 Jan 2021 10:20:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhangqiumiao1@huawei.com
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v3] tty: make pl011 serial port driver support 485 mode
Message-ID: <YAAM+5qBjAgkftkJ@kroah.com>
References: <1610615253-18940-1-git-send-email-zhangqiumiao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610615253-18940-1-git-send-email-zhangqiumiao1@huawei.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jan 14, 2021 at 05:07:33PM +0800, zhangqiumiao1@huawei.com wrote:
> From: Qiumiao Zhang <zhangqiumiao1@huawei.com>
> 
> make pl011 serial port support 485 mode full duplex communication
> 
> ---
> Changes in v3:
>   -Fix busy loop forever in pl011_tx_empty
>   -Move the definition of cr into uart_amba_port
>   -run checkpatch with no error or warning
> 
> Changes in v2:
>   -Fix two compilation errors
> 
>  drivers/tty/serial/amba-pl011.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)

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

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/SubmittingPatches and resend it after
  adding that line.  Note, the line needs to be in the body of the
  email, before the patch, not at the bottom of the patch or in the
  email signature.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
