From: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH V2 0/3] Add RS-485 support and fix RTS/CTS implementation
Date: Mon, 1 Jun 2015 10:51:04 +0530
Message-ID: <1433136067-20644-1-git-send-email-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stefan-XLVq0VzYD2Y@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, jslaby-AlSwsSmVLrQ@public.gmane.org, moorray3-5tc4TXWwyLM@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhuvanchandra.dv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Changes since V1:
Use common get/set mctrl control methods for both lpuart, lpuart32
and fix indention.

Bhuvanchandra DV (3):
  ARM: dts: colibri-vf: Add pinmux for UART_0 aka UART_A RTS/CTS pins
  tty: serial: fsl_lpuart: remove RTS/CTS control from set/get_mctrl
  tty: serial: fsl_lpuart: Add support for RS-485

 arch/arm/boot/dts/vf-colibri.dtsi |   2 +
 drivers/tty/serial/fsl_lpuart.c   | 103 ++++++++++++++++++++------------------
 2 files changed, 57 insertions(+), 48 deletions(-)

-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
