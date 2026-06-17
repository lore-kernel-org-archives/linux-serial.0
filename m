Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010062.outbound.protection.outlook.com [52.101.69.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADA83BBFDA;
	Wed, 17 Jun 2026 07:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781681222; cv=fail; b=u3LKD9lBr+UoXrAiSqsoue8iwDqoHD+/3vRyhjrPU0yZRgmsxu2IBYIuNFYIHscIT7iosK9lnYVBZ9/zUUQ0eHVtMNNgfjDtmtECWkovUHok2uAYUk9VchJ2dPHqM17Vcl0d+mFBq+aLKIGFbUHhdXLpKquaPXHEgp8dMlauzZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781681222; c=relaxed/simple;
	bh=wGT2qKynIGv40yHjk6YjJTevLIPltmhMuv86Ox2bk0w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ucry0AUD5/BgDfkueKoIKMuwwfk9wPPmH3vWhJ3Wzcmd16kOvRT0Wg6ercBYzUFvGcyCXW1yyyYnxuJVSknC/yqRli6atiNGvTizrLF3DVSBW5M/2Bnd+iawVTOBeeot1ujEq3J1zOlliUtvOVBQnWfbYLJ0ypnIEIeGtgakclU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=WQ0lppN4; arc=fail smtp.client-ip=52.101.69.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="WQ0lppN4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQ1+3QbsVfNDphpn2tOAZvWRW7LI1SAKzOAp4HQtMRWGThxEsd3hU0xyYLBaKNSEUHyKbpZXkj8QYd1obiNnZa+XuRkzmrAbujNrMNnIbg4Lc8B1BJFVuUW1Jr5MMhhCyd/B4Uttzwu/IHDl/bnvNOwVZnqw0U4/RjxAiAnhhBngs8QGEq3VpEXBpS2WhvJ9YTwImUTdnZTC9gfxqa4rSGc0/jweHcHYuUwZXXd/xdhJ267bdoX7+vQRRIBd6fUiW0d8QJp0uAFaSt/Ez5SdOTlUnbwL0HBPJp1o9sq+5DgtSXkHcTLwD7koWrqpg3mnEQr5QOM433ifu1ld3TIguw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPoj4RlIarLimVX8uv1FakpBjWFokRv57cP9NS7ZD1U=;
 b=myXh20noN0UIN1I+2+D/+fjNPK8NAZfP5JYGHQ1pgX0+KLjs/EgI/NERSXSacpjUy8uJR+BuRxr82em/9FL+Up7W3oWeNtDUhHh1V5xH90kT7u3GCU+980pTG6aMh4mRlt4Sg9X5EOzRWTcjel/LTEQoB9wJOK4C+YFs9RDQTjoxtIw1y58x1Y9ylvInXt1NwBhNeK2iVoS0XIdT7BWDjC8UZxt4CiWDC3RjO8X4x4+qIXgvyAtBivQk0tElxXLYFb++kvrChD6+8kIIAgOI+CnG8GCqCqrUrqY2r6znVZEC+dt1ACedziFSAXxQ9+HOK7t3T90GzyQo7hiskLExFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPoj4RlIarLimVX8uv1FakpBjWFokRv57cP9NS7ZD1U=;
 b=WQ0lppN4IYrtLeKo/8YwZG53opkwfHortsJIeMDy4AJqy9nKGt9bNxjDph4Illa+ZsbgCk2AmGEZ1oVqhRxVFDSQcMVQb7EV6oNriv8NHVIYWSnIDobQToRiFiVBBZrGmxZqx7G9JmigiUMAoZlCl1liVsG14S9hH1yoEjBJBpnsLBmIee8Bf1GnQKeTZuxtkET+BvyRW4bIFdGf4HOmuVgBscAToNPIg+3nUaqDyw8hYNWGUDWSBYc1/2ZWsiMvtRniHfV30/L2q7zUng5S2ZCdtHaqVoF+oSEOMOGhJ1ZmN3//aKSe5mGvED8oxI/iOkYjGvD3PxI9wgrTDpvJFQ==
Received: from DU0PR10MB5387.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:329::14)
 by GVXPR10MB8825.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 07:26:54 +0000
Received: from DU0PR10MB5387.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::de46:63f0:fed4:cdef]) by DU0PR10MB5387.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::de46:63f0:fed4:cdef%6]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 07:26:53 +0000
From: "Starke, Daniel" <daniel.starke@siemens.com>
To: Weiming Shi <bestswngs@gmail.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Shuah Khan
	<shuah@kernel.org>
CC: Xiang Mei <xmei5@asu.edu>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/2] tty: n_gsm: fix gsm_queue() UAF and add a base
 regression test
Thread-Topic: [PATCH v2 0/2] tty: n_gsm: fix gsm_queue() UAF and add a base
 regression test
Thread-Index: AQHc/bYyDzTFkO+P0EiEa/vOFdi7VrZCWemQ
Date: Wed, 17 Jun 2026 07:26:53 +0000
Message-ID:
 <DU0PR10MB538744C92335756B7F125867E0E42@DU0PR10MB5387.EURPRD10.PROD.OUTLOOK.COM>
References: <20260616173240.3665059-1-bestswngs@gmail.com>
In-Reply-To: <20260616173240.3665059-1-bestswngs@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=2e44fc8a-9f7c-445e-bd44-692a14ddfd64;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-06-17T07:04:25Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB5387:EE_|GVXPR10MB8825:EE_
x-ms-office365-filtering-correlation-id: 5d84f3d1-3a64-483b-8687-08decc41ce52
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|55112099003|38070700021|22082099003|18002099003|11063799006|56012099006|6133799003;
x-microsoft-antispam-message-info:
 qST6RYcbcuF/YSOPpKU4L5Kj6dujyM+tcMnv5MlgPhJplSWkY5U9zs1ajw7SE3zErAYlboQjMYgbY4yaa2L6Fn7ZYGMVXVmfeqakoX3tZIRYpeQoqYzxBXJsfJLL3X7PwwrkOn25C1c0KQw5t/xpmqJp39echt33SXK1J0jw4Rtd4+RRmomy1UeWkE8yCbVOc2w1hmxHWlLqVKObhNe8P4pJIzQ14POmIDcLSxPSaSLguGdBLSlwM2awsT1RlKDW9RcE3RaQXgEdnlApO4wMCvogmyWSTeSs3uxK1V3F7D5SacgPWp+/zlT+RCz05SA7n1aoK130D9dwHEHifW68XmcdL3xSNvDBHbnjW1m1i1k/pdL7ajNV0FUxlHT4PBDu5tIFrjfPrds83uY5OWxm356VTBP6T3GAFmzRi/r8VNlT+wlLsjJaaYQQwqAAryvhSTQLvwBVyij+uwy1eLCDtztNT3vpSIfH3LooPaxZFo1xzfKlE/PCgJ0gVMzjwHRH4dnystGZaZaZM9PFdSwomQPGsmQglTFuber68HC64COwZNArLlhlbq5TsWSrSgs6/LLEOrL6RAW1NIPndGYul5UFCVDcbwNs7vcO9oDsvikmfSwOQf7p1n6ENIm1zVSatLf1BzzLiJs0xy7BkT0veyDr1RA2C8Of1pSvJM3wQCbIgbK4NJ9R+U3CUK1iXdH6eYMW0x3MwDT5ATp+HHXUl3hxsTjQeFxdAu504YSUhSBqVNetgu6B49jOmIURK4TR
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB5387.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(55112099003)(38070700021)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Bg7/qL1zb4DA1db6inwl1D70oOaD5ErOoRI/4YjhKF5Yva5KBC3RUTL2vDIV?=
 =?us-ascii?Q?aA9ZlXjfTP1PlCeOS253aBd2V43lJKBfV+pk1nn3+g6Kmt+zSwbf6M90gJlO?=
 =?us-ascii?Q?45o1lA5gJZueyLazEd3VTF5h+L1wK7aENrjUzbEI0owLXTPdFg7FixYr3+v5?=
 =?us-ascii?Q?EgRjLB72f79gVhYXx9JvEShQt9zQ5H9g442yHDB6AfcSNP0wwKSMXI5/VDXS?=
 =?us-ascii?Q?adhk0cV6gnNPqh1LkVqtlSj2ZMTWkKiwMS0RopWIUz+4DYcaMQlwxlgkCQvm?=
 =?us-ascii?Q?RfQiHHRF2w2ftU3/68hK7JRKN93r23WKU3Oy3L9hsGXCfxKd2S6QfPCgF5g/?=
 =?us-ascii?Q?5kdxetTy9GJs0c2xt/ZRyxb+O6ME09v8I8CAwMkjWufp7oABTh4IcG/yIgbQ?=
 =?us-ascii?Q?fQ22aTMWzUFcVPswHcDEKrl0iZ1WTWbsdfRfDj0DL1HWpoZdJB3kYzpP/Bkj?=
 =?us-ascii?Q?9wLkrHMW3sExddTz3N9nWV/N7sXZ8oDI5BIxsiJhLKsQkJvxo9gXNm+EyIIp?=
 =?us-ascii?Q?BeAqeSErBSli7mNj8bqRxnyCksmtpdAMWuUtdkWIj5C6pRtAtEsPgZ1uJjkR?=
 =?us-ascii?Q?df2hq9bwb6ehz0TWQIwzCjUJfDHENuJs2ljdBlT5f1/jE0jX90C2NvREDUuo?=
 =?us-ascii?Q?k9uN46frPmgWqPbBsRsWObgYUxNkUKKNzAwCmvqg7QRpDb6huZI8XyKksupc?=
 =?us-ascii?Q?GjdrTCxNzrJrVR4DiT9/+KoVRKZ4O+mF9AETVUnrmasVHX3zsJKrLxSTN1Kb?=
 =?us-ascii?Q?OEjIetnxkotpwqUrLvd1Xo6gqPDkZM+G1kWHDgGAAt7Mf1X/lWFFJTRWo/19?=
 =?us-ascii?Q?kCdoTICbrNUVZNF3VqJFwoinX+hF6vBlC/qHRNJKIoOtuVPL9VSzbVHsVFrB?=
 =?us-ascii?Q?JfRFUv8zM4M/RseWuENd8uoIfPQyuTsKrDm4dvdHS7/JF6L5DO0bWB7Gtszc?=
 =?us-ascii?Q?diTdJnPT+izDGe/Fy8657Ma03cKZcA7CW2sD4Ebc/Ox7zfzGLxNgVOHi4jhe?=
 =?us-ascii?Q?TOqiYy1d8FopSLeG9CcJJ4SZ8fg3BK7f52Z+zHfb5SIoOATEVLDpsnlUWFIg?=
 =?us-ascii?Q?JQf8tukEzF5pkJRyYagznJ3IxlbZcsySOe7Ex7tADP7JhPxNPiZHLVZtBrPT?=
 =?us-ascii?Q?RmDN1vgAIUeMPNWrqaq/kACtby7hoQPpDEQtrzM+mNoXFYc3udSHSkodZjyz?=
 =?us-ascii?Q?s7bLaNEhYTa74cqPGLyh4BWJfgvBWFz7h+kb6J6GoDNoQhZ0ybNUUwaISPNS?=
 =?us-ascii?Q?mYWC7rSlpF9HQ+PGUQEquqshJVR3EOmEnB8oSL0bDcQZ/eYL6QbmhiVBoirJ?=
 =?us-ascii?Q?ziqTu4qsV1XVzYdqPD8wqohM8KsWq7Pzh1CXHkwjdZk5rhe7CDrlBuIcg+7n?=
 =?us-ascii?Q?qJzpCYXevz6MA7QZJ4jBFPIvh/19heaoRwMdiQWesumLKLe3jX9yRT47GBwf?=
 =?us-ascii?Q?cNiVe683SdfAOifa3rJBBQeR+fK2XSbTlLUk9Q/lyylJAw6IvcCEmT6oSmLn?=
 =?us-ascii?Q?ivQBBF3b+qIga4EE4RVxtRoKfyHddsAdsQFYRc/98lj3wwLBH9BbyyAxyH2o?=
 =?us-ascii?Q?6o507Zv8fUd73re1OAnIN97mhjnGnfYVNKC4PkpoweAEK48loi+5vCkfpYw+?=
 =?us-ascii?Q?6OQBbuadeJvHQiLx4f6RuCFMPXU79e/WJum6I7tC8p0xqPSZIBfra+gOF96a?=
 =?us-ascii?Q?cewngQzc+qy1M5NVoWA5LpsGjX2IQYFjt2/hTPkalejHA9icWiPkF6IIng9E?=
 =?us-ascii?Q?CxiP2ujmXA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5387.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d84f3d1-3a64-483b-8687-08decc41ce52
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 07:26:53.9307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QyVIvTK5r/rFlpr2yS+JUsCk9n3vqmYW+37cYEH6CA8TVvy24mhI3+11ApDMwN7r5kKqhpeVJSWgr/skRQXxfXSCvGh58EP56sEgWIiDzTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8825

> The receive worker walks gsm->dlci[] without gsm->mutex while a
> concurrent GSMIOC_SETCONF -> gsm_cleanup_mux() frees the DLCIs, so the
> control handlers can dereference a freed gsm_dlci. v1's NULL check only
> narrowed the window; v2 fixes the use-after-free itself.
>=20
> The fix pins each DLCI the dispatch dereferences with its existing
> tty_port reference (option 2), so the data path stays lock-free. See the
> patch 1 commit message for details, including why the late destructor
> uses cmpxchg() so it cannot wipe a re-created mux (Daniel's teardown
> concern).
>=20
> Changes since v1:
>  - Fix the UAF by reference-pinning instead of a NULL check in the
>    handlers; no gsm->mutex in the data path (Greg, Daniel).
>  - Pin every DLCI the dispatch touches, not just the addressed one:
>    MSC/RLS/PN operate on gsm->dlci[k] named in the payload.
>  - Add a base selftest (patch 2), as Greg asked.
>=20
> Verification (KASAN, panic_on_warn=3D1): the originally reported splat is
> the gsm_control_reply() / CMD_TEST path (see the Link in patch 1). A
> reproducer targeting the MSC handler crashes the unpatched kernel and
> survives 270 race rounds on v2. The selftest passes on both the clean
> and patched kernel (pass:3 fail:0 skip:0).
>=20
> Weiming Shi (2):
>   tty: n_gsm: fix use-after-free in gsm_queue() control frame dispatch
>   selftests: tty: add base regression test for n_gsm line discipline

So now there is a race on device node level. We have the old virtual
gsmttys still waiting for the current pending operations to finish while
the reconfiguration of the ldisc triggers a recreation of these. How is
this handled?

PATCH 1/2:

> -	if (addr =3D=3D 0 || addr >=3D NUM_DLCI || gsm->dlci[addr] =3D=3D NULL)
> +	if (addr =3D=3D 0)
>  		return;
> -	dlci =3D gsm->dlci[addr];

Control octets can be transmitted on non-control DLCIs in convergence layer
type 2. You do not guard against invalid DLCIs anymore. Same for parameter
negotiation and RLS.

> Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
> Cc: stable@vger.kernel.org
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Link: https://lore.kernel.org/all/DJ7OKN8EMAK8.22CE0B8NZXD73@gmail.com/
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

This whole worker separation was added later, not in e1eaea46bb40. Maybe
worth updating to the corresponding commit.
Also, the code comments have a strong AI flavor but AI use was only
disclosed for PATCH 2/2.

Best regards,
Daniel Starke
