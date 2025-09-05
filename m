Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023073.outbound.protection.outlook.com [52.101.83.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4675927E040;
	Fri,  5 Sep 2025 08:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062479; cv=fail; b=iIA3minxyfhQF4NQ5HgXi42injq6ip3/TL6zY6Bx/goo2y1p2zVNRx9kP8igyy0CEUFdLURs6stcSrvOuBYvCA7USeAUItCVLjgZDo1UWD1M7cw0LBA5ETTkbH3Z5MKgYK0t7t2VqdrmnYR9aN4R4fztTR0tPLeksOsUIdW82SM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062479; c=relaxed/simple;
	bh=g2DAYD+G+C49NafAtiwoI7o6jcpwbGb3dBWRlwRCowc=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=ZlupqcrEtW6SMjXVBPWMZ5Cr4GdxaPZZEfqueGENuO9uI4dY2s9kdy2t2PFySK5S33mSkGy8N+7V84G38ICddc/OpmD19G4N85c2ojf2PxVcxka5cvg/7TbTnuz6enDrC8J8tLJ8yZvSXrjhXre50XmMeWO4Mo6Mpa7gCuz9ARY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=fWsxNIDo; arc=fail smtp.client-ip=52.101.83.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="fWsxNIDo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUjqV4yQA65zzLkg7R8iGI5gN98heJ4aUo/vgM93jW1AApDq9mkgaosUgR86REwa9w5HB89zX1CPp1mQ/Wu8atxcFN6hBi3J3jAMm31L5OsQyPGATGlzk8oT8zJR37Om5codqXHGP1QXSeeOZ1HznpFHG6h7w7S5L5mRvShmHLCLp/wLVNrGj6rHh9rNrW8PeB7xmb6oEOb7KnI9pw0kgY//od4OdZC8UAorN9UNf/Jnlqilb9PfFmkAXTwtyPuz3rjUyxgESOCHvy6l7lSOhz4rZ+Jg7mh9uvB3Kh4viZWwpt0NVi07bdT6ifPwwv3/DBO/xx/eoE6tlDJuVy03Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yz0MdCTHC5MdlcGYw/YWrhrSRgKfkWnz1awQ5lYL28U=;
 b=pndP/ed6z3KHqJmlbh5spe005Taz9vXggjCnbQBZleiA+3PGp5kKZOYq3xfM4sffJ5CnAZN7jCXnrDTzj7ewL6pZQEIID8qyEhY9uxpnQPfkR7sjPoz3fOD5zBIzCjOGr/1D9HGWZfbZZBlawpoGq6soER22R08Z/yZk6rVZ1HWQCX2pMIVdjKs29AHDGFusQEQHexzkM2EGQKGzFnlLQIQq9y2SvIe7PtkbQ/kXB1O9o2VR7iceqwetSJuqhxb6OAjNbxSd48VQd0cjSYvPTWGH7EmvxYkIl0onMI58H9pOiDsxXkFtilu5mjL+GGBaAyDyS9ijcVAHhv7IVnmAWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yz0MdCTHC5MdlcGYw/YWrhrSRgKfkWnz1awQ5lYL28U=;
 b=fWsxNIDo7HRkAMTwRGaz0YgCxJ5UQjcnZqjRS0DaREFdfztk1FI1QfqqB//taEODK9FKRjY1Cq7SPU56ayRdGPsXk2h7zd5AhlnOa+n9x0sQYjAnMrOyvYmioW/s6CnQtm/wxZdwcM8t2qj9EQuqKNEiK0Q5zN9VK9yd8aHSaVs+4I81nhx2oxG8FFE1VKrWibQzsQ3Ak50GV+4K8UUA9e0fv3Fq/vrtLJrIUivvmRCqGwETTxFDUcjedmPjDi3SCJ1ja8qG9Gd61pZQhAvrxHzUfM+ftviKe5kVXOgcIc461GF8gkRvhnCkysZVQp+NlwDL1tgBW7UdH8s2Jm37Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com (2603:10a6:20b:676::22)
 by VI1PR06MB6477.eurprd06.prod.outlook.com (2603:10a6:800:122::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 08:54:30 +0000
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::f8cf:8122:6cad:4cf7]) by AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::f8cf:8122:6cad:4cf7%5]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 08:54:30 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Fri, 05 Sep 2025 08:54:19 +0000
Subject: [PATCH v2] serial: max310x: improve interrupt handling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250905-master-max310x-improve-interrupt-handling-v2-1-7387651a5ed2@vaisala.com>
X-B4-Tracking: v=1; b=H4sIADqlumgC/52NQQ6CMBBFr0JmbU1bUISV9zAsplBgEmhJiw2Gc
 HdHjuDq5/3M/LdDtIFshDrbIdhEkbxj0JcM2hHdYAV1zKClvslK5mLGuNrAseVKboLmJfjEV47
 b8F5WwV/dRG4QiFqb0qBqVQe8twTb03a6Xg3zSHH14XOqk/q1/1iSEkqY3hTFQ1e2vMtnQoo44
 bX1MzTHcXwB+Xt93uQAAAA=
X-Change-ID: 20250903-master-max310x-improve-interrupt-handling-aa22b7ba1c1d
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Alexander Shiyan <shc_work@mail.ru>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757062469; l=2375;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=g2DAYD+G+C49NafAtiwoI7o6jcpwbGb3dBWRlwRCowc=;
 b=DR54zTDw9rk5DWvg4S+ojByKR7bTJF+7tmVF5gNx6a3kpCPyW8aZbYPnkf5UY25ddX/zIcSZZ
 zoIuBAjiirpB/qQ4RIgt9GJmG9PWhkI2e+R7FMJwhYFxzAdWPnhTp0R
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GV2PEPF00004534.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::35f) To AS5PR06MB9040.eurprd06.prod.outlook.com
 (2603:10a6:20b:676::22)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR06MB9040:EE_|VI1PR06MB6477:EE_
X-MS-Office365-Filtering-Correlation-Id: ac0705df-6218-455a-6b9b-08ddec59d3bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mk1Wam9NVjlRS2lkZlRTenh4QzJiWVh3QVNWS09MOXFnN0lucUJOdUtadmx1?=
 =?utf-8?B?bTFSb08vTjN2endqQXl5a2VJVkpIOHpsYUFUOVV2eHdyd3c5THN5R1ZRUUtn?=
 =?utf-8?B?Q0RVQWFWbEY4MCtYQldTczBUeTFWMkdMYVJyV2lHMHdzVGp4aER6Nk5wWGR5?=
 =?utf-8?B?bmNoSnB3cnkrMnltM3ZlZno5d2tzeTJLV09KdDZQblI1cGtZd1NTU2k4eE9I?=
 =?utf-8?B?bzRLT0xNMEI2aThXajVuLzY3aTBBT2lzVEQ4ZzlhMXNYQnlyT1NIbHl4Q1ND?=
 =?utf-8?B?SWlaenBZZmRjaDJpVHBpYVFJRUJSaThGaXFpMDZyK0I1MnF2UDJ0a25uU3lJ?=
 =?utf-8?B?aGlKV2tTclFwZTkxVUhIMjdLNTFkZGx6UTAyM0dCRnFvVmc2R3BOZUpzZkNP?=
 =?utf-8?B?Y3NWK2h2QjNRNUhZTG1oWks5M1V1THplNzU1aWpsam14djhVWFQ0Vno5R1Fp?=
 =?utf-8?B?SmgwTUVkNEdTeWwra0Z1bVZSVkhtQnkyUmRQYUh5N0xndXlaY0kzSEFyeFJ4?=
 =?utf-8?B?Nlowc2xaS1VuOGM2KzMyZkdmNTZpZGptVk5XRGkyYUV1c0pwbEIybmpTMm5N?=
 =?utf-8?B?L28rMitUMlVtVktqYUxYS3BETmV2MTBKaWJ1bExac0hSNXl1V2ZkUlo3Qzcy?=
 =?utf-8?B?ZkNJdlVDNW10b2ZDa1ZJcHcwVndzRDVUbjkvYzVYYVQrcHBOSDFLUEJlbCt5?=
 =?utf-8?B?VWhNY0lDbzRlVTdaTnZaQlFnNlNPRnZJUlNVaVVhVDBzNzBwclBtV1BoUDc3?=
 =?utf-8?B?TEVqVXN1Y29FVUIvOFV6YUh5YVpxUGpIaitZN0svWGFwdkVWTEZFOFp6dTgv?=
 =?utf-8?B?MDFEYnZLU3p6aFRudzNzeW45Znprazh0YXVQVTN3VkEvYjI4RDIycEkyZjJ4?=
 =?utf-8?B?d1BCTXZTSzRGZWxoUHZOSWZQOXZBakJVZFdNNU02cTNsTFpEMTBuREFFYk5v?=
 =?utf-8?B?RkVsOS9xdmhHaWd5Q0FTSUJwVDM1azBYMmZBdFdKVnF6Wk1DNld6aXgrbDg2?=
 =?utf-8?B?a0JaTmVEWGFFTXhma2VFdWdvQ0R1Vmdaa2JjMm85TStQb0p4SElaUS9WOFRT?=
 =?utf-8?B?QVdEcE5RbG9zOHBWbUZKYU9CY3pSZC9pTWVTSFZHYzBEQ0lDbVJvV2ZUcHQy?=
 =?utf-8?B?cllFbmJrdjlWak5HdUhQQ3N3N0R4bHpDWXZ2b1J1VXFoeWVEdHE5VlZVZlNB?=
 =?utf-8?B?c00zeExMSzhJWk4zaWZBOWhhK21MZVlSVFZKMkxSU1ZRUFlwSVFZc3JaeTRX?=
 =?utf-8?B?NmlubWxJaUJ0MEJ4Q2szWGUzMHdYTnNJM2JLNmwyZ0k0SU9EajFGUzB4Ulo2?=
 =?utf-8?B?V0dPOC9vbEszeFdJeHRLRHROZlhITXJ5NTdFZk41U2huQ211RzFzaWVOK3c2?=
 =?utf-8?B?ZnA0MzJlc2hwRjlReDJnVEdlQkY5TzM3VytUNmZEeDE3UWVNODcwZFJzWG9V?=
 =?utf-8?B?MlRkbGZjSFZzaStYc0dJSlp0K2dlNGhTRlBPejR0a28za20rZ1NsS0wzQmk2?=
 =?utf-8?B?YWJWSUZ3ZFF0eDZQUzFXakRXdGdQdWNnbER4U3dra1pSWFRaVkYyK1F6TW5i?=
 =?utf-8?B?YWhGZnRHZWt0dXVNUHVFTW1IdXpxOFl1WDNOT1dCWE41aVpaSUprck55T3Fa?=
 =?utf-8?B?a3RYZC9ENmI5Wk9oSm1pUVFhNFVFdnJaeVNpZWFValkweHVpNnFrbXJPRFZL?=
 =?utf-8?B?SWY5UDg3RWRnTzF2NVdueGZINzNBSzFqbTdwQkJyR2dDcnNlUDZtUUYxUE1E?=
 =?utf-8?B?N284UlVTWW1Ca2pCUXZUSkxZN2RaWlhxVlphV1QxaWV1Tlo3UU9ITHlEMjF0?=
 =?utf-8?B?KzVwZi84UWpkMmdxZVpHVVJ4dURtSVJCemlZN2pocDJrVUxFWmJFT282b1JS?=
 =?utf-8?B?ajgwOGM5Qm5xdmNiaUJRZms1Q0VYRldqM3dST2hZUVlGMHA2WG5hU0VCLzJY?=
 =?utf-8?Q?iszoapOF8T0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB9040.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXJldE5tUjJ5TnBQdzVNOTVTSEdkU1VYR3FBcHlCRkRrdWFNWGJYQlV4TXNn?=
 =?utf-8?B?eE1XdVVXM1VuNDFweXVwN3dCOWg4anBwNTYxN0pMdzgrWUFXNU92Y1MySFFy?=
 =?utf-8?B?OEZKbGJGYjhwQUFOUkJBWXVaeFRyV3NWYlppMFhOMUhSWUxKdElYUnJZVW9T?=
 =?utf-8?B?Yml6R1Q3bEgzU0dSVWJsaDhIcDdacTNPQ1RwL2p5SkdNOXQzUG85RFVteWNw?=
 =?utf-8?B?bFN0VCswUkU2Rm1PcnZrMmgxZUJlUlErdFJUL21XNG1kMnNKeFN1VkJhU01T?=
 =?utf-8?B?a0FjeTlScTdsekw2UjRaOVNrOFM1Q0dZN2Q2Z1o5cW8vUjNzQ1d2OWNBOExY?=
 =?utf-8?B?aDc4UVZTdnFsSkdEdTRFVy9ZdXcvblRaZkJsOExWY2Y0akJtQ0FqZkdzY3Fh?=
 =?utf-8?B?ZjFvT3NPZ3hLSFNJMGdNaDQ2WHh3bjFGeUsyRTB1eE85cFg1ejM5YVVGS3cz?=
 =?utf-8?B?bHdid2tiYXYzUW9nN3N4OFB1Yk1DamtJVXIrQmxKdG5yTTJyT1JIRmcxNU9S?=
 =?utf-8?B?OE5sM2dQV2lQdm9HWmtLek0rOWRoRkJvSEpVNUFrU0JKbVVsN3ZPU25TWU11?=
 =?utf-8?B?NGxWMDdGTlh0S2FOTGVDVFo3TGkvSUNkNjFMOWkxd0p4OVNBT0pGL1Jqb0xn?=
 =?utf-8?B?N0dSOUtrdStFQUhwUTd3cmFWTzZGVnB3TXJ6MG1kekpmY1hETG5vNXN1TElu?=
 =?utf-8?B?R1UwZ3NNdDNUT2lIVVR1aG5mOWNCcFh1aXkrS3ZJbldVMmZXMHFlcHQ5ZXRU?=
 =?utf-8?B?NGpLR2wvazN0Q01NcytRSDMvbDlML1kyK1ZNd0hiblV2V3JKVTM3YVBNcUQ0?=
 =?utf-8?B?Nlh1cTMwQllETWtOWTNTUDJaVHlEZ1lNNkF1NUNqWVBLOVhUQlNOdTFkUnpi?=
 =?utf-8?B?d2d6Q0pxd3REQkJKTERzckxya0E0bjlGMkpZVGJDK3RrUHNmTkFNeFM2OFEz?=
 =?utf-8?B?WS8yNVVnVnZrZ2s1d05yVjUwU0ZMQmM0RDd1QW9EdWFXbnZGRXNLM2hSV01a?=
 =?utf-8?B?bXNpdmQxdWNpUVgwelA3bUxTQVRtZlN0amZPRzkyNGtocGRFNnBNTjByczFu?=
 =?utf-8?B?dDBqMFRFTHdsMXp2RUdkd3pjdHpMQ0JkSk03RC9pQmYxTWNLdFFYTU1UODFD?=
 =?utf-8?B?SU1ZSFErV250YzNjczhCSDRLa09xM0crcFBURURicWhkcVVZVzBydTFaK3BB?=
 =?utf-8?B?Ynp1dEIyTDBudkRQdkhCQllCVUtJMVp4YmNZM0xuMU1ESTRFRnFhcTJMOHRo?=
 =?utf-8?B?SDB4MGJaV1FLTzdXL3YzSFNJUVhTbjM4ZlliRHdPb1J6Zi9aWVBCdDlBZjFz?=
 =?utf-8?B?TFAxOEdkMFRLT0pIM29XVE9SNDJNMTgwQVJQMUhrR2IveXNuUEcyTnhkODJx?=
 =?utf-8?B?eTdjMm1jMCsyVElvNzZaczRyOWVJV2tvditocXVKN2hHSW5WL1ZtaWtNRGgw?=
 =?utf-8?B?OEpUYW52SjBjRWJvNTQzRXc2RC9VNlN0Z0VUR2Ivb1VxZHJlOGMvUFNLanlL?=
 =?utf-8?B?dFZYR1c0YUNqbVFvZlNneUd3c1ovb0NqT1lCRjFISGp4K2V5UytqY0RTQ0E0?=
 =?utf-8?B?NTBOMTRjOVY1aTdMSXRraFNnQmJnaEJ4UmNMZHRBMmViS1V1S2FtOGVzck5r?=
 =?utf-8?B?ZDdvTzh3clVWQXIwNVZYZ3VURVlYZ1BKS3VGblF5TzN2WHJlY2dDcytLNEZS?=
 =?utf-8?B?QU9HL0FRb3V6bW1ISTFLWmhRQkJ0K1dPc1JzTEtJczA4VGhWYUtNdUFrUi9O?=
 =?utf-8?B?dktpVFlvMUJVQWlhVUp5TkdqME82YkNxS1FJV2RjUEtxQ2kyVEVrM2I3allE?=
 =?utf-8?B?aFZpdSt0aDV1dHdLM01hclhuL2tDYzVJeXY4TEhHemJ2TFpCbEhZWkJuSnN2?=
 =?utf-8?B?WEtFK1NRWDN1ZUhGWUp4cDBZUENqT1lTeUNZSnphVjhoWGFvQitWdEFDY0Jl?=
 =?utf-8?B?elluSVhRQkdUYm5zVEZ4anVsVHUxMnZhZ2dhOEYwcS9PUUJCelBkQURXVmhm?=
 =?utf-8?B?N3ZNTW5hTE5VMjNvNkhsWUREbjRmeWZVWDNxdUJjTW5QcFhvbjZLUGF6cCtE?=
 =?utf-8?B?aEhNTXpYcXJOYTNkUzlmMnR4WENDWVBrTFN4L2YxVDZaYjlZYTF5Ym9RN3hw?=
 =?utf-8?B?cWVOdE90NDhJckt6K3N6NEZWVGJHN2RGcHNsRXBhb3RWTWphU2N4NGlpOXR2?=
 =?utf-8?B?Vmc9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac0705df-6218-455a-6b9b-08ddec59d3bd
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB9040.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 08:54:30.7794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +B7R0HlI6AIq9bwLUIlObN5FTF4lCG8sWBPdDzbd3f5CXnTgEpo0So7R2UUKzClzb/Hj2N/T6pzTGAk5PZu2D8aXw+qQQc/W0oPEhD76Z3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB6477

When there is a heavy load of receiving characters to all
four UART's, the warning 'Hardware RX FIFO overrun' is
sometimes detected.
The current implementation always service first the highest UART
until no more interrupt and then service another UART
(ex: UART3 will be serviced for as long as there are interrupts
for it, then UART2, etc).

This commit handle all individual interrupt sources before
reading the global IRQ register again.

This commit has also a nice side-effect of improving the efficiency
of the driver by reducing the number of reads of the global
IRQ register.

Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
Changes in v2:
- Improve content of the commit message
- Fix a line indention in prevoius patch
- According review comments, changed to use for_each_clear_bit
  to simplify serve all IRQs in a loop.
  NOTE: When a bit in IRQ[n] is set 0 the associated UART’s
  internal IRQ is generated.
- Link to v1: https://lore.kernel.org/r/20250903-master-max310x-improve-interrupt-handling-v1-1-bfb44829e760@vaisala.com
---
 drivers/tty/serial/max310x.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index ce260e9949c3c268e706b2615d6fc01adc21e49b..464f2828bd304198d79046e79b2a8a0893e5cd77 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -825,14 +825,24 @@ static irqreturn_t max310x_ist(int irq, void *dev_id)
 	if (s->devtype->nr > 1) {
 		do {
 			unsigned int val = ~0;
+			unsigned long irq;
+			unsigned long port;
+			bool done = true;
 
 			WARN_ON_ONCE(regmap_read(s->regmap,
 						 MAX310X_GLOBALIRQ_REG, &val));
-			val = ((1 << s->devtype->nr) - 1) & ~val;
-			if (!val)
+
+			irq = val;
+
+			for_each_clear_bit(port, &irq, s->devtype->nr) {
+				done = false;
+
+				if (max310x_port_irq(s, port) == IRQ_HANDLED)
+					handled = true;
+			}
+
+			if (done)
 				break;
-			if (max310x_port_irq(s, fls(val) - 1) == IRQ_HANDLED)
-				handled = true;
 		} while (1);
 	} else {
 		if (max310x_port_irq(s, 0) == IRQ_HANDLED)

---
base-commit: c8bc81a52d5a2ac2e4b257ae123677cf94112755
change-id: 20250903-master-max310x-improve-interrupt-handling-aa22b7ba1c1d

Best regards,
-- 
Tapio Reijonen <tapio.reijonen@vaisala.com>

