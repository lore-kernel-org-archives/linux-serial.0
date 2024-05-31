Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2128.outbound.protection.outlook.com [40.107.117.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDF1224E8;
	Fri, 31 May 2024 08:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717145920; cv=fail; b=ViZgkSCkdx4UvV5CQyLfSuNSywMwu8qg/RnL6tsvsynKcZ44FXb9hhCpcPmFuyg7aBflJmOEKrBZDoJnRQwMQlGFpRlyNvisoSokjhFySni9iO9LKj00Bvf6AZlhD98wvLIVL2T8SEK4bPNSor8+bpFMpUJPRTU7ZFOskou4HSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717145920; c=relaxed/simple;
	bh=KNPXWI3RMV+2CxSgU5dmBC8X4VDjd7k7shLk7u6hjtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p89Ar9rkGPWhqWwy7ODyaU9cIV5ocb9lbZIVJ1O325X4plvri8Kva5AhTYUOys2Md6Uv7nG5lIdHEFGLRbjWrYoj7euTL66KpJneXYVXpectwH2ru4NrLMyKmlySGqNey2G9ongJZglsH4iWxsLZJkPbV63Urojno8roYdOgAiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=SYQa0cHl; arc=fail smtp.client-ip=40.107.117.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="SYQa0cHl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDnf3GkTZD92WVZIk4W7H2j5vY3y8AvkuzzO0mgvio2PU7O5ViW8Oz2FgvxMjHoqDjAaXh3eR640wsS7t2edkQB8b/dwbXw3CRZ6A+RQNwiZqao6zZpUlt80JVwMDet3hNbRxw27/W28FCDQITOVz+4TsOpjSv3ToQ1BDczCYIGNHGzbQVBN+i2/0kVEUkAf0KgoRlm3BK8aZ/2uP+nLoPcJ94/A4Vn6uGB9GdRD/sYRLDk3W84/AcJzmk+Tb0CZAcAGZm7jB07jwipuhpX1d7VGgzpY77f5p+FVeY7SB9jaz5pasBH0rDeSYoPS//DvlDnzDTir2RWK6nG/UYXBcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEsz8HHwJIaLC9U6ucU9KX4xnrswlSAq/UaCbuZRBic=;
 b=SCommnAaG4/jhJgiNZso+eA1lmLcla3cL67RiZeGtnmZ8HXHkzXr0leZTPZ5Ze48BXkeW8Ayaf8rnHy+ZdNVNSKpEwcNW0bVTBLum0hy0JEoLw8FKZNHf0j+bj9YnIyzXDcshAz+flAAktSpysicF2chk8srWFfsKxgQFmc6JmP45Lm5D3rZsl1pZvRCHFY4G7a6NqMCrCJbiI+I0i6U6fOj7UAMjeLxgTKQRR4zs1H70l0IhSC4rgbaRQutiFsfs3qjxHb4je+93VOOGY8gxcE2w/1cf1vDMv0FYoXRXneLxt2n2IzivNtU1YduLInOrzYFJDeyLu+8amo45nqOsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEsz8HHwJIaLC9U6ucU9KX4xnrswlSAq/UaCbuZRBic=;
 b=SYQa0cHl8L6fPzlp6ir8pxkWRrQXpc3huTk0scU/cXiXuSuamzuw6tSlGthXypBH5dEHIqzBthYDhn8HhHHPtVr0Nl9XAhw3yAmFqJN1kML6i7aoFMB1ede4yMyV00c61bnOPqt2SbtBElJRSjUOo1uozqdhB2lpdF9r2Q3EX0I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TYZPR01MB4260.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1c0::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.23; Fri, 31 May
 2024 08:58:34 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%5]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 08:58:33 +0000
Date: Fri, 31 May 2024 16:58:29 +0800
From: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: serial: 8250: Passing attr_group to universal driver
Message-ID: <ZlmRNVONKs3MWnM8@localhost.localdomain>
References: <20240530094457.1974-1-crescentcy.hsieh@moxa.com>
 <2024053013-clapping-germless-d50d@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024053013-clapping-germless-d50d@gregkh>
X-ClientProxiedBy: TYCPR01CA0179.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::14) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|TYZPR01MB4260:EE_
X-MS-Office365-Filtering-Correlation-Id: 777b5077-3ba6-4b15-e785-08dc814fd9cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|376005|1800799015|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3aZZyCdXWYT2EwtmXIZa8SKqWLXQpx1tH8AfvknJUkC6urHbaR0gLnZR0Awo?=
 =?us-ascii?Q?Lr4cJ649PmFYEvPorWfUuQXfQflTKY6Rrp/YRsKfkwY1AcbiDWiNpmRxzV28?=
 =?us-ascii?Q?yDf2Ly6Whynn/WKkdUB8sUHk5I0ikAWERfe1VBsm9ceiplReOzROXbqnU00K?=
 =?us-ascii?Q?FrnGSMN2BMDojGI2H6+Ohgzd0O6ESOelVQdWnIOoY73VoW+gggS6W4rCsFZD?=
 =?us-ascii?Q?j+r3v1JbEySPqpvAzIrSLhIUOHK2HIuqSPlPmWyGDOGK5EnM7KQW2lercyb/?=
 =?us-ascii?Q?6eb3NaW+qgy2avIdto4AZPCX8NAG85qEkGAXUUk3ZlqG43pQU65GugI57TsG?=
 =?us-ascii?Q?WjI+rsQadis94mgS5IU263lNGifTm9/Lbfga6Vm+AUyEJmB6a/RZmH9ERb+r?=
 =?us-ascii?Q?8UkMNc62tDSn5f1k1iSHdF1W/izs+Cf+pnsRY3IJgM+lVDZ5GtdMu/rbhhL9?=
 =?us-ascii?Q?9gs2X3XbjA3yZf7AY7aKyxdHy1usLeoQ4hKn1BK9ZYYBbw/k76+suzmqZxuV?=
 =?us-ascii?Q?BSjiu8sfERqVx3uDsBx974gYbvBTyUeEtuzJ0ZAELad5RUBlm5KdR1Qf/slg?=
 =?us-ascii?Q?5gr7Mlc5x0CT2nuPCcYNCSgzAcBgypEN4es/jTwkc1FMBLrTkzyOOlA68Yyt?=
 =?us-ascii?Q?WZ0exlBmBZc7cg1vOgwkw2XWWRwHDYY6nkohglI+mqITOZ5YD4rFZkkTXMgG?=
 =?us-ascii?Q?bTEiCOZBCcOgmdnPsQsAulV7EDLA9O9AgwvZGmPqx6vMesU1ygV/1/l+InKF?=
 =?us-ascii?Q?MrzVTqT657ODsBuf7HK6PCKK9lp+q2bq7PX1V9mF/LzkHF0e2axJpUqFVs0i?=
 =?us-ascii?Q?Bf6pTs0vOCRKy9FvQO1Vc4jJ3bXoljZ7LM20qYUc34X/rIBYsM5zxpmA6XyL?=
 =?us-ascii?Q?oHvo+rcqlNwasY4K31FtJ0Y+BjIIvXi0w/XSsr6QHpc98Sd7zE1arZW68Mx+?=
 =?us-ascii?Q?KciGjWOYMWa1GSsoT+A4EiwIPnokCdpnoDLCoC430JW2pSvqwcVWtxbbCPFd?=
 =?us-ascii?Q?dlPOxtQzhFiWjbRoufsULumOZsV1HqmiPklol6RkB8b/Yl32ddit2gGhsfjW?=
 =?us-ascii?Q?eo0GP2q6MhWIZ+caGWjekc5Tm1nJYASjvUkKXldsLEIOR7398Qk2QKb352ma?=
 =?us-ascii?Q?7HmtSWfBtHfyKFOHy+oeBwhuQ5AsFMTm6js+P1nXizLt1EWn/YSjvf5djDwX?=
 =?us-ascii?Q?EVJawUTxXKmCXe2oMAsG3eXrObwrDK1GQLo7WT+rC/HBrhpiHgZ2LAIylsX8?=
 =?us-ascii?Q?9BOX5oEt66CvOIRo52WzhIrFn1c0XZ43JEjYZ/a/LA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uAkmSjlEnt/MqzNV//NenoxFsJLR0GIGA5fSObSm+yBHGZHyDqy5Fs/xe74Q?=
 =?us-ascii?Q?lne4cYl+dKJBc4Ra3jNXgMCq7vKrbblUPo0llAqwhQd1od9SzhFK2hxdxjV4?=
 =?us-ascii?Q?BrD47Gct/hbqBSLQvG+lhqVQtChdu5j+2leQIHhBn8+QJ0QXtMWMabmswKwe?=
 =?us-ascii?Q?FBbcjQMCshAWHwaxNC9Ueo6CpIzyhtYnr0melp3pcQuOLLtQc3wzfn13HEiC?=
 =?us-ascii?Q?2x+E8w1AdcJkyGJTuZu4cbJsre0EM0yU/fPKDHnxhFM5uz1UwUfYVp0GH6gf?=
 =?us-ascii?Q?gWyRtgOWTI2IYYBK9BeRJXR9eypJAXhriUZfae09uMsZB+2wJIuRxars9/Es?=
 =?us-ascii?Q?ZnRPcgFxdo+eWUf8tg3vqQ/P4pjl1J7LGwSGH5eFY0BYGu4o01mGYhK7HVZn?=
 =?us-ascii?Q?qHezYdcwie5gIWv0Fu9DFgQZta4O1Exe/LuZ7WIiekCheUJ0X4NVSnegmdOm?=
 =?us-ascii?Q?JV+GJxZdD+QRiS4xk3QVNtZoZC4pEMITc6fXtzDnFpHeN06olw22kJ5ZbiGe?=
 =?us-ascii?Q?dQ68lPwpOsZVaLvvLsagC16ExBLH1vUDUqlx7xzRR+cbxsHcAQpn1T/hIH4o?=
 =?us-ascii?Q?CqUvmJtucPqw9BXBiQTG5HqkibUe+y0UtcbHYqLga0cRxeXbx0pmgEvLIAhV?=
 =?us-ascii?Q?rctw0ka32sReCwnWmHC/21OXs+Yc3qr2OXrNdpew4+2jAbdPs2ifJfHBoRYS?=
 =?us-ascii?Q?vVNp6rR99FIoHRh41H0bWCdh7EMfjk+Ar0cpQ32N3JSHhYP/QRwg6EK6e5yu?=
 =?us-ascii?Q?5N9U/7NFUFw+G+xN+FRlWo/fa+P7cyeRgr5D/gczuewufDT9PVcMfkOZBPac?=
 =?us-ascii?Q?qEkikD+BvqxjeYIv9rCnSxkiT6sGw8/w+wYwfavGfeIXFIV+6RQrBINxAyQW?=
 =?us-ascii?Q?LMJECRdGMdf5z9l2FsNt52JKJLECoDumPOZh3xNnlGpCIC4ka66RmQUvPXrk?=
 =?us-ascii?Q?UvZ/ZfVUfhYxIWTtPoWWZKoR+px5AmRGjvmybfGiGa6i84fZ7h1cWw09NzUB?=
 =?us-ascii?Q?230ZXq0cp5YfndXsmFMCAcq0Yokh2vOBfEiOBEFkk+ABK0MGxSIfZKmTU7uI?=
 =?us-ascii?Q?3HanGxPDTpUDWBnKc9rwY5x6V5papXTfD9iio6LQa+EYvL0J7uzzdBu4wZpM?=
 =?us-ascii?Q?nHENozz9XCKpDiXFrtiDFZbTpYXdrgAqGwFrWzdbddYufq6Hw4zEnHscaBLr?=
 =?us-ascii?Q?sNpe8wTaYBNQ94JvLV0GrYSrdWo0qZSLPcH7v623qySPnEc53z/cIUDw/xtO?=
 =?us-ascii?Q?MU0h3hVnW1xhFav20VXycHHmyIB688s12bkj4FLZ0BYtKL5kxoTQd/rTrpEW?=
 =?us-ascii?Q?JlNsi0lEDcAl/NIMlays+Le1J1/XkNX1/okQ7I4VyLq9dnr5iPsWmGs8wo98?=
 =?us-ascii?Q?o2bui7zuBQzqpvWAKQtfAzncwEy84waw7bhqwH78ZmPXPjG0fuAJXp7kqiiq?=
 =?us-ascii?Q?bpWCmHc8wxe0L/tnuaH/x1FEjcuzdS7hiCi73aBpHFaDd/fIh8U8x4YHDcTM?=
 =?us-ascii?Q?zVWQNOsOOQY+8uJ95PrCC2XJfPBqCQkYsHT5mGGzkBouTzrCreV20148z+O6?=
 =?us-ascii?Q?pTSimUdpE1RptOqGUm42Opn/nibKkKYNTV8NFZdwnk53C4pU3xCSh6kzVQ1/?=
 =?us-ascii?Q?7Q=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 777b5077-3ba6-4b15-e785-08dc814fd9cc
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 08:58:33.8716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CKB5X3iM7zh++F86CVw4zv1/RDYsrCIuuMgEntbtZXKD+Lh28QSKdT11ufk03V97qt4YsOyFykc8aLKv6KsVsD2VHHNNsQS/pWPW856uwwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4260

On Thu, May 30, 2024 at 02:45:02PM +0200, Greg Kroah-Hartman wrote:
> On Thu, May 30, 2024 at 05:44:57PM +0800, CrescentCY Hsieh wrote:
> > Many low-level drivers in Linux kernel register their serial ports with
> > the help of universal driver (8250_core, 8250_port).
> > 
> > There is an attribute group called `serial8250_dev_attr_group` within
> > `8250_port.c` to handle the `rx_trig_bytes` attribute:
> > https://lore.kernel.org/all/20140716011931.31474.68825.stgit@yuno-kbuild.novalocal/
> > 
> > However, if a low-level driver has some HW specifications that need to
> > be set or retrieved using an attr_group, the universal driver
> > (8250_port) would overwrite the low-level driver's attr_group.
> > 
> > This patch allows the low-level driver's attr_group to be passed to the
> > universal driver (8250_port) and combines the two attr_groups. This
> > ensures that the corresponding system file will only be created if the
> > device is registered by such a low-level driver.
> 
> Great!  But is this needed now by any in-kernel drivers, or is this only
> needed by things that are not in our tree?
> 
> If in our tree, what driver(s) does this fix up?  If none, then for
> obvious reasons, we can't take this change.

Currently, no in-kernel drivers utilize this, but I can add a patch in
v2 to demonstrate how this patch would work.

> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> > index 893bc493f662..ddfa8b59e562 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -3135,9 +3135,31 @@ static struct attribute_group serial8250_dev_attr_group = {
> >  static void register_dev_spec_attr_grp(struct uart_8250_port *up)
> >  {
> >  	const struct serial8250_config *conf_type = &uart_config[up->port.type];
> > +	struct attribute **upp_attrs = NULL;
> > +	int upp_attrs_num = 0, i;
> >  
> > -	if (conf_type->rxtrig_bytes[0])
> > -		up->port.attr_group = &serial8250_dev_attr_group;
> > +	up->port.attr_group_allocated = false;
> > +
> > +	if (up->port.attr_group) {
> > +		upp_attrs = up->port.attr_group->attrs;
> > +
> > +		while (upp_attrs[upp_attrs_num])
> > +			upp_attrs_num++;
> > +
> > +		up->port.attr_group = kcalloc(1, sizeof(struct attribute_group), GFP_KERNEL);
> > +		up->port.attr_group->attrs = kcalloc(upp_attrs_num + 2, sizeof(struct attribute *), GFP_KERNEL);
> > +
> > +		for (i = 0; i < upp_attrs_num; ++i)
> > +			up->port.attr_group->attrs[i] = upp_attrs[i];
> > +
> > +		if (conf_type->rxtrig_bytes[0])
> > +			up->port.attr_group->attrs[upp_attrs_num] = &dev_attr_rx_trig_bytes.attr;
> > +
> > +		up->port.attr_group_allocated = true;
> 
> This feels odd, why is this all dynamically allocated?  You want to add
> another group to the existing group?

Yes, this approach aims to add the `attr_group` which declared in the
low-level driver to the existing one in universal driver (8250_port.c),
so that it will have the attributes from both low-level and universal
drivers. This ensures that other device nodes utilizing the universal
driver will not create the unsupported system file(s).

Sincerely,
Crescent Hsieh
