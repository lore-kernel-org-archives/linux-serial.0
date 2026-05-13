Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948A53D47B3
	for <linux-serial@vger.kernel.org>; Wed, 13 May 2026 06:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778655067; cv=fail; b=khTr0FzJBcHgQknr5WBrIK47RQ4dhadVy7G5PNhZfVteCvCG4NVmqcT8GRYh2kRG7nCoRI3QHBk7aju36A/TqeteSuBnedGNAS80Uj7VCtH2p1sHVjGG8WB78R2n8zdQ5E4WZnYKhOSMwsZ3/0vsuojdFxhXYhoRbBJ8eExMCuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778655067; c=relaxed/simple;
	bh=Jyl403Ramb4Zfucbvp9Zbh1XFzwgwDm0LhbevSS3vPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pc7SqrFQqgUhEZtZEih6Wl7NJs18Lt9gf84wOgFhwQxdoW9y/bTVPCJllz2uSgyscjWm7F9faX/H04dYfSI+5tXnIhRJRYeZgMySj7hBp5cGEcWNnhaBr/rhcyr9latjqI0f3LhrIH+sOAwWOEWPc7eWUr2rp2AmnyRA5FnKaOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=O38ewOaJ; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="O38ewOaJ"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D26opx016166;
	Tue, 12 May 2026 23:50:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=WHMoOGN05+X3KXnOaHRi2KKq3wlZ7WV1XuiGmn/id9s=; b=
	O38ewOaJ8OpBF9gkx4RrmUzn+Uybsb0wrK9q0qQK8ZZ7Kqgz0Egwab6aujnxZs7A
	YyCSxq9ZmGqffwqeRkWTD3GKv+BSP4uYEPc3sZhKCxgv91FufmwuFDabxBdAiGXL
	w2alXvDmyl++OPe6iZEpcBNQYebsFeWBCqQ+IaaVgsGPK7knTFfAzgSqUA44yoT1
	s03v7Ja0OcowNoiCqeQ2l/umc2DdDIczxW5izh2EmNh0WAOjeK3H4h3WBZPRUQmk
	huO0E9KrVCELFa2uETUvmAjQucMpOacS1h6Ms7IogOjKYb61WRmI/wSKh3sZyx+M
	Cypto/Cxqq/pH3xGNffyNA==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013069.outbound.protection.outlook.com [40.93.201.69])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e4g7g88xt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 23:50:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BhkB8UuAqyim7wJGoLH7iWSMXhuw5P73u2c+IXTJTzP/9iVANFE9ZEodN9LnOReaQscHja9nWAz2jD/PMRj7cGO3Xl9hsSOTQ3B07l66e3LKR1Cw2Mjt1N4y8Kk+FsdtKVzRSVbgnrOVXB3dx6Ic8vFS7RhPJqsxuNQcERs5TPbZT0JdFUXvpM8yW1C4vacrXNrn4oGFheF7LMZyQRCjvgQbgynH7oLivHYdUI95yqalnzbhgVgt81dgUmvAuqO19f0EFGdDJaFECckyOZ3ZlE76jGja/GnEy1DZRNBozGjOvzMiEH5seR7tSWu85kCzzpx08bucw1J5d2kXI2tcvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHMoOGN05+X3KXnOaHRi2KKq3wlZ7WV1XuiGmn/id9s=;
 b=F/5D2tPNQIiOFrhKcwTqlGd8QsDQhY0YLDNjjHunAYOh2MC3ypI+CQGm7txse9m7OBI/2kTMRaDtqd8Wo2+LYqwg3QxEgXZXPLOnEmeX2j6GU00yHi2p8p5Jvjm53iyEXv6jGEIJtBOVMvZzQtTcPuqzus775jPeU4j4lzX6nNZYp6i80qMRYcxF8IOBjvb4NZKU42GLwh6nAiqXqN5G9PeyN4dAbed3byzYSFEJ0weoYE7V+347D6VsvSEPsYVOgowFaS7C09VTkb5XrLIs3KynwGJwXat55nlwbCfJxVNJBsGOndj7rWmU8mIKqtSeN55tU+35d2wiIrl9XlHr1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by BN9PR11MB5289.namprd11.prod.outlook.com (2603:10b6:408:136::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 06:50:51 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 06:50:51 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org
Cc: stable@kernel.org, andriy.shevchenko@linux.intel.com, wander@redhat.com,
        chris.friesen@windriver.com, linux-serial@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v2 6.12.y 03/10] serial: introduce uart_port_lock() guard()s
Date: Wed, 13 May 2026 09:50:21 +0300
Message-ID: <20260513065028.112468-4-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513065028.112468-1-ionut.nechita@windriver.com>
References: <20260513065028.112468-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0105.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::34) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|BN9PR11MB5289:EE_
X-MS-Office365-Filtering-Correlation-Id: d21eac56-ba60-4575-b595-08deb0bbf8b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|10070799003|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	19eNwHUiAcGWQItQlH2oRaW4G0CiFK8wcBof38NnU5SAvkZHVFVUcUoZgd56hkTE4FncNj6bE/HW5DsPVrJzX22jFWdxbPJ4wA7CBilwrKNgC81TVUAxP2HmU9IcE7dceoxY41YtF1e3udXNkEh0zpF6uXIwJ+qZ9rXlfir9zq4Cf2RKqRP3EouvwJlZuBgNJITFhLu7PpUeQDhrtuL/9Akokv7QMQxnKKJHCHWKZ11qjPmUEWE7U+MnTYyoLgHsmoBMH0JKStEFNiy0xCFbw6izBze9uuytPKDTr2b0JjZAz5HFGbY28SW23swwwVJROGB+/sastm7WYTk86LkR7jSUj+TCoqSc9uY0pU6O5Jwnba7zwmeKSXPaF8Wr7E4aKgyOSbfp6hPTxWfvP2Xmn8emGowjrnqyMWOc3iMclYgCbbu93U5of3gCdeAL4awoKLg2wQexVd28ZLto17C1ts1D2b7+kNmGT7j2og8zgjL2zum1qv9z8QyLmbKTCCnbFfBy0qbaA47+yW4tElUduJxB1SYWjcQ8qpOkTLGfFc1LsilEl2reqSVOeQ2xYZaXs/iJlsNd6Xh6nJ/qD+uc/C8uqc6qqzF19g2/hKOj3P1gP9oxHLUMyqnKODctHkmXhY9rZ1OMNO0plCuOrGUATFcLEezY4yqpUzZ61dvCTPWVZZ3eFafEjZ/j8oyBY5kxBQo3y3WxbG399qdFqp9uiA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(10070799003)(11063799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WOdPGTfCQeaielqCt2qfO5PYh7qzGLNlHBzjmfkazXpXLQe25R/kdFA+LjXu?=
 =?us-ascii?Q?Dd2/qp64QJN59nTwriEn1FyDMSjDaHpXHxQNO7fwV8oEHHdkDY1q4uyL3Lp3?=
 =?us-ascii?Q?yFAXvf7eejxXFcFQBFsV/VMHKsYRBBqkzi5I18/WihjJd0N1hZtQ83F6QDnu?=
 =?us-ascii?Q?Evo6e6yzPeY3mqRu/teW8SW26JPHjh6n+ou9XxZYhZSl82R2IJBORqefEdMe?=
 =?us-ascii?Q?6RMMgNIJZsFcE14oiTpwmavhSDp6ns6HOXRYpvbDD+GTc5YfXpKixsv+UFx2?=
 =?us-ascii?Q?dmsAc00ourii0rdmb+8hBP/nbY+UqLZqZeGDRvA81US2GtYhUFREjFUMR3Tb?=
 =?us-ascii?Q?62tGluuJUmSyR1FblYVS5/N2Mn4WX2lMjZio+NDJVuo3RQ8K+CHKZQBmiw/2?=
 =?us-ascii?Q?K2wBaCtDLWTJXnKm7EurJuGBzGUJXcXOTy75n0YPEY5iAo3rYUeKePDTtZfw?=
 =?us-ascii?Q?fFkzNa/kadI+OSaxn66BdkFmdQSTnzhkSqhSxNYH010y3khFki/9pbb2q7gT?=
 =?us-ascii?Q?kUfTmNfb6W09p4IIZcVgsM3quZE5q+rehwf9rCEMb9sPNay0x3dse7mciWjh?=
 =?us-ascii?Q?ObRiT4ZNuYAMvYE5ovf0bGAeqfzV81eSroACXRaHsfK+WXB3mp8tLAuyYAmI?=
 =?us-ascii?Q?zQXkUUNMxDXGi7yrEIUWGs/5pAiULB/bcZ+BLvkOV/B/4za9ungIZlvs2miQ?=
 =?us-ascii?Q?WyGS79fPHBG/o6Dhbk1QKjKmfn7ZdYXpRsucjOXRQCn8X2CYLLtkMqbYKPWR?=
 =?us-ascii?Q?5FOnhguhLs3ZEZ6Vsgjg9feSfYdqaQnFMILC8LooMVQf56GVBZPQv2AYFtzk?=
 =?us-ascii?Q?NoXpR69AAPruOwRhh7O80BdwK+iWASvn5iwPoGYXz9DFp0WdEIE2QJHoPnkJ?=
 =?us-ascii?Q?tjf2WVRiiakFVdUDi6Lt7OD8jsMTJncURSgF/ZV7ws/dPrft630l8XA9zbDI?=
 =?us-ascii?Q?ntSAhBoyQloEDhRyEJQbVvw3z11xgu0WCRZsi6CZ7ZD6RodLJTCwntrgj6yy?=
 =?us-ascii?Q?hIi/SvXae2xEXe6pISfauQMUaL+PcU5vbsLLPmiUBXb6vRIS7FPLPfovjzBQ?=
 =?us-ascii?Q?1bwUYcJbWT+Wyj0V63NhJ8Cui9de4h7BCLyeKdWEuGyRp4SQNkXpk7fOZHvX?=
 =?us-ascii?Q?y2nvd8C0u8Z9TUrqY3o9MNxaStio1htd8z8I41L2usA8fznht393P2zXurxR?=
 =?us-ascii?Q?9FGQpy8dQ1uRre8b08eogZ7eUhjFGq7Hpt/+CQ/pMSis3hFY7jZyO/XDz5uA?=
 =?us-ascii?Q?LEGH+50lMEMXYGIgePdamDqdrgiEWlLhXDbniQFYXJ8UZH/d/4BQAppXW/Ns?=
 =?us-ascii?Q?dgMhvx7SnSS83o6Fo6OuHMKSpQBrtcR7mLaP9ZlQJ6R/082jlp6ncFyM3+Xq?=
 =?us-ascii?Q?X2XR9DwCWIWsnE1eeu6EJY835EI6rIL1nD785BSxNBOsjFBb8YkI4HFtuIki?=
 =?us-ascii?Q?3M/QAAfE48bbqxn7vgSxuwRmEgxyULwV5CePYotwWkJGlBv4UTuzKokyAl+w?=
 =?us-ascii?Q?zVDZ4mb7HZViZguJc/Gb2IQzPZmTBaS2OIbTFSHegtmZ7ipsRi24PwBi3jBG?=
 =?us-ascii?Q?QUp+hakv0L1Tc1yKYXrFpzEE6NmI/FdLq/DV/n2QrJj9NIPLwQXRA6BC/YLm?=
 =?us-ascii?Q?frDpRfnWF61n9/Bbe2dupRvELn3BdrTJxVhL5y37/lx32op/oIIbsxPSyfEO?=
 =?us-ascii?Q?3Dv3mzOJu48Zo9NruRl70Mb2S7PWDZpTM56CK04/k73yr0q+ByhYdBICs//N?=
 =?us-ascii?Q?cHNzfvrT2ZfTAKG2ScQ04JGLobcbYvX58TrlG5cAg1kQtoE8m17WqKYpQdZ+?=
X-MS-Exchange-AntiSpam-MessageData-1: vMcMTlVNKthZUfwSjwsA3lW+H2mNZQaSzAo=
X-Exchange-RoutingPolicyChecked:
	nNSO3Eqi8eZ31vBd4gwTWpRC2vILRWlBgOM4G/O0XVTjnHwn3Ot25HIcrE8g3OUQkInvR1y+74QkGXodB6xAHTYLe6K1iBKEA+zzFZ5YFGMTMOwixL6AgQMCqiDALMz0FBBzLII9aVAtrVnq5CQ08MB2OJzAOigh4/qyZUykL6iwQTUPtZjJeFTH41/+yprr0V57nt+X9qWLyReWCaoobAz/wv90Yyd4fAX8c2uCyPuSAQcZSZ+B9Zk5tGJEcoTnO1C7v5QZ+0WjYeOgK4TlE55EU+ZShB+oQ9SDU2fuFfCx9ig5YaMugeT91n6c/FTDLPMdOl/7zi3oHysoBy9pKg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d21eac56-ba60-4575-b595-08deb0bbf8b8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 06:50:51.2897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YgwaNhIiwVn3i+M5Gy1wyfP0Aq+1+lj+Cd1MQ+2ar1AwUQaLoo+4AmYXlm1WNVeMJT8tNnZDeTXmD23qRh6wwHn+k/fePmGtl0V3Tkzj7Aw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5289
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA2OCBTYWx0ZWRfX3S7hlbe4pioG
 HBqEUCst6Iy/F6Cowq7jRIASCsXVyNOaHr6gbxjEpqV4IptyuhHbsAWI70Ge1PlYmCjn4kh6N8B
 EeHKrEhKUUYsbBNecXbe4T07a3Hvom3THLgdouvydswbeXSfZvTAVHSMwxqBuOkMpvhXqLvUTgQ
 aSd/bnzpb5vaYK3TLBi3TFzSJLWgziYAxdfAkv0V7VItGCAB9qv1FdooOTjAh7E6RIKT6kWwzu2
 bezz0KyDzo/rSMq6UutgOH83m0Hp62bbEgHgWI/yId8k1rm48veALL+uFAXx6yu9KBFv/nNBklm
 H4pgOs80qk/vstSp/nI2NfIVNfT2uYgl7r080MzOo2rJ6LCaHXEBYVxpDAmeCMHrE+e4Ck0V52i
 C+LMtDpkK+jUlx/rbuWKVoWzn3RlM6SNW6/ttMa5BD9FpW0AZj9v8pDYFIScl7oH3uLai++TK1b
 qWtY+AAPZWk68kL4Pdw==
X-Proofpoint-ORIG-GUID: pHeXVrS2HGJVs1x8BBOrsc_AiTr2PxbO
X-Proofpoint-GUID: pHeXVrS2HGJVs1x8BBOrsc_AiTr2PxbO
X-Authority-Analysis: v=2.4 cv=Q7jiJY2a c=1 sm=1 tr=0 ts=6a041f4d cx=c_pps
 a=/NeaHkXls/iJsjBnUIdqww==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=VwQbUJbxAAAA:8
 a=ag1SF4gXAAAA:8 a=t7CeM3EgAAAA:8 a=B6Of6qZoNiy97DoGTYEA:9
 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130068

From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>

commit 0fd60b689b0dacce659253ec15cb3d3bf660e30b upstream.

Having this, guards like these work:
  guard(uart_port_lock_irq)(&up->port);
or
  scoped_guard(uart_port_lock_irqsave, port) {
    ...
  }

See e.g. "serial: 8250: use guard()s" later in this series.

Signed-off-by: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Link: https://lore.kernel.org/r/20250814072456.182853-4-jirislaby@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 include/linux/serial_core.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 4ab65874a850..191154b8ada2 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -782,6 +782,19 @@ static inline void uart_port_unlock_irqrestore(struct uart_port *up, unsigned lo
 	spin_unlock_irqrestore(&up->lock, flags);
 }
 
+DEFINE_GUARD(uart_port_lock, struct uart_port *, uart_port_lock(_T), uart_port_unlock(_T));
+DEFINE_GUARD_COND(uart_port_lock, _try, uart_port_trylock(_T));
+
+DEFINE_GUARD(uart_port_lock_irq, struct uart_port *, uart_port_lock_irq(_T),
+	     uart_port_unlock_irq(_T));
+
+DEFINE_LOCK_GUARD_1(uart_port_lock_irqsave, struct uart_port,
+                    uart_port_lock_irqsave(_T->lock, &_T->flags),
+                    uart_port_unlock_irqrestore(_T->lock, _T->flags),
+                    unsigned long flags);
+DEFINE_LOCK_GUARD_1_COND(uart_port_lock_irqsave, _try,
+			 uart_port_trylock_irqsave(_T->lock, &_T->flags));
+
 static inline int serial_port_in(struct uart_port *up, int offset)
 {
 	return up->serial_in(up, offset);
-- 
2.54.0

