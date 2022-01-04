Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79270C433F5
	for <linux-serial@archiver.kernel.org>; Tue,  4 Jan 2022 11:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbiADLNL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 4 Jan 2022 06:13:11 -0500
Received: from eu-smtp-delivery-197.mimecast.com ([185.58.85.197]:60858 "EHLO
        eu-smtp-delivery-197.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231834AbiADLNL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 4 Jan 2022 06:13:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1641294789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SaDlHuRrE1D62dJdx28vWq9YCkix74QNxMk7J+d4hNE=;
        b=Cz9vqTQGRClhRwZX9W0O8bS+Od/I/FBynmsOxerrt3HBdrxw6VEFqASo8PnlmyWDyBmtwY
        KGuWUDhF6hp6kHyz09HpGeB4TFRodnJYk4SpeGOvq2aEJL4q2pdmcytmKIDx/Yk2+aX1sL
        ntHrf0dYD/kW5hlUKgLIXj8BY0jCM78=
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2059.outbound.protection.outlook.com [104.47.20.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-230-n4zLgd-pNKq4U0gRU8j3lw-1; Tue, 04 Jan 2022 11:13:08 +0000
X-MC-Unique: n4zLgd-pNKq4U0gRU8j3lw-1
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:16b::6)
 by CWLP123MB6329.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Tue, 4 Jan
 2022 11:13:07 +0000
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4c56:90c1:1ed:2ea3]) by CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4c56:90c1:1ed:2ea3%4]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 11:13:07 +0000
Subject: Re: [PATCH] serial: imx: reduce RX interrupt frequency
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        k.drobinski@camlintechnologies.com
References: <20220104103203.2033673-1-tomasz.mon@camlingroup.com>
 <YdQndwYc9xaauvpS@kroah.com>
From:   =?UTF-8?Q?Tomasz_Mo=c5=84?= <tomasz.mon@camlingroup.com>
Message-ID: <7e509806-77ae-8f94-2563-7dbae1ebca17@camlingroup.com>
Date:   Tue, 4 Jan 2022 12:13:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YdQndwYc9xaauvpS@kroah.com>
X-ClientProxiedBy: LO4P123CA0121.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::18) To CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:16b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0aedc74-3122-4e73-a511-08d9cf732fa9
X-MS-TrafficTypeDiagnostic: CWLP123MB6329:EE_
X-Microsoft-Antispam-PRVS: <CWLP123MB63297E1DBE69DA2D0906222D924A9@CWLP123MB6329.GBRP123.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: y7N8MQffyV9URcJtJPcjv/zcpaYikFicVL2b/7PPrNVMfevKdEW6xsdNNQvI6jG+n8MnetzidlvGFIRCu28vmdk/dtZrRmC8kpoeEZi9rnogH3rhGpLPBDTvwaR+EkEAYsXu/rx3g+Odb+b+OPZvyr10PVkvxshaZVUxqqw63LmqsdFLTuL3TsIuFKYsRbDhoeu0qXKxGuBCQysPpQPLAKuQgXS99AjDUHI8A2SVR4+8m0Fh3an2uV7DDBiVmesvKFm3qFPt910yxpk06ggYSRD+s42ruHYg3MTVf8KrvGXrykoU//AF7GJbVoXP5vLQg0dFiHFNzrNHJgeq1oVyJYhYQu4HyzCwaYr3akrtcjQUYjXzsSaZ3LUjwvCigwc8ssvkdW+cMPAP2Ap5ayUngpwWbZGpdw6g2BOb39Iiuh9PWaB52RQ0k/SQw38Rd9VkChw+DYfxRIr3RJgf1Hgv0cQ4RJCF6rclIgPxA79xSWKBklGyyoIUR1YGPQFNDshaMJTWuOZRD7OwYnhLUdl1lYu/hJCtII9STibbYDv93KeE1THYyHb1RaXl0A+4fEwmbm1nXldOqLUSnbK6n439ggIngsYADK6Re4fU++V8hqxOuEI55LpaEVHXAdeK4agIAyrg7K6wiFuPemT0LDSpJWS1JCT0GxwcwjEVK1/Nl97G7v5UioK7+1lct2AtKusvR2ipOS3jnDOnIakw8Sbz8j/kDEg4cKCNMlv3lQfW/bl0lcYzNu/BHgFbwFvBvKggHdK+qlRTg7hna4YQ8Jn3Kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(4326008)(36756003)(5660300002)(8676002)(4744005)(508600001)(6486002)(38100700002)(38350700002)(186003)(8936002)(2616005)(66556008)(66946007)(107886003)(6916009)(86362001)(6512007)(316002)(54906003)(31696002)(26005)(52116002)(53546011)(6506007)(66476007)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjNvWWpzN1krQmEvSkdDYS8xeDA2UFoxTVFvWHh3YS9meGczZC96cVIwWWo3?=
 =?utf-8?B?Y1RwdURvRHhXMmx3VkRmTXRHNmZMczgycHBpVzhjSHl5clJ2THJkdTh6Nk16?=
 =?utf-8?B?K1ZxajlOcEp5S3BMUEpSM0hhUWl4RW1DUHpFeHJ4YnlBSk8zQ2VNNUJJVTNE?=
 =?utf-8?B?RitCQ082V0VEWDIxQndTbHVDOEx3VHloWnFvQjNHMExLOGdPTjZaR3ROSmdC?=
 =?utf-8?B?ZTlUU25COXUwL1hoQ1pxM281SVhIWVQ3Wnl6cHBsNHhNdTJkdUtKOGp4dGI2?=
 =?utf-8?B?ekRrV0pBYVhQb1JZTlhTc0xhU1V3dkRuSmh6dWViaGw2K2tmODg5QWMwRHo4?=
 =?utf-8?B?dDZ2cnpMZ1RHSUtQbnRva2FETzd0cGhUa0tkSlpQK1NvemtzVU52eTNZOFhR?=
 =?utf-8?B?SUNFMlRXQVFoQi90L1hadVRIQ29DWURUQ3F4M0xEaTFrbTdOVEVEK0lzWkNr?=
 =?utf-8?B?eHY5bHJ4eHcvRThqMTEwQXgzTFVWNStvNVJ0TzBuaE5iZ3JaejFSM1VIRWo0?=
 =?utf-8?B?TDRaYU9QYTUrMEFBdUNHVVEyQk5jV0dNeGI1Rjg5TW5RMVlmcnVIY3RPblJX?=
 =?utf-8?B?RkRBK3N4RHBHTGoxUHR5QzRHZFRBYm93N0taZUJucDYxc3M0emhCaEZXZ0t5?=
 =?utf-8?B?SisyR0w2ckZGSmlDTjFxeWJDZnk0QjNRblJBeWY5VkxmdWFMbWxVODN0TStD?=
 =?utf-8?B?di94SjdDNE8xVG1pdDYwc3JyajFRSVZGQWNRQS80K3lPYmtvQzVTRUF0NzRm?=
 =?utf-8?B?SlQzazlRcEhXVG9qSzlsK29XNnlVbVI5VGlWUDFKcWtwUHFYa09YRkZGUGtX?=
 =?utf-8?B?YXpnMjBvTkhQd3B1ZVN4MThteWw0UVJHbTVGSzlPYzN5T2VKZnZHaG9hTTdx?=
 =?utf-8?B?S0hYSnNvYjIyUzZIN3graTMxdkJLYnl1aW84R3dEak0yZ0lqbzJOUHNpNnhk?=
 =?utf-8?B?RUZMeDVlbHJLaWxUSGlmb1dCdmNqR1lzVjRlYzZoRHBnT2VwUndMWVhoTHJJ?=
 =?utf-8?B?NnM2RCt2bDFDbGlLbURHMjFwWitad2hVcFR6YkQ1d0wrVXdHbWp6OWRSUkJj?=
 =?utf-8?B?YlZTWGtaVTdXeldCQmk3WXFGKzdOS09JZHlrQnhGSjVaK2lZVUZsS1JDbkVq?=
 =?utf-8?B?YUJ1Y3Q1cjIyT3NjeXVJZUhZdGZzVnRVeEE4T2tvSHNXYjRhU1orRUtLcGJs?=
 =?utf-8?B?eWVzaFVtSTd3VmZzRnpQVmYyQ1FHd3pZM0lpdU84b3RlVDMrcVpUUC9WTzJj?=
 =?utf-8?B?SHN5RkRPUFF0RWxYWjBvaVAwUjI1eTQyK2RTRWUzNFpDWG5weHVod2tLdlBG?=
 =?utf-8?B?SnJmOVcxZnJaamxRS1ZRSkgvcWxtNHY4emFKM3JRaHRGbm1oUmYxbkhoSXRn?=
 =?utf-8?B?UmY3a2E2a2pzREdFRTA1UTdiVDNTWms4M21vWTZ1TGNRbVdZYU5DQWc5eStY?=
 =?utf-8?B?UGV4SHNIZ0xrelNDKytqcHF6Y1F2VG8ybXRrb2E5TG82Y1dhSnJ5ZUpVTjFw?=
 =?utf-8?B?Yk9IanJjU09xSDZaajlKeGJKekNxUHFOUFU1M3ZVd3NINWhSVkFrVmhCWllR?=
 =?utf-8?B?SHJoTis0bUg5QVNMR1k5ZU5iSTZWb2R3eFpxR0ZvQjN1UHlsM3lyMEg5UWxB?=
 =?utf-8?B?MDVIODdHZG1jMmRPcGFmWkpudHUrL1Job3RWK0V0VmpJTGtmRG5KV2pVTGhk?=
 =?utf-8?B?b3hNb2hNcjlXdGkzMC9ZRjFEWnZFQnNDMzBQbldNTkpXdWpxd2duUllwNlRR?=
 =?utf-8?B?OGJDMVNXSmtmLzN4THJmajFQYmxuWkJGa2thU1c2ME9oZzB3WHlnNXM2TjNB?=
 =?utf-8?B?WDRLbVZPMzM2T0xjSEM3U1cybWd0NHlzZEtLQkNqbExEcXFISGdGMlYrUS8w?=
 =?utf-8?B?aTVrRVR0TllWUFVqTWtPbFBtcnp3Njg5d0ljRW82d0FoVm1UelhJNWl3dlNq?=
 =?utf-8?B?THk4TGprNmxFUjF4UnlUbEhzblI0dktQRXRNRENvR0NyQWpDcDBJOHFMdE9L?=
 =?utf-8?B?dHhhYVR0WEhtR25DdzNBT1J2emNKNzJnWGJTRFZLVXpVNUV2ZUFlQnJCOVFR?=
 =?utf-8?B?TlVWRFV4cnptVEttR3Z2MjVwTTFpM2hPc1hvaHY5ejlFSmhqZk9pUFBrOXgv?=
 =?utf-8?B?cjJqNzdja1ZCSTB5S3BEaDQ4TWFzVUsvYmhhWnhYeFh0OFlkTUxsWU5Fa3Zl?=
 =?utf-8?B?SFpTZXNub3Y3eVB5U28rRmIwQ1VlQ0dzM2dva2tqRnVKREdHcnUrdy9qWlBx?=
 =?utf-8?B?NTFSWWZSYVpsUW1xMGdsTVg5SXh3PT0=?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0aedc74-3122-4e73-a511-08d9cf732fa9
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 11:13:07.8408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qt7V6zLjFMHaGSz89JGuDlIc4mWf4EtG6lUjKpYf+vVLzdM9vMDBTGDS0cfCDFvIdcIs3rbMzackD/rBayvfxooEqz+lK4BED2LUohEd59I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6329
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUK97A341 smtp.mailfrom=tomasz.mon@camlingroup.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 04.01.2022 11:54, Greg Kroah-Hartman wrote:
> Why can't you do this dynamically based on the baud rate so as to always
> work properly for all speeds without increased delays for slower ones?

Could you please advise on which baud rates to consider as slow? Does it
sound good to have the old trigger level for rates up to and including
115200 and the new one for faster ones?

Thanks,
Tomasz Mon

