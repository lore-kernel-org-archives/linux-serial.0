Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160B84AA1D5;
	Thu, 17 Sep 2026 10:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789642079; cv=fail; b=VxcZ2Jt6WTfJxhZU1UBFjnz4uu6RoHRDiJxmGwwr1z2x3xikgVB4v0fALNFAw6p/0FCUjVrMUc1QPDgsk92tVNbOA+UD/O1WjtWDKTfAS/snk6nBgL3XKi+FEftOojgYLENXuKFwyJ1ojICAQa/kPe7DvT3Y12+uXxA1DvegQYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789642079; c=relaxed/simple;
	bh=Hvj0GwkPtYkNPiDz2mEfixwbks1TBi7iff9SbDJ/UYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Pp/TzdDEOX6wEaL2z7MFfBNxVCWA0tP4l3NETs4Wj+x84jtadTJ1OsTPO4P2uHd92wZbm9CgWLxXNcpTvhGa6LleqhfnT8c+hHp02joLSGcV46LdTeLFiL+3CcQYpL7N/dovmxoZi5eaE63jjf37YWr+RXmN71LGdMVnkyMLEYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=D5z2Aa1y; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=w0erg6cr; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="D5z2Aa1y";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="w0erg6cr"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H9b7Cb1438153;
	Thu, 17 Sep 2026 05:47:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=b5EETn37U08oFsh8z5Uo/lk1WlX/VAEcPnZ8xS4/9
	AY=; b=D5z2Aa1yPSelNpRA+YYNDEwd3OLdxfXCpYyfrcO6efQKbPh06IRLz/d5b
	tkmL4hSkodOj6r7WigzLb+TTABaUpXpalHxoRwO2O8/BZp316opIaum5MySRb59x
	qZRf6Tm6vX5BQRQbQ2xxbC32lnYHZvaAz/LJu5yCdBCjEYr6XzFXhdfFbU198n21
	zoEJQkeceq1ra9U+LGcweEsQq8q9xqty7qvzUZqkpis1wAVQS8rtoSVAvNdulhTa
	8C/2X0dLpo/BCxS+VYbYU6G04y768Mw2t7Sq2VRp/SnsZ4JID508M0ZOdlIRudTM
	t5jSMbp+zvvmBhKyDfFDYo63X/j/Q==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012045.outbound.protection.outlook.com [40.107.200.45])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gr4wnkh9f-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 05:47:25 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SXgsyA9XxvBEDPiumD4lT5n6LA4O+PhX+VeU6EeLxIzh0J42xLmPEwuJj7KotuazdOVn7QmR/GMYfYzV3X4tW+2+PazFEBM0jJRpvjO06Jd38Vnhv+UxWYuWqeY0BrO61aX4gav7O5xs9U3WqR1hUaGnI2IdZiC55+GjCkndV5Lcrisgn43JNGZ2ZtKFG/QysVTbXpDVPdxYE55wtmPucHhoAgA8vGGT2RDhog+pb8xQ/tijbkGtG5vtVfpgORuEHRdzKPbWAv4XONN77oQA4LInXCVedTuCmMjyNlSgN08q6e7S79q4EBQLbagcNNeDHLdIw2NGfChy/g3phUcRsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5EETn37U08oFsh8z5Uo/lk1WlX/VAEcPnZ8xS4/9AY=;
 b=AMULO8LOImkFxhJxUxHYmB2VJZF2sKY99Jtd+cZ7wm9bNDQaWQAuYMvVc2owyAHBsSTRgjjPqw6gDoKT2UHDDVbtYSaxkKPxC4AE6PBawMBNfvijpsH388Empxkz+L/3GxjAMFNoPtB3cjpwKQMhKSFaemxTXxiaSicso3cvDrgIRy/BqXu3GgqJ2W3bSJWlIQj7Jl3dmOMl/eYvXQVnJH4MK513PRqkRQJYLdHlwgfM6YeaJ+7phog8/jV6FKC64ZjBILKzlZuWa4OmtfHQhIR1L3xdp6hsoXJ3FCCHZG2jLYDSuheDO1jV9Rciu8itrDjq6tBYC6wxSNbjf3IeQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=picoheart.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5EETn37U08oFsh8z5Uo/lk1WlX/VAEcPnZ8xS4/9AY=;
 b=w0erg6crxX8La6TDVODcAbNWtGy0tEfYf3d6Y2HCzM67XYka+jDgKNUa/RsPrwGg19UrEap15l4Kk3LWTxK5ARzzxXAx1UA+qXM2ZHppEbHhpjmljgtd4kIQHNsEwL5IkvpzkwyHyoDRIEsO+dHcwz2Hjg8NLQKpXpGd7JQMrIs=
Received: from DS1PR02CA0018.namprd02.prod.outlook.com (2603:10b6:8:44a::16)
 by SJ5PPF7F7BBD994.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7ae) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 10:47:20 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:8:44a:cafe::78) by DS1PR02CA0018.outlook.office365.com
 (2603:10b6:8:44a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Thu,
 17 Sep 2026 10:47:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 10:47:18 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 17 Sep
 2026 05:47:06 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 17 Sep
 2026 05:47:06 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 17 Sep 2026 05:47:06 -0500
Received: from [10.249.135.178] ([10.249.135.178])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68HAl2eM2852860;
	Thu, 17 Sep 2026 05:47:03 -0500
Message-ID: <52822f65-58c4-4def-a1b6-e37055d4c0c6@ti.com>
Date: Thu, 17 Sep 2026 16:17:02 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] serial: 8250_dw: Prefer SRBR in bogus RX timeout
 workaround if available
To: Yicong Yang <yang.yicong@picoheart.com>, <ilpo.jarvinen@linux.intel.com>,
        <andriy.shevchenko@linux.intel.com>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <geshijian@picoheart.com>, <yangyang.8776@picoheart.com>,
        <yanligen@picoheart.com>, <u-kumar1@ti.com>
References: <20260908141524.20302-1-yang.yicong@picoheart.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260908141524.20302-1-yang.yicong@picoheart.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|SJ5PPF7F7BBD994:EE_
X-MS-Office365-Filtering-Correlation-Id: 13e1d26d-fdfd-4def-43ee-08df14a90bde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|23010399003|10067099003|56012099006|5023799004|13003099007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	PzHi8fVmyaUSxtbyZzExSdotUImbD30jsYDy1fDQQLMCFK8LeMnIksFRmGqETmHNhBVUhdkAG2XModdf0EWuO8Pbws6DV8ImKpzr05wnHm5wy+eBI7dV6hSR1h9lZyFIUu5uqG+VygVBYpxQENiNF7TFlCDRaXPN3Ka4E29nXC5ST3sk/SQqR/XLbG5EGX6IGapRMKE8qgTgC8xzPpJUHu85jBIkqQw5HQYW3iUTdq9UVmMBJP8+lIQ2/vRmPO1+QgqG1Xw6rwOoZ/9h1H2JpP098Q4wb2oDCbRAEXFIwKtiEAOs9R9XMrcwOsWI2/3uSzjUDgIzUlhbhzFedvfZ9Ap5X7hDfbjMHikgQ3Qc4aPpiE43HNR7H3MW+rxW5F+ff5+73yrGP84Xb8IOGM9FVkLLqTHyj/hdOCS2ZfvGV4rBeEfzAfU/xgzAqPInaDwoOjSvM5hVK4y96iWTqRKYkD4Z8i1p/9UnEC6g6YeeucUB6mTW62VXnYDTgjhndfYGN9IG7e6at0NoKOt1CV76u6lCutYqRAtVKpwcjzHZAsOXJOT0qb05cLZo01YyR8kMiIH9OuFl4cEF0SC9c/R8O4CBICSEQfXsNikJg7CpBsQXTp3R/kIyB4Es0urYWcr1NQ7E4RoSLhEfLEJsIpBB0A==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(23010399003)(10067099003)(56012099006)(5023799004)(13003099007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MhFCPN81u2RK2jTUDgZEvc05jN170j6yNqAvQJOF9xNbDNr1RrYaXF66UGExaeF5nIXphayW1BI12aWRBZTfbObs0KtNuICcxPsEAA8f59ZCZBb650+lLLOJB3RATz20XFFWmTImudNgV/sHl2W7d38LQGjV879qU2uctcaGFV9mEO6jtE7fPoZ1HjgZ2gq31ADFrNLGEphOUESTJl3vWVwccDa6dFaaoGXLjHl5FyIjFrTNE+BfI1v3WdTz1VluuanfM+/8A0su8vPB7Cth55x03ZpXeqoXwHePRAgZ12migcS3Mf+qrtnGBEOXI/iU8KvZsPNYTFQs+xFD6buYBfWzKEg8Bbw9FgnjufV67FUmRZy31dltyyC+ZWWva4yM/jYcXrJQwquy9ZgGHgryvsnSFLCsvOLzS75HueV5I/1ZtnQMmGaqr4b664Nt/Q2S
X-Exchange-RoutingPolicyChecked:
	i1dAfEWAqhtmKITP/aRV2+wzNBoBH7M02iRoSjIqB4k8LD+EwDf5QVRbDsSbSxzmrD1zUlRE6gnnyyRFyzA6/Hc/38SYxnvV7MH6D6KFOW3b9lJoYj6gFWuiusA37EeHCdgTHQWUvKFJYV2kf4hGGVRpKciMbL+x9GI2fFmDqvxx/dtb/SlLSkxdbBKBst/ZAF4e1v6C/oC9sZStl0xqC9Xpb4OomOBs+NICWI74tvxoFUalWJgFlro9+CB4IQ7T3sJKfZ5l2RJyHNS4gYMY2b/XCLuKTdS80YIyuufO5GdtuygQEKq3EfWIOQKa/vs2F54rZDKadiHoatusmaraWw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 10:47:18.9622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e1d26d-fdfd-4def-43ee-08df14a90bde
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7F7BBD994
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDE0OSBTYWx0ZWRfX/GEeP5KCLS1h
 SCSkuuh7vUUbeaNL8Qc+bHn3LW29c5ycUb2R3T763Oyd+h10EIsEATO8dcZwO9joZeyHiI7MwxP
 9jNK/DkzjUcXrkSDo9ywV2RJoIPSbkE=
X-Proofpoint-GUID: z_cCs1R1ymnppuZAS9DE5ATR_DLzdKir
X-Authority-Analysis: v=2.4 cv=OPOyTiaB c=1 sm=1 tr=0 ts=6aabc53e cx=c_pps
 a=HkOkC5mvV7OaefGfpXsf6A==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=P-IC7800AAAA:8
 a=VwQbUJbxAAAA:8 a=TxhyHGSeAAAA:8 a=uPD2TSSiCoa6FW633DMA:9 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22 a=VRTRSrWG77IPp_BSX07q:22
X-Proofpoint-ORIG-GUID: z_cCs1R1ymnppuZAS9DE5ATR_DLzdKir
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDE0OSBTYWx0ZWRfXyLKw8bJ3Q1w0
 Uw79sD4VKrpBty39XcVfckzaVxWq5X2dmOJrnLLu0QS+biqnOfM5G4tXh1iM3jLkyhnrWWc+eva
 pwpMzF0HrTRhkNYeEiFWuDhRThfpvbO5iscgMHOfrr5fGjHm1jQT9TNKwB5Vtd77OF8v3FHKHMD
 bwQE3IfRB8JIhNNwGOGDPJRgZexokhdAf59PuMWhsWhC3rdSr3CTU081IqoD79jHRK5L0HzK0A8
 4c9y2mNAAOaxfN11qLSovwB21FaEL9ZWjrniILOWeks6xCtsKZnNcEzmVveP/ypGtHWt0p36akk
 aKB36eTy6/lsUdhUDmr9u5UI2S4E83lXnCu0Z4IYg4FfeWF1LX6kqzJ/GlCDqlXPPWeUlqOmEyR
 TadIVlHyfPKhhW6wgutRa8rYndDf1kdci7sh9r1NkibKLGCCKBgNNXvHFrl6EMYpCXRgtEZKDlu
 B9N1vvAFHNdMjVMwXUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 priorityscore=1501 impostorscore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170149

Hi Yicong,

On 9/8/2026 7:45 PM, Yicong Yang wrote:
> The DW uart could get into the cases where a bogus RX timeout
> interrupt is asserted but no available data. This could be
> workaround by doing a bogus read.
> 
> Currently the driver's using the standard RBR (receive buffer
> register) for this bogus read. However the reading of RBR
> in this case is allowed to raise a hardware error if vendor
> choose to implement in this way (our platform). It's also
> allowed to do the bogus read using SRBR (shadow RBR) for
> workaround which won't raise the hardware error. So change
> to use the SRBR to workaround the issue if it's available.
> 

Thanks for the patch. If I understand correctly, the IP you are using
does not allow reading an empty FIFO, so you decided to read the SRBR
instead.

Does this same case applies when you open a port without any data in the
FIFO:
https://elixir.bootlin.com/linux/v7.3-rc3/source/drivers/tty/serial/8250/8250_port.c#L710
?

If yes then I am wondering, how the condition mentioned above is bypassed

Thanks
Udit


> Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
> ---
> Change since v1:
> - refine the comments and type per Andy
> Link: https://lore.kernel.org/linux-serial/20260907074035.77796-1-yang.yicong@picoheart.com/
> 
> Change since v1:
> - simply the workaround path per Ilpo and Andy
> - run ~48k reboot tests and didn't reproduce the issue
> Link: https://lore.kernel.org/linux-serial/20260629075510.32854-1-yang.yicong@picoheart.com/
> 
>  drivers/tty/serial/8250/8250_dw.c    | 9 ++++++++-
>  drivers/tty/serial/8250/8250_dwlib.c | 5 +++++
>  drivers/tty/serial/8250/8250_dwlib.h | 5 +++++
>  3 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index 51d026f20825..b8a0bca8b536 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -439,8 +439,15 @@ static int dw8250_handle_irq(struct uart_port *p)
>  	if (!up->dma && rx_timeout) {
>  		status = serial_lsr_in(up);
>  
> +		/*
> +		 * Do the bogus read from Shadow RBR (SRBR) if provided.
> +		 * Both RBR and SRBR are supported ways to workaround
> +		 * this problem. But read RBR can cause hardware error
> +		 * (PSLVERR) if hardware choose to implement in this way
> +		 * (implement REG_TIMEOUT_WIDTH to 0), whereas SRBR won't.
> +		 */
>  		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
> -			serial_port_in(p, UART_RX);
> +			serial_port_in(p, d->data.srbr);
>  	}
>  
>  	/* Manually stop the Rx DMA transfer when acting as flow controller */
> diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
> index 8859e66d2d71..9bb02a4ab11f 100644
> --- a/drivers/tty/serial/8250/8250_dwlib.c
> +++ b/drivers/tty/serial/8250/8250_dwlib.c
> @@ -247,5 +247,10 @@ void dw8250_setup_port(struct uart_port *p)
>  
>  	if (reg & DW_UART_CPR_SIR_MODE)
>  		up->capabilities |= UART_CAP_IRDA;
> +
> +	if (reg & DW_UART_CPR_SHADOW)
> +		pd->srbr = DW_UART_SRBR_0;
> +	else
> +		pd->srbr = UART_RX;
>  }
>  EXPORT_SYMBOL_GPL(dw8250_setup_port);
> diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/8250/8250_dwlib.h
> index 1fe52332e774..ee7a07fac0f6 100644
> --- a/drivers/tty/serial/8250/8250_dwlib.h
> +++ b/drivers/tty/serial/8250/8250_dwlib.h
> @@ -13,6 +13,7 @@
>  #include "8250.h"
>  
>  /* Offsets for the DesignWare specific registers */
> +#define DW_UART_SRBR_0	0x0c /* Shadow Receive Buffer Register */
>  #define DW_UART_USR	0x1f /* UART Status Register */
>  #define DW_UART_DMASA	0xa8 /* DMA Software Ack */
>  #define DW_UART_TCR	0xac /* Transceiver Control Register (RS485) */
> @@ -90,6 +91,10 @@ struct dw8250_port_data {
>  
>  	/* RS485 variables */
>  	bool			hw_rs485_support;
> +
> +	/* Register offsets */
> +	/* Shadow RBR (if not defined RBR will be used) */
> +	int		srbr;
>  };
>  
>  void dw8250_do_set_termios(struct uart_port *p, struct ktermios *termios, const struct ktermios *old);

