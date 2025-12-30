Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11022096.outbound.protection.outlook.com [40.107.168.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165A525CC40;
	Tue, 30 Dec 2025 22:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.168.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767132056; cv=fail; b=t1mMaha9e/f+fPsGFH5T0JC2dqefuL06rTAjBLfoeoTYQFR8PppgByrMsxGTStcorcXFjl2rx0WQxGGXi28EYz2xriIht+uC5jGHQ0acJkrRuNARxtjz/sC+7MpyNB+mLLVhzPoXnZchJxM1FECApTSvIG0J95H23hwie3+u2BM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767132056; c=relaxed/simple;
	bh=oUGe9U3/dlWANXRe/TMjhEzdDQoYiMZwTQSVXr8tY34=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F9yQ+Djcg45SA+AYGBJu7LCuOmCJSeyGe5bU+epyX8b6S+7gI6TylT/+UrOkPJhPRVaezOAofAlZq43ul5oJzJ7kMm0ooKWZvY+zjfZcOTly47Exn6Vbvwdr9NP+ytA961EMXwcmQE2/URiK4G7kHgAl2XfUdzQaGnzJoj97DvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com; spf=pass smtp.mailfrom=duagon.com; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=bXa6CIi0; arc=fail smtp.client-ip=40.107.168.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="bXa6CIi0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B80PhEDbxD5lTthfFoZAIcaR0XJGK+HQHsEU6uLle1wqFeam9bo4b9ii3tcsUGbvY7A3SPmYMlwvRCsjFwndn+sI7FmRfEAydsKGPz9k3W8tRHRnZjx8eSEwN9UehHfzHRJVosnwOuqbKvtMLayqqsLegV7TU0TJMs0ySXCuA8xXrIkMTBVLH0Fa2/b/a2CmvbMkQot7T/V7qkZRqtLjeG8qt46F1d/rQlMciQ1Ig0ju3+EZqS5hC/o3mI8L6bOKD5W+EnSa3Q9qJbMMeRKYI60dgqvPme+FFGdhtRlO5BV12zb7kRVLIdjPfwAP0vJSQRVBW1jdzB7zxV8wPVtYBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUGe9U3/dlWANXRe/TMjhEzdDQoYiMZwTQSVXr8tY34=;
 b=AKC1aRnxIx1G9MiUE7pbX1tnaQxPoNyIu4B3br0g0SEjUaaFwGVn8sG3BHJrwxv7TU9Qow2SSpjBfOdTIhESJQbCYpl6nE3MYeHfppez+gXLrCPAwAKipl2SOxRIBhwTMJgVgZ9sFcqT4iJx0IwDzBTyJE5APDEa7hOannVrYNqflkm13+kRQnytW+BBJohNeLJFFBJJF2hyatIpUi41kux4E41YY/5c/apo5fybOVQfvpdamAR8Yy+4l96TJWBqL1uD52IUXm6QkWsnnnCJT9Nzu5qbm/bY7B+gecPT321bnHOwp9FxsyKGNSshR9CiAnyDGKwgvkKxgUrO4RhzGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.93.85.30) smtp.rcpttodomain=kernel.org smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUGe9U3/dlWANXRe/TMjhEzdDQoYiMZwTQSVXr8tY34=;
 b=bXa6CIi01173tcdHg3FhUxwThxVDDaL8wkpaYV4Dkl7QVEbrVAfH5lu7zkFD1MoMRsJzQi9WfUnttHe9dstzv23Cj8Pli7v2MmyiyyLD7Cd3D0aR/6dW2sIzGr7yuIxShp6rSFjGZ2DF+rRj+qQz5JM2rGIKnTqgWUWquscpfiY=
Received: from AS8P189CA0001.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:31f::10)
 by ZRAP278MB0029.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:13::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 30 Dec
 2025 22:00:49 +0000
Received: from AMS0EPF000001B3.eurprd05.prod.outlook.com
 (2603:10a6:20b:31f:cafe::33) by AS8P189CA0001.outlook.office365.com
 (2603:10a6:20b:31f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.14 via Frontend Transport; Tue,
 30 Dec 2025 22:00:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.93.85.30)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 40.93.85.30 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.93.85.30; helo=ZRZP278CU001.outbound.protection.outlook.com;
 pr=C
Received: from hz-deliver01.de.seppmail.cloud (162.55.72.219) by
 AMS0EPF000001B3.mail.protection.outlook.com (10.167.16.167) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4
 via Frontend Transport; Tue, 30 Dec 2025 22:00:49 +0000
Received: from hz-glue01.de.seppmail.cloud (unknown [10.11.0.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-deliver01.de.seppmail.cloud (Postfix) with ESMTPS id 4dgn8d0bNGz4wxW;
	Tue, 30 Dec 2025 23:00:49 +0100 (CET)
Received: from hz-glue01.de.seppmail.cloud (unknown [172.18.0.7])
	by hz-glue01.de.seppmail.cloud (Postfix) with SMTP id 4dgn8d0Gqkz1vdt;
	Tue, 30 Dec 2025 23:00:49 +0100 (CET)
X-SEPP-Suspect: cbf668a04d6e4e87bc1b47ac91ba58d7
Received: from hz-scan03.de.seppmail.cloud (unknown [10.11.0.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hz-glue05.de.seppmail.cloud (Postfix) with ESMTPS id 4dgn8c6mTFz1wLP;
	Tue, 30 Dec 2025 23:00:48 +0100 (CET)
Received: from hz-scan03 (localhost [127.0.0.1])
	by hz-scan03.de.seppmail.cloud (Postfix) with SMTP id 4dgn8c6955z2XGQ;
	Tue, 30 Dec 2025 23:00:48 +0100 (CET)
Received: from hz-m365gate03.de.seppmail.cloud (unknown [10.11.0.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-scan03.de.seppmail.cloud (Postfix) with ESMTPS;
	Tue, 30 Dec 2025 23:00:47 +0100 (CET)
Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazlp17011030.outbound.protection.outlook.com [40.93.85.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (not verified))
	by hz-m365gate03.de.seppmail.cloud (Postfix) with ESMTPS id 4dgn8Z5ZlDz1w4h;
	Tue, 30 Dec 2025 23:00:46 +0100 (CET)
Received: from AM0P190CA0015.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::25)
 by ZRZP278MB1940.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 30 Dec
 2025 22:00:43 +0000
Received: from AMS1EPF00000044.eurprd04.prod.outlook.com
 (2603:10a6:208:190:cafe::7b) by AM0P190CA0015.outlook.office365.com
 (2603:10a6:208:190::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.14 via Frontend Transport; Tue,
 30 Dec 2025 22:00:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.222.204)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.222.204 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.222.204; helo=de2-emailsignatures-cloud.codetwo.com; pr=C
Received: from de2-emailsignatures-cloud.codetwo.com (20.79.222.204) by
 AMS1EPF00000044.mail.protection.outlook.com (10.167.16.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Tue, 30 Dec 2025 22:00:43 +0000
Received: from ZRAP278CU002.outbound.protection.outlook.com (40.93.85.4) by de2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 30 Dec 2025 22:00:42 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:34::6) by
 ZR1P278MB1410.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:98::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.14; Tue, 30 Dec 2025 22:00:41 +0000
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::39da:49d1:7c23:953e]) by ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::39da:49d1:7c23:953e%7]) with mapi id 15.20.9478.004; Tue, 30 Dec 2025
 22:00:41 +0000
From: Javier Rodriguez <josejavier.rodriguez@duagon.com>
To: linux-kernel@vger.kernel.org
CC: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>,
	Jorge Sanjuan Garcia <dev-jorge.sanjuangarcia@duagon.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-serial@vger.kernel.org
Subject: [PATCH 4/5] 8250_men_mcb: drop unneeded MODULE_ALIAS
Date: Tue, 30 Dec 2025 22:59:27 +0100
Message-ID: <20251230215928.62258-5-josejavier.rodriguez@duagon.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230215928.62258-1-josejavier.rodriguez@duagon.com>
References: <20251230215928.62258-1-josejavier.rodriguez@duagon.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MA2P292CA0027.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::16)
 To ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:34::6)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZR0P278MB0523:EE_|ZR1P278MB1410:EE_|AMS1EPF00000044:EE_|ZRZP278MB1940:EE_|AMS0EPF000001B3:EE_|ZRAP278MB0029:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f5f7022-6d35-4535-c94a-08de47eee483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?8kRSXMyif6SPzLo+8FlONbFjSbroUUj8n8ftK61t03rd4Qm9Nl9Q3NITyzyS?=
 =?us-ascii?Q?2r/JefuyrMpVCFHXAEXZxEJBADsAeZeCexKAfLgj5X+YsDoHwmcucTLlvWQ5?=
 =?us-ascii?Q?ovX26UCIpk8CWsCMRpMG/e3UkuAKV+pC2+l5U1tT0v6gvYprwCVP7i68JxH0?=
 =?us-ascii?Q?wX+FIayYJ4dzGepJHrV+suQLUGGtXJ10n7Mzv03cMEMgBn4lm8sgIBDE0Kcj?=
 =?us-ascii?Q?qj335xOGPUtyHiL8/GF0DbiX6xaWcT0L1MjG84hQfXFTkAJ5kZ1xlQpW9LgV?=
 =?us-ascii?Q?IRJOcIHf33qHwFPo2LHTVmj/hiRR1RlQ0U2wvIezdL2OqcZIuLio3Aa6xDWV?=
 =?us-ascii?Q?58lqTBapor5phv17FoHsN+jbvhbYWOz1T3ct6rqwF9PA8sCMO/UOCuoIbns5?=
 =?us-ascii?Q?SyhAMmhEElgk6fBTgXLulnCCLSkku/YlRzpaA9Oj0WAwnHqrEwro6wzMmk5c?=
 =?us-ascii?Q?Y/IO2IoNWcOfZoUo+jYOTzrrLrz5dVZ7o4J5WbVDC3rD+gCzn6G7xlgX21eN?=
 =?us-ascii?Q?eUz7UKhmn1yLfml/4mnPpIUvjWoTYbWnLjO5j+1XNcdwnnN1c7Xv5Cw1VWi9?=
 =?us-ascii?Q?g+cGFzbfSA/yPrJe8YQFW0xFRgPqmmlDSGwon7pK5bkrOy94lOgpZ+I5ua/J?=
 =?us-ascii?Q?NfVnSNGBDBVl2T/YpkpicY+T6PTxEu6QjopmQId8J3Y+cEhE+WOCgpcz+x5B?=
 =?us-ascii?Q?IfTCgB4tItj82HsHbVZphaqMYLKjcIv35u/mmbWjYsiN/6Ozws9AcGnA4j50?=
 =?us-ascii?Q?s6V07aL8vnKl9f6Ldb4+sKiBUWkCUJuUwd+NIye/8DaYs10V1Q4oAHekI+e2?=
 =?us-ascii?Q?1maoVjUFp13Fu0MY/IrTlMWpYaSqSRjTGcIU8YbVERPNzWHeVfGGapUAUPyE?=
 =?us-ascii?Q?Y6FH98bK11rOC77dwoIeiZSO0OKTBGR1FTJtMOwN02KCMxg/sM6HGSl8flhU?=
 =?us-ascii?Q?fFvqQyKfS8Es2v3zGE5+Cts17XRvTmz3sj8WnOwc5gaPALaIRBnAVrp5mr5D?=
 =?us-ascii?Q?RCmLMIjsgfRUOM1vg7MReHaz34xP/ixcUz4KSvEiCiGH7JqYPwi7VqZH/eTr?=
 =?us-ascii?Q?LbADWsvhLPejbRH6xRH0ifOi8ucv17XK4SSmCbEHLQ8+eqJHYaS2nLDEOyaZ?=
 =?us-ascii?Q?cIV7sUg0VvTDIyTa0pRT+exqnuvcJJ3s7+aQMd+BvDcptWhNfg++ofWlQx00?=
 =?us-ascii?Q?Bp/4XLnAqweLW/1ncRyLVKkdlOPtL5GVWf9ARWCUdtDjgtHuCc6LSz1xO8SZ?=
 =?us-ascii?Q?NubiWK6Be1TZxUkNsvTThROMCQeyNmgG5QV+tYwCTGChILDOx09uvLO7Couh?=
 =?us-ascii?Q?yfrT5VN8Cn1CLnFu7Dp9C9dZRJ3NRsDOw+RNCBBIRC+2RtiL3m8JMvmQPVN1?=
 =?us-ascii?Q?7Z5a5M6UKEG30PDvJagGHHXARJuKBfcJ/e+As5jLYAHWLZkpGljtI8P8eq0U?=
 =?us-ascii?Q?zkI6xAKvAhORqtKOAdgLjZEaTqvh5+6XKBN5z+grA7wgewP1pWTcw7dUYMYM?=
 =?us-ascii?Q?QL5ymCtZ+09cVOM5CnHCW9h3ixznKpHKva8J?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1410
X-CodeTwo-MessageID: 4599358d-cb82-4c3c-abcb-6835ad1cc13c.20251230220042@de2-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000044.eurprd04.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 7d19b0f7-1387-413a-8b00-08de47eedfab
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|14060799003|1800799024|82310400026|376014|36860700013|35042699022;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?jgxEU53/ULrGOGC09wR+9EnCY90R1EwFaUXQRHvGUvtyYtI87Fe5aySPRHkq?=
 =?us-ascii?Q?SmkQrg5/5VOqUcxYR+yXAa7TcQQYwlATi+YBO0h3ZidC/pO7+g17IHbHoCD2?=
 =?us-ascii?Q?2oGya7LKlDIi/Lob4VrINXglzg1v906utbUKj9iKdUKcXZ5cfcTPNmnGTNpz?=
 =?us-ascii?Q?wzfwGqjVnQwGaZ7+QcLexululOodscNO9On8c5N2JhXVjr/JGG8ek0dlHc79?=
 =?us-ascii?Q?1+hEE9VUvtXg9DHXrWLc6cG086NfFrAl/53hwO766NUu9q5y9MYogmSwy4ov?=
 =?us-ascii?Q?6V43hWasz2mU2J1zJ7E3u4BrvOy2AWmgYiFFaUsfVhIWxngbhkpwl6ljk/8b?=
 =?us-ascii?Q?vNrr/vtgcGwialh95Yd+bP1djPUD3DYD2j5Gng5ejzW81nFJC8r/QR1LzCsr?=
 =?us-ascii?Q?w7o4neUO5LBvRALK0kKNU+RNXshfMb1eAVAnTpYTFrwndAehqpDnNTY3ayh5?=
 =?us-ascii?Q?v+fd71S1VY4hh+xgrnEXa1EQ6hy5PZFbBx+4XxeAejnJaMJt/YcTCd7bDDKL?=
 =?us-ascii?Q?aVUzdo8c5PtPh4jIeWilZB8fjmkoY4+DykC0yOqGYpnWJn1nG4F5JuWFVJ2S?=
 =?us-ascii?Q?L6PADsitgmHMmyogScKqUsY8vB2TTYrZ07afBJ4QBgzawqKzF412ylTvEGge?=
 =?us-ascii?Q?MZ8Pk6xN65F7F/VPMWPg78RBTMZXvbspKUW97hLWxHeB+FeZlOHQsj0SWsBh?=
 =?us-ascii?Q?01LPRsSK+J0CJODGkFGGXlOFq1GUqoEARx1uQM7209R92uN5nD+hl5sMK9Rb?=
 =?us-ascii?Q?T05SGKkocR+UYT5GRsgbXaJ1RoAiDH6ee0jEk+XQiPG/jW2bpHNvzuFaj9O7?=
 =?us-ascii?Q?ZQXhauf9jDRkTAKutfdq2PBEah+JdpHUfhN2AXqiv92kqCXajfZDn6Ze1LSB?=
 =?us-ascii?Q?yK1o1zRVQH2aB8U4Ma0K05SE9AbxmVQfjBQ4Q1arOijPRQ8pz6yLylq/AbsZ?=
 =?us-ascii?Q?ptVI4kF0bJZKVZoCPTN/DVpu4kKoe3CIxMk4nFENyzoH9Sa40iG5hGAr6zK/?=
 =?us-ascii?Q?++PTOii/SlA7dGJNs0ewadnNfnIGB/hPvjX20GWW9/S9RJH0nGuU1kdg3q2K?=
 =?us-ascii?Q?6RJIE7PuDbas0EudSZUGs21vOo+Yr/3uT60wb3XrPx5yt847KQQURDwLTCsb?=
 =?us-ascii?Q?wBZ2/vDkvzw5ll5Iqoj/E7zlARkVCHuXQXNNzxKrU49dwUT92pZWzMsqprZ0?=
 =?us-ascii?Q?bg9rJ0BFutr9Sx8i7d6XB+4aGTv3fr2a2APGqNE0f2ODk0cZReHbt5lcXykZ?=
 =?us-ascii?Q?mvoS/cYP4d2BdTJdvsw9BEZKFW7KSJMICoxoVLVb/VewHFapexCCM9Z+Odil?=
 =?us-ascii?Q?54Wqgu1Pb4KeIh0e76z/TnDOwvC4QEQXhnmcDQVDBSMhj2C31hYTW/gMtWxO?=
 =?us-ascii?Q?ysamj1zfxIUOPuoISrpCTlkTLZwVvfXdd5h6PWigKBgP+rG3G73r2bEGqLwJ?=
 =?us-ascii?Q?6uIVNnrnP+8bnC13MkQJ/hPIbOS8Rheh/TED6aDeYXAqwQTE+tUxj5jUuw1y?=
 =?us-ascii?Q?xXHQzmhMt35KiCLMIYlNIuZCNMmoAvf3w1/BvBhD03O+y/4b//+4ncHWBZvR?=
 =?us-ascii?Q?6z1SkiH+R5ifgLjhjVM=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:20.79.222.204;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de2-emailsignatures-cloud.codetwo.com;PTR:de2-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(82310400026)(376014)(36860700013)(35042699022);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRZP278MB1940
X-SEPP-CCCVersion: 2025-12-11T08:12:51+01:00 9ed91da2
X-MS-Exchange-SkipListedInternetSender:
 ip=[40.93.85.30];domain=ZRZP278CU001.outbound.protection.outlook.com
X-MS-Exchange-ExternalOriginalInternetSender:
 ip=[40.93.85.30];domain=ZRZP278CU001.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B3.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d3958df5-2fd1-4b4b-1901-08de47eee118
X-SM-ruleversion: 2.1.0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|156008|376014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Aw8NSzJwdiCqR+1KXL1iS4IE8imwoPbnGmzVxc/suWzPDDUW9RuAtOLnuj8K?=
 =?us-ascii?Q?+7eD2n1CRmvjXLZJJIstHX80NGMz8nEbouny+fYi5qXL15NyoTjZPvOn929y?=
 =?us-ascii?Q?ydM0QdaXNW9e/vJykMbbcAxwyG0Q/tAytmviOAA4X4nbjRGnpQGQHxyK7IEz?=
 =?us-ascii?Q?GOuStUyUdJi0eum/32dq5sp6VVK/IGr9Uoc7HhreIQs/d54+omXn7rX8vyRt?=
 =?us-ascii?Q?PcurCIZq0CTxWwJ+iAF1h+8XgVOgFOxFeJArl00dLMHNvUfk2XUHy+mim5rH?=
 =?us-ascii?Q?EP3hT95ece8JInF6GnrSFeXu/hscsmDDlsG+nZTFahUdLRfv8xIeGCiGS3vK?=
 =?us-ascii?Q?8tZTN9jtwDQw+GJf02IW3r6quy+5TdHk8fXo9fnT2YMROmbpJOsiRIFj1Ebw?=
 =?us-ascii?Q?fGWhGZFHZ1uslufavuYDNEF6HVHFiWgc1wvW7TToCnj5E/dG/1baNPVPd/vm?=
 =?us-ascii?Q?9ldW57yMwecAa4bfEMbQocse8uki2Uz47gaZuzTdg21/WA9zqptrKfdOWixY?=
 =?us-ascii?Q?WCCN65yikV0fl0MfNth0MoRdLqZwuNy9IKfHRkjviAWXWt6gn7AMek4gZw8J?=
 =?us-ascii?Q?RGIg4KcfZKI82Rz7jvl7ys+5pP6oy7aeWuUvt9qsWks2EdHoYKm7bCdzsjDf?=
 =?us-ascii?Q?ejgg28qsYr1VnmxEtiFRALdRdiVx8AaWRCuKt/QnlTfwen0/YGlswk1PD+nE?=
 =?us-ascii?Q?zMuCMYh7akVVA4gAYwouBir9Gk6Szfh7rVBt3bYLq/6ikjQasUDKaf+wMYXX?=
 =?us-ascii?Q?WqbABkTIwp6fN300uwCOqKr+LaMGIc4C9lqJOSBrO/JYzl494qNNBEIwx05/?=
 =?us-ascii?Q?7FrJxQH0YkGhAJkOHwvBrqrZFvHIc3p+cyXz6FAxjqkNSWfNsXc/A5rEPx2n?=
 =?us-ascii?Q?ZGdft+7AVURmdmgYSGw9WNHoKMAnkgIiT5GY/u/Jo3IiSU6fK0ZtXS6WPPE5?=
 =?us-ascii?Q?R71c4TFIXbKfN/SgWcUt+jTrDkfEYNlflBN4Jpq+7m8qGZJZWqyn1XhKC7t0?=
 =?us-ascii?Q?bvF1as3JPaeufIabwFVs7IntSVVj0yf3faN+tztgLhHKASL+C01Ge+V2ba6s?=
 =?us-ascii?Q?u3rQAZJ2YWky4RA8uo5ElXkxKCWcU71w7THm8n7EFUdljzIzqGtsCWtpVlvV?=
 =?us-ascii?Q?OTcoLhJrlJ1B?=
X-Forefront-Antispam-Report:
	CIP:162.55.72.219;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRZP278CU001.outbound.protection.outlook.com;PTR:mail-switzerlandnorthazlp17011030.outbound.protection.outlook.com;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(156008)(376014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 22:00:49.4016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5f7022-6d35-4535-c94a-08de47eee483
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[162.55.72.219];Helo=[hz-deliver01.de.seppmail.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0029

From: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>

The MODULE_ALIAS() is redundant since the module alias is now
automatically generated from the MODULE_DEVICE_TABLE().

Remove the explicit alias.

No functional change intended.

Fixes: 1f4ea4838b13 ("mcb: Add missing modpost build support")
Reviewed-by: Jorge Sanjuan Garcia <dev-jorge.sanjuangarcia@duagon.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@dua=
gon.com>
---
 drivers/tty/serial/8250/8250_men_mcb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_men_mcb.c b/drivers/tty/serial/82=
50/8250_men_mcb.c
index a78ef35c8187..9774a95f2980 100644
--- a/drivers/tty/serial/8250/8250_men_mcb.c
+++ b/drivers/tty/serial/8250/8250_men_mcb.c
@@ -268,7 +268,4 @@ module_mcb_driver(mcb_driver);
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("MEN 8250 UART driver");
 MODULE_AUTHOR("Michael Moese <michael.moese@men.de");
-MODULE_ALIAS("mcb:16z125");
-MODULE_ALIAS("mcb:16z025");
-MODULE_ALIAS("mcb:16z057");
 MODULE_IMPORT_NS("MCB");
--=20
2.52.0
