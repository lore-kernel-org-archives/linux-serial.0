Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com [216.71.158.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7DE40BF5;
	Mon, 10 Mar 2025 07:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741593433; cv=fail; b=SLaptXJsRWWYVGPN2YGzJlBLmP9X13rUcl5wAKvIU9AD66i//91uPorZEUAfAtKB75n/HtMVLHTh+cf5nkTZ7VVmn+1Qt+itkxd3wQcqF6AKOWUhe3S0O1Obp3WI0AIBnLN6OEfX2+5heY5HaCdoEDgbe1WXCa0w481Qsvmei9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741593433; c=relaxed/simple;
	bh=oUhzzVG7girx94yl6ZN4rUNPV47qWAfQh7AmjpLtOe4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s6gAlj9pohvXCo0ZYd8YjP2qmfCO2v8Rk5N056IZ35KB6HHseYTgOktC24GunrL4PxNj4KF2HZ71Kk72zqIP7bdJKYGw0mqSZi8/j+cn24FASutSkEMbrci4aEJzfaob4pnzU5Ht6TU5tWzr4EeiW1tiDPjcyXd01J9rFmuB8ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=yaPTwLuQ; arc=fail smtp.client-ip=216.71.158.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="yaPTwLuQ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1741593432; x=1773129432;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oUhzzVG7girx94yl6ZN4rUNPV47qWAfQh7AmjpLtOe4=;
  b=yaPTwLuQbZhNGp4LkiHOZKmNbqOlVSJQaU21J792je3/Lz+DnCM2T7M1
   fMlIOsDM0Qnxi+ZrBNeZwjPTt1YH7sUAPDHficCIKPrLei4q92vytqOv+
   E+BcYBt/aCOOIOKO8XMa9QBlWxZkZ/fvv72m7mUe4VTrLalkeFlpXNZc0
   e/PqaPlq+oMSsEZQNnvlZg3adg2wF6uEKO6fP0qOTppGebIKsXNyl6uoG
   kKvR+MgFBUZiPaqbPzHHW54ns+YxMAeJ4YoPkpdHYbwz8vYpyAclbGDeF
   yXju0hHqjsnS/MyaX3edPYeY+JsE7P4SeHMyYZlX/F1p7gC+2rI8+qA5+
   A==;
X-CSE-ConnectionGUID: ngry82hqT4ykfhBZvydOiA==
X-CSE-MsgGUID: lebzQXGVThy6rw01fFqeFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="148885550"
X-IronPort-AV: E=Sophos;i="6.14,235,1736780400"; 
   d="scan'208";a="148885550"
Received: from mail-japanwestazlp17010001.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.1])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 16:57:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpP9Nk3bjicY0JK92fTNJh34h7vWlVyIBYw9je/qFmONqmqI3ZAcXaW7LtHkac4nc5udWxrz3dBDnVSrr0dkOeUCJ4gah17L1eUKlNjyGj/scMQG8aIAk9jXahNPCkz1g1pxoEpV8J6CGQLktw3waF6lvutdunexU+v8nIXApKIyRs83dDJNofQi4f+HqiEIqJVorx2Y9j5fFCasqENHEbtUF8uqMe5Jo+lWFlJpP8Zgf/wx0Xww9OF3ff66VjNEYk3qV3ycLs1ClWjUjCx3/+iGOlFbFwiygpTcRafFXjQbEVy/2qw6YkAVMB7c7p6fx9+EZ2N4fGXH1B2VYlhHJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ute0u15/UsD0Pa1QFvbPAr+3H/lGg7McqfrCDDLmAsA=;
 b=edeWa8Dar4SMb8R9ILDVTgjSgRbx/us7mrbLQyJlsH584BPFyXQC1d+NvJyzF8qAfjWBfVfhYRTyECkfz/CPbmyJ0YNMhpHa5PD65+XDZ847ElcTyJN1RYNnDbnPXyX0dPy/819zj7nSgJiIFSNovReYNZw/tQRdqyQr52oTzFJYQAzjJCGonh2BCHQXYYV7N/4bJbIO8hZ6OL5nhwbFL++oWihBuFLHqvFto6Iee7UgFFL1IfGrd438JJZ8m/CMWgEo/SgW1e0n7RoIE2SbLVQCsqVbBWQm63EtZjykpe1m+FZrPuCHcVp+SfXp/J9AV41/ABGOeQyviyt0sDhu6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY4PR01MB13777.jpnprd01.prod.outlook.com (2603:1096:405:1f8::9)
 by TYWPR01MB11748.jpnprd01.prod.outlook.com (2603:1096:400:3fa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 07:56:58 +0000
Received: from TY4PR01MB13777.jpnprd01.prod.outlook.com
 ([fe80::60b7:270b:27c7:4fcc]) by TY4PR01MB13777.jpnprd01.prod.outlook.com
 ([fe80::60b7:270b:27c7:4fcc%4]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 07:56:58 +0000
From: "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com>
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
CC: Russell King <linux@armlinux.org.uk>, Jiri Slaby <jirislaby@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Toshiyuki Sato (Fujitsu)"
	<fj6611ie@fujitsu.com>
Subject: RE: [PATCH v3] serial: amba-pl011: Implement nbcon console
Thread-Topic: [PATCH v3] serial: amba-pl011: Implement nbcon console
Thread-Index: AQHbdr+P/ilVjo1KfU2BeYco8MFTb7Nr171QgABOZ4CAAAg8sA==
Content-Class:
Date: Mon, 10 Mar 2025 07:56:58 +0000
Message-ID:
 <TY4PR01MB1377756007BB974DB671F01FED7D62@TY4PR01MB13777.jpnprd01.prod.outlook.com>
References: <20250204044428.2191983-1-fj6611ie@aa.jp.fujitsu.com>
 <TY4PR01MB13777DB55F2231F7399E42609D7D62@TY4PR01MB13777.jpnprd01.prod.outlook.com>
 <2025031001-outwit-outsider-b34e@gregkh>
In-Reply-To: <2025031001-outwit-outsider-b34e@gregkh>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=6eb0eead-3f74-4cf8-8570-aea9cc78c934;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2025-03-10T07:36:14Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB13777:EE_|TYWPR01MB11748:EE_
x-ms-office365-filtering-correlation-id: 89e123a8-2221-45c1-5413-08dd5fa921f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?OWI5Nk9WcFNsN3BmQXAyV1NaZVlXcWJJTHdkcVVTOCswYjM0Z1Z6bGVR?=
 =?iso-2022-jp?B?dTZXWW1FRXBYY0FjczBwNkhRb25rOXRobk5xMXdDcysvNWJGS3Z0ZTVl?=
 =?iso-2022-jp?B?YitCd2V3UVJNRlZhZG9wMHhpNDRrb3FxU2lURWlBSU9KK2tYTXNEbCtv?=
 =?iso-2022-jp?B?WmhZcWRpaG5zNUhMUm81eEVwQjZueDNaZ3hJZWMyaFF4SmxibHZWZyta?=
 =?iso-2022-jp?B?Q01mdjJ0T3NXbDAyL2Z0RTdMaE5MUjJ6Wk1GRTRTc0lkKzBWZkMwRjdM?=
 =?iso-2022-jp?B?NnRSUzBWVTV4cmhUdGYrSEVXeTUzTTV3aElLdXRaSVE0QnlLazNVSU45?=
 =?iso-2022-jp?B?RzhiTkhoakJKUTRBWWZBaTFvbFp2clhodFNySWhGdmJGQldDa01vZEFG?=
 =?iso-2022-jp?B?Y1ZsN3hmR1RBS0xTUmUvV1hYZ3NQSFB6K2tuRUx5ZkpiNFh0QWlMdkpk?=
 =?iso-2022-jp?B?RmRocXlSb0VweVoxdDc1bzBTZ2RVQTlOV0UySWJ4M3pndElzaXp0WGRY?=
 =?iso-2022-jp?B?NVFOWFdLamtBWWZxcmI4VThzNjNrQTFqNkR1VGw1b0xGRnN4ZTYyalFi?=
 =?iso-2022-jp?B?S1Q5c0ZBTUJFUU9ubmFuVGN1WHk2a0pRYjZTbHpMQU1rY1pvMkZkTmkz?=
 =?iso-2022-jp?B?dkNGTkxNOWFaUmYwNm1DVTZYWVpVanpLcDVWREw0VjFQWTdNRllpVG5h?=
 =?iso-2022-jp?B?bTdncjN5QVgyNXRBMkZqNmluYmNIejZabWRkRjNvM1ZGU1NLN0lrSkp2?=
 =?iso-2022-jp?B?WkdENENlcWJOQUlYd1R5Vys3dnUzc3ZYbldEcWFHWE01ekUwbHQ0Mm5p?=
 =?iso-2022-jp?B?K1daTDE3ZWZTdmdJVVJJYjI2dkwvcWxLNDB1cTJnSGFMR2dyQ09TWmtD?=
 =?iso-2022-jp?B?NWlaVVBGaTBhUlBrSWFJSExPZlZpUGxyQ0NFQXZTL0RZYjNQRVpWMG5S?=
 =?iso-2022-jp?B?Z1J5bEJJL3hxdERmcG9OZmc1bVdjTlpDcjQrL2JpSENjbXlLN0ljeFFj?=
 =?iso-2022-jp?B?N2ZhZFJ1dWllUHJhODhZWGw4NmFjSHVuZ0c3S1QrdXdPNU5BMWFZQjNz?=
 =?iso-2022-jp?B?dDVnSE5hNTUvOU81Q1Q2Lzljajlqc0JEYkhMUVNBQzRTVzlnYTZhRjY2?=
 =?iso-2022-jp?B?eU1VRVhucDJJNW81Qmk1TmNQQ2JiV3QvMFByNk92Q3ZzSUJJQzh2eWNl?=
 =?iso-2022-jp?B?U3M4S2xXa0owSjRwc291R2tqdk1RZFFLL0didnU3em9yclBxbC9rUEdE?=
 =?iso-2022-jp?B?bDdLREtyYStZd21DTmVSN0U0T3hRTjRkRWlLTERPVTRDajlCeUpnNzJh?=
 =?iso-2022-jp?B?U3hJZTNmMnFvbElYTjJqeldXM1A5YUdhazFwR1NKVjB0VTl5WkhyNVVo?=
 =?iso-2022-jp?B?cVY0d1BXNi9ES1pNQ1lOU20zZnVuUVN5ZktRWmxBSytnWndZd1NmMzUx?=
 =?iso-2022-jp?B?bWJBbXNTMUp1TU5LOHR4MmxhS21OWFRqVmVtamlnZElNSm5jak93dzM2?=
 =?iso-2022-jp?B?RHhnT09aYktzbFpiYXFBM0N0UkI3ZDNtYVdrNlExQUNFbHl6dVB1bURC?=
 =?iso-2022-jp?B?WGIrM2FZUzhpSDI1bFlRSnZvMFYwdFppbW5lQVhuVTUwZlpmc1l5SFhO?=
 =?iso-2022-jp?B?eWs5eG56cGFvRDJrVi9INHQvRHJ5Z3lVNUFuSEZwVXFiMk5JQjJwNjJt?=
 =?iso-2022-jp?B?UEZJYTdIbFpzV2lLR2RLa3hTakliSzRyRDNMcStWOUpzN25rdUM4eFgx?=
 =?iso-2022-jp?B?elBkdzlNWm1IelhxWjRYVmlYY3Y5TERKVTBBOXRFbVBkYTZxZVpFdzdC?=
 =?iso-2022-jp?B?d2JLNURXV1BVa1dKRzJSYWU5UXJCOXY3R3NlVFVaSXliaUQrbWhLZDNC?=
 =?iso-2022-jp?B?U0hPSlhFNE1KUDFXdUFKZlBrWEpxWUFRTmtwYUF1YXIrc3Boa3hneGp4?=
 =?iso-2022-jp?B?YlMvMVQvUEJjZS9LY1JZQzhIb0llMkxHY0dCN0xlM2lwMnQ3Sk1ya3R4?=
 =?iso-2022-jp?B?U2hxb3NIN20waWhrcWZZekJHRDdGaUlvWU1LdEtBRlVqaXVqTHZDZldJ?=
 =?iso-2022-jp?B?Z2x4VzArMUg1S1grQjVoMXJvSTFRS2w1Si8yNndPTjJYZCt0TlY1aC82?=
 =?iso-2022-jp?B?SHU5b2gvLy9WQm4wMkJsYXhIVkZHTDhBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB13777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?M3ZnR01VaklsR2FYNlFKQ3BBb1J4c3J5ZVlUbkUrQUpOTnB1b0ZzQm80?=
 =?iso-2022-jp?B?a2w2RkhwS051aHo4cndTVTM0cTA2Yi9kWEUydEpla1pPeXdKeDlldFJY?=
 =?iso-2022-jp?B?MHUweERVRkpydjlqd2FPV3Y3V3dJRk82TkxPS0FoYWNvRWxCNXZUV3RU?=
 =?iso-2022-jp?B?L2YxTWpZNVlFclRMb01zRG9NZmhTajN4VUJIS1lhNExlVGxWazRpN1BY?=
 =?iso-2022-jp?B?NWdMaUhJM0g2bUF3YS9kTWJIN1VCMGdqSWlqYTBtNWx3Qk83bjRGYzk1?=
 =?iso-2022-jp?B?dm1uRTRjS1pEcFQzaS9nWUJVd3pCN2NITGowZVp5WERMWWVyczlieWcz?=
 =?iso-2022-jp?B?NVRPZVlhU0FGYVZpVi95c0VGMXRGRElsZy9lSGxOTkVRMGlrby9DUXl5?=
 =?iso-2022-jp?B?V1A1WEJyVzFYcmdPVkE0dURBekNMYnpTMkZoNTBqNldPYm1lVlhPQkF0?=
 =?iso-2022-jp?B?WlcvN3F6TFZ4emlHajNDaUg3SmRJK2lwbjFZMmQ4OW5qMEcrZlVIaDVT?=
 =?iso-2022-jp?B?ZlFNVUtmU2hPMmh0am1Ra1RXMk1jcFJvK21EWUFQWUw5d0VQU0k0T1Vl?=
 =?iso-2022-jp?B?VUhwakdXcDFid2VqN0ltY0RvQXEyR1k4YkxZbUZEMUx6RWhiM2huUFlx?=
 =?iso-2022-jp?B?L3VPbnRJeG4yV1AwcGNYcXQvR2RrNE9ZRWdxbGM5dUFEL1FNQzRyc0xk?=
 =?iso-2022-jp?B?TkpvK2VvNDJQbC9RQzNIOXpMczZQUXJBMlZQZm9VcGRHdGZmMVdCQWJR?=
 =?iso-2022-jp?B?a3FNdFQ0Nm9mZ0lZcUNieFVYSkluOUxpK1lCUXBaQUtkM2Q0WDdwOE5o?=
 =?iso-2022-jp?B?MEMxNzd4OU5MbkxxR2RnbmFCb29uQmxiYm56dHZrS0NtaDcwMGFzNWc0?=
 =?iso-2022-jp?B?TG9HZUZ4U28yMHM4SkVyNWhDV1dUb2s1bUNhN0hwZXBDMmlsbDBxMXhB?=
 =?iso-2022-jp?B?SGNkQkRJVU00YzQ5ajFaQ1RpKzZON0lMU1dWaWM4RFdzVzhVWXZNcHli?=
 =?iso-2022-jp?B?K2s5UWVJSzF3VW9EL0VRY2I1WHpINy9xN2NzUXRoYk9nNHVuekgvVFhm?=
 =?iso-2022-jp?B?cVMyc3Q4K1h0Rm9aYnlGcG1PdXlVU2dmMWZVUWFzamNRSi9qeXdhbHdQ?=
 =?iso-2022-jp?B?WFR3VEZpQnUyZ0djcE9oRHN1cGMwUWY4WmRIMUg5a1YrK0ppZFlSMXBk?=
 =?iso-2022-jp?B?RFFCS3lpUU4veVR1Vk8wOU5NYVNJdnVUT3JOTXNRallNMHUwVW5zT3Qz?=
 =?iso-2022-jp?B?dDkxemNuTkdnVjdsZVg4cWRYVFFYRk92TitveWJ2VkswSm13WVJnSjJn?=
 =?iso-2022-jp?B?Y2hNb3liaXRUMFNkSmdUbEd1Q1lScDl0eEg4QWp1eFhVeU1RdlhKOUF4?=
 =?iso-2022-jp?B?U1hmaEIzSHJ4L3E1NlFDeW53aUIrN3dremlqWUdKVHdxdytlNms0MVJl?=
 =?iso-2022-jp?B?c2x3dG1yK3VFdXdTOXA2TVpWeWdkQTJtWk9JejJiaFFrcmpRdVVOdTc0?=
 =?iso-2022-jp?B?TFRCaUdsRHpHYUhSSmJUcWN1VFdKQWxuZEtCeWdjZEVNdW41SjdoaVVs?=
 =?iso-2022-jp?B?c3FHVGtJaHlzdWZmK1lKMXJxWWJIR2xDS2YyNHR0anNFM3VLUFBvMy9Z?=
 =?iso-2022-jp?B?UFlWeGhGbWd1cnlKN0FQdEQwR2dDdXp6MGlZenJDYWdiV2EzeEdJVFI4?=
 =?iso-2022-jp?B?S2FIa25PN3A0K1diL0FpY1hEVlN6SlNBeWNqV2t1U21UVWYxS2FJTHRT?=
 =?iso-2022-jp?B?VzVXUE1ja1doN0hnZ1ZSakh0MENacGMvaDB4TGF3NFY4dzEyZVpHQmVk?=
 =?iso-2022-jp?B?R01mMEhzZ3RTNlZlUVEzZ2M3dmQ4VDFTY3V1WjExZExOMEdmR2J5aDN1?=
 =?iso-2022-jp?B?b2RlV05ERWg1MS9BSDRlNi9XbjRLNHE2bk55UlZJaUg2R2pEVXM5U0pD?=
 =?iso-2022-jp?B?WlhXYk1YMDFXenltSG1yb1JJY0g0WUE4d3UwYThwMGZoQjZPbUxYNFdx?=
 =?iso-2022-jp?B?N2xxcjA1N2FtR1ZnTnJMOW1aYmlxby9BbWZCbGMzVFlDckM5UkJTdnNF?=
 =?iso-2022-jp?B?Y2ZHdmdrZTBGaGRna3UrWkRFalpWcnFBUDcyMzI2Nk1sRnhyME5Lc01E?=
 =?iso-2022-jp?B?SkkwU3hHaGd6bXFxNzNjQUFrdTZZdGxUS25vamlEdmt5RWIyVStZcU1W?=
 =?iso-2022-jp?B?dkRaMU5hREd2VXg2bjM4SUVYNzJNTE1rWmcwdXpoRGlreTQwVDVRZ0lR?=
 =?iso-2022-jp?B?c2srckRkc3pLNjRmNTdNWDRBQUcrQkgzUmsxMmEzcFBSWlZLaFYzUGZS?=
 =?iso-2022-jp?B?QTVOWQ==?=
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
	2TnQ4GnoiSCF8OxsErkAkhruYQ5gWI4YYIYNSbkkG0mGhmemGX0KtMXFvPAgZEUO/RyNmAqfCKjT8dmdFzvwXe9i7dHUsgHIV8zmDRZjV25ziQgU+lFrUQZ4sU1n2Kd+rS0O6zbhvsUGoXlWxVYdAe+pz5AK/cbog63q1IJgh7OadYcJiwsxAsTcKyyclwwdbW4Xw1ZrBhyQK4O5a4lDxNqKWQyaNQG0lxqY7f55jTWb9aE9Ul/UqjxrmEkpoNbrQh+Rv30i/9nu0HhWX69Vjmr0s9ME+7ehjOl3Bq6yJrFMYuP4I+4eHzUpOSZxj3y1L3yvu4FsV2fJreecxpLRp4IYij/7iiVN0ddt7mQ9+QuAxm67ZvbpSmMb/n07ZSJaIn4uMDDO5gc5F3aHpsXy+o5tuUAvCCmHRAv+72i+7Io6S4XT1RaLFBuSzKvWMpFTDQgja9ujGP4sTKlNrzZ+O/6BJJHQ0/C1LroM9CUWo9Bbu/dF2YlPHkOAyrClsw3NClr7AytXWNKnuY4d94fAq0vAlADvmT0c8afeX/z0hVu/CzhRSwNV7LinafMT2juMvRrVvbYbuPFTpDkekmyWtQ6trG+poCIRIG/xYPzzzYW8g9HX48L2IkEOGXo26m5P
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB13777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e123a8-2221-45c1-5413-08dd5fa921f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 07:56:58.0278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ih03xSDsLoQRJlmjVp0Wh8lKDdHGc2Jv4hKS4XBHul8489DXqoZ/4nokR0KPPxCTLEO7AOi3HSmXlP8CmIbSjxYLfWwt5iAGqBu3uuceUC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11748

Hi Greg, thanks for your comment.

> > Dear Reviewers,
> >
> > It has been about a month since this patch was merged into tty-next ->
> linux-next.
> > I would appreciate any comments or feedback on this patch.
>=20
> What needs to be commented on?  It is accepted and will be merged in the =
next
> -rc merge cycle.
>=20
> confused,
>
> greg k-h

I had thought that some kind of action such as "Reviewed-by" would be neces=
sary.
I'm sorry for the confusion. Thanks for accepting this patch.

Regards,
Toshiyuki Sato

