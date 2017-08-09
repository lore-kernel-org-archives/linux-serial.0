From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: Re: [patch v2 0/2]
Date: Wed, 9 Aug 2017 16:31:28 +0200
Message-ID: <20170809143128.GI30723@lunn.ch>
References: <1502115467-1735-1-git-send-email-oleksandrs@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1502115467-1735-1-git-send-email-oleksandrs-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oleksandr Shamray <oleksandrs-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jiri-rHqAuBHg3fBzbRFIqnYvSA@public.gmane.org, system-sw-low-level-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org, openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, openocd-devel-owner-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, mec-WqBc5aa1uDFeoWH0uzbU5w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vadimp-45czdsxZ+A5DPfheJLI6IQ@public.gmane.org, tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Mon, Aug 07, 2017 at 05:17:45PM +0300, Oleksandr Shamray wrote:
> When a need raise up to use JTAG interface for system's devices
> programming or CPU debugging, it could be done from the external
> JTAG master controller.
>  
> For such purpose, usually the user layer
> application implements jtag protocol or using a proprietary
> connection to vendor hardware.
> This method is slow and not generic.
>  
> We propose to implement general JTAG interface and infrastructure
> to communicate with user layer application. 

Hi Oleksandr

You might find this discussion interesting:

https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2017-August/004721.html

You are defining a new ABI here, so linux-abi should be involved in
the discussion of these patches.

    Andrew
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
