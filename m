Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A6DC4338F
	for <linux-serial@archiver.kernel.org>; Mon, 26 Jul 2021 20:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64D5060F5D
	for <linux-serial@archiver.kernel.org>; Mon, 26 Jul 2021 20:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbhGZUNS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Jul 2021 16:13:18 -0400
Received: from mail-db8eur05on2073.outbound.protection.outlook.com ([40.107.20.73]:14129
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232959AbhGZUNR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Jul 2021 16:13:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0/RuI2j6xQhLpbQLVf6GBNlPqDhW3oYpu/C77tT/85BCF3rjsQxC3PIw4a2cnWX0C33KWJO8JkryfwJ6CdSd+2ieV9QYJ25Rr+M1sVWDcIzLrWmXPMfcQt/oxVSKzWcAwLKz3HsTqbBkFz7uLrwRcgMJREJPXlXoaQCGlvQVbzEw9JtZk6dldONJH9vi+CGJX1ePxXFKGOTZysB3bXNCWyF6+AB65ftOD3E6WGwSZsVElnFYgXk8kN4CvDNzq2/SXwFiKf8VQ+8MZVjqQ5TilunmTcKM7K7/stiTGVuO7CKLiOOXYCnUCrYr6XfIQUd3q8ZAAlH6+NEIUWRKe5u0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V22QFDoLdEDg39uXwKQ7MBRZOLuu3l5wFzKNCHp7V9Y=;
 b=STwZ8g2JCDE877FYf5dAc+gOkIanCITNWcKw/U/R2iSLYEbbXJJdpvkHS/si7eJ4QX2xjO71wTF5f2ucDreJBu6EHofxbhSUTD4UhtEgM24FyfRwXZUWBitD9gelH7QFZEqyoMRyNhe86A57Q7ZuQF37STP1I4jUU/W/33C/JkIvi/Ub5RPEQeOfkV8QOxuKNRczwon6NmH6ODplQs5Fur8GR/5gsPeJxiY4J6hxtNQ14QmvnDMDRkM4LdvXevPgoiO8LMzqyzKmU2ooyFF7TOnqT7FEsMY3833bvxWrXJ0ulG4l/jU5skNP2fHO7U2vg6sJWocZvL52vvnmKNNxYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V22QFDoLdEDg39uXwKQ7MBRZOLuu3l5wFzKNCHp7V9Y=;
 b=jeu4g8K2v307sMSXkqGtnrx5qcMzmU5aMGituVhoBGAn2q0K8xU3qZVKtzwecmpfoWdh2dXVCJyWwEU3LDY5SKozoj7wVqXswC3f3or5NcPHvxdrUZAG0BbIRgpGyV6mQM/KOd53TstHNswVq+yQHEJxH5lIAfGWroetUNudsVI=
Authentication-Results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB9PR03MB7515.eurprd03.prod.outlook.com (2603:10a6:10:22a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Mon, 26 Jul
 2021 20:53:43 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 20:53:43 +0000
From:   Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH 4/5] tty: serial: uartlite: Initialize termios with fixed
 synthesis parameters
To:     Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Korsgaard <peter@korsgaard.com>,
        linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Michal Simek <michal.simek@xilinx.com>
References: <20210723223152.648326-1-sean.anderson@seco.com>
 <20210723223152.648326-5-sean.anderson@seco.com>
Message-ID: <302ea0f9-6e61-ee8d-eb40-63f3bb81a278@seco.com>
Date:   Mon, 26 Jul 2021 16:53:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210723223152.648326-5-sean.anderson@seco.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0027.prod.exchangelabs.com
 (2603:10b6:207:18::40) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by BL0PR0102CA0027.prod.exchangelabs.com (2603:10b6:207:18::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Mon, 26 Jul 2021 20:53:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ea32601-3b75-4f2a-e0bb-08d95077746b
X-MS-TrafficTypeDiagnostic: DB9PR03MB7515:
X-Microsoft-Antispam-PRVS: <DB9PR03MB7515D7B3605E7646CA2F7B1096E89@DB9PR03MB7515.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pc8JutcyFs+muGcBIOfX9m1XYg/nI0VFQngM1gvNX9UYAkidkvdw2yF//dCVPD6nLiaxLh23wqAtf4Lonst4GIZXCn7Bzdc0qBlrxiO0MfcnBX8A/DHKWfoT/bXY6eGB17ljdjN+l+PeERz03cGq2N98zdCgceNHQ3/XM0nJuD86Q7ZM/jW1h+GTuqk2qw8p906tcECIqJ6m40XC7OjHp5Ld4+HvIfQpH0B0WuudTPab1ALkXry1EBRud5T4tDrsrgamcxEU/Ox6dHq7v6sgA0JhYUo8h0msdZ2TeTAZWDoRRMdOjMfc6+XHDK7yYhs2XLvZAyjI2N8D2cMWXCGszFi3MPwcrdVYGyoIiwmbiyerLEKyPM0mgzM/vYd2vPKteokVwSqWrEgJeDKOeLyYTRL4+FumCIOTVL5BWcCthhe7iy4g9j/VBi8ssAKGhbkfuJ4wkj8nKkJLRiQee6LbaeQuZYtxUYk6tkuyP2DCI4l5tGmokRDCLI0868PQJFUYBW3noCPnCCovjLVHfsRlp4Lt7sCMOTZpv2sS+rOgInulEMzv9KRpYjOLQMeIRNZ32NRUxvSLyif8OfFk+DK1dXeTtQ60/WsRTK11RMQiqRmb4vDIsVsmFPTsqbBvAp14CN2v9RfSDYcgKLJu/TUg2PwHmoV65ANOvak4uF0eq1aG5AIvjTx5XCXcZLjrYb+Dh5TXwr6LcIXOl0MkDXiOWZmPHUYtwzd9ylSAMbQEDLM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(136003)(39840400004)(396003)(2906002)(52116002)(44832011)(478600001)(2616005)(66946007)(31686004)(36756003)(53546011)(38350700002)(186003)(38100700002)(956004)(8936002)(26005)(16576012)(8676002)(110136005)(54906003)(86362001)(5660300002)(6666004)(66556008)(66476007)(4326008)(31696002)(316002)(83380400001)(6486002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TC9vaEQvamNueUNReGswRTUvdithWEVjY1Y3TlFRUDdsUVBpaDVTTUNJWjhO?=
 =?utf-8?B?dmJKOU83NkZSV3FTeVQ4TmZ4dytVRUlsVHc2MURzRGpQeERLeWY0Q2hnMXFR?=
 =?utf-8?B?aVB2MUVZR1dDd1NqUVVWbFdnd1M4cUxqNGxZZTVtYWhQYW8rVUpkeklUTldu?=
 =?utf-8?B?NWJuSGVMZkgxYnEvQWdGREtQWXRESmo4MzNxRTVZVEZ4RzN4QzREK0JKWmd4?=
 =?utf-8?B?TjlGbzNwOVJTZUsrU29JNG5iUnpuNGNkL0gzUmM5bDdaR294TGh2UGZ4dlNq?=
 =?utf-8?B?aXNSTVh1V2JUOEhhYzVmSHMrMTdZT3lQN2hiOXdJamlDTHNHMk5HLzJUVXVk?=
 =?utf-8?B?TkVTUzdzUGc3NlZsV294by9WeHdUMUV1S0JrK0c5bUFlVUJhNlhjUVVHRnZQ?=
 =?utf-8?B?N3FTd0drcTR0eEFCcG9rNDVRd0FBNkZPcmdpd3I1WXZCbVR5eE1icndWMkJD?=
 =?utf-8?B?SlMwcElTamxubU9xeFp4S00yQk1xNUNEbmM5dnRjK3BydjFnY0dWeURCMWJt?=
 =?utf-8?B?bE9ZT1JRT1Q4MzRXTkZnamUvNEhzVXNyTFY2OGZrRkdRT1pwNlJVWUlpRkxy?=
 =?utf-8?B?eC9aamdjMlNNZlE4M3M1T3NzU1BiVnFOVUxJVGJQdGJkcWxKbEI1eWtmZTZn?=
 =?utf-8?B?ZVZSSnJPWFhMN0N1VE0rdkRJZ0JkSWRZejBrRU1BUnhPR20vWHgzcVhJYXFx?=
 =?utf-8?B?WkZ3R0V3dS9GMHpKSk8vSmVhQi9icFBsckpHZ21wR2dIQmNaOG9jT0dhYVh4?=
 =?utf-8?B?ckltTXNGeCtXS3IrUXJRWmY1Qlg3RlRwMmZpWFg5cFJmazhPT29rSGkyTFhR?=
 =?utf-8?B?eHBZL2FNekE5Y2kxV21sc2hDeCtsdFFFaUs5dmx3Rk4rejhJY3FCUlZFYllW?=
 =?utf-8?B?T1JaS1pLbEtTMnFOb0gzS1dPQzIvTkJML2ZvT1Irb3VmeWhCYmNvQ2IxRE1F?=
 =?utf-8?B?NlNiZ21PNmFqMlhKZEtwN1B6aWVFR2FDbHo1ZUFNdTI2bFN5SUwySzFhcS9a?=
 =?utf-8?B?bmZRRmZ2cGpiczlwd1E5ZzNmWnA3RWZLZCtUS3dUZ2tKZytVdXZmSk5EMGMv?=
 =?utf-8?B?NU00TGZVZmZPNlJONTg1U2d2TFBjTzdBcllvM0syRDg5Z1pDTVpvclNFNm1V?=
 =?utf-8?B?dDl4U3hBSHNsS2twRy9pYjRBL1BSeVhVQ2xOQ0NCZlR1d0JTNnlqZlQwQzV5?=
 =?utf-8?B?UUc5Si93SlViV1UybVQ0Q1dJUG1hNUZqemd3T3Y0MmhqTkYwMnl4STRPL1JT?=
 =?utf-8?B?WFRlVmZrbEZYQXZtQWlWQWJuOUlHc2xkcVhuSTNrOHo1L1lWdXlLZGJGTmp4?=
 =?utf-8?B?QTdWYmYwOFZwMGd5QWN0RTB6SENzMEVpSGtkdUJFZ1JxWmZrWXJNRGliQjBt?=
 =?utf-8?B?R0dBdDJOei9IaHZ5QmlOQ0dvNVR3RWtwbnpqdkc2dlRmMVJYb3dkb2ZzWG1x?=
 =?utf-8?B?T1htamNadjZnZWk1bFAvak93ZlhDNDRZTWZ2RElaNDZaMW90LzVnSDBSc2lv?=
 =?utf-8?B?S3ZPdHVCMXU2aSt4TG9PaWRFRTVCV3hpQ0l5Z3BhVUJENGc5NUpYQjZGWlYy?=
 =?utf-8?B?YWZqcTRYTCt3dGlMdXBhcm9ON3JQeVRURVhkWEpWME5hNitnc0YxK2hjWEov?=
 =?utf-8?B?R1JtZHBKbXRkdVVXaHRERnVLTncxVnlwTEFhNmJDVldKMGNyOXZrTWNoSkdo?=
 =?utf-8?B?Y2FCTU45ZC9ydk1LdzJkNkg0UVU1UTdza2F0WG1jVEF3NWFjRTVMT2l1Wncw?=
 =?utf-8?Q?K2RkXs/uGeUi3OlZ6KwRanhjrmOkXkeHv353ZfX?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea32601-3b75-4f2a-e0bb-08d95077746b
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 20:53:43.5342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yJiKAn8r75v7L7zLZAsZrE7AtzrXKNStgeHKETsdAluxC2Oi8ZRcR8wtDvzVIDCQI0nLncY6aI9W6Yfp30QUBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7515
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 7/23/21 6:31 PM, Sean Anderson wrote:
> This reads the various new devicetree parameters to discover how the
> uart was configured when it was synthesized. Note that these properties
> are fixed and undiscoverable. Once we have determined how the uart is
> configured, we set the termios to let users know, and to initialize the
> timeout to the correct value.
>
> The defaults match ulite_console_setup. xlnx,use-parity,
> xlnx,odd-parity, and xlnx,data-bits are optional since there were
> in-tree users (and presumably out-of-tree users) who did not set them.
>
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
>
>   drivers/tty/serial/uartlite.c | 66 +++++++++++++++++++++++++++++++----
>   1 file changed, 60 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
> index f42ccc40ffa6..39c17ab206ca 100644
> --- a/drivers/tty/serial/uartlite.c
> +++ b/drivers/tty/serial/uartlite.c
> @@ -60,9 +60,20 @@
>   static struct uart_port *console_port;
>   #endif
>
> +/**
> + * struct uartlite_data: Driver private data
> + * reg_ops: Functions to read/write registers
> + * clk: Our parent clock, if present
> + * baud: The baud rate configured when this device was synthesized
> + * parity: The parity settings, like for uart_set_options()
> + * bits: The number of data bits
> + */
>   struct uartlite_data {
>   	const struct uartlite_reg_ops *reg_ops;
>   	struct clk *clk;
> +	int baud;
> +	int parity;
> +	int bits;
>   };
>
>   struct uartlite_reg_ops {
> @@ -652,6 +663,9 @@ static int ulite_assign(struct device *dev, int id, u32 base, int irq,
>   	port->type = PORT_UNKNOWN;
>   	port->line = id;
>   	port->private_data = pdata;
> +	/* Initialize the termios to what was configured at synthesis-time */
> +	uart_set_options(port, NULL, pdata->baud, pdata->parity, pdata->bits,
> +			 'n');

I did some testing today, and discovered that the termios are not set
properly. I think I missed this the first time around because on
Microblaze QEMU this UART is the console, and the baud etc. gets set
properly because of stdout-path (or bootargs). However, uart_set_options
doesn't actually do anything with the termios when co is NULL.

The initial termios are set up by tty_init_termios (called from
tty_init_dev). They come from either tty->driver->init_termios, or from
tty->driver->termios[idx]. There is only one init_termios per-driver,
so we would need to have multiple drivers if we wanted to have multiple
UARTs with different (e.g.) bauds.

The indexed termios are designed to keep the settings from the previous
time the tty was opened. So I think (ab)using them is not too terrible,
especially since we will only set them once. Unfortunately, we cannot
use tty_save_termios to initialize the indexed termio, since the tty is
not set until tty_port_open, which is called after tty_init_dev.

Based on this, I think the neatest cut would be something like

/* perhaps just do this in ulite_assign? */
ulite_request_port () {
	/* ... */
	termios = &ulite_uart_driver.tty_driver->termios[port->line];
	termios = kzalloc(sizeof(*termios));
	if (!termios)
		/* ... */
	termios.c_cflags = /* ... */
	/* etc */
}

Unfortunately, according to include/linux/serial_core.h, tty_driver is
not supposed to be touched by the low-level driver. But I think we have
a bit of an unusual case here with a device that can't change baud. If
anyone has other suggestions, I'm all for them.

--Sean

>
>   	dev_set_drvdata(dev, port);
>
> @@ -756,18 +770,58 @@ static int ulite_probe(struct platform_device *pdev)
>   	struct uartlite_data *pdata;
>   	int irq, ret;
>   	int id = pdev->id;
> -#ifdef CONFIG_OF
> -	const __be32 *prop;
>
> -	prop = of_get_property(pdev->dev.of_node, "port-number", NULL);
> -	if (prop)
> -		id = be32_to_cpup(prop);
> -#endif
>   	pdata = devm_kzalloc(&pdev->dev, sizeof(struct uartlite_data),
>   			     GFP_KERNEL);
>   	if (!pdata)
>   		return -ENOMEM;
>
> +	if (IS_ENABLED(CONFIG_OF)) {
> +		const char *prop;
> +		struct device_node *np = pdev->dev.of_node;
> +		u32 val;
> +
> +		prop = "port-number";
> +		ret = of_property_read_u32(np, prop, &id);
> +		if (ret && ret != -EINVAL)
> +of_err:
> +			return dev_err_probe(&pdev->dev, ret,
> +					     "could not read %s\n", prop);
> +
> +		prop = "current-speed";
> +		ret = of_property_read_u32(np, prop, &pdata->baud);
> +		if (ret)
> +			goto of_err;
> +
> +		prop = "xlnx,use-parity";
> +		ret = of_property_read_u32(np, prop, &val);
> +		if (ret && ret != -EINVAL)
> +			goto of_err;
> +
> +		if (val) {
> +			prop = "xlnx,odd-parity";
> +			ret = of_property_read_u32(np, prop, &val);
> +			if (ret)
> +				goto of_err;
> +
> +			if (val)
> +				pdata->parity = 'o';
> +			else
> +				pdata->parity = 'e';
> +		} else {
> +			pdata->parity = 'n';
> +		}
> +
> +		prop = "xlnx,data-bits";
> +		ret = of_property_read_u32(np, prop, &pdata->bits);
> +		if (ret && ret != -EINVAL)
> +			goto of_err;
> +	} else {
> +		pdata->baud = 9600;
> +		pdata->parity = 'n';
> +		pdata->bits = 8;
> +	}
> +
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	if (!res)
>   		return -ENODEV;
>
