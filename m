Received: from mx0b-0038b101.pphosted.com (mx0b-0038b101.pphosted.com [148.163.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B5231E848;
	Fri,  2 Oct 2026 04:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.137.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790915742; cv=fail; b=jGKYaMJ5pYtl8X8vOTVe8vET/eBJ1VHSmVqAYQrtSCX1avOQtLuwNuKXew0yHYrzHj0XZ3f+AmZ76CBMs713scHcEmtUBBucctAzhF+ZLObS8FLbk2XrvbLXA6OO26/AQvB+uwK/xFCSc+KS2UlPW8L0EX89npF5OPSle09pHN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790915742; c=relaxed/simple;
	bh=CCjbNrks13Ss1x9Crf9QLhaEQoY7QStVzOM2q8RiHJE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l6VnTti2EuP+gcy0wnPKNoveQTm8+ckCQgqHSgq3I+qyvsmzirplIv6/CJUM6tmMzpqhrYw4vbG6H/PgMq2XYGGEi9gHOAsuuV+EMfkJ72wb0i2coMOJT9sUxXVk++Fw0kaDmvjLUE+9IDqjnb4GG+lgnJVICXKoYvxoIxNI0Z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arthrex.com; spf=pass smtp.mailfrom=arthrex.com; dkim=pass (2048-bit key) header.d=arthrex.com header.i=@arthrex.com header.b=XHgfn/64; dkim=pass (1024-bit key) header.d=arthrex.com header.i=@arthrex.com header.b=dPR8GmJW; arc=fail smtp.client-ip=148.163.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arthrex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthrex.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthrex.com header.i=@arthrex.com header.b="XHgfn/64";
	dkim=pass (1024-bit key) header.d=arthrex.com header.i=@arthrex.com header.b="dPR8GmJW"
Received: from pps.filterd (m0171577.ppops.net [127.0.0.1])
	by mx0b-0038b101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6922McXT2105135;
	Fri, 2 Oct 2026 00:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthrex.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	Proofpoint090926; bh=CCjbNrks13Ss1x9Crf9QLhaEQoY7QStVzOM2q8RiHJE
	=; b=XHgfn/64sQGLovoxcou5WExG4O2LgLVXAxB1zeCunkv9mdZrE8gxOoqJnPj
	PfKLJCoojS0/+ax48If4U8ZXXGkbgPF95dITfyFBheLKNK2E4qWRnF7Y8bzaRuCY
	5R2ggzFYGE79PwJuXibrR6MjBxBFUOtO62PPgOL6XTydv93P2mAg9Q6JQ8jCFaOD
	etkf0izQdy5zVXvOlArclH/iIrF9KKhquMTVA08anEiTcsQg8utxpHVsBw5kusVa
	JsPldMzydLCjgOgCcmdCKrK9W641PV8Lj4J5G0jPpWhzQUa+xS76kCU9BWv8bC+E
	q/6S01WUrdU9AuFTOtGlcROHRRQ==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012026.outbound.protection.outlook.com [52.101.53.26])
	by mx0b-0038b101.pphosted.com (PPS) with ESMTPS id 4h1993w57h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 00:06:19 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHbkPuyWA0O2mcWOkiZ8FDDbzAelsJZsvbYorSN7VdM+KKUOF2Ke9UEBMomfQ8OjW0hi4PC5jfHCj5xrk1sd52SITjHlb7rP+7v9Cx03aI9kJgbuH+5SdPABlf6AjR0ESLI7TjTmSQO8OOypWz6IY69zhkWESkmUd5eRW2WFgebaqI9rhLeG1oLP7ihi7ubDUOWtJVbbEBJEsYhFuO39anBTi/UXCDKZ2SxPM0bmTFEFUjnAKlBmIt37tmE9tJz2fzDCzAmCic6XVwfVrbAfe8za5M0izxXxh4syjbem4Ngdrf/9eCuCbG5YvEbe0NmyrWZUXS65GfllGcvyFX0aVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCjbNrks13Ss1x9Crf9QLhaEQoY7QStVzOM2q8RiHJE=;
 b=yiAL2F0Zp7kN/ILl1QRCJiCSZKKgjiKg4lY+BPIO6cib45iW79pZOUujRCmatnSoTc1H9Mtc5zLoBWdYrbjAz/wo79L4X58s7A6Y4VTVhzhKoATm4aRtUfRdNLTNj9NlpIdD0ngFHxRqyupdJIK+GllSif2fq4evTTt2yyGFxiNMXMO4jHAHW2LBQ62xRaMCuOWWmSnXTvgRjat/gNj5WBbeg0RBJ9UtapaaApIJUxC+5CX9Xi0tAi1ROntp3A4oQm5JeBGscLI8CM2EttDo2N/254pVaftmSM3U544Lrs6HnlrLAg9qkSF6VSBc/Rv5YSsKYbEnibHBYLbr5t/mmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arthrex.com; dmarc=pass action=none header.from=arthrex.com;
 dkim=pass header.d=arthrex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthrex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCjbNrks13Ss1x9Crf9QLhaEQoY7QStVzOM2q8RiHJE=;
 b=dPR8GmJWiusQH8dp9JOTNMAwvQVTzf7HB34/UKiuFjiyjCDviXkR7m9qmo9KowrPTATNQlMpFj3jefDETt/m2/z2w0RcHERWxeBVDwkTybn1c4rXJq6ve+kf2ySu4/hEycXKhhCvufBz/3lHIsIXjj5O/2LMV9rpRFmkyQuvPYI=
Received: from LV8PR11MB8557.namprd11.prod.outlook.com (2603:10b6:408:1e8::15)
 by PH8PR11MB6878.namprd11.prod.outlook.com (2603:10b6:510:22a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 04:06:14 +0000
Received: from LV8PR11MB8557.namprd11.prod.outlook.com
 ([fe80::ff75:7102:4056:b2d5]) by LV8PR11MB8557.namprd11.prod.outlook.com
 ([fe80::ff75:7102:4056:b2d5%7]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 04:06:14 +0000
From: Austin Schlegel <Austin.Schlegel@arthrex.com>
To: Laxman Dewangan <ldewangan@nvidia.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thierry
 Reding <thierry.reding@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Austin Schlegel <austin.schlegel@arthrex.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 1/2] serial: tegra: fix RX DMA descriptor use-after-free
Thread-Topic: [PATCH 1/2] serial: tegra: fix RX DMA descriptor use-after-free
Thread-Index: AQHdUdemMXVHX6icXkaYfGG5yl3f1rbpnahK
Date: Fri, 2 Oct 2026 04:06:14 +0000
Message-ID:
 <LV8PR11MB8557D32C0AC2AB0271FC1D9FF0892@LV8PR11MB8557.namprd11.prod.outlook.com>
References: <20261001-tty-linus-v1-0-ecb8576c802d@arthrex.com>
 <20261001-tty-linus-v1-1-ecb8576c802d@arthrex.com>
In-Reply-To: <20261001-tty-linus-v1-1-ecb8576c802d@arthrex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arthrex.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR11MB8557:EE_|PH8PR11MB6878:EE_
x-ms-office365-filtering-correlation-id: c2fd23f3-6207-4161-30c0-08df203a808c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|23010399003|1800799024|22082099003|18002099003|38070700021|4143699003|260925021911599003|10067099003|260925022911599003|260925021311599003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 hX3eGb3vRTTuroZAm66D42LlMm4KQ6KjZ0pZ7+USqupgPk6S3KJ7Kkiaad1FQqtYRAiNFESWH9GSbfaCbGOYS+vvI874+7sRO4SlV1G5WBIixvaAOcVasPEPdEF6azQxjMRpeiuXQbX2g2wBvCAJr1AGN6iZOqq34cRYnwz68cTa5h5Cey8Pz1vaPa7o5oyJhnixj1O+J2kmwCy+a3vHFHbpFLTkpe3yIXK/76P2Y0PibF4oFR54L6aX24n4kpZT4Iu6CmPJ82YGzFplbL4f5AaoFcoG3RBjLqSrUtudt7EX3j5si8xyPG2y5KW5SddI+Qa1e45FaCMU09cADAzztBOynUUWBcaULMF7VIwUMcxkuHQQH1ZgLrN6afhzE2naiaCOfw5fn6yADtmHSSGVBKrKMBw/W8rL+2D4hP6J8KRYvHqLkxLyDFcknJS6D+jGtkXMx61x2WqPU8dwCWo3zAHWF+IGGS5v5Res+Raj6yyyeJcKzUvi2DfHhQ9TP7emqqMJOkqNyytU35PkCnwQ7lWkR/zadtngN2n9KHh+ej8ptzOgE9ZXs0nAlKHJUKqAgxFF6kMZkmB8MV6+qX5ejvzS9QPpkK4rQd9Ipi/0Fkbz04iKUMGtyCt4xYLYD7SItlucvCAqzPVVGIVuWWYTDymZ/yDzVk8z6PQhuIiw6j4ceXrawgEeoJWP5HIwTgkttex5Zdfqsr1s7B+XxsCbKFHb+2nHL7X3f9w80k6gkgA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8557.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(23010399003)(1800799024)(22082099003)(18002099003)(38070700021)(4143699003)(260925021911599003)(10067099003)(260925022911599003)(260925021311599003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?uuVua2NiwBq024OxbPjgPsEarqkmm3e8kG2kwlv93SMtaofsRZBRCrOzmF?=
 =?iso-8859-1?Q?2r5aOA7kzb56UZYwTnf0WvpCjqBhjxccsjoHFr7H16t3eafxJdI93d9fGo?=
 =?iso-8859-1?Q?R31dKSJ5GVtPCpgUdvJzhVaSHl+IFUPLLEQ9Gjw/lDTtAvdZQm84X9xBuM?=
 =?iso-8859-1?Q?oUvqIWOTOTHw9Qx0lcJDZkD/ZxBv0bfd7yt1OJ5q9nuZfX8bozZ8hChQzJ?=
 =?iso-8859-1?Q?3PAOOyCP8zXk3jHtN8/a8IuExnbL1rV9Uyak5itf0/M/IQrh5pHHgxualO?=
 =?iso-8859-1?Q?Wowmw8nfnLx0TeeqFMYM8JxYbyBndV4JfgE2pkub8L5bQqpZKGVW/8iI4v?=
 =?iso-8859-1?Q?mz230bx8ohZSbjWEkrxrVT9pdA63fAndT7TlIh2gZqoC4g6d45bxvAjj6u?=
 =?iso-8859-1?Q?HSeRrqiEsDaBjwn2FAVROPSBIrm8zuWioFs2T5zXWhbHuuBNtQWTmOxlXi?=
 =?iso-8859-1?Q?0tEt5ztWgEvM/3IdSKQI0eTTd6RkN+pv3PE5MhBygrROVtKusDIY16eY6y?=
 =?iso-8859-1?Q?mZkHADXKEifjHRPRYpzTpZ83IzNqh++GDHOqfcw7AwXujLvHaghweS5/zJ?=
 =?iso-8859-1?Q?aPBU6WMTzepNZT32O/rugDzz8Ord/B/lTczCzKuyub1kdpOfVJuyXK5BcO?=
 =?iso-8859-1?Q?bObTB5DmP6kF3BHeibLh+SKsEARIIUCOuhG/UmlMAbGt8EcCg+HV3dAC4K?=
 =?iso-8859-1?Q?G4BLhgN2VlqH/Ax5oO3fEv3yH3QSYRexn/4aSiu5KnS7LSTxkxpqXbt1D9?=
 =?iso-8859-1?Q?/rPDUVFviydIVCwMzHWapU2P/mfUAV4oDhYduqU0Buy/8CO7QEB40bmfvz?=
 =?iso-8859-1?Q?p57HXzaJRIv91QCC6lVjfyMUxpZcaYF0Mmff5d3GcY5CeQc76h7LkweT08?=
 =?iso-8859-1?Q?Ckc8mogmSsyfLvDKsn9wDyh9IIeregYUFyxWlE10LOInQZHzwXSvH3KAoK?=
 =?iso-8859-1?Q?/gUknvq3ZbUUHjny+r2xMaERne+5FSEJL3dQBdL+OH0RrENEaK9z2dAv40?=
 =?iso-8859-1?Q?YXMmPH0PpB0BTd0oNa/CnoaicpZIVCAwuUMzL5GxWmJB+eCdoAz51zrxC9?=
 =?iso-8859-1?Q?1CJr5GmGfsCiVBQthuZx0joJzQkqhs2nEYl1zTsfyiln/mUVDwX4tcoxeX?=
 =?iso-8859-1?Q?0hxHMxDvV3q3rh0+Rkgjn8gxqC0LH3ztZU0FWc5LMxrMNnkFxdCr08MhmW?=
 =?iso-8859-1?Q?mmqkUxpXCHMvLNSrfjFkr3shPzhp97P+tC9g3t8Xh3mkSXGIp6ClPNXwch?=
 =?iso-8859-1?Q?tBWuzz8uEs9Sk344vPP65rBri0wRcuE5h+posllWpHGlvH9VMiP+PCZwtZ?=
 =?iso-8859-1?Q?G3wQjLiF/lFthEw8OGIo41coG8gCMxQq6V8/9r3rCKCBWI4RCcsdRYeSTl?=
 =?iso-8859-1?Q?1jPaYB0hGIVY/HVq5z2NoYPmW0EqFPNqNU1Te1woLI+sIm4daOoxOD+LDr?=
 =?iso-8859-1?Q?NS14/CrsQcZ4pumhW4lIe4K1X1UuT39gOokTBywuhx7JTAR3wXgKTAFwKh?=
 =?iso-8859-1?Q?GjH0hIinLg2s6aOgjFYodax0wXJZWuan5bFyjKMUROFEuylDzmr+Vvd/oC?=
 =?iso-8859-1?Q?y/DPu1zRkxFz6bwZ/3FQNWwysXUy8rBqvwxgVOYp8miG/K7mTU75YEv0S3?=
 =?iso-8859-1?Q?eWXTheaFofyQg6sKg8UR1iGPOA4hJP0dPiiPxtVmzn8sK3XT+3mOlVQ+Vy?=
 =?iso-8859-1?Q?Fgd9qy/+9T9oYAfcQzMyEZQUwnrrqgirCARP1CLU/8eQmIISjYTpFJtn7X?=
 =?iso-8859-1?Q?/gySWV1naM+HQ05Cr8XGcBNIfuivrrU7tzsNpdkvR9mWmOs3q1Kkb2AyBK?=
 =?iso-8859-1?Q?5vOhNR+B39etXN5OZz58DMUKalRDT7cbZoo7oTEJxgbQYhcHTIon?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Xc3gtiIqrB9hqAEGZy/5KToSp9ZqjGojPB3/1+R8/lRd23FBXSfR8ly8+WxhBeDF0vD1qwMp+mDcktWN4AyC4IT5JXbIqj6zjxsjCjCG2Qu+rdXYgGhqA2m491rDd6yisup76p5dvXfTa7IPG0+e55Gj/kNjf2HutGh/bCpFzRCCQkyxPTTApYtn9LuEGd7PiT7KaZWylMHQdXhAjkWsq1TUtpGcwdtAB4V13WeeOaD/PZeSq2ewvbLftxBtvprdfaAvVM96XiwiXC7CKlZ5vsdYxqPwcqCiqSwfSRVs1gLHiSd/Jeo7JcVdzJOz1L8fS91169q9aVhKvTGdsxMLcA==
X-OriginatorOrg: arthrex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8557.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fd23f3-6207-4161-30c0-08df203a808c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 04:06:14.6477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c970182f-4161-459c-8a07-2b00ed24c146
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JljXEIPz4l9PjOdDSHxDJ30diNSFvGmHT2JR/itonw3P4325RCa/++Hk4tLbbYA+vRloQ/OpAQ0or3FI3lPvrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6878
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAxNSBTYWx0ZWRfX87a3KMRWFByu
 wlW/K0eaGay3e+LNwdG3A26abW/+IFLRT3wdltc3raSv8BjTSYztiWKSEEFTnAfhARjR0zfkmPm
 JSJ2yc/v7MeQJNTvPMUjYZlgAwYVmnbjYYmlwrcFqlp9sFfDSK/rE5AcULSchxl87CiPGUC+pDZ
 OeXiPDA5LLx7PqOnh2ytwVGLZ7DljTtcU1A8dBvDe+MxhVWYatzUuVqX5OqZdSNPATiwYjC7r8e
 iYcCkdVOl399L2OEhmNP/pcTZLuf5CoqhUIKQDtf9bAUYDoWjHmmYK1oX/bifPxRtmzAjno5gkA
 PvJgL16C4DrSVAXXNmqY/phRckhqyX0RdTtHst601Da9aaDrdXWoM3h8SvX9bKRAWJ0JgD58ihu
 zCykSEPlzT5r/axebse1pB5TLKG+OfvU5j8lanm30G9Rz3k0YIuPtliaqLiCEVYeZ0aC4O/bRpP
 vN+CsnB5m7GPcjAW4jg==
X-Proofpoint-GUID: Sq_FqcmuBLOvA6dn_eGfE1pZP6o59j7S
X-Proofpoint-ORIG-GUID: Sq_FqcmuBLOvA6dn_eGfE1pZP6o59j7S
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAxNSBTYWx0ZWRfX+K+7VgQ2RChv
 vUwJXBQ75816VeW8xCo+OK5lSKOE0F1ioHqGcJZm/+RmlYnT9E1yPrE9ft4qzGFlwVfDQGSgqE6
 fj1n+Y/IpiCDLqQ6K4iertMVO0nb4FU=
X-Authority-Analysis: v=2.4 cv=LeupeTfi c=1 sm=1 tr=0 ts=6abf2dbb cx=c_pps
 a=Rzgcbe2yxP2fEJMfMKkCcw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=660iZSQnnn4A:10 a=gbA01DrXz1UA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=70HZLsTLPGYbawPVQYjx:22 a=3TjR_UqBzVsPO2iw8btq:22 a=yW9ijH_GQebpuA_1f9kA:9
 a=wPNLvfGTeEIA:10 a=qak9Fwl7LPiBl4gFUzZR:22
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 malwarescore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610020015

> tegra_uart_terminate_rx_dma() calls dmaengine_terminate_all() and then
> tegra_uart_rx_buffer_push(), which calls async_tx_ack(tup->rx_dma_desc)
> ...
> The same freed-descriptor access happens via tegra_uart_rx_dma_complete()=
,
> which also reaches tegra_uart_rx_buffer_push() after RX has stopped.

This second paragraph is wrong - the descriptor is still valid inside
tegra_uart_rx_dma_complete(); the ack only moves there because it's
removed from tegra_uart_rx_buffer_push(). I'll fix this in v2.

> Soak tested on Tegra234 (Jetson AGX Orin) for 13+ hours with
> kfence.sample_interval=3D1 and continuous UART loopback traffic...

This should state 24+ hours, I'll update the number in v2.
This e-mail and any files transmitted with it are the property of Arthrex, =
Inc. and/or its affiliates, are confidential, and are intended solely for t=
he use of the individual or entity to whom this e-mail is addressed. If you=
 are not one of the named recipient(s) or otherwise have reason to believe =
that you have received this message in error, please notify the sender at 2=
39-598-4302 and delete this message immediately from your computer. Any oth=
er use, retention, dissemination forwarding, printing or copying of this e-=
mail is strictly prohibited. Please note that any views or opinions present=
ed in this email are solely those of the author and do not necessarily repr=
esent those of the company. Finally, while Arthrex uses virus protection, t=
he recipient should check this email and any attachments for the presence o=
f viruses. The company accepts no liability for any damage caused by any vi=
rus transmitted by this email.
