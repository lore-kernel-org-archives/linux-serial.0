Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351AFC04A94
	for <linux-serial@archiver.kernel.org>; Fri,  4 Aug 2023 13:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjHDNRc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Aug 2023 09:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjHDNQg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Aug 2023 09:16:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE435586;
        Fri,  4 Aug 2023 06:14:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3234F61FF5;
        Fri,  4 Aug 2023 13:14:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C28EC433C7;
        Fri,  4 Aug 2023 13:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691154885;
        bh=huRgIJ1gYjuFi3Njv1/kzHWYkFWESf8EQfF18/ErDXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XKe2d3mw0c0DB6ojc98z5+Ru8IDhBwbogj65tkUh84zANpvkzp0kNWsVUb1DMWt/l
         V5cFby4aVwVI02GSgN5BgHEVSHbRBuuHhgjCGC+3DHLH4HGvuVkA5W8y/lsDHmyaRs
         vnha7MjEDfEfZvH7c9q460nCSWLNU7JXjj9KavRA=
Date:   Fri, 4 Aug 2023 15:14:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jirislaby@kernel.org, jringle@gridpoint.com,
        isaac.true@canonical.com, jesse.sung@canonical.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lech Perczak <lech.perczak@camlingroup.com>
Subject: Re: [PATCH v9 08/10] serial: sc16is7xx: add call to get rs485 DT
 flags and properties
Message-ID: <2023080429-animate-elliptic-3167@gregkh>
References: <20230725142343.1724130-1-hugo@hugovil.com>
 <20230725142343.1724130-9-hugo@hugovil.com>
 <2023073146-gauntlet-lake-0b77@gregkh>
 <20230803103814.ec35dbddad880a77565ff681@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803103814.ec35dbddad880a77565ff681@hugovil.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Aug 03, 2023 at 10:38:14AM -0400, Hugo Villeneuve wrote:
> On Mon, 31 Jul 2023 17:59:14 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Tue, Jul 25, 2023 at 10:23:40AM -0400, Hugo Villeneuve wrote:
> > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > 
> > > Add call to uart_get_rs485_mode() to probe for RS485 flags and
> > > properties from device tree.
> > 
> > Again, you are saying what you are doing, but not why.  I have no hint
> > as to if this is a bugfix, or a new features, or something else?
> > 
> > thanks,
> > 
> > greg k-h
> 
> Hi Greg,
> I could change the commit message to:
> 
> ---------
> serial: sc16is7xx: add missing support for rs485 devicetree properties
> 
> Retrieve rs485 devicetree properties on registration of sc16is7xx ports
> in case they are attached to an rs485 transceiver.
> ---------
> 
> I don't think that it should be considered as a bug fix, but maybe as a
> missing feature.
> 
> And does it mean that it should also go to older (stable) kernels then?
> If yes, then do I need to add the "Fixes" tag?

Does it fix a problem?  If so, yes, it should go to older kernels.  If
not, then no.

thanks,

greg k-h
