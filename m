Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E062CA0ECD
	for <linux-serial@archiver.kernel.org>; Mon, 11 Sep 2023 21:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239665AbjIKVaX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238533AbjIKN6j (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 11 Sep 2023 09:58:39 -0400
Received: from MW2PR02CU002.outbound.protection.outlook.com (mail-westus2azon11013005.outbound.protection.outlook.com [52.101.49.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58962CD7
        for <linux-serial@vger.kernel.org>; Mon, 11 Sep 2023 06:58:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFxTlUimgqgD2t/sQ01GAUpHUFpnMwTtLxp4Bujcr5DhOBBkFus8Mu34QpPcPVgACv4ykDXfdPsNCFSyBFgLWvfbPpyDjh7DBGwFMuntD5/mYFDXBaivolvEJT8/5z5ysgMSOVUPVSj4A+OjUU/3hOwFJBsoWUJhzRXKQEx6d1kUTyfPmzzjmfJLbnxkMhXGUCHRz9liNDqIFkQP+c+zdFaN0L5OC3nnueMiYgNU+IyagGnKAzXpFSh/8QgfPCZ0brNtLTAgsCthfT4SIZbaacQDKFAyrhof+iTe69lPXy9JaccY/YIPO82kPkDEUlzEqbDnPwJbsY2IkF0r81R8XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5qctwsSQ6LTEsXUCzT57uqQUYmIFyYqE43LmfvW1hs=;
 b=bg3u07YPaby25nMG1yYOnZuaZWW05zciom4GTv8DQ8NhOHfNnDVHJAD0r8f/WCfMR8JhGbJepLWNZcktpsoMoCpvo5tecfaY9OCPBe+0nxxRE4ziIDCsiXytiVHTLmAwEO/KYU0/kslMmM9y+AbKAlz9mT9rnejIBx/ZaarWjsw4mKWFQstIoeMQQiO1PyRjIYSJ1hRq9reYESvGaSTBNalY5qYr2TnttjrIbOQw+fgxaCEE3qPNyS3PjB3vtPBd8I9yGjsf45pCy3898xQt+jf1z62E+Nf5rRWDdREDslzvwN8k5fCH2u4j27+/1LUlc8ShQ12NlGQcaG2NzimwLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5qctwsSQ6LTEsXUCzT57uqQUYmIFyYqE43LmfvW1hs=;
 b=fyrIS0Z1JBHbEdC1ee2M7NYdFr3DB/J6jfNVLw1YTI+eag7WLs2X3HCPLpBEQ6ePhQewlCXxriLEbdzekiqw45OJ+Z4Jwot24ugXuRrLEEKhKUduYtHTlxgztq0gFBAsiAaUx2p6QygTP0dP/ILtHB0luz2QYAxlimLDKAmfV02AOocKa6TGEgIBHRRXjnLuBGDtpACmoEdw1+oPXYjmjsNhH2KS0ag4IKKRyRpvW+c5y6x5kRqKdCae8CM9svKuLuF6gfoyXvURVNowdayFLiAuNbHbGjDdfBH0bBwrXg7HRSvs+n/ZBU6WXydnPgmDDoLDNHOdf5LzQzuoVa2QfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealevel.com;
Received: from CO1PR05MB8426.namprd05.prod.outlook.com (2603:10b6:303:e5::11)
 by MN6PR05MB10260.namprd05.prod.outlook.com (2603:10b6:208:471::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Mon, 11 Sep
 2023 13:58:29 +0000
Received: from CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669]) by CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669%4]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 13:58:29 +0000
Date:   Mon, 11 Sep 2023 09:58:25 -0400 (EDT)
From:   Matthew Howell <matthew.howell@sealevel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     Matthew Howell <matthew.howell@sealevel.com>,
        Tony Lindgren <tony@atomide.com>, linux-serial@vger.kernel.org,
        ryan.wenglarz@sealevel.com, james.olson@sealevel.com
Subject: Re: [PATCH] serial: Revert serial: core: Fix serial core port id to
 not use port->line
In-Reply-To: <2023091154-gallery-janitor-6ae3@gregkh>
Message-ID: <bbb47dd8-a837-4671-3ed4-c3a4ba805b6d@sealevel.com>
References: <20230829201557.GK11662@atomide.com> <472581f-e7f6-6cc-c749-5be16e4fe9af@sealevel.com> <20230901044730.GL11662@atomide.com> <e8579280-2f44-a585-a3b8-98fad29e6a2d@sealevel.com> <20230902043424.GM11662@atomide.com> <c4b1db31-7814-0d22-36de-a7e6f117d89c@sealevel.com>
 <20230905155524.GR11662@atomide.com> <79e44ee3-f4a0-6f3e-cb5d-dc2b7bd048fb@sealevel.com> <20230905165147.GS11662@atomide.com> <73817d5-cab-341-be76-ee9d565df57@sealevel.com> <2023091154-gallery-janitor-6ae3@gregkh>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: BN9PR03CA0093.namprd03.prod.outlook.com
 (2603:10b6:408:fd::8) To CO1PR05MB8426.namprd05.prod.outlook.com
 (2603:10b6:303:e5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR05MB8426:EE_|MN6PR05MB10260:EE_
X-MS-Office365-Filtering-Correlation-Id: a5defa56-12d7-46e8-cc50-08dbb2cf2d49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oh11cpu4JnTsJ9fhTw79aXRTqAzv9xF7KE67+pv/7rGCG4CX0xuWA5wmDEgfGFEaIq9D73UfYK+ymlzeWKBM7sO2FjDEKW5Nj9vLO/+Hi7Qh8jPCaqRiYbWMkXGA6rYAlJhbS+lvzwFqskU1D/eDFA9gIzib2el6ehI+pI5pHvsXpPLWOghQcrBCzBJHPI3jc4vQ2Pp0GnWP3lKAieq0L0SuILjgNN6PgJKFKzdmOJDMJUfGjBKY9DyWAeV3+RFXfzFm0gbHCcqH5HdSgkanvhAi4oCjoB3oUxfvMMRy8IGz5Fk/WJyszLD7FmIG3DXoJLSxIi66U30L/R8X4yDiZLkqTbs+tZ/Ay1N7s5ZE20Mq7RZDGpT4UbdgfJBmPUHD3kZ3UhE7q/ns0+3RYBXjJ7sI8on1Sf4adB6P6ScFYxBBt5KtK/5X59P/rq+fFDymODkazuM4T/PRf92VUisw/BzP7Jm7VyVDb5taV1JUq761ThOvLftJ4n5WQ6zuCYxErR9BFfSjP2xV4vjSq0PTMwXlbuk45eVbbXM+eKQkT6k3AONKIz8pwDdImMnsE1dXzEzkoM/ukxmqeDwCegR90gpZBwxrBm1vI8RKwvdRZllkHjAz81+8VeB6ZMBbibnl8sMjE69P3WAurfF5x44mBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8426.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(366004)(39840400004)(376002)(451199024)(186009)(1800799009)(5660300002)(26005)(107886003)(8936002)(2616005)(4326008)(8676002)(2906002)(4744005)(31696002)(86362001)(36756003)(44832011)(38100700002)(54906003)(66476007)(6486002)(66946007)(66556008)(6506007)(6916009)(316002)(31686004)(478600001)(6666004)(41300700001)(6512007)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SijWoubMcEueM169okf5CVOp6DWZIi1KO1N/1DL5qAZ+OTyZOW29l0vP/2Yd?=
 =?us-ascii?Q?nHczegyJrdPUVzGsHnsn7bE+BkVV76OI69E47rEjF7N/Ze0+glj9HeOwShJF?=
 =?us-ascii?Q?ECELBYqpekHRfNdMib43hxhBs2H+UeaECaefEtjmgCdzC4mcncRm952vhNjY?=
 =?us-ascii?Q?UWuEl5o7WScaGfO8QVz0mFlHdU9FiaQNhbh6+ogyc5LvMucGa+40On7vsMeI?=
 =?us-ascii?Q?+XaBGebasiZzH8BSzD5xDNvTEeXwa4RPVNKQLNm9RGDf11KSSSrbikZ+HeZH?=
 =?us-ascii?Q?qiGKdrfRR4vFc0YzhNuDgu8I4aVJbwZyEFzKuUAFtuCmFO9KRLfgNt7OG3yL?=
 =?us-ascii?Q?WLh5tp7iSm8BFZpTvO8xha1Q9Ha3TxLtooOLAOs3ebdVN2z9oCT/eFcTPJ27?=
 =?us-ascii?Q?Kznjj27naLdQo37i66+IlYoqgoPoXi3HOzvdAg4m1NXi6pDu1bPIZ7jDyl1c?=
 =?us-ascii?Q?iFB8y7X9J+/lmtWTMtsDh5cMmAtEMJLM5Z6aT4+3a2EF+4e/WZYNTI7wfJp6?=
 =?us-ascii?Q?/k6lrWJu2QnU8W5EOScMaZjn3cohQnSU+Yki+GFsERj7izs3ImXuolvz/mDJ?=
 =?us-ascii?Q?NsPDQVHztb9YVuF03Jmia7Tly1X1HA+r7mdRZ5lX9lotAVojh05J2YK53vx5?=
 =?us-ascii?Q?lFLUFdzaB1yMpTRyZ5PSdJWpFbXRlqBtMEpS+MVVQK3B2b0BAYq38VaYFCpn?=
 =?us-ascii?Q?Tq4b9zBth3495WsaZOdcc/NDjXWHfWmba/w4z+yM8EJgXu8dqn0tLwDM/Csm?=
 =?us-ascii?Q?F1MYCHjcgJmz4i9Jug+4+QUEioVip52+j8aFJmX4oPH5xmqn95EcW5R8zg/v?=
 =?us-ascii?Q?doTva5gpLL9yXTMIGxPlkBiW4CQ760UfmCtUd6XAWGbnPnX/seeRwC4mvhKg?=
 =?us-ascii?Q?CHVkhC9KHXAhtUZkiNOjNijJ4Ud2dOoFhFtnsNxavah9hTKgqINHmXGs+/bv?=
 =?us-ascii?Q?e3U5OdD9w14V2dDY1mZ0oKtr8IQtVcibR/wU6WRk4Et+rFL5khkehgZd65kj?=
 =?us-ascii?Q?pYye8/EWOhA66QVPmEzRfjVgpMQUCDBwv3maIvFsTr4PXfyUR4b2AF+c/njg?=
 =?us-ascii?Q?LqcthOXImSxHB6c2xmQ5XLxIeGC0GFtF6y+QwFaFkDHGS8XEt7l29k8K5rNS?=
 =?us-ascii?Q?lCagIyeTbtW6BI8jpSIr39C8nU0AMoSJZGG5fkSfGfq2wSaA50/17TgvnbCL?=
 =?us-ascii?Q?ddQSSX3MFGUI0pALO1iAbiYmT7qDU00nYnJ/FgvvvkbwBrPabkdY5GzTij3V?=
 =?us-ascii?Q?Isnbqr3IDW7tVyTuf+HMuMdxavHAQtF5CTehpPtaAXII0ggyvuyyo12C9bU4?=
 =?us-ascii?Q?WdkTKL7UoEEnAXSf8+8Tc/d/WQ9VYEPyNQXN63JRM+cIz5QZ20Qg7EsniPX7?=
 =?us-ascii?Q?EuFWgv3T1FkPd1av2CS5D/YrcAC6/1en8+f7Zdoh6mmGi/+tcJDQrN1inBy1?=
 =?us-ascii?Q?K5sN0+qnV9MCKUuN1SZPLzDiqFyaeDz2rd2CmMsrGMkhnbY29UltokmjKPDJ?=
 =?us-ascii?Q?2XgKZ6KDXvboPA1bU93cc+GVB13H+E+EpSUVKAobaxQAIgjeRBLCFpJwucIR?=
 =?us-ascii?Q?7afousKZkQNnNMgbY2xopi4Dvy9RBVoOVcVobOv1nFTvibokkjXfiCPxypZG?=
 =?us-ascii?Q?Jw=3D=3D?=
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5defa56-12d7-46e8-cc50-08dbb2cf2d49
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8426.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 13:58:29.2306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AjWgOC6JBuOLwxIjCsjrsBgShFRWfjcyb4v8Y+wvdXx86OlP92wIR2XRvkqHGAMpG8X8xgugL0nI1JpS9cshNnur+uPIB7AAgdV9C5ttCy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR05MB10260
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, 11 Sep 2023, Greg KH wrote:
> On Mon, Sep 11, 2023 at 09:04:14AM -0400, Matthew Howell wrote:
> > So it seems like this might not be an issue for typical 'users' of the
> > kernel, but may impact people who need to build and load 8250_exar
> > manually for whatever reason, unless I am just building the module
> > incorrectly somehow.
> 
> Yes, Linux does not support building a module against one source
> tree/configuration and attempting to load it into a different kernel at
> all.  You are lucky that this was the only thing that broke :)

Ah, I had been under the impression that all that mattered for module 
compatibility was a matching .config and 'base' kernel version (ie, 6.5), 
so long as no backports or ABI changes had been made by the distro. I 
guess that is not actually the case though.

> Thanks for the testing and letting us know that all is good with the
> tree as-is.
> 
> greg k-h
> 
