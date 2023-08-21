Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A20EE49A5
	for <linux-serial@archiver.kernel.org>; Mon, 21 Aug 2023 19:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjHUTJb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 21 Aug 2023 15:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjHUTJa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 21 Aug 2023 15:09:30 -0400
Received: from CY4PR02CU007.outbound.protection.outlook.com (mail-westcentralusazon11011010.outbound.protection.outlook.com [40.93.199.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EB0199
        for <linux-serial@vger.kernel.org>; Mon, 21 Aug 2023 12:09:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxvFns3Q7w/wKDT+sGqB6YzQPqgrd5IWbG6/lURAELj3P2id+387/M7fG9tacTTwk4sMG5lpuJO3wli3Md1Vo30hFHeB3dRvQsxR2fduNuF6IvKnzD+HJh42DJ3KDofDiQcpOunL2rWajT3K475WVuv/RCIHDgS+ti11ty7E6WUlCn+je3SfuK+GLRpIP+1jaE2NGm9IMNWyB3tNg34o6JYrsSoJKz9+Vp/3MthiBnOtNEWdIXD2N6GMCwNdw9hHleCtI7/dg7jdA+gxs61Q2/NwB9/KtlCmh9FooTCyxj8LfVIvk+AEQAR1waXdmyCMCxvr/i1bIbACaTqaWuoayw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29Eq8WRz2VH4RPlxewnJtyirQYm6SOqQDC14egiH4mk=;
 b=b0c4QLO5SEvN25QXp36bRjt5mVDo8+XQ6Bt7SxWcLnmUoVea+Y1zEZH14C40N5TLm3mCY4/N/uqr7DDngpN6gvBwoA7ifrynpplUWrNq/SE/bXJYkUPpX3MJt12WO4sKYGYrWWPOOk0Mty1bL3xpGyCiHyg8uNnDnGnJUD91L1EZiCDHZqEMdc6Mv/nEwjD7Q8AA6gZouUQuE3bopEWD1fM4gOU6/aGtTGsMACroyWqoljU6foWnvjWRCLGGu3gTOXLumNB9yEP8tRdBvZzIhkCPlbnQbg6gkeG0LqTp9M3f6pTRq+OvpNKf+A26LCvgZufSTyucx9bc8odueb2cXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29Eq8WRz2VH4RPlxewnJtyirQYm6SOqQDC14egiH4mk=;
 b=STvcfc0DPkAVXv7XKBXZA3RZI5kh0L7vtkrwSmtsg1qc7T0kIFU7aHYPMLuCY0ZnTlUWrcGBtmPHQHsQKGIB3/Rcld+quBUgsixMXG7Yht1elGAg0IkLdduOB9NXoAfKBp13A9sFtUstRGtepy/B9FAP/ZRjIO+yyLXBFI6GnjdKg0xC4ib99+27l9k/O1adm1OpRPFJ27pDyxIJlsdJhnyWMf7y+q5Av957C8+NM/WZGwEd+upPrcXvabEYLxsi9/NzYB4eLLztXxRE2bvYxTnkjFl5k47OSwh3WLtl8sR6GuJXtaREac9YOOPBX6EXTu9uHwjTWjBFqMa45Z2m2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealevel.com;
Received: from CO1PR05MB8426.namprd05.prod.outlook.com (2603:10b6:303:e5::11)
 by SA3PR05MB9667.namprd05.prod.outlook.com (2603:10b6:806:312::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 19:09:25 +0000
Received: from CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669]) by CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669%4]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 19:09:25 +0000
Date:   Mon, 21 Aug 2023 15:09:22 -0400 (EDT)
From:   Matthew Howell <matthew.howell@sealevel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     linux-serial@vger.kernel.org, jeff.baldwin@sealevel.com,
        james.olson@sealevel.com, ryan.wenglarz@sealevel.com,
        darren.beeson@sealevel.com
Subject: Re: [PATCH 1/2] serial: exar: Remove Sealevel 7xxxC IDs
In-Reply-To: <2023082147-deduct-absently-186f@gregkh>
Message-ID: <82dd7d4-2020-639-c63b-5955ccc08b63@sealevel.com>
References: <687157c-3d18-e18b-1936-f3f5b98ae760@sealevel.com> <2023082147-deduct-absently-186f@gregkh>
Content-Type: multipart/mixed; boundary="1338814021-1045102848-1692644965=:5046"
X-ClientProxiedBy: BN0PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:408:ee::9) To CO1PR05MB8426.namprd05.prod.outlook.com
 (2603:10b6:303:e5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR05MB8426:EE_|SA3PR05MB9667:EE_
X-MS-Office365-Filtering-Correlation-Id: 95e32d3b-7697-49fb-8e22-08dba27a22c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DyKIdDwOJ1qi+IGOGWzjWiIG0zOODaDL1b8UB2apfy/rheL/30Nf8gzsnjYpOUWZAcYJolbXB2+0oGuOQn1d5ehwSQf6JB+PKiO0vMbT50kjorslikE7KGaKZ8iso6VqfJ3oD3EfFq9SMSfVdg7wCm0abz+tgXH+JcY9ClCLyvTzC1hKNabsuGryB+TGszlrbfrCpBALq1YSd/wg29z5x2l75Nnx5Dg+U3MBCrW9+a0fNT1hd6a8Jo70pNH8t5yOAdAKZMB50FDIjQHIbfWTIcPxuXhG1QPEoBChP/mF/3luMqm9kJq9HisW4r/dBoQVlDx3CjUJp8IbxwcW7q/M3fOUx+jnkJ7+UowOvpk9QjUmFaHtO62n0mwBtDvLRb6GILrKVpWQCiUdC/VRkPA6LL7q8JJCcwAzsLT2SSSwa1guTUYt+M+UevKWuHNug7j/Y4bpQrtbU84VeSswTuzdWZ/hNhwvVJYqm6b6BDORNrnLkL53iZ1hQHk6rP0gjBW5bS+SBRR8G58gnewfSJEjeGOcWhmqt1ZNrvjMjxudhwcmClmihEEsPt5Lg85dLk3TEpkDCN1XNUtV1+2Tng4TPuf6Fubz2sFXVeoUFwtxFVTbxR9aIhePo1u4lcE5gV9XOLXdJGRt/UDy22lFzPIgeonChDau28/9Z5v2H7G8iOw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8426.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(366004)(39850400004)(376002)(186009)(1800799009)(451199024)(2906002)(38100700002)(6486002)(6506007)(66946007)(316002)(66476007)(66556008)(6916009)(33964004)(6666004)(41300700001)(6512007)(36756003)(478600001)(12101799020)(86362001)(26005)(5660300002)(107886003)(2616005)(8936002)(8676002)(4326008)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlNkVW9jSVFRbU1wQ09iOXY0VXJGdjFBT2JKQzhFb0VpNG1ESHRWWUJnSENJ?=
 =?utf-8?B?S0dRbXdjVjdzZU1naUd6eXpSZWdLQlp3MmFPRE8zU2RveWc3T2NURlFucWpT?=
 =?utf-8?B?WXVuUzFHVW42eHE3WlVsRTdSaDRtcHBRL0pCdEJEK3h1NzJpb0NXRDJyQ2VS?=
 =?utf-8?B?a0hTcWRJVnFyMlROV0tqSVI1STNLN0ZKQ0RhY0hmUUJPcnlrMHJzTGxIRldI?=
 =?utf-8?B?UHgvSUhNeUxDOFNmNG8vSi9DdW5MRFpMWmIrL0NuQmZzcVZxWXdsazZvWVIx?=
 =?utf-8?B?TEcvMS9RU3RROWR6TFczN1J2QTdNV2JCcXJwdVBaZVVzWlVaWXVETFZGVHJP?=
 =?utf-8?B?b3R2NEpzaW1kRks0RTVhTitxek9aVnpUbFpzNWhFZWU3eE5VQ1pKaktjTndD?=
 =?utf-8?B?VDZIYnY2UlFtTkdUK1hDaW1rdTJVTVZxeVhibVl6dU1WbWs2dkFBMWxuYUpC?=
 =?utf-8?B?U1h5SU4zOUpGNWZSTmcxcGNUV2gzOVk0V0Z5N2FPUW5hMCtiTFJvN2EzZUI5?=
 =?utf-8?B?ZE1lUm96Q1VBdmlEWC9jNkM5UC9DRnphNlhvb1dBelVQY0t0ZWdKQXZicG9D?=
 =?utf-8?B?V2xPZEl4dUJxNFMwYjZWS0pmRWhzbDVOdVN1YThuZjlrVVZuS05qZnVSdXc3?=
 =?utf-8?B?TVdFMVhVazFVTURTK2hIbUQweExuRkZDM3lKYUJmNVdVdXpCZVRIUE9ENGZV?=
 =?utf-8?B?c2VpSGNIeXN4Y3h6dWc4N2F6NWM5T09TR2hxOHFqdTVHOWJLNGJZSG5VSDE1?=
 =?utf-8?B?bUF3QmpmMUd2dEtMTXpPMzR0N3ViRWsxMVlmNUlQelFkMkx1bjB2Uk1NdlQx?=
 =?utf-8?B?Q3Y5cklIbE85Q0tCbUk1K1R1MDRXNkRXVHJTeXBVV0RnakhXSUlqNFkrekpj?=
 =?utf-8?B?Ync2MTlYd2piS3N3TFVnNEJXbXdpN2UvS1NsdFdObUVRVTNLSTd1WmI0K3ho?=
 =?utf-8?B?bkVUbVArVWZDeVMwanVNWjFWb2s5YVQva2NqclBRdEpHRjBTdmtqMmE5d2pL?=
 =?utf-8?B?Q2JXOHNrcjh3WHZ0V1FLQTNMQmwvZndXK2NIQWREdEdFMXE1Yno3OVB6allW?=
 =?utf-8?B?d3N4VUJDL3hkbmVOcTRZRTRNVXU4VGNYQ1MwNS9LZVduTHBDVTA2MkxYNTgx?=
 =?utf-8?B?REw1aWZFMnkxSC8yNXN3cWlXc1RTTDl1SVN3K2dWbUJaU1d5SEkwbzJoMUta?=
 =?utf-8?B?ZVdzZEc3STBOcWtmRDVTSVBZeGk2T3JBVThHOUptdE15L1MzYzQ2NXN5OExp?=
 =?utf-8?B?ZlFZTEwrWWpZTndVcG1PSWpCUG0xbFZBWWRuemNzSTVjdzBoYm1qOTVMMU82?=
 =?utf-8?B?Zmo1UFltOVgxNU1adllyc2NSOGtXekV4MkdHVE5lWXQweU9hc2Y1bnFabmo4?=
 =?utf-8?B?Ykl4ZThFNVRRczlncnhvajdLWGVEWWhqbnhqUm11OFBvQ3l1WkcxRkw4ZG9H?=
 =?utf-8?B?S0luVTFpSlNOU296Q3Q4cE1yVzFNMjFQZk0xMDY0Z0hRbTkzckpLMHN3cTNN?=
 =?utf-8?B?WTI0N1RPMzY3a1lPWVFyZlJNazJIaXEvWGJxZTJBTzkzQ09RN3RsWThjUkIx?=
 =?utf-8?B?eENwTFhPbXdEcVQ4NGpRNDZ6VUttR05pbjJOUWVHT1NWb2RFZlFYRk5kSUN6?=
 =?utf-8?B?Nzc3TGtkVkhIN1VoZUVXZmprZWZXRWQ2MEhRSHRQeGpzdmY3SGI2V3N4ejh4?=
 =?utf-8?B?b0kwNUxiQzVGUDRuRVduZ0MvNkhHREJWVzdzd1RBNTBDdUkvbUo3dXRtM04x?=
 =?utf-8?B?aVpLRnczTjZ0UVlRV25UVVF4bUVSckI5bEMyVjNXOEpVaE1MZlVaM2dXR3Iz?=
 =?utf-8?B?SCszYis4bTNBZVVMNGZGK1c0UW8zZTFhSkc2M29vTEsyTG9HV21vUVkzanhN?=
 =?utf-8?B?akh4eUpoaVNRYWJuc2FZSG51aGZXYmRqelZ1WUw2TTFxcDJRaG42NE9LeXpW?=
 =?utf-8?B?aU9PZlB6bklYdzU4aElWSUFDWWN0UEQwV0RBMWhTb2NkUDloT2hYdzJxcm0w?=
 =?utf-8?B?NnlRa3pJSVB0S1QyUnRndVhHNzVVL3JULzVVSmdRb0x1VTNJQkRuTzAySlZn?=
 =?utf-8?B?Y09IL1B3N3R0d2plaWJGRmZ1MWl1UnJlWWNyS2RWbytxVVlaVklhdG1EYVBy?=
 =?utf-8?B?em5vQlNtd0VoTHRVU3NxZHlXTTd2WU8yYWthN29mVDA0ckNDajJQMFIvRlM0?=
 =?utf-8?B?dkE9PQ==?=
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e32d3b-7697-49fb-8e22-08dba27a22c2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8426.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 19:09:25.7991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U8JgXnVWugIp6Kc6hBhIUm3q12Um9Tkw5C9iUPAqiOxZaxncXIK6kkBStx8JujY+J2V9TCI0iGAUpR+aB3aVqzYuaZtU6RtLVNQgzbA/tMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR05MB9667
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

--1338814021-1045102848-1692644965=:5046
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 21 Aug 2023, Greg KH wrote:

> ⚠Caution: External email. Exercise extreme caution with links or attachments.⚠
> 
> 
> On Mon, Aug 21, 2023 at 12:06:17PM -0400, Matthew Howell wrote:
> > From: Matthew Howell <matthew.howell@sealevel.com>
> >
> > These Sealevel 7xxxC IDs are no longer needed because we (Sealevel) will
> > be releasing the cards with the standard Exar hardware IDs. This is due
> > to the selected IDs causing unexpected behaviors on some Windows systems.
> >
> > Reverts: 14ee78d ("Add support for Sealevel 7xxxC serial cards")
> 
> If this is a real "revert", then perhaps just do that revert instead?

I will try that if that is preferable.
 
> Also, as per our documentation, you need a sha1 a bit longer than that
> :)

Sorry, I thought I had seen them referenced as 7 characters in other 
posts. Will fix when I resubmit.

> 
> And "Reverts:" isn't a valid tag, perhaps "Fixes:"?
> 
> And meta-note, your patch series was not linked together, how did you
> send them?

I used Alpine. 
Sorry for the hassle...but could you clarify how they should be linked? Do 
you mean I should have sent the second patch as a reply to this one? 
I didn't see any specifics about patch linking in the documentation so I 
am not/was not clear on the intended or 'best practice' way of linking 
patches.

> 
> thanks,
> 
> greg k-h
> 
--1338814021-1045102848-1692644965=:5046--
