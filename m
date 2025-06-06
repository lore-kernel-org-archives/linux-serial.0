Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E707542AA9;
	Fri,  6 Jun 2025 06:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749192520; cv=fail; b=QyZAEmXVMvB5NsVNMe+9P+tf6swhxaf7OiTHSELqEKqmnCfUCr0rwiVPfI01psO3S3XrnCS/zY12qjQBFuHlj/4Cyw3eLyqZDM/i19H0mxHe3eYx2xjXz/EHlDJZxrtmNFPpWpdTzgN5B7pAz+xbHuOjBnDSktvxAExJ4KPIcmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749192520; c=relaxed/simple;
	bh=xuvRZQOkLUSUQgLfJsQfKXKyWIBvFeM2FFFQoHZvr+Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HadBFj0NVX2hJOESyVJ9E7R4neQpy39kZaE6ztSgSQ5e/8n4QFeXL0Nr4XVTEr3bNhHIntJOpN/Qf2nLHgmrnnuh2nTxk9/MWjoipf5YAVRtZ1UjL4Nbn6gRhYejmyfd7xv+jTxDBbrt3CSRkwdWYVzpWhS/ACsM1okJOJnKFYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=kgyYTX6s; arc=fail smtp.client-ip=68.232.156.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="kgyYTX6s"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1749192519; x=1780728519;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xuvRZQOkLUSUQgLfJsQfKXKyWIBvFeM2FFFQoHZvr+Y=;
  b=kgyYTX6sGT1tIcCnsk6nc3Y1hb7m6E/UcKOfZG+mPIp19j5iIA8Lnkgv
   NCi/pPhd+KY0DCauAGGN99bhtRsZBdFuFEb4pY6gMkMTqO6XQDfPoJBbM
   mFgh0kMXdgF+DYZouSK1ZQxLpBxghEdq7WYDCZHeKq51sLKpUQX18pLOn
   nDsX1w3zFNlvU4Wfp1PW1LAx5TBSwj5q2fiSAv3dKIFeCfIOrrXLpdFS0
   g3gbOzHcZSgEH6JS7ew+9oTqdOlL8QZDWacjnpryR/kcIXgMLrMbgIUKk
   jFbgMzmD3Nl5GlUUXlhi6UojW2xq/DNmS7BcktMTFWoJ+75iv92CWb+IU
   g==;
X-CSE-ConnectionGUID: GJkcXpSKTTSWxatF5lSb4w==
X-CSE-MsgGUID: brC9uzI+TI2YjVr5S78nmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="157370708"
X-IronPort-AV: E=Sophos;i="6.16,214,1744038000"; 
   d="scan'208";a="157370708"
Received: from mail-japanwestazon11011051.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.107.74.51])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 15:46:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djDSY+EZepx/rcKJSGaxYAYiQpZoi+RIjBd4b2CrQin8JESlPbcgJBS+a75Mt+7oLVsedzutiwtSHFcLSLLiPz+M9IN8L3qR1pszDBjsy/dHh7VR9m5zdKGPm3SsZnnRcaT9eG/p97k1VBeMbV0WtFVlzGhRAmxbuZp0flZDIz6wmbJMGcgBFDJX5k9N2UG9BMBUooKxBvLfRYiS5QKCfaFL3ldz1us9HiTVHxte6yzcB8w4DDOLNq+fMalJqURp3rL0/DRkPXTwvwHKmMQiC4/0Oud0R2U/EyG6JMufr5wQx3mG4RiFWr+3piU1VjbZAbR9G+2jM6iyf4QMyVotTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOfSqUetFaktbjdAWX8ALdaTG4Ymzk7ZHTerKw8Zd58=;
 b=XYWi2fKn6yo5YWVx8uNLzKFBpFIq5YFXBwM/kwSmx12P/N49CWCmXSTIZ7dkBNsDZOYmNgP22KqXwyMvemt0L5J9Go6GvZvWaXn71Wh9AAXaohaAs+rx5F72z406ltQP9lY4eP4jucJ5xJSp9X+7PIv/vtwSB9jaP0OtKuOfX0SXa+e48nbMoOIrNdqDp7u626t9c4gUNOHWnmbiXRcQH8J3EgSML3Lf+oUlAmqLqaOqfpVy/3LvX8bzATUozU1cQemHYpYSbh3musU9t84Lt/BUykHhCsoO8oc6jrUxk23ubZc0SR/CYqr1XKCT5W3k9LiFRHs5eZyKhwQpsWu1hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY4PR01MB13777.jpnprd01.prod.outlook.com (2603:1096:405:1f8::9)
 by TYYPR01MB12240.jpnprd01.prod.outlook.com (2603:1096:405:f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.22; Fri, 6 Jun
 2025 06:46:27 +0000
Received: from TY4PR01MB13777.jpnprd01.prod.outlook.com
 ([fe80::60b7:270b:27c7:4fcc]) by TY4PR01MB13777.jpnprd01.prod.outlook.com
 ([fe80::60b7:270b:27c7:4fcc%7]) with mapi id 15.20.8813.018; Fri, 6 Jun 2025
 06:46:27 +0000
From: "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com>
To: 'Petr Mladek' <pmladek@suse.com>
CC: John Ogness <john.ogness@linutronix.de>, 'Michael Kelley'
	<mhklinux@outlook.com>, 'Ryo Takakura' <ryotkkr98@gmail.com>, Russell King
	<linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Toshiyuki Sato (Fujitsu)"
	<fj6611ie@fujitsu.com>
Subject: RE: Problem with nbcon console and amba-pl011 serial port
Thread-Topic: Problem with nbcon console and amba-pl011 serial port
Thread-Index:
 AdvULbS8DdGjT9TLS9OOSVhbv2AtDgAN1+gwAALFDgAAAfWTAAAeB8NgABQ6MwAAAXadAAAD5OQAABRXfIAAHd5CAAAW9gPA
Date: Fri, 6 Jun 2025 06:46:27 +0000
Message-ID:
 <TY4PR01MB13777D072C4BCB40C88256334D76EA@TY4PR01MB13777.jpnprd01.prod.outlook.com>
References:
 <SN6PR02MB4157A4C5E8CB219A75263A17D46DA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <OS7PR01MB13775FE1A20762D1EA4A38D0ED76DA@OS7PR01MB13775.jpnprd01.prod.outlook.com>
 <84y0u95e0j.fsf@jogness.linutronix.de> <84plfl5bf1.fsf@jogness.linutronix.de>
 <TY4PR01MB13777674C22721FCD8ACF4FCCD76CA@TY4PR01MB13777.jpnprd01.prod.outlook.com>
 <aEApOPTqbVOR35F_@pathway.suse.cz> <84o6v3ohdh.fsf@jogness.linutronix.de>
 <aEBNLMYVUOGzusuR@pathway.suse.cz>
 <TY4PR01MB13777CC92C858572B9C19394FD76FA@TY4PR01MB13777.jpnprd01.prod.outlook.com>
 <aEGeARVcCwqcoHb8@pathway.suse.cz>
In-Reply-To: <aEGeARVcCwqcoHb8@pathway.suse.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=e0948610-2367-4ac4-96e6-e1fbbb12e16b;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2025-06-06T00:38:29Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB13777:EE_|TYYPR01MB12240:EE_
x-ms-office365-filtering-correlation-id: 6c433098-a7a8-4dd0-9294-08dda4c5dc86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?S0hZdDFRWlpreSsrZ1NQcWxEQytXWGRTRXlWUDRlYlFMdzJIV1pqcm54?=
 =?iso-2022-jp?B?UlRURDFIZmlpbHZrRC80c3dKR1RVSW1XaWliTVlodkRRVnl1ajgvQmpk?=
 =?iso-2022-jp?B?dHdYSUc5UE9YRGhMYWpMWnB2NjhoVVpvZVpCN3BCcWt3VnZQWUw1ZU1Y?=
 =?iso-2022-jp?B?ekxxdzYxMy82Tk5rZ1l0YmVhbkg4T25la1o3cU1zVm9tKzEzVGhlU0Z0?=
 =?iso-2022-jp?B?VnhPTTZWL3ArdnZPSzJhYjJnd3hUWjNiTS9LbTA5NUJIQk51SEQzYjh6?=
 =?iso-2022-jp?B?dGVhcExXWllPZ1E0T3RUUTNpcW4zOHluTnA2M3pqNGx6b3hlTXBMeDBp?=
 =?iso-2022-jp?B?ZFFWd3l3dWxnamxKdWMxRFpaMERlL1ZoVlFGNi9DdXJsaGZHaVRWbjF3?=
 =?iso-2022-jp?B?aVV6ZERLNUc0R0tvT0pqZk1Mc3hyb1k4OGF5OWZUWUY1Z3NyZ0ZhcU1G?=
 =?iso-2022-jp?B?TnlFZ3VVS0xKWlZWMGptNVM5YVBrZjAxYUJLRUZJcFp4UDgvZGZVY3F2?=
 =?iso-2022-jp?B?NWpDWUFwWnlNYXIvdGNzRjU2U08xdE9XeFZsUDhrREdlUS9mY0pudjlI?=
 =?iso-2022-jp?B?OU1JZDMvZzdrR1M2SDVwaEgwQXlhZjVPWnVDOVRkUkpWQTVyTVRtNUxS?=
 =?iso-2022-jp?B?Nnc5a01iWWNzQXh3QTM4SDIvbm1sa3hYRmN0NWVGcUxCdjE3NDhIeDFo?=
 =?iso-2022-jp?B?dkJ2QXRlMFNsVHl0N3RCVnNZVVZzTGZxcGp6dXphTEhJNVhCOGJsTE54?=
 =?iso-2022-jp?B?RVNSbWo5aFRLcEVLR0czU3RYRkVCQ0JMdHgrNy9BYTgrbkR1RVJZb3FY?=
 =?iso-2022-jp?B?dTFYaXUrQTRuT0l4NnIwc1NRdTZDSVM2WVdOKy9xSE52T0w1enJOSDZH?=
 =?iso-2022-jp?B?SjZweUxMOW9QL3hsZGplQ1ZjRStmZHBGTUcwd3M1QUVvSDJqK1l0ZVpD?=
 =?iso-2022-jp?B?K3lET0JhMFFnY2RxYXdIWUk2aThBTFFkUFgvb1BoMlM2QndLdXViNk44?=
 =?iso-2022-jp?B?VUhNeXRYemkyK2EyeURUOVBFOFJKdVpUYXZYVlF0UldmREgwUjRUdU14?=
 =?iso-2022-jp?B?NDNnNkp2cXJGRVV3cFI5VUZYTUtlMFduVUNyTGpjK1VJbHlPR0FNQmNk?=
 =?iso-2022-jp?B?Z1JpYUZ4UkJtczhmZDgwb0Y0L29Zbll6eFFSWnE5N0F1QWNkcW9ocWxR?=
 =?iso-2022-jp?B?aElmOGIxWUxZNmVKdXowM283NnlDM3ZLdlJlTDRDdzJrMmNDVEhRNFpa?=
 =?iso-2022-jp?B?QlkvRnVaYlhZajJBZk4zZFluQWpreTZJcDRRU3JWUEhqcytNUGllaEx4?=
 =?iso-2022-jp?B?cWRYUkZ5ZE5nRkp0a2FQZktBT1ptWm9STTBsZU5VZGpmaDROSkZPYUwx?=
 =?iso-2022-jp?B?MitueXRqbGRGaEtXUS9wVmptZ3pQSlpxbDhNdW1saE5DQWZDSXdRMWR2?=
 =?iso-2022-jp?B?aTZjTUl5dk1hNFduR2V0V2dNNWpBdzg2UUVtMkIzVkRUR2dVZEtZbzA1?=
 =?iso-2022-jp?B?Wmx0Mk4zVk1jZC9hMzd4dnEvVFBnS2pvSDBvRno1amwxSHdFMDBnUlpy?=
 =?iso-2022-jp?B?d2g0Y253TlUzSjhVeE9uYW5BOTJQZkxVTlAzUnFSUERKSGtidUpYdmpx?=
 =?iso-2022-jp?B?U0I4ZklWRmphdzdLTTJ1eWhQbU9zazlFcXZuRGlIVS94NEJRVWlJYlNr?=
 =?iso-2022-jp?B?L01FZzFRalpkckFoSFh2QlFLVElob0YxQ1lnRnJ5dWxqdXN2WGszamQw?=
 =?iso-2022-jp?B?cjJpNlNOSzNtMGNET25ZeEJ1U05NR2FqeDh5QjFndWZub0FvWndZWlN6?=
 =?iso-2022-jp?B?NW8yYWNSQWpkTVJvMzVlOWZZdHBNK29WOXRZU25xRTZMd0F6OFdZR1dn?=
 =?iso-2022-jp?B?SUJuaEVhc25JSThUSmFDVHV0UTROUTZ0M2J1Z21IdmtEWXZoWDZpaE5W?=
 =?iso-2022-jp?B?b1A2S2RxMFN2aHV1V0N4VkxBWGNhY3NGWEdjaXQ2c1o2R0xEQkJhcmJL?=
 =?iso-2022-jp?B?VnRMTHpEUHh5T3JMUXVsMnJNWDVtKzVPL1E3TzJHcElFZTlFNUxlNVh0?=
 =?iso-2022-jp?B?cVRpNXIrM3Z0VGtvQVhVUkhBMXpPUXBVb1ExcmtSZVRyNHoxSFdCODQ4?=
 =?iso-2022-jp?B?SXlaQmlvUnNVVDVEb1ZOdGd3Z1FoNG1TSFJtZTY1T0FwTjJ6NllRbzcy?=
 =?iso-2022-jp?B?VWxJd1gzcEYrRDhjbGdzUlFTSlZLVTQx?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB13777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?cHE1M3R5VFBrRXdUdEZsUjJNVlJjVTAzUDhBZ0ZZWUwwZjJJV3hLeU1I?=
 =?iso-2022-jp?B?SjdrcGRocGRaemdHOGNGSFhHRTZKYXVXTkpoNUZCbGcwRXlYeXMxU1ho?=
 =?iso-2022-jp?B?WjJiQ0YwUHlPMnZaWlhOK05QZEdXY0oyc2Y2eitUNGlmNFZRN1ZJQ0FR?=
 =?iso-2022-jp?B?SGd2WkFpdVM3dDV0MjFlN3d3RStpd3Z4Zjd3Q1pRMjFkU2I3NWFIVjk2?=
 =?iso-2022-jp?B?SVorTHBQSjVqV1R0KzV3RU9wVDJBVnpIeUJMdHR0WkY5ZTFZbG0zb005?=
 =?iso-2022-jp?B?VXArZHludjZUNUV5WEN3NjhpbVJycEpmM2xVeTFCNk5TOWZXbWRTcFAw?=
 =?iso-2022-jp?B?Z0VPRm5xRW5wdk1jN1IzWjVLYjBwOVNIOTdZSnVWOGRmbjZjWkE5QlRm?=
 =?iso-2022-jp?B?WXNwZzlobGM0OTNBdzR2M3JJNFowdXd4TEZBK1hyRTFmZDU0d0RvbFox?=
 =?iso-2022-jp?B?YlkrT2Vkb2hrMkE1cGpUOENoZzkxMDZkZjVBdG9IMmVsYTBlNDk1d2E5?=
 =?iso-2022-jp?B?OWtGNG5vOUNQTDN4RHpOOXIzek5RSlA3VkhVN051aWlpYkxTVS9zMGg5?=
 =?iso-2022-jp?B?UTF3UVpYY0ZDZW9DTTZiK2ZOUWVxajZYY01RbmZ6QWNTYmJDZU5nL1hO?=
 =?iso-2022-jp?B?L1FQYW53NUtlb3QrN2g2WHRRbXRuTG5jT0NPdXdxWlRMTEgxblJHdnA2?=
 =?iso-2022-jp?B?NXBKbWJqS1BibEVXOWxoVE40M2VmRW96S0Q5OTZhM2ZrSDIzUkVyc0lo?=
 =?iso-2022-jp?B?K3VXWVcyakQxMWE2S05JbGo5ZGRWcm83QlBnM1JNZFVnVU5FT3lMZUNr?=
 =?iso-2022-jp?B?bHpKRm9LZ3JrWkxxRDNoSzNBVTFnZ3RIMWRReXlJUEYyKzBBczJLVkUw?=
 =?iso-2022-jp?B?WjNpWXpDSlhESVF3N0pIamovK2JMV2EvbHJFcXJqajBzdG0wOUpmZDhT?=
 =?iso-2022-jp?B?THdyenoxVXk0WmNURm8walB6b1QwamxWOGp1ODRlTmFiMG1RS256MGlX?=
 =?iso-2022-jp?B?NkNkZkVvL2V3RUo0MFJIYm5aMzFYbDVZRTVZS2xXWWJ4Mnp1R0U3QWph?=
 =?iso-2022-jp?B?WXFpN0wwaE5FZm5aWkFVZzhkZFdDY1ZnSHNsVmlaTlVJM2tJQ1oyc1hP?=
 =?iso-2022-jp?B?MzBpa3BNQ1o2YXYzeWQxL0pMRnlsaGM0Q1h3bFNqU2VKN3JidzhhaXNk?=
 =?iso-2022-jp?B?dHdUWEpZNk90ZWJVdmZ5Z25sN1JnRnhtNW1EcUhJcW5EWXU0WlRXY1VC?=
 =?iso-2022-jp?B?T2RJSk5ONUZkeW1Gc3FKQmF4TU85eVkzZUYxZ080RGkveGI5NVMzdnBH?=
 =?iso-2022-jp?B?TDErOHlZWno0V25HNUFpWjhSazBCekM5Qmw4THNnakZVVTI1d1hJREJp?=
 =?iso-2022-jp?B?NUd2QjdHUFNDb0NZMGlwMkp2SmNjemQ4QnpOajg2UkZibEUwQ1BmMlgx?=
 =?iso-2022-jp?B?ZjN6VlB4bVpTZ2Zabjd0dFR0ZmhaekM1QWZtYUNuaXRkdjI3TlMreE00?=
 =?iso-2022-jp?B?NEFRZEo0OEt2ZHdyVWpiSTF3Sys5NWJNb3lVMjRvZU5VZkJ5VDBSQW9Y?=
 =?iso-2022-jp?B?Z1B3WGpSMlV1TGJ0MEJ3WmFxUUQ1WHg4aWtlY2Z3elBFMk5RdkhUUHd0?=
 =?iso-2022-jp?B?SEdYMEYrakZxcDVESVlDTnNiUzZWdVhOWVZLSVZKdmFKOE9oUmpYUk1a?=
 =?iso-2022-jp?B?RWRqL0N3b3dnN2JWczdrZHBUd3hrMExGY2NUS2FCaWRpRHg4N0Z3MG85?=
 =?iso-2022-jp?B?bkRDNWJZdzZwZVZwYUptdjMxaUJ5RDBKU252UWo3c0JWaU9iaWl1VDNw?=
 =?iso-2022-jp?B?dDF5YXRkMnUvb0VOYXkxcDIrbzdSeHdlNmFpMTU5TVhUaC9aS0ZPZjFR?=
 =?iso-2022-jp?B?TEpwUXNmLzIrNDNRSzIvdXgraGRnY3ljNHhldFVKMlZER0svbEVTR1BU?=
 =?iso-2022-jp?B?VU9YZTN0RFBacEZ0OXFOVk1UcmlKMHlWL0trZ0JwdThtN0FOTkdnWkVE?=
 =?iso-2022-jp?B?SjBjOVBMbGwrWkFPMm5ISGp4S0QzSDlnOWpiWFZDckkvWjd5NWtBUUQr?=
 =?iso-2022-jp?B?UzNabndzOERKZ2RJYmNZUU0zcnUvM3U5aDkzK3pxajRNUnFhdi9JeUdC?=
 =?iso-2022-jp?B?em9HdUJaMTFlWjJMTkhvSWlBTUNGN28xR0dmZUY1RU1sd09kMDE2dnli?=
 =?iso-2022-jp?B?eS9nb2trajFsblBDdXhUSyt2Si9kcldwbVU1b2JZS081c2gxa0FXTURJ?=
 =?iso-2022-jp?B?QlE5ckYrNkt6dVY1MnEvZk5Ldi96bGZKQmlUM0RBOGw0Y012dWNYRUVS?=
 =?iso-2022-jp?B?bi9KRHRiRHRrVVBJVGxPQ0x4UnNKdUcwSXc9PQ==?=
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
	aPqHXdQ/4F+/Wh9WbbptS12wsir0/8n6oDmLa8c8plc0zbqvg/l9Q40R2dbmSNGmvAI/X7VdgZXyuMFedIJxOCBGr84K3ds0ukUBgIGhToD7CKEbwUDE+dgpQ8huhvXObGSHYj7hM2ieHNfJHL2PmiHWnt9BNqqc8GZKaMCXo2TgOJcsmLYkIX49KzdpNVriF78b5CBngm90cuVKN4mlarzMl1H8m6A7O55wK4fVHr/ceK6cotDZFeTEMjz73fQP6s/mYPHIjMx4ARd8Z55VEdC7cZsWepPGRyzJ0FnhAGu+5VqQJDpcASI1ltKK0dt9ggp0TBD1rV2MSg283RBUpPTjUoJEn9fUZUwan4Vp5Z99IQjreF6Z9B8cHijIKEou3W/wN47ij+nJ7Fx4gwsgmijeF+gN9ssI8AR8AEoZa3dNgOgM1oydfIYwCXrYpR/yU0sR1/VhHAqc1ku/luuQ/oIUDG1b1h8SYvzg+R+lsb48gn/poFNVsN3YmRPw0aRMACt4fath7/dgZYP0Hlo9GbUuOyG96H6TozLKdeGMCmVfy7/hlGtWlI8MJJpVFLJtvCCspTKWvuifa0G1L/qLa9l7nsIqbQEW1g/4WvmIHLcrhNjDg1r1xhGphwCYNDnY
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB13777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c433098-a7a8-4dd0-9294-08dda4c5dc86
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 06:46:27.1671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z/a1GljUCP6IV7dc4KD81hG/YhsnKMkDrgPMMsuqvMTiYOpa7uHIqU3hD655zkfhQZQlB6gx5+e3T25IQFcyxsF8U8vAwpHx5+6sM9XuHPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12240

Hi Petr,

Thanks for your comment.

> On Thu 2025-06-05 05:27:56, Toshiyuki Sato (Fujitsu) wrote:
> > Hi John and Petr,
> >
> > > On Wed 2025-06-04 13:56:34, John Ogness wrote:
> > > > On 2025-06-04, Petr Mladek <pmladek@suse.com> wrote:
> > > > > On Wed 2025-06-04 04:11:10, Toshiyuki Sato (Fujitsu) wrote:
> > > > >> > On 2025-06-03, John Ogness <john.ogness@linutronix.de> wrote:
> > > > >> > > On 2025-06-03, "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.=
com> wrote:
> > > > >> > >>> 4. pr_emerg() has a high logging level, and it effectively=
 steals the console
> > > > >> > >>> from the "pr/ttyAMA0" task, which I believe is intentional=
 in the nbcon
> > > > >> > design.
> > > > >> > >>> Down in pl011_console_write_thread(), the "pr/ttyAMA0" tas=
k is doing
> > > > >> > >>> nbcon_enter_unsafe() and nbcon_exit_unsafe() around each c=
haracter
> > > > >> > >>> that it outputs.  When pr_emerg() steals the console, nbco=
n_exit_unsafe()
> > > > >> > >>> returns 0, so the "for" loop exits. pl011_console_write_th=
read() then
> > > > >> > >>> enters a busy "while" loop waiting to reclaim the console.=
 It's doing this
> > > > >> > >>> busy "while" loop with interrupts disabled, and because of=
 the panic,
> > > > >> > >>> it never succeeds.
> > > > >
> > > > > I am a bit surprised that it never succeeds. The panic CPU takes =
over
> > > > > the ownership but it releases it when the messages are flushed. A=
nd
> > > > > the original owner should be able to reacquire it in this case.
> > > >
> > > > The problem is that other_cpu_in_panic() will return true forever, =
which
> > > > will cause _all_ acquires to fail forever. Originally we did allow
> > > > non-panic to take over again after panic releases ownership. But II=
RC we
> > > > removed that capability because it allowed us to reduce a lot of
> > > > complexity. And now nbcon_waiter_matches() relies on "Lower priorit=
ies
> > > > are ignored during panic() until reboot."
> > >
> > > Great catch! I forgot it. And it explains everything.
> > >
> > > It would be nice to mention this in the commit message or
> > > in the comment above nbcon_reacquire_nobuf().
> > >
> > > My updated prosal of the comment is:
> > >
> > >  * Return:	True when the context reacquired the owner ship. The calle=
r
> > >  *		might try entering the unsafe state and restore the original
> > >  *		console device setting. It must not access the output buffer
> > >  *		anymore.
> > >  *
> > >  *		False when another CPU is in panic(). nbcon_try_acquire()
> > >  *		would never succeed and the infinite loop would	prevent
> > >  *		stopping this CPU on architectures without proper NMI.
> > >  *		The caller should bail out immediately without
> > >  *		touching the console device or the output buffer.
> > >
> > > Best Regards,
> > > Petr
> >
> > Thank you for your comments and suggestions.
> >
> > After consideration,
> > I believe that there is no problem with forcibly terminating the proces=
s when
> > nbcon_reacquire_nobuf returns false at the pl011 driver level,
> > as in the test patch.
> >
> > It feels a bit harsh that a thread which started processing before the =
panic
> > and then transferred ownership to an atomic operation isn't allowed to =
perform
> > cleanup during panic handling or the grace period before the CPU halts.
> >
> > I would like to hear your opinion on this.
> > If nbcon_reacquire_nobuf() could acquire ownership even after the panic=
,
> > then driver-side modifications might not be necessary.
> > (The responsibility to complete the process without hindering the panic=
 process
> > would still remain.)
> >
> > Would it be difficult to make an exception to the rule,
> >   "Lower priorities are ignored during panic() until reboot,"
> > depending on the situation?
>=20
> Good question.
>=20
> The following two problems came to my mind:
>=20
> 1. As John, pointed out, the fact that non-panic CPUs are not
>    able to acquire the context allowed to simplify the implementation.
>=20
>    I think that it is primary about nbcon_waiter_matches(),
>    nbcon_owner_matches(), and the related logic. It was documented by
>    the commit 8c9dab2c55ad7 ("printk: nbcon: Clarify rules of
>    the owner/waiter matching").
>=20
>    But it seems that nbcon_owner_matches() is safe even without the rule.
>    The race is prevented either by disabling interrupts and preemption
>    or by taking device_lock().
>=20
>    The rule prevents a race in nbcon_waiter_matches(). But it seems
>    that in the worst case, more CPUs might end up busy waiting.
>    And it would be acceptable during panic().
>=20
>    So, this need not be a big problem in the end.
>=20
>=20
> 2. If we allowed non-panic() CPUs to acquire the ownership, it would
>    increase the risk that the panic CPU will not be able to
>    flush the messages.
>=20
>    But maybe, the problem is only when the architecture supports
>    proper NMI and non-panic CPUs might be stopped anywhere.
>=20
>    It should be less problem on architectures without proper NMI
>    where the non-panic CPU could not be stopped in the problematic
>    situation.
>=20
>    So, maybe, we could relax the rule on architectures without
>    proper NMI.
>=20
>=20
> The question is if it is worth it. Is the clean up really important?
>=20
> Note that the clean up will never be guaranteed on architectures with
> a proper NMI. They would stop the non-panic CPUs, including the printk
> kthread, anywhere.
>=20
> And I guess that the console devices will be initialized after the
> reboot anyway.
>=20

Understood.

At least for pl011, a forced shutdown does not cause any problems.
(Since clk remains enabled and CR maintains a transmittable state,
it does not hinder the panic handling process.)

I'll create a revised patch based on the patch I posted for testing this ti=
me.
Please allow me some time.

When I submit the patch,
I would appreciate your continued assistance with reviews and other aspects=
.

Regards,
Toshiyuki Sato
