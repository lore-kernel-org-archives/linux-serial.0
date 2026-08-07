Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0703D091A
	for <linux-serial@vger.kernel.org>; Fri,  7 Aug 2026 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786093806; cv=none; b=GbfM+L1KQk2vz5tXmspJusmHsoHn4wzIe0g8zbPussPmC7HIlicxYE+8ByFWPCBzU9wjD5reM8/+nYLIyox//8AQdNnLNjGd62zRsA9niKomapOxL4xXScLsx7gpWGvvkt4FfBIe54CVxqmcCQ6WdvNRuVe/BVMiXoqWnfeZdkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786093806; c=relaxed/simple;
	bh=fXE63t+reDfxE+sqDQQS8BlL8hfF9EAW6qlirdeQqlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I3WYO3khfy85BnCyuZ1yRxiV9aYebHnAK9BwuPllaCtRJTA9p2YvF9mJxMjSCVMSGPOVYk96qBO5GptAtBR8ycbzGRiznqifefKzkge7vgsFuIx7vaMteIY+sSMVZCCSn3ksfLAKk6fIbDHjazU4WnmM5D+mZSNfoxAoSY5Wsqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KU47NJQn; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KU47NJQn"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84e27035206so2413267b3a.3
        for <linux-serial@vger.kernel.org>; Fri, 07 Aug 2026 02:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786093804; x=1786698604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KIWGEh9Ufcm6qiadbjnDxFEVPk5jpDGnhvZvsj6Ps4M=;
        b=KU47NJQnEopEF+L4hTrqSxbEkxPT5dfuKOEOoSMbElijAsbEYZt5NENPUx6HvsXjJC
         IEIhzyHjS8Tvt9KhrLZE8rFymoDdyHd7ZRXTxLSFD6RmoiIrr3nNj2/V4GTK0nsvVdwE
         BPRO1Kc45KVWBFX3JyciOXJi6uJ7QoKJMUW0uwgTxV57+UojgITR9zdet3qWKaKOvJvy
         45/xlsh6YmSb/6sfxbpSeWTG/1F1kQJ4uAn6nBhqR6zEEEm1IDd88PAOi0JNQ65z5/a+
         CJHyXZzQiFN4B6EAaJLnnYIJrHV5Ni3PKJ1MJGWpdclULxOsz3Irro1d0NdgXTifNYTm
         /74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786093804; x=1786698604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KIWGEh9Ufcm6qiadbjnDxFEVPk5jpDGnhvZvsj6Ps4M=;
        b=qA0lvWzjuRGVEbBqU/sF2M6xu10+airbm58gJX8Ornt4pUD4M6PdpCCqSRh9y917EI
         CRSLwDx9jFF4ia+Kdf+Duas3J7jrMDNnHcirUm9CerKrJeSPSdxS1Jn50mqQJGCYBC/A
         LyraG8ec7n3Fa31mA6ZFLsxdrEgQy84GXTWbTGeDzOLREnS78wWrnYbFCVz9/lJpue+H
         xtWMUEmjvgwZPnxbw8MHHpY93KBS1k4OrP1pkxOv08jU8B2dJIoiVeZpSLeE1CfDc58A
         5zMaRDATkCm2/ACLvZhLuGLdpSUiD6yWkHH5asFo1LaMnhWg1I76SD9nbABHeYcI4j8F
         RcHw==
X-Forwarded-Encrypted: i=1; AHgh+RqsA1VEhTh/7Al/aZI/rWwINq0hyD2KVc7hDdnHR+AYIdmVUNCPm0QXOMNwSu47Vlsy1UBaJpcUHigbWn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YylCg1wSYpt1nIU0VsPJanLeFxPA+VPNHCmIDBcmG5pFwwOLqco
	zo8SjoSrnhVQkkRGafNxsxYmEx2n2a+FvFGMXvzQnbUBJiWwTLSUQKDo
X-Gm-Gg: AR+sD12BWOhUMGZw6saFdlziFjRYqJnQAv5Xc0Oz4TInpNcyXQ8Fth8CWmrqijzgvXz
	UFtHHPhnc+5oR1M8O0Zfgu4+r4pkO+whYUgB4/zt3uzABOzvj0XA7K+0ePVBMraxwMEZxGN57/p
	/2Ada5aEvnonqT1AX8wSahRvFCQHyi1i2hyA85WIq02gmSJ6z0oaVXCL4QUmWMONAK9/QImQanN
	nJgFBqkHJN0INqoONigWuvnzm+LPN2TBW9IMepjlvc/lunjrygg/QBRy5HEBcEu6pOmW2OU9q2I
	Fz6R6h0zU7mw8FtYoRvAwwhW4olIrO2BR2ULI2hdIKBpMjy5dRNZ9c34rPRInzOTwS9KvG/RAO7
	Qd/GunQo/t+qrM9sX0Zibq4Z/5d3UpPE3x8gHBZXnyLCTHPQGcRAE3vqdoD6/DaV9bhOcN3E+86
	IlQR//6pgxtwPqUKcnuhYw9loaSmOIzcXXeStoQjcSoFld6pQPABDSE4KFK+3f2U13Wm/Ai99I3
	54tieoCub5NIohr64Rd/1paTnI9Nch2HVu3wDTUVv543JllwgBEAoEfTDonapYP8o7cdXrpYKOm
	nlmZ
X-Received: by 2002:a05:6a00:a116:b0:846:bc60:5bf7 with SMTP id d2e1a72fcca58-84f2dfcf7f5mr24182425b3a.6.1786093804529;
        Fri, 07 Aug 2026 02:10:04 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a552859sm715908b3a.42.2026.08.07.02.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 02:10:03 -0700 (PDT)
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
Subject: [PATCH 1/3] serial: qcom-geni: Propagate errors from optional IRQ lookup
Date: Fri,  7 Aug 2026 16:09:43 +0700
Message-ID: <20260807090945.41690-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
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
 drivers/tty/serial/qcom_geni_serial.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 7ead87b4eb65..240a6d67d847 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1883,8 +1883,13 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	uport->irq = irq;
 	uport->has_sysrq = IS_ENABLED(CONFIG_SERIAL_QCOM_GENI_CONSOLE);
 
-	if (!data->console)
+	if (!data->console) {
 		port->wakeup_irq = platform_get_irq_optional(pdev, 1);
+		if (port->wakeup_irq < 0 && port->wakeup_irq != -ENXIO) {
+			ret = port->wakeup_irq;
+			goto error;
+		}
+	}
 
 	if (of_property_read_bool(pdev->dev.of_node, "rx-tx-swap"))
 		port->rx_tx_swap = true;
-- 
2.43.0

