Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461CE1925A5;
	Thu, 26 Sep 2024 07:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727336624; cv=fail; b=axDEhfteTkcApzKuq1gengGeBI2Rt5DUduIzftW7sP6ky1C1qS79AQ3hH9cKTQerl2/0iEfT8hkH/+6bSSLbOavCfDiXP0GksTEoPaUgAwvjXGBjBGsHrTLmGZqOMUKXYGAzj9kdLOX+Tn0v8kJHHGu3RvJlXlWuZX6ibWDBZkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727336624; c=relaxed/simple;
	bh=VMNUCqGmkViTUcfOUX8a3U+jTzPZD8NvDwR7rl3Ppp8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CgxlrgR6d8WZDV7NoGZ9WrHGzUxU7r2P1MDnsiN7j+hYgVS1QL3gHUjI0uu5cBGghq5gpAvDozfmzxHWO0Sp6gr/LZCM9lbQiaU0oUGn3QntI9iCTumw0H9rV+d5/GztVl5PLq0UyuamRSsOsiWW7fbvi3x8rciGZGbsle57/KQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=IPywBVh+; arc=fail smtp.client-ip=40.107.20.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="IPywBVh+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3chv68PvDN5jE/NOBOmIm5+J/FpP3kTa/IJbvZEcXa29GPA8n4azV5BQCOAYzbOW32AUrtV02WlYCwaW82cftr0kTcQdTlD5erh1hTfIQrkwe4j2zHQlurSs7feacxhS0w0Kr3cSsdK0QHhs60H85z3tffyO+GLpkretvd2MkiQqgctcvxc2NQ9EM+DJAhelVG9eTReY8cU/XUB7QdEs05BLn/ILz0vqd+7tzBFlzXC8a6ETjTFKCJGwAJmi93w1Q9cOgBpvFrs2x/qU61VscPd/boG/uK3WNr8Kj4iF6XvspOjscyS6VwRC3/QLUoxSs4dWrde5gWHSZADycGgbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMNUCqGmkViTUcfOUX8a3U+jTzPZD8NvDwR7rl3Ppp8=;
 b=VLs2mrUrrr2miSq8OoxAN4X3QKJsyM9aqABYKyX8KY5XnXLMDuC3ie/t5E23RzwF/LEeoVwzCGb/C68sY9bCrHo/tEhHuAggg8Jxt4YaNTnT8T4fGoitqzEW4EhbceglGCkzI6zdUyyObp3Bgak748pFs5THfPy234AdbaMqWFzBL5r6Fk+ocqpzdJRuY3P/WqQbS3zo5LslckW4Mojiz3o0/8FLL+RHIBjtqQ4/DGiN5bfJEpjoI9X5BOTfIOOK2a8aY/uDO5Rp2nAj9a50DAHhDvZC7JZKwzO6Zwmaxm8ZmjmDnuOCIvzsOoDMEDMIypHpyhxlaTjioTrwTnRlVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMNUCqGmkViTUcfOUX8a3U+jTzPZD8NvDwR7rl3Ppp8=;
 b=IPywBVh+uDRXUFCURztzkDa8/yKqDYs9SXmmBdIs9VLySbDaeJrbRaThctBskIc1Y7U+gVRdnJqNJZ/zTDKGxRhheNvrtztLqB0r7ddZE6q1l3XPWK4H4QvNnknNxaZ66Piz7fz82yLDbcVqrv2VGF6je4sZbZmBz4soeyTJyUQcoU6z0it/yc8Gwdyhq6Mdza5fjxFH+HuME0gRzLWEltVI0gs055VSsXqCiSSfFc/CEMkxcdX7YhvVZBPQ5oT6gz1/QJmhyBNwJ/ZjDYZX05nnCS2vPfJY8POUbbYDmh91wu6+Ii5Ko2SMK4HM/lehUyfq8Yt29uD2ms4k57mn4w==
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:395::21)
 by VE1PR10MB3791.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:169::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 07:43:34 +0000
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fb9f:36e2:85c2:ffc]) by DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fb9f:36e2:85c2:ffc%7]) with mapi id 15.20.8005.017; Thu, 26 Sep 2024
 07:43:34 +0000
From: "Starke, Daniel" <daniel.starke@siemens.com>
To: "jirislaby@kernel.org" <jirislaby@kernel.org>
CC: Greg KH <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "xialonglong@kylinos.cn"
	<xialonglong@kylinos.cn>
Subject: Re: [PATCH 1/1] tty: n_gsm: Fix use-after-free in gsm_cleanup_mux
Thread-Topic: Re: [PATCH 1/1] tty: n_gsm: Fix use-after-free in
 gsm_cleanup_mux
Thread-Index: AdsP5we23L+IveK3TNKQpTUNAC/KjA==
Date: Thu, 26 Sep 2024 07:43:34 +0000
Message-ID:
 <DB9PR10MB588133D6FD3E5FD70E15E5C4E06A2@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=27c698df-c230-461d-9f12-9b50127fdaf4;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-09-26T07:38:07Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB5881:EE_|VE1PR10MB3791:EE_
x-ms-office365-filtering-correlation-id: 9fd28c89-8a6e-42bb-ef8b-08dcddfeed0c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?qoNifkXcarGPHaGRxMNJ6vCTJn3kcYd9FNGHk4DqT4Y29qWqiV/z4FECOFpr?=
 =?us-ascii?Q?NxvwYlPAe4ZINsBBH9Jp/+8tqPie/cJ41e/a1EJaGRRVbiIpaHwYXPWvltbu?=
 =?us-ascii?Q?C164NLgN8Dv6PAuF1H54YoPGYa7XlTHmVEfT6rUHm2wpWEAcqIMHDq3M+vc5?=
 =?us-ascii?Q?CjtPHeF97naqiGoYBFtwij45PKgweb3GXsez9yXgfpp7zhhqt7LMulMrNl4f?=
 =?us-ascii?Q?2K/JfzYtqXDxaRz6lf6tmw5yY7oWpJwM+snXjiWQB/P2TiZ2xPhgRXGD4ZqS?=
 =?us-ascii?Q?uFIJCiaOoW6PC8IbQlm36Hzy2CRConFhd7TBujuBmMdyo7jn5Ljq85OjJNCv?=
 =?us-ascii?Q?2W5D4TXw8T8yz8WXFv3ogzoHyTVtzy++6ep9uyx+6I7DaCGfDMJjQ3OV3Ddg?=
 =?us-ascii?Q?xcC2OPt9jtovO4tP7ZZZMSjamJ3mG8YYi19egQqtmB37AZGcxwbwwI2/krX0?=
 =?us-ascii?Q?O6LGjchqDA6cL49P9nlXoJ2tp44PfYtroUHvfeSf4r2m7490YEBRSij+wW5T?=
 =?us-ascii?Q?mKES01pSHXMlEOV5w41LZHM5Raq5cEjvR4h6P81nnBCm2INnK8WrUiQoax0W?=
 =?us-ascii?Q?6W6jRYqluduwVQrmbJ9u/2g8rPE2/zIIuRHu3EJR4KA/B5m93rzPUu40uYwH?=
 =?us-ascii?Q?6TefEEGPxq+N7rlf7fiPAFDQCzxfMpFS3sERZ7C5xl2pi/BF9nADmxN8P5nM?=
 =?us-ascii?Q?cchnhXbku2hSuE+3AcCJ4iLezuk2gtCf6tqpxvU7Ik7qFdImCOR3AAwW63EE?=
 =?us-ascii?Q?TgMGcNY91QHUuon5kdzTbvnsu3R5F1Gd4o5DCXjrN9Sgua32kEFTEVNCb2T9?=
 =?us-ascii?Q?lCF/K13C/FuL/n2WcBoXqhwEPTtiW7g8dlnMf32mA9aYbo2fcLmfSshN0dih?=
 =?us-ascii?Q?8RTj2fl06cFIXa6hLfe4TVrlkZ2W/KWq6bZ22YxA2neiqIk/2CnEpqzu9X2d?=
 =?us-ascii?Q?ZXCUtmEJ0Pr7VSRpbg2Jw/aHNk+/VQUcbqf6wcJBqNIC4v06GKjTI8iKGcVN?=
 =?us-ascii?Q?uHMMo6OpNbMyc+HId861Khs2TQM5lGHwwJT+BYYvn+S9KNgvdOelfNuy9IJQ?=
 =?us-ascii?Q?uPYZLbjMoY9511W0TNZ2XKP441aWWLZy99iXC79ZioZ7TusG50fTtRIDxnps?=
 =?us-ascii?Q?X8U56Gmcg3NUl+1tNeEbHycMeMNWQNXRWxamul++i4VfUjFVRVPOSRM86xbv?=
 =?us-ascii?Q?0PvsQmgYPOVdpA5AdprkDLfadNLa56fn7qkB7la/ogGgfawuZqAB+9HLjf5W?=
 =?us-ascii?Q?0ftZNq1NZ2C4PyK5vX2LPcM1+CjbGbWGKtANa5Wm6EZSgECxhxVUrtv6Zgb6?=
 =?us-ascii?Q?lhXHwm4x+O9LMSXN+PAwu01NLUnW0QJf7bIe/zBUaHc9HNaTUsna/o/2zx+G?=
 =?us-ascii?Q?KhgMDyZ/p5TKau6T/jTSRYfyaa5xaIvI0eakuCgP7XBhEODT9Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AHiHZ6EbxtTDAp1127MZjvryOVzulX7PpqgXWodi9XIXyV3eA/NNsAydMrcU?=
 =?us-ascii?Q?+DL3XOEscnED18M4LnapNSnrhCm9OZafeD0au+EpSSZ38j5ecO+omYwIWGBP?=
 =?us-ascii?Q?093C6xfLdTkXHgOV8lUHT9L0B3wTST/jx1tB+OTcxp/WHERBYE7cZV4GG8Th?=
 =?us-ascii?Q?lQTOSuPjwQCcO9JhFK1H9skVhqL2hhThTCag8pFcopee7sUckxQkZdKr8ihx?=
 =?us-ascii?Q?H+oCtmGnmVDp1OahSXxXaq433RO0ud1+yTh/ZGtrPJFpr6kw02OslY30gW6i?=
 =?us-ascii?Q?1sfr0Jy0B2xxdZEAeMOInHdC66gfKSTP2C5NG3Mp9kdLkYrDWkDF55c9vPer?=
 =?us-ascii?Q?0S/yQq3wzGamiQ1k6SZFkR6fWh7v4k0dcdLBt1vw8nen8hFsFsWNcE9e4EGS?=
 =?us-ascii?Q?xDZDTnmWu71DUzctQhlUlg/rMylStJ7+Dv/FzQbwKEHPIEf/VLuA+CMFmzUb?=
 =?us-ascii?Q?BJTxLeoAYUop8rvBoNUxjJc6lwetIBIQT/XQvaXjzLz5XPabp3cwrB4c0es4?=
 =?us-ascii?Q?ykiX2RlPr21S7gLx/SpTkGiBmfiISt9EYudfSpvgRuxkmND0is3ZDW0HdS/P?=
 =?us-ascii?Q?WvdS2QoqF7J2uh3Q8n0e0Eq3zYfey0F5MUGQ42uA1bRyFD47OURdAamiv/h5?=
 =?us-ascii?Q?FkDZleC/cnM/cF59l7qXQYZSI1vbnM7iNAWcYAALXV60fARKtxMp4cCNxLts?=
 =?us-ascii?Q?VqyQpROh9duZ0P6V371TtqC95zxWOzGhlNl7F+eXWEIkomX+Ray/9Ze0ibMe?=
 =?us-ascii?Q?AoS43j3X/06Zwe5mGo6Ko+a0C6gLiIhabaNNM9Vg1aBFBaEwFZmBi48T2D3Z?=
 =?us-ascii?Q?t+tNnWqu7fOMRDpkerdiAlkiRQMtQdDdYXyiGTFqQYyyqu8XBSQmHX/8fMCf?=
 =?us-ascii?Q?7o2JL/rPm/aIAwjeovmxQsGm+E4p3I2IbmjVXm2pPKAYCHjjExTbd0m+GxuL?=
 =?us-ascii?Q?Hl4sS9b7LjhK1ci91NGQ2AWmzCIRzbGdOe3hM0Lo/KtTlGfSG0hjd5cEWPsm?=
 =?us-ascii?Q?wR/3OGWcCq/3czBhTsn1RtfXg6X0t4jo+z+JpkaDIZZuTM14Vov/Ol+hlmUD?=
 =?us-ascii?Q?uXndHf20FQLvaKufs4x50xXR+X2ttIIU3RQRedBsaV7FvERyWFHAFEAds5jJ?=
 =?us-ascii?Q?BU03iDP3N1BZMv/WPUcwR0Y6qRzPSvd1ZBIUrXqjkjOvBlxaNwQWyC97mpMj?=
 =?us-ascii?Q?l22TfGQ10LK3ZPjuY1b/2GxtZnhXjKuMDsYfhEldx6FFWkT4Kr4bjVc2m0Y0?=
 =?us-ascii?Q?PYJTjmr2Lz8JGS7awNsZNB9YLybmefmS7QcYzD44bXTiapwxAHKPOG8YPOrd?=
 =?us-ascii?Q?xAS58tcG5CX8yhrSyUXibGbx+G5IFnaKCECG6XxIrVi4mGtWf4pGpkhxdinK?=
 =?us-ascii?Q?Ntz+FaDlwIYicLy8TahSVx+83Wd5vo13EACmXL+LOPUjfClhT891C7KPmMoe?=
 =?us-ascii?Q?wpf8aJ2xDUw8pKms/qcUO+Wxda1U3keTdjVw1n0SRBjBO8H7csoNqSFpvT/X?=
 =?us-ascii?Q?7zqLxprYDnt7yg24uVgzqurIwZ1AsBquRVbN/KQu3bUhtIzBm9GTy0xG2QM8?=
 =?us-ascii?Q?u7TqLX+IEzl8FbrYzF1Z8Vw0uv/CXv08v4eAZmYm?=
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
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd28c89-8a6e-42bb-ef8b-08dcddfeed0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 07:43:34.8015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QYswMet7uqeciPg2KekuVd8WFDgj+WS1Envz6hjXPV+p7F32AKH4zgaA7ORw7d5z1f62O8vdsR+cF2q6vT6wG6b7PnU6vZpwjEM60klmLo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3791

> > [Analysis]
> > gsm_msg on the tx_ctrl_list or tx_data_list of gsm_mux
> > can be freed by multi threads through ioctl,which leads
> > to the occurrence of uaf. Protect it by gsm tx lock.
>=20
> LGTM. But Daniel might have a different opinion...

Looks also good to me. I did not test it, but this will most likely solve
one of the many multi-threading issues in the n_gsm driver.

Best regards,
Daniel Starke
