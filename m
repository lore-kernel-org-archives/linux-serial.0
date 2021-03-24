Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4314EC433E0
	for <linux-serial@archiver.kernel.org>; Wed, 24 Mar 2021 06:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E5A6619E4
	for <linux-serial@archiver.kernel.org>; Wed, 24 Mar 2021 06:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbhCXGFY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 Mar 2021 02:05:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233315AbhCXGEx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Mar 2021 02:04:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27C766192B;
        Wed, 24 Mar 2021 06:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616565892;
        bh=SOcYlJ+GJCugSLx/8qtddpu6enwjrjm3cFZt5Ul8FhI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZTxuybjbSx2NUQu4w05iqtSncmIBBBLc0ixcGvTUSfsPZRJPcbQ7vWQvUS7+qe8ZW
         iwOae9e4dDfz3nNWUcGSyJx0BWeMXqpjmqhxGIkA5/aJrqdnx45EXLYYe9jkpa4dhr
         0nm1RxQAPXt3HNaBJ5kFLmxq+8LUpFjMRLygGeNs=
Date:   Wed, 24 Mar 2021 07:02:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alex Nemirovsky <Alex.Nemirovsky@cortina-access.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Jason Li <jason.li@cortina-access.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 1/3] tty: serial: Add UART driver for Cortina-Access
 platform
Message-ID: <YFrWE93aJ/XGparI@kroah.com>
References: <1613702532-5096-1-git-send-email-alex.nemirovsky@cortina-access.com>
 <YFmzuEfpN7zzKel3@kroah.com>
 <E0630C1D-AC64-4DB5-9467-EA2F4590EB26@cortina-access.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E0630C1D-AC64-4DB5-9467-EA2F4590EB26@cortina-access.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Mar 23, 2021 at 07:25:58PM +0000, Alex Nemirovsky wrote:
> Hi Greg,
> 
> > On Mar 23, 2021, at 2:24 AM, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > 
> > On Thu, Feb 18, 2021 at 06:42:09PM -0800, Alex Nemirovsky wrote:
> >> +static struct cortina_uart_port *cortina_uart_ports;
> > 
> > Why is this not a per-device pointer?
> > 
> >> +static void __exit cortina_uart_exit(void)
> >> +{
> >> +	platform_driver_unregister(&serial_cortina_driver);
> >> +	uart_unregister_driver(&cortina_uart_driver);
> >> +	kfree(cortina_uart_ports);
> > 
> > Should not need to free this here, it should be tied to the device, not
> > the driver.
> 
> Would it be possible to provide a reference to an example 
> of a good way to do it.

You have a device-specific data structure, put this information there.

> >> +}
> >> +
> >> +module_init(cortina_uart_init);
> >> +module_exit(cortina_uart_exit);
> >> +
> >> +MODULE_AUTHOR("Cortina-Access Inc.");
> >> +MODULE_DESCRIPTION(" Cortina-Access UART driver");
> >> +MODULE_LICENSE("GPL");
> >> diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
> >> index 62c2204..1931892 100644
> >> --- a/include/uapi/linux/serial_core.h
> >> +++ b/include/uapi/linux/serial_core.h
> >> @@ -277,4 +277,7 @@
> >> /* Freescale LINFlexD UART */
> >> #define PORT_LINFLEXUART	122
> >> 
> >> +/* Cortina-Access UART */
> >> +#define PORT_CORTINA_ACCESS	123
> > 
> > Also, no need for this, right?  I would prefer to not add new ids if at
> > all possible.
> 
> Could you explain why these are no longer required and what has 
> been done in the tty design to make this obsolete?

What do you use in userspace that requires this information to be sent
from the kernel?

thanks,

greg k-h
