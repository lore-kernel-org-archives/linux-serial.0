From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v7 00/11] Add initial RDA8810PL SoC and Orange Pi boards
 support
Date: Mon, 31 Dec 2018 13:13:42 -0800
Message-ID: <20181231211342.ulg4jytermffqi34@localhost>
References: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: arnd@arndb.de, arm@kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com, linux-unisoc@lists.infradead.org, afaerber@suse.de, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, amit.kucheria@linaro.org, linus.walleij@linaro.org, zhao_steven@263.net
List-Id: linux-serial@vger.kernel.org

On Tue, Dec 18, 2018 at 08:32:27PM +0530, Manivannan Sadhasivam wrote:
> Hello Maintainers,
> 
> This patch series adds initial RDA8810PL SoC and Orange Pi boards (2G IoT and
> i96) support. RDA8810PL is an ARM Cortex A5 based SoC with Vivante's GC860
> GPU. The SoC has been added as a new ARM sub architecture with myself as the
> maintainer.
> 
> More information about the boards can be found in below links:
> 
> 1. Orange Pi 2G-IoT - http://www.orangepi.org/OrangePi2GIOT/
> 2. Orange Pi i96 - https://www.96boards.org/product/orangepi-i96/
> 
> All patches are reviewed by the corresponding subsystem maintainers. The
> clocksource and irqchip patches are reviewed and merged while the serial
> driver got review from Greg but I'm not sure who will apply it.
> 
> So as per my discussion with Arnd, sending the individual patches instead
> of a Pull request so that the rest of the patches can go through the
> ARM SoC tree.
> 
> Please consider applying it.

Hi,

I've applied this series to our next/late branch. It's a branch we'll try to
get merged by the end of the merge window, but it's not a guarantee that we'll
be able to get it done. If not, the material will be moved to the next release
instead.


Thanks!


-Olof
