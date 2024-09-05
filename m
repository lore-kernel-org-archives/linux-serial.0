Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8800F539A;
	Thu,  5 Sep 2024 23:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725578400; cv=none; b=ajM1Keg2n4EEu163+sWZ8ak/cFjabx0dxsCQxSXd5zZ5YBsmYXBQ3Kp9EIHrgKe7nzLodhCwBXRaJfQGXBaKnCo8P8EwgsRIR//A7TIZj/bdIRNOyxdKuYHccZbn7VAnycE6q+v7DXmbOrxtNUE7IlHsEiEmUwtZKhgBHTCf3A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725578400; c=relaxed/simple;
	bh=+NunTpkmBYRoBN1XNK2zT4pOpEC19/0ndMRMJ/ku66Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vnzw4Ded1TjaigqjwV8K3TeuLcmBLgBrlPIh+d57qbuDFdGYf2Zd9M59MOV0XEQm6uRL2AoDMFb3Jzla/DsIRGQCw8UhqHVemYTmgmKOWaP3QsrJZmZ5itVfwKoNs67+akvC+OHWm8+06rxiHyKH2sllYy2FoafkqWY9ZRx23m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkkXVr7y; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkkXVr7y"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7d4c923a3d7so589782a12.3;
        Thu, 05 Sep 2024 16:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725578399; x=1726183199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pc+1NbaEgwk5DVwqgo8n+Ca095xZK1X1lzbgByBHfz0=;
        b=bkkXVr7yKQFx5W7OZ8/5FzDLU0xdzZJ27ANTlSLkQQIOw59zkR97+SG47rTizFAbvb
         dvXHh+YTdJ+SLRXUldop8qdPxbjgB04HK6J4tpIwsmFM4CTdKhuX6Wl7QfOw7dfcemT1
         6Qtl7EK33URmST1HugSBRF0OVjo1phAyTh20YUnffsz9PaYtnoerD2kdiUP6RTT9Sm8x
         mPGsQaSY8tXmczhlt1knnzGVLF06ABpLO9UtpwiX+SbjxLGn6xyYmUF6/6jnqip/FDUJ
         yAL854JMC/1WgyVGbpwohVtlIP3IkcvmJBvjVXd/Rivd04QCjDqBKxRSaagGN+vTNzsW
         BU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725578399; x=1726183199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pc+1NbaEgwk5DVwqgo8n+Ca095xZK1X1lzbgByBHfz0=;
        b=CI947f63WIAT1HH5yqkAhvR9Spd5lGPujJAEhTj25B4fvSLlbyN9eq6m2tpQuiqD7J
         1aWta5RrrauNzvDLOQAf2xQVGQH5Ch2XR20A8gT/1a4GVRacO7VDTgqGE6wO5zakGplm
         tmShhaVikwOVhFkgb6nSjKZG/Q6gV2TQxU8FTmLi1eqSfAPFFKI8o29p41ajgZR3it0R
         85yOVcpn3egXYJPQ6jzepf34Tueyxot3Srthb9UGQ1gQxKnWCnPhj+9FuajMB33ywDCb
         uDsgOGbXtQ+1rMEerJKKhqEgBVk6hSDVZRPkxzsYqDIiMnAqF2D6909ojyKcRczv6rvN
         QhqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoNpSxEwjp8wjpLs8WU6NZ/rNRAVsz3nXDcMa3HNQ504UWhnHFtliWTpH43xBwccNced+TX60o0a5z7Dw=@vger.kernel.org, AJvYcCWE8Xxnp5AwR3Q7fgC9GFbAT2QRS7oW3M2sezTsTO9NDvIv0o7g8K/aJWETmc5RqwRFk6UwwQf9Ky+GPDG8@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6G9oLY0G7aAdGY7YwvNjCswz2PD/v5IfHA7wtEMaHarn1prgB
	k0QFYf5f5XhWMB+bqNhfJ7hdR8ZH4W7AItUSPUNxj4BpXDGxqiL9
X-Google-Smtp-Source: AGHT+IFqhCSxk5wcCDKYA/04Mtq+TEYkE4BgR41Z/ZkxCK3FeA/LV4tEz4jSZ+yhxBoSq/bzW8Yfeg==
X-Received: by 2002:a17:903:1211:b0:202:49ea:b6e3 with SMTP id d9443c01a7336-2050c48f8camr244672755ad.58.1725578398819;
        Thu, 05 Sep 2024 16:19:58 -0700 (PDT)
Received: from localhost.localdomain (111-240-109-89.dynamic-ip.hinet.net. [111.240.109.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea559adsm33375395ad.215.2024.09.05.16.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 16:19:58 -0700 (PDT)
From: Min-Hua Chen <minhuadotchen@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Michal Simek <michal.simek@amd.com>
Cc: Min-Hua Chen <minhuadotchen@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] serial: xilinx_uartps: make cdns_rs485_supported static
Date: Fri,  6 Sep 2024 07:19:28 +0800
Message-ID: <20240905231930.343759-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

make cdns_rs485_supported static to fix the following sparse
warning:

drivers/tty/serial/xilinx_uartps.c:222:21: sparse: warning:
symbol 'cdns_rs485_supported' was not declared. Should it be static?

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 drivers/tty/serial/xilinx_uartps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 2acfcea403ce..777392914819 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -219,7 +219,7 @@ struct cdns_platform_data {
 	u32 quirks;
 };
 
-struct serial_rs485 cdns_rs485_supported = {
+static struct serial_rs485 cdns_rs485_supported = {
 	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND |
 		 SER_RS485_RTS_AFTER_SEND,
 	.delay_rts_before_send = 1,
-- 
2.43.0

