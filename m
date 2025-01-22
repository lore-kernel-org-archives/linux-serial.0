Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E5C171A7;
	Wed, 22 Jan 2025 00:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737506648; cv=fail; b=UEVN/vGnJCNP9RxzZSNpFgY6IlZrXrJ+1gP5GEFOBXEd8XjUaVI+OQ8ogbLHmiJlzeBX0Zt37SzCj1R9V1vv02ayx6kZblce+j99L5uGMZxai4ZrB0VPc8KsfYYnCZMVlA2Qukq/1gYYM/G42i0hKM8AA5+CHj5cxzN1cjVgXjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737506648; c=relaxed/simple;
	bh=O26Avc0B5lA99VDyes9GP9n9spJqwDark6fUvYQBDKA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UCID0KYAeoEo25Zn4/xmCSnT3PMurZFIkU7kspY8z2JYuMBawaLpg2T2EVWm/7yKOtdZeRFL3QCCOm0Bgk+ijSTlPVfojUYVSc8AmWQRrUo7pdqsn0KatDbWFtoZBYu6iaXsZ0RhBNhHz2tIFw/PFOs2STyUBzaGrn+XhOYmN60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=xKacPoR7; arc=fail smtp.client-ip=68.232.152.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="xKacPoR7"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1737506647; x=1769042647;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=O26Avc0B5lA99VDyes9GP9n9spJqwDark6fUvYQBDKA=;
  b=xKacPoR7YhsmeGLGyh1lb5jiul3h6pPidR/IcDQtFAyxLsqr6w/tVMyG
   ocE25PFHOeqWR0t1i6JoOeyJ2PJi5XBJmSTSSyX7BGMqY0afA2wNcJuM7
   bU5bYYpRX0PwXaTFVTXKy6t9W6/INparRFJoegvnzWyrP1eQ+hm7EQsya
   ruT5QooJpmPnc0vxj2tOeVQjfsYMkc54wv3HnR4zcQ/KcATu9guTycDEe
   5YcPGhEr6/kTm4lNogKkYp8hFIQewFz5zXewcXm383snbf4ZKmv+2GH6y
   4FOpF70wcKhIoTVmzOYhyTTcm2Y6Uev6Y3fq3jok5FW2SE+anMB71A+7k
   g==;
X-CSE-ConnectionGUID: kx6R6JFcQD+pWPNWAfkp1g==
X-CSE-MsgGUID: JMjIh4s8TOaYdsDM2oj16w==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="54735855"
X-IronPort-AV: E=Sophos;i="6.13,223,1732546800"; 
   d="scan'208";a="54735855"
Received: from mail-japanwestazlp17010005.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.5])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 09:43:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XOzlOjEmBRpiDVaeXxjsf5DeDnMyDgSrPIiWZxJpX3HpmzkLj9AtIt1T4VV50Nw2S70OlZyG38J0x6NP7PMoJHoZDwBkHNNAA2j+yS/u6nlW2zv7cMfQAoZUo/CbRl8jASaxrwVvAgDBXjXkUENAvOPltd2GSMvvi9EGaKVmM0CeUf+7QYbcfCYCP3Z/209WZADTNTFWoaMvk1KGPYyqo9WZMxz9CNeNzTbc5jF8+qP1DFo4jjXdCDf4Yg95kqOy74FpFnrIDGasaqrPY9asa+xbWhSXDWMwq5m+j41fjwDh0xkBsO6kidLnFZXm2wDXXhA7gU8GVxi4GDOk+PEXsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujKWcY8dZR955bzBwFmKapIfcEeO/8vH/GGXchZ6Za8=;
 b=TxiXUCYtWu3IeQFShNemy1vnTs+DFXLAstuOiMeL8uVs0/AUpC3utl5XeWVj7HHS2bxDDRYeV2V+igjgIh/IZrv21yBEbtsnaYCkFbKC43R77Mo8GEEYHv8eKj+AEDNoHDZ9uI0RO5xTByIFXbjoO128AAP1rFK4BIzNb896nCQCMNTVg5FpqCdF3KHUSjX5bts3v9bttlb+jBvdsIUKFUMxDzoz8mPQB8NMTp2Ck0eGkqesLJlNnx/MEKPj/T0xIenV65LorjeYN7f72ao4c2OIHJZ6bJKdQaOqatdwPCgkxGGV00ne1ANIdMlClqeAy9Rcg55h4FQwMjmGOfZoxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY4PR01MB13777.jpnprd01.prod.outlook.com (2603:1096:405:1f8::9)
 by TYYPR01MB7709.jpnprd01.prod.outlook.com (2603:1096:400:f9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Wed, 22 Jan
 2025 00:43:54 +0000
Received: from TY4PR01MB13777.jpnprd01.prod.outlook.com
 ([fe80::60b7:270b:27c7:4fcc]) by TY4PR01MB13777.jpnprd01.prod.outlook.com
 ([fe80::60b7:270b:27c7:4fcc%3]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 00:43:54 +0000
From: "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com>
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, Russell King
	<linux@armlinux.org.uk>, Jiri Slaby <jirislaby@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
CC: "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com>
Subject: RE: [PATCH v2] serial: amba-pl011: Implement nbcon console
Thread-Topic: [PATCH v2] serial: amba-pl011: Implement nbcon console
Thread-Index: AQHbZw5nubcj++fYFESj+PMf9pSGLbMa3siAgARKIUA=
Date: Wed, 22 Jan 2025 00:43:53 +0000
Message-ID:
 <TY4PR01MB13777114C4A9577D5D0FA5DB8D7E12@TY4PR01MB13777.jpnprd01.prod.outlook.com>
References: <20250115052749.3205675-1-fj6611ie@aa.jp.fujitsu.com>
 <2025011743-rummage-civic-5c14@gregkh>
In-Reply-To: <2025011743-rummage-civic-5c14@gregkh>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=8a9d591e-96ec-4115-a40a-a49c95ed781d;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2025-01-22T00:42:47Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB13777:EE_|TYYPR01MB7709:EE_
x-ms-office365-filtering-correlation-id: ef687b67-9e65-4141-ee3f-08dd3a7dd89b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?MTFmaGI4SFk5aGZMTmhXZUsxbVRVck1oSnNIMXZTOWlvTU80Z3BKeld2?=
 =?iso-2022-jp?B?WDRaSFliR0ExVGVFY2p5SWM3V0NZTUp4SkJWV1lXTHB3YzBSMXlvd0xk?=
 =?iso-2022-jp?B?YmFBVjcvTlgyM3pYcTR2V29hWTJQWUJkTHZpelJZb2hYUXNGR1o0MlZy?=
 =?iso-2022-jp?B?Ry8yTk5QWXhwM1YvenhHNDRrQ21hcmpOTHZBbWdhUVplZ1ZZa25BMktT?=
 =?iso-2022-jp?B?WG9Yd0lBZ0hpc3FDVndmSmpIcXQrTVVqVnloZTA3VmdkM1V4QXpUblB4?=
 =?iso-2022-jp?B?WVlhWHFoVERZbllVMk9WQ285eCtIOUdsb21QRVhHMDR5bVFzdC9yOUNP?=
 =?iso-2022-jp?B?MnJpeHdJa01HMm9WNUhuR2Vzc3YzVUh5TndKS0JqOTR5dlpyNFZnNG8x?=
 =?iso-2022-jp?B?b0Jyb1NYdklaQUZJYU1DQ2JxUFhDRDdXRFpxOEV3MkVVWElNSzlCYjVS?=
 =?iso-2022-jp?B?amNoYlBVZTM0UGoybHp4b200SXRzeHFKM255eHlsb3p2VkNienJkTXN3?=
 =?iso-2022-jp?B?cEZVd3JlZm1PR0dpcThxOFY0QzZoaDVMVTlpVldPdWhEY0tBZ29kZms0?=
 =?iso-2022-jp?B?bkt4RStwODVWY2lHM094N2Z4U0pFdEpOS1J6ak1teGtFS1JHMlFnQ0dP?=
 =?iso-2022-jp?B?N0I0QVF0YzJRQXhNbWZxODlkSG9pb0lYNjFQZ3ZHWXI2MHY4NVhSc24r?=
 =?iso-2022-jp?B?dGx2U3pRTm55TWxpODJqaEVBMFd3QkwzWm10NDZoK0RBZGpMMGhKTDhs?=
 =?iso-2022-jp?B?RXJEL3piM3FFQnVZUE1rbkhGVTRRUG9RWG5JK2pYa2FISnl1RkM4M0Nm?=
 =?iso-2022-jp?B?dHMwLzJBQlZrcHMzem81Q0c3STNSeGl6YUE3ZnRXUTk2aW5LTXFzdXhu?=
 =?iso-2022-jp?B?RGFTbWtJM3ZWUS92ZHk1SlFEQXpUTXdkSnZ1Ym9CZml1Rjg1U0QrODZn?=
 =?iso-2022-jp?B?OHlEQ1FtcEJxS2FJYlpyR0EyKzA0L3YyZ2lGNnUwWXdkQnlSaktkS2Q1?=
 =?iso-2022-jp?B?UEJsd2FwQm1CQ3A3RmxZYzlKS293ZktpSlByVU9oSkJiQ0l6N01RZXpl?=
 =?iso-2022-jp?B?S29Nb2l5UWtDbjIrN0xGQyszUWx0bXpKdVpKVS9Yd1NUK1ZDU0NVTHVH?=
 =?iso-2022-jp?B?ampJOTNxaW5hd3pFRXJidjljU2lwUWRmaWthL1UwM21aMzZuUGlJa0gz?=
 =?iso-2022-jp?B?ZUt2QWdQdHZWY0ZpYytiSEJIZUZzaWNpNHFmMGR2YmF3YU93UjE4TmQ2?=
 =?iso-2022-jp?B?a1Y4UVppelV6OVNxT1R6TGt3eHg4Y3ZoZXBGRXBVNmJ5SHd0VElENXBU?=
 =?iso-2022-jp?B?bE9KTVU3bHJ1WnNVSTl0aGN0ckdUNzJHNS9uM05CVnA4c1FZVWk3RXdo?=
 =?iso-2022-jp?B?MWhvYTRMWDUxQnFoa283ZFB2VDBJc2M2bnBENGZOMVJ6NERIWG5OQ1l3?=
 =?iso-2022-jp?B?WTNIbFdNZDRaVGV6SUM0S0gwTUVzNFVwUzNTQU93UU1uMlg4TVpkYXRM?=
 =?iso-2022-jp?B?dUp6MUpicEg3T2g1Vkg1Ny9vNXQ5YnFPUk51WSthVGw3UDVCckk1bGwv?=
 =?iso-2022-jp?B?RnNJd0VaMUR2bit0WXFhM1BDM04xcTlRL1RlUU5nQVJGdGFDYWpKTHdH?=
 =?iso-2022-jp?B?YmhyU2dxZVh0SmRoN3FYN3orRDBLcGxMWG92Yys3amovTTVLNlhFaWZS?=
 =?iso-2022-jp?B?OG5KNDRBTDc3TzhDdTEwMUFHV1M5cFRrZ0QwdVY1a2xXM1lmTms4UDNW?=
 =?iso-2022-jp?B?cG11M2xUMnVnZUk1ZXhYUzVEOXRTaDQrUWh5aERQVzlEcm82MklDQi9F?=
 =?iso-2022-jp?B?cG5tZ2FpcUU0VmgvOHRpRkxFZWZuZkV1NTZhbThhWkVMQ3pMSU8yK29U?=
 =?iso-2022-jp?B?S0QwTDJoQ0JSV0tZNnV4RFZxSUlnWEQ3VCtzdnZaK1BkaCtLNTlYNUMv?=
 =?iso-2022-jp?B?YmdTV09sa0dUTEZ5WlRHU04vS29Jcks1QVBIdnJKd2NxQ21WRUlyNGtO?=
 =?iso-2022-jp?B?ZHZlZTJUQWQxc2FWbVRubnd5Q3pKSkdKNkJyQVBPVHQ2SDl3bE9mTWc0?=
 =?iso-2022-jp?B?ei9BVVdheFA3YXJscGlVa29obnJnWlk9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB13777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?eTBiRzRPenN3RDBMZkx4SGV0SWNabE1QUlI1aGFMK3RKenYzT2xTbmQ0?=
 =?iso-2022-jp?B?WEpPSzh2eUdoOFFqU1IrMFlNcVVOcU9jUDM5NzFnVm9mbzQ0WElxRkJL?=
 =?iso-2022-jp?B?UjR6OU96TjFNbUgzd0hzWGs4M01xSG9jeDVLY3J6YXNub0Y5anAyM1Q2?=
 =?iso-2022-jp?B?NW5RM29CSTdKaEVhdHIraXpCZTNJOHRLVnVJODBMUEtxOFAxTkJ3WTdE?=
 =?iso-2022-jp?B?cnpJUmZMajlDUDRQVW14UkJIckJ5d3JzR0FwSmgrLzlmeFM3YmhjYjBR?=
 =?iso-2022-jp?B?dTFLWjRZZUM5UU5zbmRaeXZqNE1tbFAzTnRvdzQrNytJTmluMlVzZ05U?=
 =?iso-2022-jp?B?TUpVQXVLS3hhb0NXOHovU2I4NHh2MVM4OG81NjBJditUSDQvNjB4OWxV?=
 =?iso-2022-jp?B?M2l1TlQyT2ZKUXEvQzlrMTFOMmprZDdFTVcwZm1ZbjRSejFIbm9XSGlr?=
 =?iso-2022-jp?B?Umxyc2R2bDFadGZBaGNEcEIzYmVhajNsMitZOUdQZ3p4T2QrSFFFUE54?=
 =?iso-2022-jp?B?clZQWjAwZytta3hrU0RldERVQlpKeU5NaTdKc1NFbmE4SVltUGFoVm9T?=
 =?iso-2022-jp?B?QjkvK2tHdGIvRVNVQWd0b21aRDhQS1lsQU5vY25MSG12cnZZTklwVmdm?=
 =?iso-2022-jp?B?TVZZdmdLYk11OWRhblg2OUVCMW5abWZrZ3EwYmFPUDEyUGFYeHlCSWdp?=
 =?iso-2022-jp?B?aGgySHhyc00yc0crYUJTb0dlMlpQL0FJRlJhTjY3bjBPWkhsT1hyWDRG?=
 =?iso-2022-jp?B?ZUw0R2MzOEo3RFJhWjM0YUhON3RIMEZpeDVMQkYvMFFoTlFqM2lteVBT?=
 =?iso-2022-jp?B?d0hTMU4zaDA0Sy9Qd1p3dHdrOXM5OWM3T1hZbUdOR1RVT3pqb1d2cW9u?=
 =?iso-2022-jp?B?aGlrR21HN0lRdmpaZ3ZDRk1IVEpab3Z4dVlNa3k3Y0ZZMmdSazhpNXUx?=
 =?iso-2022-jp?B?VVpQWnUxYmdWV1E3azJwRFVvTDFKRGlIQlpEY0xER015WE5jRDRxYW02?=
 =?iso-2022-jp?B?SkhHNG5jU1YwdlllVnFnUXMrMkwrdHYvVkErbFBCZkhNbmFsTllrTTF0?=
 =?iso-2022-jp?B?bVdsZXU0djREQmdlMlMyYURDd2lVV1c1K05iTnkzL1E5WXhkdkJQR1Rj?=
 =?iso-2022-jp?B?dmViNmVxa2pQZGtFN3NUcElMSnhWQWU3ck9wRENrV2dWZ0loQVAvczlj?=
 =?iso-2022-jp?B?TEhvMTFTeDRZUEIzS253WFh0VCtCTUpiZndpdVd1VnBRS05HNUh1b2Rs?=
 =?iso-2022-jp?B?Mi8wd3ArYWVFK1RVUGdQSDdsTEhGMHFFMVplK0FoeHp2QVVzdTlXUE02?=
 =?iso-2022-jp?B?akdXcDY2NFZEUlhLK2tGWWRxQVFnbGhXVlVXblpMK2NpM3NJSkVkYUl3?=
 =?iso-2022-jp?B?ZFB4UXhOZFNKYkhtQngzQW9YaEtNN2xMSEVKT2lTbHgvVjNjaDRYRWtr?=
 =?iso-2022-jp?B?M3lSN0NhUlliT2dDUG5QWTBnTEdDR0hzU0hwODY1VVA5ZUk5dWY5bVlH?=
 =?iso-2022-jp?B?dFZEZ2FwSU9oZnVwU2NFbThPRjVPcGRGa0NLb3RsN2F1eXNEZG8ydjlj?=
 =?iso-2022-jp?B?SmlVSml4bzF0UCs2TklvK0lreVdsOTJPQStoRGkvc3NObjBUV0p0aFEv?=
 =?iso-2022-jp?B?MjNGejU3RG5JNjlBdEhHZFBKbXBUaE9nQkNabmN5Z3lCampaU1JUemZB?=
 =?iso-2022-jp?B?eWk4UFcrdTZ0MWt5WSswMGdYZTVPSzg1UDV3ak40RTJXbWoxVW1VVXZu?=
 =?iso-2022-jp?B?YXRwQlhuNERScEh6ejAzMytNbWNBVzludkdueWVFUEZHYlAxWGNxOUxl?=
 =?iso-2022-jp?B?YjNqNlJqMUxHaGl3dUxzcFdReW96Mnh1Y3I3R3IycG4wODZncjlmaVVm?=
 =?iso-2022-jp?B?d0I3Mk1qWTJtMlllNE5abGM4MXdOYlczcDB1Ti9xTDBiNVlWenIrM0FF?=
 =?iso-2022-jp?B?Nk5xSnhKRDY0QlRYNTB1OU00V2hFeW5kRWdKdnBsTzVTc2E3OU9QTXZs?=
 =?iso-2022-jp?B?UUl6VlhXOU1LaE9NckR3eGs5aXdBZGc3YXJjbnp4b21EcjkwVUszMmdy?=
 =?iso-2022-jp?B?MFl6TXh1Nm1RdXVpKzRVWC9wQ0g5MzNhVVQ4ckVsRjdQVEMrZmxnc2VO?=
 =?iso-2022-jp?B?Sjd2akRBQmlSNmxPNlY0K1lKbTEvbFZUbngvWThOTy90VkNKcWdGMmZG?=
 =?iso-2022-jp?B?QUIvZ2lrL2dKTzVGSEt2UUNrbHlzeTRsUnorUWtpcGduckZ2MHF0WWhq?=
 =?iso-2022-jp?B?NWJxYnhlNzBWeHIyUXpPKzY0UU1zYkRWM3FLbFMway9zTjQzdDBhKzlV?=
 =?iso-2022-jp?B?WHg1RA==?=
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
	LGurVKSESSvDxxwI8escdnF6zfG0BpDvtky03By3I6FhApEs2Y8HgGwqhSRQ4FQTtbCRtOEVfojHBoXzlx1HyEAhreYzih//SGL/OZp9iu+lrVTdVl95eDeniIq/rx3Td6Zezc++iz7cijUNUbC7t6sj0phFM7yjPHK8nCrQfO+c9xsBP785dGP5dFA7ewbh4p96HA19TICNgFxISuC02gmjtXpGF16VsJhg4YPeTV60EFT0nNhGQ/+S/Ze49iQS0hQLC6kF/7tygKYRFAyAtx8zZd8CWKzOZZEIUxuT/ZlBgtrP93t8SSOoP/o8WdCrH4h1hJ6pJKKm5U75PhmtmCYocQlpuwxdUIQMHXeT8G4+J7DjWl3mJWOOO7XDxaSI4JTkthGCcu9msNvLfAs1/X3W2N+LzEINP0gB71NO9iAF3MHQAcWeK8n6iMthnqB/Iref88B0Ldl6W3PJ0ya2J7NI09IPhk/7ljbw8rRfULljXpasjzYz/PTE76Bj5hjR1lIqcgc6Esicr444yKwhNud3beA1Lfj3/4W764tQwsX+CpCD7KFArK8Tw0NcXZWwhjKeMgGS1wqZgqz6zA6a5Gi342f4yDEEsEYwWpnMqeDzBrblIpHru8ft+Of/Ygmg
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB13777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef687b67-9e65-4141-ee3f-08dd3a7dd89b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 00:43:53.5358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jwzqv602Oej55fu1FbnnruMx6ZOAT4gWsfAPlg7hEQFQPKSGg2khwAdiM/3ruFN8sf1UXrAQFqCRy1WPLRiX5Domw9+RtCn/5TsNoS0PR+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7709

Thanks for your comment.

> On Wed, Jan 15, 2025 at 05:27:48AM +0000, Toshiyuki Sato wrote:
> > Implement the callbacks required for an NBCON console [0] on the
> > amba-pl011 console driver.
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
> > This patch removes the legacy console code.
> > Please comment if you have any concerns.
> >
> > I plan to try a stress test, referencing the work for 8250.
> >
> https://lore.kernel.org/lkml/ZsdoD6PomBRsB-ow@debarbos-thinkpadt14sgen2
> i.remote.csb/#t
> >
> > Changes in v2:
> > - Remove the module parameter used to switch between legacy and nbcon.
> > - Remove codes for legacy console.
> > - Fix build errors detected by the test robot.
> > - based on 6.13-rc7
>=20
> This fails to apply to my tty-next branch, which has 38 commits on top
> of that release and at least one of them caused conflicts here.  Please
> always work on the development tree you want to submit a patch to, OR
> against linux-next, to help prevent merge issues like this.

I apologize for the inconvenience.=20
I would like to resubmit the patch applicable to the tty-next branch
of the tty development repository.

Regards,

Toshiyuki Sato
