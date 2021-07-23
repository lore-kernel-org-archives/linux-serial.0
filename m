Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE134C4338F
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 21:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA75960EBC
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 21:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhGWVO5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Jul 2021 17:14:57 -0400
Received: from mail-eopbgr40067.outbound.protection.outlook.com ([40.107.4.67]:9359
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231902AbhGWVO4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Jul 2021 17:14:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WhALJiSBKVCTa3MNwGzFp6WJd4GTB47DFZdUX9CA8avU3E35MOfeXb6NQB9nqm9GkPnUfUeXI0swCCNCKMSISb37yVt5+8YShTfQr3EvRbnR3YRNzfXbZ5XCNeDhtNmnLanq6ZBjdA9nfih4+cEcVq5KadjRuSsN2NMm4FnnMpaHuXl5trGx2EehIG0IYxYm8gK/jWxThFbupX7kTG8DmaMZAJeIYAoa7gL6WKIkmZPNFty4bLybIPS64PMs7zmM7J8FTXJEVXC9GF8RF11O4VnSfG9tBWjNnWUKptW0xqQKrvUSkFipv0vWcXnZ4f1jObtypmVMjt5zCUe2ilde7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSvJrNtakflp4kN56jueQaoM+DPIttIYdWCduXqbSE4=;
 b=iqjASCXMPvLd+f4LAQ95RTOBSsWg80HwafyJFglROu93G6Ql5fJNjraVRKjwHb769EOIKe1fLOHai78Ht+vgBJIQ7qK0c+/6A7rjpCd0Y34A731dDsdRPSKfcjMDogqiu8Gf5Z8DxZ+3hDTxqmIDyFGkUslfcXkIFGrXr8K6s+A01EmqMRgwADnNesvTgU+B+4Zy/d+aC6SkpziQm98Flx1LfJAq/CvnRwN5GzXYiUcVdPj9eRfM4RwPAi6/Qyv2sFu7cjlpys9JjFoqkKAdplCHvdJGLodvgRG83JdrCiawSsukPIn3uPB4uKYnSow7xNVni/ajv9LNd8dlIiHk0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSvJrNtakflp4kN56jueQaoM+DPIttIYdWCduXqbSE4=;
 b=C/4Oq73Zmyzu/AynYcEsjA6JYwScFawcEFh9ltW8m5XOvlURxdoNWDWgO0ocucCieT4L+d3538z8nDu3QVaq+ifprzw8i8Glvp7792oKHat8Y+ND+ezuhKkPdUm9z7q32umWA/pJnoXTEomiXjjxHPh2CUqWE8nU0L8H56njdwA=
Authentication-Results: korsgaard.com; dkim=none (message not signed)
 header.d=none;korsgaard.com; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB7PR03MB3963.eurprd03.prod.outlook.com (2603:10a6:5:38::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Fri, 23 Jul
 2021 21:55:28 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4352.025; Fri, 23 Jul 2021
 21:55:27 +0000
Subject: Re: [PATCH] tty: serial: uartlite: Use read_poll_timeout for a
 polling loop
To:     linux-serial@vger.kernel.org, Peter Korsgaard <jacmet@sunsite.dk>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Korsgaard <peter@korsgaard.com>
References: <20210723215220.624204-1-sean.anderson@seco.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <36a6d163-6c9b-7f6d-8e60-d12f0da2b010@seco.com>
Date:   Fri, 23 Jul 2021 17:55:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210723215220.624204-1-sean.anderson@seco.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:208:d4::30) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by MN2PR04CA0017.namprd04.prod.outlook.com (2603:10b6:208:d4::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend Transport; Fri, 23 Jul 2021 21:55:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61fd9bc7-8834-4ab1-f094-08d94e249532
X-MS-TrafficTypeDiagnostic: DB7PR03MB3963:
X-Microsoft-Antispam-PRVS: <DB7PR03MB39635E516C9A6145EBB49FCF96E59@DB7PR03MB3963.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fudjjUYo5XBcSXD2FHzwwiNcrkE58IrpC/zze8HyPMLV7Smyu9wb/jnDxkZ+6rDSrNtx7oBfvljhTpaM38OHmJFX+VLqk+0nC6vSaz/MTxjVu941Z1Sjb5ty1Y2wZFF1/D4xwFBtJ3AprFmWRzUInpTx2W03bB+zjL4ba5V9BVzjtNnCwwWO3ufmKJS/mexbdhnjdGDUEPBOd7XJ3EdwNi2ahW4YeWxv4d26O32YLihxSCKBWVOTTDYPZWz1tSRMN88XFDLOqzqEymF+4rfdoWwtMEVb9+reVCNIu7Qmc74ur+ib/jTqe8Icch64BJG4687g2G+gowfuV8n0SWZypR4dwF55FRhzNuaRw1pqPq/lBS64lbiYZa/nW1TuFH0L//L2yl0vXPb+Mf4QX943mGr5Uh5H81sv6bV4HYCrdaCyVRVvOWFdV5Mdr9hyiQLrfMaGBWYwqmn8K6HnQSDMMYkBshz5Kns0YX35zD/qmdLguuwvpoFhqCFBeiDBqYCWNNck1pPL/6GLFG7HGezsm8GjPRzjRF+qv0GJ13vnTLlGai08W3MhZ4Opm8zpr9QVBHV82LzjluddUDE9Oj0azRAxUkFkW+/paKQB81Dags6KkY/E5qKLEymLyHZNNlMk7+4MMDAFS3qkk9gf1d/MaBN8IOaGDDJyTIYvPBmR2/tlupXn9eOj0ifvmYwYBMWDUBZBB9/TWPO0bs1LJTLnjZGykFhL5Om5yu7ZTlloB2xsWrUr8yxm3Uh6rNzgjj+J697S34ikmVU1hvfrKlK3Ow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(8936002)(5660300002)(54906003)(956004)(52116002)(4326008)(31696002)(53546011)(186003)(31686004)(2906002)(8676002)(38350700002)(38100700002)(6666004)(86362001)(6486002)(83380400001)(508600001)(16576012)(316002)(2616005)(44832011)(6916009)(36756003)(66946007)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1NrT2xCdFQ0N3FTbE1JZ2RyUk00UHVjbDdRb09kSXJFRkVkUjQ0R3A5TitO?=
 =?utf-8?B?SzdWVzNzb2ttQlYyYzdhNUl0blBzeDlkNUpaNHlOMDRkcFF5dmVJTkF6dWxJ?=
 =?utf-8?B?VTNxWGVocVk2WThHOUNCc3dVNit3VVpWaWJwTG1vRG9oTUFRM0c5T3NBVTJX?=
 =?utf-8?B?QWhCVktkNWFPT3dhQXBqd1krQVZtYitDaFFmSUs4cUUyRjN5cm12b2JMeGhD?=
 =?utf-8?B?M0prUlBMckhIcWptUm5yYWVLTTZtSVlKQzQvcTdhMURZKzJ4QlFhM2xQNFVF?=
 =?utf-8?B?VE9TTlRsYll3ei8vSUd3dFFBNG9tbkhRenVaQTgwTXNHZTd0SkNUbVdaeCtj?=
 =?utf-8?B?TWY0QVpvUlk4bU5NYi9LdmJhRHk3bWhaLzNvMXZGZDF5bjFSejBQVURJQUxJ?=
 =?utf-8?B?ZHppcCtXNGlHdWdaZVl6ZXRSVFVzN0c3Y0hzdTg5UUg1dFZQMTdvbkc4cVZk?=
 =?utf-8?B?WTFHQnQrL21Ga2xzNnFndmhBdG90WEVSOEQ0c0hjQitGVERSVFEzNEZWUERH?=
 =?utf-8?B?NENlUTBPVDJZejhyUW5wRW5CTmZTcmJWVTN0YUt0SFRWcTJTQUxnR09TZktB?=
 =?utf-8?B?VUFFWDNrQ0RvUzAzS0lySFQ5YXBMb2owM0JXQzF0eDdOYy92SGNpdUs1dk1y?=
 =?utf-8?B?c2IvTWpNaXNMQ1FvUkIvb0R1Vjd2QzVuL3RXbTdhbVh1U01ZRmRjaERPNmJX?=
 =?utf-8?B?REllaU5wLzhZZ3ZyMGpPM1Fid216ZFpoRFlyRHA1a3ZkbzgvY0RibmVXaFor?=
 =?utf-8?B?S0YvZnJuVTV6Z1F4eTFZdWlQd1B4OHZDN0lZQ2FuT0k1ZVFudEppcEFRTWhF?=
 =?utf-8?B?cGJDOCs0aHYzcWNMTHpTS2N2QVRWRzBhc2ptYUlnaG8wUU9zMW5QSmVYL0JK?=
 =?utf-8?B?RWppc1llbUF1b2tHZlBXbHRBN0Z5VnRCUDEvMFk1cUpWMkpXUmNYVTB6d2M3?=
 =?utf-8?B?VnZzS3lNeVV3TTNBRml0L3pmL3dBcCtDWStYTVRobFZwLzZPaGFETmFSNWhS?=
 =?utf-8?B?YW1zVlBzdFByVUZGOEplQ2FaMnVsTE9nYmxCaHlpV0JwTHUxQVBBa0ZMWi9o?=
 =?utf-8?B?bU51b21VNzNURzAwa2xjZW90U3JWc1dOR3c0SXk2MFBuMzdiaDVLSXZlVTNO?=
 =?utf-8?B?cUJLYWdKL0R1RWZCVHB6U1JQb1E2L3JITUs0T2piclJBOHZwVG0xSmNRazJa?=
 =?utf-8?B?am45a1Q4dko4Qytjd2ZvaERWMnBQdjFHTE9LT25WSFUxL21Rc3o5bXpaM3VN?=
 =?utf-8?B?MWZDbW9mUUJpU3pjb052cDFuRSttdCtGYW9FbTdmTGZJMjZDY2k1ajFJNWZZ?=
 =?utf-8?B?dllMeGF1UFVHUGltVElQMzV6UzdScFN3RzRjMUxmd1BoMUFFUEs3MDVnbDZR?=
 =?utf-8?B?K0x2d3I3UHJ6RTVycVZGanFHaERSR1pJUE5QbmNWREVnVFF1RlRiQXVzRnN3?=
 =?utf-8?B?UXN6aXpFeWVWQ0hYV2NmU2xEMlhuTlZVVTdydTc0ZGl5YnpYWVV2OC83clh0?=
 =?utf-8?B?bjlWSDFBOHhsVDI1cUVqSHRybnUvOUlEaEZwbWRwenJSUktBMEIveXBzOUV6?=
 =?utf-8?B?SHkxRndGOVNuTmlSV0Q2T2RnNExXNWc3SWR3eit6bWNwWjlBUm1LM3ZxS284?=
 =?utf-8?B?RWpXaUM2VzEyZ2Y4dTVQQ3VEaDM3VkFZQUxKU3NKNVozcjhpMUZMNGhocWkz?=
 =?utf-8?B?Ynl4L1BsS3BYWGlhRXZkaFZxT3NvallnZHN0OExzMzFoS0x6UEJBRXJZRjVy?=
 =?utf-8?Q?A0te4NBQb8RMt3sOfjuLkdfGF+DymNk41ey2x2q?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61fd9bc7-8834-4ab1-f094-08d94e249532
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 21:55:27.9248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6iRwSvtUvnkFyExaOIN3EMarT7jJd7/SboMeqn+xNKdAcHnVKR3OPCMYAmq+UtcIqIq2mBOQMLob43SXDVHb+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB3963
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Looks like Peter's email bounces.

+CC the other emails of "Peter Korsgaard" in MAINTAINERS

On 7/23/21 5:52 PM, Sean Anderson wrote:
> This uses read_poll_timeout_atomic to spin while waiting on uart_in32.
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> 
>   drivers/tty/serial/uartlite.c | 18 +++++-------------
>   1 file changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
> index f42ccc40ffa6..106bbbc86c87 100644
> --- a/drivers/tty/serial/uartlite.c
> +++ b/drivers/tty/serial/uartlite.c
> @@ -17,6 +17,7 @@
>   #include <linux/interrupt.h>
>   #include <linux/init.h>
>   #include <linux/io.h>
> +#include <linux/iopoll.h>
>   #include <linux/of.h>
>   #include <linux/of_address.h>
>   #include <linux/of_device.h>
> @@ -448,24 +449,15 @@ static const struct uart_ops ulite_ops = {
>   static void ulite_console_wait_tx(struct uart_port *port)
>   {
>   	u8 val;
> -	unsigned long timeout;
>   
>   	/*
>   	 * Spin waiting for TX fifo to have space available.
>   	 * When using the Microblaze Debug Module this can take up to 1s
>   	 */
> -	timeout = jiffies + msecs_to_jiffies(1000);
> -	while (1) {
> -		val = uart_in32(ULITE_STATUS, port);
> -		if ((val & ULITE_STATUS_TXFULL) == 0)
> -			break;
> -		if (time_after(jiffies, timeout)) {
> -			dev_warn(port->dev,
> -				 "timeout waiting for TX buffer empty\n");
> -			break;
> -		}
> -		cpu_relax();
> -	}
> +	if (read_poll_timeout_atomic(uart_in32, val, !(val & ULITE_STATUS_TXFULL),
> +				     0, 1000000, false, ULITE_STATUS, port))
> +		dev_warn(port->dev,
> +			 "timeout waiting for TX buffer empty\n");
>   }
>   
>   static void ulite_console_putchar(struct uart_port *port, int ch)
> 
