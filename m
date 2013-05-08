From: Srinivas KANDAGATLA <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>
Subject: [RFC 0/8] ARM:STiH41x: Add STiH41x platform and board support
Date: Wed,  8 May 2013 15:09:47 +0100
Message-ID: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
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
Cc: Srinivas Kandagatla <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Nicolas Pitre <nico-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Stuart Menefy <stuart.menefy-qxv4g6HH51o@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Dong Aisheng <dong.aisheng-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>

This patch-set adds basic support for STMicroelectronics STiH41x SOCs
which includes STiH415 and STiH416 with B2000 and B2020 board support.

STiH415 and STiH416 are dual-core ARM Cortex-A9 CPU, designed for use in
Set-top-boxes.

The SOC support is divided into two parts which is plat-stixxxx and
mach-stih41x. plat-stixxxx contains code which is common across all
STMicroelectronics CE chips, and mach-stih41x contains support code for STiH415
and STiH416 SOCs.

Only device drivers included in this patch set are UART and pinctrl, other
drivers will be added in future.

The reason for adding two SOCs at this patch set is to show that no new C code
is required for second SOC(STiH416) support.

In the process of adding support to these SOCs we have added new code into sycon
and also added support for a9 global-timer.

I would appreciate any feedback on these patches.

Thanks,
srini

Srinivas Kandagatla (8):
  serial:st-asc: Add ST ASC driver.
  mfd:syscon: Introduce claim/read/write/release APIs
  pinctrl:stixxxx: Add pinctrl and pinconf support.
  ARM:stih41x: Add STiH415 SOC support
  ARM:stih41x: Add STiH416 SOC support
  ARM:stih41x: Add B2000 board support
  ARM:stih41x: Add B2020 board support

Stuart Menefy (1):
  ARM:global_timer: Add ARM global timer support.

 Documentation/arm/STiH41x/overview.txt             |   39 +
 Documentation/arm/STiH41x/stih415-overview.txt     |   12 +
 Documentation/arm/STiH41x/stih416-overview.txt     |   12 +
 Documentation/devicetree/bindings/arm/gt.txt       |   21 +
 .../bindings/pinctrl/pinctrl-stixxxx.txt           |  160 +++
 .../devicetree/bindings/tty/serial/st-asc.txt      |   18 +
 arch/arm/Kconfig                                   |    9 +
 arch/arm/Kconfig.debug                             |   38 +
 arch/arm/Makefile                                  |    2 +
 arch/arm/boot/dts/Makefile                         |    4 +
 arch/arm/boot/dts/stih415-b2000.dtsp               |   15 +
 arch/arm/boot/dts/stih415-b2020.dtsp               |   15 +
 arch/arm/boot/dts/stih415-clock.dtsi               |   38 +
 arch/arm/boot/dts/stih415-pinctrl.dtsi             |  480 ++++++++
 arch/arm/boot/dts/stih415.dtsi                     |   94 ++
 arch/arm/boot/dts/stih415.h                        |   20 +
 arch/arm/boot/dts/stih416-b2000.dtsp               |   16 +
 arch/arm/boot/dts/stih416-b2020.dtsp               |   16 +
 arch/arm/boot/dts/stih416-clock.dtsi               |   41 +
 arch/arm/boot/dts/stih416-pinctrl.dtsi             |  718 ++++++++++++
 arch/arm/boot/dts/stih416.dtsi                     |  103 ++
 arch/arm/boot/dts/stih416.h                        |   24 +
 arch/arm/boot/dts/stih41x-b2000.dtsi               |   41 +
 arch/arm/boot/dts/stih41x-b2020.dtsi               |   42 +
 arch/arm/boot/dts/stih41x.dtsi                     |   30 +
 arch/arm/boot/dts/stixxxx-pincfg.h                 |   95 ++
 arch/arm/configs/stih41x_defconfig                 |   95 ++
 arch/arm/include/asm/global_timer.h                |   12 +
 arch/arm/include/debug/stixxxx.S                   |   61 +
 arch/arm/kernel/Makefile                           |    1 +
 arch/arm/kernel/global_timer.c                     |  325 ++++++
 arch/arm/mach-stih41x/Kconfig                      |   44 +
 arch/arm/mach-stih41x/Makefile                     |    4 +
 arch/arm/mach-stih41x/board-dt.c                   |   80 ++
 arch/arm/mach-stih41x/stih41x.c                    |   82 ++
 arch/arm/mach-stih41x/stih41x.h                    |    7 +
 arch/arm/plat-stixxxx/Kconfig                      |    2 +
 arch/arm/plat-stixxxx/Makefile                     |    2 +
 arch/arm/plat-stixxxx/headsmp.S                    |   44 +
 arch/arm/plat-stixxxx/include/plat/hardware.h      |   20 +
 arch/arm/plat-stixxxx/include/plat/smp.h           |   19 +
 arch/arm/plat-stixxxx/platsmp.c                    |  144 +++
 drivers/mfd/syscon.c                               |  199 ++++
 drivers/pinctrl/Kconfig                            |   13 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/pinctrl-stixxxx.c                  | 1151 ++++++++++++++++++++
 drivers/pinctrl/pinctrl-stixxxx.h                  |  197 ++++
 drivers/tty/serial/Kconfig                         |   19 +
 drivers/tty/serial/Makefile                        |    1 +
 drivers/tty/serial/st-asc.c                        |  821 ++++++++++++++
 drivers/tty/serial/st-asc.h                        |  146 +++
 include/linux/mfd/syscon.h                         |   43 +
 include/uapi/linux/serial_core.h                   |    3 +
 53 files changed, 5639 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/arm/STiH41x/overview.txt
 create mode 100644 Documentation/arm/STiH41x/stih415-overview.txt
 create mode 100644 Documentation/arm/STiH41x/stih416-overview.txt
 create mode 100644 Documentation/devicetree/bindings/arm/gt.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-stixxxx.txt
 create mode 100644 Documentation/devicetree/bindings/tty/serial/st-asc.txt
 create mode 100644 arch/arm/boot/dts/stih415-b2000.dtsp
 create mode 100644 arch/arm/boot/dts/stih415-b2020.dtsp
 create mode 100644 arch/arm/boot/dts/stih415-clock.dtsi
 create mode 100644 arch/arm/boot/dts/stih415-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stih415.dtsi
 create mode 100644 arch/arm/boot/dts/stih415.h
 create mode 100644 arch/arm/boot/dts/stih416-b2000.dtsp
 create mode 100644 arch/arm/boot/dts/stih416-b2020.dtsp
 create mode 100644 arch/arm/boot/dts/stih416-clock.dtsi
 create mode 100644 arch/arm/boot/dts/stih416-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stih416.dtsi
 create mode 100644 arch/arm/boot/dts/stih416.h
 create mode 100644 arch/arm/boot/dts/stih41x-b2000.dtsi
 create mode 100644 arch/arm/boot/dts/stih41x-b2020.dtsi
 create mode 100644 arch/arm/boot/dts/stih41x.dtsi
 create mode 100644 arch/arm/boot/dts/stixxxx-pincfg.h
 create mode 100644 arch/arm/configs/stih41x_defconfig
 create mode 100644 arch/arm/include/asm/global_timer.h
 create mode 100644 arch/arm/include/debug/stixxxx.S
 create mode 100644 arch/arm/kernel/global_timer.c
 create mode 100644 arch/arm/mach-stih41x/Kconfig
 create mode 100644 arch/arm/mach-stih41x/Makefile
 create mode 100644 arch/arm/mach-stih41x/board-dt.c
 create mode 100644 arch/arm/mach-stih41x/stih41x.c
 create mode 100644 arch/arm/mach-stih41x/stih41x.h
 create mode 100644 arch/arm/plat-stixxxx/Kconfig
 create mode 100644 arch/arm/plat-stixxxx/Makefile
 create mode 100644 arch/arm/plat-stixxxx/headsmp.S
 create mode 100644 arch/arm/plat-stixxxx/include/plat/hardware.h
 create mode 100644 arch/arm/plat-stixxxx/include/plat/smp.h
 create mode 100644 arch/arm/plat-stixxxx/platsmp.c
 create mode 100644 drivers/pinctrl/pinctrl-stixxxx.c
 create mode 100644 drivers/pinctrl/pinctrl-stixxxx.h
 create mode 100644 drivers/tty/serial/st-asc.c
 create mode 100644 drivers/tty/serial/st-asc.h

-- 
1.7.6.5
