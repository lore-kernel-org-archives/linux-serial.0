Return-Path: <SRS0=zA/y=5F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085AEC4332D
	for <linux-serial@archiver.kernel.org>; Fri, 20 Mar 2020 05:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE9220739
	for <linux-serial@archiver.kernel.org>; Fri, 20 Mar 2020 05:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584681052;
	bh=bHqz/mmjyWz7y2CbYXKF3rlS2vNGxaJf7CYZ9FIl/Hc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wVmsZKYQoY5r8RAbGgCO4QUmrtXA3gZ1aalFaGhGOoMnay6XxNSgg4ntT3Mw9QHN4
	 n4l0eKcIGdOs3vCLzOAv6tOBwjJIF7qlcQ5uD+J6HSfT5M1rzp+QBz10ChwjW5BHhD
	 vQkhDIbFEXTXtrsmUH97UEDAtvobUZ8+1aglFr6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgCTFKw (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Mar 2020 01:10:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgCTFKw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Mar 2020 01:10:52 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05DE12072D;
        Fri, 20 Mar 2020 05:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584681051;
        bh=bHqz/mmjyWz7y2CbYXKF3rlS2vNGxaJf7CYZ9FIl/Hc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CS+AMu4Ldrf5EQrnN3qqOyzcwytupsd2xi8te7S9EclBM61mvUsK4Ty8Ax7mBMCL4
         JrRgTSfUZMEg0PH+nsGHFpcp9255sLia17GXV7e0lwLANmIZg5fIe0HcAz1VnEFoNM
         EZeQ0BASP2vftBfk6DI/UUBTAVFxJ3Wqo5/e0Rkg=
Date:   Thu, 19 Mar 2020 22:10:49 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jiri Slaby <jslaby@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Eric Dumazet <edumazet@google.com>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v2 1/2] vt: vt_ioctl: fix VT_DISALLOCATE freeing in-use
 virtual console
Message-ID: <20200320051049.GA1315@sol.localdomain>
References: <20200318222704.GC2334@sol.localdomain>
 <20200318223810.162440-1-ebiggers@kernel.org>
 <20200318223810.162440-2-ebiggers@kernel.org>
 <2f762aee-720b-9bec-620f-61129c724de6@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f762aee-720b-9bec-620f-61129c724de6@suse.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Mar 19, 2020 at 08:36:28AM +0100, Jiri Slaby wrote:
> On 18. 03. 20, 23:38, Eric Biggers wrote:
> > --- a/drivers/tty/vt/vt.c
> > +++ b/drivers/tty/vt/vt.c
> > @@ -1102,6 +1102,9 @@ int vc_allocate(unsigned int currcons)	/* return 0 on success */
> >  	tty_port_init(&vc->port);
> >  	INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
> >  
> > +	/* if this wasn't the case, we'd have to implement port->ops.destruct */
> > +	BUILD_BUG_ON(offsetof(struct vc_data, port) != 0);
> > +
> 
> This is 3 lines, implementing destruct would be like 4-5 :)? Please
> implement destruct instead.
> 
> Otherwise looks good.
> 

Actually implementing destruct would be 12 lines, see below.  Remember there is
no tty_port_operations defined yet so we'd have to define it just for destruct.

Do you still prefer it?

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index ec34f1f5f3bb5..309a39197be0a 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1075,6 +1075,17 @@ static void visual_deinit(struct vc_data *vc)
 	module_put(vc->vc_sw->owner);
 }
 
+static void vc_port_destruct(struct tty_port *port)
+{
+	struct vc_data *vc = container_of(port, struct vc_data, port);
+
+	kfree(vc);
+}
+
+static const struct tty_port_operations vc_port_ops = {
+	.destruct = vc_port_destruct,
+};
+
 int vc_allocate(unsigned int currcons)	/* return 0 on success */
 {
 	struct vt_notifier_param param;
@@ -1100,11 +1111,9 @@ int vc_allocate(unsigned int currcons)	/* return 0 on success */
 
 	vc_cons[currcons].d = vc;
 	tty_port_init(&vc->port);
+	vc->port.ops = &vc_port_ops;
 	INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
 
-	/* if this wasn't the case, we'd have to implement port->ops.destruct */
-	BUILD_BUG_ON(offsetof(struct vc_data, port) != 0);
-
 	visual_init(vc, currcons, 1);
 
 	if (!*vc->vc_uni_pagedir_loc)
