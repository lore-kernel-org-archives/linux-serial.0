Return-Path: <SRS0=bk4J=CD=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051AEC433E1
	for <linux-serial@archiver.kernel.org>; Tue, 25 Aug 2020 16:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0F982075F
	for <linux-serial@archiver.kernel.org>; Tue, 25 Aug 2020 16:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598374761;
	bh=2Eoi4JuT/2UvkyPyIIEp3dpOaCKju5u8+p+7/8hN/JQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ulA+sddYIamI1vh4ZQNNRQ4tA1/CDx4/Cgtpvb6ES9ESzolt1SEhq5uX0HVxHdPIN
	 vhg9lytclFMHmgQV7jLVfpps5URPUFpe/iJ7nHBA3pRnRNBZOsB4bviS5ew+9/yeUy
	 HfjmVy37tsmp4yxtY4EewYzpA8tVaVPO/cMZ/1SY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgHYQ7V (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:59:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbgHYQ7U (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 Aug 2020 12:59:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6990F2075F;
        Tue, 25 Aug 2020 16:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598374759;
        bh=2Eoi4JuT/2UvkyPyIIEp3dpOaCKju5u8+p+7/8hN/JQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hZ1ECiYuQPey2gRphijbkFwEfU/6M9n7W+P1pXvULH2llmI0/bhQb3TX/jgoKOBrq
         239qu8it0RoF3qgTO2s2yhaElpMD5WHH4CsLhCqSw2KkgJ3Ph47I8Sjf4Nit7ZYWEB
         Eiewmb4gmXUxxQ1L9FaiiTpzEfTIvn63Ohl2ZQWE=
Date:   Tue, 25 Aug 2020 18:59:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     jslaby@suse.cz, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 15/16] vc_screen: extract vcs_read_buf_header
Message-ID: <20200825165935.GA1527003@kroah.com>
References: <20200818085706.12163-15-jslaby@suse.cz>
 <20200825164804.860743-1-yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825164804.860743-1-yepeilin.cs@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Aug 25, 2020 at 12:48:04PM -0400, Peilin Ye wrote:
> Hi all,
> 
> Link: https://syzkaller.appspot.com/bug?id=f332576321998d36cd07d09c9c1268cfed1895c9
> 
> As reported by syzbot, vcs_read_buf() is overflowing `con_buf16`, since
> this patch removed the following check:
> 
> -		if (count > CON_BUF_SIZE) {
> -			count = CON_BUF_SIZE;
> -			filled = count - pos;
> -		}
> 
> Decreasing `count` by `min(HEADER_SIZE - pos, count)` bypasses this check.
> Additionally, this patch also removed updates to `skip` and `filled`.
> 
> What should we do in order to fix it?

This patch is already reverted, and it has been discussed a bit as to
how to do this properly if you look at the email where this was reported
to us.

thanks,

greg k-h
