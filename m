Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A92C49EA5
	for <linux-serial@archiver.kernel.org>; Mon, 21 Jun 2021 04:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B1396124B
	for <linux-serial@archiver.kernel.org>; Mon, 21 Jun 2021 04:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhFUEtC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 21 Jun 2021 00:49:02 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:33446 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhFUEsM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 21 Jun 2021 00:48:12 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210621044557epoutp04e3022d97b43648fe157e00e61ede9916~Kf3VVjVq41293712937epoutp04D
        for <linux-serial@vger.kernel.org>; Mon, 21 Jun 2021 04:45:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210621044557epoutp04e3022d97b43648fe157e00e61ede9916~Kf3VVjVq41293712937epoutp04D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1624250757;
        bh=HCa46d8xYQI4DLHreMXbh3X5Yj5CBNQoIEHru9jul4s=;
        h=From:To:Cc:Subject:Date:References:From;
        b=auVekq9IwOr6OI9IsS+EtCWiLvrgoS/rpt4QxEe1tismHrbk2shcWHEjCijXyfQNY
         AWI6pAr3jBqhgR7xglt3qIi8/HN46SBYVmDD83vg6MzygHhRFGueIVs/FwcC1XWoeU
         H3ZWunnCZ9SaiyeGYDi6PYZe5jBv4sXcKyHKBZ/4=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20210621044556epcas5p100cf3c190e24a4dbe9af11a78de220c1~Kf3UJoqNB2864828648epcas5p1-;
        Mon, 21 Jun 2021 04:45:56 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        15.DD.09452.48910D06; Mon, 21 Jun 2021 13:45:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20210621044400epcas5p40368077e77d2da219db8f890dfd69f7c~Kf1oELPP_2579225792epcas5p4n;
        Mon, 21 Jun 2021 04:44:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210621044400epsmtrp297ccaf01b37d2ff8915f4002cf8f7d75~Kf1oDLhPF1386813868epsmtrp2p;
        Mon, 21 Jun 2021 04:44:00 +0000 (GMT)
X-AuditID: b6c32a4b-43fff700000024ec-3f-60d0198424fd
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        06.32.08394.01910D06; Mon, 21 Jun 2021 13:44:00 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210621044358epsmtip298180bc22c1b863fcc60f15273e3bebf~Kf1mc_2O92959129591epsmtip24;
        Mon, 21 Jun 2021 04:43:58 +0000 (GMT)
From:   Tamseel Shams <m.shams@samsung.com>
To:     kgene@kernel.org, krzk@kernel.org, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        ajaykumar.rs@samsung.com, Tamseel Shams <m.shams@samsung.com>
Subject: [PATCH v4] serial: samsung: change to platform_get_irq_optional
Date:   Mon, 21 Jun 2021 10:17:57 +0530
Message-Id: <20210621044757.40046-1-m.shams@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsWy7bCmlm6L5IUEg+03OC0OvD/IYvFg3jY2
        i+bF69kspmz4wGTR//g1s8X58xvYLTY9vsZqcXnXHDaLGef3MVmcWdzLbnG3dTG7A7fHplWd
        bB77565h99i8pN6jb8sqRo/1W66yeHzeJBfAFsVlk5Kak1mWWqRvl8CVcXD/MvaC7ZwVt68d
        ZGxg/MDexcjBISFgIvG1O6iLkYtDSGA3o0THhFWsEM4nRokn29axQDjfGCU6n75k6mLkBOv4
        OO8sI0RiL6PEi4WfmCCcFiaJ/yt7mEHmsgloShw/zw3SICIQIvHu7BawBmaBp4wSy49dZwFJ
        CAt4SNx4fI8VxGYRUJU49X8ZI4jNK2Ah0fSnhRVim7zE6g0HmEGaJQSusUt8vLsG6gwXiRm/
        trFB2MISr45vYYewpSQ+v9sLFc+XmD9vFTOEXSGx8sIbKNte4sCVOSwghzIDHbp+lz5EWFZi
        6ql1YOOZBfgken8/gVrFK7FjHoytKPF/dz/UKnGJdyumQN3pIbF/eiMryEghgViJa9t1JjDK
        zkJYsICRcRWjZGpBcW56arFpgXFearlecWJucWleul5yfu4mRnCa0PLewfjowQe9Q4xMHIyH
        GCU4mJVEeDkzzyQI8aYkVlalFuXHF5XmpBYfYpTmYFES513KfihBSCA9sSQ1OzW1ILUIJsvE
        wSnVwHS19u/ipJzd2pqd7xJvdAWcFNNJFkuak/CkoH4Ft//vWTsO35uaEvcq7+vqPH7rhnSH
        o6tFrQQ2+k2XK2VzkTq4LXTC2+LQPVcMV6teXTaJW/+AbFTADsFz6qkF+yeoGJ18zWN3JY/5
        7M2wxUyihsornvC8/O6r+Dwy8ibXy4qns6ZaTtW5ytC7fpZs4IOpW099eWRbcDDl4gt7GUGf
        Z5ue/97BXyv/0Hmd8ss3HyWOsV27bDg94dzkXlHhu49/C0VcVUgW1BMtU+I7sV3zpbk6Y5jN
        DNkzszqq+H23GDov/ffd53xLaeu/H5pZ5/IfNAXWW3M4/2rMqpLo+Hb1ct0MK0dLtezp051P
        dEywC1FiKc5INNRiLipOBACoeD6JggMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGLMWRmVeSWpSXmKPExsWy7bCSvK6A5IUEg+8PWCwOvD/IYvFg3jY2
        i+bF69kspmz4wGTR//g1s8X58xvYLTY9vsZqcXnXHDaLGef3MVmcWdzLbnG3dTG7A7fHplWd
        bB77565h99i8pN6jb8sqRo/1W66yeHzeJBfAFsVlk5Kak1mWWqRvl8CVcXD/MvaC7ZwVt68d
        ZGxg/MDexcjJISFgIvFx3lnGLkYuDiGB3YwSf1bNZYRIiEtM+7UfyhaWWPnvOTtEUROTxNy/
        e5i6GDk42AQ0JY6f5wYxRQQiJGZ+rAEpYRZ4zSix5cEEsF5hAQ+JG4/vsYLYLAKqEqf+LwOL
        8wpYSDT9aWGFmC8vsXrDAeYJjDwLGBlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIE
        B52W5g7G7as+6B1iZOJgPMQowcGsJMLLmXkmQYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T
        8UIC6YklqdmpqQWpRTBZJg5OqQam6PoH7MY8l7eX5Sx3/MtZu8Nz95lpd/xEeGdMbr6k3lS1
        6njfrZm21rOMHlx6mrWjL2yd//2kBv2K0+y3PhYby/wy3KJ29dnlTyc82d+38ulu4mh1nrm+
        +cs0tbb4b/6hpeIi+ttnqdkbPby10FDH6ZpzueM/1n0Fty/Jnp4UZ7lZyfzOgsh/sUefPvQX
        YL+qefWa9bXn6lIGfw0DjkxbeNN+rWvUvqU2ll+Yn/xyunT657aJ997UvVop08n7exef/9vD
        c9d6/+h89cjB+9mLRi/9LQKx3tnXru7vnBoat+Ejg/VVl/xKz9AL+7+261x+8PGz0anlyho7
        ctZxPyj7Mzv1TmjMtBVLbzSLThT4pKTEUpyRaKjFXFScCACla/+kqQIAAA==
X-CMS-MailID: 20210621044400epcas5p40368077e77d2da219db8f890dfd69f7c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210621044400epcas5p40368077e77d2da219db8f890dfd69f7c
References: <CGME20210621044400epcas5p40368077e77d2da219db8f890dfd69f7c@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

In few older Samsung SoCs like s3c2410, s3c2412
and s3c2440, UART IP is having 2 interrupt lines.
However, in other SoCs like s3c6400, s5pv210,
exynos5433, and exynos4210 UART is having only 1
interrupt line. Due to this, "platform_get_irq(platdev, 1)"
call in the driver gives the following false-positive error:
"IRQ index 1 not found" on recent platforms.

This patch replaces the platform_get_irq() call with
platform_get_irq_optional() and hence avoiding the
false-positive error.

Signed-off-by: Tamseel Shams <m.shams@samsung.com>
---
Commit message is changed.
Addressed Krzysztof's previous comment.
 
 drivers/tty/serial/samsung_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 6ef614d8648c..c44582011b9b 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1911,7 +1911,7 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 		ourport->tx_irq = ret + 1;
 	}
 
-	ret = platform_get_irq(platdev, 1);
+	ret = platform_get_irq_optional(platdev, 1);
 	if (ret > 0)
 		ourport->tx_irq = ret;
 	/*
-- 
2.17.1

