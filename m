Received: from mx0a-0038b101.pphosted.com (mx0a-0038b101.pphosted.com [148.163.133.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8954729BD91;
	Fri,  2 Oct 2026 04:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.133.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790914069; cv=fail; b=J+5O5S/rQGxef23r6PSBmkHmtOAoNnO2QJflgI0EnurzTdBlGpK0KxL1vFaxtZwsUbOu9AX/966Qw0NwpnCqTeY3IM0aHxEKQfWDzVHRfUkd6AMe+zJmlLyoegIRgYfQ8AZlvCi3vE2XdPv7UkvvhiAA58c7UBAoBPFrgK/Bfgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790914069; c=relaxed/simple;
	bh=stHN0I/+fiHvWT0R7Fw08ed47AJVp87YRDEQReux9vI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g0QPe2TLTantZ2i+Z6/3Ive8JJ1IFARmMdK6F5FtgNFTZ2gVrHagFoWebT3hEU/dwcvUPcfvymIFMNRzWqFJ8PdqH+rNquHGKh5tEctx04pePL7ldMQhUxTcT7nCkRMqfazM5oX54cU8SnnLHCE3HTcJdehjq79IHx/5ZOaMajE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arthrex.com; spf=pass smtp.mailfrom=arthrex.com; dkim=pass (2048-bit key) header.d=arthrex.com header.i=@arthrex.com header.b=2ZoECvi9; dkim=pass (1024-bit key) header.d=arthrex.com header.i=@arthrex.com header.b=PrrqOzkg; arc=fail smtp.client-ip=148.163.133.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arthrex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthrex.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthrex.com header.i=@arthrex.com header.b="2ZoECvi9";
	dkim=pass (1024-bit key) header.d=arthrex.com header.i=@arthrex.com header.b="PrrqOzkg"
Received: from pps.filterd (m0171575.ppops.net [127.0.0.1])
	by mx0a-0038b101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6922Mdj71628831;
	Fri, 2 Oct 2026 00:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthrex.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	Proofpoint090926; bh=stHN0I/+fiHvWT0R7Fw08ed47AJVp87YRDEQReux9vI
	=; b=2ZoECvi92l848lJ+ZCM+ywPOW5k3CgQAp1WkUfl9PHG2EnbwsSi+mZlfRRF
	9XoSvG1gF8NMzRjqT0tQEq45G0VGQSYZvDYoZfKBXH++QeMJRlnHrQ0BrBSwdkJy
	s9tKYMqu7Pn7JNk4KvK9GemICvynX74GzQ2IQr2IRu47zFap/zdjOMJSYwWE6JVV
	n/fM5WAOx3cn8fGYxuXoR+LEJUYD8QCAzjcqMkF+o4uAighadMtyx0TvEAE6Uml0
	WdBpK1NfCXNnAN9QQNQOxKFhX4gJQRejAorN8D4miuVPJoRJv6CdC9EAtXNirnZy
	3bZMizgM4HJUMNCN9ER8irnIemA==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013010.outbound.protection.outlook.com [40.93.196.10])
	by mx0a-0038b101.pphosted.com (PPS) with ESMTPS id 4h1nmwb8yt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 00:07:42 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncePt6qmV+j6yc7x5ycjcubiIFTPcWM1B28+MPvQyr3kxoVrVYfrfVD4JfBuN1Aiqz454IOZ7zY2ZPWqGVguKPDRBoqddXm1jlUQXGpdkrqqg+6vVjIACu9txGYFsz+qUpiCSWj4Yh6t6qG1I9Jjpqjcogx78klSq+8TiblEoChbxQSwenGIe12a9bSSfKn072mydVcnQQ8UX/fc+AKhbyIWIyWqT2LbYhajTywfICOKJkG2hRA8vdtsbibyjAb5ErdCF+XM6660X6s2AXOJDcXyBH20OuL2YZokHlrAaR9T7hoMCeBLz4Awh5367C1AuRTMWdCzxx4r3nNtXmUEOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stHN0I/+fiHvWT0R7Fw08ed47AJVp87YRDEQReux9vI=;
 b=hnJ9Wm87oUS5dPTnPuvI9t0UFPOdhqEk4jIi+pWgsyGsBeUpW9dJWA/WOSqDpraAigH6AAZRbxqOcK5f35c3WrFycbwPd44Fm/CxNL2oU9qUCKYoTVCo8UGX2mKwc00ok9atCi6NItFtkwdqkAZRuKnIPnyVZ2Zyc/kPXqmenY37LEu7/uAqj19lP37J201gJNuxFglPQzSYyDZ1ceK8JUY2bC5o3RtP9PulHyJDA6ujWVZBODTDu9G4p45i9rgBj13L/MKwrZFXOedMoArOm/V6obuPYlvDXxOnnrcDNwJ9b5LfXBS1SOXE3exGzE8AFLavq4VH8111UdUghMk0wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arthrex.com; dmarc=pass action=none header.from=arthrex.com;
 dkim=pass header.d=arthrex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthrex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stHN0I/+fiHvWT0R7Fw08ed47AJVp87YRDEQReux9vI=;
 b=PrrqOzkggGcY1g4of9+meQcb40IPf/q3eb0y6KQy4zvK+CySPyabdBMphvORK7/mdBiG45SqP6WErBS7baDbsg7tC1gSo+hTUoat6esuFSYMTE1ieml97wfl2qW9w3R1jhH6OJma6Im7gxS1CcYH5Jcu718R9Z7u/QtswvZsJ0k=
Received: from LV8PR11MB8557.namprd11.prod.outlook.com (2603:10b6:408:1e8::15)
 by PH8PR11MB6878.namprd11.prod.outlook.com (2603:10b6:510:22a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 04:07:40 +0000
Received: from LV8PR11MB8557.namprd11.prod.outlook.com
 ([fe80::ff75:7102:4056:b2d5]) by LV8PR11MB8557.namprd11.prod.outlook.com
 ([fe80::ff75:7102:4056:b2d5%7]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 04:07:39 +0000
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
Subject: Re: [PATCH 2/2] serial: tegra: fix TX DMA descriptor use-after-free
Thread-Topic: [PATCH 2/2] serial: tegra: fix TX DMA descriptor use-after-free
Thread-Index: AQHdUdeqgTojTmFWzkaThCJxlUkCJ7bpn6Ya
Date: Fri, 2 Oct 2026 04:07:39 +0000
Message-ID:
 <LV8PR11MB85576A86BD9F99CDAAF8269DF0892@LV8PR11MB8557.namprd11.prod.outlook.com>
References: <20261001-tty-linus-v1-0-ecb8576c802d@arthrex.com>
 <20261001-tty-linus-v1-2-ecb8576c802d@arthrex.com>
In-Reply-To: <20261001-tty-linus-v1-2-ecb8576c802d@arthrex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arthrex.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR11MB8557:EE_|PH8PR11MB6878:EE_
x-ms-office365-filtering-correlation-id: d8a2ff22-22a5-4606-fdce-08df203ab353
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|23010399003|1800799024|22082099003|18002099003|38070700021|4143699003|6133799003|260925021911599003|10067099003|260925022911599003|260925021311599003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 BoQjzik7T4aCQ6rI7ZD3KbNZ+c+YbPxN0IK3DGi2kheU7Ghri06+SQIncUDgD5h7/3emlKGwTXKH0zGca3L6DLUMMYyposuUjZPeHrl4J5cKbwrzFng5hneeEW7N4yazI8F2pD9W7hAfh/B7UcgnChBHoZUFLdNDy9wqjPWQNXxj5Uvq0ATnBaP1I+XRGHivjF+MD8Ol0kS+WlyIYJS5uszu6Fuh76gRCyWGm9Mrrss1dW8AxR4/03gETeO60VwlGelYcd/uUbslWnCYS9YN+bPrSS8Ghmye1ErbZS/b6HkU98FTrqofSqoPCtZlbF2fUmh+MvHmMX3ow0y6XcB7cpMy7ypK8SLvPRG6/TcOW042WwFUwqokWPiYWXj8rYbrlwN9AksQ75U0/KIq8Iy2bpZ0h9cGWmT7jYTE2uWs0ox6ENL7lKhxR6WaHJIERnDL5H13FgFecojVXHuWBc2CJ2Q4NOxGQ1IOC07iKtNtJ6rgUkt5llaXriv8oX8IOY0HG7aCf3wByi2db0PiTMtMNSOHvyxRQlP9W2ZjP9bK4cjFe2khdogLnl46Nig4j3sjJ8MAWB+3tnsrkwZ+lSz8HK4KtIaPtj9stWXhjNsEIlroTAtAgVOU9aDvVnY2yRIoIHQ1EnpdRBsr6JkHRdYX79hSBZwUkvQenPJaFgC16/bvB/NBIgVqF7tO95tzaJaElWsOZIi4uzezvwBo58XkCvtiPwn7ox0oYfMmSpEhw5Y=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8557.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(23010399003)(1800799024)(22082099003)(18002099003)(38070700021)(4143699003)(6133799003)(260925021911599003)(10067099003)(260925022911599003)(260925021311599003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?W9ZO7JJTG0ovCiP5TT4WKUjjMKnIVbMBd0KF7rC3DIDxTk6LSoXWXASSaP?=
 =?iso-8859-1?Q?+mvdkFuiBV/A9Vw2Y0beYltdMGUKMCbwH+n3fU3qd5oCiukC98eq1keYf5?=
 =?iso-8859-1?Q?ZU+LA8DSSc3dpULwL4eguDvhjX+J2rXcQa7rZEyV3GvnlNt2qSq2PP1pWC?=
 =?iso-8859-1?Q?WQ/7a2HeLs4vZhvI/0MQSuJ5eKRTe6CSeCX8hmF0VMR7Eh2krysZN9Pu0i?=
 =?iso-8859-1?Q?pOPxB2R2VIuv6V9JhElfos/rWCui9fJk2iMgSeBE0Rg57wT0LgwwutQmjp?=
 =?iso-8859-1?Q?36rBCSiken/ViA8HBE7+M2s1ryMNeq3b16fTY094eseDtzdSZd8YOX04wy?=
 =?iso-8859-1?Q?RZGvfKX619xG1dET+zRHrtSF4sKXpc+UwWtdYU8WkTh8OZLpNoKlU5GAYI?=
 =?iso-8859-1?Q?kOTWwL9yQ8mlIwDtAABB/KM5eGBFmhY0vvG+8rfdHfKHhGoKZpxWZ5CmKt?=
 =?iso-8859-1?Q?3VhVMFxyUMgQ20tRWZuGt9uT1++SIMTcmk6fOqyVJB3yJHwv17JmjKRigY?=
 =?iso-8859-1?Q?pS8hIpdPVoBZFHmZg4l5sUI27qO3IykenYNNvU172h7liRkWL/bLPOzu2J?=
 =?iso-8859-1?Q?qsmOmZHbvkXs671zrb60AOWAnH1wW8c4pqvxWnUBSXbB6G3IVIX+TeOOrd?=
 =?iso-8859-1?Q?wD+0mR8FDk1KJ40RlD+wQ0OA01ncPf0eqXpnG5For4HYYdWCcqI1GnNWWC?=
 =?iso-8859-1?Q?bPYBOI8jvRWxlehJfKv/we1rjPERkPVSZ4TDw42a85UvttQgAzaKY/39kp?=
 =?iso-8859-1?Q?zhfqXb8qbIqOTlYqhOG8KjmL3MoJGENO/Uaf5k1bzqH/vkKGE0GQ4xLgUB?=
 =?iso-8859-1?Q?fT96U6/Jec2OdwiFxFBXMPH4AHD9mSrZR246Rd8p6AF6r5xJBnMEjUrHBs?=
 =?iso-8859-1?Q?eVfdo3VnIiK/pGAG0smXSNtIwTHEu48qUVmaHrn3rkDgrkknK6hDfLP25S?=
 =?iso-8859-1?Q?JXJ4cgMXTuYqDQvLe3h+wt8YfZv7zCMeqC19LeRkn7qO8gbVWZ1vxKpDpT?=
 =?iso-8859-1?Q?MLQ0L4GEXGMJiNXi2Fxpdh9UahDm+jq4GLTez5vsJy2t/QJEK/DxezGMp0?=
 =?iso-8859-1?Q?BmGXXVNm3dN+sPEfNkrcjqSN65fJF0Zc/LmLYTNQkf5bskgzhhHJ4B8ycS?=
 =?iso-8859-1?Q?fY1bJNYxeGST/4raytNfrMIlHAnfkTXXP8vkHH0v1ke1MTSBm1Mhjh83jX?=
 =?iso-8859-1?Q?nMfwieXzNV8uCA4YhCY6jw8yYKai0PDHF24scD6bgalQVvyz0FyIori6QU?=
 =?iso-8859-1?Q?qTm1C01YNr1jcxAzsFlX3MbBR+RCNvgWtO4Jpp7Ti63a+RcOWj8/G+IWt3?=
 =?iso-8859-1?Q?/SHHVU2jCrMZOJFTyWtdLiMHG6eCkMkf4bIQcBxWMVERXBDVfpGEnWU6o+?=
 =?iso-8859-1?Q?4EQ5X6TbA6n3aSTcxB/CvKmfmHql9hSTmlt8R7Giixv6S/xeVYYJRY+yBs?=
 =?iso-8859-1?Q?i7TtzSLqZBYgIq8qKF7Bko9Bckzyt2eDqWRcDeEpBPmDUK4c6UDq/x7Mqu?=
 =?iso-8859-1?Q?ZF5fFI31ULXbR/SNJe5A24KaTYuPf2cocifof01RzkP59kZ26SbS+A3k9X?=
 =?iso-8859-1?Q?XPhzQXTe36/3lVj6pOcEGjL1zvrobOMm+4gLwHddnRmx3kQjDRPpAB5aYu?=
 =?iso-8859-1?Q?00NBBURyTod+XHMXXiB67PFy994c3/PU/IAoCE78TiTqyJeDoOlY6m8FVf?=
 =?iso-8859-1?Q?/1CGWblxeJiR0Of97y7xovkqM/y4GLH1migEH6nH8WKQZciv4uzxwD7cOY?=
 =?iso-8859-1?Q?1kmrIDqoXgORrpq6uea3u8j2xkk1pkWoAelsyorbqc/JDNo89t/MYUqlG8?=
 =?iso-8859-1?Q?xKgPJrToh3+mF2TE7UtV6I8TDUskVX/iNOyDfUXP4G81hzJkgvGW?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	c3MMeGqT6N3a4Dmg4q6uB/wZwFirzWcAJY6HR7vyLBzzQaGu1WFTGG60GjWP+Whgs+gj0AB5ASKy0PwfIjz9Klc1F28xyfNJrY3SB9kVRlzOQtIc10yY7d9UgKGXISj4ma7EDPFS6HJRWXLQwiCQOk3nITH4sAfrxqbXvGW9Me7dikdJSzZwZQmdJCuPAeA5cxYnz7rsny73Wnzp+++uxmcZtfMDIV3/ur4Csm5zm09ociiEUvZ1kYJ7n87PdkWr++T4teIHB+VjaX54l/Yo7nvi2zQ4HyDfMnjlGLJgT/9kCKsHCarVRk83nRyAnj05GG0vHIPKobhiEGKKMOmSlA==
X-OriginatorOrg: arthrex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8557.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a2ff22-22a5-4606-fdce-08df203ab353
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 04:07:39.8131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c970182f-4161-459c-8a07-2b00ed24c146
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ri68nWBgrYc3njNcHgVaynlTGiHCeLU/itqiJrXufeqhlBY1KSvqAIDRFqOYMOuHUWDEcXcNSJfSLOO2ipZKjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6878
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAxNiBTYWx0ZWRfXwudZHIlWqUeB
 FJks9ix3pfY0slBAILMGr2tKcXNECebFPqtTcKYT/0qR4k8BHWrUALSGwLfG+mvClD3BfZYbolj
 1gG/6uYiU/1Auhxo+NJKyrjfXLHtruk=
X-Authority-Analysis: v=2.4 cv=IbsSymqa c=1 sm=1 tr=0 ts=6abf2e0e cx=c_pps
 a=GLOgxCHNDJEaGAThK2D1wA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=660iZSQnnn4A:10 a=gbA01DrXz1UA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=70HZLsTLPGYbawPVQYjx:22 a=q0qDhkDc8lThfVdnYqKl:22 a=yW9ijH_GQebpuA_1f9kA:9
 a=wPNLvfGTeEIA:10 a=qak9Fwl7LPiBl4gFUzZR:22
X-Proofpoint-ORIG-GUID: OXJ50iMFdzNJLqL2pBtphkr-UpuPndLy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAxNiBTYWx0ZWRfX8zULcBnDbxyb
 1NLq31zTQNbztZ0yALlD+Sfzo1sMawVrLPGxfRAtAFs/Vb4e2QkNwa6q9M4FwI/AO4v2To2yG1B
 yrnXTGgqQUcFM4J3uiH+vcLnqGzXdJqoDp8ZtRzzU9aTNJ3XLCkh4A9AtSMAT+Z11bVKXLkuzyq
 CKJaz8EzDFJ6sl5JW8P2jm0vWSYNBvlA/iUHgfwx5vXfGS2i6flDzCCPETK84dJh9tDNJhAYDzB
 OE8ounA/7WkP9K862Mk+uY2gVqcL/eldaSezX5zCpM3tjdmiDAhkUR2R5uuNr5tO6aA1wcR3dBq
 kUJQBDryWo+Nah500ycYcTV6Q8JpLbyLN1k3yjyDJpsXXBZuRzPyQkb2E76eLvZr+77LhuFKfNr
 TgLSJ3Xzzpz1f1JaERoKrQ3mUoPaKOvO/69zmCtCNQBQblhal9ub5kLTiAOr60DH8Txuy1UY8xn
 2l5eOOYUIZxrOJZiP8g==
X-Proofpoint-GUID: OXJ50iMFdzNJLqL2pBtphkr-UpuPndLy
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020016

> Found by code inspection while fixing the analogous RX bug; not
> reproduced on hardware, since triggering it requires stopping an
> in-flight TX DMA transfer (e.g. via a modem control line or flush)
> at the right moment...

tegra_uart_stop_tx() is reached when TX is stopped by flow control
(e.g. CTS deasserting), not by a flush - flush_buffer() does not go
through this path. I'll remove that example in v2.
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
