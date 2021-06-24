Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C3EC48BDF
	for <linux-serial@archiver.kernel.org>; Thu, 24 Jun 2021 12:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64936613EC
	for <linux-serial@archiver.kernel.org>; Thu, 24 Jun 2021 12:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhFXMcE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 24 Jun 2021 08:32:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229945AbhFXMcC (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 24 Jun 2021 08:32:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0444613B1;
        Thu, 24 Jun 2021 12:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624537784;
        bh=TpHGrVK1im57ECcVvQcLPWr9HmYUYU2TSdkASrgq0T4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=POpepCQMVmDJ2xphy1SauemUix0H7pSbQwyvHiVQn+/fKtDIfIA6uhCfep4Tqu4Gx
         +phmkota/a8HCZ+Hen1FCo3DcJvpXQUdP84sg7aZ0kBj0muBddb6q3ib7Lik8iM4mi
         blOl9XxebSxhQ6Wbjt8/HY4bsJKO6+uwYiCTGOl7ccQ18drQq35Cv0keWW/+XSGu7i
         RxmmePozYkB6Wp7fhqmLcp9IoHHMJRxUvyDgEsLJL+8qCHqESX1tdWDwW8ZTw+4DkQ
         jrC706kDhNJNskyHd1klXtZWMRau5yPrrqregbXK0ANuM72ooyzPZ+q3WGOgAmFlxY
         N+SdP+yL0bs9g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lwOUK-000792-I9; Thu, 24 Jun 2021 14:29:44 +0200
Date:   Thu, 24 Jun 2021 14:29:44 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Saubhik Mukherjee <saubhik.mukherjee@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org, andrianov@ispras.ru
Subject: Re: [PATCH] tty: serial: owl: Fix data race in owl_uart_remove
Message-ID: <YNR6uEbCJOa9s3hG@hovoldconsulting.com>
References: <20210617110443.6526-1-saubhik.mukherjee@gmail.com>
 <YMswdqNpjb9n1pdW@kroah.com>
 <ceebf511-9971-6deb-a6dd-458d69de2bbd@gmail.com>
 <YNLfxMZZ0a80qKLg@hovoldconsulting.com>
 <a9d43126-acd7-efb0-bf1a-86b06965f0e2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9d43126-acd7-efb0-bf1a-86b06965f0e2@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jun 24, 2021 at 05:37:38PM +0530, Saubhik Mukherjee wrote:
> On 6/23/21 12:46 PM, Johan Hovold wrote:
> > On Wed, Jun 23, 2021 at 11:06:53AM +0530, Saubhik Mukherjee wrote:
> >> On 6/17/21 4:52 PM, Greg KH wrote:
> >>> On Thu, Jun 17, 2021 at 04:34:43PM +0530, Saubhik Mukherjee wrote:
> >>>> Suppose the driver is registered and a UART port is added. Once an
> >>>> application opens the port, owl_uart_startup is called which registers
> >>>> the interrupt handler owl_uart_irq.
> >>>>
> >>>> We could have the following race condition:
> >>>>
> >>>> When device is removed, owl_uart_remove is called, which calls
> >>>> uart_remove_one_port, which calls owl_uart_release_port, which writes
> >>>> NULL to port->membase. At this point parallely, an interrupt could be
> >>>> handled by owl_uart_irq which reads port->membase.
> >>>>
> >>>> This is because it is possible to remove device without closing a port.
> >>>> Thus, we need to check it and call owl_uart_shutdown in owl_uart_remove.
> > 
> > No, this makes no sense at all. The port is deregistered and hung up by
> > uart_remove_one_port() (and the interrupt line is consequently disabled
> > by the driver) before it is released so this can never happen.
> 
> Thanks for the reply. I am not sure I understand. I could not find any 
> interrupt disabling in owl_uart_remove. Could you point out where/how is 
> the interrupt line is disabled before releasing the port?

The interrupt line is disabled by owl_uart_shutdown(), which is called
when uart_remove_one_port() hangs up an open tty. And as I mentioned
this happens after deregistering the port (so no new opens) and before
releasing the port.

Johan
