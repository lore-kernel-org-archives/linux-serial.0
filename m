From: Erwan Le Ray <erwan.leray@st.com>
Subject: [PATCH 0/5] STM32 usart FIFO handling
Date: Tue, 18 Jun 2019 12:02:21 +0200
Message-ID: <1560852146-3393-1-git-send-email-erwan.leray@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>
Cc: linux-serial@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Erwan Le Ray <erwan.leray@st.com>, Fabrice Gasnier <fabrice.gasnier@st.com>
List-Id: linux-serial@vger.kernel.org

This series delivers RX and TX FIFO features to improve system 
performances during data transfer.

Erwan Le Ray (5):
  serial: stm32: add support of timeout interrupt for RX
  serial: stm32: update PIO transmission
  serial: stm32: add support of TX FIFO threshold
  serial: stm32: add support of RX FIFO threshold
  serial: stm32: add RX and TX FIFO flush

 drivers/tty/serial/stm32-usart.c | 132 +++++++++++++++++++++++++++++++--------
 drivers/tty/serial/stm32-usart.h |  19 ++++++
 2 files changed, 124 insertions(+), 27 deletions(-)

-- 
1.9.1
