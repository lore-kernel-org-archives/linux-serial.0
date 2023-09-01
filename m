Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2BBCA0FE1
	for <linux-serial@archiver.kernel.org>; Fri,  1 Sep 2023 14:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjIAO0R (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 1 Sep 2023 10:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjIAO0Q (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 Sep 2023 10:26:16 -0400
Received: from CO1PR02CU002.outbound.protection.outlook.com (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79059CC5
        for <linux-serial@vger.kernel.org>; Fri,  1 Sep 2023 07:26:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDX31MGf1Jh7Hmkqw9WSaAquta5fyYbXPacYgoqn0PTAHiSFbcZy5eLopahbMUawSVrLCTBncpFm8GVypY7DGq4qNxrATsosG9OJSZfYJ36WK0YAAAd3MsetARarZ2cEM0BaNKnrKzl8V/2l9Tv6kBFbi3qXAmmcgcr2u3voTHtD5HFzcePXriLsFxAYdWTtu7QgCxH7xLv8D3X5uDiRXZBIIC9/CZfonHdpdLbMqg1CCiwD5NaDXycaK/bDYGVTYIQe6OiPMdAbCGZDCoxFeOxj5gsgVwTj3l0w7q9pvl4dwu63uiFYVtuuX/herwqQ4AxQTurX1mMZmyjFa03KDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRgzpZinQBnSOWNIu6jJw+lZJDPDtuiRlNEJrTCl8LA=;
 b=Vqqm/+AVw3SgDpj2GFYdVzFs5tRdR1QmcnsmdKdYsN82hQqBuQsAG9BEAAh5nYnmCL9YuExshvNID2XzUO0kfLLieAGA8yuJJkqDTfU/VoQ3qvervB1/Bs9QWHC8mfsQHmb/E9I/s4pZb+FQbqJ/5OorSrmc7ruvs/fb6tcbEBUA+uH6aAkyYvveJlIgo2XNDjU4TN9SGHZrX9ZOr2IRenWqNWaUsXzgKS/yaEZwZvOJW046xm1bJ/q18yEyrS82qPEy7PjBW6wNTvp9D1bzPTn//BXw3l3gAG5XJzwysGSd/i08pceEQG3ecJe/K+QzgLJycL5dde/aEPTZqYoP7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRgzpZinQBnSOWNIu6jJw+lZJDPDtuiRlNEJrTCl8LA=;
 b=DbEtqcjj2vPMtIeyh+TblgeNmf53ASq18fLS3Ne28z5TM/Uj8YyJLbB33fiPMD0ErFjyhU8pApXo1qud1vjcKMwdzI9KZMhjHhtYKjJgSV0S9FJ35pAZNmoUg0yNzyzFVmno/WN0ARoG2k/u51nMpaCu5f1TFgBtsm+RZv84HKloBzOFA+lriiurfTMeZqvU63pGrxMyUfQo2DErPu/5a0MbotKa0EqQJDezfPgLk2+dAWyU82D73Vv7jCOZEHJcwrl3kSHxlnA6Yn80ae0UBfMAUX7ardMQBuH7Omf4/WLIC9tCG5yqv//UdKY/HilHEXTQdfXsAQ5IsT/Qd92a+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealevel.com;
Received: from CO1PR05MB8426.namprd05.prod.outlook.com (2603:10b6:303:e5::11)
 by MW4PR05MB8601.namprd05.prod.outlook.com (2603:10b6:303:120::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.27; Fri, 1 Sep
 2023 14:26:05 +0000
Received: from CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669]) by CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669%4]) with mapi id 15.20.6745.026; Fri, 1 Sep 2023
 14:26:05 +0000
Date:   Fri, 1 Sep 2023 10:26:01 -0400 (EDT)
From:   Matthew Howell <matthew.howell@sealevel.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
cc:     Matthew Howell <matthew.howell@sealevel.com>,
        linux-serial@vger.kernel.org, jeff.baldwin@sealevel.com,
        james.olson@sealevel.com, ryan.wenglarz@sealevel.com,
        darren.beeson@sealevel.com, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH V3 2/2] serial: exar: Add RS-485 support for Sealevel
 XR17V35X based cards
In-Reply-To: <ZPEflBvmd5R/kImw@smile.fi.intel.com>
Message-ID: <a4d66170-82f3-5021-2991-3b67e6eb86d4@sealevel.com>
References: <b0b1863f-40f4-d78e-7bb7-dc4312449d9e@sealevel.com> <ZPEflBvmd5R/kImw@smile.fi.intel.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: BN7PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:408:20::15) To CO1PR05MB8426.namprd05.prod.outlook.com
 (2603:10b6:303:e5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR05MB8426:EE_|MW4PR05MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: 629088cc-da37-40c5-a2a8-08dbaaf76065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G7C4Klu3ufG8A4y2q7Wu7TWbL30jDsW5fBtgejqlozf3Ftwy+sFKj14CB6AMm98yctq5Wo7cel9xIUJQBiDJnpohyCSBE6UMJrbPk1ymZB94+IdmToVo9Kfv1Yvy/wHmSXByCJYZMqliMznmzt4XJCtg0HBv8H/hQ0Ri55zNw+7e4ozoSwKqphaowG+/lz7sojtJp7kejwEUudhO7GooW/CzuiTyEQGcsXjeREDG/9KcAg/xsr6UhLvN2/z5M7SA2ngpDqxh/DvrpMqxB0uMmdimNsShkEesFkywxU3VFGWgM5ryYLGbs3v16Kt0V+Laj0S5nVGeSU3e2i2zvHGatCzzi4RYN/w3oKYj8utkXBR5LMsxr2vRtQOzv7lTlOi/ENFv1fVL4XIHI9IfTYf38dMTWxOmDGfMekMjxHbbpx1YOYG9bhz04920nfBJhYxdvr0QdDYKr8BZWckJNagrKelxrKFjvxYOMs3VDGHxKGQh7yASJigtatft6ZaRbRgRHDe+HInR96LgJtUIWNoZXkyrs74c8EwUzr2QSEEQen4oqVA/hXY1JbJ3t2hjneABI9Obum/UWqHUz0ACwWXdxO+WPXDN5LA3gztXhAh4+ora/AfaUBjcyoM4JLWJV8WzLW7MpjG6uDKlwiR19S1ZVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8426.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(39850400004)(376002)(366004)(186009)(1800799009)(451199024)(83380400001)(41300700001)(36756003)(316002)(2906002)(2616005)(26005)(38100700002)(5660300002)(4326008)(8936002)(8676002)(44832011)(6916009)(6512007)(966005)(478600001)(6666004)(6506007)(6486002)(31696002)(86362001)(31686004)(66476007)(66556008)(66946007)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y2Py27Rr04HQLzVaA5G2MvJXjVxg080yWKMlGDDzCD5+4SguHFEKPz4OQ+vW?=
 =?us-ascii?Q?WwUvrfCQ5fjs8ACUBZ4CdCb2+8mNgHjS6zsoNwSJS1ywkTDWDfkOVlaIiT3S?=
 =?us-ascii?Q?AqoZ8BDi+lgl8aXXlBi/sshNFCYntCb9Nr5fai0iHW7F7WAqZzysysSqCSXp?=
 =?us-ascii?Q?tPRy/hq87n/3w9wcdQESRKHFEqn8fMPRhds+M5i+hUM5P4ro9i3btsUkCoyS?=
 =?us-ascii?Q?dQPf3OczzXlmWpuQBPrjRIkTrzuVOJF0ma9GHtFKEcZxQvxGd+MobfaOyyPx?=
 =?us-ascii?Q?CxwGPSkQ75oG6ASPogJzs+jfsoCSV0miS2odtAbW9fbg7vwnr/RFW5cpGA34?=
 =?us-ascii?Q?LnAIqEoevXB4OuxtcrY5vtTDexGUn4L0U3DIj4DQAy9LaIDYLRb13ArzvpZe?=
 =?us-ascii?Q?b/AxTBxPlJbYDzOikQZ2Cgaf7U/i4p2Ujf1jcfcLUfFddwBDlq4sVuVnl9uM?=
 =?us-ascii?Q?Jv5SxIDIGVGeIj+u/YBT2b52Vi/f/yyBMqefGXpWlo5/yimYDHkvZnJoetlj?=
 =?us-ascii?Q?SMkXWHwHFTRZoFQtSKB6MbvaKGMP5kXDkCHdyAxxDODpFS3C6OSW1uGznEmC?=
 =?us-ascii?Q?FdAnYO8CC7HUaxF150YEJszowei0UUgLyXOzOB9KRZ+s3ft6M4QEMx/C7B5+?=
 =?us-ascii?Q?lWJYcPa/ptkf3RHe/+o30KS6qqCpyFDNRZnTvlQon6PGthtgrPrS9S05+pxG?=
 =?us-ascii?Q?rQ00nhsTuu84E8hSGMKMi9aMOw9P4Vz7zLYGgBGy7Wxt8AooaoVZwonuLslA?=
 =?us-ascii?Q?XlxthEgT9apGa8ds39rCMPYhve6V5Y7uRkniQa/kwPwVfO/5Auz2M12RHQke?=
 =?us-ascii?Q?AGzz7GDYynO4n3JrSU2iHPtXvpzGaCscHfeVi6BAEF+IwiqtwgdydrTqIJSe?=
 =?us-ascii?Q?aYHO1DD0C36QyKDCoGK4ci1/Cn7K4LDtIUSusvLBjFIr7Mc5HFaFdFQox6nT?=
 =?us-ascii?Q?fyiXpIYxgdorHtPzrIESYvq3bxvLCaDQEKAgEX8tb0Ob9fSr47JlLIrsHyY7?=
 =?us-ascii?Q?qaX4yr/meRHa4b21xJHHFed1yn1y5ov8U++9ui7MZ1qXoptbkmIDcTuosZaC?=
 =?us-ascii?Q?4asGc78I5LBAyy0e2Ra+L0EwGZq6Ys+p3oR00YS0oGXu5gPIEbcTaiaNCpP6?=
 =?us-ascii?Q?MlH5UcsJ7jUhx6ZJwwUc/16RG1Nd/byAu7u3tpYyjTiQ5Hfk0O705gCIiCYQ?=
 =?us-ascii?Q?Lf4LoJlMB8FwcKveSk9Ye7QZag8XmXu5/SAQAVXDrD/3x0mVWwGjAH+sSHU4?=
 =?us-ascii?Q?1KzBsWgdmMnRIRub+dMhc7J3VCOAzfTW5rVkNs75CZwJky4s1BXZMZTgVipS?=
 =?us-ascii?Q?kip7nZkl9QDILtFPw0lyLkkuPdzmjRYp2JVW1+BYRUcbz7Nakm9Gh6t7YzUI?=
 =?us-ascii?Q?ibXHGJaweRsnEq6IFsHa3aEmKhH9C5oOiIlnYKBxWd03gba6JtDLUhC+L6Gj?=
 =?us-ascii?Q?H3wmo+h85XmTmTx9a1CwXeiL/IsSTPF3xrr3NWzyQGNzCfgMVlaq00uJ8+RH?=
 =?us-ascii?Q?aqxqB+Ka4L9OszMrf6U3xSaoALKhqpjJlOiZ80pV+0H9B6lSZ74yyIZUnMl/?=
 =?us-ascii?Q?gdKgekDMhpsTyoRO6Ko9X6PwZ7eRxgHqBfcvOsprMahcA9yNN+wcI2p/Nhkn?=
 =?us-ascii?Q?Mw=3D=3D?=
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 629088cc-da37-40c5-a2a8-08dbaaf76065
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8426.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 14:26:05.5503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MwjCUdBeGFQbYiOW7C+QgDXBcjErrS3j7NojaKOrncyfVWE+fp9CTeL6ZDZxbQIafD+eH8UPqws2CySQhqTAg2MLSvDkK3XPZViV/Ds5umE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR05MB8601
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 31 Aug 2023, Andy Shevchenko wrote:
> On Thu, Aug 31, 2023 at 03:48:08PM -0400, Matthew Howell wrote:
> > From: Matthew Howell <matthew.howell@sealevel.com
> >
> > Sealevel XR17V35X based cards utilize DTR to control RS-485 Enable, but
> > the current implementation in 8250_exar uses RTS for the auto-RS485-Enable
> > mode of the XR17V35X UARTs. This patch implements sealevel_rs485_config to
> 
> Please, read Submitting Patches documentation, in particular find there
> the paragraph that matches to "This patch". With that, amend commit message
> accordingly.
> 
> We refer to the functions as func() (note the parentheses).

I did read it but it was not clear that the parentheses are part of the 
'rules'.
 
> > configure the XR17V35X for DTR control of RS485 Enable and assigns it to
> 
> Your lines have trailing whitespaces, please get rid of them.
> 
> > Sealevel cards in pci_sealevel_setup.
> 
> > Fixed defines and various format issues from previous submissions.
> 
> What does this mean? If it's a changelog, use the correct place for it
> (see below).

Sorry, I did not realize. I found that section of the document unclear on 
first pass.

> >
> > Link:
> > https://lore.kernel.org/linux-serial/b2a721-227-14ef-75eb-36244ba2942@sealevel.com
> 
> Tags must occupy a single line: a single line per each tag.
> 
> >
> 
> Tag block must have no blank lines.
> 
> Most of these is described in the above mentioned documentation.

Sorry, I had missed that tags are exempt from the normal character per 
line limit.

> > Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
> > ---
> 
> Here you add comments and/or changelog.
> 
> > diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> > index 3886f78ecbbf..6b28f5a3df17 100644
> 
> ...
> 
> > +#define UART_EXAR_DLD                                0x02 /* Divisor Fractional */
> > +#define UART_EXAR_DLD_485_POLARITY   0x80 /* RS-485 Enable Signal Polarity */
> 
> Mixed TABs and spaces in a wrong order, usually we use only TABs in such cases.
> 
> ...
> 
> > +static int sealevel_rs485_config(struct uart_port *port, struct ktermios *termios,
> > +                             struct serial_rs485 *rs485)
> > +{
> > +     u8 __iomem *p = port->membase;
> > +     u8 old_lcr;
> > +
> > +     generic_rs485_config(port, termios, rs485);
> 
> > +     if (rs485->flags & SER_RS485_ENABLED) {
> 
> Seems you haven't seen / ignored my comments. Please, read my previous reply.

You said !!() is redundant and I have removed !!(). Previous feedback also
suggested that is_rs485 is not needed, but I had reverted both changes as 
I initially thought it was the cause of a breakage. However, further testing 
found the breakage was unrelated to this patch series. Therefore, I 
attempted to address both suggestions by removing is_rs485 and !!() in 
this submission.

I did not ignore your comments and I do not appreciate these insenuations. 
I have made changes based on every one of your comments in the previous 
submission, I just did not always address the comment in exactly you 
suggested.

Please, clarify how this fails to address your comments and I will be 
happy to correct it in the next submission.

> > +             /* Set EFR[4]=1 to enable enhanced feature registers */
> > +             writeb(readb(p + UART_XR_EFR) | UART_EFR_ECB, p + UART_XR_EFR);
> > +
> > +             /* Set MCR to use DTR as Auto-RS485 Enable signal */
> > +             writeb(UART_MCR_OUT1, p + UART_MCR);
> > +
> > +             /* Store original LCR and set LCR[7]=1 to enable access to DLD register */
> > +             old_lcr = readb(p + UART_LCR);
> > +             writeb(old_lcr | UART_LCR_DLAB, p + UART_LCR);
> > +
> > +             /* Set DLD[7]=1 for inverted RS485 Enable logic */
> > +             writeb(readb(p + UART_EXAR_DLD) | UART_EXAR_DLD_485_POLARITY, p + UART_EXAR_DLD);
> > +
> > +             writeb(old_lcr, p + UART_LCR);
> > +    }
> > +
> > +     return 0;
> > + }
> 
> --
> With Best Regards,
> Andy Shevchenko
> 
> 
> 
