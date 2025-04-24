Received: from outbound.pv.icloud.com (p-west1-cluster1-host10-snip4-7.eps.apple.com [57.103.64.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193A72367AE
	for <linux-serial@vger.kernel.org>; Thu, 24 Apr 2025 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745497437; cv=none; b=XMV7+2iCGZt7ts3c5y9f9DG+Zc5rNLMKnj58NV8/Taai6/Y3tDgV5QrilomwUCbOk+hGi4Dw4PomSIe/nDMwvDNZK392Gz0ASFHtcWcH70Qcz0EXu2/sr9iVCjB71d2+WsxMFUU4vNTh14cMS4xI3NcEXMvUKlKfhdFFnVDwUH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745497437; c=relaxed/simple;
	bh=xyn4t08/3/H1FQ9ERFo0iaNVmWPh8m4pr270tDN4EyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JZwTT4MnhTtgruHsZR89cHb1Q/nvdkm9zXg78PQ+4a9JLK1PQ+0ZIJzURLJNhvRnLrL8q+cKeh+knsEw/dLKOTHbL/TadKuV/ISzc8Ox9LCc00d5Bck41bux2O6LvW6U0gW+d1PiJNHoKPPvnnzaJhUY+2HMZayemiylkIyPfPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=P5xQbxtM; arc=none smtp.client-ip=57.103.64.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="P5xQbxtM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=xe6UzvOMcVAJcVfnvcPb6lA8c70wu+ep9ZsTAP9kDaU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=P5xQbxtM7HIUtV0N5FrgLVxLQ0gkPDz1kQkP5HbT3F/LwfVUtJ+4pqL342Isuw43B
	 iOuqtYRlGGqDczAYLRMRtzaUa6bX2n28cffb7riwhn1W5eitvMS0YCjZU1ffnduO0w
	 o8NxdGJcWwu0XAHpA8HYjUjEpmIDa+fvF1sSS5LXRg3C71nNBy2EHnGzuLB+z25N1n
	 mW547TGYpGBl5UwJnuiQ026AMrZbBlYvmMa5QWAeLeecpEn9bZehRFoBdSHLWqgF6v
	 FWObkiQD94sKgfjG8M84Sxt4/powLjazOYoV6vi46b8tU7KvRchNLX+ao+eo2cuX6T
	 zGM4Og5RWEMJw==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 42EBF180074A;
	Thu, 24 Apr 2025 12:23:49 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 24 Apr 2025 20:23:23 +0800
Subject: [PATCH v2 1/2] serdev: Get serdev controller's name by dev_name()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-fix_serdev-v2-1-a1226ed77435@quicinc.com>
References: <20250424-fix_serdev-v2-0-a1226ed77435@quicinc.com>
In-Reply-To: <20250424-fix_serdev-v2-0-a1226ed77435@quicinc.com>
To: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: lubaLBDmipTmHZWQt1YEeUV3N27OX-Pb
X-Proofpoint-ORIG-GUID: lubaLBDmipTmHZWQt1YEeUV3N27OX-Pb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_05,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 clxscore=1015
 mlxlogscore=958 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2504240083

From: Zijun Hu <quic_zijuhu@quicinc.com>

serdev_controller_add() uses hardcoded serdev controller's name, and that
may be wrong once user changes the name after serdev_controller_alloc().

Fix by using dev_name() instead of hardcoded name.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/tty/serdev/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index eb2a2e58fe78fbbdb5839232936a994bda86d0b4..971651b8e18dcbb5b7983cdfa19e7d60d4cd292b 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -783,8 +783,8 @@ int serdev_controller_add(struct serdev_controller *ctrl)
 		goto err_rpm_disable;
 	}
 
-	dev_dbg(&ctrl->dev, "serdev%d registered: dev:%p\n",
-		ctrl->nr, &ctrl->dev);
+	dev_dbg(&ctrl->dev, "%s registered: dev:%p\n",
+		dev_name(&ctrl->dev), &ctrl->dev);
 	return 0;
 
 err_rpm_disable:

-- 
2.34.1

