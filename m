From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: [PATCH] mct_u232: Fix incorrect TIOCMSET return
Date: Tue, 22 May 2012 20:45:13 +0100
Message-ID: <20120522194508.16448.68332.stgit@bluebook>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org
List-Id: linux-serial@vger.kernel.org

From: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

The low level helper returns 1 on success. The ioctl should however return
0. As this is the only user of the helper return, make the helper return 0 or
an error code.

Resolves-bug: https://bugzilla.kernel.org/show_bug.cgi?id=43009
Signed-off-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---

 drivers/usb/serial/mct_u232.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/serial/mct_u232.c b/drivers/usb/serial/mct_u232.c
index d0ec1aa..a71fa0a 100644
--- a/drivers/usb/serial/mct_u232.c
+++ b/drivers/usb/serial/mct_u232.c
@@ -309,13 +309,16 @@ static int mct_u232_set_modem_ctrl(struct usb_serial *serial,
 			MCT_U232_SET_REQUEST_TYPE,
 			0, 0, buf, MCT_U232_SET_MODEM_CTRL_SIZE,
 			WDR_TIMEOUT);
-	if (rc < 0)
-		dev_err(&serial->dev->dev,
-			"Set MODEM CTRL 0x%x failed (error = %d)\n", mcr, rc);
+	kfree(buf);
+
 	dbg("set_modem_ctrl: state=0x%x ==> mcr=0x%x", control_state, mcr);
 
-	kfree(buf);
-	return rc;
+	if (rc < 0) {
+		dev_err(&serial->dev->dev,
+			"Set MODEM CTRL 0x%x failed (error = %d)\n", mcr, rc);
+		return rc;
+	}
+	return 0;
 } /* mct_u232_set_modem_ctrl */
 
 static int mct_u232_get_modem_stat(struct usb_serial *serial,

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
