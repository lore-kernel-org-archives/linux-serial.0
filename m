Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022124.outbound.protection.outlook.com [52.101.66.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB87486437;
	Thu,  8 Oct 2026 09:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452949; cv=fail; b=kBo+6TqjuX3Wv30UFoAHtOJi5W9Qt8Qp+sSmSzhbQqpQ8kZfLemrqs07GBCIEw2mxQVHgYur6BWw/QwUIV3V9Ndxc4q90CgtxePOpMmNlVh6aeG+P0QmeAEUsYAK1WUnB72a0IaM3sYhsb/+hBdTnBzD7krl4IWKPqT7aV6X4EQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452949; c=relaxed/simple;
	bh=s7EacPrsAPZt6xtvzMPdcR6PNgY4tifV1jhBxW5txM8=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=smYxdX0mA165VJxsFNpfEvXiitKJY+b6ODBKa7muPiuwavVoBJbj/NJFAu12YH4nnuYZwVgkmMFI0vDRjqhQkaxzoilyj5+97d954RxNP4Q/f0eBfdVasnR242VMo9ch078YJxT97db8B79xMftbyAgkarlGyDba+kNFgdX7ka0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=fE3Rs6oa; arc=fail smtp.client-ip=52.101.66.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="fE3Rs6oa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXW+S0ym7rlGzfKySoSl1HiwCAlUAIgRlSu3lo06stFiHi7EZdPbM12OeWfonGWtk2xzBeu99Ez5TN+pmS5TGfEd2yVb/uVpiGDiDS87xbUj/AS2qiFFViaWa0Ml2Ku3KRV/cWBGnVvMaEHGofxsu6AVIwnsD08/ZKQllIyDCtW92kZco8AYCyy8OiCLZtixpmHjDB2ulDvV2r3Q+IsdWWaDfqQC1rBF6TPmk3Sn/JO7y4DLhRIB96E+T2Scfp8wAmXoPO6kCLcTyZDuH//M6J4X33jjMX58hlmnjufP1y5r7HWB7z6hwLeUNQIWfrnRwD58PJ/3EvBvEXY9FAA2eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfI4dx18tFJLJONtE4nI3uZs9dtdUhOXaUrF3pB9Kys=;
 b=FWCQbEYUMQaYidsCCtysozZT/Bju6dpLM0VxE7h1fB6a0yGE5VTb1Y2xfNpEBPPGvG0vNKlGE2GbHeWjisPwSEWphtKmLesLPI3dCHmePl9zIuxnZcbStbswY4e9xND6P+xXHNvHijISiopxRlQN5DqFeIroMyTeQBDFnGEGEHld8aS681BWjl5Jql/wj/3zbeNteZ3vS33vI0ZCAG2mGHo+JR9tp+yJiHL6LKPnlJK43NkZdETYveai/4WJhHRQx8sD2Nbojf4oxDPoApxrvRrM0QHltg8GULuoQVQ0y/yThXOuKWS3xgHP7LwlLPRF0JuingsZsV1E0x/rsGyRBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfI4dx18tFJLJONtE4nI3uZs9dtdUhOXaUrF3pB9Kys=;
 b=fE3Rs6oar0nNC4f6+dOl8DdOBKG6/JA3JFrP2D99hhFkG2qftBEERZ1M0A/Igo2m67PXZ+p/7tH4gWLtU184Lk8v2dEBrsO1m9st4y5Wz8t7TbNZT7plAhrVCZu7nbm2wkUeRQ+0JXyG8AkHjyttscjHT4yl/TtJDoVVqPnb2tyY+SSIZ7j8ncyi2ljKQ72A+wXW1acNxfKTSrQVLOBLedJ1DRqPAhLcj5BFcoCARA1zV6EXFAtpgWZy9zuDugfkgjekhfzMHEbwgT2nDhu7iY7sU1OmfvSCkGM6tXbl9g8Aka2TJXtr1788I3US3H/rYag8Qk8pz7MUJCXtH32LUg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by PAXPR06MB7567.eurprd06.prod.outlook.com (2603:10a6:102:dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 09:48:56 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 09:48:56 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Subject: [PATCH v8 0/9] serial: max310x: RS485 delay and RTS fixes,
 software-timed delays
Date: Thu, 08 Oct 2026 09:48:23 +0000
Message-Id: <20261008-max310x-rs485-sw-delay-v8-0-6ba881f81e1f@vaisala.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOhmx2oC/3XQS2rDMBAG4KsErasy0ujZVe9RuphY40aQxMEqr
 kPw3auk0KS4QqtfMN88LqLwmLmIl81FjDzlkodjDeFpI7odHT9Y5lSz0KAdWIXyQDMqmOVYTLC
 yfMnEezpLQnDJB0xWR1GLTyP3eb7Bb+8173L5HMbzrc+krr8/pIfYIicllTTWUKdgG9HT60S50
 J6eu+Egruik71BQqgnpCjEaHVCD9SGuIbxDUdkmhBXySQOZ+rZWryHzCLkmZCqU6koumjpX168
 h+wDp9o2sBElsHPVkA/b/TOR+IQVgmpCrEBJwr5BTZFxD/hFq38hXyBFj1NwRhO4vtCzLN/ToH
 n10AgAA
X-Change-ID: 20260513-max310x-rs485-sw-delay-a306d783d529
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Maarten Brock <Maarten.Brock@sttls.nl>, 
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791452935; l=13555;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=s7EacPrsAPZt6xtvzMPdcR6PNgY4tifV1jhBxW5txM8=;
 b=nx2czfhTsoAS9fd+xEXdCJ2cGrNZqISJkFHJ6lX+QWKcrNcjsO1J3nvWYNv3NQouZWFwN96ig
 k/tLFTdyB/AA96J+cApzeqRwz8Jihv2YMUODnqrbLvVnrbLQeyD5lAc
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: OS6P279CA0138.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:3a::15) To AM9PR06MB7907.eurprd06.prod.outlook.com
 (2603:10a6:20b:3a6::23)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|PAXPR06MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: c1e8d394-9c63-4d1c-29c3-08df25215e65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|23010399003|6133799003|18002099003|10067099003|3023799007|11063799006|260925021311599003|260925022911599003|260925021911599003|5023799004|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	8eUqLGmFrVD9sfmx1wPTVCoMcKrI282EOJYewI4BAapW/wmJXSXUfm3MUo2f9I2hbjVSGXe8W+9H9xk4b8MZknda65VbFaqw+mFVcRDvXc6X9i+r3K0fCuTY1UXsTenRhSlDblKQwf/dyNQfltDeiWFcD0RFpDTnCDiXymuXye/bO492OopNjdjJlgpBuNIhW1mvA61XXBTSGGHwCqr/JwzxYg0fkgZoOKy9uT9y+WN61oXnmfjRoOBJEdZDZDakK52I01A8deHsfu5YT0tfrlCAkR8yrLzOPdZyF4z67vu8qgpApzetq5PqyfwKVHtmoXZVD9qYNhdAFEWmrW8wF1ZSAorKvuuZc0iHd4h+2Fbk3zP/etlgKNjmcvSGRs1qpEMh44nm3gxicQS5elO/bXQpfgXy+S0kV2s9v/iiv34sQJ3gtTUIAp5p0e3X2hjOfm62f/jjDr0iAVDrEw4Uqd9unJr71SOTkwNISg5HEprEV09ndYD7leN89V2bsM7C9yrOwQSARBPSLr4faCXIHcVDvHeIWvqJ/hVLr/O+7WIANUbFBJcZmWVd5fqpw4PduJL+63MD4fFd5PtrpK6sN5vISidDHcYxRMLIFsFBfyFn3ugSkS7ArRGhG9kZ02BgSEDZA+HtGaYaSisdK2Eame6CH/FHYCI4J7vJwttYHQEdnhRTkpiYtdYsnmj51xdza+vT0vUUHN7oV82q3VP+BSxC6QH+5xIj6dSPEQXhBhM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(23010399003)(6133799003)(18002099003)(10067099003)(3023799007)(11063799006)(260925021311599003)(260925022911599003)(260925021911599003)(5023799004)(56012099006)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3VEV2UzaDc2U1BkSmVTdFYwM0w5dnRsekxnNTZkd1kvL2RWRVA4S25uR3li?=
 =?utf-8?B?dkk2Y3loU0h4dVlIQmlnNWs4K3NBamkyUE01RG54dUk1QUFrWlU3dkhCYUNV?=
 =?utf-8?B?QVJKL0U3S3RJWlRzeHpGTW1OTEUwQzBIT0pKU0RMUVZiVXpYajJHcFdseXk2?=
 =?utf-8?B?QU5WOTkrTGJEc2Z1SVNWWHdya0kwdGR3RTYyaWtyZjYrWStGNXNGSEw1dzZO?=
 =?utf-8?B?V0krd3orYWw4b0V5RFF4OG9VVVBtQkQxVnJTVFNKZ2g5cWVjTUJaVHM0RlRy?=
 =?utf-8?B?V2loUVJYRFJRb3pxdGJCOEZKa1I0N0I1ZG9HR1BXSVphbmRqZ0hlcWRXS2Nk?=
 =?utf-8?B?WXFtNFpkQ0xDcTV2TUVCdCtrV2E5WWg2U09mcC92ODY3WGRtb1lvZ2pGU1lE?=
 =?utf-8?B?V0I0bjh5NTdBUS9JS1pNdXl1UmlyY2ZuR2hNWG96U2VvUVh0ak12cmFVaCtP?=
 =?utf-8?B?R2RONmhzUlhUSHYvelZPZ2RwOHFZRzBMbFJDV0lTZnBONG1Gdk1aU1ZIRmRz?=
 =?utf-8?B?K1cyMmZZbjFlYWVwVFI4VlBVYmcreWFVSlVER041ZGsxRGVadVkxeTc2bnBx?=
 =?utf-8?B?MmhBUDF1NlRWeE1wTkhkNEsvamtqNjF5Z0FoUktpMUxlK05YeS9sWDdrTXly?=
 =?utf-8?B?NllKQkhCWklodkI1a2ltTVNYL0M4eXFLYVlsMlBSRlRHTm9LV3k5bDBIS0dW?=
 =?utf-8?B?dW5VRDZFbTNMUG4wWjl5Ny9zRkE4NDIyV2hUT2lYL2NqMXEwL3dNT1pWUlhz?=
 =?utf-8?B?S05takNUVFZmR2lKVDZad1U4UzA4amVDVFU0TXZZOGFwVSt1VzN1T1VBaTNi?=
 =?utf-8?B?V1JGTTY2dEN0dWJhb3VMdHV1UWp2Z1BaNGxiZWU1U25uelVDcEJOMTM3bFdJ?=
 =?utf-8?B?ZGxDWisxWjc1VjRBRytoalNWOWFLMjgrQzdQZEt3RDgyQ0JTYStycWpjbnpK?=
 =?utf-8?B?bjFPU3ZQanM2NTRNV0xkb05rQTRPSWZFOVR4YlhCTWcrTUhTL2dKdUhZdm5J?=
 =?utf-8?B?anlJM29MeFZ3ZWQ1V3RNYkJjY1BmNk8zQ2pKZnJHZC9Lc2dYUTlzeldjaVZX?=
 =?utf-8?B?SEpEbjhZQ2FTZG91SklRS0g2WnVsWk9mNUFrb2JGUEJZRXlodW5CK050anpn?=
 =?utf-8?B?bFJQU3F3V0plTzlCazVOemdUYUVZaWpGTzdaYk5zT3hCdVlsTHBpV3RYbk9T?=
 =?utf-8?B?Lzh3Y05VbGF2aFQwZ0JqNnNLSW45RlRBNmRSbDRnSXRBM1luZjVaSUU0VGwx?=
 =?utf-8?B?ODV4elRwdmovc1ljOFZQaW1IWW5uMVBlSmZ4MmJmZGRCSXhkZ29sbURmRk9h?=
 =?utf-8?B?YmpxTmZBVENOQmtPSTQzcXlXbkZFV3pxUGd2aTM5ajhPNExKQlJrTllGMG5r?=
 =?utf-8?B?aFZLOE9MSUpjY1BZRW1ua2hqbjFqbjZvUGRKSG9aS2FzTXNxd043bkdzVlFP?=
 =?utf-8?B?MlhENjl1N29tNjh2cnMzV3o0L21tZTBqNnV5alAzWGNoU2laNkhUelNldUxL?=
 =?utf-8?B?WHJ1aDI2N1BVbFVRVXJ4WXF6SmtreVRSakExTmFZQUlJaU5qakNMdjE2aEl3?=
 =?utf-8?B?VzlwVFNnT1dBNHp2cjFoWEdzdUJJOGtRbitzSlp3OHUzeUs3L0VhMkdPK2JK?=
 =?utf-8?B?WVFiVjkwSHR3U1d6MHJGVkJJcmZJSnpNMWhPTXExbDAzTExTUmlaQURpVmw0?=
 =?utf-8?B?T2dnbU1JUFNCYXcrcVQ4MWpnbUUvK2Vqd2RCcHVzaDlJb0xkNWxQZHo5d2xN?=
 =?utf-8?B?Ulo3ODlia2xaanZZWWw2VTVPcVl5ZS9Dck5jRVFTaTVkMkZSajlXN0FKVHFC?=
 =?utf-8?B?QTJhT2E2YWZHdUdOWDB0N2loblc3bjNoSkJjdVd0MytHakFDcFF1MTh1VEgr?=
 =?utf-8?B?QzRSZDFoUisyVjhOcTNPYkJVSnBpUW9tSU5QMEplT2d1VklXZ0tIcGkrVUoy?=
 =?utf-8?B?dm1jQlRLY2NvZy8xQXZ3SFRSaVhMVEpLR3FiSUNoaTR1bnRYVDA3a3IxaFd3?=
 =?utf-8?B?L2N3M2tPUjlLa004SzV3cVk3dlJHcG1PVDJ5U2V3SUcyVHVVRXczbUJQNEtL?=
 =?utf-8?B?ZFhnTjV0Qm1rVy8rNzdEVldtcW9heWp3R3U1aG8yb24vMG5QTnJqZXBXTWhj?=
 =?utf-8?B?djh5bG1NSTNFU255cXhUcUZ4VGJtRnpUSUtlcVFsb0w4Tm15TGZsS2R4NHRa?=
 =?utf-8?B?SDUvQk8zVnE5MmhBeVI0NEZ5M0lvRGtHZHJVTVhsdE54QXg0VFJHbmswb1Y3?=
 =?utf-8?B?WFA4azJRMmUrZlZrZHAxbkVLdmR4S1MzRVFTTXdEb2tiRXR0bWVZdnFQSUxM?=
 =?utf-8?B?bmJwNnIzZlQzcE1zNXZxajI0WkY5UkdQcE9RdVRWamZ4QWxHTXhFL0xSNk96?=
 =?utf-8?Q?1waIGtPkjzqQaFyo=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e8d394-9c63-4d1c-29c3-08df25215e65
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 09:48:55.9148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T06xCiM9MoovRGE0ZJnQzHwmJniPwcfbW2cJ9we9slzZ8kHBofHeT/CK3yg23gSUOOpJIGM1aX53J7w9gDU5ZAkKLOvBwYH/xqf58xtIOkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7567

The MAX310X hardware can express at most 15 bit-times of RS485 RTS
setup/hold delay, while struct serial_rs485 expresses the delays in
milliseconds. The driver rejected anything above 0x0f with -ERANGE,
upon which uart_rs485_config() wipes port->rs485 and silently disables
RS485 - a device tree asking for a 20 ms setup delay boots with RS485
off and an unusable bus. The values that were accepted got written
into HDPIXDELAY unconverted, milliseconds as bit-times.

Patches 1-5 fix pre-existing bugs found on the way: a termios write
clobbering an active break; breaks never reaching the wire on RS485
ports because auto-RTS only drives the transceiver for FIFO data; the
milliseconds-as-bit-times unit bug (patch 3 first centralizes the
transceiver register programming with no functional change, patch 4
then converts the units); and close() powering the port down
mid-transmission, truncating the final character and, on the auto-RTS
path, leaving the transceiver asserted on the bus until the next open.
Patch 6 adds active-low RTS on the hardware path via IRDA.RTSINVERT.
Patch 7
is preparation, and patch 8 adds the software-timed RTS path that
takes over whenever the hardware cannot represent the requested
timing, clamping the delays to the UART core's maximum instead of
rejecting them. Patch 9 fixes a reconfigure-versus-write race the
asynchronous rs485 config application has had since 2016, which the
software path would have made worse.

v4 was all of this in a single patch; Greg asked for it to be broken
up into one change at a time [1]. Splitting it meant re-verifying each
patch in isolation on hardware, and that re-verification found two
bugs v4 contained: a set_termios() or TIOCSRS485 during an active
break released the transceiver mid-break while the break bookkeeping
still looked correct (prevented by the tx_break ownership guard in
patches 2 and 3), and the patch-9 race, where a TIOCSRS485 followed
immediately by a write could put an entire transfer on the wire with
the transceiver released.

Tested on a MAX14830 (SPI, i.MX6SX) driving RS485 transceivers: for
each patch the bug it fixes was first reproduced on the wire with a
logic analyzer against the kernel one patch earlier, then shown fixed.
The complete series additionally passed an automated regression
matrix, grown during the v5/v6 review rounds to more than 40
scenarios: both RTS paths, both polarities, RS485/RS232 mode
round-trips, close/hangup/SIGKILL landing in every envelope phase,
output stop and flush mid-burst, mid-transfer path switches in both
directions, XON/XOFF injection at idle and mid-burst, and termios/
TIOCSRS485 disturbances landing in every envelope phase (setup, data,
hold, break) - each scenario checked both on the wire and against the
driver's reported state.

Changes in v8:
- no code changes - the diff is byte-identical to v7
- patch 1: the commit message now leads with the user-visible failure
  (a TIOCSBRK break silently ended by any termios change) instead of
  the register mechanics (Hugo)
- patch 9: the message documents the lock-free chip-FIFO check in the
  deferred-write restart - a refill racing it costs one extra
  before-send pause with the transceiver held, the pre-patch-8
  behaviour (v7 review bot)
- patches 2, 4 and 5 are retitled to name the failure they fix
  instead of the change that fixes it (Hugo)
- patch 5 carries the Assisted-by tag again; the v7 reword of its
  message dropped it unnoticed
- the cover letter is back in its usual shape; v7's went out with the
  changelog above the title and no subject (tooling slip)
- Link to v7: https://lore.kernel.org/r/20261005-max310x-rs485-sw-delay-v7-0-6ae392eca08c@vaisala.com

Changes in v7:
- patch 5 reworked: instead of draining the FIFO at line rate - up to
  fifosize+1 character times of uninterruptible sleep per close(),
  pointed out by the v6 review bot, and unbounded with CTS flow
  control holding the FIFO - shutdown() now stops the transmitter
  (MODE1 TxDisabl): the character in flight completes, abandoned data
  is discarded, and the auto-RTS release is given the configured hold
  plus one bit time before power-off. close() is bounded by about one
  character plus the hold, independent of queued data. This also
  fixes a bug the drain still had: a truncating close() on the
  auto-RTS path powered down mid-transmission and froze the
  transceiver asserted on the bus until the next open (reproduced 9/9
  on the wire: 0.6-2.4 s of stuck DE plus a corrupt character at
  reopen), since the drain bound could expire with data left
- patch 8: shutdown() gates first - teardown interlock and interrupt
  mask before any wait - and the envelope wait honours only the
  after-send hold plus two character times; the final RTS release
  settle is tightened from one character to one bit time (the
  measured pin propagation is one tick of the 16x oversampling clock)
- patch 8: a write landing while the envelope is in its send phase no
  longer rewinds it to the before-send phase, which inserted a
  spurious setup delay mid-stream; the teardown interlock now also
  fences the in-flight transfer adoption, so a reconfigure racing a
  teardown cannot re-arm the cancelled delay timer; and an RS485
  disable flushes a queued RTS worker that could re-assert the pin
  after the settle (v6 review bot)
- patch 9: the deferred-TX release in the rs485 worker takes the port
  lock through uart_port_lock_irqsave() instead of a raw spinlock
  guard, which start_tx()'s lock drop/retake would unbalance against
  the nbcon console handling (v6 review bot)
- patch 9: a write deferred by the reconfigure gate is restarted as
  a fresh envelope: the reconfigure helper's transfer adoption
  otherwise claims it and the restart pumps it in the send phase,
  skipping the configured before-send delay (0.3 ms on the wire where
  20 ms was configured; caught by the v7 regression run)
- the shutdown rework was re-verified on the wire: the regression
  matrix plus close/hangup/SIGKILL truncation scenarios on both RTS
  paths and both polarities, at the baud extremes
- Link to v6: https://lore.kernel.org/r/20261004-max310x-rs485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com

Changes in v6:
- every patch now carries the Assisted-by tag, which v5 omitted [2]
- patch 1: the LCR clobber is now described as "overwrites the whole
  LCR register" in the message and as a whole-register write in the
  comments (Hugo)
- the character-time caching and the shutdown drain-wait comments now
  state their reasons in place: both values must be current before
  the RS485 helper runs, and the tty layer's wait-until-sent is
  bounded by closing_wait and absent on hangup (Hugo)
- the old patch 3 is split in two: patch 3 only introduces
  max310x_set_rts_ctl_params() and folds the three copies of the
  HDPIXDELAY/MODE1 programming into it, patch 4 then only adds the
  millisecond-to-bit-time conversion (Hugo); break_ctl() keeps a
  single max310x_rts_ctl() call at the end instead of duplicating it
  in both branches (Hugo)
- one_char_duration_us is renamed to char_time_us and the shutdown
  drain bounds to tries (Hugo)
- fix: disabling RS485 during an active break left the transceiver
  driving the bus indefinitely - break-off only ran its restore while
  RS485 was still enabled. Only the break assertion is now gated on
  RS485 being enabled; the break-off restore always runs and derives
  the register state from the current configuration (patch 2)
- fix: a reconfigure that moves the port off the hardware RTS path
  while a transmission is still in flight - a termios change or
  TIOCSRS485 pushing a delay above what the hardware can time at the
  new rate - released the transceiver mid-transfer, and the rest of
  the data was shifted out with the bus undriven, with no error
  reported. The helper now takes such a transfer over: it enters the
  software envelope and keeps RTS driven across the handover, and the
  normal drain path arms the after-send hold (patch 8)
- fix: a break that begins while the previous envelope's after-send
  hold is still armed - TIOCSBRK waits for the output to drain, which
  lands it exactly there - was cut short when the hold expired and
  released the transceiver mid-break. The RTS worker now derives the
  line state from break ownership as well, so the expiry re-asserts
  instead of releasing (patch 8)
- fix: an XON/XOFF character deferred by the reconfigure-pending gate
  was never transmitted when nothing else was queued, and the re-check
  after start_tx()'s dropped lock did not cover a freshly posted
  reconfigure (patch 9)
- fix: a delay of exactly 15 bit-times - the largest the chip can
  time - was routed to the software path, because the hardware
  ceiling was computed in nanoseconds from the truncated per-bit
  time (49999995 ns where 50 ms at 300 baud needs 50000000). The
  selection now converts to bit-times first and compares against the
  field maximum, which is exact at every baud rate (patch 8)
- fix: a close() racing the after-send hold expiry could leave the
  transceiver driving the bus: shutdown's manual RTS release reaches
  the register, but the RTS output stage is clocked by the UART
  channel clock that the power-off stops - stopped too soon, the pin
  stays asserted until the next open (register confirmed released,
  pin confirmed high, in every observed case). shutdown() now gives
  the release one character time, at least 100 us, before powering
  down; measured propagation is below 50 us at 1200 baud, and the
  delay-free alternative (handing the pin to the auto-RTS engine) was
  tried and rejected on the wire - for an active-low RTS every
  register ordering of that handover drives the pin to the asserted
  level mid-sequence (patch 8)
- fix: a reconfigure moving the port onto the hardware path
  mid-envelope stranded the software envelope state: nothing reset it
  in that direction, and the TX-empty hold arming ran only on the
  software path. A later reconfigure off the hardware path trusted
  the stale state, skipped the in-flight-transfer adoption, and
  released the transceiver under the running transfer. The TX-empty
  unwind now runs on both paths, the reconfigure asserts RTS for any
  transfer it believes exists before auto-RTS is disabled, and the
  hold arms only once no transmittable data remains (patch 8)
- the seven fixes above came out of further review and hardware
  testing of v5: each was first demonstrated on the wire, then shown
  fixed, and the full regression matrix was re-run on the result
- Link to v5: https://lore.kernel.org/r/20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com

Changes in v5, beyond the split:
- teardown interlock (tx_teardown): shutdown() and the rs485-disable
  path set it under port->lock, and start_tx() checks it on entry and
  again after retaking the dropped lock, so a racing write can no
  longer re-arm the delay timer or queue RTS work against a port being
  torn down (addresses the remaining review-bot findings on v4)
- shutdown() also cancels tx_work, previously only cancelled in
  remove()
- the per-character duration is stored as unsigned int microseconds
  instead of ktime_t: single-copy atomic on 32-bit, so a torn read of
  the 64-bit value is gone by construction
- the TXEMPTY handling documents that the interrupt latches on the
  FIFO becoming empty, so a stale interrupt cannot pump data during an
  RTS setup delay
- new in v5: the tx_break ownership guard (patches 2/3) and the
  reconfigure-pending gate (patch 9), both found during the per-patch
  hardware re-testing described above
- also new in v5, from a review pass over the split series: startup()
  clears a latched break (nothing clears TXBREAK when a port is closed
  with a break still asserted - 8250 does the same); a reconfigure
  arriving during a break is now deferred and applied at break-end
  instead of partially dropped; the rs485-config worker runs under
  port->mutex so its break-guarded register writes cannot straddle a
  break edge; the termios-path idle settle re-checks tx_state after
  writing and requeues rts_work if an envelope started meanwhile; and
  the hardware-delay ceiling is computed in u64

[1] https://lore.kernel.org/all/2026092326-truth-unweave-c773@gregkh/
[2] https://lore.kernel.org/all/2026100116-saint-idealize-32cf@gregkh/

---
Tapio Reijonen (9):
      serial: max310x: don't clobber the TX break bit in set_termios
      serial: max310x: fix breaks not reaching the wire in RS485 mode
      serial: max310x: centralize the RS485 transceiver programming
      serial: max310x: fix RS485 delays being programmed as bit-times
      serial: max310x: don't power down the port mid-transmission on close
      serial: max310x: support active-low RTS on the hardware path
      serial: max310x: schedule tx_work directly from the IRQ handler
      serial: max310x: drive RTS in software when hardware delays are too short
      serial: max310x: don't transmit while an RS485 reconfigure is pending

 drivers/tty/serial/max310x.c | 632 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 595 insertions(+), 37 deletions(-)
---
base-commit: 9505146e885b1a842118aa6410f737290c4a5a32
change-id: 20260513-max310x-rs485-sw-delay-a306d783d529

Best regards,
-- 
Tapio Reijonen <tapio.reijonen@vaisala.com>

