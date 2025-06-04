Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com [216.71.158.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EE41E5206;
	Wed,  4 Jun 2025 04:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749010350; cv=fail; b=OzFtAt/ObohxFgLc2Ss/dq5DzRfnU1TvmhycnTKMePFkFw6jkPdxazpFNHhINzF6yZMsfC9RqUO+hRsilYLNacdU4D4pvcPyFetJLMKInfcVInjn097dTojO2FbGWdYBg9Jem3vVj35lipw1yLy2GrePKAuoG9hkiJPT0bTbPEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749010350; c=relaxed/simple;
	bh=sugZd5uaEQjT1W5zCgfBOGu7/cPIbGjHpwc37MM3Sqc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rt1z1K3pPCn7fwTsHWZAfSQcPzGSJlvEtk8hXu9/4R0ly8BQFlZWBOaL95FPabaGkSKAxN7oGfR3Mw720THVRWEjCplX7kVwojfkZ9J/CtPse2eC+7MgTarvOh5CartY5bFHZTjCikdgsrbw5FrF4i9RlZppXeQT5bWT+mj3BgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=y2DYr6jA; arc=fail smtp.client-ip=216.71.158.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="y2DYr6jA"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1749010348; x=1780546348;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sugZd5uaEQjT1W5zCgfBOGu7/cPIbGjHpwc37MM3Sqc=;
  b=y2DYr6jAigcrA6m+ayi0TQVfYrCAOmqBwfEW4byfy6w24yU+rxJjrKh1
   k6Kl1eMOnn/iUP3QARoeZSLaZhEDzaNUlEKam2KwYoJouw32FF6ACcl4x
   iCr/hRlNvGf47pibSJ5SsmheHUNrG00zN+z5nJmcO9ElD7fqXAsTDI8H/
   jeLM8pMHEwakZCbqBr8uxlLjpwlwTq1YDjwO4E/i7+rYWIb4qoQxBsZs3
   54lR8jnw+PvkjUXNMOg1OYJtU7An3m5tMvbstAuv5PXdTW0QWows3irrh
   gthQONZSWdcQjBe9H0ri2CnnjYRM5Mvws7b42eVLVF1ME71N0IXqZsDHQ
   w==;
X-CSE-ConnectionGUID: myaBcA+hT8qBIDZA68Q6sg==
X-CSE-MsgGUID: x3PXBVVcSRyjANg/TRqONQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="157543794"
X-IronPort-AV: E=Sophos;i="6.16,208,1744038000"; 
   d="scan'208";a="157543794"
Received: from mail-japaneastazon11011047.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([52.101.125.47])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 13:11:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQ33ztG+PZABQY2rH7ullHRby5Jc+CTJuTNhthUSzCmUqlxYOHYC0v9lFaihu0SSzEM26PBeeQfc/fGRvwDHC5hwSUDwpT8V3f0eKWw2heVVtx6gvCrP61CxKLELV6/y2MfTsN57fcFqjKnzOd9tY7NPxUBTv0cc5e+9m+q8gYvyBBxE9atZYIYta5C7xR24yif2x5IIwyCH68hAaVlb8msxDiLiW4tKDwitUJrpkzK7xZGpCAYQowsQgCL/6YTe7n/vp280AsoE4+eHqZnYdJrlBwjLA9neZc1HEIFpoNnsF/cbuuBoH2S66GJJ+1pkP9EidCBnqwxK0c05O7oIjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVACEDmMwEomIdsjy2ZKr2BnRP2e90i/N+KBQnlziB8=;
 b=wjCh5xlnR7pNmrOMBKe6yX1Tl+spqgT9k3co6OWtodigTvjUHEHs7I/S2x1d1qDBZnD8t39Rju+QJTZcDT2RH00b2duJElYwFxqIzDhpy2JSp/5loSZlyYAdNBYZJqUqomoIee0cbVwkDiEGAMIld70clkkAbCrFxGvs3KPdGB0Un/oSOKtl/QJM2lLx7AUXiu0RraPYJdnwbT7q4nQ5yMz/QVKYfgreCkhHzC1w5txIVnnvm60YTuT9zC8ydCCjfMTsOlFGNht5tp904G+K3SqQ1rrSQtgS4bBPBmRGchyqW3L2g51fcVoPNVkBzXXqDEjpr+KNU11t/0eXnC3i7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY4PR01MB13777.jpnprd01.prod.outlook.com (2603:1096:405:1f8::9)
 by TYCPR01MB12110.jpnprd01.prod.outlook.com (2603:1096:400:449::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Wed, 4 Jun
 2025 04:11:11 +0000
Received: from TY4PR01MB13777.jpnprd01.prod.outlook.com
 ([fe80::60b7:270b:27c7:4fcc]) by TY4PR01MB13777.jpnprd01.prod.outlook.com
 ([fe80::60b7:270b:27c7:4fcc%7]) with mapi id 15.20.8813.018; Wed, 4 Jun 2025
 04:11:10 +0000
From: "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com>
To: 'Michael Kelley' <mhklinux@outlook.com>, 'John Ogness'
	<john.ogness@linutronix.de>
CC: "pmladek@suse.com" <pmladek@suse.com>, 'Ryo Takakura'
	<ryotkkr98@gmail.com>, Russell King <linux@armlinux.org.uk>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Toshiyuki Sato (Fujitsu)"
	<fj6611ie@fujitsu.com>
Subject: RE: Problem with nbcon console and amba-pl011 serial port
Thread-Topic: Problem with nbcon console and amba-pl011 serial port
Thread-Index: AdvULbS8DdGjT9TLS9OOSVhbv2AtDgAN1+gwAALFDgAAAfWTAAAeB8Ng
Date: Wed, 4 Jun 2025 04:11:10 +0000
Message-ID:
 <TY4PR01MB13777674C22721FCD8ACF4FCCD76CA@TY4PR01MB13777.jpnprd01.prod.outlook.com>
References:
 <SN6PR02MB4157A4C5E8CB219A75263A17D46DA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <OS7PR01MB13775FE1A20762D1EA4A38D0ED76DA@OS7PR01MB13775.jpnprd01.prod.outlook.com>
 <84y0u95e0j.fsf@jogness.linutronix.de> <84plfl5bf1.fsf@jogness.linutronix.de>
In-Reply-To: <84plfl5bf1.fsf@jogness.linutronix.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=be343133-71c6-4d99-8848-8967c516ceda;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2025-06-04T01:30:08Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB13777:EE_|TYCPR01MB12110:EE_
x-ms-office365-filtering-correlation-id: 71b26a35-165b-4ef6-c9b0-08dda31dd6a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?bm1wamNyckx1TGh0bzhpZ01Jb0d6NHZIc3JmWVFuelJPUks4Rm1ndGVY?=
 =?iso-2022-jp?B?VEVOYTZhYWg1WDZFRTU4d3B5aW4yNTVpTnBxVWVxK2ZMN3l4UTB4TGgr?=
 =?iso-2022-jp?B?QW8yRUZnWWhqd1pwTFpWdXY3N2V2L0VYOUw3dmptSmJlRGNUQ2YxcGIv?=
 =?iso-2022-jp?B?SmtqeDZZMFhmdUFpRVNPbWNiTTNkZnNVREZFaWFVYXlsZndTVkYzUW5H?=
 =?iso-2022-jp?B?bUxiN1IydFBIMzJ3bFhpWkYzcGp0Q3JYOE1zaWtUdytqaWdoMk9Ob3I0?=
 =?iso-2022-jp?B?Sm5la2pSZnFEMEJNSkZjZ2dRVi82KzlkalNMOUpaeTNmOUhwVURpb1px?=
 =?iso-2022-jp?B?SXgyNGRPNVNsdTdteTFhTFNSK29GdWNUdTdBcU1yZXlMUEFXMzJWNjRo?=
 =?iso-2022-jp?B?SkxuTUxJMExSTzlKSHB3RGVKTk13MkVLekY0cFk5d05oV0JXSnpyUVZJ?=
 =?iso-2022-jp?B?V2lqRTZZZnJxdXlCZ0orVGphRHh2eEw1emNFRnFXS2dmQ0NudDB0dFN2?=
 =?iso-2022-jp?B?QmFIWXB2cWxPalViWHJKN2x1cXFLeWY2Q2oySHVvUXc2ZGlLQkVMNHRR?=
 =?iso-2022-jp?B?bEk4UnFEV1h3Y0VDd3Y2WG9aMUhCVHdPUFFFNy94Y0ptcmlMaExrS1VG?=
 =?iso-2022-jp?B?d2Y1N1dYYy9OaTZ3bkxhMTNPN0lya1lOcUdER3c4L0RLTWExdHJGNDFD?=
 =?iso-2022-jp?B?dUptQXJ4WHJlZVUyRUZkWEZHMXVwcEFhOXFXN3JoT3E5dFJxSVNsUXVv?=
 =?iso-2022-jp?B?a3ZqM0ZZQ0V0TmxJVjdNNGNNS2J1SFhkOTNNUVJNUzkyeURibExNMkRi?=
 =?iso-2022-jp?B?aFA1ZDVKckVhTUp5YkxadVN0akdMc0thZUpKd1laYXhrT09OYVNJRm1U?=
 =?iso-2022-jp?B?MVk4UnhnbWEzN3NZRk9mZzdvM1VoSU83Z29nT1lzQ0FsNm5UYVNCTHM1?=
 =?iso-2022-jp?B?K3kzS21UK0FtdzlDdjF0SC94dWpOclZ1VTcxTzlkbVB6UUhDOUtnQVRq?=
 =?iso-2022-jp?B?dkVaTHY2UTY0WWlrSUFtendoMzFZSmk0amUrTFdxSi9FQkNidGNQUUlw?=
 =?iso-2022-jp?B?dHR3VktYTWlPakY0WGRGR0VERTUzSWVlaUZxSnp3Z0szTUpseGNpOC84?=
 =?iso-2022-jp?B?dGQ3eHI4VmgrNGdnUEhtd05VbEVIWmE3cExBYjljN1JlVU5wSUsxUkpK?=
 =?iso-2022-jp?B?RGhyQ1N0U3lBWmx4aTB1TnlGOS9DQTJITnZQL3JnbUtiMHdQbWZoTi9G?=
 =?iso-2022-jp?B?TmQ5MmI4V0JrYjcweUJheWlkT1ZKWHNxc0p3aVR0aHdkUmZISGtkZzVp?=
 =?iso-2022-jp?B?c3VWbUZIVkFpSXl2Wm1TN1ZZR1gwTW5XdVVibWE0aFVNVkcyd2ZPVW1z?=
 =?iso-2022-jp?B?ZTRmUDNGMWN6MU55TjVxNmlmQlQzUWpONllyZTdDS1BlSnNoVldJSXNJ?=
 =?iso-2022-jp?B?TTAxNlN2YXN4dHFBdUl5blFtOCs0YVEzZzJMQ01oNk9zZHVnYkoyMmlB?=
 =?iso-2022-jp?B?Yng3Z3M2akxiZTI5QklUcFFlUFNkSWk3UmJjYUxGSnF4RjRiZGRGOHlD?=
 =?iso-2022-jp?B?ZTRLbmdwcHJENzlDWFhURCtocUFIZjJ1ZjFTUlBVZEZlenBUSjZHTVRx?=
 =?iso-2022-jp?B?VnhLSnl1MmxMWDZlRElhRG1mT2dzdUI0eWxnNGJ3QlBlaStNZVludVFD?=
 =?iso-2022-jp?B?cWthejkyc013OGF2K08zV1UvYTdxSGRnSTM1bkJXeVdnY1puc2puVG94?=
 =?iso-2022-jp?B?UGcyRXlXSlBPMmNOeXA1a0xDV2VpR2VLREVPNTd1bkdkSmkvdFc1Nlk1?=
 =?iso-2022-jp?B?SlNub0xqK1BxRk5NNFVTWVNYM1RjQzNsTHIzY1ZTRC9wbytzRzNvU2lV?=
 =?iso-2022-jp?B?Z09COG1rQnIvdjFtTE1LeXBEWC9HZE8xbHFYQjB3Wlk5cmhJYWxHWkRX?=
 =?iso-2022-jp?B?Yjc5Z0ZqbUMwNzJMd3RqbnJGdmhGWm13N2wwbzBGaUd5UDJUSmorTVdS?=
 =?iso-2022-jp?B?MnBWQWJHOTdaSE5UMGhwMEhpU1BhRnFhUjZUTmFPNk1YeXJSSnY1cXhz?=
 =?iso-2022-jp?B?YlZrUzFaNHdHQS9CSVRSS2QzS2V6WGNXMERSUURVWmxEbEdhbHFPSnZj?=
 =?iso-2022-jp?B?MjFYV0dMYmIwWEtvRHpZSmVqVGJkNEt0dHF1b0t3dUlHODJPSDZGbHBX?=
 =?iso-2022-jp?B?WHdYQWVmSklnRkg0VStJZVVtZ3hZczNK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB13777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?MUtSdWZJeHFKaUw5clVDQ0RMMklVd1VuOGUxUzJDZnk2a2VROHRZTmFU?=
 =?iso-2022-jp?B?UWl2UE1HSmhyMTZ6VU1TNnQzL3pmOGEvaitwU0ZmOUYvbmppUDZTb2RP?=
 =?iso-2022-jp?B?Q0owVXFxTDdmRTVzcElSb3JWS0V4T3hlVUtMSWNKOEhEWGdhYmNsZk5Z?=
 =?iso-2022-jp?B?MVI4NVVROVl1YW9QYVZUSjlVL3pmRHRPZCtBY3YxbHExcFpLOCtrVSsv?=
 =?iso-2022-jp?B?MGhLWmVQMktzVGhhWmZRWlR2eWN1VXZXeW5nMjZnVzBXRWpubUlUNkJE?=
 =?iso-2022-jp?B?eWw0UzdhM1RWRG1HckFUR1J2bmluN3lCVTc2K3dOYUhRNTF0RnhCVHlz?=
 =?iso-2022-jp?B?Q0FFdGlEMXRPbUg2dFZ6azBTcHBSOHRwbWlGOGZua0xva1VQZ1hDUXRC?=
 =?iso-2022-jp?B?MDI0WFhHWE5tS3RCT0l2T0RQU0xYRXJiVHZpaHFQSG9PS1VlZDNjMkFK?=
 =?iso-2022-jp?B?Y3YrbmFyejAzWDFlT0UvYVBjZStqY1hEdmVRenk2RS8yS2wxa0pzZGsr?=
 =?iso-2022-jp?B?V1o0SkFUZmdiNFh6L2xDODF6RjRhMW5YV3JJWkZ5VmoxQzMrcnpWbm1T?=
 =?iso-2022-jp?B?alRKU1JTMEZWdUZRQVVTN2ZtaktidkZvZlVjQkE1L0k2ZHdpN01uQnRx?=
 =?iso-2022-jp?B?aEtmVUhzWUh5dUs4R2xTeDdQK2RsQkN5TkFVNEhpcmFZSzJKbjEzekI1?=
 =?iso-2022-jp?B?d3lzMWdXbFlIanJEV0pFT2lzK1NES09GUGt0UU1YUjJDYjNwNkpPM3hk?=
 =?iso-2022-jp?B?NWhZQWNtbXRlUmQvSWk2ck9ncjFtdXVmL0NKS2lublcvcHhjYjZPcVB6?=
 =?iso-2022-jp?B?eHI5V3FxOWJUZG1nenphcU5XUlNpNlB1SFNUK1VQd2RyYXc2d3BueG5U?=
 =?iso-2022-jp?B?Q3UrR1hwdE5ZdGJLa2RXRVNVbmdGNHRwUkEwNlZpUXg1Rm9majZ1OUhK?=
 =?iso-2022-jp?B?SEFXakxWVVZCUEgzeEdmZGwrTi9kc09TM2lkQlZUQkZkbGZ2VFppZDRW?=
 =?iso-2022-jp?B?V0F4a2I4eWZGTG1qWDl2MUMrejgyMnVsUlZsZHlZakJYNy9nM0FJa2g5?=
 =?iso-2022-jp?B?Qlhxb3YxMmxKYlk5cEh3dHc0OW1Sd2tqd3BqZmVVa0Y3cWUzMWxVcC84?=
 =?iso-2022-jp?B?SDVoR0puUVAySFBKcC8zVld5Y00zSDFubkI5RFlRTndMYm5YcjdNV1gv?=
 =?iso-2022-jp?B?N0N3WjliTERqMWgxTG1RQ1cwTmdKYjYvL21rYXQ2NkM3MXdqaDhVdGJ6?=
 =?iso-2022-jp?B?Q2tzRmd6U0tXVm13NUVFVVBTaVVMYzZZdHIxS0RRaWNaOFMvRmFQVEhu?=
 =?iso-2022-jp?B?cGp6bFdZeWR5TU83ZEFkTExLY2dsNFlpUE1OYVVzVnJ0TDB3aWJuNHVn?=
 =?iso-2022-jp?B?ZG54RUZWVkk4elhmSDhPRFFtUm1GeHM1eW1qTHp3c01DSmFiQ0pNZlNa?=
 =?iso-2022-jp?B?SHYzaEZWUUQ0bnB1SFd0V21kRERTMU1oenVRdEdtbHBlbERKSkxIYVh4?=
 =?iso-2022-jp?B?R0FHbXU1ZlkxZk1aNFhEenZSTUwyN0J2bVAvdVYyMjRRbTRMSE53MWRn?=
 =?iso-2022-jp?B?T01iTSsxUGJIMHgzc09GbldvMks0dlZmQVcwcTZoYkYzZlkrRU5sbTVa?=
 =?iso-2022-jp?B?aXFCQ3FqK241dkQ0UmZoamU3em1BdXAvV21xQjV1QmMwN3p2cmU4enRT?=
 =?iso-2022-jp?B?UDdNSEo1dG9jeUF3SjhVYmhQS3NFRVFhSUJnQjNlTE5DZjlEOVV0eFIx?=
 =?iso-2022-jp?B?Tng2bWd3bjkwL3dXck1FdmZPNUlvTkFsaGNleFRGV1kvdnRsbkt2RGFr?=
 =?iso-2022-jp?B?ZzRVNk1wWU1nUEZQUmtBYjN5cWhGdUptNmdUZnJwM25BbW52SC9ySGpU?=
 =?iso-2022-jp?B?eFFJekJtK2VGN2hJMFd0aExYUDZTKzNFUWFUTmpTZVVsbjhJcy9pa1k5?=
 =?iso-2022-jp?B?RVNyQVZwZXZkVHlYazlDS29aNWI1V1JGVkNEYjRWSVQ1dTdpU08vRTlC?=
 =?iso-2022-jp?B?WjBaZDd5eEVudjgrRHY4R29tN0lsak9ZQmZ6QVA3djlvZlBVU1JjcnQ5?=
 =?iso-2022-jp?B?dlpKVjRqV1I1OStqRnFWRjgydlp6R05aS01MVm55UlB6TUViazF2OFJD?=
 =?iso-2022-jp?B?TlBiNnJGdytnWWlqNjVrWGlUK2JEZkhNb2tHbTR4bFlFVnZHNEZnM1A1?=
 =?iso-2022-jp?B?TDlWc2JKS3ZIU01GcG00M2RZSjJudk9qcFpBSEFqbStoTFFUNWpjMmFp?=
 =?iso-2022-jp?B?NmtjSEI2VndkenNPdkI2OENwMVJBbWRrdVFDbjk0R0NSaXhrdEpRaU9K?=
 =?iso-2022-jp?B?eURPNWlzM1dpVy9hamx4ZHQ1T1l5S0RtTWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oiK+VplRtKOsa1I5QomPS6CscZw0hKuwFvRG+Z6UdpZ0HjZY2tGN+COhFYDchAf92fhQhZxwkysQDiMKUhNNNvqkRSt3UHdd/J76MKkPaazulz2aW3ZJarmEtP5KIA+0PkluU806Laa8g62kiPapLM6C3MitxK1mWD4PGoDYc8GT+0hvN9ov1IbZ50d4/IIE+Ys8qAsdkVscvL7tQulAiV/4jcVFnS3q6tll3cdunPaO+e4Vo/ZGWtSM02T1FyWs5gXl8YFfFQ8feLsroR+/owaummcyUFNdfx4VaA7Tyoufcr7nN5lxy6Ug+TM82zinfo2o3IHH74PFQX9mIaJQjtY2syCr+KU0BP/PakkNnGYVP+lbwlqs/yLYU5QOgEiTKbqHk0WO09xQxDgykXxaSyhtSHzwO1T6T0M5Q7i+GADMFCKYkD2CwU6bKdjtzUvO7Xq0X0ThPOQSmP57Tiyc/97un8A79FCUtevGtpnFsPYrSN4KUANNTMUk9TD0Ek8hWUVGUabGyQz/CHZbnWFi5D8QEoUgUNqZZ8A3r9Qx7IiDnnTYe+9El3KVUc8vzbbZvtHgcb8FGwOXJz4tPJ89JnXxzt2knOs8P5srQ63wm/gHagr39r6uqyOqK0aZt7/w
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB13777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b26a35-165b-4ef6-c9b0-08dda31dd6a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 04:11:10.6536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nJNSEMF3LHFQ8TZBdA4brPLNz8DCgv/TvRoTyrq5WH22CGHMEWzaM80Zg7ZwccWk9/fSlBaclegTb1+iJGBLj/mHloDM2oIYvoJ2KLBUfko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB12110

Hi Michael, John,

> Hi Petr,
>=20
> On 2025-06-03, John Ogness <john.ogness@linutronix.de> wrote:
> > On 2025-06-03, "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com> wrote:
> >>> 4. pr_emerg() has a high logging level, and it effectively steals the=
 console
> >>> from the "pr/ttyAMA0" task, which I believe is intentional in the nbc=
on
> design.
> >>> Down in pl011_console_write_thread(), the "pr/ttyAMA0" task is doing
> >>> nbcon_enter_unsafe() and nbcon_exit_unsafe() around each character
> >>> that it outputs.  When pr_emerg() steals the console, nbcon_exit_unsa=
fe()
> >>> returns 0, so the "for" loop exits. pl011_console_write_thread() then
> >>> enters a busy "while" loop waiting to reclaim the console. It's doing=
 this
> >>> busy "while" loop with interrupts disabled, and because of the panic,
> >>> it never succeeds. Whatever CPU is running "pr/ttyAMA0" is effectivel=
y
> >>> stuck at this point.
> >>>
> >>> 5. Meanwhile panic() continues, calling panic_other_cpus_shutdown(). =
On
> >>> ARM64, other CPUs are stopped by sending them an IPI. Each CPU receiv=
es
> >>> the IPI and calls the PSCI function to stop itself. But the CPU runni=
ng
> >>> "pr/ttyAMA0" is looping forever with interrupts disabled, so it never
> >>> processes the IPI and it never stops. ARM64 doesn't have a true NMI t=
hat
> >>> can override the looping with interrupts disabled, so there's no way =
to
> >>> stop that CPU.
> >>>
> >>> 6. The failure to stop the "pr/ttyAMA0" CPU then causes downstream
> >>> problems, such as when loading and running a kdump kernel.
> >
> > [...]
> >
> >> After reproducing the issue,
> >> I plan to try a workaround that forcibly terminates the nbcon_reacquir=
e_nobuf
> >> loop in pl011_console_write_thread if other_cpu_in_panic is true.
> >> Please comment if you have any other ideas.
> >
> > For panic, if it is OK to leave uap->clk enabled and not restore REG_CR=
,
> > then it should be fine to just return. But only for panic.
> >
> > So something like:
> >
> > 	while (!nbcon_enter_unsafe(wctxt)) {
> > 		if (other_cpu_in_panic())
> > 			return;
> > 		nbcon_reacquire_nobuf(wctxt);
> > 	}
>=20
> Actually this is not enough because there is also a loop inside
> nbcon_reacquire_nobuf().
>=20
> nbcon_reacquire_nobuf() needs to return an error for the panic case
> because it will never succeed. This is the only case where it will never
> succeed. Should we use a bool? Or return some code like -EPERM?
>=20
> So the above code becomes:
>=20
>  	while (!nbcon_enter_unsafe(wctxt)) {
>  		if (!nbcon_reacquire_nobuf(wctxt))
>  			return;
>  	}
>=20
> We should also add __must_check to the prototype.
>=20
> Thoughts?
>=20
> John

Thanks for the suggestion, John.

This is a proposed fix to force termination by returning false from
nbcon_reacquire_nobuf when a panic occurs within pl011_console_write_thread=
.
 (I believe this is similar to what John suggested in his previous reply.)

While I couldn't reproduce the issue using sysrq-trigger in my environment
 (It seemed that the panic was being executed before the thread processing)=
,
I did observe nbcon_reacquire_nobuf failing to complete when injecting an
NMI (SError) during pl011_console_write_thread.=20
Applying this fix seems to have resolved the "SMP: failed to stop secondary
CPUs" issue.

This patch is for test.
Modifications to imx and other drivers, as well as adding __must_check,=20
will likely be required.

Michael, could you please test this fix in your environment?

Regards,
Toshiyuki Sato

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl01=
1.c
index 11d650975..c3a2b22e6 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2577,8 +2577,10 @@ pl011_console_write_thread(struct console *co, struc=
t nbcon_write_context *wctxt
 		}
 	}
=20
-	while (!nbcon_enter_unsafe(wctxt))
-		nbcon_reacquire_nobuf(wctxt);
+	while (!nbcon_enter_unsafe(wctxt)) {
+		if (!nbcon_reacquire_nobuf(wctxt))
+			return;
+	}
=20
 	while ((pl011_read(uap, REG_FR) ^ uap->vendor->inv_fr) & uap->vendor->fr_=
busy)
 		cpu_relax();
diff --git a/include/linux/console.h b/include/linux/console.h
index 8f10d0a85..ae278b875 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -604,14 +604,14 @@ extern void nbcon_cpu_emergency_exit(void);
 extern bool nbcon_can_proceed(struct nbcon_write_context *wctxt);
 extern bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt);
 extern bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt);
-extern void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt);
+extern bool nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt);
 #else
 static inline void nbcon_cpu_emergency_enter(void) { }
 static inline void nbcon_cpu_emergency_exit(void) { }
 static inline bool nbcon_can_proceed(struct nbcon_write_context *wctxt) { =
return false; }
 static inline bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt) {=
 return false; }
 static inline bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt) { =
return false; }
-static inline void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt=
) { }
+static inline bool nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt=
) { }
 #endif
=20
 extern int console_set_on_cmdline;
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index fd12efcc4..ec016bb24 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -909,14 +909,18 @@ EXPORT_SYMBOL_GPL(nbcon_exit_unsafe);
  * output buffer because that has been lost. This function cannot be used =
to
  * resume printing.
  */
-void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt)
+bool nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt)
 {
 	struct nbcon_context *ctxt =3D &ACCESS_PRIVATE(wctxt, ctxt);
=20
-	while (!nbcon_context_try_acquire(ctxt))
+	while (!nbcon_context_try_acquire(ctxt)) {
 		cpu_relax();
+		if (other_cpu_in_panic())
+			return false;
+	}
=20
 	nbcon_write_context_set_buf(wctxt, NULL, 0);
+	return true;
 }
 EXPORT_SYMBOL_GPL(nbcon_reacquire_nobuf);

