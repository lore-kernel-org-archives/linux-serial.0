Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB7AE7D0A2
	for <linux-serial@archiver.kernel.org>; Thu, 21 Sep 2023 20:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjIUUS1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Sep 2023 16:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjIUUSG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Sep 2023 16:18:06 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8B358C17;
        Thu, 21 Sep 2023 10:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=hZzmjiPkjoKwhwTOfPzJiXq9Wl0FH1yszqaV+rmX80I=; b=gX8hIuAbTho75SiIiwYcncRz4a
        cf3Y54Xck0I4KLMTUmgwld9ikK+Hp0v/f89qjXDNwFSHXiERB9NDFRApJjYECpTtPztClR2E2klT1
        ADSvz1VvELePeyHhQNvbGVXEATXAwy4AeBV/fUaVlStIo6kz0YZ6jy3J6mO3rg0MeUD4=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:49420 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qjMbW-000117-8c; Thu, 21 Sep 2023 12:32:38 -0400
Date:   Thu, 21 Sep 2023 12:32:37 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Rob Herring <robh@kernel.org>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        hvilleneuve@dimonoff.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Message-Id: <20230921123237.b3c50eb12746724a4fd62237@hugovil.com>
In-Reply-To: <20230921162424.GA435508-robh@kernel.org>
References: <20230920152015.1376838-1-hugo@hugovil.com>
        <20230920152015.1376838-4-hugo@hugovil.com>
        <20230921162424.GA435508-robh@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: Re: [PATCH 3/4] dt-bindings: sc16is7xx: add vendor prefix to
 irda-mode-ports property
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 21 Sep 2023 11:24:24 -0500
Rob Herring <robh@kernel.org> wrote:

> On Wed, Sep 20, 2023 at 11:20:14AM -0400, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > The NXP-specific "irda-mode-ports" property lacks a proper vendor
> > prefix. Add "nxp," prefix to comply with DT best practises.
> 
> The opposite direction would be worth carrying in the driver, but I 
> don't think adding a vendor prefix is. I would just leave this as-is.
> 
> Rob

Hi Rob,
I am not following you, can you clarify?

Hugo.
