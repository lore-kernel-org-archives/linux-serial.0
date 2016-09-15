From: Alexandre TORGUE <alexandre.torgue-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH 00/11] STM32 USART: fixes and new MCU support
Date: Thu, 15 Sep 2016 18:42:32 +0200
Message-ID: <1473957763-30629-1-git-send-email-alexandre.torgue@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, gerald.baeza-qxv4g6HH51o@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

This series adds some fixes for stm32 uart, add DMA support for improve IP
behaviour, and add usart support of STM32F7 MCU.

Regards

Alex

Alexandre TORGUE (11):
  serial: stm32: adding support for stm32f7
  DOCUMENTATION: dt-bindings: Document the STM32 USART bindings
  serial: stm32: header file creation
  serial: stm32: disable tx and rx during shutdown
  serial: stm32: correct flow control property spelling
  serial: stm32: clock disabling management
  dt-bindings: Add DMA bindings for STM32 USART
  serial: stm32: adding dma support
  serial: stm32: fix spin_lock management
  serial: stm32: fix uart enable management
  ARM: DT: STM32: add dma for usart1 on F429

 .../devicetree/bindings/serial/st,stm32-usart.txt  |  46 ++
 arch/arm/boot/dts/stm32f429.dtsi                   |   3 +
 drivers/tty/serial/stm32-usart.c                   | 612 ++++++++++++++++-----
 drivers/tty/serial/stm32-usart.h                   | 229 ++++++++
 4 files changed, 739 insertions(+), 151 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/st,stm32-usart.txt
 create mode 100644 drivers/tty/serial/stm32-usart.h

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
