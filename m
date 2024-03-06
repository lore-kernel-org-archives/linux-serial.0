Received: from SG2PR03CU006.outbound.protection.outlook.com (mail-southeastasiaazon11020003.outbound.protection.outlook.com [52.101.133.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667083E48E
	for <linux-serial@vger.kernel.org>; Wed,  6 Mar 2024 07:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.133.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709710034; cv=fail; b=SSEajto61/KWMykcDIO8zmSolMQK/Wuqs5UWU0uvGfSOMklJRp654KWmLTCZ0zy8Lf6qSf9Kt3tcgHUfM0Ge9GTShnRENHvJAEd+om/F0JOT0gsbkZss6kK5CxmkaKR75AwdKj4sCm+ztTS8FY2byza5b/i8EREG4q7wUyEzo4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709710034; c=relaxed/simple;
	bh=X4WgyPjY42uRJq2m+jV3jmN9kYXPC5Ubu4foKgafNRw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A6RSVoTdIUAOE5gl11UqszIfi6DTpEHZgfWz1YYa41+C5SXxuAqW2UGpOgcy8nDU8VU/j7uI4EQQ7TfvZcx9Gkn+rmFTUchL49sX5W1nFpM2OTCookgenh6UX0uRG/5v6zQZfEIDi1BHINcVbKVIwnkb/LlMOuzD1mDuFPmgOVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=iCniT6+V; arc=fail smtp.client-ip=52.101.133.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="iCniT6+V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIxcfMoQoP6ybMOS5utcLxTXt7hN/MpVKOYGpkUABJToDZ0N/nZugYAZDsdwi0U0OmpZ7IpcbeBQ8On567rQ8wTLG1a6lckFNf1QNeQSHH7QDpMcMCSmC66S1cPqzDG7N9/prul08nm56HKoDQ3XYOH2q8KtXcWNEaORMt5pTfSCmLP9AmLRHTuD37IFhT96GWzZrJ/ficYSTwAT2CF7BE0NlX2dQf3d86UONdgGnsYBWE8fOtZsXw7Qz7AMyDr/mLlaIGZ5cdHENrGLyaAc7P5oUTfzd6uYFeZOzvwym7VVUaNoC7TFuX13TvTFLihklZhp8I0g1aD1bQ7jm468OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4WgyPjY42uRJq2m+jV3jmN9kYXPC5Ubu4foKgafNRw=;
 b=l5nb5TjveSDhk2xOIpcAMFqg4gAbiFsTueutq1ThUZnjRAygyu7MUKv4NmyhM61m3quvDoKGIzhF7alREaZS1syZAHy35SQeh3hMjQUfKxPhAyd+kM57WyLih87BfObX3abx4VySb/r0jC4I8Vwzl1y1K+GCFaOKoeJvrM2wXQW/snUhFuMNG2TLcfREeozIFoBkX2UVKariKMVKfsD/yEbSje3wP3AbQmzaN7QRZ4Y7QTtYgH2XLSr07IrWcoYOcHbledoLKZKaR6P23rMCfSuFL7J/LEBtND/gZ0Ub1oUyIHPhN+KpfBfh/MFpUc/FY3SOscaoDSO5j557+DfrGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4WgyPjY42uRJq2m+jV3jmN9kYXPC5Ubu4foKgafNRw=;
 b=iCniT6+VAgdG0CGdfuQQ07tqUbsi87VCUv0IlDK57rxJfstXwElgGc4ffoW0RkKD1kmnin8HUYsKgLvQ/NANJ9XJVAG9CHWaZo5vY+ryCJJyZjOisWtTxqR8MQCNQ33sclUApSGp6qZp8KVwBpAiqIpA6dxVn6810ECE2wzpO48=
Received: from SEYPR01MB5506.apcprd01.prod.exchangelabs.com
 (2603:1096:101:13e::5) by PUZPR01MB4689.apcprd01.prod.exchangelabs.com
 (2603:1096:301:dd::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 07:27:07 +0000
Received: from SEYPR01MB5506.apcprd01.prod.exchangelabs.com
 ([fe80::2a0b:8f81:42b7:5c58]) by SEYPR01MB5506.apcprd01.prod.exchangelabs.com
 ([fe80::2a0b:8f81:42b7:5c58%7]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 07:27:07 +0000
From: =?utf-8?B?RmFuZ3BpbmcgRlAgQ2hlbmcgKOmEreaWueW5syk=?=
	<FangpingFP.Cheng@moxa.com>
To: "federico.vaga@cern.ch" <federico.vaga@cern.ch>
CC: "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>,
	=?utf-8?B?Q3Jlc2NlbnQgQ1kgSHNpZWggKOisneaJv+S9kSk=?=
	<CrescentCY.Hsieh@moxa.com>
Subject: Re: serial:support: Using 8250 driver With MOXA CP-132EL Device
Thread-Topic: serial:support: Using 8250 driver With MOXA CP-132EL Device
Thread-Index: AQHab5HUoesOCQmx9EGWSbE3BVvA4bEq1loA
Date: Wed, 6 Mar 2024 07:27:07 +0000
Message-ID: <BCDFCACC-4D99-4D87-9B1C-9B19ACFDC2AC@moxa.com>
References:
 <SEYPR01MB5506F7C6512AC1E03EA9132DEF212@SEYPR01MB5506.apcprd01.prod.exchangelabs.com>
In-Reply-To:
 <SEYPR01MB5506F7C6512AC1E03EA9132DEF212@SEYPR01MB5506.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Microsoft-MacOutlook/16.82.24021813
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR01MB5506:EE_|PUZPR01MB4689:EE_
x-ms-office365-filtering-correlation-id: cf14c331-6f20-4ea6-6891-08dc3daed441
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 SNMpQX2IsnzchVenWKcPwSjFzb8WcOdkwklDeBEXinYDRsIg+brOS5BdW7h4Pl+YSAV9ZM3h6CYulxZcoFLMZwv+n9Y/mxdoVOeEM65zY7emuSaPXtfxFWl8RLgbJywNl/Lk496gcBq+JKTUnD9E5riJAB7boCqmbAKaOcTyp7uIeGVKO3zaCvvtUFtadHp8naHMBkfWp0KcfmiN7j0U17Z3Mual5FEMX1shQ2iTZWjuTBClg8xsxi61WN4t9TxvHAjX7frHfFcSBn+IO4bFud5J6Wij4Gddf/yU/lz5MIiBT8UKxYmNbA4bsHzQCXEW3kPBdpZa6D91/N0C8Mlu05S9t5io1/dDBAJCUS7b52hosPtUHOwYfy5oqrgFsY1Xs2oMFEh4D7gFLBVM6BSndMpE+w1FIExct2HLtmMLvAfvQqm0BNFFTaCGziBwzuVR/t2RJusgulFZ9ZmAVBgY2U/vJrKf0c8izCuoUUvQiLLVdbJyXyuadJ2vMnSfHZPruY46CGSzJJ9ZykOYv2YDRwdNjEy42Tc9HjUTocUo2O3xCvTwxKF0hFZ0zWdDdwFMoy7Aj+3ktaIrf6insW+uNnqbTgv/b3CSMUT6bmLWU378jq+6QeLjWzPrmODmX2UTmJOIuAaH3o5HDh2Pkj+DyLEq01yToTjF5P3/NqNS/5A3XLio9Oq93ZlghbksOvMD0OJ479itiGwxjT9wNXSGkeX/obaT5176QSk13Faf+L0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR01MB5506.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N1NEcmt4NWxpdlNDeFlrNCtqbTRrdkg1ODdFQ3dPdmJONkJiZENaMDIrREF2?=
 =?utf-8?B?Vys2ZWxQbGo3bHRjSXNNL1dCUjc5eHFCaGxBM0liUEdXdEhxTmFMMXZkWWNn?=
 =?utf-8?B?M2dRSUU0d3BBNTVXTWgxNGIweTNFRE1wVElRaGJXOEhuRmRxMUNsUWFjQ2RW?=
 =?utf-8?B?L3RrTlNSZmFJVG9sMmhpajd2Z0szN01GODhMVDRaeTBpMGc5QzJncGNleFFT?=
 =?utf-8?B?TC9WL2tyZDIzems0MVI0SUtzZlg0MUxsN2tJdjB2YURaUm95bWdWNW1xRXdD?=
 =?utf-8?B?TnppLzRoelRsTEE1MG9UMFNhY1pBejVrNVpDamlvTHA2TDE1MjBLSk1XUml5?=
 =?utf-8?B?OHd0MHBwSDVMc09laWF6V0gvVzZRQ1JSNjdhN0pLcitRU3J1bHI0OGl0WHFW?=
 =?utf-8?B?RUlGVW9XOUM5aFFGMVdpQ0RKTTBpVXNQZitORk92VWtRNmpFY2pqQk1BUGp3?=
 =?utf-8?B?OFRvSWljUlVncy9HR0hscGEzcE55RmNmVU1rMnlsQjVvclduMzdhOXU3dktD?=
 =?utf-8?B?OGRWaSt4bWRGd3JOL2hQMEUwR0s2dzFUOFVjbFZOUjR1d1dUa0Z0UDFYcFZa?=
 =?utf-8?B?NTk1V1U5TXA5dmhGSk50czI1ZElsN0pTOVRQaEhibm5LcEFHalJhMFZZa1B2?=
 =?utf-8?B?T2NuVEV3Uys0ZTc5bnY1RkNWejNoeFFrUUJyM2RGc2hIQnhabk5BVVFrdk03?=
 =?utf-8?B?THRaZXFCdHl2aDNHbDFIbnJPVHhRek1FRmVoU1pYV3JpWXE1K0hLR3l0eUNw?=
 =?utf-8?B?ZmM4QjZZZzNtMG9uaHlFRVFuNVFiUUEzekJHV0pmZ25xaGQrR01RRlE1NzUw?=
 =?utf-8?B?ZUh3ZDNXd05LQ1VnSVlyMVRZQXJHZHVFZU82M00zQzZBay9iMFM1Z2NRbmw3?=
 =?utf-8?B?Wlg5aGtHZmhFcVlVQmQxQnU1ckNicmoyaG5JZ3JJa09OcWhxVkU0V2huR0Fm?=
 =?utf-8?B?M0FKVi82NEtxRDF3Zk0zUHhualJsU05HS3liWXRGZ3VtcVJWV2twVVN6RDBP?=
 =?utf-8?B?d25SVVkyVVRreDZsUjY1T2F5T0JKZ0Zoc1dMTGdEZUNJS2JtcU1ibUVjV1VD?=
 =?utf-8?B?VXVLQlB5MW1RVXlzM25SM2lVcmFYRUVBNStEUys0UExaSFA3SnpUbFRQVi9w?=
 =?utf-8?B?MDNsdVhjYUFYZ2pKK2FDd0M5eWZtZWpBYittUlpUSXJhd2lUSFhmelFiOGI3?=
 =?utf-8?B?NzlvWWNXTEw2dWxEUWVIMUFuUHFyVGVMeU9qQnAyWDB2a1NzTERsMVRRMndE?=
 =?utf-8?B?NWE1aVFLNm5yVk8yamFTbU9haTVkTEdiR3RLSWIxWVM3NFlHM21UTE9lUzJI?=
 =?utf-8?B?L2wyMmx3YnkvZ2Q4cnFFQk14M1hNOUpuYWdkNDNuS0FoRlZ6ZWlTQW5jSEJK?=
 =?utf-8?B?dk9abTIxVzlxYnhDNGMzR0haKzFCM1hTSXpEUm5GVWRhZmpTcHM0SUh6QUNT?=
 =?utf-8?B?VktoenNodXVxbmdzSDhiM0Z0bk1DcEkvNHF3cEVrRjRpMTd4UUpmcFZPQmNv?=
 =?utf-8?B?ekhZZHJRNmg3N1M1OXJFZXkvRjQ4dGs3a0p2Um9lUElQaWV3VEJvT3l4T09S?=
 =?utf-8?B?elFLU3V0ZzlJTFNlYm1EUlNUZ29lNitOV3ppSUt6UFZEWlQ1RTcrbU93Z1NC?=
 =?utf-8?B?TmprVVl0UkN6T3Bua3U3eUM2WExHSVBNbWh2eVg0alU2MEpjS2xUSGJWRnFB?=
 =?utf-8?B?dnFuTmcyVlN6bkhsc0t5UkpsVXBVWVdJNWZ0WUdvR0ZRMDZzWXRQdnp0SjhO?=
 =?utf-8?B?ZDFhTldSclZuWmpScmZGcU92NDB5S3BpVTJ1Uitrcm95VlJmaUlUTjJQb1Nz?=
 =?utf-8?B?WE53elZTSnpZRjVScVNyN25lUDk2cWNEMEhQQmF2ai92TnY1c3IremNBbElP?=
 =?utf-8?B?dHlaYzJpcE90WGQvOWF1bkRVNGoya0ZvMkJiSC9DTWlLRlpqTnIwS2xEZzhP?=
 =?utf-8?B?cWtjK0V4TFE4ZlhSZ294R01VeE02czI4YXFmOTJJQXJxUTdUS1AzRTNEemlC?=
 =?utf-8?B?WVA3a3ZJaVNaMmsvNVVoUXVNQXVNNW9CMktjWk94UG11Z21UWmVQcEhMM1Fk?=
 =?utf-8?B?cjc4VDZ0ZElENzQwSEpQTFNOMlp6UGIzVzBqaUJNL1l0T29HdkI2N0pqd2x6?=
 =?utf-8?B?b0xBdGFLeUpYSUtORmVBaGU2YVlPSVdnWFRRdmJnMDlCUU5Rb0dScWRoQm5H?=
 =?utf-8?B?VkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23784DA0C3C55B4C897D247EFBD658FF@apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB5506.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf14c331-6f20-4ea6-6891-08dc3daed441
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 07:27:07.3912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OXubiBeyF2RvRnCavtVTtgMjK3RYKmuu+SSECR/AvmzJ6gajdpTC6eCOqpPRwX1J8mrNEwRWksGOrsMJmPzczTECEwplE+3KjBBTILbP4sA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR01MB4689

UmVzZW5kIGluIHBsYWluIHRleHQgYWdhaW4uDQoNCkhpIEZlZGVyaWNvLA0KDQpJIGhvcGUgdGhp
cyBlbWFpbCBmaW5kcyB5b3VyIHdlbGwuIA0KDQpUaGlzIGlzIEZQIGZyb20gTW94YSwgdGhlIHBy
b2R1Y3QgUE0gZm9yIHRoZSBzZXJpYWwgcHJvZHVjdCBkcml2ZXIgYW5kIHV0aWxpdHkgc2VjdGlv
bi4gUmVnYXJkaW5nIHlvdXIgcXVlc3Rpb246IMKgd2hhdCBpcyBNT1hBIHBvc2l0aW9uIGFib3V0
IHVzaW5nIHRoZQ0Ka2VybmVsIGRyaXZlciBvciB0aGUgTU9YQSBvbmUgYXZhaWxhYmxlIG9uIHRo
ZSB3ZWIgc2l0ZSA/IE9uZSBvZiB0aGUgbWFpbiByZWFzb25zIHRoYXQgTW94YSBkZWNpZGVzIHRv
IGFkcG90IGxpbnV4IGtlcm5lbCBkcml2ZXIgaXMgZm9yIGJldHRlciB1c2VyIGV4cGVyaWVuY2Uu
IElmIGEgY3VzdG9tZXIgaXMgbm90IGFuIGV4cGVyaWVuY2VkIGVuZ2luZWVyLCBoZS9zaGUgbWF5
IHJ1biBpbnRvIHRyb3VibGUgd2hlbiB0cnlpbmcgdG8gY29tcGlsaWluZyBNb3hhIGRyaXZlci4g
SWYgdGhlIGtlcm5lbCBkcml2ZXIgY2FuIHN1cHBvcnQgTW94YeKAmXMgcHJvZHVjdHMsIHRoZSB1
c2VycyBjYW4ganVzdCBwbHVnLWFuZC1wbGF5IGFuZCBzdGFydCB1c2luZyB0aGUgcHJvZHVjdCBm
b3IgdGhlaXIgd29yayBzdHJhaWdodCBhd2F5LiBXZSBiZWxpZXZlIHRoaXMgd2lsbCBzYXZlIG91
ciB1c2Vyc+KAmSB0aW1lIGFuZCBlZmZvcnQuDQoNCklmIHRoZSB1c2VycyBuZWVkIHRvIHVzZSBN
b3hhIHNwZWNpZmljIHV0aWxpdGllcywgdGhlbiB0aGV5IHdpbGwgc3RpbGwgbmVlZCB0byBpbnN0
YWxsIE1veGHigJlzIGRyaXZlciBmb3IgdGhlIHB1cnBvc2UuIA0KDQpIb3BlIHRoaXMgYW5zd2Vy
cyB5b3VyIHF1ZXN0aW9uLg0KDQotZnANCg0KDQoNCg0K
