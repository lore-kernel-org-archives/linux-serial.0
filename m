Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6F51BDC3;
	Mon, 14 Oct 2024 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917115; cv=fail; b=HH2jwroXfa+DtD2Ot2Z/zTOOmbVupwiWFfn38N+Q1w2CGXbwKu387z4xVj6LtphkI+UYnEJik9mMZh5Py6IRbq/3nN2x8ngCfGB23B8RRoHznvLaLLBk6wvVbm2PcUANKSVgqQaC4IACNkPV6ZPKCS6x8RJhG46Rb9I1andW1NI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917115; c=relaxed/simple;
	bh=9BS8rkL1QTTXNs58BG8bOTv58bYul+z+3qK+ATtGVwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BuZWtTD8qmLdoq/gHehDpLMbodPnLxJHrJr7mtLuCZRBDfFnTzII7REiEpY6o9hEVMLCZKNlqKxduIm9UxdoG70o+91o2gM8NLOX/bzsBuk+UwjibA2Sa+twC43/hG5nw5bBBsXnlLMC1n68aFBCeof+jwSjT8Efii2OiA3jqa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=QwLvc1rm; arc=fail smtp.client-ip=40.107.21.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QwLvc1rm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrhU//Ihp8XxPOjWKTXn950KmWXaSGKOaoGdSBTPZs059cLb7nrQDObYyVKI1f8YSvt9KfOneNAkrLRJjYZpr0SeIykOHD3oVr6hkFYT4GPbyanE1WX99ljgxwhxPzjoUKqPcCVkJSDtIKut/nSv3XIMcyVpFDl/J118BGYCaZbNK2rMRWCj13wTXaGnTBgrZLh60kwzgHO2u0FI+6OhVsfnRRUeylBaqC7TazJRKeHCRwb0eyWkBAews8HGt4cbRTboAMjms8ic+dDat4HxdLXEeOYZiELki8+V0/kn9sWLw/d6E8hUfUCNquwQiRsBN3xyglOlXoR8n+jRRyDQgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yspjoETqEAdBLiFSRO+LbYk8sVc/EX4lsqm7Ql8O2EM=;
 b=G1e0hYxAaHRr6ez289aYNrTDpaeRp0LtoDBEkVP2YFdAKvrUuz3dxT2yo9Gi6wx5CFgLbnrKEW13fy8HvNXbHzOotl4t4wEM4WK3SGUOZWV/oOPjindjQjUclbFBCCH4WmxmVZJh1qkY6yN9ppacI6BSrwdu2XLbDdUaMbiHEvsc+TVnGxMs7CT2rgpnx24OISbX+RQqWlaXmut32kB83+OfDdNaV+H3O9quWqMCZpVm+qsiNyHKI2LMS0N77HC0W1MoV30VfmErUOJWH25ba8QLS0LY/4TuJ1cDxymceON9Sr7PHvgc29jt22621SezGJK4R6hejWryGlL5cUNfhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yspjoETqEAdBLiFSRO+LbYk8sVc/EX4lsqm7Ql8O2EM=;
 b=QwLvc1rmQ0WHcoUkICRrtP3af2lPZlgnn9IHgcWVZBsblatwiC9kpxdj2W8rQGO2oTV8WrkTgz3t0PBEkYidxAg6VnVCGPE/8BqLflwAyEPpM6iCyZet1VkxIyQPbWO0iISLgUTGmPPEgkeXOftmc09AncRDw9zGlCFg5+SWmDB6FGuFnRkzKtNTeAJ4q7pBe2DeJRBPNqd3oJFuze/DTMtPT3hJEytoXi0WFCWSKbvkGfHPQgWSkQbu3sIaqQ7elJK/+NkLgtDdPP+vEIKbBCAqXreV5cffv5UOucc1IsCUQ7t1t5dj/Xisi9FTXAt7Pmjm6sgwxCRnfwYLU/nW1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AS1PR04MB9406.eurprd04.prod.outlook.com (2603:10a6:20b:4da::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 14:45:09 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 14:45:09 +0000
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
Subject: [PATCH v2 2/2] serial: fsl_linflexuart: add clock support
Date: Mon, 14 Oct 2024 17:45:01 +0300
Message-ID: <20241014144501.388050-3-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241014144501.388050-1-ciprianmarian.costea@oss.nxp.com>
References: <20241014144501.388050-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P250CA0015.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::14) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AS1PR04MB9406:EE_
X-MS-Office365-Filtering-Correlation-Id: ef2d5356-05fa-42f6-2948-08dcec5ecd2d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VlNmZVBqaktXdml6Kzk3S3BSYzBQNGV2MTRHWC9OMFlkay9RZFpVdDV4WDlz?=
 =?utf-8?B?d0ZQSmt4SDZCMVhsaE95TW9WVEVUMFlCMEJGK3AwWGl5WFJJeDIxaVBWNFZm?=
 =?utf-8?B?YlN3dWdQRTRXUUdPL3lZbFZOaVliMWpPSHpMd3ZsSzdINmY3SmtDTllITUR1?=
 =?utf-8?B?ZUxsWlgzbzlhK3ZZK3N4dmJzR0g3YUVQc3hqa1pIT3cwWGRXWDYvdlZnRVU3?=
 =?utf-8?B?ZjhHUHJJVTFTR09naWRIdnNuN2VUOHVCeWY3RFI2bi9CanlGSW1HRitneUxX?=
 =?utf-8?B?dzlmOEo2WGhjd0F3SVhxcXdMSlBqUVRWL291bkltYkNNbFZ4ZW5MWWp2VWJQ?=
 =?utf-8?B?eThmdmRYSUkxdFJRa3R5UkU4ZEpMNWg0OHdFcXFUU3lEbXlNbTlzUExhQkhZ?=
 =?utf-8?B?b0tseWF5WlRueTNXamhCMDBrNG5BYjdxYUNiV01VQU40by8zcE8zdUlHSjlF?=
 =?utf-8?B?c1YrdU1leHVRdlNQOVZ2YWRmVmxqV1FPR3QwdzFNb29LYSsvbExXYnhIZnkz?=
 =?utf-8?B?cGtnaFpJb1pTb2c2OWp6ZU03WngvakRYS3V4RHQ1cmhHYXZka2ZWLy9JTlJ4?=
 =?utf-8?B?RTNMTzQzL1BQOThrQTBwdlhyS3E5UlpHSjdmczk4OUM4cENnaWl6dFh6a095?=
 =?utf-8?B?VjBqd1cwSUUrTVFKbHNyRDBCU1BPZDR1TkR2elllUjVWM01Zd2ZwYU1LRlBN?=
 =?utf-8?B?OVd2cHJlelZBaTFZb1g1a0ZKVHF6UldvT1hwbUdyYkQ5Qld5TjRPWWtOanhC?=
 =?utf-8?B?dTJKWVovVnZHWjd4OEVTMUFCdk8wWWMzSnpVTmRGQ0I0RGdaSmtrVkpLZnda?=
 =?utf-8?B?ZjQ2bDEvR1A5YUtrcTU2YXhPWnlDOEllNmpEWkpITTl2SURMbHMrV3plSldV?=
 =?utf-8?B?R3JnckZFdWxOUGkzNzVrTTFRSmI4UkJiZkg0Q24xSTJzTjlnNHZhZGFLMk5m?=
 =?utf-8?B?T3dlRitlRmQ0YlZhMzE2UjNYVGpGQVRGUjJ5TUlaNk5vVUZibHZIVTB5bkl1?=
 =?utf-8?B?ZGZ2eUw1SEF4RkpiNnV6KzdCMlA3dGRZMzYzQ1ltQkpoOEorc29NVzhieUpi?=
 =?utf-8?B?VFlyZWp1RmRyMEtnWXlWRlgrbURCSmpLVElkTTZ3OGJyQldGSlNyMEdDbVlY?=
 =?utf-8?B?dCtEZXcwbWpSMmpValUrSlB3VHpCQjk4K1ZFUG9OTzZ4ek93VFZ4NTBndmpB?=
 =?utf-8?B?SmlUZlAxZDA0TzQrbGZrWkswa0hEZ0p1YXhjdzIySG9NMDVVT2Z0VUxoL29C?=
 =?utf-8?B?WnVmYVVUYVY4dDhCb0c1Y2lVdWtEclRjTGJHK0JLYS83VXF5SGF4TUVkVFJZ?=
 =?utf-8?B?cUFkTERDbHJtd0x4YXM2SStrR2ozQ3RRWWNaczh3RkE4TU5uWmZBb0RqOFVw?=
 =?utf-8?B?anpiOUlsbzFuZGRmbDQ2eUJla0IxYzE2T2tLUEpmK0JuSi96cmt1VWJPUmJK?=
 =?utf-8?B?QzlTQ28wZDVpT3RtNmttK2QyekdDL1BYNElleHlReXpNblFlTDNCb2NJV1Vm?=
 =?utf-8?B?OWtFbGlmZnhBd01tMFI0RmVwVXJKcTZrVmk5WXZrUUVyTDVMMDkvMzdLQUdn?=
 =?utf-8?B?Y0ZZSzZBL0IxZzZBMzdQU0lBb3hkdlhJRUtzVitXNlFUTUxSc3p5UmRPMVJF?=
 =?utf-8?B?ZDlrZGxvbzh6cEczUGduT1U0UWJtbU1pRUVaVkZSdWNIeS85cWozNDhsZFh5?=
 =?utf-8?B?NVdXY2hWcmhHZE50S2F5K0cxWThQYk1UTWxCTElkYlNWQ0VKZm1uVFZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmdoMk9hVzJLNlFGN1JGbU9UZHowbkt1NVgrWUNDNktHcTU1bjkrd2NOWUJM?=
 =?utf-8?B?akNwb1JkYWJhR25IS1EwOWNXZjc3cVdYRU9Yd05YQzVSNDFJTkp6L1ZRVytD?=
 =?utf-8?B?cW9WUXNPUnV2Q0RQYTNUYkE4OTd0S0RjU1BrL0R1ZExFY1FONG5oWWJCYUxH?=
 =?utf-8?B?NTk5UVEzS01Sd2hTa0NtLzhYREs2ZlhmNUU1bWdsMmZQV0lEcXZuYi8zWWZX?=
 =?utf-8?B?OTI0aG8wbUJXK1p3TTlIZ0JtWktDbWtPQ2JzQ3U1TUtWRllrVW9hU0l6ajAz?=
 =?utf-8?B?NnI2KzBkTlNta0x2ZjNVZUcxZGYvWHFDbmMwSS9KOUVlSHN6eW1ldVZRL215?=
 =?utf-8?B?Rm1VNGZDbTZiNzAvV2d0SnN2TTROZGVjK1h6ekhIcjRyU2tMZ1VpNkI4NUp4?=
 =?utf-8?B?ZXc4WVp6TUdTWFBzK3FyTjNDQ1gwWGVhbVJvRFA0WDl4R0tkTDZBbjhBQy9T?=
 =?utf-8?B?MmpnRkQ3L1VXVU5hMWc3cGJYZkszazUzY3lHMWI1eHlHVjFyekoxY1I4RlJu?=
 =?utf-8?B?U0FMQ0picGJvdlovMnBKdmdvWGRqMG41Tk1MVGFZbmFHd25JVlBpVGFqY3VC?=
 =?utf-8?B?ZHVNS1lVWURyUEhNOWN2dXlvWmFjQzZmTm15RkdWSCsxVlVrS0JMVytRSnh4?=
 =?utf-8?B?eVhkUmYzWHMvNjN6V015UVdKNVliOStlZHZ1VEFGR2NvT0VEU2FaeWxoTXh3?=
 =?utf-8?B?bGpYT3Q4L25yVjZGdFJVUEw4bHhLai9SV08rMDlSUld3SG5FR2hFY2NWbUZD?=
 =?utf-8?B?OFdSTVo4NittY0FkYXhYQm9EbVIxbGZHY0hVWjdONmQ5SC8yOXpSeG0ySkdk?=
 =?utf-8?B?Y0RQZ1d4eTZjdC9nQWxFL0U1cEpyTVpCU2NEcGRaeUFBaG9EN0dhL21ML25w?=
 =?utf-8?B?VVJHNFRycTVnWHUxazNCVGYzam8wZjVzaFFUTkxSZE1FK3dKbVp6U3IzNjhm?=
 =?utf-8?B?RzJ1LzZDc3ZYekVyRUJCZ2lnNFN6Mk9SQjluTXl2L1J6KzZmSUV5R24wY2tH?=
 =?utf-8?B?aUsrUitpcHFjT1dtVWZMd3RXaEU5RFFUdytneThsV2FRTGJpRHc2NzJnamZQ?=
 =?utf-8?B?Z0IzcDMrcmVHaVFJT1dQaU1zbVp0QTkydmtZZERZR2pDQUJoZldOMW1KUXhT?=
 =?utf-8?B?TzMwUGZlbm1lV0EyZDNVR25hakNwTCtzdGQ2NlZCVGxIUU8rdjZPbWdiL3ZZ?=
 =?utf-8?B?cU8xd1FvNHk3cEI4Z2tqdlRhTDJNN3pNYWhabmZ3K1JJV09paFU2S0NLcnBP?=
 =?utf-8?B?TFN5UnFtdXk4RWczdUVlYmdxLzc3N0dlTnhhSVlBbzlEWnEzWUliTjB3dFVv?=
 =?utf-8?B?c0MyaFVyRHl2VXVuQnhGUE9iVzR6dS9BQWdaUTZMUllIOTgxaTRwMlpvWm9o?=
 =?utf-8?B?a3JjNEp1djd5NkpzS0UxcjVrM2JBUy9YNHo3aFBtL2Z1ZlNBcCtLOXFrMlA0?=
 =?utf-8?B?WHRGMUVlaUVZSWRZdXZhNEp5cUwxdXhwOVNqU01oWnZMaFJTZGQzcDU1cmlZ?=
 =?utf-8?B?VndQTUJ1TThVc3AvWU5xZXdYZXF5U2JMam9ueWN4WXEvTHpTUWpLQkE2aU91?=
 =?utf-8?B?bU5kcSszbVhqSU94VGRUZk45Y2MwczZjaHk0QVMwN0RTVkpMWGVkWEZzRlow?=
 =?utf-8?B?Z0ZtYnFscC9jK3JaYUloWkRFNVJ0K3J3UlBxZEpuYjZPbFNkNG9MUzQ3VE1y?=
 =?utf-8?B?dEt3a3JKUkRXS3ZVOFdmZXBWanRCOTQrc0xKMmdTdEsxZXRTQmFtUHAweDJU?=
 =?utf-8?B?RThxWU5aNk5jcXAvdFErNXI1VVlsT1ZCaXJKWFlNWGpsMjBCY2FvbkdrZlJr?=
 =?utf-8?B?Qm1ZUEM2RDk2WlBaWmhPaVp4V1pqWFEwSnNYR3hRNkh1UDhlS2NUaytVdGRC?=
 =?utf-8?B?TWI2b0JqaW9qeHdEdlF0aHJnTHZvYkFxeHR4L3JZQVBtTnYwTU1oUzlTNXNp?=
 =?utf-8?B?ejBhTDFRL2Fid0ptYVBNdy9rOTh5NlRTM3NIR25MZXJFMnZySm1LbTJwZDhN?=
 =?utf-8?B?d1J0eDkvelhEZHNhWENObGN2VVZhRXhzamJNUDZ3eG9PaCtqOXVNWW1xSXA3?=
 =?utf-8?B?SmswYnhzM2JPQmxkQTRVRGtRS202RkdpVE9WQjFmQjNXU242OVlId0w2eHds?=
 =?utf-8?B?aS9WckhVMDUya29XVkR4NVBHMWF1WndNVUxNZkZkdUR6bGdFWVRrdmJDTVRh?=
 =?utf-8?B?eWc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2d5356-05fa-42f6-2948-08dcec5ecd2d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 14:45:09.4598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDlvRi0kYlFuLEn98kDP3nkUI8pXl6PpNW5PoajgTWrbn9wOuQVSIxrJ2AjqGYuSLmO4py5BlAmPAM4b3TEUXGAICMnfJowZzesWpNNCuVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9406

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

