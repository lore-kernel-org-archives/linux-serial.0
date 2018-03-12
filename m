From: Bich HEMON <bich.hemon@st.com>
Subject: [PATCH v2 0/2] Add support for RS485
Date: Mon, 12 Mar 2018 09:50:04 +0000
Message-ID: <1520848188-7343-1-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Bich HEMON <bich.hemon@st.com>, Yves COPPEAUX <Yves.COPPEAUX@st.com>
List-Id: linux-serial@vger.kernel.org

v2:
- Patch series rebased on gregkh/tty/tty-next

This patchset updates existing stm32 usart driver by adding support for RS485.

Bich Hemon (2):
  dt-bindings: serial: stm32: add RS485 optional properties
  serial: stm32: add support for RS485 hardware control mode

 .../devicetree/bindings/serial/st,stm32-usart.txt  |   2 +
 drivers/tty/serial/stm32-usart.c                   | 130 ++++++++++++++++++++-
 drivers/tty/serial/stm32-usart.h                   |   3 +
 3 files changed, 134 insertions(+), 1 deletion(-)

-- 
1.9.1
