Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1591C43460
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 09:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9677960FE4
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 09:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhDZJss (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Apr 2021 05:48:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232140AbhDZJss (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Apr 2021 05:48:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D8EC61075;
        Mon, 26 Apr 2021 09:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619430487;
        bh=GuVPkwJT/brcC1alAHWw4s3TEAi1+DY+1el51ciiE5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GusgwygvG90/oc5/ovZDv7pPAMrWZXWVWsMK0zLxEw2oCFhCLEWKfYfndG/FjPEAr
         1EfZbtKxcwz+sNjNrMu3NUWIbg/KuQVfi/TKadHKdVw2qUMXawj3HgTiSORp+2cQ7P
         3fAzp7Nz9Dc0qgwh/fvAgfd5GUMOVd4RcgkPwz7Y=
Date:   Mon, 26 Apr 2021 11:48:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moriis Ku <saumah@gmail.com>
Cc:     linux-serial@vger.kernel.org
Subject: Re: Add support for SUNIX multi I/O board
Message-ID: <YIaMVMJXjRdW5GY1@kroah.com>
References: <20210426093828.10348-1-saumah@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426093828.10348-1-saumah@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Apr 26, 2021 at 05:38:28PM +0800, Moriis Ku wrote:
> From: Morris Ku <saumah@gmail.com>
> 
> Sunix SDC Multi I/O board are different to Timedia's.
> 
> This patch adds proper support for Sunix SDC Multi I/O board.
> 
> Signed-off-by: Morris Ku<saumah@gmail.com>

Can you make your subject line look like:
	[PATCH] serial: 8250_pci: add support for...

to match up the other patches for this driver?

> ---
>  tty/serial/8250/8250_pci.c | 36 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/tty/serial/8250/8250_pci.c b/tty/serial/8250/8250_pci.c
> index 8814ff38..5758a98b 100644
> --- a/tty/serial/8250/8250_pci.c
> +++ b/tty/serial/8250/8250_pci.c
> @@ -1802,6 +1802,25 @@ pci_sunix_setup(struct serial_private *priv,
>  	return setup_port(priv, port, bar, offset, 0);
>  }
>  
> +static int
> +pci_sunix_sdc_setup(struct serial_private *priv,

Move this to be all on one line please.

> +		const struct pciserial_board *board,
> +		struct uart_8250_port *port, int idx)

Line up with the "(" or checkpatch will complain.

> +{
> +	int bar;
> +	int offset;
> +
> +	port->port.flags |= UPF_FIXED_TYPE;
> +	port->port.type = PORT_SUNIX;
> +
> +	if (idx < 4) {
> +		bar = 1
> +		offset = idx * board->uart_offset;
> +	}

So if idx is > 4, bar is unknown?  That feels like a huge bug :(

> +
> +	return setup_port(priv, port, bar, offset, 0);

Same for offset, looks like it could be used uninitialized as well.

The compiler didn't complain about this?

thanks,

greg k-h
