Return-Path: <SRS0=kmSd=7A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F42FC433E0
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 15:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2222A207D3
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 15:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgERPYr (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 May 2020 11:24:47 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:40185 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgERPYr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 May 2020 11:24:47 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id DDE8230006188;
        Mon, 18 May 2020 17:24:45 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B41652E4EA4; Mon, 18 May 2020 17:24:45 +0200 (CEST)
Date:   Mon, 18 May 2020 17:24:45 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, gregkh@linuxfoundation.org,
        jslaby@suse.com, matwey.kornilov@gmail.com,
        giulio.benetti@micronovasrl.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH v3 3/5] serial: 8250: Support separate rs485 rx-enable
 GPIO
Message-ID: <20200518152445.e3hbwpw3wzswu2n3@wunner.de>
References: <20200517215610.2131618-1-heiko@sntech.de>
 <20200517215610.2131618-4-heiko@sntech.de>
 <20200518151241.GG1634618@smile.fi.intel.com>
 <20200518152247.slenjeiiplps7mcd@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518152247.slenjeiiplps7mcd@wunner.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, May 18, 2020 at 05:22:47PM +0200, Lukas Wunner wrote:
> And for longer cables, users may have to disable it using the
> TIOCSRS485 ioctl.

Sorry, I meant *enable* here. %-/
