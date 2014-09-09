From: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v5 0/2] DTS: serial: Add bindings documention for the Mediatek UARTs
Date: Tue,  9 Sep 2014 17:31:41 +0200
Message-ID: <1410276703-5274-1-git-send-email-matthias.bgg@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-AlSwsSmVLrQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, yingjoe.chen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

This patch set adds support for the UART found in Mediatek SoCs.
The chip is a changed version of a 8250 controller.
Especially it introduces a new register called highspeed. The value
in this register has to be set depending on the baudrate. The value
in the register influences the way the divisor has to be calculated.

The patch series is build against linux-next and tested on mt6589. Should
work as well on mt6577 and mt6582.

Thanks,
Matthias

Changes for v5:
- specify all SoC compatible strings in Documentation
- rename clock
- rebase against linux-next

Changes for v4:
- delete owner in platform driver instance
- pass plattform_device to mtk8250_probe_of
- reorganise probe function to error out early
- Fix DTS documentation

Changes for v3:
- use dev_warn instead of pr_warn
- use 8250_core function to update termios

Changes for v2:
- drop 8250_core capability extension for the chip
- encapsulate set_termios in the driver method

---

Matthias Brugger (2):
  tty: serial: 8250: Add Mediatek UART driver
  DTS: serial: Add bindings documention for the Mediatek UARTs

 .../devicetree/bindings/serial/mtk-uart.txt        |  22 ++
 drivers/tty/serial/8250/8250_mtk.c                 | 294 +++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig                    |   6 +
 drivers/tty/serial/8250/Makefile                   |   1 +
 4 files changed, 323 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/mtk-uart.txt
 create mode 100644 drivers/tty/serial/8250/8250_mtk.c

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
