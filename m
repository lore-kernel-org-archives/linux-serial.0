Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023129.outbound.protection.outlook.com [40.107.159.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A4F3C0A17;
	Wed, 30 Sep 2026 06:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751012; cv=fail; b=XWqdvPke7M1Ae1uJ1PjPK+BEvWKPv/R8uMUiogXN06DQ9o6frzn1zm61fI4vJVtl+s0dN0wZ3OgI84zd88b3E0zQ23/qSb+1iod2QPWJ43AsbnUwIhSLsBiy77FywNiiRUstQst+niGihCRA9tD6DMpPZOVy3bupwokAMn32/1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751012; c=relaxed/simple;
	bh=v/92JdiyQ5prlckpVPYqsHJOjG8appvbq5BGHkLPbWE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WIUd56xHtewhNxYxmH2Lgr20jon1PHTkjNFPCGUjLm/xTlYDt9a2bRemQwE/wVTAvIyeRt0Bbc3JXe0K5ZYbG9zj7q4VD6yxyG8sCmDzmdk39gGNzHim0ebcyxOj9jhBqi4GWP+BrEFMclenBbTvhpR2IjJtt560ICZtp/desBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de; spf=pass smtp.mailfrom=ziehl-abegg.de; dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b=S9ufgTDf; arc=fail smtp.client-ip=40.107.159.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziehl-abegg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziehl-abegg.de header.i=@ziehl-abegg.de header.b="S9ufgTDf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQPqv6PRL80NRvt5Hh4P4joylOzlhkw5mF6/R4sQzCwPnrrBN/sdHhKkZne7inDmLEkrfr0njTgYF3aDRNQTedBiwDi7gRfCGKR6TR1aX4S50JJQeVPgEgtSa6yhM6rE0tVZI7gfRiAl5HxTR06yWDU2rcbXC3ZJnf0bhXhIajYZiLKQ3A5W9u42X+6ShypdGrBgXhfg1amKxQROYckI+1L/PUKrg2Nmt64VQqg1XIamk+eJbK7BnUTBr0We8bMxNtfS3DcVH82pA4TFZV57Sx/Q48WNdOhEvVxWyHbip817lXv2M2sYpmNiJX67wL6kz6ZrxkC3Me3tmQ1z6HRCnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/92JdiyQ5prlckpVPYqsHJOjG8appvbq5BGHkLPbWE=;
 b=yLXHQZKjgpDv/oHMIy25DujPSsjxh5JfSfD/yJEMaJaBzMPdpXwhio/AOpySK6A5AlSGRamC8G4TOoFjPsACz+as2JPf2pUrOOabdCxO6w8xvsHDXassZf2IAXHljpOWjkBVHOBUY0lhVAQ/4gANcf+9vqu53aOweRiur2zL9OJH7Og04HEYm3wXP/+kvnn5JvI7yxBOJBxaX5aeYpXXN8q/4KhfYyKUoYQ0/zUXrew1jzeSCX2iId7U8tP5QjSlj+XlgK/ogDFnEw0uuADSsyyh0GXmLKA8RX5Pq9yH5GR2nGCkPPCj05AKnoZz52qRcDkU5jAfms4Gu3Dpd9ejzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.74.137.176) smtp.rcpttodomain=hugovil.com smtp.mailfrom=ziehl-abegg.de;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=ziehl-abegg.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziehl-abegg.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/92JdiyQ5prlckpVPYqsHJOjG8appvbq5BGHkLPbWE=;
 b=S9ufgTDfNNw5sOnWZpye6DO8Yyi1tpskuTYo4s3iE//iOj41UoGPPIztI/34ufh/rcEpKW7K5DIWuIOUbw8UZuRzHZXfZbaj91Tjw8gfVg0XYehnA66NWURKLsKW4PUEAx7aoeR1WLDyO633Jadae458rkU4BdRHE16v9LOaygI=
Received: from AM8P251CA0009.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:21b::14)
 by PR3PR02MB6491.eurprd02.prod.outlook.com (2603:10a6:102:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 06:49:54 +0000
Received: from AM7PEPF00000056.EURPRD83.prod.outlook.com
 (2603:10a6:20b:21b:cafe::8e) by AM8P251CA0009.outlook.office365.com
 (2603:10a6:20b:21b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 06:49:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 13.74.137.176) smtp.mailfrom=ziehl-abegg.de; dkim=none (message not
 signed) header.d=none;dmarc=pass action=none header.from=ziehl-abegg.de;
Received-SPF: Pass (protection.outlook.com: domain of ziehl-abegg.de
 designates 13.74.137.176 as permitted sender)
 receiver=protection.outlook.com; client-ip=13.74.137.176;
 helo=eu21-emailsignatures-cloud.codetwo.com; pr=C
Received: from eu21-emailsignatures-cloud.codetwo.com (13.74.137.176) by
 AM7PEPF00000056.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Wed, 30 Sep 2026 06:49:53 +0000
Received: from DB6PR07CU003.outbound.protection.outlook.com (40.93.64.95) by eu21-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 30 Sep 2026 06:49:52 +0000
Received: from DB8PR04CA0020.eurprd04.prod.outlook.com (2603:10a6:10:110::30)
 by DU4PR02MB11649.eurprd02.prod.outlook.com (2603:10a6:10:643::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 06:49:49 +0000
Received: from DU2PEPF00028CFD.eurprd03.prod.outlook.com
 (2603:10a6:10:110:cafe::ae) by DB8PR04CA0020.outlook.office365.com
 (2603:10a6:10:110::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Wed,
 30 Sep 2026 06:49:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 91.26.242.194) smtp.mailfrom=ziehl-abegg.de; dkim=none (message not
 signed) header.d=none;dmarc=fail action=quarantine
 header.from=ziehl-abegg.de;
Received-SPF: Fail (protection.outlook.com: domain of ziehl-abegg.de does not
 designate 91.26.242.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=91.26.242.194; helo=mail.za.ziehl-abegg.de;
Received: from mail.za.ziehl-abegg.de (91.26.242.194) by
 DU2PEPF00028CFD.mail.protection.outlook.com (10.167.242.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 06:49:49 +0000
Received: from localhost (10.1.201.87) by vEX02.za.ziehl-abegg.de
 (10.1.201.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Wed, 30 Sep
 2026 08:49:48 +0200
From: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
To: <hugo@hugovil.com>
CC: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tobias.gannert@ziehl-abegg.de>, <joachim.knorr@ziehl-abegg.de>,
	<david.laight.linux@gmail.com>, <Maarten.Brock@sttls.nl>,
	<crescentcy.hsieh@moxa.com>
Subject: Re: [PATCH v2 RESEND] serial: sc16is7xx: fix TX gap caused by kfifo circular buffer wrap-around
Date: Wed, 30 Sep 2026 08:49:38 +0200
Message-ID: <20260930064938.116227-1-paultyson.mbewe@ziehl-abegg.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928094733.09482cd6d6565588e2ecd267@hugovil.com>
References: <20260928094733.09482cd6d6565588e2ecd267@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: vEX03.za.ziehl-abegg.de (10.1.201.107) To
 vEX02.za.ziehl-abegg.de (10.1.201.106)
X-TM-AS-Product-Ver: SMEX-14.0.0.3239-9.1.2019-30228.004
X-TM-AS-Result: No-10--6.797400-8.000000
X-TMASE-MatchedRID: pBwXUM+nCwvrj1ICXYEoPPMcSueAbPVJjdkfepRWNj7IEVw/tNyThP5I
	KVIIaDOfvp04AHmPPpDDhNyfqjdIBEmAKa+it75/eWsf9OQoKxGjg0lrtKMWygtbihVN8itTen7
	9HuuKXBSPmA6rOmUXiznxJqun3snzF+p38MndnJrusRtB/Z90ThflOKKp20mp31qrgoURCz3OYY
	Jz5uO7hDsgfHO7P/GnBZEWfpJYBiE=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.797400-8.000000
X-TMASE-Version: SMEX-14.0.0.3239-9.1.2019-30228.004
X-TM-SNTS-SMTP: 432DA2DD621A62F31D9AC0CB22D442775294AA2826933C66133AE65BD23F12542000:8
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	DU2PEPF00028CFD:EE_|DU4PR02MB11649:EE_|AM7PEPF00000056:EE_|PR3PR02MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: e64094cb-b639-4664-3dfa-08df1ebf082c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|10067099003|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 H3hISL/sgtZ7nJOExlt8xNkPBkVpOjg2cCmw2TB19BiLs07VDMVdrKbzjy0PSEIjTLiV9d2euJZ4W3QJMaZ0oAgWf4Y8GVnwWLkiBOhGZM7Ie+vS1OoDz5yLEJzM4GvyRI9wMpzlQoGHjsZMIpSZcaKW++n5Z0DRqsUK2Rj28Lv5QuadxxaCTbfsju1kwa188d0qUUBlX6ZgIPDOlaLVeWQx5CE1dr+IaFfxRpVbtIaodqDrFIqXvnRhIHz6wUwWclAFc8gOAem63ImALkG4mm6dQdfIWfe+zj2btZCqv22pfDV34CbinujEfza0a5r96gwvbUFxdZOt1uDiiEJfJVejis32yJ4EP58mtIAp0xeuGpSU4IsnI+WooCLw4qDsI6zTLFXbYuza0aaz2EE2HyTHoLtG4Z5RZG03U8Wp6RHGO+tyrAV9uLY5WaPH4N4FppciMt4Rihl2SiPVbDBSBVyKYL6bbDgCM03Ok7t4IaDm0UN4DCmYH1MGRroBfo8qarEH7ey3NIZJquz/Z2WDc4hdgfBFA7vMx7erCeh9TFwhtu+4oDfik9xUXShVHRtcIJ4uTFQ31EQlIchjleZOHUDRbswKBLs7STY4xRbgQ2O5dwqMN8PFkgpaPMB3iddmPD2BY2OPTOZqwHKymjqPkohWndXicRWjQCpTXoVr56IeXldjvJudD6PuSc7q7b9fIzJbz27eS0HQhAF4ukNgIw==
X-Forefront-Antispam-Report-Untrusted:
 CIP:91.26.242.194;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.za.ziehl-abegg.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked: Wy6zhPhjL0fzyo8OGK1Yg9BqlYpaQfoeHSXZFfRUKPkh1lgnYvdUOyq4uWGvATZ4QrrHQ2rlWnPa0kLtuWbZL3mj8wtT1h+QyfTz8EWTCZQgjhSgnX/NAru1TbbNI4A7KFnzQvZfG/OIU0fFyzXgaBK+8coxQ0/9MDhuhBq7qBrPS0mQvQ2bvT0sO4AXWiqObW886YLm3mFGjOqQyQjhsDSg4yZkKJG+0xTnBt0bu54CXktIXe8M1zgVSatameLyLP0dGS2CVDAj5OEe1qPWrw1ob+2ugLcu6V7bhtYIx5j2XZuB1El8GIYYKuyRgYDrthUD2gozfhVnytbAbEYr9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR02MB11649
X-CodeTwo-MessageID: 9971c87d-28ec-48e1-9c5e-797a95663814.20260930064952@eu21-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM7PEPF00000056.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	dfea15f0-61df-41fc-0074-08df1ebf05af
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|36860700016|376014|82310400026|35042699022|23010399003|11063799006|10067099003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wrwBoAPvuGdA2Sj5PO1otMaVD9qFFpS0QKbfuGjQDKMukOU1XQVtsdk6jAA4DMpZubDWVZiWLNblFHNza58ofSFuRx5/9+wrfZ299geC6nZ+m1H+V7FxXhIHk2XUfP0JoFaaLBDsxeaGQdv5Vw52vB/ssJl0nlYi7tvnPg9ps0o1hysL1w28670tvEzxbDRF7LDG0KAyv0ok1J2dhJqhfvDeIayYNzUXbXqEDNfmbxPBAntSqo4gIRk/vSg/0rsmn/DLH8SPUDmhMXvsq++ax9IfpkGYiiporPuB+yZy81GWBKDmfgakZ7I3eW4IgSGlK+7/pQ77+Lc+AXNoVUA4baph6i2697O8zmLhoM8obL5Io+5ejQzuKLyYQkFW9n41t677K4roJOUe2MRkk1BWpepu0kflbQVrj39K515a/AzkXuCI2kez0LJcCQKUJGrPZY6+IhR2+IPxJekPX6tg6T6aPjqWdfR6wBYoJQ3kYkTPkmd+jin03IewQHAt2LkBrw755cpHdql4kp0JhLJNN7eawgqUc/CgAkq/MGjw7YzRYUpIpcLmGkLa3Wxq7SHXqaWxox66vXtt9BD2hs9o3bAoQivSoTL+IJSD9pUIZ39ZQ6O1Jh6stWjPJ6TU0H4gR4l/mNxvMsInX/pUZLyl+rGeSVydR1KXZfqYjnPEBUwoStEetzZma724YZCmDfTLHl2PFbl8QtHlrtSymEcuMg==
X-Forefront-Antispam-Report:
	CIP:13.74.137.176;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eu21-emailsignatures-cloud.codetwo.com;PTR:eu21-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(36860700016)(376014)(82310400026)(35042699022)(23010399003)(11063799006)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lPvtdbYPihvgLiXq0O2RxIpHIK/87CyL8VBQ8zY+XQGEa0yN4KGcFcC4QNkSB6a/BnUhAQxiTICM7zY47G5HuE2jzVewBiECljzUCRwIzJSxmQtQsdAeI5FPRO4moPQ6Lun+ckzEzMZFGjxqsz+gnuRdYObTsIgYhrMQoK6iegd7miNVEa3XBG6wCk2hrpUX1RCaLr1G03hjYzI3LlQ9xFN1bhIUaO4ur7yFL3f4b4MRa2dqLxQjq+nMvZWdxdZsV7AdCb7K2wEdH1C5D13kozYqc8KuikWjCEnVA0wqxnAHUlGK1AFbITgTE2vPQ3eDzyhma73sCu74JD38y8T2YOBAWzMGKDH+6rdvvPWORc4XZEXb/RZG2oGA8U+/iJBe4V5mBVsxGNBu4/NevMB86Gttw99+FsxTVaq4deZt7VT+31ouxPx9Pa5e5AzWBHNN
X-OriginatorOrg: ziehl-abegg.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 06:49:53.2506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e64094cb-b639-4664-3dfa-08df1ebf082c
X-MS-Exchange-CrossTenant-Id: 11a5c065-3ef5-41f0-92f9-a77cbf208c03
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=11a5c065-3ef5-41f0-92f9-a77cbf208c03;Ip=[13.74.137.176];Helo=[eu21-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM7PEPF00000056.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR02MB6491

Hi Hugo,

Sorry about the signature. The mail configuration has been
updated for your address and the reviewers CC'd on the patch.

Could you confirm whether this reply reached you without it?

Thanks
Paul
