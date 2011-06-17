From: Greg KH <greg@kroah.com>
Subject: Re: [Resend with Signed-off-by]: Add new FT232H chip to
 drivers/usb/serial/ftdi_sio.c
Date: Fri, 17 Jun 2011 08:51:09 -0700
Message-ID: <20110617155109.GA15495@kroah.com>
References: <19963.29455.319574.581029@elektron.ikp.physik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:44981 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752772Ab1FQPzh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 17 Jun 2011 11:55:37 -0400
Content-Disposition: inline
In-Reply-To: <19963.29455.319574.581029@elektron.ikp.physik.tu-darmstadt.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
Cc: linux-serial@vger.kernel.org, linux-usb@vger.kernel.org

On Fri, Jun 17, 2011 at 05:30:23PM +0200, Uwe Bonnes wrote:
> Hello,
> 
> appended patch adds support for the new FTDI FT232H chip. This chip is a
> single channel version of the dual FT2232H/quad FT4232H, coming with it's
> own default PID 0x6014 (FT2232H uses the same PID 0x6010 like FT2232C,
> FT4232H has also it's own PID). 
> 
> The patch was checked on an UM232H module and a terminal program with TX/RX
> shorted to that typing in the terminal reproduced the characters. The patch
> was written against the running  2.6.37.6 kernel, but applies to git-head
> without errors.
> 
> Please review and let me know(CC) of any problems.
> 
> Signed-off-by: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>

Thanks, I'll queue this up next week.

greg k-h
