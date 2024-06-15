Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2116.outbound.protection.outlook.com [40.107.255.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217FF168A9;
	Sat, 15 Jun 2024 05:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718429822; cv=fail; b=UDzDY3+VVv+69SaAbSRT+fBd+9pY/W8ZJ2ChtRfxHFnvSOhju1eePGdLVu+e//SzmuZE+BFXLvqZRcCU1hgX+Nh8ji65NVdOvxE8dtVQCyfg3jRzohPNR5BOaCquiTB6cgQGHXE2qp242KFZMCN5X3bI55ks7aTnOcbjA6OeY0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718429822; c=relaxed/simple;
	bh=FRODpj66hRy9DfY7U1UBRKcpKghYI3klyNk7DvFdvRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lDdun1jmZf39/iBYMMX7824xUkk93nuzgJFwY38Ni1HmmnSMS9DsjW1a7rd2dtRhnJRLr2S7epe/oZp/egMkKJaFjWXHdE2/TH5/AVjtOlGNw/U0NjAujvogE+l62qs9haGdAhTG+0UtRSSpsTpc7cLpqPOITWX4z0Rd53YSBN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=L3DTj9Lw; arc=fail smtp.client-ip=40.107.255.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="L3DTj9Lw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dd9svoBta9IiMAb9MgsmtE6HsqIfbdJjyqcAa+JWRixScG4mtM9w3b/bv5UI3HU+ubDdvuYnp5JULOI33k1PNyxg/VY0lMvqMNheA9eNoJW9VWYNCZsQaUnCOPkSG29p93xvwuARSDiY+YbBTefUSSo/uDV3yMNNNpeZ7HHWmWliDbDZc8JzVA+XR7/7gmhF8/Ov3GqEDhbZo95yheLfCfSZ6zabVZMFyIaGdxPlnedPkRC8D2ZOIUHizSmUvNkicmlnaxIGyGVh720D9lN4UK1sAYYP4EXQiqyK0+IeS/uDC/amKDRVXSncA3zxiSjSMp/+/Nzj6RbljRuC84xfRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nUK4PEh8hNIhC+Rpiya+h3akbo1+uvOym5Efc/EMME=;
 b=B2vyJay+rJmDel/G4WaHJ0PONEReMJFHCxhxnHb48ONto+/G/L0ViwH7VY+2ht2WYcI5nXVHRlD731g47fC1R3LJSPMc1fWb5WiJRc3CI25yvhwjEXVTEm+kjKkMxqv3A5C0E+LRD3CbiaUr2UosyR62rI2zghPb/c2G5m9X367czPqWBXLTifv2+X+3eQ9JPyvdxQGaH0raSH1l6ynRfKnWcam079F9F+0BwQfNi2S9VeCAhGTkj0hn/5c607OGJtf3CKZ15QaK0HbqDy35uwSyoQDNFMabfH7jcPfNlTzEczy89YOVPETR9XqLW3g4SRhnAZ1UKygcG2nmQhbvQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nUK4PEh8hNIhC+Rpiya+h3akbo1+uvOym5Efc/EMME=;
 b=L3DTj9Lw45MQTFA+aS/u3gs59ngj2Nhwumrb5I9fJfjhTuLgwVp7CP89J8C1ObEf5/uX3pt/JEjebnHfG07OSKVjcPfgbBvUhBd18ClNpJkAkmBGGutloIGXT3Gd6aiI7mkXIv5mkZtul5UvUdiRAfGyVmfw9De1j7MbXYFvZkE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TY0PR0101MB4238.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1b9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Sat, 15 Jun
 2024 05:36:56 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%5]) with mapi id 15.20.7677.024; Sat, 15 Jun 2024
 05:36:56 +0000
Date: Sat, 15 Jun 2024 13:36:52 +0800
From: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: serial: 8250: Fixes: Fix port count mismatch with
 the device
Message-ID: <Zm0odLN7ZJ/qI1nX@localhost.localdomain>
References: <20240614090322.2303-1-crescentcy.hsieh@moxa.com>
 <2024061406-simmering-sanded-17ef@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024061406-simmering-sanded-17ef@gregkh>
X-ClientProxiedBy: TYCPR01CA0144.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::20) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|TY0PR0101MB4238:EE_
X-MS-Office365-Filtering-Correlation-Id: 3289349d-d5a6-4654-9668-08dc8cfd2b35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|376011|52116011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8v6LqqclyyqEwP8Hf7PM1OvRJfi+4S8exu1WMQhOGD3qnT4//aUNFeC5BBHA?=
 =?us-ascii?Q?gXqYhmcCmNBpVZrJW3DcsDEb62HKqCylA+zH0l5140bIj1LquuVBUp4ECt9U?=
 =?us-ascii?Q?RFKU8Ao2en9CHpA966nzrNlx0mYJVPjkgU5kTGJg0LXovyT2Ov3pdjV/eVU2?=
 =?us-ascii?Q?HLLrziCAOqupZ3S2WtekeiE4wyCyKX9GypaI2dxkGAGY+shEPc96Frfp3MQu?=
 =?us-ascii?Q?CK0I9AVt5PbX/6d4KwdcYezERr7gme+FHC32ecQmf1wQNoY08wP1X5eLFz9r?=
 =?us-ascii?Q?AAf0DklTxDu56o9Wu+yrd4mHK/R8zgaOL1Fw+e5AZ3ga4Pti1s1qs65BCaPL?=
 =?us-ascii?Q?32DDPNdnNnhEQK9vNsUmoaYBA0Z0oMT2JIhKkKOTMw1YsqQBJ0brgdcpt0iR?=
 =?us-ascii?Q?ZOfu8nU8V9z810VrC8StCEIAjCuUCqKIJuj+6MwZPD94TbmpHdKLv5rK/9K7?=
 =?us-ascii?Q?OqedRcwcoyVcU3mmXLpviOiMNFvaWzZMzxMEeQhcL9g195ifrLN/i9qP36N6?=
 =?us-ascii?Q?+jnmYHeMlmUnJ0g3Q6iGM6rHbktnIUws0+uG51HYQCIyj4pSrqT6y7bymmAn?=
 =?us-ascii?Q?wEhKPPgKJ6Hh7VopUR6cF/VsNkKh7mmjKbEOuuEjD9iiHW57/6vAK16xuvs1?=
 =?us-ascii?Q?/uZtouoZxESTzonppmJEnW41PynOfhaf+AEygaxf7OnQBnzrVU5Q/PTvrvwK?=
 =?us-ascii?Q?Lq7s87j4qHN4msgq9nInrhHw5KJoH8JVvVbE2UP9rrxjCc4WczBkainVwzKu?=
 =?us-ascii?Q?PzF70mDMIWR3fxWYbS5l+3vJpML9VfLDpoJ3kW3KfRAl7UKxcppfpIcKdPQb?=
 =?us-ascii?Q?+Uz1Wq8BsVboeYh0sv0TRWzyyQRnntlg9lAcYrww0iniMDTtgYZQ7oIHB1ta?=
 =?us-ascii?Q?6KzdBNlbZ046tsxhqTbnpPugxCpoQwIC7G7RGb5iGXASHMG4qDTOHbhZr4As?=
 =?us-ascii?Q?Cd9PqX2NwCJ4jYXRKMcD7x8CLka/FVCuc1kgNJLBjX9TbwFdgjNKRCzbSaT/?=
 =?us-ascii?Q?f5PYwf8RGU/X5a0gWpROTuAerho612Wm6i/NAoM07bxCylBdBj2g9tErirED?=
 =?us-ascii?Q?HuzemrsGOUaLVrFWmG+o1DRhMW2V4lp2dPxbZplufjEc8WBWDZe4CLh4tJ8V?=
 =?us-ascii?Q?cZBsstq/z4bCfXzd7IbIHgeSG8SthQqxLBTjSAjprkwu5sG2UT4eY5fo6b+j?=
 =?us-ascii?Q?VO6SWIc/Jpr0m3wyJNmh4vy7gfn/228+e5r4vi4sH92Xrnb/YgDCFW3isO13?=
 =?us-ascii?Q?v4yBrnmeYKLLcyzsScBQmGcojjtCxWKsuGPKtVB/dPVoHhTrljtNIYuroJwv?=
 =?us-ascii?Q?JMStsUpqrM2R3iaNXoBvBXbYPPLfM80XWUefXbIqCTT1tUW75W54qyiaROQX?=
 =?us-ascii?Q?A3nvwAc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(52116011)(1800799021)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v6j+kRbMR8SRYiXlRJ+Ql8yeDPXIbU+NhhkYKZJjIHHyx0QQSIjofRA6E1u2?=
 =?us-ascii?Q?3yzUNyZs9WnXLp9Tgw3H4gJYJGrfIrhgp7JBfbbmemxgvRS7fy+Dcq0eGXsh?=
 =?us-ascii?Q?kHr02LCOoWOkbsTl1Y4VdMTfqX9NACoYr64S6ydcj/FzsoruAuuxMpry9Y7/?=
 =?us-ascii?Q?XE2YFFUCxnOlb/rIVg7sbGZ3ozWloraHmUAQ4JrSbKcg8QHY4D7RQhCOcgFH?=
 =?us-ascii?Q?ZNKH6+6jzzkXUg72xejfZsBvTiNEEguBylfTZCNKGds+pnPMK1Ke7yUKCGiG?=
 =?us-ascii?Q?x1yRf8bvlVCtsZs7DrAfqXRLFxBrz/KfdDRwn3haltdEEvPz3IKrcYTBEF4B?=
 =?us-ascii?Q?Q/Yr+PORx0v9ixpuK+t7c+JI1hKbWlKzRpFOQ92VbSNASukvyNTDvTwFEgsn?=
 =?us-ascii?Q?shq47ez3k+4/fthe10bVdJSr1hiMx2+ID1MBDhoOFqoUBZoBvknM+1r85BTv?=
 =?us-ascii?Q?URtaqmnzOSIVPwdbMX8PZUuN0istDxXGZSWcf1oXLqUW+GlXDQp64/+lglK6?=
 =?us-ascii?Q?EmHieE9DPPj5Y5Szy9Jm/dwTQo6SludeDwQ2JbVn+0i14KpCJVvwCI/bDFd5?=
 =?us-ascii?Q?dkZhzdscBZBM8HyJlux0jBRZpv7v4UwMYRxBcIprJ+Fs4D5HCot+9rItiPey?=
 =?us-ascii?Q?ffIRgS9FDNb9PyvuqVSIJINThuFtSO4YtG5zEGHhfYRwVPzKb+m6xB/4x1HI?=
 =?us-ascii?Q?JFysLn5BMST2loJvJKyzH916MNtOheiVo6T4DuvJZQQym2R6y+I1VTaTexuk?=
 =?us-ascii?Q?acsetLsDPiWE/d110aRApvjcx4KvU5+u124oU4ncK6XFa+sTVQuNTqqrpJWQ?=
 =?us-ascii?Q?P+aR2jMcqYfyTQFiEEwvG/NeIDaYiCHMS+W6UNFK5B2t7WhJsa4k76jfjw73?=
 =?us-ascii?Q?OQ9zJCFQjtm6e/90StoJqSx9GWq8SYsARliw/C35rbiTYF7B0zmOkWsrbcIW?=
 =?us-ascii?Q?freEKDcfYlly4RXGv/Jss8xNyM3lHaRMpcGRlYqLBcfhM9G/nqXct+2v9Erm?=
 =?us-ascii?Q?ohxf8yTWy5CuMDlsgKtub06WmKDth3N5zwjgM/UaEMyKMbx6pu07ocUJS9n4?=
 =?us-ascii?Q?Cdgvr1E/gMAsx/5ME77D6F483/BE0buKhxExE9uxNZGHYeM+v98Bpv4Xg7jM?=
 =?us-ascii?Q?O7jX9aZn7vpN8GTDyaPI5gK70j8NTQ1tlYAR/38zTsaK0486asWDyLmR2nvs?=
 =?us-ascii?Q?9e06e6Rx4Z5ciDTuMuUszNHiK7UvGUrorHpMFa9IjowhoTrgmK+V95+oH/d0?=
 =?us-ascii?Q?sVrc1v6sD6XKQt4HBNNHn+IRtXLgwkFTvMW2YUeStw1bqgUQUKv6Xc0D+jlu?=
 =?us-ascii?Q?il1IV9n/OJio33E2Ul5pkxazRWW/dPMKjUZs9FwLl32s9uNIMmYgGYa9p9LO?=
 =?us-ascii?Q?lWU0JpeeBwE7fLuOOAO42PfBX/s3R836hH0ywbwABGDbHAr6MkzqHn/iZedO?=
 =?us-ascii?Q?LYV3Iyre8LWexugH4HA85VyhZzXzSIUITklGfyRu4gzxo2P1GpgjVSLqIpCJ?=
 =?us-ascii?Q?b2tubvfLZ4HTSFfAKh0ZqeT+3Qx1XSFVYY5szDbsIp58mPRUacXAH9rDlvNI?=
 =?us-ascii?Q?G6yBEUR8Y2a30NbmFGQCV3flYEFxj09TX0FP8Uc6keRqWGTSDmTBx8tGaVB0?=
 =?us-ascii?Q?Sw=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3289349d-d5a6-4654-9668-08dc8cfd2b35
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2024 05:36:56.1298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XzcsAUKjNs8BaDFKHsY2XwnU6/epF1JG5TD+5oMnSnDcxPCb51noseTu+vofkAoR5Iqs7M1BTZSH7y4fEfieKMw3wOjCM3nrzN1UarN3kVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR0101MB4238

On Fri, Jun 14, 2024 at 11:07:29AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jun 14, 2024 at 05:03:22PM +0800, Crescent Hsieh wrote:
> > Normally, the number of ports is indicated by the third digit of the
> > device ID on Moxa PCI serial boards. For example, `0x1121` indicates a
> > device with 2 ports.
> > 
> > However, `CP116E_A_A` and `CP116E_A_B` are exceptions; they have 8
> > ports, but the third digit of the device ID is `6`.
> > 
> > This patch introduces a function to retrieve the number of ports on Moxa
> > PCI serial boards, addressing the issue described above.
> > 
> > Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
> > ---
> >  drivers/tty/serial/8250/8250_pci.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> What commit id does this fix?

None, it's just a normal patch, I might have mistakenly added the "fix"
tag.

---
Sincerely,
Crescent Hsieh
