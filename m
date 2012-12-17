From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: tegra: add serial driver
Date: Mon, 17 Dec 2012 07:13:09 -0800
Message-ID: <20121217151309.GA15665@kroah.com>
References: <1355746249-15347-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1355746249-15347-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: alan@linux.intel.com, jslaby@suse.cz, grant.likely@secretlab.ca, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, swarren@wwwdotorg.org
List-Id: linux-serial@vger.kernel.org

On Mon, Dec 17, 2012 at 05:40:49PM +0530, Laxman Dewangan wrote:
> Nvidia's Tegra has multiple uart controller which supports:
> - APB dma based controller fifo read/write.
> - End Of Data interrupt in incoming data to know whether end
>   of frame achieve or not.
> - Hw controlled RTS and CTS flow control to reduce SW overhead.
> 
> Add serial driver to use all above feature.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
>  .../bindings/serial/nvidia,serial-tegra.txt        |   26 +
>  drivers/tty/serial/Kconfig                         |   14 +
>  drivers/tty/serial/Makefile                        |    1 +
>  drivers/tty/serial/serial_tegra.c                  | 1398 ++++++++++++++++++++
>  include/linux/serial_tegra.h                       |   33 +

This file should be in include/linux/platform_data/, right?

thanks,

greg k-h
