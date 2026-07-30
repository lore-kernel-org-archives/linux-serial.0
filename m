Received: from mx0b-00622301.pphosted.com (mx0b-00622301.pphosted.com [205.220.175.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFBB40A953;
	Thu, 30 Jul 2026 11:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.175.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785409598; cv=none; b=iuj8Ar/wLrkY6whqMix/k0tgiEtOVmCg3rCnBBezchXis8HVPYxaSMclP+kbJ9kQiOW+aGdCJFDhZSMbAfSegNwg/8vAQh8sRinzRkbazeKGpp/689oz519OfKmbCjH4G1ZiwdVEnLTSi72DK+goVVjyD3g6Jxduri+NGVhNsdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785409598; c=relaxed/simple;
	bh=ltZlPhx/ptNQC9ytBZYrLEguAh1jyqLhPYja+dxpavQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V7hkwEInL6XF8FkXAR5/qAiIII8zS2UBn/42vJHfKxwqKDVYPTTM6AnBcOBqDF8qvpuApi4KPQKo7B1QLGgLpcF3ZXk1fMLLF6h5O3JOLp5QhFpDF3BE94ZXb1JcdN7pxMqnSxo1h37CNv0sYOpAtPobaNHp0d4n1yNXbMxS800=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ambarella.com; spf=pass smtp.mailfrom=ambarella.com; dkim=pass (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b=W6CkfW+h; arc=none smtp.client-ip=205.220.175.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ambarella.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ambarella.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b="W6CkfW+h"
Received: from pps.filterd (m0241925.ppops.net [127.0.0.1])
	by mx0a-00622301.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UA6Egn3332841;
	Thu, 30 Jul 2026 10:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	com20210415pp; bh=ijrYr6YBtJFCRCgubYGp5VRaGPQc7AEyp9FuRJSTWl0=; b=
	W6CkfW+hQ4Rr3F21IryAAvcHWDrAaX7UsJ1XEnfg5127jK18H71pJ0GyvtzYAsvg
	MJv+01Xrldy/6sUsbeM+DHuPmKdlbYN/tJXwWfHk6DjZ+ObcCOfzmAxck1uSmvcY
	XmX8nTpqXVw2Z72GT807X1HhzuH/jb5rLFOx6ipyxRPRSaSTf/mkz+YdHqmEbKtc
	NV2gz+Plj4/4G9hDp+Gf6DE/QwF+6HGcMjkXOurINLV89gFXVePnPUpKF/HhA6n+
	Irb0DQ4jPl32GIyteX60uWHArIKC6vLA/ZclZvahonIMdsIeeO1fpER5P0hUgRIP
	PMKQHSOXbl0DiJ8q90B1Tg==
Received: from webmail.ambarella.com ([12.30.244.130])
	by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 4fq8twhnbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 10:43:52 +0000 (GMT)
Received: from ambtw-mbx5.ambarella.net (10.2.4.226) by
 ambus-ex-se1.ambarella.net (10.1.4.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Thu, 30 Jul 2026 03:43:51 -0700
Received: from ambtw-cas3.ambarella.net (10.2.4.228) by
 ambtw-mbx5.ambarella.net (10.2.4.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 30 Jul 2026 18:43:49 +0800
Received: from shbuild7.ambarella.net (10.4.8.70) by ambtw-cas3.ambarella.net
 (10.2.4.228) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 30 Jul 2026 18:43:48 +0800
From: Long Zhao <longzhao@ambarella.com>
To: Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni
	<alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>, <soc@lists.linux.dev>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        "Michael
 Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        Linus Walleij <linusw@kernel.org>, <linux-gpio@vger.kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, <linux-serial@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <linux-kernel@vger.kernel.org>,
        Long Zhao
	<longzhao@ambarella.com>
Subject: [PATCH 08/10] serial: ambarella: add Ambarella UART driver
Date: Thu, 30 Jul 2026 18:43:28 +0800
Message-ID: <20260730104330.81367-9-longzhao@ambarella.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730104330.81367-1-longzhao@ambarella.com>
References: <20260730104330.81367-1-longzhao@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Proofpoint-GUID: D2ypH8hkxi8ZbtHRbbGTvoVzRgp9kDpW
X-Proofpoint-ORIG-GUID: D2ypH8hkxi8ZbtHRbbGTvoVzRgp9kDpW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA4MCBTYWx0ZWRfXyIqfZmdpLWSe
 8RWqBt5GvnKS+7+UybBZ8000OKVeKyZ+1DnrQwHhnoIjhlsWRDAmsLCSmyn2+t+6KNbT8KotcS4
 u2zl/T0/kuseRs5ClqkglP5rc2Jr2Lkk3I9RpmvrhQd1nvSzZKGYnrIzmWPyzghif98UbzDcCi7
 WNKSeNQbuBygFQWMUAm8YJvRGaw5RagSE+DGf1Nx+Hp1QTwv2wcaHhTdaNsHONAhMGCYSP9lv9y
 6jsTFqNaOi3HzKPS5JdW/oppWyy3y9Chkwkt7WfgQTtIbIiRMYmz9qxPD70ugHGMwDqG38LErSs
 PWS2k+dll+65/F0bf3WA1qdMYnY14jeQnOy5EdpyisC0XLurI9MN/HM2DQxB48Ya9B13Is0JeWm
 vMzxnbdrX3cht6/dmt73FFylwUY6DY946jm5vgh0mVRXqK9mlzZ3Y8yzGGoLJE1zkGn+p3qz6g8
 VfcyK/VlItVUkGPwUZQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA4MCBTYWx0ZWRfX5D32+OHONhg9
 0oJZFbCfUj1CPHC8Mm29Ca4Cs+Mq7oAF2GzA2A8JQNx0Pu9KvXRbEzrDrc6nWBDOm5CfD8FMDko
 8L1PjeNtSinaX7WsswLWapO7WvV+b/UvnrXzQqPJs+B/UyGEzvxZ
X-Authority-Analysis: v=2.4 cv=PNE/P/qC c=1 sm=1 tr=0 ts=6a6b2ae8 cx=c_pps
 a=DgnZYc2JwZ3KnY28M5UqXQ==:117 a=DgnZYc2JwZ3KnY28M5UqXQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yXVIz-0bn9infC194UBj:22
 a=KblO7da7ppA7TBl3N-nE:22 a=ppJngBeKAAAA:8 a=ZEP-G582OeCys1fdM1QA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 malwarescore=0 clxscore=1015
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300080

Add an Ambarella UART driver with console support for early boot
bring-up on CV75. Keep udelay() in wait_for_tx(); it runs under
console/poll paths that may hold the port lock with IRQs disabled.

Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 drivers/tty/serial/Kconfig          |  21 +
 drivers/tty/serial/Makefile         |   1 +
 drivers/tty/serial/ambarella_uart.c | 937 ++++++++++++++++++++++++++++
 3 files changed, 959 insertions(+)
 create mode 100644 drivers/tty/serial/ambarella_uart.c

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index cf7dba473b20..e3f5ec794c72 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -18,6 +18,27 @@ source "drivers/tty/serial/8250/Kconfig"

 comment "Non-8250 serial port support"

+config SERIAL_AMBARELLA
+       bool "Ambarella UART support"
+       depends on ARCH_AMBARELLA || COMPILE_TEST
+       select SERIAL_CORE
+       help
+         Say Y here to enable the on-chip UART controller found on Ambarel=
la
+         SoCs. The driver supports interrupt-driven transmit and receive
+         operation through the serial core. It can also provide a system
+         console when SERIAL_AMBARELLA_CONSOLE is enabled.
+
+config SERIAL_AMBARELLA_CONSOLE
+       bool "Console on Ambarella UART"
+       depends on SERIAL_AMBARELLA
+       select SERIAL_CORE_CONSOLE
+       select SERIAL_EARLYCON
+       help
+         Say Y here to use an Ambarella UART as the system console. This
+         enables both the regular serial console and earlycon support for
+         messages emitted before the full UART driver is initialized.
+         Select this option for early boot diagnostics on Ambarella system=
s.
+
 config SERIAL_AMBA_PL010
        tristate "ARM AMBA PL010 serial port support"
        depends on ARM_AMBA || COMPILE_TEST
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index bba7b21a4a1d..5c951719528b 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -26,6 +26,7 @@ obj-y +=3D 8250/

 obj-$(CONFIG_SERIAL_ALTERA_JTAGUART)   +=3D altera_jtaguart.o
 obj-$(CONFIG_SERIAL_ALTERA_UART)       +=3D altera_uart.o
+obj-$(CONFIG_SERIAL_AMBARELLA)         +=3D ambarella_uart.o
 obj-$(CONFIG_SERIAL_AMBA_PL010)                +=3D amba-pl010.o
 obj-$(CONFIG_SERIAL_AMBA_PL011)                +=3D amba-pl011.o
 obj-$(CONFIG_SERIAL_GRLIB_GAISLER_APBUART) +=3D apbuart.o
diff --git a/drivers/tty/serial/ambarella_uart.c b/drivers/tty/serial/ambar=
ella_uart.c
new file mode 100644
index 000000000000..e79f27c71986
--- /dev/null
+++ b/drivers/tty/serial/ambarella_uart.c
@@ -0,0 +1,937 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/clk.h>
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/serial_reg.h>
+#include <linux/serial_core.h>
+#include <linux/sysrq.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+
+#define UART_RB_OFFSET                 0x00
+#define UART_TH_OFFSET                 0x00
+#define UART_DLL_OFFSET                        0x00
+#define UART_IE_OFFSET                 0x04
+#define UART_DLH_OFFSET                        0x04
+#define UART_II_OFFSET                 0x08
+#define UART_FC_OFFSET                 0x08
+#define UART_LC_OFFSET                 0x0c
+#define UART_MC_OFFSET                 0x10
+#define UART_LS_OFFSET                 0x14
+#define UART_MS_OFFSET                 0x18
+#define UART_US_OFFSET                 0x7c
+#define UART_SRR_OFFSET                        0x88
+
+#define UART_IE_ERETOI                 0x40
+#define UART_IE_ETOI                   0x20
+#define UART_IE_EDSSI                  0x08
+#define UART_IE_ELSI                   0x04
+#define UART_IE_ETBEI                  0x02
+#define UART_IE_ERBFI                  0x01
+
+#define UART_II_MODEM_STATUS_CHANGED   0x00
+#define UART_II_NO_INT_PENDING         0x01
+#define UART_II_THR_EMPTY              0x02
+#define UART_II_RCV_DATA_AVAIL         0x04
+#define UART_II_RCV_STATUS             0x06
+#define UART_II_CHAR_TIMEOUT           0x0c
+#define UART_II_CHAR_TIMEOUT_FIFO_EMPTY        0x0d
+
+#define UART_FC_RX_2_TO_FULL           0xc0
+#define UART_FC_TX_EMPTY               0x00
+#define UART_FC_XMITR                  0x04
+#define UART_FC_RCVRR                  0x02
+#define UART_FC_FIFOE                  0x01
+
+#define UART_LC_DLAB                   0x80
+#define UART_LC_BRK                    0x40
+#define UART_LC_EVEN_PARITY            0x10
+#define UART_LC_ODD_PARITY             0x00
+#define UART_LC_PEN                    0x08
+#define UART_LC_STOP_2BIT              0x04
+#define UART_LC_STOP_1BIT              0x00
+#define UART_LC_CLS_8_BITS             0x03
+#define UART_LC_CLS_7_BITS             0x02
+#define UART_LC_CLS_6_BITS             0x01
+#define UART_LC_CLS_5_BITS             0x00
+
+#define UART_MC_AFCE                   0x20
+#define UART_MC_LB                     0x10
+#define UART_MC_OUT2                   0x08
+#define UART_MC_OUT1                   0x04
+#define UART_MC_RTS                    0x02
+#define UART_MC_DTR                    0x01
+
+#define UART_LS_TEMT                   0x40
+#define UART_LS_THRE                   0x20
+#define UART_LS_BI                     0x10
+#define UART_LS_FE                     0x08
+#define UART_LS_PE                     0x04
+#define UART_LS_OE                     0x02
+#define UART_LS_DR                     0x01
+
+#define UART_MS_DCD                    0x80
+#define UART_MS_RI                     0x40
+#define UART_MS_DSR                    0x20
+#define UART_MS_CTS                    0x10
+#define UART_MS_DDCD                   0x08
+#define UART_MS_DCTS                   0x01
+
+#define UART_US_TFNF                   0x02
+
+#define UART_FIFO_SIZE                 64
+
+#define DEFAULT_AMBARELLA_UART_MCR     0
+#define DEFAULT_AMBARELLA_UART_IER     (UART_IE_ELSI | UART_IE_ERBFI | \
+                                        UART_IE_ETOI)
+
+#define AMBA_UART_MAX_NUM              8
+
+#define AMBA_UART_RESET_FLAG           0 /* bit 0 */
+
+#define AMBARELLA_UART_TIMEOUT         (1000000)
+
+struct ambarella_uart_port {
+       struct uart_port port;
+       struct clk *uart_pll;
+       unsigned long flags;
+       u32 mcr;
+};
+
+static struct ambarella_uart_port ambarella_port[AMBA_UART_MAX_NUM];
+
+static void __serial_ambarella_stop_tx(struct uart_port *port)
+{
+       u32 ier;
+
+       ier =3D readl_relaxed(port->membase + UART_IE_OFFSET);
+       writel_relaxed(ier & ~UART_IE_ETBEI, port->membase + UART_IE_OFFSET=
);
+}
+
+static u32 __serial_ambarella_read_ms(struct uart_port *port)
+{
+       return readl_relaxed(port->membase + UART_MS_OFFSET);
+}
+
+static void __serial_ambarella_enable_ms(struct uart_port *port)
+{
+       u32 ier =3D readl_relaxed(port->membase + UART_IE_OFFSET);
+
+       writel_relaxed(ier | UART_IE_EDSSI, port->membase + UART_IE_OFFSET)=
;
+}
+
+static void __serial_ambarella_disable_ms(struct uart_port *port)
+{
+       u32 ier =3D readl_relaxed(port->membase + UART_IE_OFFSET);
+
+       writel_relaxed(ier & ~UART_IE_EDSSI, port->membase + UART_IE_OFFSET=
);
+}
+
+static inline void wait_for_tx(struct uart_port *port)
+{
+       unsigned int timeout =3D AMBARELLA_UART_TIMEOUT;
+
+       while (timeout &&
+              !(readl(port->membase + UART_LS_OFFSET) & UART_LS_TEMT)) {
+               udelay(1);
+               timeout--;
+       }
+
+       if (unlikely(!timeout)) {
+               writel_relaxed(UART_FC_RX_2_TO_FULL | UART_FC_TX_EMPTY |
+                               UART_FC_XMITR | UART_FC_RCVRR,
+                               port->membase + UART_FC_OFFSET);
+               udelay(100);
+               writel_relaxed(UART_FC_FIFOE | UART_FC_RX_2_TO_FULL |
+                               UART_FC_TX_EMPTY | UART_FC_XMITR |
+                               UART_FC_RCVRR,
+                               port->membase + UART_FC_OFFSET);
+       }
+}
+
+static inline void wait_for_rx(struct uart_port *port)
+{
+       u32 ls;
+
+       ls =3D readl_relaxed(port->membase + UART_LS_OFFSET);
+       while ((ls & UART_LS_DR) !=3D UART_LS_DR) {
+               cpu_relax();
+               ls =3D readl_relaxed(port->membase + UART_LS_OFFSET);
+       }
+}
+
+static inline int tx_fifo_is_full(struct uart_port *port)
+{
+       return !(readl_relaxed(port->membase + UART_US_OFFSET) & UART_US_TF=
NF);
+}
+
+static void serial_ambarella_hw_setup(struct uart_port *port)
+{
+       struct ambarella_uart_port *amb_port;
+
+       amb_port =3D (struct ambarella_uart_port *)(port->private_data);
+
+       if (!test_and_set_bit(AMBA_UART_RESET_FLAG, &amb_port->flags)) {
+               if (amb_port->uart_pll)
+                       port->uartclk =3D clk_get_rate(amb_port->uart_pll);
+               /* reset the whole UART only once */
+               writel_relaxed(0x01, port->membase + UART_SRR_OFFSET);
+               mdelay(1);
+               writel_relaxed(0x00, port->membase + UART_SRR_OFFSET);
+       }
+
+       writel_relaxed(UART_FC_FIFOE | UART_FC_RX_2_TO_FULL | UART_FC_TX_EM=
PTY |
+                       UART_FC_XMITR | UART_FC_RCVRR, port->membase + UART=
_FC_OFFSET);
+       /* Keep interrupts disabled until the IRQ handler is registered. */
+       writel_relaxed(0, port->membase + UART_IE_OFFSET);
+}
+
+static inline void serial_ambarella_receive_chars(struct uart_port *port,
+                                                 u32 tmo)
+{
+       u32 ch, flag, ls;
+       int max_count;
+
+       ls =3D readl_relaxed(port->membase + UART_LS_OFFSET);
+       max_count =3D port->fifosize;
+
+       do {
+               flag =3D TTY_NORMAL;
+               if (unlikely(ls & (UART_LS_BI | UART_LS_PE |
+                                       UART_LS_FE | UART_LS_OE))) {
+                       if (ls & UART_LS_BI) {
+                               ls &=3D ~(UART_LS_FE | UART_LS_PE);
+                               port->icount.brk++;
+
+                               if (uart_handle_break(port))
+                                       goto ignore_char;
+                       }
+                       if (ls & UART_LS_FE)
+                               port->icount.frame++;
+                       if (ls & UART_LS_PE)
+                               port->icount.parity++;
+                       if (ls & UART_LS_OE)
+                               port->icount.overrun++;
+
+                       ls &=3D port->read_status_mask;
+
+                       if (ls & UART_LS_BI)
+                               flag =3D TTY_BREAK;
+                       else if (ls & UART_LS_FE)
+                               flag =3D TTY_FRAME;
+                       else if (ls & UART_LS_PE)
+                               flag =3D TTY_PARITY;
+                       else if (ls & UART_LS_OE)
+                               flag =3D TTY_OVERRUN;
+
+                       if (ls & UART_LS_OE)
+                               pr_debug("%s: OVERFLOW\n", __func__);
+               }
+
+               if (likely(ls & UART_LS_DR)) {
+                       ch =3D readl_relaxed(port->membase + UART_RB_OFFSET=
);
+                       port->icount.rx++;
+                       tmo =3D 0;
+
+                       if (uart_handle_sysrq_char(port, ch))
+                               goto ignore_char;
+
+                       uart_insert_char(port, ls, UART_LS_OE, ch, flag);
+               } else if (tmo) {
+                       ch =3D readl_relaxed(port->membase + UART_RB_OFFSET=
);
+               }
+
+ignore_char:
+               ls =3D readl_relaxed(port->membase + UART_LS_OFFSET);
+       } while ((ls & (UART_LS_DR | UART_LSR_BI)) && (max_count-- > 0));
+
+       tty_flip_buffer_push(&port->state->port);
+}
+
+static void serial_ambarella_transmit_chars(struct uart_port *port)
+{
+       struct tty_port *tport =3D &port->state->port;
+       int count;
+
+       if (port->x_char) {
+               writel_relaxed(port->x_char, port->membase + UART_TH_OFFSET=
);
+               port->icount.tx++;
+               port->x_char =3D 0;
+               return;
+       }
+
+       if (uart_tx_stopped(port) || kfifo_is_empty(&tport->xmit_fifo)) {
+               __serial_ambarella_stop_tx(port);
+               return;
+       }
+
+       count =3D port->fifosize;
+       while (count-- > 0) {
+               unsigned char c;
+
+               if (tx_fifo_is_full(port))
+                       break;
+
+               if (!kfifo_peek(&tport->xmit_fifo, &c))
+                       break;
+
+               writel_relaxed(c, port->membase + UART_TH_OFFSET);
+               kfifo_skip(&tport->xmit_fifo);
+               port->icount.tx++;
+               if (kfifo_is_empty(&tport->xmit_fifo))
+                       break;
+       }
+
+       if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
+               uart_write_wakeup(port);
+       if (kfifo_is_empty(&tport->xmit_fifo))
+               __serial_ambarella_stop_tx(port);
+}
+
+static inline void serial_ambarella_check_modem_status(struct uart_port *p=
ort)
+{
+       u32 ms;
+
+       ms =3D __serial_ambarella_read_ms(port);
+
+       if (ms & UART_MS_RI)
+               port->icount.rng++;
+       if (ms & UART_MS_DSR)
+               port->icount.dsr++;
+       if (ms & UART_MS_DCTS)
+               uart_handle_cts_change(port, (ms & UART_MS_CTS));
+       if (ms & UART_MS_DDCD)
+               uart_handle_dcd_change(port, (ms & UART_MS_DCD));
+
+       wake_up_interruptible(&port->state->port.delta_msr_wait);
+}
+
+static irqreturn_t serial_ambarella_irq(int irq, void *dev_id)
+{
+       struct uart_port *port =3D dev_id;
+       struct ambarella_uart_port *amb_port;
+       unsigned long flags;
+       u32 ii, ier;
+
+       amb_port =3D (struct ambarella_uart_port *)(port->private_data);
+
+       spin_lock_irqsave(&port->lock, flags);
+
+       ii =3D readl_relaxed(port->membase + UART_II_OFFSET);
+       switch (ii & 0x0F) {
+       case UART_II_MODEM_STATUS_CHANGED:
+               serial_ambarella_check_modem_status(port);
+               break;
+       case UART_II_THR_EMPTY:
+               serial_ambarella_transmit_chars(port);
+               break;
+       case UART_II_RCV_STATUS:
+       case UART_II_RCV_DATA_AVAIL:
+               serial_ambarella_receive_chars(port, 0);
+               break;
+       case UART_II_CHAR_TIMEOUT_FIFO_EMPTY:
+               /* Clear ERETOI to dismiss timeout-with-empty-FIFO IRQ */
+               ier =3D readl_relaxed(port->membase + UART_IE_OFFSET);
+               writel_relaxed(ier & ~UART_IE_ERETOI,
+                              amb_port->port.membase + UART_IE_OFFSET);
+               writel_relaxed(ier | UART_IE_ERETOI,
+                              amb_port->port.membase + UART_IE_OFFSET);
+               fallthrough;
+       case UART_II_CHAR_TIMEOUT:
+               serial_ambarella_receive_chars(port, 1);
+               break;
+       case UART_II_NO_INT_PENDING:
+               break;
+       default:
+               pr_debug("%s: 0x%x\n", __func__, ii);
+               break;
+       }
+
+       spin_unlock_irqrestore(&port->lock, flags);
+
+       return IRQ_HANDLED;
+}
+
+static void serial_ambarella_enable_ms(struct uart_port *port)
+{
+       __serial_ambarella_enable_ms(port);
+}
+
+static void serial_ambarella_start_tx(struct uart_port *port)
+{
+       u32 ier;
+
+       /* if transmit buffer is not allocated, just return */
+       if (!port->state->port.xmit_buf)
+               return;
+
+       ier =3D readl_relaxed(port->membase + UART_IE_OFFSET);
+       writel_relaxed(ier | UART_IE_ETBEI, port->membase + UART_IE_OFFSET)=
;
+
+       serial_ambarella_transmit_chars(port);
+}
+
+static void serial_ambarella_stop_tx(struct uart_port *port)
+{
+       __serial_ambarella_stop_tx(port);
+}
+
+static void serial_ambarella_stop_rx(struct uart_port *port)
+{
+       u32 ier;
+
+       ier =3D readl_relaxed(port->membase + UART_IE_OFFSET);
+       writel_relaxed(ier & ~UART_IE_ERBFI, port->membase + UART_IE_OFFSET=
);
+}
+
+static unsigned int serial_ambarella_tx_empty(struct uart_port *port)
+{
+       unsigned int lsr;
+       unsigned long flags;
+
+       spin_lock_irqsave(&port->lock, flags);
+       lsr =3D readl_relaxed(port->membase + UART_LS_OFFSET);
+       spin_unlock_irqrestore(&port->lock, flags);
+
+       return ((lsr & (UART_LS_TEMT | UART_LS_THRE)) =3D=3D
+               (UART_LS_TEMT | UART_LS_THRE)) ? TIOCSER_TEMT : 0;
+}
+
+static unsigned int serial_ambarella_get_mctrl(struct uart_port *port)
+{
+       u32 ms, mctrl =3D 0;
+
+       ms =3D __serial_ambarella_read_ms(port);
+
+       if (ms & UART_MS_CTS)
+               mctrl |=3D TIOCM_CTS;
+       if (ms & UART_MS_DSR)
+               mctrl |=3D TIOCM_DSR;
+       if (ms & UART_MS_RI)
+               mctrl |=3D TIOCM_RI;
+       if (ms & UART_MS_DCD)
+               mctrl |=3D TIOCM_CD;
+
+       return mctrl;
+}
+
+static void serial_ambarella_set_mctrl(struct uart_port *port,
+                                      unsigned int mctrl)
+{
+       struct ambarella_uart_port *amb_port;
+       u32 mcr, mcr_new =3D 0;
+
+       amb_port =3D (struct ambarella_uart_port *)(port->private_data);
+
+       mcr =3D readl_relaxed(port->membase + UART_MC_OFFSET);
+
+       if (mctrl & TIOCM_DTR)
+               mcr_new |=3D UART_MC_DTR;
+       if (mctrl & TIOCM_RTS)
+               mcr_new |=3D UART_MC_RTS;
+       if (mctrl & TIOCM_OUT1)
+               mcr_new |=3D UART_MC_OUT1;
+       if (mctrl & TIOCM_OUT2)
+               mcr_new |=3D UART_MC_OUT2;
+       if (mctrl & TIOCM_LOOP)
+               mcr_new |=3D UART_MC_LB;
+
+       mcr_new |=3D amb_port->mcr;
+       if (mcr_new !=3D mcr) {
+               if ((mcr & UART_MC_AFCE) =3D=3D UART_MC_AFCE) {
+                       mcr &=3D ~UART_MC_AFCE;
+                       writel_relaxed(mcr, port->membase + UART_MC_OFFSET)=
;
+               }
+               writel_relaxed(mcr_new, port->membase + UART_MC_OFFSET);
+       }
+}
+
+static void serial_ambarella_break_ctl(struct uart_port *port, int break_s=
tate)
+{
+       u32 lcr =3D readl_relaxed(port->membase + UART_LC_OFFSET);
+       unsigned long flags;
+
+       spin_lock_irqsave(&port->lock, flags);
+       if (break_state !=3D 0)
+               writel_relaxed(lcr | UART_LC_BRK, port->membase + UART_LC_O=
FFSET);
+       else
+               writel_relaxed(lcr & ~UART_LC_BRK, port->membase + UART_LC_=
OFFSET);
+       spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static void serial_ambarella_hw_deinit(struct ambarella_uart_port *amb_por=
t)
+{
+       struct uart_port *port =3D &amb_port->port;
+
+       /* Disable interrupts */
+       writel_relaxed(0, port->membase + UART_IE_OFFSET);
+
+       /* Reset the Rx and Tx FIFOs */
+       writel_relaxed(UART_FCR_CLEAR_XMIT | UART_FCR_CLEAR_RCVR,
+                      port->membase + UART_SRR_OFFSET);
+}
+
+static int serial_ambarella_startup(struct uart_port *port)
+{
+       int rval;
+       struct ambarella_uart_port *amb_port;
+
+       amb_port =3D (struct ambarella_uart_port *)(port->private_data);
+
+       serial_ambarella_hw_setup(port);
+
+       rval =3D request_irq(port->irq, serial_ambarella_irq, IRQF_TRIGGER_=
HIGH,
+                          dev_name(amb_port->port.dev), &amb_port->port);
+       if (rval < 0) {
+               dev_err(amb_port->port.dev,
+                       "Failed to register ISR for IRQ %d\n", port->irq);
+               serial_ambarella_hw_deinit(amb_port);
+               return rval;
+       }
+
+       writel_relaxed(DEFAULT_AMBARELLA_UART_IER,
+                      port->membase + UART_IE_OFFSET);
+
+       return 0;
+}
+
+static void serial_ambarella_shutdown(struct uart_port *port)
+{
+       struct ambarella_uart_port *amb_port;
+       u32 lcr;
+       unsigned long flags;
+
+       amb_port =3D (struct ambarella_uart_port *)(port->private_data);
+
+       spin_lock_irqsave(&port->lock, flags);
+       serial_ambarella_hw_deinit(amb_port);
+       lcr =3D readl_relaxed(port->membase + UART_LC_OFFSET);
+       writel_relaxed(lcr & ~UART_LC_BRK, port->membase + UART_LC_OFFSET);
+       spin_unlock_irqrestore(&port->lock, flags);
+
+       free_irq(amb_port->port.irq, &amb_port->port);
+}
+
+static void serial_ambarella_set_termios(struct uart_port *port,
+                                        struct ktermios *termios,
+                                        const struct ktermios *old)
+{
+       struct ambarella_uart_port *amb_port;
+       unsigned int baud, quot;
+       unsigned long flags;
+       u32 lc =3D 0x0;
+
+       amb_port =3D (struct ambarella_uart_port *)(port->private_data);
+
+       port->uartclk =3D clk_get_rate(amb_port->uart_pll);
+       switch (termios->c_cflag & CSIZE) {
+       case CS5:
+               lc |=3D UART_LC_CLS_5_BITS;
+               break;
+       case CS6:
+               lc |=3D UART_LC_CLS_6_BITS;
+               break;
+       case CS7:
+               lc |=3D UART_LC_CLS_7_BITS;
+               break;
+       case CS8:
+       default:
+               lc |=3D UART_LC_CLS_8_BITS;
+               break;
+       }
+
+       if (termios->c_cflag & CSTOPB)
+               lc |=3D UART_LC_STOP_2BIT;
+       else
+               lc |=3D UART_LC_STOP_1BIT;
+
+       if (termios->c_cflag & PARENB) {
+               if (termios->c_cflag & PARODD)
+                       lc |=3D (UART_LC_PEN | UART_LC_ODD_PARITY);
+               else
+                       lc |=3D (UART_LC_PEN | UART_LC_EVEN_PARITY);
+       }
+
+       baud =3D uart_get_baud_rate(port, termios, old, 0, port->uartclk / =
16);
+       quot =3D uart_get_divisor(port, baud);
+
+       spin_lock_irqsave(&port->lock, flags);
+       uart_update_timeout(port, termios->c_cflag, baud);
+
+       port->read_status_mask =3D UART_LSR_OE | UART_LSR_THRE | UART_LSR_D=
R;
+       if (termios->c_iflag & INPCK)
+               port->read_status_mask |=3D UART_LSR_FE | UART_LSR_PE;
+       if (termios->c_iflag & (BRKINT | PARMRK))
+               port->read_status_mask |=3D UART_LSR_BI;
+
+       port->ignore_status_mask =3D 0;
+       if (termios->c_iflag & IGNPAR)
+               port->ignore_status_mask |=3D UART_LSR_PE | UART_LSR_FE;
+       if (termios->c_iflag & IGNBRK) {
+               port->ignore_status_mask |=3D UART_LSR_BI;
+               if (termios->c_iflag & IGNPAR)
+                       port->ignore_status_mask |=3D UART_LSR_OE;
+       }
+       if ((termios->c_cflag & CREAD) =3D=3D 0)
+               port->ignore_status_mask |=3D UART_LSR_DR;
+
+       if ((termios->c_cflag & CRTSCTS) =3D=3D 0) {
+               amb_port->mcr &=3D ~UART_MC_AFCE;
+               port->status &=3D ~UPSTAT_AUTOCTS;
+       } else {
+               amb_port->mcr |=3D UART_MC_AFCE;
+               port->status |=3D UPSTAT_AUTOCTS;
+       }
+
+       writel_relaxed(UART_LC_DLAB, port->membase + UART_LC_OFFSET);
+       writel_relaxed(quot & 0xff, port->membase + UART_DLL_OFFSET);
+       writel_relaxed((quot >> 8) & 0xff, port->membase + UART_DLH_OFFSET)=
;
+       writel_relaxed(lc, port->membase + UART_LC_OFFSET);
+       if (UART_ENABLE_MS(port, termios->c_cflag))
+               __serial_ambarella_enable_ms(port);
+       else
+               __serial_ambarella_disable_ms(port);
+       serial_ambarella_set_mctrl(port, port->mctrl);
+
+       spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static void serial_ambarella_pm(struct uart_port *port,
+                               unsigned int state, unsigned int oldstate)
+{
+}
+
+static void serial_ambarella_release_port(struct uart_port *port)
+{
+}
+
+static int serial_ambarella_request_port(struct uart_port *port)
+{
+       return 0;
+}
+
+static void serial_ambarella_config_port(struct uart_port *port, int flags=
)
+{
+}
+
+static int serial_ambarella_verify_port(struct uart_port *port,
+                                       struct serial_struct *ser)
+{
+       int rval =3D 0;
+
+       if (ser->type !=3D PORT_UNKNOWN && ser->type !=3D PORT_UART00)
+               rval =3D -EINVAL;
+       if (port->irq !=3D ser->irq)
+               rval =3D -EINVAL;
+       if (ser->io_type !=3D SERIAL_IO_MEM)
+               rval =3D -EINVAL;
+
+       return rval;
+}
+
+static const char *serial_ambarella_type(struct uart_port *port)
+{
+       return "ambuart";
+}
+
+#ifdef CONFIG_CONSOLE_POLL
+static void serial_ambarella_poll_put_char(struct uart_port *port,
+                                          unsigned char chr)
+{
+       if (!port->suspended) {
+               wait_for_tx(port);
+               writel_relaxed(chr, port->membase + UART_TH_OFFSET);
+       }
+}
+
+static int serial_ambarella_poll_get_char(struct uart_port *port)
+{
+       if (!port->suspended) {
+               wait_for_rx(port);
+               return readl_relaxed(port->membase + UART_RB_OFFSET);
+       }
+       return 0;
+}
+#endif
+
+static const struct uart_ops serial_ambarella_pops =3D {
+       .tx_empty       =3D serial_ambarella_tx_empty,
+       .set_mctrl      =3D serial_ambarella_set_mctrl,
+       .get_mctrl      =3D serial_ambarella_get_mctrl,
+       .stop_tx        =3D serial_ambarella_stop_tx,
+       .start_tx       =3D serial_ambarella_start_tx,
+       .stop_rx        =3D serial_ambarella_stop_rx,
+       .enable_ms      =3D serial_ambarella_enable_ms,
+       .break_ctl      =3D serial_ambarella_break_ctl,
+       .startup        =3D serial_ambarella_startup,
+       .shutdown       =3D serial_ambarella_shutdown,
+       .set_termios    =3D serial_ambarella_set_termios,
+       .pm             =3D serial_ambarella_pm,
+       .type           =3D serial_ambarella_type,
+       .release_port   =3D serial_ambarella_release_port,
+       .request_port   =3D serial_ambarella_request_port,
+       .config_port    =3D serial_ambarella_config_port,
+       .verify_port    =3D serial_ambarella_verify_port,
+#ifdef CONFIG_CONSOLE_POLL
+       .poll_put_char  =3D serial_ambarella_poll_put_char,
+       .poll_get_char  =3D serial_ambarella_poll_get_char,
+#endif
+};
+
+#if defined(CONFIG_SERIAL_AMBARELLA_CONSOLE)
+
+static struct uart_driver serial_ambarella_reg;
+
+static void serial_ambarella_console_putchar(struct uart_port *port,
+                                            unsigned char ch)
+{
+       wait_for_tx(port);
+       writel_relaxed(ch, port->membase + UART_TH_OFFSET);
+}
+
+static void serial_ambarella_console_write(struct console *co,
+                                          const char *s, unsigned int coun=
t)
+{
+       struct uart_port *port;
+       int locked =3D 1;
+       unsigned long flags;
+
+       port =3D &ambarella_port[co->index].port;
+
+       if (!port->suspended) {
+               if (port->sysrq)
+                       locked =3D 0;
+               else if (oops_in_progress)
+                       locked =3D uart_port_trylock_irqsave(port, &flags);
+               else
+                       uart_port_lock_irqsave(port, &flags);
+
+               uart_console_write(port, s, count,
+                                  serial_ambarella_console_putchar);
+               wait_for_tx(port);
+
+               if (locked)
+                       uart_port_unlock_irqrestore(port, flags);
+       }
+}
+
+static int __init serial_ambarella_console_setup(struct console *co,
+                                                char *options)
+{
+       struct uart_port *port;
+       int baud =3D 115200, bits =3D 8, parity =3D 'n', flow =3D 'n';
+
+       if (co->index < 0 || co->index >=3D serial_ambarella_reg.nr)
+               co->index =3D 0;
+
+       port =3D &ambarella_port[co->index].port;
+       if (!port->membase) {
+               pr_err("No device available for serial console\n");
+               return -ENODEV;
+       }
+
+       port->ops =3D &serial_ambarella_pops;
+       port->private_data =3D &ambarella_port[co->index];
+       port->line =3D co->index;
+
+       serial_ambarella_hw_setup(port);
+
+       if (options)
+               uart_parse_options(options, &baud, &parity, &bits, &flow);
+
+       return uart_set_options(port, co, baud, parity, bits, flow);
+}
+
+static struct console serial_ambarella_console =3D {
+       .name           =3D "ttyAB",
+       .write          =3D serial_ambarella_console_write,
+       .device         =3D uart_console_device,
+       .setup          =3D serial_ambarella_console_setup,
+       .flags          =3D CON_PRINTBUFFER | CON_ANYTIME,
+       .index          =3D -1,
+       .data           =3D &serial_ambarella_reg,
+};
+
+static void serial_ambarella_console_early_write(struct console *con,
+                                                const char *s,
+                                                unsigned int count)
+{
+       struct earlycon_device *dev =3D con->data;
+
+       uart_console_write(&dev->port, s, count, serial_ambarella_console_p=
utchar);
+}
+
+static int __init serial_ambarella_console_early_setup(struct earlycon_dev=
ice *dev,
+                                                      const char *opt)
+{
+       if (!dev->port.membase)
+               return -ENODEV;
+
+       dev->con->write =3D serial_ambarella_console_early_write;
+
+       return 0;
+}
+
+OF_EARLYCON_DECLARE(ambarella_uart, "ambarella,uart", serial_ambarella_con=
sole_early_setup);
+
+#define AMBARELLA_CONSOLE      (&serial_ambarella_console)
+#else
+#define AMBARELLA_CONSOLE      NULL
+#endif
+
+static struct uart_driver serial_ambarella_reg =3D {
+       .owner          =3D THIS_MODULE,
+       .driver_name    =3D "ambarella-uart",
+       .dev_name       =3D "ttyAB",
+       .major          =3D 0,
+       .minor          =3D 0,
+       .nr             =3D AMBA_UART_MAX_NUM,
+       .cons           =3D AMBARELLA_CONSOLE,
+};
+
+static int serial_ambarella_probe(struct platform_device *pdev)
+{
+       struct ambarella_uart_port *amb_port;
+       struct resource *mem;
+       struct pinctrl *pinctrl;
+       int irq, id, rval;
+
+       mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+       if (!mem) {
+               dev_err(&pdev->dev, "no mem resource!\n");
+               return -ENODEV;
+       }
+
+       irq =3D platform_get_irq(pdev, 0);
+       if (irq < 0) {
+               dev_err(&pdev->dev, "no irq resource!\n");
+               return -ENODEV;
+       }
+
+       id =3D of_alias_get_id(pdev->dev.of_node, "serial");
+       if (id < 0 || id >=3D serial_ambarella_reg.nr) {
+               dev_err(&pdev->dev, "Invalid uart ID %d!\n", id);
+               return -ENXIO;
+       }
+
+       pinctrl =3D devm_pinctrl_get_select_default(&pdev->dev);
+       if (IS_ERR(pinctrl)) {
+               dev_err(&pdev->dev, "Failed to request pinctrl\n");
+               return PTR_ERR(pinctrl);
+       }
+
+       amb_port =3D &ambarella_port[id];
+
+       amb_port->uart_pll =3D devm_clk_get_enabled(&pdev->dev, NULL);
+       if (IS_ERR(amb_port->uart_pll)) {
+               dev_err(&pdev->dev, "Get uart clk failed!\n");
+               return PTR_ERR(amb_port->uart_pll);
+       }
+
+       amb_port->mcr =3D DEFAULT_AMBARELLA_UART_MCR;
+
+       amb_port->port.dev =3D &pdev->dev;
+       amb_port->port.type =3D PORT_UART00;
+       amb_port->port.iotype =3D UPIO_MEM;
+       amb_port->port.fifosize =3D UART_FIFO_SIZE;
+       amb_port->port.uartclk =3D clk_get_rate(amb_port->uart_pll);
+       amb_port->port.ops =3D &serial_ambarella_pops;
+       amb_port->port.private_data =3D amb_port;
+       amb_port->port.irq =3D irq;
+       amb_port->port.line =3D id;
+       amb_port->port.mapbase =3D mem->start;
+       amb_port->port.membase =3D devm_ioremap_resource(&pdev->dev, mem);
+       if (IS_ERR(amb_port->port.membase))
+               return PTR_ERR(amb_port->port.membase);
+
+       rval =3D uart_add_one_port(&serial_ambarella_reg, &amb_port->port);
+       if (rval < 0)
+               dev_err(&pdev->dev, "failed to add port: %d, %d!\n", id, rv=
al);
+
+       platform_set_drvdata(pdev, amb_port);
+
+       return rval;
+}
+
+static void serial_ambarella_remove(struct platform_device *pdev)
+{
+       struct ambarella_uart_port *amb_port;
+
+       amb_port =3D platform_get_drvdata(pdev);
+       uart_remove_one_port(&serial_ambarella_reg, &amb_port->port);
+}
+
+static int serial_ambarella_suspend(struct device *dev)
+{
+       struct ambarella_uart_port *amb_port =3D dev_get_drvdata(dev);
+
+       return uart_suspend_port(&serial_ambarella_reg, &amb_port->port);
+}
+
+static int serial_ambarella_resume(struct device *dev)
+{
+       struct ambarella_uart_port *amb_port =3D dev_get_drvdata(dev);
+
+       clear_bit(AMBA_UART_RESET_FLAG, &amb_port->flags);
+       serial_ambarella_hw_setup(&amb_port->port);
+
+       return uart_resume_port(&serial_ambarella_reg, &amb_port->port);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(serial_ambarella_pm_ops,
+                               serial_ambarella_suspend,
+                               serial_ambarella_resume);
+
+static const struct of_device_id ambarella_serial_of_match[] =3D {
+       { .compatible =3D "ambarella,cv75-uart" },
+       { .compatible =3D "ambarella,uart" },
+       {},
+};
+MODULE_DEVICE_TABLE(of, ambarella_serial_of_match);
+
+static struct platform_driver serial_ambarella_driver =3D {
+       .probe          =3D serial_ambarella_probe,
+       .remove         =3D serial_ambarella_remove,
+       .driver         =3D {
+               .name   =3D "ambarella-uart",
+               .of_match_table =3D ambarella_serial_of_match,
+               .pm =3D pm_sleep_ptr(&serial_ambarella_pm_ops),
+       },
+};
+
+static int __init serial_ambarella_init(void)
+{
+       int rval;
+
+       rval =3D uart_register_driver(&serial_ambarella_reg);
+       if (rval < 0)
+               return rval;
+
+       rval =3D platform_driver_register(&serial_ambarella_driver);
+       if (rval < 0) {
+               uart_unregister_driver(&serial_ambarella_reg);
+               return rval;
+       }
+
+       return 0;
+}
+
+static void __exit serial_ambarella_exit(void)
+{
+       platform_driver_unregister(&serial_ambarella_driver);
+       uart_unregister_driver(&serial_ambarella_reg);
+}
+
+module_init(serial_ambarella_init);
+module_exit(serial_ambarella_exit);
+
+MODULE_DESCRIPTION("Ambarella UART driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:ambarella-uart");
--
2.34.1

NOTE: This email (including attachments) contain Ambarella Proprietary and/=
or Confidential Information and is intended solely for the use of the indiv=
idual(s) to whom it is addressed. Any unauthorized review, use, disclosure,=
 distribute, copy, or print is prohibited. If you are not an intended recip=
ient, please contact the sender by reply email and destroy all copies of th=
e original message. Thank you.
