Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99B9C4320A
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 15:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D9E461050
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 15:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhG3Pdx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 30 Jul 2021 11:33:53 -0400
Received: from mail-eopbgr20069.outbound.protection.outlook.com ([40.107.2.69]:53313
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231220AbhG3Pdp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 30 Jul 2021 11:33:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwVkR1PifaPcXy8Jbl5LkLoo6rH19MgqoIGOYoxwsicCgGrwNbW+rFwAEeXS3pUKQgwQNyWtTmBJE01UhLZ7HWfPNBzJeQh5AzZ/vBMEv8X5895XXfcheeYuBegN1E1eaZduDINzjgYLyW1Oigx8p5mSU4nDrS2CE7dMtOzIjmOTbm6DKTP40d+bhHkpa53rO9ItccrQtNw4anywcbI062fisNVysP6/rB9+puyH+i2FJV8pzfa8GdizBYs3i2VvjfNKMxDH52dqevVpU63uBHjtFoWl/dGIJlIkW0r1njj8ys4A3v9LY3R5AU9E4o+a7MDTs1iyoi02ZgmabxBYwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8r2Vo+VmW6LPdK9jAuOMvapMZxbsMPxvtvitJFMBg5w=;
 b=OXyPNpPwBHAOKozXoxKYGDS1ahP7XAH9uHwUPNI3MhloXG/ss7oqVZGEsD+jd2MUEqdJ+sBHHKJBVYpZ1WZuRDZV5lZMl0TUUIOTSXcVG5wp6+f6zOKvzVRIJ/KSbDdv/GIoMA7XmAwJjKfizDR3yqhBD+DBVrAcEGDOTG0F5QsMdxdvblCzNFe/ut2tJDH5hmEn+abDy4zO22ijzxqwP4m090aUTbmArFB2b2OZ/Q/epEVyubFSCmvKXPZSyvZVvoXE3BtU5ZcJ7VrTqnjoAmyA+i/ZrpI2TRYlLFlE1jpnm7RBNuPbRwmxZIvrc9USkzn0UCVJwUdYjE03o7FjgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8r2Vo+VmW6LPdK9jAuOMvapMZxbsMPxvtvitJFMBg5w=;
 b=JalfXLJJoEu40dsgIno6bIDI2VHAomMni4KfdiEawCkjcJ3AKb7ThJStemGFUcq+OhE8qF37MFcdE1eXMMwPKlMB9a6w/7NDZrEXtY3CFDRTubRsHeLUXpiVLuPbcTWbTAdX9mGQsns9mI2U/JfW+CiarfJRL2kQngOYKbZiyCY=
Authentication-Results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB8PR03MB6027.eurprd03.prod.outlook.com (2603:10a6:10:ec::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Fri, 30 Jul
 2021 15:33:38 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4373.025; Fri, 30 Jul 2021
 15:33:38 +0000
From:   Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH 5/5] tty: serial: uartlite: Prevent changing fixed
 parameters
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Korsgaard <peter@korsgaard.com>,
        linux-serial@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Michal Simek <michal.simek@xilinx.com>
References: <20210723223152.648326-1-sean.anderson@seco.com>
 <20210723223152.648326-6-sean.anderson@seco.com> <YQLC4L2Z3T4SuryE@kroah.com>
 <d46e0a4a-d9d4-190f-b41b-9c2b9e4748ae@seco.com> <YQLKB5jqx0/eFLR9@kroah.com>
 <79157167-335c-b2b3-8104-e3272226b369@seco.com> <YQONMMetaYI4aLMJ@kroah.com>
Message-ID: <97eed9c8-9583-3082-4b0d-7125ca55b5f1@seco.com>
Date:   Fri, 30 Jul 2021 11:33:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YQONMMetaYI4aLMJ@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::22) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by MN2PR07CA0012.namprd07.prod.outlook.com (2603:10b6:208:1a0::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Fri, 30 Jul 2021 15:33:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81f09207-2d16-41eb-9951-08d9536f66c8
X-MS-TrafficTypeDiagnostic: DB8PR03MB6027:
X-Microsoft-Antispam-PRVS: <DB8PR03MB602725F33AF069CD6C9BE79F96EC9@DB8PR03MB6027.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: El6hT6f2HO4SVMXLGGA+HfrCg4zyJbAMRNNbEheNSK9JDWq9mZ602cCHIPhRaQ/el1q+dtpF8stVUnOxhrr01XK3RdM7RRqscrZXQBc/GdsXUuJ7YQAO0pcOhlE7qO+VFarOBrzjf46+Nq1aUWjJZTn8LH7a4xzKVIgWo0N/R48QAQRRw4XCrFDUZbVD9uR6RtYgs6CiKUhFQB94Al406oMi3hrDh6T63ZtfwhmvPItNVZ9+V98DngxFTlRGZoGRaJ3BIvH9VdzN3E0fpGebsoYd90kH6hrC7P5XuJEhCiCkwxbjMr/C/4ncimxDZHPtUYrKXK59hLDKu+odAn3x/nIACHVbZmgIwq1lXt/AcLv0BH7O7d068wRtq2adHbjXVa/Qb+Ez53jYytBADOJC8LHuKeucnCh7/B3caC8wAsUoLGEmq+XPhI5HYU/mvaSyT5LXs6w/lFhGoRc++S/h2jYrEeBWwIE/P7VO73ou3AT6WQ37g2w+JaAJsrr3ueoQX6ENWC2Q/TwzTO/LTEWP5a9ovcNlsuVbTgpVdS5cs4FssXuvze16CGCHguRg/VehsjgUisjopWV5Besl1Ad+hs+oQidFN8YuHKuzq7U9wbtBqVbG8EAo7HQO5wJt+yx0czQDG8yP+eFSUSruHC5VF5w8LchSkz9gbrlmBYreyLQirzsDcgHZfYEn2uciZNuqAU8OIglfGBn3QDfZQon3nQBMqtnQvniBZNIyGoL3uieozl3ktATyVbA83kVVWrkyTdSH+rQWhXkiMpSIvQFUJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(376002)(136003)(346002)(366004)(396003)(38100700002)(2906002)(38350700002)(316002)(26005)(956004)(5660300002)(2616005)(4326008)(16576012)(478600001)(52116002)(44832011)(66556008)(66476007)(31696002)(31686004)(8676002)(53546011)(66946007)(54906003)(186003)(86362001)(6666004)(36756003)(83380400001)(8936002)(6916009)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU8yRlN1a25TcFVxRDBLUFBTeDluR1J1eStXSFlHR1ZLazlLVmRsaCtUejdj?=
 =?utf-8?B?WGlzd0hiMHBzM0NvMGRNeXEweVkweUdaQzZyODdlNWxlOXZaanAzS1R2UkQx?=
 =?utf-8?B?UCs0dlpwZXlMb3ZjclBoOG9VdlkvVjJDblZBUnM1WEpjQ3pUK1FTWWJ0TXVu?=
 =?utf-8?B?WXJHSXJEQTdMd0Z0c3MrL2V5Y0ZiMytOWWdMSUZNcjB1Z1JaSG0yaTh6dndt?=
 =?utf-8?B?U2ZuWjZBUENrN1dMcnNLRHRUT3c5ZVhqa0Rvcm80UWRuWk9iYzJ5ZUlBdVd6?=
 =?utf-8?B?UnF1ZGxSa3diQkRWMHhVTkpCU3l5UFNlR0x6b2JGdTVZTy9lRTJta1p0K0xF?=
 =?utf-8?B?WUY4R0RyMk9Hd3Z2eGpxTmc0ek1nVlpERVFjWUtOclhrNzE1bXlob25Fb1BY?=
 =?utf-8?B?di9WTEN1ekJEcWtWcVRnU3NLNWt6dm1EVi9uZndCSzZvZy91akZrWElvOW1K?=
 =?utf-8?B?SENhMlRZVzFKbGdJYlhKSHRmNjh2YWpNaHlWVGEyZk1Udm1WWUM1SVNWbEVx?=
 =?utf-8?B?Y1pNc0RLMDIyaWJjOVFVeU9HZVBTQjVXSXM4RzFOVEZVWUIzZ0VmYklJMk5S?=
 =?utf-8?B?b25MN1hnYmRlK2drZFZVaFkvcEt2NXFKMkRsdFc4ZkFmMitneEREc3dHTEZa?=
 =?utf-8?B?YzNBT2lWakRKcXRUT005UzAzYkNVMkNCcVF1SFF4ZFBlMEU2Q1VnUGN3Q1hD?=
 =?utf-8?B?YVFOQjhkQVdlaDR1NTB2VzY0Zi9NZUU5TGxVYnVIS0xFOEhMalI2MUsrOUYz?=
 =?utf-8?B?N0hvQUlvRzZyTFQ5ZVVFS3Zhdk5uV3hwemxGNzFaUTVHMElFYWt0MnhQN3RF?=
 =?utf-8?B?RnVpOVVvbmpLVzlJUEpHOEJJQmIwRjYrMjdOUHpuV0RyZWRnV0FUYmo2MUVO?=
 =?utf-8?B?RndOdTVidm1VTGhjblB1UTBHTWQ5SWJmV1Q2bm45Uzg3TVBzZkwzd0dROEdX?=
 =?utf-8?B?VFJjYlpOdHFRMFF6S3ZTZVpSS2tuV2hyTVAyc3N4dDJHcDczZEVhZXBXdUNZ?=
 =?utf-8?B?em5pRU1DbDR5bnlYMXNlLzVmN2ttQ0R1ZjBjekRpcG9rMWMxRVluMGtOdXBO?=
 =?utf-8?B?SmNVMmIvL0tjMHBsUStmWWo3R3pIQk1xK3B3ZHd0SndPRGxWaFdvWi9TRmNu?=
 =?utf-8?B?Z013OG9hVnYzT2o0NUwyaitiV2ZxbzVtaWJiSjlCREFOcTF0bElTeTBPeEZY?=
 =?utf-8?B?aEd2S2tPbjFuNzZNSGozcWkxQUo2c3hFdXZ1cVhIbUZRdWw1OHgxWHpsWGFq?=
 =?utf-8?B?SU1vZnRZVFBoQVl6bmxwTzV0WEJ3YzJlOThiR1dXUEJyRjJjYWo2OWFBN1RB?=
 =?utf-8?B?Q2pLdGE2YW5YaE1lL2lINHdqbWJXWFhJeUovcFd5VXlWZDZjYXd3cktDYXJu?=
 =?utf-8?B?MXY5OWNIdkFZc0lFMEtBcDRyWU1tMDZJVjFYdUdhWnlyNng4SDBWSmJocmY5?=
 =?utf-8?B?YU8xa3c3SE1oaG5OTkJtMDJrNVdSRGptNURrc0R4cHhHUFprRVVMNHhqaEFs?=
 =?utf-8?B?R0dib014dXFiV2FuOUlIRFg5WHlMWjBDbEpKcUIzdmJMc2IwbkxoVTZQbWZh?=
 =?utf-8?B?K1duQmYwYzhGYjgzL0hBWXRVSzJxNC9ZMVc5dkNFREtwTmFTQjhrSlpGZUwr?=
 =?utf-8?B?MmFER1pZV0JYTnFNcDdkL2RMY1A1NG1iRG1LWmMvQ0NnOXZDaTVvZi9HcVZN?=
 =?utf-8?B?aW05V1RuSnZZUWVLMUhDVTArOTB6cHdicW53UCt6Q1lVTFBRY0N2aXlveHlr?=
 =?utf-8?Q?c4wy0Ut8nnWnz/JCN41k6n8KZB7SLWV+KkMDEzL?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f09207-2d16-41eb-9951-08d9536f66c8
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 15:33:38.1582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFXIIc6Y8TYcsLKSqmZDPcHEnlOwgkwmoXR+dPqXfSSzki+sH2ZUgHxibmWQh1e6POFP5mAnVw+UiKmCi+tLdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6027
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 7/30/21 1:25 AM, Greg Kroah-Hartman wrote:
> On Thu, Jul 29, 2021 at 11:43:08AM -0400, Sean Anderson wrote:
>>
>>
>> On 7/29/21 11:32 AM, Greg Kroah-Hartman wrote:
>> > On Thu, Jul 29, 2021 at 11:26:59AM -0400, Sean Anderson wrote:
>> >>
>> >>
>> >> On 7/29/21 11:01 AM, Greg Kroah-Hartman wrote:
>> >> > On Fri, Jul 23, 2021 at 06:31:51PM -0400, Sean Anderson wrote:
>> >> > > This device does not support changing baud, parity, data bits, stop
>> >> > > bits, or detecting breaks. Disable "changing" these settings to prevent
>> >> > > their termios from diverging from the actual state of the uart. To inform
>> >> > > users of these limitations, warn if the new termios change these
>> >> > > parameters. We only do this once to avoid spamming the log. These
>> >> > > warnings are inspired by those in the sifive driver.
>> >> > >
>> >> > > Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>> >> > > ---
>> >> > >
>> >> > >  drivers/tty/serial/uartlite.c | 52 +++++++++++++++++++++++++++++++++--
>> >> > >  1 file changed, 49 insertions(+), 3 deletions(-)
>> >> > >
>> >> > > diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
>> >> > > index 39c17ab206ca..0aed70039f46 100644
>> >> > > --- a/drivers/tty/serial/uartlite.c
>> >> > > +++ b/drivers/tty/serial/uartlite.c
>> >> > > @@ -314,7 +314,54 @@ static void ulite_set_termios(struct uart_port *port, struct ktermios *termios,
>> >> > >  			      struct ktermios *old)
>> >> > >  {
>> >> > >  	unsigned long flags;
>> >> > > -	unsigned int baud;
>> >> > > +	struct uartlite_data *pdata = port->private_data;
>> >> > > +	tcflag_t old_cflag;
>> >> > > +
>> >> > > +	if (termios->c_iflag & BRKINT)
>> >> > > +		dev_err_once(port->dev, "BREAK detection not supported\n");
>> >> > > +	termios->c_iflag &= ~BRKINT;
>> >> > > +
>> >> > > +	if (termios->c_cflag & CSTOPB)
>> >> > > +		dev_err_once(port->dev, "only one stop bit supported\n");
>> >> > > +	termios->c_cflag &= ~CSTOPB;
>> >> > > +
>> >> > > +	old_cflag = termios->c_cflag;
>> >> > > +	termios->c_cflag &= ~(PARENB | PARODD);
>> >> > > +	if (pdata->parity == 'e')
>> >> > > +		termios->c_cflag |= PARENB;
>> >> > > +	else if (pdata->parity == 'o')
>> >> > > +		termios->c_cflag |= PARENB | PARODD;
>> >> > > +
>> >> > > +	if (termios->c_cflag != old_cflag)
>> >> > > +		dev_err_once(port->dev, "only '%c' parity supported\n",
>> >> > > +			     pdata->parity);
>> >> >
>> >> > Through all of this, you are warning that nothing is supported, yet you
>> >> > are continuing on as if all of this worked just fine.
>> >>
>> >> We don't. The idea is that we see if (e.g.) CSIZE is something the
>> >> hardware can't produce, warn about it (once), and then set it to what we
>> >> can support.
>> >
>> > So you are ignoring what the user wanted, and doing whatever you wanted.
>> >
>> > As you can only support one setting, why even care?  Just set it to what
>> > you want and ignore userspace's requests.
>>
>> That is exactly what we are doing. We set it to what we can support and
>> ignore what userspace requested.
>
> If you can only support one set of options, just set it and always fail
> the tcsetattr call which will allow userspace to know it shouldn't have
> tried to do that.

We can't. set_termios returns void. All we can do is set the termios to
what they should be.

>
>> > Of course that is a pain but
>> > no one is going to notice kernel log messages either, right?
>>
>> *shrug* Why does sifive_serial_set_termios do it?
>
> I didn't notice it during the review process.  Doesn't mean you should
> copy a bad example :)

I didn't know it was a bad example :)

Generally, I presume that any recently-added drivers are using the best
practices for their subsystems. If they weren't, I'd have expected them
to have been rejected during review. Of course, that doesn't always
happen (such as in this case), but in the absence of documentation, code
is the next best source of how things should be.

In any case, I am not particularly attached to these particular
warnings, as long as the termios get set to what we support.

--Sean
