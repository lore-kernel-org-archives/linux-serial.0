Return-Path: <SRS0=S7Zs=76=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9EEC433E0
	for <linux-serial@archiver.kernel.org>; Wed, 17 Jun 2020 11:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 863C320734
	for <linux-serial@archiver.kernel.org>; Wed, 17 Jun 2020 11:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MIEmoOwM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgFQLRM (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 17 Jun 2020 07:17:12 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:30295 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgFQLRM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 17 Jun 2020 07:17:12 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200617111708epoutp02ac365cd60ff84b1937f787ebb0ce7f68~ZUKi9Yplw2092320923epoutp02n
        for <linux-serial@vger.kernel.org>; Wed, 17 Jun 2020 11:17:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200617111708epoutp02ac365cd60ff84b1937f787ebb0ce7f68~ZUKi9Yplw2092320923epoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592392628;
        bh=De11PZoZWlcQRwwo0Y8/mr/Pxhnq+Txfs9hPs4x5UzQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=MIEmoOwMZwBbGlks8DVr4ZZ0gmwE19zwK6jWDXf8QbmZA2jxeJ48oPRPOEVKlIxYL
         qruR5Ef8YTcNrq1kmbGvVum3ME5mVxxXE4gdNFLEqMnNddTSsL7/Hyqp7um7ojJt/C
         ewYmDNfTiF1caAmFXhGyJPcWa2QIYyBfIgwVjNCk=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20200617111708epcas5p1c4e0e139b4bc55695b8bd93eea5fc4e9~ZUKiJfXDm1538915389epcas5p1N;
        Wed, 17 Jun 2020 11:17:08 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DF.BD.09703.3BBF9EE5; Wed, 17 Jun 2020 20:17:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20200617111707epcas5p3fcb86caeac4a852d44f37ae40759c8a1~ZUKhd7jLw3226032260epcas5p3F;
        Wed, 17 Jun 2020 11:17:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200617111707epsmtrp2629be9449835228b4369f02e6d3e5021~ZUKhdPlaY3247232472epsmtrp2B;
        Wed, 17 Jun 2020 11:17:07 +0000 (GMT)
X-AuditID: b6c32a4a-4cbff700000025e7-45-5ee9fbb3f906
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.4E.08382.3BBF9EE5; Wed, 17 Jun 2020 20:17:07 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200617111705epsmtip28dc31d81babdd092756d80f3eeda4d79~ZUKf9xn730587705877epsmtip2h;
        Wed, 17 Jun 2020 11:17:05 +0000 (GMT)
From:   Tamseel Shams <m.shams@samsung.com>
To:     kgene@kernel.org, krzk@kernel.org, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        Tamseel Shams <m.shams@samsung.com>
Subject: [PATCH] serial: samsung: fix spelling mistake
Date:   Wed, 17 Jun 2020 16:29:07 +0530
Message-Id: <20200617105907.7143-1-m.shams@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsWy7bCmhu7m3y/jDM4/sbF4MG8bm0Xz4vVs
        FlM2fGCy6H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gszizuZbe427qY3YHLY9OqTjaP/XPX
        sHtsXlLv0bdlFaPH+i1XWTw+b5ILYIvisklJzcksSy3St0vgyuh69YO1YAdrxfSTy1gbGHex
        dDFyckgImEhMvHyMuYuRi0NIYDejxPm/P9ggnE+MEqe7ZrFDON8YJZo2bgHKcIC1LL0YDhHf
        yygx4+06RginhUni3/MdjCBFbAKaEsfPc4OsEBEIkXh3dgtYDbPASUaJvZsbwHYLC5hJrD3Q
        wA5SzyKgKjFtqixImFfAXOLWqrnsEOfJS6zecIAZwj7HLtH3IQPiBheJi5fLIcLCEq+Ob4Eq
        l5L4/G4vG4SdLzF/3iqo1gqJlRfeQNn2EgeuzGEBGcMMdOX6XfogYWYBPone30+YIKbzSnS0
        CUFUK0r8390PNV1c4t2KKawQtofEv9vLwCYKCcRKvHx0n3kCo8wshKELGBlXMUqmFhTnpqcW
        mxYY5aWW6xUn5haX5qXrJefnbmIEx7+W1w7Ghw8+6B1iZOJgPMQowcGsJMLr/PtFnBBvSmJl
        VWpRfnxRaU5q8SFGaQ4WJXFepR9n4oQE0hNLUrNTUwtSi2CyTBycUg1MUx1U9k79cXn3jDiZ
        v/NevD748dqKgAK1jdw8rafsG959vH173jN7Ru3l25LevjVi0iz46nrZylFlU9TvSS4Pjxbm
        T9nBeT4/4Y7l/29er7fNsLxYv3bGdqaXNw0k6rx2KR39/3qG6MbcbaHbF/yIfdLhdGVxJI93
        q77iUz6LHZ9zXHZuOq3wjT3U2jx9m9ULr2vvz+y6eiYwaumLa6f0UifceTKL5b/fFMZLj+aY
        /FvU1yJ+8n7ue+mviyMrZV1O1CxblvmbT8pxssuK6W99Jj04ePjqPrad/+15971Z4vfzRHrO
        zufi97TLdgger+juE7wxY7a7sd6slRahAn7/vti9Lnhpk5jQ66G5V6GPafMmJZbijERDLeai
        4kQAIHwlMm4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42LZdlhJXnfz75dxBgu3c1k8mLeNzaJ58Xo2
        iykbPjBZ9D9+zWxx/vwGdotNj6+xWlzeNYfNYsb5fUwWZxb3slvcbV3M7sDlsWlVJ5vH/rlr
        2D02L6n36NuyitFj/ZarLB6fN8kFsEVx2aSk5mSWpRbp2yVwZXS9+sFasIO1YvrJZawNjLtY
        uhg5OCQETCSWXgzvYuTiEBLYzSgxc8khxi5GTqC4uMS0X/uhbGGJlf+es0MUNTFJfLt/nBGk
        mU1AU+L4eW4QU0QgQmLmxxqQEmaB84wSO4+vZgLpFRYwk1h7oIEdpIZFQFVi2lRZkDCvgLnE
        rVVz2SHGy0us3nCAeQIjzwJGhlWMkqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMFhpqW5
        g3H7qg96hxiZOBgPMUpwMCuJ8Dr/fhEnxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdG4cI4IYH0
        xJLU7NTUgtQimCwTB6dUA1OV3YnmfHbj1AV/b/De4vZeOJe9ie2xZ0hZYd7Dja+Uetjv79KV
        k5m3sMs/6tGNvaG9J00FfnaFzJ/0P3lB6Q2tiKmTauLeBNkIn/Nclsq35kB38Jc7d93vnd/z
        XuRs2o3uvPxN247uaTFp135z2fnH9qk30tgVHBtNnpfdPR986pvtE91pGc2HVGR3X+EVtLuv
        aOT7cvOj6P3bpEyOXPbKK9z2UGHOpRlr7z9od5nd+HGpzMOArUeWvWHzmqr5b9L+/SrMj7bK
        SbCefvC868/TTzfSszm95TS7fKqCuXr9gralvzo7gUPwyJvKure5KxbLul/LsL4mYr7MSEtv
        p/v/Oxxzrs7ivHjad+ZZax0WJZbijERDLeai4kQAXXhHFaICAAA=
X-CMS-MailID: 20200617111707epcas5p3fcb86caeac4a852d44f37ae40759c8a1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200617111707epcas5p3fcb86caeac4a852d44f37ae40759c8a1
References: <CGME20200617111707epcas5p3fcb86caeac4a852d44f37ae40759c8a1@epcas5p3.samsung.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There is a spelling mistake in a comment. Fix it.

Signed-off-by: Tamseel Shams <m.shams@samsung.com>
---
 drivers/tty/serial/samsung_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 6ef614d8648c..050a47fecdef 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -6,7 +6,7 @@
  *	http://armlinux.simtec.co.uk/
  */
 
-/* Hote on 2410 error handling
+/* Note on 2410 error handling
  *
  * The s3c2410 manual has a love/hate affair with the contents of the
  * UERSTAT register in the UART blocks, and keeps marking some of the
-- 
2.17.1

