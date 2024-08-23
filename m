Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.86.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC1518E74C
	for <linux-serial@vger.kernel.org>; Fri, 23 Aug 2024 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724432092; cv=none; b=rTmECWAj9i6lhBEn9tkyyuzJ1M7YGwaGjQSGQ4bpqd52bcJ7+JjYJI17hYERGsOhfpWykxoa/TYNXwLEufr3PbYuGYvqOAvPLJApQnFfnmz1PFQBBog8UQPmuXY1pEf25aMEpCEWXTw3qIR10Zz+Y3lOoiDO8ga1uRfh2vfHfN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724432092; c=relaxed/simple;
	bh=xlivHA5ql1it85zYsrc8TIQfQPV0ClIQCYh3/vL6HX4=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 MIME-Version:Content-Type; b=CrZOLGVGfnwUVorAmj3Dmq8ELqiLQLknwr5zejS8uJLBphNsM1+whtvOoHw72g3n7HaUlQaij0hIpvZnhHTytlM/es2FAvz/zYW93ffp2zq46PdW1vYy1encTgWRdl9ymTByiaaAeMTSdb+A5UTybFw4fZnt57t/V/Nlp2/Rb/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com; spf=pass smtp.mailfrom=camlingroup.com; dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b=hIU5u7x3; arc=none smtp.client-ip=185.58.86.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b="hIU5u7x3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
	s=mimecast20210310; t=1724432088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c728VZv6v7K8l+pge5+f5HkAlqnOFc8OqhDpJIZ4pus=;
	b=hIU5u7x3igji6eCBJ3fj1Pz7XUG7KpbrcmpF3ZdTIQ/3p8YRXe6kN5m571KBy/irvPZxPi
	SxYNunClqG7TzfUmS4Gm1GD8r2Mj4YWVtI1ZAKgUw0JhYsQLAjAUy+A0ynxMO/NP41kuiW
	CMBUJBMhDOYwLYldjOkyhX5CYEbmVk4=
Received: from GBR01-CWX-obe.outbound.protection.outlook.com
 (mail-cwxgbr01lp2042.outbound.protection.outlook.com [104.47.85.42]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-235-iZ77_G1tN9CxZ2xa7eDk9g-1; Fri, 23 Aug 2024 17:54:47 +0100
X-MC-Unique: iZ77_G1tN9CxZ2xa7eDk9g-1
Received: from LO4P123MB5272.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:20b::7)
 by CWLP123MB3105.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 16:54:46 +0000
Received: from LO4P123MB5272.GBRP123.PROD.OUTLOOK.COM
 ([fe80::55a9:7dae:8812:f567]) by LO4P123MB5272.GBRP123.PROD.OUTLOOK.COM
 ([fe80::55a9:7dae:8812:f567%5]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 16:54:46 +0000
Message-ID: <8314e995-6f7a-4e9e-98dd-8c424d25b854@camlingroup.com>
Date: Fri, 23 Aug 2024 18:54:45 +0200
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 2/3] serial: sc16is7xx: fix copy-paste errors in
 EFR_SWFLOWx_BIT constants
From: Lech Perczak <lech.perczak@camlingroup.com>
To: linux-serial@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Andy Shevchenko <andy@kernel.org>,
 =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <k.drobinski@camlintechnologies.com>,
 =?UTF-8?Q?Pawe=C5=82_Lenkow?= <pawel.lenkow@camlingroup.com>,
 Kirill Yatsenko <kirill.yatsenko@camlingroup.com>
References: <7deb753f-bf86-47ce-89bf-8277aca4293e@camlingroup.com>
In-Reply-To: <7deb753f-bf86-47ce-89bf-8277aca4293e@camlingroup.com>
X-ClientProxiedBy: BEXP281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::13)
 To LO4P123MB5272.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:20b::7)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO4P123MB5272:EE_|CWLP123MB3105:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dffcdac-b3c7-4202-e9a7-08dcc3944b4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QjgrZGxxWk0xeFlzelduOFkrZUdyanN2bUJJTmVhUmFMaktHcHhFbTVOUHpp?=
 =?utf-8?B?YkxwejFZcndtSGhDcERBRHRRRStqQzdNQmJyS2VWUHMwSzhxNklmZVYxYnQx?=
 =?utf-8?B?dStTMXhBcXJVWDRDakphMVZHLy8xWnlJL0NkNUVLMkRkL2NPVGxtNWNMbFB4?=
 =?utf-8?B?R015SXNYMlFkOWhXdkNwN2JtbytNYkt1VUUvRnhwM09pR0x0eThnNzJCeHpN?=
 =?utf-8?B?WEx2eEJNNm1SU0ZGU3QvQkJURlRLSlA4cVpkUm5sQXJBN1NnVTJuUmpXS2c5?=
 =?utf-8?B?WTluUlZLR0FJVGQ5RU5ZWVJhbWlXZlhlY2k3dEZFU3JYOGtFVzhKZ24yTG9H?=
 =?utf-8?B?aWJidFFqTDNCbGxvbU1DbkRITjJKMmJPbXVNRmE3YUgrbW1TYWRJdlhCRDZv?=
 =?utf-8?B?QkZZdVo1aWQrRDd6bGFGZm5qbUVxWFMyMTBiRWhLNEdJNUF3TlZtK3piYStj?=
 =?utf-8?B?K0lNWU1EQVVRSnpvc1RZemlObmRYUHN6QU9sSEM3c0VYTGhqR1lXZEV4cXBX?=
 =?utf-8?B?ejFpTXYyaXVlY2RLNzhBVERFM1pXUVBpa1JUcHd6Z2Q0VVd0OUpFYVQ3bkd6?=
 =?utf-8?B?Um5UaFllTktLTDAzY0xqWHZXOG5hV1lYSHAwcStNUURTU2tmVGJYTW9IcUt2?=
 =?utf-8?B?R1pTMHpBb2tTL1lXOUJ1NDRJcXV4UDNxUlpUVnkzbkp5T0lkdWNsVzVCVEs2?=
 =?utf-8?B?bVF4MDB4akw0Z3M4bDlUeFo0R09sekExeGNVWlpDY1crMERYajlSZHN2cU8z?=
 =?utf-8?B?REFJclQ0b1J6T29XM1RWZXFkWW5BWXkvUUltN0RRaGtlOVJTR1BhaW8xTlpi?=
 =?utf-8?B?a2RpcVM4UXJiaCtQeEZhcmZES3ZNdHVoN3A2Vnh4OEhCdlk3RmFQSXVGMXNu?=
 =?utf-8?B?RTRPRlVJMHprbCtsbXozVEZJMVNQT2pvelF2R3JlS3NNbGQzRHQ1QUQzMXE3?=
 =?utf-8?B?dVVZQXZRWWRDT05JaW5BNkRYQWxHeEw5ZFAwVm1FRElLbDArWHpORGpTRFo3?=
 =?utf-8?B?RERSZzVKU29mT0Z0U2VROWhqRG5vKzMzOFd0aitTdWRYdWpQWUwxSmE4K1hD?=
 =?utf-8?B?RTZYYk8rd2xIUWJjTHVOaHRMK2lrWmpzaTFVTHFtUHRZMVEvdGZFUmoyZEtt?=
 =?utf-8?B?SXoyYzVQMk9tdStjY0dpNVFETTVzK1pHRjF6azJMSU80RTZBV0NpNjRQWGNH?=
 =?utf-8?B?Rm9SblpNbWM2eXhjeWpkUHMwYUR2UVRmY2FMMElNNGl2R1VKQTc5SGtlcVcx?=
 =?utf-8?B?SXZSU082dmdaa1lKRW15eGFuWmZKeWRNVU1XSzNoWHR3VXo0Y295NkdvaHY1?=
 =?utf-8?B?V0RLV1YrSW5PS1g4N2x6MXNYNGpxMFRxc2tsMndWcGZVV05STjFHcTA5RGxi?=
 =?utf-8?B?dktxQThFb0V2Mzlaa2tHY3JkdWdnMjJpNmVldnJtWXBPa2lwK2JXRGNRclZM?=
 =?utf-8?B?TnFuVmI5ZGQ0elVTK2NhV1ZsTnpXaWczZFJxODhybFFETWUreDBLV3BzYnQx?=
 =?utf-8?B?VDRmZ08za2ZrcDQ5d1JBWGJLTWcwSkNpWURyL1pXbXBnaGdsYUpQOXJ3aytu?=
 =?utf-8?B?bXpaOWJLdEIrMktGRlR0eldqMHF6RkFrWkZDd3BWSVJYK1N1M3FhTjZwMmtp?=
 =?utf-8?B?WU4rVTRNNlpRUnRyRzN3STlYQ29Ta2xDRVVoSU56VHRtdndwYjZVdzJBdVJO?=
 =?utf-8?B?YnhlQ0hyd1draGxmbm94QTBTdG0vc3NXelh1b1FLNENUSjJpaGkweklvaXdx?=
 =?utf-8?B?SkJnSWN6NW9RYXg0WjA0NU5aYStRTnRzV0xaSys0TXZTQ1plMlgySllxek0y?=
 =?utf-8?B?czFRRWpva1hsWG1HV08zQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO4P123MB5272.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGdZTEhLOVpZWWZQdnNPNjE4VDZGODFEbC9OemUvS2krQVZwM24yS3RRWFJD?=
 =?utf-8?B?cFRNNWJPR0lnZ0ViRU9tMDdPREJWOFRlVW93NXVldXhkQWZuclNlWG5FUkJZ?=
 =?utf-8?B?U25QaTJEallyaEdVQ2xtWnI3bUdqZ2d2TDNYZzB4dEVqdWptY2NVRkgxSFZv?=
 =?utf-8?B?cTBhMkI2bWZYZ0VFSFRrZ3lDSnhSaVB0R0JqNERreFo5ZTBjQW12enBKYWtI?=
 =?utf-8?B?QUw4ZVhlV09OdlFwYzNLdnJsalpsRzJjTEVTRFEvRFh0ZmRhR1Y3K1hyVE1F?=
 =?utf-8?B?elNjczUzTVA0b1oyc2gxcGdzSkxpSjI0Y3pDNUc1eGYwNis5WVAvaG9Sc1ln?=
 =?utf-8?B?MEVWZ0NYbHpuUU1KQUxsamVGQXVDWVdjTTluRHRGa0lXTW5Nb2RtWWUxZTI1?=
 =?utf-8?B?S05LT1g2WVNScDFTZDQxZW0wTkNDSDN1bzRUaWtvYUtyU2laUm1uTUNFWTRO?=
 =?utf-8?B?K0twUFdreEtuRDkyelVONkhxWmRTK0E3MXd1WXpCOWZxeVZWdmVIenVJb0w2?=
 =?utf-8?B?K3krT3piUHNWcFp3ejR6Y3ZjL0NKcUhsMitEaXVPWDJTVjIvRDZvNGRRWitD?=
 =?utf-8?B?N2p4b2N4T2UrSWxsUEpLMUNUK2RTTWp5OC9RS3pEU1pvVks4dllxbThuMDFY?=
 =?utf-8?B?UjVIOGZ6ZnFGK3Y2dmIwVFFkSytWeTBTR2NTb3V1eWNGVVo2dWlSYjczQmJk?=
 =?utf-8?B?aVNxTjc4a2RiZENnRVFYcUp3RUUwWFN6QkRPMnlpU3Z0YVUzamxTQ1NuT2FU?=
 =?utf-8?B?M0orRU5MZzVGSlhtWHFNRFJhZ29UaFp4NHpVWFJCUDdncnA1OEVWOWJ5bjVs?=
 =?utf-8?B?djRsUGtpZFN6MXRycmJ2THhNSS9CRlBEK2xWWEp5Q1JQS0lYdnA2QTZnUENq?=
 =?utf-8?B?c0M0Tndvcmw0UEU2VU41d1JXSjZSbGx4QTJwRStjaldqcUVzY2VxdVFoSmZO?=
 =?utf-8?B?dWpWWGRWUDJrR0RzSTZhT0pvVDJFWExtR3Nid1pYV2dZcWZoMkxTZlNucmUw?=
 =?utf-8?B?N0ZObEZKbWtLRm1rWEZ4NmY3aHM2eEFVLy83WHQ4SGh1L0pKbjFDM2FXSlU4?=
 =?utf-8?B?QlRWUXdHK1dqQzhvcG9jMUxCVkRBWGNFYjJSdE5LSndvNTA4bCs5OFJxWkdI?=
 =?utf-8?B?OWY1T1R4YWlMb1QwYy9MSGJRTnNZLzVpaERxN2xnMktqMzU3Ui82RVpqNVJa?=
 =?utf-8?B?UmcxRDFIWnhhM0xCV01vNCtzZVpIUldjZ1dvSnREY1Q5Ukd6UnVaeW1ObVow?=
 =?utf-8?B?V2lTMlpYSElDRDYrWkRDendncTNxbHNVa0FwQ3JpNDM1MlVsNjUrYjBDc2FG?=
 =?utf-8?B?Rmp3WG5hVllpNEhxVEthbHhPT0R2QnlQZGs1SXl5OXVraExNNGJ3bG5NeFZ0?=
 =?utf-8?B?K1FyN2tWem9IVmVLRzdhdTRzeGplZkM1VDB6MzNHckd3NVBVRWx4a3VBM0J5?=
 =?utf-8?B?OHVvNEoxakVnS2JRTzliZGFINzZNZkdGWWk5Sm51OHVsTytnNmVtN1RleEdW?=
 =?utf-8?B?ZkFDUWVNWDRMcTBlMTFHZE1VZmJhM3oxb0JFZVZxZDMyY2lJbUxYVXBWeUNE?=
 =?utf-8?B?eW9JQ09kV0lEQUpRL2tZNld5bnQ5am8zKzgwdTZRNllRVzFYRjlZMDVSRjg3?=
 =?utf-8?B?bEttckkvYTlXbFo3cEZyV1RDcDJIRlMya1NCUFdXeDJqWERLLzE0SG1xR1Ux?=
 =?utf-8?B?RjRMdndUS2xrYnc3SFJVajFGdDRJSTN5VEtQSEszRml2eHJjdzh3ekhMSVlQ?=
 =?utf-8?B?YmlUc0QzL29uZWxCcVU0M0Q1WGlVaHJheEFVSzhIaW9FTlhTZ1JBaWk3akdJ?=
 =?utf-8?B?ZG9DcmFHbUJrOFQ2SjF4NENraEdFZEIrN0duSnRwMEtUZ1MwdTA3bXBKemNy?=
 =?utf-8?B?YVpZWis1Zmh2WjRFblZsQ0ovdGtEdEhiVVZlVmdoNE9aM2VDdk9FL2pYMHU1?=
 =?utf-8?B?NGo1L2FoY3R0a2s0WjlXK0ZlR21kR250UVczSkZEREp1SzBGYjVvVkN5Y2wv?=
 =?utf-8?B?c0E1N0lsQmpuU0h5dG9ONE9BdEdUdksxWnpOWm1QSXlsZHJDK01tLzEwWkpt?=
 =?utf-8?B?eGpURXNXU296c09QS2FyQjBYelFWR09ZSGg5TWNiVm5WZE4xcUluQk1zWVlO?=
 =?utf-8?B?OVVXTWwwYzVZOThwck14cUhHLzd0RUk5d05iSjJVbEdhcEpOQVM2NCtRdGx3?=
 =?utf-8?B?V3R3bHZDc1hSRkpOOFNLTkxaaFNPeXFjM3BUaExaOHRaWTJjMzBiRzRyQjN0?=
 =?utf-8?B?aWpEd2pBWmVveFJlWHRDMXhPV1pBPT0=?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dffcdac-b3c7-4202-e9a7-08dcc3944b4a
X-MS-Exchange-CrossTenant-AuthSource: LO4P123MB5272.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 16:54:46.6601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLBwOgcMQcNO2w3ITjaVi2jn/6qgOUaErsnt/Of2s56Eh7cZCRyuQT0V2KW2fkQ4GxLfSBOPwGsVX+1YlzbW4Ks1dLBQ07hy7v3oPkd1k1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB3105
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Comments attached to bits 0 and 1 incorrectly referenced bits 2 and 3,
which don't match the datasheet - fix them.
At the same time remove comments for individual constants, as they add
nothing to the definitions themselves.

Signed-off-by: Lech Perczak <lech.perczak@camlingroup.com>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: Andy Shevchenko <andy@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.=
c
index 8a2020f9930e..36b7c682ae94 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -266,9 +266,9 @@
 =09=09=09=09=09=09  * and writing to IER[7:4],
 =09=09=09=09=09=09  * FCR[5:4], MCR[7:5]
 =09=09=09=09=09=09  */
-#define SC16IS7XX_EFR_SWFLOW3_BIT=09(1 << 3) /* SWFLOW bit 3 */
-#define SC16IS7XX_EFR_SWFLOW2_BIT=09(1 << 2) /* SWFLOW bit 2
-=09=09=09=09=09=09  *
+#define SC16IS7XX_EFR_SWFLOW3_BIT=09(1 << 3)
+#define SC16IS7XX_EFR_SWFLOW2_BIT=09(1 << 2)
+=09=09=09=09=09=09 /*
 =09=09=09=09=09=09  * SWFLOW bits 3 & 2 table:
 =09=09=09=09=09=09  * 00 -> no transmitter flow
 =09=09=09=09=09=09  *       control
@@ -280,10 +280,10 @@
 =09=09=09=09=09=09  *       XON1, XON2, XOFF1 and
 =09=09=09=09=09=09  *       XOFF2
 =09=09=09=09=09=09  */
-#define SC16IS7XX_EFR_SWFLOW1_BIT=09(1 << 1) /* SWFLOW bit 2 */
-#define SC16IS7XX_EFR_SWFLOW0_BIT=09(1 << 0) /* SWFLOW bit 3
-=09=09=09=09=09=09  *
-=09=09=09=09=09=09  * SWFLOW bits 3 & 2 table:
+#define SC16IS7XX_EFR_SWFLOW1_BIT=09(1 << 1)
+#define SC16IS7XX_EFR_SWFLOW0_BIT=09(1 << 0)
+=09=09=09=09=09=09 /*
+=09=09=09=09=09=09  * SWFLOW bits 1 & 0 table:
 =09=09=09=09=09=09  * 00 -> no received flow
 =09=09=09=09=09=09  *       control
 =09=09=09=09=09=09  * 01 -> receiver compares
--=20
2.34.1

