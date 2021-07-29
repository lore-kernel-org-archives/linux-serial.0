Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CC1C4338F
	for <linux-serial@archiver.kernel.org>; Thu, 29 Jul 2021 15:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B441F60F22
	for <linux-serial@archiver.kernel.org>; Thu, 29 Jul 2021 15:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237314AbhG2P1K (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 29 Jul 2021 11:27:10 -0400
Received: from mail-eopbgr20071.outbound.protection.outlook.com ([40.107.2.71]:60548
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237531AbhG2P1J (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Jul 2021 11:27:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QS1VYYIERXD87iteIxkNE3Wof0s/+Yhn5diKQauFzqlZMcnG/vC4P+QdORly6Ya3VHhrsfupQbWez//lCpufb1le5rLWyXBr5UqgYtDAW+5sd3gh01dO3uyTMd4jwfYajiWro1Me+UKYwdzGWD9DkHSxERA151zJ9JNSn5ErZKQH/PqVA4TGTi0shimDxfyDRUZ7bBAtJJ51ayl1KcsM0XiMokKXTH+aYcuufF1lz2nwH6Q5AcXnRjB611ZXVooMv3y6GpmZs5lzTA0U20HfxyAqPkDyQ/gvPvh0CZhhdFI4WC7bUz0urcgwCfBACPlU/6qgOK0DdAabQ/CF934QNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlCT3T8pLsHS2hYAYHYVSN2V50lGRn/HyCikpyjjFZA=;
 b=f8v+nhtNwOB6xyPPUC4NsFO42kH7967J1NpsQEclWbVMSh+MNKh5S/0O4LSURd8Tq1KqUGsJALYCI1K3feJeMApVOO1BNFuxTcmX6NDRf1zkzaNbqwM+Ug/eFbZDaRQKU9c1+DBqQ37HZeQpgD8dG1SJPyROentyRqbRMqa5LDiNwG54PXvFTEGSeFhJ+MTr/lrnva68uxtCoiydyqoWJB379H1I0Lcj8HZ39WdRMetpQdOyFqnxdIZ2zJ+wHXrIIhBbe6plAXGsn1tGXqv6OligJWk6yKZ4AyUxsbVl9eEHNr43L0+mUA3k5pjw9ppqwm/o/YlUofQG6A0hDP2IeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlCT3T8pLsHS2hYAYHYVSN2V50lGRn/HyCikpyjjFZA=;
 b=OSFwqjkrkPb7noYSQbDewBJXQ8JEzRz90JDTmUaEwZ1Zf4OPI5vTkGb3FXuirB41GlmqOS3Cw7t8WaO4Vj4MPAog5Pq4ap/3/4ov8gRLpsfPiQpLfRE/FKotFC8FtQWtYKQnn8jMyVsHU9A011jND2gMk63RAlee31HjQ0Nkr/w=
Authentication-Results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBAPR03MB6408.eurprd03.prod.outlook.com (2603:10a6:10:194::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.31; Thu, 29 Jul
 2021 15:27:03 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4373.018; Thu, 29 Jul 2021
 15:27:03 +0000
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
Message-ID: <d46e0a4a-d9d4-190f-b41b-9c2b9e4748ae@seco.com>
Date:   Thu, 29 Jul 2021 11:26:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YQLC4L2Z3T4SuryE@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0285.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::20) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by BL1PR13CA0285.namprd13.prod.outlook.com (2603:10b6:208:2bc::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.10 via Frontend Transport; Thu, 29 Jul 2021 15:27:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3da0ef14-b7bf-47cc-225e-08d952a550db
X-MS-TrafficTypeDiagnostic: DBAPR03MB6408:
X-Microsoft-Antispam-PRVS: <DBAPR03MB6408B825AF30A5BA94B3250296EB9@DBAPR03MB6408.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OAw3SlmVprO50KYLVLVIPDbqr21gvKZD9p3CB87T0SNVxFiV+p9LuCYaf8CY8LHGHDH5AzlpeVbMahKvnXO3Q9arEiI45gFHBYPmBw64bknshrD1YVe1ypTGXm+r1ff4hn/A2tcWaqpf+e36L5/XzSmAMwkzj330YvbKp2qNaWVOC1ajoyDvTDczI3wWD0m7L9TJW24OpuT757S0xlmC1baxXkUgdmgSUajreTtmYoetK+mNMUm9Am3bB0Zz0/y7AR/4AhrbUlGVFH2LlbsMcsAyTBBoyzlDplpAj4Lb7imi3qhwnb5NlkEZVDYxjfNbhQj1saz6T+yhAWo9egxKouZYJbMfeHhuTsOdRbupcgwaBJB+viy+X0nsFg2XCjl7Q7HR3L9d5Ikf71eVDRCPBFeQYdpXf6xQvtkWd1oAbd4Tybq3m0HlQgSQ1tSMkryEl9YnxXGLaZzSjJ++MVZZFMm+qisyblL03L7C8drjTHr2E5iLZ0onIJ1j+h7HkKucgiAXUpWL76YKaphA/x5TURs4hQ759wOAS1SaiKlFCIop0kLTKVuzTrxVmqO3YBTxVka6E6n/41UGzED0i43JdAJRVD+aEYkoZbRn8ux8wSyzV1307Dr7L7DqSW5di/sxGjNQbvg5M3hHyLW3faC8DU+AEStVjT5clqMjbaCuUVnUOp1XCQlDEf8Jgyl8C6gsbSTjG2RVOA4oOWU81ZR21rHc5trwtROqh68QTQn66tZggF1RFfmxhFObhwAAb1zL4fRC/P38tgg4Sia30AR+fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(39840400004)(376002)(346002)(53546011)(5660300002)(66556008)(26005)(83380400001)(31696002)(186003)(86362001)(66946007)(956004)(6666004)(66476007)(36756003)(38350700002)(2616005)(8676002)(52116002)(6916009)(6486002)(44832011)(31686004)(4326008)(38100700002)(8936002)(16576012)(478600001)(2906002)(54906003)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wlk5N0lBZitneHBVWHh1YzI3c2cxR29XVDBsYWNHQnl4MGlSTHZTUEFMaXUr?=
 =?utf-8?B?YjZQaC82UkoyU0tib3QxYlhzdFM5QVhzYmV4MFQ2aWE2S01TbHAvWm1qKzNN?=
 =?utf-8?B?MGlPTWgrWGxrNXJCZktEMlYrWTJ1V0hpL1kya1dPdXJlMS9qd1YxSGlhMVVB?=
 =?utf-8?B?TEFNMUsxNVlNbngrTFNOTC95Wm5zZmFSZUx5QUhUY3JBRndjTUlSaDlVOGY3?=
 =?utf-8?B?anlXUDdzOWZIc0pTOTVhL3BwZEQ3UENWWEFGNzJrV2tNVFE0UWQ5MUtDcEM5?=
 =?utf-8?B?UXRiMEFTS3ZUNGYrVTlzU05PaVpCRUlhMkptMWN5UmlxNVI4c0wrYkM3UnVr?=
 =?utf-8?B?QkhFMThUeWZXY2JQQVdHek55enpFWWJDZWJGWThIdmlkOWJEMzJ5MVU4dUFk?=
 =?utf-8?B?TXA2c21NUmg0UkZjUnpDNFg5YU1VbS9tUTMrUCtvRDBuUlc0L28zYXVMZVZ4?=
 =?utf-8?B?OTB5L0xrUG5namN0T1lYWmtoNDRRNzZOM0ZvWk9ud3dTaEdSWEVDYW5PWFZq?=
 =?utf-8?B?R0xBMUp2Ti8xTnF0WGRLcnVEeENjME9OU0Z6UVF6ZWxlbzdKcnk0ZUQ2Yis3?=
 =?utf-8?B?a2ZNSE83Nm1PM3l1WENoc3dCeEJjeExVR2w0bi8zckJyZlE1TkZuRjJqZHN0?=
 =?utf-8?B?QjdVdit3K1JxRWVkVnVsdk9sdDcxaGNFZkFxUlZCbFF2VU0rcmZvOWhqcFFs?=
 =?utf-8?B?MFc0SzZrZDViRUp2YktycFhhY1dNUUdKNHBLUDlZVGE4M29BbE5IRzFUaU55?=
 =?utf-8?B?VHE3U1JKaUxKbHFMS3BCTmNWYlA0a21rbVEyU2ROOElhNUl4QmJWcFN4enFU?=
 =?utf-8?B?N0xLN3l3THBVQ25uTFdTTllmTmpIbmdSTm1NckN3aTVobjZiL2VXNVFERWxM?=
 =?utf-8?B?NUc1S0l3U08xMHF0U0dwT1M4SjAvUGxyRW5IMG5RSUkzV0x3dnpHZ1Q5d0ZN?=
 =?utf-8?B?ZzdSdmxwSFBvNkxIamc4L21LNFhoei9scm9qTEZNMzc2NlhvUmFIVEpYbzls?=
 =?utf-8?B?eHA0eFBvTzVlVS9FcVhTeWY3MURna3NpNE5FUkFiN2FQSjI2Tk1KSUJEbDZK?=
 =?utf-8?B?L2dwRUFZeGM0Ym1aU0VaUUdJa0V2dTRBMTl5bWdlZmZ4NVdsTFN5MGlZcXlt?=
 =?utf-8?B?aUpDOCs4bU91c3FoQVNMa3llajhkbUlaRmthd0RBVitwYlNyTlRGR2VFYmdG?=
 =?utf-8?B?eG92VlVGWUErbm1BeC9LQkMvZVVYemhLZ0FHTjhGbjdIZUU5QUhRYm5UeEU0?=
 =?utf-8?B?UEYxdGRCcnM4cXVReWFTby96QWlmdlZQa1h2b1FyQVkzQURFRCtKVDRzbzhV?=
 =?utf-8?B?SXFSTHFiN1htRzZaME0zYWp2M3BaeHMwd3BNTkxNV2pPZzdoL3JwaHl3Wks4?=
 =?utf-8?B?MWw4amFPQm1IcXVwaUVWa0xBVldab0UrcFdMdVdURjJWb3h6UDArS1RVS0ZF?=
 =?utf-8?B?QXFVMUxRK1RBejAwYmMzbVJWUzNFczd1R3I0Y3JTRy80S2hnVmhmTm5zZmRp?=
 =?utf-8?B?aFZHaWhWbFRhUW1xU2xoM21GTGltZGxGeXpPMTVEaWI2SWpZb2JGdkdLUXBa?=
 =?utf-8?B?Qk1tUWppK0Rjb09zK2dWRHY2K0R5di90TWJQQlMvNzFZY0M4SVZCWGQ1MThl?=
 =?utf-8?B?K01kc3JIdjhsc2pZWDRrcnZFeVl1UmIrUDNPbEJSM0ZjUW1xekpEMUJQS28v?=
 =?utf-8?B?RXZDd3gySHFOeGdtSG5UY1VTMVZHRmVIamY5US9DZTJ0MmQwa2RPZFhjb0hT?=
 =?utf-8?Q?jHZsX9SOOSesOXYG4jgot5hpRMcDl6tRxjVaYEN?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da0ef14-b7bf-47cc-225e-08d952a550db
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 15:27:03.0065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+nrDHYM1xeJ1AIophJVNMB+qpgpenTAj9bkiMS9lo4Ck6mPOHKrbj2rGY2aV9ALHblxbyS/FJUfU/rFo4iEtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR03MB6408
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 7/29/21 11:01 AM, Greg Kroah-Hartman wrote:
> On Fri, Jul 23, 2021 at 06:31:51PM -0400, Sean Anderson wrote:
>> This device does not support changing baud, parity, data bits, stop
>> bits, or detecting breaks. Disable "changing" these settings to prevent
>> their termios from diverging from the actual state of the uart. To inform
>> users of these limitations, warn if the new termios change these
>> parameters. We only do this once to avoid spamming the log. These
>> warnings are inspired by those in the sifive driver.
>>
>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>> ---
>>
>>  drivers/tty/serial/uartlite.c | 52 +++++++++++++++++++++++++++++++++--
>>  1 file changed, 49 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
>> index 39c17ab206ca..0aed70039f46 100644
>> --- a/drivers/tty/serial/uartlite.c
>> +++ b/drivers/tty/serial/uartlite.c
>> @@ -314,7 +314,54 @@ static void ulite_set_termios(struct uart_port *port, struct ktermios *termios,
>>  			      struct ktermios *old)
>>  {
>>  	unsigned long flags;
>> -	unsigned int baud;
>> +	struct uartlite_data *pdata = port->private_data;
>> +	tcflag_t old_cflag;
>> +
>> +	if (termios->c_iflag & BRKINT)
>> +		dev_err_once(port->dev, "BREAK detection not supported\n");
>> +	termios->c_iflag &= ~BRKINT;
>> +
>> +	if (termios->c_cflag & CSTOPB)
>> +		dev_err_once(port->dev, "only one stop bit supported\n");
>> +	termios->c_cflag &= ~CSTOPB;
>> +
>> +	old_cflag = termios->c_cflag;
>> +	termios->c_cflag &= ~(PARENB | PARODD);
>> +	if (pdata->parity == 'e')
>> +		termios->c_cflag |= PARENB;
>> +	else if (pdata->parity == 'o')
>> +		termios->c_cflag |= PARENB | PARODD;
>> +
>> +	if (termios->c_cflag != old_cflag)
>> +		dev_err_once(port->dev, "only '%c' parity supported\n",
>> +			     pdata->parity);
>
> Through all of this, you are warning that nothing is supported, yet you
> are continuing on as if all of this worked just fine.

We don't. The idea is that we see if (e.g.) CSIZE is something the
hardware can't produce, warn about it (once), and then set it to what we
can support. That way the user can (programmatically) detect if this
device can support their use-case. So e.g. if you you have a serial bus
or something, the driver can find out that (e.g.) the UART has the wrong
CSIZE, and it can fail to probe. Before this series, it would continue
along as if nothing was wrong, and the user then has to debug why their
device does not work as expected.

--Sean

>
> That feels odd, why is this needed at all?  If you really do not support
> any changes here, why even fake it?
>
> thanks,
>
> greg k-h
>
