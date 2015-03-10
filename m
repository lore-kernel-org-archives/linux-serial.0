From: Dmitry Torokhov <dtor@chromium.org>
Subject: [PATCH] serial: 8250_dw: fix 'cts-override'
Date: Mon, 9 Mar 2015 17:37:31 -0700
Message-ID: <20150310003731.GA21791@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kevin Cernekee <cernekee@chromium.org>, "JD (Jiandong) Zheng" <jdzheng@broadcom.com>, Ray Jui <rjui@broadcom.com>, Desmond Liu <desmondl@broadcom.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

We are dealing with CTS, not DSR here (we dealt with DSR a few lines
above), so set appropriate bits.

Reported-by: Kevin Cernekee <cernekee@chromium.org>
Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
---
 drivers/tty/serial/8250/8250_dw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 2ab229d..eb0a511 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -355,9 +355,9 @@ static int dw8250_probe_of(struct uart_port *p,
 	}
 
 	if (of_property_read_bool(np, "cts-override")) {
-		/* Always report DSR as active */
-		data->msr_mask_on |= UART_MSR_DSR;
-		data->msr_mask_off |= UART_MSR_DDSR;
+		/* Always report CTS as active */
+		data->msr_mask_on |= UART_MSR_CTS;
+		data->msr_mask_off |= UART_MSR_DCTS;
 	}
 
 	if (of_property_read_bool(np, "ri-override")) {
-- 
2.2.0.rc0.207.ga3a616c


-- 
Dmitry
