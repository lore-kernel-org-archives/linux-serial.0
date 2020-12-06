Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126E1C4361B
	for <linux-serial@archiver.kernel.org>; Sun,  6 Dec 2020 08:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDCC7230FB
	for <linux-serial@archiver.kernel.org>; Sun,  6 Dec 2020 08:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgLFIJp (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 6 Dec 2020 03:09:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:36558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgLFIJp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 6 Dec 2020 03:09:45 -0500
Date:   Sun, 6 Dec 2020 09:08:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607242138;
        bh=v6i485VT1SuE4oDryIPxb1gifn3DhHt1n5H46rNOrQg=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=WLmMuqP22LLPC3MnaucS4GSU3n+S+QlkhAAb2+0D+eH3prs2KGooPFYFhTGgdzQVQ
         uw3JQcWrBGED/r7D4K7VFo+bWe+jkAFT4vdELD2J420MysWnUvLzYTO0gJNKZO/rAa
         ly47/sgyrafACtQSJ7GpoGKhQigEC7w7Y0NCbYAk=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Clement Smith <rclemsmith@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] tty: serial: jsm: Fixed file by added more spacing
Message-ID: <X8yRlv5yIGxCwGpy@kroah.com>
References: <0d1fde4c82ce4b9f20f5d1ae2c6b34314f9d9942.1607240285.git.rclemsmith@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d1fde4c82ce4b9f20f5d1ae2c6b34314f9d9942.1607240285.git.rclemsmith@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Dec 06, 2020 at 01:09:25PM +0530, Clement Smith wrote:
> Fixed a coding style issue
> 
> Signed-off-by: Clement Smith <rclemsmith@gmail.com>
> ---
>  drivers/tty/serial/jsm/jsm_tty.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I see you ignored my suggestion and so, sadly, I will just ignore this
patchset :(

greg k-h
