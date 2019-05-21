From: Erwan Le Ray <erwan.leray@st.com>
Subject: [PATCH 0/7] usart various fixes for STM32
Date: Tue, 21 May 2019 17:45:40 +0200
Message-ID: <1558453547-22866-1-git-send-email-erwan.leray@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>
Cc: linux-serial@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Erwan Le Ray <erwan.leray@st.com>, Fabrice Gasnier <fabrice.gasnier@st.com>
List-Id: linux-serial@vger.kernel.org

This series delivers fixes in various uart functions of stm32-usart
driver.

Erwan Le Ray (7):
  serial: stm32: fix word length configuration
  serial: stm32: fix rx error handling
  serial: stm32: fix rx data length when parity enabled
  serial: stm32: fix transmit_chars when tx is stopped
  serial: stm32: Add support of TC bit status check
  serial: stm32: fix wakeup source initialization
  serial: stm32: fix the get_irq error case

 drivers/tty/serial/stm32-usart.c | 221 ++++++++++++++++++++++++++-------------
 drivers/tty/serial/stm32-usart.h |  14 +--
 2 files changed, 152 insertions(+), 83 deletions(-)

-- 
1.9.1
