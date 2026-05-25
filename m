Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020092.outbound.protection.outlook.com [52.101.84.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620903E8331;
	Mon, 25 May 2026 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779702253; cv=fail; b=oLPEweEUPDCpEf4kBa4QAbN+gAhimgLx6P2NzOFZHyKBZ0Atl3xFqqaLE6gxexWh+k5X2LjPuswGayzplThogARaFlPSEm8pqG72Ow+KOkCZ5I73VYrk3w5r8mzmuI+ARqQZDPJxZazrq+dRIcDWsG6HTEdu8mWhGnv3DOaDdAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779702253; c=relaxed/simple;
	bh=Jb0kxdJyG1UrpdSkUvdAsI/xelm6UTv5JvmVG5dDbWE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CF+ZNfDgYO7FRjH5bAXSSKSIrzJGoq5BDMDClgSYPNmGGOXeWsXjFrrJZTBdJnOELYXkUyPm5Be7aABmlTr7Y+70Up8s4htQmUNGUl1cFbbEv8RpvV7Bd76h+3Vn6nstjoW4YA6c2hr3Jfu9nhKl0czAzlQ+m/XAi53FIQg2pYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=ux+DtYQB; arc=fail smtp.client-ip=52.101.84.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="ux+DtYQB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEiDD1/dG8RsxlxTDw/0JIlsk8b7kabODjq+W7hVjqJrZjDGBRf9qpNrN5fLsgure4Y2O7KsX9yx0Q3TjLtdnHMKThaUSzQXQk7OpH0wsoX7lZhA/OnE6ihGAy+WQd7FalGJTblH99neSG6Ln2pNv43ROTiWn+fGWqzHKy8yhblrXiznSVhgd85zLeiYCU1/ksfPFua2PSUQ45QqtN2IphotS2yi4aHop8byKL03XubWRAzuhY13klTovXdMZqFHiGrQ+fiJOSIgjrb2Yh52/m6BNl7RX2VbrnOvcAx1x7rU02vF3E8edxnItHHeL+P32Gu2NSHbEt6WMHXj7S4BmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwwCXNaaoMASbDMPH0u+AvfsicVuqNtvMsaO8I1qxzw=;
 b=BvS7VWdZBMfTE2qYSxRtOxNqbbgcewwgGwMxV6Ir8CCqGGvLnktemu231VZrjrrrG/wJbdBtq6dGiJ7Mx2jZn8Iu95mQ/7cbwAj1NvqAgbZYKdZefgo5EsMxsr1pL/3fKhkzZD65+i3hiJKNpbaH9PT8T2NRf/6q/V6rxaQHPAo/FRhKUqVods+8b16GopyyIs+sLBSX+dwx+q8vw4kxgqaTcQUVD8PAYJ+dLBkkXkHZgRkhVF8LPqTworICfOkCvpLpBjVzWyA2GT/eM5X6YJbkn3nqzyVclsDZbMOe/27iNJN6x93KFVE8I8BmkuGLULayqqFphLQg7sqwk2mpvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwwCXNaaoMASbDMPH0u+AvfsicVuqNtvMsaO8I1qxzw=;
 b=ux+DtYQBRbWInHnxCu83OV0YivwBu93Peooh3a6/ueK4kGnWE3ZEuxJMCwf+F7V3cfGqK1XkxVe4GRdERNbC6Oa4LuEx4f5cxCSEubPp22A1S3Qf0BS2XknGmWHxZFeMdTyh7eya4KEXaif3RvNHR0Nhb6T1M3ZqD+Nsl75k9iQY2MpSBQg3vShhGl2NxACN3WFGNpV9QbJ0067Nl2NS0zbIVc6ZAW+iioPhZuouNz+o0F2N8l7A+w9fXr+RdPZNJRrhVu/Ui5Pv26hbtIJVuF8wMhr6eF+V0tbSRnd6piqoIdCqjZ+owO2djM7tx+/02zs5RFCmVHcxnxLRXpRM/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com (2603:10a6:20b:676::22)
 by AS8PR06MB7608.eurprd06.prod.outlook.com (2603:10a6:20b:337::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 09:43:53 +0000
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69]) by AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69%7]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 09:43:53 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Mon, 25 May 2026 09:43:39 +0000
Subject: [PATCH 3/3] serial: max310x: honour rs485 properties from per-port
 DT subnode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-b4-max310x-rs485-dt-v1-3-e6c19b4d5592@vaisala.com>
References: <20260525-b4-max310x-rs485-dt-v1-0-e6c19b4d5592@vaisala.com>
In-Reply-To: <20260525-b4-max310x-rs485-dt-v1-0-e6c19b4d5592@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779702230; l=2877;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=Jb0kxdJyG1UrpdSkUvdAsI/xelm6UTv5JvmVG5dDbWE=;
 b=qEIFzDEXFgIz/fAeXgV+CrSGEinURsR6cC/EInmytyx+JK8BHOwCJ+o+4jY6jKRmKNBulC37g
 cctPpHJWK98A/sMfUfkpI47RiglLIVE6ht5BQl8AE1hjXkOxUTat2WS
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GVX0EPF0004F082.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::626) To AS5PR06MB9040.eurprd06.prod.outlook.com
 (2603:10a6:20b:676::22)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR06MB9040:EE_|AS8PR06MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: d3ce7356-83b4-4a8c-1935-08deba4221af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014|3023799007|11063799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	MIY3b2iLWCqV1vENYiX2k/dJotbqbzvdfYnwPlq0KDOvEl2LwnGSpmms5t8BUZqryOCill4t4oo56URVDCGFerQXjQ3USMJswkfgWR0LRLwubWhwEYgvnttEMRsF6/K1xkI7vYQkXIkOymhuWlhYrc3/EhwdBD13xWNi7tDcK1pFAaUI7D1W2Yorv3hUeRl6YtVSVtvvzwS1ltjHROmeyVjljEvyTZSN0EavqBF6tcurwspvI0hEowYbliSNyfz+X68CM9llwv7wsu75oq2YbdvRHH9GexlI++otAFo1UrJl1VoCS6dMC9+Xnm8fPhuyeCK39LpcixmYiR+SFjoec2LQ+J/M4b/Op6kxrrZgSqMIXYuieqlyLD/DB5W/3nLIxZ7L0q3AqJT64ipV4YZdkA+ZwvVyNIqXhu5TzIQdZcoWnwqUoIhXxAuxMtOOylyORcKN/RGYGz6HO7+RG43qxseZ4NIsr5y0GoY4nRhUz6tl6HgOWRVbDcnp6PTobn2c80AN9oHmAFcecqpho3vPdJhDKuZEIbTkGOCv9t6uLGsY/21YXb9iyPVnTIjnDp+GaQi67gW/Q6hQT5WHDTrw9CgBrh0DXtDLE28zLyNe1hog9uesG5SgScrBO3YDZrZk8vm+mirR4X7q5Bpwlyq4P3u28j7AOrN9FFpSeUAy9pKagYA3Iu1pWE5V06o600MbKL0rrxOLHxfI65LVEHtZK+ujy6r9GeiNNJv6erm3Gz3bkK153osk1d6o0HnqdtCC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB9040.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(3023799007)(11063799006)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGcvVzBKcjJEQ09JSDVmMUg5TU1DaWJTNUh3STg4eDBvNVBneGRydlBBL2Fp?=
 =?utf-8?B?RXBON2lmNEsxOXlNdGJKakJMN29OcjZXYlQxK0lOTUVQaWd4Z3VIZU1leFNk?=
 =?utf-8?B?bFVUcWVvVHQySUtDdE9HaWtzMVBlUVhwUU5ueXVFcUd1N2gvdEFKc05MUHR5?=
 =?utf-8?B?Mk9XYVdCWnU3SWk0VE5pTzJWYk5ucVNmZ1ByYjdxNmRablJkcFlXWE1OeGZ3?=
 =?utf-8?B?MGhaQnowYWhDS3MwQnhJUDFQSmpLSThWbGd2YUlwakN5UkhLOFZ1RGpmMmIx?=
 =?utf-8?B?U0x6cUVyZlNkZjhzdmVERzNIaWxxdTIzdEV4VEc5blF5MEtkUHdrVlFpR1V0?=
 =?utf-8?B?L3BTUGI3S2ZWZllZeGZZQWdoQ2lRWG1BTXA4eTBGRVdaODQ1U0NLTk44Umw0?=
 =?utf-8?B?dWIzRTFtNnFFWGJEZ2lhTTYweWk0a2doQmg1UEExOUVxWnkrbGo0RWkrMlN1?=
 =?utf-8?B?cnlnUDNzRWNQTG0wUWc2ZzRFajkyeUdwWnlZMEI1ZXM4WFJaNFhONWVFZTg5?=
 =?utf-8?B?TXJQeG9Lc1MxZmNUV3JWcGZHbDh0UHFpRVVZVGhKNTVtRkF1QkVWS2lNamUy?=
 =?utf-8?B?NEpKYU04QkJHamRuL3dZVzVNRlJTWmhSVWdaaGlkbThuK1lMRDlrbWZicGR6?=
 =?utf-8?B?V1dLbjZ4a0FUMTBtQlBKNmFuWDFndDgyVHZRbTVMVWtRdWVSM0xKQ0hZc1FI?=
 =?utf-8?B?ZEJtWm56YzE0RGdjZjM5dXZqajFNRzRCd2tkTTcvREN1WDRwcTZhbDBMNWRv?=
 =?utf-8?B?a2xXTWMvNHJDeEcvQ2JuVU0ycW9sY2NidExoR05kSU1yMW5nbnBoRjhYUUx2?=
 =?utf-8?B?Y1R0Q1EvYmJWelJYK3hZeGRUaURKbE5pN3pRTm5EckdPRy96b2YzK3hwM09p?=
 =?utf-8?B?NmtDWFlZam4xaHRpTVoxeGwvZUlXT1JQa0hhemgxWm1zTFlhcHgya3lKVWJS?=
 =?utf-8?B?a2tyS2hmNjFDVmEzd0h6a3VwakxWTWIrd3JCSjFkdHBGVVlrTXBTYnZmdW5C?=
 =?utf-8?B?cFhkeVlMbk8zcWpLYVRIaFlUbEJOTlhnY1JHTzdqZ0tveHFXQ3YzYmVnL0x6?=
 =?utf-8?B?c1FLVVZtSjRUVHNxR1pUZzJkU2Vsa1FaYkZoWGFONERWMGtRSTdWVERFbEI4?=
 =?utf-8?B?VlVHTTJUUmtNYXJGQkoyTXp5cFZQSldKSGVIekx2Q3JMY3ZPc1RXT1k4WFZv?=
 =?utf-8?B?R1VVMnJieE14dk1mSFo2WjFod1R4M1VDOHRzbGNVUUZDbkhocEJmeUFVV2Jt?=
 =?utf-8?B?NWxxd1RzenJ0UTNBV25vRG1QUVRma2VuM3VXZlo3cG9ES2hMRm5sc1Q1U2lj?=
 =?utf-8?B?WHFEUm1FV3ZlQllsNGN0ZlFkMkZLSXhSR1RRdmVCS2Y1cHpGQVA3azZXZkVz?=
 =?utf-8?B?YTFHc0oyeEJlQ0ltUmlRRktYSTdUWVVGRkhVNXZDV3hvR2JaelAxelNTL0hi?=
 =?utf-8?B?VW9JL2JRZHFCNEc0bmRWUTl5ZVptVU1UVGtiVVA1ZkdLSmpqUlUxYXhMVVFF?=
 =?utf-8?B?YmVBZm40d1NRQnIrS0tWWDNJY1ArU1VWNFVBSVNlaGxCQm1kQVJwVG5xc3Rw?=
 =?utf-8?B?aGhmUmk5aDJDN25jMTUrM0p6cE16d3Y3ZTIwbHRYay94Rmh2YWl4ME5iQzRy?=
 =?utf-8?B?cHBYMnlIbEw0NjJkYk1yWEpKYk5iTUdMdzMvNWcrK09Nc1ZuUnFhZHVCd0NT?=
 =?utf-8?B?d0ZPZ3F0bFpPOFQ3R3FnbmFVNXZma1FTdWZCN2V0VlE3UUZoVVVUbmY2aHpU?=
 =?utf-8?B?TWVkSTZMaWZldG9rQVVZM1dyUGpoODN6U3h5aDZQQzFPY3M4T3BWekJZeFN1?=
 =?utf-8?B?UTRTQlJrVWp3cVFhV2JLN3VWRWdSeWtFRUwrWjBKQng5NllnWHNHdUtLc2tT?=
 =?utf-8?B?VzRjdjBJY1o4dmFibzcwSkhjNjJJdkVkSGREK3NPMitPemlROFhsNStCTjkw?=
 =?utf-8?B?ZDBYSzBhWGE5cHhPeGxkVXA1dlYrREVvNWVtUG4yT1c5RS8veE1zOG5qTGhP?=
 =?utf-8?B?US9LU2pSSlBiOCtjTjBWR1dkUks4dG1XR3VHQU5zUEcyeGFWVitmekVTRVAz?=
 =?utf-8?B?UGVjelZlek1qM0lCbDJSdDJLc2pNTCswLy9rdjY5V0pXeWFrTkpKWnZCbG5E?=
 =?utf-8?B?ZVdHK3A2cTk2ckRCMURUd3NlQ0IrNHExemlEWUpJSktwd2QweldHOStlc1hQ?=
 =?utf-8?B?dHVVNWlEUGx2SFNtN3I0bkQwUDA1eno3N0tLdlhWYnE5Qzc0dDdYMDcyenZN?=
 =?utf-8?B?RHFobWhxek1HaklLbFE2Y29Na0xVVU9nWEZEL0ttd2I1T1VPN1Nxb0xYWi9F?=
 =?utf-8?B?YUpieDZWSEl6TGNRN2gyeGdERk5RV1lMYThBVS95eDlCaUo5R3R4VXIyYzVp?=
 =?utf-8?Q?ClgIWQx7mNUewbog=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ce7356-83b4-4a8c-1935-08deba4221af
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB9040.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 09:43:52.9904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rz1qPnPyg+SQAymcl8ZPWIukITPg5Jo51Ev9x2eoy2sQVd/ZBCwHmqNveysUD94C0jRWXX/QijmjfHPtCzFoLmxbtTbSRXsNgAOuuKXWnfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7608

The MAX310x DT binding pulls in /schemas/serial/rs485.yaml via its
allOf list, advertising the rs485-* properties defined there - none
of which were honoured at runtime, because the driver never called
uart_get_rs485_mode().

All ports share the parent SPI/I2C device, so uart_get_rs485_mode()
called directly on each port would read the same chip-level fwnode
for every call. Walk dev->of_node's children for the one named "port"
with matching reg, and temporarily retarget the parent device's
fwnode while uart_get_rs485_mode() runs, so each port picks up its
own subnode's properties. Probe is serialised, so the swap is safe.

For single-port variants (max3107, max3108), fall back to the chip's
own fwnode when no port@0 subnode is present, so existing DTs that
declare rs485 properties at the top level keep working.

Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 5cb7d01e404663dc25b88bc7b4f8df61be2135ec..745498034293cf74c8b4d25b45739e787f1843de 100644
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
 
+		/* Locate the matching "port@i" DT subnode, if any. */
+		for_each_available_child_of_node(dev->of_node, child) {
+			u32 reg;
+
+			if (!of_node_name_eq(child, "port"))
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

