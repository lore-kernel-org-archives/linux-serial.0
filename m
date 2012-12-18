From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V2] serial: tegra: add serial driver
Date: Tue, 18 Dec 2012 09:49:27 -0700
Message-ID: <50D09E97.5090805@wwwdotorg.org>
References: <1355813993-24867-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1355813993-24867-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: alan@linux.intel.com, gregkh@linuxfoundation.org, jslaby@suse.cz, grant.likely@secretlab.ca, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, wmb@firmworks.com
List-Id: linux-serial@vger.kernel.org

On 12/17/2012 11:59 PM, Laxman Dewangan wrote:
> Nvidia's Tegra has multiple uart controller which supports:

A few nits:

That should be NVIDIA.

>  .../devicetree/bindings/serial/serial-tegra.txt    |   24 +

I strongly object to this name; I believe nvidia,tegra20-hsuart.txt is
correct.

> +NVIDIA Tegra20/Tegra30 high speed (dma based) UART controller driver.

DMA, UART (below), ... should be all capitals.

The binding looks reasonable to me. The few parts of the code I looked
at look OK.

> diff --git a/include/linux/platform_data/serial-tegra.h b/include/linux/platform_data/serial-tegra.h
> +#endif /* _SERIAL_TEGRA_H_ */
> +

There's a blank line at the end of the file.
