From: Bich HEMON <bich.hemon@st.com>
Subject: [PATCH 00/20] Update STM32 usart driver
Date: Mon, 26 Jun 2017 12:49:08 +0000
Message-ID: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Language: en-US
Content-ID: <77A0BF5F63A26C4E852BC5277C486357@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Bich HEMON <bich.hemon@st.com>
List-Id: linux-serial@vger.kernel.org

From: Bich Hemon <bich.hemon@st.com>

This patchset updates the stm32 usart driver. It mainly adds
support for fifo, dma, debugfs anf fixes various bugs.

Bich Hemon (20):
  serial: stm32: adding fifo support
  dt-bindings: serial: each stm32 usart needs an alias
  serial: stm32: fix multi ports management
  serial: stm32: make fifoen as property for each port
  serial: stm32: add debugfs
  serial: stm32: fix pio transmit timeout
  serial: stm32: less messages on dma alloc error
  serial: stm32: timeout interrupt using with dma
  serial: stm32: fix end of transfer
  serial: stm32: fix dma receive
  serial: stm32: add RTS support
  serial: stm32: fix last_res value
  serial: stm32: fix error handling in probe
  dt-bindings: serial: document option wake-up interrupt for STM32 USART
  serial: stm32: Add wakeup mechanism
  serial: stm32: fix fifo usage
  dt-bindings: serial: stm32: add dma using note
  serial: stm32: update dma buffers length
  serial: stm32: add dma rx callback
  serial: stm32: fix rx interrupt handling in startup

 .../devicetree/bindings/serial/st,stm32-usart.txt  |  55 +++-
 drivers/tty/serial/stm32-usart.c                   | 310 ++++++++++++++++++---
 drivers/tty/serial/stm32-usart.h                   |  51 +++-
 3 files changed, 375 insertions(+), 41 deletions(-)

-- 
1.9.1
