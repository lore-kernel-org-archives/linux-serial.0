Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.103
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794823059;
	b=yHb5GtAOJ7WCvC8yZ6NfF2QXmvAnN6ucDm3DCBpn8iBH7G3fV8vjt9+krFWJPWn/7JXf
	 3TGgWpaHScqpk8iCQFvPa+/ceL/gkogY+RH/G5lYBWAkT9J8lt1j+LVlo10BSR/y1gXes
	 sjCMqa3Zp9M7HQW4IVidNtjG/z6GKawN90Lp3tCoUSrv72SnIg7MUye7Ar7PkeYHH/zkY
	 ULSWrUPaVbzzW5rFoDyeChg4Ds0BXvk6Ba5hQ7pm9HE6tfURn+sCQ82f9hc9JHTuxIuTR
	 jjEU05/f2DNVv/WUFjZjXWNTW5fQFwyEXPMTg32qRgggwbbb7Lnxtmii4QA5rU8OLuw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794823059;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=OgMzjLxnJmAV7zU1n1doVIEiYS8OH42EabYDwDi9m+M=;
	b=EDZ2ISo6jUP/1VbNSw+6rORmGJnEap51VBKrGCkDs0PIoEU9yLEpZUIK5jUpZexYrk9C
	 lUP9VBjP3yemOakcKX7G5rCwXJnpgqy3SqqUZJMoz4C6lcpUlkwCd9MGg8OFuhw9yNPLN
	 EfMNPe93/cDtyGr0pzPDda6YAF31rUN3H7+WOszfOd0o+NZbUyByG3nDn2V74/BsdEE4t
	 o0mGIY/Nbph3Kq8YVXNCKsmfFHCP7bISnQoadoVHCQ53UURPQbiOu7TZh32MzqXnPBgJH
	 wgGuogQuTd9e8TMN/1fEt/mSJQ8VgDhyF+DXE017LFVhi5Cv3pMllXpjQVPBV+tsNdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=so48pcb3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.103
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021103.outbound.protection.outlook.com [52.101.70.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A79606A338;
	Mon, 16 Nov 2026 09:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03A79606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=so48pcb3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGKBy13+q6dZh4aYbvbNJ7Unsp3ebCxCQhgnw1wixnOjbI07v3FS7vh7C+cR1iUT3FWJU/jxEWyRGXt5pzUsH+01FkqcPD5nK4uO1iO3wkOQLWR2jRcWIyibt+MKQ5hWJ8RZZUJPVyvr8tjMjq+3eLSTKtMEgDroehoyKBE3eoqffqnYyAP6Du3IqUll5lwtaDrKuJyJqMHHUhFO6hX3Y0keX5hcSb29JpDPK2C1PMny15BT9+rTAN1ik898Eg+oXIOUWQv0+VBAEOZ2v/OQQZkVkiQM4BH34VxMe46/bNR/f4W8wm+FAukYQmLkGNYxhuAyaebenyL9gaqI4Of1Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgMzjLxnJmAV7zU1n1doVIEiYS8OH42EabYDwDi9m+M=;
 b=JRrV5v+tUjyqsLGja0+mA61IFwt51NcGw4PaOq4LD4pRS5Jyz83GCdO/8Pr5fiFbZVbGg07OCVg9NMEamw/GkUQ0Y5VFo7retOJSXa6d3ClgwDJg3iYu0zjomlKWVSAUeD2i2+N8gYTU5+M77uAxbTU/rM+COABpaXRwTWt12NIrwryj9s6GDB5QnY/syYHABSmRBFmWDoomxEBQ4WklyXU6AvIsvql+n7hxoEBdF4SAoVg21qiQyhR0VCK4BsW30MWhvT7+fdu9ADWfS9iKk/l6WCDbBTGa9B6jCvFT9W73JgHqi9YW7ES3pX2P6WCB5bqlsvBAxXmCX6Fyb+UV8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgMzjLxnJmAV7zU1n1doVIEiYS8OH42EabYDwDi9m+M=;
 b=so48pcb3S1Q/QqnEBtqoEJW+7LTUtjItd8qlpesf24XTz/MRifrn7f4PwwjH2z2iZ5bD9GevHdt+4J3ffU4R0Nql2EuYq242wmELT7Nlvt2P2mEMhzSJRkaEfAmHZ+NZWxFDDqVHR209/FfclOrLkmI7pWe/4w45QlhMTIv4Avu3lQHZyG3U4CjxxQgjrAkHiu9oloGXL/nVB33ZAaF32GXq6mt9kPFpfMjnhSLJDiHIOtTAJwSCkHizqi9n/zvuuMpANO2a/dOKlk858sYrnatiW0rw23YO0UE5YVE21V53TzDO8O54dUypHgFH+xVYLVl2llGsqPgdtskNoG+xUA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by AS8PR06MB7541.eurprd06.prod.outlook.com (2603:10a6:20b:33d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 09:57:32 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%7]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 09:57:32 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Mon, 16 Nov 2026 09:57:23 +0000
Subject: [PATCH 2/3] serial: max310x: re-check the TX queue before the
 after-send hold
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-max310x-tx-fixes-v1-2-61c01f180911@vaisala.com>
References: <20261116-max310x-tx-fixes-v1-0-61c01f180911@vaisala.com>
In-Reply-To: <20261116-max310x-tx-fixes-v1-0-61c01f180911@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794823050; l=2547;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=yxw+rga1UVi0Z2vhADlUFN5h1RESJIQyhsg2WO4xdTQ=;
 b=UBgSB2hqpLDP4MP53hMSiUozDs4PSPwqsLq7rjtDhQq4ijdKtHQcf4s9spGTu2JtgUoH8KRsf
 1VMFceB1iVOBUkdgiLN687B25uSx8BuMlsqfUKe6QyesXd1r6CnoX1q
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GVZP280CA0068.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:270::10) To PA2PR06MB9176.eurprd06.prod.outlook.com
 (2603:10a6:102:407::17)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|AS8PR06MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 49e8681b-a5ec-4ea7-e546-08df43c80897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|23010399003|18002099003|22082099003|261009223027099003|261022105027099003|261021123027099003|261022075727099003|261021121427099003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|11063799006|5023799004|56012099006|10067099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	+REJ0zxPdi/6J15C+g/47veZj6zSwVuJhUnnszxK03sAFRIdKFPYPUxIn4TrhcSAsh0MdgykEKBW1JdKZpTdWNgqQlz6YQ2O2nxKjp5GEpHBv5IljO2hmRb3crS1jlZrvg+be9HqLUOm+4OHeBwsWtFMLzEA8lnG3/aNJaaEqO/nWyuAL7+GGt7VIzu3OAxyw7qHXn8ENbTn98n1p7tkL27x3rZJPC1OECOAOkE7HDyGY3qM03oPTNxRE7xta4pmNkbTpzlcJTAw66gxnspl2ASVYt4NMs5GQRchJgOVuVYKUyeNmIAdBpd4RJHZKuSUGmiww9f2+cDcVZfPXI7F9tLtBwaf7/qdi0JgRP9UCVicLaCLLU14bDH/Wi2wij3r0QR8DaS6q2/4uUoMqj6d9hiSVFqDzyIoTYa0e4PtG0tRVhVplbZzzwy222q3Gn3IISAytOK/mEjQLYFvfPOuS2YkagLHUEbMx/5NdgSXMFx7tRZp5vopv5sjjBNQDC63i66FtcXX/xHHYebQ21nArERqEs13Mhgf2qUKmX1KarOHJAUOaNelJ6l46hc5hSKOLObVat+E9yOI+CY17a6ho6dTtmCKt1n18StpfshgIeK7hheN9bcqBNc5L+ehokuIyusEeI7isMCR1pHyIhoWzcXE9K9TywPUkFSvaPWprKnI/TS1QAxiJlVwL35wBe8sydUCIW3pO6XpHOoh3Qowmw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(23010399003)(18002099003)(22082099003)(261009223027099003)(261022105027099003)(261021123027099003)(261022075727099003)(261021121427099003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(11063799006)(5023799004)(56012099006)(10067099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alg0aWJwRVVhRlNVZXJBcDhONyt5WnAzWDVEUm9GZWNnU3diSG1ocWJJdmJh?=
 =?utf-8?B?dlhUS0Z4bVhwVm5PQmdsR0NySWFrcHMyMFo0REFHWnkvTnQ5Z0h2QnIvU0JL?=
 =?utf-8?B?djJZQWtRUGpaYnJ5d1g3NkdncHcwSlYwbDNsOXVXMGxSVC9sUmc0ejcxQ2lt?=
 =?utf-8?B?Z21jNXBvQjNXWjZEZFpET3VoTDhRWjZCVmNDaUtHY2t4aVY2R0RLRG1hYXcr?=
 =?utf-8?B?dXhTSlJaZEhaWi8wM2JLQ05WTCs2TkEvYldQRmJHZFUyeXBkbXdBMXNOSDVK?=
 =?utf-8?B?NlRXckZoWWQvN2plQXFVRC9yL1BTdSt1OWMxZFZNaTNaa2l2bmZ3VmxkcTR6?=
 =?utf-8?B?Qkg5b0NuM1g4bHM1WUV0ZHFXMWF6dUtxMEM0NzdXTkF2ZzF3UllkbnNnUngy?=
 =?utf-8?B?QnlrU2FrTTd2cnlTM1pvUlFTdzFyZWtIaWtnamxWS2F4ZnBKQVk3RXVDYnNR?=
 =?utf-8?B?K0c2RndvR0FzTzdrOGEzb1dIZEgvQmVCYUhTcU1kUGVYaXB0SmxEUkdaWXlM?=
 =?utf-8?B?Vk91aW52S2hYMUlHbXcvUDNjMWNUR2EybzAvS2xDSWVHYlpoQjBjeldYS2JS?=
 =?utf-8?B?U2c2eTNWekJGTE5nYlRubW1LNGhkZmJWbXdlalpVRnZHSFZKMVIrZzVpWWpE?=
 =?utf-8?B?b1VBM2FXa3QrQ042ZGZOaXpGanRKdW1EdmxMUWVrclRFc1VWTi90dWVtMzRj?=
 =?utf-8?B?a3JxRW9NakpBWE1VVmV4eC9DUzkvY1BlR0E2QUlMSjAxUTZ5K1NMSXNnNzBE?=
 =?utf-8?B?bzNMOWRJb2xtajQ2ai80Q25wMVZmQW4zRzZWTDNuaUF0SjBYbE51dFZoVE1l?=
 =?utf-8?B?MDI0bmgvTE5ab1ExVzVYdit3QXNZNVlnbFVtYU4wNXA1MkJsSnplQzZWZSsr?=
 =?utf-8?B?dVVWaHp0NllOalJISXU4ZkJtT0FXaUhCOThLSG9pRmZkQnFubHpnTmg5anQy?=
 =?utf-8?B?cFVOSnV3RS9iSElyNkNUck5hcUZBekhwWmFKYWRwM21KSmxQUlNaMnRwdzdR?=
 =?utf-8?B?b1E0SjcvOUQ5QWg4eE5ZbnhHUmp0RGg3QXNvRzhydGVDT0tQVW1OVmF3WkhC?=
 =?utf-8?B?ekdBci9FaVpUNGxUU0p3QWJGQmlaK2tsVnd5aE9RUnhlcWQxYzJXejI5allW?=
 =?utf-8?B?dVlFTllyeEgyaTBIMDI0TWhVdUc1WE0yRUVlVUgyd3JQVjE2Y0tNLzVnVGY0?=
 =?utf-8?B?aytVM0duTkN0czc4U1NCWGdTYVV5UFdCM1hOY29aVFF0a2xPdnozcW8rMWlx?=
 =?utf-8?B?RFVpTXlQQnNJY01sRzhRWWpPTnBZdWdHMnI3bUoyWUNuT3BkaDZSbXJXOVBs?=
 =?utf-8?B?bVpEcm4wQVZSQXR0ejFweGYrVks3dmFnTUtOZnMwZU9hUkxPSVlsdkpRV2RQ?=
 =?utf-8?B?eFVMWklDeTBKTkhQTm1IVWtrMDdFTjRwYnpaa1BmRXJ5SXJrMXNXc3JiWUNJ?=
 =?utf-8?B?NDZya0lXTzhuTjBGS3VFOURMZHZUS3RKUkxZNzV6L3cxbVFKMkpmY2xQRGtl?=
 =?utf-8?B?RDFSTHZzMGhYaHBmQlBVVlpwS2JMdnJVZU5LaFRCaENQc25oQjduMjJHeWVR?=
 =?utf-8?B?Z25NcWpVK0FIWlFwUlVKMGJEWWx4WGdiYTBWbzJFdFl0M29ndFRkOEw3aFVF?=
 =?utf-8?B?ciszd0RqaGFkQmJRd1hkcEZ3aWFFNDFhKzZaR1hTK2FzOElhMnVPQlc2R0dy?=
 =?utf-8?B?YVlZTzRBNVpLa0pNU0s1YTI4TnpjK1FvYjNQbGMwY2R6QlJkVmdoRmtMOUwv?=
 =?utf-8?B?ZExsVFcyRGpGdmJneUorU2Z2eFcxUTRGODJCWjF2aXRjdFBvb1Q4RTBhUkl3?=
 =?utf-8?B?TTlZZ1loTFc0N3pwQm9ObVY2TXdiMzUveWc2K2NGN0dGL3BnMGdvc3hhY2xa?=
 =?utf-8?B?b3dXMUo1U1FwM0NYaHlSTGIrdi9oTnVZZS9BTjRtUU5yTmtWclZERytkMi84?=
 =?utf-8?B?YTE1VEMzTFV6ZEdiNm9FbWgvMGQ1MUt1TjRxYytGTHVUNFNSUHZlUThtNzBB?=
 =?utf-8?B?MDZaenpFQTRydTNwYXlIZkdsMlRDeWE4L3hDZEx1K3I4OTVYbVgwZVJGc3da?=
 =?utf-8?B?ZzYxRDM5OXIwN3FBVThSdElPdkRIR0xQN29DbC9hbEZQYUJpRGN5c28zVDNa?=
 =?utf-8?B?c1RSYlBmbzhmSWxNZDhGb041WURVa1NYN1RDcHFkMWtzMnFJUlJaN3oydTBx?=
 =?utf-8?B?WHlxK0Vhc2xLcE9PRHdLQWhhOTIxM2xKcjJ3QlpWcFJBalBPRFF3a2VBcUZJ?=
 =?utf-8?B?S2J3YUwrRlBlSUJvL1BCRUI4QTdiSGNkRlhJdFFCY3kxMUxNY3FpTTl6eUxz?=
 =?utf-8?B?OElybEJXV0ZGS0RrWEhoN1preFV5NzRVbnFxNnI3V25zeWg5SHl3ZHRoNzhM?=
 =?utf-8?Q?TiDHAMb3MabTet/Q=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e8681b-a5ec-4ea7-e546-08df43c80897
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 09:57:32.8123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQOS1jdJAmaZbJgMrtQJD/AFg3kYm4HNVc6IFXKV+yukXWsAR86T2vaqTHloNf6JtalQPEAze+slM5n1zEze3LfvxW0VB8imY9dyMy/0MeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7541

max310x_delayed_stop_tx() decides that a software-timed RS-485 envelope
is over when the transmit queue is empty and the chip's TX FIFO is
empty. It tests the queue first, then reads TXFIFOLVL over the bus, and
only then takes the port lock and arms the after-send hold. The bus read
sleeps, under load for tens of milliseconds, and write() queues data
under the port lock in that window. start_tx() finds the envelope in
MAX310X_TX_SEND and does nothing but reschedule tx_work.

When the stop routine resumes it sees an empty chip FIFO and arms the
hold on a queue that was empty before the read. The hold expires, the
RTS release is scheduled, the rescheduled tx_work pushes the new data
into the chip FIFO, and RTS drops while the chip is still shifting it
out. The tail of the write leaves through a disabled transceiver. No
FIFO overflows, so no counter moves; the loss is silent.

Seen on a MAX14830 behind a slow SPI path with 20 ms of before-send
delay: 25-byte writes every 20 ms lost 1600 to 2200 bytes per port in
five minutes in RS-485 mode and nothing in RS-232 mode under the same
traffic, overrun counters equal; 96-byte writes every 60 ms lost
partial chunks of 14 to 75 bytes a few times per run.

Re-check the queue under the port lock before arming the hold. Data
queued before the check keeps the envelope open and the pending tx_work
ends it once that data has drained; data queued after the hold is
armed is already handled by start_tx(), which cancels the hold.

Fixes: 33632215e1bb ("serial: max310x: drive RTS in software when hardware delays are too short")
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index e6a740295b96653281a92f8d94999f06c2c74685..7ddfe8773faf9bc51621c49fa5d8e7d6b1e4bc34 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -897,6 +897,14 @@ static void max310x_delayed_stop_tx(struct uart_port *port)
 	    READ_ONCE(one->tx_state) != MAX310X_TX_SEND)
 		return;
 
+	/*
+	 * Data queued while TXFIFOLVL was read: start_tx() saw SEND and only
+	 * rescheduled tx_work, so arming the hold now would drop RTS under it.
+	 */
+	if (!kfifo_is_empty(&port->state->port.xmit_fifo) &&
+	    !uart_tx_stopped(port))
+		return;
+
 	if (!hrtimer_active(&one->tx_delay_tmr)) {
 		/*
 		 * Add one character for the byte still in the shift register -

-- 
2.47.3

