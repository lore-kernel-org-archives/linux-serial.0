Return-Path: <SRS0=XuIp=X5=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20F0C4360C
	for <linux-serial@archiver.kernel.org>; Fri,  4 Oct 2019 12:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0FF21D71
	for <linux-serial@archiver.kernel.org>; Fri,  4 Oct 2019 12:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570193108;
	bh=sRs7snurDrY7aNegXSG/glvUBJk3hz4ywZp9JmKIFuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BwFWJtB5pPdPM5e1Nkt5eDdMocn9s5T5+8MBxLOwfFETPstrqbC/X/ldSSprD7gOq
	 hM5IXPQIELzza5O3H2CSUBI0EmwtVDdJeRI4jbakrkaPoqDRVsQFqED9NoyL0EoRnh
	 7jjsIZnxJA/1zTDxtzp93PgGMhxazOWliM5e0E54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfJDMpI (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Oct 2019 08:45:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbfJDMpI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Oct 2019 08:45:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FE7D20862;
        Fri,  4 Oct 2019 12:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570193107;
        bh=sRs7snurDrY7aNegXSG/glvUBJk3hz4ywZp9JmKIFuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oGXnKA6vAFYzlflBwNKGjSUTINUF7dy11ZJSteuU1jqMYvrR3NLG5itBY5JV3JXty
         Qn/ZqfQ3rqDqgPPyxZPiv+8pfeb2p3MSG7V/TlI3BO4qVBiKJctHTyFSyB8tIkUHdF
         Faq9NE07r7Ax9p9GzpvySwkyJ72+ZZv+PjAHAORk=
Date:   Fri, 4 Oct 2019 14:45:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pascal Terjan <pterjan@gmail.com>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-m68k@lists.linux-m68k.org,
        linux-serial@vger.kernel.org, Pascal Terjan <pterjan@google.com>
Subject: Re: [PATCH] Remove every trace of SERIAL_MAGIC
Message-ID: <20191004124505.GA556034@kroah.com>
References: <20190927205524.250238-1-pterjan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927205524.250238-1-pterjan@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Sep 27, 2019 at 10:55:24PM +0200, Pascal Terjan wrote:
> The only code mentioning it doesn't build (and hasn't at least since git)
> and doesn't include the header defining it.
> 
> This means removing support for checking magic in amiserial.c
> (SERIAL_PARANOIA_CHECK option), which was checking a magic field which
> doesn't currently exist in the struct.
> ---
>  Documentation/process/magic-number.rst        |  1 -
>  .../it_IT/process/magic-number.rst            |  1 -
>  .../zh_CN/process/magic-number.rst            |  1 -
>  drivers/net/wan/z85230.h                      |  2 -
>  drivers/tty/amiserial.c                       | 81 +------------------
>  5 files changed, 1 insertion(+), 85 deletions(-)

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
