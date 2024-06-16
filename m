Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2104.outbound.protection.outlook.com [40.107.215.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCEF163AA7;
	Sun, 16 Jun 2024 04:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718511390; cv=fail; b=lW/dCdr9sTl8Waf5DCdQH3UUkp2phkXqHt94GacroxYXjxDqUjU+I4Cv9Jm7wena8HPyCSuRNXU7Ib/bqlSzOxYnmwHmTBuJK0UE1LmjlniMACmAj/g5YCpV4XybsFGhpnFp/nJvCr9OEdqh4Wi3g6J2fTBP4k8x0DkkP99KTeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718511390; c=relaxed/simple;
	bh=Y5OW/y4SKNnqjes/rx1NTYFw/xuw67hUofKvurJkPrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DN2U+mQ+LHkkaJpkL13kSCPbSxYMguN/L7v9rkD3XY+uWqaajO25tkrS1C5ymYDH8wMSwW1P4TCLfC1W6s9B77LLo8kb2pk7oibUqiVTwiiQQKGNS2AT7p2XCPZAaMUlkEdBpW2u5VPn+tPEVuzH+Aja5j8JcMUvZ4gEUN7Iq3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=FCACJrM5; arc=fail smtp.client-ip=40.107.215.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="FCACJrM5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxhYJiJGEOhalNLvB2ybRByqbqAaLE+rVHwmpXvcC7E3b2ASM+4nJLyjwdvI/Q8YRnmVM3F9SCDS9mlAMptzwjmMh/wwn4d8mADlzyZ3GNserNOTTeG+kNCYZfGa583nr3zXb7whXa15z4bNguqDRrmSY1ok6S/1FiLtysgJBE4WgN+KfIbI8ZRGIZxsaJTbVujd2s9gcfMow9TTfnjKWZ5M0rl1n5tQx4zvpJBQvNIVZOFXVEJZY95FrAUWNE2LuBtH3u0d2UlyZ3cJoqc48RBe92EV72hP3crKLlCWg/xYoNTEfaVIS3l9Ug4lejmiAO5jJhtiNXl+yc1rnynyXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNCnL2jFrqBeAih16JJPn+9phYXyPMQQ/2d9WJ1sP+o=;
 b=kJYzZptx9s4JfqJZ6cqO3a8zrH0sVTmaZ3PXbarI+sRCTd/UBJPCwubjMteRwAm3dI1/mfEmQG2y4mNnBUi/fEqwNC9wzFwgRJVGFY52/ZSWWyYfRPgNIDaF7frDX9ylGeeQJJTQjW2liHwupsUFKnDPCh8scXDPcwtcNyQy5OASMkpq+yUsiZjkJQ93MUnkAjDyzaZ+5MYbZjqzzqSiBj9+XA/wb4Xh7XBhqPfP1hFjZ3biIipi8J0vaeLgrWk1gv5pMigekNgIihPqjIiFSZ+zzGEJ/Mmer6F4hfShYnl0IRjO79nPZAzaWjcrRd7ZSnUgIrYcXVx2A8JAtPQlUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNCnL2jFrqBeAih16JJPn+9phYXyPMQQ/2d9WJ1sP+o=;
 b=FCACJrM5QPbzjlnoRtsPEYhftiOCEYHLN/+wm4f+W5WhRgBKCWPrPHdbEyn+AD4apuGjpxKj3ezh0LoWrYIjeL1inynCSJV7QZSfF6n4Jn6Jw5MtFynKW6yUux4Jdt0IXNqbsJL85DrizbvA+0jBmcTfLbsRDJRZt1/JLIlSwKo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by KL1PR01MB5875.apcprd01.prod.exchangelabs.com
 (2603:1096:820:108::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.28; Sun, 16 Jun
 2024 04:16:24 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%5]) with mapi id 15.20.7677.027; Sun, 16 Jun 2024
 04:16:24 +0000
Date: Sun, 16 Jun 2024 12:16:21 +0800
From: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: serial: 8250: Fixes: Fix port count mismatch with
 the device
Message-ID: <Zm5nFVCNfLZbW5tK@localhost.localdomain>
References: <20240614090322.2303-1-crescentcy.hsieh@moxa.com>
 <2024061406-simmering-sanded-17ef@gregkh>
 <Zm0odLN7ZJ/qI1nX@localhost.localdomain>
 <2024061500-jeep-upchuck-6b3a@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024061500-jeep-upchuck-6b3a@gregkh>
X-ClientProxiedBy: TYCP301CA0030.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::20) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|KL1PR01MB5875:EE_
X-MS-Office365-Filtering-Correlation-Id: c911622c-12ce-4b50-e48e-08dc8dbb15c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|52116011|376011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4BP9Ai78kb0mXsvNackOoFJl+tiDlwiKEcKYy2MhqqdS4gEOS5AhZj+XE9ny?=
 =?us-ascii?Q?HUzCnXpKguxOoBtEFTbRqxNgs6dC/jEg62fg3365MPNh1kFVDWBAvlV1mV4S?=
 =?us-ascii?Q?BhlIRz9gIOVKtNVrRSBM9hVwQPCXBwbDZ9jSS537C+1B3A/D6i048vEBVx/g?=
 =?us-ascii?Q?ddEiFpAtGACWn0Q6I/i3FPOaqLyFKOSeCi8bEqMZIXOgiumwc5D/RjecIIYC?=
 =?us-ascii?Q?SewNaXUavFfie6pK+xDoN4LzAb1I2bo/3xEQLjb/eldpUFQ/Qm29cs8JlEHz?=
 =?us-ascii?Q?n1QWfYTLnOCUKu0kxBhTDG46FqCq8sH0cqzK/sZgyYfx8siNU+X2b4fBcsZM?=
 =?us-ascii?Q?YmSOAv7ZDnbP1WGSSwi2hBfBAi9VYTVm++dS5zxfHrcgjE+gZ149ciKStAo5?=
 =?us-ascii?Q?545X3OqSfIStH72gK9zOuwgclHwwkigIMSCEXkNQjyatiEMyltbSe2vi+H5Q?=
 =?us-ascii?Q?MBAeItfei4e+ygI1HE7tS+EKhxywfZOyz5t2odmCJHOvbl0XKxrEFzb1TmP5?=
 =?us-ascii?Q?ZPJMC92fDnmLp0T0mM2BNMTdnei0VOeZNKvRIKtK9NwLtllzOJFUt842qMUN?=
 =?us-ascii?Q?GCt9t/KNnrsn+NCBKjgUg9N+OMIt88HSgUGEkpc8CEofFKVjv4+4ny/iEkOl?=
 =?us-ascii?Q?nLQ/oC0slcgqZtCam7ZV5CF6VoxjWXbYyIejldvtvRkdsT2lDofSzUXkf3/U?=
 =?us-ascii?Q?DIHSnikCTJDTv5XSeHsgipQK9OtBi2Dc9QNtuu3LBunhtyJa5z5qnENtmGPp?=
 =?us-ascii?Q?S4narohFWYLROHnUBwF1PVDm69vgCUFsBt8jgTiPRl0P4d61yd0j4fcUWXK9?=
 =?us-ascii?Q?Em2PE4WFmnacdXtBWDDuQgSfUbe7NAhKSxygKpankjI2Izrdy3vBKHLzD0ep?=
 =?us-ascii?Q?p4ZtiCibrQi3/jqzqXqWv1lOiNRC8Gk3cHX9KAazkdPqmd6yihF9tDv9YihQ?=
 =?us-ascii?Q?eusorR7FM6Ok5RGuoNMuZUDYVSeGYUJF3QyTSF2ACN1hETzLiw5fyGL8xxC0?=
 =?us-ascii?Q?93ah0Rq6b4IfDAsSSvpA4aKccCD9IAprhdL3Qa78Z7aSeo2H3OoPmfwAvmxg?=
 =?us-ascii?Q?sgpyhu4YsAGqWiLUc0tptvUZrvHhdVWlREi01WgsSLYnDCFTbNxpH3JFWtp9?=
 =?us-ascii?Q?pFTq/WRveBi0uuX33AHB9deBSsUTNt1mihXgaMlsNn6GkwHM9TxYSraG0E5M?=
 =?us-ascii?Q?C1sMRZnBwY5ojfsg0BAUvPpm7jZXLctvPuE0CsWEHStRM2yTRIuF7Dyoq3BU?=
 =?us-ascii?Q?Pg4ijvXJtjb4OyhK1ctqJZhtJ2Ci8VtgrQKJrJLD3s9I4+iFwlMNrjUgwqr6?=
 =?us-ascii?Q?xA+6ciH949Un9KWdJV1qLtgD8yNGtneWFQy+AfZxH/nHdTclO81X4anXIa5g?=
 =?us-ascii?Q?jSUH9e8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(52116011)(376011)(1800799021)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?07TLAUCBAB+TxQZTVbIoB3IwOFLoqYkuvqL16o+9UAoSk1PKrElZADntBght?=
 =?us-ascii?Q?YhF713aLOQqf0URwBQBvSw7eKvNgy0jbuHwoLFY0ze9GOWk+GIwzUo90k5KW?=
 =?us-ascii?Q?mzLo5V+CQM/GEOmdOUguw8gTY9HfkXkWP7/He7I69tGdwHpcatm6d75jG+q7?=
 =?us-ascii?Q?eeijQjtM/DhSzkgT04QU2NHxgQRJ1sOTo7wmqdZ1p5GgbrVROsTW1+Is/Xe7?=
 =?us-ascii?Q?JdqEp7R3vo528Bzu7yGD3BHMpm6OUpdWaPTKwtC43n0wtRG7OHvX0kdpxqsi?=
 =?us-ascii?Q?43B359SWRJFu0GsOeVuKFXAwfniOkylihT6iWShuKZmKaM4yHivpFqtPZ00Y?=
 =?us-ascii?Q?CrPWtlLpKsiQLgM5wMwBeRUf3xCGfMUOOVoGtOun8YTbj4pVf+0SZt2/HqDl?=
 =?us-ascii?Q?m9gR5Ih7ZNP8MXxd71xPw5+z3+GWdCym3FphQZo9rBgOOjqHp2+vzyHr12aR?=
 =?us-ascii?Q?hnn01dR35j25paLoxZqIetVNpu9jbxW639nivqpUjTQNknc97UJiEBitMCWT?=
 =?us-ascii?Q?Yf9PnVJZne4QYPlkaf+QL5RtsaU1k5aOg6w7/pbtCE/BYxLwaeVrR+Yxcht8?=
 =?us-ascii?Q?vxagjFMFZopEQRUx9RouLayfEqAl1SzidYSEqcnMtvZAsaFjAki9HIkUNR7Q?=
 =?us-ascii?Q?KTCnXkyStFu+Ih8x5V1aIdEJ9CW6HR/QzxE29+hMdfMddJcFfDcj0ORmj+nV?=
 =?us-ascii?Q?lW4hf6XD9THwuHrRMb7Vgw7V+iWtEtwL1uqNqwHLa+7AMU0zCyQesnmH3Dft?=
 =?us-ascii?Q?OLTAiz85cueHjRRVL1f6Y49t51rv/wIhHfFMKkP1PK1heR2Cv0ZrlmsdN+so?=
 =?us-ascii?Q?DHlDmTw+T95M/4qM/vpkNF2bGfGUG4s5cKJ4zzY2IIZF7JNkgFU4akRWSWuo?=
 =?us-ascii?Q?bsf6d05kxhDsVOxoSUDZ94ftTDRl3uTU88SNuJcfE0gnE9TQzeps/syRIDYC?=
 =?us-ascii?Q?Ru9AUcCY8yNwNSaLafpFH1ckDWT4OdkxkrbYVB+dsK3w7ABZ5ZpqUrXbEaJ7?=
 =?us-ascii?Q?WwauryG73hAzlnGIU9UOOSvAuirJa02BFRi4rTw7KAhuWZR9PGWUFuWleyEF?=
 =?us-ascii?Q?iwN4BvXv7UehWJF26ZegsIMoVXES1mkjdNZe4GTUEWQVizCFeZoS5gFYlmYj?=
 =?us-ascii?Q?6Je/girkVMHBsniiarR0q52tPhAHslqcQ4c4KcPQvFLewRTrbeAzjYWSUhW1?=
 =?us-ascii?Q?MdHz07d9WgsnAoDT6sf7j/UC67IXItpZ+Zmcg2T3FAVq7WhIYhugYELSSwNn?=
 =?us-ascii?Q?S+B1iKbWQDynXuITC8l1yfxeWkMZJNQYRW70Mp2PBbmqP4WbV8/W8P0IN4Ez?=
 =?us-ascii?Q?W3OJJi4YHpagacQqM3XlJfQNlaSCpT4z9JF+boZjMzvW5IjS28zNDkJZpvyg?=
 =?us-ascii?Q?8IIzR9SEQCQiEAbJzlAU1fPyJqH3LUkSWMFG96uN/k6+isW6nhL7pP93ZSe2?=
 =?us-ascii?Q?83/TGtSGXGxqLqo9Au3Fu1dtpCKmYLb0X689xLckmIXVhPOXBnxv00GffXWm?=
 =?us-ascii?Q?ln6Jt0IaTy4tsAy3mbl1DCRzXNLRNeGRMahFfNxjskxMRJn766IPlkdMMXAI?=
 =?us-ascii?Q?NKik0jck2EKl0Mfrtv8QEeaY0U9IJwUShPzVr9zZ2hAPq/IhxnmvhCIVHlbg?=
 =?us-ascii?Q?KA=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c911622c-12ce-4b50-e48e-08dc8dbb15c9
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2024 04:16:24.5665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oOqVwZkhhurK5T/LEdwRnm3LLnjBrRlea0kuJAAt+1tHmabNNgPez0bE8sgM9Drsr04iDsxE2r0yXU/uuMm/qr31QzrHXBdesvwBkWKqwvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB5875

On Sat, Jun 15, 2024 at 08:18:41AM +0200, Greg Kroah-Hartman wrote:
> On Sat, Jun 15, 2024 at 01:36:52PM +0800, Crescent CY Hsieh wrote:
> > On Fri, Jun 14, 2024 at 11:07:29AM +0200, Greg Kroah-Hartman wrote:
> > > On Fri, Jun 14, 2024 at 05:03:22PM +0800, Crescent Hsieh wrote:
> > > > Normally, the number of ports is indicated by the third digit of the
> > > > device ID on Moxa PCI serial boards. For example, `0x1121` indicates a
> > > > device with 2 ports.
> > > > 
> > > > However, `CP116E_A_A` and `CP116E_A_B` are exceptions; they have 8
> > > > ports, but the third digit of the device ID is `6`.
> > > > 
> > > > This patch introduces a function to retrieve the number of ports on Moxa
> > > > PCI serial boards, addressing the issue described above.
> > > > 
> > > > Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
> > > > ---
> > > >  drivers/tty/serial/8250/8250_pci.c | 13 ++++++++++++-
> > > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > > 
> > > What commit id does this fix?
> > 
> > None, it's just a normal patch, I might have mistakenly added the "fix"
> > tag.
> 
> You say "fix" twice in the subject line, and it looks like it actually
> does resolve a problem in the current code.
> 
> Or is this all just a "cleanup" change?
> 
> confused,

After reviewing what this patch has done, I found that it does fix the
problem of retrieving the wrong number of ports on some Moxa PCI serial
devices. However, this issue is not severe enough to cause any system
problems.

Sorry for the confusion.

---
Sincerely,
Crescent Hsieh
