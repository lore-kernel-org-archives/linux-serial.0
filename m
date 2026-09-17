Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB1C538D6E;
	Thu, 17 Sep 2026 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652072; cv=fail; b=hdRdb6Qr6PfGx171HgbLM2IZ3vPuoxPo8MzOPp98sJd+zEUde+kqhcqy2Wsv2VvT+AmVSg4BA7gAeUB/1zKr0ejQhSZjHlnoB+pUUZWlxZ4OE9pk944IzoMmpNDqKS8gReAabj3Ik7FbaMzfzmUji4uA4A934sj7OOqa/sOUyfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652072; c=relaxed/simple;
	bh=fAolPamUZWwtJwYn68wXWO9IRHLHphK7V0wU72JDo8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gyq53vVa/2D7mKsL4sLTudzNove5nedD9bEgNHIEg+UDlQimoM/PNBw+hmdrJNXIVveZfbOl7TVgVLqZub7PUvJb5BTEF7zHgjs/2pvCOxWJQdP8NYdZY9OaxXZgR85N5Ri2ZQAcXZqGQYJ0mTox2kEhYZZ1pJm9C6DGUGRxkMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=I/GhyNlU; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RtLyknem; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="I/GhyNlU";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RtLyknem"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68H9aYfh2703413;
	Thu, 17 Sep 2026 08:34:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=YcuJVkAYEm0k56TstG4ugXvOL/VkRkK5mF1EA2G49
	O4=; b=I/GhyNlUi+YoTUiJyzpYzVx62z5G9TkgMKMRMNaMlX3isSWPe8hjfVOvo
	poxDRIV0Uz4Csjw8kda5Lk5pECcY4rjPYQLkrs0dai+viWSODZHyhSfn7YUTS4nU
	7wKdns3Uq/RdyquOEWiB7fd7RMkM3zQnFGnZI8UcTR0KElpcS/PvZHhaJbVPJ5pu
	btNz9mWJH9MlYcQghRAQKK2O8rr85tgl6TxXwwZBxErAY5Tl8+rBoGQHbycPBa2y
	zlblVEb8BWhZIwcjWu1StgczGZMJPs9N+GCfIULXIwUfHs89ICIiivyDQx3sJAeI
	hfAdJ/0RmAoAAquQ4IZ3efRDNCraQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013003.outbound.protection.outlook.com [40.93.201.3])
	by m0384305.ppops.net (PPS) with ESMTPS id 4gqxfpfjub-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 08:34:08 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0skQB2D/OdRpIxuh2J215sa1JOppViYRtPAQETNzwQ2Kiy3SpH0k/cRwhMUW6mdkaI9rvGFKnlmSj4d8HztxrecSeZLyjVrl9/NoyISaTNK/AUEaY9wst7Y5xVktbq1T2WYJraTt5Mn8Xsh9evkXWxAauqC8/3ebbSVGJYz82geAI/byj+RRXwlSTFSzp3my4/+6ymyad++bE8nzDUNpLEC9UlMKHNR2xIrhNjxjxTWfzl0shKRHa6HKSmOaGERs89+FqYl+PpUqcufV8xNh5j9p8czJrb81SpNCTIG104QhGkCHZqjeIDlxrIIvpaGMCX+CsgLeSi4V+rAW9s41A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcuJVkAYEm0k56TstG4ugXvOL/VkRkK5mF1EA2G49O4=;
 b=HTCst8eIN3t18h2NGOke8jVIeD1LVybS2JPPuwR/i+n5y054wU1nIz44ZVFOMLemhLDkCJZSBrJBi4Fc3HNPNvAQeluJqJDre061uuj253dtoEFNLM/OGycvZHlrnb1dCoS9DC3hD0Sc+YKnHnX1K+PgFHWcLzZsId3FNgQi5sj7E4DGXkVfz3GbXTXmrgciYn++kNHEhbBVxRum0o+THnPiOEWBtI9d3PgUrkdRwqb6tXXG/qQqVJJX1NoMselTS+4oXqEwVrFszIqw6tkj2WPo8b2MSdSYEgnQ6E+XyKqhqP7RMi2GAL852BXgNfE/Dk87f7yd7zQgMiu/iiHHsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=picoheart.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcuJVkAYEm0k56TstG4ugXvOL/VkRkK5mF1EA2G49O4=;
 b=RtLyknemP+vQfwIXXsBJzJrgL7N2WnQxFoLys8HIfezFLf6uWjO1dsSamKJyLOAgxoZn57SLsVZ6gZkNNeitfacTrUvEOcwbnqKHojhccA5EW7kdNPsmjfEvN42lLllqfDG79k/AYE29aLoE64UwTJMZ6w7JdQM6c04tHyxb6vU=
Received: from DS1PR04CA0007.namprd04.prod.outlook.com (2603:10b6:8:44f::10)
 by IA1PR10MB6758.namprd10.prod.outlook.com (2603:10b6:208:42e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Thu, 17 Sep
 2026 13:34:03 +0000
Received: from DM2PEPF00003FC4.namprd04.prod.outlook.com
 (2603:10b6:8:44f:cafe::40) by DS1PR04CA0007.outlook.office365.com
 (2603:10b6:8:44f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 13:34:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DM2PEPF00003FC4.mail.protection.outlook.com (10.167.23.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 13:34:02 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 17 Sep
 2026 08:33:15 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 17 Sep
 2026 08:33:14 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 17 Sep 2026 08:33:14 -0500
Received: from [10.249.135.178] ([10.249.135.178])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68HDXAJV4012521;
	Thu, 17 Sep 2026 08:33:11 -0500
Message-ID: <fa69c45a-3d14-4f48-b54f-bfce7d04c49d@ti.com>
Date: Thu, 17 Sep 2026 19:03:09 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] serial: 8250_dw: Prefer SRBR in bogus RX timeout
 workaround if available
To: Yicong Yang <yang.yicong@picoheart.com>
CC: <ilpo.jarvinen@linux.intel.com>, <andriy.shevchenko@linux.intel.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <geshijian@picoheart.com>, <yangyang.8776@picoheart.com>,
        <yanligen@picoheart.com>, <u-kumar1@ti.com>
References: <20260908141524.20302-1-yang.yicong@picoheart.com>
 <52822f65-58c4-4def-a1b6-e37055d4c0c6@ti.com>
 <ab256e4a-a9cc-410e-b889-f75fb01e77c7@picoheart.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <ab256e4a-a9cc-410e-b889-f75fb01e77c7@picoheart.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC4:EE_|IA1PR10MB6758:EE_
X-MS-Office365-Filtering-Correlation-Id: 69e1ffce-ed0a-425a-ae7a-08df14c05637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|1800799024|376014|82310400026|36860700016|13003099007|18002099003|22082099003|56012099006|10067099003|5023799004|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	vfMXJ+e95yChf4ZOP7AC3zo5DQmoYkOWsdgO/mc8mihOiv3osBZqkgztuN6Mq+IW0ra5ASxHYLEB10W3/+oIQK//2zDx7up3+AGxkEqld8YPQrQVNncpdPRAY3t1MGZPTQque+0bU8+yCOMtugdWdCiNRZqhoZ2k76YZlaKDFxjD4cLJ7zqq2YGL4yDLVnVwUHnRKvKHRJhRJNmKCpAcMHDYf5JYJZtB9a/ZH5NADiXE70IYIfyMcoRElVnTAGCjRf5euYusI5iwpY0fPH8RX1U3S3C0/4M7R8Nw99t8kSpPkj4dOsXwIUplPXRg0mbksVzLfprSQiAk3FnU0dohvaGaRRbxOuhMPAUmN9dr3cLkT5Qifk+dXPyFmaCnswwjwXiwMzB1FJlkWwUdRPoUTaf/wLdjQs9EUYh5x6pwfwhfKXIcTY5lGUCDmZdLX0zNx+lwQ79xcRvuZmC4cpmk1lVO0xdi1PBLeEqq13/kTyTcu82wKJdLMUpGKp5CS0upeDSApN/4HEndCpQ7lDqLgEM/XQORct0j11p4HfOz5uqO/Q9GAc6ewRat7x9YoGoZUCEkTRbQ9AJYKzOimxdkcu8GEXODRs0cPNBXp4ren7gCLZVHsdJo/gImd8yptKXVedek8Z+8M84uWknh314Gvg==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(82310400026)(36860700016)(13003099007)(18002099003)(22082099003)(56012099006)(10067099003)(5023799004)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bIbpgnsMKn27R0arK3qDKWM8l49CDr8m1Cb9EFt0KA/qOT/UaLunUdTYfu9FpDdtNtGJxwHXTdNeL9jXLHgVW1HbdaOkGsCU8dcKHKSMzAZP5jPmAsYIVrH0ZKtdyyGqBU/mTRbduiaUboFIgK7gje2vwHh0nrt458f+ZJnvNgO+ysDekeHrBKcMiPzIUmsNOkDigMQXvQWGcxkyS5cQd/zIBqilfFet4ESeGV3SC2LiiGhnKB9Ra3pwNG6dE1l5jPm+hM7ChfFMh/mpAElYMjxA8VIMuuxxHlDV0eRaJixhWXHdfVMFd32kZMTQqRswX1j1C8/crNlrAeEqwsFZx2P8FBmXuuj5hzwHhR3auWHszXs49yrTEqEpXYPoaC4G9FvzkHc+gj18kcNWgMdPzOBUdlZOwZ5WiPhns2VEVzSwHZz/vtRkJDu7ntmK+m32
X-Exchange-RoutingPolicyChecked:
	eA2GbdYJIkcPzaK3oBwQS+awQQpgZDh5MaC7lL6xilq+Jv8rde4pd6tB19lSM4z2ysemu/Mg74BneAjcadHKwTcfddrbuafpMgDyFT32ATe+gr5Se8EdyNigMfhZMkh/++CGM2Xr31mePnAsrxwYnlee3wpBxU+cvfyQKTJwQCupH4w8tHhZIGXDUN1OUAcMlHlh5niNTqntigzdsGi9OF8xT++vpmNmQOBKERJY5x+XU9fqxC2xMU9PVk+e+y1oWSXySF2q64Z26U9s9IllDTWs9na9T21LZmY0h8CbV2Cq3cWA87ayI2AXfnhKBShB95GNxf7RLaVnZQFPZ1jsYw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 13:34:02.1680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e1ffce-ed0a-425a-ae7a-08df14c05637
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6758
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDE5MCBTYWx0ZWRfXzwP80SRaCrI7
 NHRA/RxGJu+OM2XVRzaKlH7U8KNfcrr/+hrQ/ugDpRt7vTWxDddpoka2repTA2kYRV/a/1XvzuF
 JvMEYGZuD6lKFwUcErVPXibiV7gBiGk=
X-Authority-Analysis: v=2.4 cv=HaWB3SE8 c=1 sm=1 tr=0 ts=6aabec50 cx=c_pps
 a=9JMNuyHA4Bc1wrbCcMLwMw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8 a=TxhyHGSeAAAA:8
 a=JEDr5tGq2WxbtpRiCG4A:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
 a=VRTRSrWG77IPp_BSX07q:22
X-Proofpoint-GUID: mtg4wsHRBULn3EWmT5M4qJdWcouGQ0mc
X-Proofpoint-ORIG-GUID: mtg4wsHRBULn3EWmT5M4qJdWcouGQ0mc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDE5MCBTYWx0ZWRfX5xMyoUQal1oS
 PDH2Zd2RW6dM5PKQZ7ldHPOgl7ahQ29lR7ohMcX6RJxSlF4VXt9Tf9MEPXSI2lkCAugUNV+DQVy
 olJFqppHj0COf++imfy/ikfbm7XErGt98F9IcjChzD9VfpTGw60MP6kfcmrlJijJesGJkSvpWvI
 By4XZy+6HNTBmHfCHUZvNZDgDhBKbRUyB/ACvA7w3jBr7c1eXPmUtxYFQI/FtXwiAFK29prS32Y
 /6HipTklahNsJoqfd87PzB/UDDy0KpuVqMxgeroMgYiCFDzvghIkIAF5c0bGCoa56Px/ch50IcG
 oaT2QoFGmSZWJ69Nlo+yv2kLCo0dA5230F9ER/QQPUc4ZsFyhD2s8PlsyxBL+s0pv3k3h+pLoRw
 sYDirxKNtobamtJOXQCbWWDd5UZvggJMWkDvyu/dsW4m8oUE9EwmcOmTVA8htnoxg8dDNl8OhRQ
 Qm3Xlnjeq0Npi9GTltA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170190



On 9/17/2026 6:36 PM, Yicong Yang wrote:
> On 9/17/26 6:47 PM, Kumar, Udit wrote:
>> Hi Yicong,
>>
>> On 9/8/2026 7:45 PM, Yicong Yang wrote:
>>> The DW uart could get into the cases where a bogus RX timeout
>>> interrupt is asserted but no available data. This could be
>>> workaround by doing a bogus read.
>>>
>>> Currently the driver's using the standard RBR (receive buffer
>>> register) for this bogus read. However the reading of RBR
>>> in this case is allowed to raise a hardware error if vendor
>>> choose to implement in this way (our platform). It's also
>>> allowed to do the bogus read using SRBR (shadow RBR) for
>>> workaround which won't raise the hardware error. So change
>>> to use the SRBR to workaround the issue if it's available.
>>>
>>
>> Thanks for the patch. If I understand correctly, the IP you are using
>> does not allow reading an empty FIFO, so you decided to read the SRBR
>> instead.
> 
> yes but under certain condition, see blow.
> 
>>
>> Does this same case applies when you open a port without any data in the
>> FIFO:
>> https://elixir.bootlin.com/linux/v7.3-rc3/source/drivers/tty/serial/8250/8250_port.c#L710
>> ?
>>
>> If yes then I am wondering, how the condition mentioned above is bypassed
> 
> reading an empty FIFO (by RBR) will be fine when the fifo is disabled.
> so I think serial8250_clear_interrupts() you referred is always invoked
> when the FIFO is disabled.
> 
> I also find a similar issue related to serial8250_clear_interrupts()
> that trigger the PSLVERR when reading the empty FIFO when the FIFO
> is enabled. this is fixed by 7f8fdd4dbffc ("serial: 8250: fix panic due to PSLVERR")
> 

Thanks for details, so now you are making sure, while at this empty read
fifo is disabled.


> thanks.
> 
>>
>> Thanks
>> Udit
>>
>>
>>> Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
>>> ---
>>> Change since v1:
>>> - refine the comments and type per Andy
>>> Link: https://lore.kernel.org/linux-serial/20260907074035.77796-1-yang.yicong@picoheart.com/
>>>
>>> Change since v1:
>>> - simply the workaround path per Ilpo and Andy
>>> - run ~48k reboot tests and didn't reproduce the issue
>>> Link: https://lore.kernel.org/linux-serial/20260629075510.32854-1-yang.yicong@picoheart.com/
>>>
>>>  drivers/tty/serial/8250/8250_dw.c    | 9 ++++++++-
>>>  drivers/tty/serial/8250/8250_dwlib.c | 5 +++++
>>>  drivers/tty/serial/8250/8250_dwlib.h | 5 +++++
>>>  3 files changed, 18 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
>>> index 51d026f20825..b8a0bca8b536 100644
>>> --- a/drivers/tty/serial/8250/8250_dw.c
>>> +++ b/drivers/tty/serial/8250/8250_dw.c
>>> @@ -439,8 +439,15 @@ static int dw8250_handle_irq(struct uart_port *p)
>>>  	if (!up->dma && rx_timeout) {
>>>  		status = serial_lsr_in(up);
>>>  
>>> +		/*
>>> +		 * Do the bogus read from Shadow RBR (SRBR) if provided.
>>> +		 * Both RBR and SRBR are supported ways to workaround
>>> +		 * this problem. But read RBR can cause hardware error
>>> +		 * (PSLVERR) if hardware choose to implement in this way
>>> +		 * (implement REG_TIMEOUT_WIDTH to 0), whereas SRBR won't.
>>> +		 */
>>>  		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
>>> -			serial_port_in(p, UART_RX);
>>> +			serial_port_in(p, d->data.srbr);
>>>  	}
>>>  
>>>  	/* Manually stop the Rx DMA transfer when acting as flow controller */
>>> diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
>>> index 8859e66d2d71..9bb02a4ab11f 100644
>>> --- a/drivers/tty/serial/8250/8250_dwlib.c
>>> +++ b/drivers/tty/serial/8250/8250_dwlib.c
>>> @@ -247,5 +247,10 @@ void dw8250_setup_port(struct uart_port *p)
>>>  
>>>  	if (reg & DW_UART_CPR_SIR_MODE)
>>>  		up->capabilities |= UART_CAP_IRDA;
>>> +
>>> +	if (reg & DW_UART_CPR_SHADOW)
>>> +		pd->srbr = DW_UART_SRBR_0;
>>> +	else
>>> +		pd->srbr = UART_RX;
>>>  }
>>>  EXPORT_SYMBOL_GPL(dw8250_setup_port);
>>> diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/8250/8250_dwlib.h
>>> index 1fe52332e774..ee7a07fac0f6 100644
>>> --- a/drivers/tty/serial/8250/8250_dwlib.h
>>> +++ b/drivers/tty/serial/8250/8250_dwlib.h
>>> @@ -13,6 +13,7 @@
>>>  #include "8250.h"
>>>  
>>>  /* Offsets for the DesignWare specific registers */
>>> +#define DW_UART_SRBR_0	0x0c /* Shadow Receive Buffer Register */
>>>  #define DW_UART_USR	0x1f /* UART Status Register */
>>>  #define DW_UART_DMASA	0xa8 /* DMA Software Ack */
>>>  #define DW_UART_TCR	0xac /* Transceiver Control Register (RS485) */
>>> @@ -90,6 +91,10 @@ struct dw8250_port_data {
>>>  
>>>  	/* RS485 variables */
>>>  	bool			hw_rs485_support;
>>> +
>>> +	/* Register offsets */
>>> +	/* Shadow RBR (if not defined RBR will be used) */
>>> +	int		srbr;
>>>  };
>>>  
>>>  void dw8250_do_set_termios(struct uart_port *p, struct ktermios *termios, const struct ktermios *old);

