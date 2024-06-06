Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D72171743
	for <linux-serial@vger.kernel.org>; Thu,  6 Jun 2024 19:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717703916; cv=none; b=KCwDln387AjxjcqsuTQNOlfxxUxW6vZ/Qc4+/u33evixN23vFimMyWsfpBLG0oKQHDne+3hkYYbpY0drvuHP8eTFNUfZO+qc6LPFQh1P7Ab3265KMh2RR9ywKdeYRs45xK/XKXU2BsjBWfCcbzQS/SbBdbwT+eS7Cl6vW1bd5n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717703916; c=relaxed/simple;
	bh=skqVWGCzgo9ma611abjtaugTbbDm70/JjjTaxlkXm1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nhkj5aeigDox6xksxIoHLJjTdAsZnoWPD/BsIBZnjsKgpJCIhudsikTAWnmfu82H+91dnkxvQi9IObpYAhWxAzoD2HVMbaXJ/Q+SAJiZcgQOj0UlRTtGuS1b6iyejL1m5BaPnGNA15ueLesckmwf+PBOsCDl37rb2QJGlHpKtx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com; spf=pass smtp.mailfrom=schmorgal.com; dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b=P4LKfkuu; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schmorgal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b="P4LKfkuu"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70255195be3so83529b3a.0
        for <linux-serial@vger.kernel.org>; Thu, 06 Jun 2024 12:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google; t=1717703913; x=1718308713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhCrgBpdzAke7VNUV68QTusfCqXgr2XrKc4HM00cRt0=;
        b=P4LKfkuuq5W51aYf8n5QbPXkB09fm0NUkiUVMzZQNr7fp2m6xWAso7c0FFVD6ZB7kj
         aJOtfqjFWTeyHat1PnNYjheWqSWTlVjGeN8/3GygMAJyrsnsDkVdUvIvqkTcCcsZRqwj
         MHI1zJfqt1lSCvzXkzGRz5lQDoQHACwQAQDps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717703913; x=1718308713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhCrgBpdzAke7VNUV68QTusfCqXgr2XrKc4HM00cRt0=;
        b=l/qZgIbQlCATbm9ojvbKfGHrpU2JnkBaCOPNj+0AB5vdVVsA6o9GW3v1IOwDnX8mvY
         x+SzWnSoI4NN8aat/S5yIbHl2YtlRn3cO5Mtm1QZE8oryGcEsEinQqt10KaOYjGtfptR
         S0rsWWodpEJWaBRRMrcKF0bmPUpoAa1/f/xiSZeT1WOqQN3Vi1CFobp3eWyozyL970rz
         RKTUlcq9HalSzxbGz+rWi1uqSgL94FOWBhiSM5Bbk9apRfFfDAaq3dGH/qonWJwAFHtJ
         LFiurpQztgYKjP6TskdBXi5pPSa7hLW2UIJLw6cTZMt9mlpBHrXzJJ29Krup5hYzf5EU
         4L0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdmwoFh1HrZG5Aq0L0l1hQFN5eBTh0/HE+95T6OL8RD1NZOGCiTP+joY4q7aya0mGCFo3Iadj0nAxt/NXN2u0Gz7WXJkd9otQaFn13
X-Gm-Message-State: AOJu0YxxCpH75J3LyNYqy36ClENNqZJ9cFU3ZvARvGv5Hg/1sznYtnCZ
	ktNbBozB5SaS3o1lQez48VYkARH07Q66ryuxcA2OiqPYBs3doVYXbjmPSS1UTZo=
X-Google-Smtp-Source: AGHT+IF7Ftlwe/U4NDtIPz39i7uTg5EUekjT2xSqVdbcRSCmGjClmjOuqdckU5olHmr84Y1emnijAg==
X-Received: by 2002:aa7:870e:0:b0:6f4:9b4a:aba4 with SMTP id d2e1a72fcca58-7040c739b89mr461133b3a.2.1717703913066;
        Thu, 06 Jun 2024 12:58:33 -0700 (PDT)
Received: from doug-ryzen-5700G.. ([50.37.206.39])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd394f20sm1446787b3a.55.2024.06.06.12.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 12:58:32 -0700 (PDT)
From: Doug Brown <doug@schmorgal.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Jonas Gorski <jonas.gorski@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org,
	stable@vger.kernel.org,
	Doug Brown <doug@schmorgal.com>
Subject: [PATCH v2 2/3] serial: core: introduce uart_port_tx_limited_flags()
Date: Thu,  6 Jun 2024 12:56:32 -0700
Message-Id: <20240606195632.173255-3-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606195632.173255-1-doug@schmorgal.com>
References: <20240606195632.173255-1-doug@schmorgal.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonas Gorski <jonas.gorski@gmail.com>

Analogue to uart_port_tx_flags() introduced in commit 3ee07964d407
("serial: core: introduce uart_port_tx_flags()"), add a _flags variant
for uart_port_tx_limited().

Fixes: d11cc8c3c4b6 ("tty: serial: use uart_port_tx_limited()")
Cc: stable@vger.kernel.org
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 include/linux/serial_core.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 3fb9a29e025f..aea25eef9a1a 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -850,6 +850,24 @@ enum UART_TX_FLAGS {
 			__count--);					      \
 })
 
+/**
+ * uart_port_tx_limited_flags -- transmit helper for uart_port with count limiting with flags
+ * @port: uart port
+ * @ch: variable to store a character to be written to the HW
+ * @flags: %UART_TX_NOSTOP or similar
+ * @count: a limit of characters to send
+ * @tx_ready: can HW accept more data function
+ * @put_char: function to write a character
+ * @tx_done: function to call after the loop is done
+ *
+ * See uart_port_tx_limited() for more details.
+ */
+#define uart_port_tx_limited_flags(port, ch, flags, count, tx_ready, put_char, tx_done) ({ \
+	unsigned int __count = (count);							   \
+	__uart_port_tx(port, ch, flags, tx_ready, put_char, tx_done, __count,		   \
+			__count--);							   \
+})
+
 /**
  * uart_port_tx -- transmit helper for uart_port
  * @port: uart port
-- 
2.34.1

