Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4B9173;
	Thu,  9 Jan 2025 01:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736384755; cv=fail; b=Tp5//XvW9Ao7GBtjp+X9XqfjZZb24GOUZXNns0nOofLB6UDhDm3ce2lu+KMH6DWYf9Nf05hW/nKIzf/o0Dcq9Jf1yR8ebZPMc8BA4U0egmI5Ul64jcz3kwSgZs503b5oTRCSo1wdunnjxyy6LPmr+ff4qp8odIQIufUuwlCIBto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736384755; c=relaxed/simple;
	bh=Yl02yfYGJOf1XkUkh+k3qEtEtN9W1TWBilVU4PSfcrU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F7ZqzHfXuc6jd/xSjQ2hsrY8hfGRkDYDGJFR+yaSG3flZ4SFEm4ieABBXNaSWDlai+pYIrvyzLQnotSHTsnq4r9FkDV6a/VF9kPbSX+OxByj/KZURx03m2HRdCOslJwSiV/CNGpT9gh2C2H1KffpgGIBvMK3RQu4Ih7FlcErvEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=zX1/Oi2z; arc=fail smtp.client-ip=68.232.156.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="zX1/Oi2z"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1736384753; x=1767920753;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Yl02yfYGJOf1XkUkh+k3qEtEtN9W1TWBilVU4PSfcrU=;
  b=zX1/Oi2z19MhMo+4nOEStJJiZc/RGGFE0rq5WzLGZg2y8aUlXml1tUUy
   M0jqnhCl8p85AZYD+eeaOMqvOtRj+XZ24ZJr1dkulxul/rUOrUiYkhIK1
   eHZJT1oOy5fddqF05gVtMMKvg3Twzzi1nHqtYHsfrkOAFHIMYPL+/W9Ah
   uWE6vAJR9RAAK0x1C487eNYioHVBj5o18+pUfv8yA3wk8TOoy/ldwtzbQ
   dtawdFlqAU3q12edJS73rKVqVc2RyXgR1IoI0HfruOFfHNbXBXjK5c/Qo
   qa2Gc4cEbRgt83+KObL2M9TjiBB6kRl9YVomPTAgXyyeu4aWU6jZIK3gA
   Q==;
X-CSE-ConnectionGUID: XqEM6ifYRUC+J4ukocw7qA==
X-CSE-MsgGUID: IHVMjx/dSHurxC/FMz+/SQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="141860299"
X-IronPort-AV: E=Sophos;i="6.12,299,1728918000"; 
   d="scan'208";a="141860299"
Received: from mail-japanwestazlp17010007.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.7])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 10:04:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VjetUAQOyEiaySzvYUCAcdr23xUj2v3LEJAS/mLlVyszyy8LZN5ecnLKIlu43RCUwLCaVMzPYnj7RJIFeiH/OAYKrJoO8cvd/wRL4zqIUO7BQrGFmlbprOF/2L4BSv2VcS22QSeOq7NSYImyy05XPwnvECCXvOl+imbc1iXgXRQu2mlALZYCLT0ZGyzl/TFOzTcW6vwSXHssOwFfozYZK7xs7pnXaa/PJaqkiDAKKmKGor496vzeRTsdeMnB9Y6cqd9/zPQGjfPcote59oA+I8rNuE4qlnM2rI+LfiiV5aocbcCWm4/XOvw2sIoEmHP3cZWcS1Gbe/ezHRJmZAndxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OM0Vjxx4qlL1U7IzO4al0p9SUzTMy4H6FeYlRls/tvw=;
 b=EkwgLmA76VVJKDIxDbGxqb1nhhbdzr96rUBOsSY8rX+MToPwCufxUG2qeKMCaMv1x30YuMNc/DQoCOFxXI4x7hDdOgeJK/UGvRjHp7rYPVAxWkcqb/Cl12nyLS6jsTUo92S2EO9FO/rgYQM7CezlrWY6QPQ3jGyY11XB90UWpYBa7b2s4oxDHCOiCONlcaIHEgkQh6FyBxJUCs025xcRQJRWIwRozQOrEVD+NAXffKSNIh5o5nukyYKZ9fBSXRfGEnYey6j9/kvAnguAcF7VsMCQOq9cqYLHBGURuhlPoaLldojn9M+v7jtTnoJeHwUO23P+d0ngkSIzXuST5kI8Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY4PR01MB13777.jpnprd01.prod.outlook.com (2603:1096:405:1f8::9)
 by TY4PR01MB12780.jpnprd01.prod.outlook.com (2603:1096:405:1e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 01:04:36 +0000
Received: from TY4PR01MB13777.jpnprd01.prod.outlook.com
 ([fe80::60b7:270b:27c7:4fcc]) by TY4PR01MB13777.jpnprd01.prod.outlook.com
 ([fe80::60b7:270b:27c7:4fcc%3]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 01:04:36 +0000
From: "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com>
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, Russell King
	<linux@armlinux.org.uk>, Jiri Slaby <jirislaby@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] serial: amba-pl011: Implement nbcon console
Thread-Topic: [PATCH] serial: amba-pl011: Implement nbcon console
Thread-Index: AQHbYWdP/BV+GPA6/U6eirwXO3ZUArMMh4MAgAEUEkA=
Date: Thu, 9 Jan 2025 01:04:36 +0000
Message-ID:
 <TY4PR01MB137779148D6C8C537E7108071D7132@TY4PR01MB13777.jpnprd01.prod.outlook.com>
References: <20250108004730.2302996-1-fj6611ie@aa.jp.fujitsu.com>
 <2025010845-deceiver-imaginary-ea04@gregkh>
In-Reply-To: <2025010845-deceiver-imaginary-ea04@gregkh>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=364fdbb1-1c31-446d-8ac5-9a83f2720501;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2025-01-09T00:45:17Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB13777:EE_|TY4PR01MB12780:EE_
x-ms-office365-filtering-correlation-id: 82c2dae6-3ca6-4710-5ae0-08dd304995d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?czkwU05HYU1UMmQyVDcvSEVnV0M2dmo5TlRQaHdFTzJOQzNYaVVmNnJn?=
 =?iso-2022-jp?B?L1pFbTFuajByUjQzZS9HK1FWRTcyaGIxUVBtVFJ4N05WaHFyRmVueDNw?=
 =?iso-2022-jp?B?RFlIUkZJanBDNmNQUFBDL01LaFlkdm5GTjJydVdHY0Z3K3gvZkFsdmp5?=
 =?iso-2022-jp?B?b2ZpL2xFc0RrNXZya2EweGdOYzZCWVdqNWU4M2RVakJCSEpBdnpWZlk4?=
 =?iso-2022-jp?B?cHpodGhzWW1qTVpBZkJoNzdDT3lRR1N4WE4rYm53d2FveG45NzliWlRT?=
 =?iso-2022-jp?B?eGM0Z2ZjbnA3bEExL3YxUnFqZjBxeFFCVlZXRzc0SVlzVE5McFpWakhn?=
 =?iso-2022-jp?B?TVJZdzNBUkRkQmd1SW05OXNXSnVEKzdEbTF4YnhOR2MwenJZM0hNdW1V?=
 =?iso-2022-jp?B?WHZSWlRRaVRjMjFBL2t3UHN1MGJOYWs5UkQ1UTBnREtvSHhyVVUzYTQ2?=
 =?iso-2022-jp?B?TmZSd1ZVS2ZvakFDc2NCUmJUbzh6REN5OGpLZkxkNXVwUHFNY2l3S3Rv?=
 =?iso-2022-jp?B?dW1YVjJ1V05YeUljZmw4RE5SUU9lcEhta3JtV3JsRU9KOEtBd0szQWNM?=
 =?iso-2022-jp?B?Ym5UeXFqWWxjRDRzOENucW5NREYvdFpiVEoxZkFmazJBTEVYSmhaVkhq?=
 =?iso-2022-jp?B?dmdnbk90ZkpnYktGZ2MwVlg5SmFNM00wOGRkbGlCM0xqRGZyeCttNkd6?=
 =?iso-2022-jp?B?NWxibGgzdWpaaGU3MzF2VHNwZ01nTi9JWDhPTENUTll5SFViOVBEV25z?=
 =?iso-2022-jp?B?cXJ1V1RkaGhqNWJjNFhWNUpkZ3JqRjVqbldHNU9SWHZzSVo2Sjh6VUlX?=
 =?iso-2022-jp?B?L1l6a3haaUJodVdPZktUeVk4QW1VdnRKQ2ZSUTc4cHBNL251ZS9QaWEw?=
 =?iso-2022-jp?B?elNPWWtNdlZaTXYxNnB6Y2E1NzkrZzNYTG1zMVhRV2VPcXhMdWdYOVlF?=
 =?iso-2022-jp?B?SVcweDVQZEFBeVN3dFZOcDlYbDA1cHRiWForUHlnK21ZVk9zdjQ1NElJ?=
 =?iso-2022-jp?B?a09DaHBjYzVGMStkR0JwNHd1dHdMaVJlb1REYUZsNGIvL0x4ZWZYUWNS?=
 =?iso-2022-jp?B?ZXlmellYSDJORTRCYkR1UEFxY25FUVRQa1dUUm9kc1RtK3MraTFYZXJ1?=
 =?iso-2022-jp?B?REFhazAzMnExbHVldDdWbHJKZSt4Y2lSczJSNkRXZlp6WnNlUUxRaHda?=
 =?iso-2022-jp?B?RFRoRk9wTWVrYzVEamVpNWQvUHNRb1FreDZOLzdUOHRGUkxHVVFYazRw?=
 =?iso-2022-jp?B?T0E4THlERUVuTHdXdjllMlJlZzdvT3ZoVzQ2SVdwNFdiNXl2YTk5U2Zh?=
 =?iso-2022-jp?B?b004TmxGYjhoN1labmtvenVpZnNZSm5aNTEwbEJRWnJpN1FqdlNDYkQ5?=
 =?iso-2022-jp?B?WDJ0UUp3L1FrVmhaN0V6ajFzWlBZNVdpSkx0TVc4WFRjMmYvb0UxVmh1?=
 =?iso-2022-jp?B?SnlHNDFWRmora3U5RzNPeXVtK21mMTBJcUZudnlVNWdBdXl2MXpiZWNl?=
 =?iso-2022-jp?B?VngvT2pFM0FMZjV5T0dwQjF3SWpiRCs3VDFjeEUzVFJnY2VFRUhRUVZU?=
 =?iso-2022-jp?B?TmNSaFlSUjN4bENRdGVxbnh1cXZXR2tuT0JTMno3WFJGRVZETU1IU3Y3?=
 =?iso-2022-jp?B?dWhKbzREOThyQjlZSjM4dThLWFBqL1JWOUthZko4VDBBM0RCOWlFMlEx?=
 =?iso-2022-jp?B?U3V4QnFXc2JpZ1VUZWRyWW9oMXVYVEdLa1hnZWlCRk9YNnZ3dTJmd2pI?=
 =?iso-2022-jp?B?NWFFbUpwZlFObHZYdXFhb2k5bHFKNFR3RUJ6aHBiQU4wdytLcG9FN09h?=
 =?iso-2022-jp?B?cUNRQjZYREFtenRuQ1N0VlR1a3FKWVJCaEcvMUJRZTlZOVdFRUxXZGVV?=
 =?iso-2022-jp?B?aTRYN2s3eGVuTEtkTkR5d3Q4TjUzdnZSWkl5YTNCajRVZC9WVWxLZVlY?=
 =?iso-2022-jp?B?ZVpzeEhyVGhMSkpnOEh3NUtILzd2LzB0cU9XOFFOVmtCK1J6TnNrSzVD?=
 =?iso-2022-jp?B?UkVSeHcrdGJQK2Znb1h1eE92NjNTSHJYajRmeFRseHFsU3FuczJndEdl?=
 =?iso-2022-jp?B?SjBEN2RTNml2dy95cEs4bFJsaU9abkNxWmR0L01rU29JQ1NremtsQUhV?=
 =?iso-2022-jp?B?bEk=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB13777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?c0wveVdVSmU1RlRHUkpIMGRqVkY1ZnZoSmYzd2ZPRUFxbXhlTW5kRTYx?=
 =?iso-2022-jp?B?M1B1cGdnZDl5N0tKYUw3SERRcngxeFVDV0hkbjIza2pMZ3M1RE9laHBj?=
 =?iso-2022-jp?B?WGlzcHp4RlNubFZHME95YitqcFhBRXA3WGpJQVYzT29RSnJwWU9UZVhJ?=
 =?iso-2022-jp?B?ampjdlVZRFVrbkdvMHlvZWYxbzlQSkFtS1kwa250RXYwWlZlM2ZPSy9W?=
 =?iso-2022-jp?B?SUtYK2RSTmlvL1d6bFo0dnV6NmpvTDBHMS9RUGZnOVJROVQ5V3VuLzNJ?=
 =?iso-2022-jp?B?VTI1VlZYNy9NTkQxWGtRVGRSdGxyQTN6Z1g4bUZJTXlEKzJJVWJrSjFh?=
 =?iso-2022-jp?B?cXNqbzd3eXJKYVpKS3Y3NncxdzkxbzVsc1BydGo1WmxJZXA0L3RhNWVv?=
 =?iso-2022-jp?B?d0J6REpDRVRlaWZnRU56TVM0N1M5dGZ6d2FMYTdTU0N0VWIwZTQwNFNE?=
 =?iso-2022-jp?B?UTVaS29XN3VrOVI3UUJGMWZQT1Z6NXpuc3dxWWIxNEhHZXQvR3VJRzVQ?=
 =?iso-2022-jp?B?di95V214dkF3M2d4elFzSHVFSW15VjJsWS90aDllWTFBeE5MblVoQjBZ?=
 =?iso-2022-jp?B?NjZ4SzRxZzVGMDZvZHRjMTRHVTRIVzgvSXZ0RCtaeTdMNWNLRHdqTnJO?=
 =?iso-2022-jp?B?dkhwUGZLRS9GYjdCOFphQ1F6UnZkVFg5bGxxemNkb09CN0Q1b3pRbXpi?=
 =?iso-2022-jp?B?dU9KeDAwcjZCSFI4QmYrRlphMTNoQ3JLdXZGNnpnUzRjSG5BNlRoS2Q5?=
 =?iso-2022-jp?B?V2VzTkFIeUNWc29vdk1DWEpVeDdwbU1YM0gvS2xYT1psM2JtOUxZdEU1?=
 =?iso-2022-jp?B?d0J6WFo1Q1NXVU5Xekx3WHA0U0NQWjVZWXEwTWREMlZpa1gxMHYwRXhL?=
 =?iso-2022-jp?B?cURhQ2JqdjZYalMvZERLVGtRN2UrN0FYNTJ4VHR5eFY5TDlmYUIvQTVU?=
 =?iso-2022-jp?B?bjRoamhqclovcy9uN2w0TFMrQUJvRXJlUGZIRSsyV3dEY0owaDlwZzZO?=
 =?iso-2022-jp?B?ajk1OXJxUjVBakExOHJKR3ZOVkp5Z3Z0SHN3Sk5MOXBTUW5TQ1hPOWdH?=
 =?iso-2022-jp?B?RDJwWDltVTdHVXlkZFdKdEpmMDV4VzQyWDZhZWVyUkhQRk1OUzREbnV6?=
 =?iso-2022-jp?B?MkN0QmJTUllXUzVzRW45Mkkza2VsbXprRWFvSUx3TXlzcG9ibzN0Y2xD?=
 =?iso-2022-jp?B?bnlvTGNmVXNkcFliMDBwQjF1SEhGc2RRYTF2bHFnY08zb0RYemtDYTF3?=
 =?iso-2022-jp?B?WXRES1BvN2xZMkVIQitCa1EzTkNUOVo2R1ZlNGtodHpVclBWekE0YVVJ?=
 =?iso-2022-jp?B?RkFNNTkzMGVtU2pMdmZ6VlEvU3lQdGVKYmFqZ1NjK2NDWFhYVStjclBj?=
 =?iso-2022-jp?B?UUV5UW1YaExaVWd4SG1QZlpuSElPMDdFcGYwQ3FYV281ZEY4YnNYWDdu?=
 =?iso-2022-jp?B?T2N5QnVBOTg1b1QzK3hzVlQ2VzRHcHBpeUZjWjFzamVzcTVVSzRuQnFZ?=
 =?iso-2022-jp?B?VFE1V3AwU2UzZkFRRG9CdDgzZUlxanRiU2pMR0lCQUVuZmVjYXg5RG1E?=
 =?iso-2022-jp?B?cVdTVm1SMmFyL3Z1d1VndCtPbWMzNlBGS28vZjhJNTZiZDJ6Y3lBSHJJ?=
 =?iso-2022-jp?B?VHRLbGowOWdOSi9Td1k2TzUwTy9PSHFCVXZkcUtvQXYxTXpTeHh1ZEd5?=
 =?iso-2022-jp?B?cDdBVmRoWjN1d3l1WlV5aEJySEJqa0Q1eEg5Y21UNnhxN2FvdWJHSDBG?=
 =?iso-2022-jp?B?dGdhTkx4K1VkM2h6ZTk3dWI4RjJmaVN3Y3lVV2ttRDVxMUFFajhVNjFr?=
 =?iso-2022-jp?B?NEpWcCtkL0xmTHZhWm5zVFFtRmtpaFlDbmNRenNUUmhDaFR5cFVYeDRl?=
 =?iso-2022-jp?B?VWR6TkErd2FMeFloNEJTT0pKbkZmMUtEWlpEaHFhcFBIS1o3Z1FOcG8v?=
 =?iso-2022-jp?B?TWErMExQdFZaZi9wcEs1VVBUTXZaYm8xQU84dFlzb2x1V3ZQL3U1Mndu?=
 =?iso-2022-jp?B?WWhnL0pCNElZanptTGJLWThvWjI1VnlLWnJRdVBvZGFNcnhOSDlTdzRR?=
 =?iso-2022-jp?B?ZUNuWmd5b1pVTXhFY0IwK0FsYU14ekpxWkU3cVNySFJ5Yk1rK1pyaWdE?=
 =?iso-2022-jp?B?NHFMVUJqcm1XaGMvbWoyTXdGd3IvTnBqbmhKYXI3aS93cUswVm9FczZT?=
 =?iso-2022-jp?B?cTBuZWZxdTc4bE5SbmhoUGdNamJGc3JqNUpFZmk5STdia01xV25VeE1Z?=
 =?iso-2022-jp?B?eW0yaG5lMmczKzJaNm51VHNOWGNLTk1aMW0vL2s4eEtIWEpPZmljcUh1?=
 =?iso-2022-jp?B?cUFnRw==?=
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
	xxniAAYBkmdMu15WBkUcXvMtWINPYNpVj5JlUDJblbvk8OH+Nwyp/VgnJlNFo1nqLSfATuBqwmhjziiTcQlvvUh9CL3kljy++bHsA5HRJfci/Bdo0oXxXC5LxKvjz8cKy43dHsbN9C1oMIa9MqY2ISvnTrPkPyVGVHej7d8H8kd7K3+Yx7WmWSdDzqxZdcNulvaydltjN1ODXEU3GKkcqHeHjLi6F43tC76qIzy2Du9EhBrEXoWG/M5cGOYhJ0KLZth64q9JdCnokcvtSE8ENPJbsZpoaT8F2I7EzSOfpe3mp3zFwhH6qp/BCarlamRT29wq3V0+efgnsKV3vEj0f3J0LN+DvZF0i4rs261n1p1URUxlt3EN23555jWspshVQxCCHGDyW9MfBsdyoXQqdwIOrz7xhGB+KxHIHWPD3DMhTySKgjNN31Ligiivod0bQEJ3ZFpZTUjZDwxVzwhjwprw5OKEFGQHJZVVQNS0xVtNCjMzS7H414JKmG8hx6inr9dmfO9jz7/lv11LVXZoMqgEqVYxi7lAU50IileeY1i1pqQg8sZWozZ1c7nUiL2OwTwtTYDwxzSOoh9+MmxgIQynO2Ex6PavdoK8OYeEFzPfS8e28btv1HCnqB+J32W2
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB13777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c2dae6-3ca6-4710-5ae0-08dd304995d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 01:04:36.1121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xh6RXkxE9uxboTIzlEXoWKC3vZBL7K8OtJDAarP49OgSOE+2mWDKeyHUuVfEjuWFFc0VEzADz93+VsHDagzXYWtJwyJKc/iM9gHyNxSEo8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12780

Hi, Greg. Thanks for the comment.

> On Wed, Jan 08, 2025 at 12:47:30AM +0000, Toshiyuki Sato wrote:
> > Implement the callbacks required for an NBCON console [0] on the
> > amba-pl011 console driver.
> > The codes for legacy console are retained, and the module
> > parameter (use_nbcon) allows switching between legacy and NBCON.
> > The default is off (use legacy console) for now.
> >
> > Referred to the NBCON implementation work for 8250 [1] and imx [2].
> >
> > The normal-priority write_thread checks for console ownership
> > each time a character is printed.
> > write_atomic holds the console ownership until the entire string
> > is printed.
> >
> > UART register operations are protected from other contexts by
> > uart_port_lock, except for a final flush(nbcon_atomic_flush_unsafe)
> > on panic.
> >
> > The patch has been verified to correctly handle the output and
> > competition of messages with different priorities and flushing
> > panic message to console after nmi panic using ARM64 QEMU and
> > a physical machine(A64FX).
> >
> > [0] https://lore.kernel.org/all/ZuRRTbapH0DCj334@pathway.suse.cz/
> > [1]
> https://lore.kernel.org/all/20240913140538.221708-1-john.ogness@linutroni=
x.d
> e/T/
> > [2]
> https://lore.kernel.org/linux-arm-kernel/20240913-serial-imx-nbcon-v3-1-4=
c62
> 7302335b@geanix.com/T/
> >
> > Signed-off-by: Toshiyuki Sato <fj6611ie@aa.jp.fujitsu.com>
> > ---
> >  drivers/tty/serial/amba-pl011.c | 113
> ++++++++++++++++++++++++++++++++
> >  1 file changed, 113 insertions(+)
> >
> > diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-=
pl011.c
> > index 69b7a3e1e..52fab3170 100644
> > --- a/drivers/tty/serial/amba-pl011.c
> > +++ b/drivers/tty/serial/amba-pl011.c
> > @@ -41,6 +41,7 @@
> >  #include <linux/sizes.h>
> >  #include <linux/io.h>
> >  #include <linux/acpi.h>
> > +#include <linux/moduleparam.h>
> >
> >  #define UART_NR			14
> >
> > @@ -263,6 +264,7 @@ struct uart_amba_port {
> >  	char			type[12];
> >  	bool			rs485_tx_started;
> >  	unsigned int		rs485_tx_drain_interval; /* usecs */
> > +	bool			console_line_ended;
> >  #ifdef CONFIG_DMA_ENGINE
> >  	/* DMA stuff */
> >  	unsigned int		dmacr;		/* dma control reg */
> > @@ -274,6 +276,10 @@ struct uart_amba_port {
> >  #endif
> >  };
> >
> > +/* if non-zero, the console is nbcon. */
> > +static int use_nbcon;
> > +module_param(use_nbcon, int, 0444);
>=20
> Why is a module parameter needed here?  That feels wrong and not
> scalable at all.  What happens if you have multiple devices, which one
> is nbcon and which isn't?

This module parameter is for pl011 driver.
With this patch implemented, only one type will be usable, depending
on the value of use_nbcon.
I thought it would be more user-friendly if legacy operation could be
selected via boot parameter.
Would it be better to make the patch purely nbcon-compatible, without
retaining the legacy functionality?

>=20
>=20
> > +
> >  static unsigned int pl011_tx_empty(struct uart_port *port);
> >
> >  static unsigned int pl011_reg_to_offset(const struct uart_amba_port *u=
ap,
> > @@ -2305,6 +2311,7 @@ static void pl011_console_putchar(struct uart_por=
t
> *port, unsigned char ch)
> >  	while (pl011_read(uap, REG_FR) & UART01x_FR_TXFF)
> >  		cpu_relax();
> >  	pl011_write(ch, uap, REG_DR);
> > +	uap->console_line_ended =3D (ch =3D=3D '\n');
> >  }
> >
> >  static void
> > @@ -2411,6 +2418,8 @@ static int pl011_console_setup(struct console *co=
,
> char *options)
> >  	if (ret)
> >  		return ret;
> >
> > +	uap->console_line_ended =3D true;
> > +
> >  	if (dev_get_platdata(uap->port.dev)) {
> >  		struct amba_pl011_data *plat;
> >
> > @@ -2494,6 +2503,106 @@ static int pl011_console_match(struct console *=
co,
> char *name, int idx,
> >  	return -ENODEV;
> >  }
> >
> > +static void
> > +pl011_console_write_atomic(struct console *co, struct nbcon_write_cont=
ext
> *wctxt)
> > +{
> > +	struct uart_amba_port *uap =3D amba_ports[co->index];
> > +	unsigned int old_cr =3D 0;
> > +
> > +	if (!nbcon_enter_unsafe(wctxt))
> > +		return;
> > +
> > +	clk_enable(uap->clk);
> > +
> > +	if (!uap->vendor->always_enabled) {
> > +		old_cr =3D pl011_read(uap, REG_CR);
> > +		pl011_write((old_cr & ~UART011_CR_CTSEN) |
> (UART01x_CR_UARTEN | UART011_CR_TXE),
> > +				uap, REG_CR);
> > +	}
> > +
> > +	if (!uap->console_line_ended)
> > +		uart_console_write(&uap->port, "\n", 1,
> pl011_console_putchar);
> > +	uart_console_write(&uap->port, wctxt->outbuf, wctxt->len,
> pl011_console_putchar);
> > +
> > +	while ((pl011_read(uap, REG_FR) ^ uap->vendor->inv_fr) &
> uap->vendor->fr_busy)
> > +		cpu_relax();
> > +
> > +	if (!uap->vendor->always_enabled)
> > +		pl011_write(old_cr, uap, REG_CR);
> > +
> > +	clk_disable(uap->clk);
> > +
> > +	nbcon_exit_unsafe(wctxt);
> > +}
> > +
> > +static void
> > +pl011_console_write_thread(struct console *co, struct nbcon_write_cont=
ext
> *wctxt)
> > +{
> > +	struct uart_amba_port *uap =3D amba_ports[co->index];
> > +	unsigned int old_cr =3D 0;
> > +
> > +	if (!nbcon_enter_unsafe(wctxt))
> > +		return;
> > +
> > +	clk_enable(uap->clk);
> > +
> > +	if (!uap->vendor->always_enabled) {
> > +		old_cr =3D pl011_read(uap, REG_CR);
> > +		pl011_write((old_cr & ~UART011_CR_CTSEN) |
> (UART01x_CR_UARTEN | UART011_CR_TXE),
> > +				uap, REG_CR);
> > +	}
> > +
> > +	if (nbcon_exit_unsafe(wctxt)) {
> > +		int i;
> > +		unsigned int len =3D READ_ONCE(wctxt->len);
> > +
> > +		for (i =3D 0; i < len; i++) {
> > +			if (!nbcon_enter_unsafe(wctxt))
> > +				break;
> > +			uart_console_write(&uap->port, wctxt->outbuf + i, 1,
> pl011_console_putchar);
> > +			if (!nbcon_exit_unsafe(wctxt))
> > +				break;
> > +		}
> > +	}
> > +
> > +	while (!nbcon_enter_unsafe(wctxt))
> > +		nbcon_reacquire_nobuf(wctxt);
> > +
> > +	while ((pl011_read(uap, REG_FR) ^ uap->vendor->inv_fr) &
> uap->vendor->fr_busy)
> > +		cpu_relax();
> > +
> > +	if (!uap->vendor->always_enabled)
> > +		pl011_write(old_cr, uap, REG_CR);
> > +
> > +	clk_disable(uap->clk);
> > +
> > +	nbcon_exit_unsafe(wctxt);
> > +}
> > +
> > +static void
> > +pl011_console_device_lock(struct console *co, unsigned long *flags)
> > +{
> > +	__uart_port_lock_irqsave(&amba_ports[co->index]->port, flags);
> > +}
> > +
> > +static void
> > +pl011_console_device_unlock(struct console *co, unsigned long flags)
> > +{
> > +	__uart_port_unlock_irqrestore(&amba_ports[co->index]->port, flags);
> > +}
> > +
> > +static void
> > +pl011_console_switch_to_nbcon(struct console *co)
> > +{
> > +	co->write =3D NULL;
> > +	co->write_atomic =3D pl011_console_write_atomic;
> > +	co->write_thread =3D pl011_console_write_thread;
> > +	co->device_lock =3D pl011_console_device_lock;
> > +	co->device_unlock =3D pl011_console_device_unlock;
> > +	co->flags =3D CON_PRINTBUFFER | CON_ANYTIME | CON_NBCON;
> > +	pr_info("Serial: switched to nbcon\n");
>=20
> dev_info()?

If the "use_nbcon" switching function is to be retained, I would like
to change pr_info to dev_info.

>=20
> thanks,
>=20
> greg k-h

Regards,
Toshiyuki Sato
