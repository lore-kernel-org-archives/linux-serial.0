From: Ross Boylan <RossBoylan@stanfordalumni.org>
Subject: Re: Update on problems with UPS
Date: Thu, 27 Feb 2003 12:42:55 -0800
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030227204255.GF5806@wheat.boylan.org>
References: <20030221063220.GF5567@wheat.boylan.org> <20030223080137.GB374@lafn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20030223080137.GB374@lafn.org>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Ross Boylan <RossBoylan@stanfordalumni.org>

Thank you for all this useful information.  I'm not sure I followed
all of it, so I want to clarify a couple of points.

I talked about pnp reseting the modem or the serial port on the card.
You say it would only affect the port.  What I had in mind was that
pnp might reset the IRQ for one device, but not the other, so they
wouldn't be able to communicate.  Are you saying that's so?

I think what you mean is that only the serial port needs an IRQ, since
the modem talks to the serial port talks to the computer.  So
regardless of how I set pnp, the serial port and modem will be able to
communicate.  Correct?

Further, the reason I lose communication with the port/modem after
manually running pnp is that the serial driver does not know that the
port has moved.  If I manually change the IRQ with pnp, I need to
manually tell the driver with setserial.  Correct?

Thanks.

On Sun, Feb 23, 2003 at 12:01:37AM -0800, David Lawyer wrote:
> On Thu, Feb 20, 2003 at 10:32:20PM -0800, Ross Boylan wrote:
> > I wrote a few weeks ago about some problems using an APC UPS with the
> > serial port.
> > 
> > I've made some progress, but things are still not quite working right.
> > 
> > Originally, I got "LSR safety check engaged" on ttyS1 where the APC
> > was connected.  This went away when I disabled COM1 (aka ttyS0) in
> > BIOS, since I no longer use it.  However, I am still sharing an IRQ
> > between ttyS2 (from my ISA modem card) and the parallel printer.
> > 
> > It's not clear the sharing is causing trouble--both seem to be working
> > OK.  Does anyone know if it's a problem?
> It may cause a problem if you are printing while using the modem.
> > 
> > At any rate, it is puzzling to me that I can't control the IRQ for the
> > modem.  Only COM1/2 are configurable from BIOS.  I can also control
> > the parallel port from the BIOS, and I though putting it to IRQ5 would
> > force COM3 elsewhere.  It doesn't seem to.
> Some devices can only be set to a limited number of IRQs and all
> possibilities may cause a conflict so it may use one of these conflicts:
> IRQ5
> 
> > I can reprogram the modem through isapnp, but unless I put it to the
> > IRQ 5 that ttyS2 gets on startup, it doesn't work.  (Some people
> > suggested the card might be set through jumpers, but it's not).  I've
> > also tried restarting after reprogramming the modem, in hopes the new
> > IRQ would stick, but it doesn't.
> 
> That's right.  PnP resources such as IRQs set in a device disappear when
> powered down.  You've got to run setserial to tell the serial driver
> what you set with isapnp.  Another way to get it to work is to setserial
> to IRQ0 which will use the serial port using inefficient polling, but it
> still should work.
> 
> > Can anyone clarify what is going on with COM3?  I thought the modem
> > serial port was actually part of the card, and that reseting the card
> > through pnp would change the modem and the serial port.  The behavior
> > I'm seeing looks more like the serial port and the modem are distinct
> > devices
> Yes but the modem is not listed in /dev so it's not a device in that
> sense.
> 
> >, and pnp only affects the modem. 
> 
> It only affects the serial port on the modem card.
> 
> > (My other theory is that pnp affects both,
> It only affects the serial port.
> > but the serial driver doesn't know what's going on if I move the
> > location after startup.  
> Correct
> > This would also explain why the modem doesn't work after I move the
> > IRQ,
> Correct
> > but I thought I understood someone on this list saying the serial
> > driver could cope with such moves.) 
> 
> Well, it can if it uses its own isapnp to set the IRQ but you explicitly
> ran isapnp.
> > 
> [snip about UPS as I know almost nothing about them]
> 			David Lawyer
> -
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
