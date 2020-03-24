Return-Path: <SRS0=BK0i=5J=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E125C4332B
	for <linux-serial@archiver.kernel.org>; Tue, 24 Mar 2020 09:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA35E208CA
	for <linux-serial@archiver.kernel.org>; Tue, 24 Mar 2020 09:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585042136;
	bh=jtNyRTRgsJmBEgvEJYDkKJ9vlP35PuAgLyeZsE6lJCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T2jwkUBGIkMB/bdqfGTGL2MVJ/zON5jy4+fXvCNbY7DHmcm1WYMwa4Md+6hdIGZnc
	 +pDNxfj4JuCQLWhupYO6E9HGQ6+snem3IzoOtSJH8SaVKazIS9jGCGiN8twkYX3s8T
	 Qv0Kjl1JGhB/7KDMWREMcCYcvoXBdXeaKlP7fIeg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgCXJ2z (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:28:55 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36042 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgCXJ2z (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 Mar 2020 05:28:55 -0400
Received: by mail-lf1-f66.google.com with SMTP id s1so12582231lfd.3
        for <linux-serial@vger.kernel.org>; Tue, 24 Mar 2020 02:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H9cgQBHwnun3QWnbmEHZGhQFhB4Fz93itqncOMUGIqM=;
        b=U1k5NbSsZGDkdbSTx3l5rcwd3pGaRJ5wSFgNu9S5DZmOXhwcUNFmjUXTm6LoSxHzOP
         dGBJ5OAuyqMHj2gch4Jp9+ho75w8lWUm+Rf3+qTbush39i5b92DeFiYNvaXY3zqywiIj
         nuBWSvoMzs5G8tE2H8DFALfaYyUE8f6SjQg8k1iZ7KA6ab7muDrH5JMkm/voew8iWFD/
         gYyBUHKp6Q2THpsgsOCCVStXUKn4Iru3M5oF9LHhUm6DvEHyWKpHabkgr4AkopQEO4i9
         0LxqGfoljUlNNzlaFVQmWkDJzYCGgsB4R5R+7xpIp/Fa+0uOBC1xpqKhkoMPX5isHfi3
         +pWQ==
X-Gm-Message-State: ANhLgQ3WKssirmljPPDODxpXADSUmsEX9z3vNmti11bKbQRHQenNqpUp
        CpaDQmk2LU4WTHheGb20R1fz1NTl
X-Google-Smtp-Source: ADFU+vuh6pweXCcAzZUa1ZWFJJ++I4TEMPR6Xs0qg7puPp8xXHV1ZqJ2wCCO7zesdSRUGjwq25IfIw==
X-Received: by 2002:ac2:4578:: with SMTP id k24mr3085156lfm.180.1585042131534;
        Tue, 24 Mar 2020 02:28:51 -0700 (PDT)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id c4sm7840513lfm.37.2020.03.24.02.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 02:28:50 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1jGfrT-0003nX-KY; Tue, 24 Mar 2020 10:28:39 +0100
Date:   Tue, 24 Mar 2020 10:28:39 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Ryan Lovelett <ryan@lovelett.me>, linux-serial@vger.kernel.org
Subject: Re: FT232H user space GPIO device
Message-ID: <20200324092839.GC5810@localhost>
References: <6267385dcb44b73f3b5b38070da602bbdb56d545.camel@lovelett.me>
 <20200323065211.GD129571@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323065211.GD129571@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Mar 23, 2020 at 07:52:11AM +0100, Greg Kroah-Hartman wrote:
> On Sun, Mar 22, 2020 at 03:40:33PM -0400, Ryan Lovelett wrote:
> > I have been trying to find a way to get my Adafruit FT232H breakout
> > board [1] to appear as a user space GPIO device so I can use it with
> > libgpiod. As far as I can tell from reading table 3.5 from the
> > datasheet [2] ACBUS5, ACBUS6, ACBUS8 and ACBUS9 should all be usable
> > for this.
> > 
> > I found a patch that was submitted by Karoly Pados in 2018 [3] that
> > seemes to add support for that (though maybe only for a specific chip).
> > 
> > Through a little bit of ftrace and printk I realized that the switch
> > statement in ftdi_gpio_init was falling through to the default case for
> > the FT232H [4].
> 
> So it sounds like you have the wrong device type.  Can you make sure you
> use the latest kernel release (5.5) and if you have problems with this,
> email the linux-usb mailing list as the driver maintainers for that
> driver are there.

As Greg suggested you need to update your kernel as GPIO support for
FT232H went into 5.4.

Johan
