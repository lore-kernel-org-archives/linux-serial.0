From: Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 00/15] MIPS Malta DT Conversion
Date: Fri, 22 May 2015 16:50:59 +0100
Message-ID: <1432309875-9712-1-git-send-email-paul.burton@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Leonid Yegoshin <Leonid.Yegoshin-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, "Steven J. Hill" <Steven.Hill-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Qais Yousef <qais.yousef-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Markos Chandras <markos.chandras-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Michal Marek <mmarek-AlSwsSmVLrQ@public.gmane.org>Jason Cooper <ja>
List-Id: linux-serial@vger.kernel.org

This series begins converting the MIPS Malta board to use device tree,
which is done with a few goals in mind:

  - To modernise the Malta board support, providing a cleaner example to
    people referencing it when bringing up new boards and reducing the
    amount of code they need to write.

  - To make the code at the board level more generic with the eventual
    aim of sharing it between multiple boards & allowing for
    multi-platform kernel binaries. Although this series doesn't result
    in the kernel reaching those goals, it is a step in that direction.

  - To result in a more maintainable kernel through a combination of the
    above.


Paul Burton (15):
  MIPS: define GCR_GIC_STATUS register fields
  MIPS: include errno.h for ENODEV in mips-cm.h
  MIPS: malta: basic DT plumbing
  MIPS: i8259: DT support
  irqchip: mips-gic: register IRQ domain with MIPS_GIC_IRQ_BASE
  MIPS: malta: probe interrupt controllers via DT
  MIPS: remove [SR]ocIt(2) IRQ handling code
  of_serial: support for UARTs on I/O ports
  MIPS: malta: probe UARTs using DT
  MIPS: malta: probe RTC via DT
  MIPS: malta: probe pflash via DT
  MIPS: malta: remove fw_memblock_t abstraction
  MIPS: malta: remove nonsense memory limit
  MIPS: malta: setup RAM regions via DT
  MIPS: malta: setup post-I/O hole RAM on non-EVA

 arch/mips/Kconfig                               |   3 +
 arch/mips/boot/dts/mti/Makefile                 |   1 +
 arch/mips/boot/dts/mti/malta.dts                | 150 +++++++++++++++
 arch/mips/configs/malta_defconfig               |   3 +-
 arch/mips/configs/malta_kvm_defconfig           |   3 +-
 arch/mips/configs/malta_kvm_guest_defconfig     |   3 +-
 arch/mips/configs/malta_qemu_32r6_defconfig     |   1 +
 arch/mips/configs/maltaaprp_defconfig           |   1 +
 arch/mips/configs/maltasmvp_defconfig           |   1 +
 arch/mips/configs/maltasmvp_eva_defconfig       |   1 +
 arch/mips/configs/maltaup_defconfig             |   1 +
 arch/mips/configs/maltaup_xpa_defconfig         |   3 +-
 arch/mips/include/asm/fw/fw.h                   |  16 --
 arch/mips/include/asm/i8259.h                   |   1 +
 arch/mips/include/asm/mach-malta/malta-dtshim.h |  29 +++
 arch/mips/include/asm/mips-cm.h                 |   5 +
 arch/mips/include/asm/msc01_ic.h                | 147 ---------------
 arch/mips/kernel/Makefile                       |   1 -
 arch/mips/kernel/i8259.c                        |  43 ++++-
 arch/mips/kernel/irq-msc01.c                    | 159 ----------------
 arch/mips/mti-malta/Makefile                    |   6 +-
 arch/mips/mti-malta/malta-dt.c                  |  34 ++++
 arch/mips/mti-malta/malta-dtshim.c              | 238 ++++++++++++++++++++++++
 arch/mips/mti-malta/malta-int.c                 | 130 +------------
 arch/mips/mti-malta/malta-memory.c              | 131 +------------
 arch/mips/mti-malta/malta-platform.c            | 147 ---------------
 arch/mips/mti-malta/malta-setup.c               |   7 +
 arch/mips/mti-malta/malta-time.c                |   1 -
 drivers/irqchip/irq-mips-gic.c                  |   2 +-
 drivers/tty/serial/of_serial.c                  |   7 +-
 30 files changed, 542 insertions(+), 733 deletions(-)
 create mode 100644 arch/mips/boot/dts/mti/malta.dts
 create mode 100644 arch/mips/include/asm/mach-malta/malta-dtshim.h
 delete mode 100644 arch/mips/include/asm/msc01_ic.h
 delete mode 100644 arch/mips/kernel/irq-msc01.c
 create mode 100644 arch/mips/mti-malta/malta-dt.c
 create mode 100644 arch/mips/mti-malta/malta-dtshim.c
 delete mode 100644 arch/mips/mti-malta/malta-platform.c

-- 
2.4.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
