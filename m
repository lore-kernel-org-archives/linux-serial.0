Received: from outbound.pv.icloud.com (p-west1-cluster2-host7-snip4-3.eps.apple.com [57.103.64.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FE4279790
	for <linux-serial@vger.kernel.org>; Wed, 23 Apr 2025 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745418453; cv=none; b=srI8I/sO+XnO7OY5zwjxZIDdr5sZ+HE5eqtk6TjoOc/9Mq1/SIEypfyJWdQJQd5mbnfROvGl8zDg67QBdRbYKtXnib4iN1AQx0PaiUGOH93yKvwiDWTCKMlujZihPTtFC88TM/ASw1K0nqM6MVDLyGv/DgQOEMrlAyu/rZ6UyPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745418453; c=relaxed/simple;
	bh=nXM6AtnLN1ZYma1X8iT5aCvbm82H6Km8UHls5cOvQwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=e+Nd3xnCzjubqu/vWqOOx8NCoJU3YTWXTgGLfjO7x8gtxLMkhvaM9U8v3++mi06sY4g4/uQEZfROzbuDO7LJYm+3ehYOD8r1XTIvbAK+mHfVN9a3lezLa+SMOm5C1rMoSOGmGzHH6xb1aBGhfytrq/jNis8mE0gBZbQ9l2ujjc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=l90t+uL5; arc=none smtp.client-ip=57.103.64.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="l90t+uL5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=8kCbBm/AY2YEx86pOWpcj7Bacq0Dl+t7vQBYVAMNewo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=l90t+uL5t0JUhuluYM4CfGZzd/4ElHfi0EpGncKalxCRRawtXnktgfNfn6aPTMOgf
	 UHAMiuN4iN3o9ZozX2tWBIWgkoUp2I2OsavtPS+q2naTIJ21+jrRM4WiCQ7j3cXZZC
	 eWHuRSSNxFO1sIW8+nETrEwLINreG0XOQ80T7jDZo6TntxQOX+ELZ+8SjSa0Kf9Ni+
	 3UGH6cVoB1DUDik50MwICZUpgKqjMFsgdmvJHAfmJIyjIo9cCL6HgZkbWk7F6N97ls
	 SUcYQtJBYmtghdTi0BFPnGtlGFAm80qV/VFYZEUyeXqnqI8a8+9qAaUBLKN6LMb8oJ
	 hZabAm7bOmVrQ==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id D409C18019D2;
	Wed, 23 Apr 2025 14:27:27 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 23 Apr 2025 22:27:00 +0800
Subject: [PATCH] serdev: Get serdev controller's name by dev_name()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-fix_serdev-v1-1-26ca3403fd33@quicinc.com>
X-B4-Tracking: v=1; b=H4sIALP4CGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDEyMj3bTMinignpTUMl3LlESQkKWBhWGSElBDQVEqUBZsWHRsbS0A3pq
 2tlwAAAA=
X-Change-ID: 20250422-fix_serdev-9da04229081b
To: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: q-hAJCDiicWJMw6D8RkcY1pff6e-Kkve
X-Proofpoint-GUID: q-hAJCDiicWJMw6D8RkcY1pff6e-Kkve
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_08,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0
 phishscore=0 mlxlogscore=890 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2503100000 definitions=main-2504230102

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

---
base-commit: 9d7a0577c9db35c4cc52db90bc415ea248446472
change-id: 20250422-fix_serdev-9da04229081b

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>

