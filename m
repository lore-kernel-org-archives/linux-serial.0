Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB13BEB8FCE
	for <linux-serial@archiver.kernel.org>; Wed,  6 Sep 2023 13:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240657AbjIFNcO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 Sep 2023 09:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjIFNcO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 Sep 2023 09:32:14 -0400
Received: from CY4PR02CU007.outbound.protection.outlook.com (mail-westcentralusazon11011012.outbound.protection.outlook.com [40.93.199.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93161726
        for <linux-serial@vger.kernel.org>; Wed,  6 Sep 2023 06:31:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtBmGA7XCWgJcGQKXTwCQ7fXyidXO3zh2fmCf/O/rnyluo2+Nrny84nL9YGLNi3ph5B9fNbGx/1XPZxOFfF2bYeiBH0CDneVYtMT7VmU8ewYmeUgookBQ0UAsJr0xzy0KW7N0iVvm+OLS42iukvTuR5J9XTExf7Y366+08C/tQiyPq3JKabHRWJWluKY968NpTaT/UWw/pwnRk0UeuQr3h1biUc2buFpPKfTk3ml4djLCSD2MxAQtMjL2WVwXtio5V57kPnkrMX1nP95kNbgepYQk8HL+93gRbNrjhCJRCp+376YXg9KpB0w0xnZJAa72FtC1bbWhOlJVN5kVAsAwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYU6hQKaY8hdaEbfCdk981MbV4vx8H+kTHlBKUOq8v8=;
 b=ltJvc91XMrKdYSaB4xLhGWfjJbA/6JReM4MSLxm4xohPeN0cp5tJMci/2KgEGA4brASvViF17BR7P8uv1vGd8EIIX5NR0Au5PdQ7uj4a+ZZobOSxo838+d4WTLd5qgrHMrslqsnfRrly2P/85YJXGGr2XkPJhWiflOBwAbQBBCLdeQzPWuhew7lL7S6g57LelWNuwdkOhMfstCZ8S8gsPVE+5jLV+MhVfMslEMDN+lS5aYiGh3L5DuiQP3Zfr/PyCIIKmkdW9BlXtKZH+cqRzc7v3Q4gKzfZvAbZENpzbJrou5yUiNUdGrl4zMZgO8Ixqhz+Pao4wPuj3JLmyeqmrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYU6hQKaY8hdaEbfCdk981MbV4vx8H+kTHlBKUOq8v8=;
 b=FVFtb1/99jOthpSS86NK2dyv8eBMR/cfe5Ui59mV6yTjJjZA3nIRPfZlP5rq2L30buGYhxDvCP06wr+4aWY7j29OU6YHhuzwnLIuQplnObZX9bqEMnFDHLIZUQMUdjptAwX14eGfqFDfGU46hhs406i63DDr92UVwiKHBkKhXl+CJiK69J+X/+5PQNYgE/wm+FvrM6UCACJNYBlKUBJ29p1htZkDx2me9L+Dx4o9YH91dYi+C/NjJ/EVVsFvZqsxre/OYBLcfHXxQOY6a44yXjm2IBYP6nMnwbyhhBpygdLNcA9HACuRYjOpWYNY44G8iy5SpyXHybMTS5rCq/fO7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealevel.com;
Received: from CO1PR05MB8426.namprd05.prod.outlook.com (2603:10b6:303:e5::11)
 by CH3PR05MB10279.namprd05.prod.outlook.com (2603:10b6:610:15c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 13:31:54 +0000
Received: from CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669]) by CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669%4]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 13:31:54 +0000
Date:   Wed, 6 Sep 2023 09:31:50 -0400 (EDT)
From:   Matthew Howell <matthew.howell@sealevel.com>
To:     =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc:     Matthew Howell <matthew.howell@sealevel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jeff.baldwin@sealevel.com, james.olson@sealevel.com,
        ryan.wenglarz@sealevel.com, darren.beeson@sealevel.com,
        linux-serial <linux-serial@vger.kernel.org>,
        andriy.shevchenko@intel.com
Subject: Re: [PATCH V4 2/2] serial: exar: Add RS-485 support for Sealevel
 XR17V35X based cards
In-Reply-To: <aab7aca7-33d5-732c-764d-246e474b747@linux.intel.com>
Message-ID: <1b3f5094-0b14-5a22-8654-a64eb8b7666d@sealevel.com>
References: <e2564a57-128e-cd9c-9bae-23b155fd8ee9@sealevel.com> <aab7aca7-33d5-732c-764d-246e474b747@linux.intel.com>
Content-Type: multipart/mixed; BOUNDARY="8323329-1892315126-1694004032=:22449"
Content-ID: <e15ca4db-42c8-9cfe-9550-0d14fb4a759c@sealevel.com>
X-ClientProxiedBy: BN9PR03CA0423.namprd03.prod.outlook.com
 (2603:10b6:408:113::8) To CO1PR05MB8426.namprd05.prod.outlook.com
 (2603:10b6:303:e5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR05MB8426:EE_|CH3PR05MB10279:EE_
X-MS-Office365-Filtering-Correlation-Id: c475854d-4e7c-4c91-19c0-08dbaedda228
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vNtsDwYMoeORQHLBY5+cgK4gtj+faJMNQaoCGsPN3hj06iBBtE5hs7RzlSRm7m1bL3dSZV+7IXPbcW8aCs2GZmUNaE2DyeAgvQY8xYdTrWxQl4RNfGyX2zXIiTe/pHkpceIAiAqwduE0EL9TUrR9oEwbkc2qQMZvSzBhiNiBgQ9RgnY9txC0snnEDdynwCd3ad1zs+useir0ldFT4qJBbcispMRNqDsz9P3Y/Z/6X1ie9hvBda+qyumLJIjew1dR7i6XF6CH600CegDP/2e9ItSBfOcMTs+dD7mxoDR9sbrPmRl3/OJtnnE1qqtfvea6avYhRVZiwf/yG8cg5cbUOE3slHe6Rn/GaBkC9CJhdGnV9+rH/HSwg9NMmcdoOXXP3FnTIeWeDExUOTLjqzsUoXp+BQ66O541FTZQslhhuVRk03hZZBL/zTPhcwOWC6BrrL/Y3skP/Qq2ij7lPQYIAS4glAwmgALhdAQow1ZGcZFm9jzlW+Y8czaIbJ+v+DoITrS7qVLfOiNW0Ml7+HW/bFdkE0M0ysFl6sjP99fImpnesUDmOE/khOg1UHfV5LKjgdNvHbJ9vhReBMesxw4TW8qwZgYIm+dnCw23sQDf5kcwpiVwpGl2Cx4LKio2Hpa2jZ43tdIBsTAxbC0/75fOQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8426.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39850400004)(366004)(136003)(376002)(186009)(1800799009)(451199024)(2616005)(38100700002)(26005)(6486002)(6506007)(6512007)(36756003)(83380400001)(66574015)(31696002)(86362001)(44832011)(5660300002)(966005)(41300700001)(54906003)(6916009)(66556008)(316002)(66946007)(66476007)(8676002)(8936002)(4326008)(31686004)(6666004)(478600001)(2906002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-15?Q?3swRLETcPGGiWNBh8KKpu223fKqzIgbAHQsCLjGKfnOhJ/lDnQz3huDLa?=
 =?iso-8859-15?Q?5pUIkPJh3wXnXmPdYGLXHVrX0CiNgQ8CFgHayF/aEhQrcuuSHlWr7+Qnl?=
 =?iso-8859-15?Q?/Iai8zF3CR0yePabaLpqTy/T2NUG5I7LeosQFnLxfjtKag+ZMCUCNfUk+?=
 =?iso-8859-15?Q?BuB4NdbGhe7tzQAi8yrvJYtlbzdYyH7HTLy5CnXWestmd/wtJrI/UQAx+?=
 =?iso-8859-15?Q?Yu4MsMLk5RA+4rc0sSD6SyudbnVHbFg/GMMTuSByhvX3ZqCSmWn5+tdBA?=
 =?iso-8859-15?Q?RYtlKqiNJDd07HRlwc/10LhUD5i8G3B6wti+SG6kNVKTrBfmEvw/r/2kk?=
 =?iso-8859-15?Q?hVIWev2DfEWeQ8C3owv14WRElvEI5+DW/z59vIHMYhZiMnlnYCxAVnOU1?=
 =?iso-8859-15?Q?OSb40VLcFmARBx5RR8ZA7f88dU+OwcBH0aZHntoNHwzgYjAZ/Ge44/ujM?=
 =?iso-8859-15?Q?64qBTcdk1RcN5qIj58gF65Df9PevijCxpbpZfC2dOJ1G7V9VK5kEXYAjj?=
 =?iso-8859-15?Q?3Rrj9TG+9K114ENWn/rZ5ftAzKj65EDKo65JfIY3VNM/9atv///vmgXkY?=
 =?iso-8859-15?Q?CvCMbBh9DXIgJTt6xeEw8jlXwCe/F91GDvWJePDtGCl/mgA1BU3SrUpAb?=
 =?iso-8859-15?Q?Znb81hQqkn5zt5dQ1D24pcJy6shC6E81sMGp0lL0PCGpnQsbVx+lUDeG4?=
 =?iso-8859-15?Q?iTlza6HlNc+mdHiAV9VQoWfbyJgDO7X3QipTv7F0McAetvfAoh2FArEfu?=
 =?iso-8859-15?Q?axptWXUO80ZhtNQObxeL3rsfMwV9dwX0+swX57xkIMmADCpluu68VtmXt?=
 =?iso-8859-15?Q?sR5mYTvPrAmOB1CNfM/9hAgV0CgptOTdGy0ZJAlYzCtrEjG6SpzKiI4dh?=
 =?iso-8859-15?Q?3dg1RGcKxgo6sMBxUAbWwojpg3tVxJc0vaaonr299yea6+am+QFaktXf0?=
 =?iso-8859-15?Q?kTks6rfg5gOqZ4G56d7yLnOZOY5VL5zEo28hlauB0BO8XkKtMH3KSIESK?=
 =?iso-8859-15?Q?aA9T41b2jpXB0532uKFbOMRfZD6zYVI6vD2go5uoyO8tNxl/gg1G/bCzn?=
 =?iso-8859-15?Q?/lvTSXNsIiRhnElrnI5TJuV1t39P1WhGzS3nLR2neV2YziuOLd69QuugK?=
 =?iso-8859-15?Q?uAiT9ok3Zdt1wZf/er2JpvtVJjhkpoNl2wgNNZww1LPOrwIWM9srFkBHM?=
 =?iso-8859-15?Q?+EwjzRG+I5e+Tc2k31hG56m4klNE6vuzDzN5GuwA5NTi9GaYhubl3Anrm?=
 =?iso-8859-15?Q?FYGEde1zL/Bk/DAg8alr3cNgAI+onBUmJFp9K8UIf6jZajupoQm3FmN2Y?=
 =?iso-8859-15?Q?dNX4EWhEPdXVFLqMbQhIMWd9TKQGQnCzfP2qawtH5WsVZ4dv66vyCAwfC?=
 =?iso-8859-15?Q?ez0bveZzTLAcPgT3zwsXOH/tmU9ebiJ8ohGvTVJAlCMrPYjzwS4y2BJTu?=
 =?iso-8859-15?Q?gkmbIF39uugFSCW0VWPrh7GF45+TKSavDkG2PX/gRhqanSCaJ9tT3Pj2Y?=
 =?iso-8859-15?Q?PdbALGCvvXSX/anARDUnPZg4pPZK56GDve7Ezo/t2KJRZTHHJapoAOEjR?=
 =?iso-8859-15?Q?8nhiryoDDSZljl8K7cu74Wax70V4l72iVXq106vmN4kTDec6M72C7e9O1?=
 =?iso-8859-15?Q?HnOplR+aGvCDY2TN6BRNyt0e/LpEoT/yi3+8N9ZpoesmGR2izn7Hpshgb?=
 =?iso-8859-15?Q?CcQ7nkAJR0VGb2Hl30I80YqMmA=3D=3D?=
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c475854d-4e7c-4c91-19c0-08dbaedda228
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8426.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 13:31:54.0987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x4F5G1n1AHwXctBA0qawhznjCCGlCvddkFwSba2DvaFRg2cuLJNDmmQ7gNi09FueYS94y+j+fnaVYtKaoK6UgJLA4CkRTC+sITlFd9c4aeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR05MB10279
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

--8323329-1892315126-1694004032=:22449
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <0b6377c6-5c87-90fd-ef9c-23503e089420@sealevel.com>

On Wed, 6 Sep 2023, Ilpo Järvinen wrote:
> On Tue, 5 Sep 2023, Matthew Howell wrote:
> 
> > From: Matthew Howell <matthew.howell@sealevel.com
> >
> > Sealevel XR1735X based cards utilize DTR to control RS-485 Enable, but the
> > current implementation of 8250_exar uses RTS for the auto-RS485-Enable
> > mode of the XR17V35X UARTs. This patch implements DTR Auto-RS485 on
> > Sealevel cards.
> >
> > Link: https://lore.kernel.org/all/b0b1863f-40f4-d78e-7bb7-dc4312449d9e@sealevel.com/
> >
> > Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
> > ---
> > Fixed style issues from previous submission.
> >
> > diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> > index 3886f78ecbbf..20d2e7148be5 100644
> > --- a/drivers/tty/serial/8250/8250_exar.c
> > +++ b/drivers/tty/serial/8250/8250_exar.c
> > @@ -78,6 +78,9 @@
> >
> >  #define UART_EXAR_RS485_DLY(x)       ((x) << 4)
> >
> > +#define UART_EXAR_DLD                                0x02 /* Divisor Fractional */
> > +#define UART_EXAR_DLD_485_POLARITY   0x80 /* RS-485 Enable Signal Polarity */
> > +
> >  /*
> >   * IOT2040 MPIO wiring semantics:
> >   *
> > @@ -439,6 +442,34 @@ static int generic_rs485_config(struct uart_port *port, struct ktermios *termios
> >       return 0;
> >  }
> >
> > +static int sealevel_rs485_config(struct uart_port *port, struct ktermios *termios,
> > +                             struct serial_rs485 *rs485)
> > +{
> > +     u8 __iomem *p = port->membase;
> > +     u8 old_lcr;
> > +
> > +     generic_rs485_config(port, termios, rs485);
> > +
> > +     if (rs485->flags & SER_RS485_ENABLED) {
> > +             /* Set EFR[4]=1 to enable enhanced feature registers */
> > +             writeb(readb(p + UART_XR_EFR) | UART_EFR_ECB, p + UART_XR_EFR);
> 
> You should split these to 3 lines to make it easier to follow what's the
> actual operation taking place here:
>                 efr = readb(...);
>                 efr |= UART_EFR_ECB;
>                 writeb(...);
> 
> ...I'm sorry I didn't realize this last time I looked.

Ok. Will fix in next submission. 

> > +
> > +             /* Set MCR to use DTR as Auto-RS485 Enable signal */
> > +             writeb(UART_MCR_OUT1, p + UART_MCR);
> > +
> > +             /* Store original LCR and set LCR[7]=1 to enable access to DLD register */
> 
> I guess "store original LCR" path is pretty obvious and can be dropped.

Ok. I can drop that part of the comment if it is clear otherwise.
 
> > +             old_lcr = readb(p + UART_LCR);
> > +             writeb(old_lcr | UART_LCR_DLAB, p + UART_LCR);
> > +
> > +             /* Set DLD[7]=1 for inverted RS485 Enable logic */
> > +             writeb(readb(p + UART_EXAR_DLD) | UART_EXAR_DLD_485_POLARITY, p + UART_EXAR_DLD);
> 
> Split this as well.
> 
> > +             writeb(old_lcr, p + UART_LCR);
> > +    }
> 
> This function should also disable RS-485 if SER_RS485_ENABLED is set but
> currently it does nothing?
> 
> --
>  i.

That's what I would have thought as well, but I have electrically verified 
disabling SER_RS485_ENABLED disables RS485 on the Sealevel cards I have 
tested. I did this by monitoring the serial signal while a program 
alternates setting and unsetting SER_RS485_ENABLED and verifying the card 
is tri-stating when SER_RS485_ENABLED is set and fails to tri-state when 
SER_RS485_ENABLED is not set.

I do not know where disabling RS485 is happening in the driver since 
generic_rs485_config() does not handle this either, but I left it alone 
since it appears to be working without being handled in the 
..._rs485_config() functions.

> 
> > +
> > +     return 0;
> > + }
> > +
> >  static const struct serial_rs485 generic_rs485_supported = {
> >       .flags = SER_RS485_ENABLED,
> >  };
> > @@ -744,6 +775,16 @@ static int __maybe_unused exar_resume(struct device *dev)
> >       return 0;
> >  }
> >
> > +static int pci_sealevel_setup(struct exar8250 *priv, struct pci_dev *pcidev,
> > +                struct uart_8250_port *port, int idx)
> > +{
> > +     int ret = pci_xr17v35x_setup(priv, pcidev, port, idx);
> > +
> > +     port->port.rs485_config = sealevel_rs485_config;
> > +
> > +     return ret;
> > +}
> > +
> >  static SIMPLE_DEV_PM_OPS(exar_pci_pm, exar_suspend, exar_resume);
> >
> >  static const struct exar8250_board pbn_fastcom335_2 = {
> > @@ -809,6 +850,17 @@ static const struct exar8250_board pbn_exar_XR17V8358 = {
> >       .exit           = pci_xr17v35x_exit,
> >  };
> >
> > +static const struct exar8250_board pbn_sealevel = {
> > +     .setup          = pci_sealevel_setup,
> > +     .exit           = pci_xr17v35x_exit,
> > +};
> > +
> > +static const struct exar8250_board pbn_sealevel_16 = {
> > +     .num_ports      = 16,
> > +    .setup           = pci_sealevel_setup,
> > +     .exit           = pci_xr17v35x_exit,
> > +};
> > +
> >  #define CONNECT_DEVICE(devid, sdevid, bd) {                          \
> >       PCI_DEVICE_SUB(                                                 \
> >               PCI_VENDOR_ID_EXAR,                                     \
> > @@ -838,6 +890,15 @@ static const struct exar8250_board pbn_exar_XR17V8358 = {
> >               (kernel_ulong_t)&bd                     \
> >       }
> >
> > +#define SEALEVEL_DEVICE(devid, bd) {                 \
> > +     PCI_DEVICE_SUB(                                 \
> > +             PCI_VENDOR_ID_EXAR,                     \
> > +             PCI_DEVICE_ID_EXAR_##devid,             \
> > +             PCI_VENDOR_ID_SEALEVEL,                 \
> > +             PCI_ANY_ID), 0, 0,      \
> > +             (kernel_ulong_t)&bd                     \
> > +     }
> > +
> >  static const struct pci_device_id exar_pci_tbl[] = {
> >       EXAR_DEVICE(ACCESSIO, COM_2S, pbn_exar_XR17C15x),
> >       EXAR_DEVICE(ACCESSIO, COM_4S, pbn_exar_XR17C15x),
> > @@ -860,6 +921,12 @@ static const struct pci_device_id exar_pci_tbl[] = {
> >       CONNECT_DEVICE(XR17C154, UART_4_485, pbn_connect),
> >       CONNECT_DEVICE(XR17C158, UART_8_485, pbn_connect),
> >
> > +     SEALEVEL_DEVICE(XR17V352, pbn_sealevel),
> > +     SEALEVEL_DEVICE(XR17V354, pbn_sealevel),
> > +     SEALEVEL_DEVICE(XR17V358, pbn_sealevel),
> > +     SEALEVEL_DEVICE(XR17V4358, pbn_sealevel_16),
> > +     SEALEVEL_DEVICE(XR17V8358, pbn_sealevel_16),
> > +
> >       IBM_DEVICE(XR17C152, SATURN_SERIAL_ONE_PORT, pbn_exar_ibm_saturn),
> >
> >       /* USRobotics USR298x-OEM PCI Modems */
> >
> 
--8323329-1892315126-1694004032=:22449--
