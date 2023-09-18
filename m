Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21760CD37B0
	for <linux-serial@archiver.kernel.org>; Mon, 18 Sep 2023 15:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjIRPRA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 Sep 2023 11:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjIRPQz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Sep 2023 11:16:55 -0400
Received: from CO1PR02CU002.outbound.protection.outlook.com (mail-westus2azon11010001.outbound.protection.outlook.com [52.101.46.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8154F100
        for <linux-serial@vger.kernel.org>; Mon, 18 Sep 2023 08:16:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTYl4OD0VO9nmR6gqLERFDPLVIcVsRpNdtjGUYMe0bX8fAjQGGX03Gizxx8t8vvbGyxqGOVVZlK4OVGRuNMPzwoJepj83niajZ3bp5Q8jDClSq8PvWHNoQ4W4PG4YnE+JLZH6kN0M1IqNt6o1dr8PZAbJPYNkEtOep3XQtqvqACcDhzP7TBZA0QN3ssvW8ZZ0oW7QOlHdg9B6DkVogXQtOKzdwxmxrID4EfmthTSff9JE62TVAVtUczeG0Smhb7mP0LpJGHL5nOXTwrcRqf9cMi8hYEB6Utpfm5K+HRpnqV5ohcv4Msq4y8Bw98Kl078i5EazswvjVch6HIa5LF0Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzRwYal7PDI6eA4IvJgyu6QC2aiJUiwlILKZHT0gabg=;
 b=QBGRzt7EAtRA0xuFZhScM6e/VFwO5XWsfAPUwy12dFpR0fS2OGLP9e0RMq6+Gff1Xloazk7wKrfFopwcxL10wZ7Ljz3uJy6MTwJXa1rBDld4LFgFdzFHqh8eSJgoAr3GqBnp+ikAJB8TSARA+759vkGyJTROFQQ4sjj7A8ztVQtOC0djXwm7Q3bIZPqEbuPNPjdChdpG94uq3JQdyvAmFq5vf1jkxSSCDbYhJUJk4AQvKsuScssvtDF7BULvmDngeTaTVRPkJHI73XMUzqlTp9U8YbcAYpbytib3NzpUaBWx5qE/W1HcX56Ud5OsESYXBNd3YKOV1Vdm0wy4JvvecA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzRwYal7PDI6eA4IvJgyu6QC2aiJUiwlILKZHT0gabg=;
 b=awDuASi+wKnuI3NV9lcQ9K4QskGaNqi8QTYR9aHG0EYn7BGxTflenMsQwP2M1ScllKhAMbWIKPEvRXW5lRf1QzX2dVSSQWa3++hRHlGyviaJNGXgRwcE6qgiK5xfCiGsEdq+4HJjx779h3gIcJbwkPbn/ZtPjQ6QQNvAQ0tQ2DgO2C5vhLhJ9yO6Nwri984JcZsWwwsV4hDbErgaQgh1WlmAW4LeFDbmmAqytjk1r7wxHGRxwP1dtdZ0UrsgtU3O340IXb/87u9/o8bgr/hBYBjgw15Jh2kZoxyLZB1hBKkurqi5eqA1ocYpmdQbo7BsGgk+EAKctH6DN2R3789GYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealevel.com;
Received: from CO1PR05MB8426.namprd05.prod.outlook.com (2603:10b6:303:e5::11)
 by SA1PR05MB8279.namprd05.prod.outlook.com (2603:10b6:806:1e2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 15:01:15 +0000
Received: from CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669]) by CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669%4]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 15:01:15 +0000
Date:   Mon, 18 Sep 2023 11:01:09 -0400 (EDT)
From:   Matthew Howell <matthew.howell@sealevel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     Matthew Howell <matthew.howell@sealevel.com>,
        jeff.baldwin@sealevel.com, james.olson@sealevel.com,
        ryan.wenglarz@sealevel.com, darren.beeson@sealevel.com,
        linux-serial@vger.kernel.org, andriy.shevchenko@intel.com,
        ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH V6 2/2] serial: exar: Add RS-485 support for Sealevel
 XR17V35X based cards
In-Reply-To: <2023091853-reattach-dealmaker-ebb8@gregkh>
Message-ID: <72ce80bb-20c2-20c5-a924-f1e90e8f69d5@sealevel.com>
References: <1cfeb276-788b-5d21-5af9-8948c9273183@sealevel.com> <2023091853-reattach-dealmaker-ebb8@gregkh>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: BN0PR04CA0082.namprd04.prod.outlook.com
 (2603:10b6:408:ea::27) To CO1PR05MB8426.namprd05.prod.outlook.com
 (2603:10b6:303:e5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR05MB8426:EE_|SA1PR05MB8279:EE_
X-MS-Office365-Filtering-Correlation-Id: bcdfc9c1-2e61-4eaf-8523-08dbb8581ac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 57DshJcoqEfqp4coDhJ6r3bk/X6WdLytuRHVdQzxmr8djcM0myGnhTnAK3Bjl8vbi3gC8B1yZCujKLJE7k/qjqvd3ehhEFRb05l559SyuHalE+N2IrWmTIy78op2yUx6fnyxtKA7T0SkbgkpNQxP6dhJniFNcfjal6QEocRVLuMR4ttykFSr10ZbXkcjWJEn5JCpQc9JI0802kwQAgNPe0atpNllZP4kd6a2e4Gzmy5cjTJwIF9rym8p8yL7lkyw+J4Lgf34xzHppY8ZkoixS2JWhfcOFypka7BJGFyqi9oV94+amp15Z5A3QxFom/jg8kbr0hZELdFo88a64UKFN4w82MFk52Vsue7LJ67C8UtdzZgcwNs13i4qwqcj1E6B6BAJmWlmuFk/82k5N1gGr/1h25Rz/0jUrnRWzkBEnTy4ZdlKsRSRUnkf98CwAu5odcpDPwT6ARsN5dGKemYuUZmrot3NetY8mUYiJcRClkIlk7KIlZQTQ8M/O2t6cmKgSnXK+vOWY6drUC9V1XEHhjk4+kET0ZlEUAmuRcfmKmaJvoRPSMgfKJE2RYm6P1/+fy0rRDPOaQ6LzmZavtzh+hMx+os4JmgrKJDLBVYQ8NKQ4U6Qm+vPAoGpaNYb0PmkZiKnHpdJJMLW5DwP+Kyy6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8426.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39840400004)(346002)(376002)(366004)(136003)(186009)(1800799009)(451199024)(2616005)(26005)(6506007)(6486002)(6512007)(36756003)(31696002)(86362001)(38100700002)(83380400001)(44832011)(5660300002)(478600001)(966005)(41300700001)(6916009)(66946007)(66476007)(66556008)(316002)(8676002)(8936002)(4326008)(31686004)(6666004)(2906002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a6tRBk6+6dmFZDUGHdXKpfljxYTll/kknS1ltnMOzjppBTbKq1O2KG8Uk07v?=
 =?us-ascii?Q?Zj+mTrdtvx5GOIYOYA1ZSW6LJV+yMIq8QvT3EaQQ71EbGNkm2qGq5T/0vt0M?=
 =?us-ascii?Q?Gj1LikY1ZZufquH8PwPvMIgft3hZoA2NawtB9bnYaGByg34lZaL8GoHFNZl2?=
 =?us-ascii?Q?zetvvrqccBz1g3Etn4hA5URtjiyfF35GczoLAnaXSUuEjs5XAusYE8MPMtXY?=
 =?us-ascii?Q?+Wv17B+1pMYDlOwZMLHqab/w9AFoAX8vBKvnZJga7XI/EFPkxgKhjcIsoGq8?=
 =?us-ascii?Q?mBEv/wCr0gsfH57IYDYWIJ/wZlGHndPVrRMoGYTWb41EcPjvQ/ii5QDlktNB?=
 =?us-ascii?Q?rSFztaFGuumGySRo+CUZNK+Zgs/Bp9UQH5GtX9iIB2P0wY7zmI1xyLL1sh+H?=
 =?us-ascii?Q?9vuaDcwRh800olwQQo2xVr1oJDb6wDfSaATlxdD35TM/8/osI7rW6UXrreeK?=
 =?us-ascii?Q?geKP3ddrnc5xDwfDqi2pTTKaRRA+iH/ERz61kXW4GGUDcDxV1iNvQKJNzr2J?=
 =?us-ascii?Q?hgcsDjsgWPT5lQowDd3maryvCG8eIkGDSdInO/N6hvk/DbW4D8k+6YNoZ1eg?=
 =?us-ascii?Q?N3rSD6/o3crUHixVI6nYs9EOoZlSwofCErTMiTlQucr0UuQHlZDaOjS9MgQv?=
 =?us-ascii?Q?w1Fsk1quYdZcjYgDXxnZ6A/5DhPY1LVpbHOrwHx7mL8Zq6GeyoTZo6cZvgtb?=
 =?us-ascii?Q?oJu47unKvpeWvrFqsktBd4LMjPv96Gy6mHxx4ochy+ujyTWxuT4JTr+iRA1j?=
 =?us-ascii?Q?MphkG65/8hWyRfXbK0HyE5qltZwro8faL9jpugOvnPy8c2/FFaGkSFDFDwrX?=
 =?us-ascii?Q?Iorb5/ZE5ldKBtlNl8RklJG9CxE6p1tM8iujWs9m1sSEliJ0gGjv3gAF7S+J?=
 =?us-ascii?Q?HW/uWnZlbMMntr4Y0yREVF6SN7YybEMFzEw3GCbl0hDnhjHNINkaEAnScNul?=
 =?us-ascii?Q?3VLGpJJz0CL1chjr6KhtJXVeey1Eo0D6Dl9THb9x2MiH0QevwLywfNlQi0/Z?=
 =?us-ascii?Q?dl0K/DQ8RSgc6LlLJ9nXCR03SAvGRUtLoKagfgmW54jGB53gbqu1oIHi/Pow?=
 =?us-ascii?Q?ORrK6ugnfPt2/plz4U2Ap9QT8cHcQhE5Cg/KNv5PACiAcHRo4olTZD8VAQ1q?=
 =?us-ascii?Q?zHjix9cu8SKmN3sNbUrnbffQaPSFHtW2uiiT4rMw81qg6hnw3t7OMDJ6UIKT?=
 =?us-ascii?Q?BN6yi6OquLQbVdaXTi8swltPvzWuHlIZIWlXKhF5h5BMckpauXCE/vSKXKgH?=
 =?us-ascii?Q?X/fa+5SXSOGLlyC9dbQxUfRLPmn86dc4i7t1NdJqmqiHw5MYFv+8bZb30YFA?=
 =?us-ascii?Q?CHjs5zkLXGTAvaqjsr++n0D38uQjD1eAWHprEjL7xopL8p5jfE1L41CVXiux?=
 =?us-ascii?Q?w2yiZsMsc8nGjlVJJhRkcM/Dm/9+za7Ej7ce/JIEe5fJ3xU9UHiYCQWNo15W?=
 =?us-ascii?Q?HofQLznNHkkHU/xrqs69IaC/07XHbRxSz5+pQRwFlBLrjGEaaFJWV2oHxYmn?=
 =?us-ascii?Q?NGI/I5JeEDlak+vGpT+TAH1/gtUl2O5kv2oDvv4QHlEQBc1D3buqOA3jkt7O?=
 =?us-ascii?Q?STPdfryownAzYPA6KDXtx7TJncWf1K5TKfsbYfbVmx9tc2tjEOpfWazT9iOb?=
 =?us-ascii?Q?IA=3D=3D?=
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdfc9c1-2e61-4eaf-8523-08dbb8581ac8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8426.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 15:01:15.1507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+wu0ekeNmEoNfe6yOQiYj9KWQfxURZ8WhyBEC6AbzK22Mnu2F0RhPhRTRbzVZMSR+QUn0cikkCB+FNKFLR7VyrT4cRAI1O9tsKiY5o62/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR05MB8279
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On Mon, 18 Sep 2023, Greg KH wrote:
> On Thu, Sep 14, 2023 at 04:52:21PM -0400, Matthew Howell wrote:
> > From: Matthew Howell <matthew.howell@sealevel.com>
> >
> > Sealevel XR17V35X based cards utilize DTR to control RS-485 Enable, but
> > the current implementation of 8250_exar uses RTS for the
> > auto-RS485-Enable mode of the XR17V35X UARTs. This patch implements DTR
> > Auto-RS485 on Sealevel cards.
> 
> You have trailing whitespace in your commit log :(
> 
> Please fix your editor to not do this.
> 
> > Link: https://lore.kernel.org/all/24b88a50-9c53-82ba-84d1-292c74c81981@sealevel.com/T/
> 
> This is not needed, don't link to older emails, that can be done on a
> 0/X message if you really want one.

Ok, I had misunderstood the purpose of the Link tag then.

> > Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
> > ---
> > V5->V6
> > Split ret in sealevel_rs485_config
> > V4->V5
> > Fixed typo in commit message
> > Split readb and writeb into multiple lines/variables
> > Removed "store original LCR" since it was clear from code
> > Various small fixes to tabs and whitespace
> >
> > diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> > index 3886f78ecbbf..34f0e18c7ad8 100644
> > --- a/drivers/tty/serial/8250/8250_exar.c
> > +++ b/drivers/tty/serial/8250/8250_exar.c
> > @@ -78,6 +78,9 @@
> >
> >  #define UART_EXAR_RS485_DLY(x)       ((x) << 4)
> >
> > +#define UART_EXAR_DLD                                0x02 /* Divisor Fractional */
> > +#define UART_EXAR_DLD_485_POLARITY   0x80 /* RS-485 Enable Signal Polarity */
> 
> Why are these values not lined up?

Because I had my editor configured for 4-space tabs instead of 8-space 
tabs at the time and did not catch that after I changed it to 8-space 
tabs.

> >  /*
> >   * IOT2040 MPIO wiring semantics:
> >   *
> > @@ -439,6 +442,41 @@ static int generic_rs485_config(struct uart_port *port, struct ktermios *termios
> >       return 0;
> >  }
> >
> > +static int sealevel_rs485_config(struct uart_port *port, struct ktermios *termios,
> > +                             struct serial_rs485 *rs485)
> > +{
> > +     u8 __iomem *p = port->membase;
> > +     u8 old_lcr;
> > +     u8 efr;
> > +     u8 dld;
> > +
> > +     generic_rs485_config(port, termios, rs485);
> 
> Shouldn't you check the return value of this function?
> 
> Yes, today it can't fail, but you don't know that will really be the
> case, so please fix this.
> 

Ok, will fix.

> thanks,
> 
> greg k-h
> 
