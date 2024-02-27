Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2134.outbound.protection.outlook.com [40.107.24.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7F5146912
	for <linux-serial@vger.kernel.org>; Tue, 27 Feb 2024 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.24.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048876; cv=fail; b=onPIAAbfy7ZCrrS6DIXRL7w8JHkSvzYwtxfsLEo/UHofjPuZRINjjM13KpVBh5EzXxOguGANMmrcw86oxgRSBt8l0Foow3Ig3waRIiEh1HhqHxdUiQ3YhbZuNIZq9OGQilVIkpvfFMmWO/TwCUTuioJXQ6vSm8mfiw6JlRMz3Cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048876; c=relaxed/simple;
	bh=2F/WqPoVURyO2KJGIPIgZ2Vhc5c9Xl8u71Shal/n3Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uDWckd2CwW8GQ58etuevEw/zFKwFejuV6jDTdNzKXruRdzvsbCwVTn/BRUyK+RXc1hidKi5f9GkILgakvRoKJwBEIGwTu75Jgj+EQvwDsQb8BVi1Fu9qhj2kzEwy39UAwteIRSzQKMDaGHH87C0BSwriKOqP5bvRXPlK0pjZ/mY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cern.ch; spf=pass smtp.mailfrom=cern.ch; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=Ic5QWUfv; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=Ic5QWUfv; arc=fail smtp.client-ip=40.107.24.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cern.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cern.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="Ic5QWUfv";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="Ic5QWUfv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuLKz9g8fed2oMgzWItU9b4kw57dN8uRmefn11I6pAdsKMMio9Ox9priF4XKXVZ0XwSaKgHv5pxNpBd9WBAOqUtV5Od909z8FI0cIDj79qRDlD3CXlEGSDSEImGMz0hbTncPoMuru1wFszoJbwOvi/7p2NIvbUXFA+kH2HAXyImdYy0+eksI7QeHG5xg8qSYwHhOV3hUcsc9cfiZheQnTmSZEjQoHeddHny7SNMTSgOUnsZ413BxMCEJh6+Hn71zAtDzz0qO7bfdbEOoJXTWGsLhOLC8lXUsACBq24HTQWyFVDAdgD1K3Bm1D6j5z7cDmFVZONQaD9LFMUZw+HA/ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=POw64rAXJ/KWrhLfhfPYM/Pz59uTC25XnJ5yJv9YB64=;
 b=C4d7BjYPLxQopFI2xCIAsrOksZNh1u7NJuMIP8EYqEHxA0Ya9HtfXKMCWKeXabkdTd9/y7n6uYIYjBPaq5KuLHf9cEDpj0JQE2EASAqFa0e/N4/qDsc3acZdYXsVwBnWuS5FQ+AKwSoiv4xToRBhakhcdRPTE+sdDomZHbetpxb3JDn2CWrZkGrU0ZiJ+xaH3hcmUa7NpNYzkvkRDtc73/FDlmdJA0/UqjgMUkUXwnMty3x3AsrjcgR22YpECQZ8QVOiUX806gDIfv0+2BF/4f488wNnl4Xaym/rKPx2YNkrczvtKjEs0w8EVnvM/bQO7D+j8cho4NgP/9Fn6iBGwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 51.107.2.244) smtp.rcpttodomain=gmail.com smtp.mailfrom=cern.ch; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cern.ch; dkim=pass
 (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POw64rAXJ/KWrhLfhfPYM/Pz59uTC25XnJ5yJv9YB64=;
 b=Ic5QWUfvVdlPOMc4ouoUpSa29u9TEO0DGmRirP/ieTXFhk4KgYWMuqglCJlxJQ77/Z11D0Wd7+ABY0vwA65Ths8h3M211tvlsb41ETJ6YEYg09GaFzSbZy43Af6BUyzY/Bu9cM3/F0xWJEJOUugNloumuq0xmdCOaOvM+J49+A4=
Received: from AS9PR06CA0040.eurprd06.prod.outlook.com (2603:10a6:20b:463::23)
 by ZRAP278MB0922.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 15:47:49 +0000
Received: from AMS1EPF00000041.eurprd04.prod.outlook.com
 (2603:10a6:20b:463:cafe::65) by AS9PR06CA0040.outlook.office365.com
 (2603:10a6:20b:463::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.50 via Frontend
 Transport; Tue, 27 Feb 2024 15:47:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 51.107.2.244)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 51.107.2.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=51.107.2.244; helo=mx2.crn.activeguard.cloud; pr=C
Received: from mx2.crn.activeguard.cloud (51.107.2.244) by
 AMS1EPF00000041.mail.protection.outlook.com (10.167.16.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Tue, 27 Feb 2024 15:47:49 +0000
Received: from xguard (ag_core.activeguard.xor [172.18.0.4])
	by mx2.crn.activeguard.cloud (Postfix) with ESMTP id 4F9EF80595;
	Tue, 27 Feb 2024 16:47:49 +0100 (CET)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01lp2104.outbound.protection.outlook.com [104.47.22.104])
	by mx2.crn.activeguard.cloud (Postfix) with ESMTPS id 7C15180569;
	Tue, 27 Feb 2024 16:47:48 +0100 (CET)
Authentication-Results-Original: auth.opendkim.xorlab.com;	dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=Ic5QWUfv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POw64rAXJ/KWrhLfhfPYM/Pz59uTC25XnJ5yJv9YB64=;
 b=Ic5QWUfvVdlPOMc4ouoUpSa29u9TEO0DGmRirP/ieTXFhk4KgYWMuqglCJlxJQ77/Z11D0Wd7+ABY0vwA65Ths8h3M211tvlsb41ETJ6YEYg09GaFzSbZy43Af6BUyzY/Bu9cM3/F0xWJEJOUugNloumuq0xmdCOaOvM+J49+A4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
Received: from GVAP278MB0230.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3b::10)
 by ZRAP278MB0945.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:48::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 15:47:45 +0000
Received: from GVAP278MB0230.CHEP278.PROD.OUTLOOK.COM
 ([fe80::c5c3:c4dc:7ff:29ca]) by GVAP278MB0230.CHEP278.PROD.OUTLOOK.COM
 ([fe80::c5c3:c4dc:7ff:29ca%4]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 15:47:45 +0000
Date: Tue, 27 Feb 2024 16:47:43 +0100
From: Federico Vaga <federico.vaga@cern.ch>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: andy.shevchenko@gmail.com, linux-serial@vger.kernel.org, 
	gregkh@linuxfoundation.org, Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Subject: Re: serial:support: Using 8250 driver With MOXA CP-132EL Device
Message-ID: <tenao6tccr2jim2j5tyfyfojtonrguok77pdv4potwugvnt236@cf6tsjiyelp5>
References: <zmry3u7l7dzh2iqqonxyombv4v2nzpr3fccoe677laxc2jn6nm@mo4afecdt45o>
 <v7jpnrrgmjqgmtwrahwmd6vouv2opuhwxaeo6ouimojql7lv3j@zqhwaky2lqki>
 <ZdfKxqwuJZodRDbz@surfacebook.localdomain>
 <ZdfL68clwFIYI4tG@surfacebook.localdomain>
 <751d67fe-59e5-4159-b674-924de4dfb959@kernel.org>
 <olxulijstkrryyzqkpua5wy7wkfecnspap6nmgzfbsy64qb4xc@dt6hadnb5tgb>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <olxulijstkrryyzqkpua5wy7wkfecnspap6nmgzfbsy64qb4xc@dt6hadnb5tgb>
X-ClientProxiedBy: FR4P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::9) To GVAP278MB0230.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:3b::10)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GVAP278MB0230:EE_|ZRAP278MB0945:EE_|AMS1EPF00000041:EE_|ZRAP278MB0922:EE_
X-MS-Office365-Filtering-Correlation-Id: 45820217-1696-4927-5345-08dc37ab7388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Message-Info-Original:
 r9Ep3Sfw07RP4xvwRsQo77UEaQhyRf5o3AG75qSMdBelLfqMVjg27BmCbHH+TrDGuQoz5FtkEmo2BCgADxtKmAa3fQRJfYpyYD1Y51qtm98YgKOYAdIX/4wgbxbJnHWoiautR0HweJ7zuJaKq60PY6L9frlZHktgijDVAW+VtB0FKSXjujbCWzpnRsVnlYstKc/3LI7u+sU3GKbSctZt2sKh66iErJSqsytE+O24CESkkJmEd7SDQb7Qk8yxsQOaVWNJ9nn9WuBxJduHz5mynnX1gazVAzoSDRss77kdW86vYgGti3jOrVO+gMFaH+AgGYql9Kd/VFpubTBij1nslRNQnEQLn1LIVsWWnW4y57pDg0xwXjNjCKaEstU3UAfb+uanWw+sbVm9c/n7QF7lJpjJN50xem7HGtjYF3NbcBdRG50I6F6Ave38Tmzhfl6A7HaSwkT0/kK2/JRi0QXDwdZD4i+NGrG/Eg1lr6OPNYOnhxYK5arOefVkpLVJIcin+tJ2QDHXWNMJA5qgQdmyWz1ycCffV+NPemodU9OvqWXivllZbZHLX7rj8O8ZAA/SWbWsZK05z7Bt+UyqdQ638DsScqw8qTIQogSzOioSpFmOMqwlR6iSe+NxSVfSazVR5HA2zm+iGIRwght3pFugLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0945
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000041.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c9dc4ec9-5720-4827-627e-08dc37ab70fb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UVk6PKHcwTnpw8P2WoPAu8RjnDI+u8SDkGe+fpUjAIAo1R48Oe8mn49hkQrdB438LC+vaqzD5hHCK0O1ehJPDLEw2uE7OASPU/azr/fIX2StPlqzgjIMia0HYtVEo+IaX+iAZnedV79kEhP6JrOCl9a/sKHeBV/VhboGdTzH4SEN8qHGIRpFf6XSi8XNAtaFp1UXySmru0I1GSdIRoV6DhoGwZv17l+8/+oFNGss5kwGf3aVyigRB960lr6hciu9YmnRrfAxce+BdIa1BiuLVaeWs6OqvQHRk+Cp58mRexyaea+CYm4sAT1fFOjsDP4+sYbDSHzXzkJIETaWGWjMjiRGHYxnL+qUhLVmBOIFpZxWchSGfmuYiMv+JMvlmE1EqpVh3arslZetqYmhGJixzkGN9S1m7zhbOZe2o752tQVCHLia7QmYsQns2hY8MlISLvMc/VRpksAyVcx3FP/vVs+XOuFp54URCwR4DjlaqFfiZcyiklQHQauAKCQXu5jqOG17eRjzT4imgbTDI3HJLxHQJUpVgg2XhaGxwv93D4Mubh89esty0cZoaTtqdmtr3hZyV0xrcs7SzcA7OmyO4UoSv+MGcrmrvrn6MxAYiA5DRKc9865nnud0qnXsoNUE5izEQsCMRvUiqB2JPj4hNVpg0AoP/zhGhgupivW3aAoCBP4hmGWGOnIIGVxUO7byZv8a6SuymG4rzxs7YbXzchzHVS39rQx3p6EHqJOu6nsJHEcbwnvVz1WujbMFZ6ml
X-Forefront-Antispam-Report:
	CIP:51.107.2.244;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mx2.crn.activeguard.cloud;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 15:47:49.6235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45820217-1696-4927-5345-08dc37ab7388
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[51.107.2.244];Helo=[mx2.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000041.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0922

On Fri, Feb 23, 2024 at 08:43:57AM +0100, Federico Vaga wrote:
>Thank you Jiri and Andy.
>
>On Fri, Feb 23, 2024 at 07:42:06AM +0100, Jiri Slaby wrote:
>>Oh wait, you may need:
>>commit 43f012df3c1e979966524f79b5371fde6545488a
>>Author: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
>>Date:   Thu Dec 14 14:02:34 2023 +0800
>>
>>   tty: serial: 8250: Set RS422 interface by default to fix Moxa 
>>RS422/RS485 PCIe boards
>>
>>
>>
>>which landed only to 6.7.4. Care to try that out?
>
>That sounds a promising patch. I'll give it a try. Thank you again.

I can confirm that this patch solves the problem.

I see Crescent works at MOXA. May I ask what is MOXA position about using the
kernel driver or the MOXA one available on the web site ?

Thanks

-- 
Federico Vaga - CERN BE-CEM-EDL
