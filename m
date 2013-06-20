From: Srinivas KANDAGATLA <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH v3 00/10] ARM:STixxxx: Add STixxxx platform and board support
Date: Thu, 20 Jun 2013 15:03:16 +0100
Message-ID: <1371736996-8770-1-git-send-email-srinivas.kandagatla@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, Srinivas Kandagatla <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Stephen Gallimore <stephen.gallimore-qxv4g6HH51o@public.gmane.org>, Stuart Menefy <stuart.menefy-qxv4g6HH51o@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-serial@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>

Thankyou all for reviewing the v2 patches.
Here is patch-set incorporating all the review comments from v2.

This patch-set adds basic support for STMicroelectronics STixxxx SOCs
which includes STiH415 and STiH416 with B2000 and B2020 board support.

STiH415 and STiH416 are dual-core ARM Cortex-A9 CPU, designed for use in
Set-top-boxes. The SOC support is available in mach-stixxxx which contains
support code for STiH415, STiH416 SOCs including the generic board support.

Only device drivers included in this patch set are UART and pinctrl, other
drivers will be added in future.

The reason for adding two SOCs at this patch set is to show that no new
C code is required for second SOC(STiH416) support.

Thanks to Mark B for picking up the regmap_field apis.

I would appreciate any feedback on these patches.

Changes since v2:
	- st-asc driver made POSIX compatible based on Russell K comment.
	- cleaned up arm-global-timer code for non-dt as suggested by Linus W and
	- fixed minmum clock tick setting pointed by Linus W.
	- Moved to using syscon driver, as suggested by Arnd and Linus W.
	- Fixed few plat-* specfic references in comments pointed by Michal S.
	- Removed un-used variables in mach code as pointed by Michal S.
	- Cleaned up pinctrl nodes not to use simple-bus as suggested by Arnd
	and Linus W.
	- In pinctrl driver moved lot of magic numbers in to proper defines or
	constants as suggested by Linus W.
	- Renamed pinctrl-stixxxx to pinctrl-st as discussed with Linus W.
	- Split adding SOC to multi_v7_defconfig in to two patches as discussed
	with Mark R.
	

Changes since RFC:
 - st-asc Serial driver:
	- modified kconfig to remove default y
	- removed all the forward declaration.
	- use dynamic major numbering.
	- merge header-file in to driver.

 - ARM Global timer:
	- moved to drivers/clocksource.
	- added revision check in driver.
	- removed unused header file.
	- moved to u64 from union gt_counter
	- comments added in get_counter
	- removed leftover debug code.
	- moved code to use __raw_readl/writel.
	- used DIV_ROUND_CLOSEST
	- added check in interrupt handler.
	- expanded CE and CS acronyms usage.
	- Fixed minimum clock ticks value.
	- move to use clocksource_register_hz
	- added arch sched_clock support.
	- added ERRATA 740657 workaround.

 - ST-System Configuration Registers:
	- moved from syscon usage to st specific driver.

 - ST Pinctrl support:
	- fixed few typos in the documentation.
	- moved some of the retime offset information to driver.
	
 - STixxxx Support:
	- all the SOC support code is moved to mach-stixxxx
	- seperated DEBUG_LL code to new patch.
	- removed unnecessary #interrupt-cells
	- renamed uart to serial
	- moved to multi_v7_defconfig
	- used menuconfig in mach-stixxx/Kconfig
	- removed of_platform_populate as generic code does it for you.
	- scu address is ioremaped.

Srinivas Kandagatla (9):
  serial:st-asc: Add ST ASC driver.
  pinctrl:st: Add pinctrl and pinconf support.
  ARM:stixxxx: Add STiH415 SOC support
  ARM:stixxxx: Add STiH416 SOC support
  ARM:stixxxx: Add DEBUG_LL console support
  ARM:multi_v7_defconfig: rerun savedefconfig
  ARM:stixxxx: Add stixxxx options to  multi_v7_defconfig
  ARM:stih41x: Add B2000 board support
  ARM:stih41x: Add B2020 board support

Stuart Menefy (1):
  clocksource:arm_global_timer: Add ARM global timer support.

 Documentation/arm/stixxxx/overview.txt             |   33 +
 Documentation/arm/stixxxx/stih415-overview.txt     |   12 +
 Documentation/arm/stixxxx/stih416-overview.txt     |   12 +
 .../devicetree/bindings/arm/global_timer.txt       |   21 +
 .../devicetree/bindings/pinctrl/pinctrl-st.txt     |  110 ++
 .../devicetree/bindings/tty/serial/st-asc.txt      |   18 +
 MAINTAINERS                                        |   11 +
 arch/arm/Kconfig                                   |    2 +
 arch/arm/Kconfig.debug                             |   38 +
 arch/arm/Makefile                                  |    1 +
 arch/arm/boot/dts/Makefile                         |    4 +
 arch/arm/boot/dts/st-pincfg.h                      |   71 +
 arch/arm/boot/dts/stih415-b2000.dts                |   15 +
 arch/arm/boot/dts/stih415-b2020.dts                |   15 +
 arch/arm/boot/dts/stih415-clock.dtsi               |   38 +
 arch/arm/boot/dts/stih415-pinctrl.dtsi             |  268 ++++
 arch/arm/boot/dts/stih415.dtsi                     |   87 ++
 arch/arm/boot/dts/stih416-b2000.dts                |   16 +
 arch/arm/boot/dts/stih416-b2020.dts                |   16 +
 arch/arm/boot/dts/stih416-clock.dtsi               |   41 +
 arch/arm/boot/dts/stih416-pinctrl.dtsi             |  295 ++++
 arch/arm/boot/dts/stih416.dtsi                     |   96 ++
 arch/arm/boot/dts/stih41x-b2000.dtsi               |   41 +
 arch/arm/boot/dts/stih41x-b2020.dtsi               |   42 +
 arch/arm/boot/dts/stih41x.dtsi                     |   38 +
 arch/arm/configs/multi_v7_defconfig                |   31 +-
 arch/arm/include/debug/stixxxx.S                   |   61 +
 arch/arm/mach-stixxxx/Kconfig                      |   45 +
 arch/arm/mach-stixxxx/Makefile                     |    2 +
 arch/arm/mach-stixxxx/board-dt.c                   |   50 +
 arch/arm/mach-stixxxx/headsmp.S                    |   44 +
 arch/arm/mach-stixxxx/platsmp.c                    |  117 ++
 arch/arm/mach-stixxxx/smp.h                        |   17 +
 drivers/clocksource/Kconfig                        |   13 +
 drivers/clocksource/Makefile                       |    1 +
 drivers/clocksource/arm_global_timer.c             |  330 +++++
 drivers/pinctrl/Kconfig                            |    6 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/pinctrl-st.c                       | 1403 ++++++++++++++++++++
 drivers/tty/serial/Kconfig                         |   16 +
 drivers/tty/serial/Makefile                        |    1 +
 drivers/tty/serial/st-asc.c                        |  939 +++++++++++++
 include/uapi/linux/serial_core.h                   |    3 +
 43 files changed, 4404 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/arm/stixxxx/overview.txt
 create mode 100644 Documentation/arm/stixxxx/stih415-overview.txt
 create mode 100644 Documentation/arm/stixxxx/stih416-overview.txt
 create mode 100644 Documentation/devicetree/bindings/arm/global_timer.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-st.txt
 create mode 100644 Documentation/devicetree/bindings/tty/serial/st-asc.txt
 create mode 100644 arch/arm/boot/dts/st-pincfg.h
 create mode 100644 arch/arm/boot/dts/stih415-b2000.dts
 create mode 100644 arch/arm/boot/dts/stih415-b2020.dts
 create mode 100644 arch/arm/boot/dts/stih415-clock.dtsi
 create mode 100644 arch/arm/boot/dts/stih415-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stih415.dtsi
 create mode 100644 arch/arm/boot/dts/stih416-b2000.dts
 create mode 100644 arch/arm/boot/dts/stih416-b2020.dts
 create mode 100644 arch/arm/boot/dts/stih416-clock.dtsi
 create mode 100644 arch/arm/boot/dts/stih416-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stih416.dtsi
 create mode 100644 arch/arm/boot/dts/stih41x-b2000.dtsi
 create mode 100644 arch/arm/boot/dts/stih41x-b2020.dtsi
 create mode 100644 arch/arm/boot/dts/stih41x.dtsi
 create mode 100644 arch/arm/include/debug/stixxxx.S
 create mode 100644 arch/arm/mach-stixxxx/Kconfig
 create mode 100644 arch/arm/mach-stixxxx/Makefile
 create mode 100644 arch/arm/mach-stixxxx/board-dt.c
 create mode 100644 arch/arm/mach-stixxxx/headsmp.S
 create mode 100644 arch/arm/mach-stixxxx/platsmp.c
 create mode 100644 arch/arm/mach-stixxxx/smp.h
 create mode 100644 drivers/clocksource/arm_global_timer.c
 create mode 100644 drivers/pinctrl/pinctrl-st.c
 create mode 100644 drivers/tty/serial/st-asc.c

-- 
1.7.6.5
