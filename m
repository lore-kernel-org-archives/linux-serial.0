Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012071.outbound.protection.outlook.com [40.107.75.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D1F44D02F;
	Mon, 18 May 2026 12:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779108804; cv=fail; b=sJHG4pKayiU/hu7MtIlBTQfY/Hw2mtIj2yKfWgyBllxuTI8aFmTHrnnkg5aJzHQHzT/H3x/2i3aXa6szjOVn+yCDu8oiKhoTdgCZ2b84PGDDpouuZH2DMMlbHfOVXcrRqCXwcwCqZFMVQTysPBf/v97TJSLg6RIGsgT6tj0+gGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779108804; c=relaxed/simple;
	bh=zlkLuh4UsXPvEHXkOl1E81erbge06vHWiAXjVPn7Osg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YR5P4vDn9EQrYxsWS/Et3JDw/iatxxJxhDimy7C5NTeXmMFOiiathq0+9CJG9rhA1AibJG3ljY3xxY5cFnAMl/u4SLIaxe8kbECuhUHKEvLBp3VpIvm75pmO4ZaQGOZzHFz/p5Mtj1n6a3D9j8YweZB2uZgeKV1XyHcZie5vlU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=HYt7eXqh; arc=fail smtp.client-ip=40.107.75.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="HYt7eXqh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hC2PYwrLobnivOCnpSqEAzx9fXHe8qW8J0lQdixFihHP/MnrZnubmcUySJCoVOp73H5nMjw4qULXpTmxcMM+m2vFYbCggQ18V+PRniCpPRjZW5jxeeTeFsWxR06LIXrsjOut/XaA0Jthtwj0mlzd2hi5AheIUHfoRsoU4pw0NumyOsUWvA/LytxhKW8VYx796lP+wfZYGnJNM3BQxTSzBi50NoJvJElGyvOyD3H4/op0DEEu0IqKPgR0TfycXXWjVuFnQsVvlvqHGZZhLHGYhi60+3BzK67iltV6lJmRzzwFNpmaWzAtJNECMQBrp42OySr37v1kiUytXnGk/rr2wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8G05LaAgKLElE5iEaEUfZgQrmWna0XTOvcLBAzbMrM=;
 b=ldlzQbFpvRREb+ApIZ96jeI7JaXBHhBuJraDRshmim8Lz/eqDXvqpviPzN3zjggJQfge6QV9eeYaRL2OukKvW/lyWSyDdsIS0SWbhTCzTr+4QJ/x7zEYj7QEBWbS34V80Bwf6qPCeIKWmLvEs7Uj2bOVNxmrg4EoRrcJOTzWA9Y9A/AU8rgcDHOaM8+qPS04Yjc7ioVfZSYjV9GqXyH2aVNmz3fbQz2JIj7q5Xirmq7Sb+PAUTVHI1l0WHoqfY7aMYE2zG43EGxknQ2xcv0vkWiZiRo9D6jjg0jlNN2wCuYnxLkS06TjGuPHwU7y/zltXZi6ObB70PPOjBWtyCWOUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8G05LaAgKLElE5iEaEUfZgQrmWna0XTOvcLBAzbMrM=;
 b=HYt7eXqhPTsFnfaAVyFOC3KBUWWwHgbQLyb/jQn9FaSYBOfilnvRb2vRnmaI5sNwEiwBNgLorjVkqoGw2W1HrXN/Hd42qNEQc9nuXkQ2CaKYRxvJM5/+s2mPvyXaU+2BRqnJRHiIs6vnIfvA3Hz7WqXagWrIjwtwuuBTEkpoaMw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEZPR01MB5971.apcprd01.prod.exchangelabs.com
 (2603:1096:101:1e9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 12:53:21 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0025.012; Mon, 18 May 2026
 12:53:20 +0000
Date: Mon, 18 May 2026 20:53:16 +0800
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com, fangpingfp.cheng@moxa.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 01/15] serial: 8250: split Moxa PCIe serial board support
 out of 8250_pci
Message-ID: <agsLvCVll66tPoFA@moxa-ThinkCentre-M90t>
References: <20260504084900.22380-1-crescentcy.hsieh@moxa.com>
 <20260504084900.22380-2-crescentcy.hsieh@moxa.com>
 <CAHp75VfFMLnLDP0V3U=4zG4Ayj71-ZgVkJsVtgNE=52tGQ963w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VfFMLnLDP0V3U=4zG4Ayj71-ZgVkJsVtgNE=52tGQ963w@mail.gmail.com>
X-ClientProxiedBy: TPYP295CA0055.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::15) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEZPR01MB5971:EE_
X-MS-Office365-Filtering-Correlation-Id: bac0636d-4433-4db8-f25c-08deb4dc6fdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|4143699003|56012099003|18002099003|38350700014|22082099003;
X-Microsoft-Antispam-Message-Info:
	Q/8CFQbQ6nW897XjbOHrYx5xPIrlB1YYTuXdjXv3mvR7zz2E0FxVxTMcyqxEuIwuCh0zGKbfZWouAQwGowP1LbBl/3oM/dOd5fPVeZ2zdofmKtKRLqnzKGQyZfoWrsVaGSuaHd8YR5AmVYULozd5zrpKAYic7M2+VtimjS7xCXDjKpcq7utzNalgrAy9B1KQF6GnpHEInTYGaOzZPuu9g1Wfd+NA+0XlHPjWP1T1RhneJTclRIJNQenXnHAIKNd2dXtYsXBa+14R+U5TZ3muPMWG/ry+Awx8Vr517lZOufTYtifplR2k9NzSLKrkEZcyFIQZeuRnYQHVwoeTxVGpCS+ZoccTfX7N0OxTtuDI1oe4MQcpzE2K+Zv+GiXE/EyvoWJSO1xJvYXyLvvLHDXkklEjtmDWTStIuC9k+SRUTbsE5fbWXDSBYIUEvkkIYJx9bm1qxsrCpJWe5phvngGT118Wf5PNCeZYYchbO6LBhsw6LKex9/KjY5I1RKIf1MLTtuDVbe7gU5342tQMUgJxupGlFQt3IEoJhtbDMXWHx/PHjzvzSq2WBTM1g1/0xFMWzAMZOEUHmuw/XW3vxZCzKSCYz3qf73oepMxGQbKmd2B8LDksK2Ms2hcrKalBpFrDSCNw1fxzjpTFbTuGTB/Pu2jX9LdGZZ3Ge6m/oUF0Qtd7rGzS8UK/pJYKjUzmu9aSw4ehoqJu2Ai23dHclkC3FA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(4143699003)(56012099003)(18002099003)(38350700014)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1BYaVJkb01Td0R5b1kzZEZVMlc2SGkrQVV2TWRDMjg0WTlqeUMwS2c1YXQr?=
 =?utf-8?B?Vks5UXdDQjhjNm9sbTNYVWVrekM4TitHa3NRdmRBT2k3YkNtbVF5Y0NNVEFz?=
 =?utf-8?B?STB4REhQQTZTVm9PVXVJU0QvRmVFbWVzMHBLZENJRmlIdmRFTlpUSzZCYVZF?=
 =?utf-8?B?cWFKNTIwNEFmZi96TS9hZ2VDSG5BRHB0bVhKcnRXUVZFcEd2ak4yMmpDeG5D?=
 =?utf-8?B?Wit0Qmg3blFXWjJOOUkrV2hTbkxGMktOYzVsMU0ySklWZTBIbm5FQlNHdG9q?=
 =?utf-8?B?cjlmVVlNdVpjdEI2YUVZRXVNcU1tcVhCWDFyZ0YrODBkVEVHNEJTdEJpTmhu?=
 =?utf-8?B?d1JZa1B1bjlFM1A0QVJYd24wcWdkSkk5Q1NZTXVGRk1XSy8yQW90NktPa1Fp?=
 =?utf-8?B?Z2ZJYXpWRnRwc01rSC82d0lNZEhBOVZVajNWMGxHcmF5RUNpakFGbkUvMDll?=
 =?utf-8?B?NjA2RFBWM0l2TXBJWE5kVUY4d2NlRHhhUlExYkV3Mi9UT0pvb3E2V1RySTRI?=
 =?utf-8?B?TnRha0swTGRYU0tqYmRkUWpFSE41ZGd3bmxPcnRyNFJpWjZSbFdpcDBGZkZM?=
 =?utf-8?B?cUlGbms1UUZ0bmlTTmRQbTFsRjlISUJMRk9FSzVsdlkwdXJwaFpiWE5nUFVM?=
 =?utf-8?B?VDlZS2hza1Z1UFl4M3FvSlM2WlRzZDNxY2FtL2VlcW9rRjFpUjJ6ZERzNU5w?=
 =?utf-8?B?Q0lXVnp3WXVGdStwRWo1c3hNSEFBQW1kaWd3cEk1dldGMU10Z2g4U2RNa1Y1?=
 =?utf-8?B?cWViaCtkWVVaZ0RkVWs4clNvcmRUcEpSK3NIbHlOZ1BXR2V2Z05Nay9NdWRZ?=
 =?utf-8?B?TkkrWnYrZ29ZZEYzOWU1MGo3dHhzNXo4c1laSSt3RXI4M1dPTVZMVjNrZUla?=
 =?utf-8?B?VXN4Z0trc3RMOVFkR25XNmJralpGOCtjUXpMbTdTNHdFTjJpNDRZUW9YcEY5?=
 =?utf-8?B?aThwUXhZVy9sUU53QW44djBUZFZLYWhiT2dxY0pralVxMXlEbEZuYzd1N0x4?=
 =?utf-8?B?Y1RuNUtLYlVQK0pyT1pTQ2pIdExmTjFoLzQ3UlJ4K2c2SGpBQmY2eEdWTUh3?=
 =?utf-8?B?M0hzU2xzWlpyWmVwbjdtMHhYd0drT1l5MUpSUG5SNGp1WXdzV24zYWNqc1g4?=
 =?utf-8?B?RE1nbnA3R0Q4TnVERUFUWDNHWkVyU0crd1UxTy9FdGlyZUs3OWNCOGYyZDJK?=
 =?utf-8?B?WXBUZEhVUEtvZkhqanc2TVNsREIxOUFwQWRlSmNobkZxUkl1L3Bmb0MyOVFu?=
 =?utf-8?B?b1I1V2tkTUVxK1JkTVhKUFkrOTZTd2ltVUJObnI0cUYySGpwQTdlb3NaYmhw?=
 =?utf-8?B?MnYrZzFDRHNNQVUwc1plbFpubjg0eHBuQUJrV1hIdDU1Z0lIanJ6T291Y2c1?=
 =?utf-8?B?N1VpRUVrZ05NbktnbUdETlRLN1NvOGp5RUhhUmFsMG5JNDdmQU9JNUtsTyt3?=
 =?utf-8?B?ZmxPTlJUNFh5eFZkdWlzUS8xc29LTmJSNHM3MjQxYUtkQ3N4Sm0rMGFmT1N5?=
 =?utf-8?B?LzgvODVza0NxQVkzcllpbG9SUUVFeDJlWlFJajlnS2kxTFo4dDhRNzQxcndS?=
 =?utf-8?B?ejgydis2WVpVZzBoamRqRnorV245WjFaMDdmOUUxWnhSQVJ1bXVneGRaY0hB?=
 =?utf-8?B?L1hhdVdWbllsR3grZ01YR3dWaVV0QnNqL0RtYks5VHpaeTd3Uy9rTVk0dkdq?=
 =?utf-8?B?aVBnOC9RSkl3TkxHZGtQM09tdmNGVWlVMHh2UmRUeFR2SWwwbmx0bXByMXNs?=
 =?utf-8?B?TmVKaHhYU2w5MGlLNE5iaUY2MFhidG93L2NFYVgwOW5kcktwQUpBZzVQcGR2?=
 =?utf-8?B?MG5TbGtETCtPaUwrSTdBMmlvaGo1d0NiQzhKbThaNUNoMVZsWEJROFJSUVlm?=
 =?utf-8?B?OXhSa05UNWxPRzRQQzl5Z3ZMZE1ibGdnOEs0QVdWSFBFdU5wRWlkUTR4SStJ?=
 =?utf-8?B?TlZrSFFsSlQ5dStFalRodFBaazRqQVBVUzlHQ3NzenNyajJ6V1ZPY3pzQlpW?=
 =?utf-8?B?SU5Pd3FLSVpVK2k2N2pwUk9uK2o5d1NhSHFySHNsMUV2S0R1bkt4UWx3OFZ1?=
 =?utf-8?B?ZHUvUTBRU1J4UjNyZHRPWGdMK0xISDE2WEVUTHZWOHNUM0lVRy9xK1NKRWcw?=
 =?utf-8?B?aU9GamRBaFFGUEZTbGhoekZjMHhUZElidUJJZjZaNGRLQ1pjYmNCNDU5Q1pO?=
 =?utf-8?B?MWpnaS9WT0V5ZXB6Tjk3K2U1aUY3Y3ZSWWw3Y0dKb3Q4LzdvTG1TVFZkdXZk?=
 =?utf-8?B?VldJSUtzUUE0ZjM3QVpFU0JzMzhyMTNySTR4Q1BEZE5qYklNQzd6NVBYSFNk?=
 =?utf-8?B?dHVIYUx2eGIwVVVCbW9weUxITHI2d1dOV00rSitxZlc2SDhXMUxjWlAzQ3Za?=
 =?utf-8?Q?cR1GH08M0cP5daiI=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bac0636d-4433-4db8-f25c-08deb4dc6fdf
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 12:53:20.6260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JOLayGVMsEmcrrO9QUdHIiCi9rnK8ECJyTNhjaN9b67AoQSXYTvRcBAQN1phZQNwerGkZGNi+OZ20NhvoC24aA4nbE9V81kKQvg+tDJvptI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB5971

On Mon, May 04, 2026 at 04:27:44PM +0300, Andy Shevchenko wrote:
> On Mon, May 4, 2026 at 11:49 AM Crescent Hsieh
> <crescentcy.hsieh@moxa.com> wrote:
> > +static void mxpcie8250_remove(struct pci_dev *pdev)
> > +{
> > +       struct mxpcie8250 *priv = dev_get_drvdata(&pdev->dev);
> 
> platform_get_drvdata() IIRC

In a previous patchset, dev_get_drvdata() was suggested for similar
cases [1].

Since 8250_mxpcie is a PCI driver, could you clarify what you would
prefer here for retrieving the private data? I was not sure whether the
intention was to use dev_get_drvdata(), pci_get_drvdata(), or something
else, since platform_get_drvdata() does not seem to match this driver
type.

[1]
https://lore.kernel.org/all/CAHp75VcPanVWaLi39Wf-pq8nA+xbeJUs=v1BACz-+Sns0BVyWg@mail.gmail.com/

---
Sincerely,
Crescent Hsieh
