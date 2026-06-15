Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022072.outbound.protection.outlook.com [52.101.66.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C963DC4A3;
	Mon, 15 Jun 2026 10:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781519287; cv=fail; b=lrMb+Muh8ZeDid6bhGR+q82ebm9HmSkZMDxBP4FiiPYyOJPNZ4amfuoE9TYj3yO5xoOTtHXkyyyAIM7zHQskdb+nGaQ1i1nm5agKQHq2Y/A5hGZg6RfI7wlJIOlGSbuJj55Zf2EIzafBZdGqd6OHZBjrHYFj8YX1dgxHs8HaHb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781519287; c=relaxed/simple;
	bh=eafmlWUhr82pQIFFXJx8Zsl6ZLF2wK9PVOEe52rhB+Q=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Kpyb/uxgnh9FnkLoxOGIZxdC9+0QP7MYvm4lfVgjPIPU5tkhmDiQNLD7hT8zpvzjEZbYyjo0mBYFPIXi9D4tt/M1dzD/O2z9sasVephEzmlX/ZEP0GhbAEGvFHfpoQmtU3S+pPmVybU64y0NS6DYpq5P15GRsfQneQ5P8v5RWEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=bEIBenV7; arc=fail smtp.client-ip=52.101.66.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="bEIBenV7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ux+q/c7fSdm/E229+9JHkzYGxj0qDTfhtHQjfuCyv6bfyVf4JdUkmTqUgcWz3sdfAT/awz3+qSkjr4Lg/cow186p/0nbujKl3uJkUj/r0Axy7c1WejHzd7XaCtVweXdIUZ6CrMAOh5KpYJv6pNHcLh3GrsvkjWSf9PvCK5BHEzcvo7Gb4jbSpwVUSvpkdw9hmlZ/bLonpTiAJDAUnR9fENzXVcaEgwJ566R8O0svRUhDa/hrD2bwePlEHDcQtD2wpNP932hXf5/cBs1Hh1oTC79biAr+yGz/b8+oKIXC/5heSbNc7FtXENh80zI4mVCHUTbcEo/vLc8FzqH55juHdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkMAS7DTn6mm+dmxi5v4vykTAJcH1vP3sRzrceVqXPk=;
 b=UkdLqfLy8tSsYTlRpP/+lOC6HlksZkyFu0jfi131By37N6z3oXKF/oxV5nByuQgJTMHxcw6WePKf3Ql7quy6PYaP2U8gFys7hT3a2CYebX18N8km94cYkFgJX67CRz44av3Y7euymtuYVRRfug9sBQJnwL0Yj1XWFBMrdBuswzzFAS7RL9MsDtw1KAVf3Ev9P6pP9OFjdyKCXtvaPtqtzxfqsprXz+hIQl0mra3Cog6JAmvtfYhnK+NybqcMjrA1yfFs6KzFvGXPDAwASi5Ep2na2eM0yFFKiMesHIMgglez2gjkPDCkJX42ULx+AAV0sL3Kmj9mraZhQxvLhAHvhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkMAS7DTn6mm+dmxi5v4vykTAJcH1vP3sRzrceVqXPk=;
 b=bEIBenV7MUKvGRBCyhJr6/bgTOPuJhReCg+I6MybJ+8TdkgYlRoCRc9YRnr3d7w7jtRA5a1595Azw44dwIoMlYbKtJhHWRWAL1hz4W5ecQrHqG2Yv4pauIAAxb2RrMLgSp06o7zi4K8U2N1omrTld/hhfUmnvEJXnM1QL3NaG7k263ucggllEmRqwSqxGHz3XDALrUAxgNXdsllwr6fxHNVmDYhQDNliIhR8mg3otpsMKf0XE/AvTjNQ0GZMAsiDFfSAT6TZuMyOh78pAu5E7sITlCxP0XTiNTOK5nauM1xotXmEtz7uKlPjv21AWAwdgYnWBwvVb7zhMrR3ghigTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com (2603:10a6:20b:676::22)
 by AS8PR06MB8005.eurprd06.prod.outlook.com (2603:10a6:20b:3cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 10:27:46 +0000
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69]) by AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69%7]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 10:27:46 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Mon, 15 Jun 2026 10:27:37 +0000
Subject: [PATCH v3 3/3] serial: max310x: honour rs485 properties from
 per-channel DT subnode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-b4-max310x-rs485-dt-v3-3-7e79f064bdd7@vaisala.com>
References: <20260615-b4-max310x-rs485-dt-v3-0-7e79f064bdd7@vaisala.com>
In-Reply-To: <20260615-b4-max310x-rs485-dt-v3-0-7e79f064bdd7@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781519263; l=2885;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=eafmlWUhr82pQIFFXJx8Zsl6ZLF2wK9PVOEe52rhB+Q=;
 b=6ZxOhi0Dq2D2CI/jaGjTAqmj5iI23hHOt4G8YL2uB8CTKcC3a4nOh57tkaBEbKFZHjlHaVggk
 J23Wuw67XYOAikEE+nf5Fd7RFD4xITmysjwxHyZdLif1d01Av8GjcoC
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GVX0EPF0005F72F.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2cf) To AS5PR06MB9040.eurprd06.prod.outlook.com
 (2603:10a6:20b:676::22)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR06MB9040:EE_|AS8PR06MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: d12cd3c5-0b10-409f-6216-08decac8be13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|52116014|376014|366016|1800799024|11063799006|56012099006|3023799007|38350700014|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hpKJ4oQ9xKt1MghFZxkuQPTuMH3pLQkNypWzUFRPyqnGKKlQmQ5ElWCkJztdQlVO3FZ2Q+xMM7FSuLwgL9jWJ8WnwFy2ebnO2Ch52tL8IyXyYenWB0IyUG2qqWHNpTqvv3ejkqjUeK+d40kyvq8bWe6Z7AS/U491sTXCNm1Eglc3lYmkBY0Ji5Z4wK6ria0a2Vgl6lv3O2oOoozc7OcNaLOfbaw0KPosD/kWhi77v0d3jtepfxoGuY0Vp8+PqLd46NwcEPrScRKtnRKQxajLhY8kZua9txEMgAJ3A4BQeWjgShGBkwq8s2TpxnebWvQlz1iVb4cra5ZSF4EBmXa3F+8XGg1tDkCnzzw0adEhbNw0tw3O0OQUr5nwFmsjjf7VQQEp0zyzk3U/JkOzsQdDSILx2vhl648O/CroiQ54Smj+ayHoJclJygy75avuOLiRLfOP5jo7b8RW+G3C1ZN/2ksFyHDRvVNjd6Rv8fOKxHj+gmO1j6DupEUTjPOm4Jb1e9OqX6ADSSw90fEXsMOHkSxmqYgnKdMYG6yc2S/49Fz82Zgw0PNbvVmWOI3VNSYGGKpThLab3TGMrVleCkAK8ztGnLSWKJA7zbQ5DFA12I2rtL7AhsxQAzLD3KTdOahtOEYoY0Y3Tmi2vxQ4JTKLRHx26I3J+Qwd/BfX/hlobKiYC/ePdM9wMNpHp0uRdNw/IB4NQMG9KS4NBijbXCVJQYqu45T3kyDis1GiJrntq2XDP4KtfCI5vj8X9RQMsO4F
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB9040.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(52116014)(376014)(366016)(1800799024)(11063799006)(56012099006)(3023799007)(38350700014)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmVtcmFPb2xOWXdpUzNmMFpJaXFyZmV5RzhLT3ZrSjdHa3VJMTd6eFkxMWRX?=
 =?utf-8?B?NG1McDZsVFYxMHA3eTlGNDVyQnY2cnNLb2d3VGVkcmlXdWYvN2wwWEZlc0xj?=
 =?utf-8?B?dzg4WVdtMmhuNjYrUUtSK0R0OEdJUDBIdnlwbHdkNW9MbGRUSS9TbzFFM3pQ?=
 =?utf-8?B?Nzc2OHNHajcxQTlPalhSTVJ0b3ViV2F5UmV0bmJWVWJPODY4TXRHMTIvNkxN?=
 =?utf-8?B?eTVrcEdUeWt3aENGQnpQWUFPL2hQenRkY0lYNDJsUjVBQWprVllUK0YrSjd1?=
 =?utf-8?B?MUNPZXFoZENMK3FETEt1Q2c3a0t2ZjM3c0QxYys0Zjc5NnArcWtPSGVnRkVV?=
 =?utf-8?B?QnhSNjBBL2puQjBSY0ZERUg4dFIxVGliNm9yNFBtTDJxNlI4aVNxbzgyenZj?=
 =?utf-8?B?aVY0YUtHZkRwcjJnVTNySXB3WWxpUzNKMGpWRmJhTS8rcFZOSFg0RUM4NWg5?=
 =?utf-8?B?Qlgzaml0dmFud0RtOTVBYmt0cXA0ZWtJN3NVU1RkY1oxcldHNTZZOWVsRzB3?=
 =?utf-8?B?dWYyUW9BNDBNZjlnWnlNQlBjTHVaRDBSLzl6czNaRnMvNlR5alAwdHZlRVh6?=
 =?utf-8?B?Tm5uVlNNeVRsNU1WNFM3ZCtQdnljNDdtS21kUlMzbGZNanpJYVllQWlmNEtQ?=
 =?utf-8?B?K0M3YnJNT0FySlJHdmNTMXBjamNEaDJuSGFTSlQzSytMN0luZ2R1VjAyNEo0?=
 =?utf-8?B?U1U2SXp5NGlzYm42QWcybVF6OVNNWmNvYzYyNjZoeXdSeFliS3RMcjhJMGcw?=
 =?utf-8?B?NERwZThXYVY5T04vc1NJbnVzMzBQSUx1Q0NsQkVRaHExWEtCeExqRU9lT3FW?=
 =?utf-8?B?NHNFa2YxRHVsbkt3bmFjQVlYb1kvRkNFSkVmRk9vUW5UVm9VaFVaYVBhZjZQ?=
 =?utf-8?B?cXFHbGw4ZjRjeksxL0g2a2YxUzVqcWpXdmI2Z2tNeW1LTGhZeW9LQ1A4c1NU?=
 =?utf-8?B?WHJkUllCLzdoYk9haXg5R3NWY3NkbmMxZFVpalpmNHlzdE5IRVJyYytZQ2tY?=
 =?utf-8?B?elBrUDR4NE90c3hmdU1na2dwZFpVcDdyWGcxQzBsZmZHUUE4RGU4c3VZZFNX?=
 =?utf-8?B?Qy9qR2FkcWVNQ1hiVnUrNnU2aVd0UnRPTUt5eGpDcXg5QzgyVkFvVERsRUxr?=
 =?utf-8?B?UEt5SlJWTVY5L3EvSGJsaWpCaDJ3TFRKdFVVRm5SSmhxNHhtVFdub1RKWHo3?=
 =?utf-8?B?emZnYmV6cmNMekJDeitpUU00NlVYNG1GbXluQmdBSytkeG8xVnlrV3FMZnRD?=
 =?utf-8?B?WGhEYk1FK3pwTjZQWVY0UzFJdUxrMXJ2eG8rSG5SbnpmemVUR3hWUlJIZk9E?=
 =?utf-8?B?ZXcrTC9hbTZyL2JaRzVBV09iM0tYc0QxaWJWMmV5N3ZONjU1QUdKNzRlQXRp?=
 =?utf-8?B?dEpHc1dWakZlYWVoeG5YblpwenA1V0JrVlFYd2lvSnhnMG9UdzdmQ1JqamFs?=
 =?utf-8?B?aThKM2RxQy9ZOXdRZGhaczhYaWtzZFlaYzlkQTFhd1dIeGR5bmJneVRDY2Jr?=
 =?utf-8?B?NzJUaWJNUEJmM2VuSzBQS3JSUVJRa0ZOeUFrTnNJUWVOYmVacU1wdW5JbG9L?=
 =?utf-8?B?bHFqVEkvb080cEI3QTloNkp3T2lJcmN5MWdHTjVReUZON3JCMGhwRm5QY1Iz?=
 =?utf-8?B?Y2taYzZ1eVYzM3d0OHl0cE80L2JNZ0RLMElvdHluVmR0ckd5RENZaStTak1B?=
 =?utf-8?B?Ulhrd2tla0F0WWJheThnazhoQVBvclVoNmg2WFdvZFp3UFFTQzNYVmNmbG1B?=
 =?utf-8?B?SkVFY2JvSlJrRVNSZGo3eUc2dEJxTzloYlFyNHhyVnFDdWNvWityTVBXWkFU?=
 =?utf-8?B?Mys4aE9vZ1E5YVAzbk8vYzMyUE85ekNQUlhIMk4ySFpiV2UzZnY3RWVSams3?=
 =?utf-8?B?WDFNWEw4dXpGTlhsQW5kTTU5VFI5TGVjSzBzUGZ0cjM5Qm9WbUwvSVZwTFR1?=
 =?utf-8?B?ZUZacVZxaE80cGdpQ1RMZ0VPZEpjSHlPM2txcDBpMjFzK1crTTFldUdGZEd6?=
 =?utf-8?B?VDR5NWVJY2s5WUg3ZGQwS2pjWDVvM3QzQktIRklXb0RMWm5jdFBHT3lubjNI?=
 =?utf-8?B?UzNQa3NQREV2QWxqU0xaSVhsTFdlSEpQRk5hYVd5T2U3MlBRNnNUNHNMbUFL?=
 =?utf-8?B?TlJra2tFVThLaDlvMk1VN1BLYnN5Z0l1RTFPSHE5VktiSVBGVnUvL0dxN2cr?=
 =?utf-8?B?M1g5STV3ejExY0xOVWg4Mkl4SVAzZkVHNjZOeHNGRlpMMGF0ekVKQlM4MUVL?=
 =?utf-8?B?QXkzclZnQmliUXBSRjRiei84R0tQenFGTFlVU0Z2ZjJWbmEveTQvZHUrLyts?=
 =?utf-8?B?ejdMR0dod05RYWJleEkzZk5HVEpkNGpXV3lSdGo3VktjSTFqY3RVSUs0Yktt?=
 =?utf-8?Q?3RRG3JsbmKL56xIM=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d12cd3c5-0b10-409f-6216-08decac8be13
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB9040.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 10:27:46.5516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLTLvpuGTgAj0ZWPh0hItHOQKAP4MADS4hS+9JgcQcZZKh6M2L5mVJbVdTYSUMEDwUqRcgyzEfA6mbd6mly1so1a5fEw0mgDQHp+D60pLM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB8005

The MAX310x DT binding pulls in /schemas/serial/rs485.yaml via its allOf
list, advertising the rs485-* properties defined there - none of which
were honoured at runtime, because the driver never called
uart_get_rs485_mode().

All channels share the parent SPI/I2C device, so uart_get_rs485_mode()
called directly on each port would read the same chip-level fwnode for
every call. Walk dev->of_node's children for the "serial@N" subnode
with matching reg, and temporarily retarget the parent device's fwnode
while uart_get_rs485_mode() runs, so each channel picks up its own
subnode's properties. Probe is serialised, so the swap is safe.

For single-channel variants (max3107, max3108), fall back to the chip's
own fwnode when no subnode is present, so existing DTs that declare
rs485 properties at the top level keep working.

Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 5cb7d01e404663dc25b88bc7b4f8df61be2135ec..aee3b75fff000385a7543f099663c8a0e4a7d014 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1426,6 +1426,9 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 #endif
 
 	for (i = 0; i < devtype->nr; i++) {
+		struct fwnode_handle *saved_fwnode = dev_fwnode(dev);
+		struct device_node *port_np = NULL;
+		struct device_node *child;
 		unsigned int line;
 
 		line = find_first_zero_bit(max310x_lines, MAX310X_UART_NRMAX);
@@ -1435,6 +1438,40 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 		}
 		s->p[i].port.line = line;
 
+		/* Locate the matching "serial@i" DT subnode, if any. */
+		for_each_available_child_of_node(dev->of_node, child) {
+			u32 reg;
+
+			if (!of_node_name_eq(child, "serial"))
+				continue;
+			if (of_property_read_u32(child, "reg", &reg))
+				continue;
+			if (reg == i) {
+				port_np = child;
+				break;
+			}
+		}
+
+		/*
+		 * Temporarily retarget dev's fwnode to the per-port subnode
+		 * so uart_get_rs485_mode() picks up the per-port properties.
+		 * For single-port variants, fall back to the chip's own
+		 * fwnode so legacy DTs that declare rs485 properties at the
+		 * top level keep working.
+		 */
+		if (port_np) {
+			device_set_node(dev, of_fwnode_handle(port_np));
+			ret = uart_get_rs485_mode(&s->p[i].port);
+			device_set_node(dev, saved_fwnode);
+			of_node_put(port_np);
+			if (ret)
+				goto out_uart;
+		} else if (devtype->nr == 1) {
+			ret = uart_get_rs485_mode(&s->p[i].port);
+			if (ret)
+				goto out_uart;
+		}
+
 		/* Register port */
 		ret = uart_add_one_port(&max310x_uart, &s->p[i].port);
 		if (ret)

-- 
2.47.3

