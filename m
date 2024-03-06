Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2132.outbound.protection.outlook.com [40.107.24.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61195DF37
	for <linux-serial@vger.kernel.org>; Wed,  6 Mar 2024 09:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.24.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718831; cv=fail; b=HLS0j6NqkC6KRXxIUkopC1tKG/oKs3cB9axzj4qQqHEcxhPsVLrAS3aWX1+ekFt4PxnwKhzfPfxNbi51OxYIvoulJysJn//EQSCrUyRuFwYq+XxgInYy2+NosqAv9k+HZVY1GxZTVkjY+sWvfSKSwGyxefwp4wER+sx66XP/JO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718831; c=relaxed/simple;
	bh=h1fAbfBcAhI99xvm6S+qBsnw0PJ0xBBF5jcEbMe9yZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tgzeOI5WtMGPXpQl1qrTtQDjLcdS4xKyfG3+YTSue8LMlUPtsBzkZNdFxi8NdJVetfdqqtnnutKX331VLUCsjC8wi8+VHZewVA9CZ/Ar0aafyoNno3o102pVpBHeK+Sguu1LAb8mp6SLWPDchw/r8RuNigzzVbudFo65w2nD3ME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cern.ch; spf=pass smtp.mailfrom=cern.ch; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=S9PRkcxw; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=S9PRkcxw; arc=fail smtp.client-ip=40.107.24.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cern.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cern.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="S9PRkcxw";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="S9PRkcxw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hiobix0TgDrCkpbY6Vd4CoJGGA1ylWRQVoFkBW41kbJQ+e0zchsm4c23NPpafmJljj/X4NFzX4qVrFGzL+drauQDoaqdfMmRExzMXxkHPZU01KVXVhkU7665f10bNXAFpzjkxd3Hlns5gXpRhFyJQLzdUPx/+nkVg2yVO1E/r7Z0QfGZh9iBCwCp91gPUB9LxVr8jpOL5hfDkBiPJ7MO0Ur0JJ2GyJ+4TrtSHZ0sg+Gy7uncEjGktVPoniAcBh04CcoffPAFTQRJe1X2x/kQKFrzOlnPpY3boHJlvEHcEijMP9+32D5grNo63TNvWrMnBSISXRI23o4aRVFmm4xq4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/RrRQXhOwK1xa5kHjkcv85cWR4xa7VnKGTWEyi++vc=;
 b=j3w2XcbNXo1i5fvsPY3nX2/ICdJ8KfNB913KzCqdGSjElc07iDJAx8VgdLewXlvfVo+wdrYim5OeOGXuIH5lMaEBIzt9Yzs0lbAUA5knVvZLKPZ06I+D+mZsYNqb/S1PzTnJjC9iYudwkVjo74XfrqV/erzKRBY5LbtXgg070l25HP5LGuOCZXM9UonDwgvyfly97sTMAZkdZ4AzR02oRvKrFv0VagyC+UWfFXIj5NP+puOrwPQuV7Z57t3rFTbqFbz4wwOg5XdTMKICK379waLBFsEC5WCcpaALLZWf0RrvGhR+0hiFVKz2sWPQodU781UPZBvmXPmDFEktRLdvRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 51.107.16.99) smtp.rcpttodomain=gmail.com smtp.mailfrom=cern.ch; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cern.ch; dkim=pass
 (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/RrRQXhOwK1xa5kHjkcv85cWR4xa7VnKGTWEyi++vc=;
 b=S9PRkcxw9Ng6zFrxwMg9LkeJvK00+fFB5RWG9xknnvnbFZjo4b15s0WtyVwVPkJlBQ0qimvYmK21rOgJW/NZOzIIGgsTPpPJtYIOtWg1bQrEgbhsvPssJAl+/yrKLWBMZKsVZbaUoYBJeZFh10AgdUa2TRKiKgyHTmpIjyeRJWs=
Received: from DB3PR08CA0030.eurprd08.prod.outlook.com (2603:10a6:8::43) by
 ZR1P278MB1149.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.38; Wed, 6 Mar 2024 09:53:43 +0000
Received: from DU6PEPF0000B61D.eurprd02.prod.outlook.com
 (2603:10a6:8:0:cafe::10) by DB3PR08CA0030.outlook.office365.com
 (2603:10a6:8::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Wed, 6 Mar 2024 09:53:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 51.107.16.99)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 51.107.16.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=51.107.16.99; helo=mx4.crn.activeguard.cloud; pr=C
Received: from mx4.crn.activeguard.cloud (51.107.16.99) by
 DU6PEPF0000B61D.mail.protection.outlook.com (10.167.8.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 09:53:42 +0000
Received: from xguard (ag_core.activeguard.xor [172.18.0.4])
	by mx4.crn.activeguard.cloud (Postfix) with ESMTP id 779047E419;
	Wed,  6 Mar 2024 10:53:42 +0100 (CET)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01lp2105.outbound.protection.outlook.com [104.47.22.105])
	by mx4.crn.activeguard.cloud (Postfix) with ESMTPS id 940847E3A3;
	Wed,  6 Mar 2024 10:53:41 +0100 (CET)
Authentication-Results-Original: auth.opendkim.xorlab.com;	dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=S9PRkcxw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/RrRQXhOwK1xa5kHjkcv85cWR4xa7VnKGTWEyi++vc=;
 b=S9PRkcxw9Ng6zFrxwMg9LkeJvK00+fFB5RWG9xknnvnbFZjo4b15s0WtyVwVPkJlBQ0qimvYmK21rOgJW/NZOzIIGgsTPpPJtYIOtWg1bQrEgbhsvPssJAl+/yrKLWBMZKsVZbaUoYBJeZFh10AgdUa2TRKiKgyHTmpIjyeRJWs=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
Received: from GVAP278MB0230.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3b::10)
 by ZR3P278MB1212.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:74::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 09:53:40 +0000
Received: from GVAP278MB0230.CHEP278.PROD.OUTLOOK.COM
 ([fe80::c5c3:c4dc:7ff:29ca]) by GVAP278MB0230.CHEP278.PROD.OUTLOOK.COM
 ([fe80::c5c3:c4dc:7ff:29ca%4]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 09:53:40 +0000
Date: Wed, 6 Mar 2024 10:53:37 +0100
From: Federico Vaga <federico.vaga@cern.ch>
To: Fangping FP Cheng =?utf-8?B?KOmEreaWueW5syk=?= <FangpingFP.Cheng@moxa.com>
Cc: "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, 
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "jirislaby@kernel.org" <jirislaby@kernel.org>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	Crescent CY Hsieh =?utf-8?B?KOisneaJv+S9kSk=?= <CrescentCY.Hsieh@moxa.com>
Subject: Re: serial:support: Using 8250 driver With MOXA CP-132EL Device
Message-ID: <sl7qpese7e3bht5vsp4kzqwdsoibg6npnkuiskxokhin36x2wy@ywsgqcq7iw52>
References: <SEYPR01MB5506F7C6512AC1E03EA9132DEF212@SEYPR01MB5506.apcprd01.prod.exchangelabs.com>
 <BCDFCACC-4D99-4D87-9B1C-9B19ACFDC2AC@moxa.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BCDFCACC-4D99-4D87-9B1C-9B19ACFDC2AC@moxa.com>
X-ClientProxiedBy: FR3P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::18) To GVAP278MB0230.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:3b::10)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GVAP278MB0230:EE_|ZR3P278MB1212:EE_|DU6PEPF0000B61D:EE_|ZR1P278MB1149:EE_
X-MS-Office365-Filtering-Correlation-Id: 2125d39a-2aee-4af2-6858-08dc3dc34edb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Message-Info-Original:
 owD6vA7fZrScs8BtEeyuY8Q4c4t+9kABdLVVejkKjaC1Gpa2sCQYCuZv/Tg0EFC6vA+EBPI5SfCPhfmAV4g5EvLJYnHeME4kO15dwNVGiH8BDdY6+LZjSNR4dBVf6JL8Z9NvNxiZKTyBN/U8Ya08FnwqjNPuVXehQO10VSOkQmeQhf5i+9ryiJ8/tt5gP9SwoB/o1vCGONsxShIbx/2v6S54jPIXl+bKyyxYA6jWRdDf/GxqPd4Su8dqrLP39JmVJ+RwqJsJA8cOIxHLhdTZYL8wbyVa+/pUK6eGWUbvhYj6O6EGCB/AofTgdbpoUwicnhmYSKhR31muaUE90bV7keVATcPVeRyiw5qZL9ozCcq9mLcChvv8JAhrLPO/KD1wz+cMNE/rgHeo69S/LI9pI1xg9nZLg3zoaICjFkSEymM2Sst14e4GUmaHXJGdokG96GxbGrJExhsEp2E13D4gwTZ4pQszGBEV5DJs6ei+mYXldmhfbNoUvrFtak8ORd0KsEhNnMQqzyB36NPAzkIZF9OrlJP98D6DdUMzO0H965eZIW1PlFAiUlVWezZ8VBDb6EZ82C+5liWDegbV/esuoIIp4+TcB9CZf6D0Wi8B9G351CTK9fitBtOqbQfn4lqSItFnz2Z42Hukmv+oAY00Yt4jr+JSVohCHE9Z6QaYp74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1212
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000B61D.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0847062a-1de7-497a-c6c4-08dc3dc34ced
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g8ozvgLl3rV7bQOounTr02UApbP/9BedIL3y9byvI+nrFG8Q2tC/uuy67HfteXfn4IvEI3WBoNkb5XtvSEKpm4voPn/o/7D+9EfdhoQI1NUsi6ZHsr4oYJENcRgCOVt4i7Af9ew6f++IzIVq04pVFhqqMPqeJnU4VN64untYRXZoUnYbrhVLURmeWW/o20Gp+NaVhJIgXMf/TY1t12l0eqdzdfHa45IrjtRLLJCdBegdlmVMwIgC/JrDsuDgGfwqgnt3h1qfUopeXJrEzydMyr8vgOcTgcYUKyW2Yh9mzl/DGhVp/zKnElJjAmR5QlZioavSw/IvNJiK5IUbX6NvfRKwkTeEZjc9HB3YnaOvkK1G12fgQiLzL6Qf3T7aOxHaLzKdxvI8yQp9srD9+Z6EjcqRrqaf/Oq+QWvjVrkd6y+iKnB2gqtRqiHf8zqradWsdL40pu0omLOnhfyxtlr9vYwI9h/bVmaI0QLFUsWJUtgC3lkE1tyGEx/gscfyU+4QXapNMnH9LJe/gDS0j7clGHEPo/3lr4jnelfzB+YiLfKiJ/hyNMCSfFBr6ig9XToEWAxWT/j72scgoPtLbzJJVJlBfZLFbaC33YAgPLU+0HAT5Ec2YndiMJeUQBGOmtxOkYKiijWKCdGI44Hw5WNFzQw2fHWUCxdNMleUlgyftAklB+fQsKF889TQEkt0uGM6A+ZzVW3Oic0ruz55Esc7aqgFufVt2c+0T/aaC1DdMFGfxqWMpo1Ndtsqw7vlNshr
X-Forefront-Antispam-Report:
	CIP:51.107.16.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mx4.crn.activeguard.cloud;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1102;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 09:53:42.9436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2125d39a-2aee-4af2-6858-08dc3dc34edb
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[51.107.16.99];Helo=[mx4.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1149

Hello FP,

thank you for your clarifications about MOXA's position.

If I understand well, from the user perspective there is no difference in using
the Linux device driver from MOXA or from the Linux kernel. In terms of features
they are equivalent.

On Wed, Mar 06, 2024 at 07:27:07AM +0000, Fangping FP Cheng (鄭方平) wrote:
>Resend in plain text again.
>
>Hi Federico,
>
>I hope this email finds your well.
>
>This is FP from Moxa, the product PM for the serial product driver and utility section. Regarding your question:  what is MOXA position about using the
>kernel driver or the MOXA one available on the web site ? One of the main reasons that Moxa decides to adpot linux kernel driver is for better user experience. If a customer is not an experienced engineer, he/she may run into trouble when trying to compiliing Moxa driver. If the kernel driver can support Moxa’s products, the users can just plug-and-play and start using the product for their work straight away. We believe this will save our users’ time and effort.
>
>If the users need to use Moxa specific utilities, then they will still need to install Moxa’s driver for the purpose.
>
>Hope this answers your question.
>
>-fp
>
>
>
>

-- 
Federico Vaga - CERN BE-CEM-EDL
