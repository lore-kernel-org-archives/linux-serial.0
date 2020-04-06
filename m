Return-Path: <SRS0=wTQQ=5W=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D20C2BA19
	for <linux-serial@archiver.kernel.org>; Mon,  6 Apr 2020 14:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A2E24679
	for <linux-serial@archiver.kernel.org>; Mon,  6 Apr 2020 14:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A8K9S9a6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgDFOm6 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:42:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33656 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbgDFOm6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Apr 2020 10:42:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036Edp26187573;
        Mon, 6 Apr 2020 14:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=VphygEHsVVyEJ7NmbUpBq72yHsE60+NHTngXDge3pv8=;
 b=A8K9S9a6Wy9kXvrrLF2+Dy1ifr60p4L8OXvdwf6n18sV3wPXjIrrSkz2UrYByjjTe0NI
 XYaJAovPgdwPb87V0mTcZqhg6ybFkd+05ZVdwrB5N+5hhcCqOdmLDk7fGXTj5n1HV0Lj
 8X5l4KVsqCdN0WMJCMYGQtYgtlQCUOF8o3oYhVKOuZl8ut1Iz0Np99TTfkvNBPLR0B7Z
 6Cgt/JFyyUnVRWzBygBUPfMRpvzM1SMNWk5QWok8Aoa+EyXnbXoh/rJHSV5CKFIlrjJv
 jAWFIjNZfOaprJfhRraw11H0QYIF5cQ9YR7ypcbFLD5nlM7N5M39bsb32n8pEffq+Ped AA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 306hnqy9v3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Apr 2020 14:42:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036EfN8U035038;
        Mon, 6 Apr 2020 14:42:55 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 30741arefg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Apr 2020 14:42:55 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 036EgolD022744;
        Mon, 6 Apr 2020 14:42:54 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Apr 2020 07:42:49 -0700
Date:   Mon, 6 Apr 2020 17:42:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     michael@walle.cc
Cc:     linux-serial@vger.kernel.org
Subject: [bug report] tty: serial: fsl_lpuart: fix DMA mapping
Message-ID: <20200406144243.GB68494@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=10 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=987
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=10
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060121
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello Michael Walle,

This is a semi-automatic email about new static checker warnings.

The patch a092ab25fdaa: "tty: serial: fsl_lpuart: fix DMA mapping" 
from Mar 6, 2020, leads to the following Smatch complaint:

    drivers/tty/serial/fsl_lpuart.c:1237 lpuart_dma_rx_free()
    error: we previously assumed 'chan' could be null (see line 1234)

drivers/tty/serial/fsl_lpuart.c
  1228  static void lpuart_dma_rx_free(struct uart_port *port)
  1229  {
  1230          struct lpuart_port *sport = container_of(port,
  1231                                          struct lpuart_port, port);
  1232          struct dma_chan *chan = sport->dma_rx_chan;
  1233	
  1234		if (chan)
                    ^^^^
The patch adds a check

  1235			dmaengine_terminate_all(chan);
  1236	
  1237		dma_unmap_sg(chan->device->dev, &sport->rx_sgl, 1, DMA_FROM_DEVICE);
                             ^^^^^^
and an unchecked dereference.

  1238		kfree(sport->rx_ring.buf);
  1239		sport->rx_ring.tail = 0;

regards,
dan carpenter
