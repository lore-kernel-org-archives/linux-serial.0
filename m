Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3830E3009F2;
	Fri, 18 Sep 2026 09:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789723448; cv=fail; b=b8gmjLbmYyha19T9D3RpPKeer4YlamJj+di6a3sLJuj8sdEMZmkX316nv+cIE3qQUOHx0wBbH6EBmj4Y3gRxSOaC9ptHFopxYQXLdjI9jDwogqH2pGbJOxn9hOljXxWuwG9zMJDVjwl7Q0XEfrI+8Mz6pKlv3zq2OY66kySyhD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789723448; c=relaxed/simple;
	bh=UEYSiLhVRCIE6e2/GDvOn8Xc9zgvF65wP1ZosIv9F7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=R7ME04Og9PkD99poYrC/cs42de6kGTtVNCV7zQdcmK/90ZJgF1810hIRcInrom6RgoPnl4H+mYQiELUYySH55YV9n5TkbSLrqSp8EhLQol4jWTnRCpmj2ngISCFJKgGPLP00016TuiGlYhz4QaQ9UAcYzd1Hya5r3JEOlGd5rYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=MDNIQUKH; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YkmyImNf; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="MDNIQUKH";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YkmyImNf"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I7itFd3538809;
	Fri, 18 Sep 2026 04:24:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=sEMyelgVdtiYO9rr7K1ETSN5WDlVQ5LSMWn2T1vDO
	nM=; b=MDNIQUKHPvlOD+C18vNHfdrx/fwJIN+mAW1COBtDFv8lIujsm25JswCjW
	YlEykNqfqHSp4JyMim381OxBwTRM240EvpCKBjZVgGw3Kj95LH6LbdY00AXa7Ila
	AQLxUmPH6CT4B0tvXmlJ9T/uKeksR7geI3YA0rigzAOlAXoRdWrdVNtcpuRS2KD+
	X9P4i+wLWaxpt+cOoiUDJhA8tRqQ6f+jB/d2LOJZQyJ9ynZYyyQz5QkVTBd5GASl
	qQ5J+cctgRuR3cwPIo1luQynsyfDF9jLGB6cNkhk4rtwdsHKsd6Gtjjquvywfysj
	WDVEJRtLx1rM3Z1ClhCuBl13a2dxw==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010050.outbound.protection.outlook.com [52.101.46.50])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gs16cggpa-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 04:24:01 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcgWuvAIGGRcrS+aHWdmXi6tCETONg6gENa0H64HZkGMNtpJDY50pT/3AyhirEJamz6DFJStEcccVke8oOiEXJPNsjZYGkBUzebupFGLtwWRh5HsAamLfLp7+nUf7lnTXMmLTu2cieFPp2MgOij+AZHS8+SYKLYZ+y+ASMRL5iekqiH8Mq3gXpyPY6se2kwKjB1MHwUVug1t+d6W6LyJH/4i7FJaSqmQ3KLy0+tZB70fM0MAynncQ76OWHMHe3p0y20NE5+wKIYoJCyhOHKhIxWiVgCvmYL0Dbi9PyA9p1YmPu6cp8LXl355b+XK33lm8kng7ytP8nO8lVWRQOUR3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEMyelgVdtiYO9rr7K1ETSN5WDlVQ5LSMWn2T1vDOnM=;
 b=E8XhCJFH/ipIQBil0aB//TgwuBJzj8teN55aAbFeMMk1DoOC/tL98kiwPOkMNvQMWF+0u/TjJBfsY0u0WwU1WwLndsfxkJBnSlS/sIXyaewu7JNMejYIUhrsh1/Xq7rXV7EqxyGLgJg5gdV7GmRkyKq+HlCXOKjfjjULYNOOUnIeKhscH2Xfqa526DsZFvT1Ud2ct+H6b+sugm7ss3wkh+q1esiqUEHbskt/mSXYklzBgYhJ7hLDL87vDx3bzjAH2u0p6GFxorFJQBOWYXWXyYf4oAZ2ggb5MDBVekqDM2sVTdkfxpBcVdLEZ+Mw3d3WE9MK9zhGb2c/usu250+SKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEMyelgVdtiYO9rr7K1ETSN5WDlVQ5LSMWn2T1vDOnM=;
 b=YkmyImNfor0dmNRH+HZnyW4pKGr/1ISP5It6kvrWuAZZIop+5a/lDm6jkM9cO6chyhGiMCt4udh23CYIMaFOrq9swTWwaH/BsiTmFQaBxr9Bbz5LdlvL42cNVXaz91dVvajg497VIceFwj8T4Ecvx3YPPBI0kzUqqfYAAOuxJ4M=
Received: from DS7P220CA0071.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::18) by
 CY5PR10MB5962.namprd10.prod.outlook.com (2603:10b6:930:2d::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.13; Fri, 18 Sep 2026 09:23:59 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:8:224:cafe::aa) by DS7P220CA0071.outlook.office365.com
 (2603:10b6:8:224::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Fri,
 18 Sep 2026 09:23:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 09:23:57 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 04:23:27 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 04:23:27 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 18 Sep 2026 04:23:27 -0500
Received: from [10.24.50.20] (moteen-ubuntu-desk.dhcp.ti.com [10.24.50.20])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68I9NNC41454391;
	Fri, 18 Sep 2026 04:23:23 -0500
Message-ID: <307c005e-9a37-41cc-871a-6167a54d3a37@ti.com>
Date: Fri, 18 Sep 2026 14:53:22 +0530
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
        "Kumar,
 Udit" <u-kumar1@ti.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <krzk+dt@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML
	<linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>, <devicetree@vger.kernel.org>,
        <gehariprasath@ti.com>, <vigneshr@ti.com>, <nm@ti.com>,
        <a-limaye@ti.com>, <y-abhilashchandra@ti.com>
References: <20260916085520.2259420-1-m-shah@ti.com>
 <20260916085520.2259420-3-m-shah@ti.com>
 <5fe0efdf-6d61-dba4-9703-269dfd68ae13@linux.intel.com>
 <5801b899-8090-4bff-b4e2-c3e8c97b0eb3@ti.com>
 <d82f9326-6a01-2903-a1b7-b1617ca85db9@linux.intel.com>
Content-Language: en-US
From: Moteen Shah <m-shah@ti.com>
In-Reply-To: <d82f9326-6a01-2903-a1b7-b1617ca85db9@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|CY5PR10MB5962:EE_
X-MS-Office365-Filtering-Correlation-Id: e3c5b653-3efc-403a-762b-08df1566912d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|10067099003|4143699003|6133799003|18002099003|22082099003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	gBI6uqpRDDWM650vtGv/eKsfbJ4rGWf4KqOcXmbo/n+4xFxa5H6iE9+vfl2Hn5IYDNZyWbEuDd4iBdNNUjGtvCVkW+N/OIbujonbBP/xhRVlchcjX/leUCBPQL5IFcKF2csyo/Tv2RknEq5k5sNXhBSVUcU9Z2OWSN5srd+os6a0IMDRcXq3uJ5tSDDgCZL7z9dm8WlDXhySJT7AZt13zFulzEg4hnFTQo3X887kZG6OfEg38KaGmLLA0+kvxoJyrzzEd9un7qWAig5c1zCVxYXItffdaXr4bUl0KD4xI+DuYVEbtzNni5jVkKYlyryGmb4ztt5m8uULBmaIBiCy5s+I9+4WoI4A2J7uQcS0qfykUofp5D+7PGIU4X9LbJzYHi//pfFd/uz/ItOILa53ixIn2rQ7qhIkx2Y4x8zrzsXzLwYHCuY8eiVFtzlKtOA72TI3buJU7JV9g53panTNTxlOylyTfVIH46/b8TRJ09FDVy57lBDGBEW89ZgibLdW3nGA2qCDXbvSXK5t7ZtpwHBMKRzWIA9vWwlyEdqt764OXDCuKF5MTNovwhztP0nZiPLsnrnBht6TlCmCwb+GtBT2ERO8eU7obXYSyms9KyHGwhSg+Pzt0saMH0IqYUdY16dnxJJNl67zU1mXsK26bw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(10067099003)(4143699003)(6133799003)(18002099003)(22082099003)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/pu7nsHJ+OZ7BuDjtrlPKk2GAaGlYstg0C9aQNJNtoL9YUvI4dn7nKjho3ZsNYz9M2oPwQVHcfNiE4zY7aJbyizurGhSZNRFjq2D51VuhioTvo3OdJmYGFBWen6XWULcMKHS5R7FBzGgxvDFP9bLqYA/8twJH2dOtaBPhQKWrhSNzskLCJpzm5a8knYv+SZN/XQEFAmvS59lE6N7aZeIkiIrajKsCtgX72xNCpwFbLxCPzsssm1n9UPQRpWDrQP8NQ6vG3pwFq37S+PglhEn0Gy9n0GicWeSOrSsNwQ7R2J99CnK6zeQmdreA4iJFRa8rmmchWhqY/Ggj2Jfi6j72/olYrmaoyJTURgJA+IQOjYZFnMzvOxLk1x5u5xcPaT11Ge+5wWJ38nKwCAihcymARBK95Px9d7Xxpa20gyb3H6Xqlh38AOAxVFVookErx0B
X-Exchange-RoutingPolicyChecked:
	AD3HVMIpTIqTqIAtU7RQSeB6mwuzm0Y2W1puewCcB8bqgfwiB9WKl3DRC/iDejW66iGQozZQVRgcVnSyXb/TMAdWbVILXHPbzMT8bjFNadJ/jPoCW0eFQGQOANXXQdsrYvukH3p0JUeH9D/lpv6HrUEeCzH8I+Z89oHcT077d0YDzgqakV40DopFuhRASGVX1Xx2ALj3EfWkOPE7RiogeW2joa7RtQOoYqM/cXFpClGSYE1h9GXdq89BgXer2Lmcz/NA80NBNCDMVwYxQH0Y50xUT7scoMjpN32bsJNbhtHoAwQWAbid6UImSIqp9O/qdlrMSWnBoq2erlLd3PcpYA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 09:23:57.5409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c5b653-3efc-403a-762b-08df1566912d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5962
X-Proofpoint-GUID: 20dHoPBeBhZnuBBe4KCHkWw9ULOa0WTa
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEyOSBTYWx0ZWRfX1doM/ONyGFvL
 N9gxzNldDib067T62EX54uxDyTVcloTV0NstWZt6Hoq9Eofsikmr0GM7nKPxkjM+J+hpCXgGxma
 61YSTgaSjGRELvvKESQ034TJB0BpbkI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEyOSBTYWx0ZWRfX9EFtnqRTwcyy
 qcRA5Jp2TRRD1+D+S6gJESmuAQ0TVQkofY7dX2t2dxaLhDZbvZngIruo6qITK943uhX8Fk1fRAL
 u3EgdvlthUKUPFcdkqk4st7QqXNvvuqfwIAx4CFycE+iGS5CfNxiOCKcvVR30Mh5aqyWsSXyuSL
 Ns9HQe+Cz5rpp/CK3f3+8l7UkekCFEvecnBfMoVbPNpNRe75lheP/Ulve/x0dkq8Y/rapcmBIyF
 4/Ou9eqmYFJPrSFJ24qdS3OfoZW3MIu4PZd9O8c/DDE0F/+uY7/tVHkajDxjdQwADUyLrWLWfxd
 blTXaKj2fC2YHm3fFH4vi5Qlnid3cQECdFnS0qAcoMxlW9PlvG3jkUPMRLuC8LKIlw6YPtSrcMU
 DlP38tzHLk9FbDEOauB497K3Se/jE98NmhTLDjKv13FR62VcfgUC+2xkIEKBH4/HcX8ISkZm5Qa
 VtC3SmEhM81W5/dhx6Q==
X-Authority-Analysis: v=2.4 cv=cKh1IVeN c=1 sm=1 tr=0 ts=6aad0331 cx=c_pps
 a=MMVmnpyRbxvAcRc6a9dgEg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8 a=TxhyHGSeAAAA:8 a=sozttTNsAAAA:8
 a=y5ittif9tQIw1IVr7QMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=VRTRSrWG77IPp_BSX07q:22
X-Proofpoint-ORIG-GUID: 20dHoPBeBhZnuBBe4KCHkWw9ULOa0WTa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180129

Hey Ilpo,

On 17/09/26 15:10, Ilpo Järvinen wrote:
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
>>>>   drivers/tty/serial/8250/8250.h      |  1 +
>>>>   drivers/tty/serial/8250/8250_dw.c   | 16 +++++++++++++++-
>>>>   drivers/tty/serial/8250/8250_port.c | 12 +++++++++---
>>>>   3 files changed, 25 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
>>>> index 77fe0588fd6b..45e13c3a8c14 100644
>>>> --- a/drivers/tty/serial/8250/8250.h
>>>> +++ b/drivers/tty/serial/8250/8250.h
>>>> @@ -86,6 +86,7 @@ struct serial8250_config {
>>>>   					 * STOP PARITY EPAR SPAR WLEN5 WLEN6
>>>>   					 */
>>>>   #define UART_CAP_NOTEMT	BIT(18)	/* UART without interrupt on TEMT available */
>>>> +#define UART_CAP_RXFIFO_EMPTY_READ	BIT(19) /* UART needs LSR_DR check before RX read (TDA54) */
>>> IMO, this define naming contradicts with the comment because you
>>> effectively say "capable of reading Rx while receive buffer is empty", not
>>> that it needs DR check before issuing that read on buffer (~ named exactly
>>> opposite of the actual meaning it is being used in the code).
>>>
>> I echo your comments; the naming should reflect that the IP does not
>> allow reading an empty FIFO.
> I now recalled we've also the pending RBR -> SRBR change:
>
> https://lore.kernel.org/linux-serial/20260908141524.20302-1-yang.yicong@picoheart.com/#t
>
> I wonder if a similar thing would help in this case as well?
>
> I understand this patch covers more ground than the SRBR patch but can the
> IP used in this case read SRBR without aborting?


The IP that TDA54 uses does not supports the shadow registers, hence we 
will have to go through the quirk/capability path.

Regards,
Moteen

>
>> At the same time, I am thinking, reading the FIFO based on the
>> UART_LSR_DR bit being set in the serial8250_clear_interrupts and
>> serial8250_do_shutdown functions.
>> Do you see any side effects to this?
>
>
