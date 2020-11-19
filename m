Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF8FC64E7C
	for <linux-serial@archiver.kernel.org>; Thu, 19 Nov 2020 11:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E43A2223F
	for <linux-serial@archiver.kernel.org>; Thu, 19 Nov 2020 11:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k7pIKG1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgKSLnf (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 19 Nov 2020 06:43:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:41272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbgKSLne (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Nov 2020 06:43:34 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C9C22223F;
        Thu, 19 Nov 2020 11:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1605786213;
        bh=yj9jzH1qXjIN1qaAfYMn52axTEirdTbhGMdAl7kR2j8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k7pIKG1Ni6Gs+ZfTlzq66wsKqc0LBePq5KKZS/jvyULMCRaU8oobbKxtOzhlKfrpn
         Hdb9MUyJ3/JfhaNwZ3BBGzuf4w50jvwP0qrmnCjrmDu+HMk1Ii7EG+M4bH1bwtkVG6
         CwHzHgAjRKoy2dn+ypmOw3VdMISi2K+4abx6bEns=
Date:   Thu, 19 Nov 2020 12:44:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Giacinto Cifelli <gciofono@gmail.com>
Cc:     linux-serial@vger.kernel.org
Subject: Re: [PATCH] option: added support for Thales Cinterion MV31 option
 port.
Message-ID: <X7ZakUcp8nxYoo6L@kroah.com>
References: <20201119105837.17735-1-gciofono@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119105837.17735-1-gciofono@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Nov 19, 2020 at 11:58:37AM +0100, Giacinto Cifelli wrote:
> There is a single option port in this modem, and it is used as debug port
> 
> Signed-off-by: Giacinto Cifelli <gciofono@gmail.com>
> ---
>  drivers/usb/serial/option.c | 3 +++

Odd that you sent it to this list, when the kernel says to send this
patch to:

$ ./scripts/get_maintainer.pl --file drivers/usb/serial/option.c
Johan Hovold <johan@kernel.org> (maintainer:USB SERIAL SUBSYSTEM)
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:USB SUBSYSTEM)
linux-usb@vger.kernel.org (open list:USB SERIAL SUBSYSTEM)
linux-kernel@vger.kernel.org (open list)


Please fix up and resend to the proper developers and list.

thanks,

greg k-h
