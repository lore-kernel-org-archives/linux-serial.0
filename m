Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C6CCA0FFC
	for <linux-serial@archiver.kernel.org>; Tue,  5 Sep 2023 17:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjIER6f (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 Sep 2023 13:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240282AbjIER56 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 Sep 2023 13:57:58 -0400
Received: from CY4PR02CU007.outbound.protection.outlook.com (mail-westcentralusazon11011002.outbound.protection.outlook.com [40.93.199.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DFA26AA
        for <linux-serial@vger.kernel.org>; Tue,  5 Sep 2023 10:53:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3U8i0BQb9BfapiEWXIwLYcONz/NcB066Xg2zMf3AtIC1LY+dwwhgDnllNTUcKWpWHcwU7mkVVyrflcPqPYVuX1YZGa+EHDolOVNX9QHozLCgrKR7zqow9ci1od02jiJjmk9dDpiYIOZSfpLXIfwmq2m7s/IhXQsg3BectQS0HrrEcfFCnl36CW4piuJ+t94G09AYpRUp9LS+AP3XYIoJFD5ZRMwji9U//Nt8RGBFZoPS4A4y5zqwO8cm42wojtRtkBFfSbEpM0Blkn7Vr0mHk2i9UN4b8RtDkyZvBynR5YhaRmBPnbKaioU2xrdEPtJeYBPwJbo3s7QjAhDMv5jKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZe3drlQy5viR/TfX86GWnA1q0G8sSrByV6lWZcxp+0=;
 b=Lzeawutmke0hLJ7ZCtNHyrU5z5w5lFdOhE04aEaJY4Rh0EY3QWgL818sTlw46Ikrnae6uDmkOSnKzl+cComjmyOm3pZ+NQX4h63xFDWjUFxJs6AGubM6Bo2uJYEpDPv1zLzvuw7FX9HiGjvx6C6F4cpDI97HHAMs///fS4nWbeWs3eg23O4/M1opDTQGORTiq2rMTPpnXQGmfBN9am9ThZCuDwCeBtT/VRXCKgKIchfqiFiXG0AXDbVP8+tYSs311jbHictmo1BBxrz4eVsTr82e7/+eUQQ5W7FXIXtX+SjBpC+RXk3gxKzgl9IPyW4jJTW3lLcgJi6821YoE2i6Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZe3drlQy5viR/TfX86GWnA1q0G8sSrByV6lWZcxp+0=;
 b=aiG8CpqVrt1G6hO1H9QJlAIP0UyvU4fAM/pqoaWyuNoc+UONE0A5WGunO/zYwJ0GeEZhBkHHF8MNbqpgDqippexraiyxJeeKGM1HVfWSIkWemWq4BmghKoNuxZTJkhSYHh3J/PwzvUbFoR4oRMnXGK/VQXtmPGfzB+6l1zVbYBWEIOapjMj3TyWKBL2Ph98W8diqn/EETSxLTB0pePUegF6MafeKDOZkvE/p/8Yk9nf9K5sOzJRcK14OlQoJ65KGJph3tWozOLb33vfTHhRROGDZ6NUw8dB39mEUOYt5A7ZaswPZNI91CISV1rRZi110Cw5UMuOoNwTWq4ds7CJENQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealevel.com;
Received: from CO1PR05MB8426.namprd05.prod.outlook.com (2603:10b6:303:e5::11)
 by CO1PR05MB8087.namprd05.prod.outlook.com (2603:10b6:303:db::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 16:43:28 +0000
Received: from CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669]) by CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669%4]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 16:43:27 +0000
Date:   Tue, 5 Sep 2023 12:43:24 -0400 (EDT)
From:   Matthew Howell <matthew.howell@sealevel.com>
To:     Tony Lindgren <tony@atomide.com>
cc:     Matthew Howell <matthew.howell@sealevel.com>,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        ryan.wenglarz@sealevel.com, james.olson@sealevel.com
Subject: Re: [PATCH] serial: Revert serial: core: Fix serial core port id to
 not use port->line
In-Reply-To: <20230905155524.GR11662@atomide.com>
Message-ID: <79e44ee3-f4a0-6f3e-cb5d-dc2b7bd048fb@sealevel.com>
References: <98a891fd-5a1f-6568-a12c-28577126a42@sealevel.com> <20230829035245.GF11662@atomide.com> <511f2dcf-f637-695-8e81-8eaa3735ba88@sealevel.com> <20230829201557.GK11662@atomide.com> <472581f-e7f6-6cc-c749-5be16e4fe9af@sealevel.com> <20230901044730.GL11662@atomide.com>
 <e8579280-2f44-a585-a3b8-98fad29e6a2d@sealevel.com> <20230902043424.GM11662@atomide.com> <c4b1db31-7814-0d22-36de-a7e6f117d89c@sealevel.com> <20230905155524.GR11662@atomide.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: BN9PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:408:fc::16) To CO1PR05MB8426.namprd05.prod.outlook.com
 (2603:10b6:303:e5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR05MB8426:EE_|CO1PR05MB8087:EE_
X-MS-Office365-Filtering-Correlation-Id: 56a6ce6a-2f80-4c61-ccab-08dbae2f3ae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ce6xcBfQ14zf/MuY6o49+y3bcjMsPDpphrTX8WS5va/ehv1yVYyDnRmBcZaAGm64E3WkRNjPoxrv0CHvMizyKn1suFpj8urVfhSpsgLuDlw7fZ4Kj+jY7nFfKlBQkexmUP3+DS4SVN1bKl9HnJ79MiTYmps/JeXB2LQprxsBn0OZHSVWzE9v8kNr0DgsIxVJGUojWQab6ofbbj1nLJowJBeYSJSXP+twk5dOzhYqtRfUB/ghFc0Ny1BAMoJSqvbZqwM28VFnCDh0gh0Uv7CCBLv3yqsUk7/+z6HSDCHdngA6mSoKfW3HuebLx+tCNjWeDz1d/fpYgqLREZY9EBxSL4H9lsoBqgpuCXL95OifNYulDdxEz7Fyz8smNmATFf8HNbGxwhUFPQ8X7QuSouZIbQjVghui3oXLZiScWdzy2UouR8od+gDGMO9WuJw4aF+v2NQYKY4J34qaQkqwlJ9L9sTnRb0SneEY5CjFdTgRYyjm3zfXc+nEceONjf6ljdRrPlhvKp5LV0f7VRO2+EvXs2neeTvP4ddPyTrvI4iXbGDuKWZAzSKMXoV2bLCRUov1JKj3bQZvEeWrOlPC+LvKHdv1Z0fWl40VghkUW8sk870YfThP4wDFPzhoAYmZXcopFAB7fFwKxQlxxutnVEvmjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8426.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(136003)(39840400004)(1800799009)(451199024)(186009)(44832011)(5660300002)(66556008)(8936002)(41300700001)(66946007)(6916009)(316002)(31686004)(66476007)(2906002)(478600001)(966005)(6486002)(6666004)(6506007)(6512007)(4326008)(2616005)(107886003)(8676002)(83380400001)(26005)(38100700002)(36756003)(86362001)(31696002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pgc39YgmMPivsxUd6p3I2kPSwnaLoHiKM5Lio3krFb7aXgiFzsKhukqHKU93?=
 =?us-ascii?Q?+/6Jk1TpKFAN1150GLfCPKQFLGSwLAylB06lgtVjxK/CyaPmz6R4lRQEXBIi?=
 =?us-ascii?Q?b6TaDqehAoLaAMUQV2gDXEahHxzybsyGf4Ahj031iej/fV+L6sQtkE0cOG4K?=
 =?us-ascii?Q?VVXz3KXYAjWCPGOhxH8RM7O4cdLiawQkBDns8ViEvksLdqTgFnw4NHMiu5vm?=
 =?us-ascii?Q?540YoFsl5dS+uznLuRM/13XWuHSKXAxVjtdjjX7idQttet2KRdl+nAOYHWk3?=
 =?us-ascii?Q?xJVzAzZB2AgItfHBJJtb1Cj2Dr6qeWvM0iKtXgS3ewHmESOfZO0OoBmTbhiH?=
 =?us-ascii?Q?GNxzYx3eUVk+08RWhPGHbTiCQJWw2MSRWbwGPNu+0e0AvsVasMsZFsts3kpa?=
 =?us-ascii?Q?af2P0PuGSNuBd/FUIYawUl6fUopkxdCHTT5X8ECuB+7ObSIfdikWmEHHpoX1?=
 =?us-ascii?Q?EBoPpSxkOKESK6rSbyLnF6AdhBmcpyOukZZQehy6O6Wv8Hx2oI4v53CXqmnn?=
 =?us-ascii?Q?ZaJrybGjM6pvPgLkBb5Z5rGWi5fZts32emHHe3Ym+99i5NWokoNOm8W/Fvrt?=
 =?us-ascii?Q?3AGTsy4yrQ+1VjksvRYaHwj9KGb0RJGTiIvqSIrdzsnFt99xb+2GxKskIsQ6?=
 =?us-ascii?Q?FCfKEfVmDiY/v/cvL3WY09yKQGDvm7J2ljLWNtO3MbfPFoxyqRGUxfrkyAfl?=
 =?us-ascii?Q?V8YzxrN1Vl0DBLaDubZWT85wf5GZudeT+R3WoG/hhNqqAcms93VmQHs916yF?=
 =?us-ascii?Q?m4TTEIIfTAVs6qZF9tqfe9B6HFVcZQRoaUos6B0szafYm+ZHwl5ITBlqS+yx?=
 =?us-ascii?Q?np/fnKx+7DA2+9zWexE287Si5u5gHU1IvhdTudpXgtiFP+lSXBZ/+5+iV6y2?=
 =?us-ascii?Q?uXRlkYcCDOZchkXHNGd8xEYd3fpZME6r8+ex4teqSYBWJTFqK5jnl+4kS7W/?=
 =?us-ascii?Q?upgW0RxPAyIYimkT8kLB6ZDRmWEwEyEP3Zv6BJQS+s33M44SOF3lnuU13w3p?=
 =?us-ascii?Q?34BJmXHTsNG8TodKwGC9ybSNHpB+1RcdaypZD6wQPrQkpfnPtM+a3/1yqSse?=
 =?us-ascii?Q?kN77O7uzzzkH4zA8IJqfHJR3v95U9XLRqQEo8VDtPm6HPtYozYJS1TuaJpT8?=
 =?us-ascii?Q?8xsH+3oz6Cn5lSemEG2+p/PsM05Mqd8IB7vXGA4Q5a0EAe3ME+io3TEehi6u?=
 =?us-ascii?Q?4e8BrTpp7dK98RNIRLsnRG+5WPPGLD9uRPyiCgnJbqImSjXWgCLXMV746+Rh?=
 =?us-ascii?Q?vtWXw2eoyYPcBpgF/GKqk3w8Ga2Zufn6kderR+FEQ717fSeFfbk5dEnajd8p?=
 =?us-ascii?Q?Yj5UVoUfjdn1D8Nia126zKTxFkNvqwHQINcPsNNG1EnQVHyS/QE25sKeVNjd?=
 =?us-ascii?Q?16B2Z3Rr1JRYvec0jeexWYqL2pG0a9CSPD4RyZPW1PQk05sfI+vo1hqGPp6j?=
 =?us-ascii?Q?MJgP06EY3uFKtsS5piyBpoWt8nxPjjYTsiWY9169FiZ4DaUmQRMnsa2kaY3b?=
 =?us-ascii?Q?s68nN1PGIhSufvLUU1kEZF3ghc65BEXcdj+MS/ez94qP7d58sV1sIveMxhYZ?=
 =?us-ascii?Q?OZH5ww7TljK+ozNFvtm4Ilzj95/lkoLwx6Vj2IVdvj6c3gskvEEFMNbyOfdZ?=
 =?us-ascii?Q?WQ=3D=3D?=
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a6ce6a-2f80-4c61-ccab-08dbae2f3ae2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8426.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 16:43:27.8966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6prqy8zEEEJ89Jv8d+COWo0PcIXlHRJs5CrmG6jWnCywY4hXhSpeXVP7HPwXHxrRCA8iXfIFo0B+NaeysL+ZaRweGcVI79/eyePj/CRn50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR05MB8087
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 5 Sep 2023, Tony Lindgren wrote:
> * Matthew Howell <matthew.howell@sealevel.com> [230905 15:05]:
> > On Sat, 2 Sep 2023, Tony Lindgren wrote:
> > > OK. If the patch did not apply against v6.5, can you please verify you don't
> > > have other patches applied like your revert? I don't think the patch I sent
> > > is white space damanged or anything. Doing git diff v6.5.. should show you
> > > what might be different :)
> >
> > It shouldn't have had any patches applied to. Just verified again by
> > running git diff after pulling the v6.5 branch, but git diff shows no
> > differences.
> >
> > I suspect alpine may be mangling the text on my end in some way. If I
> > apply the changes manually and then run git diff v6.5 the patch looks the
> > same as what you provided, but tab/spaces are different.
> 
> OK thanks for checking.
> 
> > > Not sure what you mean with the 8250 entries from before loading the
> > > patched driver..
> > >
> > > Maybe things go wrong already somewhere earlier if the integrated 8250
> > > port(s) don't show up either? If so, maybe this issue is somehow machine
> > > specific rather than 8250_exar specific.
> >
> > I should have been more specific there. I was actually referring to
> > 8250_exar entries, not 8250 entries. I have not had any issues with the
> > base 8250 driver loading.
> 
> Ah OK sorry I misunderstood.
> 
> > HOWEVER, I did just find something very interesting. When I first found
> > the issue my running kernel was still an RC version (6.5-RC4, I
> > believe). The issue did NOT occur in the running kernel, or when building
> > 8250_exar from the 6.5-RC4 source. I expected the issue to exist in the
> > running kernel after I updated to 6.5, but this is NOT the the case.
> > XR17V35X devices still work in my running kernel. It is only when I build
> > from source AND the source contains the port_id changes that the issue
> > occurs. My current kernel is 6.5.0-1-MANJARO.
> >
> > Could I be doing something wrong here that for some reason only
> > manifests itself in combination with the port_id change?
> >
> > The only things I can think of are:
> > 1) insmod does not account for dependencies, so in theory I could be
> > failing to build and load some other required module. However, modprobe
> > indicates 8250_exar has no dependencies, so I didn't think this should be
> > an issue.
> 
> If you are not using modprobe, and have CONFIG_SERIAL_CORE=m, you
> need to load serial_base.ko. I don't think we can build the core stuff as
> as serial_core.ko without renaming serial_core.c to something else. Looks
> like your config has SERIAL_CORFE built-in though, and without the serial
> core stuff you'd likely get "Unknown symbol in module" error loading
> 8250_exar.
> 
> > 2) The Arch/Manjaro Kernel I am running does not actually have the port_id
> > change, even though it should. Do you know of an a wy to determine this?
> 
> Well I guess you could check the patches applied to that kernel, but
> presumably it's v6.5 for that part.

I'm not sure how to check for certain if a particular patch is applied, 
but looking at the Manjaro repos it looks like they just download the 6.5 
tar file and then apply their config file and a few small patches. None of 
the patches are 8250_exar related though, or even within the tty 'group' 
of drivers.

> > The general build procedure I have been using is:
> >
> > ## Clone v6.5 tagged kernel source
> > git clone --depth=1 https://github.com/torvalds/linux.git --branch v6.5
> >
> > ## Link symvers
> > ln -s /usr/lib/modules/$(uname -r)/build/Module.symvers .
> >
> > ## Copy existing config
> > zcat /proc/config.gz > .config
> >
> > ## Make sure 8250_exar is built as a module. Disable auto-version.
> > sed -i '/CONFIG_SERIAL_8250_EXAR=/c\CONFIG_SERIAL_8250_EXAR=m' .config
> > sed -i '/CONFIG_LOCALVERSION_AUTO=/c\CONFIG_LOCALVERSION_AUTO=n' .config
> > sed -i '/CONFIG_LOCALVERSION=/c\CONFIG_LOCALVERSION=""' .config
> > make modules_prepare LOCALVERSION=-MANJARO EXTRAVERSION=-1
> >
> > ## Apply patch, if applicable
> > patch -p1 < patch.diff
> >
> > ## Build and load module
> > make M=drivers/tty/serial/8250/
> > sudo rmmod 8250_exar
> 
> Maybe check if rmmod 8250_exar now somehow causes the following insmod
> 8250_exar attempts to fail?

Could you clarify what you mean? It is at that stage that I normally see 
the error in dmesg unless I have reverted the port id patch. In other 
words, if I just load it as-is I get the error in question.

Do you mean to try loading the installed kernel module with insmod?
If that is what you mean, I just tried loading the included binary with 
insmod but did not get the error and it loaded correctly. I loaded it 
with:

sudo insmod /usr/lib/modules/6.5.0-1-MANJARO/kernel/drivers/tty/serial/8250/8250_exar.ko.zst 

Do you see anything concerning or possibly incorrect with the way I am 
building the 8250_exar module?

> > sudo insmod drivers/tty/serial/8250/8250_exar.ko
> >
> > > Can you please post or email me your full working dmesg output, failing
> > > dmesg output, the kernel .config used, and kernel command line?
> >
> > ---
> > Kernel Command Line:
> > quiet splash resume=UUID=46a37dda-0d60-4ed1-94ea-9219fbe85dde udev.log_priority=3 iomem=relaxed
> > ---
> >
> > ---
> > dmesg start
> > Note: Everything before [ 1149.943049] is prior to loading the module
> > built from source. The successful version looks the same, except instead
> > of the error message I see the same ttyS4 and ttyS5 at MMIO... messages
> > that appeared before.
> 
> OK yeah thanks, not seeing anything wrong early in the dmesg.
> 
> Regards,
> 
> Tony
> 
