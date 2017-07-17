From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] serial: st-asc: Potential error pointer dereference
Date: Mon, 17 Jul 2017 11:12:38 +0300
Message-ID: <20170717081238.bjjp5vvzq56yv2q3@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Patrice Chotard <patrice.chotard@st.com>, Lee Jones <lee.jones@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

It looks like we intended to return an error code here, because we
dereference "ascport->pinctrl" on the next lines.

Fixes: 6929cb00a501 ("serial: st-asc: Read in all Pinctrl states")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index f5335be344f6..6b0ca65027d0 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -758,6 +758,7 @@ static int asc_init_port(struct asc_port *ascport,
 	if (IS_ERR(ascport->pinctrl)) {
 		ret = PTR_ERR(ascport->pinctrl);
 		dev_err(&pdev->dev, "Failed to get Pinctrl: %d\n", ret);
+		return ret;
 	}
 
 	ascport->states[DEFAULT] =
