Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8861C83F2E
	for <linux-serial@archiver.kernel.org>; Thu, 31 Aug 2023 14:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjHaO6s (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 31 Aug 2023 10:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHaO6r (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 31 Aug 2023 10:58:47 -0400
Received: from BL0PR02CU006.outbound.protection.outlook.com (mail-eastusazon11013009.outbound.protection.outlook.com [52.101.54.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8860BCD6
        for <linux-serial@vger.kernel.org>; Thu, 31 Aug 2023 07:58:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOVvo1S0L0cGDA1lSQVUgnXmmiEqPGlTD4gDyBE/CPgCAnULpxrrZxYIQw1CLbnquZNqG23YSb6Jtnp8clR2QmUsr6OxRFvl2KRJ7BI6Doaa+rryrUfeeJ/1TTKDBtNj3Y5iuN9eJhLE2v1wUd6daXaIAITMdhgobuGy+yhr6kaN8r29bZHgFa/g7ug44MFFFLKpcVQA9hA8xytO9PTz4Sc8Yazc0sy7Gw0XNrnbJmU0eIPFQrlutknU4rLbFtCDD4h0I+fpsWV28ZP/yLE4ziw7eXqU8zESIr/4fTfUTA1B9r7DXy7vWevNDZKDnWZxywIOQ07uMHAOImzf0xnc7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Md0M58nFl1dMv43BzyDDHC3c4zUCZ8AFNfnsPrmyLCY=;
 b=GpwjEVzDZ9TZr0cv4AU0imKe5e4uLM4fJjHhwbBQMUjJzAr+jv7TjhaV0RzaHngcaPfGzxxKq2ZyQv+9qGRr3R1W+1vvoJAGDqkoAx78Ph3QnZMXBgLu94+fYF4V+MGRvf6CbP9UMenWcZO8eWY3UI8Zz+bPnxqyRYs9tPCBfgZ5rxSO1AI4wf3iETAbIrTqgycXw/i7/AC8rS0/eKzSOWjbzIBUXTXTRC1aOG22uoJ2lfJqCb1FLtoZwE4rj09arhAj4Z2ttMD0zmPGX/YLyJeEmBLx8mQT/2owuEVchSDckaQZj8LchOPDQNInCkotLfouIY1tgGFBRfgfhnDxZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Md0M58nFl1dMv43BzyDDHC3c4zUCZ8AFNfnsPrmyLCY=;
 b=W8w9jRvNEBHStLo1UgwLC485zqQcKPR9qStxMgdKEi5JY3cesIehLT5Fnt3XhHHXg76D56x63vgPGppIvElt5Eeo3tk5Vl5xmRwuhf/Lf7kezoBbzBOuLa+iHrEyeNtq3RBmQBKjRrm+aYcUSdxje12wSPAxTXptklY1Kr9Rq77pum3KpJxlZrGfqLI4jVY5y4Lfcddz1XbioTup4In6PJQt7cBM56bL2iBfL7KDvS9gmLuIwirLjo22f/+YUz0bufa1wi/gUzCC4UDmGBrkb3hyo9BDdcSb31pzBAKmRhsbXv1/zwxxFMS9Jv3GIUy2bi0R0fNSiO5n2VLg4yGvWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealevel.com;
Received: from CO1PR05MB8426.namprd05.prod.outlook.com (2603:10b6:303:e5::11)
 by BL3PR05MB9042.namprd05.prod.outlook.com (2603:10b6:208:38d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Thu, 31 Aug
 2023 14:58:41 +0000
Received: from CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669]) by CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669%4]) with mapi id 15.20.6745.021; Thu, 31 Aug 2023
 14:58:41 +0000
Date:   Thu, 31 Aug 2023 10:58:36 -0400 (EDT)
From:   Matthew Howell <matthew.howell@sealevel.com>
To:     Tony Lindgren <tony@atomide.com>
cc:     Matthew Howell <matthew.howell@sealevel.com>,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        ryan.wenglarz@sealevel.com, james.olson@sealevel.com
Subject: Re: [PATCH] serial: Revert serial: core: Fix serial core port id to
 not use port->line
In-Reply-To: <20230829201557.GK11662@atomide.com>
Message-ID: <472581f-e7f6-6cc-c749-5be16e4fe9af@sealevel.com>
References: <98a891fd-5a1f-6568-a12c-28577126a42@sealevel.com> <20230829035245.GF11662@atomide.com> <511f2dcf-f637-695-8e81-8eaa3735ba88@sealevel.com> <20230829201557.GK11662@atomide.com>
Content-Type: multipart/mixed; boundary="1338814021-90547759-1693493921=:20638"
X-ClientProxiedBy: BN0PR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:408:e4::29) To CO1PR05MB8426.namprd05.prod.outlook.com
 (2603:10b6:303:e5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR05MB8426:EE_|BL3PR05MB9042:EE_
X-MS-Office365-Filtering-Correlation-Id: 14648565-a7bc-497c-4ecd-08dbaa32c3d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CBZJnopK8pekxh5eqtlDerUXbSy6YjwLZK7GjoAuwduSkKyTaDXiN7YQ10EKxiPWDY09jdyJlnvvZj93aqCXeGKjH6XOwlGVNW2X762Ugg0CsdVuxR4aDyBukvw0iU9pNDQGWIYF6xO8qn4FN0VS5HuYSYEZFLakgPCduwwxvIwinkJqYTpFfHb7UxReU8CV9H2wABgL7+2vbjBCN+mv7J1MJS1lZlfDt5DIXxqLaV9IeeJAtTksOjPUWWL6HY/rK4MtT7PTP36MCH7i9OhliND05pAGWAQ9gRX1q3dDuKEvWyw/ttgj7QEelaLVNygXSWUIW87ADrUMsmCCZXJMsu0vtGrJjMj9h4DOBYHbWNByhM9CvCQy0S45uvGCeHQmvx1k17sCK2JraOZ1QPNZwSh5cJ/ynx++isOGSdpbjG6Mk8MoR7ZnpE7OIcV19WZevmmTuE8X4vYBZWxxVbWmjQL1HJgIPE2sTQ3kK/EHhYsEPHbPh5vSC/aCcBcQQ1nzW2H/PI5QOGjKjHovU+4WT727k51Ywix/qifC8N05SfLymJ6fDaHfzxlvmWk5hDSIp2ziB7uVaaJHk1TtHixePYrpqVTENz9329Y7PQ5gKYw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8426.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(39850400004)(136003)(186009)(1800799009)(451199024)(8676002)(6486002)(6506007)(6512007)(6666004)(33964004)(107886003)(2906002)(26005)(8936002)(83380400001)(44832011)(316002)(6916009)(66476007)(478600001)(66946007)(66556008)(41300700001)(4326008)(5660300002)(86362001)(38100700002)(36756003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TW9ZMVVPajNVbk4yT24vVFQ3cHpzWnNTWnhCMlZyU0NzNGJvbGdRUzNDUnV5?=
 =?utf-8?B?ckMwMXB6ek9Qc1lFZmlkaE1hUWRkRFRlOXV1eUg3TzFnckRYMnZROGc2cVpG?=
 =?utf-8?B?OS8xcnR6cVVnZFYyUEpnUHArY3BTZVJkbFFLMEJxb2hJZGkrdlVSVDN5WWFS?=
 =?utf-8?B?Y0VVWkw5eVpFWnVNRXU1NWsyMUhPK0MwQVI1UU9Cc2NZbE52N3luci81R3RL?=
 =?utf-8?B?V0VVaVREREtVWWxsbEl2ZldqeWhOQWoyOGF0a1RjTDhUR2VzdCt3Wm9iWFJP?=
 =?utf-8?B?VW1hZUswaExQN3pGbk5xd3FtaEZaUmViM0hCVE5ZdW1obzNnKytlVjNJVTgv?=
 =?utf-8?B?MEVtalcwZkMrSjE5YmxFYVppVGY3dzViWmNJOGx4alBOQjBXTGdSUjNVNHFP?=
 =?utf-8?B?ak13WlpVY2pLUDQ3Ukhud2ZkSVo1aHJlVVZlS2Q4Sjhtak5lajFGQSszMUw1?=
 =?utf-8?B?L3Nrd0pSdFNPbHpJSTU2ZFM3Wk9QVWYvTmFXR0NDTkZNSTlNS01QeWF6Wk9F?=
 =?utf-8?B?bUdTZXpJRExTbFpQMUVNTGNWdGRLUWlzTW1kekQ0aWVYSHRiL0dnWFRxTWRN?=
 =?utf-8?B?ZVQwUHc1dGxzZmhaMk8wYVZReWl2Q3RYZUg3T3FSbTR6Z0ZHSG1lRzk1V2l6?=
 =?utf-8?B?d0h6YjZzcjhHR1JMUnpLYm10ZVBTbjhOa1JmN3lXa3lUZ3NtN3BjaEMxSG55?=
 =?utf-8?B?cGc5TjhIZEk5dktpelIyaytiQ0U3QjVObEw1S2RmZVJnR0JBVStUUTg2SS9B?=
 =?utf-8?B?SW1kRGQ4eVV2N3poclorMEtzR015dEVwOXVYNjNQb2lRVXVuWitLZG1NQysv?=
 =?utf-8?B?NE9VL3pjZEZxdWZzUEJhK1VLbmpGVzNIL0VhamJxT1c5NWtZY2ZXbk40T0RY?=
 =?utf-8?B?bUxRanJQYm1uMTc3dXhrUUhlZVhRNEtFbUdEUUxiaFJCcEhXcGpGOXJTaUVL?=
 =?utf-8?B?SUlQbWJVVmo3UHZEQlRBSGVJMysxcTNSMVNVUW80QStveWRWWDM0QytXU0hy?=
 =?utf-8?B?TUpjazVJMGRPTUhvVVhJVktMSS9RejMvOHVEcVZSVFQzV3pqVjZCR3JIc0hG?=
 =?utf-8?B?T2tsdWE5SUVGc29pdlIxQ01mMklRaFdzKzlMZ1Q1S2JuYnpXSWU5RElZL0xO?=
 =?utf-8?B?WkxpbStQYk1XSVJPNkJyVHptMVc3MmN5SzR0RE42ODl5b1dvZ1VxUTMxVzhS?=
 =?utf-8?B?Wk9yd0xiUVVmMlQ0STdxT2U5UTdGUnNNYWhFZTgvTEUxdGNITXlvalBhMWlY?=
 =?utf-8?B?RmU2K2d0OW9pYVUrRVhnbG5aZ0M4S1JoM2tHMGt2WWkvQmh0NlBFcFg1aHZp?=
 =?utf-8?B?Q2JmNkRIbmxmT1lvUFlQZ2laYWUvamh2bHdxcUVNOHZMMmFqL1JTUVF2RFda?=
 =?utf-8?B?eFNIRUQ3THJ1c01VVjlKdjR6VERMbUFEbVM0RVRWemdrdHZWdlg3SlhGa2xv?=
 =?utf-8?B?WXZyeEFzWXV2WlBNSlNXeXY2U2k3UTNYTjhiRHhNNW9scUZCWFZTNFJCWS9a?=
 =?utf-8?B?U1NtcDNOOStORmJ6TmV4WGo3Mmx4cm9rZzU2SzJ5eVFLTHI5UGx0OFl4RGgz?=
 =?utf-8?B?RnByWWZiMmtZWXNsUWdxSHZPVDMvRXJvamJWTXU0ZGtRUkE4NXBNZWJsZGJq?=
 =?utf-8?B?aURUdW9KSis4blZVTG9vSU93K1pXR3l3VldNTnZJQkU5RzFvck0xemJLL2sv?=
 =?utf-8?B?Q2cyMmxYMVIyMUc5L0Zwa01MZVRhYkNvNHpWZHFCMGZPRmdSRFk4UG5rMTNi?=
 =?utf-8?B?SHROVTEwdDBlam1xMWcvQXBWMnBqdElncStXbWV2NXRvTTB3Vng4bUZhZnJM?=
 =?utf-8?B?NXF1VXVTNFh2eGEvbFdVcVVnL0VlWUN2N3N2M2ZWNUl6QnFhb3ppNjdLUmto?=
 =?utf-8?B?UDNXOFBBU2JNaEdGdG1wVjNqWlV2N2VTaGNUZEsrL2djU1dlMlNlK1djT1hm?=
 =?utf-8?B?NzZCVWo2cmZkdjJJZTNJQ04rOXdsUHU4cWJCampxVWlxNCtyUDNOVm5SK2JD?=
 =?utf-8?B?Y1pvZVIva01uN2xrVlJkenFQSzIvM0p3clZSTGJxRDMzQ01seTM1Qk0zS2Z0?=
 =?utf-8?B?T2pmcVBWRTdONVBtR0tWVkxQS1pxQTZuVldDdkltYU5WVWdFU2ZNYlJ5RmRX?=
 =?utf-8?B?ME5uZEJLbzdTY0ZpVnU2Vm9YOFB3UG5JWXdySjdBVzkwVUx3anBVWkRHbU54?=
 =?utf-8?B?Ync9PQ==?=
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14648565-a7bc-497c-4ecd-08dbaa32c3d0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8426.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 14:58:41.4773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J3SuVLafmtmPpdUGoYKV0Sw6AdZISQeChywagyRuRdF9tYhSlHAdap1dMnkTMOtSoRnvH1A3LvHyssffTvt8+P/C4OGgZsWpUhl2/cqg8FA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR05MB9042
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

--1338814021-90547759-1693493921=:20638
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 29 Aug 2023, Tony Lindgren wrote:

> ⚠Caution: External email. Exercise extreme caution with links or attachments.⚠
> 
> 
> * Matthew Howell <matthew.howell@sealevel.com> [230829 13:42]:
> > On Tue, 29 Aug 2023, Tony Lindgren wrote:
> >
> > > Hi,
> > >
> > > * Matthew Howell <matthew.howell@sealevel.com> [230828 20:41]:
> > > > From: Matthew Howell <matthew.howell@sealevel.com>
> > > > XR17V35X cards seemingly unable to register serial port. Confirmed on
> > > > Sealevel 7202C, 7204EC, and Exar XR17V352 reference board.
> > > > dmesg states: "Couldn't register serial port 0, irq 24, type 2, error -22"
> > > >
> > > > I first identified the problem when I pulled down 6.6-rc1 and I was able
> > > > to trace it to d962de6ae51f9b76ad736220077cda83084090b1. I understand that this
> > > > commit is noted as being reverted in 1ef2c2df1199, but I was only able to
> > > > resolve the issue by reverting d962de6ae51f myself using this patch.
> > >
> > > Thanks for the report. Do you maybe mean 6.5-rc1 instead of 6.6-rc1 above?
> >
> > Apologies, I meant 6.5, no RC. Specifically, I first found this issue on
> > the v6.5 tag (2dde18cd1d8f). I then rolled back until I traced the issue
> > down to the patch in question (d962de6ae51f). Even more specifically,
> > according to my test notes I tested the following commits, with results as
> > indicated:
> >
> > 04c7f60ca477ffbf7b7910320482335050f0d23a -> Not working
> > 3d9e6f556e235ddcdc9f73600fdd46fe1736b090 -> Not working
> > 3c4f8333b582487a2d1e02171f1465531cde53e3 -> Not working
> > a4a79e03bab57729bd8046d22bf3666912e586fb -> Not working
> > 1ef2c2df11997b8135f34adcf2c200d3b4aacbe9 -> Not working
> > d962de6ae51f9b76ad736220077cda83084090b1 -> Not working
> > 282069845af388b08d622ad192b831dcd0549c62 -> Working
> > e6d34ced01bc3aaad616b9446bbaa96cd04617c4 -> Working
> > 748c5ea8b8796ae8ee80b8d3a3d940570b588d59 -> Working
> > 868a9fd9480785952336e5f119e1f75877c423a8 -> Working
> 
> OK
> 
> > What I can say for certain is that of the commits I have tested:
> >
> > 1) Commits before d962de6ae51f work on the hardware I have tested
> > 2) Commits after d962de6ae51f don't work on the hardware I have tested
> > 3) Pulling v6.5 and reverting d962de6ae51f with git revert resolves the
> > issue
> 
> OK. To me it seems uart.port.port_id should be always 0 in exar_pci_probe()
> and get automatically allocated in serial_base_port_add(). Sounds like this
> is not a duplicate port_id issue though but something else as it sounds
> like you're not getting duplicate sysfs entry related errors.
>
> If it is a port_id conflict I'm not sure why commit 3d9e6f556e23 is not
> working for your as it has commit a4a79e03bab5 ("serial: core: Revert
> port_id use"). Care to check that again, or maybe try with v6.5 with just
> the commit below reverted?
> 
> 04c7f60ca477 ("serial: core: Fix serial core port id, including multiport devices")

Just tried that, but no difference. Same error.
 
> Dmesg output might help also to figure out if this happens on the first
> port or the second port.

The full error in dmesg is:
[Aug30 15:48] exar_serial 0000:04:00.0: Couldn't register serial port 0, irq 24, type 2, error -22

This is on a 2-port adapter. I don't see any indication in dmesg that it 
attempted to register the other port.

> Not sure yet where the -22 error here comes from.
>
> Regards,
> 
> Tony
> 
--1338814021-90547759-1693493921=:20638--
