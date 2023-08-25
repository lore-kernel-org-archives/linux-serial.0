Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7E9C88CB2
	for <linux-serial@archiver.kernel.org>; Fri, 25 Aug 2023 01:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjHYByB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 24 Aug 2023 21:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239227AbjHYBxd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 24 Aug 2023 21:53:33 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id AB0711BD4
        for <linux-serial@vger.kernel.org>; Thu, 24 Aug 2023 18:53:29 -0700 (PDT)
Received: (qmail 244637 invoked by uid 1000); 24 Aug 2023 21:53:28 -0400
Date:   Thu, 24 Aug 2023 21:53:28 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Simon Arlott <simon@octiron.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] USB: cdc-acm: expose serial close_delay and closing_wait
 in sysfs
Message-ID: <d1658254-b65b-4e2e-8c22-45008374d6eb@rowland.harvard.edu>
References: <ea1a13ad-a1e0-540a-e97a-4c44f6d2d33b@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa>
 <2023082403-masculine-scuttle-f0ad@gregkh>
 <d313a1a9-833e-981e-b9d7-920989458d37@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa>
 <f1b001d8-4d6c-8c9d-a90c-7d97294b66b4@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1b001d8-4d6c-8c9d-a90c-7d97294b66b4@suse.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Aug 25, 2023 at 01:46:15AM +0200, Oliver Neukum wrote:
> 
> 
> On 24.08.23 20:02, Simon Arlott wrote:
> > The ioctl can't be used without opening and closing the tty, which has
> > side effects. On open() it'll raise DTR/RTS and activate it. For cdc-acm
> > that will indicate to the device that the serial port has been opened
> > which will be visible to the software running on the USB device. On
> > close() it'll be delayed by the close_delay if any process is currently
> > doing a blocking open() and there's no carrier, then the closing_wait
> > time if there's been any incomplete transmitted data (by any process).
> 
> And that is an issue of the generic serial layer.

Is it feasible to add a sysfs attribute for ttys or the serial layer to 
control the side effect of opening (avoid raising DTR/RTS)?  If that 
could be done, a program could use the existing ioctl to set close_delay 
and closing_wait to 0 with no penalties.

This would be racy, but for the purposes of udev that shouldn't matter 
much.

Alan Stern
