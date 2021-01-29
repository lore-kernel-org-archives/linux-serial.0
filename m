Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11ECBC433DB
	for <linux-serial@archiver.kernel.org>; Fri, 29 Jan 2021 18:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC73F64E08
	for <linux-serial@archiver.kernel.org>; Fri, 29 Jan 2021 18:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbhA2SFJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 Jan 2021 13:05:09 -0500
Received: from mx0b-002ab301.pphosted.com ([148.163.154.99]:34418 "EHLO
        mx0b-002ab301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231381AbhA2SFH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 Jan 2021 13:05:07 -0500
Received: from pps.filterd (m0118793.ppops.net [127.0.0.1])
        by mx0b-002ab301.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10TI3MdH022800;
        Fri, 29 Jan 2021 13:04:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=distech-controls.com; h=subject :
 to : cc : references : from : message-id : date : in-reply-to :
 content-type : content-transfer-encoding : mime-version; s=pps-02182019;
 bh=LUbsA1Dg9ObF9I6UGJ3sZNvVmIzoaJAJo6LxKeM6Dlc=;
 b=DICbNFR1kuTb2FljoCxNAqEWWkL9KcOV3tY7HrhTvRhrBszRYvplyqXKGtAjz/calxLL
 o5AquECOKQJyKgAUlp8377MQ0FgP1sY4lF4SKi8gqj2Cno3weMA50XHUlqAm6wm6DdZ+
 dGyEpZkT8BJ8iO/5D2sou14GqXy6txoUx2jXma3ylU21RIQ5YJ0tQ7RH3PseAI4mKU73
 dqIW4bSLUOxJjM7E08SGRV5SpGcOIswszDICxq4WDKtl4ejMWi8LWstiVEjvQ9wxSJ7v
 9J+qcVEM3HudTRZQ095Id1wO0j2nyRH9fgYBqU0pyBLuryUucCV2AbAMPswPdG5mSuBn Eg== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0b-002ab301.pphosted.com with ESMTP id 36b3y9jdcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jan 2021 13:04:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOlAEB0tMjrVbblNYYTcHLfDL2n6J/IHIdsZyB4UCdWgK1AJiYczhonA61QH2Jlv4D2xgTDoQpTbqlJVDgEv0dJNBZqRaWTtqZF1MunczEv/ZaiCgJoYcOYRKze9v35DWqemBRZEq+IdWXXXkiQaVCJ0KVyn+1kLRHWsH+AAPL6vD3UjGNDrRug/fY9Ome+g+QDvU1dA7HPz18aXB6bPcLJf84+t2sS+LJcvfGhc6xN10PaO7NfAMpbCz549MlJT9UjamG3wNfWjvHJOU9/4kYlH4Qz/dJ9BQZ1vKShD3AvI/eE3M+bP1xiFmuEsFRiO55r4KkEX7uiobQmKfMZ6Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUbsA1Dg9ObF9I6UGJ3sZNvVmIzoaJAJo6LxKeM6Dlc=;
 b=Ruaal5sQwAJHNvtvk5MQoWEODSey1uUEZiH6UWVhA+LjEPxfW+qrBjvT6JhgnTUwiYsCwybtlt1UehGNl1x1uaO9r7yUCbVhNP5i8mVTYvrj8wL1h0FbFYVCfVOgEE2VRsI0fHhtNLTUAYjBPFdsNBvWPav2UCaxMqNgOr9qcvlOVvvXkE/4r2tzzoRDXl3xWHmqOrEYHinS+zZmQAfBH+D0NlMH5RTxS3DnLAiZxfwx8zZJWoAnzlK5PASGejY4R9iYRbdadnp8LndaG8cgaHt8rmh9bMFSCfFaxjS8wGZzlxBggVSFMQ8qDQ6Yrru+VlHyAERNKiOBiavz0z3a5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=distech-controls.com; dmarc=pass action=none
 header.from=distech-controls.com; dkim=pass header.d=distech-controls.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=distech-controls.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUbsA1Dg9ObF9I6UGJ3sZNvVmIzoaJAJo6LxKeM6Dlc=;
 b=P8kEcbCih18MefyPEwcoK6V4hbcY/USLGNISzCRJeHo9VNgf6h5LvHGrgmr9MJ8GVUYoawW1QsFyzqNxr8Jpb5hvgdt19zlaqrjD7Nqil0yvdBjQKhNDhBIDE0SqRjr19pNeOlOSbbjzSlJVPTGvnepKJ319EGS8HQXrIoUPQZM=
Authentication-Results: theobroma-systems.com; dkim=none (message not signed)
 header.d=none;theobroma-systems.com; dmarc=none action=none
 header.from=distech-controls.com;
Received: from DM5PR01MB2457.prod.exchangelabs.com (2603:10b6:3:41::21) by
 DM5PR0102MB3509.prod.exchangelabs.com (2603:10b6:4:a0::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11; Fri, 29 Jan 2021 18:04:06 +0000
Received: from DM5PR01MB2457.prod.exchangelabs.com
 ([fe80::9de6:ce8a:e281:8e63]) by DM5PR01MB2457.prod.exchangelabs.com
 ([fe80::9de6:ce8a:e281:8e63%11]) with mapi id 15.20.3805.020; Fri, 29 Jan
 2021 18:04:06 +0000
Subject: Re: [PATCH 3/3] serial: 8250: remove UART_CAP_TEMT on
 PORT_16550A_FSL64
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        matwey.kornilov@gmail.com, giulio.benetti@micronovasrl.com,
        lukas@wunner.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, heiko@sntech.de,
        heiko.stuebner@theobroma-systems.com
References: <20210128233629.4164-1-etremblay@distech-controls.com>
 <20210128233629.4164-4-etremblay@distech-controls.com>
 <YBPwlmxNfrxSLK0B@smile.fi.intel.com>
From:   Eric Tremblay <etremblay@distech-controls.com>
Message-ID: <22d98a58-724c-a563-d55c-7c18b5271ec7@distech-controls.com>
Date:   Fri, 29 Jan 2021 13:04:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YBPwlmxNfrxSLK0B@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2607:fa49:6d60:7d00:d104:219a:c8a0:bca5]
X-ClientProxiedBy: YQBPR01CA0116.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::16) To DM5PR01MB2457.prod.exchangelabs.com
 (2603:10b6:3:41::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fa49:6d60:7d00:d104:219a:c8a0:bca5] (2607:fa49:6d60:7d00:d104:219a:c8a0:bca5) by YQBPR01CA0116.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:1::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Fri, 29 Jan 2021 18:04:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 339462d0-bdcc-416d-cd8e-08d8c48044c2
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3509:
X-Microsoft-Antispam-PRVS: <DM5PR0102MB3509EDB93B05053A88D67F0A95B99@DM5PR0102MB3509.prod.exchangelabs.com>
x-pp-identifier: acuityo365
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gxXjkLJJ+1T6NCMEjokOeArMiuBzegp8CuS38vsjBt1QGzQL59mivoZLPBOVg0klKXczdFekeMaDKEf9lGNP5HEa0JHlap2vsm4Pdg3XCggyORjYvWxt3WJAWnNZfA2mS8wwrWiI1R8B3ONYrrseq1a9VzygLGm3bNVzMEfcZQnCzlhAkIIJqJQKBD4+YS7aiGK5A7VPfByrFUeet/E7ZUsuIp85DU2FhhcB8W419vS2WdV6xj13CouPNau8f4s0X0XrTZsijogQ4Dc1pXqYc5LcAsNYjQ3yQ74QuOFO2Tbx308WjWDU/edlmGeL9IGQzkSLP3X067UC03FG4QiQv4ClqXkm/Z1aHrUKKSWwWBzhDmN7AHLpGcn+1pjtzMHS5SofbUHyhhGrSltzrb90xfJvXAD5J1bs7yMQ9T4kbkellysTKEKPXAJsk4tzWTToVLtk3vO1He8K0yp/VAuSGE9PrJ48FiAhHOUSedE5dIn8rFxcQvKlYfGXcFXPmerR2mjqfZ1vkTx+6QNkQcpKTC7N9OifeeteoVZxTo/3sqzrClXN9PWqmVVOn0XU9k6NYZSAfiIWsZQqsnUhT6OccgU86U8+21LS1lnFPZOD49g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR01MB2457.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(2906002)(8676002)(53546011)(6486002)(31686004)(86362001)(31696002)(36756003)(83380400001)(4326008)(66476007)(5660300002)(2616005)(186003)(316002)(4744005)(52116002)(66946007)(8936002)(16526019)(66556008)(6916009)(478600001)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dFY1RTJOaE9iWTVXWjJSQnBFTnhHVzZGOUkrTUMwYVlYTlk0UU5IK2pkbDdO?=
 =?utf-8?B?cWV2bUVreUtaSkpTTCsraktCMXVSMEJRVHVEUUd2WGJ3VVY5TCtPZE5zOGdG?=
 =?utf-8?B?cVZSMnFxdTV4U2x4Snk2VGUxZlhWREEyUGFXc0grVUxXN1pnRmpMczZGWHVm?=
 =?utf-8?B?WVUxdCtHSkhGWDYveURsYVVrdTFzMVdZSVNZTFV4Nm1lTW1NSWNWUENXaG1y?=
 =?utf-8?B?WlA4cy9hWDM0MUYwQndJZ2ZySjR0M3crSEVGblE5VVkvcnBSbDR3cnU2eENP?=
 =?utf-8?B?QkVWcll4TWgxWlpxLzJvRnJ6QVAwWDEvSTRsamJ5Q2hIVVpacXFDNjZUbkNY?=
 =?utf-8?B?VUYrajdzVnd6NWdFVEV1N3FuWXRRdnBNbklLZ3c2YXlNaDYrbm9zZlFtRjEw?=
 =?utf-8?B?eFFXRnUyTmM5U2FNVnB0UEdxTFN3T3NYMnQyMkhnSVhRK2ZpR0phZ0VmZ0FV?=
 =?utf-8?B?ZjJxdVhlaHpVQ210amlWc29zOFloRElFb3YyM2thazl5VEFRUXFueDE4TE9h?=
 =?utf-8?B?MkV5K2c3V0tGNEZyaVBtcU1lQ012NE9mZmZoQVNaMlhwWklHOHFrc1hOMWVB?=
 =?utf-8?B?LzJ6NHRIZ0pnNnlNQmhrV0ttandYZlRNUFUwQTRkTkcrb2tQbFBWb0luYjZY?=
 =?utf-8?B?ZnM2azBBRldvdzB6NHA5S1JFbzZicnAxVjF1cDErVXR3RWZjU05qNFIweHdC?=
 =?utf-8?B?bXRIWkk1R0owM2drVlhFejA5b1FIdVlvdnIybExmcHRiQnF2bitMMmlmZFI5?=
 =?utf-8?B?djVsUzJQUGxmd0MwWXp4UUtoRS9lQ1kwL0Z6dUN0OURvcVY3SVhLc3JGeERI?=
 =?utf-8?B?T0FpV0t5YXVSZS80V2cwdEh1Z0pzTEN3QTFwak5NT0M2WDNZRFlrS3pzbExG?=
 =?utf-8?B?a1N1bEJnblc2WXA5SkdkQVg5UG05dHVKSExvRkRXT0NkZHUxNFgvY2UxVDRw?=
 =?utf-8?B?dTAyN1pFT3hPQ1RiKzdkUzJlRHM0Z2VLcG1PQ0NZVGpidm9qeWdSKzZFaDV6?=
 =?utf-8?B?VklzK21uUEQ5WXg3SjlwZzFITFdRRFUwUlJzWjMzUWQwdlJzMEQwbm1IYnlQ?=
 =?utf-8?B?MHF4amc0VTRGQlFkN3c2aW16SjZuWVc1eVd6dFN3a3RsZy9wUGVJc2hzbzdW?=
 =?utf-8?B?M3E4SEtpVi9ydFR1aXhJY2MrdlBrOUd0bUpSU1c2R2tJS21xV0cyaUxTNDE1?=
 =?utf-8?B?MUo1aU1pOS9xeUZDclVLYXFEVU95M0crNFhHMk44Mkg1dXJzNEZzMnNFSlFW?=
 =?utf-8?B?MUdHczM1K0QvbkowU0FVbVdGTWpSSjEveXZDNkF6Sks3akRpSDZBYWhEVkJh?=
 =?utf-8?B?N2dlR3lNT0x5OVBYdHJ4T1JuR00zZWV1dGNaM3RZUG52aVF5UU96VW1nbThW?=
 =?utf-8?B?WXA4OWFvZU9RQzRGRkZPUlpCQU1hN3krUmVQY08zSGZPL0RvS3ZaTmVVVmFO?=
 =?utf-8?B?QTZuUFRaMDhxYWxTMnBMaVU0MStFRDdsTzZ2cG8yN1pLQ1M0eFRsYU51R2o4?=
 =?utf-8?Q?5lT6MbsI6Yv/junDsPN+w3eySgN?=
X-OriginatorOrg: distech-controls.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 339462d0-bdcc-416d-cd8e-08d8c48044c2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR01MB2457.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 18:04:06.5078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: caadbe96-024e-4f67-82ec-fb28ff53d16d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dXDw6Ho89yaKfRFDKxSkA4ehwuZDJPOO8Am84oFGa5EpW338v33sn3CioN73x+gtlXIHdKBkk3o9PDERA+O5Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0102MB3509
X-Proofpoint-Processed: True
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 phishscore=0
 clxscore=1015 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101290089
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2021-01-29 6:25 a.m., Andy Shevchenko wrote:
> On Thu, Jan 28, 2021 at 06:36:29PM -0500, Eric Tremblay wrote:
>> That port does not have an interrupt on TEMT when using
>> the FIFO mode.
> This is wrong.
> 1. You have to guarantee that TEMT is set for all UARTs before this patch
> 2. World is not staying on OF only platforms
>
> NAK

Considering the use of the reversed capability UART_CAP_NOTEMT should I set
the flag directly in uart_config like:

[PORT_16550A_FSL64] = {
		.name		= "16550A_FSL64",
		.fifo_size	= 64,
		.tx_loadsz	= 63,
		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10 |
				  UART_FCR7_64BYTE,
		.flags		= UART_CAP_FIFO | UART_CAP_NOTEMT,
	},

>

