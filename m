Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FA12E7F14;
	Tue, 20 Jan 2026 09:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900057; cv=fail; b=bwmXCuTNkBNatcz1+opePXr6bJGMxkLiCh4KbTqh8/R3KXExyAcCOBlbonDaKl8a5JyslCMCTuy4AsWc79hdD0d4Cs+9EkQ/tWJ/IuhLb/+0VN5dk8UilIhzIrp4Xz3aT5PuCdC7Zsos4j6hgG1kemicrUmiiXFydPQ01v8V+gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900057; c=relaxed/simple;
	bh=uTQeQRZu+2deVSRWOO7awMPVsRC9qklkvHkp0p+VpAY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rV8Eb6z0fsHgvfKED+JEtZVCxyHKsa589Wwx7bmHl2srdJg0wCWb2mVytM6l6/itfnvIC6qztDcX3spc86ckQQwg0L1QQ8R5PVfIrZ2MyE4KTqzl+wpPaoOl1B52CUjHt6j1weJG8eJHC3lBPTQ+0SCfWFE97q8PgvgMYrvxFlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=c7kZCioT; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=DXkFlaiG; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="c7kZCioT";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="DXkFlaiG"
X-UUID: 71072cacf5df11f085319dbc3099e8fb-20260120
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=uTQeQRZu+2deVSRWOO7awMPVsRC9qklkvHkp0p+VpAY=;
	b=c7kZCioTxB8jHUign3gwRouuZdGR0ndFB4Jbx7xiiQe74M5VKJtc/Y0Gvs5uVCK7MQ+EijitjqpeleR+v49z2z6Np2PjmCAa4DtXopjoIGZCyGhVJ07cr1Ii508mprs6WqPasbxHLsSDUoyJWVbSr4FD7FETPY8+ROZdK/C+pt4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.9,REQID:94aa2caa-d02c-406d-979e-8aedccaa702c,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:5047765,CLOUDID:38b9bcef-16bd-4243-b4ca-b08ca08ab1d8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 71072cacf5df11f085319dbc3099e8fb-20260120
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <zhiyong.tao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 245838029; Tue, 20 Jan 2026 17:07:27 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 20 Jan 2026 17:07:25 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 20 Jan 2026 17:07:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D25lBae44IOtmowZ3jgjck3ZmMMxezOQ1Zz9RjoOfPnFLyQAnRtDfGI2ql2ZEVyIX7zjfO8DsW4R8hK8vdByp2olAHLloqepH5vuDbDpwpMQfnx85OuA6rJAA81uYdKjVeRNS3keEZxFSeHuvKF9eo12qeODdbMMyWhxEWti+zJazVXPfh5Y2FmU3aM6D3+sfpED3C78wZ/vjk1/bpRuJAGTBuASRN5ydI+jkGInd97TsWjsjjEsVueJLi3qcVTcYADLoXHS3i4iqMBuk9sR4qzdhA5yJoujbKp8a/BMHCeL+wpmDmdcvua6kl83z9++YttKh3D+iAPpY4lnbAgPKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTQeQRZu+2deVSRWOO7awMPVsRC9qklkvHkp0p+VpAY=;
 b=sT5O0mI3TjMuaHcjx1BPH3dMzd7h2GgkYC14RVG3l7XUxFh5XDCBGMx8mlonQjLnJXseTo5at7SUNbmDcrKeWb2kVbVTW2s1IXHDhoOIjRzaxaiJatfLRzFfGr/QTTWOX5K77AJa4T/HVV0jp+MFMv41JBWEH6lH9SMs682wGP1qKWLXS5hZLuXly7T3JHzuPW89UqgudiM6pPiiqHxbW8tQg10+eavypI7iUN+Oa6TAAoTSU+H+Oh2vAd1MGeoi5RjZSBbqFsKmx+hgoGwD0a5mCGDWkPhRprAWMFeDaG4yJjyFcuXUdZ+XDrA4g+IDMoBFP5PT4vHz1X5mICVykQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTQeQRZu+2deVSRWOO7awMPVsRC9qklkvHkp0p+VpAY=;
 b=DXkFlaiGxaOS4AlbORTZ3C+bzar13p/DFa/tK4OnwS64pjb3PvEEJONCp2qB1ihCthkY3/+5Hy1hIGEPpDSuFAYriaGtVtCi6LOiP6ZIu5R8akZVJbFxrtJsvnWDglVwtRYkDynLSm3O+ra0y/pmPpXOsKyhlprzZjL0l929ZdE=
Received: from SI2PR03MB5690.apcprd03.prod.outlook.com (2603:1096:4:15d::13)
 by SEZPR03MB6761.apcprd03.prod.outlook.com (2603:1096:101:64::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Tue, 20 Jan
 2026 09:07:22 +0000
Received: from SI2PR03MB5690.apcprd03.prod.outlook.com
 ([fe80::7361:3cf0:b441:7d0e]) by SI2PR03MB5690.apcprd03.prod.outlook.com
 ([fe80::7361:3cf0:b441:7d0e%2]) with mapi id 15.20.9520.010; Tue, 20 Jan 2026
 09:07:22 +0000
From: =?utf-8?B?WmhpeW9uZyBUYW8gKOmZtuW/l+WLhyk=?= <Zhiyong.Tao@mediatek.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: Project_Global_Digits_Upstream_Group
	<Project_Global_Digits_Upstream_Group@mediatek.com>, "fred2599@gmail.com"
	<fred2599@gmail.com>, =?utf-8?B?WWVuY2hpYSBDaGVuICjpmbPlvaXlmIkp?=
	<Yenchia.Chen@mediatek.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Vasanth Reddy
	<Vasanth.Reddy@mediatek.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?utf-8?B?TGlndW8gWmhhbmcgKOW8oOeri+WbvSk=?=
	<Liguo.Zhang@mediatek.com>, "jirislaby@kernel.org" <jirislaby@kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] MEDIATEK: serial: 8250_mtk: Add ACPI support
Thread-Topic: [PATCH] MEDIATEK: serial: 8250_mtk: Add ACPI support
Thread-Index: AQHcfey/SO6Kleh1dki/LWqHFZdmJbVU2gyAgAYCc4A=
Date: Tue, 20 Jan 2026 09:07:22 +0000
Message-ID: <f678673ec826b52169f21457e59c00aa15df9727.camel@mediatek.com>
References: <20260105024103.2027085-1-zhiyong.tao@mediatek.com>
	 <20260105024103.2027085-2-zhiyong.tao@mediatek.com>
	 <2026011631-zips-provider-6c46@gregkh>
In-Reply-To: <2026011631-zips-provider-6c46@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5690:EE_|SEZPR03MB6761:EE_
x-ms-office365-filtering-correlation-id: 85a2aff1-69de-410d-8763-08de5803525f
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?b2h1b2lzZ0hpa3FjS2h0WElLUmI1eTJNTUc0TGIzY2lxOFk4TWxnVWFnRG9Z?=
 =?utf-8?B?aVROcFJvRUd2b0lJeC8wVVFNQzQrVE9CUUxpVmRXR05kSHZuZnc5MUZSUVNK?=
 =?utf-8?B?NVRPWDF6bVI5bmQrakg1Y1lNcFhlRzZGSk12OWJBN1J5MFdQZzBhQ2xmVlgv?=
 =?utf-8?B?anFyR3VwbGdkcTVKMEszeXUzc3M4NzdMV2RJMGxwVkt5anJ0cTlBc3IrV2d4?=
 =?utf-8?B?V3U1RUhEOEFtNnBFSUZFTlF0dGxya3drRmxtVFBOMElORjZ6TkU0MUJRRTNR?=
 =?utf-8?B?Yndmd2IxaGFiRis3RXAvbXpuR3VpR1h4WVEvdWhTQTBsdER5V2xDcnRnektK?=
 =?utf-8?B?V2lVSnRCbmNhc3l5WU9abVlMQ1FSYkRBUVB1N3BaRE84K0ZUR2duNFo2eGdt?=
 =?utf-8?B?QnFIWnBOZDRoQXp4Zm5OSVNjMklNcWxCdkU3dkVwQnhBT0k4NTIvNkZCMmhC?=
 =?utf-8?B?Zzd5dHIrK1FFbmQ1MHdyNUFyY3E3U0JvanE0RFpRcVFFeU9zTENPNkNuNkY5?=
 =?utf-8?B?aXZJOVNyaVFhOUUxaXB0OTFJVVpqM3NFend5Z3drTytEWGlrSk9xb0RMZ0Ez?=
 =?utf-8?B?SHlRKzhocDg1eGt6SGEybmN6Qm9wM1o0d1dzQUM0WEk1ZytKYSt2TFRKV01Z?=
 =?utf-8?B?b24wdGpvZFJQbnhXNlZWbmFtZkMyS1RnVUFab00xaS8vcHl1OG1zNmhFcG9X?=
 =?utf-8?B?V3dLUjJMbnpoMUtGLzV6Wkl5RC9aMmo3eTlNZFRBZzJuR01WR1JyYTIvemho?=
 =?utf-8?B?Y0cxQ0FDNE0vaDFIZzljUjNYUlpHZElzL2NXc2RnMXAyOXMrcitQUnNZeHJw?=
 =?utf-8?B?VnZFVEVjbkpBTmpxNXdlMTRydGhDSVdaMU9UQWFHYWRVVWM3eEJua05TeFlz?=
 =?utf-8?B?ZURDR21zRS9DSHNLUGt6bThFTDUrUzB6dFJHOWh3TlphNzlmamljVFZ4SzAr?=
 =?utf-8?B?ZmNTcy9rVzduR05renpRRW9VWmhVOWNsSEQyN1I3MEU3QXlkUnpLVkVtNHA1?=
 =?utf-8?B?ay9oRFljUzFnd3BpclJKMFJWbERaeFUzR0pRSU45aEt0bVhXMUJhVGpUNDhr?=
 =?utf-8?B?OCtRTDdiZ080aGNkejN4ajY1NHRWY29Xc3JSNS81bmh2dFc4NVpkdDQ4bTgx?=
 =?utf-8?B?YlNCcWhOUE15RTlkU0pYNVlORHlJa1pXQXlDcGRISnFHSzBiR1pzRzA3Myt3?=
 =?utf-8?B?NWZmVHduSXRpbHUxenpkL3JRQk55UlpianNVNm14WXBxQ1NqbVJsbjJabWJV?=
 =?utf-8?B?ZnFGY3dldlJUWEJiWk1rWDBPb2N0TzB6NXhPYmR2SUw5bno2UHExMHpTeUhN?=
 =?utf-8?B?cU5YV255THUzbXIwaG0ybTczTWoySW9QbEQ5TEUyZkxtQmxyVm1LNzJtRmIr?=
 =?utf-8?B?dy90TEcyWnJIYjFiWCtabzdlR2dMVFZScUVIV0FnZ25vSXZ4WW9WakxycE81?=
 =?utf-8?B?MTdDQjBpWW00R0NrMlRENzNPZ3B4UFg3VUhrRnNUWWtGa0VRWnZJZDFOWi9S?=
 =?utf-8?B?UHhOM2x1UGtXK1ZrSWZuVEtSeXdqN2FWcHI2VjBRVnJkSzZxQkdnb1pzOVdZ?=
 =?utf-8?B?NHpVU3gyOEptczRiWmJHK0Y5NmF3K05tSU5lQlhsVytKaW85TElYZ1JYZThV?=
 =?utf-8?B?RUhOdSs0cFkyTEpBdUZ0RVN2VThYb3BBeDZ1VWN0MnBFRzBscWphbU9FeGNZ?=
 =?utf-8?B?Tlgza3VtU2RRSzRnamc5ZFc4bC9OSitSdGMrSnV2ZTdXUXdXL042VzBXejdr?=
 =?utf-8?B?eklFTFBETkRaRWN0dkVaWmM1Rm5yQzlORFBlaENaa2pVazQwWWl3aE5ZMTlN?=
 =?utf-8?B?WFl6WUpiY0JoM0hMT0tlU0g4eXZPL0hENzZ4cDRKUk1zc0RpV2R6d1B5dWpu?=
 =?utf-8?B?dWdPT1grWnZQNitVYXFGcm5OMlZBWGpOMVN3NWpBR1U3aW1iSTF0cEVseG1E?=
 =?utf-8?B?b1JnNkpIc1dDUE4wTU5HZjJOZzc1SFBjTmJFWkhhUnlpbXlpNWt0MmlNSXFv?=
 =?utf-8?B?YjFnUzd2allRdDJNQ2c1K3pZb28wM25ZUXFjWGZzbmNHdFI2dnkzUVFTb1pz?=
 =?utf-8?B?bkRmOHpzc2NjWERxNkZQdll1dDlYb1dUWndFWFNaQUxObU9zbEp1MExiUGRo?=
 =?utf-8?B?aVBhTnZnNVc4d1g4MUdKMzcySXViQkh6ak0zRmdmNmNZZHNGeEc2MXBQM1hT?=
 =?utf-8?Q?evkLUCOWj3U6upkkUoeNE/A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5690.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTVYSzVZUWZNcmlwQTVLQWJLVHMyV0FyUjdEM01nNEhBcHY2T3NXQjlscWQy?=
 =?utf-8?B?UTZSUmZDTGtBdkNJTVZLeEl0ZTNKWVR2OVpNVllUM0NSMjdENmk3K0w3WFdX?=
 =?utf-8?B?ZmNmL3NYc1VpY2oxejA0RXZTNGk4bjB4TEZyeSs0T3gvN1NXbkhTWmtBNENW?=
 =?utf-8?B?ak9MUlpEcU5IQVVXd1hSOEkvWEN0ejUwcnd2bE9hRWRodWFhTmczaGNWWWkr?=
 =?utf-8?B?dGJ0ZDduKzJjOXlRUjBIRE1mNXlBL3VkOVh6ajFEd2tnTHZxUldVOXc5S1hz?=
 =?utf-8?B?Q0ozYkNDL200akd0UWc3SWV0clo3LzB0UWFvMk1uQStrVEZ2d09uY3UzNUZH?=
 =?utf-8?B?clRVbXNPRUpyOGgyWkttSFpGRDBLaUV3czVkc2NRZmJuMTlqUHpNNEcwaDQ2?=
 =?utf-8?B?SEJGN3RZaGx2K3lyQVZ1cTFmZE1wdlU5c1g0bnZnM0lhTy9ybWl0TzMzRW00?=
 =?utf-8?B?aUI0ZEQ0cVFvb25EUUQwSGk3czBuaEUwQ28xcDQ5T3pBL1ZrQ2JaOGV4SG5O?=
 =?utf-8?B?OGZDOUZZelF1c0xPNjIzeTYzazVIczJYY05wQjJsblJmMjdhUCtLeWdzdXM3?=
 =?utf-8?B?azJuNTc0YllScFR5Kzltdk1zZVl2SUQ4emdYUDdzZjZNTklHMXY4RVpTVmc1?=
 =?utf-8?B?ZHJaLzA0Zmx2Sy9DaGMrekpxN0hvbUc4aDh5M1o3aDFNL0QrRFNaekFqbWky?=
 =?utf-8?B?T0VnRkR6aGNPSi80TU1xcS9JOURHRE9XOWhmTHRXZU9HK2pvNGNKRmd4V09E?=
 =?utf-8?B?NzkyeFVOSzZ6NWxTMURPZzlVYlVPVmZDbnlOV0VmQ0dER09aTWNlSE5EZ3hU?=
 =?utf-8?B?VVRvTzhwYmRnRDVjSGdaakJESTZ1M1JUZ1FTMTlQZGRFdmE3ZXd5OHF4TUlx?=
 =?utf-8?B?VEd1VzVTZGdwaENPTmtQWUptRThoRnNtQ0NzbkJYN25OTTl5UlBidGNPL3Jp?=
 =?utf-8?B?RnVreG1ianhadGQyeDdFVkN6NTF6VGcxT0RaTi9RdDhpTHMzOE9CYXgwV3ZD?=
 =?utf-8?B?NWxkeGtkY1pGUG9ob3JnVWl3REswejNQa0d5T0tEajhiMitlakFDcUIvZ2tn?=
 =?utf-8?B?UTZRVEhuQWI1VndkTy8vUkJYamN0U0RwV0RMZHhkcjFmY2dZeE9SQiswR21j?=
 =?utf-8?B?b0JaVThhZ0owS2ZlY3ZpSjB4allDUkRJY3piKytNU3I3WEkvaU9rSDlJYkw0?=
 =?utf-8?B?SGNnR0Y5YWJrT09NR1ZVcURZb1ZJK1hidDZkdHdWQlo2bTRMRlZ6R29RbGxX?=
 =?utf-8?B?Z1J2VnFvdzBiQVM5a0hIWjBjNFA1VXVScE45NjZRNXg1N1U0TkJidDhuWW0y?=
 =?utf-8?B?bTVEeEtRdVNqSnJlbHBLV1NhS3ZWamduQVhxZUxoOUtvZEpDS0xPSEtLRndH?=
 =?utf-8?B?WHJ2MS9GNkJ0ZnVCRVB0VzZMWWRlajBoRUh1bTJqeUkwemtKc2FsUVgxQitP?=
 =?utf-8?B?bFZHcEUyYUNEdGxBS0g0TENCU0J6QVF0UHdHbU80VVRVSkFYbGxiVUxlSVdX?=
 =?utf-8?B?Z0JEeW5EZG8zNEhVbVE2N0dBV003dkJVS29jaTY4eUtpVGltVUJWNDAwL1NE?=
 =?utf-8?B?Y2RJYnpqTENNcElMSVBQMHlnaHBvR1ljeTU2VXhRdEpYSldDUWFFeVpzdUlV?=
 =?utf-8?B?Q3ZIOEVKaXhJSnNUZHdMSkc1bGhlM0R0U056b1R5R29UUWRCZEl4MEpEajFY?=
 =?utf-8?B?cEk4T2VmN0t3emFROTRDV21rd200YWw2VzJiYjRFOWJ1ek9LZVNFYk13bHBV?=
 =?utf-8?B?VXkwTy9EVm9PZDlYdE01Tk1lMDNhVmg5bkZoSFd3cHZZSy9zM3A3QmN1cE42?=
 =?utf-8?B?UUVialFhQS9ZYkZtWlo3eWhFa2VNSU5CcHRDZlNmc01vZVNFSGc3R3l4b1Nk?=
 =?utf-8?B?U1FUSFprb3F2MUo1cmE2cTFsa1g3ZG1xQ2VIenA2MllzamtsU3B5RVEyZFhX?=
 =?utf-8?B?bmI3c0xGQ2NhUVVVZEc5RTU3UHRjVWhhMmJzd3U1QlJNZ3ZZN0VjbDJNSE40?=
 =?utf-8?B?Z2o1bmJRQmM5YS9CNmU0NmZkZzZLZ3p0R0MxYjJIYVp6L1FvS0IyRXFqN0ly?=
 =?utf-8?B?eDZTZnNOQlN6bndyR1ZTMEVrSlloR3dNekZtcHQ4YWRiUGFqdmtpSk9pK0dv?=
 =?utf-8?B?ZEM4R1JUQlZpc2dqdEFqdDVxUlZlZkIrOWFudWRqTGhaTmJCWjVBcTFaQ3NE?=
 =?utf-8?B?Ni9DTWhzdVRsUGE5bjRTblQxQXpSQTYxaFA4WWQvR2FBRkxLNjREUFhaaHRJ?=
 =?utf-8?B?MVFHVm1XU2hvdkJFR1lnMEUzaXd4VEV2dGRoa2JaaTZmOEE0OTVDSDlGZW1J?=
 =?utf-8?B?RkRjNDNSaTM1cjUrMVhGajRZMVRHWDd6K0pjdUVzVGpWUTRHOVFVR3FqU0FM?=
 =?utf-8?Q?+5xRxnGTIgfo74u4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0BE3AD4A10EE1B4FBE6D06B8E59F44C8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5690.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a2aff1-69de-410d-8763-08de5803525f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 09:07:22.2905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +K0qBl8uWgqdZo1wvl6r+rQVbGNjFvpULO9plpG/216eFYp6raNDIaiM+RmwodMcxi1+3pLuwuPnwuyFgYgys0akvhU63op4WLXUK1bZpvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6761
X-MTK: N

T24gRnJpLCAyMDI2LTAxLTE2IGF0IDE0OjIwICswMTAwLCBHcmVnIEtIIHdyb3RlOg0KPiBPbiBN
b24sIEphbiAwNSwgMjAyNiBhdCAxMDozOTo1NUFNICswODAwLCBaaGl5b25nIFRhbyB3cm90ZToN
Cj4gPiBGcm9tOiAiWmhpeW9uZy5UYW8iIDx6aGl5b25nLnRhb0BtZWRpYXRlay5jb20+DQo+ID4g
DQo+ID4gQWRkIEFDUEkgc3VwcG9ydCB0byA4MjUwX210ayBkcml2ZXIuIFRoaXMgbWFrZXMgaXQg
cG9zc2libGUgdG8NCj4gPiB1c2UgVUFSVCBvbiBBUk0tYmFzZWQgZGVza3RvcHMgd2l0aCBFREsy
IFVFRkkgZmlybXdhcmUuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogWWVuY2hpYSBDaGVuIDx5
ZW5jaGlhLmNoZW5AbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFpoaXlvbmcuVGFv
IDx6aGl5b25nLnRhb0BtZWRpYXRlay5jb20+DQo+IA0KPiBQbGVhc2UgdXNlIHlvdXIgbmFtZSwg
bm90ICcuJyBpbiBpdCwgbGlrZSB5b3VyIGVtYWlsIGhhcy7CoCBZZW5jaGlhDQo+IGRpZA0KPiBp
dCBwcm9wZXJseSBoZXJlLg0KPiANCj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgNCj4gDQo+ID09
PiBUaGFuayB5b3UgZm9yIHlvdXIgc3VnZ2VzdGlvbi4gSSB3aWxsIGZpeCB0aGlzIGNoYW5nZSBp
biB0aGUgbmV4dA0KPiB2ZXJzaW9uLiANCg0K
