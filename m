Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B35C433F5
	for <linux-serial@archiver.kernel.org>; Mon,  3 Oct 2022 11:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiJCLI6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 3 Oct 2022 07:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJCLI5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 3 Oct 2022 07:08:57 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8346446213
        for <linux-serial@vger.kernel.org>; Mon,  3 Oct 2022 04:08:56 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2049.outbound.protection.outlook.com [104.47.22.49]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-22-Zaf56nqDNQWBYFjcVqbXTA-1; Mon, 03 Oct 2022 13:08:52 +0200
X-MC-Unique: Zaf56nqDNQWBYFjcVqbXTA-1
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GVAP278MB0883.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:57::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.28; Mon, 3 Oct 2022 11:08:51 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c6d:333:ab23:3f5b]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c6d:333:ab23:3f5b%2]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 11:08:51 +0000
Date:   Mon, 3 Oct 2022 13:08:50 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     linux-serial@vger.kernel.org, Fugang Duan <fugang.duan@nxp.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Shawn Guo <shawnguo@kernel.org>, Johan Hovold <johan@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: imx serial chars lost issue
Message-ID: <20221003110850.GA28338@francesco-nb.int.toradex.com>
X-ClientProxiedBy: MR1P264CA0150.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::6) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRAP278MB0495:EE_|GVAP278MB0883:EE_
X-MS-Office365-Filtering-Correlation-Id: 0af4a98f-18fa-488b-f83e-08daa52fa726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: RnElHATRgo3bYdPbFKIpWTE6HEYI2gykxL+78ljVM9M0en0Yn+ceVDX2C9Qpi2F7Wk7omcmoLuZTgES/+ZKytSV9m170ZqwRdmcEw347XifacY/aDcKVIjo4m3kq/H6GExidIiEYTND4JN/tumIm8gocPvrCD5TtA3LfW8pt2ySTsqHBzWshRurhTwXBpIsgxwDDLXvr/X+jHtF+8FuC/K1ngvFWT3LlVLVerQj3B3uePJrN+S1aGlsC2f+3pZj5v+99wB3B3IC+4DwLP6cgv9DPkfaJNuDcI0Od8YveGnhbwa+ZMbLjJpsE108rZgGbe+ylRbMK61BRfSSWnxDcKwkHuongedKa94s3sEvhFC4EPZ6FHb2zTlCITefpr3k/2LBPCp16f9TaqgYVLs9oMiOkSrR5i6tTG/wFHgLAwyauujCIjumC+HWzzijAjUxW+s+SNZGR3X1T2E3XdlxGEUDWqtj67or57knX26UEEo03/miaC4fqgR7d7MBS5GYEA6aBJG7ciNDBw5n+e5N0uJgopsrdt6bWVVXotKe9ptuSYmnWiBBXYPQVDUT/s4GJOn9DA+GGPmw4Y638zHh2Nbmxx39eMgr1qxiaBN0JB4nDXirSkbJU/ZwO7+K/C7vyfQaRnK3kgB2IzXzEWLLpn93hhRQDpcUq0mHPZlU8WOu9Xw4fHeNpQ43b9YRoRFsttd7TzR02pTiWM4P1VuoZ2bsP/UrAfe+nFbdcCb3Rh9Y+kYc7YjbsO+3drqD2D/JsHjYyXLBPlZcFQaaFZv36Nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(136003)(376002)(39840400004)(451199015)(5660300002)(8936002)(44832011)(4744005)(316002)(54906003)(33656002)(86362001)(110136005)(83380400001)(6486002)(38100700002)(66946007)(66556008)(66476007)(478600001)(8676002)(4326008)(41300700001)(2906002)(6506007)(186003)(1076003)(38350700002)(52116002)(26005)(6512007);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uXUk52Ayx6YPuwGSUcmhkUBgEw+iWteLKavMHwJ5DPHM2EYoYy9EmDlfRZeN?=
 =?us-ascii?Q?2ivQ7US2VB1IU97ZaeUXUQw+g46fEI5rSwv/q1Ip6XMMw77zGeTIg7xt/CAs?=
 =?us-ascii?Q?mObM40MImkVxuwKzd68ElsnyrjOdfbdeDVNurGedojGnP1XsHGq870tZ4Wnm?=
 =?us-ascii?Q?dS+AijvjtrlbEMi8QW+veYFMzR74c0EeN1yB0DG46Fe2TRwmEyUXRhSjkQXY?=
 =?us-ascii?Q?ZUHfTClsMRMfhHi53Oqyuv5+CSie/QLnw8eMpfJA8ozP5eDAjbZrSTiAu0Cc?=
 =?us-ascii?Q?xWtLz9a+ItiEK30xF182VsWbvvKF9N12gut7Gmh9LAuLgP1fZQ6cygMsgjzA?=
 =?us-ascii?Q?Y5xd0Xrfh/Qpyq/EWnxFLDzqNkkFf/5RNm4AR3FFD8qLVywZLqb//vcFC/uZ?=
 =?us-ascii?Q?o4cA3ZHJshTBXE5HU3VC31VK3KgJJCKLW36tUXqiiEB2nkmJxgl8Q7J3BXzr?=
 =?us-ascii?Q?WQet0NPidyBiBiZJ0jOddvccfN76Bip/B4ZQMk4sfgzvyFF5LZjCo/I3E7Y4?=
 =?us-ascii?Q?M+zDeS/JCGZOq1YdqIalhzliXsxnS/Lyzc6gqDOL6P1rrNvOeNp1XpsXcrwo?=
 =?us-ascii?Q?fLpoHfo+Te2U7/zeVRBw57XfyF6aOwrIkR3ZitxFrMzdl6qHA5S/2e3aDTyw?=
 =?us-ascii?Q?eJPtxqImxzQnsH0+vwGtj3UrAU9pAHyxVEesI6Es6nbdeeRkOT4aO2ABcp8s?=
 =?us-ascii?Q?1KeR0x2mbjpZaOPJ2YRYsEGmQVCeSbb62tP8P2BpeLvvF3RSNiotcrQd+90y?=
 =?us-ascii?Q?iIlwZ22K68zObT4pNU3cVSKXTuULHxfjMwbnPRNsSCLXHi5AShijQk5oTi+w?=
 =?us-ascii?Q?f8sNe36Hd+lKT4cH4XXQOM6XA7Mtp2siTQ+pEKet+E44aYFWPjWI2vf9OLPP?=
 =?us-ascii?Q?bfbPwfn7JO3ByXFm08A5uiToKqZo23JY9RRL/2v2glrfb5Yutq9nwM0y7bMQ?=
 =?us-ascii?Q?PqHgmhhbVlMPXV1ty592d2XKvzJktS1My1DTdOiQQOEweFH0uGv4gtZLL6hy?=
 =?us-ascii?Q?2z54Q3wHhm1yxrn55yIK7eHlWRwaOoCZnn3jQxRiNxXJsf0ZyUe/d5BH8Urp?=
 =?us-ascii?Q?bV1Wlqc83wT4dLwuL9X9/vfpvqN9SP6YFbf1XP1zPXWdcL7XpQGEG2LhEyOF?=
 =?us-ascii?Q?6sl9H3g/xkHv6xu0IN9OEhORIznRf7QT3DZxdDMw2t3k0i83815YDTC45U1j?=
 =?us-ascii?Q?ka0qjktsDlIOsEaKPsKvyYX3XWcoyZU+YuPCljSIuda1YU5tGsFjOzP7e0XE?=
 =?us-ascii?Q?iNvp5Yme9a6U022r57K6aJzjntPijf8wecPtyaWzAxWJLi5/0aP0k1muI8KJ?=
 =?us-ascii?Q?mTK9Wo0+feQupb4GfAH082wrdGgvb6LYPMr3BjjIBpajC+yDqZJGyWB7wN+J?=
 =?us-ascii?Q?b1rQaME/r7h+6GsaMDDPAsnFjJugxnvuoe0477lvfchiwUq29s9Ql/YdjaWT?=
 =?us-ascii?Q?76iDL3ol2csNpEvuMQEzMWa3ARkG+04wVOCi9098IuYcBebyA8hOcNdndPKt?=
 =?us-ascii?Q?DLtE3HmG8bl3yK4901tSnS50a1qisuVZCDXV2GWBmEqeU7kqkiwb0pEoxifZ?=
 =?us-ascii?Q?ni0guf35sgfJwlRXSOpGVNeNkuaLVk9nOfY4aosMFFafRMgDCyzyBYh/Ahcr?=
 =?us-ascii?Q?pQ=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af4a98f-18fa-488b-f83e-08daa52fa726
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 11:08:51.3366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMP1UQBgUbtYARDlRMm/QK7fgp0vsJ4Ww438i1Zoqy7Z36bcEpYIToNj7+b4D5DG4BZfwB8vz9KoO19KvehnPSYS22zFwS93CfPnlK8s/Aw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0883
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello all,
recently I have been experiencing an issue with the imx uart on i.MX6ULL
SoC, on the tty console (no flow control, 1152008n1), chars after the 32nd
are lost when typing "fast" (copy/paste or writing to the uart using
automated tools).

This was tested on Linux 6.0, however it does not look like a brand new
regression, kernel 5.4 was somehow subject to the same issue, although
it was way more difficult to trigger it.

While I do understand that without flow control this is something that
cannot be prevented, it is pretty fishy that is always the chars after
the 32nd.

I guess that might be happening is that the FIFO is emptied only by a
timer or when it is full, instead of emptying it when half-full, and the
CPU might not be fast enough leading to an overflow and the chars lost.

Any idea?

Francesco

