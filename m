From: Erwan Le Ray <erwan.leray@st.com>
Subject: [PATCH v3 00/10] STM32 usart power improvements
Date: Thu, 13 Jun 2019 15:49:50 +0200
Message-ID: <1560433800-12255-1-git-send-email-erwan.leray@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@st.com>, Rob Herring <robh+dt@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Erwan Le Ray <erwan.leray@st.com>, linux-serial@vger.kernel.org, Fabrice Gasnier <fabrice.gasnier@st.com>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

This series delivers power improvements for stm32-usart driver.

Changes in v3:
Move pinctrl/consumer.h include from "add support for no_console_suspend"
patch to "select pinctrl state" patch in order to solve a compilation 
issue.

Bich Hemon (3):
  dt-bindings: serial: add optional pinctrl states
  ARM: dts: stm32: Update pin states for uart4 on stm32mp157c-ed1
  ARM: dts: stm32: Update UART4 pin states on stm32mp157a-dk1

Erwan Le Ray (7):
  dt-bindings: serial: stm32: add wakeup option
  serial: stm32: select pinctrl state in each suspend/resume function
  serial: stm32: add pm_runtime support
  serial: stm32: Use __maybe_unused instead of #if CONFIG_PM_SLEEP
  serial: stm32: add support for no_console_suspend
  ARM: dts: stm32: update uart4 pin configurations for low power
  ARM: dts: stm32: add wakeup capability on each usart/uart on
    stm32mp157c

 .../devicetree/bindings/serial/st,stm32-usart.txt  | 19 ++++-
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi          | 17 +++++
 arch/arm/boot/dts/stm32mp157a-dk1.dts              |  5 +-
 arch/arm/boot/dts/stm32mp157c-ed1.dts              |  5 +-
 arch/arm/boot/dts/stm32mp157c.dtsi                 | 40 ++++++++--
 drivers/tty/serial/stm32-usart.c                   | 88 ++++++++++++++++++++--
 drivers/tty/serial/stm32-usart.h                   |  1 +
 7 files changed, 155 insertions(+), 20 deletions(-)

-- 
1.9.1
