From: Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
Subject: [PATCHv3 0/9] *** ARM: Update arch-vt8500 to Devicetree ***
Date: Wed, 22 Aug 2012 08:47:29 +1200
Message-ID: <1345582058-2291-1-git-send-email-linux@prisktech.co.nz>
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
To: vt8500-wm8505-linux-kernel-/JYPxA39Uh6Zox4op4iWzw@public.gmane.org
Cc: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mike Turquette <mturquette-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

This patchset updates arch-vt8500 to devicetree and removes all the old-style
code. Support for WM8650 has also been added.

Example dts/dtsi files are given for the three currently supported models.

Major changes:

GPIO code has been converted to a platform_device and rewritten as WM8505
support was broken. Add support for WM8650 gpio controller.

UHCI support was missing. Added this as a generic non-pci uhci controller as
it doesn't require anything special. Should be usable by any system that doesn't
have special requirements to get the UHCI controller working.

Framebuffer code patched to support WM8650. The bindings for this are of concern
but there doesn't seem to be a formalized binding yet. This patch is based off
Sascha Hauer's current patch on the dri-devel mailing list and should be easily
patched out when its finalized.

Patchset based on Arnd's arm-soc/for-next branch.


Could I get this reviewed, hopefully for inclusion into v3.7.

Regards
Tony Prisk

Changes
v2:
Cleanup style/formatting errors
Removed erroneous commit message about GPIO not being converted to devicetree
Corrected arch-vt8500/irq.c header to correct filename
Changed GPIO driver to use module_platform_driver()
Renamed vt8500_gpio_bank_regs -> vt8500_gpio_bank_regoffsets
Changed vt8500_gpio_bank_regoffset fields to unsigned int
Changed bit-setting code to use BIT() macro
Removed of_find_compatible() and use pdev->dev.of_node in _probe()
Removed regoff field and related code - leftover from old design
Added kerneldoc regarding struct vt8500_gpio_bank_regoffsets fields
Update MODULE_LICENSE on all platform devices to "GPL v2" to match their headers
Renamed dts board files to clarify product names

v3:
Corrected serial driver issue after porting to device tree. pdev->id no longer
valid.
Corrected irq.c to properly initialize slaved interrupt controller.
Updated framebuffer drivers to use phandles for display node.
Corrected dts definitions for updated framebuffer driver.
EHCI/UHCI patch (Patch 4/9) already in -next via usb-next tree.

Included common clock frame support.
Added initialization code to arch/arm/mach-vt8500/vt8500.c for clocks.
Updated wm8650.dtsi to include basic clocks.


Tony Prisk (9):
  arm: vt8500: Add device tree files for VIA/Wondermedia SoC's
  rtc: vt8500: Add devicetree support for vt8500-rtc
  serial: vt8500: Add devicetree support for vt8500-serial
  usb: vt8500: Add devicetree support for vt8500-ehci and -uhci.
  video: vt8500: Add devicetree support for vt8500-fb and wm8505-fb
  arm: vt8500: Update arch-vt8500 to devicetree support.
  arm: vt8500: doc: Add device tree bindings for arch-vt8500 devices
  arm: vt8500: gpio: Devicetree support for arch-vt8500
  arm: vt8500: clk: Add Common Clock Framework support

 Documentation/devicetree/bindings/arm/vt8500.txt   |   15 +
 .../bindings/arm/vt8500/via,vt8500-intc.txt        |   16 +
 .../bindings/arm/vt8500/via,vt8500-pmc.txt         |   13 +
 .../bindings/arm/vt8500/via,vt8500-timer.txt       |   15 +
 Documentation/devicetree/bindings/clock/vt8500.txt |   72 +++
 .../devicetree/bindings/gpio/gpio_vt8500.txt       |   24 +
 .../devicetree/bindings/rtc/via,vt8500-rtc.txt     |   15 +
 .../bindings/tty/serial/via,vt8500-uart.txt        |   15 +
 .../devicetree/bindings/usb/platform-uhci.txt      |   15 +
 .../devicetree/bindings/usb/via,vt8500-ehci.txt    |   15 +
 .../devicetree/bindings/vendor-prefixes.txt        |    2 +
 .../devicetree/bindings/video/via,vt8500-fb.txt    |   48 ++
 .../devicetree/bindings/video/wm,prizm-ge-rops.txt |   13 +
 .../devicetree/bindings/video/wm,wm8505-fb.txt     |   22 +
 arch/arm/Kconfig                                   |    5 +
 arch/arm/boot/dts/vt8500-bv07.dts                  |   31 ++
 arch/arm/boot/dts/vt8500.dtsi                      |  100 ++++
 arch/arm/boot/dts/wm8505-ref.dts                   |   31 ++
 arch/arm/boot/dts/wm8505.dtsi                      |  126 +++++
 arch/arm/boot/dts/wm8650-mid.dts                   |   31 ++
 arch/arm/boot/dts/wm8650.dtsi                      |  138 ++++++
 arch/arm/mach-vt8500/Kconfig                       |   72 +--
 arch/arm/mach-vt8500/Makefile                      |    9 +-
 arch/arm/mach-vt8500/bv07.c                        |   80 ----
 arch/arm/mach-vt8500/common.h                      |   28 ++
 arch/arm/mach-vt8500/devices-vt8500.c              |   91 ----
 arch/arm/mach-vt8500/devices-wm8505.c              |   99 ----
 arch/arm/mach-vt8500/devices.c                     |  270 -----------
 arch/arm/mach-vt8500/devices.h                     |   88 ----
 arch/arm/mach-vt8500/gpio.c                        |  240 ----------
 arch/arm/mach-vt8500/include/mach/restart.h        |    4 +-
 arch/arm/mach-vt8500/include/mach/vt8500_irqs.h    |   88 ----
 arch/arm/mach-vt8500/include/mach/vt8500_regs.h    |   79 ----
 arch/arm/mach-vt8500/include/mach/wm8505_irqs.h    |  115 -----
 arch/arm/mach-vt8500/include/mach/wm8505_regs.h    |   78 ---
 arch/arm/mach-vt8500/irq.c                         |  209 +++++----
 arch/arm/mach-vt8500/restart.c                     |   54 ---
 arch/arm/mach-vt8500/timer.c                       |   67 ++-
 arch/arm/mach-vt8500/vt8500.c                      |  196 ++++++++
 arch/arm/mach-vt8500/wm8505_7in.c                  |   79 ----
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-vt8500.c                           |  496 ++++++++++++++++++++
 drivers/gpio/Kconfig                               |    6 +
 drivers/gpio/Makefile                              |    1 +
 drivers/gpio/gpio-vt8500.c                         |  313 ++++++++++++
 drivers/rtc/rtc-vt8500.c                           |    9 +-
 drivers/tty/serial/vt8500_serial.c                 |   37 +-
 drivers/usb/host/Kconfig                           |    4 +-
 drivers/usb/host/ehci-vt8500.c                     |   25 +-
 drivers/usb/host/uhci-hcd.c                        |    5 +
 drivers/usb/host/uhci-platform.c                   |  169 +++++++
 drivers/video/Kconfig                              |    6 +-
 drivers/video/vt8500lcdfb.c                        |   79 +++-
 drivers/video/wm8505fb.c                           |   97 +++-
 drivers/video/wmt_ge_rops.c                        |    9 +-
 55 files changed, 2384 insertions(+), 1581 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/vt8500.txt
 create mode 100644 Documentation/devicetree/bindings/arm/vt8500/via,vt8500-intc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/vt8500/via,vt8500-pmc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/vt8500/via,vt8500-timer.txt
 create mode 100644 Documentation/devicetree/bindings/clock/vt8500.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio_vt8500.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/via,vt8500-rtc.txt
 create mode 100644 Documentation/devicetree/bindings/tty/serial/via,vt8500-uart.txt
 create mode 100644 Documentation/devicetree/bindings/usb/platform-uhci.txt
 create mode 100644 Documentation/devicetree/bindings/usb/via,vt8500-ehci.txt
 create mode 100644 Documentation/devicetree/bindings/video/via,vt8500-fb.txt
 create mode 100644 Documentation/devicetree/bindings/video/wm,prizm-ge-rops.txt
 create mode 100644 Documentation/devicetree/bindings/video/wm,wm8505-fb.txt
 create mode 100644 arch/arm/boot/dts/vt8500-bv07.dts
 create mode 100644 arch/arm/boot/dts/vt8500.dtsi
 create mode 100644 arch/arm/boot/dts/wm8505-ref.dts
 create mode 100644 arch/arm/boot/dts/wm8505.dtsi
 create mode 100644 arch/arm/boot/dts/wm8650-mid.dts
 create mode 100644 arch/arm/boot/dts/wm8650.dtsi
 delete mode 100644 arch/arm/mach-vt8500/bv07.c
 create mode 100644 arch/arm/mach-vt8500/common.h
 delete mode 100644 arch/arm/mach-vt8500/devices-vt8500.c
 delete mode 100644 arch/arm/mach-vt8500/devices-wm8505.c
 delete mode 100644 arch/arm/mach-vt8500/devices.c
 delete mode 100644 arch/arm/mach-vt8500/devices.h
 delete mode 100644 arch/arm/mach-vt8500/gpio.c
 delete mode 100644 arch/arm/mach-vt8500/include/mach/vt8500_irqs.h
 delete mode 100644 arch/arm/mach-vt8500/include/mach/vt8500_regs.h
 delete mode 100644 arch/arm/mach-vt8500/include/mach/wm8505_irqs.h
 delete mode 100644 arch/arm/mach-vt8500/include/mach/wm8505_regs.h
 delete mode 100644 arch/arm/mach-vt8500/restart.c
 create mode 100644 arch/arm/mach-vt8500/vt8500.c
 delete mode 100644 arch/arm/mach-vt8500/wm8505_7in.c
 create mode 100644 drivers/clk/clk-vt8500.c
 create mode 100644 drivers/gpio/gpio-vt8500.c
 create mode 100644 drivers/usb/host/uhci-platform.c

-- 
1.7.9.5
