Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE0DCA0EEF
	for <linux-serial@archiver.kernel.org>; Mon, 11 Sep 2023 21:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348724AbjIKVaW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237928AbjIKNW5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 11 Sep 2023 09:22:57 -0400
Received: from DM4PR02CU002.outbound.protection.outlook.com (mail-centralusazon11013023.outbound.protection.outlook.com [52.101.64.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7C8193
        for <linux-serial@vger.kernel.org>; Mon, 11 Sep 2023 06:22:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WH0fPGLrWL2Dv1WLS8uKOgNsWV3siqArO5uf3qMDoidREvCPFVYn5DOmiuYnBBv2dCt06Ua41n9jhOqdx3apjtrxZS0IlEhmS9LFpaX69z9ZpB87oHyX8Tm91/oBbsCVIb7PFwFM/CqrIkfg7cj/Lo3sJ3wnKbmnmv8U8TXEIb6HOe6Ryk4zzJtD+BOPqqbDCQBEUpe5+085hC2k4apEQbH3Ej+8VpI1XAMriRUPMGOzdFoRPUeXqwrh1Ile5rx5FFmzpkl2mO3LDyK1kCpReTLPB1Bf9WSg7DtinMyKbxBP6WqNTtjLopwRZBFcydyB+BWYoScWOUr2X7RF+p0V7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAkCGVqG+4LTuXw+Uc7Ls9RzIE8QrBrc1fsIzZU/Iuo=;
 b=bs7eJcuxtBfCIwjGNiihEb3fqD487xTiykg3czmk75qDZC82tfUEuqxNSKi7PFFVlaIh7ae+qzCOwUfVC46sHhiCzmi76N9itVPDWIXYsFavH3De5lpEW3kpoJAWMMz52QLVge19+dWe4uy7BECNekdpHegz3MO3PbvW+zBgpz7wFW3tKcZ+spZrjxu7dt7Ja5qdzSDiex3sCqI9ID54U1w8KyfPgQVdSI0nO1ufrW5TkZBSoN2tnqxVE1vQYM1ePkrlm5t0j043FIzAFzCNJRHEZc752MfIALCtJ05fkj4NQ/z7k7T8rYusIExo7g4Id9u96hTDNmR7BywyZWJvqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAkCGVqG+4LTuXw+Uc7Ls9RzIE8QrBrc1fsIzZU/Iuo=;
 b=M34i9bQQdeBdlMtK4DkgMLEu5zAhLKIT0dHG6HVix/vEjAha9c7ApKzXtlW+hnVCFNy4ia/laa44GhXWxKjtQCt9P5Hl6LsiFr5mUSfyT+e+w8DY42UdvKAwbZlacMI0exOxN+xwWGznvehf3D8upD0/Ob70WBEODrA+WdZLoGyX7M9Di7K6wsT1XAM34KJIyg9KwZ2OzQqIZEkg+OTPHtCUBb+B6DYk2U3f5LatpcJlbrEFzxlkMW28zAhFLMK9H5P+HzkrtNlU69LhSQB0Hnq9Zk9yDPL5mehY36mvkMx7QpM7VeBD8ue7sSMMCBfPb4jo9qXs2DK07WNCdIy7Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealevel.com;
Received: from CO1PR05MB8426.namprd05.prod.outlook.com (2603:10b6:303:e5::11)
 by DS7PR05MB8950.namprd05.prod.outlook.com (2603:10b6:8:86::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.33; Mon, 11 Sep 2023 13:22:49 +0000
Received: from CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669]) by CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669%4]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 13:22:49 +0000
Date:   Mon, 11 Sep 2023 09:22:45 -0400 (EDT)
From:   Matthew Howell <matthew.howell@sealevel.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
cc:     Matthew Howell <matthew.howell@sealevel.com>,
        gregkh@linuxfoundation.org, jeff.baldwin@sealevel.com,
        james.olson@sealevel.com, ryan.wenglarz@sealevel.com,
        darren.beeson@sealevel.com, linux-serial@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH V4 2/2] serial: exar: Add RS-485 support for Sealevel
 XR17V35X based cards
In-Reply-To: <ZPiXLdATKs2pD20d@smile.fi.intel.com>
Message-ID: <f9984ae7-354f-4c14-a62d-73e51cf3ba6e@sealevel.com>
References: <e2564a57-128e-cd9c-9bae-23b155fd8ee9@sealevel.com> <ZPiCPJYfiR9ZfVJC@smile.fi.intel.com> <375eb5e0-27db-cadf-721e-2d5c0cd150f4@sealevel.com> <ZPiXLdATKs2pD20d@smile.fi.intel.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: BN7PR06CA0053.namprd06.prod.outlook.com
 (2603:10b6:408:34::30) To CO1PR05MB8426.namprd05.prod.outlook.com
 (2603:10b6:303:e5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR05MB8426:EE_|DS7PR05MB8950:EE_
X-MS-Office365-Filtering-Correlation-Id: 7edfd16c-7d76-4a7c-c7c1-08dbb2ca31af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /BQf12xADtBPNxPyDpuES1MyhNO0QVqZb4GgHUyGmF/TrFJaZqo9//PO1LLbbH8UFjPwXuN7VkyTn0ifOv3ov9/Z/o6NJb6T7i9b3DxJh1/YC72qGmG8QkJJ17cCFSFmUkI7pWOGiJf2XnYufi17qdTm4I/5zrodngPxAw2+Ifr2ClCG3wb+QYkT0yeW4h2XPcv4jEi2CpMJXIGuE9w2iSEqdgbcPHEs/kEtwuOLrAijmWP0WGsaYiPJYV9iS3tUOIvTsb6TJ0g2FbTHIwXAmoNjWi971CExZ8xup/KXJgHUuOWTA4uTQK6y80WxOIdLu+0ANyuo/Ak8eQMlbpRKWlNojK8WXqe9IjToJYangbURNNbGzEqgbmM5ky+nZ38Wv1XDobiyZatZW+1wdcX2qRmU9Aualkm1gkdClwti+aSny0upEWXc6egLcPH8qIxrEKDfP3OtEtKumK4dLYL1Audb9E/oTqktLonOFKnw03cDJ1nPvXO6R9RrIgqHiPn3kRrOvnZzmlU31m+1G74kz39n2FECBnvjicTFciAPITnnH8MnyEi7D3yBQazFbS64I9AroGKYOpF24EzJKBtOrnuzi0WRPMn/FS2nN81V82q5Ae7RIriMc99XZ1LrJELtL9CTIQE7oNtHtIoPd4ZdnoU6o94SyCDUrKJ9beOGlKw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8426.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(136003)(346002)(376002)(396003)(366004)(451199024)(1800799009)(186009)(36756003)(6666004)(478600001)(6486002)(31686004)(44832011)(6506007)(5660300002)(8676002)(4326008)(38100700002)(8936002)(6512007)(2616005)(66556008)(41300700001)(66946007)(2906002)(6916009)(316002)(83380400001)(26005)(31696002)(86362001)(66476007)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5b86b7QxixG8g2G9dhZmg6wQaCzIiZZA0BOk0nhCKIxclluhoF1CSeKjHEh1?=
 =?us-ascii?Q?xh8ePLiJPRXGmBoqBqV0lGTGpaPhALCxXlcB7Dnv/hbWDzJyYZWtmU8JuWiG?=
 =?us-ascii?Q?v33e/4QHB52vcMD/sdVtHsabWbeC0vWO3eCFNDxdE+E0TxdqutvDXlJh/gX8?=
 =?us-ascii?Q?BsIx0Q3D+IRlt/xbVVooViWi81wXfuN0/H9yh7qTIQF/0ZObbEnxldALkwlt?=
 =?us-ascii?Q?TJpiMHlDdDyvW9daI+nNojij6qM954Z4aG0S4JO7oxihz09uVLd/oqh4U1L5?=
 =?us-ascii?Q?Ow41T/SOJQIdXuUqkjzIXHc+NptLXtlWZ6KERtYc/FbSYEGoac0p6dRwMJbu?=
 =?us-ascii?Q?7t03Obqj8Vvgnyemjl0TcTc3uaIpKAC/aZD0pEi9rNxgJfyHWak4DPyxTKZD?=
 =?us-ascii?Q?BGDDP2QXHTL766q5k6YsfM96+J2i7e4xmLJ20rUZELI6rmG3H784BMh1hgYW?=
 =?us-ascii?Q?8SjpiG9rwoBlvmO8d8jibOpJl2ApgQ1RnwB7d0OBiwu6CupsJqTZNyWGgb7q?=
 =?us-ascii?Q?g0ubllcpJCDKZBZBlLFJ0glPumI04Y9DtbBrv9vEEFn4v54E0ciCD9wIktSa?=
 =?us-ascii?Q?vHC9Fn09rVFjDsZCrZtuDWp9tkYHCcdXZhmdeggUEy3LDuEdaxWGbNnhAGvL?=
 =?us-ascii?Q?QrKpFT25FJUlPLBpE91XITIABx/kgVmv+qDNLAKNFoms6aJ2k9rf8KR0Vvdr?=
 =?us-ascii?Q?vVNRancJ3kWxqRQA8iL+75AItOE/Tx3yQRb0aMFlYpA/5zpM+hHr0AiT3Ttt?=
 =?us-ascii?Q?sWumDOQsbxtYb+YorHtTmQjQQQ3t9H7WvM9kBQM/T1hfuEPfzLUe+BLZvmDK?=
 =?us-ascii?Q?ajRCoLD2YBgY1uOUR/qNTBm0tyfoeFQQ5UIyAOJ/C5/H/b7E8/QFHqSWw9dF?=
 =?us-ascii?Q?SLGc65Ceo3Hsr8rfx0Of9enSytL7m3qVWd4W0szFHUJ7i9HuHTK3I79Xt8uq?=
 =?us-ascii?Q?S4XCWUIdM2X2d7zixYLOkyIdjYwlCtIBgafLGIdSKLrB5ucPnKCb/iomYMEA?=
 =?us-ascii?Q?rg3sqUFwOTuaZ0LBWB+OBGF/lpBypHfDGq2xWGGoQECcp14MA0ilATBYHFat?=
 =?us-ascii?Q?qWSr5QRpFyVY6ERSiEs6uxMMTJ9yicmwaZ4EBG1A4mbUz206YgKYHKhxL5em?=
 =?us-ascii?Q?vhY4wVCvoZLQZpR3ljQ2qUL00eBEQMfcQJ3j4IeTXSXOR6fXOBPvgm0h0OVn?=
 =?us-ascii?Q?V/CJdWjJrHQaB2qRYInYeHa19AtG3NSt0IF1vd8ZQARnJCXTnRPz96uYwDjW?=
 =?us-ascii?Q?JZP86HfeFX09kpyO6mqPxLy4A6RzLG6zKeZ/oCuqF3kuPmbEWGfqbLoiXBm3?=
 =?us-ascii?Q?gcuXKaL7NXiFc96GdJj1MKDEJ1KJxPmi5ymrewgTOxMvBbJKy9LIzI/TIkmK?=
 =?us-ascii?Q?W6wsNDip4Ld8bDFjfH16IG+95PU7mZ8V/r23qaAplxbt4u02G9ohwHFx1bbf?=
 =?us-ascii?Q?96TMlNh9OT6lH3tuNpbP5pgAn3X7hwrpwbXqYMG4BP02+ISu0Lj5K/BGJvVV?=
 =?us-ascii?Q?EXlLwcr3cPsHCONXmOnOQm8YzcRXI+7dJuQ+ujMB81rrGyOh3OulcfQZU8Kk?=
 =?us-ascii?Q?o4FMhruBcywkD8TtfIFl5vZm6pgZzEIHLED5c1cjwXxc/tR12oXNlsynhWFw?=
 =?us-ascii?Q?SQ=3D=3D?=
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7edfd16c-7d76-4a7c-c7c1-08dbb2ca31af
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8426.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 13:22:49.1316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwD4TT7qaaLtTSfDXvq+tyd3rzwPw4ZsPTqBUZStLaFoiVr2d7ifKsY0SUGKO6Yd0yFhifK3lPCUBFeHZ/CHFFgFguUOIr22mPRyiT7JcIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR05MB8950
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 6 Sep 2023, Andy Shevchenko wrote:
> On Wed, Sep 06, 2023 at 11:05:20AM -0400, Matthew Howell wrote:
> > On Wed, 6 Sep 2023, Andy Shevchenko wrote:
> > > On Tue, Sep 05, 2023 at 12:06:20PM -0400, Matthew Howell wrote:
> 
> ...
> 
> > > > +     generic_rs485_config(port, termios, rs485);
> > >
> > > > +     if (rs485->flags & SER_RS485_ENABLED) {
> > >
> > > What I meant is to have
> > >
> > >         if (!)rs485->flags & SER_RS485_ENABLED))
> > >                 return 0;
> > >
> > > here, which allows you to reduce indentation level in the below block.
> > >
> > > > +             /* Set EFR[4]=1 to enable enhanced feature registers */
> > > > +             writeb(readb(p + UART_XR_EFR) | UART_EFR_ECB, p + UART_XR_EFR);
> > > > +
> > > > +             /* Set MCR to use DTR as Auto-RS485 Enable signal */
> > > > +             writeb(UART_MCR_OUT1, p + UART_MCR);
> > > > +
> > > > +             /* Store original LCR and set LCR[7]=1 to enable access to DLD register */
> > > > +             old_lcr = readb(p + UART_LCR);
> > > > +             writeb(old_lcr | UART_LCR_DLAB, p + UART_LCR);
> > > > +
> > > > +             /* Set DLD[7]=1 for inverted RS485 Enable logic */
> > > > +             writeb(readb(p + UART_EXAR_DLD) | UART_EXAR_DLD_485_POLARITY, p + UART_EXAR_DLD);
> > > > +
> > > > +             writeb(old_lcr, p + UART_LCR);
> > > > +    }
> > > > +
> > > > +     return 0;
> >
> > I see where you are coming from now, but I find that slightly less clear
> > than having the 'main action' within the conditional statement. And since
> > the code is not heavily indented I don't see much benefit of removing the
> > indent.
> 
> In that case it might make sense to split to two functions:
> 
> func1()
> {
>         ...
> }
> 
> func2()
> {
>         if (...)
>                 return func1()
> 
>         return 0;
> }

I will have to respectfully disagree on this. Splitting the function into 
two still adds additional redirection, however small, to the function. I 
would also like to point out that the level of indent I am using is not 
uncommon in 8250_exar.c and as such I do not find the styling of the 
function to be out of place. 

I will resubmit and try to address the other concerns raised by you and 
Ilpo but unless Greg KH says otherwise I don't see any reason to change 
the indent at this time.

> --
> With Best Regards,
> Andy Shevchenko
> 
> 
> 
