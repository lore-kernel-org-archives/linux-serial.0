Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.85.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBD81DA21
	for <linux-serial@vger.kernel.org>; Thu,  8 Aug 2024 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132667; cv=none; b=DagcWvnDaXBpvmlMB5AZJRMsY6iYW4XWICovdlHtB2ZMsRDgWTlEXFu2+8O8/UZDmAyQw6bdkkau6BNQy6lEsbKOc3FkvxTC1MEt8M5P+4aMaSSj+HSoFsWUUWF/Extr46InGQC/JRWvkX+EHmvKg/0IvAlLNumpuvWQLaJEenk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132667; c=relaxed/simple;
	bh=GVi7K7H1Rr8AxY+eGtaR5qvYQ8R4RmPpxSo4GsEnlps=;
	h=Message-ID:Date:From:Subject:To:CC:MIME-Version:Content-Type; b=ETdWZIx/IUYIBF1YhmvWd9cJNj/wGJLJ1IYzWSE+3zoIoXvxOR96143hgJQa0yRfy9gKinQNWra7grfgR9YJ1+ewgsaJTsKDS6BYV74a1YnsJzIqHoGRluWQdqXPepO5GjaP5djMAPGJh7tAoQJwnvjl+y7PsHtzH5J9cnHE5C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com; spf=pass smtp.mailfrom=camlingroup.com; dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b=Fp4Jx/db; arc=none smtp.client-ip=185.58.85.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b="Fp4Jx/db"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
	s=mimecast20210310; t=1723132663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1EfL++nfVws65aGQJGh5/3drEslJWFloKLJjDeyU85E=;
	b=Fp4Jx/db1TpYuhhN2B3cVLEHdTQ42a35oG17wwh5bsdBm0ziLM9ib6ZMHOU78U1TEqAIri
	ORxHb+vTLFCkQcSLnf5u/+fTZsRtp3GaaFx2w9ADSUUveUyw4Epeg7Xwy/1EcXoPoAKzTt
	CIAoYRw4d0dtj07mQhxpABQDfOdsLEI=
Received: from GBR01-LO4-obe.outbound.protection.outlook.com
 (mail-lo4gbr01lp2105.outbound.protection.outlook.com [104.47.85.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-104--Klr_J2mN3abhW_6I8lKcQ-1; Thu, 08 Aug 2024 16:57:42 +0100
X-MC-Unique: -Klr_J2mN3abhW_6I8lKcQ-1
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:142::9)
 by LOYP123MB2816.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Thu, 8 Aug
 2024 15:57:40 +0000
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f866:62f9:716e:ca4f]) by CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f866:62f9:716e:ca4f%6]) with mapi id 15.20.7849.014; Thu, 8 Aug 2024
 15:57:40 +0000
Message-ID: <6bfb7abc-0264-440d-b0d6-6dd6a8b64b5e@camlingroup.com>
Date: Thu, 8 Aug 2024 17:57:38 +0200
User-Agent: Mozilla Thunderbird
From: Lech Perczak <lech.perczak@camlingroup.com>
Subject: [PATCH 0/2] serial: sc16is7xx: cosmetic cleanup
To: linux-serial@vger.kernel.org, linux-serial@vger.kernel.org
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Andy Shevchenko <andy@kernel.org>
X-ClientProxiedBy: BE1P281CA0327.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:87::6) To CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:142::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB5267:EE_|LOYP123MB2816:EE_
X-MS-Office365-Filtering-Correlation-Id: dd9f3c88-0cd9-4511-9b2b-08dcb7c2d4ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0/O3g5fpldcpR9D6yljYmsQPJWuGG7kb8hdLxw/iSwDp61+5V5JEndxped+M?=
 =?us-ascii?Q?gJFGnrOihiTOyJ1Q3B1y9SiL9szS8MZrMiNuEBfEloTiny4yaZQxUTdB6FAm?=
 =?us-ascii?Q?VF9hytSQqjcUX0morq1Y53278h2jkQQAu6fZAyU9lmYER2DPWdegcl+b7uxS?=
 =?us-ascii?Q?9OSWrL/rLCD987q1HK73AeuOXBb2SfmCrQiRdjx505SxksY/KijN79P3ic36?=
 =?us-ascii?Q?mHDt+dcGyGv9uXZrcSiJF/SKtXPIGt3BFVUTPuf079ktjQYyI1Mqtp17VIOT?=
 =?us-ascii?Q?ygBVTyVyvjCJQgOezbEP3hO9cmTXiNIIoi4/eJpko9K0kzM0wxy8gwBmfuEZ?=
 =?us-ascii?Q?XHGjOy+S2Qfarj5zbUgQ+7VL5tCDlVRP6sFR/jpXsUnqRpIro+rbQLtlV0f2?=
 =?us-ascii?Q?isbJ5mdOArcivMPuGl0lXNb2MT9H+DQRQMv2DgEBqcTAahbaRTzl6wPBD/U5?=
 =?us-ascii?Q?u38/DAMVrQSloCgXZPS2qBeX8+Oqlk4aXJSLcGs5M2PrXSmgiWAKrsBFMmNW?=
 =?us-ascii?Q?lPPps0yEs+eJnAYoAMck6DL7LtSWVmd2c7tssEuM83+M+1rIJ2FkHwNO16NI?=
 =?us-ascii?Q?RWcCVQQhNh93SOSpODVGF8imkvamACzhKBxV2n6Wum477fMzpgxx2Prjr1Q5?=
 =?us-ascii?Q?LBjmnIqFfnnJnTs2nLGyJmVqON6ave9peverHYLogfM0toK4KPuGP0nk8wLu?=
 =?us-ascii?Q?fEXcL1Sq7z/S735gul0jyNuoQwdta3ZgJcNK54jnboVXLTpRlB3Cq3i80kmk?=
 =?us-ascii?Q?OJYWDw00+jVfq+w6tPy0kHbDqWjO21KaBiRxe+lRx45HW7WE1xxvaww6PUJ8?=
 =?us-ascii?Q?st2dnQSafnCDaOIvh4JunW8AFXuIHtMEiGpn9EhksZESoEHz8wR76Po0MyiK?=
 =?us-ascii?Q?X0U2QzTVC0OE3v8cwel3EXXfuijrLhrQ6xJ3z85SBRxJrOjBHOBoKrW/Vryp?=
 =?us-ascii?Q?DiPaBkAU4UbZ2YkzYZnYwyT3f1fR4cLjnBHiPdrYILqTaoRZ+B0F10VHE7At?=
 =?us-ascii?Q?wcrn0MKz6ALRw9uQapge0QQLr39q+9h+DVFegUEgFHZbDtQ4Mopqx0HXhwVx?=
 =?us-ascii?Q?I8Lqq2mZGzMpN8XI2AL1rDBTqxoXbHUelHrKwL67ppzKzVLJdeaNYXrabgxH?=
 =?us-ascii?Q?IwIKK+9Nx1JVQg54u+k9WwwSa/SrOZsP+1+ZjKGhUR3cZ7xV2+DB4PPARr4D?=
 =?us-ascii?Q?2W7EhEwwpCjfvRjOGUqoXQBBI1KR69K3RjxcAoCSZpXOa5/+ky5Mtkg4R485?=
 =?us-ascii?Q?qCm3cDAZBQxlss5rXrz+zV1F3hQLM9zZpMTQU2lACtGtSsbBHF27rxYb61OC?=
 =?us-ascii?Q?ED9w+S2Lax3XeASY0B9NiVu8lsAZ/4EFoY+8TOFev3znyg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pCP0rJK7kBtzAQ8+nPB4LWRrJ9CNOWk4oMNSDQ6UMkSSFKPzMo45NgmmldrK?=
 =?us-ascii?Q?QIbGZ1YOedEu5bpaKQWCwL8f9BM9e0JGxIptDVBM9fuPpZN4HpdPeQxqc6hZ?=
 =?us-ascii?Q?uvkvAtu9MCM+hqMjS2ZGs0XbWt7phV2M5USZWS+PZp7cuSLs0pXGNXx/RSMG?=
 =?us-ascii?Q?clmVkEdktSEIzaJq2K69rjnOCxP5uewqkG6XsU+33lidS8C1zKWkJhFylhrf?=
 =?us-ascii?Q?0EBFCmA+mwZOP8yrKO0OHBa/qBRxL98kGkhBe+mbNUr3nd2G/f4qZ6cOUqXP?=
 =?us-ascii?Q?J0FCqe7zZcAIVMIBPR5TemscZBpboOI2iT5Iu1r6nxwqQh06Q5317vg8GTNe?=
 =?us-ascii?Q?c23Kjj6bOVMNK7Tolhmup9nXhCwqeF5bePdZ4VPCO6tjT+iNKKgyDgfScb0S?=
 =?us-ascii?Q?AkGStY2NH8KxftXmH6WdswYUvI028cgLLD5LPGe7FQ9NMX7HDO8xSvY9sfbr?=
 =?us-ascii?Q?M7ckf8z11tIfrD0A7k37t8aYGINwWW/j2C+SUju2G1n4JbGfZvZ2gTBESTcY?=
 =?us-ascii?Q?c5MwhVXWa5qUX0KU1kwc0h4B2TWAm7SUCzesX0Pqz7hRmgqDXMwcDkhnzNO6?=
 =?us-ascii?Q?VQGVCJLkdRDMKs5XBIYxPmFO98PbrtHvarA5DnezR6Fy1dEF+5+aD3w0oKfA?=
 =?us-ascii?Q?6Y8FqS2OpWm+Xzsk++P5hZ8pFIRcY/fnrxDNNCyI1TJgdu9YKFLQ1WhIaCy+?=
 =?us-ascii?Q?/TMgytz32Y/hrg1S1lHZfbl5iysNCyzNeVb0WBKepCShfJhljwiJUppcWquV?=
 =?us-ascii?Q?qHchZsWRmkxTVqyEaOPq4lG6m5l0iRFDykv2FNESDEwklIwqLHs05cixP1ch?=
 =?us-ascii?Q?QlAM7rESh8ZTQ26nkDlsPub+e6Z66KQRznL8D0r8krtIcpaQ4XATTImSWw/k?=
 =?us-ascii?Q?UDAPuMkqfQEYzInaYG6Io5U2sD9iEHnENMbsWbwzudh1yXBX6SI2uPa/d89f?=
 =?us-ascii?Q?660AfRqyVO7AuPEY29DFeDGLTWD5LvPn73Pc7ZQWmEV5iVLKTVcVlu82g7x4?=
 =?us-ascii?Q?N+5j1S0ieEzQ3ZZrvX4SHkteC282LSSuwGBAquw2VSufcdNudOYoJRYOVzYj?=
 =?us-ascii?Q?l7NwXUtpKXZLg5Lmey9oO2Ro3XMju9menganj/JDxg7cv12kL+y9Q0cFLbAH?=
 =?us-ascii?Q?52uuKqFtVMT2q/YykeCcynIXh3P3WtASIu0aGjd6XJMpnPHQjJBefi/PIZmI?=
 =?us-ascii?Q?As2Vy/ZHsZCMpiHu4jc1gvS/0bAuSHDCVA305j3zuQzCPDHv50PMGzXmR4LQ?=
 =?us-ascii?Q?/9W+1UmX+EEvL6/xfl04kJKok7wh+3pyl+FKR7sLB94yX5UJhhSeea5S8wMX?=
 =?us-ascii?Q?XchMLZHF6g2H4pMO8f/74H+16fid3zxCz5qLf3OXjqyQx0Y8onSXByp0E86S?=
 =?us-ascii?Q?xCvTOZTVjgTwonpxHxShlmygWg4UUeuEU31DVPDbAxkdC7vWa3d+VhLj+T4c?=
 =?us-ascii?Q?CykAQ+R4rY3XQmXiR2lhh3rTeVrrbOPyt3BaF4GQTwP5VAzyN3bBxZTwltGJ?=
 =?us-ascii?Q?YMnatkEeWfpTdqaBQ64tr6GnxgrYWg75Eu7T4uKnfU3qaKFyj75tsMSVtxNn?=
 =?us-ascii?Q?vUZ4IKr9vDS3viBlLSkNwMkh/puBH7BMp7j+XVCiYUzvmH/T+nNXTN2Yewl5?=
 =?us-ascii?Q?2eCkQHnoSJ2z1Bpn9XXoyp3fKM+PCiuxDDZKlRAyZpKTvgq5uoOOGxLhrSvt?=
 =?us-ascii?Q?laVPrQ=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9f3c88-0cd9-4511-9b2b-08dcb7c2d4ac
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 15:57:40.0860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3+gOrEUMLPE/QJ/aj0v2q2FpswSCpp+VxyMcVd1rG3zHHZBkBK9jzLy81upUh7P6CgfL/zz2vD+sWy3Lxu9rgzD9vAI4bnwNLUwn2Vyi3iY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB2816
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

When submitting previous, functional fixes, Tomasz Mo=C5=84 omitted those
two cosmetic patches, that kept lurking in our company tree - likely
by oversight. Let's submit them.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: Andy Shevchenko <andy@kernel.org>

Signed-off-by: Lech Perczak <lech.perczak@camlingroup.com>

Lech Perczak (2):
  serial: sc16is7xx: remove SC16IS7XX_MSR_DELTA_MASK
  serial: sc16is7xx: fix copy-paste errors in EFR_SWFLOWx_BIT macros

 drivers/tty/serial/sc16is7xx.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)


base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
--=20
2.34.1

