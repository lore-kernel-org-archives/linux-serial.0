Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4969EE7735A
	for <linux-serial@archiver.kernel.org>; Sat, 30 Sep 2023 06:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjI3G4d (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 30 Sep 2023 02:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbjI3G4b (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 30 Sep 2023 02:56:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4E41A7
        for <linux-serial@vger.kernel.org>; Fri, 29 Sep 2023 23:56:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1406C433C7;
        Sat, 30 Sep 2023 06:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696056989;
        bh=U7bSwLngOvONo3KcyDa3+TBMKTbBkoSrWBNPRVNZUJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HSe0pqs5Pdlhx84uUkI0SAqcwWr6WqySCbPPDJQzihhlDZ/JNZOKoVSpJ0WCgNYIZ
         nlxiOqLDgoQdar1uM6rnUhRdaHQBCO5XwV0hSx2kO9Q43uPPnAVsHhWGTqNYpl72Ll
         lnXBO/LmFy9OTDwibvocpDcZc6Xyew9wTx0X/Mu4=
Date:   Sat, 30 Sep 2023 08:56:26 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Matthew Howell <matthew.howell@sealevel.com>
Cc:     Darren Beeson <darren.beeson@sealevel.com>,
        "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "eff.baldwin@sealevel.com" <eff.baldwin@sealevel.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Ryan Wenglarz <ryan.wenglarz@sealevel.com>,
        James Olson <james.olson@sealevel.com>
Subject: Re: [PATCH V9 1/2] serial: exar: Revert "serial: exar: Add support
 for Sealevel 7xxxC serial cards"
Message-ID: <2023093014-endurable-chalice-2397@gregkh>
References: <8ffa2f583ff142c3b0eb6cf51a7c9cef5dbfd320.camel@sealevel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ffa2f583ff142c3b0eb6cf51a7c9cef5dbfd320.camel@sealevel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Sep 29, 2023 at 05:39:49PM +0000, Matthew Howell wrote:
> From: Matthew Howell <matthew.howell@sealevel.com>
> 
> Hardware ID of Sealevel 7xxxC cards changed prior to release.
> This has rendered 14ee78d5932a redundant.
> 
> This reverts commit 14ee78d5932afeb710c8305196a676a715bfdea8.
> 
> Fixes: 14ee78d5932a ("Add support for Sealevel 7xxxC serial cards")
> Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> index 077c3ba3539e..3886f78ecbbf 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -47,12 +47,6 @@
>  #define PCI_SUBDEVICE_ID_USR_2980		0x0128
>  #define PCI_SUBDEVICE_ID_USR_2981		0x0129
> 
> -#define PCI_DEVICE_ID_SEALEVEL_710xC		0x1001
> -#define PCI_DEVICE_ID_SEALEVEL_720xC		0x1002
> -#define PCI_DEVICE_ID_SEALEVEL_740xC		0x1004
> -#define PCI_DEVICE_ID_SEALEVEL_780xC		0x1008
> -#define PCI_DEVICE_ID_SEALEVEL_716xC		0x1010
> -
>  #define UART_EXAR_INT0		0x80
>  #define UART_EXAR_8XMODE	0x88	/* 8X sampling rate select */
>  #define UART_EXAR_SLEEP		0x8b	/* Sleep mode */
> @@ -652,8 +646,6 @@ exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
>  		nr_ports = BIT(((pcidev->device & 0x38) >> 3) - 1);
>  	else if (board->num_ports)
>  		nr_ports = board->num_ports;
> -	else if (pcidev->vendor == PCI_VENDOR_ID_SEALEVEL)
> -		nr_ports = pcidev->device & 0xff;
>  	else
>  		nr_ports = pcidev->device & 0x0f;
> 
> @@ -893,12 +885,6 @@ static const struct pci_device_id exar_pci_tbl[] = {
>  	EXAR_DEVICE(COMMTECH, 4224PCI335, pbn_fastcom335_4),
>  	EXAR_DEVICE(COMMTECH, 2324PCI335, pbn_fastcom335_4),
>  	EXAR_DEVICE(COMMTECH, 2328PCI335, pbn_fastcom335_8),
> -
> -	EXAR_DEVICE(SEALEVEL, 710xC, pbn_exar_XR17V35x),
> -	EXAR_DEVICE(SEALEVEL, 720xC, pbn_exar_XR17V35x),
> -	EXAR_DEVICE(SEALEVEL, 740xC, pbn_exar_XR17V35x),
> -	EXAR_DEVICE(SEALEVEL, 780xC, pbn_exar_XR17V35x),
> -	EXAR_DEVICE(SEALEVEL, 716xC, pbn_exar_XR17V35x),
>  	{ 0, }
>  };
>  MODULE_DEVICE_TABLE(pci, exar_pci_tbl);
> 

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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
