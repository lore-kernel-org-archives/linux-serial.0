Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A163AC433B4
	for <linux-serial@archiver.kernel.org>; Mon,  3 May 2021 14:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72DCC611BF
	for <linux-serial@archiver.kernel.org>; Mon,  3 May 2021 14:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhECOz5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 3 May 2021 10:55:57 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34574 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbhECOz4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 3 May 2021 10:55:56 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 143EnUY5078997;
        Mon, 3 May 2021 14:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=TXA8sOKaTOPue529/45nwBbsE1uKyU93EWPEE7BrQsU=;
 b=MUdNHoNGVWnOfxw6yKiAO9mu3cgbiGJQQ8M3pojaUJ4eU1d4w4LB6xjupKzLkOzlYbLF
 9xlSllxJaGifBuNqTZuQekmy6xr9Y2PaOjUOBEMzJ5K/cF6TH9YsnP1VwgqcOCq/2IPX
 F5EyKXZRKYhbUTocBOt+ThXQlGTWvLE9BY67ARFZSpqDphQ9oKy6q+VNc0YsE2oAXig2
 lG8rRMLIzwzKW+/YYs7RzircM6vPbSG0au+6bkHLFEp8Rfe7qLM22MX0sp6SodNR70p0
 tLqESODdNICYy3GDsFnNBl4DePF32tvXS5+2X3c0f48H90b7nRrCb/NLt+FGgS/dxNLy 5Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 388vgbkymd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 14:55:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 143EoBTE125490;
        Mon, 3 May 2021 14:55:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 388xt2guck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 14:55:01 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 143Eqwkj193098;
        Mon, 3 May 2021 14:55:01 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 388xt2gubj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 14:55:01 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 143Esx8a018062;
        Mon, 3 May 2021 14:55:00 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 May 2021 07:54:59 -0700
Date:   Mon, 3 May 2021 17:54:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     peter@hurleysoftware.com
Cc:     linux-serial@vger.kernel.org
Subject: [bug report] serial: 8250: Extract IIR logic steering from rx dma
Message-ID: <YJAOvZpFi9nTSkAX@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-GUID: gl6suyupiHMVaLhSaCDnuKHp2MIWqFig
X-Proofpoint-ORIG-GUID: gl6suyupiHMVaLhSaCDnuKHp2MIWqFig
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9973 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 impostorscore=0 clxscore=1011 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030103
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello Peter Hurley,

The patch 33d9b8b23a73: "serial: 8250: Extract IIR logic steering
from rx dma" from Apr 9, 2016, leads to the following static checker
warning:

	drivers/tty/serial/8250/8250_omap.c:1093 handle_rx_dma()
	warn: signedness bug returning '(-22)'

drivers/tty/serial/8250/8250_omap.c
  1084  static bool handle_rx_dma(struct uart_8250_port *up, unsigned int iir)
               ^^^^
This returns bool

  1085  {
  1086          switch (iir & 0x3f) {
  1087          case UART_IIR_RLSI:
  1088          case UART_IIR_RX_TIMEOUT:
  1089          case UART_IIR_RDI:
  1090                  omap_8250_rx_dma_flush(up);
  1091                  return true;
  1092          }
  1093          return omap_8250_rx_dma(up);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This returns error codes


  1094  }
  1095  
  1096  static unsigned char omap_8250_handle_rx_dma(struct uart_8250_port *up,
  1097                                               u8 iir, unsigned char status)
  1098  {
  1099          if ((status & (UART_LSR_DR | UART_LSR_BI)) &&
  1100              (iir & UART_IIR_RDI)) {
  1101                  if (handle_rx_dma(up, iir)) {
                            ^^^^^^^^^^^^^^^^^^^^^^
So I guess this is reversed for the omap_8250_rx_dma() case.

  1102                          status = serial8250_rx_chars(up, status);
  1103                          omap_8250_rx_dma(up);
  1104                  }
  1105          }
  1106  
  1107          return status;
  1108  }

regards,
dan carpenter
