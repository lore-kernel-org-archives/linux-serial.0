Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021126.outbound.protection.outlook.com [52.101.70.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C135139B;
	Tue, 21 Jan 2025 10:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737455011; cv=fail; b=P9pxU3h2NcBP5wQ9TnAURdPbuORbR/VIaE9JyxPSy82llyrLkRKZzkp3MyIX49W61WW/W2F1M1HJOMompOGMW5zv1b5OEoPPON02LJbMtfSo0jHgHW+W8MHDfjjZH1beKvmUwwfiHr/uKdEGh/mM0XoOqUPgTt51R7vD/0FDf7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737455011; c=relaxed/simple;
	bh=biHvIbDvuGsNT+QfIlz/khjErzCxjOylR0nbBP/O/JI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DIEoX5zlW0e4quVmLRwCVUUzefkYdJzR+XFuRoV/w3KrSo26dhqKkb83bCGflVbMxnRpf9FucxAeNEK8GGfSefDbdM1FKvOrY+aT2D8+bmddHeXxxKdykCdB0DF6fqv69QtQn1irheP8lQq/eG8ciE6Q+AmmDcfj2bync+JA7ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl; spf=pass smtp.mailfrom=sttls.nl; dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b=P7uTjUUz; arc=fail smtp.client-ip=52.101.70.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sttls.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b="P7uTjUUz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDf9OIArUIQGXb25nyn/JmjZlkmi/BI1ukIiV6hQ9i/i7E/TQ5db5pafyUvb36TteOiBShA4ETkQShCZZEHU+CcfPsy8CTv1Wr+ayf56zF4Q1BljVLigN2YEKIZoe1DwTC1rr0Zraib6WfbNFzwdn8sL0U8wu+yDOWzCo8ir47nmQ4QQqgT2VKDuFGAXCD2vke46q9wWUMQwB5gKewEuBhwn1fnboQp3iraoVt+QqZdMLBwegf+IOF4ZgKwpYzul0qfghfjQ2h5oSrdnFeq13QO8AFZb5V+5hH+9gbX5VAJgnb8xtInLzFlD8XbVQ5uczmWYS9/9intSfaANISSgVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biHvIbDvuGsNT+QfIlz/khjErzCxjOylR0nbBP/O/JI=;
 b=AIa+jBUbU8595zK5phHbyCNoZ4OhnAo9CTEWo6Ljnvtt7nEK/24RAwBorJ3OuCXEsvxK28+0k9ehbGn3VOdCcR42LUg7ocxsOlyCuOwgsK8V8+AG+dRMFpydKJYTyfvS+zmQ9KYCvvDcP9BtalQ/Gzw98qiWVyDHwzCbOSOV9CEWK0QEhsKcatSM+4V8pLQSpeqmPD6erScmci9P1Kakz2IKYBo/GBeJlAuZ+9PMsogkoXhKtxj6bc6p6+G0/QDyUNN0J9CGrRNlCCkS82aM+lgDbyk3QpM2yaikQZFZ77BxAFgC1+ZxHmg9p4+bYuE8XsG4qJ8eQN/jF5q1mm2Zig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=systec-electronic.com
 smtp.mailfrom=sttls.nl; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=sttls.nl; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biHvIbDvuGsNT+QfIlz/khjErzCxjOylR0nbBP/O/JI=;
 b=P7uTjUUzGnIFwtTUPg+1BAvXPnwMIkm8aQ8v762sW8r1hHdC7Vp+L1VfxRqGAVMwfulNtpcP01FM44cwnR8HkjhFrH8cByFdPSW+8CIQc0+80FKocMIW2fxQQ6Cqo32IApYkrgaelnB4vjUdvJvQkB+jfyD/jOs6P9HNbDjydiYsOJCQAVJq7NFKd/5/b4thVeOkt3K6uxXODTraSnhWpC0Ia2iPW51l9sgvr4vkOtgSKP91TKD1yICDEUGHOlXemuaKzMKxywYsCp5Ui+9OHhaKnlelqRVnvc4H/NvAVItSl7kcUMXd9LUCcFPdo2XtdL/UH8+g110BiG0gqb8A0A==
Received: from DU7PR01CA0019.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::22) by AS8PR05MB8673.eurprd05.prod.outlook.com
 (2603:10a6:20b:34c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Tue, 21 Jan
 2025 10:23:24 +0000
Received: from DB1PEPF000509E2.eurprd03.prod.outlook.com
 (2603:10a6:10:50f:cafe::9e) by DU7PR01CA0019.outlook.office365.com
 (2603:10a6:10:50f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.23 via Frontend Transport; Tue,
 21 Jan 2025 10:23:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DB1PEPF000509E2.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Tue, 21 Jan 2025 10:23:23 +0000
Received: from DUZPR83CU001.outbound.protection.outlook.com (40.93.64.12) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 21 Jan 2025 10:23:22 +0000
Received: from AS8PR05MB9810.eurprd05.prod.outlook.com (2603:10a6:20b:5c2::16)
 by AS4PR05MB9062.eurprd05.prod.outlook.com (2603:10a6:20b:4e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 10:23:20 +0000
Received: from AS8PR05MB9810.eurprd05.prod.outlook.com
 ([fe80::841e:3b57:8c60:5734]) by AS8PR05MB9810.eurprd05.prod.outlook.com
 ([fe80::841e:3b57:8c60:5734%6]) with mapi id 15.20.8356.017; Tue, 21 Jan 2025
 10:23:20 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Andre Werner <andre.werner@systec-electronic.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>, "hvilleneuve@dimonoff.com"
	<hvilleneuve@dimonoff.com>, "andy@kernel.org" <andy@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"lech.perczak@camlingroup.com" <lech.perczak@camlingroup.com>
Subject: RE: [PATCH v4] serial: sc16is7xx: Fix IRQ number check behavior
Thread-Topic: [PATCH v4] serial: sc16is7xx: Fix IRQ number check behavior
Thread-Index: AQHba9SuBSnbmwlU2kijPUKNAAsszLMhBIGA
Date: Tue, 21 Jan 2025 10:23:20 +0000
Message-ID: <AS8PR05MB98106EAAB928CF87A4A1C6E783E62@AS8PR05MB9810.eurprd05.prod.outlook.com>
References: <20250121071819.1346672-1-andre.werner@systec-electronic.com>
In-Reply-To: <20250121071819.1346672-1-andre.werner@systec-electronic.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic:
	AS8PR05MB9810:EE_|AS4PR05MB9062:EE_|DB1PEPF000509E2:EE_|AS8PR05MB8673:EE_
X-MS-Office365-Filtering-Correlation-Id: e59abb6d-71e5-4c2c-6764-08dd3a05a2f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?aFd1dVZhQXF0QjN3Vld3RUpaTGM3eDFHYWJrNTREMW90VGRRczJ5NlFLVXJh?=
 =?utf-8?B?SDludnIvTHBKemhjM0RkTkpmbkIzWlUwVEM3UWpNWDBHWlNVMGI2ZzhaYW52?=
 =?utf-8?B?Ui9JbGpDSmZjRG1GUVdYUVJ5eGlrYmZRd0E2emtlUGU3T1BSMWpCVHVndDlk?=
 =?utf-8?B?Uys1MWdzUmhDOUl4TFNVTi9DSGlhL0tuNFJjSnhzMjI0T0c2dmRvWEU2amha?=
 =?utf-8?B?MG5KWTVWMml5b0JHR3c1ajdTZlhQWWVONmRnRmZ2WlN2Y3RPM0kyMC9SdHVy?=
 =?utf-8?B?V0tlQ3JpTDJZWHNRbzR0SUlaZFYyOTY5eE5ZVGZzYXAvbzArcnA5bHYzNlVy?=
 =?utf-8?B?MkVHbkFDWktRVFFXbUZFdjBQMHR2aFpDMXBkVEsyYktSUk9zUWlGTUFNa3JB?=
 =?utf-8?B?b1I1UThvQTl4NWwyRmJ3bytkTGs5YVRlWnFHR3Q0N25wZENzSWoyTXZzeUg1?=
 =?utf-8?B?OCtodVZJMUQ2NjZuSmY5ZW01T3JJclk3ZTlFWmp5eldMUC9uQnl1eVZmTUxo?=
 =?utf-8?B?ZzFNWFBZS3hTZ0lVbVBPVFBHQ2hPU0F2b1BRd3BzWDIzVEdyS05rUVJQaDVP?=
 =?utf-8?B?MzhIWU92aDMyKzJYZ1R4YTZCWmd6bjR6SjhYZ2lTbFNWZ1hvRTFYMHhuSldR?=
 =?utf-8?B?elYwdVROZjVkYlBoVVRhcDBYd2k0ejV4dXpBeDM2RkZIODBFaURPTTJmT3Ax?=
 =?utf-8?B?RThDcEV1TTdpUE1zMHBIWlNLZnV2R2xWM05ma2NxVVdvcGxMVnRqTSs2czlK?=
 =?utf-8?B?ZzBwd09yOVZSSjFXb1g3a0dWUkhwNlFSaDI2Z2NVaFZEaSt3NzA1OVhlR0hO?=
 =?utf-8?B?UmhGTVA2a2hLSWRsWENuTUYzbVkwakJzOWE3aGpyeC9HUEZMMFJ3Yy9Tdjkv?=
 =?utf-8?B?Sk4yazViYnVyZWduRStQb1RULzcxSm53RXdVOHA2c3F4UGRrU2VGeU5UWFdL?=
 =?utf-8?B?eG5pSmhEOVJuYWVTKzhYbWVqdVlFNXNjeElSaFFpQ2xkZG1obS81UmJqNDlr?=
 =?utf-8?B?aHV4QnJMOUc4djlibGxUamNObE9DZDdYQ1lab3FLblFhaUpscnFSK1hYZzU2?=
 =?utf-8?B?VjI1cHU0Y2VwWTVlYW1tTnVYcXBvZWhvaEl2VDM4RUVmTnpwbkttb3M4QXJu?=
 =?utf-8?B?OUhreTF4SEEzOFRrQWJYZU53Q2k3R0Z5S1h1VjdDa1ZBU0NYcTdYcHZ5L3RQ?=
 =?utf-8?B?czRMUFdDdmpMZ3NSU05Femx0TnVZNUFVcEFjeGdEUjJVWUxRb1ZXRTU5SjVR?=
 =?utf-8?B?bjRPVE80bjNkdGJPZ0oxcTBEK2dZSzhDUWlkbEpFUDR6MTF0TlhjZlJZK1hI?=
 =?utf-8?B?QjVPVVVmWm5WMm1NbDZuY1lXSUJnMVoyY1ZWV3V5dmplN21YVlZPYmdDdXpu?=
 =?utf-8?B?emZ5dEpFR3E4Q3B5dWhhbzhWQk0xVkxyRDVLYjFqS2IvY2NtSW5ReHgvcklr?=
 =?utf-8?B?VllPZEUxdFVTek43d1dvU0RLb3c1UkI0NXdIeWdzWFVlYk5lMk1CM1NjL09C?=
 =?utf-8?B?S1p2MWlhZmhlNmRjaDJxYjhOMUNBblMxNUx2Q2VIckpGcTREUTZ4N29Ic0xI?=
 =?utf-8?B?cWJ2Y0pMb2NsZHB3L2hVZ3p0ZFRVa05MUzdZRjhYclBqQkYycUJjcW11Mm1p?=
 =?utf-8?B?WG92dW52bWJIVVBwQk8yeFNtSWk3WEw3d3BzeldzRXJHcjZiZmwrSzlxNHdr?=
 =?utf-8?B?WnVrc3ZMWnA1U3ljVS9ENWdicEdIeG4xM0hnLzk5dU04dmZncExiVmNxcDhq?=
 =?utf-8?B?MU9IYlduZmp2a2hFOE5mQnJHUXBmLzJLTUgzM1k4L21ZdGNubzcreHc2Qk9t?=
 =?utf-8?B?WnN1Yk1pZlZ4b2lPWWxOUVNhQVEreVFsOU1zckp4YUJCem9WMTBJUXJoa2FK?=
 =?utf-8?B?VWVDcXRFQk0zeDhPQW4yQzB5SVYrbTZjbDZlUFVVeUloY2hpcmYwT0dvdWFz?=
 =?utf-8?Q?B8X4b73iVXXrM7euX6kfLwo4rno/jlpV?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB9810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR05MB9062
X-CodeTwo-MessageID: 567e3dec-9ca5-487f-b284-b91471c2cb21.20250121102322@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509E2.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8ea77b78-c7f4-4073-caec-08dd3a05a0e7
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|14060799003|376014|36860700013|82310400026|35042699022|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEgvbDJjMWFPRHRBQWMzNW1LMkNCRkFmUnRQUjNrbFhIeFl2Y3F0cGFncHR1?=
 =?utf-8?B?VTFCcUc2dHFQTCtpQnQ2cVMzT2FkRWdnRkM2RkxpZENXT0R5UGtpN3lMYjdZ?=
 =?utf-8?B?Z2x4cFBpVzlsanpaWW14ZVppTHlzNkRJdXRrZUhWc2xvdG9GR3J4cHhiT0Nx?=
 =?utf-8?B?WHJ6N1NKUUx2U0hpNWh2RGY5QUNDdk1WMzc2dThOV2ZSRzhnVTU4ZW1sYlNl?=
 =?utf-8?B?dC9zNlQxUzByL0ZIR202Qkd5RzU4eFFUYVc4T1ZRRlVkbnh6Qmh3ZmVaelpR?=
 =?utf-8?B?bzhqbWlqYjlRRlk0eXdJSk9nOXhLaVZYUmp2WnlEeFVyRjFIeVZwQXR5bDlC?=
 =?utf-8?B?MUhYYUNFdEVublRnbllZWDdleVlObzRmWlhpZXhvQ0ZqN2NYQXZlNU5zcWxP?=
 =?utf-8?B?OHdDTVBiSXliQWw4TEtOdnRXT2VibXhWbUNxTkJFaUViOExKbzE3OE80Mlh6?=
 =?utf-8?B?bHhldGljRVFuQUNhaGpyejVlZjBDR2ZzRXJ1azVnSTZIYnoxYkY1U2ZTd1JL?=
 =?utf-8?B?ODZMZzY4cjhIZ1FiSitJT280OUpGYlhjYkE5blcrSlJYNVlpamtVd0hENnlo?=
 =?utf-8?B?QW8veW9LVXl3T3kxQ0llVEordUF4TVNweXJjTFpWL3FXVlArWTE4M3BNZE1l?=
 =?utf-8?B?SjdlV3RhaGtmakZBem5WMzVVeGRSbnFQUnRtNncyaStOcTZiK21WYWhSZmtv?=
 =?utf-8?B?MmlkbWl0bFNxV3lTOEFlR20vRTNnZ1hMSlcyWEZTMURONU1IOHpuZGJEWklV?=
 =?utf-8?B?aDMwK3FjVkVVOGtray91NTRtYW9SaVo1RFdnOHlrNHNLaGpNR3ZYaWVGVmhC?=
 =?utf-8?B?ZExTaVZOcUVnMmcrZ1BtbnlST2U5OVdackI1NnJBU0RvcWlsZWJBZStkL2No?=
 =?utf-8?B?aXZNQ1F6Y3dUWE9EdlR0WlFueWpudXVYaFY2NmVvV2dWZmFIWVJ0aDEvY1Zq?=
 =?utf-8?B?QlZMTGVOMHlxSE01M2tYRVlUT21peHMvdjBqYXpjcktmMStUeUU2SDJUb1Iv?=
 =?utf-8?B?TGRnNVJQYVNvYTJMM2R6aVJKcngzOXVvNGtCQmx6VUZwdlVRZERUa21kWGRz?=
 =?utf-8?B?VHg4dHlrbEpFdkJyTHdYNXZ3QkRXbTJQOFNoMHVDOW56cFdOK1FtMnkvOW9X?=
 =?utf-8?B?dUQybTJZd0pKYkZEaDR1aVlHUjErZUJZSXJFdmNRdklteXZHeTZJZ2M2bE16?=
 =?utf-8?B?U3BRSHk1MnNlOEJraFVSdFFRNVNyV2JKSER2WEFwaS9xVVhDWnd0cmlBeE1u?=
 =?utf-8?B?Z2NqazBKS2xhd09XbFIyRkZ6ako3RytnOHI4YVF4aWRCdTdwSHIxa2xRQVZN?=
 =?utf-8?B?VUFJQWJySHp0T2dMUk42OEJndTliWG5FT2NKRWVrNkNOUlRMR1dMNEV6UHNm?=
 =?utf-8?B?Z2NaVmsrUFFWOEpXdEVablNnYXg4bmhMMUR2TFdsODhLY1N6eVNLdFllUlF5?=
 =?utf-8?B?U2NGMmFSUjI2Nkl3d2pKeHVDcll0OURyYm9uKzBKK0hVUWdhMTF2bUlTK3Vy?=
 =?utf-8?B?YWNkWHRuckE4UzNadjVpQ216cUYreXhMaFcyUjNPZHhGN21yYldhTXZnSmN2?=
 =?utf-8?B?RUxHdUgwM2dJSGQzM2Q3b0drSXJPQ0ZFeW5keU5PdE4rdllrTEEyaFlkTGdt?=
 =?utf-8?B?d1VjY01laGFVQ28rMTF6dy9sUm11UStjS3BnY3pKV29JOUJoRVFxWmtPRDhB?=
 =?utf-8?B?YmUzRTlrS3ppemtMV0VoZXQrczcvSFI1T3VzYUNnS0xQYTExR0tYZGdUZ0NH?=
 =?utf-8?B?SFdBVFJMSEtMK3MxVzJOZ1dxUjlBTjBPbDJsZGpuMkdSQ2FCUjVEOTZMRmk1?=
 =?utf-8?B?aSszNG9ZZE1QWTZHT21WeXFSVmM1Qkk3RVpwbnhDeW9TWEg3U2dFaDNyc0Er?=
 =?utf-8?B?MmdKTHEzOCsvdFUvd3QzS3h5bzQ1cHk5M0FxejU0alRsemQySHVxZzg2QVVP?=
 =?utf-8?B?b2FCazY3Sm1Ya283d1hkNmtpdlo5K0NOQTVDeUlKUDJIa2xSdVNvbjMwc0ZC?=
 =?utf-8?B?T3YzSG5jRFNBPT0=?=
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(1800799024)(14060799003)(376014)(36860700013)(82310400026)(35042699022)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 10:23:23.7984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e59abb6d-71e5-4c2c-6764-08dd3a05a2f0
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E2.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR05MB8673

PiBGcm9tOiBBbmRyZSBXZXJuZXIgPGFuZHJlLndlcm5lckBzeXN0ZWMtZWxlY3Ryb25pYy5jb20+
DQo+IA0KPiBUaGUgbG9naWNhbCBtZWFuaW5nIG9mIHRoZSBwcmV2aW91cyB2ZXJzaW9uIGlzIHdy
b25nIGR1ZSB0byBhIHR5cG8uDQo+IA0KPiBJZiB0aGUgSVJRIGVxdWFscyAwLCBubyBpbnRlcnJ1
cHQgcGluIGlzIGF2YWlsYWJsZSBhbmQgcG9sbGluZyBtb2RlDQo+IHNoYWxsIGJlIHVzZWQuDQo+
IA0KPiBBZGRpdGlvbmFsbHksIHRoaXMgZml4IGFkZHMgYSBjaGVjayBmb3IgSVJRIDwgMCB0byBp
bmNyZWFzZSByb2J1c3RuZXNzLA0KPiBiZWNhdXNlIGRvY3VtZW50YXRpb24gc3RpbGwgc2F5cyB0
aGF0IG5lZ2F0aXZlIElSUSB2YWx1ZXMgY2Fubm90IGJlDQo+IGFic29sdXRlbHkgcnVsZWQtb3V0
Lg0KPiANCj4gRml4ZXM6IDEwNGMxYjlkZGU5ZDg1OWRkMDFiZDJkICgic2VyaWFsOiBzYzE2aXM3
eHg6IEFkZCBwb2xsaW5nIG1vZGUgaWYgbm8gSVJRDQo+IHBpbiBpcyBhdmFpbGFibGUiKQ0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogQW5kcmUgV2VybmVyIDxhbmRyZS53ZXJuZXJAc3lzdGVjLWVsZWN0
cm9uaWMuY29tPg0KDQpSZXZpZXdlZC1ieTogTWFhcnRlbiBCcm9jayA8bWFhcnRlbi5icm9ja0Bz
dHRscy5ubD4NCg0KTWFhcnRlbg0K
