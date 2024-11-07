Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195BA20ADC8;
	Thu,  7 Nov 2024 11:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730979986; cv=fail; b=OJGmijnFq65sesjx2RYiea2iWU1LM09WFgnqATGfrUoW95fTls1cgMIJMhY/k6GpgdOSUwVhBasWNP95IAbwK+xY5DgKFwYe8RTIbG+1ITj6jgiexm2i9qtrMUmhAkN3NEjEVJrGR0BSi7B1VnDWuTWP2RvnFjaCaQBvvLjwWoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730979986; c=relaxed/simple;
	bh=qlbiEqkLCwITcySrvE+0Rg/6vCX5fsz8SwhMLZjMxlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AAnfFBVd/703JK9cuznbpbiElok3IcFADZgBeu32XOkf2Nv6HTSr8tcZ8ORPIvwB/GO52JrvuKln8ZBcOk8VcMW9quMqYWVenRRnV4iUjxHBIGc8WzqglNbILpuhuuAK59XSpBxN/sS0vDq0kCoA5iKXTNExh1nIQQd+AhAeGms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=YdyeDxW5; arc=fail smtp.client-ip=40.107.20.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YdyeDxW5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3ciTkNVdzO6TX7CtsHR4kE+g+9MmYsi5/BWlKzwy93yQFeWRGUHAkWHquAB9D4FhlBej4jMH8KTjqIkXRk4jBJ4zhw61xKwpFOViesqAUoYlSlLb5IIQdMBmb87PtD1/jiPc1B35hwWttfpSn6W1i6My62wu96RimZ1ygj33Yb0k6myL7pnkJwZSsGuehuRoYpdB/dKePU96Z3P/d13b9b0KwxfHXQpx+UWEiovkqdkvy3Me/xB/2o8YttdQZHxofdlOpS1OTU11GFnXynig30WwnkVAB7lmO60ngVmzI0Tl3NTFrstF9oxlkBwWKDaw66O+oIENaf4mLiSDsRWFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yr1y9s3NxgYDBvfbMlqSm2pPtBHvj61Qk9HTt1Oy440=;
 b=bbtulcj5+obYX8FfZjek8ThcjwMk9ibAMdtAJwDhFaBDPFPxe7Czvn9Cfpm0vUglCR+HVdpNQqMUu3VDptrsOzwDzQTgZA1gGyhhynkacCc72VDnXNvcF6tqJPzsOoiK5Ruw00lP8CXVq1wJdCrercPWIC9ZA2ZiIfKQut/enbe+V4uGGGEZalq1Lbvg/RbssK5RNY18HtDEET9TFhwTcCJJvAD46fOGy6tg9Y6b1+BzIZ9P4SJ1msakjV/UyFt4Cq2j1rW1aWEb09zp8XrytWZtEZFqApg2Di2UqgRVHtZK4WLoP3qNEuy6OHlGdOvyXOtjqscrePmIjADl9/I52A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yr1y9s3NxgYDBvfbMlqSm2pPtBHvj61Qk9HTt1Oy440=;
 b=YdyeDxW5DGenyUp9dLFU+HBRs0iIhJEuNRayNYPCoWHLU7PZCbzYPPRcJT1XAlPrmlBBsZFRMRWQHu8unRocMdrCjHhlFUbTcXHnc6gHDa9WyIZsHRwtVGi+gzlYlhKlk/YlcZV8gXNd8hX3IZ1hHnTgSnyaexoH20fKNAPmiD1WFT1plUGazt0hLT9h2XPv76zjQqczMtFhG+EsgF/htheYO2xvXlo8+4L82zj0yGnB02zo5suF2cRSIMqjAp3VWMHKRrgDECB9sulaevFVTWYBdt7zx6g+ADvewib3iSOSW1AzUfuR+2heSzuVNEDUgYyfibiTtchOJa2+dzpk/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AM9PR04MB8762.eurprd04.prod.outlook.com (2603:10a6:20b:409::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 11:46:18 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 11:46:18 +0000
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
	imx@lists.linux.dev,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v3 1/2] dt-bindings: linflexuart: add clock definitions
Date: Thu,  7 Nov 2024 13:46:10 +0200
Message-ID: <20241107114611.758433-2-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241107114611.758433-1-ciprianmarian.costea@oss.nxp.com>
References: <20241107114611.758433-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0117.eurprd04.prod.outlook.com
 (2603:10a6:208:55::22) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AM9PR04MB8762:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a161659-81ba-40fd-999d-08dcff21caf7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VytEQWZBbXBtOWk4L1VlTUZpNEZkN0Q1YWhzWjFsdldYbzZjRHZoYXJzY3R3?=
 =?utf-8?B?MThsNWwwWEFLeGp3bUU1eWhjdkxNMEkvQ2NvenErN1BRWnJqZjVNVFRITm9H?=
 =?utf-8?B?dVBZeDVpTndFQXQvT1JERDY4N1h4OWRtblkxS3ZxcFdtVS8vb2hkM2JBYjRD?=
 =?utf-8?B?M0l6aEVSUzFiZ01PUFVsbFVCbTA3anZFendqcmV2ZThTUEE4RHdGZ0pQVS9k?=
 =?utf-8?B?UzRjemZka3k5S2wxcmVmMDF5bThBc2plOUltRU9RS3YwbUYzTU40SFRDaVFM?=
 =?utf-8?B?ZFdRTnhBc1FRRFJib0VPR2hHNjVTS1BpTnFvRHBmbFFNZ3BYSUxnNWVvZ3Qy?=
 =?utf-8?B?eERpbnNSYXRyTEd0T2k5QmZSNUI3VForNHZjZXRWeXlBRUxsWW11QVpGWWdK?=
 =?utf-8?B?SFQ0cURySG9oQmczUXpXKy95R01OSHhpUE9NU2ZlaDhoRkQ5KzZUUkxjNmRB?=
 =?utf-8?B?KzZWR3pVaXVtL1RiRXRidENMZUhHdWVRNGV6OWJoc3RuYUlYK3pVSWpDWmhB?=
 =?utf-8?B?ZWViNTFLUjYvYjRrZUNERzUxVjZkZTYyNVdQOTlOVVRCWXUvc0pUK0taMU1q?=
 =?utf-8?B?MEdJcHZhaDJkLzhsUTU3clNTbmRCWjJSZktBN1p6eHRRTWR3b1hlSlludmF4?=
 =?utf-8?B?U05xT01KOGtzd3o4TU1sYlJhd0hVeDhTMlBMdmhSYys4anpXRFA4amQ2cVBG?=
 =?utf-8?B?VitpQ3dtUzdBTFZCZWVEaFlSYlRRRksva2dnUUtTVnFXU2xyd0lSRUFrR2Ji?=
 =?utf-8?B?UkVUR3ZBb2YwWGtpcno5RnJIaGRMZXg0RUtEa3NYUzVqN1B1SjJnOEdTY1Ar?=
 =?utf-8?B?TEZLVVQ0S1VCaXVVTndtODBHVnVYZERTV0RzOE1rZVFDSzNZdVlZVkV2NFBu?=
 =?utf-8?B?N2ljSVliWG5Eb3UxaGV0dGFvUGw0YStRK05jQjRJblJlOXN0YkllTWF5Nllq?=
 =?utf-8?B?SzJJRWdZVHlCMFg5NEtab05ablJLazd0QnVqaHM1QVpRMk5BMW83VDlGdXFk?=
 =?utf-8?B?elptUE1aL2ZRNjFPUW5RbGJPR1ZHYmdUVjJ4Z0pjdmhXeVF6aS9RM2QrL0hj?=
 =?utf-8?B?LytHU21hSldqaHppaVl3dHdtWkh4c3hUdDNXWnMzRkVHVnVlUlRDRkV6d2oy?=
 =?utf-8?B?QXQ1WlljdEliM25vVGhPc1EvdElHeHdOQ1dRZGk5bXhmTER1djhHU0R2aWNX?=
 =?utf-8?B?K0tCeDJwSU1PSkswZlgxY1IwSjlXdTJuUjhrVVBaQ0pwKzVuTWFpMnV1U2tP?=
 =?utf-8?B?a1YzNHJGMkZJNzdJekJZeXlob1hwcWpQN3kvQTF6NUJjOVJNenExK1c3aU5m?=
 =?utf-8?B?djVvQW1kZjRCVVhWc0JCUlJCbXZndjRjQW9maHEwY0lzR1BLR3RYME8yRDZL?=
 =?utf-8?B?NGtETlpJcnJiaWh4RFBoVDlHMkxvaVFpRU5vRHZDMXJ0MGJFR1dsbUNPSmRY?=
 =?utf-8?B?QVhjUy9rWmh4cnF6UXcwL3Y3bVFuNGZFdTRibHBORjRCRmhhNjROOXM0Mndv?=
 =?utf-8?B?aW1ldGJGT1NYdWFVZ2tUS010ODI3WnEwR3pHNHZqQWZlUjlJUzlvK1lpQmdF?=
 =?utf-8?B?MFZsaVkxdXo2UHdUamN2b3g5bFJOYk8weFFVM1RrUVlNMkp2WHVKNTh0Rlhr?=
 =?utf-8?B?YTFLdFhZQ0hEQWVPSzRtUUFCa2w5M2pzNG5LYXAzVmoxUUFHcDJEcFpJVENv?=
 =?utf-8?B?V2pLWkI4NE1VeGI3UzNOSUE4aHNWVENwL3I1SWk4djByRGZjQXdUSDU0aEN1?=
 =?utf-8?Q?m+tn1EnhZ3fPiLHxJoNAnNACtnY1RW6deB35kPg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDdUdUl2a0hQZTFIYjNpRGdmUUdOTXV4VDc3K2dvUjc4TnBHM3dzRk5pWEU0?=
 =?utf-8?B?dnQ4dW93NDNheHBDZk4xRzRja0xWa0VZZ0RiSkNKLzZPaFRsczZaKzZYQW14?=
 =?utf-8?B?TVRvMGU1WjN6T2tGdVdaVHJiSVRaQnNORllmOFZXaUVCUVk4cEZNNU9PcjNi?=
 =?utf-8?B?NEp2dmRMc09FdEdwekJhOVRBRkRLOEF3Z2RqTTlrWkNIMjBZRXAycGV1OTJz?=
 =?utf-8?B?Nit0WDZZQTdTU1pXaFhFT082NHNvZ2llZHlHWndhczJxMzl4YnNycHN4bkd1?=
 =?utf-8?B?QWg5M2ZBTXhFMSs4L3N4Q2RpS0RMV1R2eGJCRFUxSXRwUWVFR1dVTDl3Zmww?=
 =?utf-8?B?Q2cyQldSYzlNbmJlZm5aeFhVNXJ5cldDdlp5M05BbGkrTkdnZlpEcnNCQmJS?=
 =?utf-8?B?NklzQkFDalRCa3NLRjJUV202MElkOVRJSXN4OHF1OGFIRHJlZWZUZjJtbk9M?=
 =?utf-8?B?WjNRN05meFNEUkRMNUkrb3c1T1ZuWWNxckpQMUEyUW91Wi8vdlRILzljTXZW?=
 =?utf-8?B?S01PTThQMzZpRlJvWUZHWGcvMlZZZHN3YkI5RjNhNWhmaThlODhKejJ2bndU?=
 =?utf-8?B?bzhTMmhYTnB3c0w2UTZnMWNUSDNhaXJaa1Q2KzJlZkVodSs0SHhsTWU5b1Ry?=
 =?utf-8?B?dGVtWFBLcEVpOTU3SnNoV2RYV1NZUFhnajR1aWtMMFZ3ZHpCWXV2dUJHbWU2?=
 =?utf-8?B?RWQvdUtjNjlRRmg1SUtkQUNvb1UwOTc2aDUwcmZobEp4eGdXQmVpdlc4S1Bo?=
 =?utf-8?B?bkdCSzVZbjlOck9BRktuZUd1b1NHRWE2TFdGZjFuUkR3cTNqZVdqcTBEaURt?=
 =?utf-8?B?a0Uwb054cG92N2tueXZDbTRLbjF2ekxxb3RPRjU3akJXVE5IMmNRRkZZYTVm?=
 =?utf-8?B?TXpRQmNoSDVwL1VXRnhMajhiemNhVnlKWGE3T2lJY1BVV1A1WmNxSGxyQW9G?=
 =?utf-8?B?S0xMaDVzUEJXdXB5cXhhbXpKeStqb0tuRTB1eE56MDVWckZKdU0zcjU4M09E?=
 =?utf-8?B?bnNwZWF5dzNlb1ZEOWhWV2FpWXh6R0pHQkMxZE56QmRUWW04R0IrZlV1V0Zp?=
 =?utf-8?B?Tm5pbS9pTzA5b2VmOWxqVlR1Y3hZL1NYVHZSSlJ4bDNHWUhMU2w0ektYKzkx?=
 =?utf-8?B?NHg4WGoxWVV2aGN1V0IvdVVnd3QzZ1JsZWpFb0x5ZlBHNGdPbWF6UWFFK1cx?=
 =?utf-8?B?R2lZa0RmUlJjWkI0QVNEWmZyaXR0Y3pxVmNyMlpiMG93QmsyNjJXYVVmOHVH?=
 =?utf-8?B?STBNNUQvTmdMT1ZvclhFSTVUMzZYbkpiaGsyTklRUHRUM1QvVUkrSmdZUlgr?=
 =?utf-8?B?RGwrSmppQlR1ZUpNSFhEN3Jiak9GeUhnZXZ6cVRiT2hSam5rbW1tekQxR2c4?=
 =?utf-8?B?MEVTUlpYT3RkTXo4cHZDZnVZVVA1cm9pK3Zsa2hRaERqRkFWMzNrM0lHMzk2?=
 =?utf-8?B?RThqdDRtZjlDVzVrUTBOQVVlK21uT3MyWXlNTHJaMDhrOUFkdCs2ck5Tc2xv?=
 =?utf-8?B?ZTFJb1RkUTkwMWdRZkl1bm03N3Bvc0dkYUlUM1pFRmhJYmNkNFF4RDJZdWlV?=
 =?utf-8?B?dUtBOVZiczVJODRIeHRRaURTbGh4L2h0YUtCVGJOb3FLVldlU1F6RGZXbk9F?=
 =?utf-8?B?ekZuOFlEUUFkZnJFWnlJNGYrVlhSS2dGWGFENjlPdUNKVFZObU5UOXhzc2Fq?=
 =?utf-8?B?cGorZlpRUHhzSFJqeDMxbk9HNGpHQWpoaWVydkw3R3hwVmcvZjQ3MndvaE9h?=
 =?utf-8?B?T3Z1Zmc1ZXpzaTBMdFNkZU5HaDVaMEVMRTdjYmxJQ0wvcHQ2bjJZV3owMUZ3?=
 =?utf-8?B?aFBKcEp5V3FHeDlmckRjQzRJc1NaZ2RPY1FRcEhaK2lxdWxmc3J1VW04RTBY?=
 =?utf-8?B?OXY4NkpyVmNSSk9yMzkzbGtHLzFkVi8yalVGUnpoQlFYR0xlRHZ1Si9pdWtv?=
 =?utf-8?B?TFFrVWJmUi95WmJiWmNmaHVLUFl4YkdLb3k1elNTZEFSZmw1YUhNWFlpa2dp?=
 =?utf-8?B?K29EVUt0b3owNU0zd0tUU2pWdE9hanExWlhtNmFneE9uSFlYSWg4d0JvVEVT?=
 =?utf-8?B?ZkFGTzFEYWEyNi9keUF3UWIxWE5QT21LZkltSkRINGh0cXlDc3J3cm10d0t1?=
 =?utf-8?B?ZnA5RlFPZElmWHhhL2pPbnhneDhGcjJXZDFjQ0tyUVI1M2RrVmJIbVJHeWtQ?=
 =?utf-8?B?Z0E9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a161659-81ba-40fd-999d-08dcff21caf7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 11:46:18.6612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1KOpZ5E6ri3AWC9w9/+Lhfn5x38XZ4Y4IuiI+tUj0Fb9tYahRbJ2i5VMc6+go1Fc3C5XVsI/t8WrLfBNlomhIUjuGpUzqIPHDQ7jWAoyqtg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8762

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add clock definitions for NXP LINFlexD UART bindings
and update the binding examples with S32G2 node.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 .../bindings/serial/fsl,s32-linflexuart.yaml  | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
index 4171f524a928..2716a9cd6c22 100644
--- a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
@@ -34,10 +34,24 @@ properties:
   interrupts:
     maxItems: 1
 
+  clocks:
+    items:
+      - description:
+          ipg clock drives the access to the LINFlexD
+          iomapped registers
+      - description: lin is the frequency of the baud clock
+
+  clock-names:
+    items:
+      - const: ipg
+      - const: lin
+
 required:
   - compatible
   - reg
   - interrupts
+  - clocks
+  - clock-names
 
 unevaluatedProperties: false
 
@@ -47,4 +61,19 @@ examples:
         compatible = "fsl,s32v234-linflexuart";
         reg = <0x40053000 0x1000>;
         interrupts = <0 59 4>;
+        clocks = <&clks 132>, <&clks 131>;
+        clock-names = "ipg", "lin";
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    serial@401c8000 {
+        compatible = "nxp,s32g2-linflexuart",
+                     "fsl,s32v234-linflexuart";
+        reg = <0x401c8000 0x3000>;
+        interrupts = <GIC_SPI 82 IRQ_TYPE_EDGE_RISING>;
+        clocks = <&clks 13>, <&clks 14>;
+        clock-names = "ipg", "lin";
     };
-- 
2.45.2

