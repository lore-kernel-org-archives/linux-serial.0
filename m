Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45255C00140
	for <linux-serial@archiver.kernel.org>; Tue,  2 Aug 2022 07:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbiHBH35 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Aug 2022 03:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235913AbiHBH3u (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Aug 2022 03:29:50 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F904A831
        for <linux-serial@vger.kernel.org>; Tue,  2 Aug 2022 00:29:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQn0tltLZZJlyCta+6AtDXD5+ZOiqnHllDI+AYIVS1+nuiLR0J0pPFxVqbytAApeu4r0PYtM54LHpu/L/0++eGQAIh9ZLgKaZSfMLDR/G6Nv5X0u8Qs1T1u1pH8/3pmO7JnwiIR5ECwnmylAdaA0OHUoIPxeFVokVCEgDMmhLL8xn8MRBTwWaDZUWTPXMs/8J9LH0FhW3ZI05b9kQx5QE7/ASJStuB3cq/tRVQbsziR2hOa+zLx7QyzBprh1cDMYGM/j0W2hfmfijB+XI9I2W6TaG5IuxG3VSBFlofUZFsIfphqo1xhbs2+6hOEzEAMv8r7B+gF2BYk8YAef3ua3ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/oVxCtaL7oRVRR6wMCTHIFnLzXlMCD2YkQP5vnFKsN0=;
 b=W3wpgm0wYWiG1DTnE5eKfAk+Ibe4YtZGY+CQqraPpz9zMsQKio2Z6s6Ts1fAIz28BWDBJC7rNs/OVIKH7KTCJWYTh4cklnrlSZ3rcNCcMySPfo9fD4OKS+QAmucYsXg2/1gsyq/6iJNKiaU9Cp2s097vGRk5tzFRaqUcZNii1uszt2puFF0yd1cLvxYoaabK6pwRvDlwxTX8me0sBokocrNfqQdYJ/aST59f6SLwytuR+ThIHR5tQJEWGfdku74iVtAlLrM5iylqDRHXzVcTmEC2JAMGguTsjgM6WpT3dL5YdSSAVttpF5FlTU+JBbjgjRTn5KppA23iKKKOe4Hirw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oVxCtaL7oRVRR6wMCTHIFnLzXlMCD2YkQP5vnFKsN0=;
 b=JgGYO6NNmj4IwzdlX1lNJd2QMFG67vUqJ4QtamtYT6hR63YpFRFewKvakAOmbAqgiqlqMer0KKJtYXFixHdI9HUZXDqgp0ueDD4fVOeOUIxyIZXg+yb3zKb0eXzHzGXmWrcE0onyIYj/xqIyTkBi5PVxooPUtuiu+aBPjeZ5+Kg=
Received: from BY5PR12MB4902.namprd12.prod.outlook.com (2603:10b6:a03:1dd::9)
 by BY5PR12MB4036.namprd12.prod.outlook.com (2603:10b6:a03:210::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Tue, 2 Aug
 2022 07:29:45 +0000
Received: from BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::c070:5fa5:52c4:5d43]) by BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::c070:5fa5:52c4:5d43%5]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 07:29:44 +0000
From:   "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "shubhrajyoti.datta@gmail.com" <shubhrajyoti.datta@gmail.com>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v2 2/7] tty: xilinx_uartps: Update copyright text to
 correct format
Thread-Topic: [PATCH v2 2/7] tty: xilinx_uartps: Update copyright text to
 correct format
Thread-Index: AQHYo0EQplf1HeKZ3UyzrUDrk4HuR62VXNSAgAXfy4A=
Date:   Tue, 2 Aug 2022 07:29:44 +0000
Message-ID: <BY5PR12MB4902232C79B35E32D1E14E8A819D9@BY5PR12MB4902.namprd12.prod.outlook.com>
References: <20220729114748.18332-1-shubhrajyoti.datta@xilinx.com>
 <20220729114748.18332-3-shubhrajyoti.datta@xilinx.com>
 <YuPk0bAqMIg33EQw@kroah.com>
In-Reply-To: <YuPk0bAqMIg33EQw@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-02T07:29:41Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f4be079b-0272-4ae7-865d-6e90bb80e626;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d77f4e45-ef21-45f9-e30a-08da7458c595
x-ms-traffictypediagnostic: BY5PR12MB4036:EE_
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AWRHRQ4kxE2xGXCMkez8TmM4Gv0QKhqcfhe7PP6jkGC69EfGOuEKL+b5fPNwGgUxXxXT2rv6UUM2BX53WrxO43hts8QgokpDbTzv+gC3V5bgRH8vJ1ORKsHnlJ//vnYf+r40aJZfjyB0atCc2RTXHkn+vfDmi58pMYb2yL2OcJFdJB1eO9dkK1JmORenNeGhsmIaFhahg/+9gRdJOjEfuLg6TgBw3iavTmc0uPVvxC/MnOx2WkLSSuxjbb+FqlDQ/EqdDJD+UyJfh4eKPnwISSqoDhhtXX41ZSZfQIN/HbKrHQLhpVWVemHx3GLXKFbbpgoHLOvbgjYJU1FNWAM+XPDklN8ZUAB7BmI/QOcp4J8ao8JjKV0/XY5qVhPQXlWZfef5uuE6ATDQ/KaTZ2nt9+MDEZhVsTPAqgWRMzBQ1SoIyNPA2MIq84EX4/BS/kUIqkBhr0cGiyfykRuiAJ3z4PWqJpjhvIV1UYrgjIY1jTUSkLAv97yD7jIS4+rtBSnUC4P+NCG7AclvDNeaggMXytfADHvbzvWVHBYiGCv2A+Z/bqHKvIR4PKfgfEBSNyQFWQdo29OSDV3cS/SJhx9wxrfogsxQL/veN0rmJwAc/gor8ON1kby65cc+7e7G7YcBD8alcgqy3Nz9LuXCpkGAod+mEoJ2qFwr5qByHLEq2KLifupQMN8elZQUpkSyzPN8ECLGjfaSF6yPxHRYR2pz+Mf8lsprh7HbQvJa3IcPkekoRBOfsbS4lDVGbj0ylGytmPTS+i0mzScTovmydl6DsiDvmLCiLgXCYwUOEdtARelcHCC4NaOMQW8Gq/eU3xYA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4902.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(53546011)(9686003)(26005)(86362001)(41300700001)(7696005)(6506007)(110136005)(54906003)(55016003)(316002)(71200400001)(478600001)(38070700005)(122000001)(38100700002)(186003)(66446008)(66556008)(66476007)(83380400001)(64756008)(8676002)(15650500001)(66946007)(4326008)(33656002)(2906002)(5660300002)(76116006)(52536014)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qeZqYKhTcaONyTVJTFofbrKEMkY5utIwsv95ctQRHD64AkCKnAb7MwI50Epn?=
 =?us-ascii?Q?DPCO1FIwF8NZVyedqmuCg914aD/9ELLkhOI8UUTtQQkBkwUuHY5pQzCxFqfu?=
 =?us-ascii?Q?PO9TQ8ukq9uLzYfNkb2K7UzddzqLsoVJLtpGk+QqW9pc9v0KGLZU6U9DU/YJ?=
 =?us-ascii?Q?ZGCZmbtLYLQqgRTfLSCf9WnhVR2rWDkv3uBVwQQfY+n1ywl15AbG1OH6hk/6?=
 =?us-ascii?Q?/oWFrzDcSdNexC4k4qZQ/FggJz4SnUSC2l/nByj7EHoIAkhXCQxo/kR7YECh?=
 =?us-ascii?Q?MTmX9m8sGM7V39ars/i22fTpIUJsfDfEIiC7DDwfFQDSruTMPLya7PtycYn4?=
 =?us-ascii?Q?PwvwObczN12bCYAHC6Dx1r1nQZuRaHnJ6wpN3CPw34CkiRe+faOkGazDdh2J?=
 =?us-ascii?Q?b7aiPoSbD70GYl5AVCmrQblzcU7ibkPy5fS/OaLJRvevIlrFcsbPgo6zvlp9?=
 =?us-ascii?Q?p4Xy5CX4trr2cxqvPfytNQT+cweVwkkhVD12rW8krNC4cE+RcKayQq9IOHkF?=
 =?us-ascii?Q?YPkxBQcLHbqcYzM3YUtC85EEUwkfrFGXDrw0h8K84mS1tcadnveTNdG0x87s?=
 =?us-ascii?Q?5wHF9wkLh6CvQjXLhYiOrb402pBhNLTEUoq9zOu3FWcwwnWy39uUXL0z9Su4?=
 =?us-ascii?Q?d2jk+wrCUjXMKeYkqaZdjNLhALuHX0kShT9n89sAg+2CeCZDGDnqCrl1dF15?=
 =?us-ascii?Q?hdtnKp5HX5xebXZ6zzUu6d6mQCCwmVC5Lzzgfjbwh7/rY+0CR8UTS5dMUESQ?=
 =?us-ascii?Q?FbKmfsUiberQQwcJ/zKJ0SsU60Gjq1GPCR9FVJUu1Kh/B6a1UaV6poi/8ysb?=
 =?us-ascii?Q?jC9EhnLR7tzZfjBCpKmfkA0Ox/4SHIDn7f1LwBMhhcAMLUpgyG6JNLHAA5nY?=
 =?us-ascii?Q?TCDZL4gIitnf/tO+irWELoY/zBJD71DDoUaVjuAGmuYpzXFFOWg1QNM+iblU?=
 =?us-ascii?Q?LZSFQZ+cqkmUcM/D5sb+lWgsfcgl3Kd8c5cd1BvyOQPzSNQdDmeOmTd+tLU+?=
 =?us-ascii?Q?gvzJ2+2zHIOxObhe8H96m89iJgJsGVI/8FQrNvRORTZ2ib0Vz34K7TJt55Vq?=
 =?us-ascii?Q?5JHjCwwieYgqkI0FOOeLqTc1sxCx0losL4aVk/79Fa/YLFPqekhp9wbO5E2N?=
 =?us-ascii?Q?JSgG6DFODVY/QbaDch7KuL/wMwLvg656s94hVY6QpQ++uJ4rfvxHUsyNg1TA?=
 =?us-ascii?Q?gg9GwE4FMJk09eaUBZoxfHNBprHFzp1N8PXMLp1sJKCCnduzCILlD/qNXhff?=
 =?us-ascii?Q?GvBltm1U+BSE0wSiA87WQIs5DBCUaw7VpvuuXp9VrJw3XC3HMVtwI9UY0vMd?=
 =?us-ascii?Q?8A8Og1KgNGMMPfM/CUnjOOmTtH2KxMG+70Ff10xXDiCgwxdUEsLj0F5cv2GQ?=
 =?us-ascii?Q?fBpKYsnprnZzaRt6TAxuoKAj6arpAqZTe4umnJrcDSZ5RlJc0QXa5K3ITBue?=
 =?us-ascii?Q?UxVGtshWGuGpfQjAqIkAByE/j2Ls/kVL+adaG4M6q7WJymwIcmbHCvOW43pU?=
 =?us-ascii?Q?QNZIW6gNyipLvySdvRKVHjCGQfv92dMa1yQYG3B9lkEoNo0nd1VLJV7PBYri?=
 =?us-ascii?Q?P/nuXhOMsoCnkifD6U4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d77f4e45-ef21-45f9-e30a-08da7458c595
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 07:29:44.6600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kD+M1h/C8TdN+S0EngnSbN2C1bOdJclidGQsKLKsx9jb2s7rn/60Kge99oNm1bR/f2t5N/A4Xhtjwy/jrclhGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4036
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

[AMD Official Use Only - General]



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Friday, July 29, 2022 7:17 PM
> To: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Cc: linux-serial@vger.kernel.org; michal.simek@xilinx.com;
> shubhrajyoti.datta@gmail.com; git (AMD-Xilinx) <git@amd.com>
> Subject: Re: [PATCH v2 2/7] tty: xilinx_uartps: Update copyright text to
> correct format
>=20
> [CAUTION: External Email]
>=20
> On Fri, Jul 29, 2022 at 05:17:43PM +0530, Shubhrajyoti Datta wrote:
> > From: Michal Simek <michal.simek@xilinx.com>
> >
> > Based on recommended guidance Copyright term should be also present in
> > front of (c). That's why aligned drivers to match this pattern.
> > It helps automated tools with source code scanning.
> >
> > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> > Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> > ---
> >  drivers/tty/serial/xilinx_uartps.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/xilinx_uartps.c
> > b/drivers/tty/serial/xilinx_uartps.c
> > index 51fd09e14eda..8d2c21718869 100644
> > --- a/drivers/tty/serial/xilinx_uartps.c
> > +++ b/drivers/tty/serial/xilinx_uartps.c
> > @@ -2,7 +2,7 @@
> >  /*
> >   * Cadence UART driver (found in Xilinx Zynq)
> >   *
> > - * 2011 - 2014 (C) Xilinx Inc.
> > + * Copyright (c) 2011 - 2014 Xilinx, Inc.
>=20
> This is great, but as you did just touch this thing in 2022, shouldn't yo=
u write
> this as:
>         Copyright (c) 2011 - 2014, 2022 Xilinx, Inc.
>=20
> You can do an add-on patch for that if you want.

I will do a add on  patch for the same.

>=20
> thanks,
>=20
> greg k-h
