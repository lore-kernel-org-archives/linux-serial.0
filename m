Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2125.outbound.protection.outlook.com [40.107.21.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578F114AD29;
	Sun,  5 Jan 2025 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736082746; cv=fail; b=GpfEVd6/fYmfTHytDDrsfWOxWbztfk/7j40uFUTxfHy5PSxXzB1A3tS+hf+CIXgJZyVkwzlpg7s2X1OKCcj9JeeP37npld1/6S7ALp8GBDY272Am2z30IMDqLKyC8NdwRDx3GYoWchQnIkgLMbiD6blH96JUbabcNqS67KWN+y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736082746; c=relaxed/simple;
	bh=8OqEMIK2Ycw6/vCDcpHe8JRFAUaqclklIegH7XNfvyc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h3TvvHNBgqxGLG7vtnbk/JprKg3ZU6Atrvp7Vfapjr2vRPRW/SDAeQqi+Wj73aYlSTPIm5RzfHdt5SAFrUw1slZmkmUHPSmHVU2DMuiAZ8duDrbUYOq7LVfSqJByQwO5+Cl+b7C/GtuJjRkaUeLtYtH0kE2oCjvLlkL8qRgcVMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=cKP8Ly4V; arc=fail smtp.client-ip=40.107.21.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="cKP8Ly4V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+278Jo2sBU5+yZCbw7w+RewN0hj/11omPfupmLLxeiTI9Sx6Ll24yErzS7lynBkUYMRbQr9OLIHAvw15HhQTbm7MVCfooC1JpLVSfnRfKHT4Fx0vr3H5jL7GxfKE78XiEMSRbTG86RbwG+2zBORL12HNGflB7h2lw4+vZkMk8WUvok5ONWNhXuBNThbdvtioutTi3QWZeCbm/oPWKeWiwzs8Vktjp3inFHKrfregHgZ28EOeFGqP8qz7C/UkmF/PK9Bh0fLhOGCsPCpieBxmJS1rUuTcr3pkCfjdpVQ4KLU7paVkC8bgoSn5JMPKPCYSA62QhnKZhVKbAzeLtZ8zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlXOkzWaKOltlOHhqLjbmu4kNZTEaeU/7NQgo9VwXoo=;
 b=CNmC1PAd8YPPSrC4qn9k1t6YKRcdMNZwdb7swbGgaRxqjLHzIezW1r1CiU+Fugytdbpqamxg3kmDnh3SNW76SQpK9gZlm1To3dWXd+3LhYUd+MsyLKNpUNrlajgKsOB4hrwbKiatsw8RBRPEmlAJjpy7tNm1/vkL6KjZ/G53xD7cESGj78Yn128aB/m73Wbdkl5vlDxMWtw+AnhPm4ZmpzUo6Hg/r4WYNZy0QhRu9iwZCMoNfmCyoQXTc5wRozDSh1JHe7xU9NCpOYXlJvFAGSMtX+HKgEhm7AAwirmcaeX+Hf8WH/fww3yP4Y4xZfBZoZHe/xdnbIFWxHuWsOvUnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlXOkzWaKOltlOHhqLjbmu4kNZTEaeU/7NQgo9VwXoo=;
 b=cKP8Ly4VJ7iYS54QstZWoh3YBvPggTXOiVyNVqtaEeojmRowb/Vzb7UnQfyYNIzm3H+vqFuC14Ki/otLQspz0RYIYChTul6m6JdWdC4GtzNQRozcOnXAzk6Hl1MDXESKY8sLFXlVkfCLt0PBWwwWp08cAAxbJAl8yCMQ0wgOiFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com (2603:10a6:20b:90::16)
 by PAWPR08MB9613.eurprd08.prod.outlook.com (2603:10a6:102:2e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Sun, 5 Jan
 2025 13:12:16 +0000
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42]) by AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42%7]) with mapi id 15.20.8314.015; Sun, 5 Jan 2025
 13:12:16 +0000
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
To: linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: ansuelsmth@gmail.com,
	lorenzo@kernel.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>
Subject: [PATCH 1/2] dt-bindings: serial: 8250: Add Airoha compatibles
Date: Sun,  5 Jan 2025 14:11:46 +0100
Message-Id: <20250105131147.2290237-2-benjamin.larsson@genexis.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250105131147.2290237-1-benjamin.larsson@genexis.eu>
References: <20250105131147.2290237-1-benjamin.larsson@genexis.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002BAE.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:6:0:8) To AM6PR08MB4215.eurprd08.prod.outlook.com
 (2603:10a6:20b:90::16)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR08MB4215:EE_|PAWPR08MB9613:EE_
X-MS-Office365-Filtering-Correlation-Id: 359b7a1b-5dac-4d25-b7ce-08dd2d8a93db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?955UTqzoBerTaXibtXgVy/HK8l42k6bkQLibbi1IOKZBAMjYa23Y/C2W0R4b?=
 =?us-ascii?Q?GP0k3hlRjaiVMwzTXcY6jd7nxG3A7QOPX4p0C8L/RuMSpxpnecfON5arRXwr?=
 =?us-ascii?Q?OBcAQgOW+tZAckQSgrzX6/N+w+qYxVHRCUfvIuJAAZa3upXt/jaK50nvt9uf?=
 =?us-ascii?Q?NdFlZZtUIn14FIhnV+Y1h95OrGOZML9GP2P2+9i8mgLr1zcomA5A0X9fIynG?=
 =?us-ascii?Q?YMvnV31BIwQzcAAfbjHmIpWkLPhG/wv5r0jD/rOoqMvSBpOFnqyhGFvQJwmD?=
 =?us-ascii?Q?lmlOXh0OyR3kX7lBLQ1Gd4MdUNPW03p7mQ4kpDEn+a7p+o3X49swHPw8B70W?=
 =?us-ascii?Q?gxvPnsMf9mAzUMIDbDtwk9QTqoi63fnqU2cZXQbzjMCoKt60ft8jj3b3wixP?=
 =?us-ascii?Q?330ObO/SZu18uavdwudogs9mHZ0OLpG7em/8o7XD9EB1oqStF0IZQmxS1SZE?=
 =?us-ascii?Q?CT6Cfk6Whu8qADHEmoSafvVHQjIYZ8cMlad0kSPD4ejoXI9LkTe8fT8yBAlg?=
 =?us-ascii?Q?FRwYbfJbVftNhBOKnpsqZ5kar4qRQdmoekThOJsFo2sSgVJ+NIIrTvKI+fYn?=
 =?us-ascii?Q?O0b1Xt/mbxehulrmIoXr88Y3vWEuyAgkq4mUsppx+NaLL09efnCwD91H85mI?=
 =?us-ascii?Q?Es3CKyJqlCTCjEvdZMCxhYwQD/3ogDWDuCnignb5Va3Kex7gwlBoAxa25Rpq?=
 =?us-ascii?Q?2QOas5WrFEaNxb9sxKIT53DAcpf409MsPUgw/UYvILpjOElwmlxrEZg7mZSk?=
 =?us-ascii?Q?rjGSQ+zdtudVY76XJedj8E2cKrmsOOtCXZSs0OP5FUWaByUaPHtPVoW3N84o?=
 =?us-ascii?Q?gEhQs9aK6TQ9POJnfQh3WOVzOVkRGdE6p5CXsxtVk12u+ReroDVQXQ+4DXF+?=
 =?us-ascii?Q?rND2MYhkcmh9iUtVGhG73i3AlrQJvR4ade5GwUm/XX0tuEGSNuhYQbhE9fRT?=
 =?us-ascii?Q?gk4tigHJrR9fE5yXlVEsu+/4+z4ZO2n95uXPn1sk1zcxzegSUSj95dCoJCcr?=
 =?us-ascii?Q?OkOqpITMbcnL7ps8jckVu06mbYB5CqZFp7WTjFd1D4bTbAiCLXywkn4dp7WL?=
 =?us-ascii?Q?8l9p9Xp0+wANtet2WKg5XuoqSkEZnlobBOvQvNbeLnPD4Jl0s5Gj39rbYvUL?=
 =?us-ascii?Q?DjoYr5ge/TMQkpyyHA1+88LhfKTIkVc5cHvxwvBYKfcEGuDnxDKiDzanQ3OW?=
 =?us-ascii?Q?qdQiqodKimqzQFd6WNL7BwCR81+hxDV8du7tUV7YnHOLeVXyiaMdWK9FL7q1?=
 =?us-ascii?Q?eXN823dh3D2EgMfszFJcy2wc2/xIhCjqRXc3E36d3PpikjKVUTOAcKJ7nCOX?=
 =?us-ascii?Q?wjN/6fHox1dinGB6S4upYVhMOlwFb8TJI1pvKXdffCYp8uYE8hHK6c4D0Qlh?=
 =?us-ascii?Q?HfADzJReN6TtF0f2tXEcRb4JkAFB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4215.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KM4KRiWodpTiFZ2BLHtlFkIPo0eNpausMa2dNXn1ESll0W14f/oT//ozTVtL?=
 =?us-ascii?Q?Ctzb30Way7Y/ys5LnaL4KG1bQc0EiPc9hCpdFB4yYEHsyr2lEbFkacS7hsHi?=
 =?us-ascii?Q?hGRwR9IsTMIQHq/fBS/FheFiH0jTW9w528+jqWo3+trD7n7k5JFFjFiG9Rua?=
 =?us-ascii?Q?zxmm3YEefQD3x3SCgJnZSOl2ivG+urODKoNeAVBhHZlBM6pQpZYmeuKV2ipW?=
 =?us-ascii?Q?SJrTX7SrGqxrFEDovRsY4DDO25vR80hJLtu9zuoECTnhni9cKPI63Rr2Jzye?=
 =?us-ascii?Q?SNlUV4b1QpZvpArx91lD8UstZhyzxMCg4DbtaA+i8dgX1m6N1XtO29b9ZPZZ?=
 =?us-ascii?Q?iAsU1M8R3dspCMRNLLy6tc+/yi4f7faUsjj7UBT81G4JSsYEcZ1z0hcg1c/d?=
 =?us-ascii?Q?PBS5f281c3zL312c+oIHvfx7Vu0UZ+n+BB8pVyEw5PN5mEgG8QEq3t5Iz+zE?=
 =?us-ascii?Q?qOvzCKuFFbBoPqS+bkGFiJjISDnEyvWPcCztY0JMl+RfBKdf/xGnJrGxyzVo?=
 =?us-ascii?Q?oi8lbHeuc5FtaXlPGlzdW3RRKbug7jqDFBS248NGV+GDW9VlgDmdTJdnk9ms?=
 =?us-ascii?Q?Iq/IEI3ZisvLdrr/by6V3JfOTdflvozOQVpSLlwgwwP2YHI1gjUj8W9Mj4D4?=
 =?us-ascii?Q?KpWcfR+U3/MMZocWQJezRfJGEvPkiwYypYG6cvEBLYb2uOfTnHRAyBh/oxgU?=
 =?us-ascii?Q?o/xLMvPZsl2ehjAamaOwHaUsaD+gIoQ9UrswHuV/puYki3s//YZbnXuDxH+T?=
 =?us-ascii?Q?2MYFAFYEr8v62tC64X9Y4ZJyud+jKOnihBpAxTXTUFiPfEmFTt117WVIPd0C?=
 =?us-ascii?Q?QyV04VgSCI+HLjQjyd9LoNC6E+5LzwakJBJXsCl2udvS3yYK01zpPmeTJ7La?=
 =?us-ascii?Q?tHHrrk2fOWiWiC4xiGiVajUiTS5b2VAoS2rx0wCR56m5HQxx2fX8RHqwg6SW?=
 =?us-ascii?Q?QHeEVuNQGIKlmAjTygg6IMtTmCGe8FQGAS3eH2qNxThdSURt6Ua3ipfHJnMP?=
 =?us-ascii?Q?ikikpXnZvns1XB4oIeI+H9A4V3K5xY6s8C8vvWutydDEx2sF2yghFaFwb3Wy?=
 =?us-ascii?Q?vs8GXQLzIpP3J0bI7qpCGeO0LlYN10Oo5aaCaxPJl9d+TRav+VK+gGHiv2tW?=
 =?us-ascii?Q?YGpl7l1rxOR5lBdJ0N318KAmYEiWmPyQpqM+hlFzF/f+PCMwKrEQBxvsN2By?=
 =?us-ascii?Q?fSwqg8iyx50vG50IW/55s8KeVwndzO37fsLEReeCLctuALiXFCJlxyT5Con9?=
 =?us-ascii?Q?+pjB5WpI+wLrjR3MAlsE3lhT7sGDINDOEMuksCvMGIqmf4uHfjfBoFuYvdHC?=
 =?us-ascii?Q?4GUXM9rdeUOBeATEQXIpA2zTQJUmAB9oDRESZq5kqjB4/QVxPhi8d4hdCcLH?=
 =?us-ascii?Q?JSa3oNf6FuWxt+/LpMx6drvObXqgYGKZ+jyAH5UFCWKmJje8hjbwTIWWhrJ2?=
 =?us-ascii?Q?y1F0s39thtdbikOxbcUnc+uC8MuAykb0/tNmJKN6+mXT2s80j3MYasMpL1+F?=
 =?us-ascii?Q?8uk1FdFHba6jjvsKr+uY7SZYj+hF71tj0S46Nd98Diysykyip7tpSD+6sAPE?=
 =?us-ascii?Q?rOeTnecrje5kf/a7ZjhaK5bMJLRT/IBiCQ5+iYtO1rHNDLSYawLWChOaIbNk?=
 =?us-ascii?Q?CZuoiXp16dznjXAVMagWudIwHrRy1Ao0qX3z5NuI7DqMbvIlo4ksacaiigVb?=
 =?us-ascii?Q?d3PgXw=3D=3D?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 359b7a1b-5dac-4d25-b7ce-08dd2d8a93db
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4215.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2025 13:12:16.7390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n4kKTQ31fm8cSHfMV+4vc0RNbyEYJHdTQOEt3WyqKrEY2jnigbN52q559VDjHi60SJZvHp0CAsdIa8IfJzXwHXqET64smMu9Qs7yIFvSdH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9613

The Airoha SoC family have a mostly 16550-compatible UART
hardware with the exception of custom baud rate settings
register. Specifying one of the following compatibles
will enable routines for calculating the baud rate.

For the regular UART use:
compatible = "airoha,airoha-uart";

For the high speed HSUART use:
compatible = "airoha,airoha-hsuart";

Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 692aa05500fd..2fbb972e5460 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -63,6 +63,8 @@ properties:
       - const: mrvl,pxa-uart
       - const: nuvoton,wpcm450-uart
       - const: nuvoton,npcm750-uart
+      - const: airoha,airoha-uart
+      - const: airoha,airoha-hsuart
       - const: nvidia,tegra20-uart
       - const: nxp,lpc3220-uart
       - items:
-- 
2.34.1

