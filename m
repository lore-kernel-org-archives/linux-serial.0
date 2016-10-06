From: Alexandre TORGUE <alexandre.torgue@st.com>
Subject: [PATCH -next] serial: stm32: fix build failure
Date: Thu, 6 Oct 2016 11:33:33 +0200
Message-ID: <1475746413-18301-1-git-send-email-alexandre.torgue@st.com>
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
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>, gerald.baeza@st.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

While building m32r config the build failed with:
ERROR: stm32-usart.c:(.text+0xdc988): undefined reference to `bad_dma_ops'

To satisfy the dependency CONFIG_SERIAL_STM32 should depend on HAS_DMA.

Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index c783140..8a261c0 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1624,6 +1624,7 @@ config SERIAL_SPRD_CONSOLE
 
 config SERIAL_STM32
 	tristate "STMicroelectronics STM32 serial port support"
+	depends on HAS_DMA
 	select SERIAL_CORE
 	depends on ARM || COMPILE_TEST
 	help
-- 
1.9.1
