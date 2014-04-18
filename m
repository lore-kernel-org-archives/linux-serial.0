From: Greg KH <greg@kroah.com>
Subject: Re: How can I help?
Date: Fri, 18 Apr 2014 15:09:03 -0700
Message-ID: <20140418220903.GA22429@kroah.com>
References: <8A1E86F6-47F2-44A7-A8DB-8A643FE9796B@usgs.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:45829 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753935AbaDRWI4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Apr 2014 18:08:56 -0400
Content-Disposition: inline
In-Reply-To: <8A1E86F6-47F2-44A7-A8DB-8A643FE9796B@usgs.gov>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Larry Baker <baker@usgs.gov>
Cc: linux-serial@vger.kernel.org

On Fri, Apr 18, 2014 at 02:53:35PM -0700, Larry Baker wrote:
> Greg and Johan (via linux-serial@vger.kernel.org),
> 
> I am hoping you will have some good advice for me, and maybe I can help you.
> 
> I am migrating a serial data acquisition app from a PC platform to a lower cost/lower power ARM SoC platform.  The data come from the instrument over an RS-232 link that requires RTS/CTS handshaking.  It also uses a packet-based handshaking protocol in software.  Serial ports with hardware handshaking have been difficult to find on the SoC platforms I'm experimenting with, so I bought a USB-to-Serial adapter.  The one I bought is identified as an FTDI FT232RL.  It sort of works.  What happens is, after about 8 or 9 hours, the RX to the TTY port times out.  Sometimes it happens in only an hour, other times it takes about 14 hours.  After about 10 seconds, it seems to recover.  Too late, though, for the application; it has already started its abort sequence by then.
> 
> On the ARM SoC platform (CompuLab Utilite, Linux utilite
> 3.0.35-cm-fx6-5.5-rtscts-00002-g39389d3 #102 SMP Tue Apr 1 18:52:11
> IDT 2014 armv7l armv7l armv7l GNU/Linux), the ftdi_sio driver is
> v1.6.0. To eliminate the possibility it was a Linux ARM bug, I ran the
> same setup on an AtomPC.  I got the same result.  The AtomPC runs
> CentOS 6.5 (CompuLab fit-PC2i, Linux fit-pc2i.wr.usgs.gov
> 2.6.32-431.5.1.el6.i686 #1 SMP Tue Feb 11 21:56:33 UTC 2014 i686 i686
> i386 GNU/Linux), which has ftdi_sio driver v1.5.0.  I was blaming the
> instrument, until I hooked it up to the COM1 port on the AtomPC and
> everything ran fine.  (The full software handshaking protocol handling
> in my app is new; the other mode of operation is the device
> continuously streams its data.  This last test confirmed that my
> software handshaking was not at fault.)

The driver "version" number means nothing when it is within the kernel
tree itself.  Just go by the kernel version number instead.

All of the above listed kernels are very old, please try something
"modern", like the 3.14 kernel release, as there is nothing we can do
about these obsolete kernel versions, other than point you at the
company that is forcing you to use them to get support from.

> I have seen people complain about problems using FTDI chips and
> questions about ARM compatibility.  I think those were either pilot
> error or have been fixed by now.  (Though, I was surprised by a very
> recent post and a patch as a result to add parity support to one of
> the non-FTDI drivers.  I would have taken parity support for granted
> -- it seems pretty fundamental to serial data comm.)  The FTDI-based
> adapters seem to be the ones that most people like.  I just ordered a
> couple adapters with Prolific chips to try.

All of the usb-serial drivers should work on any platform that Linux
works on, there should not be any issues.  If there are, please let us
know.

And yes, some drivers aren't as "feature rich" as others are, that's
just the way it goes.  Parity settings were never used in the majority
of the places where the device you are referring to was used in
(embedded systems talking to specific hardware devices.)  So it was
never added, that doesn't mean the driver doesn't work well at all.

> If you would kindly point me to the correct web page or e-mail address
> to participate in debugging the FTDI or other USB-to-Serial drivers, I
> will help a much as I can.  I am suspicious, for example, that the CTS
> grant is getting lost.  When data starts to flow again after the
> timeout (there are shutdown commands being sent to the instrument), I
> see correctly formed packets (the ones that timed out earlier -- they
> were already in the device transmit queue); no runts, no checksum
> errors.  That fits with the scenario that CTS is not always being seen
> by the requester.  I don't have hardware like a logic analyzer; just
> an RS-232 break-out box.  I plan to try wiring RTS to CTS on the
> sender side, disable RTS/CTS flow control on the app side (I don't
> know how much the device driver vs. the chip is involved in the
> RTS/CTS handshaking; I want to disable any RTS/CTS state transitions
> all the way out to the chip, if the driver will do that), and see if
> the RX timeouts go away.  If so, that is a valuable data point and
> gives me a place to start probing in the driver (assuming it is not
> the chip itself that is the problem).

The linux-usb@vger.kernel.org place is usually the best for Linux USB
serial driver issues, unless it is serial/tty core related, and then
linux-serial like you used here should be fine.

thanks,

greg k-h
