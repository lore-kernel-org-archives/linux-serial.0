Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC79AC433F5
	for <linux-serial@archiver.kernel.org>; Mon, 21 Feb 2022 11:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355746AbiBULRM (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 21 Feb 2022 06:17:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356092AbiBULPu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 21 Feb 2022 06:15:50 -0500
Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.85.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27B2F63DD
        for <linux-serial@vger.kernel.org>; Mon, 21 Feb 2022 02:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1645441014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oUm0xuH/cSZI8o/5Nn2Cd4NXStuj/4l10TQt2JvzYDQ=;
        b=dTCyzlQAeQCGuwiggc85jU/DbistTW3iFZI7iRJGOyPXCtuvxN9qqPSHj6NHO3pVUb78YN
        Tpuah8NfwqhiCXOkDPHEHejAhRoV/TJomHOzsdFjuE6YL+k4wxFKqOwYrkDdLin0jkYAKy
        e2/b9dPo4Oc76aLF2ebMQ3pH3jbCD9E=
Received: from GBR01-LO2-obe.outbound.protection.outlook.com
 (mail-lo2gbr01lp2057.outbound.protection.outlook.com [104.47.21.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-186-E61Za5tKPIOAgA8HqK7oeQ-2; Mon, 21 Feb 2022 10:56:53 +0000
X-MC-Unique: E61Za5tKPIOAgA8HqK7oeQ-2
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:16b::6)
 by CWLP123MB6574.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:184::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Mon, 21 Feb
 2022 10:56:50 +0000
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6dad:8602:45c5:6747]) by CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6dad:8602:45c5:6747%8]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 10:56:50 +0000
From:   =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>
To:     linux-serial@vger.kernel.org
CC:     Phil Elwell <phil@raspberrypi.com>,
        Daniel Mack <daniel@zonque.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Krzysztof=20Drobi=C5=84ski?= 
        <k.drobinski@camlintechnologies.com>,
        Lech Perczak <l.perczak@camlintechnologies.com>,
        =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>
Subject: [PATCH 2/6] sc16is7xx: Update status lines in single call
Date:   Mon, 21 Feb 2022 11:56:14 +0100
Message-ID: <20220221105618.3503470-3-tomasz.mon@camlingroup.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220221105618.3503470-1-tomasz.mon@camlingroup.com>
References: <20220221105618.3503470-1-tomasz.mon@camlingroup.com>
X-ClientProxiedBy: LO4P123CA0469.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::6) To CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:16b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cb7424b-720f-4b8c-d3ad-08d9f528dcec
X-MS-TrafficTypeDiagnostic: CWLP123MB6574:EE_
X-Microsoft-Antispam-PRVS: <CWLP123MB65741D92E6C87C8228C75B24923A9@CWLP123MB6574.GBRP123.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: CPw3mnF+U2RBQukaZ9LyVxeYFJDo1IcNvYW5Z2+LGtBMfS7mB05ji6XgOYkkr0dNX+8Hr9/p+/wP0Nl+cPfYfeMgI3XzGRajjWvpGvqKbdJrKaJ2+pyveFuOIafkpiZzVhC0mjd+AoTvLARhuj65QPmYlYNPLKwaz0WKMqZMUa57uYnolU2rlAHZLpdLwC1IojEBV0MO03GwyeKfUWsxMz2EOVlkI/+P2sxSGMvSS4Zr5nYJRXdONDXamW+IQXv+SsmxvzHskh3J9kqV/BrlFTv/tqyUcV9sEvCVyKHJ1uDyqdbYHCKyPc0ccArOSIf14c8orvX+n8u88Y47ovcfx0jkKbzVkFvUAT+PpWVTgt9n1SYq12FO/7ccY7qQw1eMSkqwX0uCXQDKmIvdltbuVGLEzphLCpXfeE1h6Cx6151Zl+0pRGRe+S5XYOBaYjFsi/hnywn86eYOuLJ2EgZp4cxsjblgE8sE/uIbgVeBRQf2VAkihGeRHYkhe9Tmy5iIKElNc55UsdrDz/dELi3o32x1xf/HcRsLNjA8u8LRgRFW2RI3lh1sHOJAZrMX1jNiYv02Q2s+0rWALM4tJO2rLtqkJ+W6KtxqG70FZajh7tWYqtAJWen2mLQ8CKDSXsoR7Ui/lmIWHgY096wfxrB3oaErPMARSUzR97W1NgMmmwCH4vOI3Vext/gn70hNUljUJZcq38Rz6cAEy7kpaZj/Lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(52116002)(6666004)(6512007)(6506007)(5660300002)(508600001)(8936002)(38350700002)(38100700002)(36756003)(15650500001)(2906002)(86362001)(4326008)(8676002)(6486002)(54906003)(2616005)(83380400001)(66946007)(66556008)(66476007)(6916009)(316002)(26005)(186003)(1076003);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xPlgmun+zGNw8sffeYZrMDfvz/csKg4o9yE4iAJ8dFA6jiKe9qbtGOlYwFcz?=
 =?us-ascii?Q?cJqyhcufBuwmCTAHJt4llQirHcOEXO8PhOz1HQCYAmJPObwbZqThI0sAUlqE?=
 =?us-ascii?Q?O+Rx4/mAlvTxgE8POqId1TO8n0scGBBM4yWqguhEIyc87PKxm2ajOs0mewM3?=
 =?us-ascii?Q?j4BYyN2uQYrGVcz8Y+IvxIbLep/gY5SODT924k2+VPVE5x2fqfuUVGtLAS3x?=
 =?us-ascii?Q?p1NTguVsydPbfjE3Nj9rPC9roi6TOPR4Rk5xwJ6j6MFPqLRZ0r+UAyPOHP+w?=
 =?us-ascii?Q?/nTfjcc8ulYIATuGfNEdP5RHqxRNgzjvz1csQom4bY27v+nYoO+QjQUtimZl?=
 =?us-ascii?Q?SJw+iwI+b2xHmed7nK/n0fIl7jMQFNd6PG6yTdoCEs0ISOwgz1cxdzHQF9HM?=
 =?us-ascii?Q?DFKa4E++NognbBwUSHN6fkDxQMmSStxLJhfUB2oXs4PVw96cXfUs+TCrThKX?=
 =?us-ascii?Q?XascVnEDVtIVPTrNXxcuPgno1uFENSbxw6N3SkMmhVu5cWKlsQNaryg/tODZ?=
 =?us-ascii?Q?pAVmoC+41hd/GDP8/HYmfycJMN1CIRDBRt0IflxaMCaxmQHLRLDBauIyui2y?=
 =?us-ascii?Q?bnls0Z/kvGmYddpynWDsoVWBTU3rzCdRTnsNeICxLQmTfClFiQjTjoYkateE?=
 =?us-ascii?Q?5M7JbWjTaX8F1MXR3GlFK2aUCj0cMPswz9QiSLCivicIjd2y+9H9ce2ryzJN?=
 =?us-ascii?Q?5sH5R2qNp3pflXtlrm+81BGg5vyV/qDtne3dKUNVi0hYkA2PILjUKNvqy61q?=
 =?us-ascii?Q?JgQzqZZFM0rxFZ5ZKODxNTHrRHvuz5Fn2PsFdOR40y2F5qHZ+oygZdu+zBXC?=
 =?us-ascii?Q?DCmHNZTQlvFtDgrQhwomGA7H/V0Kp/YSH01X05ubeFVxiyE7JtiAnB04EkHw?=
 =?us-ascii?Q?r1BOIswy5FRZkxpAzT5LPqY93xFqCl+JfTCb+qXCVULA2+qFZRs5ah1fsqgb?=
 =?us-ascii?Q?YurSSZfpMxAht4ia/B0DJLUTPnIgYIw0XFtUn3jGgrJD3yB89Accn07Ju4H7?=
 =?us-ascii?Q?g6Nqtym/pAx1XWNNAd//0AbHoG9TJbL+ALXgoK8e5TGYEwYxwws3rQJuaV72?=
 =?us-ascii?Q?6CtbdTGURu2BBG1iee5G+9MgaWkldVIgYD610g/9wIMaMd+iuY84tR22XJ8V?=
 =?us-ascii?Q?/afbqjlp6pb6YiAzdlP2iuWL/I8bqAPyXe4gXYlEDxR5WKFL5q8AGHWzBS8b?=
 =?us-ascii?Q?Fg4OnNOO2hBmhXTn/OnYSVuTj1ciDKcT/0VBUJkpddRk8lBpafHYRQvDXFYb?=
 =?us-ascii?Q?VjnOJV4BGSfgDoog8CWnxdjIr0ANZHTixOV1BIX5dmwHdECM+D2mowM3lwKd?=
 =?us-ascii?Q?M0l2reAi1L7VKlpdBpmti39nKSIw97TKXbte3jgjxt+/WpjbsyvnRi5zsag8?=
 =?us-ascii?Q?ejh40DnsY4HW16BatHJch9JrZiRX+mqkJ0Ngq2EE6jH0XNAc2zVg+/YHWwvl?=
 =?us-ascii?Q?XTz9oFE20v3uYMVr7OxHNlJXx8LCkuCk+ataRoiKcfAR7CHdeFFGv1aif+Ce?=
 =?us-ascii?Q?2IIzdFdlmaNZ9a8uq4jtDGTyz23XiDaIKrj0ADsimWmD50oCclqBUA38IKmu?=
 =?us-ascii?Q?zQUx8rvjcLZWAcJBHZuT6OMfzrVGwH3RyGMDMTe+gdnTlmj+FLd5wYhN2lKe?=
 =?us-ascii?Q?yYZvZAE2C7D5/SWqVNhvOgNSyL7XegOiXkoiCEokn8+X5BVzYftM0xaI/zoR?=
 =?us-ascii?Q?9aIQ7I8IjFQ8cDMrNCsXeBu9610=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb7424b-720f-4b8c-d3ad-08d9f528dcec
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 10:56:50.4747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LyRBjcEzul3POAYINh/eAxOjYNSA8r0ysyLouQHjfPGe0ThbYknVd30E7VlSeY9kvkUZ58ZjHFztNvnrlYAAcT+4QeicQK3rhKN4WcHUWGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6574
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUK97A341 smtp.mailfrom=tomasz.mon@camlingroup.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Lech Perczak <l.perczak@camlintechnologies.com>

RTS, DTR and LOOP bits can be updated in a single MCR register update.
This reduces the number of (slow) SPI/I2C bus transactions.

Signed-off-by: Lech Perczak <l.perczak@camlintechnologies.com>
Signed-off-by: Tomasz Mo=C5=84 <tomasz.mon@camlingroup.com>
---
 drivers/tty/serial/sc16is7xx.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.=
c
index 3800733452fe..c62531b2efe2 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -787,19 +787,24 @@ static void sc16is7xx_reg_proc(struct kthread_work *w=
s)
 =09spin_unlock_irqrestore(&one->port.lock, irqflags);
=20
 =09if (config.flags & SC16IS7XX_RECONF_MD) {
+=09=09u8 mcr =3D 0;
+
+=09=09/* Device ignores RTS setting when hardware flow is enabled */
+=09=09if (one->port.mctrl & TIOCM_RTS)
+=09=09=09mcr |=3D SC16IS7XX_MCR_RTS_BIT;
+
+=09=09if (one->port.mctrl & TIOCM_DTR)
+=09=09=09mcr |=3D SC16IS7XX_MCR_DTR_BIT;
+
+=09=09if (one->port.mctrl & TIOCM_LOOP)
+=09=09=09mcr |=3D SC16IS7XX_MCR_LOOP_BIT;
 =09=09sc16is7xx_port_update(&one->port, SC16IS7XX_MCR_REG,
+=09=09=09=09      SC16IS7XX_MCR_RTS_BIT |
+=09=09=09=09      SC16IS7XX_MCR_DTR_BIT |
 =09=09=09=09      SC16IS7XX_MCR_LOOP_BIT,
-=09=09=09=09      (one->port.mctrl & TIOCM_LOOP) ?
-=09=09=09=09      SC16IS7XX_MCR_LOOP_BIT : 0);
-=09=09sc16is7xx_port_update(&one->port, SC16IS7XX_MCR_REG,
-=09=09=09=09      SC16IS7XX_MCR_RTS_BIT,
-=09=09=09=09      (one->port.mctrl & TIOCM_RTS) ?
-=09=09=09=09      SC16IS7XX_MCR_RTS_BIT : 0);
-=09=09sc16is7xx_port_update(&one->port, SC16IS7XX_MCR_REG,
-=09=09=09=09      SC16IS7XX_MCR_DTR_BIT,
-=09=09=09=09      (one->port.mctrl & TIOCM_DTR) ?
-=09=09=09=09      SC16IS7XX_MCR_DTR_BIT : 0);
+=09=09=09=09      mcr);
 =09}
+
 =09if (config.flags & SC16IS7XX_RECONF_IER)
 =09=09sc16is7xx_port_update(&one->port, SC16IS7XX_IER_REG,
 =09=09=09=09      config.ier_clear, 0);
--=20
2.25.1

