Received: from mx0a-0038b101.pphosted.com (mx0a-0038b101.pphosted.com [148.163.133.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF89936194B;
	Fri,  2 Oct 2026 04:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.133.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790915965; cv=fail; b=PtPqruQSvwkRPAxXFuakgEfnSCewHzz+nSMjS82DhHukOH31nuRJDr+1DLEY75im1I+jZOG0dQy5YEVKoYx+jbONeibBRN9GRGlaXWI8lvX8cPdj0GEuS2GB2q3hWbKxephXPw3VKFZ6lCVPJtSgbNXBizg+9cEF66gXbSpHHJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790915965; c=relaxed/simple;
	bh=bitgd5z+jgEStks4IAJcHal0sdDCapiwEV9ljKGn7YY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LvPdahW4dhiDTRmx4kZzBcpPRnkVpJLgYMiYyKYpJ77Q9YAXHUW01RCkJgRbIp1CSZgDw+JYvEsl5Lb3mt1EhX9Uv0qSzOT6T2MzYqxEFEodA0cQ+ghxkxeYaiMV7qwAusncJ+svEjrG/Lsvj8SV6hHjFGlcimGbnQ7uq5Z/5m0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arthrex.com; spf=pass smtp.mailfrom=arthrex.com; dkim=pass (2048-bit key) header.d=arthrex.com header.i=@arthrex.com header.b=dLA37ao9; dkim=pass (1024-bit key) header.d=arthrex.com header.i=@arthrex.com header.b=ps0DujRy; arc=fail smtp.client-ip=148.163.133.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arthrex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthrex.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthrex.com header.i=@arthrex.com header.b="dLA37ao9";
	dkim=pass (1024-bit key) header.d=arthrex.com header.i=@arthrex.com header.b="ps0DujRy"
Received: from pps.filterd (m0171576.ppops.net [127.0.0.1])
	by mx0a-0038b101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6922QCPN3701398;
	Fri, 2 Oct 2026 00:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthrex.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	Proofpoint090926; bh=bitgd5z+jgEStks4IAJcHal0sdDCapiwEV9ljKGn7YY
	=; b=dLA37ao9hFnEdRP8dq0EZraiBdfNhdD5MLqfCygVYBVsHFcDbXz5g6+68Km
	X8/F63VJ7fdOpgsCKTHT6trW6ChhuyYJPBCayETICcAKvq9ggV3FynHjhcYrkgMW
	JSzgMBv0IH7Y5PNTG1fp1tUKQu0eJY9o/k27L/OOUH8FjBsCR9MbEjR5v24kbbDT
	PrFTXiLfXftVI4NVxAOlerMUd1AjGKgeaf+FkEZgKZdwfmMuuA5Fl+7DZ3Rnk2Pq
	Zh1dSHfEyDRu4vE34l5h0ENl9kz2l21q0fiVJ53GHPWyX706J3D7yqllIS3ugSe0
	ryHy+70cDdF1NA7r4XExwYRTugw==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013063.outbound.protection.outlook.com [40.93.196.63])
	by mx0a-0038b101.pphosted.com (PPS) with ESMTPS id 4h1svtt737-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 00:06:22 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFgqtUABxJDOZ8WFQMtW2/7ovaoMG+CO6G2Qarw4tbwZ31ljsplvcpUsE7TRWaJt0i5bw98E4IhR+6MZQrZM70dmm74ggTo5XLpdSo51FF64fceUEQc98D5lnDFbwiGJtoF6usUqENZnIifw8H0bXEsAXXFsHB3Vr6e2lKa3BpJ5yxDT6iZCvFy9Hop1U4xuTsC4K6HhtxAQTf9AIMnYDa8BvosGTVI6KUMm2esOIidqlQJl/k7BjqYw+798Jw0ftymMtn6UjSlGvqTZqHj7tLzGcRoRXDPS0qJTpgc0oY00JlivVvdEZkmXjMzQMkIVaiWrWu2gPXpEBp4ypC/PXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bitgd5z+jgEStks4IAJcHal0sdDCapiwEV9ljKGn7YY=;
 b=JAF0oJVmwcpVN4LpCQLRRvuZlFJfW2VRHWJ0a6sdurIn5cxARJIl4dV+ZqNlOVKHvh2u1YRNJc3G5HV9DiynYRz/XY4dosAgWBnv/7067+qXWMkchW09edVMQruyp6oAdnnPPIB6HfBNCk1Muguwb9GBD/NTZbWTjrwLt0GAAk9Auxyj91wVEH9OGqWw63j5Jqd7rYOjh1O7bjw9dxF9rXpFqgXE4ZF/H1mzQ12HTgc1BroHV1XW6cnjufjzOkbkh+c/yEawfu6Bh8/zMSIdxJP00+NBhvoJQ0HaFwnlsX9B3fWumyH9oTTZ5zpizQw2fyppIp/BCDsiL5WhVQxNeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arthrex.com; dmarc=pass action=none header.from=arthrex.com;
 dkim=pass header.d=arthrex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthrex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bitgd5z+jgEStks4IAJcHal0sdDCapiwEV9ljKGn7YY=;
 b=ps0DujRyiVYjKZKVseFKiiJ4X6KMt+yQWUZhuWXzIcth2zjwEpedpHB2PVP4d+Q53LdXXkG2vR2EQz/GT+6NwzFejqTpM4NyNqlHhj6qFPpmpWIOh9QCq19R3bDnHf3KiNzVov+SdC6hvJ7aGAKzPN98hTZRs7zVepo0EdWrD1o=
Received: from LV8PR11MB8557.namprd11.prod.outlook.com (2603:10b6:408:1e8::15)
 by PH8PR11MB6878.namprd11.prod.outlook.com (2603:10b6:510:22a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 04:06:20 +0000
Received: from LV8PR11MB8557.namprd11.prod.outlook.com
 ([fe80::ff75:7102:4056:b2d5]) by LV8PR11MB8557.namprd11.prod.outlook.com
 ([fe80::ff75:7102:4056:b2d5%7]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 04:06:20 +0000
From: Austin Schlegel <Austin.Schlegel@arthrex.com>
To: Laxman Dewangan <ldewangan@nvidia.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thierry
 Reding <thierry.reding@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Austin Schlegel <austin.schlegel@arthrex.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 0/2] serial: tegra: fix RX/TX DMA descriptor
 use-after-free
Thread-Topic: [PATCH 0/2] serial: tegra: fix RX/TX DMA descriptor
 use-after-free
Thread-Index: AQHdUdenxLe3wNbHeESn5+Xi5HA71bbpfhFk
Date: Fri, 2 Oct 2026 04:06:20 +0000
Message-ID:
 <SA1PR11MB85433C17AD648BF60E4529CAF0892@SA1PR11MB8543.namprd11.prod.outlook.com>
References: <20261001-tty-linus-v1-0-ecb8576c802d@arthrex.com>
In-Reply-To: <20261001-tty-linus-v1-0-ecb8576c802d@arthrex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arthrex.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR11MB8557:EE_|PH8PR11MB6878:EE_
x-ms-office365-filtering-correlation-id: 4863a644-8d01-41dc-e8bf-08df203a83ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|23010399003|1800799024|22082099003|18002099003|38070700021|260925021911599003|10067099003|260925022911599003|260925021311599003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 UoiBuWsnINhMO2Eq77tFYI/Ns0rdRmwoWCbv5dLnTs/IfkoyS0ahKEGBFM4UcFYKY1k8siRjxehNF72mDKhdBcEueo7xhG1tFsI5vA0510nlVtfNnjl7kNXQ6HdA7sfB2aqkEEt76L2hmVoe+dELXEYZu5BRAN3ZT6hMORSi7WXgtpuCPP9iu2NxmeL/cKeaBOHt3N2PnlA7sHgR5cnc/gQzCMUDKfAqQiKOykiIjvrVnBh+mKQFXmmpY2et/uoDz2sqLZpk85+to9uwb6zzLqJA2MDETEaYLrTwbXqyv/QX16IAXE4uDcYmHN1K3S6EMhczrL2AzkFk+4gmvezZ2JLwSpZKAYW8v1K4r9h99QCrBuPFsc/m7f+0Nuqx0NDbxNhfWfIgwFIkUDarMBZLIstfK+eDnzQjEKGf1R46dYIAxkj65MO1los11gnz/qVpBU/g06AL9+LJJwBS+8UAdIGCjmeVG3PuaAUjEPZ25cT5tNxUy+ywIE6or8JEKS6+n9cpFhXJm1YEn0aWYIdKnQivCDyCySkCSEVpv8LmH8g+LtqG0y0NHjDCt+R7ygbHKzCJCTvqpwCM5/h5gMSBeDu2a9dYLh0iCBYwdgEuGG9QnOrzVj0+nBi8yxtm2MTRi3++Sfuwzu27EYGM89v8oJ1xgCHGdjzIJKGOYXZLZqnCvvhHkz6IsZUWo5YvI3LXi+R6wj6r1w67pBayGDALRg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8557.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(23010399003)(1800799024)(22082099003)(18002099003)(38070700021)(260925021911599003)(10067099003)(260925022911599003)(260925021311599003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?iVHwQfEAfoenAhxCYCjUXVJBiImDzPm3kJGpr3ThpvKHlY0ZcUDH2OGVcB?=
 =?iso-8859-1?Q?oEfwUBtNWnfJwaINtWzqidRj6tZittlKA45YX3q86OSkA9ZDgfsQzgLHUy?=
 =?iso-8859-1?Q?zNscSQhdqyUf3pLsbnmB4Vv0BBTKrUXe/+1CH5WzqgpZZ2juOyP7pWlv7J?=
 =?iso-8859-1?Q?O+7Zfw1PfMrO8mIomgXjQ9gOTJiOZosaCAcnD0neBg7QxwyZi3bEtDlobu?=
 =?iso-8859-1?Q?zTjaff0pJ88IFhU0yTcrDyAyEudYbTzOtnS/IxQT6pjYyk6xWU+3RxyVz2?=
 =?iso-8859-1?Q?fH4ux5jqwCEUmVFnGsiJNB0Ne0+gnuGR1fQQCmu7kY+zjX8InaNQe7IppN?=
 =?iso-8859-1?Q?5MvfVIlgyuPPzWN5f8McNFTAfR/WQDo1SQYxizDkOAgMhd51Bsmul4Wk4Y?=
 =?iso-8859-1?Q?Q433LJRxD/AydvPCY1m21x7vwzp8tFaiXH6Vg1SgRnhShhGfEZbJYc3FzT?=
 =?iso-8859-1?Q?l9xfOg5FpXgqXXHBGA5F3tvelSH9m5HSVnIWgJkIU3HdWMxARrJtFuMcGz?=
 =?iso-8859-1?Q?jUNOmaHT8JpmfgzHgquCIWGS5DVY6GgsPWW9H5SaT2R+rcPN4P0MK1tRGe?=
 =?iso-8859-1?Q?Pmg5xG0YJtf0GO0iGqA2W386ibjZdewdjzFzObUKzA8skWhdY6ahtVk0rX?=
 =?iso-8859-1?Q?ZNZwKg8706jQ+CNtCe9ojLvyOzbVPmR8JmVEHwHQFUdFBg9dXGBbO/9LE4?=
 =?iso-8859-1?Q?zYdtWXylpypz5Rw7WILRruSIBCBqcd4J4Uez3iLHV5aZnCeCC23K/+uZVo?=
 =?iso-8859-1?Q?nedFgL6C0EPLAgbThdJE7QCQNxW9VsaUpEVDzkmhcCuBVU0inZfAK8/zLr?=
 =?iso-8859-1?Q?9XehJLz7L73bCKfiUta5scmP31k6H2MwON1AR5lKlOKb6JFf1TCHg/UsTl?=
 =?iso-8859-1?Q?56uU+KOJFXPWzhdHdLPqhDcixMNia69MMMTDqwWwwVr2eNOt/aDD46RkQb?=
 =?iso-8859-1?Q?L/VuybhRsD/1nswZpf/I8l8UI6NO8YeTDz5hQ+OlJzDOtE6PKWj7f78582?=
 =?iso-8859-1?Q?IiW6RuL+wlB3TGpWBNHmoq7QQh+5i/deevl2WMPEhFk+9lfswwP03zIu/J?=
 =?iso-8859-1?Q?SS1EXBkYHiF1/tEq93ZjhkdF0gC+m63Tql3h+rG2HTCraybDv73lX39dhe?=
 =?iso-8859-1?Q?RUdwEBk/B7W9HXKVK34lnhPbdTceEdKrCT3AFJVtppeC3yOgzFQ3ZOv8Ir?=
 =?iso-8859-1?Q?gOh73w4AIpsbanaNUEKhl63PMbbUI9bH9P6cMBi0BEkFNPz6ubbIxDDvHR?=
 =?iso-8859-1?Q?iUNZl1mfjR0s6xbQXCnsgMGriZwFnauJK6+sgCbhCnxyI3fM83JpqgX7HD?=
 =?iso-8859-1?Q?82m5iCgQq9iuG0o2cZTCoEPBswxKHT2ufCupFb8YENq0VYAkzztdY3ddVw?=
 =?iso-8859-1?Q?ozAMwVuT0L0HBiagcdyFR0oHM6mV7+7TAEiVb+d8SoFYjulAeXIjvL8kQZ?=
 =?iso-8859-1?Q?vCXhgbUgN5TYlx24CQr/6wfvI0pgdS1jTzBWw2Xpea9+KfvL+Sje+J6Mv3?=
 =?iso-8859-1?Q?cmrv5+M25oZ0HpAlCSCGhVGG3gdFu1LzG8Ta31TT8Evzjfhjk5/7hkEp9a?=
 =?iso-8859-1?Q?RtBPIH8/QXq8h5OajaldUMXqrUKRzMA4hfigNuVhDCRxXr0Kd8iZLoIbhh?=
 =?iso-8859-1?Q?B+F+DwJ8M48C+Wj0gTcPDzbLebfKMV0+HcAmTXT567On81QPbrGSN9L307?=
 =?iso-8859-1?Q?jN7Z4exBZ8nWCV5xVoGsSsL8Jqv5QAcS65dfpSMGioUg732xrd5eoByXHi?=
 =?iso-8859-1?Q?iebIJmIHJf90PtwY9L4H1CKn0A1E/5QVCm7URkUI6acxYiS8wx8uPjG9YS?=
 =?iso-8859-1?Q?91Gpw4IX4+B0j+Cb/vaILM5nhkcjbfLpl6g4Ad27ndg2taWLvd9S?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ALbxJ2p2VmSQoz92bXskEd2+sOFoNvAFH7dTGQLsVEWDV5hsN5lOMxwBOv4PNB0jDlXi3CkH7nGMETi1UAmP+LKPlwa0i3EYY+K0qgPnVlXYnnkrp410wJteV7rg2k76xHIstudjQL87oEvdyezdy/fxvxYjlieGlb/WLraIKmABvNUDyMRguNKJum0q0Xkx2JTsA+6eRm2F+Cg3IYZQ1FQPPGbiU0Onj3WvNlxigxn6845qm/mL00lNtZnboTV84hWWb21tFrYZmSkx0WD6oJAXuEctThhoc234HXTMKJH81uce4uruat38QgWI2cOpWoikvrrB54WvBeWZMhJWww==
X-OriginatorOrg: arthrex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8557.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4863a644-8d01-41dc-e8bf-08df203a83ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 04:06:20.3139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c970182f-4161-459c-8a07-2b00ed24c146
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QPvPTCVdUKhlWuYC0gSHrEJVA+Q6EgssfADfNaHzGe6vh1+hq2lW4UER7KExHxRDv9vbf3aN+mQksuB2ClL33g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6878
X-Authority-Analysis: v=2.4 cv=dIAzC+Zb c=1 sm=1 tr=0 ts=6abf2dbe cx=c_pps
 a=VUNJaWZlx74G+l0QYBOIDQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=660iZSQnnn4A:10 a=gbA01DrXz1UA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=70HZLsTLPGYbawPVQYjx:22 a=4g0OkPzbsB2Xedxo-XT8:22 a=9c6j8fwxAAAA:8
 a=yW9ijH_GQebpuA_1f9kA:9 a=wPNLvfGTeEIA:10 a=orddK7cku93UzC8moJry:22
 a=qak9Fwl7LPiBl4gFUzZR:22
X-Proofpoint-ORIG-GUID: 6S9NAkaijXeaKrh2t5DbTfXHrqXkVpEI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAxNSBTYWx0ZWRfX0XkwtPUxrsLt
 TCGidQVLPQyakimfmPMGpcHiBy4elrSidiSKI0eEzpo3wKCkhhCJ2Z5j79TH/h71I0Ui+jJiO31
 ueJYOW2SlttwGq6K1DW793m0MS52KKoa+BgPHJAtD0MEYCrDCvaeXDxokJuZDF1kX3/3UqaaXx/
 J/UL/Z6OqA0PKhcVlhe7l2Fv84z/ZgCdU+dgV4j/7TGjC1TJESJJxSd9BXZ7KMhw/deIeoXUTVw
 IMH9/7lMoUSezIJqlP53laJ1GaX/5zRxs2Q5FM2nvZF2RGrs6By0fEOkvuiw8MJe3HL7N/TsI0j
 hqCd250dQEQBo0tF6a0F8Z3xfVc+3wudm1+7Blx9dSXfryHAQqTINxVpxY0jOVfaC/Fcxp2fPCl
 PkfaUKEy8hPZKuDaSs6qp/3g6k4xIA3T89ACdYKmrcf+Vazx5Fpjmlso7cRDzf2c9CEXhEPRISJ
 Fnwa8eeDTa9VlE7eeGA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAxNSBTYWx0ZWRfX0snbfgXPS0nf
 T2n4Yp2oYdC3IZjNh5TWeVQfBbLurn39whqH/m6aL7sEA4fvUOTBp0soY/KMAnWYV2j7/SGcMoV
 S2U6QcmNV+moN2nsOKQqeNKIqFpgt5E=
X-Proofpoint-GUID: 6S9NAkaijXeaKrh2t5DbTfXHrqXkVpEI
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1011 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020015

> Signed-off-by: Austin <austin.schlegel@arthrex.com>

I also forgot to include the AI disclosure. I will add an
Assisted-by: LLM in v2. AI helped with: patch drafting, code-path
analysis, and creating the soak test. I manually traced the bug to
serial-tegra.c, verified the new ack placement, and performed the
soak test on that hardware (Orin).
This e-mail and any files transmitted with it are the property of Arthrex, =
Inc. and/or its affiliates, are confidential, and are intended solely for t=
he use of the individual or entity to whom this e-mail is addressed. If you=
 are not one of the named recipient(s) or otherwise have reason to believe =
that you have received this message in error, please notify the sender at 2=
39-598-4302 and delete this message immediately from your computer. Any oth=
er use, retention, dissemination forwarding, printing or copying of this e-=
mail is strictly prohibited. Please note that any views or opinions present=
ed in this email are solely those of the author and do not necessarily repr=
esent those of the company. Finally, while Arthrex uses virus protection, t=
he recipient should check this email and any attachments for the presence o=
f viruses. The company accepts no liability for any damage caused by any vi=
rus transmitted by this email.
