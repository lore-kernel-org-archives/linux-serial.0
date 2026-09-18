Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560DA391513;
	Fri, 18 Sep 2026 09:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789723774; cv=fail; b=GUT4+R6vUbTAWTaqRSjCG5FYhdQT/GS1WfDFyIAWi0QYDg3IYdMXJG3Dl6WrPKfFq0tO1gdGoCOYx17TDipIIHgFWwl+HxNQrn7eu68eB2dnZQEmEqt+Fw/iejgwPMfhrUCTYx6gV36hlN+oSHqSTA2yGjotGCrkH3Ykys8mz94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789723774; c=relaxed/simple;
	bh=oGANuh2m+ivVurPsPYpIGg03fMSSG4jUncWKOkWzwkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZS5Q7Si5vLVPAB2KPAzOmHRngGCL/AFMdDfNvRmv3Jqn47BUzBfSn8Ccfy5lj9N/kw6zZORWBYDnySrp4d3lAxSpGxM317Uvt0cveOpQ5ARTnq1WfK3K76VmpOQsSrDaRX9oyu46+07WwyvQShcEgK6aMtLOykr+UH9fkeAfTUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=J8oIUMF7; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RircnxOQ; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="J8oIUMF7";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RircnxOQ"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I74I7v3917794;
	Fri, 18 Sep 2026 04:29:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=WIxnhf1WwM7+IR+qIMFpRbOrnRbkdd24fA4WVVXfl
	Sg=; b=J8oIUMF7bMwN8y3hd/eWsCe12adldrDEUPPhvP9cY7CgfLWpLTdDpH+t0
	JpiXmljg3zYGmTA3+aDyykU0mA/o/yQ0S74ND3r8VeOTNP+8TX67jKtf6vdCDU3f
	FR1mWz0LxH2RAattx51I0htCuO16nyQDejUUeyI98QVyGkSroC4zVrlStbxsoJ92
	M2wRUlga0IZoG6QyoA1R017AcpnuCdGQn2kNOGxA3R26mYwexM18dWUzCyRzttPP
	Twi5n4onCSe4evI0pzGq32xKk8e71Z017MkW8uOHRYo8nb7rl9zZpMKBo+qzicWe
	AUicva4oahM8HAPfkAscIYNJSbx1w==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013015.outbound.protection.outlook.com [40.93.196.15])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gs0k38qv8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 04:29:29 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M62ptnFzNxfKqEv4xROaYFGCKCeY33u8oKM2LzCHe5vlugUz8AzMalbXeGsDYvJP1+vWNyTbskfc1fuN9h+jTWzDoLPKL3bl7xTx+k1XEQ6bPkPjDyXEkirY97DKYK6AmfEwsZ1ZEUWdDosZ+HLqe9Mn62YXp4hJltCwBDjrfD3MbFDhy70qwELKQrPrV3OYt7LWgGnPyeRR1UvMQetd82LWZaaEO3bAuCmQnKSQIyk0JqXC2CJlm+tIBcrxv7aUnGCw+rAe2XzGJiF1OA7MKswaUkNT3/3OYqj/si3UOIHGY8O1JnP9PW8WoL/J+Wf5NtWU5pNo3Oki0J7vv+akLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIxnhf1WwM7+IR+qIMFpRbOrnRbkdd24fA4WVVXflSg=;
 b=x/R5ud+lncxc+fhXjis14ZDXph9ZQfm01U5KKxAoPY92vhROTiGajDUgXp1mD+AgSeC0B2VU3dYfF4Y/KVZfIw8gcVwtQ73Mm6Pao3OYU1byjp5oNFD0N/l4TFh6WZP4YcRhhms4xfHTFRAAj1k7FH2R3gLejZGmRe4buMH3YD5C76DK0Z+K4GxJ0VCaXENOIIoXqWYBvHTGaWMdrWxRnrP6OvvHH7Lid830VVR1sGIM4erFJ1cKZ49w7h3zmyOHT7VE0yhhJMnpqK8SeaUk8R3GXfYvxBaoUcfwsGzFY0cE28+75Dlg+StJeKw3zUsAlr9eKomdnyfWmWJEKgDpUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIxnhf1WwM7+IR+qIMFpRbOrnRbkdd24fA4WVVXflSg=;
 b=RircnxOQmoGrJ4o4zv2G+XPYQ+4m6J1adLphtnNNBxDbsJog5hwzUZQq9LpggYIn9ARvKF1dBbVUj/LMcpntqV8hPzd2IuAZ9uuS8Itp8qSHAeql6FsEOfWxnZRVun/zJDNeSYdX6NQoom7TYM6JOMu5wGo4I0tLCR7Ux62Xxl0=
Received: from CY5PR18CA0023.namprd18.prod.outlook.com (2603:10b6:930:5::19)
 by SA1PR10MB997652.namprd10.prod.outlook.com (2603:10b6:806:4b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Fri, 18 Sep
 2026 09:29:26 +0000
Received: from BN7PEPF0000009C.namprd04.prod.outlook.com
 (2603:10b6:930:5:cafe::1f) by CY5PR18CA0023.outlook.office365.com
 (2603:10b6:930:5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 09:29:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN7PEPF0000009C.mail.protection.outlook.com (10.167.248.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 09:29:25 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 04:29:08 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 04:29:07 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 18 Sep 2026 04:29:07 -0500
Received: from [10.24.50.20] (moteen-ubuntu-desk.dhcp.ti.com [10.24.50.20])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68I9T5c61460608;
	Fri, 18 Sep 2026 04:29:06 -0500
Message-ID: <63d8e4b2-19d0-41d1-bb44-d7a5b9963790@ti.com>
Date: Fri, 18 Sep 2026 14:59:05 +0530
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] serial: 8250_dw: Add ti,tda54-uart quirk to skip
 empty FIFO read
To: <sashiko-reviews@lists.linux.dev>
CC: <devicetree@vger.kernel.org>, <conor+dt@kernel.org>,
        <linux-serial@vger.kernel.org>, <robh@kernel.org>
References: <20260911092529.306082-1-m-shah@ti.com>
 <20260911092529.306082-3-m-shah@ti.com>
 <20260911094123.913011F000FF@smtp.kernel.org>
Content-Language: en-US
From: Moteen Shah <m-shah@ti.com>
In-Reply-To: <20260911094123.913011F000FF@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009C:EE_|SA1PR10MB997652:EE_
X-MS-Office365-Filtering-Correlation-Id: 977e7f60-933d-4f7e-f215-08df156754de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|4143699003|56012099006|5023799004|10067099003|6133799003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	n9p5qlUgs/9Yy0aEyw6BMDlGp0J758XGFJeEblcLFNv2efqHOsya4EDhvBulMKV2sDKtlhdahuCkux6JoRKm06ssDaJ8o/63hXVKkDRCNjgzvaJifUujUEClJhIV5A2yQ56YBKpSIqbEMTqxdm7DnL8OnG9Gb4addrwgUp6aX4zXB8FnKsdq3gij06iAqPVQNRm+tC9EwsAHDf2bB2nQd8QVMnzYI4U4kFeCiQ6iySvhvS0QRgb7zwlYIhBh1AcQQMi4UxtovlXx1SvRbSb/r4YNXrU8oB9wByv5ZWIbY1bQA4jb9lTj03bFWC6pV4537XHMQlgaDhJaaPr72Wp9JpaSP+J9Qik6OVLL/uNIk0unqU4lB5hrdoROPF5N+2/A4I9dxAhh/TT6nl859chG+LtvUSkIv3BKGXtlST5GmFi/BiqxhaF3M93YYXrEJUblEbxI92yK0SlFurKFhxA7iNh2zf3+NyD+Ij+MfQtsvaKibe94ePfiBu5CkOoj7MfhwnnOynZUqzceLE1CtvF64vpiLjCcJWgDWSG6QSwNwQt0rVzgdIxB75QeJKeYYNiWUkFuYASKfEFl8x5CtB9ScbS8NvK6ORvlxMUfB/CKRem4MMx3XFKHjtm9h9np6Y9lC+g8JVUPtZxQBIVACUytXneTD7MgmmUJyTjlg+X2l21zn+Hxs+Pl4A4hx679ZThiZsX6A3QoRUFmLoa21nAfuQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(4143699003)(56012099006)(5023799004)(10067099003)(6133799003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IwVpCKsq0FGNqESogvUA2aQGq6adBPOOuOTDudG8SIaQ0FUYax8lQkLU4DzF14WqZjpg78cy79B4UEKDC8AFA1jm5sHsaNGtzfflEcFwpKAe51ls8RsKVLrNM+lZjOSZ30/eAvNP6ibxsJYsTqyMN/l1rV/XAgy+bl158gueHI5YcVffi+vafOT9Wu1+MWgYOG8i3Zfyp1FyrWDUIkmkhnXop942It2OW68e6xZfCUPjeBNGgqS+mXKRryl2wlLCNdfwA2skMhp+873ewlraaVULDoqLDkoKMydBR+7fCTHq+rIRefJJ8RHlhg1R3Rs1nSS0tRlkYkGa94BI4Wgx3lpouN6/OFfQJFahmR3sjodUDZJQOT2GgDsBpY48GdpwdmDFcVpjJi3nfZGOjN4jcz/WrQ95gcxpd64Ilrl7T0Rga56weBOTAvfU7SHlQqLL
X-Exchange-RoutingPolicyChecked:
	xdX5g0RwbduPzzh1py8zJjbXM2wcWn2GC75p1ZQh5avUCRIcVbsCKZKQTRatXlMrVN3BY5YBpR7IqJ5IDl42O9FrAecovSbQoW/9lpjEh5GNq3nisnY9pjl8yUBN3dm0lFcMiDLOzs+cR3ZMtCZPaS/4VlDlQiWgrO51AkgkRdcDNcauANbVvUpO7Bz3BirC6scugKVD0gB058z0qYsJRvMI49Vb+aGaugGX/UaVkUbWhp6b7UmATVlP3BqP8C2dsTynwC81SBTPVl5kH17COhyjLtR0VOQ6IU3lcGcV8UtUDWB36N5y/X8TlZU3754EnO5LYHLNq3mZZhdLTIKWJw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 09:29:25.8478
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 977e7f60-933d-4f7e-f215-08df156754de
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF0000009C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997652
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEzMCBTYWx0ZWRfX//9LaWJcdzMb
 FVYaVcd+ddggz5urfkyzqZFwEva9Ts1FfV/73fqIy9AUVjiJ0AYiVhtsxVE4HP4EXuDWsY0GiRZ
 NenaYL8c//jFOBTsd7I1hXucfyH1OUw=
X-Authority-Analysis: v=2.4 cv=K6S3jCWI c=1 sm=1 tr=0 ts=6aad0479 cx=c_pps
 a=KH9ZsF1Q5Y6vOSsawDVSsw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8
 a=TxhyHGSeAAAA:8 a=sozttTNsAAAA:8 a=TISPNgGIdREmF_lVC00A:9 a=QEXdDO2ut3YA:10
 a=VRTRSrWG77IPp_BSX07q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEzMCBTYWx0ZWRfXyHS68U2RICVZ
 TCD6FINgqUOMHMcq+YifiJqh9tuDOvPwkKHuKN7u+6br+0qBU98ZkkE8VxS9hlHJqkNbZTHOml0
 gY6JbfzsJbM0jfsVYxsZSfjYUwazlFHB9/NVq0Eg3RZ1CcQaTIq5RyX8tfXoZf+saU5FiWPt0J+
 D3WrCNwwIzzbbZyLziwXATHobjXNShQJc7OukRcXsglK7yq9ahc5ORE70+lPRzQ53yBe6orD5G9
 yGklRvWYo6B9Nb1wqmRf83ApfoczamvzxITvVzOly6hEGCdbmX/LAhkLpMNLTeu8r8L4g27ZKDX
 sB/DlmJNtLdm3xRVDiFVLvBnk46G6WxoZvTYCnb+V8b/y9W6bFibgmvyION0lp2cVc5XY77dA1a
 UCEzZ0XCM04bXGCgtcl/3Tqo4bzNWqw/EZqhC1QZFSyzrf90wfoc6Gh+SX1MqgFjl4H0zVe/WGS
 P6vxCF5oxBe+IjVpiEw==
X-Proofpoint-GUID: CzqHRmwode5xHCpnmWJYHRu3_uzZeZ5d
X-Proofpoint-ORIG-GUID: CzqHRmwode5xHCpnmWJYHRu3_uzZeZ5d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180130


On 11/09/26 15:11, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> New issues:
> - [High] The quirk avoids reading an empty FIFO in the IRQ handler, but generic 8250 core code performs unconditional empty FIFO reads during port startup and shutdown, which will still trigger a data abort on this hardware.
>
> Pre-existing issues:
> - [High] pm_runtime_enable() is called after serial port registration, violating callback timing rules.
> --
>
> commit 31fb31567ebe4c6e4b9eb7b2826e35722f3e46f5
> Author: Moteen Shah <m-shah@ti.com>
> serial: 8250_dw: Add ti,tda54-uart quirk to skip empty FIFO read
>
> This commit adds a quirk to the 8250_dw driver for the ti,tda54-uart. The
> quirk skips an empty FIFO read during an RX_TIMEOUT interrupt condition. This
> is intended to avoid triggering a data abort on the TDA54 IP, which crashes
> when reading an empty FIFO.
>
>> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
>> index 51d026f20825a..f97cc3dfbab4a 100644
>> --- a/drivers/tty/serial/8250/8250_dw.c
>> +++ b/drivers/tty/serial/8250/8250_dw.c
> [ ... ]
>
>> @@ -436,7 +437,7 @@ static int dw8250_handle_irq(struct uart_port *p)
>>   	 * This problem has only been observed so far when not in DMA mode
>>   	 * so we limit the workaround only to non-DMA mode.
>>   	 */
>> -	if (!up->dma && rx_timeout) {
>> +	if (!(quirks & DW_UART_QUIRK_SKIP_RX_TIMEOUT_READ) && !up->dma && rx_timeout) {
> [Severity: High]
> The quirk avoids reading an empty FIFO in the IRQ handler, but will this
> fully protect the hardware from data aborts?
>
> The generic 8250 core code performs unconditional empty FIFO reads during
> port startup and shutdown. For example, serial8250_clear_interrupts()
> unconditionally reads UART_RX, and serial8250_do_shutdown() does the same
> immediately after clearing FIFOs.
>
> Won't opening or closing the TTY device still trigger a data abort on the
> TDA54 IP due to these core empty FIFO reads?


Actually this issue shouldn't come up

"reading an empty FIFO (by RBR) will be fine when the fifo is disabled"[0].

In the case of clear_interrupts the issue is fixed by the following 
commit 7f8fdd4dbffc ("serial: 8250: fix panic due to PSLVERR")

I will send another version of this V1 after pulling in the changes from [1]

[0] 
https://lore.kernel.org/linux-serial/ab256e4a-a9cc-410e-b889-f75fb01e77c7@picoheart.com/
[1] 
https://lore.kernel.org/linux-serial/20260908141524.20302-1-yang.yicong@picoheart.com/


Regards,
Moteen

>
>>   		status = serial_lsr_in(up);
>>   
>>   		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
> [ ... ]
>
>> @@ -888,6 +889,11 @@ static const struct dw8250_platform_data dw8250_ultrarisc_dp1000_data = {
>>   	.quirks = DW_UART_QUIRK_CPR_VALUE,
>>   };
>>   
>> +static const struct dw8250_platform_data dw8250_tda54 = {
>> +	.usr_reg = DW_UART_USR,
>> +	.quirks = DW_UART_QUIRK_SKIP_RX_TIMEOUT_READ,
>> +};
>> +
>>   static const struct of_device_id dw8250_of_match[] = {
>>   	{ .compatible = "snps,dw-apb-uart", .data = &dw8250_dw_apb },
>>   	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
>> @@ -895,6 +901,7 @@ static const struct of_device_id dw8250_of_match[] = {
>>   	{ .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },
>>   	{ .compatible = "sophgo,sg2044-uart", .data = &dw8250_skip_set_rate_data },
>>   	{ .compatible = "starfive,jh7100-uart", .data = &dw8250_skip_set_rate_data },
>> +	{ .compatible = "ti,tda54-uart", .data = &dw8250_tda54 },
> [Severity: High]
> This is a pre-existing issue, but does dw8250_probe() violate the runtime PM
> callback timing rules, which could cause a boot deadlock when this new
> compatible device is probed?
>
> dw8250_probe() calls serial8250_register_8250_port(), which synchronously
> invokes the dw8250_do_pm() callback. This happens before pm_runtime_enable()
> is called at the end of the probe function:
>
> drivers/tty/serial/8250/8250_dw.c:dw8250_probe() {
> 	...
> 	data->data.line = serial8250_register_8250_port(up);
> 	if (data->data.line < 0)
> 		return data->data.line;
>
> 	platform_set_drvdata(pdev, data);
>
> 	pm_runtime_enable(dev);
> 	...
> }
>
> Since dw8250_do_pm() uses pm_runtime_get_sync() before runtime PM is enabled,
> could this cause a circular dependency and hung worker threads during device
> registration?
>
>>   	{ .compatible = "ultrarisc,dp1000-uart", .data = &dw8250_ultrarisc_dp1000_data },
>>   	{ /* Sentinel */ }
>>   };
