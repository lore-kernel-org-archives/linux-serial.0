Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92FCC4338F
	for <linux-serial@archiver.kernel.org>; Thu, 29 Jul 2021 15:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC0A660F42
	for <linux-serial@archiver.kernel.org>; Thu, 29 Jul 2021 15:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhG2PnT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 29 Jul 2021 11:43:19 -0400
Received: from mail-eopbgr40083.outbound.protection.outlook.com ([40.107.4.83]:17217
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237891AbhG2PnS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Jul 2021 11:43:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6TS0oxAHrvPH4ZWDWA782SsBIGHUP7F5yMeKlwZQ0QNKIufgLMmPxAooOhI+wfp2XmO7dMZ6nlRLBOFvjUBp+dR46htMcoYJ8+3ieFqfORTICXw1Ga2EN0rKUrUHvaShrpvfDuQrcpF+U85SqrXjwoLPHFLVnmFA9f6bN4hpJzdpN90tMI+5VIBbVCyWQSDld6h+8lVNV0GKnDUHWzOzxBxzCEff4zyrPVZ+o570TiR6Ka3YJ817WjBdybPr3zFrduAohmxzBX1QDCgk4dv9tTOpjVYWJ6an+csLRmJqGsIezBuJjWu1XXEYNrlyTwcrCT9fnHPXb05tYJhPLJFoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGw31ro4NzITNW81M0R8jXH5EicdpAlYi+oAqeX2rkw=;
 b=HtD6m0Al6+FujfuiriQAodQPZaNLY3UaKdf5ekQcAL1N0qvRUjw1h77yxUDuPSHW5hOCsf2vCDf6lYukc4e4wjE8ZSdIzqoaVh+0H5QOInuizJVBtzJfioqk1XA2BLqpOcrz6BSuOODwqrSWVqdNMDcpA/gD0luR0z4JVHJR3umT0MoVq5xk6eT6C6qQkSZsTqmEhK7+B7kbnpdJiArT796jqevegS/CW5ZlvRVjsg5MwUetB4d8bxpwcofjo6xmoAXrcpkQOWzWuIuupxKK0CmvagzqGSyphYBI7a12hC69QKixsEhU2Sa0nl5gImYn7XWx6BJ4dzhtJP6IfP16kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGw31ro4NzITNW81M0R8jXH5EicdpAlYi+oAqeX2rkw=;
 b=3NEPw9+k83RpXJlYPHwJv4ChxUT+/1uqlHOCDvUM611AW2RkbRrkOfl8i2Yz8ytqfWBXmV8846GB3So1kModsyXnHRZyTr//p4JND007oAMeQR69eaLCCq5RC2C+A+1xtmp4KX42yYNYKSH+kY2p1YkAc2hiuI74Tb+MH7GWEAE=
Authentication-Results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB8PR03MB5579.eurprd03.prod.outlook.com (2603:10a6:10:102::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Thu, 29 Jul
 2021 15:43:12 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4373.018; Thu, 29 Jul 2021
 15:43:12 +0000
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
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <79157167-335c-b2b3-8104-e3272226b369@seco.com>
Date:   Thu, 29 Jul 2021 11:43:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YQLKB5jqx0/eFLR9@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:208:2d::32) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by BL0PR03CA0019.namprd03.prod.outlook.com (2603:10b6:208:2d::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 15:43:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5d0a44b-6442-468b-3046-08d952a792ad
X-MS-TrafficTypeDiagnostic: DB8PR03MB5579:
X-Microsoft-Antispam-PRVS: <DB8PR03MB557914A27F59F11C0347AC8796EB9@DB8PR03MB5579.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M8x8VpBUfM8UgajFuonNHY1pgX8alLk7XZVE5WRNnTGqdDRHtG0hmzPvL4C34X2DtIJk9TSB7keKprwMFmsi9ce+2ossC4hq7rDufNFdqVDiIXChWq4ox7wswh4p9eEbr9gqw9HR+wmRl4axaiN0AS8ZeGE7eg2PYhtjoZnXtAAUYIA4N+j+N31OzMVMyE/G+AEdvOJhHMYWXCcyHrGQ8kRvdNNhhtGTUiWbJUHSel5eneHynCFYS+qdffBfiKqPNolNwWyb6dSdpKaKabk2dG+VSrYc4jnpglOTMgZqj9WQhlvlGKBKRgaJTdi1AcSFHu23NV88TZcjjFdpRvS9nVVO/7muGW+Dr52G4XO9PcM+BIFSKqlvm9wHBTJuPEkr/UBXzL11m4CpC5nWcQdI3b4qTBByEIfemT0w6OZuY77aMGYM9fngEQhE2RuCr+MsOawriKdUYLDDnKFlnoslFjsjIopmb1kIVt+LLtAJI37bEpDX8n1bq5+t2pRPPK/At8gAkulmSMfI5T4KBVbAGk8tUK2NYiK+c7xt2/jWZ73sSQk98ubQFZrWOl15tWINLtDthITur37tMYFYtctlblwiYe1UCLHtS7yTGZt3uYXgNDwRy9kUQav8E1xI2oo269M3oc5FuP3CRURnt6TOTxG9AI9qnOJFBZOx0wSORtPWZIRZyI6E8dsQH7SQ4eUEV6l82p5QdiJKbBR7EIcqL3eEQkgaw3+xQnalpkR2ib1P5vNMTaKfJkhmd2aYfq5or6LlOlBBbDNKJJtkL9Xkaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(39840400004)(366004)(396003)(2906002)(36756003)(86362001)(54906003)(316002)(16576012)(478600001)(83380400001)(31696002)(31686004)(6916009)(26005)(52116002)(66946007)(8676002)(6666004)(2616005)(53546011)(66476007)(66556008)(4326008)(186003)(8936002)(6486002)(956004)(38350700002)(38100700002)(5660300002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkN0OTFwMHpUMVZ3d1hSNXgrR1lTbU9Lb2JqNUZ2UDFqcS9aTzhCYXBUMk0w?=
 =?utf-8?B?aXA1ZEx3YWJxWlVpNWhrQkdEYmVqbXIvakh6NUpjWEpTWkhxOFBKOU83UUgv?=
 =?utf-8?B?TUN0U091MEZJY0ttbE4rN0o0US8wZVhybEJJSVAvOFJUdmcxRkZhWHc0R0NE?=
 =?utf-8?B?Z3I0TFJrYXlnaVJNbmx0Q21oaUZDUGs3alNxNnI5T01QdUFtQkZPWVZqYW40?=
 =?utf-8?B?ZGxCUW01M0RSakNHY3IwSVZyWXhvWUFzclJwWW9haXpLK25GYjRJM3N0eXFo?=
 =?utf-8?B?NzZFTjNpS09OQnhOYi8vakhFb3NjYkdSek9UbFNMeUg2TmF5QzMvNjBGME5K?=
 =?utf-8?B?R0tvNkh4QklmZ010N09hYjlUc2pRbUdsZjlyc09ZZjBZY05BMkxtRkxNZnI4?=
 =?utf-8?B?bGoxMnZ6Snc5YW55M09tSnVCaFRwblhkR1ZhZjhFQ29pakR6eDI4TTd4M3lX?=
 =?utf-8?B?MjV1b1pFT3MyTEJuYXIrbDBKWnY1TWlEN3d0cjB6RlZzT0NWSkwza1NFL3Vk?=
 =?utf-8?B?QjU3VFJEbDViU3d2Vjg0SGxSSGd1eHFuR0s5WUM2dDgvcGlKTis1L1lEMlZU?=
 =?utf-8?B?eVRVQmZqeFJsK0k4bEFKRjJUQ0hCazhobUVxdzFEdm1ZbmdEbUJTMlFZYjRj?=
 =?utf-8?B?c3JTdzRKVTZHVVVWOXl2SUl2Z1JlT2VLUStmVjdlRjdhSk1TeXJicVVnUnh5?=
 =?utf-8?B?bXNhSjVhTm9WTnNkZWRZK1RtM1BER0YxbGxObmpXaW1tdzRaMXJlRVgyaHFt?=
 =?utf-8?B?YkVwRDJDQllWMFArK2R4RWxNSVp6b3c0NlYrUVVqdXZrbHN1bjhvYUtQQVpL?=
 =?utf-8?B?ZWlmcTZBUjE4cDF0WUhoYnBURGZQMGtrWXRvR05pQnBtR2djWFZjdmxwQko0?=
 =?utf-8?B?c01DMVlaanh5b1Z0OXhkbFNKRStKai85TS9uVWE4aUVRdkl2bmVSZWNBNnNY?=
 =?utf-8?B?aU1iMkU4S0FmOE1icE1OVnF0ZXptb2xQNHYwT240cHhBRkhsYVF3Y1dzVUJr?=
 =?utf-8?B?WVBNcEpjQm9RSUpXNEJUQS80ajZteW91Z3dhUFRDZFMrVDJQQ0h5eG4xNGlT?=
 =?utf-8?B?bUg1eXZEVk1HcWt2YWhLa2dXQnNrQ2JBMVh4RXF2WXBiTWxxSFp5U1pDOWc4?=
 =?utf-8?B?dGhxYzcvMkhpUnBnLzZhd3c4aTRiTi8xS3h3WVJLakF0NHdLYVQrKzNKV3hh?=
 =?utf-8?B?VzVyc2FoZmZwdzVVcThQQ2piV1Q1cS9SbkcxdmRzSmFackY5Q0FSaGJxelFX?=
 =?utf-8?B?cTJSTHc3SVVKbnZuOTlKN3VzOE5WS2Z2ZjhXMUhpZFdTTGpWVXlqbTlqR1ZP?=
 =?utf-8?B?QXZRL3A5MWdEaVREOC85VWgrenF1UER3MU9XR0h4ZlNXYkE3MHdtMW91ZkVh?=
 =?utf-8?B?R2QxOHZnQ2lqM1dRelFCUjhhSW41UDl5NitDZ2hqYVVBek1oUXFuZVdCL1dh?=
 =?utf-8?B?Q2JvWkJBT3hNemJXTk40Z1dWRTc3dGR0Nkl6MnV1S2g4NzdNM0tya1VnQ1ZR?=
 =?utf-8?B?b3JuTUJHTWswSTArVlJjclVXb3ZZRlFQdHV4NzhJeWJWRFFwdkJqRGI4eXRV?=
 =?utf-8?B?cWFTTW13aE5ydDFrbTg0SjhSTDB6OVpLL2xtdzhXL2YyTzA2cjlMakdZRlkx?=
 =?utf-8?B?bnRTcVJ5QTdqRng0Q3h5anM5UEdpdS9JdGxLK0xFa3hoa0ZSZXNqSlVQVXlI?=
 =?utf-8?B?ZFdaREhiTkp4WDJzS1FjY0hkY0kwbkhPNVRpSlY4UDRSQy9RYW4rejZMb3Ru?=
 =?utf-8?Q?U1IJu4ol3Y58ZnmGLzxgZQWb0J7uZYU7rURt/MX?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d0a44b-6442-468b-3046-08d952a792ad
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 15:43:12.4385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d60Su79ER835UlsoFukZzjLyOMOuW5ZUUAKsO0Zv79ZdcTNTPFHVJEOLTPCF8n7U6MMEwEr+pu63bn1/NYpZrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB5579
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 7/29/21 11:32 AM, Greg Kroah-Hartman wrote:
 > On Thu, Jul 29, 2021 at 11:26:59AM -0400, Sean Anderson wrote:
 >>
 >>
 >> On 7/29/21 11:01 AM, Greg Kroah-Hartman wrote:
 >> > On Fri, Jul 23, 2021 at 06:31:51PM -0400, Sean Anderson wrote:
 >> > > This device does not support changing baud, parity, data bits, stop
 >> > > bits, or detecting breaks. Disable "changing" these settings to prevent
 >> > > their termios from diverging from the actual state of the uart. To inform
 >> > > users of these limitations, warn if the new termios change these
 >> > > parameters. We only do this once to avoid spamming the log. These
 >> > > warnings are inspired by those in the sifive driver.
 >> > >
 >> > > Signed-off-by: Sean Anderson <sean.anderson@seco.com>
 >> > > ---
 >> > >
 >> > >  drivers/tty/serial/uartlite.c | 52 +++++++++++++++++++++++++++++++++--
 >> > >  1 file changed, 49 insertions(+), 3 deletions(-)
 >> > >
 >> > > diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
 >> > > index 39c17ab206ca..0aed70039f46 100644
 >> > > --- a/drivers/tty/serial/uartlite.c
 >> > > +++ b/drivers/tty/serial/uartlite.c
 >> > > @@ -314,7 +314,54 @@ static void ulite_set_termios(struct uart_port *port, struct ktermios *termios,
 >> > >  			      struct ktermios *old)
 >> > >  {
 >> > >  	unsigned long flags;
 >> > > -	unsigned int baud;
 >> > > +	struct uartlite_data *pdata = port->private_data;
 >> > > +	tcflag_t old_cflag;
 >> > > +
 >> > > +	if (termios->c_iflag & BRKINT)
 >> > > +		dev_err_once(port->dev, "BREAK detection not supported\n");
 >> > > +	termios->c_iflag &= ~BRKINT;
 >> > > +
 >> > > +	if (termios->c_cflag & CSTOPB)
 >> > > +		dev_err_once(port->dev, "only one stop bit supported\n");
 >> > > +	termios->c_cflag &= ~CSTOPB;
 >> > > +
 >> > > +	old_cflag = termios->c_cflag;
 >> > > +	termios->c_cflag &= ~(PARENB | PARODD);
 >> > > +	if (pdata->parity == 'e')
 >> > > +		termios->c_cflag |= PARENB;
 >> > > +	else if (pdata->parity == 'o')
 >> > > +		termios->c_cflag |= PARENB | PARODD;
 >> > > +
 >> > > +	if (termios->c_cflag != old_cflag)
 >> > > +		dev_err_once(port->dev, "only '%c' parity supported\n",
 >> > > +			     pdata->parity);
 >> >
 >> > Through all of this, you are warning that nothing is supported, yet you
 >> > are continuing on as if all of this worked just fine.
 >>
 >> We don't. The idea is that we see if (e.g.) CSIZE is something the
 >> hardware can't produce, warn about it (once), and then set it to what we
 >> can support.
 >
 > So you are ignoring what the user wanted, and doing whatever you wanted.
 >
 > As you can only support one setting, why even care?  Just set it to what
 > you want and ignore userspace's requests.

That is exactly what we are doing. We set it to what we can support and
ignore what userspace requested.

 > Of course that is a pain but
 > no one is going to notice kernel log messages either, right?

*shrug* Why does sifive_serial_set_termios do it?

 >
 >> That way the user can (programmatically) detect if this
 >> device can support their use-case.
 >
 > How will a user program read the kernel error log for this?

The idea is that after calling tcsetattr, you call tcgetattr to see
which of your termios got applied. Then you can handle that however you
want. This is what (e.g.) stty does:

     # stty parity
     [    7.221696] uartlite 84000000.serial: only 'n' parity supported
     [    7.222139] uartlite 84000000.serial: only 8 data bits supported
     stty: standard input: cannot perform all requested operations

The dmesg lines are just to help out whoever is trying to figure out why
their stty command failed.

 >
 >> So e.g. if you you have a serial bus
 >> or something, the driver can find out that (e.g.) the UART has the wrong
 >> CSIZE, and it can fail to probe.
 >
 > What will fail to probe?  Where?

The serial bus device. Though, it looks like things such as
ttyport_set_baudrate/serdev_device_set_baudrate do not check the
termios after setting them, so in-kernel drivers don't handle this as
well as userspace can.

 >> Before this series, it would continue along as if nothing was wrong,
 >> and the user then has to debug why their device does not work as
 >> expected.
 >
 > Why not fix your broken uart?  :)

I believe this is a feature, designed to reduce the amount of FPGA
resources :)

--Sean
