Received: from outbound.pv.icloud.com (p-west1-cluster2-host6-snip4-7.eps.apple.com [57.103.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AB9247285
	for <linux-serial@vger.kernel.org>; Fri, 25 Apr 2025 12:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745585310; cv=none; b=KgEOsRGw3YlXV6PSdigj+ADQ2N69T9/5WYvW1Ayp7CFXwJg5LdeITdi06DCLp0dbE6aLNiEZAqxezew7lO2CCLHS9WnPcSxQTY07w0Dv1KvLABWM3uWirdTV22ZAO+uIjtrrCyoXpbmL9tuCq47Jx0EzxDPVRUwaffwYJef+e4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745585310; c=relaxed/simple;
	bh=ItpS2xzAPSqiTM6g+RYEGXCpDzJkoySyO6rgMQ7nBm4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TsIENo5d0aLglY40STtyChvRaxjH7koCqAcw4GDtk9Ujb69ZdT35UwZef70dQakLlDyrh9PjGWhYzCK5OfULfSqtixvTr5TXHkFNlPIkrbhP3sJu2PueKKymkg9fmQSJTMAu5U5MrT3IlZe2RmWiDacjVt7KYxaue9NNO9kE/E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=AYEPtaDk; arc=none smtp.client-ip=57.103.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="AYEPtaDk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=W+hPrG8Sv+ny5hQpRcrUhB/yLitYHoz8WmN/Jhjb124=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=AYEPtaDkVr91tES583vF/Aokv2OvPGvIngv1rMPo6KBL8QQaQ8VLaJoXGn1QjRqNO
	 mUvGJmEgGyBTWhJJDMDPo4JiFNKEVOY6zs8AH22yvNLwYy2eu4Ry8pytpLiBfFP+tU
	 KhAxeyWEmU//QL37S2ELlbe3lF3xMQWC3go/LwTrFAy2RjWAmCbiXWpgkjbLxpPvYX
	 ic5yJioMPilMMKTOfJwjHWGdL8jmoJqS/Xk1Wwbx8CnmEZNaRs/UuhgAammF0rsbRu
	 Z8a5YjdWoVk5MMzDagNB/Wd+hlGZc/xCZf6BCK3dk77fDH+BIA//zngsi95kYHjbTT
	 pmvYg6O9dqvLw==
Received: from outbound.pv.icloud.com (localhost [127.0.0.1])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 0C19E1800872;
	Fri, 25 Apr 2025 12:48:26 +0000 (UTC)
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 07AE21800869;
	Fri, 25 Apr 2025 12:48:24 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Fri, 25 Apr 2025 20:48:10 +0800
Subject: [PATCH v3] serdev: Refine several error or debug messages
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-fix_serdev-v3-1-2e4ea8261640@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAImEC2gC/1WMQQ6CMBBFr0Jm7Zh2WkBdeQ9jTG2LzELQVhsN4
 e4WEhNYvv/z3gDRB/YRDsUAwSeO3HcZ1KYA25ru5pFdZiBBpdBE2PDnkh3nE+6dmaa92MkrZOE
 RfH7n2OmcueX46sN3bic5rf+MWmaSRIlUWaO0UI1T6vh8s+XObm1/hymUaCnrlUwo0Eiiyru61
 qpcy+M4/gAjSGch4wAAAA==
X-Change-ID: 20250422-fix_serdev-9da04229081b
To: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2

From: Zijun Hu <quic_zijuhu@quicinc.com>

Refine several dev_err() and dev_dbg() messages to solve:

// hardcoded device name
dev_dbg(dev, "...dev_name_str...")

// repeated device name since dev_dbg() also prints it as prefix
dev_err(dev, "...%s...", dev_name(dev))

// not concise as dev_err(dev, "...%d...", err)
dev_err(dev, "...%pe...", ERR_PTR(err))

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
For messages printed by dev_err() and dev_dbg(), this patch series is
to remove hardcoded or repeated device name.
---
Changes in v3:
- Squash both patches as Rob's comments
- Simplify error code printing as Jiri's comments 
- Link to v2: https://lore.kernel.org/r/20250424-fix_serdev-v2-0-a1226ed77435@quicinc.com

Changes in v2:
- Add one more patch to remove repeated device name pointed out by Greg
- Link to v1: https://lore.kernel.org/r/20250423-fix_serdev-v1-1-26ca3403fd33@quicinc.com
---
 drivers/tty/serdev/core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index eb2a2e58fe78fbbdb5839232936a994bda86d0b4..0213381fa35876f43f2f10f6c444160cde73a686 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -118,12 +118,11 @@ int serdev_device_add(struct serdev_device *serdev)
 
 	err = device_add(&serdev->dev);
 	if (err < 0) {
-		dev_err(&serdev->dev, "Can't add %s, status %pe\n",
-			dev_name(&serdev->dev), ERR_PTR(err));
+		dev_err(&serdev->dev, "Failed to add serdev: %d\n", err);
 		goto err_clear_serdev;
 	}
 
-	dev_dbg(&serdev->dev, "device %s registered\n", dev_name(&serdev->dev));
+	dev_dbg(&serdev->dev, "serdev registered successfully\n");
 
 	return 0;
 
@@ -783,8 +782,7 @@ int serdev_controller_add(struct serdev_controller *ctrl)
 		goto err_rpm_disable;
 	}
 
-	dev_dbg(&ctrl->dev, "serdev%d registered: dev:%p\n",
-		ctrl->nr, &ctrl->dev);
+	dev_dbg(&ctrl->dev, "serdev controller registered: dev:%p\n", &ctrl->dev);
 	return 0;
 
 err_rpm_disable:

---
base-commit: 9d7a0577c9db35c4cc52db90bc415ea248446472
change-id: 20250422-fix_serdev-9da04229081b

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>

