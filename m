Return-Path: <SRS0=jxo+=BD=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2DBC433DF
	for <linux-serial@archiver.kernel.org>; Fri, 24 Jul 2020 09:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB7292063A
	for <linux-serial@archiver.kernel.org>; Fri, 24 Jul 2020 09:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="TTw5ki3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgGXJT3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:19:29 -0400
Received: from mail-bn8nam11on2062.outbound.protection.outlook.com ([40.107.236.62]:9504
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726945AbgGXJT1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Jul 2020 05:19:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxyKRdtA8SfMKxPNPny3YqC/ZW6N1wwguhLH7dpJ3of2XF7ceAGejueSjKmgZovDUESAOVdgsJSw0aXWY0SYF2nL1ApItaGVkkKO0+9iPeidrvFrjqDdu9Pznk0vJOVRNLwKt+h2/PXH9A9rOvJYleicjxq39uYmS34Ps5pjb5jHKGsrg0uTcNxNycuKUGVwWlUNDUMTvVfJmd/+7kBTmWQlTybvTEbB1VaxUKM7Yjk3K4wR0LqMYhiEOwha75ledo5zOlI7BnaIRX5RfXodNdIcDH1MZE7EKnar7PXPqdjUkPCnGHjn5Lh0PNispZbtqHt98ps9wmipwRFDoJKdmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MckMOFVbhT+n74FyxHQPJQiv/9xsGuJJ9J1XIK5VgXw=;
 b=MzE+mNbOgtL/iCpv7xIScbwOT/OUQP53rtFrCO5u40/ahn9o+JTs3pmv3fd/hwLRrUVj5pNK7Vep64jcYW/UBfIvyVkF7jlP6t/20GOBcY+QWNe2WWnK8Gd8CiaqRHd136M6MK9HSOZ53n7A7uLffARwuUD7ydorsDSLJAC1pAaYRDeA5I3FjAuOEXPfOvwzb0uimOoyZ9VzWnQ3IbTslMv7CKQB7t1tv0SlqAqo18aKzk2d33wuqH3pefDgIxEDEEWseNr445EY7QfDla7DmUqmRys9nIl3i8lX8z/RCfX3Nf1Hs4IleFuJCreWy4WZSybrIIDVgsG5HLnZtaCKxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vanmierlo.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MckMOFVbhT+n74FyxHQPJQiv/9xsGuJJ9J1XIK5VgXw=;
 b=TTw5ki3Ms10X+lCC7UJy0WWBRRaw9QZFJD+nHrOUifOxOlT03uHquAGWdCiCVTmUEJxECq15a1fqtEKhdUBmSvr1RDWdHqP971+TaMgIdidwlleHE9v/2mECbqJO5JbNn6Wr9Ok5wABH4XvVokqZaxTssPQrDa4Tpzgm7u8SzUY=
Received: from MN2PR20CA0004.namprd20.prod.outlook.com (2603:10b6:208:e8::17)
 by BY5PR02MB6227.namprd02.prod.outlook.com (2603:10b6:a03:1b1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Fri, 24 Jul
 2020 09:19:20 +0000
Received: from BL2NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:e8:cafe::d9) by MN2PR20CA0004.outlook.office365.com
 (2603:10b6:208:e8::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend
 Transport; Fri, 24 Jul 2020 09:19:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vanmierlo.com; dkim=none (message not signed)
 header.d=none;vanmierlo.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT017.mail.protection.outlook.com (10.152.77.174) with Microsoft SMTP
 Server id 15.20.3216.10 via Frontend Transport; Fri, 24 Jul 2020 09:19:20
 +0000
Received: from [149.199.38.66] (port=53397 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jytpU-0000g5-NO; Fri, 24 Jul 2020 02:17:24 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jytrL-0008GZ-Q9; Fri, 24 Jul 2020 02:19:19 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 06O9JA1X019234;
        Fri, 24 Jul 2020 02:19:10 -0700
Received: from [172.30.17.109]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1jytrC-0008AR-0t; Fri, 24 Jul 2020 02:19:10 -0700
Subject: Re: [PATCH] tty: xilinx_uartps: Really fix id assignment
To:     Maarten Brock <m.brock@vanmierlo.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     Helmut Grohne <helmut.grohne@intenta.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Jan Kiszka <jan.kiszka@web.de>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-serial-owner@vger.kernel.org
References: <f4092727-d8f5-5f91-2c9f-76643aace993@siemens.com>
 <20200709074849.GA28968@laureti-dev>
 <a3b9df28-8142-fc04-317f-44d65a24f38e@xilinx.com>
 <20200713071123.GA1994@laureti-dev>
 <e7b766ab-8c99-d30c-2352-6d7b09033537@xilinx.com>
 <20200713121019.GA6920@laureti-dev>
 <2db78149ae9ffb205f02ca4919b50d88@vanmierlo.com>
 <c652674b-97c1-c333-0d75-ae40c3c7de49@xilinx.com>
 <775b7fc75f27513f70df63854ddccf58@vanmierlo.com>
From:   Michal Simek <michal.simek@xilinx.com>
Autocrypt: addr=michals@xilinx.com; keydata=
 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
 0Z1MQlmNcq2bhOMzTxuXX2NDzUZs4aqEyZQ=
Message-ID: <420b9424-671f-f7b4-a7af-7468475f984c@xilinx.com>
Date:   Fri, 24 Jul 2020 11:19:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <775b7fc75f27513f70df63854ddccf58@vanmierlo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2a9fce3-0409-4cfa-4dc3-08d82fb2a593
X-MS-TrafficTypeDiagnostic: BY5PR02MB6227:
X-Microsoft-Antispam-PRVS: <BY5PR02MB6227ADD60988157FA29C61C4C6770@BY5PR02MB6227.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pCnsX/tcLa/gxxZHu3AOmvGEnp+11G8XHPPiQ08WLGnSdznzVf82nEep0W/jEaYo5XIZiCMR/V88KZ0+5+0QQWlLIjh4YD3WmrcJ7vtSXK+jmIQKRAsvUfwo/ssR+36pXDvLZvooRJ+lskDTk2FS22+BB3UUizLWz7mAkTHY95Xhle+zsYmH5Zw3aYosezp30UGdBKiXvCsnlZuxafIgW3hrhsed3lMCBAI3ksmE+hoZeQxMPFBmodEUAyC4bQA0IR5v2G2IV5wlqN26tKefh7Vv+k3Ga+0dtMQ7jqmNN4DyHs6alMqbyAyyBI5OWYOnqVJ5MkR4g+uB/PXt3oyMAoKDBwvcANPs95UbapnW8Z57dDb/d/twTjejPao3SWEmUtQinnKM1Uv9G743LNvoMjVSf33isi0mufu2m4ZMUP+W2c2o8r7oS5QRuy0+qWPk
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(376002)(346002)(39860400002)(396003)(136003)(46966005)(6666004)(2906002)(81166007)(2616005)(36756003)(356005)(8676002)(47076004)(5660300002)(82740400003)(186003)(4326008)(31696002)(44832011)(426003)(336012)(54906003)(110136005)(70206006)(478600001)(82310400002)(316002)(83380400001)(31686004)(9786002)(70586007)(8936002)(26005)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 09:19:20.1393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a9fce3-0409-4cfa-4dc3-08d82fb2a593
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT017.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6227
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 22. 07. 20 18:50, Maarten Brock wrote:
> On 2020-07-22 09:18, Michal Simek wrote:
>> On 13. 07. 20 18:08, Maarten Brock wrote:
>>> On 2020-07-13 14:10, Helmut Grohne wrote:
>>>> Hi Michal,
>>>>
>>>> On Mon, Jul 13, 2020 at 01:49:38PM +0200, Michal Simek wrote:
>>>>> On 13. 07. 20 9:11, Helmut Grohne wrote:
>>>>> > Let me try to enumerate those I know:
>>>>> >
>>>>> > uart0    | uart1    | console | remark
>>>>> > ---------+----------+---------+----------
>>>>> > serial0  | serial1  | ttyPS0  | regular case
>>>>> > serial0  | serial1  | ttyPS1  | normal assignment, second console
>>>>> > serial1  | serial0  | ttyPS0  | -> Jan Kiszka, broken since revert
>>>>> > disabled | serial0  | ttyPS0  | use only uart1 as serial0
>>>>> > serial0  | disabled | ttyPS0  | regular case with uart1 disabled
>>>>> >
>>>>> > Out of these, I'm actively using configurations 3 and 4.
>>>>> >
>>>>> > Which of these scenarios do you test already?
>>>>>
>>>>> For above we are missing also others
>>>>> serial1 | serial0 | ttyPS1
>>>>> disabled| serial1 | ttyPS1
>>>>
>>>> Is it actually possible to have ttyPS1, but no ttyPS0? I think I tried
>>>> doing that earlier and it resulted in there being ttyPS0, but no
>>>> ttyPS1.
>>>
>>> What if you also have a 16550 (in the PL) and give it the serial0 alias?
>>> Or a UARTlite? The serialN alias is inappropriate to set the number for
>>> ttyPSn. How are you supposed to create all of ttyPS0, ttyS0 and ttyUL0
>>> using a single serial0 alias?
>>
>> yes this combination is not possible and I don't think this is xilinx
>> specific issue.
>> I expect the same problem you have with ttyAMA, ttyS and others.
> 
> Well, it is very easy to add a 16550 in the programmable logic of a Zynq.

agree.

> Worse, it's impossible to only add uartps devices as the IP for it is
> not available to the public.

I expect you mean to PL. It is cadence IP and Xilinx is not the right
company who should releasing this paid IP to public.

> It is less easy to add a 16550 to a CPU with ttyAMA but no external bus.

Nope. Xilinx latest SoC called versal is using pl011/sbsa uart instead
of cadence one that's why it is as simple as was on zynq/zynqmp.

On Xilinx devices you can regularly see mixing devices with ttyPS, ttyS,
ttyAMA and ttyUL.
There could be others but they are more rare cases.

> But if you add e.g. an I2C/SPI based SC16IS7xx which generates ttySCx you
> might have the same problems.

yes and a lot of other examples are also present.

> 
> But the problem is worse. What happens if you give the serial0 alias to
> a xilinx_uartps and the 16550 driver has already taken ttyS0? (Or vice
> versa?) Will the uartps still use ttyPS0 or will it ignore the serial0
> alias? I predict the latter.

yes and this issue is around I expect from time where the first !ttyS
was created.
I my series to this driver (which is reverted now as incorrect design) I
was using bitmaps to find the highest free alias at least for this driver.
But for quite a long time there is commit 351d224f64af ("of: base: add
function to get highest id of an alias stem") which return the highest
ID for certain device type which could be used.

DT alias list is stable it means if driver supports it all the time you
should get order based on it.
It means you shouldn't never reach situation that you will have ttyS0
and ttyPS0 because only one device have serial0 alias.

If uart IP is not listed in alias list you should get highest id and
starts to count from there.
But there is issue related to this too which is that every driver has
NR_PORTS defined. In this case we have 16 in the driver.
When you have serial16 = &uart0 then you can't register it as ttyPS16.

My series was trying to solve it but it was reverted and I haven't had a
time to take a look at it again.

> 
> I see only two ways out.
> * Let uartps generate ttySx device names, or

It is not just about uartps but about all drivers and just use ttySx.
(not sure if this should be also for ttyUSBx devices)

> * Do not use serialN alias to set the number.

If this support is removed I expect it will caused a lot of issues for
others SOCs.


> It was already stated that it is impossible to have ttyPS1 and no ttyPS0.
> That would mean we cannot give serial0 to ttyS0 and serial1 to ttyPS1.
> This makes me wonder if the opposite is valid: to give serial0 to ttyPS0
> and serial1 to ttyS1. Probably not either.

Please take a look at Helmut's reply where he retest this scenario and
having ttyPS1 without ttyPS0 is possible.

> 
> There really needs to be a way to create deterministic names for the
> devices!

If you have alias list described for all devices you have deterministic
names already.
But the highest ID in name is limited by every driver which seems to
limitation which shouldn't be there.
If I write for example serial1000 = &whatever_uart; then I would expect
that I will get ttyX1000 which points to this device.

And as was also confirmed alias list is stable for base dts file. When
you start to work with device tree overlays alias list can't be extended
with newly added devices which has to use dynamic ID assignment.


>>>>> serial1 | disables | ttyPS0
>>>>
>>>> I'm not sure what this is supposed to mean. When there is no serial0
>>>> alias, I'd expect ttyPS0 to be missing. However as indicated above that
>>>> is not what happens in practice. So either of these two configurations
>>>> seems invalid to me.
>>>>
>>>>> All of these above are just not setting any console= on bootargs.
>>>>
>>>> We usually set the console= assignment on bootargs.
>>>>
>>>>> It means mix of these combinations is tested regularly but not all of
>>>>> them. Do you see any other combination which is not supported?
>>>>
>>>> I'm not aware of further relevant combinations.
>>>>
>>>> Can we maybe trim down the matrix somehow? In my context, the need for
>>>> swapping the serial aliases arises from a limitation in u-boot-xlnx and
>>>> the desire to use one dtb for both linux and u-boot. It requires that
>>>> the serial0 alias is the console. Are there other reasons to swap them?
>>>> If not, maybe fixing u-boot would be an option?
>>>>
>>>> Helmut
>>>
>>> I think that it would be better if u-boot used a "console" alias.
>>
>> console is defined in bootargs which is OS specific feature. U-Boot has
>> no idea what ttyPS, ttyS, etc means. That's why I don't think there is
>> something wrong in this in u-boot. But please elaborate more on this
>> because I am not aware about any issue on u-boot configuration.
>>
>> Thanks,
>> Michal
> 
> What I meant to say is that apparently U-boot requires serial0 to point to
> the user-interface. This limits your options when assigning aliases. If
> U-boot would use a different entry (e.g. "console" or better yet
> "earlycon") things might be easier. serial0 should not be special IMHO.
> 
> But let's not diverge too much here.

U-Boot is using stdout path and I am not aware about limitation to have
serial0 alias filled. If stdout is pointing to serial444 then u-boot
should be using it as console without any issue.
If you see any issue in u-boot please send email to u-boot mailing list
and CC me and we can take a look at it but as of today I am not aware
about any issue related to this.

Even serial uclass records serial alias (req) for drivers properly.

	aliases {
		serial0 = &uart0;
		serial1 = &uart1;
		serial2 = &dcc;
		serial1000 = &uartlite;
	};

uclass 80: serial
0     dcc @ 7deb8230, seq -1, (req 2)
1   * serial@ff000000 @ 7deb9db0, seq 0, (req 0)
2     serial@ff010000 @ 7deb9e80, seq -1, (req 1)
3     serial@800c0000 @ 7deba960, seq -1, (req 1000)


Thanks,
Michal
