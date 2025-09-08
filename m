Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021107.outbound.protection.outlook.com [52.101.65.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F32214A64;
	Mon,  8 Sep 2025 06:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757314451; cv=fail; b=bGBQyUo6Nt6zY4qF/5hd4KnTNKW4bTVUZghU2MJtniuglh2BEiY74lKuwKThT3g8Y1o1OAlZdn3vsfL1/Ne5K38Z4oQJMASPD2rhCF/GvQCQKoQfOzTE4J6n3t8mID+1LxeS29lKGSVBw35TkVFnxi6bG6ZGXU9etQdSPzD+p8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757314451; c=relaxed/simple;
	bh=oYPT4rdaNGfZ0NrSj7UhxR52dnrFM0vPQOAsuKsBySA=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=fVzv4L2/qAjzj2m34sIdPYCiWGfPP6cJTz2q8l+ygWE60yg8V+qXklIX2j9cSw/F2cjf2bHhhKBvW8seGTZqCrhJhD/pyUycUFk02ZiUBFhr7q//Azl/zfIq0F+2mVf2rQnA7rs2ZoH+1YH9PZKVrWs/qa91ML8Yt7eriQo9QDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=Uy6+zZe5; arc=fail smtp.client-ip=52.101.65.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="Uy6+zZe5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZmY2eP55G9qVeBhhlelAfBHNCIZShYvb5d6DId/wM6+NO6EE6kxmEJltjRn3+2i3AQy9U/baS4o2E3NgGx4Ht6pQE8x1ufVjMZY0DF7jZ1i4iNQdKJ3pqcHTQFvKToq78hldzysWRsNs8KMfW2bFopflaBO1h+eYfWWzehxT/DvGKehso/YUBj8j8Oakn+9YK4XtrSEBVu7HEOHgkqIuhEtEp+khXLrw6Yq57GvJYYZoLMuqebGYgi9I6KPjy5UKN5SCZYNewAq9qZLb2XQxvOewsivSgY+23uskx+6Y6OWpUsbAacOpRPavkr8UcFgzhnB7CsLO6bsJ4xyrjHBjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDLKKTthHPpddQZEJtuh+6M+jJ5qqafRYOJ6E0UnVPk=;
 b=J5ad5rKBSg7X5Le4vXdW6009mlsox4N02LtEn+PaDNqQYW0CrX1f9e2qiQdBj0ZdJNqr3D8O8z+R2RTKCwO4E5SAAXeVWiQGsNa4wgAFzR4c+S/xBZ7GGXPAXRzRT0+2nT2tZHxqWdxmyKqqbRmePi9LC7zvnzh09AyI3UGNA/PjkX4xN/aIYL35VBBqgY8tnNkiaDQURxi9ZGn1OdYsj3E9c1NpfcrFMyCp8YWnyJmv5m/hkRNggfWNJ+lcF+K+DWwX8es1eBAG+d9o6d6JpotT56T84ReQ7BLk38GmBBRanYyUj0uZBlFqbVje21WcfKwtypP8IrqePCEHcDvuZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDLKKTthHPpddQZEJtuh+6M+jJ5qqafRYOJ6E0UnVPk=;
 b=Uy6+zZe5keOawPzkNaoil7iY6/fT6RseHp8NQcy5BwXb0OWdDvveXwEhv+ERj1C4k/QCT8efu+YOBOmuRvoCScKkyZnCTsQ0HOC7R/B5D4gfyinob/Tbn6Jt7m40trWTNAiX805NQa9ToczZioajSBwFs45aJJpNtjddC5axgBOkGRm6uj5IdgQLQv7K9JjnuEADaV7hu7x/dK7J3YT8hCO9EXppn9qqxNurYdfnI+Cq54L27hUYtZKp/LNuO+9Y6UFIEOtUF36/ON/S4u96mlYcUfC8ZGVkrP65isKniswUMIAsXuRmltxI77VzimVZARf2n9SrsEmfucLTA38i0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com (2603:10a6:20b:676::22)
 by DUZPR06MB8611.eurprd06.prod.outlook.com (2603:10a6:10:4b0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Mon, 8 Sep
 2025 06:54:03 +0000
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::f8cf:8122:6cad:4cf7]) by AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::f8cf:8122:6cad:4cf7%5]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 06:54:03 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Mon, 08 Sep 2025 06:53:43 +0000
Subject: [PATCH v3] serial: max310x: improve interrupt handling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250908-master-max310x-improve-interrupt-handling-v3-1-91985e82ba39@vaisala.com>
X-B4-Tracking: v=1; b=H4sIAHZ9vmgC/52Nyw6CMBBFf4V0bU1bnrryP4yLKS0wCVDSYoMh/
 LsDK13qanJv7pyzsmA92sCuycq8jRjQjRTSU8LqDsbWcjSUmRIqFxeR8gHCbD2dJZVi4ThM3kV
 ajdT65zRz+jI9ji0HUEqXGmQtDSPe5G2Dy+G6Pyh3GGbnX4c6yr39xxIll1w3OssqdbFlIW4RM
 EAP59oNbPdE9cnOf2ErYpdpVRa5hNwa9c3etu0Nviz970ABAAA=
X-Change-ID: 20250903-master-max310x-improve-interrupt-handling-aa22b7ba1c1d
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Alexander Shiyan <shc_work@mail.ru>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757314442; l=2669;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=oYPT4rdaNGfZ0NrSj7UhxR52dnrFM0vPQOAsuKsBySA=;
 b=9Ub6BvGuJnCxWau5ujpZzIto2WybJEjlOWx8sRVEVu3Qus2hsPZiBazgczag7JyIK0AZR0sJm
 jDpYBLxiTDNBfWE9h9IRKyO6XwNH3jQc6ricUmG0EDEXUkN8dgCTeBM
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GVYP280CA0026.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::29) To AS5PR06MB9040.eurprd06.prod.outlook.com
 (2603:10a6:20b:676::22)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR06MB9040:EE_|DUZPR06MB8611:EE_
X-MS-Office365-Filtering-Correlation-Id: eba80c65-3040-4624-3cd9-08ddeea47ef4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0xBdXF2M0hkb2tEY3JqYlF6WlM1Ukl4WTEvNDAydFJlYWQ0SGxhNDVISy8v?=
 =?utf-8?B?ZFpqUUdpelhFMjEzN2Y5SEczNlZpRERqRytaL0hHeDJxL3pzQTFpL3JLSUhY?=
 =?utf-8?B?R3RaM2srVllKem1DWlFYYytyNitFMDJjZk1MVjZsL1o2Tll6Y2RvV0UrRTNO?=
 =?utf-8?B?WVlUQm1vamRjd2pKYWJtODg5OC9kK25SRnNiTzZhU0xRTFV0WGhXdDcrdm5W?=
 =?utf-8?B?d2RRT2l3elFVbDdxUkdXV2Z0RWxBNDQ1bkREZDNpb1lReEFCcndlc1BNUnJi?=
 =?utf-8?B?UVZFQThZRGZycWMxNVRyVGhyWjVjQzlPbkoyUVZuejhJbDJXSkFOa3pMYW9m?=
 =?utf-8?B?dm12L21kRDNrNHgxN3NZQ3VsUzRtR3cvaFdPdWVoMVhYV1pYd0d3c205WmtG?=
 =?utf-8?B?OEVDeEVKMkl0Z3RrcXRRLzdTOU02bi9ZenptM25hRkVKbVJSZHhJSDNyVEJZ?=
 =?utf-8?B?QzJlZjRJNlRNWGJTSW1MVnRDUm1EN2dlNzRhTmhUU09kbHZadlVZT1ZPQ2xK?=
 =?utf-8?B?WUhBN1ZzbDNNTnoybkl2cm9hZzZYQTJra3VIcDRXVW8zYmVQTTd6TkpRdFlw?=
 =?utf-8?B?aGdLaWZXRlk2UVEvYXRMd1A3c1NyTTNwTjdHQU9tNm91dXlCV1RWeTlsUGtR?=
 =?utf-8?B?TVJvdnExaGMwNWpadjlXdkdoZlNSQ1lRWnF6MFVFalVLazRqTUI3eFA3V3cw?=
 =?utf-8?B?elA1Slo0Y2kxNkpXOGh4SStVU0RoSFREbXRLcUJjYW5vVFozNm5qeEZuMEZx?=
 =?utf-8?B?Qmx1VHRMTCtnL3hwN21zblhYNTFVWXljenUyRHR0ZzU0TXJDZ2tycGlHMmZ1?=
 =?utf-8?B?THdXV0lGQ0JZYTgvaFN6ZGI5WnR1aTZwbHRMYmErOXJadUU3SU4rd0Rra2Jw?=
 =?utf-8?B?Kys4V3QrZ0Y5bkl0TVFINFo3cU1GZ2hnazJHbzNNdFhTUXhvbEVqUjR4dTdH?=
 =?utf-8?B?U1IzRGRyK0NrWEhNeGtXemgxU1RrcTJiRXc5cGM1d085aDJyNW9pdjlsT3p3?=
 =?utf-8?B?akxUNFkyWmRtZW9sUTBqK3ZBTFJUajVYbEtzS3FQTjhRK0R6bk4rbDcxTjVT?=
 =?utf-8?B?MFJuQmFDREVrRlptR3hCMHp2MDYzN1p0blk0eE5adFU4Z0J5NG9CN1N5dm9E?=
 =?utf-8?B?Y1d5YjBiaXkzWmwvN2N4eXZrN3F0MEhjSGV0dWdLYXRXc0hreUQ0Q0k3VWJv?=
 =?utf-8?B?OTRjeXRKQnY5d3RQMk1ZaUVsMFk2UlI3TDhMeDdjb015bDdPZy9QRWltVUdM?=
 =?utf-8?B?Y2V4QUNwYmFjck9BRTMvVzJLNUNIN1pSSGlYZnkyYlRKTEJMSHcvdEY3blhF?=
 =?utf-8?B?TWJJQkNxQVZWK2U5UUxVd01nUWZrTytMNmVydEcwejZsaFBCY05WVmlKVjgr?=
 =?utf-8?B?Yjg3V1l4RkxxTStmSTRoRG1qUXgvRGZsc0ZEdlhpNk9WSkVEcFl1aVlxa1NT?=
 =?utf-8?B?MmpHY1NEM1VKL1lydytxVnVhRXd1RFh0LzJjT090MXpDSm12Z0Q1UGd4U3k2?=
 =?utf-8?B?UmZoNVFWYituN1RHaHpDajcycVhud0M0QUNKRUJIazFwY2wzSFB5RUwzdmU3?=
 =?utf-8?B?SmtDTnpKWFhxTVZIVDNHUnh3dXhRc1lWOUgwS2pCdkw1NTA2WnU0MWgzYUxm?=
 =?utf-8?B?VE0rVHJpVTNaSWEyZnJGMUlwNmxqUTRTQSszZjF5OHJGMm9SaXE0eTZZaUZQ?=
 =?utf-8?B?TUhRVXhVemlVVTVOL3Nod0NqbHhWZlBYU2JSTEJxZ0tORGxBWDJQYjhFUWpE?=
 =?utf-8?B?TkdxZ2IvMmpVK1QzbUp1Z0ZhRkFuOWY4YW03L0ZZSUtyelZ0K00yV3c4UUd4?=
 =?utf-8?B?T1B4NnpFWVVrUnBZVlpEQkl3SmVIdUxmbWVSWDhpRmVnM1VDY3ZCRG5pbEF5?=
 =?utf-8?B?dURCZ2kxZ2JaekNCYlNKV3lwVXBqZkNzOG9HZEp4OUZpU0phUjExWFBTLzIz?=
 =?utf-8?B?NGVSeWowVUk4YWdadVFEZjByZlhnbGVZVzV3amMxQzBZd3hIcGZNVEg4QXVI?=
 =?utf-8?Q?TNMby0p4hakd0HOejAbF0nt+/dp4Qo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB9040.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmlIMjVhVEhocWFXQlNOK3BaeEI5alk4bHQ0bzRUdHFKelZjSUZFUnlOMEdD?=
 =?utf-8?B?djRsZkdQakl6MXVQSy9FRklhSVNoQmg4T2RsMWg1SmZFUUxYSFBac1cxR2dX?=
 =?utf-8?B?aTAxQlRXMWF3VVREc2JTSG1YdUxVVG9HZFlLRjdHK014d0lQVG5HTCtlQkFv?=
 =?utf-8?B?NnVOaVdkL3BOR2FacFVoZ0h1dXRVeCtWY2FiV1czMXNMK3UrdjZVOGs4WWhV?=
 =?utf-8?B?dXFmbmJzS2xhSVhockc5Z3RQYkF4YTJYcnNEWDNZODltZ2NreUxrbDhJQm12?=
 =?utf-8?B?V05pT2NXT1E3UDd6aDQ1S1lhMkw4a1NDK0JQVDcrZ3JYWUdCWmUzTWVsZWdP?=
 =?utf-8?B?b25xUzRjTE14dzA4RWY4YkkvbExOaXhIMTB2bTRsZWhyeEthOUlHRTVDMjkz?=
 =?utf-8?B?M3QzTk1wTVFDU0FvYmRONTJaTkJUTmJUVlRIL2VFYTArQ0V5YUhjNjhobm1a?=
 =?utf-8?B?YzladG5ac1l1U090SEZGZXY5Uks5YzNLN1IxUXJid011UmUxQWNKSFNESUtF?=
 =?utf-8?B?V0puK1VoYlh0d1hyN2JSWmVsSHlzMitRcmg4T1QvSEtiNENqeFgxSnl3QytE?=
 =?utf-8?B?Sy9LL0R3WHMraHRxVXB1dld5UDNZcmhiTExLUVVVMm1ia1FVSGNxTjBaVkVX?=
 =?utf-8?B?amRGRjVxWXZoOGs3aHFwY1JDeGtSOXJFaDNndDd6Z000OVNpK2RZSS84NWhn?=
 =?utf-8?B?V2VPQVlqbnpUNHFUMUVRZTVvYUo2UEtrWHgvTzJzbCtSVW15b2pNVUpqMnRq?=
 =?utf-8?B?YldqcENNODI3cC9zMWdtYUpBMnBOUWJNcXcxK1ZYbCt3REs2ZlV4SkY0T0hu?=
 =?utf-8?B?QVNFbXpUWmlrbnlKbEx3TCtjYXhKRFNBSEtJY0c5UW0zbFVlMDdQVSs0MW9N?=
 =?utf-8?B?Y1k1UzhLeDJpdW0wN3dmN1VacmhDUHlwN0c3dlB4UXkzdWc0WXdPYnNvTXU0?=
 =?utf-8?B?dXNuZ3dnVFBXbmV4Q1RHU2lmQVB0YS9pVzZHZnQxcWVCWW1nRm5pVGducXFV?=
 =?utf-8?B?TGRKQkt2WVFaT3c4dGg5N1p3ZldJTGRIbnFxUm9iTG9HekhYQ1pJRDY5RXpJ?=
 =?utf-8?B?MzhuRGE4ZHViRmEwejRLUXkvb3BPWkhiQ05jU2pXWEJUQmx2RW5TM0tUWTZV?=
 =?utf-8?B?NGdmRDFGL3doMFlvYnZIVHM5RjMwQlhZU0dEWmROdlNHdWw1S3ljS3ZvN2do?=
 =?utf-8?B?YzV4V0NtRGszaERFTDNUZktzSTdMb0tWVkYrOXRwNFFVTFBiNElLVWlqNUhq?=
 =?utf-8?B?Nndla1lVMWxBYVdVM05BQzA5UHFJMWMrbmV6b1IwR0JKalVmdS90bCttSzJU?=
 =?utf-8?B?NW93NEVDRzc4SVVwNDBkSVFaV2hvNlNWZzZzQXFNQjBqaGJ0R1pWWXMrM0dY?=
 =?utf-8?B?NVQ2V0ZpQ1oyMlNiTTQrU0RWMXNTNTZ3SXBrNGJyU0Z1bko4d2xzak5ieGNm?=
 =?utf-8?B?RS80RVVZZ1lVQTFwY093dkdXWm9QbkNFZVlneFl0RDVUaEhvbUp2SHBlUFZW?=
 =?utf-8?B?ZmRpMzNwZmh5dUM3Sm5hNFZ0QW9RZExsSlpURWtaOFlGTGNYV25iK2xhQXZs?=
 =?utf-8?B?VU9TUitYak4ybUt6cDdSRW1vaFh1bmxRS2dRYWkzSzRXdnpURTNUQ1pReE5W?=
 =?utf-8?B?ajI5ZitPdm1LelEvN1BQd3J5dGdpNjRLK2dMM1JPK0RkVHE1S3N3RmRlU0Qv?=
 =?utf-8?B?ZWFndjRPa0FCalZZd2E4dlhOM1FFYTZ0cFQwS0t6WGVydHJxeTRRelJnWEhq?=
 =?utf-8?B?dG0wb0twZXN4WUhaKzdJRkF1ZlhMbk5SM0gwSWVqR1VVUktUZU1GL1pmMnY5?=
 =?utf-8?B?Zkg2cmd3MjdYQjB2QUt5b1ptOENhRHpqT2l0K21NaU1wRkRWdXhocHl5U3FS?=
 =?utf-8?B?UUhUUmxjSkhXbU5yK1cxOU5oTFV5aWYrbzhFQ0g5NFhPVHp5d2MyUFdCaU1Q?=
 =?utf-8?B?alQvUm9jOGtycE9TRVNUZmYwRE1veWVCMnpZU05DNk1TbnRiZ1E2WjJpRlkz?=
 =?utf-8?B?N09mYlJNK25oVm9lUllpQmxsQWY4djNtS0FoODdZRkxLVnF0eUM2UlgxWmpw?=
 =?utf-8?B?ZDkzb1JrdWlQMmdCSEFnZW9uRTJmNDQvZUs4VmQwQzNiOUNZQnpkSy93OVhF?=
 =?utf-8?B?UGlhNE8vRnJBWjBkeExhRFQ4Q2Y0c0MyN0tXMDhLRGZhQWV1WlpzdzhOYWVW?=
 =?utf-8?B?d3c9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba80c65-3040-4624-3cd9-08ddeea47ef4
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB9040.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 06:54:02.9956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oIgZPBgOijZPxIr1Kzp3wVx+dbizKna8H1WN69cpmxIe4ELZ4r4X4FPbJYaLl5N7MIjisS+P+6BmSvwRQUMgY81RH0ApAUDl8YvrnEfgLJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR06MB8611

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
Changes in v3:
- Change variable port to unsigned int
- Use varible bool to stop while loop
- Link to v2: https://lore.kernel.org/r/20250905-master-max310x-improve-interrupt-handling-v2-1-7387651a5ed2@vaisala.com

Changes in v2:
- Improve content of the commit message
- Fix a line indention in prevoius patch
- According review comments, changed to use for_each_clear_bit
  to simplify serve all IRQs in a loop.
  NOTE: When a bit in IRQ[n] is set 0 the associated UART’s
  internal IRQ is generated.
- Link to v1: https://lore.kernel.org/r/20250903-master-max310x-improve-interrupt-handling-v1-1-bfb44829e760@vaisala.com
---
 drivers/tty/serial/max310x.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index ce260e9949c3c268e706b2615d6fc01adc21e49b..e3af381b1702ad7df7a7911030c958d07933fe43 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -823,17 +823,28 @@ static irqreturn_t max310x_ist(int irq, void *dev_id)
 	bool handled = false;
 
 	if (s->devtype->nr > 1) {
+		bool done;
+
 		do {
 			unsigned int val = ~0;
+			unsigned long irq;
+			unsigned int port;
+
+			done = true;
 
 			WARN_ON_ONCE(regmap_read(s->regmap,
 						 MAX310X_GLOBALIRQ_REG, &val));
-			val = ((1 << s->devtype->nr) - 1) & ~val;
-			if (!val)
-				break;
-			if (max310x_port_irq(s, fls(val) - 1) == IRQ_HANDLED)
-				handled = true;
-		} while (1);
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
+		} while (!done);
 	} else {
 		if (max310x_port_irq(s, 0) == IRQ_HANDLED)
 			handled = true;

---
base-commit: c8bc81a52d5a2ac2e4b257ae123677cf94112755
change-id: 20250903-master-max310x-improve-interrupt-handling-aa22b7ba1c1d

Best regards,
-- 
Tapio Reijonen <tapio.reijonen@vaisala.com>

