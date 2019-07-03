From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V2 2/2] PCI: Add NI-Serial PXI/PXIe+485 device IDs
Date: Wed, 3 Jul 2019 10:36:05 +0200
Message-ID: <20190703083605.GA8996@kroah.com>
References: <20190703072516.34199-1-je.yen.tam@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190703072516.34199-1-je.yen.tam@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jeyentam <je.yen.tam@ni.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Jul 03, 2019 at 12:25:16AM -0700, jeyentam wrote:
> Add NI PXIe-RS232, PXI-RS485 and PXIe-RS485 device IDs.
> 
> Signed-off-by: jeyentam <je.yen.tam@ni.com>
> ---
>  include/linux/pci_ids.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

You have read the comment at the top of this file, right?  If so, why
are you adding these entries?

> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 70e86148cb1e..7fad4794789f 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -1027,7 +1027,9 @@
>  #define PCI_DEVICE_ID_SUN_TOMATILLO	0xa801
>  #define PCI_DEVICE_ID_SUN_CASSINI	0xabba
>  
> +/* NI-Serial Device IDs */
>  #define PCI_VENDOR_ID_NI		0x1093

That's a vendor id, not a serial device id.

thanks,

greg k-h
