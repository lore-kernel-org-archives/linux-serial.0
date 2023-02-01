Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29FCC05027
	for <linux-serial@archiver.kernel.org>; Wed,  1 Feb 2023 07:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjBAHMu (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Feb 2023 02:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBAHMt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Feb 2023 02:12:49 -0500
X-Greylist: delayed 1831 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 31 Jan 2023 23:12:47 PST
Received: from walmailout01.yourhostingaccount.com (walmailout01.yourhostingaccount.com [65.254.253.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48E22ED64
        for <linux-serial@vger.kernel.org>; Tue, 31 Jan 2023 23:12:47 -0800 (PST)
Received: from mailscan01.yourhostingaccount.com ([10.1.15.1] helo=walmailscan01.yourhostingaccount.com)
        by walmailout01.yourhostingaccount.com with esmtp (Exim)
        id 1pN6ow-00014S-WE
        for linux-serial@vger.kernel.org; Wed, 01 Feb 2023 01:42:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=grabaclue.com; s=dkim; h=Content-Type:MIME-Version:Message-ID:Reply-To:From
        :Date:To:Subject:Sender:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BNWIenDKDE/rJsWT3z/BcBFEn9zY8Sn1XbkLDij0qSU=; b=MlAidqyIbjsdCMfhPMJK675bGH
        MDaQzepYL2ST9O+vcJK+vvHB9wls4C+mkNqzOcKsuWW+Fd8+EDYRY1aBTQsUlDdZcxrWKC+2lO8MI
        eoMjOxODiuytkwLQMSq3lSH1NCsqVz3GuNn6x5pf43Wj9RBWsQQQGcpi1PtJsgSZf39tVCT63ZEgc
        ygTyDwFNOiEu7/2izZJ7rycDh/IMkBdqBtNH0PcDJ7VIEJ7GS9oiDI+JA1LSCXui25ZcmGHQONm0Y
        RBywkFMoXt0cPfnn0XbT+HNE/ZkJxxTLJN4p3EOSvsTD4lVb4XDAPwCn0nsggrHGpS316YHGJjfoW
        Lm4aWU1Q==;
Received: from [10.114.3.23] (helo=walimpout03)
        by walmailscan01.yourhostingaccount.com with esmtp (Exim)
        id 1pN6ow-0002Ne-OU
        for linux-serial@vger.kernel.org; Wed, 01 Feb 2023 01:42:14 -0500
Received: from IIS85S.nt.com ([10.15.51.85])
        by walimpout03 with 
        id FiiB2900x1qHeCS01iiEMB; Wed, 01 Feb 2023 01:42:14 -0500
X-EN-SP-DIR: OUT
X-EN-SP-SQ: 1
Received: from IIS85S.nt.com ([127.0.0.1]) by IIS85S.nt.com with Microsoft SMTPSVC(10.0.20348.1);
         Wed, 1 Feb 2023 01:42:11 -0500
Subject: linux-serial,  please confirm
To:     linux-serial@vger.kernel.org
X-PHP-Originating-Script: 0:d3dccas.php
Date:   Wed, 1 Feb 2023 01:42:11 -0500
From:   Sello Juaquin Dabeer <support@grabaclue.com>
Reply-To: sellojuaquindabeer@gmail.com
Message-ID: <9edcd91b02d9eecc6a81e5e6b3250271@grabaclue.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-OriginalArrivalTime: 01 Feb 2023 06:42:11.0705 (UTC) FILETIME=[502F3690:01D93608]
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

02/01/2023 01:42:11 am

Good day ,

Did you receive my previous email to you, or do I repeat ?

Best Regard,

Juaquin Dabeer

