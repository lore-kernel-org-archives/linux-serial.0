From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Controlling the serial port at kernel level
Date: Thu, 2 May 2002 21:09:26 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20020502210926.H24630@flint.arm.linux.org.uk>
References: <11E89240C407D311958800A0C9ACF7D13A77CF@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <11E89240C407D311958800A0C9ACF7D13A77CF@EXCHANGE>; from EdV@macrolink.com on Thu, May 02, 2002 at 11:31:45AM -0700
List-Id: linux-serial@vger.kernel.org
To: Ed Vance <EdV@macrolink.com>
Cc: antonelloderosa@inwind.it, "'root@chaos.analogic.com'" <root@chaos.analogic.com>, 'linux-serial' <linux-serial@vger.kernel.org>, 'linux-kernel' <linux-kernel@vger.kernel.org>

On Thu, May 02, 2002 at 11:31:45AM -0700, Ed Vance wrote:
> That will get the UART initialized and held in an 
> operational state while you program the MCR register from inside 
> the kernel to change the modem signal states.

You don't need the UART initialised to wiggle the RTS and DTR signals -
as far as standard ports go (rather than the fancy ones that do flow
control), they're just simple IO lines.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

