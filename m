Return-Path: <SRS0=2gYx=ZZ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A15C432C0
	for <linux-serial@archiver.kernel.org>; Tue,  3 Dec 2019 15:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1432080A
	for <linux-serial@archiver.kernel.org>; Tue,  3 Dec 2019 15:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575386855;
	bh=M12IvIO4VV2YmcUBAdR7ScT9lvdtLVwKEAsicmX9ZRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eciyyLu0rCsc2JTN65tPkZevslULVfgXiljzdBvC7WlPKT5uTNFDpH8Wb7jyjnS2y
	 f6neY+/rOVdWW3tF5UCs3B8Hffk1T1pAK1LqKNW/LEO+P21qWs0xQ6erM2C/rF1Sgs
	 IKooAOvNUpP4jTI2YDdHJ4bEHHDV6FAwDlcidoss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfLCP1e (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 3 Dec 2019 10:27:34 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39816 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbfLCP1e (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 Dec 2019 10:27:34 -0500
Received: by mail-lj1-f194.google.com with SMTP id e10so4295738ljj.6
        for <linux-serial@vger.kernel.org>; Tue, 03 Dec 2019 07:27:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7aZ/WPFP8IDZCDK+LQRVdRV/ok4L4matBfIvMXz8l7c=;
        b=DpqbKSraafNBGh+ipynSyc6HYWzDsVj/JJ+FGs7kGyt/4lI7osdlrvQKB0ETvwIIB+
         4ltVA04BhVyCuSWumyuDewaGJLbJ47bbBeNR9y6lKFTVuYNh1jfUlTewB+wlqcmVRU1z
         7DnuSP2h+9c1hP78hcJPLobf/UdPvfOhu/XRFgu7K4i4na/Bf3QIQMOU2/HJxxkTfU+D
         XMlgCuj8eycsT88aMwlcHUVlKqNf+GZLd8xvQbvIX2kX9qNkA6Fw82ovCg90vJiWSWZo
         O6MyULU8ONkRAHBYTUXsQ0s7ZRxjsmfpcWj+ZwEDXOaz4sJrxO+UWPgwvTq3XRnARSVE
         mE+w==
X-Gm-Message-State: APjAAAWIHz7OJBGkHky1xZRD257bULxO7I7mo7PFOaHrbcSJbOrb7gYR
        rYYXG5je58WnVjyuQ9RHIk8=
X-Google-Smtp-Source: APXvYqyRZKc6+QATampjswt+VUbUyFGcTpF5GbiV6YDPlJN2+PwCJun1TfGErJcBai+1J38G9m0rPw==
X-Received: by 2002:a2e:8518:: with SMTP id j24mr2648183lji.13.1575386852681;
        Tue, 03 Dec 2019 07:27:32 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id z5sm1493910lji.32.2019.12.03.07.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 07:27:31 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1icA5S-0000y5-VL; Tue, 03 Dec 2019 16:27:39 +0100
Date:   Tue, 3 Dec 2019 16:27:38 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Johan Hovold <johan@kernel.org>, shubhrajyoti.datta@gmail.com,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jacmet@sunsite.dk, git@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: Re: [PATCHv5] serial-uartlite: Remove ULITE_NR_PORTS macro
Message-ID: <20191203152738.GF10631@localhost>
References: <1573646408-392094-1-git-send-email-shubhrajyoti.datta@gmail.com>
 <20191113153846.GW11035@localhost>
 <fbfa424b-6730-fae9-14bf-bf666e93ad28@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbfa424b-6730-fae9-14bf-bf666e93ad28@xilinx.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Nov 15, 2019 at 09:21:03AM +0100, Michal Simek wrote:
> Hi Johan,
> 
> On 13. 11. 19 16:38, Johan Hovold wrote:
> > On Wed, Nov 13, 2019 at 12:00:08PM +0000, shubhrajyoti.datta@gmail.com wrote:
> >> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> >>
> >> This patch is removing ULITE_NR_PORTS macro which limits number of
> >> ports which can be used. Every instance is registering own struct
> >> uart_driver with minor number which corresponds to alias ID (or 0 now).
> >> and with 1 uart port. The same alias ID is saved to
> >> tty_driver->name_base which is key field for creating ttyULX name.
> >>
> >> Because name_base and minor number are setup already there is no need to
> >> setup any port->line number because 0 is the right value.
> >>
> >> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> >> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> >> ---
> >> v4: patch addition
> >> v5: Merge the patch so that all the patches compile
> > 
> > Greg, 
> > 
> > Please do not merge this. This is a hack which really needs to be
> > reconsidered as I've pointed before
> > 
> > 	 https://lkml.kernel.org/r/20190523091839.GC568@localhost
> 
> I think it is quite a good time to start to talk about it.
> Over the time I am aware about only one issue related to one way how to
> handle console which came recently. I was looking at it 2 weeks before
> ELCE but I need to get back on this.
> Anyway I am ready for discussion about it.
> What was said so far is that we shouldn't add Kconfig option for number
> of uarts. We could maybe hardcode any big number in the driver as is
> done for pl011 but still it is limitation and wasting of space for
> allocation structures which none will use.
> Then I have done this concept and it was merged where struct uart_driver
> is allocated for every instance separately and I really tried to get
> feedback on this as we discussed some time ago.
> 
> Anyway we are where we are and if this needs to be fixed then please
> tell me how you think that this should be solved.

As I told you back in May, registering one uart driver per physical
port is precisely what should not be done. Just register a fixed number
of lines like every other tty driver. And if you're worried about
statically allocated memory, you need to address that in the tty layer
and/or serial core instead of hacking every single uart driver to
pieces.

Specifically, you could move the uart state allocation to port
registration so that all drivers would benefit from this.

This is already causing way more trouble than it's worth, and the big
number you mention above for pl011 is 14! In comparison, usb-serial
currently supports 512 ports just fine by allocating state at
registration.  

Greg, I reread some of the mails reachable through the above link and
was reminded that this hack also made it into xilinx_uartps. That would
need to be fixed/reverted as well.

Johan
