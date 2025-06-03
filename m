Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com [68.232.159.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9C525D213;
	Tue,  3 Jun 2025 09:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748943446; cv=fail; b=DdOIXBXUW9wT5XMtHJAoENC00O9SiOOQG+z7O6RIoz+86L2dXZwhkB3k7QnXbA02fYrhqi2vrISDIewaPK7tig8vi0snw/wvZmjYim1ePEcXnw2VqX8XCQEB3fXF8eSmfAieSDxSxKZihTCQ2DYuImGeazRIgyTENSouO1lr7lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748943446; c=relaxed/simple;
	bh=AQTr/yT53ml1wvzXJpSrIPSoi6czmVUaqYhWyZnpyKo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aYuhUrp05Hun1Xa/n98xtDzHCyQjNvytnYBZc8sLGr+zpqRlpvTjtRPgUQSKsQtIk3DtBCCOO3kXJffqVDIA04jolCIN1M8LF1Dg3tYXD9IiIJmYnto0MFpbvMFTj1Jqxmg1jt/Eyy66Sv59gaB5VFveuS1TcG9rYDqBWjsG75Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=xHyVElls; arc=fail smtp.client-ip=68.232.159.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="xHyVElls"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1748943444; x=1780479444;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AQTr/yT53ml1wvzXJpSrIPSoi6czmVUaqYhWyZnpyKo=;
  b=xHyVEllsz1zmWpPSxDcKOncLt5b202NQqTcd1m3PEtxQF7X/Bl3AMVYT
   xR2CsYscGpoSih+zksH/IDClce8wjoiR+P52s3IKcLROuYfA6GDAiONcK
   SV6Yp4JNLAZN/OZWc2G8jrBcAFfa+RajBeRQWi8dlFz41Lhns6cikRFAx
   zmk1yYDhsHc1WhhGP5+RzAzgwxb2lXB/SkmZ9tQSNBxbLGrF1e6Ebtav8
   AiQ7eTynm0SLN8LuiHymhS1GTJe2IclF6ruq7lL/ilpuEJV0fwld2jycy
   ZHe2jmVHLdd82OL68FvaCU8MopNrbM8mpqE3T8r7Oh/fH/IgUrR/C63E/
   Q==;
X-CSE-ConnectionGUID: Re27QXchTBGiba+zvoY/zg==
X-CSE-MsgGUID: XKplaPBIRgCy353UB5eKAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="157480572"
X-IronPort-AV: E=Sophos;i="6.16,205,1744038000"; 
   d="scan'208";a="157480572"
Received: from mail-japanwestazon11010061.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([52.101.228.61])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 18:36:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBriMyeD4M18CYF7NcBQfhAjCJDkddRWFsQHryuNufsfPKV2UGWEl3bS+9TuycLFEHEte9evVNpa1OmF9BA7OGdm9oZHm2cEQkKNkffXEuGqDCyfGrUFZJh0ilUkriwopsBEfvdHS6B+iqxL2rzP5+UhCHTLnAbtjWuLtPKdX7SKsw1yxFxcuHIr9Oxf/DKoMjvK4KGXJlkLzQCOlbQcZpXEsbjU/HNCW+Tl8jJgXdXvTbMeXB514cIVGWS2SUi2gC5uxkzAtKVCDPMuB9N+dVEHa1kEWTI8NHy45iWTKBBYzFGAk+d6H1SvwVix0F6XMhJnzkJyPgaaKtrf86MRdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gr+YhMt0i2UNZfcB7VAeZ4wopajWo+1dYxeX0ILRqFI=;
 b=WScsvS7PzyA0dBvq1SI7jrgGp++JxQrU7S2Dtp51Af3BzaXkuQCDwX3fcRiPz7RkKpvmR1hGV8WHDCOBtVrzeqZ1kjlo4UKuGbJoi+ixCa3m4kPbr72hC96bCDAHrP3/OnEILwcVxlGwQ2XDE+txA/PeAbx8Ia5Q7OGEcLYc726lRTVIwgnZNGpwZ12L+dWm566Plyz+Q/X/JFyE6igaZYlJoMS9a0nfM0SIhxE/afTfgzmLNzetzi6WaMVNmIULHUE8DKGiPP/PQmmDttV8LQ6Cd5GbohS4TQq5AyR8TESDGFOU0Pi9LjshthWgPjNy5afAPrKsS5L63VQ5AOWu7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB13775.jpnprd01.prod.outlook.com (2603:1096:604:36c::5)
 by OSCPR01MB15033.jpnprd01.prod.outlook.com (2603:1096:604:39e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 09:36:03 +0000
Received: from OS7PR01MB13775.jpnprd01.prod.outlook.com
 ([fe80::5e9e:e74e:c0d5:31e4]) by OS7PR01MB13775.jpnprd01.prod.outlook.com
 ([fe80::5e9e:e74e:c0d5:31e4%7]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 09:36:01 +0000
From: "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com>
To: 'Michael Kelley' <mhklinux@outlook.com>
CC: "john.ogness@linutronix.de" <john.ogness@linutronix.de>,
	"pmladek@suse.com" <pmladek@suse.com>, 'Ryo Takakura' <ryotkkr98@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Toshiyuki Sato (Fujitsu)"
	<fj6611ie@fujitsu.com>
Subject: RE: Problem with nbcon console and amba-pl011 serial port
Thread-Topic: Problem with nbcon console and amba-pl011 serial port
Thread-Index: AdvULbS8DdGjT9TLS9OOSVhbv2AtDgAN1+gw
Date: Tue, 3 Jun 2025 09:36:01 +0000
Message-ID:
 <OS7PR01MB13775FE1A20762D1EA4A38D0ED76DA@OS7PR01MB13775.jpnprd01.prod.outlook.com>
References:
 <SN6PR02MB4157A4C5E8CB219A75263A17D46DA@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB4157A4C5E8CB219A75263A17D46DA@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=080678b1-4b43-43bf-9dcf-154d084b630f;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2025-06-03T08:54:44Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB13775:EE_|OSCPR01MB15033:EE_
x-ms-office365-filtering-correlation-id: 9b310882-8edb-456b-f27c-08dda2820dab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?NVlEeHBuWjlDbmd0WWxjTGRWajhQZzk0SHI4ZllNVUd5R1pSUlZRZzJX?=
 =?iso-2022-jp?B?aHFWaSsxUE1qNHc3VGRCbWt5a0g4L3htRHhsU2dBZHBjVUhZR1ArcUkx?=
 =?iso-2022-jp?B?SDR5VUMrQzdpL041SDBuRkRSMjFFUmhzVkp0RXltWWwycnhhTmI2M1Vo?=
 =?iso-2022-jp?B?VjJLMXFRUGI1UFc2Z296NHVSZ1JVZ1RhYVZvc2ZKNzB1OXIrQTZVcmNx?=
 =?iso-2022-jp?B?YXVnWlZWMXdMa1ByanZOWHBLNDVPU1hIQWxyUjdTdC9MUTlUMHlCY2w5?=
 =?iso-2022-jp?B?S3lQRERHb2JPWDc4UTA4WVROcWVCMG9FK0s1aDZWbzhwWUt3TGpzMmtG?=
 =?iso-2022-jp?B?VU1EMFErc2hqRDE1RDJIMlRzSEUwTkNBZHhPcGNJczZ5U1UrMXBiZHlZ?=
 =?iso-2022-jp?B?S3AxenRpbnFWWkNNMkdJaU5hZEJKRitYN2RmaDRGU1lKbG5aSGhZK2Nt?=
 =?iso-2022-jp?B?QjV3aG1qREQvNHFQbUM5RjQxU0MwWDdpbzRGY1hZRDJzcnNMaDhvb1lQ?=
 =?iso-2022-jp?B?em9pdThranhtSkFOcU96dTJCSXFnd2VHYnFTb2tMYVAzSi9qbEhlUUJw?=
 =?iso-2022-jp?B?UDNrVXovYnZYL0s0K1p6VmVia2xGV2VkbTR5Y1RWUE03Y2FTTWxPSGJD?=
 =?iso-2022-jp?B?NFlLZlUyL1F2SkxibXJBRkx2YWdzUHJGeFg1dEluZ1k1UHFvRE81aitO?=
 =?iso-2022-jp?B?c0doNHgrRkhGRXZjaWZUWkVvM0poazM5U3VKSVhSenZ6b2E0dzJFV09t?=
 =?iso-2022-jp?B?aWI5QXFQeXV1eE1iQ2N6RjNhbzJPQkRrU1RLWE5TdExVbUhGcjlhVlZ0?=
 =?iso-2022-jp?B?KzZMWUdpbUpqVEpLYVNQU0pPQ045RElkYVV1TEhBOC81aW5IU2wvRXJL?=
 =?iso-2022-jp?B?WEFycFRuWitWMG1PUTVNR29DZzRGSmtFODNTOGZCalJyVzJWamM1bThV?=
 =?iso-2022-jp?B?OURHZ25xK3RwRGJLQjR1M1pYZlNFdlU0OGpBQjRpa0ZqOUtDTGorTGdN?=
 =?iso-2022-jp?B?Z1FBc1dWSHhqVW5GUS9ja0JGUUw5b3p3QzJ0QU5sR0FucUxiL1JnalhJ?=
 =?iso-2022-jp?B?VjZ3UW5QcGlMRXNwUjhjZVdtVUgyZ3RDcWRocEpsSzg1OUpQQjMrWG9V?=
 =?iso-2022-jp?B?b2d1QlY4VnFjcWpaMjZRR1o0ZU91MDIwcEFJTnVFOXNRUCtaZ25INDhK?=
 =?iso-2022-jp?B?WVEzNTJZZEloOGQ3QmRpRGNHL0FDeFRDellvamtKeEJqV09WTlRBR011?=
 =?iso-2022-jp?B?TVU2YVlLQTVOSlAzOXBrb0NJOFJjZkpUSVNFR2dvQWtEV21ndnBzODlE?=
 =?iso-2022-jp?B?eFN6UFF6bjNCcVRmZmZEMWVkdmpqaHJzeVB1aHgrNmpjeEhMVUcxcFVH?=
 =?iso-2022-jp?B?cUlQT3h3aDZSMFVLNHVDYWhDMFlTQSt2ZWZoRVN6cWV6cG5IZUhtVmgy?=
 =?iso-2022-jp?B?WG5NV1pUa28rOHFMT25tOXFkWmNseWx4VStyZG1LQ1Z0ZGxUT1dzZkpK?=
 =?iso-2022-jp?B?WjBTb3hPV1hwQjNET2IyVUdXV1JWRERNTTJpb0JXUElETTJMMk1vZ2xx?=
 =?iso-2022-jp?B?V0xQeXhKZDJpbTBhbG9aL3dyQTdpZXpBdldTellCYnQzbzhQeTZJTmJm?=
 =?iso-2022-jp?B?STlwL2NFMFhTWW1xUlZ5Qm9VSHMwMjh3Y3BXRFVQeVdBUm1OK08vWi9O?=
 =?iso-2022-jp?B?ZE56RnNXaCtZdjRVd1FERXByd0o1eStoT3ZlVE5NY2JVa2QvTm1rVUt3?=
 =?iso-2022-jp?B?VG1VbVpTMUY5OXJmMEwzNEdQcG95ellsVUFDck1Xa253QjBwb0lpT2Qr?=
 =?iso-2022-jp?B?U01Ia1NBY3F2SSttRlZHSHlLMkgybDBwTzhXUjQ0ekVRNzRCaE5tK3Zm?=
 =?iso-2022-jp?B?WnZyVG5YVHpYdVdwVEtXSHVZbWdsSWtzS2h5cDI0K0RmSGpxTGRZckRW?=
 =?iso-2022-jp?B?T25VWHFvTUw5K2JNQ2Y1dmgrUGhOaVJqTnJhM1VjTWJLb3VFcXhXWjN4?=
 =?iso-2022-jp?B?RDlxMXRhQW43VWxNSnk2cG5TMTJYT0tJOU5LOXRJYkFITmJwOHFETjM1?=
 =?iso-2022-jp?B?RWdPR2FUamZkTVVVUzJRNlNua2duaTB3VGxwaFcvL0s4Y3ViSjA2dFNS?=
 =?iso-2022-jp?B?bzM2SlE0UmZNSTh1Ymw4b2VYQ0xuVkNKUEUzUkF6RkJrL2h2ZldmUXlJ?=
 =?iso-2022-jp?B?NWhpcGloaUVFL3JmejFuSXFIU0xVMi9X?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB13775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?UGlRaFVBb2ZjTHZZbENtL3VObGdoVy9WQXFqbkFNcGF3VVN1QmhXaGRa?=
 =?iso-2022-jp?B?VHNDQ2Q1WU5vQm1ZZmN4ZHRsQmlySGlPa0xibGMrZ0hKOWxRUVloWDll?=
 =?iso-2022-jp?B?VnRabDhHNlVBVkJPcUN4YlBvZ0VuNElaeGRORWh5MXhaZDZUczY2OGhM?=
 =?iso-2022-jp?B?dFlJT245cmVmVFJZVW0wZXRha2Fhd3pVYnZxbWdWTTBiNktnVmM3aE4r?=
 =?iso-2022-jp?B?Y09nbUxSQ1VXY0RQYjhrUjRhYkNsM0hFcW1wSVRjRUxBM3puQnVVMVpT?=
 =?iso-2022-jp?B?OVB0cXFKRHZUajg1b0VvWElTQjN3eGsyK05rVkhrdnNtOXJteEZBcEh3?=
 =?iso-2022-jp?B?NklOYi8raW82MDB6ZXNZQkw3SFhnc0l4UG10OXdKMjJaWGt1ZkxCa2lU?=
 =?iso-2022-jp?B?YXk0aEhHTXhRdjZkd0J5Si9EWXpSVG92MkVkUVIya0JlWm4xQm5XVnhm?=
 =?iso-2022-jp?B?TjlZZlhhaldHTlBCb3VRTlBPSWNoZTBnY3VZcmI5dkdETXNJMjBZUkZo?=
 =?iso-2022-jp?B?Q1hjNi83ZVhmMTZhN1NnanZSeC92Y0RRbXBTWURyMHpsMVJncFRPZmRR?=
 =?iso-2022-jp?B?SG5obDc2anh1ZzlUYmpxRUtDU3V3aGYvbE9OK1ZKOWhjdGwraXRiSVhD?=
 =?iso-2022-jp?B?QnB1MmI5SkIvUHNSaWh3SmRrbVh3cStVczVLS084NU1TN1g5eUZjWkZk?=
 =?iso-2022-jp?B?bTRyRGdTd0VvbDJva2hXSlJZbVlrVGRoY1Z1ZFFURVljMzgvM2hxeTRG?=
 =?iso-2022-jp?B?c2ZJTmpwdzJzMDBZM1hyNis2cUVoMWQ3ckR3S1pub1ZhR0NuNXZyNUV2?=
 =?iso-2022-jp?B?clQ3ZDJrMlRudWxFVm1ybkluRHNISWg4aW03NTBWUklGNTRiRVlVOTNx?=
 =?iso-2022-jp?B?WmNCOCtSSk5Wb1cvTkZPeG4zT2FkVGlDaVpkTUMvTm9YczVKSDg0bTRH?=
 =?iso-2022-jp?B?YnZsNnhpM0VVdytHdUNZOFRGOWxGNmkwOUw1Q3JPZ2ViUEhJUTRaNWda?=
 =?iso-2022-jp?B?dElwdWRuSTYyeFFIM3orcTU1ZnNZbDhVV05WTWN5SXhvVGIrOUJGZDh4?=
 =?iso-2022-jp?B?Vk00bXdBaCtmY0JHc1FWblBYZGZHVmNFaXozb3NjcFRaaXR2TUFXakZk?=
 =?iso-2022-jp?B?SW54dEx6OEdvbHA2NWNPNkFRNGJvdUVIK01WRWtiZjVCS0toMlZDUDM3?=
 =?iso-2022-jp?B?YlRBM3dZMEZYRHlTQndYeXZldVJlMWsrYmczcy9SeFhKNXNsUmpEOUFM?=
 =?iso-2022-jp?B?aERxTnZ6NnZ1dzNDbWQyaW93ODY4eGJjZWNBdFpaNXB3RWtWSjI5WWow?=
 =?iso-2022-jp?B?UkIrVjhEUHBFUHdCT3Q5NkU4K1FTajBpUEszR0twVWRZNUR4Y0F3dUov?=
 =?iso-2022-jp?B?TWc5OG9kZmpQMFp2WWcwOWUyc2ZUVFpIck93NVMxZHlKc0hCMHVvMXpm?=
 =?iso-2022-jp?B?QmhQeFQ5b3Jtdng4bnlFcXRxSFl2WFFoTW02SjFyU1BRYjFobXY0YTZo?=
 =?iso-2022-jp?B?bmlMa2xlK0pDL2h6Z05UWXRKc1FBUXZ1OWlZVmd6cG4zTUNMNDBCWGVt?=
 =?iso-2022-jp?B?MEJoZzFjRW9XQWRHbjNlK09pTlRJTGd6ZnpvWS96SWk3MEdkekdLNEEz?=
 =?iso-2022-jp?B?ZlZ4cFdYSjZKSUJYV05tOVZiL2o4R0wzNjdDeGJVazNieVc4UkZXY1Fi?=
 =?iso-2022-jp?B?eHJPVk5NMGVMaDZ6UW1DdHZSVlJvU0p4Qmw1K0JWV0g5MHV1d2xKQUtS?=
 =?iso-2022-jp?B?VDBSOGhGTVdsdzlURStKR0o3UUdnRGhLUXY1NVBRMDJDWFQ4bTFtdmYz?=
 =?iso-2022-jp?B?OEJSU3daQncyUUg1L3JhUUNndTNiR0N3cjRicWZiaEFEYnRYSFZKaFgv?=
 =?iso-2022-jp?B?MlBrVXB3RHJpQUVlV0luMlJJWHFvQUhPdHlFOC9Uck9VWS9mM2JyWG1w?=
 =?iso-2022-jp?B?Qmt5WjIwdXo3M283QWZhdFR3Tml1V29Fb0VYbEtHSFFLejExNDA4TTNS?=
 =?iso-2022-jp?B?eXp1K1k5SUtDZUlKV0c5Ty9zSDh0Yi9UcTF1ZzVZenZ5dC9JZlVUZTJh?=
 =?iso-2022-jp?B?dXhWR2xLVHJlVDdCQjd5SzI0L0tseFFlVTk5L3UrRHYxS1RhSmQrVVhF?=
 =?iso-2022-jp?B?cUo3Q0tjcUVFUEQvVnduOCtZUmE1TzR2eER4UzJRSWtrcFNrL2ZXNjY2?=
 =?iso-2022-jp?B?Z254dmxZSjNhUkhlem9jaWVOL0gwZHZDMjhvZkMxSytXSWdPMDNZekor?=
 =?iso-2022-jp?B?aU1HdkRUZWx3ZGZoZk9DQkxWc2N0RE13SjlwUEt0UXRXR3l4NlowYzE1?=
 =?iso-2022-jp?B?bTRYYnVGNWcydnYxdjRzenFJUEc2Vi85Unc9PQ==?=
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
	FSiYNKJmDlkJscz8VM6WPFXU9bmsUt5lYS6+Dn9nRYdVRArut1WCFuoqSUzKo6r+fG3NdCIeJTqXI/ISm0FngUiNAETBfnMHND578tzVjPxN0Ynv3iALmsv34djuGp2PCnP9BQSZiYZCKZoh0f1MQfkE7+uWBrxAVsLlpWPM25k0+E5JwYrMFGEuF7fq8eMxpWdR35qMlRl5uij2PNrbMop5dHMwUshGJ0uD5lX8cP/ARJ4mf8/Ys/NsYOx7enxFqBGNcjDIg0NnteI6hci9WKdpIHx1jYTMRFukz/RIhzXyo8KA3xFcjMcPBnal1C8iPSs9IBI8BZDZUZiOux9Z3pHkClaXVxNeyKW6HCA0NC7+jTgejW1djW4Qef6Tu8eCRvwUAYoDzwxwRTWDOeEM6C0p+4+Qch0QFG2EWa+xssWENVyr/UIUf0WdmAfpboX4DmfO84jAhd3tNfWt52xdYcYOAMqt1+rYtxbtzV//Qhu3m2lyaKjLppUDc6deI6d1wecJkOJ7afMgIt8Az/lh7nzSzmScCR4NgXFedAUiH7VHx1A1DbD1dJZjolJuGqT/X5lvXvFLzwhnn+vgVN0HQRaIbnjgG/CvFAuOyVF/ZgmAaaBNYCMeALUFQiEZHtFh
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB13775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b310882-8edb-456b-f27c-08dda2820dab
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 09:36:01.4702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jAUYIJ7LGV/ipoP8IwQeQw/d8w/4M+uKh788L63p675BINdGwaixDMiP4bpefRfiPIw6Q2RzdwjpxfPjg5fF+ADR/vb9ISjk3JDH8QuUZuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15033

Hi Michael,

Thanks for the incident report and problem analysis.

>=20
> I'm seeing a problem in the panic path of an ARM64 VM on Hyper-V
> in the Azure public cloud.  Here's the output from the VM's serial port:
>=20
> # taskset -c 4 /bin/echo c >/proc/sysrq-trigger
>=20
> [
> ** replaying previous printk message **
> [   51.616656] sysrq: Trigger a crash
> [   51.616689] Kernel panic - not syncing: sysrq triggered crash
> [   51.624212] CPU: 4 UID: 0 PID: 2278 Comm: echo Tainted: G            E
> 6.15.0-rc7-next-20250521 #1 VOLUNTARY
> [   51.630165] Tainted: [E]=3DUNSIGNED_MODULE
> [   51.632331] Hardware name: Microsoft Corporation Virtual Machine/Virtu=
al
> Machine, BIOS Hyper-V UEFI Release v4.1 09/28/2024
> [   51.638771] Call trace:
> [   51.640179]  show_stack+0x20/0x38 (C)
> [   51.642488]  dump_stack_lvl+0xc8/0xf8
> [   51.644638]  dump_stack+0x18/0x28
> [   51.646654]  panic+0x384/0x478
> [   51.648371]  sysrq_handle_crash+0x20/0x28
> [   51.650815]  __handle_sysrq+0xdc/0x2b8
> [   51.653080]  write_sysrq_trigger+0x124/0x240
> [   51.655508]  proc_reg_write+0xa4/0x100
> [   51.657917]  vfs_write+0xd8/0x3e0
> [   51.659836]  ksys_write+0x74/0x110
> [   51.661735]  __arm64_sys_write+0x24/0x38
> [   51.663967]  invoke_syscall+0x6c/0xf8
> [   51.666025]  el0_svc_common.constprop.0+0xc8/0xf0
> [   51.668771]  do_el0_svc+0x24/0x38
> [   51.670713]  el0_svc+0x40/0x198
> [   51.672509]  el0t_64_sync_handler+0xc8/0xd0
> [   51.675170]  el0t_64_sync+0x1b0/0x1b8
> [   51.677351] SMP: stopping secondary CPUs
> [   52.728175] SMP: failed to stop secondary CPUs 2
> [   52.731229] Kernel Offset: 0x5706ebce0000 from 0xffff800080000000
> [   52.734528] PHYS_OFFSET: 0x0
> [   52.736115] CPU features: 0x2000,400007c0,02110ca1,5401faab
> [   52.739275] Memory Limit: none
> [   52.803615] ---[ end Kernel panic - not syncing: sysrq triggered crash=
 ]---
>=20
> The problem is the failure to stop secondary CPU 2.  (The CPU # that fail=
s
> to stop varies from run-to-run.) It is mostly reproducible, but not alway=
s. I
> bisected to commit 2eb2608618ce ("serial: amba-pl011: Implement nbcon
> console") in the 6.15 kernel. Further custom logging shows the details of
> why the problem can happen. Here are the steps:
>=20
> 1. The "echo" command ends up in __handle_sysrq(), which outputs the
> "sysrq: Trigger a crash" message using pr_info().  I always ran the "echo=
"
> command on CPU 4 just for consistency in my testing/debugging -- there's
> nothing special about CPU 4.
>=20
> 2. The "pr/ttyAMA0" kernel thread handles the outputting of the message.
> nbcon_kthread_func() calls nbcon_emit_one() with the "use_atomic" paramet=
er
> set to false. nbcon_emit_one() in turn calls nbcon_emit_next_record() wit=
h
> the console spin lock held and interrupts disabled. nbcon_emit_next_recor=
d()
> then calls pl011_console_write_thread(). The latter has a "for" loop to o=
utput
> each character of the message, and my custom logging shows that it is ind=
eed
> outputting the string "[   51.616656] sysrq: Trigger a crash".
>=20
> 3. While "pr/ttyAMA0" is doing its thing, __handle_sysrq() calls
> sysrq_handle_crash(), which calls panic(). After some preliminaries, pani=
c()
> outputs the message "Kernel panic - not syncing: sysrq triggered crash"
> using pr_emerg().
>=20
> 4. pr_emerg() has a high logging level, and it effectively steals the con=
sole
> from the "pr/ttyAMA0" task, which I believe is intentional in the nbcon d=
esign.
> Down in pl011_console_write_thread(), the "pr/ttyAMA0" task is doing
> nbcon_enter_unsafe() and nbcon_exit_unsafe() around each character
> that it outputs.  When pr_emerg() steals the console, nbcon_exit_unsafe()
> returns 0, so the "for" loop exits. pl011_console_write_thread() then
> enters a busy "while" loop waiting to reclaim the console. It's doing thi=
s
> busy "while" loop with interrupts disabled, and because of the panic,
> it never succeeds. Whatever CPU is running "pr/ttyAMA0" is effectively
> stuck at this point.
>=20
> 5. Meanwhile panic() continues, calling panic_other_cpus_shutdown(). On
> ARM64, other CPUs are stopped by sending them an IPI. Each CPU receives
> the IPI and calls the PSCI function to stop itself. But the CPU running
> "pr/ttyAMA0" is looping forever with interrupts disabled, so it never
> processes the IPI and it never stops. ARM64 doesn't have a true NMI that
> can override the looping with interrupts disabled, so there's no way to
> stop that CPU.
>=20
> 6. The failure to stop the "pr/ttyAMA0" CPU then causes downstream
> problems, such as when loading and running a kdump kernel.
>=20
> The problem is timing dependent.  In some cases, the "pr/ttyAMA0"
> thread is evidently able to get the message out before panic() calls
> pr_emerg(). In my case running as a guest on Hyper-V, the pl011 device
> in the guest VM is emulated by Hyper-V. Each pl011 register access
> traps to the hypervisor, which slows things down and probably makes
> the problem more likely. But from what I can see, the underlying
> race condition exists regardless.
>=20
> At this point, I just wanted to surface the problem. I don't have any
> specific ideas on how to fix it, as my knowledge of nbcon is limited
> to what I've learned in figuring out the failure path.
>=20
> Toshiyuki -- what are your thoughts how to fix this?
>=20
> Michael Kelley

I believe your assumption is correct.
Using nbcon-compatible serial console driver on an architecture
that does not have NMI will likely cause the same issue.
(I think imx, pl011 and sifive which is under development have this problem=
)

After reproducing the issue,=20
I plan to try a workaround that forcibly terminates the nbcon_reacquire_nob=
uf
loop in pl011_console_write_thread if other_cpu_in_panic is true.
Please comment if you have any other ideas.

Regards,
Toshiyuki Sato

