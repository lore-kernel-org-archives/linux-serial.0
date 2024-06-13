Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2097.outbound.protection.outlook.com [40.107.117.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2E91420D1;
	Thu, 13 Jun 2024 10:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718273730; cv=fail; b=bjI9Ye8fNjbz3VQhp8A7BEUgjT9Fpv79joAW548hqRUuC3pYOwXBhVCSVYt/TxO92JdvFbY49B1rhjqpMBXG2yO0+YmYCsOxLoylhF3XrQvdapAjfpdmxR32bwdO4KB3t17+nH1mCXvT6UKgxDnEiSglo5O/G+EhfnGZaQCRZtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718273730; c=relaxed/simple;
	bh=VZ5NIsGvBIbINDuE6eEbGA66Vp+WFs+BsSykmXmymto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o+ShoNq3l07h9dpZKVW9ycLAtBrMumeYUwlYsljwlaASot5SI8ww2jzYOUAFpVgLFKERCoDkdk5EJHnuzjt3br6CGabAopnSXF6TxlToLrZBhAXDfD0HVkuEWXncsWSsmwcTFWURBvAorcUQWCQVKJWwJylpSAQA+OHTUsXHZSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=O7Lc1jb9; arc=fail smtp.client-ip=40.107.117.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="O7Lc1jb9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mshOM3EGhC+mohQf5zf1ZbbM3GRDIp+onMz+KcERMEMe4r3GqWJicDNkCNwwNN2LE+Wupt2B9scsiXTZDc8JKTRPfsdUPgPMzz7Z6TteGWmzXZFjScytp2w68oGcYSa95GcWXuE6mgRbTLDmfRbpKkCBv+px2y7zLvt+VOaiLb6j3saKiSWu0wLkhiGxFMRM53c5ENDuP4T8hirKBiFhIDKyOfAjEAHpxSSL+O4Qsm4T7NE41EInnnkkv/7AnrAf95ZA5KZOOL36L5JwbvYyXuqdUYfpNJhkOUqHir9LtURob0H1EwQ4Z/iac1ZS9D98CSn2pZxrJ7lHIEp/xvuRtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zl3a96sg/98Xkq9ICneHXHun2Ko4ZixFNxPfNKr3NlA=;
 b=Jc/xzSKVZ5stieY3SanmE+sBb+mccKDpy3bbxIBlY+DP56aigOgBNRgc9nzLMANe3OY5cXH1MesWz2o1NGP3ZNmBlkaW6oAIJ4hwE1m71iJLMo0RB6orAsMsZAXfWXatrudtKf1cy61KZ5Cp/PRdew3BwUiYtI1ONg4cA+Q4Y3CBxQEpZvxJauf8yTjsrkIl74O+zanJM6KVWDZTiKie0jyHdacPWaBYPIhsln1IV3DUKN1yySsD7MNUEIF5o6Z4KvdZWpQ6ACGOqoplDfPW87rsj5LGfoUXiOPhpXxllknWOxtFgcuK8ZVSU/aBlcEdoxQH8CSuTbBTmG+BH/Lb6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zl3a96sg/98Xkq9ICneHXHun2Ko4ZixFNxPfNKr3NlA=;
 b=O7Lc1jb90OkgMP1S4PyOCs3k5c7TRPVT+MPuItpKSl3yWrk2yDZCIutoEKTqaxfhh52exsM6G6LdBYJQS6s8fGtstv75NbnY2DecKH0jmWW0eIQe5UXsfWFQLfd+VeMkPAvEKQ1+o8MHEaQd5AjfdQ0g2d0fA7XBl2r+sMMiQps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEYPR01MB5930.apcprd01.prod.exchangelabs.com
 (2603:1096:101:1dc::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Thu, 13 Jun
 2024 10:15:26 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%5]) with mapi id 15.20.7633.036; Thu, 13 Jun 2024
 10:15:26 +0000
Date: Thu, 13 Jun 2024 18:15:23 +0800
From: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 0/6] Adjustments and Enhancements for MOXA PCI Serial
 Boards
Message-ID: <ZmrGu4j8SRIgxCum@localhost.localdomain>
References: <20240607114336.4496-1-crescentcy.hsieh@moxa.com>
 <ZmQovC6TbDpTb3c8@surfacebook.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmQovC6TbDpTb3c8@surfacebook.localdomain>
X-ClientProxiedBy: TYCP286CA0272.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::18) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEYPR01MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e44a06b-955d-448e-84af-08dc8b91be78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|376008|1800799018|366010|52116008|38350700008;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A+1wZMCL22iFB7B6v2/nPx4WSHdM0YXdVca1CswicEcJFRFFCmPOkMYgwG4/?=
 =?us-ascii?Q?3aoJj59kxbUbwVhfR6/P48tnx+mpXfqMUuB7w8BxV46IynMai398+uSshFnP?=
 =?us-ascii?Q?yr0ODzBzslZymme56ho/6UR6bXdTU+zzZnbzfJJWqN9PgGvFSpusozoCP+HX?=
 =?us-ascii?Q?Mq8MdrgNi9hxF49hl5DgeR1WWK1DDSWg+fGNgm2mJmMgxm9aYcXQDjwEPZ7s?=
 =?us-ascii?Q?+b+7qDyhsAiFf9fCDWBfO66XhAcugkYpr5URBy+fGPOBziwIWtH/qz1F1TmO?=
 =?us-ascii?Q?NOjZoCLL+OpANCmvxWubmcoso+tACzPYwvklGkfVqVmya4xfNRDM1AGxbk4l?=
 =?us-ascii?Q?keUIqLKg0+ciVSEqjr10FSsGLKOmPuKEHf5IQUtFC/mPKE1EgUdSAze1f+bm?=
 =?us-ascii?Q?A9U1JmkP1QR0IpaodgChLrDuJccXvMg3qYJAEnRivyZCS1GK/2yM0m1orLg9?=
 =?us-ascii?Q?GRRhqejo59bglxG8ziuqwqHFGra/uox854rn+uM/KR4vavv6BodjYHHDuO+c?=
 =?us-ascii?Q?Ta3n0rOqkRkkN2GfIghFhrgH7tfswVXufbV1LY6DEp4rQpEX9DwwX0o8L8AC?=
 =?us-ascii?Q?Wl3qjjEamrQSpBY4OlSWdfb7lvO7WMdDTPyEsvQIQrLB4JDO6mJCsFgkHWR6?=
 =?us-ascii?Q?wp7roKZVReKtzHLX5nS0qRPw/Nj9U1Df26cMbONHckRGz3HTJ++ULBVrW6UF?=
 =?us-ascii?Q?0vOHrrL8FztZQJMQMpsENiC2sZHAlicX0gRaZoiuDuRcNC2/EKf9w7ERoqkx?=
 =?us-ascii?Q?hgTXa//FvvIVg+sbpTrMXj2FWZ6Uf13qQQg6CYBQc/pO/OrgwRAZkGwEsWjL?=
 =?us-ascii?Q?RdETOaFX8ut6a49n70QddTvq7bsMmv2pZGk33fVVmri4ZaqelHRqeBvRmRHq?=
 =?us-ascii?Q?jf40qU+x1mC5bFT1+fODy1hiUb1eSNyAldBTL/lJQfqm6Gq/WzhYYtToqOPh?=
 =?us-ascii?Q?15xcZ7hsOppqAniuLIBLgiKcku6/D+N/yr6H3oMSv1nGDI5rD3uPM8jBLMOR?=
 =?us-ascii?Q?zgZbtGySf8+Ng3b2xKSGOhw6UGtjs/gWsQTS33AAi1hlHPwwsYkF+SlnSkwZ?=
 =?us-ascii?Q?LElfFtLnEuPj/UCE7O4uRkr8qrPYv2iS5/ITv7vZ0F2ytKnD34WvEewTC9cP?=
 =?us-ascii?Q?ubC8osz1ELrQ5TcWGZsCWLMeV31AzdIUGecKZiEZrxzjYpTVv868GrO6vCJU?=
 =?us-ascii?Q?+APL77Fjg6nRJo39tt8zdNS8iK/eHXiFpLkZZSwlLh3a0G+Mem7e9+nAi9Ly?=
 =?us-ascii?Q?x7nSgGkrqsyFWtcRHA039V55WqFmkroSV/W1Q6I0aSzYf9UxkowBSFW3URqi?=
 =?us-ascii?Q?FOYCtX+bZ+1LT0G0jCGbYZeCERsfC+WBgSHzP8RZPqRN0dLoZSUPNkAlTbAf?=
 =?us-ascii?Q?TWC4vrc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010)(52116008)(38350700008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VepZyCcnILBbOt+m7LjJfbGoJw2+GTQnKEMx1Ymjs+6BF8Kw1CuP5wFJ0l17?=
 =?us-ascii?Q?RddBd4nnFnQsREKJWcc3RLSSSvYmYd6UbpWNvKF9aLvR4OhexBqBbvEGlH3a?=
 =?us-ascii?Q?XJ5AXt08xHyCEIl6hmRWEjTxpV7I8BO6PgNLH+4i8DtzHs0ubAcUZvmDAsnN?=
 =?us-ascii?Q?PEBHGorE65BmIKxITT9BM6UNAyksddDYtgFaVKnaZDoKIUBcrobapX5MIkKN?=
 =?us-ascii?Q?c+E2QHrQjAQA9c5GH+4+Jo3MrdBNzni5BM4m+mi5Th/dXAFqeUSAg8T0D9Dt?=
 =?us-ascii?Q?mc+cKisQp/fJ93+ERxthIASlMCPVwslW6sZqiMRggs425l1HulsbB7HH+C3D?=
 =?us-ascii?Q?FsD7Rew3q9Jyb6rv5C81wQWbhBClNbgUoRmr/YvZLQcHEZKa6GPvr3hW7Nsp?=
 =?us-ascii?Q?oqL2WURJXAclw55av13oQQYSIl3NEQgmYgcA15ULS4Tk76LZh6lRjrePTSyC?=
 =?us-ascii?Q?bxFpwVz48HqiowCgRYU7EH5e8INK5PSLKInp2OLe632o1j+aqglk+abCqlq6?=
 =?us-ascii?Q?ebnzbh3uRMmEzPPUDI361/PKEkwkY67rYIcl4pXF7ktTxu/hw9Y4uwVR3Q2i?=
 =?us-ascii?Q?WKqCu0IJgjn8k5jT0Iyly66E7jVsGKSmEVp68G/Cz2iyys9x5Nsrv0w+aSEL?=
 =?us-ascii?Q?KjRwGCq+xd16bAZNS0uHtSK5i5/ROHfSjivqpBn9FDpLXEaP9htcLNIQxd/x?=
 =?us-ascii?Q?C2uC+UP+1Nk7bActHxeZqTyPokyZt6SWXmKN0Oy5QTrad9GeoL/wIPh8+wKp?=
 =?us-ascii?Q?oamNCUlPZG0z0GQdo0fKwGqVHHT3RK3W/a+c9eF9W7D8+mKgPGfgkEvIc12P?=
 =?us-ascii?Q?PlZovkGmz1m2CCAS5uxCUgIBVQKVFGJ6WeQ3AFxHYRRelc7viT30bkgzFzwL?=
 =?us-ascii?Q?05lDMswi24KKOQFCb3DkMzsVHuaJNYglC7zw5LXfz9T0Tkv24OZLBOnyzyDR?=
 =?us-ascii?Q?Ks0PiECwJmEcH0EdiirHJAt4ncfiuWabB7YWBM0Hpr/LcqOFwZU1qs/uP2QK?=
 =?us-ascii?Q?ji2MGh2tgHIRLYT08n9aPG2KIy0oLN6hpSMUI5sUHp34LECRjJcXnqFSCmi9?=
 =?us-ascii?Q?cvV2wlHLiY3G7fHLAP/7/0Ll1WJsNCB0qUININ3w67izWjJUBX8vm9qaV92m?=
 =?us-ascii?Q?xCGyvhlX/UxGsNb/3p3drMzSD1v+qfCd8KzCcmzBHqfo357kvEaGkj5C8hFn?=
 =?us-ascii?Q?63I/HQyEogVMn6+cP2EGubKU2R6zVPDlkMh6wEFjbeZC8mN5ucDEWJ+aVeaQ?=
 =?us-ascii?Q?+h9Ns3mDO8b8eHyg+1lZ4VpeR/bRB13Fm1Yto4z1gn90o/7e1JoGVJp9haxp?=
 =?us-ascii?Q?xIJxSLFEwNJbGkk/QgVQC3jz++8dqQ7wdfhhEtk1SqdhDkGngAAeAEg3rxvP?=
 =?us-ascii?Q?7GyX0R6M2PD28oWCIqNPu1FADs/phWUK9UBwtDZe4pmnR8JxvUwI3ZObTys9?=
 =?us-ascii?Q?zNUzDWeWW4lac11LNCiyoUQpkXATWgv3GEF5+0giSc0kC8j5lAJgBXxv4lNj?=
 =?us-ascii?Q?Pe9Hk/yiQ5Zf70WdixMSyqlqtO7JjiwI5fET1AiMZF7bolbo696AeVdVxYwq?=
 =?us-ascii?Q?w962CxlRGeps3L8e816MecQ8iNihfV/wm/m9uKtRDJ4+NVmJ0EnYwExXOfwD?=
 =?us-ascii?Q?PA=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e44a06b-955d-448e-84af-08dc8b91be78
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 10:15:26.2935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZkRE0zkJYokFo+3benya5azOqrs7ciwRflAuV5AL0Q0cCMhHDjTJSMSyX5099Uft/clAIqfhVPAnxb4N1MeK/oXo+8lqus5Z929thERHklo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB5930

On Sat, Jun 08, 2024 at 12:47:40PM +0300, Andy Shevchenko wrote:
> Fri, Jun 07, 2024 at 07:43:30PM +0800, Crescent Hsieh kirjoitti:
> > There are 6 patches within this patch series to make some adjustments
> > and enhancements for MOXA PCI serial boards, a briefly description is
> > written below:
> > 
> > - The first patch is an independent bug fix patch.
> > - The second and third patches migrate some MOXA PCI devices from
> >   `mxser.c` to `8250_pci.c`.
> > - The fourth and fifth patches address improvements and adjustments in
> >   handling the serial interface.
> > - The sixth patch adds a UART configuration that aligns with the
> >   hardware capabilities of MOXA PCI serial boards.
> 
> Everything is fine except one issue. Can we avoid polluting 8250_pci?
> What I would expect as a patch 2 is a separation of 8250_moxa from
> 8250_pci (see examples how it was done in the past: 8250_exar, 8250_lpss,
> 8250_mid, ...) and then updating code there. Can it be achievable?

Agree, I have been putting too much stuff into `8250_pci.c`.
I will send the bug fix patch first, then create a new patch series to
split the code into `8250_moxa.c`.

---
Sincerely,
Crescent Hsieh
