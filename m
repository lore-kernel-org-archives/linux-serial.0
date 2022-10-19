Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74748C4332F
	for <linux-serial@archiver.kernel.org>; Wed, 19 Oct 2022 16:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbiJSQCd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Oct 2022 12:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiJSQBs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Oct 2022 12:01:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D973A169138;
        Wed, 19 Oct 2022 09:01:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C7C76194B;
        Wed, 19 Oct 2022 16:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC97C433D6;
        Wed, 19 Oct 2022 16:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666195270;
        bh=Jl0feuE/hCUs4ZinWiIUvZ7CgpCxzFCrKhn3RWEyrwQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VWtwpcunzH553U7bdxHr7DqMaCVvmdidO8olmjkS6u7yq1zjVNxkuQqiKm1ovn1ij
         ZZ/Mwv44+JZtS9jsITPQD2w25OmVFl7Nmo37M+PWvo/GDoubNaKnVVxzI6SUN+7Idf
         orJhsE5NOIgSt4+6dRmlM0y9KijmA1wD9lr6e8AY=
Date:   Wed, 19 Oct 2022 18:01:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v2 11/38] tty: serial: earlycon: use
 console_is_enabled()
Message-ID: <Y1AfRKIptcqyeVE5@kroah.com>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-12-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019145600.1282823-12-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Oct 19, 2022 at 05:01:33PM +0206, John Ogness wrote:
> Replace (console->flags & CON_ENABLED) usage with console_is_enabled().
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
