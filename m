Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022079.outbound.protection.outlook.com [40.93.195.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577F725A2DD;
	Thu,  6 Aug 2026 05:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785992633; cv=fail; b=NRIWIGnA0EtdE3XEwTQqDxteiRbgyzKVC7rc4UhiRmP9Lh2og8G4JjBJXD1LbAI5UJSPgFb4WWOD6fy5VU9MfKg+Oj0ccRdn1lckR+T21mfio4NxXMKNL0c8zK+E7+0mBNS7XURbX28sPqb4gnVUCrxJPoB5oWEi9ihyAQSJ3r4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785992633; c=relaxed/simple;
	bh=M+9CcAIoy95Op3kP2xUFgDFVoZAXtnexzHCf0nTLSe0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UgaBTX3D97gEy79r0fPK4sBreCPsj2fM4P6Da76gUQ5wjFKYhnXEAycMK4/9nV3XRmQKs0tS8anjD1CHo9X+H1eMBT3H4i75c1JKHgwy3kTx4rHqooSATvXXsInuFzKU7dXxxgHdSReUUVZbx6m+3VHQnpAbG84Hnn2aOv+sO14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=XQjWlU9M; arc=fail smtp.client-ip=40.93.195.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="XQjWlU9M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tlzW0fMWdK8QNC7BH9qeItp7V+XenN9SAwhRKmEDDn7RkVP1LBKip/lyaBJnC31jSbh1zvxPCwKT/eQjoL0wM45zhARMrGDeYP9HjhjasOLEk2jQkBvCLzx0of7D3X2flEbe6u9jwgCETzPZuxI4vpJKrrQuXJ3AlrALICqFgtuvNAx9lqXSbU+VT4Lr5BhIt5HNr30kaRL6XpEyL4R32bdog/+EbKoi7HgKHv0/9x/xCByQKPPuXOS8CYRpzkUyxgLxwe6+I8AhNCaOyV30Ct9fO8MIysTl0KddmxcaW4QYtJdFrlCi9c/qhJ41trX9zpwEYjq39B7E3hBY38poNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGyzk6iVwUnOAEv8FNVpbQLuhR5AOPm23bbkPLkWteA=;
 b=igtshD79dFAM2SJ4brTaqRyWy0qmGsJtBdjdweYC/MZkhmVOLMd+DoK63L3CdggO4tbc2/UDo/h9mFjPEJ53nOCqIJpYMepZtYPYzJIlVBQoVzQZZAZhAfaPD2LWFCKIWQPNqTdG3NmDTBcrsj1xITphUvaAnKtjECd/zAqKFeIkXW8WRazDjy5QwiSXXZ8Az0Up56ZBsgDdqsZk/V5MHFnoTWs/cP4xivDxWUUMGEX7LhGq5F9I76kBgwmdeQUO0Ngh4pSnDO+jeCsLMJhKhlcy0UmR+kf86D5gltLn2Ahk0FpZI+hzOGjAsePEbHOYWSY2zNSsByVwvrGkHzZ6Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=amd.com smtp.mailfrom=axiado.com; dmarc=none
 action=none header.from=axiado.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGyzk6iVwUnOAEv8FNVpbQLuhR5AOPm23bbkPLkWteA=;
 b=XQjWlU9MU3ZKf6ryxTQMBThr8AZPOi1w8IuBt+vRNyhasG56hPte/0MpKVZ/G9jOow3UTquIl2PE530c5OOdAkTZeTviCh56n1TQCx58CzHCX2CZ9W/hWmG1K04JHgK5uKDotOyv7txIfj5EZcUIR8OxHNUHhNTTiUl0buYkA2SDL6LCjoUvg0ZyzrGpVQEuiUwiV6NL0o8ZfK5TogswrDmGq/mUiQ7Gbcgi1+iL/iDCsgZgYL43/LhCqv9jYbppllybLvKs9M8MqAfJZAa3hvhknWh+6K434QcsBR8zya5JDRyMUMO3F6JHSYjrKEO6zAEx4mD9uGpSMJ/evVN9XA==
Received: from BY3PR05CA0003.namprd05.prod.outlook.com (2603:10b6:a03:254::8)
 by CO6PR18MB4436.namprd18.prod.outlook.com (2603:10b6:303:138::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 05:03:47 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:254:cafe::75) by BY3PR05CA0003.outlook.office365.com
 (2603:10b6:a03:254::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.7 via Frontend Transport; Thu, 6
 Aug 2026 05:03:46 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.6
 via Frontend Transport; Thu, 6 Aug 2026 05:03:46 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTPS id 3F6B64157BE1;
	Wed,  5 Aug 2026 22:03:46 -0700 (PDT)
From: Swark Yang <syang@axiado.com>
Date: Wed, 05 Aug 2026 22:03:37 -0700
Subject: [PATCH v4] dt-bindings: serial: Document Axiado AX3005 UART
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-upstrea-ax3005-uart-v4-v4-1-8399f0773b13@axiado.com>
X-B4-Tracking: v=1; b=H4sIAKkVdGoC/x3MQQ5AMBBA0avIrE0y2hJcRSyqBrNBpohE3F1j+
 Rb/PxBZhSO02QPKl0TZ1gSXZxAWv86MMiaDIVNRTQ7PPR7KHv1tiUo8vR54OZxCUTbWhCoMI6R
 4V57k/sdd/74fXWMhOWgAAAA=
X-Change-ID: 20260804-upstrea-ax3005-uart-v4-fc15932c6cbd
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Swark Yang <syang@axiado.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2202; i=syang@axiado.com;
 h=from:subject:message-id; bh=M+9CcAIoy95Op3kP2xUFgDFVoZAXtnexzHCf0nTLSe0=;
 b=owGbwMvMwCHWlWK8+EozbyzjabUkhqwS0Y2dutmeoprhKxdyTbiddGd5C5OXn/beaAWflbvXd
 msdTc7pKGVhEONgkBVTZPmq8y3/ZK72vc69K0th5rAygQxh4OIUgIl4SzIy/Cjl/ZLSd+uPLMOD
 cBbjJibOs9fORXC/0ygTqbzt5hQTzvDPxuLRF4cN6WxP3x1oqfya8KJw7jq1K0zX1RvyOOyed/7
 nBgA=
X-Developer-Key: i=syang@axiado.com; a=openpgp;
 fpr=F52CF66FC96D2BDE89BDA9758A6433A3D4830D5D
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|CO6PR18MB4436:EE_
X-MS-Office365-Filtering-Correlation-Id: f4fd050c-a02a-47c0-9e5b-08def3781890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|23010399003|36860700016|56012099006|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	90q8f3eDkIHzW5n8C4nbz7aik04K5YxQT+ZlQGSggeM6Z/O5iJywAvaRxGzFss1I2Yhk1FJHVqzLXLAbSh4QwHkDuk6/s2UA2h2mRBUev5U1Nk6ZLx/1FYQBHzSLa0S8AvN4Npe/4KSujhZzL0j/7VnpaeGPZYtztvKK1Uxagk9jkezK+QxWdbhidWodQoMhqYyftHtBWFyIAnVR79aUfpYsIs1G0J/PzFidt38W0/4mcAofPGanP9a0u3rAmUYb8Ctw8jBcbfBEtSINdNldeKz1PU5Hvo9pc0mJC9Ov/UqeFF6/V9kGgcPNBtXw4aqUFR2mFhUIaSYeaFQF9yIdjGcnKslBPMf0/ntkcsY99S2iA5NwTB88/pFuz3kn3/KYa3BT1vq64Ioyy3K+sUOWZWGs4b4vSpF37UcqWmeDZfo8t2SH1D1+mBFrvo7WfZ3Xca4fsVxYti3rljD7yYVm9nK/ex2zipB3+Bq93WHIlBjShp4tX+JgQEQHEjGqHNVkPcLbteRWKF8IBarl7oB7CzaDWVDFtWT3hkb7swLe2WovnsLAGURz4Qq+l0SIfT2tZ9dxZVJnCUsBxvEKAHMjqcvycOxkeZnHxKz9PkRVD39oGoohKIiaMJHGmvyd8LIL0rIRlwWwc47qIs2i0csJsMklYekWjf41gjNukM8lFCk3lCD7ecsBaSMLciCzoXiCO/sRe05H+CsInj7bXGIJvA==
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(23010399003)(36860700016)(56012099006)(10067099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JWB7zcKpHj2gbeDY4rgbJuDjZ+Wz/7k7v0oOBRvRKSZgfEb6rzeqvJAZ/dpaw6M/6OBXjdmFgIUr2gC/xfAhHFlJ+jtJpfDn5SoaW/41SeS2Yxu1sTzXOV5E7Q50c6RJBotzlJAqavWjeAUQuril8Z3QfzdY8RJ2LXDra8gK3DIRO6mQ9k+EFO0nT3XuLOtYz84G58cQAc9hf2rkZcnH0MxEqzr1drHrRIIEL6O73psRRp09TJl8qROsfLOBJvEREpPmbkZwv/xQVdmPMwwMetaaQ9HHWfiTgSGnqhboDIVtrMrQXtlbaMoO4u4y6Y/gQdrEkLzsInrUACs88DD7+FUDSNgp1xbRjFpP/yyU0z9f3Sida+bRiG2TKDwNCvW0W1pfdrnzb2v6Ewq7epp1qZvhzxYwMsMGR/M/wWShaYa+Pew0KaZy7MXAe5gl851K
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 05:03:46.6053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4fd050c-a02a-47c0-9e5b-08def3781890
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB4436

The Axiado AX3005 UART is software-compatible with the Cadence r1p12
UART programming interface.

Document the "axiado,ax3005-uart" SoC-specific compatible with
"cdns,uart-r1p12" as its fallback. This preserves identification of the
AX3005 integration while allowing the controller to use the existing
Cadence r1p12 UART support.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Swark Yang <syang@axiado.com>
---
This UART binding was previously submitted as patch 5/8 of the AX3005
v3 multi-subsystem series.

Following maintainer feedback, the binding updates are now submitted
separately to their respective subsystem maintainers, as there are no
cross-subsystem dependencies requiring them to be submitted together.

This submission contains only the AX3005 UART binding. The corresponding
UART controller nodes remain in the separate AX3005 arm64 Devicetree
series.

Changes in v4:
- Submit the UART binding separately from the previous multi-subsystem
  AX3005 series.
- Expand the commit message to explain compatibility with the Cadence
  r1p12 UART programming interface.
- Add Krzysztof's Acked-by tag.
- No binding schema changes.

Previously submitted as:

[PATCH v3 5/8] dt-bindings: serial: cdns: add Axiado AX3005 UART variant

 https://lore.kernel.org/all/20260716-upstream-axiado-ax3005-upstream-v3-5-c429095143ec@axiado.com/
---
 Documentation/devicetree/bindings/serial/cdns,uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.yaml b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
index 9d3e5c1d8502..11292de42c67 100644
--- a/Documentation/devicetree/bindings/serial/cdns,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
@@ -19,6 +19,7 @@ properties:
       - items:
           - enum:
               - axiado,ax3000-uart
+              - axiado,ax3005-uart
               - xlnx,zynqmp-uart
           - const: cdns,uart-r1p12
 

---
base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
change-id: 20260804-upstrea-ax3005-uart-v4-fc15932c6cbd

Best regards,
-- 
Swark Yang <syang@axiado.com>

