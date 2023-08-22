Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E58EE49B1
	for <linux-serial@archiver.kernel.org>; Tue, 22 Aug 2023 20:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjHVUws (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 22 Aug 2023 16:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjHVUws (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 Aug 2023 16:52:48 -0400
Received: from CY4PR02CU007.outbound.protection.outlook.com (mail-westcentralusazon11011009.outbound.protection.outlook.com [40.93.199.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1681B0
        for <linux-serial@vger.kernel.org>; Tue, 22 Aug 2023 13:52:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWVPqqFJTT60pr34SGagsFRfP2ONNf129XvpEB7VQAgcV2iMjbn4pNmYfd2BCJIEUqP2pwkFC19MV+kqmC3CG/GlKxEUcuTuNbfzf/7n0t9efwtkQEl4vi8dyrg3u2oES5H3jnlh8nVXZ0QSl8sH/fZnWI4vw+5WoIbsPLnN7VwW6sL1W3H1D3qHHyodzd1Q7VR025PVqEO3pfH7KjK6T0vJUAPGto+0Vm3TVnxvwaS23Pa0ld6QsFXM9axO3b7pKUyIBGF2w2ZhyCnZvRTXj9r5M9SEp4kdW6M9jkzH8oZzxU6N4p/s4mRw45lfqBmgtgQ8EL4a0ZVofhN7jafSWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2bRkixPlJt2xzmPdXQVWP6f57JYe67+df/etr/3fpM=;
 b=Srsv5ty6cTJJfYgXOmumrQUl+1wSGGtMrtcf0G2zv2vPXKNsr196BR3qxtufuSqQVCMJCvcR6vpSAx6doA5JdC9dPR+2kafXxucvzLUAgKCt3jJ9TEJ5b0CrmCCAB1icAdkNq+YzKktCARN3CT7mHGFoclK5KlahetFw7A6qF9Iek+PiFhJ/IlDziJKMKqM0GNETj86k3ZKRsXntes86MNB85syESSi1LAwU/1XBv7RiYXoH5PikkUiRyAUd3gPjToQM1Ivw+/VY21HomDrs9UrwuP6eRYzQqsiUrOFRnVKVGWGT1BQxZCm0h9u7MvlN7GmDRgIzpwDRtvgsRQiPig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2bRkixPlJt2xzmPdXQVWP6f57JYe67+df/etr/3fpM=;
 b=O2pXiOVNJVIPw2MMUoObMrJH7v5BZlG5xFbxxDL4vf6FV4b+D+0AO7KCm+XWm1wrRMHszTBeYREPJqjKtxSw0soFCiJ4sW50XalVIT80rDDYtzpyNn+8j5vs7c4INpzgkr+HoxWiN4nr7wHK1T2VYL5JicWIJ/olMNn31p0W67uDy6fW+e0Kx21mWh5/APM5h0WtyE0aQ5Ie9VEvLW0ULFAPusdPxVqzY1IPKS+NVaEyjOYIVz5nMvCwzHz41424dnud+9vSAMrVXOTFn7sXtV1+Eh9XM4Eq7f9NN5Nafvb9lG7w7nc6xhw9atIRGDL5i67qjz5o7Zj7wPQS9Qnc8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealevel.com;
Received: from CO1PR05MB8426.namprd05.prod.outlook.com (2603:10b6:303:e5::11)
 by SA3PR05MB10420.namprd05.prod.outlook.com (2603:10b6:806:39c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 20:52:42 +0000
Received: from CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669]) by CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669%4]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 20:52:42 +0000
Date:   Tue, 22 Aug 2023 16:52:38 -0400 (EDT)
From:   Matthew Howell <matthew.howell@sealevel.com>
To:     =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc:     Matthew Howell <matthew.howell@sealevel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        jeff.baldwin@sealevel.com, james.olson@sealevel.com,
        ryan.wenglarz@sealevel.com, darren.beeson@sealevel.com
Subject: Re: [PATCH 2/2] serial: exar: Add RS-485 Support for Sealevel XR17V35X
 based cards
In-Reply-To: <bd7f9d51-7cf4-d3f5-d2d7-3c822656f67d@linux.intel.com>
Message-ID: <fa478ca-d6e-859-e68a-374f405f3a58@sealevel.com>
References: <766dab31-6982-67d9-ead9-30f61648d7a2@sealevel.com> <bd7f9d51-7cf4-d3f5-d2d7-3c822656f67d@linux.intel.com>
Content-Type: multipart/mixed; boundary="1338814021-2139520478-1692737561=:5755"
X-ClientProxiedBy: BN9PR03CA0625.namprd03.prod.outlook.com
 (2603:10b6:408:106::30) To CO1PR05MB8426.namprd05.prod.outlook.com
 (2603:10b6:303:e5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR05MB8426:EE_|SA3PR05MB10420:EE_
X-MS-Office365-Filtering-Correlation-Id: 6903a09c-a2cc-4f32-471d-08dba351ba1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J3h3Be2nEt0kTZ1o8q4HV7b6D7n34/dJhlTdBM9V+3YM15ksVtC61+fTJWEyH2xT923NYR8F6wFv4YxabG4NBM6+XKHcDENcJL5IHEGXPJHxGmTK1Z/dLyhM1LhVlEZo7cQBtAqwX2usD22J3yEUuHo/I1DT59FsHYcvwHhp4QoIgsx+NPasq2y0oTkHXRhLBAOw5f2ji0EHMfNzI7vSYYMD3zQZvWljZuPBWRX6KPirWaefH4Yoggq/brRoAQqFJyhkfXfzLZp3aTDZftpiohU7//nvsGDR5PcXn6XSylcnOMn04/CQO6/iTV7kerxKyjfcPm9mVeQOc8OvKmiQB0a47Jqh79sKf5iOKz3W16vMnJb0TpEQXKWkbDp1Ur8edFcum0nfqqHooQ/LGoTyr8nxqxxTvYyIDpOBq3TE9TGsGT875/No1ML6no5zlVPgnQSLNwJH/ndxfvHhce8XOtms6llBkMd7ochyS1x+HI/aypzlpCcAe6zb2QrMb/lmLp8Q3zbMHrrW/5k1qUQ94kBw22Ai+3knDjPQvJjJa5j9BNihy0G9CoShBrJ4MpfzB3XaOk9tPGNFq2wC5FDP5J8hrtUQz/X43zLMFCdMnJ9giinOM+onrpkEVN619BnK7RFgX8i3of7d6/dVsLpA2F57QXaVS5coFrKOvyundSc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8426.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(396003)(346002)(366004)(376002)(451199024)(186009)(1800799009)(478600001)(36756003)(41300700001)(6512007)(12101799020)(86362001)(6916009)(316002)(66946007)(6506007)(66476007)(6486002)(54906003)(33964004)(66556008)(6666004)(107886003)(5660300002)(8676002)(44832011)(4326008)(8936002)(2616005)(26005)(83380400001)(2906002)(38100700002)(66574015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFlsQWhJaUVHK2tnaTRub01kVFdwdHRmZzdCbU5rdjNFVHBWSXZoNTliN2Jm?=
 =?utf-8?B?WlJ0NFN0b0p0NzhqZHYyRVE0YkFNa0UzSE5USk42Y0FNNEp2MUFCajhvUnho?=
 =?utf-8?B?Z0xyNHUrRFJSK3ZGNTNoYTRrY3NLNlVLemlaZERsek4vc2ZqRDFXZ3BwUXJW?=
 =?utf-8?B?NUNvRlFZSkpwWUpZSmRSbFpLL0V5RmFWZ1hEOTczK1BMVUlLc0ZqdjhzSVdj?=
 =?utf-8?B?WVdJYTFkSnRkc1p5OWh1UVNKaEd3TGpqMmI1dlFKNkdMZnVneWJNc1pJaFZH?=
 =?utf-8?B?ZnFJakFYaklvdnd2ZkhYOWdBc3Q0TVViMndkTHNzaTRGcWtYdi90OVVKYzNK?=
 =?utf-8?B?Lzh6YUpVbTVGZzNWSDA4OWZNTk5qWTJVcGtDSm42Q3U5b2Q2TzB6bFdCOE40?=
 =?utf-8?B?dDJGY3plRENNalIwNXNVK2U4M09UVk9hWFV2R0lQNlNYb3dYc1NHUFQra3Yv?=
 =?utf-8?B?K2gyd1lLdUlTazhGTDBLZ2psQnlBbVU1RzFDNVg5akJMQlhGc01YNUFzQ2k5?=
 =?utf-8?B?NHFVY3lPR1RFR3RGMUZPU3Nwa1cyQVZ5WWU0cHc0NU9jdUQwNWZSNG1LYlNF?=
 =?utf-8?B?NDRCOEZwNlZ0MTRDYlR5RDBMYU1kV1ZYWXUrakpjTmNNdjJVdFYzZ1NJZmkz?=
 =?utf-8?B?cjlYY09vMXQ0emJDay9ZOXRsdlQyekRNcHFKdmVqMDA0T011aTcvQ3Urc0o5?=
 =?utf-8?B?azM1N2toQnhiKzhFWmF1YWpYMzIyOFhWNFM5R2d6VjNKREo5Y29SUHNTLzFt?=
 =?utf-8?B?dnZ5VE9FcGRUMlZsL2RTc2wxMGRKQnA3bTZHL2MyaXVJazI5WXg1a0ttL3BU?=
 =?utf-8?B?WVRKVGp2aU9oS2VUUW5JU1lFRnRQdmlmMy9PSGdnOThubXBIYTExclBmcTBI?=
 =?utf-8?B?eG0xdnkzNmdwZ2UwUUluZlhIRm1SOTJXRGJ4SVZuVU01d2NuQ3l0L2ZtOGlO?=
 =?utf-8?B?VXVhNlRSN1o3eHIvK0dlUVYyUjRHa2VRT0RtM0hiSGhiWHpDaXpFaThCRzRN?=
 =?utf-8?B?eU1vd3VXRFIwUVNjZTZ4VVFIRUIrR25BeTlVNU9lRW9WVUQ4enpqeFRLdVZt?=
 =?utf-8?B?MlVCUCtGNmdvczRDVjNpUUFMelBUMFYxVU1RWHlnU2haNFdFcE9rOWRMRGNE?=
 =?utf-8?B?Q01JWmRnRm1DOERtcUVwK29DTEdTc2NSaFZJL2I5WTNlNnFnZmI3OVd5N0c5?=
 =?utf-8?B?aFFhZWFUNXJhaUUzUFM1UkJaNm1mZDRVTm5Sd1JJSnljZW9LNmN6V0YrZ0pq?=
 =?utf-8?B?cEFra0NwbEhGalM4Yk40NlJvUWw3Z20rLzc0amt2azdjUWFVTy8zL0U0OWQx?=
 =?utf-8?B?c2tUc1p2dmMxNDJCZGxoUHpTRmdpK2VEQzY4aXdIRUlPUlJBL3NyOXhwQzZn?=
 =?utf-8?B?Q2xLdTFNdVZUT1ROc0VOME9YWFBUOW8wdGlRL2xPVFR2MzJvcUlQYUkweURy?=
 =?utf-8?B?biszcTEwZUtLSk5TaTZaNURNMjM1TWR2azh2T1Ric0UrdElnaFpwblExWnpJ?=
 =?utf-8?B?bmhUdlFvbHB1cFNKNEh2S3phZFhVOVFGdlBrNStBL3g2NzltMngvU09FZk40?=
 =?utf-8?B?NnpwWThFMzdYNTRnUXZKNUtTVXdERm9OanZzd0dmTzB0ZFNmdDA0UDhpdGxx?=
 =?utf-8?B?L2dsZWhlRkZMRWJRSTVIY0NzMXNTaFhtL04zV2VOQXU0NGw4UDMvRUtNVCti?=
 =?utf-8?B?enRuWVRuSWpzRHVzTUJxbnhlU2t0bGQ3WE11QzZ0R2F3azUwa21EOVJwZzZH?=
 =?utf-8?B?R2IrelVOSFYyU2lqYXNJQlhCNVRSVXhGOWF1V1lQak5uWFNEMkZNN084U0d6?=
 =?utf-8?B?dWUzMXRNQVovT2JEalNjYTlrVUY2alQzWG5JRENrbHppT21hNU91N3BKM2hh?=
 =?utf-8?B?MGZTaHRYZ2xVVDdpV0JBa3EvYVk4bTVmNmNIWG1jSm12YXFzaFZUcHRHN3Zv?=
 =?utf-8?B?WmptSWNZWlQ1c1NDU2U5QzFwTWpaSGlaSXNaVTI4RWhYdXFBa2ozUEJMT3FZ?=
 =?utf-8?B?VjUzTkxFTGxXMFVLak5xeEl6RWZtSUUwNDJCZzRaMGpaMHZ2WjVqd3BOSzg2?=
 =?utf-8?B?VlVQOE5iMVliNjdsaG0xWkRqdGgyMXhPZFRuc0hVaC8rdjVjKzFuYllPNVU5?=
 =?utf-8?B?NDV6TnVQR2JwZEFsK2hkOU1hSXdESmIrUFFqRFBFZ2tQZDlzRk5rdHFoRzVy?=
 =?utf-8?B?Q2c9PQ==?=
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6903a09c-a2cc-4f32-471d-08dba351ba1e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8426.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 20:52:42.2737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AYhWXVMqsxKHwKIbCQpEMI2bexhxDcgPv1Rwa4qf74NtXC7svVd+5spX8/xjbNXkwgugxsoZ5LypH85ieffLuLc/oOwL0ZxfZeQvPjYilcg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR05MB10420
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

--1338814021-2139520478-1692737561=:5755
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT


On Tue, 22 Aug 2023, Ilpo Järvinen wrote:

> ⚠Caution: External email. Exercise extreme caution with links or attachments.⚠
> 
> 
> On Mon, 21 Aug 2023, Matthew Howell wrote:
> 
> Thanks for the patch.
> 
> > From: Matthew Howell <matthew.howell@sealevel.com>
> >
> > Sealevel XR1735X based cards utilize DTR to control RS-485 Enable, but the
> > current implementation of 8250_exar uses RTS for the auto-RS485-Enable
> > mode of the XR17V35X UARTs.
> >
> > sealevel_rs485_config(): Configures XR17V35X registers for Auto-RS485
> > Enable using DTR.
> > pci_sealevel_startup(): Calls pci_xr17v35x_setup(), then sets
> > rs485_config to sealevel_rs485_config().
> 
> The changelog doesn't read well as is. The logical flow breaks when you
> jump to describe functions.
> 
> > signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
> 
> Start with capital S.
> 
> > ---
> > diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> > index 018cbaaf238c..246cfb3cc3f8 100644
> > --- a/drivers/tty/serial/8250/8250_exar.c
> > +++ b/drivers/tty/serial/8250/8250_exar.c
> > @@ -390,6 +390,8 @@ static void __xr17v35x_unregister_gpio(struct platform_device *pdev)
> >       platform_device_unregister(pdev);
> >  }
> >
> > +
> > +
> 
> Please remove this extra change.
> 
> >  static const struct property_entry exar_gpio_properties[] = {
> >       PROPERTY_ENTRY_U32("exar,first-pin", 0),
> >       PROPERTY_ENTRY_U32("ngpios", 16),
> > @@ -439,6 +441,35 @@ static int generic_rs485_config(struct uart_port *port, struct ktermios *termios
> >       return 0;
> >  }
> >
> > +static int sealevel_rs485_config(struct uart_port *port, struct ktermios *termios,
> > +                             struct serial_rs485 *rs485)
> > +{
> > +     bool is_rs485 = !!(rs485->flags & SER_RS485_ENABLED);
> 
> No need for !!() if assigning to bool.
> 

I just did it that way because generic_rs485_config() does it the same and
I assumed there was a reason for doing it that way. Are you sure !!() 
isn't needed here for some reason?

> > +     u8 __iomem *p = port->membase;
> > +     u8 old_lcr;
> > +    generic_rs485_config(port, termios, rs485);
> 
> Use tab to indent. Leave one empty line after declarations.
> 
> > +
> > +     if (is_rs485) {
> > +             // Set EFR[4]=1 to enable enhanced feature registers
> > +             writeb(readb(p + UART_XR_EFR) | 0x10, p + 0x09);
> > +
> > +             // Set MCR to use DTR as Auto-RS485 Enable signal
> > +             writeb(0x04, p + UART_MCR);
> > +
> > +             // Store original LCR and set LCR[7]=1 to enable access to DLD register
> > +             old_lcr = readb(p + UART_LCR);
> > +             writeb(old_lcr | 0x80, p + UART_LCR);
> > +
> > +             // Set DLD[7]=1 for inverted RS485 Enable logic
> > +             writeb(readb(p + 0x02) | 0x80, p + 0x02);
> 
> Please don't use numeric literals. You should add defines (or use existing
> ones) with proper names in all these cases.
> 
> If the names for the defines are good enough, the comments become
> redundant and can be removed so please check that too after naming things
> properly.
> 
> > +
> > +             // Reset LCR to orginal value
> 
> Unnecessary (very obvious) comment, please drop it.
> 
> > +             writeb(old_lcr, p + UART_LCR);
> > +    }
> > +
> > +     return 0;
> > + }
> > +
> >  static const struct serial_rs485 generic_rs485_supported = {
> >       .flags = SER_RS485_ENABLED,
> >  };
> > @@ -744,6 +775,19 @@ static int __maybe_unused exar_resume(struct device *dev)
> >       return 0;
> >  }
> >
> > +static int pci_sealevel_setup(struct exar8250 *priv, struct pci_dev *pcidev,
> > +                                                       struct uart_8250_port *port, int idx)
> > +{
> > +     int ret = pci_xr17v35x_setup(priv, pcidev, port, idx);
> > +
> > +     if (ret)
> > +             return ret;
> > +
> > +     port->port.rs485_config = sealevel_rs485_config;
> 
> Do you need to setup .rs485_supported too? (I'm not sure how the init
> works with this driver whether the default one gets used by some logic
> or not).
> 
> --
>  i.

I don't believe so since .rs485_supported is assigned in 
pci_xr17v35x_setup(). If I assigned .rs485_supported here I would just use 
the same code as pci_xr17v35x_setup(), which seems like needless 
duplication to me.

Will fix the various small issues and resubmit within the next few days.

> 
> 
> > +     return ret;
> > +}
> > +
> >  static SIMPLE_DEV_PM_OPS(exar_pci_pm, exar_suspend, exar_resume);
> >
> >  static const struct exar8250_board pbn_fastcom335_2 = {
> > @@ -809,6 +853,17 @@ static const struct exar8250_board pbn_exar_XR17V8358 = {
> >       .exit           = pci_xr17v35x_exit,
> >  };
> >
> > +static const struct exar8250_board pbn_sealevel = {
> > +     .setup          = pci_sealevel_setup,
> > +     .exit           = pci_xr17v35x_exit,
> > +};
> > +
> > +static const struct exar8250_board pbn_sealevel_16 = {
> > +     .num_ports  = 16,
> > +    .setup           = pci_sealevel_setup,
> > +     .exit           = pci_xr17v35x_exit,
> > +};
> > +
> >  #define CONNECT_DEVICE(devid, sdevid, bd) {                          \
> >       PCI_DEVICE_SUB(                                                 \
> >               PCI_VENDOR_ID_EXAR,                                     \
> > @@ -838,6 +893,15 @@ static const struct exar8250_board pbn_exar_XR17V8358 = {
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
> > @@ -886,6 +950,12 @@ static const struct pci_device_id exar_pci_tbl[] = {
> >       EXAR_DEVICE(COMMTECH, 2324PCI335, pbn_fastcom335_4),
> >       EXAR_DEVICE(COMMTECH, 2328PCI335, pbn_fastcom335_8),
> >
> > +     SEALEVEL_DEVICE(XR17V352, pbn_sealevel),
> > +     SEALEVEL_DEVICE(XR17V354, pbn_sealevel),
> > +     SEALEVEL_DEVICE(XR17V358, pbn_sealevel),
> > +     SEALEVEL_DEVICE(XR17V4358, pbn_sealevel_16),
> > +     SEALEVEL_DEVICE(XR17V8358, pbn_sealevel_16),
> > +
> >       { 0, }
> >  };
> >  MODULE_DEVICE_TABLE(pci, exar_pci_tbl);
> >
> 
--1338814021-2139520478-1692737561=:5755--
