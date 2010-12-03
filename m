From: Eric Malkowski <eric@bvwireless.net>
Subject: SOLVED: Re: Sysbas 16C1052 PCI single chip UART
Date: Thu, 02 Dec 2010 21:51:30 -0500
Message-ID: <4CF85B32.50106@bvwireless.net>
References: <46bd4cff09751de9f1ed17e0f7b7acef5d89a6a0@outitgoes.com> <4CF83B20.1080504@bvwireless.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mmi.magnemotion.com ([66.237.178.195]:25752 "EHLO
	mmi.magnemotion.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932219Ab0LCCvd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 2 Dec 2010 21:51:33 -0500
In-Reply-To: <4CF83B20.1080504@bvwireless.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: tony@pridopia.co.uk, linux-serial@vger.kernel.org, Eric Malkowski <emalkowski@magnemotion.com>, Eric Malkowski <eric@bvwireless.net>

Hey Everyone-

I finally got this working!

It turns out Tony Pridopia's board is utilizing the TXEN0/1 and RXEN0/1 
pins on the sysbas 16C10502PCI UART to wake up and run the TI 65HVD33 
422/485 transceiver for transmit.
The UART register "ATR" or Auto toggle Control Register is described in 
the datasheet as follows "ATR controls the signals for controlling 
input/output signals when using Line Interface as RS422 or RS485, so 
eliminates additional glue logic outside."

I set the ATR register (which is part of the STARTECH enabled extra 
register sets on page 3 which is available when the LCR has a 0xBF and 
page select bit is 0) to do RXEN polarity 0 (the RXEN output pin of the 
UART would be off or logical 0) with RXEN control set to always output 
RXEN at the selected polarity regardless of whether the TxD signal is 
transmitting or not.  Then set TXEN polarity to 1 (the TXEN output pin 
of UART is on or logical 1) which gets the transceiver finally 
transmitting my data! -- and set TXEN control to always output TXEN at 
selected polarity of 1 regardless of whether TxD signal is transmitting 
or not.  Since my goal is RS-422 full duplex 4 wire, this lets the TI 
65HVD33 transceiver transmit and receive all the time as true RS-422.  
I'll confirm it's all correct by having it talk to known correct RS-422 
setup instead of the hardwired loopback between the two UART ports.

Tony -- I will put my changes together as a patch and send it to you and 
perhaps post it here too -- the changes are really very small to get 
this working on a 2.4 kernel and should likewise be easily forward 
ported to a 2.6 setup.

This way people don't have to build in the sysbas "complete extra copy" 
of the serial driver with mods that don't even work with your board and 
can use the normal kernel serial driver to enjoy the latest / best 
version (so if tty interface stuff is changed or made better in the 
future and other enhancements / maintenance to the serial drivers, 
people can stay current easier!).

Wow -- what a hack session, but worth it in the end!

Thanks to the serial mailing list -- if anything a good sounding board 
for me and if anyone finds this info useful, it's documented on the list.
Looking forward to cleaning everything up and additional testing tomorrow.

One last item -- if anyone is looking for a very simple and capable 
mini-pci board with 2 x RS422/485 UARTs with deep FIFOs that can indeed 
work with the standard linux serial driver (comes in as ST16654 and sets 
FIFOs to 64 by default which is fine for what I'm doing -- it goes up to 
256 bytes) here is a link to the board on Tony Pridopia's website:

http://www.pridopia.co.uk/1052mir2-485.html

Eric Malkowski wrote:
> Hi Tony / Linux-serial mailing list-
>
> I tested this on windows with the proper jumper settings per your PNG 
> graphic and it still works fine on windows.
> I spent all day today having the standard 2.4 linux kernel driver 
> detect this as ST16654 UARTS (it's register compatible) but I cannot 
> for the life of me get it to transmit anything out the pins like 
> windows does!
>
> Here's the outputs from my changes (2.4.29 kernel -- old but has 
> worked fine and we haven't migrated to 2.6 on all of our projects yet):
>
> Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT 
> SHARE_IRQ SERIAL_PCI enabled
> ttyS00 at 0x03f8 (irq = 4) is a 16550A
> ttyS01 at 0x02f8 (irq = 3) is a 16550A
> Setup PCI/PNP port: port 1400, irq 9, type 0, port_high: 0
> ttyS04 at port 0x1400 (irq = 9) is a ST16654
> Setup PCI/PNP port: port 1408, irq 9, type 0, port_high: 0
> ttyS05 at port 0x1408 (irq = 9) is a ST16654
>
> Upon opening a port:
>
> ST16C1050: Enable PCI IRQs
> ST16C1050 @ I/O 0x1400
> ST16C1050 Num Ports: 2, Dev Info Reg: 0x13
> ST16C1050 Interface Info Reg0: 0x18, IRQ Mask Req: 0x03
> ST16C1050 Intrrupt Poll Reg: 0xff
> ST16C1050: Enable PCI IRQs
> ST16C1050 @ I/O 0x1408
> ST16C1050 Num Ports: 2, Dev Info Reg: 0x13
> ST16C1050 Interface Info Reg0: 0x18, IRQ Mask Req: 0x03
> ST16C1050 Intrrupt Poll Reg: 0xff
>
> When application transmits data:
> serinfo:1.0 driver:5.05c revision:2001-07-08
> 0: uart:16550A port:3F8 irq:4 baud:115200 tx:12083 rx:206 
> RTS|CTS|DTR|DSR|CD
> 1: uart:16550A port:2F8 irq:3 tx:0 rx:0 CTS|DSR|CD
> 4: uart:ST16654 port:1400 irq:9 baud:9600 tx:126 rx:0 
> RTS|CTS|DTR|DSR|CD|RI
> 5: uart:ST16654 port:1408 irq:9 baud:9600 tx:126 rx:0 
> RTS|CTS|DTR|DSR|CD|RI
>
> No bytes on the scope, none received.  Same hardware setup works fine 
> on windows.
> Same application code works fine on a different board that has genuine 
> Oxford Semi 16C950/954 UARTs.
>
> I noticed in the 2.4 and 2.6 drivers from sysbas that they do a few 
> things with the Option I/O registers.
> In particular:
>
> Enable PCI IRQs by writing 0xFF to IMR (interrupt mask register in the 
> Option I/O regs that live at 0x1440 (32 bytes long)).  I do this on 
> initialization and it does make the card have IRQs happen on IRQ9 and 
> data gets written to the UART (show in /proc/tty/driver/serial).  
> Without this particular mod, I was not getting any IRQs, so I think a 
> timer they use for timing out was showing the tx count incrementing 
> very late and IRQ count of zero in /proc/interrupts.  So I know this 
> is for certain needed just to get IRQs with this -- I don't know why 
> they don't just rely on the standard IER register...
>
> In the IRQ handlers rs_interrupt (used when both ports are open) and 
> rs_interrupt_single (which is used when only 1 port is open), I have 
> it write a 0x00 to the IMR (Int mask reg) in the option registers at 
> 0x1440 at start of IRQ handler and write a 0xFF to the IMR at end of 
> IRQ handler.  I was thinking the chip needs this global IMR disabled 
> and re-enabled to "ack" the interrupt even though it's normally done 
> when reading the standard data register for instance to clear the data 
> received IRQ (or maybe it's the reading of the LSR that would actually 
> clear the interrupt, I'm not sure).  Either way, I'm surprised this 
> chip seems to require disabling the global interrupt mask register and 
> re-enabling when the equivalent reads of registers from the standard 
> 16550 register set should work...
>
> It's very disappointing that this UART chip doesn't seem to be just 
> 16550A compatible in the true sense.
> Maybe since the kernel thinks it has the STARTECH features (which it 
> does!) it puts it into a bad state where it won't really transmit 
> anything.  I'm very skeptical of that.
>
> I'm getting to the point where I may have to table this.  Do you have 
> any info from the manufacturer sysbas as to what on earth needs to be 
> twiddled with this thing to get it to simply transmit chars.  There 
> must be some voodoo going on in the windows driver they never did in 
> the linux drivers.  Any further info would be appreciated.  It really 
> looks like it thinks it's transmitting, but nothing coming out... it's 
> got to be something simple I would think -- I've exhausted every 
> possiblity I would come up with the datasheet and in looking at the 
> sysbas version of their modified 2.4 and 2.6 drivers.
>
> I'm copying the linux kernel mailing list (using my home e-mail 
> address) to see if any ideas are fourthcoming from the kernel developers.
>
> -Eric Malkowski
>
> tony@pridopia.co.uk wrote:
>> Hi,Eric,
>> Here is the some information for setting .
>>
>> I still waiting more information.
>>
>> Regards,
>> Tony
>>
>>
>>     ----- Original Message -----
>>     From:
>>     "Eric Malkowski" <EMalkowski@magnemotion.com>
>>
>>     To:
>>     "Eric Malkowski" <EMalkowski@magnemotion.com>, "Tony Pridopia"
>>     <tony@pridopia.co.uk>
>>     Cc:
>>
>>     Sent:
>>     Wed, 1 Dec 2010 21:59:15 -0500
>>     Subject:
>>     RE: Mi-PCI-03 issues
>>
>>
>>     Tony-
>>
>>     The card I brought home works fine on a windows laptop with the
>>     windows driver.
>>     This is good news as at least we know the hardware is good.
>>
>>     I tried typing chars between two hyperterminal windows on ports 1
>>     and 2 with them jumpered for RS-422 on the overall board
>>     RS422/RS485 jumper selection (same as factory default) and I set
>>     the jumpers for PORT_1_RT and PORT_2_RT for "RS422"  (all makes
>>     logical sense).
>>
>>     With the ports wired loopback pins like this:
>>
>>     1 <-> 3
>>     2 <-> 4
>>     3 <-> 1
>>     4 <-> 2
>>
>>     I'm able to do my typing tests at both 9600 bps and 460800 bps
>>     (our target speed)
>>
>>     Tomorrow I'll make sure the board can talk at 460800 to our
>>     embedded hardware and then we'll know the hardware should be fine.
>>
>>     The concern is using this with linux.
>>     I'm hoping the manufacturer (your guys in Taiwan or the people
>>     from sysbas who make the UART chip) has any pointers to better
>>     linux drivers.  Or -- is it possible they could send me a snippet
>>     of the sourcecode for the windows driver that actually initializes
>>     the chip -- I'm guessing there may be some things that need to be
>>     done in the option register to get the chip to transmit and
>>     generate interrupts properly.  Again I'm surprise the standard
>>     linux serial driver won't work.
>>
>>     In the meantime I've downloaded the datasheet from sysbas for the
>>     SB16C1052 PCI chip.
>>     I may try to make the necessary mods to make it work with the
>>     standard linux serial driver -- that would really be the best
>>     situation as the main serial driver is at least maintained by the
>>     linux kernel folks...   I'm also going to send an e-mail to the
>>     linux-serial@vger.kernel.org <mailto:linux-serial@vgerkernel.org>
>>     mailing list to see if anyone on there has made a sysbas UART work
>>     with linux at all or any other tips they could offer.
>>
>>     Thanks for looking into this.  I'll hold on to the hardware for
>>     now and keep working at this as I'm confident it should work... 
>>     it may take me a while, but I can't imagine there are that many
>>     extra things that need to be done beyond a standard UART to use
>>     this thing!
>>
>>     -Eric Malkowski
>>
>>
>>     -----Original Message-----
>>     From: Eric Malkowski
>>     Sent: Wed 12/1/2010 6:24 PM
>>     To: Tony Pridopia; Eric Malkowski
>>     Subject: Re: Mi-PCI-03 issues
>>
>>     Yes -- I'm going to try the card in a windows laptop tonight at
>>     home.  I
>>     don't really have a windows setup I can try it in at work.
>>     I'll try to send come characters from one port to the other with a
>>     RS422
>>     Null type setup and a couple of hyperterminal windows or something.
>>     It would certainly be good to at least know I have good hardware to
>>     start with!!!!
>>
>>     I have some more test information on the linux side -- with a scope,
>>     there is simply no data coming out of any pins 1-4 on the DB-9 
>> cable.
>>     We're using 2 channels on a scope to look for the differential 
>> voltage
>>     between Tx+ and Tx- pins 1 & 2.  We checked pins 3 & 4 just in
>>     case the
>>     manual was wrong.
>>     The only activity we can get out of this is to put the board into
>>     RS-485
>>     mode (both jumper blocks -- the 3 x jumper pins for each port set to
>>     "485" per the manual for PORT1_RT and PORT2_RT and then the 4 x 
>> jumper
>>     pins we place those two jumpers on the middle two which say RS485
>>     on the
>>     board).  If we run a small application program that sends
>>     characters at
>>     9600 bps, we get nothing.  Then we kill the application and run it
>>     again, and on the 2nd run we get a single trigger on the scope
>>     where it
>>     drives the line the opposite of idle (like one single bit!) and then
>>     shortly it goes back to idle.  It's almost like it tries to take the
>>     RS485 bus and then not transmit anything.
>>
>>     Anyway -- this is not very useful as we want to do RS-422 Point to
>>     Point
>>     no echo mode (4 wire full duplex), but we were trying in
>>     desperation to
>>     get ANYTHING to come out on the pins
>>
>>     So I built up the 2.6 kernel driver with my 2.6 setup which is
>>     designed
>>     for somewhere around kernel 2.6.19 but I'm running 2.6.28.4 so I
>>     had to
>>     port some of the data structure changes.
>>     The 2.6 kernel driver actually identifies both ports as RS-422
>>     Point to
>>     Point with no echo -- clearly the 2.4 driver doesn't identify the
>>     board
>>     right.  Makes wonder what else is wrong.
>>     But -- when I tried to transmit, the kernel was crashing -- I found
>>     there were some locking primitives that were removed in the newer 
>> 2.6
>>     kernel, so I remove the equivalent ones in their driver and it 
>> doesn't
>>     seem to work right.  Perhaps my porting efforts aren't quite right
>>     -- it
>>     doesn't even think it's transmitting characters (the counters in
>>     /proc/tty/driver/multiport don't increase).  So I wasn't able to 
>> have
>>     any further success with the 2.6 driver other than seeing it seem to
>>     identify the ports correctly when jumpered for RS422PTP no echo -- I
>>     don't really have time to try and debug why that driver won't even
>>     think
>>     characters are transmitted.
>>
>>     I'm willing to use a functioning 2.4 driver for this that is
>>     systembase's custom driver, but it would be even better if the
>>     standard
>>     serial driver could work with this board.
>>
>>     The registers are 16550 compatible at the PCI address space (there
>>     are 2
>>     banks of 8 registers for the 2 ports that are standard 16550 set 
>> of 8
>>     registers (Tx/Rx, LCR, MCR, FCR etc. etc.).  I'm surprised they went
>>     through the trouble of re-inventing the linux serial driver when the
>>     standard driver should work!  I'd be curious to hear if they have 
>> any
>>     idea if the board can work with the standard serial driver -- I
>>     originally made some quick mods to get the standard driver to
>>     detect the
>>     UARTs as 16650 STARTECH style UARTs, but when trying to transmit 
>> data,
>>     no interrupts would occur indicating perhaps one can only use their
>>     proprietary global interrupt register to deal with IRQs from the
>>     board...  this is disappointing.
>>
>>     Anyway -- I'll let you know the results of trying this on windows.
>>
>>     If they don't work on windows, I'll need to send the boards back
>>     so you
>>     or your folks in Taiwan can test them!
>>
>>     Lastly -- if systembase has and "newer" more current linux drivers
>>     that
>>     are tested and verified to work with your hardware, I would like
>>     to get
>>     my hands on those.
>>     I'm not convinced these linux drivers have ever worked properly with
>>     your hardware!
>>
>>     Thanks -- I'm trying really hard here to make this work and would
>>     really
>>     like to use your boards over the other ones I've found, but again 
>> it's
>>     not looking very good!
>>
>>     -Eric Malkowski
>>
>>
>>     Tony Pridopia wrote:
>>     > Sorry about your problem, we pass all your problem to
>>     manufacture, I am waiting their response. Sorry for the late..
>>     >
>>     > Can you find one laptop with mini pci slot, and test this card
>>     in windows first, make sure no problem first.
>>     >
>>     > Regards,
>>     > Tony
>>     >
>>     > Sent from my iPhone
>>     >
>>     > On 30 Nov 2010, at 22:31, Eric Malkowski
>>     <emalkowski@magnemotion.com <mailto:emalkowski@magnemotion.com>>
>>     wrote:
>>     >
>>     >      >> Hi Tony-
>>     >>
>>     >> I received the 2 Mi-PCI-03 serial boards.
>>     >> I set the PORT1_RT and PORT2_RT jumpers for "422" as I want
>>     RS-422 full duplex (4 wire mode), I do NOT want RS485 multidrop 2
>>     wired mode as shown in the manual.
>>     >> I left the jumpers that select RS422 or RS485 mode (not
>>     documented in the manual!) set for RS422 as they are from the
>>     factory (this is a row of 8 pins where the "outer most" two are
>>     populated with jumpers).
>>     >>
>>     >> By the way -- what does this thing do if the PORT1_RT and
>>     PORT2_RT are set to the "NONE" position?  As you can see below I
>>     tried that position in desperation.
>>     >>
>>     >> I built the 2.4 linux kernel driver for my 2.4.29 target kernel.
>>     >> When the driver loads, the first part that seems wrong is the
>>     following:
>>     >>
>>     >> ==============================================
>>     >>     MultiPorts/PCI Board Installation         version: 3.0     
>> revision: 2009-06-22
>>     >>       email :  <tech@mp.com <mailto:tech@mp.com>>             
>> ==============================================
>>     >> 2 board(s) installed.   4 ports availabe.
>>     >> Board No.0 Multi-2 PCI (rev b0) ttyMP0 ~ ttyMP1 using IRQ9
>>     >> 1 port --- RS422 and Point to Point mode
>>     >> 2 port --- RS232
>>     >> Board No.1 Multi-2 PCI (rev b0) ttyMP2 ~ ttyMP3 using IRQ11
>>     >> 1 port --- RS422 and Point to Point mode
>>     >> 2 port --- RS232
>>     >>
>>     >> It's claiming the second port on each board is setup for RS-232
>>     mode -- not sure why -- that is really wrong.
>>     >> I'm using your cables that came with the boards and made an
>>     RS-422 null modem by wiring the DB-9 pins with a simple loopback
>>     setup as follows:
>>     >>
>>     >> Pin 1 TxD+ to Pin 3 RxD+
>>     >> Pin 2 TxD-  to Pin 4 RxD-
>>     >> Pin 3 RxD+ to Pin 1 TxD+
>>     >> Pin 4 RxD- to Pin 2 TxD-
>>     >>
>>     >> The driver reports the application trying to send data, but no
>>     matter what no data is received (and I'm not sure if it's actually
>>     transmitting as I haven't put a scope on there yet, I won't get to
>>     that until tomorrow).
>>     >> The Driver shows the following:
>>     >>
>>     >> / # cat /proc/tty/driver/multiports
>>     >> *** MultiPorts Information :1.1 driver:3.0 revision:2009-06-22
>>     >> 0: Multi-2 PCI(rev b0) uart:SB16C1050 port:1400 irq:9
>>     osc:14.7456Mhz baud:9600 tx:56 rx:0 RTS|CTS|DTR|DSR|CD|RI
>>     >> 1: Multi-2 PCI(rev b0) uart:SB16C1050 port:1408 irq:9
>>     osc:14.7456Mhz tx:0 rx:0 RTS|CTS|DTR|DSR|CD|RI
>>     >> 2: Multi-2 PCI(rev b0) uart:SB16C1050 port:1480 irq:11
>>     osc:14.7456Mhz baud:9600 tx:56 rx:0 RTS|CTS|DTR|DSR|CD|RI
>>     >> 3: Multi-2 PCI(rev b0) uart:SB16C1050 port:1488 irq:11
>>     osc:14.7456Mhz tx:0 rx:0 CTS|DSR|CD|RI
>>     >>
>>     >> I have been trying port 1 on the first board (line #0 from
>>     above) to port 1 on the second board (line #2 from above) since
>>     the driver reports the first port on each board as RS422 point to
>>     point mode.
>>     >> I also tried having just ports 1 and 2 on the first board talk
>>     w/o the second board installed
>>     >> I tried configuring for 485 mode and all permutations of the
>>     jumpers in case they weren't documented right -- still no luck --
>>     it thinks it's transmitting (the 56 bytes from above) but nothing
>>     comes in
>>     >>
>>     >> I also tried having my application do the proprietary ioctl(fd,
>>     TIOCSPTPNOECHO, NULL) after opening the port thinking that maybe
>>     the systembase chip needs to be told to do RS422 point to point w/
>>     no echo in software -- the ioctl call is accepted, but still
>>     cannot get data to be received.
>>     >>
>>     >> Have you had anyone successfully use this board in RS-422 point
>>     to point (4 wire) mode with the 2.4 linux kernel driver as
>>     delivered on the CD from systembase?
>>     >>
>>     >> Tomorrow I may try to build up the 2.6 kernel module against a
>>     different setup of our software (we have a 2.6 kernel setup for
>>     another project, but I really need this board for the 2.4 project)
>>     just to see if that driver is plagued with the same problems.  If
>>     that one works, then I will certainly compare how the UARTs are
>>     being handled in the 2.6 stuff versus 2.4 -- perhaps systembase's
>>     2.4 driver is flawed -- just by the output above from inserting
>>     the kernel module where it things the 2nd port is RS232 is a
>>     pretty good indication this thing has serious problems!
>>     >>
>>     >> I'll also get an oscilloscope on there to see if anything is
>>     coming off the pins.  It's not looking very good...
>>     >>
>>     >> As a last resort I'll put one of the boards in a windoze laptop
>>     and try the windoze driver to see if I can get ports 1 and 2 to
>>     talk to each other.  This will at least be a baseline that the
>>     hardware actually works.
>>     >> I'm not really convinced these boards work unfortunately.
>>     >>
>>     >> Is there anyone from systembase you can put me in touch with to
>>     try and get this to work???
>>     >> Any other info would be greatly appreciated...  I've been very
>>     thorough about this -- I'm losing confidence quickly
>>     unfortunately.  I've made many many serial boards work on linux
>>     (PCI, ISA, USB, etc. etc.) and never had such difficultly was this
>>     one is presenting.
>>     >>
>>     >> I'll get back to you tomorrow, but I'm hoping you might have
>>     some info by the time the first half of your day over in the UK is
>>     over.
>>     >> I'm really hoping I can get this to work -- my only other
>>     option is a board that has only 16550 UARTs which may not work
>>     very well at 460800 bps.
>>     >>
>>     >> --
>>     >> Eric Malkowski
>>     >> MagneMotion, Inc.
>>     >>
>>     >>   
>>
>>
>> ------------------------------------------------------------------------
>>
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe 
> linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

