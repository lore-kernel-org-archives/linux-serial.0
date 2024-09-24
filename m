Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E14D1AAE2D;
	Tue, 24 Sep 2024 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727187185; cv=fail; b=OoAez9nlxggvZRixNVWiPZFo3Ze94hfwKhi0ztqpv3Qe0Bshuo5/TZqKb9FRyPXC9jGnLqfYF3te26U2ycnCefHMvcmY+07qf+Q/5+MfesnYSYm+zx8s4SsaoC5ZLMcDgIzD6P4K7OSD2ZFp+g4heo1wRk4zrqkwdgFPZ502uoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727187185; c=relaxed/simple;
	bh=9BS8rkL1QTTXNs58BG8bOTv58bYul+z+3qK+ATtGVwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b1UY9Rf76uPv7zBQHy8NV70obPwG0XzHB1qdsALLS0MC4p06dHoMzpL4732P8vCBJ+zhDmRlrpVg4xvSdIJ7hpR90LwAaW+y43i/hFwMgos3++xY5VB4KR4KYad0RGBWCJcSmp1M5PExfFp38fUJ4r75kLvfQzaAfRG1+bL3Xl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=I393AtOp; arc=fail smtp.client-ip=40.107.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="I393AtOp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4G6cifa7hY73BBBaOC2O3+01eoy70SARzX4Ky14/zpG5Lw+zqp7C9AYDKTFBEPPgUisPyA5Q3xQYpSSQEW/tQbuNUZGeSsuyOlgBaNrfaouiP9Hhi7Mw8vH/RH9I+ljGKe0RLhXmuc19gyDFtaN6LhoEtB7pubUYbekq6BbYf0nMqOkA9UCeMvBUOPJjBjC0UCnbnpv5E+TzCevUPfWg4aNHNPlTIz6XE+cJlJxAg3vCZXF92hnPKA6I76zLzr7fmU5g53s9jxUtSoQ0YtBtXmGuhY8glDkq4tb6xBFi2BOpvz2sk8oCRyoZ3vFB9bms+6PMxgPh8MOWzgWTXJ9Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yspjoETqEAdBLiFSRO+LbYk8sVc/EX4lsqm7Ql8O2EM=;
 b=mVb6Yis4YN+uR9v9errv0ZAuR5NmDVevu5tPJPW1iC39rN7w634Ed0KDV0PW8NvjJYqFwBY/g6VOl/olsBcpKtYI4qAi5m66Sos52AAd9nm7u1EWGP/pEdwGXCAppHodiX9R/2K8rpIOFi0Ip+s7EgGDfo3HEiBwXypN7W7rLzP463wjTq+HiLx80nQkKNnfUM6mjaSGbcrExxprtKKtPCybIp9JSNC7ps4m5Co2mSGRUwnXHVu4SWaGNW5EDlPiykgWMXAfIPJZBqlEIBDUd2362E1JWWztdkFCPcQQUGFYDZc0d8n3118Gqj3rz/BWyu89XK7pJ0iVyGFH2HYzEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yspjoETqEAdBLiFSRO+LbYk8sVc/EX4lsqm7Ql8O2EM=;
 b=I393AtOpkdCWqW8mP/BHfSAQBUHKG6IyAopUWkeggUGkbxlNF7Dni5U+jc5dioDB6nImtoIPHR4G4/FT7TBebO97vnr4ImFswa/JqTijj/aRDrfIIanR4hCznbA9nA6wILE49aB0cRsJUMhPEdPiJPZRKhW8ZbJkQ6gAOU/o6+e/fMGxBXskCm6khGxkMEUbErdmqz/XpSaY+wtdoCfThhuXk0k+Nj+Ep9co+S44o4nSqtHUVzhkcfjeth7ClWWJNm4w1YCEOsLm3/l7tBEvEcXzlvFpwWnLUoQzlxe+ptIorcCw7oRQsNIFSYDID7JaZelkmTBjcDqkilp1zpWImA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by DB9PR04MB9791.eurprd04.prod.outlook.com (2603:10a6:10:4ce::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 14:12:55 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%7]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 14:12:55 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chester Lin <chester62515@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH 2/2] serial: fsl_linflexuart: add clock support
Date: Tue, 24 Sep 2024 17:12:47 +0300
Message-ID: <20240924141247.132455-3-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240924141247.132455-1-ciprianmarian.costea@oss.nxp.com>
References: <20240924141247.132455-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR07CA0002.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::15) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|DB9PR04MB9791:EE_
X-MS-Office365-Filtering-Correlation-Id: d3a6b197-d9e2-4f3e-1fa3-08dcdca2fbfc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVVySXdmb1dXaG92eGhla0pUejBUMTV0bDlPbHpIbmJ1ZGRJV2VDQnR4YzYw?=
 =?utf-8?B?dzhnNUVJTjBvMTJDYmtpODFYTC9OUm03Vmgvd2plQy9MVDNUbmExeXRheDVi?=
 =?utf-8?B?blVGdEViVTJCdkttT0VTalRLYVlpWmsxcFhIbmZPV2lGaUhxaDYzU0NnOUZI?=
 =?utf-8?B?NC8zbFZ6TVVDMFZlTE8yYmRWdm9UYjcxN0U1NGxxRlp6SXQrSVpOYmc3aExD?=
 =?utf-8?B?bm56Qk9DN1E1ZVRwYXo2Q0hVaWVhM2owZjJVNWdiZVFRWWU3QmxPS3hVUVNQ?=
 =?utf-8?B?UTB0TWE3d0xBQ2dndzBycHFLZmt2SGRVV0ZkeUlmQ1psSEo2aDc0VlJnRkJM?=
 =?utf-8?B?d1lpQ1VtMVRzOHFCckZya2JTRlA2SlhSN3BtK3grRHBPSUVKMUcwRXEyLzNz?=
 =?utf-8?B?R00vU0owZEwyRTFjTitlSGZWU3VyMFJibWNObHNqendPNjJXOXJ5dDFoU0pv?=
 =?utf-8?B?WU0wWFE3VkV0U29XUVo3Z0NXQ0svR0JXMzBOMHFQRVFFU1pwQkUyZWNGQ0Yr?=
 =?utf-8?B?U05NOUQ3YVpwQzR5VS9WQzhrVzVzV1lUVU9JanBQczFaMm4vNTBLNElOTGZO?=
 =?utf-8?B?Y1IzSkpmd3FLYlh1WUtBOVVVZzdEdERydzhNS2NKOSt6QnRKaEFnLzJBaUd3?=
 =?utf-8?B?L0cyRmsvYWhzcGJ6QlhrcmVQUVhRdnZwdkFNTElBVzNmakRmSVZSdXM4dHhP?=
 =?utf-8?B?bHh6aWttMVpZQ1lNb2VZcys1aC9OUk5mQk9QSmp0T2hzWVl0UW1zWEpPb2N2?=
 =?utf-8?B?YXJwWXlBWGk1Q2dYVWQ2cXBQZU9NUTA4OFVqbGIvT1R1RERhUEJXT0Z6ZWhk?=
 =?utf-8?B?L0VRMVZMRTZEMm1qSHM5NjJxcDJPMFBDbGd4My93S0kxeEJvNjVra2xNeVJq?=
 =?utf-8?B?MWVOV2lNbmRKQXY3eFJmL0pGeVdVUXlzOVhBZlMwKzA4alZpUGM1WWJ3RHZv?=
 =?utf-8?B?OHJSc3BJRjBBUWZKYXo2S3luamZ0RERyN0VwcFZZNGlEZFpLMDd3SldPM1Zr?=
 =?utf-8?B?b0JVK1k4LzhLYmFYaGxMVDFEQ29oZVV1eitUTUJQL0RuVXB5UFZrMXl0YzVm?=
 =?utf-8?B?VHVWaVFlZ1dSUDVTS1FqN2txQzJWdEpNTmxIRFRhUS9mempyMC9Bc0IwNW13?=
 =?utf-8?B?c2gzajcxU2ZRUERPTzUzNG4xQTZVU0s5RnF1N3BiOUFvRGUrbWZ4NytlMHE2?=
 =?utf-8?B?V2UrZXJYVzF5aXk0Tnlid3hhYy9RK05OV3R6MjltbWlpQ2d0SUdYbEVtUVVk?=
 =?utf-8?B?cXJVTGJFYzcwV01idWJxdUpuUkl2M1RmRW44RUpsSlZuL3UvOXlXZitZVHpu?=
 =?utf-8?B?T1ZiWGNNWGFydGNIbUFQdEYzRGNtc0dseUdnemt4VVlCQTluSFhZTDM3Slo4?=
 =?utf-8?B?SW1aSVZKZ2prTEVEbHZhSHozeTY5d1p3RU9pUDNKU3h0dVZZVCtBSStzajNq?=
 =?utf-8?B?OG5ZbGRBaXAzOVREMlVkUnVVdmJ3TjF4aFp0K0xHRndQWXkwbDFXQklheE80?=
 =?utf-8?B?Wm5jZXZQWk5kdWMybWR1SlpjQVJ1YU80RUdFOXUvOUxHSWdOUUhJbllrY0ZV?=
 =?utf-8?B?WS9KV1dUY1hQSU1QdThNdVVrbWRPemtibkZiWFFqeEpzYXA5L0dWU1EwZ3Zn?=
 =?utf-8?B?Q290L1pWQmF2bkFySVRHMFNXN3psYzdRa3NMWE5RVnJtMXNVVVNYNm55YUVr?=
 =?utf-8?B?NDJGelFEZXJOMi96eDVveDI0V3dZcXFLUTJpTjFXZGkrb2RSb1dlR0dSU1FX?=
 =?utf-8?B?anh6cWlMQXBiSUdJdCtvOUFLUVBicFoyTkVPeUk4WkZHWGRaZXY0TUhSZlJv?=
 =?utf-8?B?OVNIU005RVlSZVZSU3FwZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K09TRHVoa0g1N0tTajVjVVk0UE1DTG16dnVxL1ZDOXYrSzNGaUVNclpibjBY?=
 =?utf-8?B?YzlaR09nZUxLUUV2Tk1aenBKTW5aSmRVYjdQTzIwbFVKVDQ2RXN3UXBOZERn?=
 =?utf-8?B?Z3lpSi9PSHViQW5tTmZLUS9lSFY2VjdLUFVFZGVoamx1RG8wN2x2NXYvS3JZ?=
 =?utf-8?B?bDVaSitVamM3c3Y4cWdyWnRzV29nbUJRT2VXMURRb0RHS3hpV2Ixb2FnUmdN?=
 =?utf-8?B?djVTek9KdGRlWTBwOUZhakJraWVxM3RpcjhqSW1BbDE0YWRHQ2QxVDRXREdN?=
 =?utf-8?B?ZTZrQzdtTjhIalo2a1V0c1hZQk5IZ0RPK05QakkyZUtPQWUwcWxlRTZkWUw0?=
 =?utf-8?B?N3NyLzg2K3J0VDJTaXVpZDU0dWorR1JUK25vMEpUckRQRzhLaTZSUTJ6QzQ2?=
 =?utf-8?B?SGd2a2JNd0MwNk5xVHVnbmNkL1lmVVBUQUp6NkFXSkNLaTJrQklBN2lsT2Nw?=
 =?utf-8?B?RThIRU45KzZoMDBTYnRSakcvanRsRk9tRWhOaTl1WitjeUhSQ0cxc0wySW5u?=
 =?utf-8?B?aDZlN0pQdWRyek1wVTFPUkRnSEtCWWdRZzhMVkNvRVl2S0tLNzI0YXNBRlNJ?=
 =?utf-8?B?d2N2b2JFK1dBUnpVZjFkZGI0bzdQS2NIWW9OeEpTcFBQcHo3eTRuN1BzUm1E?=
 =?utf-8?B?RVBMa1NkdUVncjQ5eCtLOWhKcHdLeVpNbEE2VHFLWnY0bFdOT3cvbk03RXND?=
 =?utf-8?B?bkJSeHMyWWJhQnhtcjg5YnNja1k3aTNGMlhiblkxK0VQWEJISERpeE1SNkNR?=
 =?utf-8?B?Rnp4SVpKek9pU0JTQWFhckhNL1gvRjFBejMrZlFqWUNlbngrMzJFL1JUNGdX?=
 =?utf-8?B?V3VZRDFUMjVpaFpiNStsUkN2eThOMXh3cXVwYitkb0xnSmdUWGQrOUNGS3pT?=
 =?utf-8?B?WDUwRUVwcW1uc1Z0Sm9JWVBCWnNHV3V1NjNJNlBOZGhwWmtzZ0lpRnFCM085?=
 =?utf-8?B?anZmYytDb3Boem5aR2tLQ0xtL0lIQk56OERWdGFSMXpwV1BubnVxclVQVG9G?=
 =?utf-8?B?eWhmZHdTeVJRajdYOFNUYkR4T0gvSUMyWjVWVGRVekg2VkpQMW0xbHRYUXdh?=
 =?utf-8?B?RmZ2SmcvaE1DQVRndko0QkNGTWRVd1BhdmhPSWpOS0FTV1FkZ1JQMnVuR0R3?=
 =?utf-8?B?ZDh2OGZYbFFrcTJlQkp1K0U4elZpWE1LQXhuUm9WcGpubEV0WEJQbHl4L3FR?=
 =?utf-8?B?NzBQUnEyU3g3Y0ZoR2hLRkFzTGtHZXZzaUhmclpXb1k2cW5qdEIxNjQ2ekN0?=
 =?utf-8?B?bVZXUnl1cXFvM1QvYUxEMGdzM0ltdDRWdFNNbTc4MSt4UG9PNUNBVlZ4S0Jj?=
 =?utf-8?B?cHkyVG5qbDU5MTQ3LzlPM2tkQlJreVVkV3Jaa2VLcGw3MTh2U085SUxiTGcr?=
 =?utf-8?B?OWlaV0ZpMFp3RlRsbG1uY00zT0tjM0NWSXFFQkhKalF3ZUwyOWZFa2E0V1lS?=
 =?utf-8?B?bXhuWHN1TDV5NU5NZC8xekhidmxFNUc4TlRlQ2NPUktLUmJMOTkwODhLTXNJ?=
 =?utf-8?B?dzhZeG5LRllOV2JQNGFIelVOcldjWTlabGdyUzErWnF0Q0pqQTRVWFhqV2Rn?=
 =?utf-8?B?cldoWmxKMUJDTzQxdXc5ZzdmYklaY1RWZk92amxwRGg5QlorNGR6ZmlGT2Ny?=
 =?utf-8?B?MTNPODVJcU5NbzVJMHZGU3U3WWk0Sm5mUVNWUFVwd0czcmFEZTcrZzliZmx4?=
 =?utf-8?B?emREMnRPMHliUGFPcFVtc0ZUV3ZQeTdmbFJ0TjRmaExBdnpEZU9SWURka3RN?=
 =?utf-8?B?QmNQaTJmSGtiaHUxRGJQSkpPWTduQTN0TEc5eVl3Y0hvU1NwQ1JUNTRPcy9Z?=
 =?utf-8?B?T2wySGwrK01sZjlucTcrUDZYSVE3dCsxeTFybDlqeWNheGpaRTFQMElZZVBE?=
 =?utf-8?B?d0RKZyt4eXRucVc3YlhxdmNsTmlmSmNNRCsvVmZVZHR5N080ZUgwMmlSdzhi?=
 =?utf-8?B?QUpYNnhrSWJ4OUhVZlQvWHRuL2N1VHlEcVQvZStyckhiR2xua28vRGxWZEh0?=
 =?utf-8?B?TDNBRFg0ZDdLWkcxQjVHaG12YThzRm9GVXVyKzBhWWpqRHp5L0FWSXIrTlZq?=
 =?utf-8?B?ZkZ3QmNkdTN0MXllaTRjd3VESkRUMUxxTFY0TnQwOTBKYzF2dU9uWGJobjYv?=
 =?utf-8?B?SlZOa0pCYlc5bEdYUVhBbTFjb3ZTMGpHM0NFdHQrZkRVU0xWZXlYdGhOdlRw?=
 =?utf-8?B?NlE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a6b197-d9e2-4f3e-1fa3-08dcdca2fbfc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 14:12:55.1518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zfsp8K2hMpHGq/C4NW7W5iiYzuaIHs2ojJeodKUbelSNIjdt06YFBMHNwgB1fuklXjAlVlHPD7t6WuQ7yQwmmeR3JsXiDHlB3NJjNf+M8qQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9791

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add clocking support to the NXP LINFlexD UART driver.
It is used by S32G2 and S32G3 SoCs.
Clocking support is added as optional in order to not break
existing support for S32V234 SoC.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/tty/serial/fsl_linflexuart.c | 67 +++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_linflexuart.c
index e972df4b188d..23aed3bbff6c 100644
--- a/drivers/tty/serial/fsl_linflexuart.c
+++ b/drivers/tty/serial/fsl_linflexuart.c
@@ -3,9 +3,10 @@
  * Freescale LINFlexD UART serial port driver
  *
  * Copyright 2012-2016 Freescale Semiconductor, Inc.
- * Copyright 2017-2019 NXP
+ * Copyright 2017-2019, 2024 NXP
  */
 
+#include <linux/clk.h>
 #include <linux/console.h>
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -120,6 +121,12 @@
 
 #define PREINIT_DELAY			2000 /* us */
 
+struct linflex_port {
+	struct uart_port port;
+	struct clk *clk_lin;
+	struct clk *clk_ipg;
+};
+
 static const struct of_device_id linflex_dt_ids[] = {
 	{
 		.compatible = "fsl,s32v234-linflexuart",
@@ -807,12 +814,13 @@ static struct uart_driver linflex_reg = {
 static int linflex_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	struct linflex_port *lfport;
 	struct uart_port *sport;
 	struct resource *res;
 	int ret;
 
-	sport = devm_kzalloc(&pdev->dev, sizeof(*sport), GFP_KERNEL);
-	if (!sport)
+	lfport = devm_kzalloc(&pdev->dev, sizeof(*lfport), GFP_KERNEL);
+	if (!lfport)
 		return -ENOMEM;
 
 	ret = of_alias_get_id(np, "serial");
@@ -826,6 +834,7 @@ static int linflex_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	sport = &lfport->port;
 	sport->line = ret;
 
 	sport->membase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
@@ -844,39 +853,65 @@ static int linflex_probe(struct platform_device *pdev)
 	sport->flags = UPF_BOOT_AUTOCONF;
 	sport->has_sysrq = IS_ENABLED(CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE);
 
-	linflex_ports[sport->line] = sport;
+	lfport->clk_lin = devm_clk_get_optional_enabled(&pdev->dev, "lin");
+	if (IS_ERR(lfport->clk_lin))
+		return dev_err_probe(&pdev->dev, PTR_ERR(lfport->clk_lin),
+				"Failed to get linflexuart clk\n");
 
-	platform_set_drvdata(pdev, sport);
+	lfport->clk_ipg = devm_clk_get_optional_enabled(&pdev->dev, "ipg");
+	if (IS_ERR(lfport->clk_ipg))
+		return dev_err_probe(&pdev->dev, PTR_ERR(lfport->clk_ipg),
+				"Failed to get linflexuart ipg clk\n");
+
+	linflex_ports[sport->line] = sport;
+	platform_set_drvdata(pdev, lfport);
 
 	return uart_add_one_port(&linflex_reg, sport);
 }
 
 static void linflex_remove(struct platform_device *pdev)
 {
-	struct uart_port *sport = platform_get_drvdata(pdev);
+	struct linflex_port *lfport = platform_get_drvdata(pdev);
 
-	uart_remove_one_port(&linflex_reg, sport);
+	uart_remove_one_port(&linflex_reg, &lfport->port);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int linflex_suspend(struct device *dev)
+static int __maybe_unused linflex_suspend(struct device *dev)
 {
-	struct uart_port *sport = dev_get_drvdata(dev);
+	struct linflex_port *lfport = dev_get_drvdata(dev);
+
+	uart_suspend_port(&linflex_reg, &lfport->port);
 
-	uart_suspend_port(&linflex_reg, sport);
+	clk_disable_unprepare(lfport->clk_lin);
+	clk_disable_unprepare(lfport->clk_ipg);
 
 	return 0;
 }
 
-static int linflex_resume(struct device *dev)
+static int __maybe_unused linflex_resume(struct device *dev)
 {
-	struct uart_port *sport = dev_get_drvdata(dev);
+	struct linflex_port *lfport = dev_get_drvdata(dev);
+	int ret;
 
-	uart_resume_port(&linflex_reg, sport);
+	if (lfport->clk_lin) {
+		ret = clk_prepare_enable(lfport->clk_lin);
+		if (ret) {
+			dev_err(dev, "Failed to enable linflexuart clk: %d\n", ret);
+			return ret;
+		}
+	}
 
-	return 0;
+	if (lfport->clk_ipg) {
+		ret = clk_prepare_enable(lfport->clk_ipg);
+		if (ret) {
+			dev_err(dev, "Failed to enable linflexuart ipg clk: %d\n", ret);
+			clk_disable_unprepare(lfport->clk_lin);
+			return ret;
+		}
+	}
+
+	return uart_resume_port(&linflex_reg, &lfport->port);
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(linflex_pm_ops, linflex_suspend, linflex_resume);
 
-- 
2.45.2

