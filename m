From: Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 0/31] Create generic board init for ARM, x86, PPC
Date: Tue,  5 Mar 2013 16:39:34 -0800
Message-ID: <1362530405-10824-1-git-send-email-sjg@chromium.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qa0-f73.google.com ([209.85.216.73]:63212 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595Ab3CFArY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 5 Mar 2013 19:47:24 -0500
Received: by mail-qa0-f73.google.com with SMTP id g10so426169qah.4
        for <linux-serial@vger.kernel.org>; Tue, 05 Mar 2013 16:47:24 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Wolfgang Denk <wd@denx.de>, Albert Aribaud <albert.u.boot@aribaud.net>, Graeme Russ <graeme.russ@gmail.com>, Mike Frysinger <vapier@gentoo.org>, Tom Rini <trini@ti.com>, Vadim Bendebury <vbendeb@chromium.org>, Hung-ying Tyan <tyanh@chromium.org>, Simon Glass <sjg@chromium.org>, Macpaul Lin <macpaul@andestech.com>, Daniel Hellstrom <daniel@gaisler.com>, Valentin Longchamp <valentin.longchamp@keymile.com>, Andy Fleming <afleming@freescale.com>, Minkyu Kang <mk7.kang@samsung.com>, Stephen Warren <swarren@nvidia.com>, Kumar Gala <galak@kernel.crashing.org>, linux-serial@vger.kernel.org, Tom Warren <twarren@nvidia.com>, Kim Phillips <kim.phillips@freescale.com>, Jason Jin <jason.jin@freescale.com>, Stefan Roese <sr@denx.de>, =?UTF-8?q?Andreas=20Bie=C3=9Fmann?= <andreas.devel@googlemail.com>, Greg Kroah-Hartman <gregkh@suse.de>, Sonic Zhang <sonic.adi@gmail.com>Stephe

This series creates a generic board init implementation which contains
the essential functions of the major arch/xxx/lib/board.c files. It is
split into two parts: board_f.c for pre-relocation and board_r.c for
post-relocation.

What is the motivation for this change?

1. There is a lot of repeated code in the board.c files. Any change to
things like setting up the baud rate requires a change in 10 separate
places.

2. Since there are 14 separate files, adding a new feature which requires
initialisation is painful since it must be independently added in 14
places.

3. As time goes by the architectures naturely diverge since there is limited
pressure to compare features or even CONFIG options against simiilar things
in other board.c files.

4. New architectures must implement all the features all over again, and
sometimes in subtley different ways. This places an unfair burden on getting
a new architecture fully functional and running with U-Boot.

5. While it is a bit of a tricky change, I believe it is worthwhile and
achievable. There is no requirement that all code be common, only that
the code that is common should be located in common/board.c rather than
arch/xxx/lib/board.c.

All the functions of board_init_f() and board_init_r() are broken into
separate function calls so that they can easily be included or excluded
for a particular architecture. It also makes it easier to adopt Graeme's
initcall proposal assuming this comes about.

http://lists.denx.de/pipermail/u-boot/2012-January/114499.html

This series is not dependent on generic relocation. So relocation
happens as one big chunk and is still completely arch-specific. See the
relocation series for a proposed solution to this for ARM:

http://lists.denx.de/pipermail/u-boot/2011-December/112928.html

or x86's implementation which is in mainline. Unifying relocation is
probably the next step after this series.

Instead of moving over a whole architecture, this series takes the approach
of simply enabling generic board support for an architecture. It is then up
to each board to opt in by defining CONFIG_SYS_GENERIC_BOARD in the board
config file. If this is not done, then the code will be generated as
before. This allows both sets of code to co-exist until we are comfortable
with the generic approach, and enough boards run.

ARM is a relatively large board.c file and one which I can test, therefore
I think it is a good target for this series. On the other hand, x86 is
relatively small and simple, but different enough that it introduces a
few issues to be solved. So I have chosen both ARM and x86 for this series.
After a suggestion from Wolfgang I have added PPC also. This is the
largest and most feature-full board, so hopefully we have all bases
covered in this series. Other archs are mostly a subset of these.

A generic global_data structure is now in mainline, and this is required
for this series.

Similarly we need a generic bd_info structure, since generic code will
be accessing it. I have done this with a simple generic file for now.

There was dicussion on the list about passing gd_t around as a parameter
to pre-relocation init functions. I think this makes sense, but it can
be done as a separate change, and this series does not require it.

While this series needs to stand on its own, the goal is the unification
of the board init code. So I hope we can address issues with this in mind,
rather than focusing too narrowly on particular ARM, x86 or PPC issues.
I have added TODO markers in places where I think there are opportunities
to relationalise the board init now it is all in one place, but these don't
need to be addressed for the feature to work, and are best done as smaller
patches than can be reviewed by individual arch maintainers, I think.

I have run-tested ARM on Tegra Seaboard and x86/coreboot only. To try it
out, define CONFIG_SYS_GENERIC_BOARD in your board file and rebuild. Most
likely on PPC at least it will hang, but if you are lucky it will print
something first :-) I hope to test an SPL board (snow / exynos5250) when
I can get that booting from mainline.

I have run this though buildman with CONFIG_SYS_GENERIC_BOARD on for all
ARM, PPC and x86 boards. The only failure is highbank (an ARM board), which
seems to use SCSI but scsi_init() is not available.

Code size increases by about 1KB on ARM and about 1.3KB on PPC with generic
board enabled. This is mostly due to the move to using separate functions
for each part of the init, which will make it easier to move to a pure
initcall approach later if we want to.

Since this series was first sent there have been additions to the board
code for ARM and PPC. I have added in these additions. This is a manual
process, and I expect that people will find problems (and send patches)
as they try out their boards.

Changes in v6:
- Add bi_ip_addr field back into struct bd_info
- Remove CREDITS boilerplate from asm-generic/sections.h
- Add linux source commit hash to asm-generic/sections.h
- Remove x86: nds32: tags from stub example patch
- Fix up watchdog support for m68k and sh
- Tidy up stack reservation code to separate out ARM
- Fix up ordering of dram init (specifically to get ARM SPL boards to boot)
- Add debug() to show RAM top
- Adjust the way the top of memory is calculated
- Unify code in reserve_stacks() and reserve_stacks_spl()
- Tidy up stack reservation code to separate out PowerPC
- Don't use scsi_init() on ARM
- Drop ppc memory barrier macros patch
- Enable generic board for all Tegra boards
- Add new patch to enable generic board on x86
- Add new patch to enable generic board for Exynos5
- Add new patch to fix up blackfin's board_type global_data
- Add new patch to remove noreturn attribute from blackfin's cpu_init_f()
- Add new patch to correct avr32 compile error caused by global_data chnage
- Add new patch to fix up ns16550 cast
- Add new patch to fix out-of-tree building on sparc
- Add new patch to fix warnings in sparc's serial.c

Changes in v5:
- Use unsigned int for baud_rate
- Remove bi_ip_addr field from struct bd_info
- Add new patch to replace __bss_end__ with __bss_end
- Remove the __bss_end #define now that this is consistent across U-Boot
- Remove avr32 changes from what should be an arm patch
- Adjust u-boot-nds32.h link symbols to keep U-Boot building
- Add debug() code to initcalls
- Update copyright on initcalls
- Avoid using static declaration for init_func_watchdog_reset()
- Add fdtdec header file to board_f.c
- Remove setup_global_data_ptr()
- Tidy up stack init
- Put global data on stack in board_init_f()
- Add fdt relocation
- Remove fdt relocation field from x86 arch_global_data
- Deal with change of board_init_f() semantics on ARM
- Save boot_flags in global_data in board_init_f()
- Add print_cpuinfo() prototype to include/common.h
- Add code from arch/arm/lib/board.c to control loading of environment
- Put watchdog init function definitions in watchdog.h
- Adjust ppc to work with watchdog.h additions
- Add new patch to fix config in keymile boards
- Add offsets support for access to fdt that uses CONFIG_OF_SEPARATE
- Use watchdog.h for watchdog functions
- Add define to work around __bss_end / __bss_end__ confusion
- Add prototype for update_flash_size() to include/common.h
- Updates in board_r.c to make ppc build correctly
- Add prototype for board_start_ide() to include/ide.h
- Bring in new ppc features since this patch was first created
- Add new patch to adjust board_f.c for x86
- Add new patch to adjust board_r.c for x86
- Include asm/sections.h in x86 sdram code
- Define _end instead of __end for x86
- Avoid setting up gd on x86 as it is already done

Changes in v4:
- Add three more fields required for ARM
- Add asm/sections.h for each architecture
- Use asm/sections.h instead of asm-generic/sections.h
- Use asm/sections.h instead of asm-generic/sections.h
- Adjust u-boot-x86.h link symbols to keep U-Boot building
- Use asm/sections.h instead of asm-generic/sections.h
- Use asm/sections.h instead of asm-generic/sections.h
- Updates to sit on top of earlier patches
- Updates to sit on top of earlier patches
- Use asm/sections.h instead of asm-generic/sections.h
- Rebase to master
- Drop sc520_timer.c patch (warning already fixed by previous patch)

Changes in v3:
- Cast away the volatile on gd for memcpy()
- Add header to new x86 relocate.c and init_helpers.c
- Rebase to master
- Rebase on top of x86/master (which has not yet been pulled to master)

Changes in v2:
- Change generic board to an opt-in system on a per-board basic
- Add CONFIG_SYS_GENERIC_BOARD to allow board to select generic board
- Add PowerPC support
- Rebase to master

Simon Glass (31):
  Introduce generic u-boot.h file
  Replace __bss_end__ with __bss_end
  Introduce generic link section.h symbol files
  arm: Use sections header to obtain link symbols
  Change stub example to use asm-generic/sections.h
  Introduce a basic initcall implementation
  Define CONFIG_SYS_LEGACY_BOARD everywhere
  Declare watchdog functions in watchdog.h
  Introduce generic pre-relocation board_f.c
  Introduce generic post-relocation board_r.c
  Add spl load feature
  arm: Remove use of board_early_init_r/last_stage_init()
  arm: Enable generic board support
  Add CONFIG_SYS_SYM_OFFSETS to support offset symbols
  Adjust board_f.c for ppc
  Adjust board_r.c for ppc
  ppc: Enable generic board support
  x86: Adjust board_f.c for x86
  x86: Adjust board_r.c for x86
  x86: Use sections header to obtain link symbols
  x86: Enable generic board support
  tegra: Enable generic board for Tegra
  x86: Enable generic board
  exynos5: Enable generic board for Exynos5 device tree boards
  blackfin: Fix up board_type global data
  blackfin: Remove noreturn attribute from cpu_init_f()
  avr32: Fix cast warning in board.c
  serial: ns16550: Remove unwanted cast
  sparc: Fix out-of-tree building
  sparc: Fix build warnings in serial.c
  Use 'unsigned int' for global_data's baudrate

 README                                           |   17 +
 arch/arm/cpu/arm1136/start.S                     |    2 +-
 arch/arm/cpu/arm1136/u-boot-spl.lds              |    2 +-
 arch/arm/cpu/arm1176/start.S                     |    2 +-
 arch/arm/cpu/arm720t/start.S                     |    2 +-
 arch/arm/cpu/arm920t/ep93xx/u-boot.lds           |    2 +-
 arch/arm/cpu/arm920t/start.S                     |    2 +-
 arch/arm/cpu/arm925t/start.S                     |    2 +-
 arch/arm/cpu/arm926ejs/davinci/spl.c             |    2 +-
 arch/arm/cpu/arm926ejs/mxs/start.S               |    2 +-
 arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds        |    2 +-
 arch/arm/cpu/arm926ejs/spear/u-boot-spl.lds      |    2 +-
 arch/arm/cpu/arm926ejs/start.S                   |    4 +-
 arch/arm/cpu/arm946es/start.S                    |    2 +-
 arch/arm/cpu/arm_intcm/start.S                   |    2 +-
 arch/arm/cpu/armv7/omap-common/u-boot-spl.lds    |    2 +-
 arch/arm/cpu/armv7/socfpga/u-boot-spl.lds        |    2 +-
 arch/arm/cpu/armv7/start.S                       |    2 +-
 arch/arm/cpu/ixp/start.S                         |    2 +-
 arch/arm/cpu/ixp/u-boot.lds                      |    2 +-
 arch/arm/cpu/pxa/start.S                         |    2 +-
 arch/arm/cpu/s3c44b0/start.S                     |    2 +-
 arch/arm/cpu/sa1100/start.S                      |    2 +-
 arch/arm/cpu/u-boot.lds                          |    4 +-
 arch/arm/include/asm/sections.h                  |   27 +
 arch/arm/include/asm/spl.h                       |    2 +-
 arch/arm/include/asm/u-boot-arm.h                |    4 -
 arch/arm/include/asm/u-boot.h                    |    9 +
 arch/arm/lib/Makefile                            |    3 +
 arch/arm/lib/board.c                             |    1 +
 arch/arm/lib/crt0.S                              |    4 +-
 arch/arm/lib/spl.c                               |    2 +-
 arch/avr32/config.mk                             |    3 +
 arch/avr32/cpu/start.S                           |    2 +-
 arch/avr32/cpu/u-boot.lds                        |    2 +-
 arch/avr32/include/asm/sections.h                |    6 +-
 arch/avr32/lib/board.c                           |    8 +-
 arch/blackfin/config.mk                          |    3 +
 arch/blackfin/cpu/cpu.c                          |    1 -
 arch/blackfin/include/asm/global_data.h          |    1 +
 arch/blackfin/include/asm/sections.h             |   27 +
 arch/blackfin/lib/board.c                        |    2 +-
 arch/m68k/config.mk                              |    3 +
 arch/m68k/include/asm/sections.h                 |   27 +
 arch/m68k/lib/board.c                            |    5 +-
 arch/microblaze/config.mk                        |    3 +
 arch/microblaze/include/asm/sections.h           |   27 +
 arch/mips/config.mk                              |    3 +
 arch/mips/include/asm/sections.h                 |   27 +
 arch/mips/include/asm/u-boot-mips.h              |    4 +-
 arch/nds32/config.mk                             |    3 +
 arch/nds32/cpu/n1213/start.S                     |    2 +-
 arch/nds32/cpu/n1213/u-boot.lds                  |    2 +-
 arch/nds32/include/asm/sections.h                |   27 +
 arch/nds32/include/asm/u-boot-nds32.h            |    8 +-
 arch/nds32/lib/board.c                           |    2 +-
 arch/nios2/config.mk                             |    3 +
 arch/nios2/cpu/start.S                           |    6 +-
 arch/nios2/cpu/u-boot.lds                        |    2 +-
 arch/nios2/include/asm/sections.h                |   27 +
 arch/openrisc/include/asm/sections.h             |   27 +
 arch/powerpc/cpu/74xx_7xx/start.S                |    4 +-
 arch/powerpc/cpu/74xx_7xx/u-boot.lds             |    2 +-
 arch/powerpc/cpu/mpc512x/start.S                 |    4 +-
 arch/powerpc/cpu/mpc512x/u-boot.lds              |    2 +-
 arch/powerpc/cpu/mpc5xx/start.S                  |    4 +-
 arch/powerpc/cpu/mpc5xx/u-boot.lds               |    2 +-
 arch/powerpc/cpu/mpc5xxx/spl_boot.c              |    2 +-
 arch/powerpc/cpu/mpc5xxx/start.S                 |    4 +-
 arch/powerpc/cpu/mpc5xxx/u-boot-customlayout.lds |    2 +-
 arch/powerpc/cpu/mpc5xxx/u-boot-spl.lds          |    2 +-
 arch/powerpc/cpu/mpc5xxx/u-boot.lds              |    2 +-
 arch/powerpc/cpu/mpc8220/start.S                 |    4 +-
 arch/powerpc/cpu/mpc8220/u-boot.lds              |    2 +-
 arch/powerpc/cpu/mpc824x/start.S                 |    4 +-
 arch/powerpc/cpu/mpc824x/u-boot.lds              |    2 +-
 arch/powerpc/cpu/mpc8260/start.S                 |    4 +-
 arch/powerpc/cpu/mpc8260/u-boot.lds              |    2 +-
 arch/powerpc/cpu/mpc83xx/start.S                 |    4 +-
 arch/powerpc/cpu/mpc83xx/u-boot-spl.lds          |    4 +-
 arch/powerpc/cpu/mpc83xx/u-boot.lds              |    2 +-
 arch/powerpc/cpu/mpc85xx/start.S                 |    4 +-
 arch/powerpc/cpu/mpc85xx/u-boot-nand.lds         |    2 +-
 arch/powerpc/cpu/mpc85xx/u-boot-nand_spl.lds     |    2 +-
 arch/powerpc/cpu/mpc85xx/u-boot-spl.lds          |    2 +-
 arch/powerpc/cpu/mpc85xx/u-boot.lds              |    2 +-
 arch/powerpc/cpu/mpc86xx/start.S                 |    4 +-
 arch/powerpc/cpu/mpc86xx/u-boot.lds              |    2 +-
 arch/powerpc/cpu/mpc8xx/start.S                  |    4 +-
 arch/powerpc/cpu/ppc4xx/start.S                  |    4 +-
 arch/powerpc/cpu/ppc4xx/u-boot.lds               |    2 +-
 arch/powerpc/include/asm/sections.h              |   27 +
 arch/powerpc/include/asm/spl.h                   |    2 +-
 arch/powerpc/include/asm/u-boot.h                |    7 +
 arch/powerpc/lib/Makefile                        |    2 +
 arch/powerpc/lib/board.c                         |   18 +-
 arch/sandbox/config.mk                           |    3 +
 arch/sandbox/include/asm/sections.h              |    2 +
 arch/sh/config.mk                                |    3 +
 arch/sh/cpu/sh2/u-boot.lds                       |    2 +-
 arch/sh/cpu/sh3/u-boot.lds                       |    2 +-
 arch/sh/cpu/sh4/u-boot.lds                       |    2 +-
 arch/sh/include/asm/sections.h                   |   27 +
 arch/sh/lib/board.c                              |    1 +
 arch/sparc/config.mk                             |    3 +
 arch/sparc/cpu/leon2/Makefile                    |    7 -
 arch/sparc/cpu/leon2/serial.c                    |   10 -
 arch/sparc/cpu/leon3/Makefile                    |    7 -
 arch/sparc/cpu/leon3/serial.c                    |   10 -
 arch/sparc/include/asm/sections.h                |   27 +
 arch/x86/cpu/coreboot/sdram.c                    |    1 +
 arch/x86/cpu/u-boot.lds                          |    4 +-
 arch/x86/include/asm/config.h                    |    1 +
 arch/x86/include/asm/global_data.h               |    1 -
 arch/x86/include/asm/sections.h                  |   27 +
 arch/x86/include/asm/u-boot-x86.h                |    9 -
 arch/x86/include/asm/u-boot.h                    |   11 +
 arch/x86/lib/Makefile                            |    3 +
 arch/x86/lib/board.c                             |    3 +-
 arch/x86/lib/init_helpers.c                      |    3 +-
 arch/x86/lib/relocate.c                          |    9 +-
 board/BuS/eb_cpu5282/u-boot.lds                  |    2 +-
 board/LEOX/elpt860/u-boot.lds                    |    2 +-
 board/RPXClassic/u-boot.lds                      |    2 +-
 board/RPXlite/u-boot.lds                         |    2 +-
 board/RPXlite_dw/u-boot.lds                      |    2 +-
 board/RRvision/u-boot.lds                        |    2 +-
 board/actux1/u-boot.lds                          |    2 +-
 board/actux2/u-boot.lds                          |    2 +-
 board/actux3/u-boot.lds                          |    2 +-
 board/adder/u-boot.lds                           |    2 +-
 board/ait/cam_enc_4xx/u-boot-spl.lds             |    2 +-
 board/altera/nios2-generic/u-boot.lds            |    2 +-
 board/amcc/acadia/u-boot-nand.lds                |    2 +-
 board/amcc/bamboo/u-boot-nand.lds                |    2 +-
 board/amcc/canyonlands/u-boot-nand.lds           |    2 +-
 board/amcc/kilauea/u-boot-nand.lds               |    2 +-
 board/amcc/sequoia/u-boot-nand.lds               |    2 +-
 board/amcc/sequoia/u-boot-ram.lds                |    2 +-
 board/astro/mcf5373l/u-boot.lds                  |    2 +-
 board/cm4008/flash.c                             |    1 +
 board/cm41xx/flash.c                             |    1 +
 board/cobra5272/u-boot.lds                       |    2 +-
 board/cogent/u-boot.lds                          |    2 +-
 board/dave/PPChameleonEVB/u-boot.lds             |    2 +-
 board/davinci/da8xxevm/u-boot-spl-da850evm.lds   |    2 +-
 board/davinci/da8xxevm/u-boot-spl-hawk.lds       |    2 +-
 board/dvlhost/u-boot.lds                         |    2 +-
 board/eltec/mhpc/u-boot.lds                      |    2 +-
 board/emk/top860/u-boot.lds                      |    2 +-
 board/ep88x/u-boot.lds                           |    2 +-
 board/esd/dasa_sim/u-boot.lds                    |    2 +-
 board/esd/pmc440/u-boot-nand.lds                 |    2 +-
 board/esd/tasreg/u-boot.lds                      |    2 +-
 board/esteem192e/u-boot.lds                      |    2 +-
 board/evb64260/u-boot.lds                        |    2 +-
 board/fads/u-boot.lds                            |    2 +-
 board/flagadm/u-boot.lds                         |    2 +-
 board/freescale/m5208evbe/u-boot.lds             |    2 +-
 board/freescale/m52277evb/u-boot.lds             |    2 +-
 board/freescale/m5235evb/u-boot.lds              |    2 +-
 board/freescale/m5249evb/u-boot.lds              |    2 +-
 board/freescale/m5253demo/u-boot.lds             |    2 +-
 board/freescale/m5253evbe/u-boot.lds             |    2 +-
 board/freescale/m5271evb/u-boot.lds              |    2 +-
 board/freescale/m5272c3/u-boot.lds               |    2 +-
 board/freescale/m5275evb/u-boot.lds              |    2 +-
 board/freescale/m5282evb/u-boot.lds              |    2 +-
 board/freescale/m53017evb/u-boot.lds             |    2 +-
 board/freescale/m5329evb/u-boot.lds              |    2 +-
 board/freescale/m5373evb/u-boot.lds              |    2 +-
 board/freescale/m54418twr/u-boot.lds             |    2 +-
 board/freescale/m54451evb/u-boot.lds             |    2 +-
 board/freescale/m54455evb/u-boot.lds             |    2 +-
 board/freescale/m547xevb/u-boot.lds              |    2 +-
 board/freescale/m548xevb/u-boot.lds              |    2 +-
 board/freescale/mx31ads/u-boot.lds               |    2 +-
 board/gaisler/gr_cpci_ax2000/u-boot.lds          |    2 +-
 board/gaisler/gr_ep2s60/u-boot.lds               |    2 +-
 board/gaisler/gr_xc3s_1500/u-boot.lds            |    2 +-
 board/gaisler/grsim/u-boot.lds                   |    2 +-
 board/gaisler/grsim_leon2/u-boot.lds             |    2 +-
 board/gen860t/u-boot-flashenv.lds                |    2 +-
 board/gen860t/u-boot.lds                         |    2 +-
 board/genietv/u-boot.lds                         |    2 +-
 board/hermes/u-boot.lds                          |    2 +-
 board/hymod/u-boot.lds                           |    2 +-
 board/icu862/u-boot.lds                          |    2 +-
 board/idmr/u-boot.lds                            |    2 +-
 board/ip860/u-boot.lds                           |    2 +-
 board/ivm/u-boot.lds                             |    2 +-
 board/korat/u-boot-F7FC.lds                      |    2 +-
 board/kup/kup4k/u-boot.lds                       |    2 +-
 board/kup/kup4x/u-boot.lds                       |    2 +-
 board/lwmon/u-boot.lds                           |    2 +-
 board/manroland/uc100/u-boot.lds                 |    2 +-
 board/matrix_vision/mvsmr/u-boot.lds             |    2 +-
 board/mbx8xx/u-boot.lds                          |    2 +-
 board/mousse/u-boot.lds                          |    2 +-
 board/mvblue/u-boot.lds                          |    2 +-
 board/netphone/u-boot.lds                        |    2 +-
 board/netta/u-boot.lds                           |    2 +-
 board/netta2/u-boot.lds                          |    2 +-
 board/netvia/u-boot.lds                          |    2 +-
 board/nx823/u-boot.lds                           |    2 +-
 board/quantum/u-boot.lds                         |    2 +-
 board/r360mpi/u-boot.lds                         |    2 +-
 board/rbc823/u-boot.lds                          |    2 +-
 board/renesas/sh7752evb/u-boot.lds               |    2 +-
 board/renesas/sh7757lcr/u-boot.lds               |    2 +-
 board/rsdproto/u-boot.lds                        |    2 +-
 board/samsung/smdk5250/smdk5250-uboot-spl.lds    |    2 +-
 board/samsung/smdk6400/u-boot-nand.lds           |    2 +-
 board/sandpoint/u-boot.lds                       |    2 +-
 board/sixnet/u-boot.lds                          |    2 +-
 board/snmc/qs850/u-boot.lds                      |    2 +-
 board/snmc/qs860t/u-boot.lds                     |    2 +-
 board/spc1920/u-boot.lds                         |    2 +-
 board/spd8xx/u-boot.lds                          |    2 +-
 board/stx/stxxtc/u-boot.lds                      |    2 +-
 board/svm_sc8xx/u-boot.lds                       |    2 +-
 board/tqc/tqm8xx/u-boot.lds                      |    2 +-
 board/v37/u-boot.lds                             |    2 +-
 board/vpac270/u-boot-spl.lds                     |    2 +-
 board/woodburn/woodburn.c                        |    2 +-
 common/Makefile                                  |    4 +
 common/board_f.c                                 | 1016 ++++++++++++++++++++++
 common/board_r.c                                 |  919 +++++++++++++++++++
 config.mk                                        |    8 +
 drivers/serial/ns16550.c                         |    2 +-
 examples/standalone/stubs.c                      |    7 +-
 include/asm-generic/global_data.h                |    4 +-
 include/asm-generic/sections.h                   |  117 +++
 include/asm-generic/u-boot.h                     |  162 ++++
 include/common.h                                 |    2 +
 include/configs/exynos5250-dt.h                  |    1 +
 include/configs/km/keymile-common.h              |    4 -
 include/configs/km/km-powerpc.h                  |    4 +
 include/configs/tegra-common.h                   |    2 +
 include/ide.h                                    |    7 +
 include/initcall.h                               |   25 +
 include/watchdog.h                               |   18 +
 lib/Makefile                                     |    1 +
 lib/initcall.c                                   |   39 +
 nand_spl/board/amcc/acadia/u-boot.lds            |    2 +-
 nand_spl/board/amcc/bamboo/u-boot.lds            |    2 +-
 nand_spl/board/amcc/canyonlands/u-boot.lds       |    2 +-
 nand_spl/board/amcc/kilauea/u-boot.lds           |    2 +-
 nand_spl/board/amcc/sequoia/u-boot.lds           |    2 +-
 nand_spl/board/freescale/mpc8315erdb/u-boot.lds  |    4 +-
 nand_spl/board/freescale/mx31pdk/u-boot.lds      |    2 +-
 nand_spl/board/karo/tx25/u-boot.lds              |    2 +-
 nand_spl/board/samsung/smdk6400/u-boot.lds       |    2 +-
 nand_spl/board/sheldon/simpc8313/u-boot.lds      |    4 +-
 254 files changed, 2979 insertions(+), 295 deletions(-)
 create mode 100644 arch/arm/include/asm/sections.h
 create mode 100644 arch/blackfin/include/asm/sections.h
 create mode 100644 arch/m68k/include/asm/sections.h
 create mode 100644 arch/microblaze/include/asm/sections.h
 create mode 100644 arch/mips/include/asm/sections.h
 create mode 100644 arch/nds32/include/asm/sections.h
 create mode 100644 arch/nios2/include/asm/sections.h
 create mode 100644 arch/openrisc/include/asm/sections.h
 create mode 100644 arch/powerpc/include/asm/sections.h
 create mode 100644 arch/sh/include/asm/sections.h
 create mode 100644 arch/sparc/include/asm/sections.h
 create mode 100644 arch/x86/include/asm/sections.h
 create mode 100644 common/board_f.c
 create mode 100644 common/board_r.c
 create mode 100644 include/asm-generic/sections.h
 create mode 100644 include/asm-generic/u-boot.h
 create mode 100644 include/initcall.h
 create mode 100644 lib/initcall.c

-- 
1.8.1.3

