Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A3619C549;
	Mon, 11 Nov 2024 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731324578; cv=fail; b=J+QBT5wuCkRDt9CaVjhUBH27AHrPmqKfi7Dyyy4TXFXcDHAGejWjjOQLOtS5uMEqe/4/NwzdPoKxqCor4MhicKs+dNDYu2nNVRrydZNWqdkbUxNRC+SXd1hciQd3Ah7v/tlvAaqd+L+geOtTUFW5g+aYeA81scc/+43+DdC/utc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731324578; c=relaxed/simple;
	bh=x+SQ4LkHPihEEdpRbCpmHgA0UzGSE+LNZZr9L6b890s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jhzesQQdiYBcVfOiWJ4uhB7tkBq4IOMmCTcyNKgyNo+SSKUgExkGFJM490FY5UT5VRRD4VXIok0JiSfXjbp07gPYVB8NxcVQ5bfUqMUnqwMvBxdu5ydCwiLH4hZIvUiiQ+9iwy2jW8joK6RjhdM/r6Y0oGl3dtRyqllfSdMifyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JnHhrxFQ; arc=fail smtp.client-ip=40.107.20.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JnHhrxFQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unta92UfXOk3/U1c54CVI7zlgPzX+eO6FTX57+BlJtRoIZyMv2fecpwm3Z8eVcVJHCCVaZ46KgkDoQ455aUYDSgL1SIfFctHHNvzNTqmiFQXkPAdTol/BaX/lRQYtg0gxqT2f+gtOlCkLj9yhmKOPrhZT10eD8S3AFWUBWFVZOmI9fgLWnks5bQYXXA9boMGZ1gMHuCUUwRmR3Z1Br+F+IW0gNlxESnMFnn3bMK7r/R6WeOyRjyLG5GsRQMH8R86TdyuLNKCl0soFHnbFGdTHqB7ifec5xQGj5tobePBatZrgQ9fyYMDrlNC7ngvyJ+i1LRQ9+KIzJvsH5LtVY+6Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fG+Hj1fahqHiHaIj7XnHjzSDHuLftIqClYYXKEdUchw=;
 b=IWeRTDlZ6ai0fHQKzX7ylvJ15xNd9jCXEk7dKjQiCMr7X456IoTOD5Vhk1XmtaY/mecnZKERxC7EE2HNJtm2F3CzhflDMqd8lxawTN6SPD5Ind+iLNG7+PgdPC5DC7MsJQPvf5P7CtjFj8N1VjSAj6f8IQthKSGeuCXlhAPnx84P5SAhrMivFwHGHbeRFcyHDelGhWD5p7q35K6jNjbNnomUxt+NY46eoxjCmZA83Ap1UTeX8wSv3hxFgVvCuYov77ePh2wkIxnezVRB0icGNo7hqsBqhbY1H90Hkpe0cl78YX9aZmZUoK7LZ4PSzB6F89VLBx5fKxZY9Hu4Sw8G2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fG+Hj1fahqHiHaIj7XnHjzSDHuLftIqClYYXKEdUchw=;
 b=JnHhrxFQIE21h3NJj2fAU9hrTeIAMoar2Spt3tUL1OiZqHT5fl9BnZr69q/I/uzEKYVySVtFmmSDM/nWBrVq4V7iJp958nQK6y3l5B4noNrTyqhMPEE2KMPMXFgPXcSvpfgCn7zuJZyHmakDgFfCddxA3ZkDogLiaGiP60cF6u5QvKkoNlS62FGX5ZkOtlYTucMKdi1Qp0wM3hEuRwaur4Ygu4qgvEj3KJeOd70K8Rs6th7LtViR+rXEYdqM/qPSV+WsjXs6Zs8sxAUNWyH7CG8Fk20xDPL2bgsUKzj5QFOFf+dxIPm7iUvKGpKisEbn7PtkQFeJVUtK07lliQAeaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by DB9PR04MB9428.eurprd04.prod.outlook.com (2603:10a6:10:368::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Mon, 11 Nov
 2024 11:29:30 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8137.018; Mon, 11 Nov 2024
 11:29:30 +0000
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
	imx@lists.linux.dev,
	NXP S32 Linux <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v4 2/2] serial: fsl_linflexuart: add clock management
Date: Mon, 11 Nov 2024 13:29:21 +0200
Message-ID: <20241111112921.2411242-3-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241111112921.2411242-1-ciprianmarian.costea@oss.nxp.com>
References: <20241111112921.2411242-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0012.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::12) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|DB9PR04MB9428:EE_
X-MS-Office365-Filtering-Correlation-Id: aea894f7-ec02-472b-d4e0-08dd02441bea
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0w1TG91MDlrRCt6M1FPSzYvek1aUUt0ajQ4dnJsSXRrZjZtTzU0VWhZNUIr?=
 =?utf-8?B?Q3RTM3k0bjBFU2hEcTcxNmZXMzlNNUQrbVpzMk1qU0hYT3lzUk0zZW92dEhE?=
 =?utf-8?B?R1kxdXFCK05LWUxST3V1Q3V6elU4d1Q2SDVyb2pxZ0VWd1h2SXpBWm0yd21D?=
 =?utf-8?B?ZWs0eGNORkpEZzNnRDJ4S1dCMWE1aWNqSzdsRmtBeTVqTEZPTS9tWGc5Wjda?=
 =?utf-8?B?c0NmRTJNNFlibk90TU1kWGQ2TzlKdm5CZmFFYU1NbEhlQmthVjE1OVlxTEpV?=
 =?utf-8?B?OXZaczVSQXYvbDdDQnB6cG9sWStRRmdlQ2VSTkFLdWFVd0t0NThMRHlCT3Q3?=
 =?utf-8?B?TXpoVkFqZWxKbFhweEk0U3ppTk45c1Zza283andYVEIwbWs2eGViQnluRllW?=
 =?utf-8?B?MkltWWYzVFB4bjU0UHJzUzVzN3k4cWRCTDdBakFnZGwrNVE4Z2QySWV2RXRO?=
 =?utf-8?B?UEhOSlo0ODJXZnZ6bytQSDlWUVFZZVFoQWdrZ3JDak1aQkpRQjhZWGQzSzJh?=
 =?utf-8?B?bUJ2YzlKeTBxYnFEZ3FVd3J0aVpHdUUrK1ZjYmRmSTZyVDBJcUVwZmhFeWt4?=
 =?utf-8?B?bDhvRzQrdGI1Rkh2T09zT3dRblYzeG9zU1Bqcy8vWitEUWVEc1JCdWVscXB0?=
 =?utf-8?B?WEFneDdoZ3NGTU9pa2k5UlpuS2tEMnFlVXVTd1hpY0xXeEV5NnBJeUJieUtG?=
 =?utf-8?B?bXNKRFFVQlZDTzJodkxJU2p2aUpFNWpQT0FwOG9wUU0rLzFGYlJTMkxRQmZG?=
 =?utf-8?B?MVM1T3BQSUtaaWhjWVBIL3Jwa3RzbDd1dXNvRnh5YVRYVnlXS0U3Qm82MGVm?=
 =?utf-8?B?QVEyRUorQjZ0cVVRMWQxa3dLci9LZHNjNkpTMXpWY1NQRU1wVVN3R1hPclI1?=
 =?utf-8?B?YktSUkRwazRnUWxqbXR3ZmJvOTFYYWM5ZnM4ZzFtWFdpaUtGTm00SW8xWW9G?=
 =?utf-8?B?RmhIV0wyQnVPMFUvcHNkNzFCSXB4ZmtlcjF3YTJ3b3A3M0RSRmZKRmkzaW90?=
 =?utf-8?B?OS96RTd1NmpFYktpMGpzK045cHlyZXdWWU90aXNWYnZ5aGEweUUyMWNVaDV5?=
 =?utf-8?B?VHJla3NDTjRCS0VUbU5PNlBDNU16bE51RzF2NUxHRjVrVUk0ZUlEendlcThw?=
 =?utf-8?B?U1lxUlZ5YWNMSEwvUjQxMXV2MUdjU1JQNUVHMy91ck44Y1ZXNW9qS2c4Z0tn?=
 =?utf-8?B?dkkzbXkyM1BUMlJhR3dOOU1YN3ZLbGRxbnFESXgzbjdFL1JFT3g5K2tkN1V5?=
 =?utf-8?B?SVFRK0F3akJ3d3dNblA5dXRPbjRXcTF3VThYMFpZL1E3LytrNDVyN200RzJa?=
 =?utf-8?B?NkM4SDN6NlhzN0M3ZUtUVHFhMlpTWFJXbTA1R2hCTFc2RzFTNmhtcmx2Y2Fv?=
 =?utf-8?B?WiswNmpITE1YTTFjTTVMekVjcUlDQlZqOE9LY1dJR200ejdBVmNkYitxRTBD?=
 =?utf-8?B?dHBwQi94QmNqdXpLSkFuK1ZlNjRKSWFGcTArdVNzb0kwVzFZbUNUUVFOTzU3?=
 =?utf-8?B?amhsL3ZJT01DdzZEdlZqSGR0U2hRaGpCTDk5eGdxKzl0YWxyRlVhZUl0TDJJ?=
 =?utf-8?B?eHV1QUd1OGVScTdkeHo2K2NuMnIrREdjKzdLTHlub3RRdGlpYlMrMGpoNW1K?=
 =?utf-8?B?YU9jUFQrOVZrMzNWdkd0TjI2b0swTGg4Ni9BNm9jSzN0aTlXd0dZYzV0Q2hN?=
 =?utf-8?B?b2x6SDlMRE4zOXRxamhpaTE4QnNFTG1RZ2N2WFBGOVE4dkRRSk9jcHNkR3NG?=
 =?utf-8?Q?UVUhOzOi90iin7hDmsgzCdIrVeutMVmiYJDXlox?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnhPQThQbXRmT0ZSS3hSeXV6VWdqRnFGaUVjamxFSmFZUWJrQ2xPQmJHUElr?=
 =?utf-8?B?SGZDQ0VvQThTN25QbG1GS2N2ZHhORVhFR0ZEYSt0MWU1UGFwUUdIYmN3Tk9O?=
 =?utf-8?B?RHhmZmlLaFF5TnNDWmREU0FVejNieEVsWVVhNnRqMWNtUmxsNzU2aHppZjdx?=
 =?utf-8?B?c1A1R1lYb21RV0tHU3pnU1N2a25SdXFZa0VvaTFFTWVNejA4VE9nV3NBeFFF?=
 =?utf-8?B?djVoTHFaanM3RnZmRTFRbzVIMzdMeFVxNFVMamdZUkZ2UExkSnBJamFPYkhT?=
 =?utf-8?B?VVhQT1BJQUEvWFl4bUV2d1o2QkVnNlNMV1ZBZW5KZUtZYklCS2NybGovTExX?=
 =?utf-8?B?Vk4zZ1Y1MnBVc3F4L0lrRi8xeXRRWmRNenF4YS9UbkxzWTJlbWx2bW5pbDN1?=
 =?utf-8?B?UjVvQ0lveDVVYmRuMXcvNHNLRjM1SENxSjduTHNoSlQ3LzNRSlVvRHUrdDk3?=
 =?utf-8?B?bURQL2JNSVpxVFlIWGVYUi84NGdvTk1JUTRUOUpyRnVveXBQL1hTZytYbWJZ?=
 =?utf-8?B?YUJhdHp6dzQzM2NoMUcrKzBXSE5ETFZESktqNjVSSk1WTStmNEgxdjBMN0FB?=
 =?utf-8?B?bTUydS9BcXlKdmttOS9QZ3h2OXY0cjcvSHpuQ01ZK1FKSDRIanU4NVJTMUdD?=
 =?utf-8?B?VmtsT0xNcWVaMmFzaTlUalV0V096R2hOSWVJa2tNS3ZzRDkrb1R2YmF0TFVh?=
 =?utf-8?B?Vk9LVUN1cFRobFlqZW5zQXkwY213NzdYM0VlUUpIL0tYbzdObjNSR2FUSDJP?=
 =?utf-8?B?MGczakVGRUVnTkxRbVRPRmxQWnJKY3l6ZS9kMkN0UjVnQ2Q4UnN0ZFlFc0RF?=
 =?utf-8?B?eWpqV0dCZzM1OFZXQTNlMXdwbDgvMy9QRXB3MHNFT0YxZWVmMFFoaDNkWWNN?=
 =?utf-8?B?eVp2ZFQvMU5jOXVTTVVaUlFoNTNmNC8vK0Vqbk1BQXVRRXI1dnJaNlQwd1p1?=
 =?utf-8?B?ZlEySVJ3TUs2cjQ2M2RjeThmSFB3ZWpQcnZXd0IzSkc5USt2Z3IxbEZIUzk2?=
 =?utf-8?B?SHpBTjNITWhqVUpmNU5FcWNiVmh6RzZqMGZpNTBQdlNyRkg4UjRtM2kraVhx?=
 =?utf-8?B?V21Jam9DZ0FkMjJ1dlJKeHk3RmhBUHpHVVNLUFJRUkY4TDJLOVgxeVRac3Rw?=
 =?utf-8?B?RmZSd25QNk9NWENRaEJmWVJBRG5UYmZmR01tMlZSK1YrZGEvWXVRZUlJWndh?=
 =?utf-8?B?bWh2cVF6aUQ4ZDNOejRUOXFPK2NiMm1xTVVVSGViUTRVLzZydHRoMHFFUFAy?=
 =?utf-8?B?SzRpNDZPSFlDM0cwNE5hbmNqQWo4NkhwZUpqZ3RzamVsZ1A0MFU1RTNnbktk?=
 =?utf-8?B?eVExc0crYnU3NXVlTFBidFFLQ2g1ZnJzMTFjM1h1R00yWW1rcjZHNHp0WHFo?=
 =?utf-8?B?N3VhZTdMbnoxSEYyTkVmSHIvbzBHL2JMTnFZLzNUWS9RTnhkbERucDdMODhn?=
 =?utf-8?B?Tkl1ems0UU5OdkZlaWk2RDR2aFJIK2FHK0gzS29WaXFrNFE2K09IMU5Ea0E5?=
 =?utf-8?B?aXpuOHRsMnRveSs0MXpSTHRNa0YyZDF0bkF0QmpQS29mU1g5L3lNMDZoZjBl?=
 =?utf-8?B?VmtGQTc4MmVJQlJyQzVFOHpmb3YwSGYydFlNblpHbUJ2cVlJZC9EaDdwN0FW?=
 =?utf-8?B?NzJaOUxTNjVsdGxVaHJRcHZpUDZHaVkwMGpXTElDSXlBUmpxdkJHUE5taVhF?=
 =?utf-8?B?NHR3RDI3bTdvUVkxRGJSeGM5S04yTjVDYldtOGd2MEYreVFNLzV2b0ZuU2pM?=
 =?utf-8?B?Y0ZPdU5pcFlNZCtndUdJbU42d2oxc1hMYW9oR0lya0xjY2JTOHdOajlzVmp2?=
 =?utf-8?B?MVUzTzQyU0FZODcwRkpFclJ4VnljdCtLdkpyZ1l0QTNQZjhBRkZxeUdKQ2E2?=
 =?utf-8?B?Q0ZVTmprenBtb2lWQktFcE9GcmdNNXA4TnR5dENWVkdaK01USWJYVzhHSHpx?=
 =?utf-8?B?ejNiZXMyRmMxemdtSERBNzg2L1ZPRUdibU5ZSE1aZG4zMWxIL1JHNUs2UWxh?=
 =?utf-8?B?aHRFUnlFNTgwdjlxL3hyUWtGM1l2b294b3RHT3dHclFaK01RYWkyb0xkZys2?=
 =?utf-8?B?Z2Z1WDdPeUdTS3F3T3ZzYzZuOFRiU3M4L2NTQVhsYkFzd2tiYmpBQTZlYlpU?=
 =?utf-8?B?ZVhIaUQ5b1I1NVc5MklJRjBYamx0QTFNak51YnQweWFpT1R3MVZiSENpZGFB?=
 =?utf-8?B?RGc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aea894f7-ec02-472b-d4e0-08dd02441bea
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 11:29:30.7392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THEt37wruZ42uNy2d1igJcI4r8+5dtZls2J6gDGj+xGoKuRz7I8/mv93VK0ESKTAygvqqRr81be2PLgRQX6YfMZzpAbilLa69/qjWQclyKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9428

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add optional clock 'ipg' and 'lin' support to NXP LINFlexD UART driver,
which is used by S32G2 and S32G3 SoCs.

LINFlex driver should perform clock management and not rely on a previous
bootloader configuration.

Clocking support is added as optional in order to not break existing
support for S32V234 SoC. Therefore, there should be no impact if not
providing LINFlexD clocks and continue to rely on a bootloader clock
configuration and enablement.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/tty/serial/fsl_linflexuart.c | 82 +++++++++++++++++++++++-----
 1 file changed, 68 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_linflexuart.c
index e972df4b188d..66b822f36d06 100644
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
@@ -120,9 +121,29 @@
 
 #define PREINIT_DELAY			2000 /* us */
 
+struct linflex_devtype_data {
+	const char * const *clks_names;
+	int n_clks;
+};
+
+struct linflex_port {
+	struct uart_port port;
+	struct clk_bulk_data *clks;
+	const struct linflex_devtype_data *devtype_data;
+};
+
+static const char * const s32v234_clk_names[] = {
+	"ipg", "lin",
+};
+
+static const struct linflex_devtype_data s32v234_data = {
+	.clks_names = s32v234_clk_names,
+	.n_clks = ARRAY_SIZE(s32v234_clk_names),
+};
+
 static const struct of_device_id linflex_dt_ids[] = {
 	{
-		.compatible = "fsl,s32v234-linflexuart",
+		.compatible = "fsl,s32v234-linflexuart", .data = &s32v234_data,
 	},
 	{ /* sentinel */ }
 };
@@ -807,12 +828,13 @@ static struct uart_driver linflex_reg = {
 static int linflex_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	struct linflex_port *lfport;
 	struct uart_port *sport;
 	struct resource *res;
-	int ret;
+	int i, ret;
 
-	sport = devm_kzalloc(&pdev->dev, sizeof(*sport), GFP_KERNEL);
-	if (!sport)
+	lfport = devm_kzalloc(&pdev->dev, sizeof(*lfport), GFP_KERNEL);
+	if (!lfport)
 		return -ENOMEM;
 
 	ret = of_alias_get_id(np, "serial");
@@ -826,8 +848,14 @@ static int linflex_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	sport = &lfport->port;
 	sport->line = ret;
 
+	lfport->devtype_data = of_device_get_match_data(&pdev->dev);
+	if (!lfport->devtype_data)
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				"Failed to get linflexuart driver data\n");
+
 	sport->membase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(sport->membase))
 		return PTR_ERR(sport->membase);
@@ -844,37 +872,63 @@ static int linflex_probe(struct platform_device *pdev)
 	sport->flags = UPF_BOOT_AUTOCONF;
 	sport->has_sysrq = IS_ENABLED(CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE);
 
-	linflex_ports[sport->line] = sport;
+	lfport->clks = devm_kmalloc_array(&pdev->dev, lfport->devtype_data->n_clks,
+				    sizeof(*lfport->clks), GFP_KERNEL);
+	if (!lfport->clks)
+		return -ENOMEM;
+
+	for (i = 0; i < lfport->devtype_data->n_clks; i++)
+		lfport->clks[i].id = lfport->devtype_data->clks_names[i];
+
+	ret = devm_clk_bulk_get_optional(&pdev->dev,
+					 lfport->devtype_data->n_clks, lfport->clks);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				"Failed to get linflexuart clocks\n");
+
+	ret = clk_bulk_prepare_enable(lfport->devtype_data->n_clks,
+				      lfport->clks);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				"Failed to enable linflexuart clocks\n");
 
-	platform_set_drvdata(pdev, sport);
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
 
 #ifdef CONFIG_PM_SLEEP
 static int linflex_suspend(struct device *dev)
 {
-	struct uart_port *sport = dev_get_drvdata(dev);
+	struct linflex_port *lfport = dev_get_drvdata(dev);
+
+	uart_suspend_port(&linflex_reg, &lfport->port);
 
-	uart_suspend_port(&linflex_reg, sport);
+	clk_bulk_disable_unprepare(lfport->devtype_data->n_clks,
+				   lfport->clks);
 
 	return 0;
 }
 
 static int linflex_resume(struct device *dev)
 {
-	struct uart_port *sport = dev_get_drvdata(dev);
+	struct linflex_port *lfport = dev_get_drvdata(dev);
+	int ret;
 
-	uart_resume_port(&linflex_reg, sport);
+	ret = clk_bulk_prepare_enable(lfport->devtype_data->n_clks,
+				      lfport->clks);
+	if (ret)
+		return ret;
 
-	return 0;
+	return uart_resume_port(&linflex_reg, &lfport->port);
 }
 #endif
 
-- 
2.45.2

