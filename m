Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E63EC433EF
	for <linux-serial@archiver.kernel.org>; Mon, 20 Dec 2021 10:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhLTKHw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Dec 2021 05:07:52 -0500
Received: from mga09.intel.com ([134.134.136.24]:32366 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230422AbhLTKHw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Dec 2021 05:07:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639994872; x=1671530872;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ol8CJ3pCU3GvZPP9/mFAe2OZhqCofIhLLLw5s9/RCQc=;
  b=gmxF1ueLdAJlB882fBiRC2xvBD/eaTKJ0AJ3/Ff73pSYcWGDK86OhAoo
   zuRtaObLmGCeUfBGF2q4rJtwAbGbHOxKO1xEsfMTAyIJwNc7zsa35Mz/W
   jj+fpH+rjC81o5vcFKPODKpyt23Pns5JeICsUiR0QocM96sWbYgf44VT5
   ILLS4KPtbYGZ86/wb5nacxh7IlN0UV4QBY9LjtmS4K6MKI7Dxr6QyM1Ov
   kLApQ4xyxqRuWUZ/wbbdbQTYm84OEXF1m3B2Cy2kUMuzM2FavfFiCW9lT
   MG24ccM0+FUBs38BxFGBhIz52aGusqDmHnQGBh4mUyfRXuuzdzi8BOOmB
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10203"; a="239945092"
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="239945092"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 02:07:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="663573047"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga001.fm.intel.com with ESMTP; 20 Dec 2021 02:07:51 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 20 Dec 2021 02:07:51 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 20 Dec 2021 02:07:50 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 20 Dec 2021 02:07:50 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 20 Dec 2021 02:07:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGWQi75s3ixDEueLUnBlCh1AJFAybs/xSXU03le+FX2TBVTZumPc1EZd8oJgJ220/jre9TBZzuUjcGImdqo/mC8FHBdYB/ZLqTJeIRhsjG516d+C6LjaaZjcpD9EjydEes3zjZSzj5csj+S09hAcKNPAGfNwbLpg9CFNaB4z5KvWX1v4v5llO8hgOgMUs1a7zjphR+P1yA2IRK0R6Bv29BHb98gkWrAE4cAJii8VfLseF7br6x90TElE3g3RNjBtcKHaGFzvgaoh1quvFIawfrLIqlu91ctuMH10Py+TSkm/ZgzU/YD4Tuepmf+RJRfhOCwwpdvqABdxOOlKPUg1Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6DgKi/p/925mi7TivrvYcLkRRmeSM3S5C9Adf+4oeo=;
 b=SkVRvEb6+AYznpRnvmpdYbGe90JsROdhNNYxb9A0pPj5FdsoPovIl3HRR2HROhv2Q1p47aIaA6FYM/DoGobRxPjSg5rHWQuB8QjHBbZPOcWDwBrLWIeRRkIeToB/pbKmmkaj7KCNlYtf0JtSvjSs4Cj/VAfCTzxkdSLAIY1hWf1AIfD1Vm785lMVzRjwD71+uTsS2NKlA/dAgKn8Av9Sbp5KIDPT7SBASyeVMJgHC/n6TmBq3uEuZ97iBngu+tAiSEHIHRNlhlOXmyzF2yYKAGE5LEv6fJG6SevPPo/j0wEz/iVh5JS1PTN3z4ydWeGthxMZpyr/tmzlKMZVYDSkBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB4739.namprd11.prod.outlook.com (2603:10b6:5:2a0::22)
 by DM5PR11MB1932.namprd11.prod.outlook.com (2603:10b6:3:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Mon, 20 Dec
 2021 10:07:49 +0000
Received: from DM6PR11MB4739.namprd11.prod.outlook.com
 ([fe80::5d13:b5:7aa3:2a16]) by DM6PR11MB4739.namprd11.prod.outlook.com
 ([fe80::5d13:b5:7aa3:2a16%8]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 10:07:49 +0000
Message-ID: <3f82cdd9-c1d9-2dfb-45b0-55d0a419c96a@intel.com>
Date:   Mon, 20 Dec 2021 21:08:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [BUG report]: serial8250 unbind/bind failture
Content-Language: en-US
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
References: <DM6PR11MB47391ECD2402AB4F521DAC869A7B9@DM6PR11MB4739.namprd11.prod.outlook.com>
 <YcBThJYwRk1i9emo@kroah.com>
From:   Jun Miao <jun.miao@intel.com>
In-Reply-To: <YcBThJYwRk1i9emo@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR02CA0196.apcprd02.prod.outlook.com
 (2603:1096:201:21::32) To DM6PR11MB4739.namprd11.prod.outlook.com
 (2603:10b6:5:2a0::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e340dee-9567-4574-0f93-08d9c3a093ff
X-MS-TrafficTypeDiagnostic: DM5PR11MB1932:EE_
X-Microsoft-Antispam-PRVS: <DM5PR11MB19327818308A74549E8BF6569A7B9@DM5PR11MB1932.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tvQLzvWsCjHWT2BjuZXUzOPsIVxwBfRAh31TrKvRKPw+vKEzQZ6b36iwoZgDjqQrmXoPVobZdIA98tHSwIq1mhtzOj3lPJGCv6ziKZSa0gCr3ceS+9MznAtNYfdfB9us4I7CVElC6jJGm084oDhBe2uwDa0NFHgQQJFqTwiDEA8srMhRfTXp8NfVFGcQiMBA2gwcq3kvQSs6mHuegpotuQX52qlhvhNtNXCmCthwSqxtlehS47O+6RPkeq0dmbtmI/5TquVw9YCfIHqmHK0XsVuGFwWSRBiRTNz3rJytX3paNk/fpHhxPArX7qPUQKoPZxEG4bbxHNbS0UoifA7EANgb1XyGyxqufHh6pqjZ3ZnlsqOmOv0RMeOxuQsvRe21p3nqTnlannY94XVdXh5l33NSUIz0JDdtqOK4t6MynuaE+8rUXPZOp0x1i4Ghuh9YRNUXV//Zvz3eR3PfOQPrA0UUlvC3tV3u1wOjfuAWt07GL3iY3ZPCx3BnLz4r/PDwSb93ApM+8N5d3OZHO/52a/AdHu94yaWlrlG8oEURa13fpKZ6wuMDkGES/uaQ3B6o5obFdJz0OSphthgVchPo1udR9UCi4W0gdrqHHLRakjp1XDNUqiMk5FZmVZFiUT13JItPjfV3HSpmlR276Ez7chyobu5+X2AoGUrVVaVFb8NO7qVtskAQAFK6za4Acgz7Uht9Ts4Op2l+XbqqhCTV7P6nQIXMU808U8xq/Xy3Ekk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4739.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(6666004)(8936002)(86362001)(4326008)(38100700002)(316002)(6486002)(36756003)(31686004)(6512007)(186003)(44832011)(54906003)(26005)(82960400001)(66556008)(66946007)(66476007)(31696002)(508600001)(53546011)(8676002)(6506007)(6916009)(2616005)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDBVdmxtdHMrYklCSGM1RjR4KzJDV0hGdWJmdXFXbDA2NEVzSXRpZmV2ZHdU?=
 =?utf-8?B?SDVSYXdvMC9aYUkrdXRHRklUQk9IRFJGMTJpRXNraW05VXhWa0ZQa28xUVBS?=
 =?utf-8?B?SmZhWDdhbUNSSjl1eDNSV2ZibjZMSTNOWVUwMkVGTTJGMHFwQ2FtSUFlYmhE?=
 =?utf-8?B?TXhFVG1ZeFJyWTMyUDRLOWduczBuVjlrZGc4MW5PTUY4U0NxZVdrOVJOVHZW?=
 =?utf-8?B?OGUyeHIya2hhM3NmVU91YittVDNqT280ZldrYksvbFpqUlh6aXk4Z1IwV1gx?=
 =?utf-8?B?TnlBcHEwNFREbjAxakUyTWxORWxEOEEzdDZ5N2kzSnF5NWJIYUE1Nll2ZTNt?=
 =?utf-8?B?UUFhYWJSaEJRY3R3R3NFd0p1cXNwaWIzUE9Pa1UwSXUwMmpIeVJXRG1mMFlF?=
 =?utf-8?B?bTlGeWdjdGdiaGhHVUgrTDVTeUFQQUlmUUFhQlhhRkhERmZSWlc5UC9heWpS?=
 =?utf-8?B?YjZDNVRBYzVqNlEvVEZzbk0yT0xYUVh5bldBcCtaeURCNkR3bC9udE9XWG0z?=
 =?utf-8?B?a1VDQUYyRENlN0Z0VjJoSVlkYzQzRlBHZlNEdGRROEFmaVpvdVA0QkZaVExJ?=
 =?utf-8?B?emRjcjVuZFFic1lhNzNrYnlEeVQ1TFIzaTE2TUpLd1ZXdE1zcW1ZYzh1YlVW?=
 =?utf-8?B?ZzduelB1YUI2eTRRMG5UbzRWMG1mVk8xUi9DOU5uTDNqZC9QdWc0QzJVUTJs?=
 =?utf-8?B?NWgyTWo4QTdzRnF4U1RHblRQSUluRVhUQURxVld5WGJ4V3YycjFFT0U3Q2FY?=
 =?utf-8?B?ZzJWTXlKTFJoT3lDc1BpU2FLcnMyUTFDMFdMaFR4c01sT2Z5eis1Y1FNaVdv?=
 =?utf-8?B?clpsbFJRZUY5dFBEOUZuZFdJL2g1YzZVcHRrU0JiV2ZqTFkvaFdDem9rZHl2?=
 =?utf-8?B?d1RhcFJUa3hRRWZCaGQycStDR2NMd09jREtFeXR2blhOVzR1MFd6QU1WY01s?=
 =?utf-8?B?TFBWaXh0cEdHRkJCNVFpQlA3VFVaY3ByYjlzRG9weisvazRrVm5YcWF6S015?=
 =?utf-8?B?WHhac1BNRG9VaW1BbmdIbUFMbFdWVndUYWVuM0UyZVRHTVlxV0FNZE5XRWxP?=
 =?utf-8?B?dGcvbjBYc0FuUVR0OTBvUWhLeTVwaTNmNVRWRzk0WEdCY0d3MStsRVoyNWJl?=
 =?utf-8?B?OTE3MDFPdkcvemVkaGZrYmlwdVBQNWRFY2JCUTJhb29JbHRoVTNscjRsSFlo?=
 =?utf-8?B?NkU2OWtkTzduR2tDSU1nSFBSOFliSmlvQ2ZWQXV2UWl0NEJ6eVZ5T2NkbjZC?=
 =?utf-8?B?ZjYrd1QwV1dWeTFOS2U0VGxXNWRTTzVqWmczdDVrVURhZHllNHVSTFFMYm4v?=
 =?utf-8?B?RTIzSkpYRmMxZEtKaVJJVDlMSDFJSkJzT2k1djN2aXp6bUlibVRJRTQ4K2ts?=
 =?utf-8?B?cEpUZ3NGVmNENEJ4cHBReTM3VVJxdmNHbmtuNFpMTnJKTE9yZkF4NVFBWjBL?=
 =?utf-8?B?ZnVpMVlNb0x4cFNCbjV6NCtsMmprdHY1RG4rWE9HMUJ5WFdtUk9RQWpod0Zj?=
 =?utf-8?B?LzJ6V1FjbFNiOGlyYzltZVl4elltZkFHaUdFWTRUWXQveFFYdmlYSkpZaDRR?=
 =?utf-8?B?RmR0QUZLSHg3ZmxQTjdMK3dEQ3FiY3pRc0lyVnIyTDhPVjFyQXgxelY4NFV0?=
 =?utf-8?B?Z2ZXYktoWDlzd1Z5dWZqaWNlMTYxVTRqQlZoOUtFUW1hVUhIZVlvL2pHTTdJ?=
 =?utf-8?B?eDFiSCt4eDZhQ2VWZ3lDUFpES0QxZVZKN2FoZTFTcEdNY1RXbWk4dHZFajMv?=
 =?utf-8?B?TzhTMDRrY25kSDdEeXFUUEhBcUlKbGRIcFlDSWJKR0VZODAwY1pydnFFdmZN?=
 =?utf-8?B?cGpVRlJtMDllNmVkUmtPbHFvUWFkdDNOVnpaY0Z4d05aeGxZVWhRWU91N1lv?=
 =?utf-8?B?SE00V2NTaW5sRnlQdTIyVnpqblgzdWhBWlNTM2EzRXd4NUU0V2VFWS9zY2g2?=
 =?utf-8?B?MDlRb1BZdC9YcHM1NElVb0d5RjJBazJ0b3NRa05tTTdpMTVFbTRZZW1OMVkw?=
 =?utf-8?B?QUt5Q0c2dldnMU5YKy94aGJhMjJqUUtWMXdzN05xMUNlSjJpandwR054dWIz?=
 =?utf-8?B?THFjSWdhQkgvZlg2K1I2U3JwcFVGNHlVUEpHV0xEMjJ6Q0xVZkRHQ2VDbkRN?=
 =?utf-8?B?cmx5bUJXM1pUejJrYnFxendIV1gzenNZUmZGdHZidDFPR0wwWWtVc2t6ODFq?=
 =?utf-8?Q?xB91nLlBXRAswR6gL6zCcLE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e340dee-9567-4574-0f93-08d9c3a093ff
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4739.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2021 10:07:49.7772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQwN/LcF5+2vDfi4fTyIIUeXVgR/cuJevMH2yNfXwMaQMfnf+sOo4OCUF7GxJXeo/B38beSv5Bxis/L0cklOFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1932
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On 2021/12/20 17:57, gregkh@linuxfoundation.org wrote:
> On Mon, Dec 20, 2021 at 09:54:41AM +0000, Miao, Jun wrote:
>> [Hardware]
>> Intel Corporation Alder Lake Client Platform/AlderLake-M LP5 RVP, BIOS ADLPFWI1.R00.2265.A01.2107010436 07/01/2021
>> About x86 old UART, not the PNP device.
>>
>> [how to reproduce]
>> root@ALD-M:/sys/devices/platform/serial8250/tty/ttyS0/device/driver# echo -n "serial8250" > unbind
>> root@ALD-M:/sys/devices/platform/serial8250/tty/ttyS0/device/driver# echo -n "serial8250" > bind
> After you unbound, this device is gone, so how does this path still
> work?
>
>> [What`s my Confusion]
>> After the unbind and bind the serial8250_probe cannot register ttyS0.
> Then do not do that :)

Hi maintainer,

Thanks your reply so quickly.

You mean, this operation is useless and should don`t do that.

But , if this is a PNP device,  it can probe successfully after unbind/bind.

>
>> And there is not dmesg like this: "serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A".
>>
>> Any one have some advice about 8250 serial ?  It is a common operation if we believe that the old UART which don`t support like this unbind. Or we ignore about this really bug before?
> What are you trying to do here exactly?  Why are you wanting to unbind
> the driver from this device?  Why do you then want to bind it again?
> What problem are you trying to solve by doing this?
>
> thanks,
>
> greg k-h

There is a testcase to test UART by unbind/bind.   i want to support it 
on old uart  of serial8250 .

