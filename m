Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911956;
	b=hGi0F2B0rTFAZ/j6ABcB9N+Es7DgGqy7LiKarK67C9EFXz8DIVMrhLBC33UUE1TnGK+2
	 ejFBmyHD5ApCmPag2vBDABLiTTfN8xoshMCk59rSM8bbJ7qZ9+y5tcPq1zzn7EjIPDxjD
	 K4/JkM1xJ9ToNqeJrHeMaJ3AqdppEjyr3OJofFfgj4obcMycBd5H7wOqTKXDSicvx9xem
	 KiVJTnNM2FbN/Ud1P0hpkbAkITcRjr1fEQYVJusjIY/kYTEInRhITbomff4ewO+htCT/4
	 wo5wSwqlrmLmkm1WSzIoow22nphU/RpITRiNqQfkvFgCaztuLiGXlPrE17MdWb4YHPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911956;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=gLp03dCCASGHpzLVyWfgND6QB17hfQHAhLsrbe2Ht9o=;
	b=kCzxNmkVMZ87MT9+6gInmMRfqIP6MWVSrHEOW7RmzAgCpFTUKgKxcE3IfSMPq/0/LCY6
	 BKGgGPBQAqf5p9/v/pz60doL1ZR+Xoxvup4Gc1cVhgTEyzN4kLo9otFRJTUUwFhGEwDuh
	 SPjic0cZY6M+xFlXOpLhhoARVt8KhqgsoyJO3hHU0LgUAG8Up0oC20Y8tedTcGDBwMrfz
	 HclRn6W7/PXIUVRavy/1BHWAhpSQ85JiinXGk7n1oKcnpXzyHla02t4XIhkHa+cbcJeqB
	 wj1Db1W8cH4ASQsyVFR0xvEghrKTPSOsyo9ZztD+5sT23ay7aG+/I2PZhj0fgMlvNsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ckMnUrqB;
	arc=none smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E54606D82F
	for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2026 20:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5E54606D82F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ckMnUrqB
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6f8a519e215so1204969eaf.1
        for <linux-serial@vger.kernel.org>; Thu, 05 Nov 2026 12:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793911955; x=1794516755; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gLp03dCCASGHpzLVyWfgND6QB17hfQHAhLsrbe2Ht9o=;
        b=ckMnUrqBF5YjkYWNzJKEtt3h3QNjhP9PJbZXBV/J6bRVKXTyR151+RSJ9U+eER71Ap
         EZldnj1ydj2XTvzN/QAd1lAaKdYRiMolKOMghRHOUoMDS8SQjujfcwgIdq4WmgNcysKa
         hHmECxLq77xxeGRIIheOWSmb+8PthutqlN1Kr+E6rrLvE6em77b1DstgthhRi85GkJrT
         rzNjQLqLPOD+kwi1iBLCztr3zLJfqCJgTAVJLbCpu02QbAeJWQFO5qFx/w4NDJW3snyr
         MaNBywJAxiISvEsiIYk2F5ADkqXMYIHKfuCmxKCo7+3xCHSpKtdd/b/xbQhBTkU0nDs5
         JgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911955; x=1794516755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gLp03dCCASGHpzLVyWfgND6QB17hfQHAhLsrbe2Ht9o=;
        b=r5cqU4blIY2YVpG4mso7TxNWI0ASET380YDlvQd+9ewA1tF0bEEwKOGV5P/OYfWEaC
         JI5z9YNoQuArZi1uEORD64/CLj4tnE21Ehs32I7Mioc3eAbB9df+d152YNI3Lcfhdiwo
         K5i8NEbChfaO/mJyAGDupJexdYWtiFUVA4+XrEHgOaPHLVD/3nQrHnfHpg6J7gQ2hU+z
         OiSHwrl6AKn9nwlE3uKw8y2oSEFnN1PXH1jVtr98XWkpynw6pYJuQjWHPsob0UDGSWrT
         GzzPHrtwQ/a8QPqHI075aavapCzVZvjMcdKhe2oNcOGbZbrs1DVqotJ6Uek3WOwBa/1E
         nZ7g==
X-Forwarded-Encrypted: i=1; AKwUvBy+jHCWc7mMoKwMgbKHQYUMvle1UZFsAUW14ppcHbEL3GAZn1a37BRpTeYuXd00M6RV/qYRYTfDF71Y4j4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ZJSjS3LlCVYsaZGGZ4s3xPsTOgvLBDVUt1KFA1YdxjPZzrNgv
	2j8BcdbeiuYuS10Vvb4qABX9NtQKMDc5IjxJ37Mk1pVP3dx6d8doqiQ8
X-Gm-Gg: AYBFou2RhovDfKDYW47jsLDFMQPkte1oQm4uS+rnoqdCsGQTdHmwgm3/P9/pxkhoLOh
	dACHzwIgdSb/me14QtfFthXbuvpsCA2fx2z6+yq7JGylEC7Dn9jx6uaIjwyOhH7Fio95AzRVcjd
	l/5gOyVw4GnZL9TuOoeU7kkBhFLElrMk9GGLgOfdqGG3E2B4UwIZrjN+JsI61McSc+GJMFUyGLc
	dwMWHuLTo70IvQGPcaHaz2te/2RDivNp8DlkR6WDz34XURHP+GbNxrHdI1FAPlgwxvop7Sw/lkJ
	l1CxWS34uql4nZJGTNwr4aglWKbRn8yrsQe4Xt+FtXtl/ttRuVy/QO1pkaRmGg/63qdyoM4XGKL
	UWeVoeC15ulEKrv1T3HA0RLe2pgHGTW6btrsVxp6XQulcgSCM8NH15JAOsQCbxzQWc1xbyeSWen
	PalJQa8hHwzVkCEvhW5BNr39bwePBYPXbOBYbBtWbsJ0Hbl6noJJn2GsU76r0KdS5SgmvH35BX5
	RE9LqwkhNPDdH8d/UkA7jMVoWPa5wVmuFOUV7OYpCKRthpu6QDNaMW3uUN2t3OU71XlaIk/361t
	9tk3lIFELqx2ysou44ioi85GJP0iB/vWsxijoqHwvNwBRHoyT4YVNgI416o4XMPYMEkaEVQZlAR
	xVWwmkjxKYbcdQpYU73drNPtEZ0lTbtsPoHPHNDiTM0R/Yd341xgwQS7Idh9ehphvtLxDDdg2fc
	Ap3nwDwFG/i+lHOi3mOEHAQHaX47YHnbP2E2Vjq4fRzrzyFEfHRZBEEh1xlnt670eL+4UzC9In
X-Received: by 2002:a05:6820:995:b0:6dd:c600:ec2e with SMTP id 006d021491bc7-716d20ba2a8mr2263018eaf.19.1793911954642;
        Thu, 05 Nov 2026 12:52:34 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85f1dbb298fsm292276a34.6.2026.11.05.12.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:52:33 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 05 Nov 2026 13:52:12 -0700
Subject: [PATCH v8 11/11] serial: 8250_dw: configure RX trigger thresholds
 for Octeon
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
Message-Id: <20261105-submit-h616-uart-fifo-v1-v8-11-14024d2b184b@gmail.com>
References: <20261105-submit-h616-uart-fifo-v1-v8-0-14024d2b184b@gmail.com>
In-Reply-To: <20261105-submit-h616-uart-fifo-v1-v8-0-14024d2b184b@gmail.com>
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

Octeon uses the DesignWare receive-trigger mapping with a 64-byte FIFO,
giving thresholds of 1, 16, 32 and 62 bytes. Its setup bypasses
dw8250_setup_port(), so it does not install the common trigger callbacks.
PORT_OCTEON also has no static trigger table, so rx_trig_bytes is not
exposed.

Supply the fixed depth from platform data when firmware has not provided
one and initialize the common trigger table before port registration.
This makes rx_trig_bytes available while preserving the Octeon port type
and register accessors.

Select DMA before filling in the default depth, as before when the 8250
core supplied that default during registration. Thus the new trigger
setup preserves which ports attach DMA and their existing burst sizes.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_dw.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 257baab5a3ed..31045128dcc6 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -663,6 +663,21 @@ static int dw8250_setup(struct uart_port *p)
 	return dw8250_setup_dma(p);
 }
 
+static int dw8250_octeon_setup(struct uart_port *p)
+{
+	struct dw8250_data *data = to_dw8250_data(p->private_data);
+	int ret;
+
+	/* Preserve DMA selection before supplying the fixed FIFO depth */
+	ret = dw8250_setup_dma(p);
+	if (ret)
+		return ret;
+
+	p->fifosize = p->fifosize ?: data->pdata->fifo_size;
+
+	return dw8250_setup_rxtrig(p);
+}
+
 static int dw8250_sunxi_setup(struct uart_port *p)
 {
 	struct dw8250_data *data = to_dw8250_data(p->private_data);
@@ -934,8 +949,9 @@ static const struct dw8250_platform_data dw8250_a523_data = {
 
 static const struct dw8250_platform_data dw8250_octeon_3860_data = {
 	.usr_reg = OCTEON_UART_USR,
+	.fifo_size = 64,
 	.quirks = DW_UART_QUIRK_OCTEON,
-	.setup = dw8250_setup_dma,
+	.setup = dw8250_octeon_setup,
 };
 
 static const struct dw8250_platform_data dw8250_armada_38x_data = {

-- 
2.53.0

