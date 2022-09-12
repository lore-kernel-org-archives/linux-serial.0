Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC40C6FA83
	for <linux-serial@archiver.kernel.org>; Mon, 12 Sep 2022 20:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiILUOS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 12 Sep 2022 16:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiILUOR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 12 Sep 2022 16:14:17 -0400
X-Greylist: delayed 902 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 12 Sep 2022 13:14:14 PDT
Received: from wedge010.net.lu.se (wedge010.net.lu.se [130.235.56.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC920481D9
        for <linux-serial@vger.kernel.org>; Mon, 12 Sep 2022 13:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=control.lth.se; s=edge;
        c=relaxed/relaxed; t=1663012749; h=from:subject:to:date:message-id;
        bh=BhGGxzZ6YWAjkpHYm45Bc+E/I+GF1WwFLNUhoY+uL9g=;
        b=HBC5UOWcmVq2id+eUdl+HlLh2/XVY4chm9WFudaAIn0aPXOH+R3HJvY4JSigh2y/MaRpzb1wtfL
        4+uxfzijVRQ+lg22KTEPTstL6ML/z+Wut21Wi1G/+8kotususpzvFE7MIZA8LG2tXu4/7whplA2Ad
        02ZaFwINS0J75JHNywd2av1t+wJCB6QsiGc0/pgRnYTYteIfGpEJDsERdgSDFuMz7GZMP7IfrS9mA
        UQZHn1IvWJ880TlRVQuVFLHFYEUxGxjW5mw7JeoVMPffApsBjQPWaouVujNGcoZR7HOQE8gKC4nXk
        1x+agDpYgVkFP+1FsIyOb3R31zuAgb1ijnNA==
Received: from wexc007.uw.lu.se (130.235.59.251) by mail.lu.se
 (130.235.56.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.2507.12; Mon, 12
 Sep 2022 21:59:09 +0200
Received: from [130.235.83.196] (130.235.139.100) by wexc007.uw.lu.se
 (130.235.59.251) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P521) id 15.1.2507.12; Mon, 12
 Sep 2022 21:59:09 +0200
Message-ID: <ef8fd762-88cf-548a-0599-17d939ad3a57@control.lth.se>
Date:   Mon, 12 Sep 2022 21:59:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-serial@vger.kernel.org>
From:   Anders Blomdell <anders.blomdell@control.lth.se>
Subject: kernel 5.19.8: "Oxford Semiconductor Ltd OXPCIe952 Dual Native 950
 UART" gets wrong baudrate (PCI ID 1415:c158)
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [130.235.139.100]
X-ClientProxiedBy: wexc011.uw.lu.se (130.235.59.233) To wexc007.uw.lu.se
 (130.235.59.251)
X-CrossPremisesHeadersFilteredBySendConnector: wexc007.uw.lu.se
X-OrganizationHeadersPreserved: wexc007.uw.lu.se
X-ORF-InterSessionInfo: eid=CNqSUe6Ra18=;oid=AAAAAMCENUM=;bar=wip;cid=AFRb3DDViAQ08ILSDHAc86NA4A==;iss=y;loc=hp;s=oimKRc0dyxoLh90pl9o355Ro213dy5Qw9UOj9NTlTmRLbk/ngH3DCnDu+tpkn7vcS4+6zR7rTat3nJiit12pAA==
Received-SPF: Pass (wedge010.net.lu.se: domain of
 anders.blomdell@control.lth.se designates 130.235.59.251 as permitted sender)
 receiver=wedge010.net.lu.se; client-ip=130.235.59.251; helo=wexc007.uw.lu.se;
X-CrossPremisesHeadersFilteredBySendConnector: wedge010.net.lu.se
X-OrganizationHeadersPreserved: wedge010.net.lu.se
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Reverting commits
   366f6c955d4d1a5125ffcd6875ead26a3c7a2a1c
   9c5c8aaed50bf3478073ab51b8b1f3f5327d3cfa
fixes my problems.

Regards

Anders Blomdell
-- 
Anders Blomdell                  Email: anders.blomdell@control.lth.se
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118
SE-221 00 Lund, Sweden
