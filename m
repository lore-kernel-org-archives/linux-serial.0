From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 040/123] serial: 8250_pxa: honor the port number from devicetree
Date: Wed, 27 Mar 2019 14:15:04 -0400
Message-ID: <20190327181628.15899-40-sashal@kernel.org>
References: <20190327181628.15899-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327181628.15899-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Lubomir Rintel <lkundrak@v3.sk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Lubomir Rintel <lkundrak@v3.sk>

[ Upstream commit fe9ed6d2483fda55465f32924fb15bce0fac3fac ]

Like the other OF-enabled drivers, use the port number from the firmware if
the devicetree specifies an alias:

  aliases {
      ...
      serial2 = &uart2; /* Should be ttyS2 */
  }

This is how the deprecated pxa.c driver behaved, switching to 8250_pxa
messes up the numbering.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_pxa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pxa.c b/drivers/tty/serial/8250/8250_pxa.c
index 4d68731af534..de1372ba24b1 100644
--- a/drivers/tty/serial/8250/8250_pxa.c
+++ b/drivers/tty/serial/8250/8250_pxa.c
@@ -118,6 +118,10 @@ static int serial_pxa_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = of_alias_get_id(pdev->dev.of_node, "serial");
+	if (ret >= 0)
+		uart.port.line = ret;
+
 	uart.port.type = PORT_XSCALE;
 	uart.port.iotype = UPIO_MEM32;
 	uart.port.mapbase = mmres->start;
-- 
2.19.1
