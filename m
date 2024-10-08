Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310D013C816;
	Tue,  8 Oct 2024 09:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728379244; cv=fail; b=I+VXHKBtV6mLp0nGiLBZckO+LJGp8xPr1YZaDb5Ke3vz67UVJKPQa6ZzCEV9iW1qbSDIpJ/e4KiHUuAc2ajSLX3IUyIsqZSQZmzltTXksKDiPpbLNjW6HqgU1JY5U/VvAQqaUS/vsmEi0t8SJOMUnFmPyscf0O8/OPdMu+hfOr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728379244; c=relaxed/simple;
	bh=6oddejFvBpsjCeNtkHOX04dJBshrArKhy/+ARXE5QYY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DDBI3dBTDQPvASQUThLWtilT4izAGSIUryaMHpwYa+m6CcJ+wzgLY9lRl0DMiyjTXswQTs2nsgaQkOo82qfSKBTmGTdS8rJIQwaBbjXEvp8GvtkjO07pyzUDLVi+TJVjBLw2VaNr6sqJdbFYxjcln0YtEbGVRw+8tgghuW6McMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=w1l+Th1h; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="w1l+Th1h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q72OAiVD+bvl/ChpfrhBmnweBLghA6rpT4heitQug3cuJHYgREBBbJVsl9q1FAu0miFAI2jomlnwYnmiIeU7ERLviKEiwtAUXUNn+Okrg8uPegzdsQzQNbbhJZbCcjVU5kumPKwC8fW5caScuxp9zsK9D/7Te1R9lo2Mf5etYyEM9LEwWSeCLSTHfUR69buC5EUspOF7vlWfsuJn8Qot0vfY4yBO2uMWwnGgOd+wv/1X0qXrZEvjIn/5GXnF4pkP7m7CiEU5CbukK5rcSWCT9v2LRNgRp1CZgpbbIBHfj00amcZj3VA5m98lyE2ATxq/OkwVWNvSAYziukUS3g613g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6oddejFvBpsjCeNtkHOX04dJBshrArKhy/+ARXE5QYY=;
 b=PjIXqm6HvD/uEMK0N9YXXgbCP2UbF3F0rOxGQnYwD11+dH2jHYFQ+hn3wJkjMLU3tiMUzU3yP75CajiXsuuMCtlkerO4TA7hCIUqZpP1YetrLYg6HNP1QoehqdAw76SUlp3KOldWtCE+g4a4p29xmYpmONfaaA+Wm1RVA+8EsIynNuj5DStJehAwZtQMUNjSHF6qeWvYMoGOXS+pCQAMI5JBugioSi20qH3tzx37Q0kwTQlV8CxzBGyDNsK0nIPkMmbvE63Oo68qD472hTXe9DiUj1qOVhq+pD/xWBxuoEfh8YiHBsZ/XJKd6sQdll8DHD5sGiDyRtWVk/3OJ9N9ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6oddejFvBpsjCeNtkHOX04dJBshrArKhy/+ARXE5QYY=;
 b=w1l+Th1hQT3To6RtXuA3QZa/6D7vbprzpMiOdg5YQ0G1FPqx6u7yLX6MiNpF4fcWijPt3dOkh1+reOCiZkP7bKx26uppz6rHMnifRzsM3xdpTE1IOjWVO2hWJxUwHH6A/QxlcsBWVfnLUsuCEqT7+JDP4qrzyK5M7VOFCBCpWlTSnYoFHSflslubi4tnxUitZpvPq2d7yy3y/XzHtNFfSYDoutekm9E5/cSaY7fBe5TMWyuu8LAEhLGowoWGNdFVWosO0CaEiBZA0ia7QyBuWzOFq6PMjgFrqQtsfVA65FOOrJ3SJaBeN756XIIsRgaayFcnkcigFhppafrmNK+f0g==
Received: from PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6)
 by PH7PR11MB7074.namprd11.prod.outlook.com (2603:10b6:510:20d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 09:20:39 +0000
Received: from PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::6f39:a4f:9001:ea75]) by PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::6f39:a4f:9001:ea75%5]) with mapi id 15.20.8026.019; Tue, 8 Oct 2024
 09:20:39 +0000
From: <Mihai.Sain@microchip.com>
To: <gregkh@linuxfoundation.org>
CC: <richard.genoud@bootlin.com>, <jirislaby@kernel.org>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/2] tty: atmel_serial: print the controller version
Thread-Topic: [PATCH 1/2] tty: atmel_serial: print the controller version
Thread-Index: AQHbGV0Sw8+hLIY4SUaHEGKRHUG6XrJ8kfqAgAABkIA=
Date: Tue, 8 Oct 2024 09:20:39 +0000
Message-ID:
 <PH8PR11MB68043103D6C3D39A2DD6D486827E2@PH8PR11MB6804.namprd11.prod.outlook.com>
References: <20241008083459.51249-1-mihai.sain@microchip.com>
 <2024100822-mantra-customize-cab1@gregkh>
In-Reply-To: <2024100822-mantra-customize-cab1@gregkh>
Accept-Language: en-GB, en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6804:EE_|PH7PR11MB7074:EE_
x-ms-office365-filtering-correlation-id: f6c6eb94-aed3-4959-94ef-08dce77a79ad
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6804.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b3hTeUkvSWJJZldHRHJ4RXJ1OUc4dzhSSmZrUDRNdE11N3l1MEl5ZHMzZ3V5?=
 =?utf-8?B?MDVhcjBXdENMS0pKelkwMzZsMkd3eVBZbGMwZnE0RFQ1SWV2T3BZU2crbS9B?=
 =?utf-8?B?d0tjQzY2Z01CaG5DK25PMGEwMUUvOCtKN1pXRDFXMlR3N0grZ3FyVW1LaXpt?=
 =?utf-8?B?Um1va1JnQ0pZZUEwUnJpb2NGalQwMTRPWGkzUjZXMHZ1bkcyd2g2MWtucHEz?=
 =?utf-8?B?UFhEeFNpZUE4QmtaeE5DdkNVbjdYNFdpYkFjWlRZZ3NkUm92b0FRSk9ra1VD?=
 =?utf-8?B?RkR4dlpGY25wSU5PMXowVUM1N0htUTJtYmYwMkZldVhUYXhDRkQxd0xQNU9i?=
 =?utf-8?B?cmlJeng1TGk0aDhYWTgrNk1CZERnRzVwNGZGSGo0SUk1NkZQNTM1OUVZMjA2?=
 =?utf-8?B?dlhCMVVpYVgzZ2JJZVI5WFBMaVIwN2NhS2RnaDJmRzNtMTM0LzZ2ZDRhK2Fk?=
 =?utf-8?B?Y3RENkpnSjBNK0h3WmdHY1BtOWlHRHhrcFlscG5DNzNOZUNVZ2lnZjUxb1NE?=
 =?utf-8?B?cXNLcm9NT2tHbXBDcDR4ZGJIaUtRRDZLcWVFQng4Ym5lcWl0RmEzbW5ndFp1?=
 =?utf-8?B?NFYzeU1vNGkveXh5ZDdnc213akNxcXRZd3VVc2poQTRubjB5TGhIbUFqNmdR?=
 =?utf-8?B?bTlGbEpjb0ZDM2JTeS95VzlsUGtmMFpKR0FxNk5hYTdSamlUVG1Ra3BmY3ZX?=
 =?utf-8?B?ZHlKN1hDdDQ0ZWlJL0pZQm14RGJ3Q08raW85MHJGbVpDdHFlQ0JKZjJjQ3Bt?=
 =?utf-8?B?czlwWlAwbElmVXRsaHRDeDdERHd5dVBjd2pRR0t2bDB3bHExK2QxOXFvZWt3?=
 =?utf-8?B?cDJqejBJdjVobnF5RHNWWVJPU2JUdmJvWlVVTE1xVWFoWFdRa1dIV3FQTlRn?=
 =?utf-8?B?bVVwcndhWGVFTHNYWWdSYThJaXhGZmN5Vm5IR2t2QVdzR2RvRjNMZHJRVEFt?=
 =?utf-8?B?S0NWdUZORUx3eUNNdEpacEQ3ODNQUTl0eithcE9IRE1FeVExSVZQVnFneUY4?=
 =?utf-8?B?VG1LL01qVERnakNETDRKa1lzbVNyU3BSeDk1WVdEdzdhN2hJUHpDbW5KV29W?=
 =?utf-8?B?NzhwS2lUZmJmcHgwcFRPcGR5WStjQ1lrd0syT2JxQjllQkYyRjZQY2dIT3Ax?=
 =?utf-8?B?RUlnMm5MQ0Z4ZXo0WVBOWDRNV1ZkVElxYW1XcHhqTzBRZVMyTmI3VzhtSlBr?=
 =?utf-8?B?cko3STY3dTM0M1RFaDFhS0UvU2xhQVl6UXlGeFNWbFN5ZDRSR2lRR3hZbkVL?=
 =?utf-8?B?eTY0T1hlaUtUMlVJaVRwQUlUbGRXWTZremd5dUVwNlFaMU5DdVZrL2lPL3h5?=
 =?utf-8?B?ZU9ONi85VUR0dTdYcStTUFFYZnpsZ3lUUENXUlhwOFFGa0QydVRGODRycVVa?=
 =?utf-8?B?Zll0SUx0cndpMFJ0UWVYZWhZQXlkUk9NUkZ5Wm9Zam1WZC93ZkU4QXlPQ0NU?=
 =?utf-8?B?Qm9TV21QVHhOSEdNc2t5V0Q1OXJ1S1o0aVZMckMrRVlodklhNGpFV1Y5T2NM?=
 =?utf-8?B?WHorc1pRb3IvWXVSMUZES1FLNlRaQzhndUVQNDArcFN3MGJQWDRhcnUvMzAw?=
 =?utf-8?B?c3J6NTlCOVkvN1VLQk02NFBQbXZsdmVoaEFxMkVjVU1YZFBwY0c2cGVmWEJa?=
 =?utf-8?B?ZDdyVzg5ZFYxMTBpWjh5azY2MkMyWmRrcGgvOW9DVEl0aDJXVGpnNmtuVy9J?=
 =?utf-8?B?VEo3M0R3dy9lWFVOWFMyOFpQNXdrYXA2T05MRGQ0a3VaU21DRkRwTk4xU3BR?=
 =?utf-8?B?dUJHWDZrSlRrVXlRbTBqTFh2WjA5TFhmRHJUTmoyeDNNTzFYQ2ZnYkFqRzJk?=
 =?utf-8?B?UUtqUFFMQWtMS2ZVcUhmQT09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Si9yME04bitpRG9lRXdURW5HOTRlVDRNWkpWOFdNR21CNVk1V1RObFRXQnll?=
 =?utf-8?B?bk9TRDRwUEFSWDhaSkFyQmFVRGdpUkRhdTNSZHBnMm9GZ0g0Rjc4em1nRHpn?=
 =?utf-8?B?eW5kMU9ad3AwVld2NmRQNXBFWTZ6UndKd1lIenpaQnZoQkhYSUNPOXBTdzFy?=
 =?utf-8?B?N0psMVFiaUw0clV0RUhIWStrek93bWtlZytCL0JSQXRuSFB4cjBEUTlWcFRR?=
 =?utf-8?B?TWJIMGNDZ3RWaEZ0L2gxZ3FzUXZ6bWVmalUrVExyVURYbWNTY2hlSkZMaTV5?=
 =?utf-8?B?QjdJQUpNZmVxT25yTnE2OUhQTWdkRUF1cUpSa052RXQ3OTR5Rmx4TmRuTDhn?=
 =?utf-8?B?WGREd05wdEV4K3RtVTlaaU5vT2o3TTdCL3F4b082cmR6eHBTRGtYMXdZd0g2?=
 =?utf-8?B?QXZ3Z1l5YmhNL2U5STl6T3BEVENvdjgwS0JOdG1TcUFIZXlVMkFzdHJSVDFq?=
 =?utf-8?B?OUJtSjkzQkVEL1l5cmt2anZJZW9LUXlLNW9RdWdyTnFCL2hQbFFncEhCbjI3?=
 =?utf-8?B?S0Jka3VnSXRyeEcyYVFURGdmbXdQUW01TXBva0ZMd1lPa1dQdDVkVVVja2Jn?=
 =?utf-8?B?b05jdkRyL2VuOWxiY25BL1JZVldlNEtJZFNoSGJ2L1Rac2VEVE0xUkEzSmJG?=
 =?utf-8?B?WFUxeVRxNHhtY0w3dVdneEd4ZUN2RGtpbVhPczh3OVVtczNtRGV2amltYXZZ?=
 =?utf-8?B?SGxieWVyWll4eEtuWjhjREJkUnhhUXpCVXJBaXF6eUhlODF5NGxVZ2ZTMXQr?=
 =?utf-8?B?NDNvMW5aaFhhVTVEUE1sdlpjcWZEV2JId0FTTjBPK2txdVMzNC9rYUVlUC9V?=
 =?utf-8?B?LzlpUVlPdW5oSjNNTjF1YWgyOVRBbTlUY1NTYm55OVgvNS8xb20xeEMrZlly?=
 =?utf-8?B?aldRV2pZR2Nvdld1MFNFc2p5VFVIcGJhYlpKUk1EZi9DTmIxQ1ZCVGRVS2Vq?=
 =?utf-8?B?QUZPWG5mUHozSlJCUHhCUTBUZCtVYngyTVdBendOb1ZaeVNvaDd3SEFQSlBO?=
 =?utf-8?B?TGFNR0VDNU9Qbm5JVnptcGlDbm56aW9HajIvQWJVQURRamlpKzI2emtXMGhS?=
 =?utf-8?B?QjdQb2NpVHBOVXhicGNjZkdGbW95ZXQ1M0ZDS2xzU3UrRkNhR2FKUUhTRnAy?=
 =?utf-8?B?U3liMFdaS3RhZExzcitNL1V6RXNUQXdHSUk3eXNaakx1OHpXVEtNZ3hQcWZZ?=
 =?utf-8?B?NVFySGU5SFd5cDdteE4yZ29BZ2NwTDhtQlEvdVcrOE9PSVNYTE5QMEFlZCtI?=
 =?utf-8?B?THozSFVOYnpZSWptZXVPMmZiVmZ2UUVnQTRQWkhEakpqREYvcnM0RG82dTFv?=
 =?utf-8?B?bmlnYTdyZVA5NGNsaWFDZ0NSSzUyUkhYMmVZRVUzSmVISVlYU21tVjkxWTRU?=
 =?utf-8?B?Zkorb3Z5eTUwNjF6cWh4Nko0TEdRbi9STEtUVnlUVnl3K1o2YXlldVlCNE1J?=
 =?utf-8?B?U21jSWtmVW1EKzBaRWJvUEZlRm5wZ25rN1h4KzNIODBpOGFONGYrUWRhYUlB?=
 =?utf-8?B?azRiZVV5N1VuWmhrRlVvTVdRemlEMVVZRE4zVmgxUXMrekYwZlFBWmVNcUpW?=
 =?utf-8?B?Lyt4eldzVVZqWHg1bit6YnlhNWdNY1k5WkJTa1ZuTDFvbVdmWnRPMThkVTdU?=
 =?utf-8?B?Z1dRSGZzUVRqT3pKZmpZYzRhdDVOK2FSWUFHNHU4blVBbGhHV2FrY1dpN2hl?=
 =?utf-8?B?QnMweGV2bGNnR0pkb3ZBaWh3aTBsUTNndUtxSURGZ0F5cFpBMjZwcytQVnR5?=
 =?utf-8?B?UzQ5VVk5ZVFtZWZuNEN6Q3I2bXZJYkJuVjlxNE9hbGNkYi9ITGRMVEJUaVI3?=
 =?utf-8?B?aTZoTjJDK0Z0V3pxV0JGeTVBSmthdmtxOHV4dDduNTNtQUx6NlErWTh6eEpj?=
 =?utf-8?B?RlJIVm1VMnAyWlBidERvM0w5L09EOUlpNkFuK0hQaUVIVGNBZWloVHE0T3lv?=
 =?utf-8?B?eDMyQ2VFU2VxNmorM0Y1WGp6bHhldjE4OHJ5TXkxNGZQakRMTnNzRUFwT294?=
 =?utf-8?B?Tmt5TTRabjJ1dE9DTUtqSmJET2Nza0E2SkgwKy91Smp6YjdQMU9oWEkvNmRR?=
 =?utf-8?B?NTcxVm9EbFZCdWwxazdnVXRxajJIOUFDWFJaTUV0eERFTG1pZDJoVjlHaW9x?=
 =?utf-8?Q?dOruMGbQWVa6PXEbGoL8xxKvZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6804.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c6eb94-aed3-4959-94ef-08dce77a79ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 09:20:39.2925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qv4XuNihWhpSc0F58XVnLH8gY0aC4tb1Ir8ogDfRjfkJQLlDfAFSqLg+F20HpuhsYGfY+WtrWmGoZzShMtmFYtlG/EqS8IV/QfVsVGCoZA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7074

PiBPbiBUdWUsIE9jdCAwOCwgMjAyNCBhdCAxMTozNDo1OUFNICswMzAwLCBNaWhhaSBTYWluIHdy
b3RlOg0KPiA+IEFkZCBzdXBwb3J0IHRvIHByaW50IHRoZSBjb250cm9sbGVyIHZlcnNpb24gc2lt
aWxhciB0byBvdGhlciBhdDkxDQo+ID4gZHJpdmVycyBsaWtlIHNwaSBhbmQgdHdpLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogTWloYWkgU2FpbiA8bWloYWkuc2FpbkBtaWNyb2NoaXAuY29tPg0K
PiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmMgfCAyICsrDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmMNCj4gPiBiL2RyaXZlcnMvdHR5L3Nl
cmlhbC9hdG1lbF9zZXJpYWwuYw0KPiA+IGluZGV4IDA5YjI0NmM5ZTM4OS4uNWY5Mzk3NDkxOGMw
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9hdG1lbF9zZXJpYWwuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9hdG1lbF9zZXJpYWwuYw0KPiA+IEBAIC0yOTcwLDYg
KzI5NzAsOCBAQCBzdGF0aWMgaW50IGF0bWVsX3NlcmlhbF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlDQo+ICpwZGV2KQ0KPiA+ICAgICAgICAqLw0KPiA+ICAgICAgIGNsa19kaXNhYmxlX3Vu
cHJlcGFyZShhdG1lbF9wb3J0LT5jbGspOw0KPiA+DQo+ID4gKyAgICAgZGV2X2luZm8oJnBkZXYt
PmRldiwgIkFUOTEgVVNBUlQgQ29udHJvbGxlciB2ZXJzaW9uICUjeCIsDQo+ID4gKyAgICAgICAg
ICAgICAgYXRtZWxfdWFydF9yZWFkbCgmYXRtZWxfcG9ydC0+dWFydCwgQVRNRUxfVVNfVkVSU0lP
TikpOw0KPiA+ICAgICAgIHJldHVybiAwOw0KPiA+DQo+ID4gIGVycl9hZGRfcG9ydDoNCj4gPg0K
PiA+IGJhc2UtY29tbWl0OiA4N2Q2YWFiMjM4OWU1Y2UwMTk3ZDgyNTdkNWY4ZWU5NjVhNjdjNGNk
DQo+ID4gLS0NCj4gPiAyLjQ3LjANCj4gPg0KPiANCj4gRGlkIEkgbWlzcyBwYXRjaCAyLzIgb2Yg
dGhpcyBzZXJpZXM/ICBJIGRvbid0IHNlZSBpdCBhbnl3aGVyZSA6KA0KDQpOby4NClRoZXJlIGlz
IG5vIDJuZCBwYXRjaCDwn5iKDQo=
