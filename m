From: Harry Wilkinson <harryw@nipltd.com>
Subject: Re: C code - Dealing with a serial cable getting unplugged and pl ugged back in.
Date: Thu, 20 Jun 2002 09:50:17 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <E17Kxk8-0002ab-00@mail.nipltd.com>
References: <11E89240C407D311958800A0C9ACF7D13A788B@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <11E89240C407D311958800A0C9ACF7D13A788B@EXCHANGE>
List-Id: linux-serial@vger.kernel.org
To: Ed Vance <EdV@macrolink.com>
Cc: linux-serial@vger.kernel.org, 'Russell King' <rmk@arm.linux.org.uk>, 'Theodore Tso' <tytso@mit.edu>

Thanks a lot, Ed :)  I will try and find a better cable somewhere.

Harry



On Wednesday 19 June 2002 5:28 pm, Ed Vance wrote:
> Hi Harry,
>
> This is a good place for this sort of question.
>
> On Wed, June 19, 2002 at 7:02 AM, Harry Wilkinson wrote:
> > Currently, when I unplug the serial port, if the app is trying
> > to send something it will just send the data into a black hole
> > and the data gets lost.  I was sort of hoping it would get
> > buffered somewhere along the line until the connection was back
> > but I guess that isn't happening (I'm new to this serial port
> > stuff).
> >
> > I'm using software flow control at the moment since that's all
> > the cable I've got at the moment will do.  If necessary I can
> > get a better cable and use hardware flow control.
> >
> > So, what I'd like to know is, how can I stop my data flowing
> > out into the abyss?
>
> If you don't need a separate indication of the disconnected cable,
> then hardware flow control should be enough to stop the transmit
> data when the cable is unplugged. Most RS-232 CTS inputs have
> switching thresholds selected to read open as "low". As long as
> yours works this way, the transmitter would stop when CTS went low.
>
> The minimum RS-232 cable would be:
>
> TXD ------------------> RXD
> RXD <------------------ TXD
> RTS ------------------> CTS
> CTS <------------------ RTS
> GND ------------------- GND (signal reference)
> SGND ----------------- SGND (cable shield)
>
> Both ends would have to handle partial messages gracefully, since
> the cable could possibly be disconnected during a message.
>
> > I can see two options at the moment, but I'm not sure how
> > feasible either is, at least in a POSIX-compatible way:
> >
> > A) Set some settings on the serial port that tell it to wait
> > until the receiver is ready before it sends the data.  This
> > is good because I don't have to change anything other than
> > port settings when I call open() :)
>
> If termios bit CLOCAL is off, the port will wait for DCD to be
> asserted before completing the open. This would require cross
> connections between DTR and DCD signals, and it would not
> replace the hardware flow control. Sounds like it's not needed.
> Also, some DCD (and DSR) inputs detect open as "high" instead
> of "low", or worse, they oscillate when open.
>
> > B) Before I write data, make sure I wait until the connection
> > is okay.  I don't know how to tell whether the connection is
> > okay, however.
>
> If you don't need a message to come out saying the port is not
> connected, hardware flow control should be enough.
>
> Best regards,
> Ed
>
> ----------------------------------------------------------------
> Ed Vance              edv@macrolink.com
> Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
> ----------------------------------------------------------------
