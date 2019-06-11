From: Erwan Le Ray <erwan.leray@st.com>
Subject: [PATCH v2 03/10] serial: stm32: select pinctrl state in each suspend/resume function
Date: Tue, 11 Jun 2019 14:25:23 +0200
Message-ID: <1560255930-22554-4-git-send-email-erwan.leray@st.com>
References: <1560255930-22554-1-git-send-email-erwan.leray@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1560255930-22554-1-git-send-email-erwan.leray@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-serial@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Erwan Le Ray <erwan.leray@st.com>, Fabrice Gasnier <fabrice.gasnier@st.com>, Bich Hemon <bich.hemon@st.com>
List-Id: linux-serial@vger.kernel.org

From: Bich Hemon <bich.hemon@st.com>

Select either pinctrl sleep state in suspend function or default state in
resume function.

Signed-off-by: Bich Hemon <bich.hemon@st.com>
Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 9c2b04e..04eda75 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -1298,6 +1298,8 @@ static int stm32_serial_suspend(struct device *dev)
 	else
 		stm32_serial_enable_wakeup(port, false);
 
+	pinctrl_pm_select_sleep_state(dev);
+
 	return 0;
 }
 
@@ -1305,6 +1307,8 @@ static int stm32_serial_resume(struct device *dev)
 {
 	struct uart_port *port = dev_get_drvdata(dev);
 
+	pinctrl_pm_select_default_state(dev);
+
 	if (device_may_wakeup(dev))
 		stm32_serial_enable_wakeup(port, false);
 
-- 
1.9.1
