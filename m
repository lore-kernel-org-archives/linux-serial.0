From: Bich HEMON <bich.hemon@st.com>
Subject: [PATCH 0/2] Add support for RS485
Date: Wed, 28 Feb 2018 10:56:18 +0000
Message-ID: <1519815373-22940-1-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Bich HEMON <bich.hemon@st.com>
List-Id: linux-serial@vger.kernel.org

This patchset updates existing stm32 usart driver by adding support for RS485.

Bich Hemon (2):
  dt-bindings: serial: stm32: add RS485 optional properties
  serial: stm32: add support for RS485 hardware control mode

 .../devicetree/bindings/serial/st,stm32-usart.txt  |   2 +
 drivers/tty/serial/stm32-usart.c                   | 134 ++++++++++++++++++++-
 drivers/tty/serial/stm32-usart.h                   |   3 +
 3 files changed, 138 insertions(+), 1 deletion(-)

-- 
1.9.1
