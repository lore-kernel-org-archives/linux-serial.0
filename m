From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [patch v1 0/2] JTAG driver introduction
Date: Wed, 2 Aug 2017 16:12:09 +0200
Message-ID: <20170802141209.GB25781@lunn.ch>
References: <1501679918-20486-1-git-send-email-oleksandrs@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1501679918-20486-1-git-send-email-oleksandrs@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Shamray <oleksandrs@mellanox.com>
Cc: gregkh@linuxfoundation.org, arnd@arndb.de, devicetree@vger.kernel.org, jiri@resnulli.us, system-sw-low-level@mellanox.com, openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org, mec@shout.net, joel@jms.id.au, linux-serial@vger.kernel.org, vadimp@maellanox.com, tklauser@distanz.ch, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Wed, Aug 02, 2017 at 04:18:36PM +0300, Oleksandr Shamray wrote:
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
> to communicate with user layer application. In such way, we can
> have the standard JTAG interface core part and separation from
> specific HW implementation.
> This allow new capability to debug the CPU or program system's 
> device via BMC without additional devices nor cost. 

Hi Oleksandr

Do you have patches for OpenOCD? Or maybe i should ask it another way,
what user space tools are you using?

Thanks
	Andrew
