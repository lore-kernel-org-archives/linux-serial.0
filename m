From: "Michael Langford" <mlangford@tieronedesign.com>
Subject: RE: Call to tty_flip_buffer_push crashing system
Date: Wed, 3 Oct 2007 16:08:32 -0400
Message-ID: <3547473BFF99D74F875EEE3E38BCDDFF337176@tieroneserver.tier1design.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from www.tier1design.com ([68.16.98.218]:46852 "EHLO
	tieroneserver.tier1design.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752874AbXJCUKK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 3 Oct 2007 16:10:10 -0400
Content-class: urn:content-classes:message
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linux Serial Mailing List <linux-serial@vger.kernel.org>

I forgot to state we are on Kernel Version 2.6.20.11

     --Michael

-- 
Michael Langford
www.TierOneDesign.com
Phone: 404-386-0495
Fax: 770-234-6899


> -----Original Message-----
> From: linux-serial-owner@vger.kernel.org [mailto:linux-
> serial-owner@vger.kernel.org] On Behalf Of Michael
> Langford
> Sent: Wednesday, October 03, 2007 3:53 PM
> To: Linux Serial Mailing List
> Subject: Call to tty_flip_buffer_push crashing system
> 
> We're writing a custom driver for a 4 port usb-serial
> device we have
> made for a customer. We have issue with the recv of
> characters from the
> device. We have a snooper connected and see the data
> getting to linux.
> 
> When drivers/usb/serial/generic.c  calls
> tty_flip_buffer_push, in
> usb_serial_generic_read_bulk_callback, the system goes
> down hard. 100%
> frozen. I'm guessing I'm getting a kernel panic, but I
> can't even see
> that.
> 
> This behavior happens with data I make up or what actually
> came from the
> usb endpoint.
> 
> When I call this function (and tty_buffer_request_room and
> tty_insert_flip_string) in an ioctl command I've rigged
> up, all three
> functions work as expected, pushing the tty data to the
> awaiting program
> reading from the /dev/ttyUSB file.
> 
> Any pointers on what may be going on here?
> 
> We've verified that the tty is the same one from open. We
> do a small
> action in our port_open function on a separate endpoint on
> our device,
> then call the open function that's in generic.c.
> 
>             --Michael
> 
> PS: If this is the incorrect list, I'd like to apologize
> for the OT, and
> ask for a pointer to one you think may have more answers.
> 
> --
> Michael Langford
> www.TierOneDesign.com
> Phone: 404-386-0495
> Fax: 770-234-6899
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-
> info.html
