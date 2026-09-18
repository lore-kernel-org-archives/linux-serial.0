Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB12B30BB8D;
	Fri, 18 Sep 2026 04:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789704354; cv=fail; b=dChetyk8jmrrJzUlghtQL2MRVyhu9OyQvYCp9Rqa+ZLwARYFzASbsUyG8KCaMAd8YjN9DlQcBepVSAX3uIAMXBxTpKZxhQNOaipKrKm/PSRgWVjuilkLONoqOv3KL/UG1XMjh133H/RxGxcaLi2FBUt1/By7IU3mO/oX6XerM0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789704354; c=relaxed/simple;
	bh=2MILFJsiDrqCv2NswIkwxbniXNZRf0yfl6c5mwpQUFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LUKYwa3gTO569D7t/tlqcEWUJfdH/AF1JxJNtM1SlF63sTOURQOFolfh6KGQ6bCl+pDsX7D0rz3Jzrxijx/VBke8EB6RF/Pvawdh/H5IFbLtbnJLVM7KyLyusEoa+7vua3UHquWu4Icpy6MAa6Uim7ht+SAZQU3Go0/au5+GDyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=h/6Zfr2y; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FgzYCVFy; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="h/6Zfr2y";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FgzYCVFy"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I2VG7Y3382663;
	Thu, 17 Sep 2026 23:05:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=AcALSr7YC0LhHgQ7pKQIMi6r9pkW2IuqFAuRALmUm
	bM=; b=h/6Zfr2yvCdlwqKa1//LbZ69wxSTCqjLTl7ozUyoilAt6BB0Lun0bs7Lv
	v9PuiKCChYFU4Xyfg8SuOdWoVXwFZHp78obmBMhbaWm+2JKbNDLq60XvP21SclzN
	Q72zBmwvv4bMominbs1y838YCDs5ZbOKm7e9Swm4oPqWOVygYtyZOHUqtQS9skSW
	K/5JXM/CjqvAEiUhVPXJNWn7LalOQIYPPzmk/5xoRo7teKUSaeKKdEVA8YDSF+r6
	BhizbKPWX7+nlzlCmCSiCAKVSLl9Xo8uvGYDGskr/zMmkxhTmjUW5JCrdH/864Cf
	XFeegI+gGIEWEEgmJH5Bl71DjY8nA==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013062.outbound.protection.outlook.com [40.93.196.62])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4grqn028ur-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 23:05:46 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iX9XZAvLDR5TAh8eJ5t2vbIDbUka6lYl1zuegZtNDq7o0p5MmsUoUvrzELaWw/zqnPDfdj3UVua9AeLT5ltD5p9DTmIdLc831fSqpIluRsCD023q4WY/KE1FaG4dS0kdmJnqdgMNdG0EW3JlHicyI4mCx2lIhdeW/R15fK80GACdns9waCLIEM2+oSPaWaM/sy9vygNUznVeVo6Icw3Lghp/rf176lYBCXuF+pNkun5iKKa9NdcZJJRbg+uDCwQN9zoCiR297UmanFxPO1jgoj3eIUeAqGOZ8T9YZFDNb9mAvQY9yB9egfOi1NaEDGYJbCMH8rovcmydvZWMUj5kRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcALSr7YC0LhHgQ7pKQIMi6r9pkW2IuqFAuRALmUmbM=;
 b=dIDALHZOF+dChV5jiEix2PeKwE0/eWRvPZ9h4bVCWPvJiNMItEuQhuHruEc1+hM+c37S6JVGubnpmXWezzy2Q5jSlIrjDUSh4gEgzZQu6cAmnfBAbsxc4/YSDUjpuo2WzWKBp+eDpmHQQwy4pLyQN22X6uZWRDjiAFXMz2YlcaD92jLLlto4Xe+J1kYaN1n/q310EuYOAkemLmUUQJKkOqzzxLngsnNkTtOQ39XMvLl4Kb1Q8W4WDmLs569jF8BiyqCO2Sz+uO//I5N9KbngqMzRaVSX7qyjCMrUZo6W03TUoI6O1qEBq/Nsit8WUNQYtYadOTT9VNSaxjSXu9GBBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcALSr7YC0LhHgQ7pKQIMi6r9pkW2IuqFAuRALmUmbM=;
 b=FgzYCVFyoHAgJINyuRYcgIDl25afMf6l45Zi5m5PjbefEH8dR5q3IOHDc0KYf20bDAPdeGcjDrj6OxYH+y5/2uNHT4ExA8CByfMki9CoR/GeKtpKJXUi2f557NsmA34Knd6basN+7+6ORynlCHsIHg8va9naiLieoddHr7zot4c=
Received: from CH2PR03CA0003.namprd03.prod.outlook.com (2603:10b6:610:59::13)
 by SA1PR10MB7792.namprd10.prod.outlook.com (2603:10b6:806:3b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Fri, 18 Sep
 2026 04:05:42 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::70) by CH2PR03CA0003.outlook.office365.com
 (2603:10b6:610:59::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Fri,
 18 Sep 2026 04:05:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 04:05:42 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 17 Sep
 2026 23:05:27 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 17 Sep
 2026 23:05:27 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 17 Sep 2026 23:05:27 -0500
Received: from [172.24.28.100] (lt5cg60819vj.dhcp.ti.com [172.24.28.100])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68I45NPH986369;
	Thu, 17 Sep 2026 23:05:23 -0500
Message-ID: <dd95a15f-1ba0-4575-a0af-e0cb5ea5ec56@ti.com>
Date: Fri, 18 Sep 2026 09:35:22 +0530
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
CC: Moteen Shah <m-shah@ti.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <krzk+dt@kernel.org>,
        linux-serial
	<linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Jiri
 Slaby" <jirislaby@kernel.org>, <devicetree@vger.kernel.org>,
        <gehariprasath@ti.com>, <vigneshr@ti.com>, <nm@ti.com>,
        <a-limaye@ti.com>, <y-abhilashchandra@ti.com>, <u-kumar1@ti.com>
References: <20260916085520.2259420-1-m-shah@ti.com>
 <20260916085520.2259420-3-m-shah@ti.com>
 <5fe0efdf-6d61-dba4-9703-269dfd68ae13@linux.intel.com>
 <5801b899-8090-4bff-b4e2-c3e8c97b0eb3@ti.com>
 <d82f9326-6a01-2903-a1b7-b1617ca85db9@linux.intel.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <d82f9326-6a01-2903-a1b7-b1617ca85db9@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|SA1PR10MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: 43db1777-dd49-4c92-85b1-08df153a1b9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|56012099006|6133799003|22082099003|18002099003|4143699003|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	4cGkCP+lU4KlhFvYtnrC3kdL4fB7Su7an3dz3YH1HgRKffDUeBzGjn7YMJ0M+9bXMvEdO9qzkBMCcg0TyXbGILEUXZVB8z8xxC5EsU+zzTFHFnuz44ZUw/drTY9PWtNdM53luRXdELF+UBCa6kbA+2ejmUTQeM5CunxgGaihrIO+AeeoakX0UebrXooBr3yDAY6LWcpjH1VTh8l6UCY55OpAeA/hxlgPtKtsGQfmf1Rkn2r4+I75XWnkP0ehL44TYGn7+oxMH/RqYOb7zy3K+SLQ0lShz6GNGbpemKjD1VkGlfisM1FWIUwkTWB0euQsFpCJoq0oZSuBpJ/ryi9mkGA/9w3pq62ryiMP2p8qcAYcfYcSaG1NXhrBLPVVtxPkbyKZhu9t3c1vHGE/eTGKvQHn0R0/1p8+6iJnqGtCe/M2SeC0gCIkdSZHX54qJrL5ZSAObS9QWUiFTdXMprQbMEf51OWivvHMN70ztT2OAGpC0HPnWXpcfamq3yBOaCHwM6LS/wz8bicF5urLvY9kxGzegr4xra6AyP9mDT55uZxt8M4zUjxupFKYYWsJuyaIh9hOtTIXoBsVWXXNS/PMlrUX0pRZFbtJAMQukeGQ/cfYvdUcCIA+oYiiJ0o4mYNvX9lLAG3eo1pwQowREXA4tXwdHzEKsFLTRBZP5WiWDsU=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(56012099006)(6133799003)(22082099003)(18002099003)(4143699003)(5023799004)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jh8uijmFnFiFoVn7W2YeM4OwFyv0UEQpv3mAJapxg1+zTxM2uTw5L4P18dA4ET7JCDL1oAT+Td8EpSXDSuL4Xsscj5kUxYX6WgS/vFx38XN0um2KAq72QUPsxf1j4TrSp0F8UcG1glZnp6gH6GpFZydVfFQLMc5m7BJX4MXew8S1YAtbQIYHMWFLJqEt1gHKvHOWqRYuyOfOCg51ZFvYbvS+iOfkZVYGlPOplDewfVuAlP/MsUk1h+oH5XNlsewHQik8SFUpyCNtZ+EHBgRZdY2M6yQuE6OJjUpKnAz3POQ086ZJYm4ZBd5ibIpgexFy0NEBxbjG+Zv0IfaG2ATpzEH8JWUxe0QZUkSOsosXhHgXltPZ1uqhKXyh3Ccpaim2IxS6DBkXIrNU9xAwBqdt+dXfD928GCMI9bsxlFqFsOGnyfmG76o8pAIO8wpLnfyo
X-Exchange-RoutingPolicyChecked:
	pAQhQxAVIpfj4XmN4XwBuYddSZDYMMJY+g5jyO4xfGAfmzBJgMIypICM+UzMzNRielEOAHx/NDkqaS5lx9NwGIxY4OIRFmsVQwnjEFN6yrE3Wy6wHF9brA+q+VEoN7mbnOuYkAcTnGR3BGS1HIFHAmTalP1veegUMViktBxEL/fmkYPpCitVw3SIoLwmlY6FIsnEvzfG99O3wMPJGtNt0XtkIVbvbIKEVKALLAdPf4H53D6nNpKoBf15LKRC/liGzFJMhhnsHCfd8vInrPE10BlEwghgAnGsfBeHTUGAdoCFgsyXraXgDQJdDzQKZ485uBFQ6cChoZkfJji7swxiqg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 04:05:42.4574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43db1777-dd49-4c92-85b1-08df153a1b9f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7792
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDA0OSBTYWx0ZWRfXzbQeOFzo7/1q
 NtCN3DEUKkL+QsOzqUeHryxxBgOB0l8a5j3UCyvrbcUmG81/IJTwU+xCtqdOuT21KcnCCMx3ixL
 vLJI+d6WZ5k+rb/VspSRYMshBvwlu+PZdLgFML0mMA3uG2OswhBOH2m0Nst/TH3U72rBOd93+R8
 IvIdEXGfEne1f3r0Vh/AWxHZhFk0FkKoSHtLpTEMY1vmo5SZhrk8naqpP3+NOh7gRnKUcUyU6yN
 1b9YcrluXbYekjellsgnPYUV4O3GLdVyg8QoOECWhB0/e6k/ZDxPZGCkP1uYTR4OCc/VvCo1wia
 Amlt6Mc0RL5AvoWitREpF2vYxr9k8nYcoe1298Yd4Dqi68fMz+kz0rVpb4fbBtsKh00rSdIVg9C
 DfLP0gMe7ySbVwE4QzK2uht0dC2hn2ALhBY3IYmw/7b/cq4YF6vo32BLyIOi09XbHtNwRvhSESK
 RcbTmWqPY4xvOM8zslA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDA0OSBTYWx0ZWRfXwm+vK3JjFUS2
 8yEjtQ6Xp0Ieh19JhDxXo1jztOzEl37vCBqMt38AyUXyxXGXzaZ1PtgL1WeNxm1HNZLel0O87CT
 kIq0Jeh4ufynPDxf4cYEpGxJU7iiVzw=
X-Proofpoint-ORIG-GUID: Qcv57si6Xbtl4Edoa0d_ImcNZ_lrc8as
X-Authority-Analysis: v=2.4 cv=XcccX455 c=1 sm=1 tr=0 ts=6aacb89a cx=c_pps
 a=NNTlVNVDZfSUkWkRvmJkNA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8
 a=TxhyHGSeAAAA:8 a=sozttTNsAAAA:8 a=y5ittif9tQIw1IVr7QMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=VRTRSrWG77IPp_BSX07q:22
X-Proofpoint-GUID: Qcv57si6Xbtl4Edoa0d_ImcNZ_lrc8as
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180049



On 9/17/2026 3:10 PM, Ilpo Järvinen wrote:
> On Wed, 16 Sep 2026, Kumar, Udit wrote:
>> On 9/16/2026 4:22 PM, Ilpo Järvinen wrote:
>>> On Wed, 16 Sep 2026, Moteen Shah wrote:
>>>
>>>> dw8250_handle_irq() does a bogus RX read on RX_TIMEOUT with no data
>>>> present, to avoid an interrupt storm. The UART core also performs
>>>> unconditional reads on the empty FIFO during startup and shutdown
>>>> of the port. On the IP version used in TDA54, that interrupt storm
>>>> no longer occurs, but reading an empty FIFO instead triggers a data
>>>> abort.
>>>>
>>>> Add a new capability to guard against the empty FIFO reads, avoiding
>>>> the data aborts.
>>>>
>>>> Signed-off-by: Moteen Shah <m-shah@ti.com>
>>>> ---
>>>>  drivers/tty/serial/8250/8250.h      |  1 +
>>>>  drivers/tty/serial/8250/8250_dw.c   | 16 +++++++++++++++-
>>>>  drivers/tty/serial/8250/8250_port.c | 12 +++++++++---
>>>>  3 files changed, 25 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
>>>> index 77fe0588fd6b..45e13c3a8c14 100644
>>>> --- a/drivers/tty/serial/8250/8250.h
>>>> +++ b/drivers/tty/serial/8250/8250.h
>>>> @@ -86,6 +86,7 @@ struct serial8250_config {
>>>>  					 * STOP PARITY EPAR SPAR WLEN5 WLEN6
>>>>  					 */
>>>>  #define UART_CAP_NOTEMT	BIT(18)	/* UART without interrupt on TEMT available */
>>>> +#define UART_CAP_RXFIFO_EMPTY_READ	BIT(19) /* UART needs LSR_DR check before RX read (TDA54) */
>>>
>>> IMO, this define naming contradicts with the comment because you 
>>> effectively say "capable of reading Rx while receive buffer is empty", not 
>>> that it needs DR check before issuing that read on buffer (~ named exactly 
>>> opposite of the actual meaning it is being used in the code).
>>>
>>
>> I echo your comments; the naming should reflect that the IP does not
>> allow reading an empty FIFO.
> 
> I now recalled we've also the pending RBR -> SRBR change:
> 
> https://lore.kernel.org/linux-serial/20260908141524.20302-1-yang.yicong@picoheart.com/#t
> 
> I wonder if a similar thing would help in this case as well?
> 

Thanks for this patch, we are using similar IP but not same.
Let's consume above patch and revert.

Thanks


> I understand this patch covers more ground than the SRBR patch but can the 
> IP used in this case read SRBR without aborting?
> 


>> At the same time, I am thinking, reading the FIFO based on the
>> UART_LSR_DR bit being set in the serial8250_clear_interrupts and
>> serial8250_do_shutdown functions.
>> Do you see any side effects to this?
> 
> 
> 

