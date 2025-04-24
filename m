Received: from outbound.pv.icloud.com (p-west1-cluster5-host11-snip4-10.eps.apple.com [57.103.66.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152CE233149
	for <linux-serial@vger.kernel.org>; Thu, 24 Apr 2025 12:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.66.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745497431; cv=none; b=IodXfXfVqfSYAYSz6cUPKoUk/DivEUyBbrXt8wbplwnOKBazLQ7nW4hfSxAWBfcgSnZlt0vP3AbU9l9fbOshN3/VTobHnUiXP2UPgV0/XQZOBrnyks526mOJMefCASLOEH+kdhVc8CDq+mfOuNIp0e/SKnrvACspfZFtHr/tUT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745497431; c=relaxed/simple;
	bh=vRjj/i8ZOSlYnCFeskeFgXiGkimGvV7t+REdxmOwCNI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s6qLfeHRNR+kkQx3WetecMF51v1wsx6ta2yTQFeb7avLmgRvKxLmMD5kLMHrNWCyEvbCGKU89yG219HtszVlZL4r8D252pI3dNTvDOXFY2CocbulEEaeJTUSO7MnvPiFvTKnDejtf2oSN+L4eQgVzf3zliqngGmZNeXr68TiZpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=gRPQWx3Y; arc=none smtp.client-ip=57.103.66.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="gRPQWx3Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=6PnP1PRGPyqBE9H2lWN8SRFczqyqTI7hAzJh0Q3xVs4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:x-icloud-hme;
	b=gRPQWx3YHjXn8qaTkKHLlVNdXzvMQPeHl2OKyqQVdt99/maPT41NWcwNU8YWsjQ3M
	 x9d9hCBvo1nQoyIJlA+XTST+VVfMmtm9YPOtp7rqmYBQGR7tK0LuZFsLPpQ71NmFrG
	 LI/sUmD5s62nemDWouLS7FLwcEqghNtdjucZBYDzF33iO1MhffnLepSTSdHH7u8qtP
	 NpdDkfC/QdOK+MhONmDcgxjeOneEMVwHCc7jyf3FgSKJVmrT5Ih09EoEQcn9+DozRo
	 mTPU1NQh0xcMXPMbvz9Dc+jvGATTpK39neHffK3dYNUmWmFcpFxi5ChmQIr+bgl28+
	 vVqd8iQOVIGIA==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 2ACD21800322;
	Thu, 24 Apr 2025 12:23:43 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH v2 0/2] serdev: Improve messages printed by dev_err() and
 dev_dbg()
Date: Thu, 24 Apr 2025 20:23:22 +0800
Message-Id: <20250424-fix_serdev-v2-0-a1226ed77435@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADotCmgC/02MQQrCMBBFr1JmbSSZVLGuvIcUiUlqZ2FSEw1Ky
 d2dFgSX73/emyH7RD7DsZkh+UKZYmDATQN2NOHmBTlmQIk72SKKgd4XdpwvonNmmTp5UFdgYUq
 e3zV27plHys+YPmu7qGX9ZfR/piihBO6t0a3Ug9P69HiRpWC3Nt6hr7V+AdAyVo6mAAAA
X-Change-ID: 20250422-fix_serdev-9da04229081b
To: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: w1rPZ1Fxh_qcoYXdD-N70T4KrOYfXTtd
X-Proofpoint-ORIG-GUID: w1rPZ1Fxh_qcoYXdD-N70T4KrOYfXTtd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_05,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 clxscore=1015
 mlxlogscore=508 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2504240083

For messages printed by dev_err() and dev_dbg(), this patch series is
to remove hardcoded or repeated device name.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v2:
- Add one more patch to remove repeated device name pointed out by Greg
- Link to v1: https://lore.kernel.org/r/20250423-fix_serdev-v1-1-26ca3403fd33@quicinc.com

---
Zijun Hu (2):
      serdev: Get serdev controller's name by dev_name()
      serdev: Remove repeated device name in dev_(err|dbg) messages

 drivers/tty/serdev/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)
---
base-commit: 9d7a0577c9db35c4cc52db90bc415ea248446472
change-id: 20250422-fix_serdev-9da04229081b

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>

