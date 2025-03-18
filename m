Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2106.outbound.protection.outlook.com [40.107.21.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4E919B3EE;
	Tue, 18 Mar 2025 09:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291183; cv=fail; b=TewnlLtr0c4gLmuqGZ51tq1RM/LP/7sdzU+B8BCh2KgmnGpcbwou5209pr6WsNvH7udwM72m0lLjLwIEfgL3Teg0f+tMnD1EDm7/oE5pRNtSXH7CRBOu3g8ir9eAD66oZu46m2jc2qWKfQeXw/KE3USw+0lQ4CTGrp1WM9HBz34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291183; c=relaxed/simple;
	bh=tZt08UaNlg5MvVJoVrEGARVAfd2Qfzb4uZZoly465KU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UJ2dmwVWDQlofbICWVBO7vRvoWPIh/HBn442osRveBUCL6cYwhW749rpDijybR9m/j0G2ue/xkOiBkRtg/6NJ0fgS3Q3x3HwBfYtlHTIXjToNTIXRPmj2o5pBXdQDIpJg6pxs9BQOWQbvFRV7B95HalT/dr+deCSsdlTWdky5AM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl; spf=pass smtp.mailfrom=sttls.nl; dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b=KsArQU+i; arc=fail smtp.client-ip=40.107.21.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sttls.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b="KsArQU+i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMhSPPWo4ThSMoOM8Hym08CzIpV452aHOj8DF5lVvB7ARSwaandIKkxrKcQcp89+rpjxXG90Esk6u8PXpdetii4sLxWG9YBHpLkF66XdpO0UAArY3yPDnveMY1Tl4e5NyLJZUyQYynwJ7nacacnyNH9QN23nNhMzbEK5Jt+xcjycb6vCuc86wqtpHl31iETHriyYEy+HoURFUCwzpRFfz2wOiDcW684YscMMcbMaCLvP6PuvnX8jCAK83SpBXscZ2h2P1fak/rywXb7Em/Watn0KPcoAtUIenVovqYajur5zmcGLNHZO2xpbP84iGRejZGupn1o/Gbs31Hpo59XoFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1k8JgJmqdWvFthUxhmZ85u+9m6ty564dDkSu+mPiMG8=;
 b=tXVpmME71r87zk83ERUOU+w4h6husC+8x2G9YfrRey8dZJS49xyByoVmWNVaUsNvuCAUXDIPRqoCp90PyTOryjL91cDPXLjZ8ddAJWHo/dJ2Hg9S8sGgaYLeyG/44aafroppZoBk/TEbK1CI8uKJ9RwBmV9nd0IDA1ZzrwScAPb4tZ0neJQP1hnrOvoEP1/zPBalWbYJbHdaFSVcTvOE0nKOpJtlA+F+lzQqKvyBM3h1eZbxhobgZKEcrpOZX8wfldvNSa1woErbJ6oGMwQzhfGKGmHfbBI59y1eAt556OLjy1CoxFmFRdP6KWubu3+UDPFs978SNsjHtoGM0T2EAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=sttls.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sttls.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1k8JgJmqdWvFthUxhmZ85u+9m6ty564dDkSu+mPiMG8=;
 b=KsArQU+igRmHS6Jn9f3ZecYrw6r/mUFD+qAs43gcfnIvDBcWNtxgzCwQOSDXqsNv2jDyK5VA/aigYC4Ba7Jv4NPUmHIoYucbCRo8P19FKDdOq4ux8QagsorxpPmccuQDkQ/cqdPyfjZ2yYcxsFYhU1mZIMAnGYHyTjx5dYZRxqn3nIqJXyVOHdUYy+8lDVqqvbRTTmgBvLDqbm8lPNFfEeDJoearhr8hR3WUtWcEgsLoXzediCXChGnB347BrlUBhyndMLRHW0vPxch4VPax5m/UhJ831JkI9l7ey7JhD0BPcs41OvPra+WdLQdU0/OHd0V1n6tTU8h1cXbd2dFyNg==
Received: from DB8PR03CA0031.eurprd03.prod.outlook.com (2603:10a6:10:be::44)
 by AM0PR05MB6817.eurprd05.prod.outlook.com (2603:10a6:20b:153::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 09:46:17 +0000
Received: from DB3PEPF0000885C.eurprd02.prod.outlook.com
 (2603:10a6:10:be:cafe::6a) by DB8PR03CA0031.outlook.office365.com
 (2603:10a6:10:be::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Tue,
 18 Mar 2025 09:46:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB3PEPF0000885C.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 09:46:16 +0000
Received: from AS8PR03CU001.outbound.protection.outlook.com (40.93.65.51) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 18 Mar 2025 09:46:15 +0000
Received: from AS8PR05MB9810.eurprd05.prod.outlook.com (2603:10a6:20b:5c2::16)
 by PR3PR05MB7178.eurprd05.prod.outlook.com (2603:10a6:102:8b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 09:46:14 +0000
Received: from AS8PR05MB9810.eurprd05.prod.outlook.com
 ([fe80::841e:3b57:8c60:5734]) by AS8PR05MB9810.eurprd05.prod.outlook.com
 ([fe80::841e:3b57:8c60:5734%7]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 09:46:14 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Greg KH <gregkh@linuxfoundation.org>, Elodie Decerle
	<elodie.decerle@nokia.com>
CC: "jacmet@sunsite.dk" <jacmet@sunsite.dk>, "jirislaby@kernel.org"
	<jirislaby@kernel.org>, "jakub.lewalski@nokia.com"
	<jakub.lewalski@nokia.com>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tty: serial: uartlite: ensure uart driver is registered
Thread-Topic: [PATCH] tty: serial: uartlite: ensure uart driver is registered
Thread-Index: AQHblFrIJWe/DpTEvU+ZlqXLItyCLLNyHTcAgAUZLjA=
Date: Tue, 18 Mar 2025 09:46:14 +0000
Message-ID: <AS8PR05MB9810A677E1036D59D23448EE83DF2@AS8PR05MB9810.eurprd05.prod.outlook.com>
References: <20250313205852.2870-1-elodie.decerle@nokia.com>
 <2025031424-clay-ashamed-f0bf@gregkh>
In-Reply-To: <2025031424-clay-ashamed-f0bf@gregkh>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic:
	AS8PR05MB9810:EE_|PR3PR05MB7178:EE_|DB3PEPF0000885C:EE_|AM0PR05MB6817:EE_
X-MS-Office365-Filtering-Correlation-Id: d983ecc6-94fe-48e8-7175-08dd6601ba74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?PEskVGRPyLHCC4KqtixcTLBkCfV0/T1eJM1ViN2O3Donh95yO+N0+WkL2s?=
 =?iso-8859-1?Q?Lrw08QEhBzpIltUf18YANdXlMcZI2CcVNs1haDEH7TTfQ8Ib8nDNfsZu1Q?=
 =?iso-8859-1?Q?s0NEEet4fvqC8EdMa6+i8M62EbgV4tq6rTBKDNjoR0yH0NrR49DJFz22O7?=
 =?iso-8859-1?Q?YYQj6Pd+X7o/HPupWgJHIm11UZeVfmvtlfU5pE9MFDDniWbmk/0QyscOMg?=
 =?iso-8859-1?Q?8pljpEH13CI25CqtV++sMaN25zXXKDeiNiTolvGbnMIZz0/wzN4rtQP4o9?=
 =?iso-8859-1?Q?jnGKQyNrnRZqhDRDJvoMeDHQ8ZusgSWZPfocvHIvxYvqSOqujkjg4+67eo?=
 =?iso-8859-1?Q?/FgieTUQxVWcrlEJ8HmFy4Ky/sdzaChOhLeFQ8uRSpvstcsNwq03OnzRA+?=
 =?iso-8859-1?Q?d19xw+BFOb6h/4OUnu+7kv7O9cwspUignMs7oY6mT2qnwrJRQGQ7esOO6z?=
 =?iso-8859-1?Q?AxeZZfcfOCReCbzwXpx+bvbLgwgbx5mZ+kucDX/Bm53zAr1nXINsQyYt/r?=
 =?iso-8859-1?Q?+PpUDh5Uc+9SPk5vljahxM6//1CybuoCwSajvGVlWaQMGlztdvflm6hFqc?=
 =?iso-8859-1?Q?0/dLlkw66yBDnWNaMpiMSBCUoMF4jh5Cj36w0zPRQwCZXJY/tElirvaxvJ?=
 =?iso-8859-1?Q?idni39Opra4ZuW2cmf+WTDy6zlqtN51QWp/riI4z9ze++pfWYywDvIFsuj?=
 =?iso-8859-1?Q?OdgelKZtQYv8I7A4XwtrcwmWK30BJ34+V9x15GktBfy//1rO9T2Gpa8lRI?=
 =?iso-8859-1?Q?Aupi7Ovpy+csPCZZwQs0Y75cL588DwWLLPndAK0HgWRqwCZcQMd8XDS/3o?=
 =?iso-8859-1?Q?1ChsR92CkKuHJ3fOZi+0Ns0Ih/dAy+P+UQPBEQyxapeFrC/Yha+/Kr2sb+?=
 =?iso-8859-1?Q?GvIPhyI4/uhMCtPO1rgakor2gcPaPxGG5zescFZkkzE9Yme+tvfNApRcIr?=
 =?iso-8859-1?Q?Cb2zWhX8/AlxlPELQmpzvCJlbFYD683NzBNnUP0+UYGMxRMGP9zozrun/r?=
 =?iso-8859-1?Q?/O+mOsveguZzjQJri8zz2hdPAcPUcqBIOq/80quUVE7CcK9kmZJhfIlLYt?=
 =?iso-8859-1?Q?wrEcq/e4YFhvSD+4TtZyViNUsVQEgDtZTUuiWK2ycF+TuOutnNkvRZFims?=
 =?iso-8859-1?Q?1cqCVKjrsHIJfM5xyLvsIiXRKVTHu5tJqLuKcUykf70lYNdgpiss+/7gHY?=
 =?iso-8859-1?Q?YiRMICT9pC5URgAHjO9GTAsF51ixyGyWi7oDay5+bkM5jJsd2ElA52yWr9?=
 =?iso-8859-1?Q?gx0EFGYzVx1XfSE8+1VwghLp4Ri74BSZaiZW4/0S1mwLeJCP8q9orV8P68?=
 =?iso-8859-1?Q?he1xhtc8wfeRXblQYVci48LMq+2BFGUUdwkrWdXw/XrzTChgBE/64Zj29P?=
 =?iso-8859-1?Q?dszTcDop6dU/835WhItQ/dwMattXFofhM9frfs689n1h1s+/88G+KNSMTb?=
 =?iso-8859-1?Q?A30Gvo9YI5X4phcDoYnpYYx2UcVzjLAp24Papne7rYPiA03gZzockHeOAh?=
 =?iso-8859-1?Q?U/sAwslAcfbfCpsXiJDc7H?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB9810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR05MB7178
X-CodeTwo-MessageID: 0c95eb15-d1e0-42da-9965-0d259ffcc0cb.20250318094615@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885C.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4fddb6aa-219f-4ed4-33ad-08dd6601b8fc
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|1800799024|36860700013|14060799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?ENiaVR+2JCTvKJUFnaZNQVCYddMDkFtISNLkBqoiY5XJInFMj7Lc+1TBvQ?=
 =?iso-8859-1?Q?KSpNzYrSkJB5sAnM+8fbTQ/RViXR3hJdc+YoPzftpKc5quDyUsFZalxDb9?=
 =?iso-8859-1?Q?c8BARWbNEXw7wBOcX2Tq2MUbfFiuRlkILerTLzdEdfQdDbTintGXWxKcq+?=
 =?iso-8859-1?Q?vkhdOUfPgGIKs83ljq9anXZQlKu+hiN2MIvbNxkHgttGm/iy9ZTq9eo6ou?=
 =?iso-8859-1?Q?UromSYZpQ22crGQW0440uG/MYUM96LT1UEivxa0VFL2963PpfMyYz+1Ya6?=
 =?iso-8859-1?Q?Md8G4rPgrBaZQ+/L5pGVStf2eTFOEGg5Twu6LmUK8DmgLbeT6KWO67Ih3a?=
 =?iso-8859-1?Q?7T1YrajPNSW8XNIdSg+goc8FWWeGRuI09pD4APxCSAiRHsSqLlFuuausWV?=
 =?iso-8859-1?Q?7Wty4SmwZA6jQhnJNKgzDQop6YcOa0gGYZ+S2bsTVnVwGcA95u7menh25X?=
 =?iso-8859-1?Q?TGA29nWNw7ADDHFVxizjtYw46LrPz69869Dn2MrXAYzSgJrzaqsaRgbBMU?=
 =?iso-8859-1?Q?pe8gIjcCPADyJW2uwwJ79QJEVlw8hlTbMlxx5ntUt+KS7En/Pq4Eel4rJ9?=
 =?iso-8859-1?Q?AGQ1X7ZTSop8MJRGnkOQEVdItn5M+tpANnZlxUzAvAQbsd3xNNiCmPjwxp?=
 =?iso-8859-1?Q?uuohB9WqQE1NFHD9QH67rt/gbAKNvUtsAlH8+Jc42DQMDadeE31bZS1Z5B?=
 =?iso-8859-1?Q?UzzPaacS+QAor+/2LmujoUrQj0brr5YjDj/KTz0lh57Pn7WqkYp3Vjn5+o?=
 =?iso-8859-1?Q?0t/uE44q+f8EsusVfO+4UmRd2Tm5r5UZWGLTOjdzLkBeTid+1o6Nkm+jSw?=
 =?iso-8859-1?Q?R1lhVBSBcDxhAEwQhv+WY+rLWMYSanjTyLZlr2gjG6cSn9lBUtDB5998sg?=
 =?iso-8859-1?Q?fM6HCT5t4WnBZ3IC3uPqFtdvMhWtZdK7ybGtPi8WX5UuwOVmb+7ScTJdhS?=
 =?iso-8859-1?Q?Qjg8otG40Td9kMEbbotURwrgda7PNbdXcZyRVllfhdkIHMBSrIexfif9lM?=
 =?iso-8859-1?Q?8eiZaQHLi4zwPO69x1vZfI9V1O2lMWrUVPygABLUC3Ltrp08bIcUW7NDSN?=
 =?iso-8859-1?Q?hDSgStemmJY9C9VlajlYOzxt/3tVVS1VZBvL4eoItJzP/egNX4tysoqIfv?=
 =?iso-8859-1?Q?pBePtBQkyB/xcNFQorUYZfDXLrDxsGVZDFmv5S/bm3Gi5uEYiqGXcJQjGF?=
 =?iso-8859-1?Q?h+zu+FMn5RJgkP7CXgn/PfgaCzRM1WBw34YHByU8plgt1JIRCEOdcDizNY?=
 =?iso-8859-1?Q?VtXlH/UtDzyCKyqMX3DvF7eiBNhm4sIQjtKyieOyQjrnqWVNj98eXfaC+L?=
 =?iso-8859-1?Q?K+fqK66BfkngqKPEmbiUDnBwatn6Cph2zt1iYCrccSaowysVbkEkumPE5l?=
 =?iso-8859-1?Q?uqc21rsFuxCXn2YPfvwlb6HlOwF5U4UcbxzqUJYcGDuVf8CTUrWH52CiXX?=
 =?iso-8859-1?Q?oc3cfMWHL9zhXudsfzRgGUNp+/O7MPLcv/fxoIw1rTGBaLCNVcqzw2Dgcs?=
 =?iso-8859-1?Q?k0xiHFqQdedbzA6KgWPtxyLRoeyRjGmDQcWGJg3KLZ1/6j34Gdttu6aAkf?=
 =?iso-8859-1?Q?ojVtcA4=3D?=
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(1800799024)(36860700013)(14060799003)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 09:46:16.4266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d983ecc6-94fe-48e8-7175-08dd6601ba74
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6817

Hi,=0A=
=0A=
> > When two instances of uart devices are probing, a concurrency race can=
=0A=
> > occur.=0A=
> >=0A=
> > Adding a mutex lock around the uart_register_driver call in the probe=
=0A=
> > function prevents this race condition and ensures that the uart driver=
=0A=
> > structure is fully initialized and registered before it is used.=0A=
> =0A=
> So the problem that there is a single "state" for the driver as a whole.=
=0A=
> That should be fixed up to be local to each individual device that is=0A=
> added to the system.  Don't add a lock to paper over this as odds are=0A=
> this is not the only place that will have problems.=0A=
> =0A=
> Are you just now having 2 of these devices in your system at the same=0A=
> time?=0A=
=0A=
In the past I have created a Zynq 7000 based system (dual core ARM) with=0A=
11 uartlites and I have not seen this problem. This was with a 5.10 kernel.=
=0A=
=0A=
Maarten=
