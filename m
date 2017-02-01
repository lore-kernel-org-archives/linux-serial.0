From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2 05/10] serial: st-asc: Use generic DT binding for announcing RTS/CTS lines
Date: Wed,  1 Feb 2017 14:31:40 +0000
Message-ID: <20170201143145.31962-6-lee.jones@linaro.org>
References: <20170201143145.31962-1-lee.jones@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170201143145.31962-1-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

The initial binding 'st,hw-flow-control' isn't used anywhere, in neither
in upstream nor downstream kernels.  It isn't even documented in
dt-bindings, so we can safely assume it's safe to swap to the generic
one.

Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/tty/serial/st-asc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index e521078..bcf1d33 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -794,7 +794,7 @@ static struct asc_port *asc_of_get_asc_port(struct platform_device *pdev)
 		return NULL;
 
 	asc_ports[id].hw_flow_control = of_property_read_bool(np,
-							"st,hw-flow-control");
+							"uart-has-rtscts");
 	asc_ports[id].force_m1 =  of_property_read_bool(np, "st,force_m1");
 	asc_ports[id].port.line = id;
 	asc_ports[id].rts = NULL;
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
