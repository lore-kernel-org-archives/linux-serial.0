Return-Path: <SRS0=1VgQ=6Z=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB01C47255
	for <linux-serial@archiver.kernel.org>; Mon, 11 May 2020 19:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E79D20720
	for <linux-serial@archiver.kernel.org>; Mon, 11 May 2020 19:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731200AbgEKTkY (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 11 May 2020 15:40:24 -0400
Received: from mail-oln040092010057.outbound.protection.outlook.com ([40.92.10.57]:13943
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729453AbgEKTkY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 11 May 2020 15:40:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUDmzzUDI02pF8V3/IOxVAhSxSZEnwsNrbXg7AfZPDTLh8Zjc6FC8DJxb6AXNs+uWirxptpuFepXMBTJXQjbeOx1pu2mLVvLeLtIeyP8IVCh6yh4T9IwUo+QEkgD4edeGpKioSRhzTULNChlQuu2gW+8c8sNDsaj73MXL939HGmHVc03oxM5eVf0W3HrBdSqlxktEkf23rGoheqzW9dDgQdFSkTG2owrnXPawIKncKbdXam7obOE/ui8cPyGq2ZtyOeT/sUd6dU9F+Re4Qy6hpyHtONBPUi39RjBzlXUlCidrfUnDtsrWQWVOY+zSetvS/nYxfgAxnVyqd+X0BDUiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPe79cHYrLT7fgnm2xmrMQZ2LOTrgl7ADSAeP23qE8A=;
 b=nOYUbV4SkLmFsp4h5TBQ2viVkrgc9S1odFbwk0YPOrQdODEd+72FsS3eVh3qF8lrD3pa9/cQ0coB/f+LrJpc/BddKja4groHs7mW6ABkjPwdCGT14ZcSiBUj4340tbG5IUq61Shk40uiX0Pc11iRaAYCrDxsAbOrb9Nq2PKuIA0cVngGD0Tx16j9y9UAMOxhnMvO79crKYk9OJNTFKtBDOD/c+W5ePOEN+rUgYj7By9bull0XJmmOtqoCC7sM6WlQsxSYPaQpwetd6cNhUqXOTgInsScmIK3w5DN3LOh6VdcJy0peQrds+mD2Xp0xodxemGmFrhw8JmZ8umd0iEHtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from SN1NAM04FT055.eop-NAM04.prod.protection.outlook.com
 (10.152.88.54) by SN1NAM04HT120.eop-NAM04.prod.protection.outlook.com
 (10.152.89.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27; Mon, 11 May
 2020 19:40:21 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:7e4c::50) by SN1NAM04FT055.mail.protection.outlook.com
 (2a01:111:e400:7e4c::276) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend
 Transport; Mon, 11 May 2020 19:40:21 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:72E7EE7FA8188B73B014FD6571BA844966295E2419F5255A20FE51EC8D36D6A4;UpperCasedChecksum:F1D8481A5A4CBA010304E954551F802575924E9DA2F1B2C6E9DA84A6B162EFB1;SizeAsReceived:9121;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 19:40:21 +0000
Subject: Re: [PATCH] tty: serial: samsung: Correct clock selection logic
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kgene@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <BN6PR04MB06604E63833EA41837EBF77BA3A30@BN6PR04MB0660.namprd04.prod.outlook.com>
 <20200511100836.GA16828@kozik-lap>
From:   Jonathan Bakker <xc-racer2@live.ca>
Message-ID: <BN6PR04MB0660B66569974294E24F2044A3A10@BN6PR04MB0660.namprd04.prod.outlook.com>
Date:   Mon, 11 May 2020 12:40:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200511100836.GA16828@kozik-lap>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR04CA0156.namprd04.prod.outlook.com (2603:10b6:104::34)
 To BN6PR04MB0660.namprd04.prod.outlook.com (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <3f94a7d6-65c7-4fa7-f4b2-2ddc9fec10cb@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2001:569:fb68:9c00:8067:f823:1e15:7520] (2001:569:fb68:9c00:8067:f823:1e15:7520) by CO2PR04CA0156.namprd04.prod.outlook.com (2603:10b6:104::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend Transport; Mon, 11 May 2020 19:40:20 +0000
X-Microsoft-Original-Message-ID: <3f94a7d6-65c7-4fa7-f4b2-2ddc9fec10cb@live.ca>
X-TMN:  [MtnCR6rpauK6C5JN3dkav6WAQlB48U8Sy0q1NXDY52gErLx89AGZ6RkEzfSXVh5Z]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 47665e5e-5e92-41dc-9ba3-08d7f5e32444
X-MS-TrafficTypeDiagnostic: SN1NAM04HT120:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9PQn66Nm+45+3rLWORJVcsu7zKbS5wgJbrAwd/Uwg1mN8msulqhQqsbTY8XynQWtmaQQfmIIFN6IhazkyGSYG9zVaDLK1gfJldHov3kON1n+UC6Diw20tiO9pkDDOzjJvY+qxpbhnnpd5M7zRJmaifG86Bwfa4uPiG1gDqRubPnSCiQUZ6HLSGn+ozO64Ij5SYG8r3pGoQwXIXwDRI2iTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: ys4YbTpP2aQc1OzRWZPI9MGDprNkLvOE9GZAG3IAra7A8SLbCMKZYI9FOHkrdYel5YzErwcMZJNdOD2E/BhCKBY5f548UfsynV3Yn/3AC/NtJhdRT3tSOTgyMCTSzBwzIihLn9sjvsRL4RafvTLULza4C9HoOecSVPIHBIv27RzHkKo3yih5lRkHxoQ+o5vdNRjeWbPnWdjGLICQLcIU8g==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47665e5e-5e92-41dc-9ba3-08d7f5e32444
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2020 19:40:21.6769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1NAM04HT120
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Krzysztof,

On 2020-05-11 3:08 a.m., Krzysztof Kozlowski wrote:
> On Fri, May 08, 2020 at 06:34:33PM -0700, Jonathan Bakker wrote:
>> Some variants of the samsung tty driver can pick which clock
>> to use for their baud rate generation.  In the DT conversion,
>> a default clock was selected to be used if a specific one wasn't
>> assigned and then a comparison of which clock rate worked better
>> was done.  Unfortunately, the comparison was implemented in such
>> a way that only the default clock was ever actually compared.
>> Fix this by iterating through all possible clocks, except when a
>> specific clock has already been picked via clk_sel (which is
>> only possible via board files).
>>
>> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
>> ---
>>  drivers/tty/serial/samsung_tty.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
>> index 73f951d65b93..9d2b4be44209 100644
>> --- a/drivers/tty/serial/samsung_tty.c
>> +++ b/drivers/tty/serial/samsung_tty.c
>> @@ -1281,14 +1281,14 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
>>  	struct s3c24xx_uart_info *info = ourport->info;
>>  	struct clk *clk;
>>  	unsigned long rate;
>> -	unsigned int cnt, baud, quot, clk_sel, best_quot = 0;
>> +	unsigned int cnt, baud, quot, best_quot = 0;
>>  	char clkname[MAX_CLK_NAME_LENGTH];
>>  	int calc_deviation, deviation = (1 << 30) - 1;
>>  
>> -	clk_sel = (ourport->cfg->clk_sel) ? ourport->cfg->clk_sel :
>> -			ourport->info->def_clk_sel;
>>  	for (cnt = 0; cnt < info->num_clks; cnt++) {
>> -		if (!(clk_sel & (1 << cnt)))
>> +		/* Keep selected clock if provided */
> 
> Makes sense and good catch.
> 
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> I wonder about the s3c24xx_serial_enable_baudclk() which has similar
> pattern - is there
> testing only def_clk_sel on purpose?

Yeah, I saw this instance too.  5086e0a409a0c ("tty: serial: samsung: Enable
baud clock during initialisation") introduced it, which was just to make sure
that some clock was enabled during initialization.  Since it doesn't appear to
be critical which clock it is, I left it as it was.

Thanks,
Jonathan

> 
> Best regards,
> Krzysztof
> 
>> +		if (ourport->cfg->clk_sel &&
>> +			!(ourport->cfg->clk_sel & (1 << cnt)))
>>  			continue;
>>  
>>  		sprintf(clkname, "clk_uart_baud%d", cnt);
>> -- 
>> 2.20.1
>>
