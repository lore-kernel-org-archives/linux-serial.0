Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A184C433FE
	for <linux-serial@archiver.kernel.org>; Fri,  4 Dec 2020 10:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEC93229EF
	for <linux-serial@archiver.kernel.org>; Fri,  4 Dec 2020 10:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387631AbgLDK5c convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Dec 2020 05:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgLDK5c (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Dec 2020 05:57:32 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FCEC061A51
        for <linux-serial@vger.kernel.org>; Fri,  4 Dec 2020 02:56:51 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kl8lS-0004Tj-Og; Fri, 04 Dec 2020 11:56:38 +0100
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kl8lM-0006gu-8p; Fri, 04 Dec 2020 11:56:32 +0100
Message-ID: <2c36ef4c2d022f6f83ec5c78a951d5e76f95378e.camel@pengutronix.de>
Subject: Re: [PATCH 1/5] media: dt-bindings: add the required property
 'additionalProperties'
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Stafford Horne <shorne@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-media <linux-media@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 04 Dec 2020 11:56:32 +0100
In-Reply-To: <20201204093813.1275-2-thunder.leizhen@huawei.com>
References: <20201204093813.1275-1-thunder.leizhen@huawei.com>
         <20201204093813.1275-2-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 2020-12-04 at 17:38 +0800, Zhen Lei wrote:
> When I do dt_binding_check for any YAML file, below wanring is always
> reported:
> 
> xxx/media/coda.yaml: 'additionalProperties' is a required property
> xxx/media/coda.yaml: ignoring, error in schema:
> warning: no schema found in file: xxx/media/coda.yaml
> 
> There are three properties defined in allOf, they should be explicitly
> declared. Otherwise, "additionalProperties: false" will prohibit them.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Thank you, there already is a patch to fix this:

https://lore.kernel.org/linux-media/20201117200752.4004368-1-robh@kernel.org/

regards
Philipp
