Return-Path: <SRS0=nVIq=DB=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44ACC2D0E2
	for <linux-serial@archiver.kernel.org>; Thu, 24 Sep 2020 12:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9731423977
	for <linux-serial@archiver.kernel.org>; Thu, 24 Sep 2020 12:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbgIXM1w (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 24 Sep 2020 08:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbgIXM1s (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 24 Sep 2020 08:27:48 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30950C0613CE;
        Thu, 24 Sep 2020 05:27:48 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BxvSx4dt3z9sV1; Thu, 24 Sep 2020 22:27:44 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20200916062138.191188-1-miaoqinglang@huawei.com>
References: <20200916062138.191188-1-miaoqinglang@huawei.com>
Subject: Re: [PATCH -next] serial: pmac_zilog: use for_each_child_of_node() macro
Message-Id: <160095000206.26280.11624408226554470734.b4-ty@ellerman.id.au>
Date:   Thu, 24 Sep 2020 22:27:44 +1000 (AEST)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 16 Sep 2020 14:21:38 +0800, Qinglang Miao wrote:
> Use for_each_child_of_node() macro instead of open coding it.

Applied to powerpc/next.

[1/1] serial: pmac_zilog: use for_each_child_of_node() macro
      https://git.kernel.org/powerpc/c/1d42e07e9c249b7a032fba82b673ee8a8d6bd7b7

cheers
