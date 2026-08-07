Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446533D091A
	for <linux-serial@vger.kernel.org>; Fri,  7 Aug 2026 09:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786093816; cv=none; b=XO1MlP1FxvKcAj1sEBakFyZszMSXKn7ojh6xhOkjFmkltawV2YGt+ZxNO+aRzELZuHXFG4gdo5U7ANCxtMpOSzFNpev+EeJxP8ouuJ2K9T/DvHT3UnhciKb8+gnKtewJF9JHG2Qf8g5TSqa2HkhxWkjIkEq5Euxh22ezCKlCq/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786093816; c=relaxed/simple;
	bh=g8Pd3hLWXKDO1TxCxTibVOhcinoabj6frf5OHE6N6r4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ivnFgISgfLdOAiih8BByFI41bKufnez7Aehz5mwk/1xsmkjQk9lalqzk3zp1/2IshnvfNh1xJbM/pMGZDiQ56B9QQ+ROAgY3wEHE4HtR3arpD6WUdmBU3hOzcmRqYBrEczwHAdsRsdZyiMgwzUE/iZdvTiAonRivM/EPchAOhE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pWsZIzPp; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pWsZIzPp"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-848643382fcso3513547b3a.1
        for <linux-serial@vger.kernel.org>; Fri, 07 Aug 2026 02:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786093813; x=1786698613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ff2PqEjwL9/E48n/LYtyoRX7V3j9un3+kJnzZ64yyh8=;
        b=pWsZIzPpqelHngJ98XRM3q6m1VwfH3Au1wer4+wHds6MxvevrWaAIwAtB3vtxkmGj2
         K8NthasfzDwZS7huwZBUlL848HjDkkdjK8GnLvcvhy5tOeebTj1ncNXge8ecyRfIKiM1
         FzsAG9vITXDLisvDekxSLmKGoXKCAeTwW7Fqsq1zX4mrQaJmoXVLnYw2RxRuWBXM8UgS
         xswQkft3hM8zYi3ASOhax0FdIAIAhpBsSi8t3OgSsGmX+z6oPM97kw97k26h1yZ7HMQU
         TG3kFKWslNC1TTBDfM7L2I12e59TgeEOvI1dmO2xiEdtto/R7lqDEHsd+vh1C+DuvF0t
         FNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786093813; x=1786698613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ff2PqEjwL9/E48n/LYtyoRX7V3j9un3+kJnzZ64yyh8=;
        b=DaqRjXhe7dmPP/U+gUlEvDIu/jzjXKUueZ0VmqbJ5SRzWWUxSB1KvnvoFhmc1MmZvT
         8ctygIsL2nVYJXh8eXDejJGtO7M+1+gg68IoJmGEtgJknjFTXAIcaVTj79NkJ8dVWCVg
         pWDl9t1wpVRS6/zEaWjqc/3Ho4G+UoUlZzbfXeItXvYPjqWT/uXg+9j2I/2u6tGHkx8I
         O8xwb24TF1V2GVK0vjnM3hd6Ohkl4jSu95uAr2JHL0YbI4GYWVw7LZkIpsvdb9PsC+AL
         Gk6gPTwbCCgQG2ktFriD4XfDszUs6deCUGTTx98qB2LeQX2e0d8sUDC70fUcvOAh/9td
         i+sw==
X-Forwarded-Encrypted: i=1; AHgh+RrJgJJI6c+VPAlsDRzcf/NFM0gtUeWA3puCH9+D0YVe5Afr34SeE6MhAZSLdjIAixEIEeEHtkZj/x4WnkY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw35za+MAA6DRqwCGUhTb6P0HxkHA4q4gIGWxnGLX70JX/HTnvH
	OEYMq5c39IC3QiNndn7PrItmPOK03ATw2e43uACkNM8L3eWnGCk/Hd4u
X-Gm-Gg: AR+sD12pwr/IhH1DZdMOolZ1qenHTbmNUi2D9XTQRbaThPKqXo3t+sulcGXifdAa1VF
	XjsNJFq8J8CulYzVy1vHVYNQXlPwwg9pYIqC+/zGSsmFzWrc1+yk741YNEjdjHVWqyT/kVuLpMW
	Om9XHogHpWcsvylC6XIxv8t/WegNNvicZNel6qdW2x1qy+0CR3ynbI620dPAW365o8wjbfCzjpY
	MAgTrvzblorIAtYBs5FDQrSxUiFwb5QBNMRGV7THgf2XWXKo58q0ft7MLykPtmzXtKdEsH9g63G
	5ZPsTDlyJ6+gAR8nVJXsZ7xFQzau6DYjzt3RDwz8xSo8OmBWQB/YxVWHXzxZAjwI94TiOxYdzTi
	Nva4Ak0jd3Wjbuau+mrJ8nQxmzsDaJiEqidk3oBP8pBAQUu5W1lowc3aol4raEg0V7t/rVXZY1N
	s6+MAS8TsSPycARjNBddVenqt1Jq+8jMXA84w6tJx7CEh3WKYODgf5WsWc6GC7mYS2vNIc0NIY5
	qYJBD/osbMk5mz/6pVU5NLiP9OjLgYhtxZ1FlY+uSozsmDsDWE9c2Hby4wNSwSh3qDdVLNPGIbl
	Xdays/8hb7uxzSA=
X-Received: by 2002:a05:6a00:420e:b0:84a:6726:62f9 with SMTP id d2e1a72fcca58-84f2dff7c61mr26343835b3a.9.1786093813505;
        Fri, 07 Aug 2026 02:10:13 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a552859sm715908b3a.42.2026.08.07.02.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 02:10:12 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Frank Li <Frank.Li@nxp.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Yenchia Chen <yenchia.chen@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Zhiyong Tao <zhiyong.tao@mediatek.com>,
	Sherry Sun <sherry.sun@nxp.com>,
	Robin Gong <yibin.gong@nxp.com>,
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
	Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Zong Jiang <quic_zongjian@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Aniket Randive <aniket.randive@oss.qualcomm.com>,
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
	Anup Kulkarni <anup.kulkarni@oss.qualcomm.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	imx@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 2/3] tty: serial: imx: Propagate errors from optional IRQ lookup
Date: Fri,  7 Aug 2026 16:09:44 +0700
Message-ID: <20260807090945.41690-2-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807090945.41690-1-phucduc.bui@gmail.com>
References: <20260807090945.41690-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

platform_get_irq_optional() returns a positive IRQ number on success or
a negative error code on failure. For an optional IRQ, -ENXIO indicates
that no IRQ is available, while other errors should be propagated.

Propagate errors such as -EPROBE_DEFER and -EINVAL instead of continuing
probe without the IRQ.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/tty/serial/imx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 251a50c8aa38..4224454d360e 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2463,7 +2463,11 @@ static int imx_uart_probe(struct platform_device *pdev)
 	if (rxirq < 0)
 		return rxirq;
 	txirq = platform_get_irq_optional(pdev, 1);
+	if (txirq < 0 && txirq != -ENXIO)
+		return txirq;
 	rtsirq = platform_get_irq_optional(pdev, 2);
+	if (rtsirq < 0 && rtsirq != -ENXIO)
+		return rtsirq;
 
 	sport->port.dev = &pdev->dev;
 	sport->port.mapbase = res->start;
-- 
2.43.0

