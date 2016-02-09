From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v3 00/12] Add support for the Armada 3700 SoC an mvebu ARM64 based
Date: Tue, 09 Feb 2016 16:23:20 +0100
Message-ID: <3329016.IcNNJBVSgr@wuerfel>
References: <1454951660-13289-1-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1454951660-13289-1-git-send-email-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Omri Itach <omrii-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Monday 08 February 2016 18:14:08 Gregory CLEMENT wrote:
> This series introduce the support of the Armada 3700 family: it is the
> first ARM64 SoC of the mvebu family submitted to the mainline!
> 
> Currently there are two members of the Armada 3700 family, the only
> difference is the number of core: the Armada 3710 comes with one
> Cortex-A53 whereas the Armada 3720 comes with 2 Cortex-A53. In this
> series we enabled only the minimum to boot, pinctrl and clock tree
> will come soon.
> 
> The changes in this third version are very small (see the changelog).
> 
> The first two patches patches are here to be able to use the the
> ARCH_MVEBU for the Armada 3700 SoCs. The first ones is only here to
> have standalone series but it comes from Thomas Petazzoni's series:
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/472625
> 
> The third patch introduces a new serial driver for the uart used on
> this SoC. The driver remains simple even if the hardware is capable of
> doing more.
> 
> The forth one adapts the ahci driver to support the Armada 3700 SoC.
> The forth patch updates the binding documentation with the new
> compatible string.
> 
> The fifth patch adds a new entry Kconfig entry for this SoC family.
> 
> I took the opportunity of this series to tidy up the Marvell related
> files in the binding documentation with the seventh patch.
> 
> The eighth patch introduces the compatible string for the SoCs of the
> Armada 3700 family.
> 
> The ninth patch could be considered as the bulk of this series: it
> adds the device tree files for the Armada 3700 SoCs and for the
> reference board.
> 
> With the introduction of this new family the MAINTAINERS file, the
> Marvell README and the ARM64 defconfig files have to be updated: it is
> the purpose of the last 3 patches.
> 
> The patches 3 and 4 could be taken directly by the maintainer of their
> respective subsystem as there is no dependency at all with the rest of
> the series. I think that the rest of the series should go through the
> arm-soc maintainer but in doubt I also added the ARM64 maintainer as
> suggested by get_maintainer.pl.
> 
> 

Looks good overall,

Acked-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
