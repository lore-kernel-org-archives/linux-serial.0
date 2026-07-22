Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013000.outbound.protection.outlook.com [52.101.127.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8807353EEB;
	Wed, 22 Jul 2026 03:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784692014; cv=fail; b=WfV0+lqgr1jaz97rCVHuVsYaYy7e4nGALd11kt12O2HCR4aDJ3p3NPPLcwN/Aj4FQiU3X16K0fj28A8qWVMSDFVWJbfNLRZI0cFseRH1P+2BaiCy4lBp2Lz4C4D0RiYkY7krvZ5r56Xo3qamdeMB0A3fvVlCQIa3rDquhf+pJlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784692014; c=relaxed/simple;
	bh=t/U3R7QDxza6dWO2ZVVBCR6qC1nbEvYCe0umneWbYqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E1PU7DS7g0enBHTGBgyN6oZlCMpEdt3qYg8bCPtgD0H0yDtN2CqbLvB7JkUexdIhVrWiqxxrqtIZMMyQmHwxThjcKtC/01XAh1eS8UNygk1Q+/DRpVxvUwnzNHb5PEj7KigAbwTc7j7J2v7JjNy+Tar/B1r8ez8iLYnTNIpZxFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=H12FtwFf; arc=fail smtp.client-ip=52.101.127.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="H12FtwFf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t9qdMMkWc7IVUoI6LNjvHHlC+kUJUpdioWyDAQ7RiFl8/EGMbqIlnEtF2VkEDgaN5Y8eeXrV483xhc/JPbQHDlWlbzUwUoY5XR2Rtb2cj8DWEOAeh1Vu9a4h5ZW7tm/l9fbfSbJfOFd757YzSJlchFaphHOSi16tz/W4h0M6SNju/sIKIH9D1FIzJq5XpPVJNsxaExC2u+CnJSdAAsfTLS7jfZGZUByFbGcvHFoEFh15pXDze8397JNap1eTHy57I3Zhe/cfoOcB4yroIyFJk81rBnt2+2K6lqR4I9B4ZKzStxDGWhkY7QKi1hzm3qhNQM6FxCW1BCfvrYFq67x+kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mXb72vozSrT0IfdD1hAMlbl8Z7Fgp4Cg+Gvfb3bZ9Y=;
 b=MS3vnb/mp3+VtH8g74+TXBbpdMhDGD7JvzvLR7qhBYVRgzj4u/5sEKpIOI3spEAGSVVZVqxrK7Nh9jmg5xiBu96I0XwPqyKJ6goc+sMN0p8CtPJMn5LHbi0y3O1SVqJXSaD+3lGJF0YfuG87luoDZf16bfpMN5UU/j7Di72jTtSezbcq0gIS+lXKXV2H21afzKzoohB5KpYG3fOSdPR1kLA8XYcx4fvIWy3Cev7h+L3754U56+LL9kv5hEHzN57N4mf/e+VFPM3BJdS3exRhrQ41PWRj9CRml2sIp0jPD5WWx+qCk5VnJYWvRklgSwpIO5b4g06TFNCBIUZKthR/zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mXb72vozSrT0IfdD1hAMlbl8Z7Fgp4Cg+Gvfb3bZ9Y=;
 b=H12FtwFf3rzFaF48nMNKJgSOacKK9aBWgO0uXDNfMHG4oAO58qwGRZnW8yIpnz4MWwILpoLMBjF3rmNX3lrSFSdAFcukG+UNqOJudKKemtAv3Ha1MU6iKWA5MiJAvUkO7r4v2O/EvAW4tQHGZIbrHrbekKcG/D85tpK9ijf1+OtUWSSLwd6nb1Xi7JwlTzAwTynFPzJtaoj8yAOmkz35o++o135mFAuXJcR/aG63Fog1SIsH33EEMPxb2eO7GYRXaPIjEkYGHf7paHkYbNYT0kyc/3CrJV/S1JVzdgcA/+/U+B9bmqOOL5j+2Riyz0WMrYQkekNjtYLx0POSchZclQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SEZPR06MB8863.apcprd06.prod.outlook.com (2603:1096:101:33a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 03:46:48 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 03:46:48 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Al Cooper <alcooperx@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org (open list:BROADCOM BRCMSTB UART DRIVER),
	linux-kernel@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 1/5] serial: 8250_bcm7271: Remove redundant dev_err_probe()
Date: Wed, 22 Jul 2026 11:43:29 +0800
Message-Id: <20260722034342.316755-2-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722034342.316755-1-panchuang@vivo.com>
References: <20260722034342.316755-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0131.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::19) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SEZPR06MB8863:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f74de55-bc62-462a-2ca6-08dee7a3db7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|52116014|38350700014|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sTGgsF7z34KRr9ZIuaHQ6isJKGyYDgP0/57D3ugaPteL683CsBAwW2n+ktP+VDl+0ZKosYZ9Dk8o5YoxDc9KQizXECW+oGPO61i7XQiiMT7lOMcSZmpMkSINZf0d9qUxImhRM82xa6dxrrhl9KIu8njs8UTeOlEULJuJrE7ibGM7W2pK5p+AMv2qRCXvunm8xiw0eXaJW2qdvnXQ6AvQ7ICkfi9huJ8mn7pc3KgLM7bT/aTTiSQiTe2f9PR6ziwNrJzxbH4KeHnCXDvL1hWWLNANUMZBTox6TyRMuONVxWFJwN6A/XCeIL/bIE5uR3imtr4jkXxNbYNZmeGJ0D+32N4KtF11QWO7wt381aD3MBj2U3pNy8AEDxox297UHhHD3wsOq4A4eoFk+M8GTN2usEffDfF69ZSGYXU5Nj83wTLZDZFxOeD9l0eKdlPYtDv1OpPqRg3jkO6xKX6R69krhlGx6fByrNcJO2qjfZw4ohOHImx/8DDLsRDnqLHIzVYXLv1KxDfj4yPPbNZBuJGQOfsjbG35rA12GZkoZJTW4MNKlczM6PYw7nS+qFnRDzPK5XeIcJacl1T4TCHvrfA9B9xUfPGAS64ZYV6HicRhHjV+ugIo5f1A6xyOIiP2Cr+n3+SnnM0LlAmvbMnm21VTHGdqkudMGv6fzhild7iPUiD5TX5j7ai81LrYBTKv1QkJQTQXX7+R+vfjFJ2kvspy2VsM3jiNJ32BaweCjJ2P6Fg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(52116014)(38350700014)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HR1vzsc6MTxsO1q3bDxCBZaO0jRxdN5c3UajiHh0PysAWoxHaILbk5Ovygc5?=
 =?us-ascii?Q?kCrDmSKR8yvYbQvC800dHp5fH0cobm+X/WL/mNoEX9DWwd6/SeXucbLaLROi?=
 =?us-ascii?Q?iS2Rf8cAqU7T3ffObOs+v1vVpHIoPj7xhEidhbU5Yn8x7/ehaKS5XjfOkDw9?=
 =?us-ascii?Q?0tW+8RIhpnOyuWh5A5ZXFCI9KU14EAc/Z95i54FwWHK5Y6YBceXqLf4dXa/l?=
 =?us-ascii?Q?xLdU00ejrLwEtqCWgDoJ+bNkpTV1JcH43lGWvrxxR6dNI4QbUGar7YAlHzkn?=
 =?us-ascii?Q?Rb6cjIG/LFxwFtzkCDCjvQvHfnYgBp1Z21MXkHLendwAC1ybrvMI1LX3kQt3?=
 =?us-ascii?Q?yFowvZX6FQivGZqwsXtBi9cghqfy/C16zaf9AXXakZ2zWp1WoM76r5K4Y9nv?=
 =?us-ascii?Q?AMKTK8PeGFBdhxRJs3vWm02rjbXWVeOKvk9iQigKmn9ddpHyGxy+EC5r6cFl?=
 =?us-ascii?Q?XRcPyPzrp5cyPslMReVSOSYinK7G3BPI+zIfjEr+KJr6bLZ72pwgSWscEXz2?=
 =?us-ascii?Q?qhvryeiEVQYKj0Fu52kd9vvFVFX3R+XGsnbOJ7/qaZx+hQyLf/vQGLgxWdqJ?=
 =?us-ascii?Q?0vjhTD1VE/ON0VE0RHuNJQMz5arLLyjvexMd6MrzC6UPyZQU3CIos3UaOgod?=
 =?us-ascii?Q?PXPeMpfE2ZLZbie5+onTHhe8NGeGEQalB206tYr3lZO5YAMxTlwFJRciawqt?=
 =?us-ascii?Q?K48bOj77K0t7ASrfb+tTzK3a9ZRzrja+yjdyVnGpw1hyqC/Pf5MHsSsxpfth?=
 =?us-ascii?Q?2Ue3aFpUBH+vy69ZIRNez84oCU9Z4jo/efKGSoa/gHJ0UME2jgNiJL+By3/T?=
 =?us-ascii?Q?cauJtULVFrqm3b3w7PL36pwzmTVJxtcYRSDhRjvUPzvuCo/JG0effG3XJBfh?=
 =?us-ascii?Q?SeAjFfDK/364hxi0xAwHVvkNG72CdXF5ROWaWnBOSjsMvw++xy96tunq0n0I?=
 =?us-ascii?Q?rOqdLiDiPKqRIel1cDULZj6fLtZ8Tp8xjg8hngEAgi5b66/3eca/rSWPK90U?=
 =?us-ascii?Q?Nl7OvTtO2nCLo/HpFka+woTNISbT+pDDwMw7vCjbVHF6Trpu2/Teq6Whn7Tz?=
 =?us-ascii?Q?DAl8PMeAXCWLliLgXWSb/+fJuFk2pekJYLZDJ4vREDTd6rlHbtPRlCw/ohUw?=
 =?us-ascii?Q?TYSR1ajS9dDAF0sxguZfwdjb3R4M4cMZsT5r2ghkmiI+QAIawKQyQu6TE6t/?=
 =?us-ascii?Q?NW2bYDlI1bWO8tkccwHdcNWfRi/5iOjKU1SAqFhQIriPvvJwDHfJ9wIFhe/z?=
 =?us-ascii?Q?jVe6YzgIq5KoFM/DmBcm4fqVPV8wejtIdb0H/H84fL6+/XduBc2GzdeR3zX3?=
 =?us-ascii?Q?yt1qENDx6kWMj5R9NX2tor7UghMY5xz7zfMNnfZsjrCtUimTODXB/8J14j88?=
 =?us-ascii?Q?ORE/Xc+DOFfnRzJxQ80NihGehm6GGqFfwpmgKjhBwV0xzH8ZGFKIQJ0Vk3Rd?=
 =?us-ascii?Q?BgsjD4125K1XShUd+n1Pz8QOj4jsjEMgzGwcZ5Vn2ZhtSyvDzDFFUrJGqZtH?=
 =?us-ascii?Q?YqmMXIvJity5/fmCc19BlT1G7vQBL7fmqIVSm3ovlWCh9Nsg/Iis+oVLbDfM?=
 =?us-ascii?Q?DvptBg1aWwgciGPiaMYtPeW6X8npZ0VDV8Dwnhgwa5sSpvO9QScQuiTmvnkj?=
 =?us-ascii?Q?4D0fRMSV79siC2OaS2/yIL58u6PY5qrQll1usWZt4y13r2kqxsLrcuUXonNn?=
 =?us-ascii?Q?9hwaTCK1U+23fJIJdosec/XkWm2QTgGU8plmbcgM/il6PpXks0ibrMZUbfzQ?=
 =?us-ascii?Q?75KJwJttxw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f74de55-bc62-462a-2ca6-08dee7a3db7b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 03:46:48.2782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJxOt9hXxAhG5aj3aRhZ3vsAhThSy4Em2KgdZXgK1aNHj7Rg8TCbHHC+WOz6CCko6FjG0CVuTcOLz+R6atyDsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB8863

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err_probe() call.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/tty/serial/8250/8250_bcm7271.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index 742004d63c6f..cb7d594d263e 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -1099,10 +1099,8 @@ static int brcmuart_probe(struct platform_device *pdev)
 		}
 		ret = devm_request_irq(dev, dma_irq, brcmuart_isr,
 				IRQF_SHARED, "uart DMA irq", &new_port->port);
-		if (ret) {
-			dev_err_probe(dev, ret, "unable to register IRQ handler\n");
+		if (ret)
 			goto err1;
-		}
 	}
 	platform_set_drvdata(pdev, priv);
 	brcmuart_init_debugfs(priv, dev_name(&pdev->dev));
-- 
2.34.1

