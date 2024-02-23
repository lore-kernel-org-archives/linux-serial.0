Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2138.outbound.protection.outlook.com [40.107.24.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1A012E7D
	for <linux-serial@vger.kernel.org>; Fri, 23 Feb 2024 07:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.24.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708674247; cv=fail; b=SaXYJHRra/tsR420l7+fVQbCbe5j4tOm3VS3LT13pJyKDC3xG5SQCCm1wzgv4hxQO8UNNTWQEooMHTU0yYu9v6xXErPZ1KXW5Hg3WA7HPFtBj5l2s5q5vbOomvrDPzwMpQ1xWxOo72Q4k/lMHnVMwU3lgXHFr2N4PZxqVyfiQqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708674247; c=relaxed/simple;
	bh=Kc3c+uc8GkPsa4LBh6f9zuVBuW/LZVmL2iUMMLh2yWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OAdKZ13LiUhye4Jv3R2m39PQw/JfQg+K2VGYd6XPtfc/YWXQQS/ODxzSA4uB6ycDtVpDbm9cJyxUaGyS9iUK5XNT9L5pITmTOun3pd+F2Smdx+0PfFuOu9dAe4xRFPCbJCVMFk0ODJKt3fD1fcDn883ksCzth1TfPwODidJIjZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cern.ch; spf=pass smtp.mailfrom=cern.ch; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=omm+gTb1; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=omm+gTb1; arc=fail smtp.client-ip=40.107.24.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cern.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cern.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="omm+gTb1";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="omm+gTb1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aU5+n1akWES9v6SGajo/lUslfk36+6eIyIbk8Y3GASf+8gYOas+WvU42GwFb2GUGXl9ys6rLTdHl3A5CETWiozg1VJxgnkZ3No7ARhtGW+ADxklqWZnN6EFYN6iwexJOYrDJOSD4T1/F1vEaa1tJrUcfYZgOEXf4LI29Gm3rTbMQdd/cDOzAQZLvUkyRschz7qGfUocj43u/sM93XsgW4WdattpvYtlS0Rp8gGzi6+WKf+Pkesep4OWFZaWvlXX8cFaxX/zC3krCj/NN2gW+L5rhMKHgHQ36/RPn6M+EXxjExBurEBbiCTz9sVz3LouaR/tr5YykdiVqdOHD55ZitA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4284jzggA07KQ0b3xMHHLUijaiD9SjqbHbKDQ7qajLY=;
 b=i54sPQUyxlkJ30/YtOBZzNCLX8sdXS1NedWR1FKy3Uxc9dfo7hMDfU6GSTFDFr8Zilk8FE58rtQplc33llciUeqp9TzWxDoRsKQcZdxrNgVIwzknqyJ3KhwEQd0maF4wuD4HxGdCewb+yq+QFFHcxt4fZvnAgSqEtdlHkPaoh90QRr+2ieWJTDpdS9ZfN9W5aIMIcYP9+uKFxtgEP++xp5Leqvr8yZA1r1yp++MSxo0FgAXBrzqPzvW4hYFy5SGg5P0o6xqnF56SeiIzp9RsPogfyVfJBSCt76mHhE2HE/meGxVrJu30hPJmQNOx97two2ZgmFU4HGqQdt7soHJ75Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 51.107.2.244) smtp.rcpttodomain=gmail.com smtp.mailfrom=cern.ch; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cern.ch; dkim=pass
 (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4284jzggA07KQ0b3xMHHLUijaiD9SjqbHbKDQ7qajLY=;
 b=omm+gTb1JI33ejnZpgK0+mIJudHGUNCiYmsl+hU6To76LBIF2U+cKBE/c/CySEJSfn7UI3iNSnfkNUo8I8+i2YQyNxqmqvZNLLZYrJelshfsFslQbZ7GGYLGorB7yl3KvhMoa4ZQhld1OykewNHrP3EX8+9ELdzo2vdX8FvYziQ=
Received: from AM6P194CA0026.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:90::39)
 by GVAP278MB0881.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:46::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 07:44:00 +0000
Received: from AMS0EPF0000019C.eurprd05.prod.outlook.com
 (2603:10a6:209:90:cafe::26) by AM6P194CA0026.outlook.office365.com
 (2603:10a6:209:90::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Fri, 23 Feb 2024 07:44:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 51.107.2.244)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 51.107.2.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=51.107.2.244; helo=mx2.crn.activeguard.cloud; pr=C
Received: from mx2.crn.activeguard.cloud (51.107.2.244) by
 AMS0EPF0000019C.mail.protection.outlook.com (10.167.16.248) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Fri, 23 Feb 2024 07:44:00 +0000
Received: from xguard (ag_core.activeguard.xor [172.18.0.5])
	by mx2.crn.activeguard.cloud (Postfix) with ESMTP id 8C4D87E51B;
	Fri, 23 Feb 2024 08:43:59 +0100 (CET)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01lp2041.outbound.protection.outlook.com [104.47.22.41])
	by mx2.crn.activeguard.cloud (Postfix) with ESMTPS id B3A167E4F3;
	Fri, 23 Feb 2024 08:43:58 +0100 (CET)
Authentication-Results-Original: auth.opendkim.xorlab.com;	dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=omm+gTb1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4284jzggA07KQ0b3xMHHLUijaiD9SjqbHbKDQ7qajLY=;
 b=omm+gTb1JI33ejnZpgK0+mIJudHGUNCiYmsl+hU6To76LBIF2U+cKBE/c/CySEJSfn7UI3iNSnfkNUo8I8+i2YQyNxqmqvZNLLZYrJelshfsFslQbZ7GGYLGorB7yl3KvhMoa4ZQhld1OykewNHrP3EX8+9ELdzo2vdX8FvYziQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
Received: from GVAP278MB0230.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3b::10)
 by ZR1P278MB1086.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Fri, 23 Feb
 2024 07:43:57 +0000
Received: from GVAP278MB0230.CHEP278.PROD.OUTLOOK.COM
 ([fe80::c0ba:1ca7:d3b6:a040]) by GVAP278MB0230.CHEP278.PROD.OUTLOOK.COM
 ([fe80::c0ba:1ca7:d3b6:a040%6]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 07:43:57 +0000
Date: Fri, 23 Feb 2024 08:43:56 +0100
From: Federico Vaga <federico.vaga@cern.ch>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: andy.shevchenko@gmail.com, linux-serial@vger.kernel.org, 
	gregkh@linuxfoundation.org, Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Subject: Re: serial:support: Using 8250 driver With MOXA CP-132EL Device
Message-ID: <olxulijstkrryyzqkpua5wy7wkfecnspap6nmgzfbsy64qb4xc@dt6hadnb5tgb>
References: <zmry3u7l7dzh2iqqonxyombv4v2nzpr3fccoe677laxc2jn6nm@mo4afecdt45o>
 <v7jpnrrgmjqgmtwrahwmd6vouv2opuhwxaeo6ouimojql7lv3j@zqhwaky2lqki>
 <ZdfKxqwuJZodRDbz@surfacebook.localdomain>
 <ZdfL68clwFIYI4tG@surfacebook.localdomain>
 <751d67fe-59e5-4159-b674-924de4dfb959@kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <751d67fe-59e5-4159-b674-924de4dfb959@kernel.org>
X-ClientProxiedBy: FR4P281CA0402.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::14) To GVAP278MB0230.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:3b::10)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GVAP278MB0230:EE_|ZR1P278MB1086:EE_|AMS0EPF0000019C:EE_|GVAP278MB0881:EE_
X-MS-Office365-Filtering-Correlation-Id: d6f72056-7582-455c-d4d6-08dc344332e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Message-Info-Original:
 VazZ9rChEgrcx0u1GLynYRPyzko6zb+R2VfQBQ2sKEpf1Wu9hk6A1I00QLxviCR12RSeWEIHNyDSc7Cp5sR4xPmrgFtqw+dx6SEyZTDkq7ugwU84lCZ2xWKvFfE4k0daQmosvNDlPGxKOOBk+sIDo5wZ4dVATnUUOHPi/c0wOKQtLXzW8tLGxGvfZTp/OoDW8K42JIZN0xnOWGAMxNjJvYahIECsAHy+FQY+0bY/6jAjiFtG6M5k7afzPMK2QXtnpcpYjCeN7PZsGiu0g+i9LmPOtKmkWWnh6lFSL2vQZw0N8d+9uVqiYdkAZUtDEWaEyD1oA582FnuYVKOV0bPs1s5pM4bZHwjTy6FV6pvugwRWETb+F/t4fzZTlc9cWTHG7CNlwYhyEQn5Jh8KL0Rf4m7CXIx3uS5lu5IHOhWrC+NkjszS0+xh/Ze8Vfj/5gpLbvjDpWrYcRgqA/nm0R6KxmdHdXTBhV3Icy5o/srOxnd+wEsa4xm3VrRNB9l2jQ2tEVLguj0sVIJypZsLO9Nx5mjyH8hxisGhLo0us/YIeJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1086
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF0000019C.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	cef0c9a0-3252-49f5-d4f2-08dc34433173
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eCS2gGhyRba9Ul9V5TMX20U+oSZXIDU8NLGKbRitXM8d4nXdXLEnIa0UgbwhHcBSo+omrgtK6MhxIToaX17rZUpwnhT6a6ExU0TUGNOEls5WgUmH4pCRemIojQbglnux31SfG0NvJryCLs5bLVLuJ/LJByqMS3/t30xe1aEhe/k7NHl2Ngf42PitdUdPjt3dEApjzA7B6UUKsd62sAVdjgWXcZw12VKIaCEl/GTD/cTA5eRbXTVjXA82kWx78PWz2p9aID3HCv4xehz1q5FAlp/JfmbD6JvbD8HG1H2k7+AVa8bYXxY5qwFcAHDHN/qGh7gzBBzJO8OUyQ9V0C36XTXvAaeahZt1cONU+qzgZqu8MxGXfVGoERVPHhcxiUYyqPf2qWu7eN0gXvEc+gREPR+70X5ASSguHD5QHfCvIcgqVR8H/tb1aSE6qmeImJ9MsyClOSGVkbMYKZ2AfbDbzosZm3Eb0vGtN4aPWmBkPSbrDznz5Cv986emIPSIh0Nfv5JjeMDYEsHlPkaMbt42FN6wwVOTZvG/za+Nq+R99ES49AUzrxPRSVKa/z8B1jcCmQ+hB7K1PdaqBma5M5nrjb+lfB2+BXt289yFqykgQ5V2pGe47yITy/5jt1AVNMSjeIG4tjo5brygTak41z6cUvtPYmUE7vced3kTQFXVyf0=
X-Forefront-Antispam-Report:
	CIP:51.107.2.244;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mx2.crn.activeguard.cloud;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1102;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 07:44:00.0100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f72056-7582-455c-d4d6-08dc344332e1
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[51.107.2.244];Helo=[mx2.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0881

Thank you Jiri and Andy.

On Fri, Feb 23, 2024 at 07:42:06AM +0100, Jiri Slaby wrote:
>Oh wait, you may need:
>commit 43f012df3c1e979966524f79b5371fde6545488a
>Author: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
>Date:   Thu Dec 14 14:02:34 2023 +0800
>
>    tty: serial: 8250: Set RS422 interface by default to fix Moxa 
>RS422/RS485 PCIe boards
>
>
>
>which landed only to 6.7.4. Care to try that out?

That sounds a promising patch. I'll give it a try. Thank you again.


-- 
Federico Vaga - CERN BE-CEM-EDL
