From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3] serial/8250/8250_early: Prevent rounding error in
 uartclk
Date: Fri, 5 Oct 2012 09:20:55 -0700
Message-ID: <20121005162055.GA24092@kroah.com>
References: <1349267263-21683-1-git-send-email-abrodkin@synopsys.com>
 <20121003133740.69c9dbce@bob.linux.org.uk>
 <506C3532.4020400@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:41706 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756662Ab2JEQVD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 5 Oct 2012 12:21:03 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1939114pad.19
        for <linux-serial@vger.kernel.org>; Fri, 05 Oct 2012 09:21:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <506C3532.4020400@synopsys.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Vineet.Gupta1@synopsys.com

On Wed, Oct 03, 2012 at 04:53:06PM +0400, Alexey Brodkin wrote:
> On 03.10.2012 16:37, Alan Cox wrote:
> >>So the bug had been latent and it only showed up with such low cock
> >>rates.
> >
> >clock ?
> >
> >Perhaps Greg can tweak the description as it goes in - otherwise all
> >fine with me
> >
> Sorry for this.
> Essentially I meant "clock".
> May do another respin if needed.

Don't worry, I can edit it :)

greg k-h
