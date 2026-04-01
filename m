Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E81368275
	for <linux-serial@vger.kernel.org>; Wed,  1 Apr 2026 07:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775027281; cv=none; b=qGeWNz41fKdSMpdbuSyiQnHOgi766GehYI5OdsdrNheI/CpbEtghwSiONctc8EpJAXjJj8u7OV5ykGZWHkigfS24r0/BbNS6RDCTk8Nisas9T0HgAXEI8eJ3El35hDCO2TXpTnsAN1yBvH9mrSY6cDFnzAnO8xzDKTm3/S+V1wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775027281; c=relaxed/simple;
	bh=BSCNS1UNMXIGtFM+QUX7Rbto0UCstaR3LYY/zZnmgvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJ1OJbzTngdUT9oyrJNsRkw6ZDu+N5E0IHpqLNbBXJeMKajvlKAXqL0BTaAnzJXnFOG+e+TECUJQgg02DD6oDmdtMEwFVwGxQodbuG0uouZ2ZUaMNuiKklyuFbQdViELoHtfux0lZOguT+IpSvK6stpqjNZMM1eVTnHC1GkZCcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hxtuUiMV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NSLy9ZUT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hxtuUiMV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NSLy9ZUT"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6312U9Hi719069
	for <linux-serial@vger.kernel.org>; Wed, 1 Apr 2026 07:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=h6zxdLf6xUW
	szA6KhrhvifDZ0ndILcCybaBSzNjg60A=; b=hxtuUiMVdgvrUovJ6tJEdaYYz9E
	I2c7cYpZD2KHUFZrCBe3rEYROwp8345L6XyV8WUcqrW3BKAkG5kgGVhaJ0idN3s1
	khGeKmX7CNeYmasPtVkAd78i0b3O28LAAWFVI7cN76Tis7sCTJV+BE0iEqeCq1lN
	eUeuXnNARsJHpZ3kX5balEu4P/VtLMa//K/A2zzaON9NLId0PHP7H3dPpFDfZ0rK
	pbORauWx783oDWG2QBZQ1iF5OkFUaH/8yDhcihIXylA6IEPkPoC23hqSa2GSFPS+
	Ja8Qc0ZhgrXIbNyF+LnTe92F3jlJeGyFNgkBYtFRV2GWB5Ea6Forly4i6wg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8kcstr6a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 01 Apr 2026 07:07:56 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35d9f68d00fso10771534a91.2
        for <linux-serial@vger.kernel.org>; Wed, 01 Apr 2026 00:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775027275; x=1775632075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6zxdLf6xUWszA6KhrhvifDZ0ndILcCybaBSzNjg60A=;
        b=NSLy9ZUTLvHPPBqhpw5wPklQwgr+LJ6v/+Bvh71Oc2YPeRSgo0neI0TeILx4IaBz6K
         mjD1Cb6zC6GdHxjc5Hci2hrZxlH/7jtJiIAfzE55gpi4Rp7fi83hCqTJqlLnhcZ9C0Ej
         RSY8gGgeRaygT8atTpna6vsmoAPZQDLehhOs/fkOLaWGy96PF4I1wqHD0I9Q4Rd8DAnT
         c7f3pwQYcT9rBNq5Nfe0MSXEErJDesyuAZlhIHy33Lw8ywNpA5nn3CLAu7QzsltgwfF+
         NaAbmkBSj3UPnbJsBh69r/BHog73R8igqJ88+RWhxAVytmwXni+jfJbntcdcIIEOl7oB
         7z8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775027275; x=1775632075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h6zxdLf6xUWszA6KhrhvifDZ0ndILcCybaBSzNjg60A=;
        b=D6ar7x5E3wa7yLqg4YOU6ODpNH2x3OtRbNOScNmWskYH1Rv3FXwHzP9Hl8xEmHLSiV
         DLrcovpkELmu1xHj/z0uOZ6Z4tFXZe5kjY11aU1yEAzr6RMn5GDBmeeiuYDeiHrBuOJK
         3Igv+QElbrWv3y7SNScNSyeqDokMkJUcEaqeWjzpuDTiPEDGSuwGyXtbae7g53UPv3v0
         fP8d4Larj0+ZqD5rYqkWN9+kEkyr6Kk/x7BqAzb1iDTCjlTw0FLf8tzjfUJm7yfLeBE1
         9d3cXN6ID6JofkH0LePmugqcBCWN0FG+3uy+Xh8RyPJzBWOV5WZfFbNEOICFqH2C+s5v
         WZOw==
X-Forwarded-Encrypted: i=1; AJvYcCXf1+1AVHI+pD0w2JnaBBYTL6Psbwb7QIUCTCnnjfz6sotbzUz8pL/mxAmRelDhY02ElJ3BGDiWzZhh00g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYgOyakMHhJwiHLRwgq6wMFOGUnqJ5P3r1DWyurKjU/z+eYATh
	lct2UIJSR39EyplHTkz5SzWNRmswGilWrKWQkRSSI44xKqpDSNF28YI0W8U5iPtNIRIjexdyrRG
	9BTMpA/8n5nQbBCBGwQm4+r+AEGExL4+vVymY18B9iDRucWNdgaQ4Lre2cBIIoV/gogc=
X-Gm-Gg: ATEYQzyYHo/XYpzftrPXbsA6jppahqjwWFkHSkvF/tSGNPPdPhuwjVTgIceXkoYEjef
	h1qtApKx2MlFNRJfuGQq541YmtKMp5vwJCaM5EwFJr5iBCybQbDvZM4dt3Jw4JxNaYIp6yDGLgw
	CwYuhbclhb/BryEFkW36Z1yGKFHpuYP9RvC9nN6C84kqJRWKoCTigMgAGRtPT2cV6P6ptU9OhK+
	ML+Y+uaWrH1nhs5RkG4q2hBl/Kn450Hass2V2e3Hut6B643TibHV62YahNzNtv+KDVc7STXDkeQ
	WVEo8yesk3NL4gKuz7ZyCD7g+zaOGNYAvEVYBbMa6A9j9qYiNR6jctELkkNmYagTQFVZKt9K00g
	zGrHUk2EukbBByMvARKYpxcAnDKr6YPiXiCQZ
X-Received: by 2002:a17:90b:4b05:b0:35d:943e:3c2c with SMTP id 98e67ed59e1d1-35dc6e77ee9mr2279402a91.5.1775027275088;
        Wed, 01 Apr 2026 00:07:55 -0700 (PDT)
X-Received: by 2002:a17:90b:4b05:b0:35d:943e:3c2c with SMTP id 98e67ed59e1d1-35dc6e77ee9mr2279369a91.5.1775027274518;
        Wed, 01 Apr 2026 00:07:54 -0700 (PDT)
Received: from work ([120.60.63.102])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe6e2fc9sm3956464a91.15.2026.04.01.00.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 00:07:54 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: brgl@kernel.org, robh@kernel.org
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        mani@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 2/3] serdev: Add CONFIG_SERIAL_DEV_BUS guard for of_find_serdev_controller_by_node() API
Date: Wed,  1 Apr 2026 12:37:34 +0530
Message-ID: <20260401070735.107162-3-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260401070735.107162-1-manivannan.sadhasivam@oss.qualcomm.com>
References: <20260401070735.107162-1-manivannan.sadhasivam@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA2MSBTYWx0ZWRfX5/Alw6ZnhLeo
 koc7DoqkIBMrHfUI9k6JxCA+7SY3etIcqDzYPOegt7tjnlDi0Ep7EV7ElhDcvhF9BZHcZPuDdHS
 R8nefmAoFXl3Bt9HRa5Is2hJma5+rCws+2E2uKi0v9rW0M+lgqbjtYOuKi8UTT2FSsdZXXRiIAQ
 y9uDHg87a8mnZ2WXymv1x4rzbLtleeFw3F4KQBbk1knQUeZ/BDeozI8EreyJH8M+yFoLCqDqpnb
 MhhBpOQ4Fwo/HbgMjEahrwboRmsJPWoWaXNYIPfpVUYDKtS2BO/ybwwZPlU3IxfmUn+dtfiKcl5
 8N4x9kxnnX9k5GOEHu1B+VUIGUGXFg4EMDBY+HDkwe2AAn0dlXt/uQULBQBSGMTOlS/XmePmLHS
 tlnKig4k1BvUhSPoXfwBiCGiuwPFqt7VZYf8ALGzMS3p3rlpXIK3yFuDDXxi0VDzJ9rphEy6qz6
 PlEsR5X3YtfBVIPLBpQ==
X-Authority-Analysis: v=2.4 cv=KNlXzVFo c=1 sm=1 tr=0 ts=69ccc44c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=zTATW481NYPnotdwU90osA==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=b1-ATBUx8nBV-T_5hXwA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: 5hMf_4Auk1ThvqWllgBKGOjOEMAIxJtK
X-Proofpoint-GUID: 5hMf_4Auk1ThvqWllgBKGOjOEMAIxJtK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010061

Currently, this API is only guarded by CONFIG_OF. But the function
definition is guarded by CONFIG_SERIAL_DEV_BUS symbol in the .c file. This
causes below build error if CONFIG_SERIAL_DEV_BUS is not selected but only
CONFIG_OF:

pwrseq-pcie-m2.c:(.text+0x924): undefined reference to `of_find_serdev_controller_by_node'

Fix this issue by adding the CONFIG_SERIAL_DEV_BUS guard to the function
prototype.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202604011226.KGNn5974-lkp@intel.com/
Fixes: a2b4814190af ("serdev: Add an API to find the serdev controller associated with the devicetree node")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 include/linux/serdev.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index 0de261a26284..58f000534bdb 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -356,13 +356,13 @@ static inline bool serdev_acpi_get_uart_resource(struct acpi_resource *ares,
 }
 #endif /* CONFIG_ACPI */
 
-#ifdef CONFIG_OF
+#if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_SERIAL_DEV_BUS)
 struct serdev_controller *of_find_serdev_controller_by_node(struct device_node *node);
 #else
 static inline struct serdev_controller *of_find_serdev_controller_by_node(struct device_node *node)
 {
 	return NULL;
 }
-#endif /* CONFIG_OF */
+#endif /* CONFIG_OF && CONFIG_SERIAL_DEV_BUS */
 
 #endif /*_LINUX_SERDEV_H */
-- 
2.51.0

