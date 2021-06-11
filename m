Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D76C48BD1
	for <linux-serial@archiver.kernel.org>; Fri, 11 Jun 2021 09:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A704613D3
	for <linux-serial@archiver.kernel.org>; Fri, 11 Jun 2021 09:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbhFKJtL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 11 Jun 2021 05:49:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231690AbhFKJtI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 Jun 2021 05:49:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E830610A3;
        Fri, 11 Jun 2021 09:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623404831;
        bh=s9Ag+rBWyFYnCDlIp2K0FdiMm24u5iDhIbyyCsbP9zY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tNBnT7NZUVNitBKE7XkF4uHrVf9161ec1HhC+OnndU08OJ/h1tcDlPlWQccUIXt/k
         NPn0bNnDSpVk7qdtyMqyDmjQf3U2TQyolw8gLb4rOg7ZDgw7RPDXzcQ3sSFtx8M2YD
         AS3u11qPmUew8xn5wHCNtLf6bsKPZue1nsoCKyko=
Date:   Fri, 11 Jun 2021 11:47:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saubhik Mukherjee <saubhik.mukherjee@gmail.com>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        ldv-project@linuxtesting.org, andrianov@ispras.ru
Subject: Re: [question] Is it possible to remove an active port (without
 shutdown)?
Message-ID: <YMMxHFkhr7UDgk4o@kroah.com>
References: <07b2ccfa-cf98-54a2-d03c-50507de06d52@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07b2ccfa-cf98-54a2-d03c-50507de06d52@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jun 11, 2021 at 03:03:42PM +0530, Saubhik Mukherjee wrote:
> Consider the following events involving drivers/tty/serial/owl-uart.c:
> 
> Suppose the driver is registered, and the owl_uart_probe() was called.
> Then uart_startup() can be called in serial core. This calls
> owl_uart_startup() which registers the interrupt handler owl_uart_irq.
> 
> Now suppose uart_remove_one_port() in serial core is called. This
> detaches port from the core. This calls owl_uart_release_port(port).
> This writes NULL to port->membase after iounmap of port->membase from
> port->dev.
> 
> During this point, an interrupt is triggered and the interrupt callback
> owl_uart_irq() is called (parallel with uart_remove_one_port()). This
> tries to read port->membase to send or receive chars (with spinlock on
> port->lock). This introduces a race condition on port->membase.
> 
> QUESTION: Is it possible to remove an active port (without shutdown)?

You can remove it, if the driver is set up to do so properly.  Odds are
the owl-uart code is not written to expect that to ever happen.

How are you "removing" an active port?  What triggers this action?

thanks,

greg k-h
