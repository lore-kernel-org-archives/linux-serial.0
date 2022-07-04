Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236E9C43334
	for <linux-serial@archiver.kernel.org>; Mon,  4 Jul 2022 08:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiGDIbY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 4 Jul 2022 04:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiGDIbX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 4 Jul 2022 04:31:23 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2111.outbound.protection.outlook.com [40.107.117.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADEE958A;
        Mon,  4 Jul 2022 01:31:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnMaky9kRYhGOGHg+sGE7nQp9NqNmZPMpx+z2RnwTyW6h0/0zex/dwOiPtm7zmm8HlAN18sBkISyoFN4II1VAgijsagJJ6NlEKl6sQaqJh1/hqMX/Qj/fBjO74mUtjoldn4oDeYZwrPRtpWTRjHp+x9LwPC1f1YR4xz0L9/YcE6zGq3RmvYUgl6jI9SZh+mcJvFoU/6NFkjIO+9osOxZ5zO1aS93Kxgj62B3CAYzaGPi8udFoU6HIKlo566c18/QtuNX5EeBY1F5u22cUOHlRi3kmePlPJmc7VPSh3kbJ4XLYOrdQr3GjMVgstRWw/R928e59C+fQ7ueTgwNWXf6Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IelrYbqfKE+xIhpDlAQ2ovsT3pzYcWanEwbMcZ9t3s=;
 b=FN3OK6OXtLuIhE8IZH+c9ubuz4g1Lpk8ss4rhGyvxHhQbfGF9czualkf6Xr/mRqDNJ8djiX6x8DUzOddNQsf5m4li5e37Q0ZW6r4MMSh6MgRMdJFS7CbN4PJO9De452stQps3QtcutivsYtFiLhiyTcqZEcREPOQJ/4J4XqyrxLFtRMPJnG6i7ZwuWR0W+hUEgibKad1lWZrbrF+XqJIr7aulbA3lH2t6oAKCEBTQLcwQXRW3FklemqIshhCKJjxTPFTYErIimji6KuA40jnRuzW9dFAMBIzWDltFP3AzToLv3X7n4XZONB31/qleMmKUAHOpVsNNvrzwVsjHRl4MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IelrYbqfKE+xIhpDlAQ2ovsT3pzYcWanEwbMcZ9t3s=;
 b=p/i9X4GuGFVmjqdtZtDQv4N5Kq9GBQKXfiXztf+wRs4bUaYiVNXmGsPD7iWE2YRCkzx9PNr6KO6ccymwh3JgzNfejkfbRhUg0pTGFQZBCTA/NSiqYzOO0yhrf4JuoP2vVaZznCnEnnLq0sdw4Oe2IrDTwMxs9rt5ZSW5V6vubXE7WPLCHE/odzKoJHhTW7o4zehooHiRnAdLeiU4ZytGgPPLPAZNbNhAsZyDwueFkLZ9ksCI9hL5Swgioer2Ai+YiNTvihkQNfYZS6uWV8yL7wQ412+umdUKWXaXK4OKXgu0wuOG78rKCCj+FEoWvfSE856WVOCKLwkm+oCXygkbcQ==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by SG2PR06MB2777.apcprd06.prod.outlook.com (2603:1096:4:1a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Mon, 4 Jul
 2022 08:31:13 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::46d:a7a:f047:e9bf]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::46d:a7a:f047:e9bf%5]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 08:31:13 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: Questions about usb to serial driver
Thread-Topic: Questions about usb to serial driver
Thread-Index: AdiM+OnNdGp6/p28TOGY715mtlYERwAIYqqAAANDRFAAATLCgACU5GCQ
Date:   Mon, 4 Jul 2022 08:31:13 +0000
Message-ID: <HK0PR06MB3202E63C8B86846B6F7C675380BE9@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <HK0PR06MB3202C7064582E6CB027237BC80BD9@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <Yr6fQbeo/FDrBmfU@kroah.com>
 <HK0PR06MB3202364874FC7283767C05D280BD9@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <Yr69MTLQHcJBC6Ts@kroah.com>
In-Reply-To: <Yr69MTLQHcJBC6Ts@kroah.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4f0e992-d7d3-473d-4eab-08da5d978e38
x-ms-traffictypediagnostic: SG2PR06MB2777:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IroBP61QGoJMUq+Ja8zntbf6ml1UA2+xQCK33vePM4Th0zHJwVONzVGbZY0s3a/4xSNPaBU1VYinNjjHWlWGrR4DTT50fl/C2CyDVxwzBsCEzlp8MZJz0v64BK+8/WboY4rGXovF+W5jLEsJ+QnAWb/HuMJL/C60beN6h+G10Pd71Fb3gtnLflh90MekgLaS5rTBHaMYj0YMQYQoRKdhCN71QK3veuX/sh2FFbp4wb/arHsxZq7mYPgMaL46JgbWlb0lOj9ZQPIRxWFzQizKbejZ+HXC5uj4RhL+sihzPKCxJFdNjKZKP4LflHE4ILnmFinCWH7Gabr9+pN8e/g6PyYgowX9792POjPJKoxay0g/wy8Chy2+G95L8eAJSMGdqTB9Dv20C6Wg0hNuSRGLGfg1yi8yeASzzAcAtk4QVj3hDGHs52ZjrsC8nDNCVhzeZJYoGGUA5WJ8YQiGXLK7AV2OJhkN+KZUWt7CHVmuLTcbLWVZIcuQ2O8+Ll3JcHsjH0R1QHWDunV0dFLALZXK5Bm8gYP1CbbgkqKtMmgxSTF7LQl8+UP2/wid2cKY4lVi25YI44u64nj8wjtaGSXKd2rvl237XI1jgA/RQRzF5ysWcDjqbtW8DzvE2WY9w+HUo8GFiFzy4h/ob5o5hb/DgSRxHdkYiozY1t8Lh1n99/kVCWs8+tKCyV4I5Ni3+uDHUiBMo/FkPaSe+/L92A73C1aIJGQfMAOVXXiVpZV3P2FPKIafoNdzhnnukTEHVPuDam2z2Oe34vu0F2WvLrFkimsqCL9yFXKSAlgp+SIm3AkAYZQXJv/2/zew0nrVOzJ4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(396003)(39850400004)(366004)(136003)(83380400001)(122000001)(2906002)(33656002)(38100700002)(54906003)(38070700005)(9686003)(6916009)(316002)(66946007)(26005)(64756008)(76116006)(55016003)(71200400001)(66476007)(66446008)(66556008)(8676002)(4326008)(41300700001)(86362001)(8936002)(53546011)(7696005)(52536014)(6506007)(186003)(5660300002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bySwtO+pN2Iy2Ha5CC3Q/xoM6xITPJ9Ljxgqyb8oZfEXtGTfjfmIFq703Huv?=
 =?us-ascii?Q?J3FIvst3faqM37LDCeb+gOLFHNH89likcikQZv5zBzXjhj8d66C+/DiEfmrF?=
 =?us-ascii?Q?CIQ2Vnb2pHiLR62r2Jm7VHkWHY/ANXW6yZNGTKiV4Yl42RYi6CgJ6qx8tebc?=
 =?us-ascii?Q?8OxW3eMsVqOc7sfMTVFDrXM9Kbk7OxXVAixCufYh4JnJGDr+WGYBbpTAVs4E?=
 =?us-ascii?Q?bZWvtOCpafKGJnjFF7KoS4TVytBEDqLICVrDAvnoNmmlUOuMO1VCs8XxgtMW?=
 =?us-ascii?Q?suq8Re5XBmsUUE7ULDopg+cbsZ/9MyJ4eEQtEAaCKKQeqVMXvwRHE4O4Wyga?=
 =?us-ascii?Q?YeaZq0UXvf/6+Q1LbVyYX+FDdFlwBT6/6A7DBG2HCxsn27e7FuvOcxFe1ZIV?=
 =?us-ascii?Q?YTHPZrCGl1epVHsHmJzBZ6BlI7zXqcj7VbkK/YeZePCTnTDeTd9E3CfX+P3H?=
 =?us-ascii?Q?I0gqkAXsReMyXVE/xL6ZXFtqjPUgfhTlMLJS17sgkDSOEbnjs6VocWkdN6tl?=
 =?us-ascii?Q?oS+FOFyGmzG9kameILZkC+mjbHeX2BH9Vpquj2rgAsCsNRGmpZHbIWXa+jkN?=
 =?us-ascii?Q?bOGuJ0r29H8XDMPKDFlOielDLKUHTLRGYFtNgdKcSASd4/P7sAADWIPNEja7?=
 =?us-ascii?Q?la8kHWY6BhdLzJgKTyECw0TmI664wS18yI0v0naTG+OmJJ/f/dwObui0toNU?=
 =?us-ascii?Q?VavfNZhiUZ8Ivv6Ljgotf2cH6PXgv5h/Qq7ok0ykHeGzFTFBbQ/b/YdeagaG?=
 =?us-ascii?Q?Jdfjx70KWFpqQQ0t3HqWgq20HajH4vyuw9drNngqUTIfAaFy//Hyg2SGtrC8?=
 =?us-ascii?Q?RWm2HhHvEF7OM3NVE57O6q40Xh4FRoLWpYooXygHddIYomzWrLb9AR6CQuze?=
 =?us-ascii?Q?wfo2SBkLUhg2cjXkjAHIJcGV7SZ4tMTUqbOQu2olEKG0jyQKFQSPQ1ycKvbZ?=
 =?us-ascii?Q?QiD0PbgMghnUD83/V0fK3NmRJoFyo+OaHxujg3OD1tcmxwz2BuTYPjmRw8lh?=
 =?us-ascii?Q?OLRFyX9unk/q/CGySvVZj6v2eav+LkF97WP9fQ9egfXVTS7emstCzV1jrJQf?=
 =?us-ascii?Q?D1VHI30dtdQDXiToj5v00s8ejgISd8H47ATPqWNUwZTcTQTGAjMnC4M5+fq5?=
 =?us-ascii?Q?uOCLNc2LxwhnmqHXxZq88a57CEtd3NiXkkixLoo3/z1zT/PGDWV5cwEKogBL?=
 =?us-ascii?Q?k3PVPqFn2X9Mavc07qQgzUyOu2MxPbV6qCDUYAAYOJWzTxRfoNk8MvsMlvZq?=
 =?us-ascii?Q?FLgdMfs6uHQ7I+9Kcw/l3igN0xeufH+fsz/A6h2+t4FWmLIOON4Av7QlHjLs?=
 =?us-ascii?Q?IB98eNM4gUL0Cm809dFCxB5LpsQ9WO+RGnEcoV9dhoWnO68BMv74M0C+9C+C?=
 =?us-ascii?Q?9XuehQN4geiVW22g8TPuQ4tpRWPA/X/JAskN3Wi8NWlmml3SI91AUfioQc3q?=
 =?us-ascii?Q?Jx/KUcIVwEnhwXB0y2TRjN8hM7W5mnM1L9kd2PGD/WNpqvVQQbxm5/8Em0/t?=
 =?us-ascii?Q?wMDIVSbR02Gd7m69ZfJevMbx7L3BcAWV3C1ixvj5ODVG8eX8B4hOwcgv8Lvm?=
 =?us-ascii?Q?KtGvQ4qJTqhJF4mfQ+pb/WTMxEDPt2WZHRd2Tta8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f0e992-d7d3-473d-4eab-08da5d978e38
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 08:31:13.3377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ACw87MjHvqDWp4cUbewOnT7tdzYxNKn0AV7SrQXoG3Ub/BfBrFaup3YuMmtn+cUJ/+LsdlcKGIrW1qc90OrSUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB2777
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

> > > -----Original Message-----
> > > From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> > > Sent: Friday, July 1, 2022 3:16 PM
> > > To: Neal Liu <neal_liu@aspeedtech.com>
> > > Cc: linux-usb@vger.kernel.org; linux-serial@vger.kernel.org
> > > Subject: Re: Questions about usb to serial driver
> > >
> > > On Fri, Jul 01, 2022 at 03:16:13AM +0000, Neal Liu wrote:
> > > > Hi all,
> > > >
> > > > I have a question about USB-serial and I hope I can find the
> > > > answer from
> > > here.
> > > > I'll be appreciated it if there is any feedback from you.
> > > >
> > > > My question is If I have a USB device controller (udc) and a uart
> > > > controller (16550) independently in a SoC, is there any usb-serial
> > > > drivers or
> > > applications that could possible to support/connect:
> > > > -	udc tx to uart rx
> > > > -	uart tx to udc rx
> > > >
> > > > Any chance I can make this SoC as a usb-serial devices?
> > >
> > > Sure, use the CONFIG_USB_CONFIGFS_SERIAL or
> CONFIG_USB_CONFIGFS_ACM
> > > build options and hook your gadget up to the serial port in
> > > userspace and you will have a very expensive usb-serial converter
> > > (there are very cheap chips that do the same thing if you want to
> > > make a simpler
> > > device.)
> > >
> > > hope this helps,
> >
> > Thanks Greg!
> >
> > What the detail steps exactly for "hook your gadget up to the serial po=
rt in
> userspace"?
> > Assume my system has:
> > 1 system uart: ttyS0
> > 1 uart: ttyS1
> > 1 usb gadget cdc acm: ttyGS0
> >
> > How to hook up ttyS1 to ttyGS0, so that I could communicate through bel=
ow
> path.
> > PC1 - usb interface - my SoC (ttyGS0 - ttyS1) - rs232 interface - PC2?
>=20
> That's an exercise left for the reader to do, odds are you need a userspa=
ce
> program that just copies the data back and forth.  Try it and see!

Thanks for your guides, I have implemented it and it works well.
The most tricky part is to configure serial port configuration through term=
ios struct.

-Neal
