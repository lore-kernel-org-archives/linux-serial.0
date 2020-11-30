Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733F1C83017
	for <linux-serial@archiver.kernel.org>; Mon, 30 Nov 2020 15:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40C772076C
	for <linux-serial@archiver.kernel.org>; Mon, 30 Nov 2020 15:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgK3Pim (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 30 Nov 2020 10:38:42 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33486 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbgK3Pii (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 30 Nov 2020 10:38:38 -0500
Received: by mail-lj1-f196.google.com with SMTP id t22so18610508ljk.0;
        Mon, 30 Nov 2020 07:38:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eioTLuh9qMD02dGo7kd70kPRax33tNEMYOnayXuoEQw=;
        b=MZRcP0uFRJPXYR+eOx0ZLiNY+2EjfHoTpTtUkWs8NmEPlgiGVKTiQlqTyWfLONnjhx
         OwMd/tU66zPHsjvLKKKIWZadNCGhXFOd8YHi/nWeT84TlqZ+tT973EZfOpZGD6o/r4mB
         RgwUm48twv/qs4t5+Iz8veLCjXXhlQ97LpEzE+lFG3u72jNYm872h2Hr+uhT5jlCvrEb
         8sRTdpXbyRqfuGTtWxXcJUz6o4WVGbKNrCvdCWzfl+OGiTX6kjYKXoEg+HA6HbNSTbQs
         QHaNUnEfoNfLQVIl3n60ceL+gKtb7sNRupHgoAzjLNAF/4c7lTCQw8fNgHPSxBS6Vs6P
         jJiw==
X-Gm-Message-State: AOAM530/REe5Oyzqe+3GRz6z9kaRvoaUXB2ZHpO68Q9kF1N1iDzcQe3z
        IDokmj6s2CjuZPyrJp0dzqh3ei823MhIlg==
X-Google-Smtp-Source: ABdhPJycWz4pakWbnNhMZrR15429/k3C2l+f+SL+NfM0k55ybkoyPv1lvJESnpb6LIozLrCrb/Th/g==
X-Received: by 2002:a2e:5750:: with SMTP id r16mr10156744ljd.61.1606750676106;
        Mon, 30 Nov 2020 07:37:56 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id r8sm2467749lff.238.2020.11.30.07.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 07:37:54 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1kjlFu-0002Ow-UO; Mon, 30 Nov 2020 16:38:22 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4/5] USB: serial: ftdi_sio: pass port to quirk port_probe functions
Date:   Mon, 30 Nov 2020 16:37:41 +0100
Message-Id: <20201130153742.9163-5-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201130153742.9163-1-johan@kernel.org>
References: <20201130153742.9163-1-johan@kernel.org>
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

