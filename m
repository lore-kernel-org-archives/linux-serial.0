From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] msm_serial: add missing iounmap() on error in msm_request_port()
Date: Wed, 17 Jul 2013 13:34:09 +0800
Message-ID: <CAPgLHd_LGRtkqcPbm=snHOsFOzX6vfafw3EnZtcJmDGCHKHq=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: davidb@codeaurora.org, dwalker@fifo99.com, bryanh@codeaurora.org, gregkh@linuxfoundation.org, jslaby@suse.cz, grant.likely@linaro.org, rob.herring@calxeda.com
Cc: yongjun_wei@trendmicro.com.cn, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add the missing iounmap() before return from msm_request_port()
in the error handling case.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/tty/serial/msm_serial.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 2c6cfb3..0b38b28 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -637,7 +637,7 @@ static int msm_request_port(struct uart_port *port)
 		if (!request_mem_region(gsbi_resource->start, size,
 						 "msm_serial")) {
 			ret = -EBUSY;
-			goto fail_release_port;
+			goto fail_release_port_membase;
 		}
 
 		msm_port->gsbi_base = ioremap(gsbi_resource->start, size);
@@ -651,6 +651,8 @@ static int msm_request_port(struct uart_port *port)
 
 fail_release_gsbi:
 	release_mem_region(gsbi_resource->start, size);
+fail_release_port_membase:
+	iounmap(port->membase);
 fail_release_port:
 	release_mem_region(port->mapbase, size);
 	return ret;
