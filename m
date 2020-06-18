Return-Path: <SRS0=rTT/=77=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9685DC433E0
	for <linux-serial@archiver.kernel.org>; Thu, 18 Jun 2020 10:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7588B21924
	for <linux-serial@archiver.kernel.org>; Thu, 18 Jun 2020 10:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgFRKKU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:10:20 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:46410 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1728746AbgFRKKH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Jun 2020 06:10:07 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jun 2020 06:10:06 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 0A597200C125;
        Thu, 18 Jun 2020 18:10:05 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qGvK_SY5v7eO; Thu, 18 Jun 2020 18:10:04 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id E737A200C104;
        Thu, 18 Jun 2020 18:10:04 +0800 (HKT)
Received: from [10.128.3.2] (061244237146.static.ctinets.com [61.244.237.146])
        by s01.gtsys.com.hk (Postfix) with ESMTPSA id DC415C013A5;
        Thu, 18 Jun 2020 18:10:04 +0800 (HKT)
To:     linux-arm@lists.infradead.org, linux-serial@vger.kernel.org
Cc:     Jack Lo <jack.lo@gtsys.com.hk>
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
Subject: rk3399: uart2 crippled signal on tx @115200
Message-ID: <4d7fde0a-58f0-485f-41e6-2cb0b36decbc@gtsys.com.hk>
Date:   Thu, 18 Jun 2020 18:10:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

I run into a strange thing on our customized RK3399-LPDDR4 using the 
UART2 @115200 the
console spits bad charters. Checking the signal at the TX explains the 
reason, the rising edge
is very slow, (we checked with the scope).
Set the GPIO4_C4 to pcfg_pull_up_20am not working.

Kernel: 5.4.40-rt
Uboot: 2020-4

The strange observation:
U-boot TPL boot , return to Boot-rom and the 1st
lines from SPL (show uboot version) have a sharp rising edge as expected.

Anyone?  I don't know anymore.

Regards
Chris
