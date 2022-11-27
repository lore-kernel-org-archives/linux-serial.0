Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1349C43217
	for <linux-serial@archiver.kernel.org>; Sun, 27 Nov 2022 17:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiK0RgX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 27 Nov 2022 12:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiK0RgW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 27 Nov 2022 12:36:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4296AEE05;
        Sun, 27 Nov 2022 09:36:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65DFFB80AEE;
        Sun, 27 Nov 2022 17:36:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DAE2C433B5;
        Sun, 27 Nov 2022 17:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669570577;
        bh=KXjgMIIzjeBW/b+BUU54O+6KKHdrQhBefEjGsi6yglo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iTs9uHb4YgSD0785JI5mzgYLquHrM9eYIbKfgfqb6DbI1McwaudwLVO9fge9apJYw
         3qvj+TsE9DbcQ1Peyy9OnP+irQ+Sa1TA2o7lv7R8/djO+Z07OSqMiS45Thr6koxkzb
         jPv3V3FlnX9VntLFLCA+yNz1/OD/3uuT1IvPLxi2VVG0t+yE+G8fBbO1HEzNN2n54y
         lF9p0AdM+o/PyyPK7MkaaMOvf/2B1MHtsM0EtLJT9ViEQkA/kjBKcWmbRmNtsFLroT
         pYC8dEPuzf8FrBtRYAM32dBoq30gYMzYmM/AniEY5KGpyvPvTwS6oPmCCQroday8Ff
         vsKs92+Stz3HA==
Date:   Sun, 27 Nov 2022 17:36:12 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 9/9] riscv: defconfig: enable BOUFFALOLAB SoC
Message-ID: <Y4OgDBSexibCJGBG@spud>
References: <20221127132448.4034-1-jszhang@kernel.org>
 <20221127132448.4034-10-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221127132448.4034-10-jszhang@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
