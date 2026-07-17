Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023092.outbound.protection.outlook.com [40.107.201.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1DC36073E;
	Fri, 17 Jul 2026 03:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784260310; cv=fail; b=sycTV+osYQDgck4AcW/2V2MI8FD9zurXkjpKw0KEAeJ43aU2v1PGLAoNjB7Qlz2rWbYffciAfQSpU9AUiBHmUbaMANBb+dMJAeeXsFFGnVrIhhuTVahIWA90JO5I0IBn7BfecXziDkgkySk2eO4RmzN6nOjYVKIjWaqj4hJvSyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784260310; c=relaxed/simple;
	bh=WdFGARF2kX8BXdySvPWUp5znwXTIsofLBWjmpo3KbOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G1qJApim84WH3pWuOZFlv4VCDn0Zs6zDmFPI3TNTQYRUdWz4ogtK3tM2mC7pAOIw4jMqbMK6uKHMk2FKRL02eVgq0wcAKfriJpPb4hkYrkFoYwL/05UNQ3a6+SHEgU39RiFiPpKuMsNh92c283mdFxdOSR4EmyAhkTr3fFsFvEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=vxhprFry; arc=fail smtp.client-ip=40.107.201.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="vxhprFry"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfQxYtUQ52YKvLzCfuJTKCUPa+TKCzOHqoTe32rNWv0Smo72/xq+xpy2eslWL62xSvNdO9C7Ld0gs+nED3jCtRk6uUMFyiwKE7zeIJmHBO1zOe03KKK8GJ6qeeLewcM3HSI3kN2QpRB+J2cBjEo4KRdLL/Qyb9/Oyuy+YKTVJQx7ZK4LWumAec5oUmTjHFEZ2pHROPVtTgltBCA5e/qjQonQT0mhFqz6MTshWWHdtZBOLrsKbc0pnqskP93DvqFaIyjyQRq7lB2+btDYoiTH4JpLasvr2e46NeKwZMHLhALLlCi5CVngYrkGYP6og35sAy9Tpep613EpXfoyNVKLSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucqz1DdH+pq5YyApCMdUPrOqzlSlii6RVOaYtZHQ+KU=;
 b=v5+sRTEmndnA0dI6cpLoOrxr4tUZz79v4c+GwEuaCVPkJ0tpxxdZ5Fl1EncrTJC9BJA7Zqdaw0WawwNASBb31FQ/jy3of/6XBb0V2MX4SiTMfBXWqkmd020JZdrhdTDv+ENZXasEZf48bYGJWqyJt28FlqqrLpk9MIrVcMuX+cXtYmwpu9PEoBcDruM5nQOQ26zHoqMxKmvHetPoipytAJ5yzc9j3RFyKep0spiKY3SMvEakDWDKLUFjhqaHXbovNujBJ4auxSb65riVgWZxZuSb64BZQtqTlL4ERaV5QjRox3XNBh7A7A2iJYTGFTbIywl8ayR1EMGISeKsKKjSZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=amd.com smtp.mailfrom=axiado.com; dmarc=none
 action=none header.from=axiado.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucqz1DdH+pq5YyApCMdUPrOqzlSlii6RVOaYtZHQ+KU=;
 b=vxhprFrymCQUY/eeMRg6lcipfMpKj98D3EaDGWdTKDbWIyCeGMBe7+YkebsMuHJ+krAvPiTIGAo90XWEapayXrqoK0HGTBbIWfGkzGfJ98GhWqNfBkRUd/kRUfpZ+7Qe6kxLaLk6hMUvc2y3EZOGIe14GAtUovBhznAaP7puLw3iCnrbVyim9JJKo7SgmltjY/dkTickCSfoqNcaD/RxvuEwCftoZ9OyLsDtULPks1qpqSKcymH0CW+DRCiAqofctDh5kiB5OieuquhnXzWjQWILeavkEmFVZlYZJmcx8oifHU2G6CHzviMGX8UungHY/sSINjrKyl+vCvRoGYgfeA==
Received: from SJ0PR05CA0077.namprd05.prod.outlook.com (2603:10b6:a03:332::22)
 by PH7PR18MB5058.namprd18.prod.outlook.com (2603:10b6:510:15d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 03:51:27 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::14) by SJ0PR05CA0077.outlook.office365.com
 (2603:10b6:a03:332::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.4 via Frontend Transport; Fri, 17
 Jul 2026 03:51:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Fri, 17 Jul 2026 03:51:27 +0000
Received: from [127.0.0.1] (unknown [10.4.1.181])
	by smtp.corp.axiado.com (Postfix) with ESMTPS id 4BBA640BFE11;
	Thu, 16 Jul 2026 20:51:26 -0700 (PDT)
From: Swark Yang <syang@axiado.com>
Date: Thu, 16 Jul 2026 20:51:14 -0700
Subject: [PATCH v3 7/8] dt-bindings: usb: generic-xhci: add Axiado AX3005
 xHCI variant
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-upstream-axiado-ax3005-upstream-v3-7-c429095143ec@axiado.com>
References: <20260716-upstream-axiado-ax3005-upstream-v3-0-c429095143ec@axiado.com>
In-Reply-To: <20260716-upstream-axiado-ax3005-upstream-v3-0-c429095143ec@axiado.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Jan Kotas <jank@cadence.com>, Michal Simek <michal.simek@amd.com>, 
 Andi Shyti <andi.shyti@kernel.org>, 
 =?utf-8?q?Przemys=C5=82aw_Gaj?= <pgaj@cadence.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Frank Li <Frank.Li@nxp.com>, Boris Brezillon <bbrezillon@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Mathias Nyman <mathias.nyman@intel.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-i2c@vger.kernel.org, linux-i3c@lists.infradead.org, 
 linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-usb@vger.kernel.org, Swark Yang <syang@axiado.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=943; i=syang@axiado.com;
 h=from:subject:message-id; bh=WdFGARF2kX8BXdySvPWUp5znwXTIsofLBWjmpo3KbOU=;
 b=owGbwMvMwCHWlWK8+EozbyzjabUkhqzIZXuFfxyt6Et3idjhteBS9gNOucQt/MJrF1/N/p3qK
 /ya+/bdjlIWBjEOBlkxRZavOt/yT+Zq3+vcu7IUZg4rE8gQBi5OAZjI2gyG/0kHde58+yAUt+/w
 A7mf72OWHK2SMvDmixZfILi1au3kc+qMDLuamnqSZc60Mu9bOSmwYPZ1jhzGzd+/XZi3VN5/alb
 yHVYA
X-Developer-Key: i=syang@axiado.com; a=openpgp;
 fpr=F52CF66FC96D2BDE89BDA9758A6433A3D4830D5D
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|PH7PR18MB5058:EE_
X-MS-Office365-Filtering-Correlation-Id: fd1076ed-39dc-46f4-3aaa-08dee3b6ae0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|7416014|921020|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	K1GRQomQGo45GpF4hu6KFe70BvSErcZOw3WoQQNu1VE74nk2un6J/GhwiRiIFnduOPsccjEKmsaYgd/o705jr9KC7bGUN+L2gLSax45PrfYrRYFmjt7RYf7DRns7m0o5qt5Qk8duJyBL31q/DuW33MX64DoLBfZYIudNa/w1zrBxwRq+cYflA/qAbvgNuKVJS8KMmSzAjeJMO0UYb97m1w2TDyENhgqvQ9Vpvs9moqpAB5Q91SK45yA12PGySN2r7s7o8FLhU5xcUTCcBtmU0qc3nFhCwQHusB/Iid9PirEAphISeGXPtBl9eGCf7vZf2UX9HxFOlw8W8St8dv3aj7fQXbYHfjS6blt/u2RQSz4NVTV976ValVWvDkm3GX8ORaT84brThcjOF57IY+G3cUAO4UgR3Ryb92vvvNLHuLzRkOLHBbasJfkVPYRPU4QSNYopeDiuYalT1sw/81vhrixnkV8cK3O4+MvmUOX/EmSPMYF0O2USRDx7/wo3GuTv7+ndJaNasU0OSs8rGwAouZQxJyzrMruJkSd8LZxGFimFHaM/PHtNxY9Oez9SZsuwcMW8JgiMP22fcaCeR9BEXVgCXf/9fSk32IA/Kda5BN5m4y2fo7PnmyozpOcNmqWt4WEIGiDf9xRIeMcCHtI7RzWNJSEmCWRFl23JxOzI6bO0nrT9FfRbJb9QAp/TlsW9r8FUstd/IyDMxg7aqAezJtStcCVmw8NHejXojGwQTbrjgsoR6MAoogMP+znHP+t6
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(7416014)(921020)(10067099003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nG5tyO1C7kvM7eJbDcwxi0w7Q+073keoP5UOxdYlIrnwKT5zM84UYLtN2oOyYSFM7K3GvQUwKo6HrXOzwWy2f3r38uGWHDrGBxaRPzqqUVXJHl0qtL+xOQ+fpt+TSX69tVetcTj/odkoDsznTk/sK0cey5Vn3DR/ABk+aT53MLxndC8Etzw1NFtSWV8lIIcRQ0dksSwkvqXriYsZB7fOuKyumaqPEq4beVRaiaoUkZRlDYDmyAaoUUYBziYsOWVdq8+g+yyNWX7IK2FNJUM4YdSwsqMu8rNm+JXvun9lKi+wx3eyhIcd4XVi0joq4dLWkOZWWlW7oZEh5KLoZfAit8TfasaNPCCnZ3v6KOJ2AayNw95OBZMHSiQzq8a2AkDKFhH3IeHcOakeZ+oxUAPR1/uamvv+QDmNgadUtySbnZk8H/6d7CLSnKDeX0dB9s6/
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 03:51:27.6386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1076ed-39dc-46f4-3aaa-08dee3b6ae0d
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5058

Add binding for Axiado AX3005 xHCI controller. So far, no changes
are known, so it can fall back to the generic-xhci compatible.

Signed-off-by: Swark Yang <syang@axiado.com>
---
 Documentation/devicetree/bindings/usb/generic-xhci.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/generic-xhci.yaml b/Documentation/devicetree/bindings/usb/generic-xhci.yaml
index 62678abd74b5..d7fb0301fe4c 100644
--- a/Documentation/devicetree/bindings/usb/generic-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-xhci.yaml
@@ -14,6 +14,10 @@ properties:
     oneOf:
       - description: Generic xHCI device
         const: generic-xhci
+      - description: Axiado AX3005 SoC xHCI controller
+        items:
+          - const: axiado,ax3005-xhci
+          - const: generic-xhci
       - description: Armada 375/38x SoCs
         items:
           - enum:

-- 
2.34.1

