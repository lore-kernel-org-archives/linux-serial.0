Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBF8C6FA8B
	for <linux-serial@archiver.kernel.org>; Fri, 23 Sep 2022 16:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiIWQ2p (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Sep 2022 12:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbiIWQ2W (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Sep 2022 12:28:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14284137468
        for <linux-serial@vger.kernel.org>; Fri, 23 Sep 2022 09:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663950495; x=1695486495;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VDnmYox05kVtaHjr9CzVjMkCKsraW1+lTkpYFPFNrWw=;
  b=fsb/0INfCT4TtT9AgYpy/H3zJv11z6z4GWhmr4IVqy0MCCPgspkjDXZw
   PPUgcQ3l1EWoh0buzJl/XvdC75fnTZVkTSM9pVZDhCoqXV/3i5asOHgTB
   /tGirMTEdzet/lRd2lQoh3vpqpJFjdHdNeM2hSBjRSgXYKhZSwmtU6Q+V
   RjnKcshZxMxoLlmbnsGn/DU3H63lLL723UjWhK5b++qYziITNjpI+UdrJ
   OJH79VUgKMZZhVsNu+VPPQ2gdRLh/SXFNKoJV+ja+v37jS0sXCMVCMnSR
   fFFfQ6C3BJU5uaN1LYBMDjrKtEXkXOHscZm18XUVRuADbG+ItDw3rJVlA
   g==;
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="175320544"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Sep 2022 09:28:14 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 23 Sep 2022 09:28:13 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 23 Sep 2022 09:28:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5abIyyl+mWao/c7Ixg9HrDdFKPwGdh1slQ+4aWx2MzZaGi+DHslaLJXnkpAQgos7M+p6PCbd2+h1kIIJTI8hTGoilpCvzd5nkrg96zRUBY58//wy5PmRK57+dTclgEu/KGEMoNEuCibkdz3KNzUZF5U4qCw2UMil8ljdpJy0uPAjUbmYRKCYQOlwgxKga6EB4vQ4F8s7E1l0fm4WRpKm+j6Im/FUU1DgVmLu/VI+KHnOmQDb38vvgWHGpdPP2r/ryxuPWjw0g1OZigV3gP+YuwOTL9FwZxarrPYag7fwQTEeGSlZw4b8TycavxeDprcugsrU6G8AjOI2kc87iPvoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDnmYox05kVtaHjr9CzVjMkCKsraW1+lTkpYFPFNrWw=;
 b=OHcWLJfo70ligySHLts7WjElF83de7wzvtreS8WTnFGIytpDDfj2X18uFFIlxSXU6PAjvFSqYcu33/DNSd4dreZeQU++gVwuQo7pXpz9LIRcfVlcI/u1I1f4PsLylfnuSEV8F4L55YXsdSh8264Uzgsa2A7tjTtJbf6MSv+wB5z+UKpa9w0xZrYG/2LIntxH1YYRb9Q9meqJCkpWbctlNN/dr+K4xKyjW9glyBZGAU56SQveyC0RoNUieFD8IFNi2Y4orQt8HxWQ04nhbUjx1wZ+RPJwPRtaLuEwKBdut5wex1AAuOQQ4CxxcDASZi1rg9ZiQnLwmY6bja42QHCIww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDnmYox05kVtaHjr9CzVjMkCKsraW1+lTkpYFPFNrWw=;
 b=StzpzuYtWGVkS/v4dfZY6X2bZIU2P9RxTBp7Ro72NKytUj0aobnlQf/JNJyUo+9Prl52bsMZoV28nd3oOSeHyEcnKk2g+d/YTB6Fo5nhn2tzeEybvTu7879CfUT29E8hULei38pQ/JnTVe2VQsiL3snF3mtcULCGgdHDztWKnIQ=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by DM4PR11MB5424.namprd11.prod.outlook.com (2603:10b6:5:39c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 16:28:08 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::2cfd:fc73:ba36:ae64]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::2cfd:fc73:ba36:ae64%4]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 16:28:08 +0000
From:   <Sergiu.Moga@microchip.com>
To:     <lkp@intel.com>
CC:     <kbuild-all@lists.01.org>, <linux-serial@vger.kernel.org>,
        <gregkh@linuxfoundation.org>
Subject: Re: [tty:tty-next 42/45] atmel_serial.c:undefined reference to
 `__clk_is_enabled'
Thread-Topic: [tty:tty-next 42/45] atmel_serial.c:undefined reference to
 `__clk_is_enabled'
Thread-Index: AQHYz2jbk47DDwDOFUCzdmVlqMA/a63tNBqA
Date:   Fri, 23 Sep 2022 16:28:08 +0000
Message-ID: <700b1dff-fb79-2cff-bee7-7172ed33b152@microchip.com>
References: <202209240013.GWFiVnCP-lkp@intel.com>
In-Reply-To: <202209240013.GWFiVnCP-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB2758:EE_|DM4PR11MB5424:EE_
x-ms-office365-filtering-correlation-id: b83118b8-3dc1-4084-5c20-08da9d80996a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2LfTd48qWBFFE19NCTIMhh6LoVQV0zzyMUBo5FySP/Ez7JWA6kFpJi4CM0UCMsdUhJUpiNNyuGepc074eXVb9FLT3PEvtQ0DlX1fv5LAAG5Ec2gBW1sjknmhjOrq3zweNKJwI1vSgP0z//kfz/2pB6ybcGT+6YeNEUALat0S4dSIeL1KuJVHVu6HQFQYaCgKYVdBYeTR441gf5nY9+IWP1AF8LCX5mLL8MurETTz8qHiXOrb3yy1Wr909/xl5iI6c2p6r5KkmVbpZdYtNjFYKwduzbx9NiMgybpVh1jKZyXS/BjYqHPatXDQMXaT9GIZ7ylnnQojzNGceDE+9J++OQJZo4ZIiwaAWTL5YhjTtl3G60xSsPsnOBrAcgNTiXAww2WT3xNHXs7sZg5O7iAp4mWsyNSlqGzNb79bJ+FyBA/Eca48VtSe6ZAipgrwkT+LIDHDF9u0Bz8q8zslUjijeyVrPSripMunY3WovBLxq8jFzON+xYH23AUGBqVPcQc3UtcOxnbjreYDzFye5p2pkwrh3IjVc2+jdGZHhSQfsueCRq4HYZ/H0qNPgrfUxqPwbS4Qgcpc+W1ov0fCE+6v1Vxp2b3pM68qVTYSA3y4nr9/K+IWWaU/5pu8GRnX89gC9ZOS0T/wVrtxwq/ZmYHde77d1NA/QvGP59Wih4aj7dI9IcbvkkFba3Zgh6sJ6Q5oxPJAME+HHySc7T11ilcU1jnUa3piKhecO7s4MNAiLNXzX/TIR42A5HQu1OcD5lIry4KZ3AMygAmZcp96Cwb3mQk4A8xrH8a12VvSvYLe+ASc9tXyqpOtwCvi463fGYF07NUoWbmmfGCmyL+bIurxt4mSJvUYtpltP/q7q3jLS3L5zNMep96rerno/9E48aQW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199015)(36756003)(38100700002)(31696002)(71200400001)(86362001)(38070700005)(5660300002)(122000001)(4326008)(6506007)(26005)(41300700001)(6512007)(8676002)(54906003)(8936002)(316002)(66476007)(478600001)(64756008)(76116006)(66446008)(66556008)(66946007)(91956017)(6486002)(966005)(53546011)(83380400001)(2906002)(6916009)(186003)(2616005)(31686004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjV1Wmh1VTFIdFR6VEZNQk5aVGlBN25uZ0srMkdXSkZjaEVvUytVSnFsV0dU?=
 =?utf-8?B?bitRZWJpblRIdEU1RVRBT3h0K2VhV3cxVTRTcXhTSmlMMTV5SWxzU0NrSHJX?=
 =?utf-8?B?aUVwdk5CRFhjZGVJcnZLUVAzemlyR2ZxLzY5NG9Fdkt5dElFMExROUhHTFRW?=
 =?utf-8?B?UkhzWnV0VWNPWmJoRktuY1IwWEJkZlgzUTJnZmZxTWdERXBqSUdmWVg2Nm15?=
 =?utf-8?B?WWF2Vm1MeVIzUVMyOCs0NlgrdEdyR2ptRVVnTE1KZy85QmtlMzJTd1pXTmts?=
 =?utf-8?B?OTZXSDVGaUhyUDhzemoyalQ5TWIyNnlma1dPOXVacFpDTzh0dVZ3WDl5bnps?=
 =?utf-8?B?cG1Ra3c5Q2QvN2hnTXUwb1NJNzZ1L0pERVpZMnNldm1wQXgyTEEza0wyVmxs?=
 =?utf-8?B?c1c5MUNVYnpVcDV6Wjc1dkJwb3dkVkRnSHJ6ZVhCVCs4VUxUSitxdUtiUFVV?=
 =?utf-8?B?VW5WQmdvYy9wQ3o5R1dDaGtoQ3ZtQmQ4UFBOTmJsSitFS2lGQXBJSnQzUngz?=
 =?utf-8?B?OTdJVlhiMWc5dVg3eUZwWjdFZ09lazJvVzFPY0Zoem42NExwWTRCMk9mbGFw?=
 =?utf-8?B?MnMvNldVVThQRUtXWVIwSEpwN0kvMGRZdEdJSit0NnVMYlFMRU5WOXNFbDY1?=
 =?utf-8?B?MUNybVNTRTduM1Y3UDJGV1VBc2RVZHlWV1ZjVGJlMG13RmRoWi9nK3RZUG5w?=
 =?utf-8?B?UEg0NzNGejZkelloN2wxRjVXQzRodktKQmd2WEQ1Z2JlSUx6SG1tNHU3UHBp?=
 =?utf-8?B?ZEw5K0lRS0M1VFVuY1JpMWp6LzlMc1AzcDllWUVPN2d4cFdYVWR0bWZSL1pi?=
 =?utf-8?B?ZERCVHBwTUFvcVZmb3N0MWFua2hxMnhuQW9nUit4R2hlcEJiK3ExRE9xdDBO?=
 =?utf-8?B?L0M4M1JoWXV3U0hoTGU5TUdIU1hBbSswSjkxZnB2L0srMUdST2lWWDArRzBU?=
 =?utf-8?B?Rk9tU1F3ei8vUnBWaERHMnVnV2NmL3FLZXhPWG1nWThhZUdid0dUYS81cjFY?=
 =?utf-8?B?b01NTUhQVGl4NFVmeERUZVhRSWJUWmw3ZUY5blFuQWFlM215QVkyZlFzaW4x?=
 =?utf-8?B?Q0JWOXhjSkdJbzFaS2Q4TndlenZYRHhGR2E4blZ0UmpNRUtlUkJaSmczUnlU?=
 =?utf-8?B?VDVNNXc4NlYxM3l3MTVnR3VET3ZobkVITzQ2WlhHdVlxQS93d016Y2c5Z3ox?=
 =?utf-8?B?WnZwdVJIa0JodVRHU3h1dU1TbjhySlA4U0o2TWh2clIxYzBqNHZpOHh5eEJY?=
 =?utf-8?B?ZkZ4TmRFWmZ2c292M2VmcTdhekl2Tms0N2ZQSmVYUjkwbmx2TzdmOW1ENDhp?=
 =?utf-8?B?MVZQOG9tYjkxa09vOEhYR2ZYendRTG1ZM0tuakN0WEJraUVreHZWMHZwNUdy?=
 =?utf-8?B?dENlVFBXU2x2aVQ3V2F3M3JhaXIvNTJjNDF2RmhCbktqVFlCaUZXZHdTditj?=
 =?utf-8?B?ejc2SnpGbkRjUlFJNFlJM0FZZVArUXVFM0hqZkhtdG1wV2s2dVNwK3NWcHNu?=
 =?utf-8?B?ZU5VNExIbEExRjRXa2cvN3NiOGRyT2Z5c09laC9vVE5IeURTYVMxN3pKdnVp?=
 =?utf-8?B?TkVidERESDhYeVRKTGR0TmxmUmdMWDZKcFg2SXRUL1RZMXQyWm5oWXVaU0dy?=
 =?utf-8?B?blVLMG5aUmdtaDNZRGl3RFFnNlpNTi8zRXA0dGRjd3BqWGFnQUVTdG5vVmtZ?=
 =?utf-8?B?cmFUNUhSZmFGSnJjOHJrU25ZTHBHWThzMXlqZ1pueUJEa0ZlZXlsaDkwRCtz?=
 =?utf-8?B?TCtvb2dTZGd5RUMrd2RTeFlCOGJHdnBQTE51MzdLaUttSGpFUm1IOTRuZFps?=
 =?utf-8?B?cllSZFhkQmNUMVBVMWVyRnl0RkxTeWJJNE5XSDBlcC9YUXVCVEFQdWlscmdI?=
 =?utf-8?B?dnBCWnphMmlFbG1hcFIxc2l6ZXI2RUplVkZqWEdpRHJab0c3dVZBMkVzQ2c1?=
 =?utf-8?B?SndXMTRNcEpZMiswT1JSMXdSTHVoV0RmOTdndnV2SHJjd1FLNXgwQ0tOK3lU?=
 =?utf-8?B?QytDb2hvV2NOOHc4SEFJb3A0Z2p1Y3ZRd2VmTUwzclR6d3kwakI3L1I0aHk0?=
 =?utf-8?B?VTI2cHZrTGF5V0twZFF4OW1OaU5xcFhLcVdrTmR5bGJrekJwcEV5OUwrdXFn?=
 =?utf-8?Q?IsYQDJU3kuQnawiNbN4S7tqJm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8FD5FDDE6600C4CAB4B060CB3485572@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b83118b8-3dc1-4084-5c20-08da9d80996a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2022 16:28:08.1449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V0ZY6Lkct4ctGKDBUZW0Ahk/wufL+Dcq8IXUzaxx/W7o4TC4VNRW8lvp6QvCIlgpOBa6Dm+CdAIxj6puas99/D0eg1UH1O5Gollgr9+KhZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5424
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

T24gMjMuMDkuMjAyMiAxOToyMiwga2VybmVsIHRlc3Qgcm9ib3Qgd3JvdGU6DQo+IHRyZWU6ICAg
aHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvZ3JlZ2toL3R0
eS5naXQgdHR5LW5leHQNCj4gaGVhZDogICBhZGFmYmJmNjg5NWViMGNlNDFhMzEzYzZlZTY4ODcw
YWI5YWE5M2NkDQo+IGNvbW1pdDogNWUzY2UxZjI2MTI5NmJmZTRiYjU5YTk4YzgyZjQ5NTlkMjE0
YTRmNyBbNDIvNDVdIHR0eTogc2VyaWFsOiBhdG1lbDogTWFrZSB0aGUgZHJpdmVyIGF3YXJlIG9m
IHRoZSBleGlzdGVuY2Ugb2YgR0NMSw0KPiBjb25maWc6IG02OGstcmFuZGNvbmZpZy1yMDAzLTIw
MjIwOTIyIChodHRwczovL2Rvd25sb2FkLjAxLm9yZy8wZGF5LWNpL2FyY2hpdmUvMjAyMjA5MjQv
MjAyMjA5MjQwMDEzLkdXRmlWbkNQLWxrcEBpbnRlbC5jb20vY29uZmlnKQ0KPiBjb21waWxlcjog
bTY4ay1saW51eC1nY2MgKEdDQykgMTIuMS4wDQo+IHJlcHJvZHVjZSAodGhpcyBpcyBhIFc9MSBi
dWlsZCk6DQo+ICAgICAgICAgIHdnZXQgaHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29t
L2ludGVsL2xrcC10ZXN0cy9tYXN0ZXIvc2Jpbi9tYWtlLmNyb3NzIC1PIH4vYmluL21ha2UuY3Jv
c3MNCj4gICAgICAgICAgY2htb2QgK3ggfi9iaW4vbWFrZS5jcm9zcw0KPiAgICAgICAgICAjIGh0
dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2dyZWdraC90dHku
Z2l0L2NvbW1pdC8/aWQ9NWUzY2UxZjI2MTI5NmJmZTRiYjU5YTk4YzgyZjQ5NTlkMjE0YTRmNw0K
PiAgICAgICAgICBnaXQgcmVtb3RlIGFkZCB0dHkgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQvZ3JlZ2toL3R0eS5naXQNCj4gICAgICAgICAgZ2l0IGZldGNo
IC0tbm8tdGFncyB0dHkgdHR5LW5leHQNCj4gICAgICAgICAgZ2l0IGNoZWNrb3V0IDVlM2NlMWYy
NjEyOTZiZmU0YmI1OWE5OGM4MmY0OTU5ZDIxNGE0ZjcNCj4gICAgICAgICAgIyBzYXZlIHRoZSBj
b25maWcgZmlsZQ0KPiAgICAgICAgICBta2RpciBidWlsZF9kaXIgJiYgY3AgY29uZmlnIGJ1aWxk
X2Rpci8uY29uZmlnDQo+ICAgICAgICAgIENPTVBJTEVSX0lOU1RBTExfUEFUSD0kSE9NRS8wZGF5
IENPTVBJTEVSPWdjYy0xMi4xLjAgbWFrZS5jcm9zcyBXPTEgTz1idWlsZF9kaXIgQVJDSD1tNjhr
IFNIRUxMPS9iaW4vYmFzaA0KPiANCj4gSWYgeW91IGZpeCB0aGUgaXNzdWUsIGtpbmRseSBhZGQg
Zm9sbG93aW5nIHRhZyB3aGVyZSBhcHBsaWNhYmxlDQo+IHwgUmVwb3J0ZWQtYnk6IGtlcm5lbCB0
ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPiANCj4gQWxsIGVycm9ycyAobmV3IG9uZXMgcHJl
Zml4ZWQgYnkgPj4pOg0KPiANCj4gICAgIG02OGstbGludXgtbGQ6IGRyaXZlcnMvdHR5L3Nlcmlh
bC9hdG1lbF9zZXJpYWwubzogaW4gZnVuY3Rpb24gYGF0bWVsX3NldF90ZXJtaW9zJzoNCj4+PiBh
dG1lbF9zZXJpYWwuYzooLnRleHQrMHhmODgpOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBfX2Ns
a19pc19lbmFibGVkJw0KPiAgICAgbTY4ay1saW51eC1sZDogZHJpdmVycy90dHkvc2VyaWFsL2F0
bWVsX3NlcmlhbC5vOiBpbiBmdW5jdGlvbiBgYXRtZWxfc2VyaWFsX3BtJzoNCj4gICAgIGF0bWVs
X3NlcmlhbC5jOigudGV4dCsweDE0ZmMpOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBfX2Nsa19p
c19lbmFibGVkJw0KPiANCj4gLS0NCj4gMC1EQVkgQ0kgS2VybmVsIFRlc3QgU2VydmljZQ0KPiBo
dHRwczovLzAxLm9yZy9sa3ANCg0KDQpUaGlzIGRvZXMgbm90IGFwcGVhciBvbiBBUkNIPWFybSwg
Zm9yIHdoaWNoIHRoaXMgcGF0Y2ggaXMgaW50ZW5kZWQuIFNvIEkgDQpndWVzcyB0aGlzIGlzIGZp
bmU/DQoNClRoYW5rcywNCglTZXJnaXUNCg==
