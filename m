Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.85.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5DD8003F
	for <linux-serial@vger.kernel.org>; Thu,  8 Aug 2024 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132812; cv=none; b=ny2+vgNI9ws8xF6hEHB5UIE6d5dPwIC6jilm8eLx/+8tQ9SArC1jh9ZWE9DtbqzXeSmdPVfcvzsGKKkVDdqyDU7Haan9zFDvmLizqM3mHnw+ZaehMsdFNxuUcE4Z6BkWHKpn0MyXX8E/OG677FZIVISXRmZmH1cWFjV/1vg1brw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132812; c=relaxed/simple;
	bh=xwHM+2jEJSRymGKmUvstfzDr/HlHog80byhRbKRnSk4=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 MIME-Version:Content-Type; b=KsVehdo4vAW/QM67+x4zgUOybYDlDLEc701NT+n43ytLJ/cWoRH9v4X12ErxPR46uWo2korj1uJuqieL4j1rpV/e8mzyU7P9+ZZ+Bd0INqTzoCAddaV5eA1RROhXZv2+jNUrpUqaRnnpLTwz8a9qhBV3W5kpZO9fRaxwPFTBkJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com; spf=pass smtp.mailfrom=camlingroup.com; dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b=FJ9p/EoL; arc=none smtp.client-ip=185.58.85.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b="FJ9p/EoL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
	s=mimecast20210310; t=1723132809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YfnnNoTR8wZkzAeozP6Z1sB7CMSAZQbY0yn1Z/xP9r8=;
	b=FJ9p/EoLI8AlRP4lp0Pmz6PwrHi7RwOGK0y/Dg98PPvtnnqqnoYAkYfTZ9jO3YVV3nP5Bi
	MGFnGdA02DSCPA3MQ5wi6rN8IG8qWIgQLvpfpxQfRRYqCSUGm/8zSEdl0JDe6W5B8wB8k2
	es9vGkFizEgQ/VU6Cikj5cpNf2DXFHw=
Received: from GBR01-LO4-obe.outbound.protection.outlook.com
 (mail-lo4gbr01lp2105.outbound.protection.outlook.com [104.47.85.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-232-ZPA-JwDsM9WO7q7c-FJ81g-1; Thu, 08 Aug 2024 17:00:08 +0100
X-MC-Unique: ZPA-JwDsM9WO7q7c-FJ81g-1
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:142::9)
 by LOYP123MB2816.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Thu, 8 Aug
 2024 16:00:07 +0000
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f866:62f9:716e:ca4f]) by CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f866:62f9:716e:ca4f%6]) with mapi id 15.20.7849.014; Thu, 8 Aug 2024
 16:00:07 +0000
Message-ID: <b792ee31-6e47-418a-9619-3937a38d3054@camlingroup.com>
Date: Thu, 8 Aug 2024 18:00:05 +0200
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] serial: sc16is7xx: fix copy-paste errors in
 EFR_SWFLOWx_BIT macros
From: Lech Perczak <lech.perczak@camlingroup.com>
To: linux-serial@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Andy Shevchenko <andy@kernel.org>
References: <6bfb7abc-0264-440d-b0d6-6dd6a8b64b5e@camlingroup.com>
In-Reply-To: <6bfb7abc-0264-440d-b0d6-6dd6a8b64b5e@camlingroup.com>
X-ClientProxiedBy: WA2P291CA0001.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::20) To CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:142::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB5267:EE_|LOYP123MB2816:EE_
X-MS-Office365-Filtering-Correlation-Id: c71f1961-8fd4-42b7-41f2-08dcb7c32c4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUJJeXdXQ3piWjRCc2dHc1NjMzlOZFNtYkg3eFpYcmxxR3p0M1o2eFk0SjU5?=
 =?utf-8?B?V2NJcXRENWlGejVEMy9uVlE2RkNUWkpEbWZLems0Y0lRVE96Y0x4VXg1SWdG?=
 =?utf-8?B?dEw3SXFhemFhZmtvNUozT3V4Vk5KSzZEM0l6emp5Rk5XMXpOc3FrSjFGZjJo?=
 =?utf-8?B?TkZjcmpJTXovWXBKSmM2VWZIWVlXNys3bno2ZWpwVjZMTkQrZFM0ZTZnaDVL?=
 =?utf-8?B?TlRzSkNnOWNTamMrc25YU3ljMFd4cnlNY0toMlpPcU84SFBTS09RNjd1blR3?=
 =?utf-8?B?cE9HWDhsZ3kyeVQzQjFvczRZelBTck14N0lSd3IrS2IvUnM0bEtGdUw1ZXdE?=
 =?utf-8?B?M2xTR2s5Wi9QQUQvS01VWnI4YnRqMWNUTzFDVXFFekZIR0l3ZjRoSFZXdDBI?=
 =?utf-8?B?SUowb3FFVzk3RHlvejJCUVFUcWl1dWZWVHRMUkt4NFBUTzRFOEIwUUhJVjVC?=
 =?utf-8?B?b2I2cGNhT2N5WTZyMGNVUDVtQ05yVHBNdk45N0tZTGw3SXcwMzh1azJhTnRu?=
 =?utf-8?B?SHk2YU1CcHNRdDgzTGtKNkkza2dTdHd4MW1lNWdQTWJiNGF4NU5IY0lCcHBU?=
 =?utf-8?B?MFAzZXlDRzVHT080VDJZVG9neWxjNVB5eExjVUFKLy9DSDlWNnRYWjdweVVs?=
 =?utf-8?B?TFY5Vm9TS1BjR0NLVjlKUUpteGVxZmtOMm1mYVhyOTFRQ2MwUHB2RjUxS0Rk?=
 =?utf-8?B?WjQ4WDYrNTBNWkk5eGM0SDJOYVpnalE5RFFTeGM3Vk9mQmpUTWE2YjBLRmlP?=
 =?utf-8?B?RDhsbTlaYnJoVEhhRFlZaGQraWw4VlYxQy9wZGx1OW5SZWV4cExFWmlMVFBx?=
 =?utf-8?B?UTBtbzNkcGRzRmFWTytpdUN0SmwxYW10MW01M2hrbzBvWTV6YmJEM2hyZE9r?=
 =?utf-8?B?RCt1eEZ6eFRUNmtYRFFJeElDNm0xWE9ZckNrekRyUHhsUjlNR1lQSVVTQmQv?=
 =?utf-8?B?bGhKYjIvQmd3Tmtjb2VlWE9UcUxXcC9SVGwzSkFCd0xCdExPSHFOM0NHV0Y0?=
 =?utf-8?B?NzA2b2gxbnNIa2tieGxGTFZEMFFFTlNWY1FpbUlKU0VxdHhJMEZ2ZnFqcEdn?=
 =?utf-8?B?cDN6cFlOeStkNWwzNHIzVXpCVFVyZS9UeEcxbVIwenFnUEFDZ2Ivd2Z1VVhQ?=
 =?utf-8?B?MllIL3hEMmU2RGNpcU1La0UweVNpT2ZoSHIzMHFuTUJEdW5XTUx5N3dRZUhI?=
 =?utf-8?B?SHdmQk5kR2dPSGpGYVNkRnZWaC95R0d1cmNTMDROa241M1Y4SEx6bzRvdUI0?=
 =?utf-8?B?d0NxR3NKbWZ6QXh6bFcwZEJzOTdmUGoyK0l3TG9ncTlpM29IY2dkbGhDRzNQ?=
 =?utf-8?B?b09HTkFWTG11NERiRThJRUdNc09hQTY2WWExS09GU2hVUVFtQ3l4MnlYbWZK?=
 =?utf-8?B?OWNVNjYxTk83VzU1TzJSVW4yWlJLR0xqZjExbXNVWFRUcWZYUHVoUkdJYkpJ?=
 =?utf-8?B?ajZLSWVRU0thcVJPQnVZTXN4NnBDY1ErVzZUeHYrR1l0WFRXdHlhTHV0eVBo?=
 =?utf-8?B?QzRHanhqQU1OT09mNjRubk1VZUdYLyt3dmszSjM0VWh3VTNPMzlLVit1ODBC?=
 =?utf-8?B?aEQ1bXhseWtrRFREcVVmVTFxbXpvRHROSmIySnVRMk55ZWw4UDE1c0o0NGxS?=
 =?utf-8?B?cElqbE8rK0RRb3JGOVplVldXSlJjcS9VM2ZNcDAyOThjeDlDVUlNUzNDRGp4?=
 =?utf-8?B?UEcwU1NPaDIvbm5TRWI4eExoTWdPZ2JwMW5KL2xlQWNVd3EwSzc1MExaWUVx?=
 =?utf-8?B?WkFXbFdVZytoQXczWlNIZEIrVmlkNEwzZkNZTEU1VFFwdVlxN1diekozbHJn?=
 =?utf-8?B?bURzNXZZb0Q1QU05VjdEQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzZUbFMyN3BNOU1KVmR5Vit4Ky9RSXJ4Z3NIZmk4dWJjbk9aajAzVDkyU2lp?=
 =?utf-8?B?Sk41cE5UTW8yZ1VnVDVzSllmKzIxY2tXakFwYmw2dnczak9Dbko5MW80TGdI?=
 =?utf-8?B?cndmMmNFVVpTbWNQMHcxOFM4MUJHNmxLSzRJRVlHVGlzcDEybzhub1drUHlK?=
 =?utf-8?B?ejZHRnJRb3ROdW5Ec3I2YXp4RDhyYUozSWRzR29WV2MySStQMW1sQXduMWNM?=
 =?utf-8?B?bmxqUEx4WkJma29UK3ZSY256N29tREQ3VDllakxCUUs2U3RnYjhQc21XZCtQ?=
 =?utf-8?B?ZUVJMnpMdHArYWE5elVhNFRoZ1hKSHNub29oMldyTm1lTUhQWmtEUEpSeFF6?=
 =?utf-8?B?V0hYSkpTK016L2ppS29IdVlrMFFTVU1iRUI2TS8yQnR0bVJsNW9KY3E1RTBH?=
 =?utf-8?B?UnBPMXM5bEdkcUNoZXRueitXc015bE1Rb2hxWW1ydlJOamhVZG1OMUtGWUkx?=
 =?utf-8?B?cWVhWVhISVVablg3NUpVRHpvOWNhK25pNmxqWW53VmhDdlNjelVLdFozOC9a?=
 =?utf-8?B?SzBqU3loZkp1MWlCMG1TMFlrak9FV29Mb1NXWDFJSjRvd2o3YS8rcFZDd3do?=
 =?utf-8?B?K3ZRMk9YemZBSyt6VUFFbkNmT0F5cFNoVi83MDFpaU9MVmc0NG9EeGVla25n?=
 =?utf-8?B?L0FZQm9ZaWdwcUVjZGxlUEx5Nk1MYlFXSURlZGlCQml4c1Q4TFJzRmNrcnpO?=
 =?utf-8?B?WnF0V3UvV29vUi9wT1ZCTWJ1QmdMV2FmRmh6eFRRcE82Nk1NN2ZVUnJrelA0?=
 =?utf-8?B?ekw0blBFL2tiSUVyYkRJeW1hVUZpbG91R1dmOWpQWk1aQmNLTnY2cStVK2pT?=
 =?utf-8?B?NEFpMFZMeWJhcUplQUJINkNLZk4yWDhlS2hyZ2RNZGEvYVFURXBqWTgwbkFZ?=
 =?utf-8?B?WVV0SFFpejY1WDI4ck50cGUxeWs4WU9xUCsrTWxtdjREYUZiSWxtM0ZKMUMx?=
 =?utf-8?B?SlZndWZPZlBPMXpGOUtFOVFGeUdsOFNXVUxjb3ZBSmhlVGlGZnBuQ0NSRWw1?=
 =?utf-8?B?dndKNExRZXZVYmhaekhRa1F6cDZwZDlCenlVdk8vbWhSVEFPdmNVeDhYUzF6?=
 =?utf-8?B?UGdHYzA2ZStCM1lVMURyeXIrQmVhRGIrZEFSUmFCM2lnLzVZZTVyallvVkow?=
 =?utf-8?B?RUdXTGVpRS85a1JtQTFsNkhUVDl1bjc5WVFjVTdkYjN4bWJycWNTelk3SmM0?=
 =?utf-8?B?ZnA5VHdkT0dKZUo2M3lFMC9NWGM5aFRZYkRWOElNOE1GWndUaXkyNlp5cjdh?=
 =?utf-8?B?Q0ozaVdEM2J0Vk44dlVuQnRyRTRXa3RUSUh6c002WXF1eWVpZll6dVlvTEll?=
 =?utf-8?B?Smt5OExheHVzWHZOVklzMlQ5VzVUbzA4K3UydFpvbGdhMWE1Sk9xbEw5MzlS?=
 =?utf-8?B?amhVbmF3SVl6Q2RVeTRxd3A1TXlPL3B3YmNMSjczMFFFaVlub3dTRXBpT28r?=
 =?utf-8?B?a0x4ZnV6MWVLaUV1Wm1vUFVmaDdGZTFxQUQwQmVMVTg1WTd5eEhlMUl5RlYr?=
 =?utf-8?B?SzM2TXFJeGZBZ1dGVVRqbkVzN1N6aTdLcUhIdWtYUDdybDVST0FKczEvbCtH?=
 =?utf-8?B?RTZNbEZ1Zk1SdGQrWEc1UjFDNHhqZStZZkNmTXYxdkh6UFhqR0ZqM09SUG9D?=
 =?utf-8?B?c1kxWWFNZU1tSjl3cTg1dG9ITFU0Q00wNzJWSGhsVFNLVjQ1UE44TDE3eGJn?=
 =?utf-8?B?eHpDSXRZcGJrTlBHSGRlU2VLUk5pbnZaa05SQTAwclh1ZzM0RUd1Q2k5TWlP?=
 =?utf-8?B?Q3NXOXl6dDhLMGZOaVVkYXBHcERyZFdXbDRHZjE1YXF1eUNBZ1JxRXcyTlFq?=
 =?utf-8?B?TGVudTJZUXFlWmpYQ2k1dFA1a1lPOHZOeVRiTHBiZ1hOby9EVVJ1THl0OWxS?=
 =?utf-8?B?cTZqYzBjOURtMlRPZElWSDRuQm1oYkVKMnRZTVBnZFNSVzhENUxBTlBkeHEr?=
 =?utf-8?B?UmVjSE1SQkhaaVZKQklMODE2VkJ2VEExUTNzL2tUTHpDOWQxaUpXTlp0TVFn?=
 =?utf-8?B?WlAzOTcwaHlYa2xYWWRBSFppcWd5VEJzTFhCTkZVSlRYYnVKYWwyc3JKemJ0?=
 =?utf-8?B?MUU0R253Qy9QaGZob3J1cjUyam9DM3NoNzFUSEp4WU5OU0VWK3JkaENtRjlG?=
 =?utf-8?B?dHZhcko5QjRKT240eUgzYTZrQkdYUWF5L1ovYk5RLzdCUTlUd201WkNzTE0v?=
 =?utf-8?B?Vk1WbGtxQWRoVENJOGkrMDJpWnlqTDRydVlyakxlRGM4ajhpQWdtZm41QVAw?=
 =?utf-8?B?d2VLWE5uZ0VwRnlJR21ZRXJ5OTdBPT0=?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c71f1961-8fd4-42b7-41f2-08dcb7c32c4e
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 16:00:07.1070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nkt7Y3dC0bPEj8OiWHudG9S92+9SDoIMk+CjdA0UX2gV8Fj3ffnUqyMpK+Z8X625TGMecwMZT2YRqt4Aq7Mcs77FvBdH3H41KzokN4OD+Zw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB2816
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Comments attached to bits 0 and 1 incorrectly referenced bits 2 and 3,
which doesn't match the datasheet. Fix them

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: Andy Shevchenko <andy@kernel.org>

Signed-off-by: Lech Perczak <lech.perczak@camlingroup.com>
---
 drivers/tty/serial/sc16is7xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.=
c
index 8a2020f9930e..c9695a3fd193 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -280,10 +280,10 @@
 =09=09=09=09=09=09  *       XON1, XON2, XOFF1 and
 =09=09=09=09=09=09  *       XOFF2
 =09=09=09=09=09=09  */
-#define SC16IS7XX_EFR_SWFLOW1_BIT=09(1 << 1) /* SWFLOW bit 2 */
-#define SC16IS7XX_EFR_SWFLOW0_BIT=09(1 << 0) /* SWFLOW bit 3
+#define SC16IS7XX_EFR_SWFLOW1_BIT=09(1 << 1) /* SWFLOW bit 1 */
+#define SC16IS7XX_EFR_SWFLOW0_BIT=09(1 << 0) /* SWFLOW bit 0
 =09=09=09=09=09=09  *
-=09=09=09=09=09=09  * SWFLOW bits 3 & 2 table:
+=09=09=09=09=09=09  * SWFLOW bits 1 & 0 table:
 =09=09=09=09=09=09  * 00 -> no received flow
 =09=09=09=09=09=09  *       control
 =09=09=09=09=09=09  * 01 -> receiver compares
--=20
2.34.1

