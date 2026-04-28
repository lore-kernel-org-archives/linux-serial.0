Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED01382F0C
	for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2026 07:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360070; cv=none; b=mL0tJd5UnI4/tSmye5wNXSRi+Jt2E1nguebC1zyTnAgkEzoRRjTmOBb7+G7UI/dutFaU+8iNVsfK5EjNbNBmY6A/RmjiUpYTei4U4mO56FPPtPdi4wr65GiJLrLkbOBsnBDNvWJIS1MSTag2+XstOqSdnZXec5SI4KE2gd27ZrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360070; c=relaxed/simple;
	bh=3qaWLRrK13lySvvQtDaRu4icofV0klbNEnYkK5PoagU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dqEuk2Uxg198vZqh7RhXogK+rVyyL/vNdYNFLFemdzdksfjKfJQEJ9Qvg614vCP5TZmpPR9zgjykQA9DqiSOfsuAmkPHR6gvhgK/6s7yV7HnZ/Ygd/4AjuMxQsmKb3uJJyRcFh0yM+fE6sZ76whzfQHUyiTPkFwanIss3jfvKKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oEt5zSXA; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oEt5zSXA"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8296dabef74so9216092b3a.1
        for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2026 00:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777360068; x=1777964868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2j/sRizJKN30TvT9iyb4DM4Q5nnqFSUzdz0sb2qVCcI=;
        b=oEt5zSXAuw6XeIaAAl/CS3nijwUhbPkVJAuKDAQpiXs5n9f7hNMRHzOxHetx7QvSxp
         Aq/sTsMiFM6WwHT4KuG4eF653i8zdHwgAi8ZkwRPzedYdHwSdWLXL9ayhkb3RChFw4zS
         evbv7vP07rkvFjn9SCAYE6Sa15/E6vyw7VXBqOSDf2karjWzjzJBAkUCyYP409nfD4AL
         1odhpeTCba+vARLiuCAcM/RSJ3aDyDecuuQR+Ua5Id18NMEaD3TQxIOlrh9If1adwT7s
         95DpE5orqgHnNcdlyec9Yu/TYk/f/1lvbl0eF8HJ7jtZpJjZo+VVuYST4ZSKUBXp8vev
         XFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360068; x=1777964868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2j/sRizJKN30TvT9iyb4DM4Q5nnqFSUzdz0sb2qVCcI=;
        b=mMdLObT2VU8WASuVLiDnO5HmDwdpFEmwIgIxEpxjs2nY9VSK/tHSG19LVRGWtNDomJ
         fr7uA/XBt0rpmHJ1eeTW8ZU+tOeFgM3/Rv8vIB6raptsoCQjSW2WEXWjdyuAEAMHhAtB
         3kKVtwVLz/4XgYLDOFY2C02GDMAg4Wv5r8f49OkgW19Nen2Cq5XMjWC8c8YO8IjWvFCj
         kBd/CgPqZJdPueW+vsz9qAkQiZyrkY4Qtn65N9kKG82hdRX8vsPy7vEIxSFW59oIuOLH
         MlAAuZ3p81V2T+7RkSeejyv9z+DmOx0HXMVrHEG014sdBHwqIXUA7gTp/gQ5w+JPr3tb
         SdKQ==
X-Forwarded-Encrypted: i=1; AFNElJ+F1LKUsgC+BEj+alLEXQ9KP7FkdbNFtATQHhAshxwUOLVBupAKiENdlqJnI1MoHGjWPM9aMqdi9Jdz68o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxcYBY3zflb8F5xl98dCeY0BUIm9Nnu6B6DeE7JPjIk4GhtpOJ
	ITdjnWXlmL7/I0YXWfEaCLYHm/FQL9qA41p9vzSGisjuAY3lJxwj94s=
X-Gm-Gg: AeBDieumZVIsFQW6iKmN6DrEbyYRs6pfR1gqMbQ2nUTN47jK4lEyQNXw9fb4O+81g5/
	mhuWKTdau3/LsPA+C4Sd/vpdEmJhtDpUqCLEGiYH4TK3cMA1bqNmHH95p6m4ZJu7s4noRssrjcD
	9Ka2fPvcHcpmZ5/hJgLrTSZfEhdfqoej3Xu+VX7nx2aAlnT1vsXX4BpPW5kN1VdPtihzg3DzjE7
	G4Gx06oxpFMNQJQP5SGU0Bb+iG/SvaXztfsZcEEjV6UPkMPsuJIbqOMxbsN87CKZGWQm44lU2pZ
	BLLKvuPyMyoh6ZqihBShhpnGlLWn9NCip3Nr7b6ZMcCtNZ9CAdevbyxdaIONU7dcnmAUmA/mEua
	6TaZjpCKvIZbq7ILb2iAR4wAcfj9AxJ3+OsyWS1CoDS6vtnaYhZUTY9VyJC/FDks7Mpn2mlwSfZ
	y8SMjB4W8/cHQGLFiug+vC/o4GrWs9bEAW6DlUfEZfCW+D5cG/KpflzlAjsFUzi+AAVbD9RQYzN
	ukyRH75YRI68LOL37AKLIOW5bxxW1NqdMchwZHppuUR2Csl85HqGu9J9Q==
X-Received: by 2002:a05:6a00:990:b0:82f:42bc:3386 with SMTP id d2e1a72fcca58-834ddb4a92emr1906959b3a.21.1777360068079;
        Tue, 28 Apr 2026 00:07:48 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834dae2027bsm1745248b3a.16.2026.04.28.00.07.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Apr 2026 00:07:47 -0700 (PDT)
From: "=?UTF-8?q?=EB=B0=95=EB=AA=85=ED=9B=88?=" <mhun512@gmail.com>
X-Google-Original-From: =?UTF-8?q?=EB=B0=95=EB=AA=85=ED=9B=88?= <pakmyeonghun@bagmyeonghun-ui-MacBookPro.local>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>,
	Myeonghun Pak <mhun512@gmail.com>
Subject: [PATCH] serial: max3100: unwind port allocation on add failure
Date: Tue, 28 Apr 2026 16:07:27 +0900
Message-ID: <20260428070742.40072-1-pakmyeonghun@bagmyeonghun-ui-MacBookPro.local>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Myeonghun Pak <mhun512@gmail.com>

max3100_probe() reports errors from uart_add_one_port(), but then
continues initialization and returns success. The device is left with
per-port state in max3100s[] even though serial core did not add the
port.

Return the uart_add_one_port() error instead. Free the per-port state
and, when no other chips remain, unregister the UART driver that probe
registered.

Fixes: 7831d56b0a35 ("tty: MAX3100")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/tty/serial/max3100.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 475b0a6efc..83a9db1819 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -732,13 +732,31 @@ static int max3100_probe(struct spi_device *spi)
 	device_property_read_u32(dev, "clock-frequency", &max3100s[i]->port.uartclk);
 
 	retval = uart_add_one_port(&max3100_uart_driver, &max3100s[i]->port);
-	if (retval < 0)
+	if (retval < 0) {
 		dev_err_probe(dev, retval, "uart_add_one_port failed for line %d\n", i);
+		goto err_free_port;
+	}
 
 	/* set shutdown mode to save power. Will be woken-up on open */
 	max3100_sr(max3100s[i], MAX3100_WC | MAX3100_SHDN, &rx);
 	mutex_unlock(&max3100s_lock);
 	return 0;
+
+err_free_port:
+	kfree(max3100s[i]);
+	max3100s[i] = NULL;
+
+	for (i = 0; i < MAX_MAX3100; i++)
+		if (max3100s[i])
+			break;
+
+	if (i == MAX_MAX3100) {
+		uart_unregister_driver(&max3100_uart_driver);
+		uart_driver_registered = 0;
+	}
+
+	mutex_unlock(&max3100s_lock);
+	return retval;
 }
 
 static void max3100_remove(struct spi_device *spi)
-- 
2.50.1
