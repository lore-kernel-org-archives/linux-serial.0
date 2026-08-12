Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B1246D57D
	for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2026 15:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786548389; cv=none; b=eoelT4DWQXzsza//FtF5+YgWL6pNC4uiYZlx6mbb7cSQb36ZyXtwtAaQajH8r2RmctbLkizCPbYE8LXzYFkZkRRa3vRrAZIMNIYHKlKEHUJK1ULdUuj3m0+dgyVJs8ogGhuQnWpsKY7qPNOJ+9zPxXmbab+O8mAIRh7cZdD62So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786548389; c=relaxed/simple;
	bh=XSnigZ+8lXrN+h1DK2jDpYLe1HS1P10Q0jBZkBu9EDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L322JAvxm2Nz/FOp8u6ABLO42r09Evj1wP9ltSs6J16lsZWpCn15i4wD4xYHmg8/mEi4lzkJu7pNfYgFeTEhJcm1RmBvbpEYcyJlx9+7GhRFT6kERJpg6RWg0kn5Rbfu41O1i61C7X+d9+29qF0WQvhV0osN2gqH9tfYmc3Dp4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Uq31LRWE; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Uq31LRWE"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f633e6058so930443f8f.0
        for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2026 08:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786548374; x=1787153174; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cxaMCj/rMllaU9X27TX8pfm9p2Xu7HVXmrHtmXljmm0=;
        b=Uq31LRWE8sGvyZ3MDKVIankghp5dwvHfXpEZX1D8ZOvwxsNZWhBY8/nllRv07ISPSY
         pPBXYuvyVDBmpJDQ6flkfCxHo9UGkSX/RFiMaXAMSitETgtEFIGR24qvo6jLEUoduJ2E
         tBFlOob3xyoVY3TwhHOoUHjLzgD4cvONdx/if9Ryhz8an5mVbOS86mdBDTjDSXuvzbTR
         M2EcTlwmrdJTrWyBVBThob+M1IENg8I4LF/3loHXF9xvsl+nq+PxsPOz20tSWRxF4NzU
         AQtJF/VQRli+Ec4GxU63ofRpeOlcnxOt8mMpqYYxWC9IfyKNQ/m4Chwnhl6mic3ZWo7e
         2RRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786548374; x=1787153174;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cxaMCj/rMllaU9X27TX8pfm9p2Xu7HVXmrHtmXljmm0=;
        b=Dsr5DBRpK621fW1vwlLGfhbJsoqE6Ib2CC4iHgsc6a3TQ0jukZqLAq/eMNiOhwrguY
         mOSNA0deCG2PrnjsFKJQzMrbwN/NCRDu2cvr3Ii/swsFDo/qsR8hkxpDpbWU8KcU53bn
         Chdd73iN5STfrEkMUGnhMe75DJj88MPWuN5hGYlZopifrBg0FogsPfSKPqstrReL496a
         kvDhxBPxZBcmp3MNzx9qqCHuTQ+xN/3xo5S+HYL+r6vCNxSUqmimXgh7sYKlaLZ8/zN+
         qYXql7ZmMtAILVB+dBCDawfm3gUfqxZWTE0YRMHTdRsNiadvqdjQWA+j30gnHT2K4zeb
         qQ5Q==
X-Forwarded-Encrypted: i=1; AHgh+RpzpxrCEu82ZRIvdqDnqmBvcwl2IPGYC15TBb3viR79w6+NqHDgS8JXVPGomq2uVvCT8fqR4+DJJiiF+fM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCmeB2+6uSgfkt4kmHs+4PFqEoFgG5Bkdnjh3IJgWhC2+FGm+n
	zzSiSvmdYV2WRAHcYc57hT6u9JYZ14ANRr4YaXO4YfiVu6UuDmom+8siKrwJB6HOL3I=
X-Gm-Gg: AR+sD11HoDpbHCTIrM9zIH7bj1ck7ZOztF9FKQ8vLaElzcSrzFstjni+tYbnn8gz6oU
	seHMlDV+G9Rday5SaogVZ8KW/Yaua+MVyKBHnF5raVmfMlbYd9WS+BCWPN9nTBrC8P/1BcmdRFG
	KZyC/pkTuH9zkO83mhtLm5nnrzAtn+uVD4znOlXKeDYEggKcizG0E0XL/hVkzRw/A3lqkhZZgxA
	XHr8uONYdis8v1CUSnp462YlsqidzZFvT53h3QBuX+WRm0S3TZp5IX1yoya9lPgdnHt65gMAzaS
	WQ/dRFYz13xGAbuwe5d/GlPYU5M3Jg8nrYbsgwmAM4ob2YXNRlL7NiqwT2q1Ah4OKtx3tMHVKmK
	06FdA60U1UtAsXQizTNWD4uImmdgKhhaT4yzvwMrKal5m9X/y7R1y7coRbynrE3cpjKd5DrFe22
	MuDRXuosHMFOkqkNBWlEnSflagAhHX0gtcEaKWcCOA/EGvFet4VQ6aglLe6VjHTJqJy8R4z3wYT
	nncmS9nMiQHXUB/YsgOX0aP1OKrDdY7+2F2eM4zBIRA5ianM4w=
X-Received: by 2002:a05:6000:4607:b0:47f:9283:1fb3 with SMTP id ffacd0b85a97d-48152775015mr8986415f8f.0.1786548373922;
        Wed, 12 Aug 2026 08:26:13 -0700 (PDT)
Received: from localhost (p200300f65f017104d1b8d865063c5703.dip0.t-ipconnect.de. [2003:f6:5f01:7104:d1b8:d865:63c:5703])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48150d5eb2csm7883241f8f.30.2026.08.12.08.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 08:26:13 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v1 3/3] serial: tegra-tcu: Make use of devm_mbox_request_channel_byname()
Date: Wed, 12 Aug 2026 17:25:54 +0200
Message-ID:  <f641b6d092d1ed92e27f521e9028b5d1da3f63b4.1786547950.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1786547950.git.u.kleine-koenig@baylibre.com>
References: <cover.1786547950.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1952; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=XSnigZ+8lXrN+h1DK2jDpYLe1HS1P10Q0jBZkBu9EDM=; b=owGbwMvMwMXY3/A7olbonx/jabUkhqyaCW05MloPOQubfn23d2jb+0LTJa867t2Mp9Led1mdP Rc5n5HvZDRmYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTCBTGLg4BWAiJjHs/6xUnUyKfsdoqjGE pKae2nmkPWz9qqO2lV89+ruLW7ua8yY4GoTn/bCS3zg7+bfCjflnM8+aBqYvvnlcLP64eQhDeqp K9p0lPltkcng9TjzllxVeXbPhY+n8zZsXF9/TlJt69vnat3MyQ7tjg+5k8J5aVqwR+8yxMX/HzK zNKa/arHMEXKseNHL3nC7ZUjvhSubyz/zTH821c7J9byJuKGb4sbhX2UrykqA7m4ZVq9wdC9WzZ hmOBRv+JsbP4Q5onHjjL0PR6r+anq4XdF0zGuXc9fwnK8lXsk54MaEgYJ9r97/MdUVpkTVdNQUX H0ziXh7AeOuDpt6Pv3L9vgUTBSJd7tZteiNWonAr5SMA
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Simplify tegra_tcu_probe() a bit by using the devm managed variant of
mbox_request_channel_byname(). For the rx channel the function cannot be
used without confusing the order of resource freeing.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/tty/serial/tegra-tcu.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/tegra-tcu.c b/drivers/tty/serial/tegra-tcu.c
index 077023ce1842..a3596ec24d34 100644
--- a/drivers/tty/serial/tegra-tcu.c
+++ b/drivers/tty/serial/tegra-tcu.c
@@ -190,7 +190,7 @@ static int tegra_tcu_probe(struct platform_device *pdev)
 	tcu->rx_client.dev = &pdev->dev;
 	tcu->rx_client.rx_callback = tegra_tcu_receive;
 
-	tcu->tx = mbox_request_channel_byname(&tcu->tx_client, "tx");
+	tcu->tx = devm_mbox_request_channel_byname(dev, &tcu->tx_client, "tx");
 	if (IS_ERR(tcu->tx))
 		return dev_err_probe(dev, PTR_ERR(tcu->tx),
 				     "failed to get tx mailbox\n");
@@ -216,10 +216,9 @@ static int tegra_tcu_probe(struct platform_device *pdev)
 	tcu->driver.nr = 1;
 
 	err = uart_register_driver(&tcu->driver);
-	if (err) {
-		dev_err_probe(dev, err, "failed to register UART driver\n");
-		goto free_tx;
-	}
+	if (err)
+		return dev_err_probe(dev, err,
+				     "failed to register UART driver\n");
 
 	/* setup the port */
 	port = &tcu->port;
@@ -260,8 +259,6 @@ static int tegra_tcu_probe(struct platform_device *pdev)
 	uart_remove_one_port(&tcu->driver, &tcu->port);
 unregister_uart:
 	uart_unregister_driver(&tcu->driver);
-free_tx:
-	mbox_free_channel(tcu->tx);
 
 	return err;
 }
@@ -276,7 +273,6 @@ static void tegra_tcu_remove(struct platform_device *pdev)
 	mbox_free_channel(tcu->rx);
 	uart_remove_one_port(&tcu->driver, &tcu->port);
 	uart_unregister_driver(&tcu->driver);
-	mbox_free_channel(tcu->tx);
 }
 
 static const struct of_device_id tegra_tcu_match[] = {
-- 
2.47.3

