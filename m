Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA307514761;
	Wed, 16 Sep 2026 13:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789566510; cv=fail; b=ZDOPgXTfxBjDbAxj6/LZkZzEkNDIt4FjRueC+AOirV21iGQ0DV3FdcTQNVHfy7qGtMZo1L7ffvRphmq0yr4+PEPI0wVRYFK/mvIX3LqUF2m1WXQ1rYlFYFWYqJXHPU0H5eik+bM6AK+7s0qefasN6lVC8Kh2atIDcl8kRpLHki8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789566510; c=relaxed/simple;
	bh=NvPYLqIDM6JukJYq8LxBq/AC6h3PVAqS2u5Uh6RwXYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oDgpnZZ2r3t+uw+SVXGySB9kkZZNKsggPiXinbvZ/NLQN+3QrSMJi2LkQp9HW/KCwNVjnoWEWdUUr4JvaXVuhEuhet5ZgVF9K9WCoV8xQeZBidLa6k4G2AXyBnfwstR8rayRF/WNV9Uv5s01Qi3ApPsvBS8T0CyM3FAIiqJ+qXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=PpfOYBqJ; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Dc7b/I+z; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="PpfOYBqJ";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Dc7b/I+z"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68GCVjIQ2811431;
	Wed, 16 Sep 2026 08:48:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=FqDp3rlVHIB+c5nitVEY9vDu++Df8Ux2z+1Bsyk6i
	SE=; b=PpfOYBqJOnLCpbqGVQFF8eUcOH9XuHNFUibSRuUIYHkls4cwvXmMwEmeS
	DcA/tkb3HhPqivLDy10rDljDD9dkyzVuzI+DSnXYnnnNfGU91fOkE8d1jVRb01UF
	ThhtPeYbZmFJ1riPYJQcO3rmpQmJ3lm/AL+eGZA4lSEUsRqREnCQil4JyLFCTwpH
	wLdLOEYoO93zNeef1hcY+Yfzfo57OJjTAPPdJnkmwkeaJ8zCsnZ7wESzUC8pjfVc
	bLCJ9M0EtWSqDMx8fdPutvTmWA/lVJ/fmDuqP1/prU2RvBbH9x9pVpgQcKYYCcbQ
	x8pMnSWzA5ytr3UvuKf8maev/YTkg==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013016.outbound.protection.outlook.com [40.93.196.16])
	by m0380145.ppops.net (PPS) with ESMTPS id 4gqqmehkfq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 08:48:14 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+QWqv8WgiLQsEIgJKp78w/OEJNe19wV4gU/SHbSUcbBvgT2NUak5+Cll2F9QmmCqUulHXam8qA1gljDRstcjaChEdxKBf7MOtvjh6PpZ2gK85enAjtZhk0XVPjDGTp5vvGX7oV8JRigzq4pxg6xVS1zH3IX0zBvFm+raUDZrTsU/ntVBokVmCLKm5/KCZWIvbqrY1k28eBgbKmTx5eby2WT97pFTzrz8iueE16dmZhHrNkFR+EsYJrsKVn6QBUYbpMuAMoei2HdlFiGCph97ZmEMxxWwR/94v1xjnvQS1tRRWtN9580nNbgEU55qpcoZpfDSO8ugQW0RslJZYHiOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqDp3rlVHIB+c5nitVEY9vDu++Df8Ux2z+1Bsyk6iSE=;
 b=SvjDxZg7KRP1NJM7swC5Fy1zh+lOMbczzncTbHzhS0iretHrerLGR0u+hBohCE2mUexCI1vGPQ8gJHklRUziRkgPRzVOVWnUQQ7m+o86Iq62f53FfjmDfp0qKdVVYd+LxTza/xqQQZ5XNdMhnFnKemmjc39OGG1ML3O7wMi1QkNExl/4bdao5BBflFgP5SeMRi9ptOoD7uAhQc44gKOjhRAc6tZRpQt2THoSB1+/Ngekx3j1P+uO7S9WUkMK7rFxY6lHJTOvhHYLmAkHT67D0nXQ7DgihnknyG6OKYPPwjreF2+sH9JR2FjL0B1U8YCtTqzONn6+mT8w1sSL0PqJJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqDp3rlVHIB+c5nitVEY9vDu++Df8Ux2z+1Bsyk6iSE=;
 b=Dc7b/I+zQFWU3mFzJHd4IQKTeE+S1dapn3m0AEZuY2Iiv7ckWy2FFYqG3AK4DRCjh5Yu6IdjtnnxPYKt5oRFogJYdfL+SDaGT1IKCUbKp2fSrZHHuUFMbSn4a/R5+9cuknhyzGo3GVyLs8MdtBddx+UXD0yKu7Il8bKTR3sD0DI=
Received: from SJ0PR13CA0164.namprd13.prod.outlook.com (2603:10b6:a03:2c7::19)
 by LVTPR10MB997841.namprd10.prod.outlook.com (2603:10b6:408:3c3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 13:48:11 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::96) by SJ0PR13CA0164.outlook.office365.com
 (2603:10b6:a03:2c7::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Wed, 16
 Sep 2026 13:48:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 13:48:11 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 16 Sep
 2026 08:47:52 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 16 Sep
 2026 08:47:52 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 16 Sep 2026 08:47:52 -0500
Received: from [10.249.135.178] ([10.249.135.178])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68GDllk71114499;
	Wed, 16 Sep 2026 08:47:47 -0500
Message-ID: <5801b899-8090-4bff-b4e2-c3e8c97b0eb3@ti.com>
Date: Wed, 16 Sep 2026 19:17:46 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] serial: 8250_dw: Add capability to skip empty FIFO
 read
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Moteen
 Shah" <m-shah@ti.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <krzk+dt@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML
	<linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>, <devicetree@vger.kernel.org>,
        <gehariprasath@ti.com>, <vigneshr@ti.com>, <nm@ti.com>,
        <a-limaye@ti.com>, <y-abhilashchandra@ti.com>, <u-kumar1@ti.com>
References: <20260916085520.2259420-1-m-shah@ti.com>
 <20260916085520.2259420-3-m-shah@ti.com>
 <5fe0efdf-6d61-dba4-9703-269dfd68ae13@linux.intel.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <5fe0efdf-6d61-dba4-9703-269dfd68ae13@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|LVTPR10MB997841:EE_
X-MS-Office365-Filtering-Correlation-Id: 0edff1d8-c302-4bad-63ed-08df13f925f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|22082099003|18002099003|5023799004|56012099006|4143699003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	xD1+6nzxKiwewrlGs+1yA0VtEgH20R8+EITaoommj/zYj6IPVCjHLgNUa0jxhx0MrBvckYluRxuWOMdVdDWNMbIk+hRkaN0xYqwuRR9PgS4P2pa5Z3nSfHvLCeMl3XyDQZyQ2ZcSDIqTn2ak1BltsoJjj0+DUq+juJ4y37oVIeat4iWT5IocAdPFHMzuRwPrQpi8wU9K05bS+1GLv4YE/0aOMGPoaRLexjOaLshksE+0r8ffVJpKLnLQJFAPU7ogzTRcjdMVnkorf7UCn5oF39hKlALtxJxRWVY0bYa2LJcMlVrpFF9ZQo811V3/IqAfVSvWGBV+B7ITg7BlP/0nlNGqZ4NNbGlC18K941LpxXUKrz2IEMe4p0bOIx3eow/B5+2F+fK7eELOhOLH689PhSTjjQTjA7nnLCwobtvNOylwHl+4d5hj1HkgWrSKZZD4Ru/8/45QwCsMFk18uRwJFqp1nbX0r18feSb6I7DKhiHsyjcuk4HjuJ8W1DowR+sGQUC1stzX+uj7/tOqRcF4KMhvuCCh79VbHEtv5RnYk2DahKsSqe4Ou60ZhVN+kGFBe6wGUqmDWdk+RAsulloMicfExDTdH8iz/cqZpNIq9sClQ2nyH0stnziogyR6Ykar+c5lqy3/7kpkGHcddmb3I5iZeAIS5BJG2jFi6mn+mgq+pEz5dMxY1tVSJ81IML0OChNlINwFbJ0DTACEGKya1g==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(22082099003)(18002099003)(5023799004)(56012099006)(4143699003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1WEngbq7I4/pRdV/D2EHvXqP/VzuA1yqh3mmRhl/aa/jHe7hAWS8O0DBPzdK8cGd6PpkDjoCYcmUbIM6nrbLeA17hNHv1XkvedF6wQOOqwsmFeZEa17AeQnCpxAyGB+dHQmEcCOS/VpWVj3pIptpuOhbSa6HXVKb1ljYBYs5xYoAjh6qVYj4S3Tf1OP1MyVNaTb91NUZlbikj4W2oJtDFoukFa2xvhzICkfwxjQiFS/epsNGegbuohKwFcAwovqHIPng7Zi48o8zRvZK9MbsnKiDQhD3oc8lvdXBlaLI4ZNVBk4wUFQ67o23F+IJEjI+0O6e0AxnLX2z7oOb6NchQE7ybdmyL6aNJk/j5WzQYDT6AhiRsflgqbs3YNu89YEGP7FMWgdxY2lfRnWWEcEmGRPgzcfsVuqUWzbE3eNkXRw985d2L3EG3YebXvwbGg91
X-Exchange-RoutingPolicyChecked:
	W5iF2wLf5GmZRkrS69AO3zHcdcSw8Z9e679tYciszUtS6qkH2ygdKCWvegE8vR5HsYM6p9NTv9fB6J7PelLjG+YpLQt4YozoX//aSCUvZGzZgLkEHapusCK30RUvOYGUr9cFc+tZ2hSam8RSdW2FqBeGM0ehWeCOr6/55fzlRoiZMXPgCWIFesl9XOGI1liSQ2g4g2ZlgTVfX2ucE+sJKNREJ/yyFJ1AUQ55YdhEBlo7eZbD+wabiX0FU5zt4JZBNG/o0k1AlCcY7oDzhi4vTeW2Jef9f97aDNQ6wFkTwjtNgEUoJfi1r5EUibwEvQ3bmL5SsWQhxr4BPbAz03ZqGg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 13:48:11.3400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0edff1d8-c302-4bad-63ed-08df13f925f9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVTPR10MB997841
X-Proofpoint-GUID: oPsCcgLz2Lzb5BaMalllad9F4Z9Cl1TR
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE4NSBTYWx0ZWRfX8N73DrZFfVtb
 IPnK8jR/BlNTVx7ZOy5fFIQ6xRzVZWx4gZk76QWx2w0eQBkIads2lId49Usl4nYa7L0HvU3469+
 Q1uC/mHM2J+C29/3tGZkkjl6xwxK4gk=
X-Authority-Analysis: v=2.4 cv=ausnmiZV c=1 sm=1 tr=0 ts=6aaa9e1e cx=c_pps
 a=26rO91Bbw6QoawbNyte6AQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8
 a=jsRvVW0sjvyF_ANNBvYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: oPsCcgLz2Lzb5BaMalllad9F4Z9Cl1TR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE4NSBTYWx0ZWRfX/SNfz846aNwt
 s2zi9ryPBK+bv7ekAuBme7pUaABZGD4zqzKjKqefEXHxBBVpwWMWpX7qlRR2A9qvX0mV42eSwEF
 6QMCzwePrDfKqKoqBUq9lEb377ukKTm2hrnQAtQOe2UbGVy4neFgbTbrH0S7lKX7JXb001akh0t
 9iMrT13s6CjrGenISUU2LnVrt6e/Xg7+V0mXav/zXsYbB4B0yIo0jW8618iZekTS1Wec665To0m
 1xe9yN4V+7+BxJiAsjQGcuT0ZF11rBZXnFtRwReKrIa9Pt3NUpfD5ZElFn0UiVXvoGuZC8eocKu
 5oWrnVW4k7v8ONfWWWnjYgAb2chdswBeBviGRl0Ne1zHyU7Wqdxb64iHwQOQX+ed79byfz82dk9
 T2CtX+2IQipLhf1uj8Khw86zS5TFQqW7mqDD9mCIo3F6J8tASjGBEO186d7AU6nU7NjIr8c2TzE
 PteUuqrOTUY/w3sSPfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_02,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160185

Thanks Ilpo,

On 9/16/2026 4:22 PM, Ilpo Järvinen wrote:
> On Wed, 16 Sep 2026, Moteen Shah wrote:
> 
>> dw8250_handle_irq() does a bogus RX read on RX_TIMEOUT with no data
>> present, to avoid an interrupt storm. The UART core also performs
>> unconditional reads on the empty FIFO during startup and shutdown
>> of the port. On the IP version used in TDA54, that interrupt storm
>> no longer occurs, but reading an empty FIFO instead triggers a data
>> abort.
>>
>> Add a new capability to guard against the empty FIFO reads, avoiding
>> the data aborts.
>>
>> Signed-off-by: Moteen Shah <m-shah@ti.com>
>> ---
>>  drivers/tty/serial/8250/8250.h      |  1 +
>>  drivers/tty/serial/8250/8250_dw.c   | 16 +++++++++++++++-
>>  drivers/tty/serial/8250/8250_port.c | 12 +++++++++---
>>  3 files changed, 25 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
>> index 77fe0588fd6b..45e13c3a8c14 100644
>> --- a/drivers/tty/serial/8250/8250.h
>> +++ b/drivers/tty/serial/8250/8250.h
>> @@ -86,6 +86,7 @@ struct serial8250_config {
>>  					 * STOP PARITY EPAR SPAR WLEN5 WLEN6
>>  					 */
>>  #define UART_CAP_NOTEMT	BIT(18)	/* UART without interrupt on TEMT available */
>> +#define UART_CAP_RXFIFO_EMPTY_READ	BIT(19) /* UART needs LSR_DR check before RX read (TDA54) */
> 
> IMO, this define naming contradicts with the comment because you 
> effectively say "capable of reading Rx while receive buffer is empty", not 
> that it needs DR check before issuing that read on buffer (~ named exactly 
> opposite of the actual meaning it is being used in the code).
> 

I echo your comments; the naming should reflect that the IP does not
allow reading an empty FIFO.

At the same time, I am thinking, reading the FIFO based on the
UART_LSR_DR bit being set in the serial8250_clear_interrupts and
serial8250_do_shutdown functions.
Do you see any side effects to this?


>>  
>>  #define UART_BUG_QUOT	BIT(0)	/* UART has buggy quot LSB */
>>  #define UART_BUG_TXEN	BIT(1)	/* UART has buggy TX IIR status */
>> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
>> index 5fba913f3301..325b620172a7 100644
>> --- a/drivers/tty/serial/8250/8250_dw.c
>> +++ b/drivers/tty/serial/8250/8250_dw.c
>> @@ -28,6 +28,7 @@
>>  
>>  #include <linux/serial_8250.h>
>>  #include <linux/serial_reg.h>
>> +#include <linux/of.h>
>>  
>>  #include "8250_dwlib.h"
>>  
>> @@ -436,7 +437,7 @@ static int dw8250_handle_irq(struct uart_port *p)
>>  	 * This problem has only been observed so far when not in DMA mode
>>  	 * so we limit the workaround only to non-DMA mode.
>>  	 */
>> -	if (!up->dma && rx_timeout) {
>> +	if (!(up->capabilities & UART_CAP_RXFIFO_EMPTY_READ) && !up->dma && rx_timeout) {
>>  		status = serial_lsr_in(up);
>>  
>>  		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
>> @@ -758,6 +759,14 @@ static int dw8250_probe(struct platform_device *pdev)
>>  
>>  	if (!data->skip_autocfg)
>>  		dw8250_setup_port(p);
>> +	/*
>> +	 * On this IP, reading UART_RX while the FIFO is empty raises a data
>> +	 * abort. serial8250_clear_interrupts() and serial8250_do_shutdown()
>> +	 * in the 8250 core unconditionally read UART_RX, so guard those
>> +	 * reads with an LSR_DR check.
>> +	 */
>> +	if (of_device_is_compatible(pdev->dev.of_node, "ti,tda54-uart"))
>> +		up->capabilities |= UART_CAP_RXFIFO_EMPTY_READ;
> 
> Wouldn't it be better that the extra caps would come from .data?
> 
>>  	/* If we have a valid fifosize, try hooking up DMA */
>>  	if (p->fifosize) {
>> @@ -888,6 +897,10 @@ static const struct dw8250_platform_data dw8250_ultrarisc_dp1000_data = {
>>  	.quirks = DW_UART_QUIRK_CPR_VALUE,
>>  };
>>  
>> +static const struct dw8250_platform_data dw8250_tda54_data = {
>> +	.usr_reg = DW_UART_USR,
>> +};
>> +
>>  static const struct of_device_id dw8250_of_match[] = {
>>  	{ .compatible = "snps,dw-apb-uart", .data = &dw8250_dw_apb },
>>  	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
>> @@ -895,6 +908,7 @@ static const struct of_device_id dw8250_of_match[] = {
>>  	{ .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },
>>  	{ .compatible = "sophgo,sg2044-uart", .data = &dw8250_skip_set_rate_data },
>>  	{ .compatible = "starfive,jh7100-uart", .data = &dw8250_skip_set_rate_data },
>> +	{ .compatible = "ti,tda54-uart", .data = &dw8250_tda54_data },
>>  	{ .compatible = "ultrarisc,dp1000-uart", .data = &dw8250_ultrarisc_dp1000_data },
>>  	{ /* Sentinel */ }
>>  };
>> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
>> index e94a0802cbdd..4435df88a1b1 100644
>> --- a/drivers/tty/serial/8250/8250_port.c
>> +++ b/drivers/tty/serial/8250/8250_port.c
>> @@ -704,8 +704,13 @@ static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
>>  /* Clear the interrupt registers. */
>>  static void serial8250_clear_interrupts(struct uart_port *port)
>>  {
>> -	serial_port_in(port, UART_LSR);
>> -	serial_port_in(port, UART_RX);
>> +	struct uart_8250_port *up = up_to_u8250p(port);
>> +	unsigned int lsr;
>> +
>> +	lsr = serial_port_in(port, UART_LSR);
>> +	if (!(up->capabilities & UART_CAP_RXFIFO_EMPTY_READ) || (lsr & UART_LSR_DR))
> 
> Is the logic correct way around? Ah, it's actually naming issue with the 
> define (see above).
> 
>> +		serial_port_in(port, UART_RX);
>> +
>>  	serial_port_in(port, UART_IIR);
>>  	serial_port_in(port, UART_MSR);
>>  }
>> @@ -2421,7 +2426,8 @@ void serial8250_do_shutdown(struct uart_port *port)
>>  	 * Read data port to reset things, and then unlink from
>>  	 * the IRQ chain.
>>  	 */
>> -	serial_port_in(port, UART_RX);
>> +	if (!(up->capabilities & UART_CAP_RXFIFO_EMPTY_READ) || (serial_lsr_in(up) & UART_LSR_DR))
>> +		serial_port_in(port, UART_RX);
>>  	/*
>>  	 * LCR writes on DW UART can trigger late (unmaskable) IRQs.
>>  	 * Handle them before releasing the handler.
>>
> 

