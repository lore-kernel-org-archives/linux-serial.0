Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDC7C197A0
	for <linux-serial@archiver.kernel.org>; Mon, 20 Nov 2023 16:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjKTQYU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Nov 2023 11:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjKTQYT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Nov 2023 11:24:19 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2071.outbound.protection.outlook.com [40.107.13.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1741F94
        for <linux-serial@vger.kernel.org>; Mon, 20 Nov 2023 08:24:15 -0800 (PST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=bLRnQQEeeeJGbR9NzBYKtle/sHVqMC+XRqOIgmjrc4EPUFcVdlh5Ez2I5lOpZDDUJ1R4D90hhSEUnx/3k2F6N4OWElHQwjq1b3XevLDRwCFXEdGq92SHdRrfHPnzz34r+NOCp4pvXF/kMRoVYTsBLvqtq6wK21Al9OxXBtRY0mY4emmBB5YpjkiY8jt2kl30+F0nCweEFKKvmgJAw0daQ7wUAm8imlj1WkIqLOKBgYpuSJaqnmAETs01yjPwd0etDqqBy4bTPgX5p/utZT6ivQz2B+NX0VOmK+GFR9Cqneu9zMHc/vlAp87gbqrafCrnxn3kVuivUHwWBjmZSubCMg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOuPkl+56gHps6Knel+ltxT0VT52NK8w4SKKHYUTEGU=;
 b=DfP/p4ODHvz05Kd9HQ01WLsaO6jnHVvWDilCa4u6bKaXf6HwOn0IapMYLJgXCb7aaWKKl6A8qSIK6b3gGsKNcYI394EHqn9S/IQYhaG0cgt53CKmAv/QD+XfACar0B55omPYPAFCgUseM541s6nOFZh7NOyExMa+vYh5BxaSS6w//gT5EAZm1kMqgOlhnY06Y2AyDvaVKv+MblkE4F0UbMQfl1acQ8sbGDrttirsMPb8b/ef11tvDF/yyqfp63Da9C91EsgnbmMoRowlv3A8nBfosKb0umNJgvYFqyxxsxc1cpI9Gj3ld80+vbZ20eoDP3khNZWKeq0PzQ1c5BbU/g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.87) smtp.rcpttodomain=amd.com smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOuPkl+56gHps6Knel+ltxT0VT52NK8w4SKKHYUTEGU=;
 b=q+3qRHAErUFijJvs/xUoEMWv612cXh71WUH+fkWd0PTudQ4Q0ai9DHMcFkyBTsmKWhtX+WuxvIc+cA1svmLf5v6q1Y5EDojoayLa7gveKiW3cPFTPAtfKqQWvvahlDtJRkiDImGxFxCVAHnwjdJR74e8UuuJMpRFAR9kxJ0dWfKlfG8guDUA5ogTkXCy4hG7WuRe0IzLQ49ZtVHEbrgmff2vN/TL7DLoPUml4UPGFf+mbnUOTfFKoGy2CoUxkws2ph1J7ZxZgFfgd7+u9ic+eUloXukkByL3IJow/HGk8pA0Q/JBN67iaobR6h9AUN1YsRWAtLJg6e7T5uM0wXLCIA==
Received: from AM6P194CA0061.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:84::38)
 by DB9PR03MB8352.eurprd03.prod.outlook.com (2603:10a6:10:393::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 16:24:11 +0000
Received: from AM6EUR05FT036.eop-eur05.prod.protection.outlook.com
 (2603:10a6:209:84:cafe::13) by AM6P194CA0061.outlook.office365.com
 (2603:10a6:209:84::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Mon, 20 Nov 2023 16:24:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.87)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.87 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.87; helo=inpost-eu.tmcas.trendmicro.com; pr=C
Received: from inpost-eu.tmcas.trendmicro.com (20.160.56.87) by
 AM6EUR05FT036.mail.protection.outlook.com (10.233.241.222) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.16 via Frontend Transport; Mon, 20 Nov 2023 16:24:10 +0000
Received: from outmta (unknown [192.168.82.135])
        by inpost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 080C120086FC5;
        Mon, 20 Nov 2023 16:24:10 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (unknown [104.47.11.40])
        by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 5E9E22008006E;
        Mon, 20 Nov 2023 16:24:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epuojLxw1RfJWqZ4RN04JfcM9MV22aAWmU5z+viALTtYofdCDhsBLJSPtu7wX14bG/Lw+j9KkP61Txjgvj384pwx/t45d4a1M/clo2MZzbDOB8fnEx0xEOJa1s4GDGul6FbPAxxv9QJJgbyLxKKGDphEVZAT9DgWtzv56uwd0oSDkT45NCXm2/heFzknhq8ZqGgaN3R8o+x7Dt6U/mgemKTpvjzHDGCE2ly+IiUo+widAMTKDChrriw8z84BGPa1/1K+8V8lsGeu5MzX5SOkGsFT5rUs34IS3nasw+gOCzr/rluVvxSq67AJxuJzgRdUGb6LFp+eetikrD+rgqO0xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOuPkl+56gHps6Knel+ltxT0VT52NK8w4SKKHYUTEGU=;
 b=FGsKJ+MzZsPvvNXv3yv10RaZOwB89NqHLWrvhQAm7P/JiOkIbjGCYdk6F1FpHZebMMqY9pthqvu1QsVIecnwi2AmOd1EUYdTIKY6D6l72VE61n3zQ6V8C3uh7j0Y7Kc6RMzoHXku1IqbfZhgKgJibhkWQKCHZu9/qnzoDb+RRAqRME3zwC4r8g8HRHGqze5/heYc2YTM7W8yTFt7w47oBZu5z++ujaNkoRbpiWDOjptcRBr8jRwzVrFCaQb6Nlx8Fnc9Ke61LlJzRr/tX4pzXNVL1hdTNE6qWYuB/YSZ1ADt6r6e9qHMks0Z47mmQT/XhH7AYPdhNIaasIfJNgHfuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOuPkl+56gHps6Knel+ltxT0VT52NK8w4SKKHYUTEGU=;
 b=q+3qRHAErUFijJvs/xUoEMWv612cXh71WUH+fkWd0PTudQ4Q0ai9DHMcFkyBTsmKWhtX+WuxvIc+cA1svmLf5v6q1Y5EDojoayLa7gveKiW3cPFTPAtfKqQWvvahlDtJRkiDImGxFxCVAHnwjdJR74e8UuuJMpRFAR9kxJ0dWfKlfG8guDUA5ogTkXCy4hG7WuRe0IzLQ49ZtVHEbrgmff2vN/TL7DLoPUml4UPGFf+mbnUOTfFKoGy2CoUxkws2ph1J7ZxZgFfgd7+u9ic+eUloXukkByL3IJow/HGk8pA0Q/JBN67iaobR6h9AUN1YsRWAtLJg6e7T5uM0wXLCIA==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by PA4PR03MB8133.eurprd03.prod.outlook.com (2603:10a6:102:2a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 16:24:02 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::6176:6be7:d620:8a87]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::6176:6be7:d620:8a87%4]) with mapi id 15.20.7002.026; Mon, 20 Nov 2023
 16:24:02 +0000
Message-ID: <10f7887c-00ed-4de8-a9d9-a3852c75d1ad@seco.com>
Date:   Mon, 20 Nov 2023 11:23:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tty: serial: uartlite: Fix kernel doc warning
Content-Language: en-US
To:     Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        linux-serial@vger.kernel.org
Cc:     jacmet@sunsite.dk, gregkh@linuxfoundation.org, jirislaby@kernel.org
References: <20231120090905.24222-1-shubhrajyoti.datta@amd.com>
From:   Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20231120090905.24222-1-shubhrajyoti.datta@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:2d::40) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|PA4PR03MB8133:EE_|AM6EUR05FT036:EE_|DB9PR03MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: 932f56d5-3bc9-4854-39dc-08dbe9e5204b
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 2iTnDhxWLDpVOiSQFU9ougN7KppdcPbb8d2oAXJ6WDd6GludXbOJCbUDBD7NhuugcffQ4pMqq972WlJZZVVMjkA8wKvMgb3jqU+HM70SEU/1wYi8aPZiVpgSKmuVh91LOzzq3IVtX06Pyb+GtX/DnqWol0NFyMCF8BX9ZruLxTXXlnG+u//VE5U9fT01j5eyJhANmtc6hLNWrbcM1ar5VxmIPqOl+VqXXVtlgakG1Wlc5sRSjLa3qXXwCyJq5O1/FLskUbvkurKSHd0dI116vyQtScdQWS7G4qDbRp+8IGKtAPO+1tYUOmZC7a1/fnI19S8/SwL4by/z5CXdkmuiPRqwoR7UbySi1swezAmSPWB6k8bwSRi+zj0/NBmL85aeAFxk3ltbh9S85AxZMs3nRLqs39xaBYdJE66NFe4hQyH04gIua0VBbjsKkpWdREYinC3q4of94ZKu0OhiYtOGWjJfyoPxlwKpO79Ip6aezhBGEN93t7+QWKiNjFBFqSlbPjasyJyrlymjoqqgeVKTkpBKfenl7zChLE0Dea3Zaoc2pQX6bdQUjvGaXU/3G26s+SKr1ZielIrRP2Vhy5nYEFXjN9unWXpLOELP3+j8UachABNLLgQpCHBOg5paHFXZ/DseNFc4a1JNnekiwYVYfbED6xwuLZqOw7EA/JNSUvo52CbqM5Ru4Ikl9dPVpQQDw8R12uJx2yeAM7u1PL2nmA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(39850400004)(376002)(230273577357003)(230173577357003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(5660300002)(2906002)(26005)(2616005)(4326008)(8676002)(8936002)(31696002)(41300700001)(86362001)(44832011)(38350700005)(83380400001)(36756003)(66946007)(53546011)(52116002)(66556008)(66476007)(6506007)(316002)(478600001)(966005)(6486002)(6512007)(38100700002)(31686004)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB8133
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM6EUR05FT036.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: dc30fdaa-3589-4d87-ff91-08dbe9e51b76
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VzQTQ6Zr+z1VqweP7FAzHrwXYZhkRl9MNrYjQfvuxNY2maRcCCkT1YujthAN7Hm88RJJKITht5ysEM96l9MWlK2YUqP20kBou64P/sVEKYZYCsuLiWPOqPMpXRYy8IDW0f7j4uAvohu7SVC9Z+OJYlqBfv9vS462KFakxKBNijEJudIrlYcrAu1YkerLpLcG/nuc7Tk5KPDYdprCQqG+7r2dkmQZrmFPgzTw5YoQc5uKYV/RBESz61qwlLwLe2jv98von8zx7PWB8q5KzZQ0A/n173WH0Kvsj4QslP/jGQszO8IBaDi8H9nSSH0Bt1N/2Vwjx7riTGFPVp5at4C4sZ5dm9dIE1LsFkO2wGxG0c3OTQ94NXjMkTOO0TUIVtClwysPrhrw2cu6blhFhfW0Hyn+oIr9Dhlrzg+KnAKcPORhEG0gBKzxhQoYYavhr6bSeZrtDWmQD9bzvX+P8uTWna8Xl1U+YQOug3rf/q2KTTwC0Nu1VlT7Z+O2zpOJ/pFeQIM5Hhcwr9Qk8mx18Ug24oNkUOhi5/CDopzAA5Jqrfqnm+zFu8zZwNbGsTew5k7GrSFq2+EWL25EAxajpFDDd9ieM2csi864ZLwmMzXTUc9ihpT6UAZlsBuAx9v13ciWSyu6WXho2M6vwCTacBXVPswWrvToQ40B5nu3CvfzhloKCXopz1dvvi1h/RJF2IhCN4NTq1bjzjHKoPGJeTcWshbQ0TmMfsVs1LJjW7qdieyf0bsF0VsQqUA+N4h2V/OI1E9q1RYSEwsIOuYjnl5tax1ORt01QJr1SpeuYQXC4WUwIX8nh/gWDZJYWntF5ODz72/Ox00UZt9Rrpw6AKXToQ==
X-Forefront-Antispam-Report: CIP:20.160.56.87;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:inpost-eu.tmcas.trendmicro.com;PTR:inpost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39850400004)(136003)(230922051799003)(230273577357003)(230173577357003)(451199024)(186009)(64100799003)(1800799012)(82310400011)(40470700004)(36840700001)(46966006)(40460700003)(336012)(83380400001)(86362001)(36756003)(31696002)(82740400003)(7636003)(7596003)(356005)(47076005)(34020700004)(36860700001)(70206006)(70586007)(316002)(8676002)(4326008)(8936002)(41300700001)(5660300002)(2906002)(44832011)(31686004)(53546011)(6512007)(26005)(2616005)(40480700001)(966005)(6486002)(6666004)(478600001)(6506007)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 16:24:10.1171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 932f56d5-3bc9-4854-39dc-08dbe9e5204b
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.87];Helo=[inpost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AM6EUR05FT036.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB8352
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 11/20/23 04:09, Shubhrajyoti Datta wrote:
> Fix the below warning
> drivers/tty/serial/uartlite.c:79: warning: Function parameter or member 'reg_ops' not described in 'uartlite_data'
> drivers/tty/serial/uartlite.c:79: warning: Function parameter or member 'clk' not described in 'uartlite_data'
> drivers/tty/serial/uartlite.c:79: warning: Function parameter or member 'baud' not described in 'uartlite_data'
> drivers/tty/serial/uartlite.c:79: warning: Function parameter or member 'cflags' not described in 'uartlite_data'
> 
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Closes: https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2flore.kernel.org%2fr%2f202311061059.NUeUar9b%2dlkp%40intel.com%2f&umid=ca5e675b-75fa-4a6d-95a0-b7630f896afe&auth=d807158c60b7d2502abde8a2fc01f40662980862-7a9c276d4643e915ccea59b2b954eb8784b19bd4
> Fixes: ea017f5853e9 ("tty: serial: uartlite: Prevent changing fixed parameters")
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> 
> ---
> 
> Changes in v2:
> Update doc for uartlite_data
> 
>  drivers/tty/serial/uartlite.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
> index 404c14acafa5..e586d7aeac98 100644
> --- a/drivers/tty/serial/uartlite.c
> +++ b/drivers/tty/serial/uartlite.c
> @@ -62,11 +62,11 @@ static struct uart_port *console_port;
>  #endif
>  
>  /**
> - * struct uartlite_data: Driver private data
> - * reg_ops: Functions to read/write registers
> - * clk: Our parent clock, if present
> - * baud: The baud rate configured when this device was synthesized
> - * cflags: The cflags for parity and data bits
> + * struct uartlite_data - Driver private data
> + * @reg_ops: Functions to read/write registers
> + * @clk: Our parent clock, if present
> + * @baud: The baud rate configured when this device was synthesized
> + * @cflags: The cflags for parity and data bits
>   */
>  struct uartlite_data {
>  	const struct uartlite_reg_ops *reg_ops;

FYI: this is a duplicate of https://lore.kernel.org/all/20231106152428.3641883-1-sean.anderson@seco.com/

