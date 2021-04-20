Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19656C433B4
	for <linux-serial@archiver.kernel.org>; Tue, 20 Apr 2021 19:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4CFA613D0
	for <linux-serial@archiver.kernel.org>; Tue, 20 Apr 2021 19:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbhDTTIB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 20 Apr 2021 15:08:01 -0400
Received: from outbound-ip23a.ess.barracuda.com ([209.222.82.205]:58306 "EHLO
        outbound-ip23a.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233509AbhDTTIB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Apr 2021 15:08:01 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173]) by mx-outbound15-156.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 20 Apr 2021 19:07:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHBX4WdMTD0hf+CguWH8YeL9NCukt/4dKQcHnO47x3agbB44xlex0hQP4cPcf6NXrRVDuiyaq3lJDOkRPaySakOL8FfyZP8Ue8uZIQXctzp3mxNEamZjgjiQevgqovNSpBEe+JvUs8jSvdDV2QCgGI+qy8PPLnMIE5cQfS6qkixMFAnsBZBbgaZrZvEmQUQVwiwKcPbytHfs5cfRG0LCKbK+ePviOE8B3DwR6orgRTPusObsxrynGtBQ1GjvnOOPPau7nWNvMvhNuZjyJz3qHwqVJYTkpFY4yxWCXVDiaS2ZFF5MC+pS1mPO2IHZ2Ur22h5mN1Bvpzku6vo3dPnrOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndxX9KIbdj/768LTy0JxRKtqsmQ1g3036cvLwxp9W4U=;
 b=WD9gf3/5ZStmt8N+Af1Pk+MFTc+hBGYIbF1XvREqPMZkKe6vcpowV3j8IGJ3lYf1iUryZvtQ4+XciFSmwRjfRH8QyJNj9JTI4bMaNUYAQinAziPUM97pnMyWM7WhYancJXv7twNZkXsi8cwy5wSELWFpgJaEOr+s+dNk6XDHOUg9aaVFL0XH7yPVy5D2vGf/ufL0cCmGOJ/iBvg4jvTBK/xgmxVDEK8G+BVb9o0Hx/Y9C4Jb3vp0MC229V21tDKFKQgU1wu3JU5WCGBDlR35VqxE2JtfBOrun4r4XdOUf75SJugfmrOl32e9Ai5V1fp6o/jNNFrr4YTXFPndMbYb5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndxX9KIbdj/768LTy0JxRKtqsmQ1g3036cvLwxp9W4U=;
 b=pU3egVpMFvJnF8qCRf6InVKk2xjT54CPPjJHt9+s/n0gld52XZnPFaY4t+c7Q+UCxMGyJX7YR+WoytQi4c8EDHXi0NKju3tvyI/iq15OoCHCctzrd0gH+hmrq+a7jmZgpCTEfdO4pE5tBj9jEEgUt6sXO1e2zTCxB/E5F+vIhcE=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=digi.com;
Received: from CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15)
 by MWHPR1001MB2160.namprd10.prod.outlook.com (2603:10b6:301:36::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.24; Tue, 20 Apr
 2021 19:07:16 +0000
Received: from CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::75d6:e217:6181:f5a5]) by CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::75d6:e217:6181:f5a5%5]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 19:07:16 +0000
Subject: Re: [PATCH] serial: imx: fix TX stop function not setting state to
 OFF in RS232-mode
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <ac5aa181-eca3-040a-302a-4992022d39f1@digi.com>
 <YHFi9gmtpCbIp8aU@kroah.com>
From:   Robert Hodaszi <robert.hodaszi@digi.com>
Message-ID: <a20e43f0-e900-61a9-328c-a8dd9ba7b8d2@digi.com>
Date:   Tue, 20 Apr 2021 21:07:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <YHFi9gmtpCbIp8aU@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [81.183.32.32]
X-ClientProxiedBy: VI1PR0501CA0010.eurprd05.prod.outlook.com
 (2603:10a6:800:92::20) To CO1PR10MB4561.namprd10.prod.outlook.com
 (2603:10b6:303:9d::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.209] (81.183.32.32) by VI1PR0501CA0010.eurprd05.prod.outlook.com (2603:10a6:800:92::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18 via Frontend Transport; Tue, 20 Apr 2021 19:07:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 210c422b-96a9-4ace-270e-08d9042f8322
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2160:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2160734A1396866A1CD7C410E6489@MWHPR1001MB2160.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YTjP1h4tt8ZWQeTPV8eLKOYZ3cUlFEbCp1vmVThn9keWi6jawN4hpJPOShaiqCVypFX/YP4ugjtplO1cMj6q6tgibBKj0deuKgOuaIxYMuKKbOnaGnbuNTPah67bnyXTHNiSqDiuBRqkPj46436akS9wY8aGg8yHwQ/NwUvPCNzBDvsMgJ11kBzLzxIRS02mS0yfyh/gEB2+V9F2jiXBewUF0gJdxt9TJPPpbS28PrTHFr9YlTJshY8ulKiMcPBO91viRW6nHtvyKThgH2EUPJNbylS5TWE2TGy+x5pBh+XFZDawpPv2ef2OBFWiRbQimdrFo6lySnhdpvt6ahmJQHn6mkmlejyh03/RW7mt9Tk7lPIZoBFgZgFuGvSvjM9c0XtCNBKC24Eiu12mKbMUdccIBbcI9kqi3KcjX84ltx2GgfG1fJdSZigUixIFEJdFzTkpCJLf1RPsvpk0Vmx6X3ZYqehHswSDt17RrO5iMPF0R+NarQvdtpxUQNsmuK28sXY6jEwrOORPMMY/ZZGNfDZ5lHIwICwrR9l3kOunt+YbriBvxyJCQmH5yzQ+pWSm/QqJFeNKgFFSYcryWykasSC1G8vHO4cZs2P5T8ww10AtQcmFFc6u4f6TBJtxEz1aqHqKzduRXZU6qK639Wo4kWXIhJJEh6Fqt57ar8x96a7IhvXYmIQxX3b0PX+JrgV1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4561.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39850400004)(44832011)(6916009)(26005)(478600001)(83380400001)(16526019)(38100700002)(86362001)(6486002)(4326008)(31696002)(6666004)(66476007)(8676002)(5660300002)(2906002)(66946007)(316002)(66556008)(956004)(2616005)(16576012)(54906003)(31686004)(186003)(36756003)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?K0xwaENuVCtRbGFYdWRseWpvUk5zUEExakFuc3cySnd2YVBFVnpVWU1SM2hF?=
 =?utf-8?B?WkRHcnNCV09jYjUxUWFSNHVQaWhlZWRIcmlMdWI2TXFSbDRPY1I0Kyt6cklo?=
 =?utf-8?B?d3RTalUyM1ArSkUvaW43YklMQUFFUHlYN2M3OTQ2NDRvYXZQNFRuVEdLdnV2?=
 =?utf-8?B?eUkvWkNDZ3VmU2tFMkM2dG9oM2xqdTB2YWNQWW5jNktlZmVQYnBNNXgxbElh?=
 =?utf-8?B?b3AyT3luS1BIa0RQM1lHYlhFTVkwL2dzTGN6Y1QyUDRNZ29lbDduOEEyQjB0?=
 =?utf-8?B?OEU1R3g0VnUvTFRFYlhFL3VRVEJVeWVISVpuR3g1bG92RTNnZ0lNL3VNNXVo?=
 =?utf-8?B?Z0dFT2taeUVFR3IzaGkya3FsZXBGeWlyTGM2QWMveWxhc2tDYnZIN1M4YnVF?=
 =?utf-8?B?V3paTlRRTmtGdG4xLy9aYXlKVnFlYUdlaWZGeFNVQStDMm4waWVwVFR1YXY2?=
 =?utf-8?B?WHpqdm5qVzRReWE3bVQ3NkFONGdhbUxQQmNJVWZldUxrR0hBUGdCdjVKc05P?=
 =?utf-8?B?SFBUdmJaTzlPblVabzhjRmJ5eFZhNWtGRnZjc1VCZWs3VHkzc3l2YWNZMXN2?=
 =?utf-8?B?ejBGZjdiWWo1SzJ1SU9iRkkxMHMzbEZxNGt0OHdjOXN5WnNMUy9WM0l3UUI3?=
 =?utf-8?B?L25mSlQ1YzVIVldRT1ZwT3lwZ2kra2RHcy94MDVhb1dUekpHOEpTVUd4Yjdz?=
 =?utf-8?B?TVJUWEIwV3hwODdtWlN5b2REZHdsYmg1TC9oSEg5ZEV6T2ZmTldjQng4bDAr?=
 =?utf-8?B?dkw1WVRreGhZdDZVU3RjZFVraU00UURtVEN3cnNwMWlLd3A0UmVrRDRHaWxV?=
 =?utf-8?B?Q1lWdStIN3VSNTZZVXUzdVdlMWdPbGtLZ1Y3VVpqVHRBMTVVd1lyUnZtWmZ3?=
 =?utf-8?B?RnIxeCtTbWFtaGd5QnJnVnZVa1NFMkdBRkVibGxBSGVKVEhPVXlTSFp3aXdJ?=
 =?utf-8?B?ZVBSYU8xZ0hCM21YUXhxTDJnanNXZFVJZlBTWDlDVm1ScEJpYlRSbUxoc1E3?=
 =?utf-8?B?ZHdRUE43c3RtOWFXTXMvS01KQzVLVnRSdW9hT2p0M3Bpbnk2M2tkVHFxaDBv?=
 =?utf-8?B?VjduUTJMcXY5VFFNanFMU0s4Y1JuaGtGcDFHZ25PVU5hLzhlRVNkd1dOZGtk?=
 =?utf-8?B?VklwbHorSERXMlNsZi9Na1l2VFBLZElOcFFOa05yQ09Ba2E1cHJpcTVHSm5T?=
 =?utf-8?B?TmdtcW9vcDJyQXR0clNnNHEvVno5MHZmUy90Rnpjdk15OE0zN0gvd05KeDFx?=
 =?utf-8?B?VGJwcFZNN1lkZXFKZnp0a0J4NDZCb084T1l4TkJ1cXBIN1hHOGdEQjdCMTYx?=
 =?utf-8?B?UkpFeVhWaEcwdllmUE9kNm1CVjN4ZUdrbVQ1V2hEd29ycm1JNG50a0Q0YUFI?=
 =?utf-8?B?ZXpQWmtWMlRjeDJZRlptbU85UzBWZ3g0WGQyanFZOG5JclhUUXh3U1RkZExS?=
 =?utf-8?B?L2lCcUhRdjArK0JQbFhtZ0JPeXFoc0dGUHU3cGFpZDFpMmR2Z2J6a1NtOVhr?=
 =?utf-8?B?QzVBZXVuWGp4VHBsUnljaW1RYkxwcVViL2pGNk85Y0E0bld0L0ZHM3g2Qk9a?=
 =?utf-8?B?MlhYWXJ6dnNOUEQrcjVObHpBT0NZTE5QSnhMOTYyZjd1Ni81eVA4V1dNdzBs?=
 =?utf-8?B?UEpqZWpxYkZUMG5veWhsdEFMQWhMSWxsWlJvSkNidmpCTDcySCt2OVNpa3k2?=
 =?utf-8?B?bzU4WUo2ZU1jOUFubkpwbTZ3K2hsR3dnbHJOZmo4ME44UkFkS21FUEtKcUF1?=
 =?utf-8?Q?qx7EvcnpaAiNGuGrC3lKXAHOQibsck3BPohbWb/?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 210c422b-96a9-4ace-270e-08d9042f8322
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4561.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 19:07:16.2291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mPvt2w3eftv0qXb5rkq6xrvLSQukDmPEDSONie+PmdVKocEKmDyK/0MKJhFy52rOAxpGTs5PBq7SRkmG1eJhPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2160
X-BESS-ID: 1618945637-103996-9074-5766-1
X-BESS-VER: 2019.1_20210420.1810
X-BESS-Apparent-Source-IP: 104.47.55.173
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.231691 [from 
        cloudscan13-110.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 MSGID_FROM_MTA_HEADER  META: Message-Id was added by a relay 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=MSGID_FROM_MTA_HEADER, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2021. 04. 10. 10:33, Greg Kroah-Hartman wrote:
> [EXTERNAL EMAIL]
>
> On Fri, Apr 02, 2021 at 01:05:48PM +0200, Robert Hodaszi wrote:
>> From: Robert Hodaszi <robert.hodaszi@digi.com>
>>
>> If the mode had been changed to RS-485 after at least one character had
>> been sent in RS-232 mode, the RS-485 transmission was not working.
>>
>> Commit cb1a609236096c278ecbfb7be678a693a70283f1 ("serial: imx: implement
>> rts delaying for rs485") added a TX state variable to keep track, when
>> it needs to enable / disable the RS-485 transmitter.
>>
>> In RS-232 mode, the start TX function just sets the state to SEND, and
>> the stop function supposed to set it to OFF.
>>
>> In RS-485 mode, the start TX function expects the state to be either
>> OFF, WAIT_AFTER_SEND, or WAIT_AFTER RTS. It cannot do anything if the
>> state is set to SEND, expects a stop first.
>>
>> But stop TX function in RS-232 mode usually didn't set the state to OFF,
>> as it first checked if the shifter is empty, and if not, it just
>> returned, waiting for a TransmitComplete interrupt, which is only
>> enabled in RS-485 mode. So the stop function was never called again.
>>
>> That check, and the subsequent code part is not needed for RS-232, it
>> just have to set the TX state to OFF.
>>
>> Signed-off-by: Robert Hodaszi <robert.hodaszi@digi.com>
>> ---
>>  drivers/tty/serial/imx.c | 46 +++++++++++++++++++++-------------------
>>  1 file changed, 24 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index 8257597d034d..511badce3edd 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -443,6 +443,12 @@ static void imx_uart_stop_tx(struct uart_port *port)
>>      ucr1 = imx_uart_readl(sport, UCR1);
>>      imx_uart_writel(sport, ucr1 & ~UCR1_TRDYEN, UCR1);
>>
>> +    if (!(port->rs485.flags & SER_RS485_ENABLED)) {
>> +        /* Set the TX state in non-RS485 mode, nothing else to do */
>> +        sport->tx_state = OFF;
>> +        return;
>> +    }
>> +
>>      usr2 = imx_uart_readl(sport, USR2);
>>      if (!(usr2 & USR2_TXDC)) {
>>          /* The shifter is still busy, so retry once TC triggers */
>> @@ -453,33 +459,29 @@ static void imx_uart_stop_tx(struct uart_port *port)
>>      ucr4 &= ~UCR4_TCEN;
>>      imx_uart_writel(sport, ucr4, UCR4);
>>
>> -    /* in rs485 mode disable transmitter */
>> -    if (port->rs485.flags & SER_RS485_ENABLED) {
>> -        if (sport->tx_state == SEND) {
>> -            sport->tx_state = WAIT_AFTER_SEND;
>> -            start_hrtimer_ms(&sport->trigger_stop_tx,
>> -                     port->rs485.delay_rts_after_send);
>> -            return;
>> -        }
>> +    if (sport->tx_state == SEND) {
>> +        sport->tx_state = WAIT_AFTER_SEND;
>> +        start_hrtimer_ms(&sport->trigger_stop_tx,
>> +                    port->rs485.delay_rts_after_send);
>> +        return;
>> +    }
>>
>> -        if (sport->tx_state == WAIT_AFTER_RTS ||
>> -            sport->tx_state == WAIT_AFTER_SEND) {
>> -            u32 ucr2;
>> +    if (sport->tx_state == WAIT_AFTER_RTS ||
>> +        sport->tx_state == WAIT_AFTER_SEND) {
>> +        /* in rs485 mode disable transmitter */
>> +        u32 ucr2;
>>
>> - hrtimer_try_to_cancel(&sport->trigger_start_tx);
>> +        hrtimer_try_to_cancel(&sport->trigger_start_tx);
>>
>> -            ucr2 = imx_uart_readl(sport, UCR2);
>> -            if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
>> -                imx_uart_rts_active(sport, &ucr2);
>> -            else
>> -                imx_uart_rts_inactive(sport, &ucr2);
>> -            imx_uart_writel(sport, ucr2, UCR2);
>> +        ucr2 = imx_uart_readl(sport, UCR2);
>> +        if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
>> +            imx_uart_rts_active(sport, &ucr2);
>> +        else
>> +            imx_uart_rts_inactive(sport, &ucr2);
>> +        imx_uart_writel(sport, ucr2, UCR2);
>>
>> -            imx_uart_start_rx(port);
>> +        imx_uart_start_rx(port);
>>
>> -            sport->tx_state = OFF;
>> -        }
>> -    } else {
>>          sport->tx_state = OFF;
>>      }
>>  }
>> --
>> 2.27.0
> Your patch is corrupted, all the tabs are turned to spaces and it can
> not be applied :(
>
> Please fix up and resend.
>
> thanks,
>
> greg k-h

Sorry, for that (and for the slow reply)! My latest Thunderbird setup
seems not playing very. Went back to my older setup, and sent out a v2.
Hopefully, that will be OK.

Thanks,
Robert Hodaszi

