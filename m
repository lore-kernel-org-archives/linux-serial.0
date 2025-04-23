Received: from outbound.pv.icloud.com (p-west1-cluster2-host2-snip4-1.eps.apple.com [57.103.64.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A3E13BC0C
	for <linux-serial@vger.kernel.org>; Wed, 23 Apr 2025 14:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419278; cv=none; b=mRgshbZAeyB1w84cjjQsmsxFJ1zMAimFQ8Fnhat2kkm25wx/6q2MH4U7uicQzdd+y9RaBacHINof7Rm7JbTAKKtXyhT04vMp/vNK+yK7qHo0K2Vhxm3+NRNBFOVVNxLtGD/GEl4pROR9oAxB9fCxU7a9VxWvZdRlloF22yVrIL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419278; c=relaxed/simple;
	bh=zErhtI3a0XzGBOiMo0E5nQ9ED7Ta0ruzPDfrjh7EFAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Fp2fQJxFNWdyE7G4fAjj19P+Dr0IqtASG6bJ6yUzittJvU77SeTZI8zCZdFdVlkDMbX1xvP9q1uoHJgNdNapAuquPRJyiEAsuSqgvolqn9lZnQcKM+D9pmJeC1scpfDxqOIja5QkMjcPT7A8pZpkGwM2nfFxXaSNIwSJ0mqdTK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=EF/UBBn+; arc=none smtp.client-ip=57.103.64.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="EF/UBBn+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=OFTUbeC1duWE3NcbJV6ltGL1mi1k8xQIxToGjB2DcOM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=EF/UBBn+Szp+r56Tgs60E4q5LFMtwNrOAqTFE+ysfJQmJFxE1kbIcIEs40UVhRn6x
	 YNnHZ5uXdAmnObY+atZs8tgsQGaNmPUw9yTN0ECiZWZKtOLp58HOKmo38PL4yokeEG
	 yI8secp6CjUqQwsK+uCNUKn1KS+oNkVP3cZ6sCBOviBK/5nFWq8YzjlDMgnrcFNiLX
	 rkQCnSOhSqkjOEn7DFNCrUIDGTfD4KzCMTNiS34MHvE58yAfBnCSMCzjpz52HSDSEJ
	 DLR0wJXEDw0asdF7T02r3UNVG3oNYhm5A0bjI5QgP/zMPOnUX+rOxeWCD+J7ZtabNy
	 VeImS16qwlKoQ==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id F070418003B9;
	Wed, 23 Apr 2025 14:41:11 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 23 Apr 2025 22:40:56 +0800
Subject: [PATCH] tty: Remove unused API tty_port_register_device_serdev()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-remove_api-v1-1-fac673d09feb@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAPf7CGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDEyNj3aLU3Pyy1PjEgkxdI9OkZDMDC2MDC7NUJaCGgqLUtMwKsGHRsbW
 1AAhQZ2dcAAAA
X-Change-ID: 20250423-remove_api-25bc6083086e
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: JyRHJ_qnXfICI58kySRXI_kuIX3VS6EP
X-Proofpoint-ORIG-GUID: JyRHJ_qnXfICI58kySRXI_kuIX3VS6EP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_08,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2503100000 definitions=main-2504230103

From: Zijun Hu <quic_zijuhu@quicinc.com>

Remove API tty_port_register_device_serdev() which has no caller.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/tty/tty_port.c   | 20 --------------------
 include/linux/tty_port.h |  3 ---
 2 files changed, 23 deletions(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 14cca33d226930f56ecbcce0d8ad8e90df8eee4f..4af1fbf73f51ca6eb321e7bf507a1cde74442b89 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -199,26 +199,6 @@ struct device *tty_port_register_device_attr_serdev(struct tty_port *port,
 }
 EXPORT_SYMBOL_GPL(tty_port_register_device_attr_serdev);
 
-/**
- * tty_port_register_device_serdev - register tty or serdev device
- * @port: tty_port of the device
- * @driver: tty_driver for this device
- * @index: index of the tty
- * @host: serial port hardware controller device
- * @parent: parent if exists, otherwise NULL
- *
- * Register a serdev or tty device depending on if the parent device has any
- * defined serdev clients or not.
- */
-struct device *tty_port_register_device_serdev(struct tty_port *port,
-		struct tty_driver *driver, unsigned index,
-		struct device *host, struct device *parent)
-{
-	return tty_port_register_device_attr_serdev(port, driver, index,
-			host, parent, NULL, NULL);
-}
-EXPORT_SYMBOL_GPL(tty_port_register_device_serdev);
-
 /**
  * tty_port_unregister_device - deregister a tty or serdev device
  * @port: tty_port of the device
diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
index 1b861f2100b69f120971c7dd503d6635db1fb468..08f89a59836621b2c8864c46c4ed8883b3f9045b 100644
--- a/include/linux/tty_port.h
+++ b/include/linux/tty_port.h
@@ -147,9 +147,6 @@ struct device *tty_port_register_device_attr(struct tty_port *port,
 		struct tty_driver *driver, unsigned index,
 		struct device *device, void *drvdata,
 		const struct attribute_group **attr_grp);
-struct device *tty_port_register_device_serdev(struct tty_port *port,
-		struct tty_driver *driver, unsigned index,
-		struct device *host, struct device *parent);
 struct device *tty_port_register_device_attr_serdev(struct tty_port *port,
 		struct tty_driver *driver, unsigned index,
 		struct device *host, struct device *parent, void *drvdata,

---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250423-remove_api-25bc6083086e

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>

