Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011041.outbound.protection.outlook.com [52.101.70.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF2FEED8;
	Fri, 19 Jun 2026 07:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781853244; cv=fail; b=UW7nLEH9KrHRci+iCw2fdMAhoZzZQaAHMlRrPodVUv1HVocyktssmMoZIhkUuyRVfwk7s0hn/LacgQo1IdMDnVPBdlsVUTT+Gf5BK9a4jU+A9+Ya6ST7a960RRWY8eAzOHWHyee/qm4n6VFGSrRaO7LeNVFdGll/KmpdwoXV6ZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781853244; c=relaxed/simple;
	bh=uXCAfopvY8fLr59AduMBTRhpKhAPPlbWj2zufa3TeB0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qKB82n3YypMRxJVPOoJlKbbzbuFLZgIJR+1dG8xKKKCxlmXfBpHnVnsRRbHV/b0Wr2vSOVDbLXARwbpbjMLzbVk3HONVyoQd6mLM2bkF6qiXJWVnB9NQjIJsGWnkK0D+Bp8zIJCTR2FuGojUDajPfZLwfKi/uir6aP2mCIvY+fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=FMKiCeqv; arc=fail smtp.client-ip=52.101.70.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="FMKiCeqv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpUfGgczrs7Ez5pNpCU7IPpM/8uDsxJkMZR6AblcDOvgcuFNmnDKrexrn73kyfotj1vLF+QOEl+x0JxSlhCLbi07Ipuzu7no7RhFIzIIjKFvptL01cUS+ojb5pLka8eB5R1IBoQycKu4LMfwM34WeMqI2w2dz68AWl33yazPAhvvAnREFMtB73M1bFVeDVjmBbw9M5OQev6V+9eSbuBsn2y8F0N5Lhm+MSOBQa2VLTp4g68bc8pxBkWMJVCtTy6FaBYmoAwMoZbgC0hXuDVk83XvEkpgH1yElSWOXMBBYA6JLrL6QmQCEVyl2rqxim3fNHn4S1Sr/PxiOsvdAkPEFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HD5r+aRftWCTf1PRTdHdIMjyovOntf/hzCiiRzHisjE=;
 b=TI4jmwSFYQ3+BSh+hOj5t86mXQVEiQH+MkeLs4NTgCl7cm61eCqx15pzwuS2AMazsR8j9TnakcqWZhV2xyjKBB/cQvCA66StUJyeRk3ojvMY72tZ68WgK0QOdEvpq/SCdgkmaFO7E2bS8Zu2UdgG9QaeSgbjW9ACum7myol1+S/2rebWew0siRkcgmcIEpapU+Shu/U+I/QACS4WF3+cfCmcuNn1b3HxTFSdkO4VAzmZgXB4ecOSTr394J6lqxgKGtS+VwOkIaimjyeInFeXC8KBjuE6JXpEji46Q9XOXr1/Dzj/QSAIjj+dL0R9Xs2zBeaiG18lxEeG4+ITyChPeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HD5r+aRftWCTf1PRTdHdIMjyovOntf/hzCiiRzHisjE=;
 b=FMKiCeqvxEHc1CO3WCQ7uoAgTfwfSSncdwCiMOTRwzwoE1IMtgFwxr2oBr7gLYEzyX7PVAu9n6yQ+Sap5qQo6rXBWID05m8hbGuYlejItvscAI6G4DCU+XQCrl1W/iuywo9L2JptolSy16OpwBOYKbWoLmuaGQD8Swwz4yo8LPvWQWuV0gvfZe3FIW67KQpnBei4DLHKzcsxvxlqcxEDDzyqbjnfwWP7bO41Ze2MoTblWbMnwtwmJqC0u00BWp8uVFBNjDlyNkSun6CdX0jf6XifVBJ059J6C18MD6rSEJ/SnCcgNiI7iaWigAIQWwX+ub5U86i0X78LECV6hr0nFQ==
Received: from DU0PR10MB5387.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:329::14)
 by AMDPR10MB9502.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:739::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 07:13:58 +0000
Received: from DU0PR10MB5387.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::de46:63f0:fed4:cdef]) by DU0PR10MB5387.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::de46:63f0:fed4:cdef%6]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 07:13:58 +0000
From: "Starke, Daniel" <daniel.starke@siemens.com>
To: Weiming Shi <bestswngs@gmail.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, Shuah Khan <shuah@kernel.org>, Xiang Mei
	<xmei5@asu.edu>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/2] tty: n_gsm: fix gsm_queue() UAF and add a base
 regression test
Thread-Topic: [PATCH v2 0/2] tty: n_gsm: fix gsm_queue() UAF and add a base
 regression test
Thread-Index: AQHc/bYyDzTFkO+P0EiEa/vOFdi7VrZCWemQgAIssYCAAPRcEA==
Date: Fri, 19 Jun 2026 07:13:58 +0000
Message-ID:
 <DU0PR10MB5387B831C4F2240AC3B03984E0E22@DU0PR10MB5387.EURPRD10.PROD.OUTLOOK.COM>
References: <20260616173240.3665059-1-bestswngs@gmail.com>
 <DU0PR10MB538744C92335756B7F125867E0E42@DU0PR10MB5387.EURPRD10.PROD.OUTLOOK.COM>
 <CANgPUi24wvQ4CLMozb3EBAC-5QKWiMHWpoCQgsBHkG+vZjHALg@mail.gmail.com>
In-Reply-To:
 <CANgPUi24wvQ4CLMozb3EBAC-5QKWiMHWpoCQgsBHkG+vZjHALg@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=2baab01c-1e9b-45a2-904f-2b0d03e768e7;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-06-19T07:01:07Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB5387:EE_|AMDPR10MB9502:EE_
x-ms-office365-filtering-correlation-id: 67c1dc71-b025-4d1b-7e64-08decdd2550b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|56012099006|11063799006|6133799003|18002099003|22082099003|4143699003|55112099003|38070700021;
x-microsoft-antispam-message-info:
 MzNWYATiRvH62BM/97FrEqxvmFpDoLtkdtTRBZJj7dfyBKGP/hsgXkVw2wMyjlwNcIq9u4SIPmOZCGQrNzpkINqVWnrCWaghXZEBBfzWisufxNGAbwhrbX+RgonH2g/s3OK69h6iiFJVmnFwc53NXs0oEnjwGcKSzfOXn/2HX6OUMEmkWYWBu4riThrjgORp/KjJag5rd75nQ8Shu/Yp0cFWqkmlOVDlm+M2uZ+ACy416r8uRWg/OmrXtV9w9phaaPb/MMOh8gkqmib8mvsi1IPySp+xer3gb0NKBHDBWNwltDvPDjiz2fznNCgADHt24BDr5OdtJ8OrszqDP2NI6MuSv1cGyxFcNuQgnjR8LNXxd1ojxLFfl6m4TI6/eBb1FZ1aR/NJGhvEzrQqrpaiVQ8BEMuzZNmCH0ZxpEObsIb+FJtq6WGMnzGQRCLfKSPCUoX6QUftwQVxxvWQWoC/swIAhphi5EyDrQbFLiYatlo6WGWgvCAvRuuj5d5ret3yh4/1RWZXPQPWT3lNWURZkWpW7SbVf2vg4ySmQsll8CM3eU2HSSTcXHD4SeysafnZnmNUd51yWvZhKkIbAiQwUXtCV+Vnb7CC0g0/Dwl0zGj2mh/7IosvrU3h+HAXq0+l77DFc3uNmVIZGRU9KTGbc0YNYQzrX80AI2SjKLc2b4gPcYGoWH20PDXVjNgUSAzsrYaSYbIXVYE5tsGTCa7v1Vo+1ugbwT+F+Ykkjd/eQzI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB5387.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003)(4143699003)(55112099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ma9nckuFXnvf20+TDU3n3UwazJEMwkkgUzEPmManHnBOPb5QYuEo10d3fNoD?=
 =?us-ascii?Q?Ms0ofb6aHepkLdEYPSCeEewfI3X83SFCBIbk6DeU13KPXp0UYns71rmnoOT6?=
 =?us-ascii?Q?U2PuP9ThJybs3nVn8VEuY97Y8BLgUm3d2Ysd9ZczCqb8sBLNqqM1bZReW68z?=
 =?us-ascii?Q?IbDA4AcGokX9YWw0rlwdm75rYa92X2qHYyeFrmFeJAF5WUSaXSJk+m7kfuiE?=
 =?us-ascii?Q?LImL8kF1Df3OKehG+horyaN40cH5NO3oVElGj3py5sSv4oAkBfebQl7CKMnI?=
 =?us-ascii?Q?cRl9AL+PvFwr4cMCEMoVpy1I2FggWSJwCSGfMET58RefecKIuh/GkobYXHFl?=
 =?us-ascii?Q?DgyJyHJiFLVmhM978jpZx4/ttCGjBqwjYCan4NnnW6Oo8ywzzEVxeDsI8zF2?=
 =?us-ascii?Q?KSonbFZlduAhvkmbIxiW/LZxGMsWovbFOdR0upsBuUzAWfc/y4d5tD1KjMbB?=
 =?us-ascii?Q?sfe+ZJQN5To/qigW7ipOsSp+fKwPVyw60gyx7LvmMP+4BzhfFs9D3covfWnu?=
 =?us-ascii?Q?2MqDSmwspW3UNrFjOIPzqd4Fm5lTh7RJoPTAe9CUbg17C0W2oi4wGNuI5kQe?=
 =?us-ascii?Q?GF4rs6J85FOgU6Em1GDhJTzCbK5MC/Ls4c7jtZ2FuhikslbfyZkdGKmgkUdl?=
 =?us-ascii?Q?t1CJdt5MtgkPhGfy8ITJDl1XPWN9oPU5iG73RdgcrxTJOu3k+/3sdLwjRMhm?=
 =?us-ascii?Q?yAUk1qo/L5CsusNrqWBPBVnXIjgHCjvQuDeFo4Hf58spB5HeFCvLm/EOpqQx?=
 =?us-ascii?Q?WAPe9ekU6dH3hwDqagi8EgmStEsLZg8qXqV8l4REs4WfR3ZuRN0DwDOrDiCw?=
 =?us-ascii?Q?UssO0bZ0only+vvZzYastnfwuRJZIArIL/Z8fS6cnxTUlb2VBPzER0LmtfXd?=
 =?us-ascii?Q?z8m+5uPIe71NIasdsrXTFRP1wh6VJ54/KfjYyQY+jhSehfgvN/s51YmhN8Qw?=
 =?us-ascii?Q?6jaNUGpIBf8QlMhEu8BnBn+fEV8oFIkCu50vz4ymEX7RIThY8EdXUPDO47ip?=
 =?us-ascii?Q?SjhNr59OOaNvqPbJuddhC9N98QdPDm2UfwPmbGuluDdSDmTCk74V4MFsqiHE?=
 =?us-ascii?Q?K4YJdjq1fICOekDyMO6NH4L9YoCadmf280qasXhoohCueAyfTEtSKJphBNkr?=
 =?us-ascii?Q?a3xVz4cZbHV9otUwCPd/myE5EfmWfM78CyiVYUkjd0WyIwqH0aDvrdxzyimx?=
 =?us-ascii?Q?XdTvexpHRlQds2gWUt41RWOzYv5Q0WDLQwQt5rccYGhcLKwpHGIIl0NT7jin?=
 =?us-ascii?Q?cvWWvifrZuQEFlzdLwUW2S/94aa+EYMZOrrofOfCkMmX0SS2mSqzMHZLo4hI?=
 =?us-ascii?Q?qs20yW58i399VIPGRoBtg83lT3CGjSK3UAw/6jhrcJL0V2vY+pfldzS6QHgC?=
 =?us-ascii?Q?SYcwgcX1DV0fm46OxyPYxhW8O1kXBvN5R4LNPVeipM3aOclk3cwz9HUWs4FY?=
 =?us-ascii?Q?vywCtxGr2Wc5SuhdpEHigZi5ly3LMyWQcV2d6Jv6Tfo7RSauHFBRtpqY/66w?=
 =?us-ascii?Q?abZRDyP/dFsNL2xtHnaHe4BOMyiKw1tWkLXglQT9w85yU1/EphIa3yscl6kl?=
 =?us-ascii?Q?fE1G1s8aOts/MmIGNpoZ9cq2Zh+ibs4c+fhH/tCB/t1kzcujEqkwgqpEZX1T?=
 =?us-ascii?Q?p6hmH0EuSksSR9Ly+2OL6uRqC91WcEPd2fLnSmU3ELF0Y6TktWoAWQkvQQle?=
 =?us-ascii?Q?y0ycuO652R0TcVNNwP+sww84xJvk3NnGXRHGp2YRJTBMYy4amdII4gbqqIfU?=
 =?us-ascii?Q?5qzKCwbMCw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c1dc71-b025-4d1b-7e64-08decdd2550b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2026 07:13:58.5791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xz4Kznnwqb/7W2OhENJFWLO/kL6qkhja++9WZr1aRjsB4AQ/m4IeQbf8SJT6NzEuntqWEnqbr1I43yviabduGF+XSQ9LhNpvcuUK/Mj0SrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR10MB9502

> > > The receive worker walks gsm->dlci[] without gsm->mutex while a
> > > concurrent GSMIOC_SETCONF -> gsm_cleanup_mux() frees the DLCIs, so th=
e
> > > control handlers can dereference a freed gsm_dlci. v1's NULL check on=
ly
> > > narrowed the window; v2 fixes the use-after-free itself.
> > >
> > > The fix pins each DLCI the dispatch dereferences with its existing
> > > tty_port reference (option 2), so the data path stays lock-free. See =
the
> > > patch 1 commit message for details, including why the late destructor
> > > uses cmpxchg() so it cannot wipe a re-created mux (Daniel's teardown
> > > concern).
> > >
> > > Changes since v1:
> > >  - Fix the UAF by reference-pinning instead of a NULL check in the
> > >    handlers; no gsm->mutex in the data path (Greg, Daniel).
> > >  - Pin every DLCI the dispatch touches, not just the addressed one:
> > >    MSC/RLS/PN operate on gsm->dlci[k] named in the payload.
> > >  - Add a base selftest (patch 2), as Greg asked.
> > >
> > > Verification (KASAN, panic_on_warn=3D1): the originally reported spla=
t is
> > > the gsm_control_reply() / CMD_TEST path (see the Link in patch 1). A
> > > reproducer targeting the MSC handler crashes the unpatched kernel and
> > > survives 270 race rounds on v2. The selftest passes on both the clean
> > > and patched kernel (pass:3 fail:0 skip:0).
> > >
> > > Weiming Shi (2):
> > >   tty: n_gsm: fix use-after-free in gsm_queue() control frame dispatc=
h
> > >   selftests: tty: add base regression test for n_gsm line discipline
> >
> > So now there is a race on device node level. We have the old virtual
> > gsmttys still waiting for the current pending operations to finish whil=
e
> > the reconfiguration of the ldisc triggers a recreation of these. How is
> > this handled?
> >
> A pending gsmtty operation stays bound to the old object. gsmtty_install(=
)
> takes a dlci_get() and the gsmtty ops use tty->driver_data, not gsm->dlci=
[],
> so an open fd keeps its own reference and never reaches the recreated dlc=
i
> (a fresh gsm_dlci_alloc()). On teardown gsm_dlci_release() does
> tty_vhangup(), which unblocks the pending ops, and sets DLCI_CLOSED, whic=
h
> every gsmtty op checks first.
>=20
> This is the existing tty_port refcount, and the receive path here uses th=
e
> same dlci_get/put, so I don't think the pin adds a device-node race. But
> you know this hardware better than I do; if there's a path I'm missing,
> point me at it.

Sounds right. Thank you for the explanation. My tty internals understanding
is rather shallow.

> > PATCH 1/2:
> >
> > > -     if (addr =3D=3D 0 || addr >=3D NUM_DLCI || gsm->dlci[addr] =3D=
=3D NULL)
> > > +     if (addr =3D=3D 0)
> > >               return;
> > > -     dlci =3D gsm->dlci[addr];
> >
> > Control octets can be transmitted on non-control DLCIs in convergence l=
ayer
> > type 2. You do not guard against invalid DLCIs anymore. Same for parame=
ter
> > negotiation and RLS.
> >
>=20
> The checks aren't dropped, just folded into gsm_dlci_open_get(), which
> returns NULL for addr >=3D NUM_DLCI and for an empty slot. But hiding the=
m
> in the lookup makes the diff read like the guard is gone, which was a bad
> call. For v4, maybe we should keep the addr checks at the call sites and
> et the helper only do the locked lookup and pin, so the guard stays
> visible where the DLCI is used? Does that match what you'd expect?

Let's revisit the code for gsm_control_modem for example:
	len =3D gsm_read_ea_val(&addr, data, cl);
	if (len < 1)
		return;

	addr >>=3D 1;
	/* Closed port, or invalid ? */
	if (addr =3D=3D 0 || addr >=3D NUM_DLCI || gsm->dlci[addr] =3D=3D NULL)
		return;
	dlci =3D gsm->dlci[addr];
Without the addr >=3D NUM_DLCI part you access the dlci array at a possible
out of bounds index if the received data was broken. Let us keep input data
validation at system boundaries. You also risk dereferencing a null
pointer if the requested DLCI has not been allocated, i.e. opened, yet.
Hence, both checks should be kept in place.

Best regards,
Daniel Starke
