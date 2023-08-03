Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345C3C001DF
	for <linux-serial@archiver.kernel.org>; Thu,  3 Aug 2023 14:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236797AbjHCOkZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 3 Aug 2023 10:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbjHCOkM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 Aug 2023 10:40:12 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B1D2D5F;
        Thu,  3 Aug 2023 07:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=RwiPZlt5h+l4EEd8rB/jTQqRs++DtmWkgJ+ASZBIevQ=; b=oKnK7lRHjeM0i+OIw/kOkx+eER
        pTAxR4L3yLU7FPGjZ/jLO9ju5GtEGxxcFGlty1ZuuJqaSLE6WwgWLquAK5abU/hO2oivzTXO1Gokb
        CQyAKUd87AIH28B+pA77cfx1sqdu8hsCQjS2UOEKPEoIWusrDSBXJwGR9VGDpk43GqjI=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:59988 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qRZSx-0000hw-9W; Thu, 03 Aug 2023 10:38:15 -0400
Date:   Thu, 3 Aug 2023 10:38:14 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jirislaby@kernel.org, jringle@gridpoint.com,
        isaac.true@canonical.com, jesse.sung@canonical.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lech Perczak <lech.perczak@camlingroup.com>
Message-Id: <20230803103814.ec35dbddad880a77565ff681@hugovil.com>
In-Reply-To: <2023073146-gauntlet-lake-0b77@gregkh>
References: <20230725142343.1724130-1-hugo@hugovil.com>
        <20230725142343.1724130-9-hugo@hugovil.com>
        <2023073146-gauntlet-lake-0b77@gregkh>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: Re: [PATCH v9 08/10] serial: sc16is7xx: add call to get rs485 DT
 flags and properties
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, 31 Jul 2023 17:59:14 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Tue, Jul 25, 2023 at 10:23:40AM -0400, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Add call to uart_get_rs485_mode() to probe for RS485 flags and
> > properties from device tree.
> 
> Again, you are saying what you are doing, but not why.  I have no hint
> as to if this is a bugfix, or a new features, or something else?
> 
> thanks,
> 
> greg k-h

Hi Greg,
I could change the commit message to:

---------
serial: sc16is7xx: add missing support for rs485 devicetree properties

Retrieve rs485 devicetree properties on registration of sc16is7xx ports
in case they are attached to an rs485 transceiver.
---------

I don't think that it should be considered as a bug fix, but maybe as a
missing feature.

And does it mean that it should also go to older (stable) kernels then?
If yes, then do I need to add the "Fixes" tag?

Thank you,
Hugo.
