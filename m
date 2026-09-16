Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529B637DAD7;
	Wed, 16 Sep 2026 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789563375; cv=fail; b=dzant/i6li9FCih4VHgs73gbhAqYujoZCycSf7CjGywiFSfqP6mBrGAGKcZDa+PX8gJ3Pxc7WsBj5NeFdOQLD7bFq47h4+KrJ4ptjobRg9kpt4L8pkiC2Go+RFhYIdD+/HenqBQhBoO/b1VjT6c/vWa9LXcMmqBOLH3bl6Rhu/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789563375; c=relaxed/simple;
	bh=SlJ3ASCLW9kq5nnNXAuY/lLgT0bPsvVhGXntqd8fqjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=me5sJK2TZbwXDQSfaxDbdzqVIS10n5isvO0c3rqNNNP5YomFNDAQcL2o2frsHdo0s1bn5KsZ5M0s9nM33L+0AsA9CdfhIvG8YjjXy0u6C1z+j/hNLBuqMURmv18/gPe/IoqyqgHoI1g9/1JkxwCGsxb1SyBBnWPx/l078DbFrPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=EiHydaXr; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AvvVUHes; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="EiHydaXr";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AvvVUHes"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68GCWFiO321993;
	Wed, 16 Sep 2026 07:56:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=Uy8E1OW64Wr0RmRr3DVYWg3Ihgm8Ybv9PXC7YNJQW
	8w=; b=EiHydaXr2DfzA+TrRPzE/tk2KphnROZX6ox6vaNBag8ppzsMqOkPT3Q5e
	3FaX/xuz2EKhglnOjgSUboI+1FDmuGlhCSTZ43MLKCKzAjofRF9w1LCX4Q0ywC2e
	EmBe5QuW/lYB8cSrdtQVs0/ZB0alk1X8mZiXH132HQYZ/jIhTBJ0Kwmzqizbnbnd
	b5Tn6OpkYG1gQ33NStn9MVNx1PlUXaBNes5o9+FDkJdExDeC90X4DrCzaE706BID
	doy2dVCO1xap9JHSIdw/4tM5T6oZ5M5a71GRzOwUvVZlzapvoVi4w2BYESqXDjmQ
	GDwzy/4wROuVuWzeGZk0JsAKONUNA==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010008.outbound.protection.outlook.com [40.93.198.8])
	by m0384305.ppops.net (PPS) with ESMTPS id 4gqfuf3vrc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 07:56:00 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQjaJeJuL62tQzm2ahzHo7HFUCj0CWWcjjb0EkyEE9nnDNoxjp7bg1dQqaOr7uRea4ICa8jUXsEbzvjhc4WTQPt0cp9GgQDbOq87Q6dMh+2xWryQeNeVqu/ALdoBlg0Sr+DKbLXzFLgDWfkuvlLNESL25A/t2mEFYHE7sUBe4ed6tdED267MlgQCszDvJx9LYmyc0HfTdT9KRLZ0AJtJ+Urylx0YIG54hb68h7YfFxOJs5SLJTcGOhcY64uwJwsvIHqiMdeqNP0eVpNoFKDrH+26eQuw+VkFXMQnH5ti7j/n6mOSTnfTuvFUBZwzp8FZ+oLlY3iHl8pLCZhu//q8Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uy8E1OW64Wr0RmRr3DVYWg3Ihgm8Ybv9PXC7YNJQW8w=;
 b=F520HKUKrx5vJGAexbxn2uiHVOx2kTGnMzh8Zh+MNQtWLvPWfQocAbZ5t5JMdaKeqogdi+QnMJ/zLWdJd2eKZCZvoPja60KTt6NbHHxJHwx8qFuejs7tircKMAUETa/mX7+nz2EAxsEFeI9R1VW3Q0mBJYjhBJjKoWFBC21w/zpOnd33RQg8IdBup2HKGQSpz72lUPT/cGhuy1aHmvNfh6TCsAKEytfl1jeSmZU7p8+soJY9maW0g79UAnWyhyU27WzAaQSC28LoKHPyPgmjsAzpgMYIfWTm9dLmGZQc/stpzIh0yxd7gmOwBVGD64WdlU7mAG+BsqnKYyGvFQy1Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uy8E1OW64Wr0RmRr3DVYWg3Ihgm8Ybv9PXC7YNJQW8w=;
 b=AvvVUHesrKzWUIGqLH2rmTG4jD64Yi7u8Sg8OX1ilE1KdDpKzc+6l+eiphi9HpQKEmHOWsbgrAVvO7KLGvUSkR8ANuO9HQsrXkJqSWwT3++dfBZ0qbPKIHmWuT8z0i8tqhdlC/I0sN7Tkp5kvwsoEADQuLAHaz1eaqdJYx1UZyM=
Received: from CH0PR03CA0302.namprd03.prod.outlook.com (2603:10b6:610:118::24)
 by MW6PR10MB7592.namprd10.prod.outlook.com (2603:10b6:303:242::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Wed, 16 Sep
 2026 12:55:54 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::5) by CH0PR03CA0302.outlook.office365.com
 (2603:10b6:610:118::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 12:55:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 12:55:54 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 16 Sep
 2026 07:55:51 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 16 Sep
 2026 07:55:51 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 16 Sep 2026 07:55:51 -0500
Received: from [10.24.50.20] (moteen-ubuntu-desk.dhcp.ti.com [10.24.50.20])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68GCtlMG1991969;
	Wed, 16 Sep 2026 07:55:48 -0500
Message-ID: <a86d414e-3615-4fdd-862b-2cf3a4e15528@ti.com>
Date: Wed, 16 Sep 2026 18:25:47 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] serial: 8250_dw: Add capability to skip empty FIFO
 read
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <krzk+dt@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML
	<linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>, <devicetree@vger.kernel.org>,
        <u-kumar1@ti.com>, <gehariprasath@ti.com>, <vigneshr@ti.com>,
        <nm@ti.com>, <a-limaye@ti.com>, <y-abhilashchandra@ti.com>
References: <20260916085520.2259420-1-m-shah@ti.com>
 <20260916085520.2259420-3-m-shah@ti.com>
 <5fe0efdf-6d61-dba4-9703-269dfd68ae13@linux.intel.com>
Content-Language: en-US
From: Moteen Shah <m-shah@ti.com>
In-Reply-To: <5fe0efdf-6d61-dba4-9703-269dfd68ae13@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|MW6PR10MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: df3b485e-db26-4bc2-c2a8-08df13f1d7f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|6133799003|56012099006|5023799004|4143699003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	xQ66+YkEo53ofvJt+9pdrBYVVre04WrQ4ZRqHaO06pRpSuuMcFET2AQGox3MideBAXxVnXa7pIBh/18qGIzR8Vf3pU+ANu69HUGF3FCHGSpm53pqNBkBfwVsL2WbZvSG/pmdDjoBu2+BBaMDagiHLjvOFojw9ptyLscrm/PChXLggZBVtiaCUU7P5vaxi+JimoIqjdwstn3UjB7lvxYOQWuIVrA1ZFBIrN6SskvnJ2NfRPTlk6xOUOYfRTfQ91U4BPj1hDQS0H90C6K+SB8tdDus5g5QZV86m3vXdghHXsnfV6J3mTvjkuhrRmpxJtfJuLMrIiHEo7uk0C1UT5g92gtb7kKDGsPrtUj8L95BOaMNuJS0yfo92YQtamnHyxVaUCs9Thl+EFvQP6M5QOn3eeY7YqeVzlX15Z8Cjf69p7oKf+eCAMNlO8nKpMoO/cWUjQOg4pppv8jcvLPZLcKwQUtmff4E2lT/SdN2pGeRXXupBKpvY32iLNyJ+zWNXQVT3wg/riUuz8vNWWRv2wAdhl2cmtGQY3lQe/OfqAirSP4Pus42h9JCx7Pyc0WGTm5fNJOsiScW7ZIC9ytMuE9pVnLs4r00+0zXu0lCLgLUB4AWr4Z/rvoKsVvZ4mx4VjZytSN4qr5XsrldMbMpVMvZzgILLW/bgMwHM5KFWG4a3/tQkfRobR9gMEhQQBLiiV2/SaLPoIuWjl9R3JehHbVpwQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(6133799003)(56012099006)(5023799004)(4143699003)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hhlf5swLzQYVxZbKXVyuo9Eno7+ZUlZEHF3/v93XiisX9rG5eqDQOBGlj/aXLtdcV9Qx0iQZb/Re/8kG5uz36M6KHDkfoO08cd+Uuj1JS/si9F4J2ZQHVxBgcvx5oOoMRxI5dO6gbfPQ/kXz7QYP41y1Dm14iKheXbt/KKL7B5F4u/4BQM9g64DNQ64cwTsCKL+eHmYXqeItGwWkL5v4RFMvbWWU8664QNQBcXwa7DSpXU4eeOGdBL/L2Bs6EVNL0Ie0rPfSHzCt/fopZRG18IaxUX4LJkoavDh2Lx4OSB6Maa+jqUUnyC9JsJ+PrP3Dkh2hKACHC7JMX4mGT2DektaM+cztI8Q0ryuecJTo3LXgcfHWjI0I9mpg5ipVMnI4nMBPgm3pa22KTj0p2Mmgu1bKBjsOJnrZRJ5Itf7e3e744vA/3HGKU1D/sH2iaYbf
X-Exchange-RoutingPolicyChecked:
	T5KzENAh02ADljGcQ3+gFzs4fpXCEbnwUqMwOTjSQMLth3+HXYCCnZdLBCGj0oQcPU+3H4pavTsGGXKF+b3Db1zn0EFHsmQgRsUJS5zV0T6mJMsaZmpetLy1G1KBg29aUY11rYQiiiOsanhwU9mMJfIp8XwY9fFyqUDIbpoqrDP8tQReEeUfS48EiJiYkFavUQvBhrPVPtOkTVkIvMFWaFhceVn6GdZ0TZadMoPZkosfHX2OtW/r5BJjzAiLMck8WVKtfaNGqz4HKxWFyW64HKIqHtJXzMgajq4Yy5EcHH3Bhj0l1iDgbOp2QixvR21dahDiobQvcD1We5c6f9Dh9A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 12:55:54.0327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df3b485e-db26-4bc2-c2a8-08df13f1d7f7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7592
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE3MiBTYWx0ZWRfX6uB9+8ayZZrj
 0/IxMENS4ig/DS9kKAkNBDWl1PsDFpdRrTYfTl+hshwreCE8AUubJIhAuxNb6bKIJwF7sGXEjmU
 0pWJzlaaSkLk43GPeOxyoC0aVcgvv+vW1eZscCaynEURqmgwR6FPCP7FaBlMAMVXxNTm/yTksZc
 1RU34ryWBo4/64H4vCIt9RHgU33zugSVri4gPRz6SzhrCFwQIyyhvmNi7Qslpc93hA+KwXRheQ9
 OpQjWQRKuFeXOxccwHxRFmtn16DPFczgdQOpNmWmtwibBOtBOtQ1TezETvW/pAhMBlfBYpT1IIZ
 VUfkBq7PJe4ma8j5fW2qYbe0rvTu4ymGDYhMf37QQvUJhWKtOcIlRIY5owA/4WeNwENfk4NwYQK
 HUZtvwdEt6F/BB7WuWSd8jwVXpPfkBnpcs9lWw6QRsTl0Au8MeqaD05ib3Hs/9WJbkJKYntWzsb
 yrcvRwaK29u0URB0Ydg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE3MiBTYWx0ZWRfX0bf6tPJ0pORD
 nQeW+JK4z5Pm2qqnhRKiQzD46Gtgx6t2/zT50srpb5JJ4DYVc2R7tgVroF+95UMn/v6IfGfCgDv
 C6b78ggF5JxXsD1muDNlgmD9hcDuBmI=
X-Authority-Analysis: v=2.4 cv=E7JYNqdl c=1 sm=1 tr=0 ts=6aaa91e0 cx=c_pps
 a=ugQZG2M6WJJQC2vHgpB33g==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8
 a=B1l22-7mApB2nf6dgJEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ZAXa93o7gz6vvee40sWVvIwkHk6nkJxF
X-Proofpoint-ORIG-GUID: ZAXa93o7gz6vvee40sWVvIwkHk6nkJxF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_02,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160172


On 16/09/26 16:22, Ilpo Järvinen wrote:
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
>>   drivers/tty/serial/8250/8250.h      |  1 +
>>   drivers/tty/serial/8250/8250_dw.c   | 16 +++++++++++++++-
>>   drivers/tty/serial/8250/8250_port.c | 12 +++++++++---
>>   3 files changed, 25 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
>> index 77fe0588fd6b..45e13c3a8c14 100644
>> --- a/drivers/tty/serial/8250/8250.h
>> +++ b/drivers/tty/serial/8250/8250.h
>> @@ -86,6 +86,7 @@ struct serial8250_config {
>>   					 * STOP PARITY EPAR SPAR WLEN5 WLEN6
>>   					 */
>>   #define UART_CAP_NOTEMT	BIT(18)	/* UART without interrupt on TEMT available */
>> +#define UART_CAP_RXFIFO_EMPTY_READ	BIT(19) /* UART needs LSR_DR check before RX read (TDA54) */
> IMO, this define naming contradicts with the comment because you
> effectively say "capable of reading Rx while receive buffer is empty", not
> that it needs DR check before issuing that read on buffer (~ named exactly
> opposite of the actual meaning it is being used in the code).

Hi all,
I am in a bit of conflict here regarding the capability, I dont think so 
this "cant read empty FIFO" falls under either UART_CAP_* or UART_BUG*, 
ideally its a quirk. Any opinions on the naming?

Regards,
Moteen

>>   
>>   #define UART_BUG_QUOT	BIT(0)	/* UART has buggy quot LSB */
>>   #define UART_BUG_TXEN	BIT(1)	/* UART has buggy TX IIR status */
>> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
>> index 5fba913f3301..325b620172a7 100644
>> --- a/drivers/tty/serial/8250/8250_dw.c
>> +++ b/drivers/tty/serial/8250/8250_dw.c
>> @@ -28,6 +28,7 @@
>>   
>>   #include <linux/serial_8250.h>
>>   #include <linux/serial_reg.h>
>> +#include <linux/of.h>
>>   
>>   #include "8250_dwlib.h"
>>   
>> @@ -436,7 +437,7 @@ static int dw8250_handle_irq(struct uart_port *p)
>>   	 * This problem has only been observed so far when not in DMA mode
>>   	 * so we limit the workaround only to non-DMA mode.
>>   	 */
>> -	if (!up->dma && rx_timeout) {
>> +	if (!(up->capabilities & UART_CAP_RXFIFO_EMPTY_READ) && !up->dma && rx_timeout) {
>>   		status = serial_lsr_in(up);
>>   
>>   		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
>> @@ -758,6 +759,14 @@ static int dw8250_probe(struct platform_device *pdev)
>>   
>>   	if (!data->skip_autocfg)
>>   		dw8250_setup_port(p);
>> +	/*
>> +	 * On this IP, reading UART_RX while the FIFO is empty raises a data
>> +	 * abort. serial8250_clear_interrupts() and serial8250_do_shutdown()
>> +	 * in the 8250 core unconditionally read UART_RX, so guard those
>> +	 * reads with an LSR_DR check.
>> +	 */
>> +	if (of_device_is_compatible(pdev->dev.of_node, "ti,tda54-uart"))
>> +		up->capabilities |= UART_CAP_RXFIFO_EMPTY_READ;
> Wouldn't it be better that the extra caps would come from .data?
>
>>   	/* If we have a valid fifosize, try hooking up DMA */
>>   	if (p->fifosize) {
>> @@ -888,6 +897,10 @@ static const struct dw8250_platform_data dw8250_ultrarisc_dp1000_data = {
>>   	.quirks = DW_UART_QUIRK_CPR_VALUE,
>>   };
>>   
>> +static const struct dw8250_platform_data dw8250_tda54_data = {
>> +	.usr_reg = DW_UART_USR,
>> +};
>> +
>>   static const struct of_device_id dw8250_of_match[] = {
>>   	{ .compatible = "snps,dw-apb-uart", .data = &dw8250_dw_apb },
>>   	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
>> @@ -895,6 +908,7 @@ static const struct of_device_id dw8250_of_match[] = {
>>   	{ .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },
>>   	{ .compatible = "sophgo,sg2044-uart", .data = &dw8250_skip_set_rate_data },
>>   	{ .compatible = "starfive,jh7100-uart", .data = &dw8250_skip_set_rate_data },
>> +	{ .compatible = "ti,tda54-uart", .data = &dw8250_tda54_data },
>>   	{ .compatible = "ultrarisc,dp1000-uart", .data = &dw8250_ultrarisc_dp1000_data },
>>   	{ /* Sentinel */ }
>>   };
>> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
>> index e94a0802cbdd..4435df88a1b1 100644
>> --- a/drivers/tty/serial/8250/8250_port.c
>> +++ b/drivers/tty/serial/8250/8250_port.c
>> @@ -704,8 +704,13 @@ static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
>>   /* Clear the interrupt registers. */
>>   static void serial8250_clear_interrupts(struct uart_port *port)
>>   {
>> -	serial_port_in(port, UART_LSR);
>> -	serial_port_in(port, UART_RX);
>> +	struct uart_8250_port *up = up_to_u8250p(port);
>> +	unsigned int lsr;
>> +
>> +	lsr = serial_port_in(port, UART_LSR);
>> +	if (!(up->capabilities & UART_CAP_RXFIFO_EMPTY_READ) || (lsr & UART_LSR_DR))
> Is the logic correct way around? Ah, it's actually naming issue with the
> define (see above).
>
>> +		serial_port_in(port, UART_RX);
>> +
>>   	serial_port_in(port, UART_IIR);
>>   	serial_port_in(port, UART_MSR);
>>   }
>> @@ -2421,7 +2426,8 @@ void serial8250_do_shutdown(struct uart_port *port)
>>   	 * Read data port to reset things, and then unlink from
>>   	 * the IRQ chain.
>>   	 */
>> -	serial_port_in(port, UART_RX);
>> +	if (!(up->capabilities & UART_CAP_RXFIFO_EMPTY_READ) || (serial_lsr_in(up) & UART_LSR_DR))
>> +		serial_port_in(port, UART_RX);
>>   	/*
>>   	 * LCR writes on DW UART can trigger late (unmaskable) IRQs.
>>   	 * Handle them before releasing the handler.
>>
