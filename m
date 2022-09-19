Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C265BC6FA82
	for <linux-serial@archiver.kernel.org>; Mon, 19 Sep 2022 11:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiISLeY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 19 Sep 2022 07:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiISLeX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 19 Sep 2022 07:34:23 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00137.outbound.protection.outlook.com [40.107.0.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9FE2612E;
        Mon, 19 Sep 2022 04:34:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQH67bROXI8O1CjEF+AvNrzoTpLhNZA70lCdgPZxhRv2Ro94ykD6U6q4vYFxuO8LzH0MeNRfAUkMsJ08bMmzTPhcxtC3hlBkP9u12/t64VTdFhCTM0n840dEyW1Eq18LBTEBmDDr00L5AKALUEpf7qPnPzWIjEt4+KeStQV0ixAtKhQd77M9xPkQtAPdYtoxc1jKeeapIs4q1evYfCCyMEnfJBMXGeUa863Lv5JiNMkbMZmkAjfe0gQEPyTUZb+4iSFSatqgzdXrMynBAHw6wiSAC3KfEn8RV0vfkHFeHd2H5O3N2uDrfn1teSMHrHRabufM9tnH2F1loycRTQgs/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwOFDaugfFlkEEWMVCheVbW5C7ctPE0ZvSlKc5BSDpw=;
 b=offocnOHQ2Qp+XCV48+36t/KXw4hc94wgqeBDy//Flla7VhQ9KAokg6N7dUk0MtTBGFm9WQSyeaJZfbK2Q/USI2lqNrIcotC+aw7jD3JwrrH3AjA61c4oiaJpaMitr4xEd1EnumEOuh0sZV/jHUIfzFJzP2bdd59TRCuz4q/DJhbQ49ScE1+VzAihWkHGh7xk7wTBcojey2mQ/G8i5KMUHGmbpPMdmkAhlQR8If25c/eK/sgQCIAekYG8/N3oChz2vWt+i7EOiQgs/bSEX8OgC0MVJ8t2I6cOj7/UPW1P2+M21LiyTGRLbZGoN5IIQcu+R/9+1CwF2bR2DLxC4ofyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwOFDaugfFlkEEWMVCheVbW5C7ctPE0ZvSlKc5BSDpw=;
 b=JIxJYEl/1elxc+oo1DivcRQnaiieIOoubrIPnzBEl17nv8Oy2YwR09FNdFay5b+BK8Vu4WJx0CMKIY4hwRSREvAaJiKKy+PG4fzifZuldRWmLJYeLH/xgyBSc9rsT4P/9VRD7/SinU9ChPO+GITbzVCs/1gRPp8k5vXEEJ+ExCE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34a::22)
 by AS4PR10MB5150.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.14; Mon, 19 Sep
 2022 11:34:18 +0000
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::814a:9d16:8115:f3d1]) by DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::814a:9d16:8115:f3d1%7]) with mapi id 15.20.5632.017; Mon, 19 Sep 2022
 11:34:18 +0000
Message-ID: <05bd7a9e-d895-bb7d-b114-f3eecdec3ba6@prevas.dk>
Date:   Mon, 19 Sep 2022 13:34:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: binding and generic support for external uart supply
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0081.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::31) To DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:34a::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR10MB5266:EE_|AS4PR10MB5150:EE_
X-MS-Office365-Filtering-Correlation-Id: bdbc53c9-0c50-4f97-cb10-08da9a32e36e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T+9ntOKb5kEOn62paJaVzFRowMFRG1HkUrPGZgSZ1NJYFRP/j31/OCiI920fss6hksTw2B6ie1wqXSf0zuNcEL7bEH2pN7RcOlKsGBpAInLqZ0JSzM1WW4BrlK6dPGjROE/AMRleNMH5B5onFmP4E97V85A1fgb7VsQqFmuwyUSEAbFyoPRKAIoGYb5hpuloHNFyywtBBfaVXQBXmaK0UxEr7a8x9FmeHmN0zi4H8db9qU2DN6NrRTUPWyyyBbQovIC2ttmCiyBMLKxPMf7tDUB4F8PSXXtYkQabdENnV9E0InlmEeTAMK7APPmPw383Nd+AzHeeWjCEVbt5UY8KNNse/gqvELb3RYrDo2VdWR78puQrEfC/TrMnwW3dzWy9oeOEMT9h5PI+/fyGRC5aWeYHmzJks4+DQycjVe+t2fPIJ5J6liQ/xsh0wBJe4eO1R0f7cVmZrNOOPhCI+Ls/sNY1tFYj/XdI+X1k0c/U1M16zi55N/keFcAyzDCd7qKkivv9EkxaVqGuBBP/TW0LimHwW0Nd7K6LJAOOIb7GmRlK+LRZ2nsBJ3RCMMapVnJoVBpY+PTpEVRqN/p+jg9WjcOb56XYGyPhE/zgToArJSAbjTe2ukMm5hzuagLZpzjPMHFjp7yzRwacN72ib+zKJvDgyeCdmeTpjzKSh362VNLRKumKjt3+HsI6R+kVSUW9zES2DaW36U/lc5QqE9IOZT8imHh5Opti98ifVJLMehXccJ8o8Hj20dBPCq43bts6oTk/Wp+VIATmXTzjqUpbgZ2z8kXpQJmhc4Dci7A6BAgVC6LYy2JViQ9hnTZnWYAuHKvbj9RmfLkoaZJ45db9FKwTd7lgxHO1GU79QzUiZNY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(366004)(376002)(39840400004)(346002)(451199015)(2616005)(44832011)(110136005)(54906003)(83380400001)(316002)(8936002)(5660300002)(8976002)(186003)(2906002)(52116002)(6512007)(26005)(6506007)(6486002)(4326008)(8676002)(66946007)(38100700002)(31686004)(66476007)(66556008)(36756003)(31696002)(478600001)(38350700002)(41300700001)(6666004)(86362001)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2xCVEFLVEVJQWQzSXF5cEdDbnlGUnY3SkoxUzk5YXpLaXNJb0NCWUxXQmJm?=
 =?utf-8?B?L3hIOFVoUmFDOGxVaGNjRmxIWkdzS1AwQkNNSWNCVkN5QkZObGpVaE5zbjBH?=
 =?utf-8?B?SlIwY1hSVHBUVFZrdUdRaWlwUEFLQVpLazdhU3pBZjlES0xEWW13UndIZVUx?=
 =?utf-8?B?b3BNUkRNMHVqSHFYVk03RjFVUFVYNVRoZ1QzbDZ4blJLZjg5UWVsNXV6Q2Ir?=
 =?utf-8?B?OEdXbXNuZVdrTXJ1K2V1Z1pibGRydUxXTndPdjZhS2Rxek95NzhIUS9sZStz?=
 =?utf-8?B?ZlYxYmJVRkxhbjgyVG83SnEvZzNwc09aRGJpMzY5Q01URVNvYzVTNXowVHFh?=
 =?utf-8?B?TXVQUkpUS0FzUXZ2emo0Y0YrUkUvOEVGZHRVOHZEZVQyZkpycFRiS1ZqY0dy?=
 =?utf-8?B?UG1SZWRhcmVPeHkyR3JLZVVEbGwyRmZ3Yzc5KzBVUzJZcHE0K1BNa0dNdmhO?=
 =?utf-8?B?SUVuRUFBKzI0TU5jNG44VG4yditUNWZHVmRFMXMvTTBSSXN5NU5tSDc4OW55?=
 =?utf-8?B?aUc5QVgzYXRBcW5WSm9OMmpsUXo3ZnZtNkQrVDA5YTZmb3djakFqTEJVSWpN?=
 =?utf-8?B?bHE2dTNYUU41VDc3R0l4VVBOeFFNdVBTYnQ2dytvQnZJTEdrbGxzM2gzWFJT?=
 =?utf-8?B?MVRCY3E5THRjUmdUMHk1OTVlcGtKYzZvVk92bkJ4c1h3bVlGR3RJeXVIWnNj?=
 =?utf-8?B?S2ZLRnk5SlFYMWJDOG1xaUVwZTJWTkVBWkFXY1RQTXVWc25HSEZEYURrQnRn?=
 =?utf-8?B?R3RIanRqeUhsT0NDQ0N1eHhldVIvNFJlYktHWEh3SDJLazJIcC94aXZ0Qk9R?=
 =?utf-8?B?ZFlWT3c5OEFEVTE2Lzk4YXMyZkdaUGVMRG1URTc3OXkxYWFOYVNWTlJabjRu?=
 =?utf-8?B?MStqY1M5TFJSQVZyVHpSMDVPanZjZnllU2xYT2VaV214ZXM4Q1FPRnV3WHo2?=
 =?utf-8?B?TlJFd2FIaDJrRGVLWlhHWHlWZUFKcDBPWFBzamk4eG84ZDBxdFg1OXJNZFBz?=
 =?utf-8?B?dHYrWlVBQkk1ei9kSFhMSlI4eHpvOTV4VG10RHhEU1l4Y0ZjTjJVLzdaY2pz?=
 =?utf-8?B?SFVTV2F3NVZxcXhjVWJLZXhYUFBxdCtDWFFSZXRPSXNNWWoreTFiOXFSaUZ5?=
 =?utf-8?B?cmgrc3k3Z3BNMVpHZDRnZ0V1cWhVVVBQcWJpNXdJY0VQKzc4NU13T0RZU1lr?=
 =?utf-8?B?bms5YmVENW40Y3JIUUxmOG1CQ3J6cTJaMUhWZmlRNU9IKzhneUExSndYMUs0?=
 =?utf-8?B?dlhGUXcrcWpZWTdaejMveHB5WlBpRGFpdXBiQkRJMi9JcEdQb1hOK3hnT1Y5?=
 =?utf-8?B?dktKb2VlZVk4MDREUmFJNDNVaGxtc1B1WWZtVWliNFdMdjVsb3ZoUHBNczQv?=
 =?utf-8?B?Q2psa09jTU5lSmJDcXY3Z25CbEpQT1hRK2M5cnNhZmdHUkxEQVFBY3ZCejg2?=
 =?utf-8?B?N2tZMHppRjZJa1VxdWtkTklqbTJPVzdhYld0N3k5bGZ3MWo2cXdXbytjRkhQ?=
 =?utf-8?B?VE0xcitQcm15UlhUL3o2ZWFROGFLZlNkc0NwLzM4V1NKNFhJSlJyQ28vVnln?=
 =?utf-8?B?cEdBeTR3OWh1MkM3MElJQVUvV3AwY1E5Tk8xZmNCREJmSndCOFdETW9DTXc0?=
 =?utf-8?B?VkVBcEMvV1lMVHdRUEJ4cjZhTTZBZ1dmejJLT2JOMTExVTNTK0NyT2ZFdWhv?=
 =?utf-8?B?dVc5VmNDVGRvYXJqamwzVndvemxqTUs3Nk9qRGZadGg3ZE9keHpRWWllclR6?=
 =?utf-8?B?Yks0K3A4TWtRZUJmV0VQeW5oOGptNmlvbGE4d1hyNFI3VjFyYkFlNTdPRGJv?=
 =?utf-8?B?OEphNElLSmRBVExLTDhialk5QXNxL3YwWFlxVU1sVllBdEloL3NPc0lCZGZl?=
 =?utf-8?B?amRDSG1udzRGeUplQTZ1Z0dyNXIvbVcrUUEySlV0N3lYSmRZcTA4VjFvQUpH?=
 =?utf-8?B?NVFjVy9BUWtIbDZYVzBJQXl3bEF0d0g2SEZqZmpFWFJkbGpRVDlzNUdkczJs?=
 =?utf-8?B?MFp4dXhFZ2NQdGo2MkV6WEJNV0dBelllSVl2SytzSG9Hei9WeTcrWEZCNGtD?=
 =?utf-8?B?cUxsYlQvd3dUbWtkM25nTXcyNEVpbnpMaVpMeUZkTWlnSG9Mdnh6ZG5mUFNF?=
 =?utf-8?B?Qm01UnJHL01QVWdrZEI5YUx1UFVCNTlIRTVMaVhTYVRXNGpicnVHeEVFTlM0?=
 =?utf-8?B?emc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: bdbc53c9-0c50-4f97-cb10-08da9a32e36e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 11:34:18.2640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7I1Vq2hlGkITAlZblXRFoaUTVRFI2IuDccnOtqexSw8dNebAW3yfRlXa5SzJVeOrPN5BW1ariCgHskgai/gDvMxgBRDYOER6bkWIo1oyYXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5150
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

I have a board with a couple of uarts routed to external connectors,
through a galvanic isolation. In order to actually use those uarts, I
need to turn on a regulator (in my schematic called 5V0_PERI), which I
can easily describe as a fixed-regulator with an enable gpio.

However, there doesn't seem to be any generic "ext-supply" binding or
similar for uarts; I would think this should be in
Documentation/devicetree/bindings/serial/serial.yaml if it did exist.

So the first question is: Can we add a binding for such an optional
ext-supply?

Assuming that's uncontroversial, the next question is on the driver (or
rather, as this is quite generic, serial core) side: how and where do we
enable that regulator? There's an uart_change_pm() which it would seem
natural to hook into, but that returns void, whereas a
regulator_enable() can return an error which I suppose we'd need to
propagate. Then there's uart_port_startup() which sounds promising
("called once per open"), but then I can't figure out where to put the
corresponding regulator_disable().

Thanks,
Rasmus
