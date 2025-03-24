Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011029.outbound.protection.outlook.com [52.101.65.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B207261580;
	Mon, 24 Mar 2025 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837702; cv=fail; b=FZLnomS9o1DbFTeMjV+wQxVyaV7DU7/VTpuhEfXoCd5ObiugTa/Ck/pD+aYQp3HhsfMeHK40jhBaDwmSog9FOlTNKpvHHW0wAYFPo0Di0c8sDQx2KJD2SZ+xxoRGgvAcXrHFYOoGjkLBy1/ZRBSVmJ2oVkoNrbfuzUQ4Qmha3D4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837702; c=relaxed/simple;
	bh=blt+ZDByjRmlYWusTBcEERgvRf/NGlCjn5geHPx/mVw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A8+QnkU3AFVJEjRQ9s72wk2TJTZMwU+wD3OEUfBW0x+OBaf9+o0guRG93INMdE0ZNMVaWnHEo9JOWTai16yIeI2Qt/KQPnpLa9QYBuB7o4pFweDuwlc02L4HZDs5ctbiPg5XrLwOYBmTS0AySdaELMf05BE0ZzC2H34qKce0+KA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=qyjYKmzj; arc=fail smtp.client-ip=52.101.65.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="qyjYKmzj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQYicPCI0b+MfVkVkD6AJI+LqLasmRPJxNfgoFdjngH+89ek7/WJCYECq0QG3dsFVhR7KeRqsKh+mSXYO3cOz8LJEqJHEknvnV8dAd/Mun6Ht+nFzhjZFcL9wmU2EndrGuDb40viVOkXw+566ToW8EKMQ2YxWGRtDgTO4aMmzLSyahcTXk1lpce7W0Fx1A5GyVDXwde6wLnjTPtNmVGK9OaMO5e2U4wc+L3x3eQ+gtCteEwPAjHW4cw2kqUAkEJFmpg262DxQaeyplIV4QUW3CfzNHHH3cp9yPh/w958wCkxqSN5zj5W63N6WGQRmZaZvASQAH2knGF7bJljn4GdSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocQ1Yu694W81JGYn+FzApOUBRiNyV4LI82FOhlaYrz0=;
 b=C7cQ9UFT6g/hN0MkF9aTfLDFPuKDsQaIy0iUnlaO1TktklBPDY3YKCUlc+/ovKMUs8lGZDTf/Juc0iBCctEuDLHk/O+LvqLsHs0NKsF6iVF3FI14y2cRSWJmIjnzbAqyNKwtMD6hYSPFF55ddCVX5X1OAbkZxVyqi4WIaWA4+GFtQC4ksznkqPDKn3WWFZtX/huEwE/04VToOxkkuNsl5qbzTma+f2oVMnV7rynM0dYR09HvKE03xm6hj+Cri+QADwqBue9+QkvRLk7jfQNNtDFjMB+g6gRXP/rtnQX5YiasGNBLy8yA8SUz247zBSy9CXylXWwIBaoosHa63t3zLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocQ1Yu694W81JGYn+FzApOUBRiNyV4LI82FOhlaYrz0=;
 b=qyjYKmzjF2mShD07tPHZj+JhuU0t98AhMxthv700MKwvlZQht2Z2TMcM6qtnX8KSpB0rWEAR1EKBY2zRRD2abGcAqbf2x3pvgkoiKgBqiZv+U+b1GeiGTcl2X9De8xppeYB5LeE7MJolyAwZdSBpurZZ5x3AnHRuCcaOAOHi/bYcA0jrZoACXt673SxLzI5uVyDOXwbzV/5px8gurgmWrA7qfam6f0EpBVAgyD5wYAMUQUtGQeONKrdV2zDG8o0OLHGZanUSeVaRJIyzb2YdMLG6KeYk8ueldXaiYhEEqSfOoeDQp9ZNa1Ajzmpz2a35Ru4KSn6/2jREjkELWcsF2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from GV1PR07MB9047.eurprd07.prod.outlook.com (2603:10a6:150:a5::17)
 by AM7PR07MB6946.eurprd07.prod.outlook.com (2603:10a6:20b:1b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 17:34:57 +0000
Received: from GV1PR07MB9047.eurprd07.prod.outlook.com
 ([fe80::9d20:3826:e457:8415]) by GV1PR07MB9047.eurprd07.prod.outlook.com
 ([fe80::9d20:3826:e457:8415%4]) with mapi id 15.20.8534.036; Mon, 24 Mar 2025
 17:34:57 +0000
Message-ID: <1f20bb2b-f898-4e68-aee7-b4e9c7fcc32f@nokia.com>
Date: Mon, 24 Mar 2025 18:34:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: serial: uartlite: ensure uart driver is registered
To: Maarten Brock <Maarten.Brock@sttls.nl>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: "jacmet@sunsite.dk" <jacmet@sunsite.dk>,
 "jirislaby@kernel.org" <jirislaby@kernel.org>,
 "jakub.lewalski@nokia.com" <jakub.lewalski@nokia.com>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250313205852.2870-1-elodie.decerle@nokia.com>
 <2025031424-clay-ashamed-f0bf@gregkh>
 <AS8PR05MB9810A677E1036D59D23448EE83DF2@AS8PR05MB9810.eurprd05.prod.outlook.com>
Content-Language: en-US
From: Elodie Decerle <elodie.decerle@nokia.com>
In-Reply-To: <AS8PR05MB9810A677E1036D59D23448EE83DF2@AS8PR05MB9810.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0166.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:347::12) To GV1PR07MB9047.eurprd07.prod.outlook.com
 (2603:10a6:150:a5::17)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR07MB9047:EE_|AM7PR07MB6946:EE_
X-MS-Office365-Filtering-Correlation-Id: 70627427-783a-4c2f-7a52-08dd6afa31f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzlXMU4zQ2liQzFENXMxbTdZNnpIMTRtdGgvRTZCbDgrWmE0OE12NkhPTDZN?=
 =?utf-8?B?RVQyZUJpU0lpNFdnNTFrU3JyR21tclJuWjJpMVB1cjBlcVN4SDNyUFlqVitV?=
 =?utf-8?B?NzdaV1h1NXptQVMwRWwxaGJpZ3BURnVIMUh1aWNock5rRjFrVVVmNFdrK2s0?=
 =?utf-8?B?MkU3Y1pnTDJSYklqZUpZN3J1NVQxckYwaGp0TEY5bTJHSC9kcVNRVGoxaXAv?=
 =?utf-8?B?UU9VRm5LTy9sN0w5aVgyNjJwaUs2dzh0bnJMbkFoNVExWTVVdDZNWlVpMVVI?=
 =?utf-8?B?RVlzWEtGb0JoN05oaFZucEFQV2NPcHdmT0V4WEViRVUrbjFGcUVjNEhncDJx?=
 =?utf-8?B?RkgvbXBySzZXQkZZbVUrUzJCNDU2M0ZjNHU2WFRjTVRyS3AwcXpIeUNCYmFK?=
 =?utf-8?B?N0V0SjZyU0hpb2tCQVQzQ0dPSkFzbFhUVlJsekNOcXdLeEF1NzlDaW1kbmJF?=
 =?utf-8?B?dzZNdGZHZk9HTWtZbGlWRVJOM3h6SnQ4R3lYSFFWUC9PWCt3c1U4K1FnZU14?=
 =?utf-8?B?VWhpQmlDUVBKYXRGcTBIQk9PNWNMdGc3YnozOFQwclJmOUhybllOY0wvR1Iv?=
 =?utf-8?B?d1FIdWdIY3MzejFNWHRtcGpxSkNMREdScEFjdXNnVjZLRmZHT2l2RFhuMHc2?=
 =?utf-8?B?eXNjZXN2cFpZRmtic0tDeDF2a3haK05QWlV4V2dNTlR3eUJCdWhXYi9leDdW?=
 =?utf-8?B?eWZjOUlJMExzcVhyWEVXbHhYd29kUVVZd1pGZGdIVmhxNU4zTk10aTc2aU5V?=
 =?utf-8?B?aVhOb1Q4L1c4R3liaVZTendrYkF0UzlyYTQ4bFlqVDJ5VUdJc2R3VFIrV3RH?=
 =?utf-8?B?bVNrWWVDUGxrYmlWdG15bU9pT2pLcHlUaTl1MW93SG9vaW1xZ1dNYjFsdVdG?=
 =?utf-8?B?WjhaYXJnUXhtZ2VGQlNQTk1FR2JPaGVBWGVSa1I2QTFqWTdMVXVaWEY3UVYy?=
 =?utf-8?B?L05pOTJBVTFTL2VNVWUzQ3Y3bVJib0VjUll6ejVCRmxBYTZNZDBHOS9CdGRQ?=
 =?utf-8?B?bFVpMXBaSW5zT2gzNmZIdlZnTlI4ZzFEV2RsN3NDN29Cb1M2dFRjSmdiaitz?=
 =?utf-8?B?Y2IxYWFVR0dlNVArdEVaTmp4NFpQcmtqR0o5dDFPWVArUzVsRWNQWmxRYXdI?=
 =?utf-8?B?OFVzRnB5blpqR2JKeGI4ajZ3MVR4QmYrOU9wZW5uSEpvUTFENEFhd0FReUUy?=
 =?utf-8?B?dlBDTDhyV3BZM1VmRWVxb05tUDZLQnZWd1hlenYxRWJSVGZLNldGa1RGakho?=
 =?utf-8?B?WkRNb3hYdU0xUWloVlhrOGxaOENFd001Ukovcjlva3hMRnFXNk11ekRINUt2?=
 =?utf-8?B?T3haeWdvS2kybmE4RFJ3REpWL1ZlS2g0SzRnVVdydGd2L2hTRzF0L0VBbit5?=
 =?utf-8?B?YVVNREgvZE9jNmg0RlRYKzcyZ3UwUm1rdVI3T1Q4VGhMMkYrNWNnK2FlWDZr?=
 =?utf-8?B?ZitIeTZ4OGxpcGcrQUZlb2ZzSk1ZakxHWDc5clNpR1hjeS85Q25QMnBHcllQ?=
 =?utf-8?B?aW1LMHpkWVV3Tm4zWVZtYkUxTDIrM0p3NDhzbEVyRCsrWWx5aDFnUFRPa2Nz?=
 =?utf-8?B?RHNJWDZ6NFNSNDVGM3RKbGJXL3VGYzZZMmJEZExDVlpUQmJETHlrd2UyWlRM?=
 =?utf-8?B?ZmRQUWU2dXJVeHZSQisxcFJmd0poRi8vYnJUaXFtUE1qSzdIbTZOUE1tYmc4?=
 =?utf-8?B?NW01bFY0VnJxaWE3MFkySjBKb2dsU1JLVTlwekVTc0NvL2dYbUd3VG5WVjVE?=
 =?utf-8?B?OStMTGFMMmlpTWdiMWhxZ1JhM212NEwwQ2dOcUlwUDNqWDBTUzJDR29NQVFp?=
 =?utf-8?B?M3FrU0NqSG5YQmxSeHRSc0tIWHVPbmJ4V3o0OFBHeGhLWGNOZmU3TnlKWU9T?=
 =?utf-8?B?MkFWWnNjeUp1ZU44YlltNElTSkVHRDMrUTFZSTlwVFNQeWllVnJ1bjRudEFT?=
 =?utf-8?Q?trV7Yj/4ng0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR07MB9047.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eld6ZnV2K0R4ZVp6d2ovZHRxQ0t5RStaeDhMaG43RE03U1NhUU1sOHg2Z2tY?=
 =?utf-8?B?eVkvemRxRzVTOGRNNlBhTjZ5Q0t6eEFMSFQ1b0ozTjZGdVlZRDMxY2RQbU9Q?=
 =?utf-8?B?Y1o3bGVaT3dMZmRBLzZvVFUrQTJRYVN1aWVwSDFlSVhrKzBNSmZCbC9XTC9G?=
 =?utf-8?B?NUdHdnhNTmExa2ZxOCsvYXc3UGZoV0J5aU04SFl6bjdhM2dDMmYzOXZkYUJY?=
 =?utf-8?B?Z25JOXMvVUkvbmh6d2lvbVI1Wm9rZCtKajRiU2R0QU4vMmFUQkZxTHJEaTEv?=
 =?utf-8?B?eW9GYjNuVUlzUkd4ZS9veUJYeTR5TElRSFV0K2Rsa1FqRS9XS3dVUGlIc0tC?=
 =?utf-8?B?WnJUVEVja2RTTkx1aGtxYjFXbk5vWFp0dmpDS29wMHF6ZDVRWTg3bkc5Z09z?=
 =?utf-8?B?aTZPdVhkbTRwT0lCTUw5elF0eFYxTWJIaVNtb3RJZzh1ZzBlcEJtSks2bzhO?=
 =?utf-8?B?OFdzSlYrSVF1ekVIamlDd2ZBMVNYdy94Y2lQMVlmUTg1d2x6T2dibm9tNkEw?=
 =?utf-8?B?MVZNZEorVE1vS1RJL0FwQWdTV1FYYXBaK3NzL3lnU0RzamZNVHRIbDNmOVZw?=
 =?utf-8?B?T2pSRTNVZVlCZ0VJYnJVVnFtTWY2VE5heDNUcDBKejFiKzJoNHAzZTFGeFVn?=
 =?utf-8?B?RmJWUDZVYVVkQXJxYXUxbWptQ1BSRFBZMStpTE1QMFAzMko3aHRHdHRzOXJ4?=
 =?utf-8?B?dTZuR3JRc2NWYWR4eFN4Y1JIZWI3NStieUh4c293RWdMTHhkSmNLSXpFVTBR?=
 =?utf-8?B?TUNtK2o2TmFESHlycFdxM21zS1I2YUFhRjNvcU1LT3RQdEFiWWNtbnBmRGND?=
 =?utf-8?B?ZjZwdFRJaWdEU0Q3VHZia2s4dDEvRnN1Y2YyRlVaTkZpeXdPMVRueSsydk5T?=
 =?utf-8?B?WmFidU9CalhNLzhUMWkzcCtpMDkzd2R5d3F5b2RZVW9kSzRuQTd1OVBySnp1?=
 =?utf-8?B?bW1hS1h6RTNhZ0RtWlZxWktFeWhJcUZUYkNFWi95aXkxalFNTGV1REFhUjRk?=
 =?utf-8?B?MnJ1Q294SlZxUXpBU1FMVFFpaHJpNGQrREdGLzRLV3dWbGIwRTBGTVFMNnlx?=
 =?utf-8?B?T3JYbXFYV245SElQK1lyd1F3cU1XcUNZOGc3SU5VWWpKU1l5TkZHSklhaEcy?=
 =?utf-8?B?SkcyeGJWbExBUm9mVHNaUzlneVdhSzBkNEgrcXdKUUpoNlZjTTlXSUJ4a0JY?=
 =?utf-8?B?TW5uYVBxSWtJWWJXSG8vVTYrb1ZqNno4a09jc2x2c043OUlLWGZMaVNvQWRt?=
 =?utf-8?B?ZFIrVzhKendIRmNMaWVUclhadC9JRnR6VmIwVHdORVNGNDBNV3RWL1Z6QktF?=
 =?utf-8?B?bFNHaUhiS1NIbFNMQ01NRjJBZFM5cTVHdHlGa2g0bFovVWhqbmovOEFUOFlM?=
 =?utf-8?B?WG9yQlF4Uy8vWVQ5NVpiZjZ3R2NHWnBXT3doMFFzb0hjSUYra2NQRVk2aGM4?=
 =?utf-8?B?L3BKVS8yR0lRMk1xR0g1anFCUWswZ0ZzejFzdEp0Lzh6NWhxZnp6cWltbzRm?=
 =?utf-8?B?RDJqSWtacEZFd1JLS1JSOXdHWjhMVVZlcVFUdEdZN1RNZ1pWc2dPendrT1dW?=
 =?utf-8?B?dmw2RGU1cHo3TExYVjV3YUU4VDhndWNxZ1pqdHFSWGo2bS9aWC80bFd2Ujd4?=
 =?utf-8?B?ZHgxWXBkeEpmUTB5TkpDVTdZdUdGWHNLZXVzRGFDMUdWVFU2dmYxSUFUZ0xt?=
 =?utf-8?B?c2lYeUZOdXd0VTltanVMQ2QvY0tONktPRHc1M1B0UThVNS9WR1djelEvWWJx?=
 =?utf-8?B?Qzg4SkhhRzNuMHRaTXVxU2lJSmVuYzhqSlhpaTEwTFVKRlptUGJHR2k1KzFi?=
 =?utf-8?B?alFQajg3ajlHb3RIanB4ZmtlUHFZYmFJNk8wVHZHVkdPUGZkVEtiOVVtR0dM?=
 =?utf-8?B?ZjNHa3BwSTROWHRUUm1oNkZCdGJYV0dadHJ1RmdMbDJmcGhMY0JPTHVrV2pW?=
 =?utf-8?B?eFZxYTN3Qm9KQll2QU53aEpmK1ptRHlsUGNRVHc1a3lpSWlmNzIxaE0rZjBG?=
 =?utf-8?B?VEZBQnQrYWtKVG9PckUrdWdqeHRqWE43RnN5dXhkekR0TFF0YXF4M21GYkc2?=
 =?utf-8?B?Tmw5cjlncksyK0tFc2lmV3M4RHNrdjUrTlBtT3ZYNVhUM3JrbWh3VFZxZlJU?=
 =?utf-8?B?RGluL0xhdUZoTzFzcDF5OG51dlJQeGp2UnZTYnJtNFhUcXMwSUpTZmRET1l2?=
 =?utf-8?B?Unc9PQ==?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70627427-783a-4c2f-7a52-08dd6afa31f7
X-MS-Exchange-CrossTenant-AuthSource: GV1PR07MB9047.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 17:34:57.2666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VbzV6iUJH69FqmC9kEDxhMIKHxijfxyI85z7gNBV+evkQxaR89Qn0bYWn+t1wGEkSL+E3f3dKEUegP42t3Fpyk5cGgpaiijWPFGMKu2uFfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6946

Hi,

On 18/03/2025 10:46, Maarten Brock wrote:
> [Some people who received this message don't often get email from maarten.brock@sttls.nl. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> CAUTION: This is an external email. Please be very careful when clicking links or opening attachments. See the URL nok.it/ext for additional information.
> 
> 
> 
> Hi,
> 
>>> When two instances of uart devices are probing, a concurrency race can
>>> occur.
>>>
>>> Adding a mutex lock around the uart_register_driver call in the probe
>>> function prevents this race condition and ensures that the uart driver
>>> structure is fully initialized and registered before it is used.
>>
>> So the problem that there is a single "state" for the driver as a whole.
>> That should be fixed up to be local to each individual device that is
>> added to the system.  Don't add a lock to paper over this as odds are
>> this is not the only place that will have problems.
>>
>> Are you just now having 2 of these devices in your system at the same
>> time?
> 
> In the past I have created a Zynq 7000 based system (dual core ARM) with
> 11 uartlites and I have not seen this problem. This was with a 5.10 kernel.
> 
> Maarten

Thanks for your fast reviewing and suggestion. In fact, we are using
multiple UART devices in our multi-cores system. The problem is
extremely rare and we could not even reproduce it so far. We'll provide
another version for this patch based on your comments, Greg.

Best regards,

Elodie
