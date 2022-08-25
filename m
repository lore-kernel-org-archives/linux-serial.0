Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0941C04AA5
	for <linux-serial@archiver.kernel.org>; Thu, 25 Aug 2022 11:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbiHYLrP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 25 Aug 2022 07:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239774AbiHYLrO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 Aug 2022 07:47:14 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 974F07332B;
        Thu, 25 Aug 2022 04:47:13 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 0AD4A92009C; Thu, 25 Aug 2022 13:47:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 05F3692009B;
        Thu, 25 Aug 2022 12:47:08 +0100 (BST)
Date:   Thu, 25 Aug 2022 12:47:08 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] serial: dz: Replace DZ_XMIT_SIZE with
 UART_XMIT_SIZE
In-Reply-To: <20220825091918.8398-1-ilpo.jarvinen@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2208251219120.26998@angie.orcam.me.uk>
References: <20220825091918.8398-1-ilpo.jarvinen@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 25 Aug 2022, Ilpo Järvinen wrote:

> Use the normal UART_XMIT_SIZE directly.

 I gather this is to fix a potential inconsistency with the size of the 
buffer allocated by the serial core (though in reality this driver will 
only be used with 4KiB-page systems), right?  If so, then please state it 
in the change description.

 Also I'd rather:

#define DZ_WAKEUP_CHARS      UART_XMIT_SIZE

and there's no need to include <linux/serial_core.h> in dz.h as the driver 
itself already does that (and dz.h is an auxiliary private header).

 Thanks for your submission.

  Maciej
