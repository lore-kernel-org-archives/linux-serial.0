Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E72C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 18 Jul 2022 02:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbiGRCt3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 17 Jul 2022 22:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiGRCt2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 17 Jul 2022 22:49:28 -0400
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC99F11C36;
        Sun, 17 Jul 2022 19:49:24 -0700 (PDT)
Received: from marvin.atrad.com.au (marvin.atrad.com.au [192.168.0.2])
        by server.atrad.com.au (8.17.1/8.17.1) with ESMTPS id 26I2n2NC006650
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 18 Jul 2022 12:19:04 +0930
Date:   Mon, 18 Jul 2022 12:19:02 +0930
From:   Jonathan Woithe <jwoithe@just42.net>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [Regression] CH341 USB-serial converter passes data in 32 byte
 chunks
Message-ID: <YtTKHhdfq5cM0G4G@marvin.atrad.com.au>
References: <Ys1iPTfiZRWj2gXs@marvin.atrad.com.au>
 <Ys1sfRyL6El7go94@kroah.com>
 <Ys2nEmkvz2dfAKkU@hovoldconsulting.com>
 <Ys4QOgNF0pJDwRCJ@marvin.atrad.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys4QOgNF0pJDwRCJ@marvin.atrad.com.au>
X-MIMEDefang-action: accept
X-Scanned-By: MIMEDefang 2.86 on 192.168.0.1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jul 13, 2022 at 09:52:20AM +0930, Jonathan Woithe wrote:
> On Tue, Jul 12, 2022 at 06:53:38PM +0200, Johan Hovold wrote:
> > On Tue, Jul 12, 2022 at 02:43:41PM +0200, Greg Kroah-Hartman wrote:
> > > On Tue, Jul 12, 2022 at 09:29:57PM +0930, Jonathan Woithe wrote:
> > > > It would be great if this regression could be addressed.  At present I must
> > > > boot a pre-4.10 kernel whenever I need to use the programming dongle with
> > > > this converter.
> > > > 
> > > > Please let me know if there is anything I can do to help resolve the
> > > > problem.
> > > 
> > > If you revert this commit on top of the latest kernel release, does it
> > > solve the problem for you?
> > 
> > Simply reverting the commit blamed by the bisection should only makes
> > things worse, at least for some device types.
> > 
> > Perhaps we need to set that bit 7 based on the type, even if the bit
> > meaning having been inverted seems a bit far-fetched.
> > 
> > Jonathan, could you try simply commenting out the
> > 	
> > 	val |= BIT(7);
> > 
> > statement in ch341_set_baudrate_lcr()?
> 
> Commenting out the above line brought some improvement.  In minicom with a
> loopback connector in place, the first byte sent does not get echoed
> back at all.  However, all other bytes are echoed as soon as they are sent.
> 
> The kernel used for the above test was 672c0c5 (5.18-rc5), which is the most
> recent I can conveniently get onto the test machine at present.  I tested
> the unmodified kernel before commenting out the line and confirmed that it
> exhibited the full fault condition (bytes come back in blocks of 32).
> 
> > Also, what chip version do you have (see debug statement in
> > ch341_configure())?
> 
> Chip revision is 0x27.

Is there anything further I can do or provide to help identify a solution to
the regression?

Regards
  jonathan
