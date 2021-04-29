Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2F3C433B4
	for <linux-serial@archiver.kernel.org>; Thu, 29 Apr 2021 07:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D101C61431
	for <linux-serial@archiver.kernel.org>; Thu, 29 Apr 2021 07:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239280AbhD2HVI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 29 Apr 2021 03:21:08 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41862 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239259AbhD2HVH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Apr 2021 03:21:07 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13T79B0X057234;
        Thu, 29 Apr 2021 07:19:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=jsdn4YxHgm56M3A35OuWefg0AHZp+MPWhQ4rZ6Il2VA=;
 b=iWkQenwG3/viiiDGAbizIcboIyUDMZseD9BDr6CmT5ZUS+GtREm9R/z621iNvtUl7GPp
 4RZWaCkGR0nObiIeFnCIkhYfSBvLz/rvJxPMdR0px2CyG1wnk9JWRdQgp8W0N1t2UHmT
 ErKAkD1EASHjpzxrNSkNQ8Ljre8BSHeWFQz9Ld889bWeG88vW+pGnbWBlWTDqQrgEs63
 UoW8Q2z3p0Oa2rl6bUBD/UyF5aWDbUMxSxZi3SIA4KcRblUXRF6Csrcf7TMGTBAlULSS
 A6QJLy+KypqOUlIoLfzJB6BAhUcP+qyN71C2+6S9rT0zzAyMsxYFwu30APIMjxuQKqCs Ig== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 385afq3as3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 07:19:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13T7Eo5i105983;
        Thu, 29 Apr 2021 07:19:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3874d34xxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 07:19:33 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13T7JXcx123631;
        Thu, 29 Apr 2021 07:19:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 3874d34xxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 07:19:33 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13T7JW1p010053;
        Thu, 29 Apr 2021 07:19:32 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Apr 2021 07:19:31 +0000
Date:   Thu, 29 Apr 2021 10:19:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] serial: 8250_omap: fix a timeout loop condition
Message-ID: <YIpd+kOpXKMpEXPf@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-ORIG-GUID: DuMRfTpx1w-bLUMeQFEqUvhKOVz6spGf
X-Proofpoint-GUID: DuMRfTpx1w-bLUMeQFEqUvhKOVz6spGf
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1011 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104290052
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This loop ends on -1 so the error message will never be printed.

Fixes: 4bcf59a5dea0 ("serial: 8250: 8250_omap: Account for data in flight during DMA teardown")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/tty/serial/8250/8250_omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 8ac11eaeca51..c06631ced414 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -813,7 +813,7 @@ static void __dma_rx_do_complete(struct uart_8250_port *p)
 			       poll_count--)
 				cpu_relax();
 
-			if (!poll_count)
+			if (poll_count == -1)
 				dev_err(p->port.dev, "teardown incomplete\n");
 		}
 	}
-- 
2.30.2

