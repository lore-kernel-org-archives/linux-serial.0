From: rich+ml@lclogic.com
Subject: RE: [OT(ish] Duplicate Character between modems
Date: Mon, 5 Aug 2002 11:26:08 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0208050924060.17324-100000@deadrat.localdomain>
References: <HMEGLNIPFGJPACKIEKLFMEKLEPAA.neil@gemini-it.com>
Reply-To: rich+ml@lclogic.com
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <HMEGLNIPFGJPACKIEKLFMEKLEPAA.neil@gemini-it.com>
List-Id: linux-serial@vger.kernel.org
To: Neil Everton <neil@gemini-it.com>
Cc: "Linux-Serial@Vger. Kernel. Org" <linux-serial@vger.kernel.org>

Hi, ec (really called arq, I suppose) works like this: you hand data to
the modem, it packetizes it with a crc and sends it to the other end, that
end checks the packet sequence, crc, etc.

If good, it sends an acknowledge and spews the data on the serial port. If
bad, it sends a nack, or waits for a retransmission from the originator or
whatever is specific to the particular protocol. If the sender can't get
an acknowledge after some number of attempts, it hangs up.

End effect is that there are only two outcomes for each character sent:  
successfully delivery or loss of carrier (this is why your average ppp
stack never shows crc errors, the errors never make it that far).

Without ec there is no 'meta-connection'. The data is just squirted onto
the wire, whatever the receiver gets is passed to the host.

What you are describing does sound to me like typical impulse noise on a
v.22 connection, due to the phone line going past the refrigerator with
the dirty compressor motor contacts. Or whatever.

It's very interesting that this noise exposed an old bug in a device
driver, and this really makes me wonder if the old modems really DO use
some kind of ec after all.

(MNP2 and MNP3 are encapsulated in the V.42 protocol, but there were lots
of other magic proprietary protocols before V.42 came along. If you can
find documentation, you might be able to reproduce it at the level of the
linux serial driver.)

You could test if this is the case by having one pace linnet call the
other and see if you get garbage on the terminal by picking up the
extension phone. 

Other ideas:

Avoid internal modems, since PC power supply raises the noise floor.

Maybe you can set the modem for UK operation to ensure proper telco
impendance.

Set it to support only v.22, i.e. 1200 baud, not only will it connect
faster but may have better noise immunity than 'degraded' v.34 (or maybe
not...)

Should turn off v.42 as well, so the modem won't waste 5 seconds trying to
set it up (and the caller won't see the 'garbage' bytes at the head of the
call).

3com tier 1 support is useless, don't waste your time :)

== Rich

On Mon, 5 Aug 2002, Neil Everton wrote:

> Date: Mon, 5 Aug 2002 10:05:19 +0100
> From: Neil Everton <neil@gemini-it.com>
> To: rich+ml@lclogic.com
> Cc: "Linux-Serial@Vger. Kernel. Org" <linux-serial@vger.kernel.org>
> Subject: RE: [OT(ish] Duplicate Character between modems
> 
> Hi,
> 	Thanks for all the replies. Error correction was originally disabled due to
> issues with new hardware connecting to the existing system, and the fact
> that a lot of the old hardware out there, will not connect to the Couriers
> unless EC is disabled (it's true !!).
> 
> 	I appreciate the fact that EC is there to 'stabilise' a connection and to
> filter out bad noise, but we have a check digit routine for that (as indeed
> do the modems). The problem I have though, it that if it is echo, I would
> expect it on most characters not just the odd one. If it was line noise
> (which I expect is probably closer to the truth) then the modems must STILL
> be providing some sort of correction for them to resend the character again.
> If this is the case then I cannot totally disable error correction, which in
> turn means I cannot get rid of this problem.
> 
> 	I've emailed 3com about this, but got a simple response of turn off echo in
> hyperterminal, which considering I never mentioned any terminal emulation
> software (they got pretty much the same email I sent here) I'm intrigued at
> their response.
> 
> 	I'm going to try later on using the modem in it's default "AT&F1" state and
> see what happens. But I know that this will cause problems further down the
> line with other modems connecting in the field.
> 
> Many thanks for the responses
> Regards
> Neil Everton
> 
> -----Original Message-----
> From: rich+ml@lclogic.com [mailto:rich+ml@lclogic.com]
> Sent: 03 August 2002 22:31
> To: Neil Everton
> Cc: Linux-Serial@Vger. Kernel. Org
> Subject: Re: [OT(ish] Duplicate Character between modems
> 
> 
> Since you don't have an issue when error-correction is on, then I'd say
> that pretty much rules out any software-based cause of your extra
> character.
> 
> What the ec hides is line noise, why do you suppose it was invented to
> begin with? Noise on a serial device turns into bogus serial characters,
> and you end up with something like thi~@#&!~!#ER$!@#as4 NO CARRIER
> 
> On Fri, 2 Aug 2002, Neil Everton wrote:
> 
> > Date: Fri, 2 Aug 2002 21:41:09 +0100
> > From: Neil Everton <neil@gemini-it.com>
> > To: "Linux-Serial@Vger. Kernel. Org" <linux-serial@vger.kernel.org>
> > Subject: [OT(ish] Duplicate Character between modems
> >
> > Hi,
> > 	My apologies for sending this here, but I reckon you guys are probably
> the
> > best bet I have of finding a solution to my problem (esp. as it indirectly
> > relates to serial programming)
> >
> > 	I'm currently porting an application from DOS to Linux (RH7.2 with
> Cyclades
> > Cyclom-Y (hi henrique!!)).
> >
> > 	My issue is this, if I send down the modem ;
> > "ABCDEFGHI"
> > 	the receiving end (very infrequently) receives
> > "AABCDEFGHI"
> > 	This is caught by the check digit routine and the line is NAK'd ready for
> a
> > re-transmit. It will usually work the second or third time. This has found
> a
> > bug in the 3rd party transmitting software, but they're taking the
> attitude
> > of the existing system works, so you fix your end !!! (the bug if your
> > interested is after sending a NAK they drop the connection, instead of
> > waiting for 5 retries)
> >
> > 	The existing DOS system uses old modems such as Pace Linnet (1200 baud)
> and
> > an even older modem called a Compact which you cannot do anything with, no
> > init string, no RING or CONNECT message, just straight into getting the
> > data.
> >
> > 	The new system is using 3Com Courier V.everything modems. I can replicate
> > the problem on other modems as well, so it's not a courier issue. We have
> to
> > disable any error correction, compression (except MNP), and set the flow
> > control to hardware. As far as I can see I've disable pretty much
> > everything, but I still occasionally get these duplicated characters. It
> > used to be quite bad and then I realised that the Courier set the flow
> > control on both the transmit and receive stacks seperately. Once I'd set
> the
> > flow control to hardware for both stacks it made the issue a lot better,
> but
> > I still get it.
> >
> > 	I can normally get this issue (at home) at least every 3rd order, luckily
> > it's not so bad at the clients end. My home setup incidentally doesn't
> have
> > a cyclades card, but I've sniffed at the modem connection and I definatly
> > don't send the duplicate characters to the modem, they're adding in
> between
> > the modems.
> >
> > 	The modem I'm sending on is a generic 56k modem, but we're getting the
> > issue on 300 baud modems, with the Courier set to only connect at 300. The
> > connect message is simply 'CONNECT' so should be giving no error
> correction,
> > compression, etc. it should be a standard V21 connection. There might be
> an
> > issue with fast modems connecting at V21 I'm not aware of, but I'm at a
> > loss. My client is also concerned with the issue (understandably) and are
> > also in the 'it works on the existing system' mentality.
> >
> > Any help/pointers/advice gratefully received
> > Regards
> > Neil Everton
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 

