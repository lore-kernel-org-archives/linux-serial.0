Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF810C83016
	for <linux-serial@archiver.kernel.org>; Wed,  2 Dec 2020 11:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EC6220709
	for <linux-serial@archiver.kernel.org>; Wed,  2 Dec 2020 11:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbgLBLki (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 2 Dec 2020 06:40:38 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40703 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbgLBLke (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 2 Dec 2020 06:40:34 -0500
Received: by mail-lj1-f195.google.com with SMTP id y10so3201837ljc.7;
        Wed, 02 Dec 2020 03:40:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eioTLuh9qMD02dGo7kd70kPRax33tNEMYOnayXuoEQw=;
        b=JEsJTJ7HgMwoalHv+9t1mJQEvFR4miRs3ZN18+Nw6D6dtop7N9eADkj7H4yBmAUVKM
         x0beFwZF+eWhmPkM6F1SV46Xy6Yw0pRx743I2VdztlMYeyj5icGuDsnNUSSciwjvV+CU
         6dxT1schanz48ryV1YZ+8hksR13hJcwLOp33tuAcLdgnuP7vfXeHOtgs1blVjKxpQmKT
         fL6NBKO15XO/TgcCLFuiZR7NS4MkCWkR6xYCwJ6aUotcogaZjMTN9smBMbpyBDqRHNUM
         4sgDV/hPL6A9/C9OVaMyZFx53EeFz3sS+1AMjkeKuieKulck/aAVN2ucMwQBiyUgqDzn
         WdXA==
X-Gm-Message-State: AOAM533bZtshmcVRQCqC9IEn4Li+og7BO2AMJgdaIV3zBcvxQ8FLZCjF
        DegyYPB8sXL4TxvCO/uOaW9FRbju0ApjAg==
X-Google-Smtp-Source: ABdhPJz5D+PQ6DzPdL9r9JsL4vg/TaoTkfaha5it7UuZ/g1kY3PSanEghj7QtwQsdePnLdQX45iFlw==
X-Received: by 2002:a05:651c:3cf:: with SMTP id f15mr980595ljp.118.1606909191641;
        Wed, 02 Dec 2020 03:39:51 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id a11sm403184ljp.21.2020.12.02.03.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 03:39:49 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1kkQUd-00073D-52; Wed, 02 Dec 2020 12:40:19 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 6/7] USB: serial: ftdi_sio: pass port to quirk port_probe functions
Date:   Wed,  2 Dec 2020 12:39:41 +0100
Message-Id: <20201202113942.27024-7-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201202113942.27024-1-johan@kernel.org>
References: <20201202113942.27024-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: "Mychaela N. Falconia" <falcon@freecalypso.org>

The original code passed only the pointer to the ftdi_private struct
to quirk port_probe functions.  However, some quirks may need to be
applied conditionally only to some channels of a multichannel FT2232x
or FT4232H device, and if a given quirk's port_probe function needs
to figure out which channel of a multichannel device is currently
being considered, it needs access to the port pointer passed to the
ftdi_sio_port_probe() function, so it can traverse USB data structures
from there.

Signed-off-by: Mychaela N. Falconia <falcon@freecalypso.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index e0f4c3d9649c..b69032c9ec2b 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -88,15 +88,15 @@ struct ftdi_private {
 struct ftdi_sio_quirk {
 	int (*probe)(struct usb_serial *);
 	/* Special settings for probed ports. */
-	void (*port_probe)(struct ftdi_private *);
+	void (*port_probe)(struct usb_serial_port *);
 };
 
 static int   ftdi_jtag_probe(struct usb_serial *serial);
 static int   ftdi_NDI_device_setup(struct usb_serial *serial);
 static int   ftdi_stmclite_probe(struct usb_serial *serial);
 static int   ftdi_8u2232c_probe(struct usb_serial *serial);
-static void  ftdi_USB_UIRT_setup(struct ftdi_private *priv);
-static void  ftdi_HE_TIRA1_setup(struct ftdi_private *priv);
+static void  ftdi_USB_UIRT_setup(struct usb_serial_port *port);
+static void  ftdi_HE_TIRA1_setup(struct usb_serial_port *port);
 
 static const struct ftdi_sio_quirk ftdi_jtag_quirk = {
 	.probe	= ftdi_jtag_probe,
@@ -2252,11 +2252,11 @@ static int ftdi_sio_port_probe(struct usb_serial_port *port)
 
 	mutex_init(&priv->cfg_lock);
 
-	if (quirk && quirk->port_probe)
-		quirk->port_probe(priv);
-
 	usb_set_serial_port_data(port, priv);
 
+	if (quirk && quirk->port_probe)
+		quirk->port_probe(port);
+
 	ftdi_determine_type(port);
 	ftdi_set_max_packet_size(port);
 	if (read_latency_timer(port) < 0)
@@ -2277,8 +2277,10 @@ static int ftdi_sio_port_probe(struct usb_serial_port *port)
 /* Setup for the USB-UIRT device, which requires hardwired
  * baudrate (38400 gets mapped to 312500) */
 /* Called from usbserial:serial_probe */
-static void ftdi_USB_UIRT_setup(struct ftdi_private *priv)
+static void ftdi_USB_UIRT_setup(struct usb_serial_port *port)
 {
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+
 	priv->flags |= ASYNC_SPD_CUST;
 	priv->custom_divisor = 77;
 	priv->force_baud = 38400;
@@ -2287,8 +2289,10 @@ static void ftdi_USB_UIRT_setup(struct ftdi_private *priv)
 /* Setup for the HE-TIRA1 device, which requires hardwired
  * baudrate (38400 gets mapped to 100000) and RTS-CTS enabled.  */
 
-static void ftdi_HE_TIRA1_setup(struct ftdi_private *priv)
+static void ftdi_HE_TIRA1_setup(struct usb_serial_port *port)
 {
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+
 	priv->flags |= ASYNC_SPD_CUST;
 	priv->custom_divisor = 240;
 	priv->force_baud = 38400;
-- 
2.26.2

