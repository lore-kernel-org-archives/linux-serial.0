Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820A5EE14A3
	for <linux-serial@archiver.kernel.org>; Wed,  6 Sep 2023 15:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjIFPFc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 Sep 2023 11:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjIFPFc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 Sep 2023 11:05:32 -0400
Received: from CY4PR02CU007.outbound.protection.outlook.com (mail-westcentralusazon11011007.outbound.protection.outlook.com [40.93.199.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18BE94
        for <linux-serial@vger.kernel.org>; Wed,  6 Sep 2023 08:05:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcuCNmJnsqkVDp+zxjkaS87MsKcO1fvfGzWsZwI1OLjEyX6OpSQrOOtMw2ychftBC6zW9IuKs0cMyZMODjhRoMu1x57oPKvjqLahH9Tvw5XWZ17usw4kC8wHv84G71vLdxWutRhbaI5pqZLCJ0KXiDdPSRZknoIx7/a1HbPuqCmjur/HTu8xoW4TTNJA3xysbef8KxjZX9ro/qHE+6L082BwK1SSrHdzZiWKTxFobCyD4Q3+Nv8dcHiMITRZkn8T3pl02lyGsAL1UmOq8SEIns5tKM16pxUXKgPV2AM4cITdqW+UfJO7UXIhMc3yKv28FdBR3BlrX93U+BJ5F5mOhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFU8oDxxyuO0xsX9d/MjwDuK3zRl+IjXe1H7yvlSAPQ=;
 b=Ttrzh1LP4Hwo4NUEAnzBNy46wKLXkzw/E7gIa6317Rh7TJ27JYStddJJ9uqlEHu97PrvldyAnlCSU0N1QuNm1IWXk8BQAgvGf5rGzVq/PgJSNv7+45MeRdhyUM7XW9Fs1QeWut3cW3zvPyuSICftu+5zVT50miPYc4QpzLPljZGeUFlywRxrUY4wfwvaC6qRHnT5KgjqOXOdL6flvuhRm2/XOheSv4H3u5plmVQcjhOjw8S7kdVHYVhhMqCIZ2QCYvxTUfdsOXU9lj1HFjo+cF4nBSyyFq6Nx1Dr6mVlkfTdpSZaYvNGqtoVDceNUXbEWcFQLp4MsgTL0Sp/B6SuXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFU8oDxxyuO0xsX9d/MjwDuK3zRl+IjXe1H7yvlSAPQ=;
 b=VHmy6ngGu9QJXk4ISEyrSc+tkygiaKK/Sp7f85CTJoXClCEj+S+Ge+OpsvZl9AXz1oJXycp0dULypEevJ8ySGRklCiYpENbr367Znge0Uc/sDq3xNODk+iTf9JVPL2xAEg53iZB7AusuAZePrGqP8ajVJbnFQoCh80+nFYHW/KuCUkjlyEdmnTp+kmbuEnI0MhNnHUkoj5LlB+SSIMTX+u+1CsTXEiRYxuo1BlLAZhuczwmCmcIR1rxdwh9Qt5tvRoC8fZ+/X/24ZrIhUGfZxNUvuTmoEX9yESfbn1T0QD12C3j8bI9CiFrGdJJy1b6XlPljOmM5P91NJb+g5xVFQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealevel.com;
Received: from CO1PR05MB8426.namprd05.prod.outlook.com (2603:10b6:303:e5::11)
 by SA1PR05MB10054.namprd05.prod.outlook.com (2603:10b6:806:335::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 15:05:24 +0000
Received: from CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669]) by CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669%4]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 15:05:24 +0000
Date:   Wed, 6 Sep 2023 11:05:20 -0400 (EDT)
From:   Matthew Howell <matthew.howell@sealevel.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
cc:     Matthew Howell <matthew.howell@sealevel.com>,
        gregkh@linuxfoundation.org, jeff.baldwin@sealevel.com,
        james.olson@sealevel.com, ryan.wenglarz@sealevel.com,
        darren.beeson@sealevel.com, linux-serial@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH V4 2/2] serial: exar: Add RS-485 support for Sealevel
 XR17V35X based cards
In-Reply-To: <ZPiCPJYfiR9ZfVJC@smile.fi.intel.com>
Message-ID: <375eb5e0-27db-cadf-721e-2d5c0cd150f4@sealevel.com>
References: <e2564a57-128e-cd9c-9bae-23b155fd8ee9@sealevel.com> <ZPiCPJYfiR9ZfVJC@smile.fi.intel.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: BN9PR03CA0653.namprd03.prod.outlook.com
 (2603:10b6:408:13b::28) To CO1PR05MB8426.namprd05.prod.outlook.com
 (2603:10b6:303:e5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR05MB8426:EE_|SA1PR05MB10054:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b64a35-1c9b-43e4-3649-08dbaeeab200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: buk2ep/YaAffQYte00Q1d4STA37UXdvCSD4fa8S21UbttO2nwZFBxho7kML7iW+CFZRmMJh+D1zr/y+2/S4z54jM+bwJ2Aak7SMC9SkwH8gKKg+upk36on4Q8E5c2EZ+6XK6bUL+OnA4Xr4qt3s1fcKW+6udwXMsVGsTpurTwwFiVHBPJ4QeXI5Sm917md7DDscJVMHkHnkcZyGzTUVnYw7gIU+BO4cN2ex7CDhfkL7RlCHPy0YENJVU1Qtx5sTOMAIxZzMGd1UlNwcRR1eikQx0FUJlwzjQmzYMSRp0L0ylIy7SRi0xMA5GbbXGCit31M/LV0LeLMKn+MeyMbJssxsloUPNGVwrKd2KdUN6y7q6kjzTWZHRu+UskvpuwyummZgg3L1LWZinZoIOk3HPeze+OKc5ETpYOLH2v1OWPEix9SyGbrPJjwl6fO4be9SUkB2S2GeWeEQ6EPwnVcgaC3WJUXZKuzheaBPsegXZIXgJtrwtMHVkpY5JKOASqyWTecZ7CZCn66L38R48j7BgwpHp/Xs/LLwbAfnxWYpbP8pXuWZsJnX3ppc7rd3crezW9Us6ZCpn9HH9NxDWqa+WexVuWH+NxR2vJ/Yu7giNoLtXpuTO92Ma8aNKKU178yGAq0S5dQyfrl7bx9LP6sHl8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8426.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(136003)(346002)(396003)(366004)(376002)(186009)(451199024)(1800799009)(31696002)(86362001)(966005)(478600001)(66946007)(66476007)(6916009)(66556008)(316002)(2906002)(36756003)(41300700001)(5660300002)(8676002)(8936002)(4326008)(6486002)(6506007)(6512007)(26005)(83380400001)(44832011)(31686004)(2616005)(6666004)(38100700002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FJYzLsbAp63nYJ2/SF2ehVUPD2rLP6LVQGjSy8sXmq2/vcY0wICtjaxPvwY4?=
 =?us-ascii?Q?ciBx8z7SU0/0qZGHRR8uteJzsNCBF11uUg7/OKLXJU5u2/iYNV8eOa58zV6h?=
 =?us-ascii?Q?oLhLOcAjdJGI0xy/LDE00kc+nNAI9iH4x5i3vw/idpRhPhM7PxM2A75byah2?=
 =?us-ascii?Q?m0yOHZEiLZCmniHEeHS71aXRThD5qN54lUva+wh/B1GlbKB5817hNu3S+oOZ?=
 =?us-ascii?Q?kgd49azR6cEV+lzsRJRw5lXXnfJgX+nSv7n0ejRHptM6dQReWcWc7BNz8lWZ?=
 =?us-ascii?Q?0O34TyiXYt8d+0Wcwpw/75oGWRgZJj3kc+NEirxrP2YY1sPuGBotzpURFQvJ?=
 =?us-ascii?Q?kVbPfaMytTEdSQSL5MS4c+31l9JrUhXYtKC9Xcu9U0LhIdKzeqDBn97hUsOn?=
 =?us-ascii?Q?8d3vW0X6PXwWnlcp1Kmg69dX2lOUVvggfETXdd/GbAyWMNnzZNMRGwXaeNvq?=
 =?us-ascii?Q?Dmu/7ns4vtWZWtv8f5RvYfpsTyOYThs8wUVRfXqHLnGTbsgqnz4TQhVwEwXR?=
 =?us-ascii?Q?GIgvX2elwzC8omFEkkCeg0pBi8qZted7KO8Op76A8J9dgWluF4N+CyUYKRE+?=
 =?us-ascii?Q?+3vlDWT/Fj9UnQZpdePDYhC8uLDKUnsV9dHJruEdRPaO9f6icJ3gQDURcSzo?=
 =?us-ascii?Q?cZnEsOPAXiBM/L7tE2A6pB3tNGYIXd5iGonsxUyzZ8hWsvc/zjAmFEFGkT8X?=
 =?us-ascii?Q?Tnnrjv63sTI32rOA6XGrqQuTg8pJrvU17zz7njsrMM0yzBFw2+A1bD9vRA8o?=
 =?us-ascii?Q?gG66Gny7z7/doanw7kuanhFqrpIh/PffeE1jbDM47wbvnW2e/sRqA9DqFSYN?=
 =?us-ascii?Q?qOu8tJZF/8HUB2A5gFo1JhoZiBNKCCEBA/M6RlAenASlUW3Wf+tf4MXqm91T?=
 =?us-ascii?Q?LD5TjJ68A0jtRMpf2bUxe04ebmrnNwXKlssh1jBsdUHXvBOLD6apMAATR7y2?=
 =?us-ascii?Q?SzIH4ifIWC3uuVzhtFZQx9yDqo5dDx4mSHZNrE/TzTIsklQluoPMjlBzaBdl?=
 =?us-ascii?Q?IKpRxW8OYobBDwy8s7BbJG8enKmYBQCblgY2QtGz9waW26kKaG13t29ku6bK?=
 =?us-ascii?Q?q0lBJZm1bNzzoaJbBxlwzFRhFikM6aSwWEJNf8mMkrskPfxLwdBVnZq71vyK?=
 =?us-ascii?Q?3R5M+OHivYUuP7inolJGb+qzoH8wdrhkafeNoFyZCM2epBAQYStgq5/6e3B7?=
 =?us-ascii?Q?LGXZyhaNeZpC783FR6J6XLrOHqTNO2QicSx0UFXkIUMmvuHSqNtOnTeBc31N?=
 =?us-ascii?Q?1Avxp2II/xCSiov0e6WVp90Y5sJhYA1dL35vR1seyGDShHkRYsQqrFTIT8FJ?=
 =?us-ascii?Q?hY9PC53Rct3BUWbvjVX04+OfmpcuhM91ZfUGgQZHOQPh29VjSKfy6ALYbRcT?=
 =?us-ascii?Q?6qguLlCzNNs0S6CKo7PiceKvyMVmfbVtRtip38p/OCyawww2aM88mrwbapsc?=
 =?us-ascii?Q?6mu1UEgzVP6wJ9ffZIVSFAZgO+XqT5XIZay+zr43LBSqlDziwA4nKeZitdzp?=
 =?us-ascii?Q?HUcsm7+DV4wFgtCWXoJXy2ONO9iFG07mk4d6eKY/m4rUQSopjOzh8aqKLWL4?=
 =?us-ascii?Q?fRq2xfPb/ytRKns46F9XIN/lPqR++ofgbupvxL9oJJId09EQPqn7U1Dhhe/s?=
 =?us-ascii?Q?0A=3D=3D?=
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b64a35-1c9b-43e4-3649-08dbaeeab200
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8426.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 15:05:24.2105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OQjT7o3MFgSaiCMDQIareUgI5dh7kfV1H9LwgA0H7MCAYwHtUxXcCzTasWLa8PSH/NZVUY0Zwh92udwnX7q1Qp6nTYSM5+h15Vk9IaoHIQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR05MB10054
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 6 Sep 2023, Andy Shevchenko wrote:
> On Tue, Sep 05, 2023 at 12:06:20PM -0400, Matthew Howell wrote:
> > From: Matthew Howell <matthew.howell@sealevel.com
> 
> Okay, I started reviewing it and it has all the same issues that I pointed
> out previously. Are you sure you sent a _new_ version?

I did send a new version.

> For your convenience I left all comments here.
> 
> >
> > Sealevel XR1735X based cards utilize DTR to control RS-485 Enable, but the
> > current implementation of 8250_exar uses RTS for the auto-RS485-Enable
> > mode of the XR17V35X UARTs. This patch implements DTR Auto-RS485 on
> 
> All four above and two below (Link: and supposed to be a blank line)
> have a trailing space. Which editor do you use? You probably need to configure
> it to avoid this.

I use the the default editor in alpine and I had configured alpine per the 
email client configuration reccomendations in the documentation. I 
believe this happened because alpine automatically adds a new line to line 
wrap at the character limit, but since links are exempt from this rule I 
have to manually undo this and I made a mistake in that process.

I will try composing in a different editor and then file-read it into 
alpine instead of using the built in editor to see if that helps avoid the 
issue.
 
> > Sealevel cards.
> 
> > Link:
> > https://lore.kernel.org/all/b0b1863f-40f4-d78e-7bb7-dc4312449d9e@sealevel.com/
> 
> Should be a single line.
> 
> >
> 
> No blank lines in the tag block.
> 
> ...
> 
> > +     generic_rs485_config(port, termios, rs485);
> 
> > +     if (rs485->flags & SER_RS485_ENABLED) {
> 
> What I meant is to have
> 
>         if (!)rs485->flags & SER_RS485_ENABLED))
>                 return 0;
> 
> here, which allows you to reduce indentation level in the below block.
> 
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

I see where you are coming from now, but I find that slightly less clear 
than having the 'main action' within the conditional statement. And since 
the code is not heavily indented I don't see much benefit of removing the 
indent.

> ...
> 
> > +static int pci_sealevel_setup(struct exar8250 *priv, struct pci_dev *pcidev,
> > +                struct uart_8250_port *port, int idx)
> > +{
> > +     int ret = pci_xr17v35x_setup(priv, pcidev, port, idx);
> 
> > +     port->port.rs485_config = sealevel_rs485_config;
> 
> This is incorrect in a way that we do not assign return values in case it is
> an error path. This will be prone to mistakes on the caller side.
> 
>         int ret;
> 
>         ret = ...
>         if (ret)
>                 return ret;
> 
>         ...
> 
>         return 0;
> 
> > +     return ret;
> > +}
> ...

Ok, will change for next submission.

> > +static const struct exar8250_board pbn_sealevel_16 = {
> > +     .num_ports      = 16,
> 
> > +    .setup           = pci_sealevel_setup,
> 
> Here is the indentation issue. Use leading TABs.
> 
> > +     .exit           = pci_xr17v35x_exit,
> > +};

Sorry, I had missed that one.

> ...
> 
> > +#define SEALEVEL_DEVICE(devid, bd) {                 \
> > +     PCI_DEVICE_SUB(                                 \
> > +             PCI_VENDOR_ID_EXAR,                     \
> > +             PCI_DEVICE_ID_EXAR_##devid,             \
> > +             PCI_VENDOR_ID_SEALEVEL,                 \
> 
> > +             PCI_ANY_ID), 0, 0,      \
> 
> Seems trailing \ is indented wrongly, missing TAB?
> 
> > +             (kernel_ulong_t)&bd                     \
> > +     }
> 

Ah, I see. In my editor none of the trailing \ lined up so I thought that 
there was some sotr of space/tab rule with trailing slashes I wasn't aware 
of, so I just used the same amount of spaces and tabs as the surrounding 
..._DEVICE() macros. However, I now see that I should have had it set to 
tab size 8 instead of 4.

Will fix in the next submission.

> --
> With Best Regards,
> Andy Shevchenko
> 
> 
> 
