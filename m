From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] serial: 8250_pci: add support for Cronyx Omega PCI
 multiserial board.
Date: Fri, 13 May 2011 16:22:35 -0700
Message-ID: <20110513232235.GA14997@kroah.com>
References: <1305316189-31027-1-git-send-email-antony@niisi.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:42915 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758874Ab1EMXZa (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 13 May 2011 19:25:30 -0400
Content-Disposition: inline
In-Reply-To: <1305316189-31027-1-git-send-email-antony@niisi.msk.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Antony Pavlov <antony@niisi.msk.ru>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org

On Fri, May 13, 2011 at 11:49:49PM +0400, Antony Pavlov wrote:
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -1028,6 +1028,7 @@
>  #define PCI_DEVICE_ID_PLX_9056		0x9056
>  #define PCI_DEVICE_ID_PLX_9080		0x9080
>  #define PCI_DEVICE_ID_PLX_GTEK_SERIAL2	0xa001
> +#define PCI_DEVICE_ID_PLX_CRONYX_OMEGA	0xc001

Please don't add new entries to this file, look at the top of it for
why.

Please move this into the driver file itself and resend this.

thanks,

greg k-h
