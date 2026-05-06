Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012007.outbound.protection.outlook.com [40.107.75.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BFA2773E5
	for <linux-serial@vger.kernel.org>; Wed,  6 May 2026 03:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778037358; cv=fail; b=PLdQfcEwx6zuY8l9t7H0O/gol6wc5UKyA3UyW6udbQ5sl6GAOSJVtTGs7+1k5CE8TfWKnlv04Y6uA9BA1N1dayVgziKVeaWKYa8iBxNJ/vz1fKxXQUGXWdU9xI7wRi/IwQno37+EgycxulhjAxpGZMa0YT51sKvyeJf4tbO+zWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778037358; c=relaxed/simple;
	bh=ZJDX2nkxOP6mL47Iap3BmM4Ge7HuGhcSJx7lFCOtMW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W4isMjhzcUYiqHF6lKnLYzoF1YQCV6hF3t1m5f3tLUekmINE53InwCkFtlTHrx0pBcoUOyim5MNSAojWUSlXBfgUDVkb5sanNSeiZRXo/UHC/DF4rcVM8OLSwdEvWoQnBhm3XFv9f/4lkQOKmzXRgNj3osP/GysCn4zVT/6xWq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=Z1MidgIW; arc=fail smtp.client-ip=40.107.75.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="Z1MidgIW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XR5s2iZveXpFALCcgSFUrqaegN3LfKkrssKjTpsNWp623pbmRF9CQLx4SJiZmS04LsplPaNMIG7G5GW1EQVDTHrgifIN0z/ZJz5yJ/1KwnKPAH/R1UMonnYMAd5+mzreocllvoCIRStvU5NxsTIRLg7sedYrbynEgCOntn+BqMFtWA/Aru6oeT+o8WpIl1WwEnhXdQhPYlx1J9uO3TwZ0Cz1xLY+sKMOExCjObktEzJMqz+VHXmcX7ZQ/KxuoyM7O7bfXOMGB3s6naGk1pHkzLlLFLiNcW3u1lBWpcQHhiycnFxuPDX0AAo0hIpL05/g/pFLn04HN1GwFS9YgZjm5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lybjN0T1Uf3hb54SqKmtFtcs+0AfM9TFMcfy44aOXYQ=;
 b=YPF7RQanI0qlI7flnZWMh6VFMp7h0cSGBZku2ujQPV79/mP1bG9wGxQ8JDJ0UuaKl8HIMMAoHv3S0zUHBJGkVxxp0vstBTB1Hz78K9IxJQ1P2hiI44PJmYeu8141J1iWh3Ks/OpyQZj4tfuVKhXwbTW9qYiTtRUAfiln9Uec1zuTjYfqQzoJn+rTA4T95lFkp0itbFsXsh+CQH4R1PJnfepvUde9dJS7FWSrhZoWaSyU4ndLU61B9OIwyGPo0lss1a9AeF03v6sxMLe8iejslykUgMUC+Pu0u3WYa26C5Yho8X08n3uNy0IfZ+X54c+obHpJ6gRQN5RGGWF+0YdV8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lybjN0T1Uf3hb54SqKmtFtcs+0AfM9TFMcfy44aOXYQ=;
 b=Z1MidgIWI+AHghBHCiPQEautIK1F4QGt5aKJwFtylDTW5yLaiZF7amtilrNGi8dv1AMBMlKnlQHSk/7fJq+fKyX8egDnasiYdNvgHS1q5us9yBo2UST7jvpfVhcPZv9mMye5ZW3Uhdgtx7zcQ61Q5fH8OG9VlNe63z68u9iqRAg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by KL1PR01MB5473.apcprd01.prod.exchangelabs.com
 (2603:1096:820:e2::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 03:15:53 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 03:15:53 +0000
Date: Wed, 6 May 2026 11:15:47 +0800
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ray Chen =?utf-8?B?KOmZs+advuaYsSk=?= <Ray.Chen@moxa.com>,
	linux-m68k@lists.linux-m68k.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/3] tty: move remaining serial drivers into the serial/
 directory
Message-ID: <afqyY8FQ8ZfpH48_@moxa-ThinkCentre-M90t>
References: <cover.1777943090.git.enelsonmoore@gmail.com>
 <042d993686c87fdfd4130f11b57c3b559944603d.1777943090.git.enelsonmoore@gmail.com>
 <ed6dce34-2207-4403-bbcf-080db2614241@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed6dce34-2207-4403-bbcf-080db2614241@kernel.org>
X-ClientProxiedBy: TP0P295CA0035.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::17) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|KL1PR01MB5473:EE_
X-MS-Office365-Filtering-Correlation-Id: 20856471-5c28-4966-4266-08deab1dc73a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dD130/kBkNb3ucupZDeAARMcwD3mft2UJXg/qZk+TqIdyeZYsvEivwM7HEMpMrw2cGG7uWJvyAXgO2iioDUTOq5PQANJ+ekF5MQu/elt62weMAA+AbtS++gS7MCkUdOrde+C5+fUEH958oQBDdIjwEyRSYcjySL/kJozQjUUVi8JRBwk7MuHBvr0Rk2R/pQEbA8km4vGmQkHyTtL7WtncoIjpiFk364CPj0zQhkYupsZ5QTFpjyB1KDHItI0r/S50AIJzDQpjyxygGS6DEUG2iloH4aZ1XT6hzlcd/znIfASRDFIJyOS2QNYiwsBSrdgDavOuu4Y6Hp/663Hy7vXKCYVWCCZ9d/8KB9fYonsDSuq8Fjk6xWI6MJKmyujpSna6hrGq8GL6Qnjn2r2E9oT2WHjztAkUBRa+o7rd0KaMmcEb5HpymLwIDBtmGroDU3Q4h+b9hWexABSF5ZLFGrzqZAJbjyqFEJMq1tC5ntLt5mm3ZZq8KiVVZ/IjekMCD2PPNDB1tqVwSapd9H0O+gGtKE/9E1BQx5oUaHkv8AZeiaQ2vq9mHTFdMUEZ7LAF+j6nomiAogMGenCgTltqePrmFmODwT3QN1oIU2+S98EU/q3o78sjDBCccrSRO2auQXZzTNrlsbwpV4GLhrBLuZseaxJnykx91hWxs8w6PoXOTVhtFr5XlJv+zlTr3iilnrIj3n0/jnPVwB1SfXHpU/ZXQl7fJZaRWIouqMoULoMUq+sL1m4esZwVnP21LlQejaZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qH1bA980oVd1EptPKHRT3+EQ4Mnp1weDhZdf4ldp527p8uGRKhtP1PxrPxOd?=
 =?us-ascii?Q?3R1JQMp1QpmFEZ4+c8zzECuyREOK4e5pGFKBBpDwyn9/yruMZPXtH9Gw/hLu?=
 =?us-ascii?Q?jXUYk1elLmwv++h5KObA0vXzVYSfFJVpSkwE0JS18h7iH9EckMm0AHX5cq1m?=
 =?us-ascii?Q?KV6dwI7nn7AMGYq5UdXrRJQEeRyvLuhkF4rsNNlVvP8Kpd90nCrBxbVpzmvH?=
 =?us-ascii?Q?f8NEz2toVQkoF4zs4BgdpakLEf35L1qa7GAyEX5rtt5DxLKGaFrkBU1WTj2Q?=
 =?us-ascii?Q?1m7MrfvGBQQVEARypyDbkVG3djtZJlA5nx/AePxKTX1Hl0LwJP0AkTVONhny?=
 =?us-ascii?Q?Bm4bZ082sqPGR8aeKbXl81woOTzc1CRtGkTiSKujvJakCAxrVOlWqhPuVm2X?=
 =?us-ascii?Q?9tQ3xjeuCQCMJ0sBgsHRe5mvDbE1JG/Oj+RsACf/mTXm07R/QLWTb8mUQc/M?=
 =?us-ascii?Q?T0UWGql41HGSh3BD7Q4TVjvA3XTzUg1O8eorncPAXpQyMAFkE1uL21y/qRGq?=
 =?us-ascii?Q?uaFXd/JT0pAmvEL8k2DYH4VNWybbNKsRNNuD4+DIgn+bikVwq+yweaOwqn4z?=
 =?us-ascii?Q?/ktxyeuaBXi2NZ94UGPwjXxafYlbVNm2SfvWBodfTNr0Gj5pQDt+jLntwJIt?=
 =?us-ascii?Q?qpWDUtvrb9/JCwikLwVM/LwLaaVArzi9dzwu2JXm4aXubKJOToFoePUdOCg1?=
 =?us-ascii?Q?1rLcIZR6mcsPVhVerIHrkDbUKDLEFQNAXlhetU+y9/aBnonU0/XSHl23Ljtt?=
 =?us-ascii?Q?Knguftrv55grS90r+zcymOPh53dS9kxIhunJWrbrqfSKZWJ83zteEiB8PS98?=
 =?us-ascii?Q?kcK+lMiKROEkTZ4cFAgm0it/1jfsvVKbXA5U72F30B3BIk7SPCJ1MWneRGAM?=
 =?us-ascii?Q?Xs0/Rd+Qnrtj939LjTqoQjXMZ+BiCvgWzTLFgbOTwx6U9Bde5gA3xRRhMzGa?=
 =?us-ascii?Q?LNbK/tAjBBRu2xgIVCCRuf/tEOaArwGhiggARWtqdQU5IWaXYDLRBrgsMWpU?=
 =?us-ascii?Q?I4tlNKvAtxA32+jwRvy/ndCuGnPjbFJXDpxNw3Zd5trXqNTvob3zQ2jNdAiB?=
 =?us-ascii?Q?1dnRAWiYNQ92i57xjyh0FUsqnduPn/BBKBJbmmp0GC94yMbXLpG5tERaup/U?=
 =?us-ascii?Q?zgl+IUKkbzutHkrn26Dyiz3+zzd+W+AZ+ncec4UyDsQXU8blaVVWKvdCsMPc?=
 =?us-ascii?Q?yoAxPubxZGT4wGG+JKGk8hplgAuNMstQT/ddS8y7btO4t7D3uHIrBhXnvAEs?=
 =?us-ascii?Q?wrtB0Kcf3pCBY75mOWiv2f9ZDFc3ZAVHLsdd4WFNtsh64tgZfZhsGlBLW3aB?=
 =?us-ascii?Q?O/8Om137quKRNZdSMMCp4OALruy5GQR41EG2+sjQmhztDYm6vf+vdxwrQDEn?=
 =?us-ascii?Q?/hbuAc04QAy8lRvBk2RmauFuT1ILpgjP1KKqFoK1FDIJm4ARWewIKQ5m627/?=
 =?us-ascii?Q?H6gWJyLpWhAUcMZiyIgeQoWfZuSgh9SSrih1aqmnuKF6HgXXs5PIeY0Ptqm9?=
 =?us-ascii?Q?7/c+nyxcTIAiBk+FEoMhrJptV85DNVoek4eYjnKRzbvv7/tCfT2yLW4Ryxhj?=
 =?us-ascii?Q?Rf8ZIBy23BGIP/LbZgXFGfXt9FAoEiIbbOhvcz/Ozzouu+6TVuklvXpz+Ynd?=
 =?us-ascii?Q?NGNbdG98SWqYBEnjIXSWhP/rdqGeN08wcsLE7BjJdDNfqK6LkKy88ma91BPp?=
 =?us-ascii?Q?k+07irR6RrtzZeRVBcyllDK0a1RZj/ALeslCsr1T/udE1ol0GXwdwaEt70T9?=
 =?us-ascii?Q?i0q2F7angt5JcMChuiEptK8ttvF1tvA=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20856471-5c28-4966-4266-08deab1dc73a
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 03:15:52.1642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +O3PfB74oV3uHzAZGtySoqDDIkDdBSoevJNRh2bV+Wuy/ZEUabec5F9FrfAWflyLlVPW4wYSRaxZKl/69PDHrxKT6i00Zs2OK4w5Wyz1qqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB5473

On Tue, May 05, 2026 at 07:59:29AM +0200, Jiri Slaby wrote:
> On 05. 05. 26, 3:20, Ethan Nelson-Moore wrote:
> > A few TTY drivers are outside the serial/ directory despite being for
> > serial devices.
> 
> Yes, but serial/ (historically) contains drivers using serial_core. tty/
> contains drivers using tty_driver (which all of three unfortunately do).
> 
> There was a patchset from Crescent Hsieh (Moxa) to convert mxser [1].

Yes, I have been working on converting mxser.c into an 8250-based serial
driver for some time, and it is still in progress.

> I am not sure even about users of Moxa Intellio. I think I prompted long
> time ago. Oh yes, Ray Chen (CCed) from Moxa wrote me back in 2021:
> === 8< ===
> For the Intellio cards, we phased them out in 2017.
> You may find the discontinuance notification as attached.
> We will keep the software support for 5 years, to 2023.
> === 8< ===
> 
> I believe we can mark it as BROKEN to let someone convert it to serial_core.
> Or drop it for good already.

As for Moxa Intellio (moxa.c), I have confirmed internally that both the
hardware and software support have already been phased out.

Therefore, it would be reasonable to drop it at this point. I can help
with preparing a removal patch if this is the preferred direction.

---
Sincerely,
Crescent Hsieh
