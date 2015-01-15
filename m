From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5] ARC: Dynamically determine BASE_BAUD from DeviceTree
Date: Wed, 14 Jan 2015 21:05:52 -0800
Message-ID: <20150115050552.GA24813@kroah.com>
References: <CAL_JsqLzzLajoQAT3nYd5zi4=+zchXfVVPnYNriAZZi4tpa6yA@mail.gmail.com>
 <1420889152-29361-1-git-send-email-vgupta@synopsys.com>
 <54B73FC0.4060506@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54B73FC0.4060506@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: robh@kernel.org, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-serial@vger.kernel.org

On Thu, Jan 15, 2015 at 09:49:12AM +0530, Vineet Gupta wrote:
> Hi Greg,
> 
> On Saturday 10 January 2015 04:56 PM, Vineet Gupta wrote:
> > 8250 earlycon is broken on multi-platform ARC because the UART clk
> > value (BASE_BAUD) is fixed at build time.
> > 
> > Instead, determine the appropriate UART clk at runtime; parse the
> > devicetree early for platforms requiring alternate UART clk values
> > (currently only the TB10X platform).
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jslaby@suse.cz>
> > Cc: linux-serial@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
> > Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> > ---
> >  arch/arc/include/asm/serial.h | 23 +++++------------------
> >  arch/arc/kernel/devtree.c     | 24 ++++++++++++++++++++++++
> 
> This being all in arch code, do you want me to take this in via ARC tree ?

Sure, that's fine with me:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
