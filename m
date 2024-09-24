Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012017.outbound.protection.outlook.com [52.101.66.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5121E4AD;
	Tue, 24 Sep 2024 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727191964; cv=fail; b=uRIeaJI1pcB4PNeYaOcvVwO0Yqf3v1zPA2OBtKlVi/f7uC27RY4L3pm5qJ7dejd8d8o0J+S5k2/xnQS/3eHAc2owVpoLQjIQ6xju1kL6XX554oRL1w/Xb4FKZ3aWf1vpBhfSaqDW37tkjK53oS/HhPU9dOI6yCATCOzUheSxF78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727191964; c=relaxed/simple;
	bh=T+gyszxaO8OO02UaZ5d+hl9I8b1tudpKJWIyAxRIbvY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qPHGDxw/8ImtPKjwEB5GgJRgPG6ajxvrCMH6c6bRFJCzQ9ZdaJg49/i3AhUK7EAMLGgk4XbUmwjCLQ3otdpYazHx/5uP5SveOsS2o3UlP0chUyHYxMOyivGLi8fnhE5wkpJ2qQ/d3frSyz0wem4iB9NRab59z9xTZcWg48ZYyTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=KyfypaHz; arc=fail smtp.client-ip=52.101.66.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KyfypaHz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O6o39YUIDuVHsWq+5gEwkH4L3Pb6TWntBnRb0/27PbMTdhGNC8eTpT11IxgoSNr717o5G/1R/ihmniQ8CnMZ1ozjLrbNrnAis9DSFzvwaWLNhTH7YsSQzKCdy5TfusVpfXlm9XidZBJBUnVu8GMO90OGGGaVGugSGUufE42c7JCQdRiVMlr+6kuh6exulbm/tyncfPkJ4fbx3kv/lMaLr+nUrcz3yGDY57Mj/TsdHKnxb1JVIIUnMf4RCoKayEnUr4BPvOOhkI5v5Ej6xFd3S1CRLiawr4KUfKM7AwsweEKUO0Y67DbsjigvjBLyl9KsJ08xzxF7XL5Y5Urnm2L5ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YK0Ok35PQqruCUhcd/M03jC1htbHccTiKTSURk3LcPc=;
 b=PNkAfN4cMfpt90iMczTKcd8PvIpEegl9CWABw4HsH3z69SZ47qYmURfyw+L2k/Bccnx0Z8mN3g5C39IOyePoeSMKHRLUnZU0F4sopsFRhYgxjumiCSwN31pJtDo/gC+ufAdtM8RGvOFNt3T+Dy/6D21SwyNdteDrFSv/0eaXDhE2IvetOKXo4cM4yDz625M2XHDCp7BqcrWRkbRkl7t8uN4tqz7pS2QVgpbZNjYS285HCaJP2oYJidXsudfDOmoR6vLBhf29divARNpB+VhiM7YIOE94y3kefuo0RgF42rTiND0MdsOpITum7MndiVOP5DX5ITNIAPWBoH69gn1scg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YK0Ok35PQqruCUhcd/M03jC1htbHccTiKTSURk3LcPc=;
 b=KyfypaHzB5odNZzk49Y6M0TzVLFOzu87dGmHEyeomznKBQnR2rDBWh2nZKA/wwA8FOSrWhmig94nFBq1DY5Y7xvAcLbdCvWD9CVE1mI+fg3n8nxnKmMAI/KLoAmL0rsclWIEEOSAnzXkeT5LkAk4SEGVV1JqR+X73wWgvdDBih/gbvz3VsSKqxf9yZHw+BD9bT5ztPK893W62fZUGiMANHKKK1Owr4uCScQ/IA60lAcuMMUn1rN45JcLeYxw+1UU81gOpamh4GnJWjn11NAncz4LgBOrzaKLmK0PHaffxILyuXjmoZ1OQ32wOtBlmZoInGX2muyQ8j8vZL29c9ZvBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PA1PR04MB10796.eurprd04.prod.outlook.com (2603:10a6:102:48e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 15:32:34 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%7]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 15:32:34 +0000
Message-ID: <b1282273-51d9-436f-bf39-749ff21f4ea2@oss.nxp.com>
Date: Tue, 24 Sep 2024 18:32:30 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: linflexuart: add clock definitions
To: Conor Dooley <conor@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chester Lin <chester62515@gmail.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org, NXP S32 Linux Team <s32@nxp.com>,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>
References: <20240924141247.132455-1-ciprianmarian.costea@oss.nxp.com>
 <20240924141247.132455-2-ciprianmarian.costea@oss.nxp.com>
 <20240924-twitch-embody-0ffb3ab7fd26@spud>
 <b8024c74-f5d7-4b56-96ea-dee5d8dd9a98@oss.nxp.com>
 <20240924-exposure-juiciness-c0e9a0c54854@spud>
 <a043494e-0dd3-4db1-93c7-55f59dbe2d0f@oss.nxp.com>
 <20240924-pulverize-ranging-0ec3fca845a0@spud>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20240924-pulverize-ranging-0ec3fca845a0@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0022.eurprd03.prod.outlook.com
 (2603:10a6:208:14::35) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PA1PR04MB10796:EE_
X-MS-Office365-Filtering-Correlation-Id: 1870a0cd-ccb8-4f72-7ebe-08dcdcae1c8d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWx4TnVES1BvMFYrbDFCakZsYjR0WFcxK2ZRUnNIUkViQW1hQmZNaGorblow?=
 =?utf-8?B?TXNWd3FYQUNrS3FaUEsrOTNTYVdxZlRKSWxJeDg3S1FaWFd0MU9OZWRJQzFK?=
 =?utf-8?B?VldIQ1VLZ29ONEJhMy90Y1lxZFlEMGFNdVR3UmZ2L0RRbTZzTlBDcW1TM0JW?=
 =?utf-8?B?UDJMYnlSQlBwY0k4NEt4ZEhKbEdYa1M0Y2s3U3lZY2tTUWNvR2NpRXBuc292?=
 =?utf-8?B?VTNpQ3A0VURLMHlkRnpJcUpFbDFFbTNoZ2VNVVpuTUM1OWZGeUdpeGtjdmtD?=
 =?utf-8?B?V3pxZmFGWUlsQ0xvOHZQU2lhMFpyTDY1aFVQam5qUDVZSHJDSFBYNk5Yamwr?=
 =?utf-8?B?dFVtZFZhdGNYNVEvQ3JZbDR4U3pNN2t0WjlldnQ5VThwZWZhSHBEVXp2a3da?=
 =?utf-8?B?Rjl1aUxBVHhyaHlONW9qbmc2OWVtZE0xNzhwbFl2ZnJBSDBQWHhReWp3NVhE?=
 =?utf-8?B?ZlRPK0pmNlFQRDZCdmdnRDU3ay9tMVg5WTVnUlRZMGFrNVZ2UStIenJSYlEw?=
 =?utf-8?B?VFNZT2F0NnRxbFNxbjFCNVIyYWVFZURFbmtqdEhqRDRwZFpWTzFkWWtEcHJ4?=
 =?utf-8?B?TUZpbjJSOHFJUjg2WTc4Tm5HL0FZNmlaNWVmaWQyeHhFTm1QTGFKaDd5REhs?=
 =?utf-8?B?NVY1cFpjeGdDQXA3MFhMY1U4eDRpSHllYlExUWt2MTI4WmsrYkVjUS9ldDgx?=
 =?utf-8?B?T21zTitvU2RIYTdTbkpTTVhzdEdsTmlPTnJUWTdROTB1WU1FZXdwY3FlMGV5?=
 =?utf-8?B?RDloVk9LV3FweE51bXlMa0NUNGdJR1p4Vnp3OThGMmJETExOeUUrYzQ5RFFL?=
 =?utf-8?B?Y00vTk8ySytnRE1GZWJWTEhEc3lYSVRCcmVLb1FrM3o0SjZRZHJxZW5pRG82?=
 =?utf-8?B?STZlMk1oVWxCeW96ellVdi9rSndsbnNvV1p4Mjd6SnYrTndrYnc0ME1IYndT?=
 =?utf-8?B?Nzc5MEdZY1o0UmJFT3JzNVovTFArbExaMW1LaG52aUpLSlFGbTRXZC9xOUNL?=
 =?utf-8?B?YXlhakUwM0h1MkpVcm1PK2JOc1BSQWJYb0dCOVRBU2ZIYmZzbERIc1UyQjc5?=
 =?utf-8?B?ZjlUTEdvcHRDRFNaelhtTXN0K043SnlBYTJocmlxOXgrbEkrSjZDay9FU1o0?=
 =?utf-8?B?OXVLM0tpT3ZOeXRXWDl4OVIzRk5rUENVdzNjOFpuMG9EMDdkbjl6QnhFbWdx?=
 =?utf-8?B?K1dlMm1pMDNhWFc3ck9OZldrdHFlT0xYNW1qMDZsN1FCTmYxWG1JQmxiVDV4?=
 =?utf-8?B?UnlXUm9LSi9NTDJhMEVHSlo3Q1FiYzJJNnRjZzlYSmVDcWdnWFc2NWk4ZEt1?=
 =?utf-8?B?VVhBMENHZndyQ0pFRkdtM01zcm5iV2c5SjBkRXhCVTRIMFNTbDR6bFVRcHRF?=
 =?utf-8?B?SHNLUUNhNE4wem9KUDNyd2FVY0tHN0RzMlgxU016cUlNWU1CYkFXNkc4Q3Vo?=
 =?utf-8?B?RTJzaVJzYzc4QjRuaG5oUWg4U0I5YVdyeklscEthZE4xU0JTdHpMbjlFOWtF?=
 =?utf-8?B?dFNNejlMMm1nbjFGNW9KNUEwQWlrdjlPbFpNc21IcXhXNkpCcXNlcFB4OVdN?=
 =?utf-8?B?NFVPOUpmVkZFaVZndmFDejlrOUc4Z0trTDdyUE9RZWs2ZHBvMDBCTWlxQWNr?=
 =?utf-8?B?b2FoVG1DMWlYU0d2SXpJcTEzT0JacGd5V0xaK2Ivb2NIMzZDYVQwTnpxNFh2?=
 =?utf-8?B?OURFcUNhNlJCWUU5L2tUMkVYNUc2YS9PZVZvSGowVTk2dHpmaGdWN0NvOC95?=
 =?utf-8?B?dm1vaWdkbkRlSEZEenc3QkRvWXhpdWpBQmlGMXFDWXpCRkJUTVZ6blptYk5K?=
 =?utf-8?B?cWFLeUtWMFRwOVc1c1ZJdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVFzM29rZlphQ1ovYWZRYXdlblJPdGkveDZLV3JqYVYxYUJiZ0JySUJ5U2tO?=
 =?utf-8?B?NUY2TUM2UHdBQUNVY2plWGJuOFRIYnVNZXpHOVVNamtZYUVKOVp5R0RlcmZy?=
 =?utf-8?B?SnZSRXdNTDlaY2k5RllmQ2hBK2xrYmE0UGxEeE00aW96aWxmVi9PNnMrb2JC?=
 =?utf-8?B?SVRueWZ4Uyt6aEYxenJqVzA1NEdLaXBOUlRob3lxQi96VTBSanFiYnR0eXZY?=
 =?utf-8?B?cjZtSkFaM204RSt4Z2pKbEVES1ZBSmdBNzFoK2tSU0J0VjhOQ1c3L1E4RnE1?=
 =?utf-8?B?MTFpL0JtOHFLQmt0Zy9ZM0xSSnMxTHJjYnVqMGZjZWUrR0ZhQnhVbW9ZMWhn?=
 =?utf-8?B?Y3hNeUFiUTVXeUM0di9FeDBuNkJYTW96VjBwWUdVS3hSbUxUZkx2V0srL1VB?=
 =?utf-8?B?ZVVyWlNSaHVWcW51Q3d1WjdPUUlQcXpzelFqeUtZVktSYUJYK1NtN3pxdUpU?=
 =?utf-8?B?MzVVdC9iNEF1NVM2dVpmQ3FwdFBjVUpYQUN2NXFaeTVsOGxuNFN4R3lJQ2hv?=
 =?utf-8?B?cFBzd1ZDZ0wrK29kLzkrN3RYTEcvT2tsRDdCdExUMGJiRE1nMTNETUFScHZJ?=
 =?utf-8?B?NjdCS0llQzVOeUt3VGZES3dsWWJ5S2JtK0VKbTMyZUpIZU15M0Nyb2IvcXJu?=
 =?utf-8?B?K3dsbkxNNkh4UUdZRENVQXlGVmdqYkRuYjczWkdKakVENmxhRHRxc3lkQ1lz?=
 =?utf-8?B?S0prNWJ5Tjg3VVduS3Z1dkROd0FsMXJWTWRGNHhadFI1YkdUaG5rUlFuU1Y4?=
 =?utf-8?B?R1J3aGlKMWszOFRHN1ovVHgvSnRtR0lIVVlFazV5SCtwRUtyUVlPc1lDNnJP?=
 =?utf-8?B?dEZzR2x4QkkySnNFZUFMalY5WGJKaERYcHBrdTUvSGFoMmgwWUhpZkVrTWJF?=
 =?utf-8?B?dUhzeldlV2hMWUdKNU9SMXRwWmRxNndQdmNwOURYb3c3d0MyQ1M1d1hFZUlw?=
 =?utf-8?B?ajVUVURvNVphZHlZNnlHV3d2SXZnVjF2WURRZEcyYzl4anhla09ucUwxZ0xv?=
 =?utf-8?B?UFc5UVJObkRvM1hqNlNDUmlUUHhnWTF2OENnZVkvbXd3MCs0RVZtMFBoRWI4?=
 =?utf-8?B?OGQ4ZFh4bFBHUUczaHRjZzZhMXYvQmRoWjZPNUpybHpTZC96TmtQV0F2Uzdj?=
 =?utf-8?B?QVFlMDVFY0pjTDlmSDFvSEthL29UUjBrV21TWFp6ZVEwT0QvMGNTQnVKdmND?=
 =?utf-8?B?b1dpTjNaZlJwZzdwOFpIbmNmWFpDM2w4MzVpRUw1UmVINGZmci82VkhIVk5a?=
 =?utf-8?B?M1M1anE4Umx4RXlpL084MlNkS0ZlN2NIS0NqeXN3dmxiYTdPdmlTM1lJRy9E?=
 =?utf-8?B?ZGxRT2p5TTNxSTNxSmx0RTFsNm9zbWw5cFpnUFFmQW1jSmp6ZlFPdjhncGF6?=
 =?utf-8?B?ZzdmaVBVM0lmc3NMOW14enFrdzNBVC9GWmNzdExObVhrd2gzd2Q4R1NZd2J4?=
 =?utf-8?B?V2RvK1dPVlQva2ZmQTZhT3V2VDVaaUFaMWhBam95WnZGUTJONWEwY25GZmtW?=
 =?utf-8?B?NktQZ05hMXdQT3pWTUlhZERWMksxbFhYRXNnNUFXellESkorMTBJWWlEN0F2?=
 =?utf-8?B?b2kydDdVTXozMzlGNklzVkNtZFpmcVJ6dWEwdjZDMzNaTUVVakNkVzRnbktR?=
 =?utf-8?B?MHE0NWRKUjd2NHhmaWgrcUd3YmVGbUdkRU5lbDJ2Ui8zcWs0R2RiQ1FCY3Rn?=
 =?utf-8?B?dVJJcXdseGZYMEhFUGlVRW4vTkUxR3ZmSFlrVlpJZHNKR3Z4ZjZnS0o0WHZs?=
 =?utf-8?B?YnNOU0hscDRvc1lWZ29KcnYvNWJneXRXMDB6ejdMSEc2RmZ2eUdLeHgvOVZ5?=
 =?utf-8?B?SXIybnlxY2lMNFFEZS9rZ2hEVUZNSFpGdUU4ZkJuZncwemU2bk5wT0dyLzVD?=
 =?utf-8?B?a1NQMk5EdG9aOXl2aG5UclZSek00bjZHTXoxTi84ZVF6RzAwMmxCUXRKYnZy?=
 =?utf-8?B?ZHJQajVwM09pclA3eUhzbzRGclRwcEZtMGRXQlNvVTdpTVIzd0lZL0p5MEdF?=
 =?utf-8?B?c0ZZenUvZU5WWnowV3NMOUlhcjZpeDR5Q09tTjUzZkF4TEREN1M4RGFjQnhM?=
 =?utf-8?B?enRiNWdpd3ZydnJqNkFnL0YvcTF5bzVZdExjUFgzLzBsWXlzU0hZbWJEWHU2?=
 =?utf-8?B?WnByTStIQklCV0YrZGZ3TG9EQnp1VjhzVG12UFVaVExMWTZZTHFJbHZ2UVFR?=
 =?utf-8?Q?iGPnDQX6cDOucIqLbQyhDlA=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1870a0cd-ccb8-4f72-7ebe-08dcdcae1c8d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 15:32:34.2685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RK7HHWxSN8kyIleH9dum7dzVXKUm+b2qQIb7gc4e99esaZUhhxUnJpacL9FUySE7VFvceho9qJbxMd9t9kDt40MD2gTPYXs6o6Pgqjaasj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10796

On 9/24/2024 6:27 PM, Conor Dooley wrote:
> On Tue, Sep 24, 2024 at 06:17:11PM +0300, Ciprian Marian Costea wrote:
>> On 9/24/2024 6:01 PM, Conor Dooley wrote:
>>> On Tue, Sep 24, 2024 at 05:52:13PM +0300, Ciprian Marian Costea wrote:
>>>> On 9/24/2024 5:24 PM, Conor Dooley wrote:
>>>>> On Tue, Sep 24, 2024 at 05:12:46PM +0300, Ciprian Costea wrote:
>>>>>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>>>>>
>>>>>> Add clock definitions for NXP LINFlexD UART bindings
>>>>>> and update the binding examples with S32G2 node.
>>>>>>
>>>>>> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>>>>> ---
>>>>>>     .../bindings/serial/fsl,s32-linflexuart.yaml  | 21 +++++++++++++++++++
>>>>>>     1 file changed, 21 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
>>>>>> index 4171f524a928..45fcab9e186d 100644
>>>>>> --- a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
>>>>>> @@ -34,6 +34,14 @@ properties:
>>>>>>       interrupts:
>>>>>>         maxItems: 1
>>>>>> +  clocks:
>>>>>> +    maxItems: 2
>>>>>> +
>>>>>> +  clock-names:
>>>>>> +    items:
>>>>>> +      - const: ipg
>>>>>> +      - const: lin
>>>>>
>>>>> Can all devices have 2 clocks, or just the s32g2?
>>>>>
>>>>
>>>> All devices (S32G2, S32G3 and S32V234) have 2 clocks for LINFlexD module.
>>>
>>> I see. How come the driver is capable of working without them?
>>>
>>
>> The driver was working because the LINFlexD clocks were configured and kept
>> enabled by the downstream bootloader (TF-A and U-Boot). This is not ideal
>> since LINFlexD Linux driver should manage those clocks independently and not
>> rely on a previous bootloader configuration (hence the need for this current
>> patchset).
> 
> I'd also mark them as required in the binding too, but the driver will
> still have to account for them being missing, for backwards
> compatibility reasons. Add a comment explaining the history to the
> commit message when you do that.

Already in the second patch from this patchset the clocking support was 
added in the LINFlexD driver as optional, indeed for backwards 
compatibility.
I presumed that because of this optional clock enablement, I should not 
add the clocks as required in the bindings, but I will do so in V2. Thanks.
