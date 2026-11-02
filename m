Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649329;
	b=AzbuwdjAeQOWzW81uFss/O3kVNMnDlJ9LHk0vsahLHFjLSAVWgPI3tYv9aqL3FRcrlvl
	 KMBOj76IwRIzpMENqJy06VK8BmGXz39uQ18ZiB0Dc7rtkTaEtZN7758LVX/6XF5ptcSCI
	 QXP5U+6QdNha7Ig4zSg/FolHFLfftsVmpBNKAxMLcYF6d5MzmQlcnWI5pwFvWmqPHj3x0
	 6iJ4/gwgssMa22oSmS+Phlpzw7Q0X8fF9GFBECMq1SGEeiKEP8secznMUfDP+TjvN+Gh+
	 SQ1a3wxfE+QPByMH3eSrlM2kh1KlQ8bhKioUZZribkZbiBAG4wkTI4dNSypYmHD2sKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649329;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=N6NaCr2YqwIe/GreNxQyGPwW88t11Y+r+IlcKQCQW48=;
	b=U/OUTCm/uKARmw8+jyXA3kSv1TY2py/N54Hu1NsQH1C0DU5gfkJc/Zs/3Qiz7I2qrX6h
	 fVvOa6ogi5FgeJmIeJknBNi0s5mlVlyz3R8TwQgOncdoGiIbkr4CiTfR7vUOaMn2GedOt
	 p+ak0ABOYqqSSaQUD0+VQ53ALezjHIU3ERVopWJZV2cPix1muOz4wz9FHmKNbv7MkKQgm
	 HXpMabiaYvTBbjEEhrVDDaxfqCQ9KjMTNGJPMD08DGfAQ97FcvklIxPj4Y50AyX5Wwhv3
	 1G6YXVPI/yeQD1h8dl+k+qmz+DLyfYrPVA2lUPtOT/EPngDrmKi9dmQdeFL/aHz1nvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RHrcYLtu;
	arc=none smtp.remote-ip=209.85.160.53
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9FD606EEA9
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 19:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE9FD606EEA9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RHrcYLtu
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4911df1e196so2172760fac.1
        for <linux-serial@vger.kernel.org>; Mon, 02 Nov 2026 11:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793649328; x=1794254128; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N6NaCr2YqwIe/GreNxQyGPwW88t11Y+r+IlcKQCQW48=;
        b=RHrcYLtutXWsZ6SzT0PPS6ZO/wc4raZ0Bykh5LV3aL5yAuRicpt093K2BGorJtG5YX
         0onUZoGnUgget57tuH9JA228CPhjtMyjwfLjoc+5XlHt+JtTxrVffWftnNR0pm8NKUbW
         r9jOxek8y3eHV5Rg0rsFEM6PEGtQBc+gJUFNmiCRZwC0+3N7zG+v+u2bnT2L8Ofb/vmh
         ZAqTCJMsx1JLv+Oeyh6zRT063BldX44YmhK2489ZFGZgsfCskZmZ288Ppvel5DddXKTW
         Yzo91lJXWU+KxsDlhG0CCUFCe/DTSm4UhVC4un1K2/SQkbpXHUgJOsc7FSJvH/Zuu5ZL
         XPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793649328; x=1794254128;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N6NaCr2YqwIe/GreNxQyGPwW88t11Y+r+IlcKQCQW48=;
        b=d5atfH9Bk2+y4BBKXzygvHIgD+iPi2Txd3lIrWmLaaFciJfN9gUUNnTTEPmC0sdWWA
         EvtcpRcLZ0ggS9IRPDWRJ0R2kz61xzsw5HNNNbZQHBjJRnsCIlScW3OIAT+p6d/QlM6/
         6GdXh2PDG7JG9cAD7PiOXD6Mx0akWovoEWbcwqCk2iII8fkVJwJZ5p9RETyS97EEgo28
         rfkieBzVD/XeMK09l4g5SJUxcsa3SBrE43L+ugpOYmGO/eGUZszqcBtGO9rnN6DunAv6
         2kAYW8XTbZKZluO6y6y2d97Iduxmh/NkhzmkBew+duEuuVz1QaSbnZY9qD/EiU5siG5P
         Y02g==
X-Forwarded-Encrypted: i=1; AKwUvBykRvpqvbGCmj64OtXzKBoFPD6VpaPLuL/7/3J1eo5uoNqeumEmCKjPyOGIPfGFE00pRXtThA5imek46uc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKy5GA0FAOZGqXJDrVNbg2zn0N4JJDDkcWo+bYNag4DC6xBee0h
	7TEf/ci58Hn+cqw9/d4L4rSE2TLc3rXbjsu3bhjWVdgENsk1h38wlxEG
X-Gm-Gg: AYBFou25R9+ZlBXH/H8uMGclxCTaVPx1Q0L0BT+rVejNA68b+f0eyODlGRtg3lZcNwv
	l7vVqhBin2so5Ty3sF8c2zoxyLanNezYj4rDXT2F20hqBpkYVCltlki7aHL3t2/GpXoJfhl6IGJ
	1OrWGBNyN7F/bsdeP00FpoOtu8zkMh2pVkiqhcPV6dkS9FZj91n04YKmj/cpHNgVeojRI2ktOFn
	6Olj+Hp1hLzPm5oB2J7vXv4ewn6vTOG0M7c2jkz9MyGOjJ9y120hNwcx5vWVnYzRDEttJVGsTNw
	GvL6s2DqepEp+5SL+C2rDM5lCt++Kj4Y3Z/Y8ycN0ZLpECAZgTuNGUvMv6NeBS+1m9FaK6hsU8O
	DTC6gZX5+dUny4NA6Q1Hla23IGdOcomMeNJ8NojRtM/dqTs8s9XJzigrZeV4cVVvz/uoAQBGDQX
	9bCY3jD6IN31YmdSZtkBgMDchr/BYyyaR7Vp475icD1V4U5FfNnBeHiiV23HYUOdwRVsVtUf0Sy
	okmWUiaf1kyJcOjoh/JpckMoKrrJ2CMJa9hUR9TtpVIo7Ap1kAMCTUgFsmo1Zekv4bk15S2RP3S
	KQFb7SwpmSWQmuw6lzeytNO85+9X9tPAbnutUd+xEPIQnPgY7/udNk2a9s9GKrH8iVt5eh9Dlj0
	9R8dIUX183nHy4NJIHrbwOWLscnhrLHcFFFGa0ZVGhGqGefj2l1NrGqZTdjB/dgRftqxmzoBT9H
	pWJ/G/3xXKR2oKsaROnNSJaHVmxGOsPrrecfQ7iz7AdzE/UUxbs6I=
X-Received: by 2002:a05:6871:e41b:b0:4a6:f610:87eb with SMTP id 586e51a60fabf-4a90729a753mr6897453fac.3.1793649326753;
        Mon, 02 Nov 2026 11:55:26 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a921353dcfsm7809249fac.0.2026.11.02.11.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:55:26 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 02 Nov 2026 12:55:17 -0700
Subject: [PATCH v6 2/8] serial: 8250: share the RX trigger conversion
 helper
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261102-submit-h616-uart-fifo-v1-v6-2-25afcb346b0c@gmail.com>
References: <20261102-submit-h616-uart-fifo-v1-v6-0-25afcb346b0c@gmail.com>
In-Reply-To: <20261102-submit-h616-uart-fifo-v1-v6-0-25afcb346b0c@gmail.com>
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

Drivers can supply receive-trigger thresholds through the RX trigger
callbacks without adding a legacy port type to uart_config[]. Extract the
threshold search into serial8250_bytes_to_fcr() so those drivers can use
the same conversion as the generic 8250 implementation.

Keep the implementation in 8250_port.c and export it in the SERIAL_8250
namespace. Include the unsupported-table check and preserve the existing
nearest-lower selection and highest-encoding fallback.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250.h      |  2 ++
 drivers/tty/serial/8250/8250_port.c | 21 +++++++++++++--------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 21ed9c41b751..1600f2e45d76 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -73,6 +73,8 @@ struct serial8250_config {
 	unsigned int	flags;
 };
 
+int serial8250_bytes_to_fcr(const unsigned char *rxtrig_bytes, unsigned char bytes);
+
 enum uart_port_type {
 	/* Internal 8250 only */
 	UART_PORT_AIROHA		= 124,
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 36b2b0a2c05c..4a25badad3c5 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3015,22 +3015,27 @@ static int fcr_get_rxtrig_bytes(struct uart_8250_port *up)
 	return bytes ? bytes : -EOPNOTSUPP;
 }
 
-static int bytes_to_fcr_rxtrig(struct uart_8250_port *up, unsigned char bytes)
+int serial8250_bytes_to_fcr(const unsigned char *rxtrig_bytes, unsigned char bytes)
 {
-	const struct serial8250_config *conf_type = &uart_config[up->port.type];
-	int i;
-
-	if (!conf_type->rxtrig_bytes[UART_FCR_R_TRIG_BITS(UART_FCR_R_TRIG_00)])
+	if (!rxtrig_bytes[UART_FCR_R_TRIG_BITS(UART_FCR_R_TRIG_00)])
 		return -EOPNOTSUPP;
 
-	for (i = 1; i < UART_FCR_R_TRIG_MAX_STATE; i++) {
-		if (bytes < conf_type->rxtrig_bytes[i])
+	for (unsigned int i = 1; i < UART_FCR_R_TRIG_MAX_STATE; i++) {
+		if (bytes < rxtrig_bytes[i])
 			/* Use the nearest lower value */
-			return (--i) << UART_FCR_R_TRIG_SHIFT;
+			return (i - 1) << UART_FCR_R_TRIG_SHIFT;
 	}
 
 	return UART_FCR_R_TRIG_11;
 }
+EXPORT_SYMBOL_NS_GPL(serial8250_bytes_to_fcr, "SERIAL_8250");
+
+static int bytes_to_fcr_rxtrig(struct uart_8250_port *up, unsigned char bytes)
+{
+	const struct serial8250_config *conf_type = &uart_config[up->port.type];
+
+	return serial8250_bytes_to_fcr(conf_type->rxtrig_bytes, bytes);
+}
 
 static int do_get_rxtrig(struct tty_port *port)
 {

-- 
2.53.0

