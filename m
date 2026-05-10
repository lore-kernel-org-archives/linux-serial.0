Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31F818C008
	for <linux-serial@vger.kernel.org>; Sun, 10 May 2026 13:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778420469; cv=fail; b=Vt4evEvQWpKBsMPjM04EFTFdupYEZx1ashNmPvzG2Nuf3serNsKPeVUyiaC/RxcEAgqBfIIu1B70ixIgat/rG5OY40kdS2HUNPEtFAh2UtblAJOIqj53+dsJOgyBtoyJ78Ud0OMtqyhqZ6AD550fMM5wxjZDiA6TfkRkbb5w2pM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778420469; c=relaxed/simple;
	bh=Ih3q2+ixe/wAqwf7h3+rbPHpRJPptrQdMDCk3mMzCH8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KC3k7FraKAK7VNXzAvrK2GlFZFwLAwG+et44EBPpdAmBeBki6vrNPoEhU3g8l0mrQ3FQdRJxt3Fm1CcbqbMMtqHapR6KepBUSnsDOYOUc6oneQ0o1v7DmLc+D/He+V3mG4Ctm7rP8bfW0w69jZXICh7g98muLWRhDp+iNCdOfAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=TJEf885B; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="TJEf885B"
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ADeklc3565510;
	Sun, 10 May 2026 13:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=T0hibi2A6
	/0JrUgw3ncjcFmVIZlbxn76VYHggTp7aAE=; b=TJEf885BLcfyJ4meDbuZi71sX
	AlVd9WF/uWforybO3PxiwPZjW24kj2zsZiYNArAtYi8I2NBYYxp5ImWWywCKJuf6
	VtZWcNb0fnHivwEFA3ySs/hKz1zy90/taR5NaWVQzXRdE/u1UhqEBX/rXzIi1ng7
	8NDMZOP5L7PkDyByErrctDvw99y+ViJSqDgDj5UI4/K8R4qAhwjSXOklx289MbUy
	rIt5V1MFWCy5PFOV4qJlSTEPdvKWtb8szYirBAgdlaADCfU4tM+D87K+G5oweC9C
	iT0916teCGBFJaNdvdHFYMDW7dsh4Vk8FYzLNl8l20TEgLnBK98jUKPhL2VQw==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e1t5015a1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 10 May 2026 13:40:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DuSIUeiih0YR06hZbuSIaO1aYb0sTHBHW9zHrv26oeBz14wp6/sdLWJPcUYQccgE1BIUiBP2cAplw05jtVyI7U679XZICfXBf3oGl5iUPuwTF/1xzu8lDK7tthL3KQg1FqXqHxWrGa7iGBV6zL68kqhXoLD3oyEC8MEUDATvCAhVMwJk+E6ViR2IIuToEzp7IYhB0tIRp9t0Bf7yNIkvxeo6mEKuAiqcvSIcW6L5HkCJjwjiqNN+8eqoEN3sd5rb+0bk3HSbTyg2EK4Nffbb9XjrACiqzr/sD8IGJqV5Oa9Rk+hTP80SJWZ9B2+UyMdo36MPQIecZguDpIBu+b5zbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0hibi2A6/0JrUgw3ncjcFmVIZlbxn76VYHggTp7aAE=;
 b=QmXK5UqyWi35U4mJ91m5mPplZhZWSyOCciLzuPEBB3AaGZ9k7uqVVkoMdUs9CPdDBqP8POE/J37ouhpBJqY6/TGwQvT5p3utsuQASqA0WLi726LCnH/Beu4tTfq9WzvGrJ6SCnyEpWjP6L+7mqxPPFlDjNpj9Xq9Ud1LgUzvB7VgFchvr6OQqlACJhDTXIAC6/UnhQiV9VmD/A4c2EONBloweiWdCid79HxsrJC9xcdGBCC+LNtudnYFLUW2nkUX2Na1CF1VLla5yAFhtBrtF4Gp0kpPlrP1L55tnIhMl3Fu85yRY51y/HI0JP2O8zMqynji878/DdJgIsGHXHwntQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by SJ2PR11MB7454.namprd11.prod.outlook.com (2603:10b6:a03:4cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sun, 10 May
 2026 13:40:41 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.20.9891.021; Sun, 10 May 2026
 13:40:41 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org
Cc: andriy.shevchenko@linux.intel.com, linux-serial@vger.kernel.org,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH 6.12.y 0/8] serial: 8250_dw: backport BUSY deassert series
Date: Sun, 10 May 2026 16:40:03 +0300
Message-ID: <20260510134011.618215-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P191CA0012.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::15) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|SJ2PR11MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: e90cbdc7-b88f-484b-9c09-08deae99ba59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|10070799003|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	oy9uaglVqcRBSnLNdik5GtcEhiLRa1OsvQjjeGocAixcdIO2NkGyD4MNK7tOh4/7ldyznybvbZItAsnQLuB1dLAlvi98k4HN1lvTv48SZ+Bp/QiTdNfhXm4p51faTiT5KnwjlmdvlUbXaUZ7Q/BmfIJ5XHh8Nu3CVGt3ARtLVA1bVU2HqZvy97/Nh0czna7boEP0gjU5dzF3lUG47lMV26k1a4C84lf37LhXDrFPmVfKvGONLhPEC4OZiA80iVeMY3odu/45qjIzV0WdvKPVAFZDipxY7YhSJuFQiq8A7JPMYhOyrpM24WaGBlOczj0ADDO3TwxFc4Ys0osHms/ScYejUrSaoQaVUPmplpc89sI034MVGcXY1+DqVO6oZhehHN9mN9bovX5+gf6phm/PxDVDfrX0meiNKNvuSEpkY1lnMhWzWDo2JKlFYyLMKBQMidBzHRMqn5SCcRdLW7w2AY5ICRZhoeHZpULuhCyasnCac70QQP1HjzCCZybErkMctLvvJr96BhXlbMcImKSVOglg/9CoBWpw58gJNvhElJSKjuZgWZl0h13+7K7RGp1CVpJsE2lRO7mkgqW+62HbRGpoIvsriuI602DMuBwXO1HU9fZZRYsLdoFLM1gKFQuVXoK+bevc1plSo5SBkKrRyw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(10070799003)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmFoS2pqSE5kS3FSUk5tVlJnNWhhMEQ3czB3Y2VxV2c2YzJjVVB1c3RScGpr?=
 =?utf-8?B?Qm96RDdybE93QzFwN3VaUmZydXZIVmtQTTVjQmxXWUJxTmo1MmlzL0llRUMr?=
 =?utf-8?B?SXFwWUhJUDI3QTFFSEcyR29IWXhXMGM5NFR6ZUpyQWtsN2tlUG1aV210ODRY?=
 =?utf-8?B?TGtWbDlTYkE3ODg3eVlWTURpOUN1UlBVM0Z1dGk2YzV6c1hlVXRJZEhEMEZH?=
 =?utf-8?B?VEYrdW9nQkxOZGdoM1ZrUjBBbCtMTEFXUkpWQXV2QjU5TVRDREN2V0JFOVhF?=
 =?utf-8?B?dWg2aHd2Qk0zNHhJcmsyWlFmZ3NUeFdVT2NPRzM4MFBROGNZNEhiekpaNnp2?=
 =?utf-8?B?MXY4OEVSK1crSE1lTzJldnkyTjVDYlF2dHlaZWs4S0MxbUEvbTBGanh5WVA4?=
 =?utf-8?B?K2xhdzk0bTkzZGpROEMxYTYvSWZwTVQvZWRTTFJjK0V3RUhsZjFXVE13NXFm?=
 =?utf-8?B?KzUrRmRSbTBreHBvTWp2ajVCdWszWS80eDhOMXI0WWlDL1dhdXFuaFlrSnZX?=
 =?utf-8?B?K3lFQzhTU1UrQ3d5RktsbThKNFNnd2NlUGt5V1VwY3JxMTZkU0pUcjZJWXF2?=
 =?utf-8?B?clBoQm1yWnZZd3R5UC9xZFJMeDlXNk5VdWFmS20xd245NE42d0RidjYvUWQy?=
 =?utf-8?B?YmhlWG4wM2FXMGhrOGo0RHN6U202MGp3WjZQR01Ub0wrNTRGZFROWmZnRUJp?=
 =?utf-8?B?dlRMNmUwLzhBOFMwbEl1MXNWSzVuWFMxN1ZJdW9rZ1BEZEcvQ2tvNlNHZE12?=
 =?utf-8?B?N1hxQklCc2MwSUFONDBOb0ljY2NEUExNZVBDczEvU0FXVHFlRzVCYWJEN3hx?=
 =?utf-8?B?eVI3SzNQQ1ptOGN0U2FLNFdFVFdRTGdPbXdtanowbndQK01vR25oRWZZVmUv?=
 =?utf-8?B?R2xrRVVvZU54RUFYSlREYUdMVDZiaG1CNWJCY1pkaU5pZVZpU1l4Rkl1a2Q5?=
 =?utf-8?B?cC9QN2JIZFlrTTF2aGdDdzVHT2VXM1V2UHZ4TFg5VVJBQ3JXRkNHcEZFWDVD?=
 =?utf-8?B?dHRWQUtoQWdza0VhblNPejMrci9KUG5JMlpxVU5rKytjN1orNmdoZG9keU9W?=
 =?utf-8?B?bVVvaGVTWnJDY1kyN3F6WFQ1Rnl2OEtKS1JhbFZRTE5qcGRiT0pKNTBFblBB?=
 =?utf-8?B?VTlmSDFqOUVEWnEzdUxabTBNcmlPcEFGYzJTTDlKeXZuVFJCV3lHUU00U2Rl?=
 =?utf-8?B?NEpJbEQrL013clpHNEtrclcvWTlMSXB6K3FBUDNWUHNmYTR0b0c2cERTcE1h?=
 =?utf-8?B?b0pzbjJGWThtbytEVDZOcTJFbkYzLzJLT3dxcHFURTllOUw4YWpIV0FGY3ZO?=
 =?utf-8?B?R29BbkFPK0JQamRMQloxMlhPWWlwcG11blJjQUVKUXZsQks3aWh5eDd4d1A0?=
 =?utf-8?B?YXB1R2lOOWc4N3ZRcy9hc2xhaGdZcVluSzJ4Unp1RjJmUFRxNG8vcVgxVHN2?=
 =?utf-8?B?RTVzZWh6a2orUTRvYnVWeXlTclREaEVKYU4zajBwdC9LbUZjcGxoUnRpYU1t?=
 =?utf-8?B?cTVnZmxiOWFmMDlQQVBwek9kakJnOS9wSlQzRW5XUWIxSTVWb0RDMi9EbTM1?=
 =?utf-8?B?eW4yaUdaZm9GVjVvYTg1TXpIbm54U3l6WmxkcFBZRDlMNzNJL1F4M0lpTVBj?=
 =?utf-8?B?SFQwR0dGRS9ud1pkT21ZMEluZDZ3djBEcGNIdWM3NXBrc2RyRkx4VlZqb0th?=
 =?utf-8?B?enNKMWtrTWN3YklKbXBDUWFTTzdDZEtnQ2x1Mnord09oY1lCSFI4RXAxQjNJ?=
 =?utf-8?B?elloQjRHUzRmNnVjNEg5akwvZy9UUVRSell6SmRtTHRyL0ljZ2xFc3pFMk4x?=
 =?utf-8?B?YUJicUU5enNRQXlrbGxLaFY3RWZqZzhBd1hLOE5oMGdIWmllZWMxWWt1L0VF?=
 =?utf-8?B?ZXgzQXhabWVEc2srUkhhVG44eXlwUEczaHZXSkQyRnNrOXhwMGJEOXJvbG45?=
 =?utf-8?B?ZVM4R3BadWdQWkdpd3NJRzNWUGNwbkVybVVEd0dwSVExVFZldDE4ZlNRQmZD?=
 =?utf-8?B?akVSckc2cjNaNXlCcjB3RU11T0VmOWR5bGxHVjl5azI4N3FORVBtV1Y5WGZG?=
 =?utf-8?B?UkVGM0w0Q3Y2RUlrWXdzOFk1V0VPQ1NPMGtrZzJsNVNaNjZXQ2t3NnNuMko0?=
 =?utf-8?B?WC9VOW1nZlI4b3hOUFhNS3E2Ukkxc0VMMUQrdkFYOXZIYTdBRzN1SGVBMDJz?=
 =?utf-8?B?TGo3TTVaQ2luSHJGazFCQlNZY1lTdHdnLzVwMm9HZW9YRzVXM0E4U3dlRDZB?=
 =?utf-8?B?THJDWU1GRFdSM2lVYlZGVzRSVDBqTksyTnlCUURRUzBSMzZEVlJYNHM0cFpq?=
 =?utf-8?B?SjJ0cU1mRW5ZY0U5N21jYndadVZvdFlySWRPbVE2bWdtcjVJZFpMSytmUjA2?=
 =?utf-8?Q?H7s/YH8AX8pMpkRFt/VUu5BFtoEQgR4fg0QE7kgkSUAt4?=
X-MS-Exchange-AntiSpam-MessageData-1: GOjTP3kxphLRYYHi5YIekegt1U4fv2EipOg=
X-Exchange-RoutingPolicyChecked:
	LKi93u+e8OilgtWiH7sU8f6Uzr40X9fM06/A1fCzrLBfuoBvLlhsLKOZLSdcKECIkQPDbjqodTxO5QwSxYDaEWsWfh4HFkiH0jzM3vv6yi/qoeYFU3eqc7Q2RvOuGdA/OmXLHAIev6iVKa651hCMWwuIX1f0pbD8HV6+mqpke5+kbd7NppHBhgOlkk9CUCFKp+avzSVuLVW5AULySif6yKcFaHaXXuEmOnH51SXmx1cIYdNobTkJebaRpEu8vCUTM14iXtwD86ePntvA+dTn2gHPj504F2gWMFetzlnPkNNNeCjoImNAZRKpLv3oGmfcMKtpJNrUqmsjcmvesPeIvg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e90cbdc7-b88f-484b-9c09-08deae99ba59
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 13:40:41.6016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6LxweopFjYzRKx74xJvEy/51w8JnZ0Td0SZB4+Sv+9W0tnXSnxY7ngpAUbyXJxhsEhQ+c8sIJUEOqqP8pjeutMAOMtyT0DeJAwI/jrq2fM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7454
X-Proofpoint-GUID: aGzdPnv1j_4opOHfvN9C_ZtqsCGnlSGZ
X-Authority-Analysis: v=2.4 cv=C9fZDwP+ c=1 sm=1 tr=0 ts=6a008ade cx=c_pps
 a=XC7dmRpti89zb13hwgmGPw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=t7CeM3EgAAAA:8 a=ejPzb3hPsXxZhmvGdr8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: aGzdPnv1j_4opOHfvN9C_ZtqsCGnlSGZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEwMDE0NSBTYWx0ZWRfX60f9hB2rFD0i
 Neo3iX12MvzoMS6ff4A0XpODPYeWhdKodegnzsvX97DKndDu851/USFEYYgWT39JIztsa4pj3o9
 IvpVwi2J2gWU/APd/IhBodNg2s9+zXmiQwVRmcdDzzILW3VF/DXlKM8C1QoJnE22JIbgPGbtnXR
 Qwc4bNOWGSqxsncRvvGB+s/kXzCFBiYZMDzyIzgs+z/SxnBxCZQAA+eSIASOCY1DogDHztg1cRE
 05YF//Wi8hzHZO4wvTcHZ6gpzQUlOdgSKmf/pmhL5ElxXWmu3xMUN6pYBksQ4WW8PL21VRgwY/p
 BURQWFjsDcgNBfahaHKmrSbR8sYjBZL8HRfHkkaDrDSTEe7YWa16vPyBonR3Q6dStO2mhy0AjpS
 xgUemrf7LSv28q+1OxPDr5Vly+h83Or6gast5bi7j+TcvKYpMRkYcNtbTYwL/w1CDm/hEL5kTOk
 br/ThTn4sB44TzKbIMw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-10_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605100145

From: Ionut Nechita <ionut.nechita@windriver.com>

Hi Greg, Ilpo,

This series backports the 8250_dw BUSY deassert fix to 6.12.y, per
Ilpo's guidance from the request thread:

  https://lore.kernel.org/linux-serial/deb9499d-3245-7e38-9034-e533d4b5f512@linux.intel.com/

Background: we ship 6.12 LTS as part of a certified production
platform (StarlingX/Yocto) and are hitting the BUSY assertion issue
on Intel DesignWare 8250 UARTs - LCR writes get silently ignored
under Rx load, causing baud-rate / framing mismatches after
set_termios. A major LTS bump is a multi-month re-qualification we
can't justify for a single subsystem fix.

The original mainline series is 7 patches by Ilpo (plus its
dependencies). For 6.12.y, the resulting series here is 8 patches:

  Prerequisites (per Ilpo):
   1/8 serial: 8250: use serial_port_in/out() helpers       [dbd26a886e94]
   2/8 serial: 8250_dw: Comment possible corner cases ...   [bd8cad85561b]

  BUSY deassert series:
   3/8 serial: 8250: Protect LCR write in shutdown          [59a33d83bbe6]
   4/8 serial: 8250_dw: Avoid unnecessary LCR writes        [8002d6d6d0d8]
   5/8 serial: 8250: Add serial8250_handle_irq_locked()     [8324a54f604d]
   6/8 serial: 8250_dw: Rework dw8250_handle_irq() ...      [883c5a2bc934]
   7/8 serial: 8250_dw: Rework IIR_NO_INT handling ...      [73a4ed8f9efa]
   8/8 serial: 8250_dw: Ensure BUSY is deasserted           [a7b9ce39fbe4]

Notes:

 - Patch 6/7 of the original mainline series,
   commit e0a368ae7953 ("serial: 8250: Add late synchronize_irq() to shutdown to handle DW UART BUSY"),
   is *already* in 6.12.y as
   commit 0bae1c670aa8 ("serial: 8250: Add late synchronize_irq() to shutdown to handle DW UART BUSY")
   (Ilpo, 2026-02-03), so it is not re-sent here. Functionally this
   means patches 3-8 above land on top of the existing
   late-synchronize_irq() fix; the conflict in patch 3 (LCR write
   placement around the late synchronize_irq) was resolved
   accordingly.

 - Ilpo's other suggested prerequisites are *not* included as prereqs:
     * commit b339809edda1 ("serial: 8250: use guard()s")
     * commit fc9ceb501e38 ("serial: 8250: sanitize uart_port::serial_{in,out}() types")
     * commit c213375e3283 ("serial: 8250_dw: Call dw8250_quirks() conditionally")

   Reasoning:

     * commit b339809edda1 ("serial: 8250: use guard()s") is a
       large refactor and only the shutdown hunk was needed;
       instead, patches 3, 5, 6, 7 here are adapted to use the
       existing explicit uart_port_lock_irqsave/unlock_irqrestore
       form rather than the cleanup-based guard() introduced by
       that commit;
     * commit fc9ceb501e38 ("serial: 8250: sanitize
       uart_port::serial_{in,out}() types") only causes a trivial
       conflict in patch 8 in code that the BUSY change removes
       anyway (per Ilpo's note);
     * commit c213375e3283 ("serial: 8250_dw: Call dw8250_quirks()
       conditionally") only causes a conflict in patch 7 around
       the dw8250_setup_dma_filter() helper and the conditional
       p->handle_irq assignment, neither of which exist in 6.12.y
       and neither of which is needed for the BUSY fix.

 - Namespace export syntax: in 6.12.y both EXPORT_SYMBOL_NS_GPL()
   and MODULE_IMPORT_NS() apply __stringify(ns) to the namespace
   argument, so it must be a bare identifier. Mainline (where the
   upstream patches were written) accepts a string literal. Patches
   5 and 8 here use the bare-identifier form (SERIAL_8250) instead
   of the upstream string form ("SERIAL_8250"); without this fix
   the .vmlinux.export.c link step fails with "expected ':' or ')'
   before 'SERIAL_8250'". This is noted in the [Ionut: ...] block
   of the affected patches.

   Each of patches 3, 5, 6, 7 and 8 carries an explicit
   "[Ionut: adapt to 6.12.y - ...]" note describing exactly what
   was changed relative to the upstream commit.

Build:
 - Each patch builds individually on 6.12.87 to a complete vmlinux
   (bisect-safe), with CONFIG_SERIAL_8250=y, CONFIG_SERIAL_8250_DW=m
   on x86_64 defconfig.

Testing plan:
 - We will test on Intel platforms with DW APB UART
   (snps,dw-apb-uart) running 6.12.57-rt / 6.12.87-rt (PREEMPT_RT)
   to confirm the original symptom (LCR writes silently ignored
   under Rx load -> baud / framing mismatch after set_termios) is
   gone. Will report Tested-by once cycles complete.

Based on: linux-6.12.y at v6.12.87 (8bf2f55ef536).

Andy Shevchenko (1):
  serial: 8250_dw: Comment possible corner cases in serial_out()
    implementation

Ilpo Järvinen (6):
  serial: 8250: Protect LCR write in shutdown
  serial: 8250_dw: Avoid unnecessary LCR writes
  serial: 8250: Add serial8250_handle_irq_locked()
  serial: 8250_dw: Rework dw8250_handle_irq() locking and IIR handling
  serial: 8250_dw: Rework IIR_NO_INT handling to stop interrupt storm
  serial: 8250_dw: Ensure BUSY is deasserted

Jiri Slaby (SUSE) (1):
  serial: 8250: use serial_port_in/out() helpers

 drivers/tty/serial/8250/8250.h      |  25 +++
 drivers/tty/serial/8250/8250_dw.c   | 298 +++++++++++++++++++++++-----
 drivers/tty/serial/8250/8250_fsl.c  |   8 +-
 drivers/tty/serial/8250/8250_omap.c |   2 +-
 drivers/tty/serial/8250/8250_port.c |  66 +++---
 include/linux/serial_8250.h         |   1 +
 6 files changed, 319 insertions(+), 81 deletions(-)

-- 
2.54.0

