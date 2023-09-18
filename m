Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BE9C46CA1
	for <linux-serial@archiver.kernel.org>; Mon, 18 Sep 2023 16:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjIRQKz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 Sep 2023 12:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjIRQKG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Sep 2023 12:10:06 -0400
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11012011.outbound.protection.outlook.com [40.93.200.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F2610F2
        for <linux-serial@vger.kernel.org>; Mon, 18 Sep 2023 08:57:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9Fql9A+HUEQnRx9XQqo6qzysFGG6cfl2iwwu8baHMNA6cDUQ4nrfMAHPRRXqnSyiwXDn6KJ0QeoWyQc7XOKVpnAepwKhSkW+dfpuBpPWYaCqOO9nfZCzN6J79BRbJbzI3AAb081iJGjMkDH+pRFmuLQjKSr27Ii7g4VIifOyZ/p1P+rIzNBZEaY6iCiKZZ2DPtUNDCZ2BBBC07DFJD8Ss2V2riZjJIlfTdcVMb7+vY2iw8bvQyL02l7SDsJxg3uXx4Tkf1TcZQg91YO1z4SxitJ7hj4tzMQU6OWmukMyXDkmWPW5cSIlDYbVZI5F31GHLSwU+61i9ZzTzGU7wIFPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wk/E7+DVIHODLGO/dwnXL6gPg2hz2qVNbVFJ2i18dAQ=;
 b=lciHF+a0ylqK1xxmkRbcLSp6K5eiSERg8KjLWfzzNa7xDqooUfklN6oFS75idaqJbVTOyjkvQqSiUHMTLPEIOkLOPd/mMV0mHy8Bbshc/yVEi981EaRbGb1i/F2pqirh4pGblIlyI0VQBbKSrhMdhHatP8ECTuclU3dXTB5RQ2d43taftbuP4L3sLEoJAiPwJUZWI6TUmOQ9vqJyoiRZVJxXIKjXv4t5XyTq7WjeD5GqprSSAidKZQdIxZHTvaHLeP1cMohl4IfeyR44FUR3Dykdp8+pKnE9ELqPG3KoGhdYr9ZFaLw79R77M/QZAXJHJSOXIIurpkoNXVnK9piIpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wk/E7+DVIHODLGO/dwnXL6gPg2hz2qVNbVFJ2i18dAQ=;
 b=aoUA+bDdrPKEUrI7x5UzyZQkFTK7bemnjwa+qzGSlbZJnXurVIt8xJMx46+cCie+jbuR/DRfISVGin7sn48akD0b4FsKCaiBImruCsnzdEfB06NNOr66oVS8SqR0q9Gv0LAW8D9wYOmk42T/ed7unyn9MUgXOWkCClbCWuC23dovbxzAwK6faIFsF0KJ4Sq7smhxNM0VJiKxLnYaWZOX0s9BMiNTcrwLtxnA0c9yDD8kUXmrqDdt5hQk19Hbh3y5zbeOaGNefiECJlZh7JhGTSNLXPdI35l6Y6cU6saIwe3tFMlPn08KgMVCwLB8c6t8Xf+ORSYZwnWc2+tBa4ydmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealevel.com;
Received: from CO1PR05MB8426.namprd05.prod.outlook.com (2603:10b6:303:e5::11)
 by SJ0PR05MB9997.namprd05.prod.outlook.com (2603:10b6:a03:448::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 15:34:31 +0000
Received: from CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669]) by CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669%4]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 15:34:29 +0000
Date:   Mon, 18 Sep 2023 11:34:23 -0400 (EDT)
From:   Matthew Howell <matthew.howell@sealevel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     Matthew Howell <matthew.howell@sealevel.com>,
        jeff.baldwin@sealevel.com, james.olson@sealevel.com,
        ryan.wenglarz@sealevel.com, darren.beeson@sealevel.com,
        linux-serial@vger.kernel.org, andriy.shevchenko@intel.com,
        ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH V6 1/2] serial: exar: Revert "serial: exar: Add support
 for Sealevel 7xxxC serial cards"
In-Reply-To: <2023091847-wireless-snowdrop-5e0a@gregkh>
Message-ID: <01677f8e-56a3-1ab8-9626-d4aaf511826d@sealevel.com>
References: <b5c01f33-35fa-e974-8f55-9b19d3b9de18@sealevel.com> <2023091847-wireless-snowdrop-5e0a@gregkh>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: BN0PR03CA0038.namprd03.prod.outlook.com
 (2603:10b6:408:e7::13) To CO1PR05MB8426.namprd05.prod.outlook.com
 (2603:10b6:303:e5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR05MB8426:EE_|SJ0PR05MB9997:EE_
X-MS-Office365-Filtering-Correlation-Id: 16b4f686-b462-4ae6-7b0e-08dbb85cbf49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c94utklKPl23x74TVCnd1ARd5O4/Oth9EmFbMeI7zeMKfnpPMJj4m0zg/YiQKfhjWPKGcXPBacaFTUAdIBMc8ozxFWUy4WeY6oN877aNzH76NyzUkd+IwbCe/NSunAq3lZesSNxosdmfYRTBMnaTCFLwO5iTUaZu5efQVs6046Q1QDuykE5ty/1xbrTVgk34pvSsQl1E9FMsLPDxOJ1gaQOBtCmt1aohcdlUq3KaRKqgK4EUYyWV4NsxK59Dj/x//HGvba9uCuIoAzGNvd+wgmNZEPlxlhJLTlCj+e6YHXhVBWTZwjZ781lXQdTtjQdne0VV31nHbR3dxTB3dtOgzsHaICY3EBFCHLU87zQm76PNHq7xTbDakTWR439Ab3rC9m0HQitrSPKlTDyNPrT5JEulBIyHHqU4ITkzrJN902xFn8Ja+s287DapUZFMVjDTaCRwnBZi9bq97gl9niiyJP3bl9/TPL1cl/RYC8G4qvD2/Krch7mDYxagw9IAPHvhTGqRONqJyahvJNjAqCdifEeDG9pkWksp5N3gjpNNOMLEAnoKAa9U1S/t8MWWtBELVZjsnKuZ4LivMdIJP/1HyT6Ak2Q4LWUfpxCiF4LTmXBmoTaQE9uZTaKkvDMba0Hxw1dYDQ2UfCZoZcudM0abIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8426.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39850400004)(366004)(136003)(376002)(396003)(186009)(1800799009)(451199024)(26005)(8936002)(2616005)(8676002)(4326008)(2906002)(4744005)(36756003)(31696002)(5660300002)(44832011)(86362001)(6506007)(6486002)(966005)(478600001)(6666004)(31686004)(6916009)(316002)(6512007)(66946007)(66556008)(66476007)(38100700002)(41300700001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X4gnL5fYObQOTpbEzW8sBiUZaTH0VlrIOiCN5ZrD2PUlwcYSTu/9IlDLCGO6?=
 =?us-ascii?Q?p9HVrCHBE7uBOYlOoxS1QDH0bUT6q5tDivAKRln+LyQq8p+08HPawwpeF07D?=
 =?us-ascii?Q?2mLEFPvAIWJWZV1pu1rPe0qy3EKtR/MPnXweLhaUDh0spV8Vhp/Hb2FyvkNW?=
 =?us-ascii?Q?3qk2jR0rNOMsi8xy8QSvGSpcqZ4Rl6ffLhke9Zc43YcFvhHv7hRbU2FA3XxA?=
 =?us-ascii?Q?2r1+IqOMcVGujo2wEWsKfZc1PS1m5MXqt1qHIZRv5gVHX48wd5lb28deEUY9?=
 =?us-ascii?Q?6khSYjDyw2s5/YXzbzwhfRxdybL0ERj0s7G6XSN7d7eA/LIazoyXR9ZXAxs+?=
 =?us-ascii?Q?wxza8l6VdLSfhvIyMjnrN/dr50bV6nGNqmW4YgLOinuSLOZ9HC2OPskXnaQL?=
 =?us-ascii?Q?0DazY9dqp8qAjFVkyaSP9JfcyDjtS5tliagl7Na2gEsgxOMXlHlmMKkQdQWQ?=
 =?us-ascii?Q?98+aiAl86T0a+G59c3OosO5T913xAGiX0FKLZ+hBK1ZMVW5g/oXb9fXO8Ypw?=
 =?us-ascii?Q?WA6pa7B9ChUsAnpTEfnNF809Howt41aZLDBQpd8vKwTY4fq8ovncLo3GRku6?=
 =?us-ascii?Q?qfhp5sufKyFzczmxL1SznLCZwThyaIi537kvSyDjaPHQK3L1u6280svPiKEh?=
 =?us-ascii?Q?NugMMaaHxYBcqrMJfUy1rWl+6uxHDF6rngpJ8UMtVbbqCMEHP0EsZlfCqIB8?=
 =?us-ascii?Q?ea+AgMloUvrJpIeczW/kwLiuPlJgxkIGqpbWX3HdN63eVKZEOXOqgu57TpiU?=
 =?us-ascii?Q?0Jolmows/5U3uE7FpXhGH1Hn0//G7SBaKScWGlmXvTesieiKMXw9AGLyY+L8?=
 =?us-ascii?Q?DthyoWc+ompDWBC1PNIjYZZ8M+d2vXULmlnfgiU6RlMgdWr0G4szEIcZQlng?=
 =?us-ascii?Q?iKyJSgZzXBJ8Qv5Mgf9GYSoxmfUl6wOa5RyFUwbd/M2A33TwQqBctomf5Ch8?=
 =?us-ascii?Q?XjZG7ymGEw9cb8xb1PoHmarebgcj58kyGqLxjWD9B2R5pLQEjoeQ2Jakhtts?=
 =?us-ascii?Q?Sv530pPbVRk2+KMBoYXXMuJ0zQtDt6pJyAEEHzCK6Rt/33Mjj2GBs9IELyH2?=
 =?us-ascii?Q?Z/zSCh7DNz0RWxQ7J9sE437LIHllGKiQ6nWHqx90PORqGWzskIY8SO7qWbVT?=
 =?us-ascii?Q?de3hFV2lnN+0T0JCHuyU5xGmqah8DvDYc7eT9gH8yWUlgufGA5ECaQ8hU1WY?=
 =?us-ascii?Q?5uNlI2m2ZWC/fTB5JVYu6GL8xGeb92k+jKFlQQ3f3cNTNfOsynsCrNcysdI+?=
 =?us-ascii?Q?MlQ1YzN093uXssYDqCrpw4vY5MJQot9garOkS0GxY9OH7Vsz91J3UX4jtd71?=
 =?us-ascii?Q?h1i5yEJdaqnscDKYaw1q8pOh+EPqwU0fnjxmy0iBTz77mk+xyM80QqrGbf+x?=
 =?us-ascii?Q?ncBcSq7YQP1DGQv5PtEXGc59EvcKuZxksqoqIZJTwd9xL50EHq0VB/Qoszi8?=
 =?us-ascii?Q?b2aww6vPjwKxX5BbhT6JQ9XvCVYVeq76NTu7arHCypfbFAxQuu7o3km5Zbgl?=
 =?us-ascii?Q?mzH4dQWgQU8yxutfzmrkDoqsemVq43TcMkXdGHWVKkOgO12Tc0UzCz+2ktmQ?=
 =?us-ascii?Q?aiIIBm3W2vRxJq/cE4/aRtLsPnt3QnoB9flJn9oqnIUKBZs+/2TAs2jZgBFi?=
 =?us-ascii?Q?Ug=3D=3D?=
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b4f686-b462-4ae6-7b0e-08dbb85cbf49
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8426.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 15:34:29.5551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: liAZlWAm2kh8d7tywtalhK/ahcKpSWKlkQCzkA6ChrMm8vybO/vi0nX3yATDemWmh4Ry/3kWVEgHmgXdwVf1St84IfuljVHRYoBg5xlmj3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB9997
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On Mon, 18 Sep 2023, Greg KH wrote:
> 
> 
> On Thu, Sep 14, 2023 at 04:50:32PM -0400, Matthew Howell wrote:
> > From: Matthew Howell <matthew.howell@sealevel.com>
> >
> > Hardware ID of Sealevel 7xxxC cards changed prior to release. This has
> 
> trailing whitespace :(
> 
> > rendered 14ee78d5932a redundant.
> >
> > Revert "serial: exar: Add support for Sealevel 7xxxC serial cards"
> >
> > This reverts commit 14ee78d5932afeb710c8305196a676a715bfdea8.
> >
> > Link: https://lore.kernel.org/all/a804d136-4865-f528-6434-68a7358d7606@sealevel.com/T/
> 
> No need for this :(
> 
> > Fixes: 14ee78d5932a ("Add support for Sealevel 7xxxC serial cards")
> 
> Shouldn't you also cc: stable?

I can do so in the next submission if that is appropriate. The 
documentation only mentioned cc'ing stable for fixes to 'severe bugs' and 
I didn't think this qualifed.

Also, could you clarify whether you mean just adding the Cc: stable tag, 
or adding the tag AND cc'ing the stable mailing list?
 
> thanks,
> 
> greg k-h
> 
