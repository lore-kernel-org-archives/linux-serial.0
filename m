From: Kukjin Kim <kgene.kim@samsung.com>
Subject: Re: [PATCH v2 0/9] serial: samsung: rework clock lookup and add device
 tree support
Date: Mon, 24 Oct 2011 10:27:47 +0200
Message-ID: <4EA52183.3040206@samsung.com>
References: <1318241285-23568-1-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53796 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753798Ab1JXI1u (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 24 Oct 2011 04:27:50 -0400
In-Reply-To: <1318241285-23568-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>, Greg KH <gregkh@suse.de>
Cc: linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, kgene.kim@samsung.com, grant.likely@secretlab.ca, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org, alan@linux.intel.com

On 10/10/11 12:07, Thomas Abraham wrote:
> Changes since v1:
> - Included the missing dt bindings documentation in the last patch.
> - Rebased and tested with linux 3.1-rc9 on linux-samsung-soc tree.
> - Commit messages are modified to be elaborate.
> - No changes in code.
>
>
> This patchset reworks the lookup of parent clocks for baud rate generator in
> the uart controller and adds support for device tree based discovery for the
> uart controller.
>
> The Samsung uart driver was dependent on the clock names supplied in the
> platform data. This dependency had to be first removed to add device tree based
> discovery support for Samsung uart driver. In the process of reworking the clock
> lookup logic, several changes had to be made which in turn made parts of the
> driver redundant and such portions of the driver have been removed in this
> patchset. As a result, all the SoC specific extensions have been deleted.
>
> Patch 1 modifies the driver to keep a copy of the location of the platform data
> in the driver's private data. This makes device tree support addition
> non-intrusive.
>
> Patch 2 moves the complicated clock divider handling for fclk source clock for
> s3c2440 SoC into platform code. The fclk clock can be easily managed by
> representing it as a clock in the platform code. fclk clock handling was
> specific to s3c2440 and moving this out of the driver makes the rest of the
> clock handling in the driver almost identical for all SoC's supported by the
> driver.
>
> Patch 3 modifies the driver to lookup source clocks for baud rate generator
> by using generic clock names. The generic clock name used by the driver is
> 'clk_uart_baud' appended with the parent number of the clock. For instance,
> the second parent clock source option for baud rate generator is named as
> 'clk_uart_baud2'.
>
> The driver stops depending on the set_clock and get_clock callbacks in the
> SoC specific extensions. Instead, the driver is modified to lookup parent
> clock rates and decide/calculate the best parent clock source for the baud
> rate generator (best clock would have the least delta when compared to buad
> rate requested).
>
> In this process, four new members are added in the driver's private data
> structure. The 'def_clk_sel' member is a platform set bit-value that specifies
> the possible parents that the driver is allowed to use for baud rate clock.
> A bit set at a particular bit position selects that parent clock source.
> Example: If bit number 2 is set in 'def_clk_sel', then parent clock source '2'
> can be a possible parent clock for baud rate generator. The 'num_clks'
> is the number of possible parent clocks that the SoC supports. The
> 'clksel_mask' and 'clksel_shift' members are used to operate on the parent clock
> selection bit field int the uart controller's contol register.
>
> Patch 4 removes all uses and instances of 'struct s3c24xx_uart_clksrc'. This
> structure was used to pass source clock 'names' between platform code, driver
> and SoC specific extensions. By moving away from using platform specified clock
> names in the driver, all uses and instances of 'struct s3c24xx_uart_clksrc'
> is removed.
>
> Patch 5 removes all the SoC specific get_clksrc and set_clksrc callbacks. These
> callbacks were using SoC specific clock names to communicate the clock to be
> set or retrieved. These callbacks are removed as they are no longer required.
>
> Patch 6 reworks the uart clocks in platform code of all Samsung SoC's. The
> driver would use generic clock names and this patch creates aliases to uart
> clocks with generic clock names as the alias name.
>
> Patch 7 merges all the SoC specific port reset functions into one common port
> reset function and moves the common function into the common Samsung uart
> driver. All the SoC specific port reset functions perform the same operation
> allowing all of them to be converged.
>
> Patch 8 collapses all the SoC specific probe functions and associated driver
> private data into the Samsung common uart driver. With get_clksrc, set_clksrc
> and reset_port functions removed from SoC specific extensions, all the remains
> in those extensions is the probe function along with SoC specific driver data.
> These are merged into the common Samsung uart driver and all the SoC specific
> extensions are deleted.
>
> Patch 9 adds device tree based discovery support for the uart driver.
>
>
> This patchset is based on the following tree
> https://github.com/kgene/linux-samsung.git  branch: for-next
>
> with the following two patches applied
> [PATCH] serial: samsung: Add unified interrupt handler for s3c64xx and later SoC's
> [PATCH] ARM: SAMSUNG: Remove uart irq handling from plaform code
>
> and tested on the following boards.
> SMDK2440, SMDK2416, SMDK6410, SMDK6440, SMDK6450, SMDKC100, SMDKV210, SMDKV310.
>
> This patchset has dependency on the following patchset:
> [PATCH V2 0/2] Add a common macro for creating struct clk_lookup entries
>
>
> Thomas Abraham (9):
>    serial: samsung: Keep a copy of the location of platform data in driver's private data
>    serial: samsung: move handling of fclk/n clock to platform code
>    serial: samsung: switch to clkdev based clock lookup
>    serial: samsung: remove struct 's3c24xx_uart_clksrc' and all uses of it
>    serial: samsung: remove all uses of get_clksrc and set_clksrc
>    arm: samsung: register uart clocks to clock lookup list
>    serial: samsung: merge all SoC specific port reset functions
>    serial: samsung: merge probe() function from all SoC specific extensions
>    serial: samsung: add device tree support
>
>   .../devicetree/bindings/serial/samsung_uart.txt    |   14 +
>   arch/arm/mach-exynos4/clock.c                      |  106 ++--
>   arch/arm/mach-exynos4/init.c                       |   21 +-
>   arch/arm/mach-s3c2410/mach-bast.c                  |   22 -
>   arch/arm/mach-s3c2410/mach-vr1000.c                |   24 -
>   arch/arm/mach-s3c2410/s3c2410.c                    |    6 +
>   arch/arm/mach-s3c2412/clock.c                      |    7 +
>   arch/arm/mach-s3c2440/clock.c                      |   44 ++
>   arch/arm/mach-s3c2440/mach-anubis.c                |   22 +-
>   arch/arm/mach-s3c2440/mach-at2440evb.c             |   22 +-
>   arch/arm/mach-s3c2440/mach-osiris.c                |   24 +-
>   arch/arm/mach-s3c2440/mach-rx1950.c                |   18 +-
>   arch/arm/mach-s3c2440/mach-rx3715.c                |   19 +-
>   arch/arm/mach-s3c64xx/clock.c                      |   37 +-
>   arch/arm/mach-s5p64x0/clock-s5p6440.c              |   32 +-
>   arch/arm/mach-s5p64x0/clock-s5p6450.c              |   32 +-
>   arch/arm/mach-s5p64x0/init.c                       |   31 -
>   arch/arm/mach-s5pc100/clock.c                      |   33 +-
>   arch/arm/mach-s5pv210/clock.c                      |  107 ++--
>   arch/arm/mach-s5pv210/init.c                       |   19 -
>   arch/arm/plat-s3c24xx/s3c2443-clock.c              |   23 +-
>   arch/arm/plat-samsung/include/plat/regs-serial.h   |   45 +-
>   drivers/tty/serial/Kconfig                         |   45 +--
>   drivers/tty/serial/Makefile                        |    5 -
>   drivers/tty/serial/s3c2410.c                       |  115 ----
>   drivers/tty/serial/s3c2412.c                       |  149 -----
>   drivers/tty/serial/s3c2440.c                       |  178 ------
>   drivers/tty/serial/s3c6400.c                       |  149 -----
>   drivers/tty/serial/s5pv210.c                       |  158 -----
>   drivers/tty/serial/samsung.c                       |  639 ++++++++++++--------
>   drivers/tty/serial/samsung.h                       |   32 +-
>   31 files changed, 752 insertions(+), 1426 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/serial/samsung_uart.txt
>   delete mode 100644 drivers/tty/serial/s3c2410.c
>   delete mode 100644 drivers/tty/serial/s3c2412.c
>   delete mode 100644 drivers/tty/serial/s3c2440.c
>   delete mode 100644 drivers/tty/serial/s3c6400.c
>   delete mode 100644 drivers/tty/serial/s5pv210.c

(Cc'ed Greg KH)

Looks good for me, and I need to get the ack from Greg before applying.

Greg, if you're ok, I'd like to send this series to upstream via Samsung 
tree for supporting device tree because this touches a lot of arch/arm/ 
Samsung stuff. If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
