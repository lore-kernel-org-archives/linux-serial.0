Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794424780;
	b=x07bsg+nUget+EQRNOYRshZb2hUrs7bgTrCiBXH1mnRfWuXyTLcK6XYiWM2WYMofbHAS
	 iSLIX9Wy17Ka8T8oF1FtT3+HSeJfEN+JC0HhNacHGcT95SsXzN5So1m+NyRwyqO/uLFgv
	 ulHvbKS5ZU5R6wQ1mvA9iz+DhHMzUuLfGAT2RH/KyDIfRRtAkmu7BzOVLtC2+J0clzLFQ
	 x5RJXXepd2NiN5GtwCEMk6at9CsSZAkz+jUxOm/ZIHW2krWT9JYk4C36SGzfwo7r812Ac
	 LRl6hHo07qQMvvArYcXUC3l/2gWQi/6ec6752B60nYCTGf7X/AbBAKNJA9iGrsV3b/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794424780;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=zLMJgZGyXVq2893oxSE6gXi5j/SSt9qL+lboxMV52CM=;
	b=hEREBkPqewVcWlygoIT/qC/jKkhwYVy6DVxtCvodw7I4nXLv5GrBaJV7eJOCfUaKdQ11
	 y7XD4iw6jsCSFcyLt9cOsdb8UIIbMhG054WStosaPn4ZQ4tceLwK0G/vHpWjtDvoKpzlt
	 +iK/aaFLP8T1eRRYUu8byPRBQOIDhmkZPzQaPRI8dHQwS4xE6O9VMad7oHW2LRaB1WcT5
	 MRVt0WJUbq/wXp6wIEhYleMd1R5+E1Vd3SeS6UVhhTWutFPwKuxBDT5c/Eyh8gI19KVvy
	 xOS7Sq5Rc+nxOXPmpD+d1If/x1mFSMriBAECnKIY1muC3dSjWv+Qh9on5zl2x3jcR+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=us1EEAwU;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC099606A8AF
	for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 19:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC099606A8AF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=us1EEAwU
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-490585eddfcso2758777f8f.0
        for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 11:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794424778; x=1795029578; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zLMJgZGyXVq2893oxSE6gXi5j/SSt9qL+lboxMV52CM=;
        b=us1EEAwUYkVwHm0jh989cNsr1foOYCFOs3Rl++Fg7Dl7gODq8dCV4UBKmbXklztK73
         y1eLBfzeGyNY4WStaOptSqClt3CuTgE44LLsqkYJJEf0U3xR55U5OMTotgKVPiweEhgZ
         UEYkSUIRwOzjtRcWK9bkye0P+P5stQAR8e+t6ITYSg1VHzmc4oSuXIblR7/wLgMvEgc9
         /GBbZ4fEtd0dSPBy+7LrXzYItDjnToVDAr6OLpBiYsoHgmN5JMPKsknwhuAymRUOLYWs
         VxMUg75viRopo5cWvqLeyRJAZMJWoH/dQ8tYHHL0dyxHXjXEANfAOPAaNbu5ODzg9gNP
         QziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794424778; x=1795029578;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zLMJgZGyXVq2893oxSE6gXi5j/SSt9qL+lboxMV52CM=;
        b=qzkmvzdfPmKIZ535QVjRWdXu1UiiOGjgLyCvvNmW9oUFNcsruW6gZBy5YGuizcvb/H
         WZFzPNmZTHx4Hy2gUrCUtcrWDTqv9xdboUkW14HgghPDBlUwXE3ySeSFjNsU5+Gsdnag
         DTVQsK7fkWsRVq940xa8L4M6qbjgC5de6JCPo6aLtnE0BYaqyYtnDr7FbQhzZ0Ou+PQD
         99CQkIHdRbatj0HLKMcuykgo7yJJrtxdymwm6Uat+siYwA8hfvKt56/9y1g1lef5bNLS
         zsJnmbjHMmrRiDk+a+6nI8HZXwmrjNXnANQ7YJ//BUHzKektgUVP9nlhim2nqnZTVtqj
         8xNA==
X-Forwarded-Encrypted: i=1; AL+hErFN+lE8mvTuNc0d6H0TcFWYclNEQEtFPhIx/0MxVx1ibnsvPfBDdzhkczACU2oMB3nS/QU5xTa950OcjDk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8cidEVq/f/jlo8YH0+h3QaSlOSwd7nCACOJHFTqiZkZxOt4I5k
	XzkGLonTMVAKW+XApyudRUNx3Fy0uqpTePQA4ho5lC2gJeMbEusHG10b
X-Gm-Gg: AYBFou2mU81FdsQLAs3ZAQ9+M7RXBIgRik4K8+UeKZ7ahPix6C4bflEFoaPYpya7RdU
	DLmnhs4gQ/i0EsKxtEj2ljJvBc+K1ZGqxtJEY6qm2q17r+5Hczxs6raQUda+SazrMWGXaxEtot1
	ZgtMswLa6pBL2R95m3yqZ/4o4n+xO6kgOjpkM23jdgboIS9bPKF+PNegoprhSaGQa0X/Inelju6
	5IpE4evQulmt9n/xkXpI7kw1NZiDq/a8WdvIzY1NFcbQD+pG5j8wd7kFtCfWYNtHnyVIN7pWJve
	BaGjiPjsyZEx8P+dcg4jI8hyE77ax4zK6kt3TCUlANd4o3Ue9Fsu7F3epGJ3RaJYDYd72UUNPIS
	3tIBjPvNh7yhSDj0KHT326tdqTjEaydM/1tAiJeAvPHvF0YeQz5x1AEfibEP5Je+vFFiQTLi4YO
	MbwSQJbHXNsvPxthCd8pIq+eDSs39+qeqeE7XjHUiGCXl87qxK6Xl1mJYvAhw1L9Tm1iFyktuhW
	yKfA91dbgtrAP4VK90Q6/9ahbs4o8Y8aWx35qtWzbl7kjrya9R2ZGN6uBnuOddBpyOw/FKuvr5L
	thRy4Tul8yJEmw+hSVpRO9YOKUO1+oc6hs2p6z3O72dSD6gJl24LuRFjO4ZACCb/aYI6NMnI2Eh
	b1FHKV+39l5Q0bLtxyRVb/3bJanaH
X-Received: by 2002:a05:600c:3b93:b0:49d:1fa8:b266 with SMTP id 5b1f17b1804b1-4ba093c512fmr64982705e9.26.1794424777994;
        Wed, 11 Nov 2026 11:19:37 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e267dcdsm9345305e9.11.2026.11.11.11.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 11:19:37 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 11 Nov 2026 23:19:18 +0400
Subject: [PATCH 3/4] serial: vt8500: Handle uart_add_one_port() failure
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
Message-Id: <20261111-vt8500-serial-cleanup-v1-3-b33594a25f87@gmail.com>
References: <20261111-vt8500-serial-cleanup-v1-0-b33594a25f87@gmail.com>
In-Reply-To: <20261111-vt8500-serial-cleanup-v1-0-b33594a25f87@gmail.com>
To: Alexey Charkov <alchark@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Tony Prisk <linux@prisktech.co.nz>, 
 Alan Cox <alan@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, 
 Wentao Liang <vulab@iscas.ac.cn>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1364; i=alchark@gmail.com;
 h=from:subject:message-id; bh=6MVluE0cGwPl4+DUsX6qfJLuLpTASBELCw1Mz2npDqw=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWR92b+f0Vrnfv6nd/x3/l8WdJP4umvfcfVH1RfTtoQlc
 e5h+Xrpe8dEFgYxLgZLMUWWud+W2E414pu1y8PjK8wcViaQIdIiDQxAwMLAl5uYV2qkY6Rnqm2o
 Z2ikY6xjxMDFKQBTfbWYkeGSha5a/YT3jaorImQVNdMzpu7d67ry5z0hM8uI51/+nyxl+B/Fn6k
 ntP/R5YBAtgz1j/dvtc3attF6SedHleYvb7gnPGEDAA==
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Return the error from uart_add_one_port() instead of reporting a bound
device for a port that never registered, which would keep its clock
running for nothing. Let devres release the clock and the remaining
resources on that path.

Set the driver data before adding the port, so that the probe can end
on the registration call.

Fixes: 304e12665a4a ("serial: Add support for UART on VIA VT8500 and compatibles")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-ce64cdae-9faa-4109-b7da-29b8a8c99e76
Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 drivers/tty/serial/vt8500_serial.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 17f928a7073a..7c7b4beb51fd 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -671,11 +671,9 @@ static int vt8500_serial_probe(struct platform_device *pdev)
 	snprintf(vt8500_port->name, sizeof(vt8500_port->name),
 		 "VT8500 UART%d", pdev->id);
 
-	uart_add_one_port(&vt8500_uart_driver, &vt8500_port->uart);
-
 	platform_set_drvdata(pdev, vt8500_port);
 
-	return 0;
+	return uart_add_one_port(&vt8500_uart_driver, &vt8500_port->uart);
 }
 
 static struct platform_driver vt8500_platform_driver = {

-- 
2.56.0

