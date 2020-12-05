Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4432C4167B
	for <linux-serial@archiver.kernel.org>; Sat,  5 Dec 2020 18:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C4DD23122
	for <linux-serial@archiver.kernel.org>; Sat,  5 Dec 2020 18:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgLEST3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 5 Dec 2020 13:19:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:39726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbgLERjj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 5 Dec 2020 12:39:39 -0500
Date:   Sat, 5 Dec 2020 17:30:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607185727;
        bh=wvcBfHK729324pcxOkEQ3caGkWSOs8L730mD3RJl7lM=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=OcTOm4FdXoSdlMSY66ClB29wSv/Hms0wQ/bwmi8PLJ/qVm9NnRib+QH4BAQz6XDYQ
         N0Cjf4YrGs1VCu92agoO0D4d/hAHCas7yWPd/TKFQ+hYZLBMT4J3hVtNqqlOYCTed5
         vHJx19EgfLfl7zXp2/u5wEu/QxkonHoLGqN2GLFQ=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Clement Smith <rclemsmith@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] tty: serial: jsm: Fixed file by added more spacing
 in line 610
Message-ID: <X8u1iR6uajt2prf8@kroah.com>
References: <cover.1607177807.git.rclemsmith@gmail.com>
 <0c203c3dfd32ea016ed7c0de7a1e83a09eb91806.1607177807.git.rclemsmith@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c203c3dfd32ea016ed7c0de7a1e83a09eb91806.1607177807.git.rclemsmith@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Dec 05, 2020 at 07:50:08PM +0530, Clement Smith wrote:
> Fixed a coding style issue
> 
> Signed-off-by: Clement Smith <rclemsmith@gmail.com>
> ---
>  drivers/tty/serial/jsm/jsm_tty.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

The subject lines in this series is really funny.

Please don't do this.  If you want to get practice in making coding
style cleanups, do it in drivers/staging/ which is why the code is
there.  Don't "practice" in other parts of the kernel as it just gets in
the way of other development and review efforts.

good luck!

greg k-h
