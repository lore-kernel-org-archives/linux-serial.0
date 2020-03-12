Return-Path: <SRS0=FKjJ=45=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60101C5ACC0
	for <linux-serial@archiver.kernel.org>; Thu, 12 Mar 2020 08:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C2920650
	for <linux-serial@archiver.kernel.org>; Thu, 12 Mar 2020 08:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J+7nxoNf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388197AbgCLIBn (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Mar 2020 04:01:43 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40292 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388186AbgCLIBm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Mar 2020 04:01:42 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02C7wjBS038372;
        Thu, 12 Mar 2020 08:01:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=XvYHsboiG2BhzPT10Pu1PpnnzQA6MDBoslIAumrXS24=;
 b=J+7nxoNf5NV50ltobVn//4LULEce7+erMspIXzwzZY6Q7BG3Qj8h2muMk5HagaGa2/Qf
 pEP4tleqZkPHtHHcE5iRnovnUXvKkUtqCUyOGWHGPZls8FGaisnKi8bJxfCMhMNeckWN
 ZxGZpUvKYRu+aUL5gNO/5IV5txzoZdkorxp9Kys8ymiotTVf1D6CdLXSoKnoILFQvG4o
 Q0aalrUN9p2yJ4pAKpGjW1d7MADPW56yv18VgjJWj6e5tAP8wjlr/nkMDJz83UWVoh42
 OfCOw77BM5pUeGSLZ8YAVH174k3RiWR9SyPEQcLnW40TC/jsgVAbJtSJIXluC5BLWp7g xg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2yp9v6b3nv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 08:01:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02C7w3lG179730;
        Thu, 12 Mar 2020 08:01:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2yqgvc9nrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 08:01:27 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02C81NBC003458;
        Thu, 12 Mar 2020 08:01:26 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Mar 2020 01:01:22 -0700
Date:   Thu, 12 Mar 2020 11:01:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     lanqing.liu@unisoc.com
Cc:     linux-serial@vger.kernel.org
Subject: [bug report] serial: sprd: Add DMA mode support
Message-ID: <20200312080117.GA3881@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9557 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=978 suspectscore=3 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120042
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9557 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1011 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120042
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello Lanqing Liu,

The patch f4487db58eb7: "serial: sprd: Add DMA mode support" from Mar
4, 2019, leads to the following static checker warning:

	drivers/tty/serial/sprd_serial.c:1141 sprd_remove()
	error: we previously assumed 'sup' could be null (see line 1132)

drivers/tty/serial/sprd_serial.c
  1128  static int sprd_remove(struct platform_device *dev)
  1129  {
  1130          struct sprd_uart_port *sup = platform_get_drvdata(dev);
  1131  
  1132          if (sup) {
                    ^^^
Check

  1133                  uart_remove_one_port(&sprd_uart_driver, &sup->port);
  1134                  sprd_port[sup->port.line] = NULL;
  1135                  sprd_ports_num--;
  1136          }
  1137  
  1138          if (!sprd_ports_num)
  1139                  uart_unregister_driver(&sprd_uart_driver);
  1140  
  1141          sprd_rx_free_buf(sup);
                                 ^^^
Unchecked dereference inside function

  1142  
  1143          return 0;
  1144  }

regards,
dan carpenter
