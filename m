From: <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Subject: [PATCHv2 0/4] Add TX FIFO Threshold for Altera 16550-FIFOxx
Date: Thu, 22 Sep 2016 14:56:13 -0500
Message-ID: <1474574177-4984-1-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, lftan-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, anton.wuerfel-d40JDW7QUjc@public.gmane.org, phillip.raffeck-d40JDW7QUjc@public.gmane.org, yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, matwey-TTlVxmypnbovJsYlp49lxw@public.gmane.org, mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org
Cc: peter.ujfalusi-l0cyMroinI0@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, dongsheng.wang-3arQi8VN3Tc@public.gmane.org, luis-HiykPkW1eAzzDCI4PIEvbQC/G2K4zDHf@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tthayer.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org, nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org
List-Id: linux-serial@vger.kernel.org

From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>

Some variants of the 16550 have a programmable TX FIFO threshold that
will trigger an IRQ when the FIFO drops below the threshold. The Altera
16550 compatible soft IP supports programmable TX FIFO thresholds.

This patch series adds the tx-threshold parameter to the device tree.
The tx_loadsz variable is amount of data that can be loaded into the
FIFO on an IRQ and is updated based on the tx-threshold value.

This patch series also adds support for the TX FIFO threshold registers
in the Altera 16550-FIFOxx soft IP.

Thor Thayer (4):
  Documentation: dt: serial: Add TX FIFO threshold parameter
  serial: 8250: of: Load TX FIFO Threshold from DT
  serial: 8250: Set Altera 16550 TX FIFO Threshold
  nios2: dts: 10m50: Add tx-threshold parameter

 Documentation/devicetree/bindings/serial/8250.txt |    2 +
 arch/nios2/boot/dts/10m50_devboard.dts            |    1 +
 drivers/tty/serial/8250/8250_of.c                 |    7 ++++
 drivers/tty/serial/8250/8250_port.c               |   43 +++++++++++++++++++++
 include/uapi/linux/serial_reg.h                   |    8 ++++
 5 files changed, 61 insertions(+)

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
