Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81782264CA
	for <linux-serial@vger.kernel.org>; Sat,  3 Oct 2026 21:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791063115; cv=none; b=eh0qUhsIvwa8EvqyjJhiTPYNFvhOx4gGvhzQzxl6DzkbhbieOcTXnKNakorb7usmD5NftxoSw/hvRYkJmegpZkc7f11MgWcoM64huL4z5W2AD4RrZiGYhe+D+N0LbEng9qA7AmR30Cgi3g9MIQpd3uYin0AeKruQ9/B6j6x04tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791063115; c=relaxed/simple;
	bh=3IGIouzNerHBwDt2XZKFq7EhkZ7ohljzRYzr3vY2Skg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cHU7hEqhA6RdtNtYl8ZYFQ90RjB/G8p4FcDfBrTN9YWLmr0528Rajc1gqMv93CnDVfE2ubS25CnW+aAA3y3dKYLByyBv12MAbVf03YTKBvOc23pIx2FZVj5JKQToAZ1ByXjINoULhwOcgwvQfAQDJnJgTX16dpm8qlQCuomQ47c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cO1qEDJF; arc=none smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cO1qEDJF"
Received: by mail-qk2-f41.google.com with SMTP id af79cd13be357-93e49f4d30bso55456985a.1
        for <linux-serial@vger.kernel.org>; Sat, 03 Oct 2026 14:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791063112; x=1791667912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EF7nOMoHU/lXOBcLECCEmjeD1XvCzGTt0zKSXYTVC24=;
        b=cO1qEDJFBTZ8RbLpwOuMh1JIxExF3V/qbsYRFXR2/n08qpclkWkRrTLPcxGWazDYz0
         lmPavltJ24kckZOQvfDpvpFbw3jJTZ3IjYRBmPwuB/f6hn2yTvMLARJt0EJ+Ni2Hts3E
         ZoiLepzyGXD4wxrNtG1Stqh/FqwAiIe4Ed5JKqNDkSMmN+2tfRLqyk8vY/sdlC0kXz63
         qN6mFCSQsjbxgWUnjJV4QIxEtqK/QnmdohT56jgA2b+rZUN0Mu64VAS30YKWh+aBD2JO
         uVlZ4VRsxumD8LPedX3+ZOeoZxkMGvHcYVZ8GYMAD5RAwYEDGAZzaOhePQSyizuDLnIq
         KyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791063112; x=1791667912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EF7nOMoHU/lXOBcLECCEmjeD1XvCzGTt0zKSXYTVC24=;
        b=ayPgmU1kKmqSCLPSzEt8G0/D81E8cachg1bJhfoHrjhAwZOlDLh096JMNuprLW64OW
         gYHGZfyQjmBe3xbht+zjOD3Y4Qvzpa8DbPx+0VPnw58/SPkXDMSDKXRBUrq498+MFhhV
         d7UdnGaQfv6e5U0ElDK736GxyWU2htAyBvYBTUm+o49qGYTkyeH2kxGJQ1JHHq/UfFA3
         nBoZFZiZgNNzS5EvkBEjjS5GuM2qQ5MsOv3wK3Shbf+pFmyBzWjSCVSSauzIXM1Jfv5N
         lo/RPyseidmhyu/ZQTTLjQXIWv6jVr/JD5Ga1QHgtRoSt3hRB4XUtfQv7HLf1K47RV4Y
         V9gw==
X-Gm-Message-State: AFuF++lrFmiGL3YJHMgBJayXzivTWFFryJIHIC18o+kQC/6jL6Bx2nYB
	X0BcNX8mphdISpiXqlIzz18KPds3BQBNEEP4SDMR4YHyfZH+bf1GAsZPKTJxgEYA
X-Gm-Gg: AYBFou3Qu9VqlI1wm1Xk03ProsEuLjKt/58rbOkcHck3WslPuKa+BlgORDRC57Iveol
	ZykOPmfG8P/R4aF169TC2X8BLlTgxe0+La2DoaWsp22FPhe/+bfqFExPY45hhnouGaT5BYxD0d8
	LoANGveds3hrRu212EeFADPfP81/v2LERyiMiPcWEOqRlp0xh3RwSnUGoppnsRyq78Y+LHXCmBY
	h8CC0vscd+tZ0I/eCVCkfd1MM/wtPjYuvBVXblxaqPyrlC/cp+ryZyGdxkxCKT9AFuqltYOYNv1
	KzXCwpBJn05rD+/fa6ltS5kQ7rrnL1u5dkDoft5/SBcsiNeiSwWJlUqeSBKe2QTukp1Kdpc7QQB
	mS+4y0Rqhl6hVwo/ElXFT6I300vXuY6pzCCMjBpVg+kdaZxV6eyhYfNCtO5pbl+S3DAU+FBQYah
	2oU8LxPAwyDgUpd5O8Eoeyf/2s1OHQZwkQxh98/h5dPlKdglhJqXiRZm8mVgCT5qDcWAPTH7JlC
	+/Q/fIUxrZhY0tkpC9cOfg1qXdt7IG3Fsv+z7I/G6AzyqAwx3L3duyGk7X3NmR5gQ1SJqPlddgm
	l0PJCmtUXngxJ8Biz+HuwzkQcTkmEHC6OQxEfom6m2ulppQX
X-Received: by 2002:a05:620a:6190:b0:93b:f402:a204 with SMTP id af79cd13be357-93cf1787c37mr1300849285a.51.1791063112470;
        Sat, 03 Oct 2026 14:31:52 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca2c96f4sm526896985a.43.2026.10.03.14.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 14:31:52 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-serial@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)),
	linux-kernel@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS)
Subject: [PATCH v3] serial: hvc: use modern IRQ acquisition API
Date: Sat,  3 Oct 2026 14:31:48 -0700
Message-ID: <20261003213148.137206-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use platform_get_irq_optional() to be able to handle potential
-EPROBE_DEFER and other errors. Move it earlier to avoid having to call
kfree() on the global array.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v3: resend.
 v2: move call earlier to avoid failure to reprobe.
 drivers/tty/hvc/hvc_opal.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index 402da9e7c534..fb9a566ca213 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -13,7 +13,6 @@
 #include <linux/slab.h>
 #include <linux/console.h>
 #include <linux/of.h>
-#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/export.h>
 #include <linux/interrupt.h>
@@ -157,8 +156,9 @@ static int hvc_opal_probe(struct platform_device *dev)
 	struct hvc_struct *hp;
 	struct hvc_opal_priv *pv;
 	hv_protocol_t proto;
-	unsigned int termno, irq, boot = 0;
+	unsigned int termno, boot = 0;
 	const __be32 *reg;
+	int irq;
 
 	if (of_device_is_compatible(dev->dev.of_node, "ibm,opal-console-raw")) {
 		proto = HV_PROTOCOL_RAW;
@@ -176,6 +176,10 @@ static int hvc_opal_probe(struct platform_device *dev)
 	reg = of_get_property(dev->dev.of_node, "reg", NULL);
 	termno = reg ? be32_to_cpup(reg) : 0;
 
+	irq = platform_get_irq_optional(dev, 0);
+	if (irq == -EPROBE_DEFER)
+		return irq;
+
 	/* Is it our boot one ? */
 	if (hvc_opal_privs[termno] == &hvc_opal_boot_priv) {
 		pv = hvc_opal_privs[termno];
@@ -209,8 +213,7 @@ static int hvc_opal_probe(struct platform_device *dev)
 		dev->dev.of_node,
 		boot ? " (boot console)" : "");
 
-	irq = irq_of_parse_and_map(dev->dev.of_node, 0);
-	if (!irq) {
+	if (irq < 0) {
 		pr_info("hvc%d: No interrupts property, using OPAL event\n",
 				termno);
 		irq = opal_event_request(ilog2(OPAL_EVENT_CONSOLE_INPUT));
-- 
2.56.0

