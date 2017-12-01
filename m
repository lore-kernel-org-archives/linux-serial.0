From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH  0/2] serial: stm32: fix name conflict
Date: Fri, 1 Dec 2017 17:36:49 +0100
Message-ID: <1512146211-29086-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Rob Herring <robh+dt@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-serial@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch series:
-fix name conflict, when both driver 8250/stm32-usart
are activated. Replace stm32 tty name "ttyS" by "ttySTM".
-by default add stm32 console when SERIAL_STM32 is selected.

Ludovic Barre (2):
  serial: stm32: add default console
  serial: stm32: fix name conflict with 8250

 drivers/tty/serial/Kconfig       | 1 +
 drivers/tty/serial/stm32-usart.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.7.4
