Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A4B4FECDA;
	Wed, 16 Sep 2026 14:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569171; cv=fail; b=BcZERi3HEoasHV2VpRJTO7FhMYxXieDrB43k/bk5Gm8qSy+2MmjHhxnTQN4LTcr1sqdFGEGY6gKcuFor+IiLLYTq4EwJoEOtXddph7Pri/Q7yu3mz/hmZnhXdoQYgo0/7sxB3gBBCTd84NMhzZg13zWB0DmEdWmfdHIpl0aYTcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569171; c=relaxed/simple;
	bh=m68EoIxPbniC9F4XbRpH/JPY3vvNeWaS7VO21yJXTCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JjDYAGgg2Ubjqcqkojlts/m+m3VfGoC83DMD/C/yn1K3jEYg/JeZqTm384wMSiZ44zDrPK/VzugESL3v8PhZsf8yKCqJXfFffP5jMDVyhV3KRAUX8ELfXlj+YGrKat+yaM4a6ewsn0OIGX0fOjsoVTpScanXT5tluEL1OQTRj/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=SuVvz+He; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=t7Zbea5e; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="SuVvz+He";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="t7Zbea5e"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68GCWCN6321790;
	Wed, 16 Sep 2026 09:32:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=JIGVrBGIm7+fJZBL4mvbIwqjXATLuK5OqQSKed2Fq
	bA=; b=SuVvz+HewemgTW4AjzrHs59WpfajScCZKVIvf+dIPLAV3DSpk371iA9/T
	/xJPfFmtU3QiQ40LpCXgzCg+yjkZkghN4yO1FFDJPIlW1IWuMy7eObBzv3t790Gm
	Ky1KIGdR0Vw0yqc2ClL91pH5aCtFE8dxsKgNeZ4AodVooo5rvj8UDeVKZIshz6W6
	aDiioI4FoHXEQ715Q0m27vo6Ha5x25+XLjc+yMqF3LNtPpCWWgz4LeA1mspetrlC
	ux8dMRGhbEuS/Tri/tCE/vQLSVtcbmrZhKLpECDMS264nbgUFoIsSKnVR9Pf6m4g
	xdzsc3OOgLOWpdQWitOoJuIt/Heow==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012054.outbound.protection.outlook.com [40.107.209.54])
	by m0384305.ppops.net (PPS) with ESMTPS id 4gqfuf4gum-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 09:32:43 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpmIlGpyeBcRyDzrX0zzjroHIaEVxLYg0QDMV87MrjoIiWa+gf6EJ7SA/I74rRNKTThRhiXcUHv43mzi3nOb25IfOR0Ft+WNkL8VRILUO4r2EUfd1ShBMyr8XDxP/YvPDH+MOBWt6rZTE0HWIz2vPyKKelIuUFs8+oWWyaGAGoqH4ur7oRsRyijlKLteYoXFgt3n8gnljvqpMxU6oasuxh9hMI6+0r0dsIAf08HSTy5AtpJMiN+7gXJZofmZn8sPlof+5DD+6olkPDje846LwOVvZGU5oPyDjmWUYvl7tDfcSQS5pTPmDkUjVrlqiwBaXcrRvB9mpZ/9nMfLuroxlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIGVrBGIm7+fJZBL4mvbIwqjXATLuK5OqQSKed2FqbA=;
 b=yGSG5GMYIYtyQ6HwmUwshDA72HL9UIIKtS+IB0JWfy2grqPN6tL/Ntq8FtK62dkcBxti8rBl4Dx7lFGG3g1nuDzYP9yRlLsEy4WCa508DzKo36QJyXuyty7EZEPSA1SwjfGhQaEO+VgDR9hf8QiqyRMKw2L443wEii3xhnUzCSlOVAdrTYPGZIgqLv1p/A8ezpkllEGiOayhuvk1TDNqg9T3nVKPHsl3LKfuaxoQHqFzK38V3XdNZnY/dbsyMfWt627y5e8c+vvskyKlCEHS+oN3lJifdAxCT28nchfjf1ZENl8CpMJue/NQ4bH+mjn0AzGwK5RjHpmRaSqtZ7XyyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIGVrBGIm7+fJZBL4mvbIwqjXATLuK5OqQSKed2FqbA=;
 b=t7Zbea5e0CuHtud/A/P9w4r53/W5fRvzvXeN4zdvrG4Zv3GeBUbhqItLdT9fC+wEGwJ+7KvCRA3A/bM7EJ9HTQ2J6HDV0p2OMVXGg+if065hL9bs4G/sMzKs+sxWp9Y15vpWegYYKZ9UVCGvtVF979XHtnVjfBdv0DlsIfBqhIk=
Received: from PH7PR13CA0021.namprd13.prod.outlook.com (2603:10b6:510:174::29)
 by DS0PR10MB8221.namprd10.prod.outlook.com (2603:10b6:8:1ce::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 14:32:42 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:510:174::4) by PH7PR13CA0021.outlook.office365.com
 (2603:10b6:510:174::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.7 via Frontend Transport; Wed, 16
 Sep 2026 14:32:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 14:32:42 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 16 Sep
 2026 09:32:07 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 16 Sep
 2026 09:32:07 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 16 Sep 2026 09:32:07 -0500
Received: from [10.249.138.105] ([10.249.138.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68GEW39g2130993;
	Wed, 16 Sep 2026 09:32:04 -0500
Message-ID: <01ddb59b-5987-4be9-b6d0-f77ba5535d64@ti.com>
Date: Wed, 16 Sep 2026 20:02:02 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] serial: 8250_dw: Add capability to skip empty FIFO
 read
To: Moteen Shah <m-shah@ti.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <krzk+dt@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML
	<linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>, <devicetree@vger.kernel.org>,
        <u-kumar1@ti.com>, <vigneshr@ti.com>, <nm@ti.com>, <a-limaye@ti.com>,
        <y-abhilashchandra@ti.com>
References: <20260916085520.2259420-1-m-shah@ti.com>
 <20260916085520.2259420-3-m-shah@ti.com>
 <5fe0efdf-6d61-dba4-9703-269dfd68ae13@linux.intel.com>
 <a86d414e-3615-4fdd-862b-2cf3a4e15528@ti.com>
Content-Language: en-US
From: Hari Prasath G E <gehariprasath@ti.com>
In-Reply-To: <a86d414e-3615-4fdd-862b-2cf3a4e15528@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|DS0PR10MB8221:EE_
X-MS-Office365-Filtering-Correlation-Id: 749c363d-5cf6-4b04-7a2f-08df13ff5dd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|6133799003|10067099003|56012099006|4143699003|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rMYDzhvvck2sbBUUNk8+U9V0kKcPhmFDoRt2fx9CjcC/6SyvzN8NzbeJoU088joAu4jT67oDIXSg6wcCg7VKuGLJLXxhJXdckaIEPZQPij7LBYzxa0x5zAI0ebyCYMxnxBymWyi09M5SecMc2BYhrLN49tc5MVZqqiev6YMo9X8maapijjJE+QRamAFwWHSFQdVu8g+/CSFUyv6hDE+gFYdahHu6AWtCpnZmtHNZq03afr7C35GTTSXrvIsYAR0AfUDbC7S857lOXpYVEkHoKYKPDJc1kAjB17foUdQaES3lIVaj2f6TAWyY97fBZglqhHS8hIQsU5OqlS4XUqyrZFVLdxTcueLQyof3fnz8ofHthlfmWN9FP7/TW7RTNoeFWwM3Pws7wS2+MLVYeF1f/EijpRe3EzQ8/yfRsSlgOGxHYoWY8C8YB+7IEH/AO8AG1t0oT/le19tZzHxqBLeboY97MDyUBnodL4I13wt2N20dnxFAkwh8Yt/rcCk5aiFOWN/u7ZB4/8YmP/q0dXp2c8TRvLHTbOyrW1JUdyj3cbhJN+Fyb2bhCtOzafRD5JW/+v+55MBVYWjZCAhJ1k+thHA1uysbgJDuTV1YFCnUtQcAtEmO+2ooJSu51l/bpBJ1acoSXbuTN31DNCM4vHCaBrBWMCVtt59oDO5Ag4jmEbR80LIKWG3Lek4uXxfl98mZ+1DtQCjik/8NEAoHqFOMhA==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(6133799003)(10067099003)(56012099006)(4143699003)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	P0Gv8/3SGjijNHbrakIvX0m6LvC9JX0Q86VOh0Ay0iNG/97/txCij8XwoYfAmz7GiNcfohwVcv/2LpswChD6+m2zS+DXDVvrphakl8/BFrEJ/ChlU9EF/VZq55AhV47To3Nntxqweicw+2NGLsF1REurYtO4LmpzcM8CiIVqlppXiLDlsrWBUKtmELzwdvvS98jgNWB9yHiKoN+Lj0Lv3278MHBjrKEiVlkv/r7wNFtvw5NORZs7SKkRslk/s6vu1VEEPSyNfy+VqBaSjk/HrjsBDQlbaso7sdZEfmd0hAiPi66qlKjzO2363HmaP1ro6gmx1HgcYoQwT7+I9r8wJU1b655NVRMaf5mDisVDSabD8s4eJl5anhiLFp7biDzjslwdH0xyJAxBVLlink41W/MblCl6hxsRCfbWD6/tnbTNF8jpkw9hY6aJwqR8alfc
X-Exchange-RoutingPolicyChecked:
	HXoTgC0aT/KHFnOvWgBbbJ6ei54SSsv3yNaPOoP73nExdkj9sE+7WyI3PbDwFBtLVC9cb8LAb2fdc8aaD9/2qcVtXBfUq70l279oXA8UwAZhcq9fTp39GHFykge/2HyXmB3fsu4bwizyJZECf1zGKwHIoJaDJpVINCxob3KJryfHKELqj4VyN5ShlnkROZsBuBCQiOKbLln9s4qJ4w041LuJZULb+s0Nxo/Qr3OEBnLpFXEh26CvmmtZozo7h1GRgssHAB5GsrXirv7sMnWYExiARGwepoLivu5CfdIEXMBXSjYy2yz5Bw+qjt8bH0ZM9DyYNa20e8T6DppUWFBOrg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 14:32:42.0816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 749c363d-5cf6-4b04-7a2f-08df13ff5dd3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8221
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE5NSBTYWx0ZWRfX91MV55rVtvdE
 sP0S7+JUDBciRJdapoZOZgT7yQbhTdgWH8yF4L8Xcr6tbbr0TASn4dInCZmW3dpK4Nj4V2qGiHT
 xrACnYYMyzODMMWGEbUi08TbNAZy248DjzN5ENKhwxElwk+N0c855BZWUz0PHa1CrseTeccPXfo
 c2eFKiaxnlqhzn7IMHuF+6fCHj9RpogQ26DS6cG27QuhedV3i9tFgXPt/BK7X7xo+guggavSIbe
 DM73VXDluF5MzGemlKWrpGS+BnmQzrop4BNxbFqJr4l4z7rQdjNWuzoAmlpm+C85F+qrnTIvnFz
 ShJX4OuFaMvrHsdJ2HcYjvNHA7zn2Z2Xnjq8xSi5obVHGTYKoPd1bkgYbpSl2i7y2F2YNm+6x9A
 yUYCYg2HDRs1+1MZgPLop/1LabCZ04Q5yc3lUh/BZRcuw+sy5e0BI7zd+YrcxTORY8tLwM3xv4Z
 wDE2bZBEMgh1rIgM9aA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE5NSBTYWx0ZWRfX1OxfknpqyYR2
 Zh6TPWsAOmv3mz5cfTNbkDfIFpaJTPF+JUt+Rm7x3umVIYIgQwwXYHp7rOGtK2atLgn2xvHDc+V
 a76kqS9kUZpbqDoh5HYWe0GIRW5/lbQ=
X-Authority-Analysis: v=2.4 cv=E7JYNqdl c=1 sm=1 tr=0 ts=6aaaa88b cx=c_pps
 a=AdSExLHk7727Th38kKp3hg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8
 a=iOpkIWuewEEs_d4jb4UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: i3tdVQsbj_VCg7XZwqPa9Pvzzn0h2Aby
X-Proofpoint-ORIG-GUID: i3tdVQsbj_VCg7XZwqPa9Pvzzn0h2Aby
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_02,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1011 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160195

On 9/16/2026 6:25 PM, Moteen Shah wrote:
> 
> On 16/09/26 16:22, Ilpo Järvinen wrote:
>> On Wed, 16 Sep 2026, Moteen Shah wrote:
>>
>>> dw8250_handle_irq() does a bogus RX read on RX_TIMEOUT with no data
>>> present, to avoid an interrupt storm. The UART core also performs
>>> unconditional reads on the empty FIFO during startup and shutdown
>>> of the port. On the IP version used in TDA54, that interrupt storm
>>> no longer occurs, but reading an empty FIFO instead triggers a data
>>> abort.
>>>
>>> Add a new capability to guard against the empty FIFO reads, avoiding
>>> the data aborts.
>>>
>>> Signed-off-by: Moteen Shah <m-shah@ti.com>
>>> ---
>>>   drivers/tty/serial/8250/8250.h      |  1 +
>>>   drivers/tty/serial/8250/8250_dw.c   | 16 +++++++++++++++-
>>>   drivers/tty/serial/8250/8250_port.c | 12 +++++++++---
>>>   3 files changed, 25 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/ 
>>> serial/8250/8250.h
>>> index 77fe0588fd6b..45e13c3a8c14 100644
>>> --- a/drivers/tty/serial/8250/8250.h
>>> +++ b/drivers/tty/serial/8250/8250.h
>>> @@ -86,6 +86,7 @@ struct serial8250_config {
>>>                        * STOP PARITY EPAR SPAR WLEN5 WLEN6
>>>                        */
>>>   #define UART_CAP_NOTEMT    BIT(18)    /* UART without interrupt on 
>>> TEMT available */
>>> +#define UART_CAP_RXFIFO_EMPTY_READ    BIT(19) /* UART needs LSR_DR 
>>> check before RX read (TDA54) */
>> IMO, this define naming contradicts with the comment because you
>> effectively say "capable of reading Rx while receive buffer is empty", 
>> not
>> that it needs DR check before issuing that read on buffer (~ named 
>> exactly
>> opposite of the actual meaning it is being used in the code).
> 
> Hi all,
> I am in a bit of conflict here regarding the capability, I dont think so 
> this "cant read empty FIFO" falls under either UART_CAP_* or UART_BUG*, 
> ideally its a quirk. Any opinions on the naming?
> 
> Regards,
> Moteen
> 

It can be cap as you have done already, just name it to something else 
like "UART_CAP_NO_RXFIFO_EMPTY_READ" and address the review comments 
received from Ilpo.

>>>   #define UART_BUG_QUOT    BIT(0)    /* UART has buggy quot LSB */
>>>   #define UART_BUG_TXEN    BIT(1)    /* UART has buggy TX IIR status */
>>> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/ 
>>> serial/8250/8250_dw.c
>>> index 5fba913f3301..325b620172a7 100644
>>> --- a/drivers/tty/serial/8250/8250_dw.c
>>> +++ b/drivers/tty/serial/8250/8250_dw.c
>>> @@ -28,6 +28,7 @@
>>>   #include <linux/serial_8250.h>
>>>   #include <linux/serial_reg.h>
>>> +#include <linux/of.h>
>>>   #include "8250_dwlib.h"
>>> @@ -436,7 +437,7 @@ static int dw8250_handle_irq(struct uart_port *p)
>>>        * This problem has only been observed so far when not in DMA mode
>>>        * so we limit the workaround only to non-DMA mode.
>>>        */
>>> -    if (!up->dma && rx_timeout) {
>>> +    if (!(up->capabilities & UART_CAP_RXFIFO_EMPTY_READ) && !up->dma 
>>> && rx_timeout) {
>>>           status = serial_lsr_in(up);
>>>           if (!(status & (UART_LSR_DR | UART_LSR_BI)))
>>> @@ -758,6 +759,14 @@ static int dw8250_probe(struct platform_device 
>>> *pdev)
>>>       if (!data->skip_autocfg)
>>>           dw8250_setup_port(p);
>>> +    /*
>>> +     * On this IP, reading UART_RX while the FIFO is empty raises a 
>>> data
>>> +     * abort. serial8250_clear_interrupts() and 
>>> serial8250_do_shutdown()
>>> +     * in the 8250 core unconditionally read UART_RX, so guard those
>>> +     * reads with an LSR_DR check.
>>> +     */
>>> +    if (of_device_is_compatible(pdev->dev.of_node, "ti,tda54-uart"))
>>> +        up->capabilities |= UART_CAP_RXFIFO_EMPTY_READ;
>> Wouldn't it be better that the extra caps would come from .data?
>>

yes that's easy and straightforward to do like...


>>>       /* If we have a valid fifosize, try hooking up DMA */
>>>       if (p->fifosize) {
>>> @@ -888,6 +897,10 @@ static const struct dw8250_platform_data 
>>> dw8250_ultrarisc_dp1000_data = {
>>>       .quirks = DW_UART_QUIRK_CPR_VALUE,
>>>   };
>>> +static const struct dw8250_platform_data dw8250_tda54_data = {
>>> +    .usr_reg = DW_UART_USR,

Just add capabilities here as suggested by Ilpo above

  .capabilities = UART_CAP_NO_RXFIFO_EMPTY_READ,

Regards,
Hari

>>> +};
>>> +
>>>   static const struct of_device_id dw8250_of_match[] = {
>>>       { .compatible = "snps,dw-apb-uart", .data = &dw8250_dw_apb },
>>>       { .compatible = "cavium,octeon-3860-uart", .data = 
>>> &dw8250_octeon_3860_data },
>>> @@ -895,6 +908,7 @@ static const struct of_device_id 
>>> dw8250_of_match[] = {
>>>       { .compatible = "renesas,rzn1-uart", .data = 
>>> &dw8250_renesas_rzn1_data },
>>>       { .compatible = "sophgo,sg2044-uart", .data = 
>>> &dw8250_skip_set_rate_data },
>>>       { .compatible = "starfive,jh7100-uart", .data = 
>>> &dw8250_skip_set_rate_data },
>>> +    { .compatible = "ti,tda54-uart", .data = &dw8250_tda54_data },
>>>       { .compatible = "ultrarisc,dp1000-uart", .data = 
>>> &dw8250_ultrarisc_dp1000_data },
>>>       { /* Sentinel */ }
>>>   };
>>> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/ 
>>> serial/8250/8250_port.c
>>> index e94a0802cbdd..4435df88a1b1 100644
>>> --- a/drivers/tty/serial/8250/8250_port.c
>>> +++ b/drivers/tty/serial/8250/8250_port.c
>>> @@ -704,8 +704,13 @@ static void serial8250_set_sleep(struct 
>>> uart_8250_port *p, int sleep)
>>>   /* Clear the interrupt registers. */
>>>   static void serial8250_clear_interrupts(struct uart_port *port)
>>>   {
>>> -    serial_port_in(port, UART_LSR);
>>> -    serial_port_in(port, UART_RX);
>>> +    struct uart_8250_port *up = up_to_u8250p(port);
>>> +    unsigned int lsr;
>>> +
>>> +    lsr = serial_port_in(port, UART_LSR);
>>> +    if (!(up->capabilities & UART_CAP_RXFIFO_EMPTY_READ) || (lsr & 
>>> UART_LSR_DR))
>> Is the logic correct way around? Ah, it's actually naming issue with the
>> define (see above).
>>
>>> +        serial_port_in(port, UART_RX);
>>> +
>>>       serial_port_in(port, UART_IIR);
>>>       serial_port_in(port, UART_MSR);
>>>   }
>>> @@ -2421,7 +2426,8 @@ void serial8250_do_shutdown(struct uart_port 
>>> *port)
>>>        * Read data port to reset things, and then unlink from
>>>        * the IRQ chain.
>>>        */
>>> -    serial_port_in(port, UART_RX);
>>> +    if (!(up->capabilities & UART_CAP_RXFIFO_EMPTY_READ) || 
>>> (serial_lsr_in(up) & UART_LSR_DR))
>>> +        serial_port_in(port, UART_RX);
>>>       /*
>>>        * LCR writes on DW UART can trigger late (unmaskable) IRQs.
>>>        * Handle them before releasing the handler.
>>>

