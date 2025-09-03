Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021138.outbound.protection.outlook.com [52.101.65.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2419032F76E;
	Wed,  3 Sep 2025 09:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756891422; cv=fail; b=NajwP1uWcE2J0dhUHHoJZYTNCmnv3Kd5eQABdofIeF1h+zMAm//9nsLk+Hd7hkolfseOgX0SUpgU9Fcw8w3fYJ2NQD4jXl+cCvQbpUC0d+xKN3OpmB/nKT2kmEDwHn026RNRpmXfM9mgfOchzB84SAID8wPYO9dkkg8u9CwIXFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756891422; c=relaxed/simple;
	bh=TZPkz0xXD5quDdkUWkyuvM2LdUuMHFqveFMmda/ddQI=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=DKHWG4C9PaA8H644Rh5pT50h6jKRuSyeQI7mGUZ4WavymF/XiSYxJopio+iDOzdKSoh2P2f5wEgo2UuXkeC6/mhbFXyF9mF9/eXFQGtUk7SZ9STem7ke4UBRgQ8GgcUE6n3S9TRRGPplDky1DZy/byzhd1busZQXVbgLsygCFiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=HYJnvaWF; arc=fail smtp.client-ip=52.101.65.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="HYJnvaWF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MAv04yEWnFj+vjX7jKB7kGzvVVRf9TcCm3TpHnl6887NMcS/YUKwDCBTTdmLjDrOWgvTOIE1ncNcFwuGkcWctTXeMjO12XLiXn43d2p0QhM8EquUh6zgiC2uu5TJjPFUiO+5Q6AU/k9y7s1HL5T2SbjIKppmXKwripp+U8k1Qk6/mWQPzokRP7I9UXaO+eIXAS82PZvN0lY7QPY9s+sJPwBGhPwbcsNEtFTWdPbH64SjYAXIjipwvsH3FOmgw2/u8jds/Rpr0ccgS8QXxRNDq6od7fjJKDD8Vp1dsVzT1yDe+vVgJHLbEUemlSROsNFby6Jd0zup1i4JsYCe68PDwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPmR1591nrOVD9vCLJHMwl03b13R6dSR96UdQCF6NLU=;
 b=mqXC+kN/90y7aq4H7YUxxNeFXBbvg/ortnic0XnvNz9MW0KErq+Zs9nGOUaZXjz5qyMb4OeQh+20o7fLGLUhWMyvf3X5DM5Jcglbfcv4s2tGWv4Aivc+A72DY17PqTohIun0RNtzR6/nxnnjs49o7h0cFeUlCJfLx5mD9iEcofddlDuCEXoQ8QicLuCq+p9JuSE4UxfOPmF3fhKeXPs+fZ89qaCLX+39aHah4GKFAOy+MlomBr3opGv0imxXjwbzaFgfXTYB+DiHw7id9E3ay7U/+ubKUUyQKBfxRWZqgPLfrmStUqRpfSDvA7SQMP9+k8P/f7LIDsJqgyizMxn6vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPmR1591nrOVD9vCLJHMwl03b13R6dSR96UdQCF6NLU=;
 b=HYJnvaWFca1LlkmMngqJ9vQYBI3/nGCiAcsN4mb7olIlNJLIGeZU8U7DGh4NuzUEhcIaRg1vlueaWG9lvw89g3gV9XiIW3jt1k7vLi+dOUQf6tnTrtXmGv+0r4OeJ70DcA5z1HduK+D/dsGIfG/lDGMHiGJMmzhBsp5OupeMYJ59xLiX4ObYORnzUs9H8tEQP+psz5SGiDXBGXIXxkM/L9fWGhqgxNUOtOo+lD4NmUr6bTLeoNvQ/Pr9vASJ7phGIz3vYMplCZeBBk8vR1CFU+72Z2aqHZqq6nS79wGkxh+qzacGNpV5vi0zlC7yuZW4zgEUzeQjoGi3RQJGWKJvUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com (2603:10a6:20b:676::22)
 by DB8PR06MB6377.eurprd06.prod.outlook.com (2603:10a6:10:12c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 09:23:35 +0000
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::f8cf:8122:6cad:4cf7]) by AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::f8cf:8122:6cad:4cf7%5]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 09:23:35 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Wed, 03 Sep 2025 09:23:04 +0000
Subject: [PATCH] serial: max310x: improve interrupt handling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-master-max310x-improve-interrupt-handling-v1-1-bfb44829e760@vaisala.com>
X-B4-Tracking: v=1; b=H4sIAPcIuGgC/x2N3QqDMAyFX0VyvUBbGcO9ythFtJkLaC2pSkF8d
 4NXh+9wfg4orMIF3s0ByrsUWZKBfzQw/CmNjBKNIbjwdJ1rcaaysprU1ruKMmdddkslc3XLK1o
 rTpJGJAqhf/XkBx/B9rLyT+r99fme5wU7vZZqewAAAA==
X-Change-ID: 20250903-master-max310x-improve-interrupt-handling-aa22b7ba1c1d
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Alexander Shiyan <shc_work@mail.ru>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756891414; l=1862;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=TZPkz0xXD5quDdkUWkyuvM2LdUuMHFqveFMmda/ddQI=;
 b=6HqSWMW/r6HevY+BiyXMtRjHFroH3owiPcIAojGFdAv/KBSJi/sbuCZdBriO+IjHJS/1C3jxN
 WBwnjRu9Sz/BLdWgJdK053/n+QBc/k3D3nZz1NOOEQ93HTdzDO13nab
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GVZP280CA0098.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:275::8) To AS5PR06MB9040.eurprd06.prod.outlook.com
 (2603:10a6:20b:676::22)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR06MB9040:EE_|DB8PR06MB6377:EE_
X-MS-Office365-Filtering-Correlation-Id: 37ca5e7e-9a67-4555-6505-08ddeacb8e95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHRWeVF6c0pFM21WY2tsNTBHRTRjOFBJejJBYmZJbXVMWW5HMTdyR0J5WFJx?=
 =?utf-8?B?SFBORU9LQkRrSmJCRXRCTkQ2MkE3MC9oNnhuK08wV1RNd1BSRktrSlZXQnV4?=
 =?utf-8?B?c3FsZk1DcmFPQlErdnBSYmttYzlVQVJmcGtseW4zWnpsLzlpV1dJVDYyS29O?=
 =?utf-8?B?RnRTRHpUTTEwZnNCNCt3V2ZuYlRzM3hCT3JqOWpwbUI5YWd5MVVUTkRlUmpt?=
 =?utf-8?B?T1haaHdEQzlqbWxoaGtwUXRIcWRtMzYzRW5WRENubDFuRTJ3c0VxT0U1TDYx?=
 =?utf-8?B?cHVYQTNkZENPdmRYRURTeFRtS3hJT2IxM0U5ZnJjenFYV1VSQlM1cklnZnpr?=
 =?utf-8?B?b2tYV2hNRis3QzBaWWRtOWJPdTAzT2ltc2NVTXdXRkQzdldiQ2tVeTVsVzV0?=
 =?utf-8?B?N2dHTlpDNE9iNFlQUTZrRnQ1VlVsMWFqT0VNRFgxM3NJSVkwY2hySDFITm5V?=
 =?utf-8?B?dDI3WHdvci82SS9aMVJFdDUxc2FOUE9lZTRjUXRRREJCbFFadlV6dEVrMDA3?=
 =?utf-8?B?RzNwb3E2TkFjK2xlWkVQcFo0aHNqMW1pdTgyMGR1UUJwYjh1Ykg4cHllbW0r?=
 =?utf-8?B?Qkkrc1hoL1lBQXZVRStMaDNIeUlJMU1NRFV5V3M2WHJRaHNyMUExQVBXVVgz?=
 =?utf-8?B?YnBQZHlSSGd1R2pMNDE3SDFFeEpBNjFZRUR6dEFqcWwwVmJJTXp4bFFDOGRD?=
 =?utf-8?B?ZzE1SXRSUDFhakhLbldITUhtL0ZSVTRiL3o3d1NNNGJ0TVBjbVJwVlczZzFE?=
 =?utf-8?B?dDNlOG4vZjdvOWdoZ1BpZ1ZhcWh4YXl3cHo0ZTZXNW1DaEhaaGx0alBZV21z?=
 =?utf-8?B?cW5ZWFdyMkQrQ2ZiNHNTQWk5dkV4ZERDWW9Db0lLZjRHWlA1WTNhaWtrNlJE?=
 =?utf-8?B?SEUvZUltTitBY1p5L0RxT3lBTSt1TEF3bFIvWFBNZS9TOVRGR1lwREh3dmov?=
 =?utf-8?B?dWN5M212WllSOFJPTFRVL0pXcnNNWEx6a1Z5NTV1NmZPQmNuMWJsSTVRb0tk?=
 =?utf-8?B?M3Y5RnVubkZ5eTduWHJxS1FXdksraVhNeE93QkxjRmE0K1llVUhCeVk0TlVn?=
 =?utf-8?B?TW5SUVp4YURKT0xCNW8zL25ZT1RDWkhoQmw0b283K0sxZnROS2tFK3FvZU41?=
 =?utf-8?B?RGd4M3F2WFBzUHhhY3BZMllpTno5QTRSbDJSWGVydmhJS2xhaXFJeHRqVTgw?=
 =?utf-8?B?OTBhMTlvR0JXWk1OMis0WnM4K0lwNFFJUDgwQWJCNndWTVNURjJDYnZTWEhx?=
 =?utf-8?B?MFRYeHQ1dzlUWi8zZmVJNlRBMG9Tb0VOTEFJZUhYeXNCbSsvcERWS1dCbVlX?=
 =?utf-8?B?VERVaGV1dUpFcXJMVmphRlhKckc4OWExYU5HMCtqaVlyV2tsQjh5cUFFVks0?=
 =?utf-8?B?NmJtaUZUVDBvVDJaRU1aRkk5bHcyT01iYkNMRDI1RWQwUSs4dm9mU3UwWTYv?=
 =?utf-8?B?Y3BxU01oMElLaUVWVTRkeEhJMzNlTSs1Y3dCZmNEY0tKeHVKMlNKMFAxS1Z1?=
 =?utf-8?B?dFZtendKSXB2dVdwZ2lqOEZmdnBBYld5NnVTNzgyaGhpV3FXMzF0MVhYOFFm?=
 =?utf-8?B?SFN4ZXAzeXk4cEpMY3FlYkJ4RGNCNzA3Q295UHpYU3Mrc0ZiUjNyK2FOZkNk?=
 =?utf-8?B?K0wzdWlqWVBZVkZ2KzFQSmhPQ1dYdzg4M3B1Y0ppRll3YzNnQ1RjV1l4RHVx?=
 =?utf-8?B?aVNFL0xCZ1ZWM1B1aVVNQnF3NmNIaWxCcStiUlphOERWaFpBWHd1L2pOVU9h?=
 =?utf-8?B?Szdvc25BZmxXK05Kei8wMitFRC9aTS82bFdzdHBOcGgzTXAwYjF1OUc3N1pF?=
 =?utf-8?B?MHlTbExkZ1lCYVJmSkQvUVlnYTBmNUFHeFZJSU1RVkYrNWYzR0dnYzRETXhy?=
 =?utf-8?B?UFBZZXQyVFhUUHFkWndoVGZxdjhGckVwOTNEYm5DdC9PdTdFenpOKzF6dDZM?=
 =?utf-8?B?SDNPT3l4MUVmeDlqcmxsbEZ6dE9OZllQUHJNTFJRSElteTFDTmZpWGVkZ1pO?=
 =?utf-8?B?TDNSK3dtSXl3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB9040.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekwzRGxPYlJRdVhFMHR2MjlZTnB0TG1TVUsybjFmeS9SeWZzUUNSTXBuQllN?=
 =?utf-8?B?UXhZOUd3RytaYWVsODRObDdhZjRVYzNIOHhERllwYTg2OW14VGI1aFMwc3Nu?=
 =?utf-8?B?YisvOS80WU1KQzYrbVJKL0RDdkE5UlRxWi93ODVUaVRoT1ltN2Y5VjZ0RS9t?=
 =?utf-8?B?aHJxVkc4WnpCTitXTGZOK1l1N1pab2g3aEw0ZEVFbjh3aHR1UWQyczRDL0Rn?=
 =?utf-8?B?QTdxRThDcUJnb2VrYnhTbU9xaDNxUFBQWmhkVW12T085TmJKdXM3VDZPZTNw?=
 =?utf-8?B?aW1iWTdCVy9nUWRVeFI0Tk5uK0lRQUVDQWk3b0orQ3pNS3ZQOGVkbFY3U0g1?=
 =?utf-8?B?WGRzMHdQbjF4Qk5oMktlMExuYm1aUmk0MEVidzVJL25HdUVFcmZYbHR1QnU0?=
 =?utf-8?B?OS9ra05HNDVKdFkyeFovL1pvSmF4WGxQbUw2djZnbnJDaVF2WkNTcGdzRWRz?=
 =?utf-8?B?ZHJkZjBnQzk0SWdjNktYeUVqaWd4VUhvT2ZLbnZBemY2WHprcEFmSTFVTGpY?=
 =?utf-8?B?dFNGWkcrM2hRV3h1eUhkZDhJRDVZTHNmTGUvL1JCYWwyZHNMazRmcFpCRFlR?=
 =?utf-8?B?V0tURDE3d2h3bDFpZGRSR2xKQVkxZXBDcWZMenQxQWdYNFY0VVEvVGtmR0Rs?=
 =?utf-8?B?WE55d1QxOFcxNlhQb0hWR2Z0YTdGQm9qcXV5VHNJcUF5THBXZDBHaXpxWFlx?=
 =?utf-8?B?VU5ZdE1WOTN1Q2Z0L2VUaVVsaUI0L2pSallyV01OUUtTMTRRT3NIeVF2a0RC?=
 =?utf-8?B?Q2hLTG5hTFhndHNyYmFydWdRV2xOYmp3MURreEI1RkVWRlFvNnR0Mkl1TE1F?=
 =?utf-8?B?NDBIS3h3a0dvdzRYR3NsZ1NXQlh5TEZac1BOUW5CUk9oMnJJV2ZjaXA2VE9H?=
 =?utf-8?B?YlFFMnF0ZUY2dDkvWkdLdy9Pa1Z3TkJBbnlTUTY2a2k5RDd2Z2tpU1NnVHNT?=
 =?utf-8?B?MjNudmRDN2lwUkhidmlzRnRZN3RLNGt5MU93cWVrMldBemVuTElDL013VkZE?=
 =?utf-8?B?TVpOb20xTUo3ZnNxaFN6MmtKNENyTE5TQXJoNWVaeVdMQktMYm1lZnNzb1ow?=
 =?utf-8?B?N2RZdENjL2lSRUE5U2xVTmtseG1lckRHWlpTZ2ZhOU9SUUVLM1BJUm8xTi9x?=
 =?utf-8?B?dUtaWlRYU2R4MWhoZEk5SjlZTjZjcmdwbVhhcmY4b2g4OFYvQ3Y2dVNQeFd0?=
 =?utf-8?B?TnA0bVIrLzBRbWVBbWYxTndjeTFvWlZFTUE3bzc2cjZYNnR4bXV6YUJGWDds?=
 =?utf-8?B?VzdpRmxTS1plY0hZVGoveU9oa2Q3YVIrcDBTYmRLWEFPdWdPTFc1TGlhNGlT?=
 =?utf-8?B?b3UxS3k4VEg1eFQyQURwLzZkOXpuQ3p4QTZCS05ZRUJmNE5KNTl5K0s3NmZ3?=
 =?utf-8?B?czhhSDRyTFhkNTk2TFVHd2gyb1hvcnMyRUE3M1YvMi96S0N0SEkxUkMrcUcw?=
 =?utf-8?B?MmYvY2pYd1IvYWdIUEY2MFNVRW01Rmo3ZnR0UkhxOWNOaFJ4NHg3Sk8rM0hM?=
 =?utf-8?B?MG5uQ21oZGNERjJhTGhTS0hJWkw5SFEwQ011dWhxcUlqZFNXZnU4MWwyQzh1?=
 =?utf-8?B?dVNEZWtsWDJLenRNSWNQOStmSFg2TEVoSWF0UE9IMml0WkVrcUZuM3orTmp5?=
 =?utf-8?B?d0E0Wk4ycXBZRVFGV1NMZit6VmFWYWNGT3U1YXhaTHhqbktQMVA0SkhKUXZo?=
 =?utf-8?B?YVpUWDNQSUNmdGRhdnVPbXFMc25LMUlwUnMvOHZxRkZ1SkNESWZGdmVNSVcw?=
 =?utf-8?B?bzlMZkMzT1FtWjBCMy9sWjdMd1BEcDEzNEY3NzE4ZC9ZUVJIUXU3SGdZVDVV?=
 =?utf-8?B?VXlGcUtUVWUwcFoyTEQ3UndEclE5dDBvbWc0ZTR3eENDTHhnZHpIMTNLTzdW?=
 =?utf-8?B?TVY2UjNyd2xZV2M1dkZxOXFsc2V0akRvSlV4QTNkYTBPS1ZITHA3K3pZaEcr?=
 =?utf-8?B?d1ZzQ1B4Mk1ZZndUOEdhb2MvTWFDVmNHakFsSUtyOXY3QXpuQWNFRjl1K040?=
 =?utf-8?B?eThheS9VakhybURyTENXYWNNM1A2SVdBTU1HKytHRkl2OGFKNFpPNitqOVRx?=
 =?utf-8?B?NVZGS01PZ2NuU3BHQ1ZtZndsQ1BpZCtXeEc4NHMxRkZ3cTlXY1FwQzVRTHdB?=
 =?utf-8?B?K0ZGS3ZUd2ZHbjZEM2J5R0NMNlUxQmZMN2hxMDNnaDZiZnJOcDQ3NFVvK2FV?=
 =?utf-8?B?NHc9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ca5e7e-9a67-4555-6505-08ddeacb8e95
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB9040.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 09:23:34.9528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IubaUVjslljIbl6QJYtUgMz4O7RIiY3509RXjtu2/UjR5S+bTgYRGfLE2KSQQsH/82HApYacT2hhIicVPAQH7ktFpxSGcqm//O5ZaPpkpZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR06MB6377

When there is a heavy load of receiving characters to all
four UART's, the warning 'Hardware RX FIFO overrun' is
sometimes detected.
The current implementation always service first UART3 until
no more interrupt and then service another UARTs.

This commit improve interrupt service routine to handle all
interrupt sources, e.g. UARTs when a global IRQ is detected.

Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index ce260e9949c3c268e706b2615d6fc01adc21e49b..3234ed7c688ff423d25a007ed8b938b249ae0b82 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -824,15 +824,26 @@ static irqreturn_t max310x_ist(int irq, void *dev_id)
 
 	if (s->devtype->nr > 1) {
 		do {
-			unsigned int val = ~0;
+			unsigned int val;
+			unsigned int global_irq = ~0;
+			int port;
 
 			WARN_ON_ONCE(regmap_read(s->regmap,
-						 MAX310X_GLOBALIRQ_REG, &val));
-			val = ((1 << s->devtype->nr) - 1) & ~val;
+				MAX310X_GLOBALIRQ_REG, &global_irq));
+
+			val = ((1 << s->devtype->nr) - 1) & ~global_irq;
+
 			if (!val)
 				break;
-			if (max310x_port_irq(s, fls(val) - 1) == IRQ_HANDLED)
-				handled = true;
+
+			do {
+				port = fls(val) - 1;
+				if (max310x_port_irq(s, port) == IRQ_HANDLED)
+					handled = true;
+
+				global_irq |= 1 << port;
+				val = ((1 << s->devtype->nr) - 1) & ~global_irq;
+			} while (val);
 		} while (1);
 	} else {
 		if (max310x_port_irq(s, 0) == IRQ_HANDLED)

---
base-commit: c8bc81a52d5a2ac2e4b257ae123677cf94112755
change-id: 20250903-master-max310x-improve-interrupt-handling-aa22b7ba1c1d

Best regards,
-- 
Tapio Reijonen <tapio.reijonen@vaisala.com>

