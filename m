Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A96C46467
	for <linux-serial@archiver.kernel.org>; Fri, 20 Jan 2023 05:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjATFTz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Jan 2023 00:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjATFTj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Jan 2023 00:19:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646307DFAD
        for <linux-serial@vger.kernel.org>; Thu, 19 Jan 2023 21:09:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4399B826FB
        for <linux-serial@vger.kernel.org>; Thu, 19 Jan 2023 19:02:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C44C433F0;
        Thu, 19 Jan 2023 19:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674154971;
        bh=FxmuMNY95tSkO6GCCRSUZcRsDNZLf64oi7FRyUtNuIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KqQTNt+jVnN5jwTY4dMF/CkaRwSUxKbTu2cU6Hi2NA9rv7mbS7vfsuti6vt83HWCD
         mqsb4iYS1g0P+gtB+A/vUEeUhuxT2hXAHC8v92qdzW4fWdGNWr/9TU0GQktxbIs0io
         +15Lr6j6a9BRVlfa5mOqXKbrpzuUn8oeC2oRYa/Y=
Date:   Thu, 19 Jan 2023 20:02:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthew Howell <mrhowel@g.clemson.edu>
Cc:     linux-serial@vger.kernel.org, jeff.baldwin@sealevel.com,
        ryan.wenglarz@sealevel.com, matthew.howell@sealevel.com,
        darren.beeson@sealevel.com
Subject: Re: [PATCH v3] serial: exar: Add support for Sealevel 7xxxC serial
 cards
Message-ID: <Y8mT2P4asFeTEOAB@kroah.com>
References: <alpine.DEB.2.21.2301191204520.22332@tstest-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2301191204520.22332@tstest-VirtualBox>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jan 19, 2023 at 12:10:49PM -0500, Matthew Howell wrote:
> From: Matthew Howell <matthew.howell@sealevel.com>
> 
> Add support for Sealevel 7xxxC serial cards.
> 
> This patch:
> * Adds IDs to recognize 7xxxC cards from Sealevel Systems.
> * Updates exar_pci_probe() to set nr_ports to last two bytes of primary
> dev ID for these cards.
> 
> Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
> ---
> 
> v2: Moved "This patch..." above signed-off line.
> v3: "Added From: Matthew Howell <matthew.howell@sealevel.com>" to
> submission.
> 
> Let me know if I need to make any more changes.
> 
> diff --git a/drivers/tty/serial/8250/8250_exar.c
> b/drivers/tty/serial/8250/8250_exar.c
> index 314a05e00..64770c62b 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -43,6 +43,12 @@
>  #define PCI_DEVICE_ID_EXAR_XR17V4358		0x4358
>  #define PCI_DEVICE_ID_EXAR_XR17V8358		0x8358
> 
> +#define PCI_DEVICE_ID_SEALEVEL_710xC		0x1001
> +#define PCI_DEVICE_ID_SEALEVEL_720xC		0x1002
> +#define PCI_DEVICE_ID_SEALEVEL_740xC		0x1004
> +#define PCI_DEVICE_ID_SEALEVEL_780xC		0x1008
> +#define PCI_DEVICE_ID_SEALEVEL_716xC		0x1010
> +
>  #define UART_EXAR_INT0		0x80
>  #define UART_EXAR_8XMODE	0x88	/* 8X sampling rate select */
>  #define UART_EXAR_SLEEP	0x8b	/* Sleep mode */
> @@ -638,6 +644,8 @@ exar_pci_probe(struct pci_dev *pcidev, const struct
> pci_device_id *ent)
>  		nr_ports = BIT(((pcidev->device & 0x38) >> 3) - 1);
>  	else if (board->num_ports)
>  		nr_ports = board->num_ports;
> +	else if (pcidev->vendor == PCI_VENDOR_ID_SEALEVEL)
> +		nr_ports = pcidev->device & 0xff;
>  	else
>  		nr_ports = pcidev->device & 0x0f;
> 
> @@ -864,6 +872,12 @@ static const struct pci_device_id exar_pci_tbl[] = {
>  	EXAR_DEVICE(COMMTECH, 4224PCI335, pbn_fastcom335_4),
>  	EXAR_DEVICE(COMMTECH, 2324PCI335, pbn_fastcom335_4),
>  	EXAR_DEVICE(COMMTECH, 2328PCI335, pbn_fastcom335_8),
> +
> +	EXAR_DEVICE(SEALEVEL, 710xC, pbn_exar_XR17V35x),
> +	EXAR_DEVICE(SEALEVEL, 720xC, pbn_exar_XR17V35x),
> +	EXAR_DEVICE(SEALEVEL, 740xC, pbn_exar_XR17V35x),
> +	EXAR_DEVICE(SEALEVEL, 780xC, pbn_exar_XR17V35x),
> +	EXAR_DEVICE(SEALEVEL, 716xC, pbn_exar_XR17V35x),
>  	{ 0, }
>  };
>  MODULE_DEVICE_TABLE(pci, exar_pci_tbl);

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

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/process/email-clients.rst in order to fix this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
