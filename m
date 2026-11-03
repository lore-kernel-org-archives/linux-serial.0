Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742009;
	b=qZL4tSDo5bULeMUXQLgZ5GtTWb+V7Of42xzS2RbLiHaDCkFpnRg+DMAx8b500FdisyJC
	 KqOwYvOwan7pZSZeFdalrcMTAjXbyIfhTT3Wq0W0mTLNdZJpLAyFUIvDaHzA1goeIPwXG
	 yYp8m+WF0K0DAnVYsmB9grZuEsvW7Hj9Y8U8Ekga8G/X6H9pUe14GCcBjI4bnLG5ew36D
	 X/iDaVlYVLukh/0q8WO+ssj6r9Vu+K0gIPz7HgXCBoriljjHhFTTlzbPbMY+YmLuAucTT
	 onG06ZFsvnz5Tl4PdFhBptECggZheeV3oHyxVbEMVZkiiC6rfLWbOv5NDJ2T8jO9muw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=E9UoBDBjwLLwDb4WmV28avfpsh+5/w/6UybGFvQ6fZk=;
	b=lfCrhh0ApkFJTqyOxn+rmLjzH6elRG2Rn75XLJ93ushuQklIsiEszWHztEa3sG2/QNpN
	 zaFS30P4om48du3Ttm7ctqYuFUF0raKg9NY6cqs0uDfPqKjkCfL7WL/OkbSiS3QksUkFD
	 /vWIC+vrIYDDmPlwyr/3ovtRVBvcl4q/bIg4l2+EKSTG+u+leGE7WpIdup580IjACOREn
	 zvwMKqiM4CQfo7oqBFUzeCGM/IclGPjCO4UMLJRiB+puu2nyaZ9a1OzeasvJ+ClfcGxoD
	 jdQnt2dzSEh5+Pdr+Kfw8pF0fbWB19qkket8ll4wtYsvNo4EChtzlWKuZBTGsVB+4Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z9kUYWq2;
	arc=none smtp.remote-ip=209.85.167.173
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDFA606A33D
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 21:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BDFA606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z9kUYWq2
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4c5d8c7f326so32057b6e.1
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 13:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793742007; x=1794346807; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E9UoBDBjwLLwDb4WmV28avfpsh+5/w/6UybGFvQ6fZk=;
        b=Z9kUYWq2J1PQrrBHzOjE+jvFKjYRag4wfA7A+PcWa/4v0oOJGNIKUmnvDk93En0OY6
         gexWUVLAG1L5tf42hcd1yZlnbAbNAhl2ICgu5/SRlS/kSUt1DxDDzVNnKheSiFW1zmK0
         oKhMySDWNQ17VxIIyCDKizJ1gI5fML2pxNwvlliER5V+1SsgDtjQ4r3T94XhMSaZ8hxK
         UTxs25vpgWD7cSm2Kw8CuJ184I4IR2TOdr8kwa634b33vn+g04Lu/YN1voZVP4KrjY9O
         wICQM3st+DwWeDrrlmYGBq5yIKXa1e0YyuRxurB4TTSIZ76PxJBwZUKljk8FXfzhYfd2
         DsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793742007; x=1794346807;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E9UoBDBjwLLwDb4WmV28avfpsh+5/w/6UybGFvQ6fZk=;
        b=pVJE9+GuXa4FqxLbXDW2ktRW8mSnaArmK8CrnzYXiYLzHx62Uq/S6CnsGczwMiwBnj
         VjIFrQmf0EncnuSUI/3v0rhK8KROWccjTciR88R8wesOtQoQ05FXvaSSMu8lptsFZS8l
         cYZeM7BH14hxFNrkfmj6wrFqAuhT8Xv25Nv/fp7o5VSfELQ0YgUTv6Sd77gBeTU7mL9O
         AC0L4QPOwh7yZb+VBAfuOAja5HwxIXz+y0PAZbI7idPf7HIQfXrKgke5uSvNXM26kL1K
         ggo6iqnoz6G3/E2bCcyyaKC0Y/tVVSNE28uLQncSKxVXdGAL67lC7kYB1fhox12AS/vj
         n6ZA==
X-Forwarded-Encrypted: i=1; AKwUvBz6WMY+4sIlb9Q+iD8M4ZfJG2O38XRRL3aJ3MZXcHl7Jh1rGky+RUITI9Dccrv5TrDZW6NP4bIEsFgMn94=@vger.kernel.org
X-Gm-Message-State: APuU4Z8iYcCbDVLslVLfkEylLpad2SaqkRykEs/MzFPEfxd6JEihnjDq
	/M7y8zssTfdWrsrkLKqCcMD4m2UDP6t24Z/ivfFWD+VYzYjUI41A48GkuTGDV/v2
X-Gm-Gg: AYBFou1H0MvydS+qOVSGTaX50suah2kl9HBhUxYnQkIDnBrpPy2eGXwJXv6FrGG603x
	zhLBBENbM1HVJ8mJEQ8+U2ArA+od0WJh8v3AkSNbbUZSuQGtFGqxvOyA+alPV7FjbJAb7myFtnl
	RZrva672o6Spq5hxtOmNUJNRDp0P58+tIMSBNGzfBEjRpWKvUzdm0xCNgD2tDmcZ9ad1ARzDmrC
	WW7eZ5JmiPoqPln7prSBHNcZPMJ/nnlAOKHc5sqZQBMXSCsMPEqrbk3giGpbKTJ2scwiff9V9Yu
	q62oRYC6o3KgAaAirI/gc9vRSzkM7aPvhVXFuo0XQvL6FxeS2lTbp2E+H7/Aii0NTJWgRpuLDST
	+2EeNCt5aKBGqkiSVaMhltvxp0jWGWE4znI+AGlkmnJ2hTSGiVYegiKtqr8dA9VVV0dObNWGlL4
	kmwO31sC/y9DAT59khiL95yOmaRJrF0Qsvjc2coyiXsuE/mJlR2i+tqtJjXdS5R1TDxaLj/lfJl
	PoKTB9nGYFelWDTFgvTjYxfqzuhKuSX7AAin2Qv3CWvBCIwlHDgxjccLUGZ1MLQnoHBbNnWICJB
	tQNoWwBMP+NMH2WC3kuFvx1EGN8eZsZ3qeTeIov61e4SGmOZDOMJpLrYt12wL1vfntLnWkDwyys
	EJbO2iJYvXJhSZzBDwnAfmStx43bUMDqjwTE8jMpr1ifriIa2EtYGBePMqQyh39dNhZSm0w/qsb
	I7LVBpI5fzsaPdZoAkSMlz07NjKCbqcJ++7zU2jgmXf3y1yN2D16CD
X-Received: by 2002:a05:6808:11c9:b0:4ec:d580:2440 with SMTP id 5614622812f47-5640de5a472mr9799943b6e.54.1793742007017;
        Tue, 03 Nov 2026 13:40:07 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9f9115csm27060b6e.11.2026.11.03.13.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 13:40:06 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 03 Nov 2026 14:39:55 -0700
Subject: [PATCH v7 02/12] serial: 8250: widen RX trigger byte counts to 16
 bits
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-submit-h616-uart-fifo-v1-v7-2-c9e248d685c1@gmail.com>
References: <20261103-submit-h616-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com>
In-Reply-To: <20261103-submit-h616-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

DesignWare UARTs can have 2048-byte FIFOs, with receive thresholds as
large as 2046 bytes. The byte-sized threshold tables, setter argument and
sysfs parser cannot represent these values.

Use u16 for the threshold tables and byte counts throughout the 8250
conversion and sysfs paths, including the uart_port callback interface.
Keep the FCR encoding byte-sized and preserve the existing threshold
selection. The Moxa setter continues to validate against its 128-byte
FIFO before writing the byte-sized trigger register.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250.h        |  2 +-
 drivers/tty/serial/8250/8250_mxpcie.c |  2 +-
 drivers/tty/serial/8250/8250_port.c   | 12 ++++++------
 include/linux/serial_core.h           |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 21ed9c41b751..939b7d4209f1 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -69,7 +69,7 @@ struct serial8250_config {
 	unsigned short	fifo_size;
 	unsigned short	tx_loadsz;
 	unsigned char	fcr;
-	unsigned char	rxtrig_bytes[UART_FCR_R_TRIG_MAX_STATE];
+	u16		rxtrig_bytes[UART_FCR_R_TRIG_MAX_STATE];
 	unsigned int	flags;
 };
 
diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 4935a5d1c1a3..4f0b881b4f83 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -257,7 +257,7 @@ static int mxpcie8250_get_rxtrig(struct uart_port *port)
 	return serial_port_in(port, MOXA_PUART_RTL);
 }
 
-static int mxpcie8250_set_rxtrig(struct uart_port *port, unsigned char bytes)
+static int mxpcie8250_set_rxtrig(struct uart_port *port, u16 bytes)
 {
 	struct mxpcie8250 *priv = dev_get_drvdata(port->dev);
 
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 36b2b0a2c05c..452851815ffc 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3008,14 +3008,14 @@ static int serial8250_request_port(struct uart_port *port)
 static int fcr_get_rxtrig_bytes(struct uart_8250_port *up)
 {
 	const struct serial8250_config *conf_type = &uart_config[up->port.type];
-	unsigned char bytes;
+	u16 bytes;
 
 	bytes = conf_type->rxtrig_bytes[UART_FCR_R_TRIG_BITS(up->fcr)];
 
 	return bytes ? bytes : -EOPNOTSUPP;
 }
 
-static int bytes_to_fcr_rxtrig(struct uart_8250_port *up, unsigned char bytes)
+static int bytes_to_fcr_rxtrig(struct uart_8250_port *up, u16 bytes)
 {
 	const struct serial8250_config *conf_type = &uart_config[up->port.type];
 	int i;
@@ -3073,7 +3073,7 @@ static ssize_t rx_trig_bytes_show(struct device *dev,
 	return sysfs_emit(buf, "%d\n", rxtrig_bytes);
 }
 
-static int do_set_rxtrig(struct tty_port *port, unsigned char bytes)
+static int do_set_rxtrig(struct tty_port *port, u16 bytes)
 {
 	struct uart_state *state = container_of(port, struct uart_state, port);
 	struct uart_port *uport = state->uart_port;
@@ -3094,7 +3094,7 @@ static int do_set_rxtrig(struct tty_port *port, unsigned char bytes)
 	return 0;
 }
 
-static int do_serial8250_set_rxtrig(struct tty_port *port, unsigned char bytes)
+static int do_serial8250_set_rxtrig(struct tty_port *port, u16 bytes)
 {
 	int ret;
 
@@ -3111,13 +3111,13 @@ static ssize_t rx_trig_bytes_store(struct device *dev,
 	struct tty_port *port = dev_get_drvdata(dev);
 	struct uart_state *state = container_of(port, struct uart_state, port);
 	struct uart_port *uport = state->uart_port;
-	unsigned char bytes;
+	u16 bytes;
 	int ret;
 
 	if (!count)
 		return -EINVAL;
 
-	ret = kstrtou8(buf, 10, &bytes);
+	ret = kstrtou16(buf, 10, &bytes);
 	if (ret < 0)
 		return ret;
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 4eeb8253752a..97301ef66af0 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -461,7 +461,7 @@ struct uart_port {
 					       unsigned int quot,
 					       unsigned int quot_frac);
 	int			(*get_rxtrig)(struct uart_port *port);
-	int			(*set_rxtrig)(struct uart_port *port, unsigned char bytes);
+	int			(*set_rxtrig)(struct uart_port *port, u16 bytes);
 	int			(*startup)(struct uart_port *port);
 	void			(*shutdown)(struct uart_port *port);
 	void			(*throttle)(struct uart_port *port);

-- 
2.53.0

