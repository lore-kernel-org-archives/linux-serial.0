Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117D5C433DB
	for <linux-serial@archiver.kernel.org>; Mon, 29 Mar 2021 06:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1C4061960
	for <linux-serial@archiver.kernel.org>; Mon, 29 Mar 2021 06:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbhC2GEL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 29 Mar 2021 02:04:11 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:5799 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhC2GEG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 29 Mar 2021 02:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1616997846; x=1648533846;
  h=message-id:subject:from:to:cc:date:mime-version:
   content-transfer-encoding;
  bh=WoCYgpGwzwkMhETPa+Cx49yA9BK33IMcZ93mlYYWIZE=;
  b=ie3pnsG7+djZT3DVPOXj+vz7Xfa1H8bQydZtK2JvRWLvRS1RGm58LuUa
   jT4Yh4G30R/hUvVHYdH3H4DyYjNCPqBmiESkCNXlyuxP2U58SQUMbwM/m
   25niX1pWBI4PuhbsP+iCB09OlcDc/scMocKG7W9psCjIJmygITeMBtdrF
   BvkJnCc5ZaN5Vfqc9loA9YMgvIxocHsDfXzmYyaNs8deMK6DdPFtssYTe
   f4/4qfnXICeqU9TJbVUgPmiaXCN45xHtNPXs4dt5WzMTn4oiJoHAhotKF
   QtS/neEjCNX2SMfMc5QjQThqwS/JwD6kHzU3vP3OaFLPOykrPU4l93/gu
   w==;
IronPort-SDR: kvC3fwtJHjS46WcKChZOpeoVoKkljtslXjYW8phpAqLfxwB4UTlq0Zi+6jdUMia7YSbWrrzFq8
 3TDlIVAL5+SEKt5NNqPYVni6lN+/1gs6wXj8wyDbrwV5KnqD2RQofRC66pHzG8W+YzZ8rxkJes
 dR8hB5Z5pU176f9OmacBax03f2gp8G3qhk4gmxanZdaackdVnrtSOn8OsPGu/kiSPz30sL0+V7
 tIpjTz0egpsv+cR7Cl0I6bWvZ2PI/8W3zj+0HAZAOL8Uou1Box9FdqLzhUNPgTx3exMziWK2Dh
 fkg=
X-IronPort-AV: E=Sophos;i="5.81,285,1610434800"; 
   d="scan'208";a="114476485"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Mar 2021 23:04:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 28 Mar 2021 23:04:05 -0700
Received: from HYD-LT-I52873.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Sun, 28 Mar 2021 23:04:04 -0700
Message-ID: <e93aeae4a727b13b541973fe63240278217e2b45.camel@microchip.com>
Subject: git tree - branch to use for patch for UART(8250) drivers
From:   LakshmiPraveen Kopparthi <LakshmiPraveen.Kopparthi@microchip.com>
To:     <linux-serial@vger.kernel.org>
CC:     Ganesh Kumar Gurumurthy <GaneshKumar.Gurumurthy@microchip.com>
Date:   Mon, 29 Mar 2021 11:34:02 +0530
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Dear Maintainers,
I am planning to submit a patch to add support for one of our PCIe to
UART(16550) modules.I have found the the following tree in the
MAINTAINERS file for 8250/16?50 serial drivers.

git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git

The master branch in this tree doesn't have any check in from 2020-06-
14. I would like to know which branch to be used as a base to generate
and submit the patch. 

Thanks,
Lakshmi Praveen.   

