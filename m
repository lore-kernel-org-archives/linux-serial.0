Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012022.outbound.protection.outlook.com [52.101.126.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2167242D72;
	Fri, 31 Jul 2026 02:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785464339; cv=fail; b=bvK3iPtjBOiuhUmhtOW+nzjbsQSdFa9/xP1mJ3w7VrAWeccMWNVvCd7yju7fIJlJuwRLg9USxnwCGY7E8AK2ZqWTMjD1Oy46B9Qb/ZShqVZVqkgkdHkkIZEg5PkQEcp9j/gmuIue51fef4+mdrSNf2XSEWELatBSMxUiRY3w82U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785464339; c=relaxed/simple;
	bh=9daqAd8ymERyhFuZgk0wEvcN/HMWCAvgIyTn9pLSr7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zi6Fc+pYBfpFBHEunVrhJRHyBXViSaT4kEX74E4rv6gZQI/j919kVV5Gl0QwuBsZ7P9C5Jb9Xh9HjYK+XEK98iy4NIGCMMTcdFpJxWRq1FKsz/abxJQCQ+VLfkR909quXr9niGBs1u3ZTWk+DwTJyCh+kXCLK5opEwdhgYvCr0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=ZKySphCo; arc=fail smtp.client-ip=52.101.126.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="ZKySphCo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1pn+7ZwYqTGka3BmJf9jTKtnEPmOP9t6npRClpcXcltFzv2k+5Yq5BAhrVIVQeMpbzIXueYsk76yPgRYwnSK57zecBSIHdT2BU1LErCo2Bk3YzxF7d8fCTgBNllvZqILSkQjocZjxmpG24AzDNIYBQ8q9h4tKk9U7PKUatFy7Ti1BZoH+gIip339en7aSKIiedPtd9G3Za5Ode9F8X5rr4cRfZu92dFaz7scg1wnwUjDhK5mA1nL4jJmUIJjfwLFQTKKtXLQwJh4u6tF38Lm06Om8R2BQelxqqLGL5dXMkhLQaIUC3EIQKIR41P0HwagLH2Ua1CsA5AHP5VO2ARUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4CV2rdQ3Z0E4dflwBScsOvS6hHoBG4u4XnFSKWvb1M=;
 b=SRnDcAyS+x6Tm+uQuhXeopOwaUUFRTLUbsr+R0YUuzE8ouEtWDQ0dURzxpXfa+M0sqjJVTnUaFh1lIDtbJrTEE9K91bHiSnHfi09phmDPBD0/3COOnk2+rAOrkS2wxvOIgk7jTP+aEQdI+ZvGB/5PJKNvT88qVE07tSaGhNaaEOugWe8uLvz3QPNstzTu8g1gUXu7oE3SzA7CYvx1EhDQamaZgDB81n/C8au6NQvG8bfDdqDupjZiTHfZlTWl4diZFjKZ3nQTEZAZwZbhDqCblu06UsgPirsM01Kjj+dWsdxQn8WCgPPk458sYyoOhkCYD/1QVZIS9C+KQLAs9KjVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4CV2rdQ3Z0E4dflwBScsOvS6hHoBG4u4XnFSKWvb1M=;
 b=ZKySphCoPYKIYAPJXCCZ9tB9IiPunAR/hiIKMyKaVQtimy9ql68qZVTjZP1z2GegKXQtkITEovQ09yn6KJAvCH3ana9LUFY3rzuPU5esaiILZxJKB36F+nxfEkaxabvJNf6FJ9gKoT9XHXczEAqOT91QEfL3zEZsApCDEO7Jn+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TYSPR01MB5962.apcprd01.prod.exchangelabs.com
 (2603:1096:400:46e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 02:18:53 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 02:18:53 +0000
Date: Fri, 31 Jul 2026 10:18:50 +0800
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	FangpingFP.Cheng@moxa.com, Epson.Chiang@moxa.com,
	EddieSY.Lin@moxa.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 05/14] serial: 8250_mxpcie: offload XON/XOFF flow
 control to MUEx50 hardware
Message-ID: <amwGCoDvISQOgbLO@moxa-KabyLake-H>
References: <20260729060602.492430-1-crescentcy.hsieh@moxa.com>
 <20260729060602.492430-6-crescentcy.hsieh@moxa.com>
 <82cb09bd-7f95-4cb8-9cd9-634dbcf38729@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82cb09bd-7f95-4cb8-9cd9-634dbcf38729@kernel.org>
X-ClientProxiedBy: TP0P295CA0002.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::15) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|TYSPR01MB5962:EE_
X-MS-Office365-Filtering-Correlation-Id: 2097d6a4-42af-4e7c-ec40-08deeeaa112f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|52116014|18002099003|22082099003|4143699003|56012099006|10067099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c73h+BMRNAZyGzKphCW5kcbybw62gmDJ6+qahZCmaX76k8pW8kxlPQdLN5QR?=
 =?us-ascii?Q?y/pvQ9gGk9Mm+sy4vbcRSvhiPGBb34GdoaLLKP/iCG8GiiJZ3Muv7/LNfRx9?=
 =?us-ascii?Q?rg1IBZmQgfebqYh0/d4ExzmLxvF2myLJFWvEZ4xYU1HJ7zvhOpuVRGYbA24o?=
 =?us-ascii?Q?O2kFUK4sJIjNQKTjYvHKCjA0/JyLU37cQh+JoTe7hVM+MAycUgXCKq4Uu1o4?=
 =?us-ascii?Q?RznTMuZ75M3N22zre+AmJzvE5qzOKfl4SwlNEyTkcL2Wm5ZxgGeZYmlKZkpk?=
 =?us-ascii?Q?6vFA3A//OsYOx+kcwUAw7XGfRVcGL22j+XdoHffcJUbrp+V9hyY2NYVUMYBi?=
 =?us-ascii?Q?LwsAwPsDlEQlyrEjs/HjGzSQu83fq50Dfk2MQ8MqT3oEkl6E2UVGSAFfaMQs?=
 =?us-ascii?Q?PSleQxDdl+tk9L8lFUuy3pUZ3a7pX6tGoaenFmNvFqZFcy7IucQsChy90bkl?=
 =?us-ascii?Q?MIX2DcQgzupxclHohmmx89zem97n+vvl1T3pD9k1xq25blsVb8WRbwEd9W6e?=
 =?us-ascii?Q?FKzQFCmYAU/1jB1eXGu/3XMPdaP4dp2/ch3hPkjwVC+Cq/vUKCrHIDS2f+sW?=
 =?us-ascii?Q?spm72JPrIiVFRSK2fA0P26sfpi9H0KH9jMVJ3cvvLV/5eGYINUMLRg/auvt2?=
 =?us-ascii?Q?DCnDABf+Vb9bEyNKsZJvdmPGJpVK7KgKsMjzDZ1lkGVH2a76ezR1F0OOPqHD?=
 =?us-ascii?Q?3r56umzEDSHPPPgc8YajICnk6o0wYCH0Lo0dlAv6nOAJGqrKvXATzeMMJKXA?=
 =?us-ascii?Q?zEje98XQBLwar8yAzWcKVwbabIKXaU7rDQd0CR5l16WfZaCs0p41Pmy5W32C?=
 =?us-ascii?Q?r3vbHFllmN5HSrogU4jkeEsaumfmwe4lu/24hT4lIB7dPJxhBE4KkEacQoQC?=
 =?us-ascii?Q?1erz+WdBQZxoEifAxPKQBNDyE3lPazHDcob+QOORB+uEKliYEgiorWA+SZ4u?=
 =?us-ascii?Q?jbfXtRpv1fuuYQ90KsukSJYAo4ChhxP2jYzpe7xzsTwNEJd79pujUeS/u7Hq?=
 =?us-ascii?Q?wJAtQvFVaCH1kiDzwo81v20XVXUmW/WQsb7BOJ8Ipp8EiZlU4KeoCW2vA4WY?=
 =?us-ascii?Q?EHvmXS/6wAMDGR+Lbysttll6pGndjqnuAFvXz+0voKQtw8t3M9IlWPlkfaJW?=
 =?us-ascii?Q?YIR6DQrTIy313EHpzG5tyRJlv0uBHU/KbhG1cfv6tZp4osY9Ao3saZImriFd?=
 =?us-ascii?Q?vNWeGnNNSz5pxyFppZsW0hTBKe8yNaD/y1fV6ui8+8kns7ZAVKGH3e/gLDgm?=
 =?us-ascii?Q?7DZIK4ArAHDvktn9c87mD6oLl6LWcMoW5pyaZAl5bQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(52116014)(18002099003)(22082099003)(4143699003)(56012099006)(10067099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G0n1ccTZar3f51s9Th363FMcFIFNO8zgN5e/46vmP8SJov6PN4JIOVsnxmOG?=
 =?us-ascii?Q?Co57e3BeATUpQ7mMXaSkG7owf7vedjSfNqKQRyxnx6HsV+edfyoRBladREVT?=
 =?us-ascii?Q?CJQbogK4DmYQVNmuXU2J4wowpdtka36C+Uor8aertc88bhCg8vWu8eFipt85?=
 =?us-ascii?Q?HBXF2Bn02hkXBLbdbKIWbixxxkw5wXllGoPNfj3frXAkBP0fsqydLhfdcoaj?=
 =?us-ascii?Q?i40i9iAAYrD7ZHCKDXyrs0YCTBFQ50Z7wqzzKX7c2aAV8YqutOv72TXt1c3d?=
 =?us-ascii?Q?qNKttgpa3BlP3zMt9//f+JvYsMvL6SpJClMH8T641pUhPI9DFNjO9A7cM8So?=
 =?us-ascii?Q?3+w9LdTQkbwuiB4hC5SAuX0XlNxSTLI/srmiACjqMWpSKMvMbenKXAC9wBYr?=
 =?us-ascii?Q?zim1pmZkwoN2wMKM/epW4P6Zhg+az+9/pN924J+AZ+q8UQoFCBRCsIuJKzEO?=
 =?us-ascii?Q?EFIr9txCazul/JeVQTYwlP0zxBMVXruzAB9kPfHnxYUGPYY2cQHRlOhO208p?=
 =?us-ascii?Q?B8mclCSrLeSuhFNG37R92HtgW9FVi4EHiNvgFU04NS9kNRumQ5O1bbz2PWiM?=
 =?us-ascii?Q?PLoYEeGdcOl/9sMWeplkzCNWaU5rg8cKF3CZ5aNb8y16pdDBzW6A3kU4+A2V?=
 =?us-ascii?Q?3Ihz1sURfPStwpzF12Q50YKDNrOuozUAampbWde+qPWZ4bb0V0zr7O8PFqoM?=
 =?us-ascii?Q?c6uDBhnriyEpdDl5opFSL5NYwOFzYdCFcASJMw01h09PFoznU8oY306LSmoX?=
 =?us-ascii?Q?2c35AB3hrgoyU5S7u2AZtactTHRa/4D+7Fw2A3uyC5lI/dZ+cTeuFDJXgmOJ?=
 =?us-ascii?Q?xra5CaGZ7ozd/Gajr0qk537Wv8kpzqnoobfNBG92JoZqPGKB/j+SCxLhYVzx?=
 =?us-ascii?Q?lw46BgV4c+agptNsHRMH2tt2KZTCh+jz/d4QkoglE1W4G1+tvh6eqrc6eVbz?=
 =?us-ascii?Q?wtCdht3Y8zu1F42VZTtizuG2orD82dNmPCk/AuxZZHpz+RoDao/FTowijjJ5?=
 =?us-ascii?Q?WhKlB7AcAYKIu455VcpDSnnP2bl/rCbfcJeHceRFbeutRXMW8mhesbe3I/YC?=
 =?us-ascii?Q?Q3YFGRIKMYl2JW3fDIyyWV65ZoGT1BNQzYnjHjkUQQP/vKxUXaguus2RVxJd?=
 =?us-ascii?Q?3/Mej0nm+pxbDTqclbM4yyAz6FjkBYEhJdLuhTm/ruln3VSMIYYcB98v884n?=
 =?us-ascii?Q?5EMkM2lJ3nN6t1HzKWgVv3JMNC8XHqjAlaaxsgxt/r2NWaDGbHmywIYH08Jy?=
 =?us-ascii?Q?6Hgs7oMD3N8thyUwIYXByqw2bDnl4ac3sjKEUMOJpD4hjnsPNqTTOwYRGvwT?=
 =?us-ascii?Q?yXoySSck+aSwm2mgNIsf9b8XTMmXgM6RkJanUoneDaa4zItsudiO+rf8mjZW?=
 =?us-ascii?Q?CtIf/n/ew7SD/nabJL9094UMuThnaKVqumM+QzlSLHR5BIUOCN8XBNfcEkPQ?=
 =?us-ascii?Q?z8u6uw5Ch0SNbvB+xOiCpzsOz5MhX5Z9jAfODZkiL5rCPZNDSn3e4uhxuud6?=
 =?us-ascii?Q?nLI7RcGclXyKHkLxWu6rHCmBi6fpKPEsO0iQPNkkx40wTy5jckEyqjPnqMqQ?=
 =?us-ascii?Q?/mQoU0N77ETbmvK9p4T3+ozLneyBqLaH249vkNsv2iVTUcXpVZzEtDx6rym9?=
 =?us-ascii?Q?CkayJ5vQEMUcO2ybyabcT3XEzscfYfMz5Eq5q+b7x3bTQ+SB5xRFkHdfqEXV?=
 =?us-ascii?Q?7ClQe1HOMGAGIVo77WZgoEj8g/O/1xVlxW1dr3IKMPk2yeGvJDZPdKtnMaJl?=
 =?us-ascii?Q?qqfJs1h0Fr3rSdouLud57agiaabe+eE=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2097d6a4-42af-4e7c-ec40-08deeeaa112f
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 02:18:53.5615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2eYtHOOxIza2aetsBzcMLv7a1ihSGOfUtG8hot5pxHBu7GKp8dEOoVM79vu/7WT7dXEr8wWA+fK8pcNSv8RTgtRIKBwwpkLLEteD5JeeoSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR01MB5962

On Thu, Jul 30, 2026 at 07:49:43AM +0200, Jiri Slaby wrote:
> On 29. 07. 26, 8:05, Crescent Hsieh wrote:
> > +	serial_out(up, MOXA_PUART_XOFF1, STOP_CHAR(tty));
> > +	serial_out(up, MOXA_PUART_XOFF2, STOP_CHAR(tty));
> > +
> > +	efr &= ~(MOXA_PUART_EFR_RX_FLOW_MASK | MOXA_PUART_EFR_TX_FLOW_MASK);
> 
> This is not needed, as you use FIELD_MODIFY(), right?
> 
> > +	val = I_IXON(tty) ? MOXA_PUART_EFR_RX_FLOW_XON1_XOFF1 : MOXA_PUART_EFR_RX_FLOW_DISABLED;
> > +	efr = FIELD_MODIFY(MOXA_PUART_EFR_RX_FLOW_MASK, &efr, val);
> > +
> > +	val = I_IXOFF(tty) ? MOXA_PUART_EFR_TX_FLOW_XON1_XOFF1 : MOXA_PUART_EFR_TX_FLOW_DISABLED;
> > +	efr = FIELD_MODIFY(MOXA_PUART_EFR_TX_FLOW_MASK, &efr, val);
> 
> Assigning back to efr is unnecessary. The reg is updated in-place.

Hi Jiri,

Thanks for your review.

I also noticed the same unnecessary assignment pattern in
[PATCH v4 01/14], in mxpcie8250_set_interface(), and will fix that as
well.

---
Sincerely,
Crescent Hsieh
