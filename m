Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3723BAD80;
	Thu, 16 Jul 2026 07:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188790; cv=fail; b=nSJsYgG1ab+JsgIqd4x+CrDvnqYkxCc8qOY+pM+znzxdgwQhZob0n+Hn2ie0GtDLYTzBRAeC6Gbs8+HNb355zXX0Rnqb1ft8NPCSU8MV66aRDqt9HuFIBe0tEv5egSogMzVSmF01Te2VhQTGTsKw3RU5EoiAm4GFn1anRJinYy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188790; c=relaxed/simple;
	bh=22mAV1DfgC6VjwphTViKE/+fEywCpwNnaQIfxm4SEEo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sy2fZXSSzT1rLE7xIjj3Jg7Sz8CAtB65RNGIhKirlncdp45ZEu/gEwHu5VhMTlQovVXrtpoFOi9Gz7ZSEmk+wxokQVbfP/eDt5SXCM8G4df1v5W1aaAvHU6q7MAeIQ7OFK++ZOET1zb9nHqqumXE8jbE1UC3O0bQQBwZR6khPyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UUNC0+yu; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UUNC0+yu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784188787; x=1815724787;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=22mAV1DfgC6VjwphTViKE/+fEywCpwNnaQIfxm4SEEo=;
  b=UUNC0+yu7nqUS1xnYPW2fKuk+xyaOhrttCtQPPDWqzDBbqGT4pjCkTYz
   BoZZOSPaAEkAMsiJ7kPgSZM3eZxI+ijzjtInc+ZrURVBsPXA9wMgekq8y
   3jbzASTgWr9gpeZnsf/u0J2nNvNDCAxKwlCJRK+MbOP2vkAn5CUhgez8M
   UhyauUb8RNREt0BOYh/XqB88i244zbPu5vUizgK5l7ftKlCzCeaJ8Cj+Y
   yP+hzq8PYuGn7zQ9gP8JIx4H0W7UrgWM9Vxs0Zl7EagcVAW9IkpJ8JOAQ
   K2Hc9oZMQ8yQNdgAsUi6eu/WMdLx2QhXabVmGCPVUBUNrov/rkY2wDNA9
   A==;
X-CSE-ConnectionGUID: 8MFV9073Rxut7A+PWQavKw==
X-CSE-MsgGUID: fH0MmDWWR2Wl4z27EzNp7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="102391754"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="102391754"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 00:59:43 -0700
X-CSE-ConnectionGUID: EFirc9yjS7S5RvonbAXa8A==
X-CSE-MsgGUID: OVZrQFusQ2SHvCBDNZ1PAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="260004806"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 00:59:41 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 00:59:41 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 16 Jul 2026 00:59:41 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.66) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 00:59:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yd7VI3si9PXngr4oZtsyEejRIkpRiOGf9Nerf8IRseMDlte9/PBRHTZC4kaeYLk+6XKglen7rJa7MZUCthDVFwyDqloakE1V025HLH7IAKgeYN5REnb+qlrm/7shJ9UZBCPG7hKQEFsi2f/y2xlXeeLPZbmJYUb2grNzCgFSxgiEgIGfSiRPrLxcjAATH3VGpupBhDM0x+24DRIp/x2PiX+GwvQhgMvFl3sd4+tYDK5PFXHVE2Cyxm9CMLtj5sOi9uKR1wi+qcBcfut7hApRHN8lTPHWMxHT32I8/ECTEcYP9R87xrEscCb7jlkUF7xQ6sLFLEXeF7lccfuDOWsnpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iLsaTrabqnvbZ34rLs980rF5HxQmbZmEIUQ2R4YTTk=;
 b=lgtzo+Ov7ntSxNocD/8e1gTMtjcPOXdnlIm279zGPvkcoJBXC8dfqNoLKiK1ph9cPvt/NfC0tgtW2O0vaex1L0UY00M0l0Lm40GTvx2pY+5Ch8BC1ADJeqGWEpI+TelQxbefoCpcZ+jffpeIPaJwmOxzzfTylsisjfJZq9NI2L2vi6GCuHBNc/+N7gYaxvZ/nXTrbhxVd/mbl29NdhtceNwpnA258oRPdbXu1BxFw0w6DAeZ4DTq+Wd6PKU85vjgVRBSqX9/DxjBK9lva9uDpj65+oExNFoDcPBtYQQFWLlMBfM0K11t6WdsGXoRfo3fR2b341HxSdYsVcNKZg+qnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by DS4PPF2D9C959A2.namprd11.prod.outlook.com (2603:10b6:f:fc02::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 07:59:33 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%4]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 07:59:33 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Yun Zhou <yun.zhou@windriver.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "jirislaby@kernel.org" <jirislaby@kernel.org>,
	"socketcan@hartkopp.net" <socketcan@hartkopp.net>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tty: ldisc: fix deadlock between ldisc_sem and rtnl_mutex
Thread-Topic: [PATCH] tty: ldisc: fix deadlock between ldisc_sem and
 rtnl_mutex
Thread-Index: AQHdFO8eoCMizjyZPkygekKVlBK1rLZvx+9g
Date: Thu, 16 Jul 2026 07:59:33 +0000
Message-ID: <PH0PR11MB5902C0DC3D8407F2701948C1F0C72@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260716064719.1401892-1-yun.zhou@windriver.com>
In-Reply-To: <20260716064719.1401892-1-yun.zhou@windriver.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|DS4PPF2D9C959A2:EE_
x-ms-office365-filtering-correlation-id: 12c65f5d-596c-4dfc-15ff-08dee3102c08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|38070700021|10067099003|11063799006|6133799003|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: uvDEYVFobZwlX69uYjYCILmfgq+CWahPPwSDnhr0/z2PjRD7TzECxnuY2QinH9TS+2CjplAZ+P+t4J1V16VL4rhLbcvVCd/FcCPaYACHbwwtUXrKgk3W0mfU00RhlilGMvJJMScdhZSy8Hwc34eLQNVU5AJYOw2OSUuCOfu4+xJW96BBCnahXEXENKOLNrguIh4w0GuXKpOk1b6umSqnsT5dt7e6u5tuxALnC17PKeqWvmaoR2MKAPV2jLkHZWTU3SSUWKR1hcVle4u/PFL8gMI/uoSnlOyFamvCbbZQQvg94buM+aapNG1qwohnMnV9zJBY/jG/4uPmadlChpBEiKc6Otzfijl3i+FOKbI7bydDyGJaTFa9FqY/YmSB28CQcXydZr/iCkOv1G5PHZYVJGJSN+LMyezrWVlqB8mpCKUstSlvRX7hSdtKjBIfe8azFgZt2ZgH7vT2XwXylxo917/zo1suQds8vjT5L/TXHNqjWqdPqqLlbE0oVjW7q9A9Eu1eMgSNIwmVdXwHNUfYVm+FrbfPBtkD8Jroyvi8H3wY5A2XgeWhEzKQaDhLH556NT9YxoDLnmxAtJx93zj0t0RZS9vFvGYjCyw5xKgNr2S1f5/fR4WwyuVTg93aNdXpt/20N9JSDOoKB6STFSmWzmMSBnNIlo/ekpeBsfh8NYo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(38070700021)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c230JzB/BzN0tk2otNOYd5D4wRKTM9RqnPZjOdaewTeT2OU0B4ijMvoYj7o+?=
 =?us-ascii?Q?6q1R393B6O88d4JHgaUM9VQCJTphnFL4uadVLWuZdFD5NloEvoO1hgXrH8Fb?=
 =?us-ascii?Q?rDJE+Mq4rrojCBt5icfCSQMD2FY2M059lI8LPRvGqogSELTonozFanipnUz7?=
 =?us-ascii?Q?6zOg/GXk9INP5c/BwuqZZ6QxJiunqGqUZ4pv2ZoMrKznhvgRLpEtqTDgnyuG?=
 =?us-ascii?Q?p+OXfVBo5L2dkXYXwhCbzCQpNIMOKPXaa8TMQjm01t8YGUHJ8PbxAe02TaHH?=
 =?us-ascii?Q?7yP4xggW0ZIq//gpxPJRIi5htMkT2I71xYigxAbjQxkXtx+FEi+JxWd/euwV?=
 =?us-ascii?Q?PR2y2rxbcUfeRz/D/43B/OGpia3It3rQS70GlwBjiz7FlrmYUCLUAjEmgKsw?=
 =?us-ascii?Q?gMsj9ZDfpI/Bd4qI3OVre8n4DcUbJLt87jfIVk1v+velUqt20Qdye8s1TfyJ?=
 =?us-ascii?Q?bKUzAVi8FVN8xwFTBpbyn9Ojxp9qXEpmWbebN3TqY/n9vBkU2tzxLnylxIbF?=
 =?us-ascii?Q?4qGp9EqGGGhQJx0WXE+1wecUSsKBVXEsxokbu7ZWxJZy4sC3zeuw0nFXodqw?=
 =?us-ascii?Q?aRc6JGycQTJWsEM2O1vRIHmPlHYhUQIOLOaDnrJkBFIZAcxZeetkZIb4NQJu?=
 =?us-ascii?Q?lOdqydfImpzGBtrvouKjipm9x+IEStcefiTUV2WqkpR5bPcQUkIMrCAzo8Y1?=
 =?us-ascii?Q?zDe5wE5LWYu6nVNyaUyB9CjIXl/xOVtkcXLSDpy8xJYGdMywHROSuLqSYapp?=
 =?us-ascii?Q?9qf+ceBqYT38PL2Yxmw4uroXsSs7gZyuUqPZQdchRHdamL/DtNEiU58DRbRg?=
 =?us-ascii?Q?N1aqby8TmOzbNiQTHmIzLo9JfuLzpMSu4BL7Expvyfd795PSHsL2Cz/IAL85?=
 =?us-ascii?Q?wLjOeEDA6/CikU8l8Y3EHF9VCU0wcG9KdIBtyllf0hZaIAuopyAZW31Xevtp?=
 =?us-ascii?Q?/8+7XydU1HR4CgbioJ0NZFyt2xA/CRSC5wguKRIUHkK9JY9qgsHMj+GyRlB3?=
 =?us-ascii?Q?MbMENx98XvG3/SZyby8dvvXdQ7SDITtoRicipV2szGPsfYE0TX8kcActnmkC?=
 =?us-ascii?Q?qUStv6H1dBSefWPeyOcfEMyXIORqfB6Z2k7P1s9YNdiNxbTmAf83iTuDRHZm?=
 =?us-ascii?Q?pSYS91YtaDLtR/xhJ48SQtO8j/he3oVSPYTmJshVQ+RotqhS2+9IX4FKxUMB?=
 =?us-ascii?Q?/NyOiWD+3YPbAQc7IrSsSCvRq5QzGeYsl6HarzrvZ12c1M/DsPvxwL0ateBB?=
 =?us-ascii?Q?pqHpEH4nBoC1Rfpd72890H8oW2MEDTBKFz3mrtLKOBj+d9IbaDRaxuVA6hV7?=
 =?us-ascii?Q?G3SlFb3PugUn3UDGOTmw43LYWr64tSpJKE0AkB/3NYOiz7RSyZR59RCMcr37?=
 =?us-ascii?Q?/lhYnfpv4zGFAGhj3Wz+15enkQRPsxhz/ZYmp3DCxeD1TI83QMV4neD50hah?=
 =?us-ascii?Q?f2iAwXPRwfVm9GGAtldtyEXPoKVthoxo726Uye57k6pWko015VhK6li1mDrN?=
 =?us-ascii?Q?B6OrMnaboBwGAFIe0JGgpfTn49Va6coYgrP7l0VOiu+hDfPAWwyA2jXZiDjd?=
 =?us-ascii?Q?IFqLIObNuHL39TQt4x8dTylylwkWJTcRpZEkG5PDF7C1V5oOaJzwD0huPiZ0?=
 =?us-ascii?Q?bYRglolo8mERgCswOvkja/rTU7nL0Fwu522vMAFE7Kut6SXHhZ89O/dbfswn?=
 =?us-ascii?Q?LLs8k/ixjC9PB0poCup4fZSMCiinGda/x4eGKhKkC3R5vbp4ElbR7DFvKBtQ?=
 =?us-ascii?Q?N251xJMbIg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fQ5JXCOCyje2Pmo+VilKO/lJUqV6+57C+P4jmOpfYJn3t+F4cURJBucA+DvMWXflcu28JIqGvYBcyAM8nL9g5cfckiu5IdBl2P+glvsYfADcSpYK8WwkmrUe41apyNqQJR0SnEbUCossS411jo7prwqyucM9l0Q4q6oynGevWGxl2eHT3sOlbzYGVeDgSi1IJZhRFGCy11hAky3rogP+ySRF23j3rlDXy4ADwKC9W1i3pLVxf00UHpVlMC3xMWC9zLeyrnPw1BBusW72c6EPIkffWpCIoBSXPW9POaZwpdBy6lTv65Bahw6PSLXGHZlkFFvQG+Dy5QH5l3zHagIbgQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c65f5d-596c-4dfc-15ff-08dee3102c08
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 07:59:33.0657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fwKIibAh1io/XZTAc3mWaxylMHUS3tp9Nmi2KYng3RQq81Oj3SCrvr3yoEjPrAYhXoJZNRWKtmeqJ2YVVfspJIM/XKQHFalJnfDZGWQivmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF2D9C959A2
X-OriginatorOrg: intel.com


From: Yun Zhou <yun.zhou@windriver.com>=20
Sent: Thursday, July 16, 2026 8:47 AM

>syzbot reported a circular lock dependency involving tty ldisc_sem and
>the networking rtnl_mutex. The full chain is:
>
>  rtnl_mutex --> nft_commit_mutex --> ... --> ep->mtx --> ldisc_sem --> rt=
nl_mutex

Hi Yun

still unclear where the first mutex may come from

>
>The last edge (ldisc_sem -> rtnl_mutex) is created because tty line
>discipline .open() callbacks (slcan, slip) call register_netdev() which
>acquires rtnl_mutex, and .open() runs under ldisc_sem write lock in
>tty_set_ldisc().
>
>Fix by moving the .open() call outside the ldisc_sem write lock. The
>ldisc .open() is initialization of the NEW discipline after the old one
>has been closed - there is no need for ldisc_sem protection at this
>point since:
>
> - tty_lock is held throughout, preventing concurrent tty_set_ldisc,
>   hangup, or close
> - tty->ldisc is set to NULL during the window, so concurrent readers
>   (tty_ldisc_ref, tty_ldisc_ref_wait) see NULL and return immediately,
>   which callers already handle as a hangup condition
> - tty buffer data stays queued until the ldisc is installed
>
>The sequence becomes:
>  1. Hold ldisc_sem(write): close old ldisc, set tty->ldisc =3D NULL
>  2. Release ldisc_sem(write)
>  3. Call new_ldisc->ops->open() without ldisc_sem
>  4. Re-acquire ldisc_sem(write): install new ldisc (or restore old)
>  5. Release ldisc_sem(write)
>
>Reported-by: syzbot+de610eeef174bd59a8a3@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=3Dde610eeef174bd59a8a3

please add fixes tag and consider cc'ing stable kernel
please also add net tree tag to the patch title as this is fix

>Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
>---
> drivers/tty/tty_ldisc.c | 17 +++++++++++++++--
> 1 file changed, 15 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
>index 27fe8236f662..248a6995cc53 100644
>--- a/drivers/tty/tty_ldisc.c
>+++ b/drivers/tty/tty_ldisc.c
>@@ -556,15 +556,28 @@ int tty_set_ldisc(struct tty_struct *tty, int disc)
> 	/* Shutdown the old discipline. */
> 	tty_ldisc_close(tty, old_ldisc);
>=20
>-	/* Now set up the new line discipline. */
>-	tty->ldisc =3D new_ldisc;
>+	/* Clear tty->ldisc so concurrent readers back off during transition */
>+	tty->ldisc =3D NULL;
> 	tty_set_termios_ldisc(tty, disc);
>+	tty_ldisc_unlock(tty);
>=20
>+	/*

this blank line is redundant i believe

>+	 * Open the new discipline outside ldisc_sem. The ldisc .open()
>+	 * may acquire locks (e.g., rtnl_mutex) that would create circular
>+	 * dependencies if taken under ldisc_sem. tty_lock is still held,
>+	 * preventing concurrent ldisc changes and hangup.
>+	 */
> 	retval =3D tty_ldisc_open(tty, new_ldisc);
>+
>+	tty_ldisc_lock(tty, MAX_SCHEDULE_TIMEOUT);
>+
> 	if (retval < 0) {
> 		/* Back to the old one or N_TTY if we can't */
> 		tty_ldisc_put(new_ldisc);
> 		tty_ldisc_restore(tty, old_ldisc);
>+	} else {
>+		/* Success - install new ldisc */

rather obvious comment

>+		tty->ldisc =3D new_ldisc;
> 	}
>=20
> 	if (tty->ldisc->ops->num !=3D old_ldisc->ops->num && tty->ops->set_ldisc=
) {
>--=20
>2.43.0


