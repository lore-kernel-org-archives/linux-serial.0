Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFDD36B058;
	Wed, 18 Mar 2026 12:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773835968; cv=fail; b=Q5l4fvGUB9t9XufUPNg63LMHn1IMbaLdMIVgf2Bsames62+7VuEeHDdG9xf07Bcf8UHHj/Ntx3z8UV8DV2eKD8lbFy2/DeBzu912IsgqWrNqfm/HTnKQ1bmExZ3rLen7DbfVjf4UDg0yh5KQNbKd6e2AIA4vHuO/lI8nTHqHICo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773835968; c=relaxed/simple;
	bh=I+Hco7vnU/3rdBHWtg0lkBJAvijt64o9KCJuN4YZ4dw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C9JuGKB/qFpa2xQOJuBsUUnRLi84fobM6UDphfQRSW46UIsvHigL4AMzuKB7TNbz7eXrtLwiPsMKH6K/fblu9hnd3KVrpZQk/gjotJuKtQv5LubErZYXhvWA+KP8oBIKnUaRynOt8BSM7fXpMySYCILRTEy33T2JoPCiSj98SSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kZc+EhAl; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=dBevi0VL; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kZc+EhAl";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="dBevi0VL"
X-UUID: c35102ba22c311f1a39cd589f645bc18-20260318
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=I+Hco7vnU/3rdBHWtg0lkBJAvijt64o9KCJuN4YZ4dw=;
	b=kZc+EhAlshim9vT9Jbw8kgjOgbmSUW8CeekkclUhApD3jfyuJcDYfPu7csTnMFNTwSk4P8QF4Xc7spqVAPrbeMvqtmhUpHr1gc0DTRSeucq3a9baZZgjNbeN1RuKbo770dmlAFynXGwMbKPAAqI4CGyD0uxJCjVHlmIVWLvZEkg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:957c1db5-4d6e-483c-9e4f-1596d4873dc3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:8feeddd4-060f-4ecc-9ee0-121eeeb4a682,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c35102ba22c311f1a39cd589f645bc18-20260318
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <zhiyong.tao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2092264601; Wed, 18 Mar 2026 20:12:41 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 18 Mar 2026 20:12:40 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 18 Mar 2026 20:12:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J45hE77jbqNeuRdopF7VQhpmlyEqi7ZAnRqMTPSX1g0TGSkMGruRp5KmAyQp9QY9rPk5s77v+/CgZZQqOVvJy/c/vu9co69fpTlZtQ2l4nt+C1WCCm94sv3l0mO/xc212CNcnhjUFaH90/maVOIQOV9YAPwUk7vljPbYvCVeIcVkIeTxkpqZQAU3OROf/Ltz7T8G+/neN8G/BOUBqKjHjw2L84oFCoGNb0xNspHypLSAXQp3ps9uWgA7X736Ild+WGzT4wkWilGXldjCkdeBBGAeOY8uW+3dO+wYXmzxqCvUwOLtfUazINbtlHHediDWiMfauKSgksMgzQzsO2Psuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+Hco7vnU/3rdBHWtg0lkBJAvijt64o9KCJuN4YZ4dw=;
 b=MpejeJyc7PrAWa/fdW1ZYd8feAZgG7DocxsR7VTGSNphb1Gfw4rQnfmL14s9uK5DAfZ72JIqPBgaIbKMyq3sawuqCwbL0qXyNUAeFFaNffMJCMWjYhmqLN3UTferArGDL5nUD5FZfp73R1QmnVnCph5MOgn0CcE/G6X+5nISfwZzQVxWPe/kIS6z54O8cvTRPXQrVAdZoqnvdxqXDktrpMDbRZWU+++KwQRTzMoQ1SqAbAJiJKF5XPq3GPiBkAUCWzRC88KqyW+mSwFfhTsTvS4ri0MXFLS8PYncJf4jipwyCncM8E++4lJ/YUxtX7D0ArdH1WI6q3vX6bSbA2jyxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+Hco7vnU/3rdBHWtg0lkBJAvijt64o9KCJuN4YZ4dw=;
 b=dBevi0VLSFkUZBa/3io+tiKRmV31OExa8i7m9UDGH8+fjpov8RhEsoys6S9ezXbZA3gxY+qWC+nvS0B5ZPf9vbIhsLf1v3yp6LjklJzJbCThohMp0axXfqHr6sRrJpCvGpLUD11HME5CFrupg9gmNzj9K3fM5nCGEonlYOqukA4=
Received: from SI2PR03MB5690.apcprd03.prod.outlook.com (2603:1096:4:15d::13)
 by TYSPR03MB8110.apcprd03.prod.outlook.com (2603:1096:400:479::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 12:12:36 +0000
Received: from SI2PR03MB5690.apcprd03.prod.outlook.com
 ([fe80::7361:3cf0:b441:7d0e]) by SI2PR03MB5690.apcprd03.prod.outlook.com
 ([fe80::7361:3cf0:b441:7d0e%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 12:12:36 +0000
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
Thread-Index: AQHcfey/SO6Kleh1dki/LWqHFZdmJbVE6yeAgBdV9YCAWGQMgA==
Date: Wed, 18 Mar 2026 12:12:36 +0000
Message-ID: <6478a71ffca65e58fa19a5edbc25eb5f51a8cc12.camel@mediatek.com>
References: <20260105024103.2027085-1-zhiyong.tao@mediatek.com>
	 <20260105024103.2027085-2-zhiyong.tao@mediatek.com>
	 <2026010643-ladybug-tiring-7f3c@gregkh>
	 <434e34f05bb5f87b59402811012e3a2f56f2182e.camel@mediatek.com>
In-Reply-To: <434e34f05bb5f87b59402811012e3a2f56f2182e.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5690:EE_|TYSPR03MB8110:EE_
x-ms-office365-filtering-correlation-id: c20c5ac3-1f74-4cb9-5c33-08de84e7a445
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: B3PyhR1taQR4SVDgrLDsi5Y6MQkeHDC0jVO2wHgthMGw1hv8Ffi5Ht/yb/3Xu+os0Zs8HIYcZJNsrlB2l7K9Qdf80IHeGQiMspEXrCl7ZJ38FipIidE0fohX/nXx3viirBNwmbrNObP0InENPXeTm9GwbejneZynr9yziVldNnVcs5G3bNRx6NPyqrqIgcd8vwrgl8HU7/SWnynLylfgXJk5X+9SSqCU3vgJgkt00xYy2uXbaNUerGHB9a8CS6Ah/UX9LJwEMqq31pciXBIfUQDm/t6bR0fSPD2d4dVB0rltHnb0NWAAsaFG4hHO0rBTQVOoyiZIojWnog1GHccnftMxjOvT7z8PdwuVQVBLq2VfmV8HQ+6j0kscaCYtV6p1fNJZUkiJT1rK9l9rhPknm6dJ0/FKnWDHvy8GoUYxgXWvasY8txb8WBjo/V4ZaiN3GEEYB6lOMyWbCs4dbtQ2TuYVv98y1naSg5Zoxjyj52UR8HCkT/AkUOHocnG9H98y9wgWnjX+8y6ck3EucIKHNlcYeyAEL4CEqthxK6AUL7OZufeEjMLXPCPEC0bz/YG2ILrr6uxVjHAmTBqVqy8/VWwWOiAJJlpm4RtwSi6lfP5dH7dQYuXTB4xLhw6NLchB6MffNG/AwXb/4lIPzAhPxwct1c2Hxdjw7Yo6h+pqrp0StxPP3JW9hQa4bWG7yRfu1Z+UDK1DbGBF4qgjWjaga27ElaoPuLXMrU/dXFy7Oy9cDoKKFJzb2jgb0re3xO0g6P4G3b0OvhhIX9WBA08Y1EQ1uss/oDdNngOqcWKfuEU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5690.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1JkU2I1YU1ocVdveUN6WjBEVWZWSlJ1VlZ0TmlweGNobmh6K2hxMU0xTG9X?=
 =?utf-8?B?cGtxUURpVUxQMzBKSlRWanNIdGNCelgyWDNmMGRRSUloQ3IyRXhFVlNyU3Zw?=
 =?utf-8?B?emVodnFCRFFCaFNLYWdFanlHYU5yUEsxNDE0VUdONnlOVnZLcUx5Yll2WDhw?=
 =?utf-8?B?Tmp2enAxWk5pWDhqeWpIa1FaV2hoa29vRk02SElJOEtOWHlTSlFIMVNKaEVm?=
 =?utf-8?B?ZzZRem02KzErNW5VZlVTamNwZEFzNGEyOHM1MEk2Sjk2UFJiYlBDLzREbG01?=
 =?utf-8?B?R1R2enMrNzJreHJKblk3amdoMTlhd05WZmM0eC9vWE9jelphLzRZQXNjVlZU?=
 =?utf-8?B?Zy9nV2xDOHVybTJOOHZSQnVtNUtmOU9BTGl4M2RFVm4rSlB3ZVB1eWlNSjZ5?=
 =?utf-8?B?TTNiTE5JbjNIODlxQjA4eTlKdzhrOEtmQkR0SFZOaW5zVDhQS3J6UTk0bTlL?=
 =?utf-8?B?TVlIMTlnRUo3Y3JoV25odGFmR2FJbFZaSFVWYStlUE91QVE3aGY0RUkzUkI4?=
 =?utf-8?B?M3R1c09PVXRlMDlMSXpMcTh3QTZ6TVRUNGgrWXpQaU9qK25aN1VHTGxxbkRu?=
 =?utf-8?B?VzVaWDJwV1AyUG5oSmZSTDUxWmVaeGc2akZhRnJjOVlTQmlYb0RKTjlndmk4?=
 =?utf-8?B?Q0plNGVDYTRyRUtTVHR3WEZSSE1ZOTY0RUc5U3hkOUdrTU8xNVpOWDdDa1dv?=
 =?utf-8?B?Szk1dlNOWE5xandQM2xERDJMdi9YM1gyL1RoMWQxNXZZWS9yaUo3L3JiUERU?=
 =?utf-8?B?NjdFQXc4UlkvazN5aEJDY0g3UW8yYkpjaEhiaUdZck81NzNsYjd3MERSck9L?=
 =?utf-8?B?RHloamYxaGszRitSdlpQbkVQZ0FpM2ZCY0I0bm9rUjNQWkI0bUNmNVFtOFRK?=
 =?utf-8?B?UEhqSU5KaHJXZ2ZLNjFkNS82ZDNBQ3hSSWpBZnlxckZGVFdaSHhoSlVSY3Q0?=
 =?utf-8?B?UkhiR2lna0pvalZ2UmZwNXVpV3plUzU0c3NHWFJxUDZ0SlhjNlJkTC84dUNC?=
 =?utf-8?B?ZTlEbFRSQ2p1bktXN0RMelcrVlZKRWJJNFd3QmdKSDArWTVFSU11dG9FMnkr?=
 =?utf-8?B?NWhTYWpZN0JTUngzbjJ2VUo0a2Z3b1VaM0hQdzhBTi9lR2I0Sm5mcXB3djFu?=
 =?utf-8?B?UjN2ZEZtWGxYc05TTmFJcjVOUzJhK1hJVkl5d29NSCtVOFRESU5YMkpYd011?=
 =?utf-8?B?Nm5WM1hNaXJuQUUvK1A1ZlVXM09HUG9tQklyZEh2NTNDZGIvYU1Zb1hVNGRI?=
 =?utf-8?B?ZVdDME0wOWV2czRURXlkemhpMzNuNTREeWFqdG9KK0xycHdZM2dZR3lCbHNW?=
 =?utf-8?B?NEVUakVUcXMxa2RsalRVRE84U0dOY3pCUW4vYkp1bzB2T2hsTDJtb3U1eTdT?=
 =?utf-8?B?U3FhM2d5K0ZHcXIvS2daamt4elc0WUluWlE5Yy9iQkEzYWtIYmVxODdpTzJq?=
 =?utf-8?B?bnZsQzB3OWI5U3hOcXB0d2RFR3N0RGxDcEhKa1BncWprRm5GZVNONHIvWWl5?=
 =?utf-8?B?cm1RZEVwZ0I5MHo1dVN6N3FSTTd2TDFYb3JDRlU1dSt4VTNWOXdweTM5TGZT?=
 =?utf-8?B?V3VORjl6K044KzZUTE51bUVHNDFva2M2TmFWRGlZV0tCSnNDUlRHbmRnZXB3?=
 =?utf-8?B?TktrRGRDTXVVL2pJWmVtaUxyK2tkbFpPcy9KQnRyS0dHUHdydjgwKzNHS1c0?=
 =?utf-8?B?dWk0KzY4WnRIV2RKTWZDdkxsalRQMVh6cHgvQU0yUjVrZytVZlU2NGhkVmtP?=
 =?utf-8?B?QmZyWXdrNXVSZmN4ZDNkVy9kNitjSDFRanpnZ3p1eTlQc1oyWkRqdHRBbFRI?=
 =?utf-8?B?aGI1S1J1aC80YVErNGpOekJQMWVVdC9MYXRwdWdkZlZPNmQweFRTYkZ3U2R6?=
 =?utf-8?B?RGtROXo0b1dMVi95Z3NSNk1Ic3JUd0R1aEwzT0RINitZc1doL0t6RlFYdERT?=
 =?utf-8?B?L2hGY2VxNW56MktGT3Rxb3VlWkZjeGhxeXoxRmJTTnNGU2YzR1RhM3BtTXUx?=
 =?utf-8?B?b2kzNVM2a2htVE4rL2RvZnd5YzhMMVN4MGNOVXVKWXRRQVI3TG5jQVZwVnM2?=
 =?utf-8?B?UVFtbGhmUEtDOFhaOU9vTzFmNElUVEFBYzhTaGFvQzlkQ1hqZmhoUzFoUHRx?=
 =?utf-8?B?Tjg0Z1NJRnRFUGRkeHcwWTJPekZUOGdiQUc2dGRkTmdudGJnWUZreFdzR2ZC?=
 =?utf-8?B?empLVGFJbVhaamRESSt4cFE5M1N4NWJ2NGpiZXZ0VXRhd3hsWlBJakkxVUNr?=
 =?utf-8?B?aFdPbU50eHRIaFNLYXgyUEk5VjdtM201OTVHSzBFMU14ZXU4SW05SncxTEps?=
 =?utf-8?B?OTBvY0Jyd0dCWXJJbXZDTEZlMjhRblo3Vm93OVBmZnZ6TklGMlZra0FSZkJm?=
 =?utf-8?Q?IT79ixboxsMXT73Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DAB0CF4227C9F42AEF846303DE5F1D6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: g3MXuQ3akGvEv8GIUnPju5PBzwTYsikGd7RDS32gvW5gpij1EGHLZcvKXWHYsqSHRhsw2467jR71hNstaQWYJhAonu1Wby/yJf4d11AKMuL6tgqXx43nhubsxUder732IoWCh8WjpV7si9LooybiIOF/EdzClcqkDKXRR/T8CiSGUfDQ69L6UHs8cT4rpXLLmcFt7gM7GmUB7qXID9bGun4sXFd42Rhta7JxGJGynlIFtxl4OuY0BaeQjOUgmUC5jOObeOxcAKCwnVSIhzZE5D7cMbqR0m28RSLrxvPB7myGXAzSUNPJXQ4l2r4ZU0RtNJkBofAeSnbrBQPF3jrVlg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5690.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c20c5ac3-1f74-4cb9-5c33-08de84e7a445
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 12:12:36.1385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pTt0T2sHyW8wFoN0/QJWHRQZ5rd4vfISmmZTgxqHaE1DKpmVSfaixGEyDLU5SSuTEDz4olvPcs9CZLGuIGfw518CnUFjO9SA0cRx4DTUkJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8110
X-MTK: N

T24gV2VkLCAyMDI2LTAxLTIxIGF0IDE0OjIzICswODAwLCBaaGl5b25nIFRhbyB3cm90ZToNCj4g
T24gVHVlLCAyMDI2LTAxLTA2IGF0IDExOjAyICswMTAwLCBHcmVnIEtIIHdyb3RlOg0KPiA+IE9u
IE1vbiwgSmFuIDA1LCAyMDI2IGF0IDEwOjM5OjU1QU0gKzA4MDAsIFpoaXlvbmcgVGFvIHdyb3Rl
Og0KPiA+ID4gRnJvbTogIlpoaXlvbmcuVGFvIiA8emhpeW9uZy50YW9AbWVkaWF0ZWsuY29tPg0K
PiA+ID4gDQo+ID4gPiBBZGQgQUNQSSBzdXBwb3J0IHRvIDgyNTBfbXRrIGRyaXZlci4gVGhpcyBt
YWtlcyBpdCBwb3NzaWJsZSB0bw0KPiA+ID4gdXNlIFVBUlQgb24gQVJNLWJhc2VkIGRlc2t0b3Bz
IHdpdGggRURLMiBVRUZJIGZpcm13YXJlLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBZ
ZW5jaGlhIENoZW4gPHllbmNoaWEuY2hlbkBtZWRpYXRlay5jb20+DQo+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBaaGl5b25nLlRhbyA8emhpeW9uZy50YW9AbWVkaWF0ZWsuY29tPg0KPiA+ID4gLS0tDQo+
ID4gPiDCoGRyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfbXRrLmMgfCAyMyArKysrKysrKysr
KysrKysrKysrLS0tLQ0KPiA+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwg
NCBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBUaGlzIGlzIGEgcmVzZW5kIG9mIHRoZSBwcmV2aW91
cyB2ZXJzaW9uLCByaWdodD/CoCBPciBkaWQgc29tZXRoaW5nDQo+ID4gY2hhbmdlPw0KPiA+IA0K
PiA+IGNvbmZ1c2VkLA0KPiA+IA0KPiA+IGdyZWcgay1oDQo+IA0KPiA9PT4gSGkgR3JlZywNCj4g
WWVzLCBwcmV2aW91c2x5IFllbmNoaWEgQ2hlbiBoZWxwZWQgdG8gc2VuZCBvdXQgYSB2ZXJzaW9u
LiBDdXJyZW50bHksDQo+IHRoaXMgc29sdXRpb24gaXMgc3BlY2lmaWNhbGx5IGZvciB0aGUgR0Ix
MCBwcm9qZWN0IGFuZCB3YXMgbWFkZSB0bw0KPiBzdXBwb3J0IFdpbmRvd3MgQUNQSSBzZXR0aW5n
cy4gDQo+IA0KPiBJbiBhY3R1YWwgYXBwbGljYXRpb24gc2NlbmFyaW9zLCB0aGUgYXBkbWEgY2xr
IHdpbGwgbm90IGJlIHR1cm5lZCBvZmYNCj4gaW4gbm9ybWFsIG1vZGUuIEl0IGlzIG9ubHkgdHVy
bmVkIG9mZiBpbiB0aGUgU1NQTSBtaWNyb3Byb2Nlc3Nvcg0KPiBhZnRlcg0KPiBlbnRlcmluZyBz
dGFuZGJ5LCBhbmQgd2hlbiByZXN1bWluZywgdGhlIGFwZG1hIGNsayBpcyByZS1lbmFibGVkIGJ5
DQo+IFNTUE0uDQo+IA0KPiBBcyBmb3Igb3RoZXIgTGludXggcHJvamVjdHMsIGFwZG1hIHN0aWxs
IHVzZXMgdGhlIERUUyBub2RlLg0KPiANCj4gVGhhbmtzDQo+IA0KDQpIaSBHcmVnLA0KRG8geW91
IGhhdmUgb3RoZXIgc3VnZ2VzdGlvbiBmb3IgdGhpcz8NCg0KVGhhbmtzDQoNCg0K
