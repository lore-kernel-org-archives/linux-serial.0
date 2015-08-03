From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] pci_ids: Add Pericom vendor and device ids
Date: Sun, 2 Aug 2015 21:36:47 -0700
Message-ID: <20150803043647.GA20605@kroah.com>
References: <1438576401-24921-1-git-send-email-adam.lee@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438576401-24921-1-git-send-email-adam.lee@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
To: Adam Lee <adam.lee@canonical.com>
Cc: linux-pci@vger.kernel.org, linux-serial@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Aug 03, 2015 at 12:33:20PM +0800, Adam Lee wrote:
> This patch add Pericom's vendor id and Pericom PI7C9X795[1248] chips'
> device ids.
> 
> Signed-off-by: Adam Lee <adam.lee@canonical.com>
> ---
>  include/linux/pci_ids.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index fcff8f8..c4a93cf 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2995,4 +2995,10 @@
>  
>  #define PCI_VENDOR_ID_OCZ		0x1b85
>  
> +#define PCI_VENDOR_ID_PERICOM			0x12D8
> +#define PCI_DEVICE_ID_PERICOM_PI7C9X7951	0x7951
> +#define PCI_DEVICE_ID_PERICOM_PI7C9X7952	0x7952
> +#define PCI_DEVICE_ID_PERICOM_PI7C9X7954	0x7954
> +#define PCI_DEVICE_ID_PERICOM_PI7C9X7958	0x7958

Please read the top of this file, this isn't needed...

thanks,

greg k-h
