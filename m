From: Manish Kumar Arya <manish_ipx@yahoo.com>
Subject: Re: modem help needed
Date: Sat, 22 Mar 2003 09:29:46 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030322172947.570.qmail@web12708.mail.yahoo.com>
References: <20030321.151240.8.1.whitnl73@juno.com>
Reply-To: manish_ipx@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20030321.151240.8.1.whitnl73@juno.com>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

hi
   this is my second mail regarding modem problem.
i have made lil progress in this
  Lawson told me that i should recive "CONNECT" from
remote system(modem/fax machine).I did tested my
program by dialing to ISP and got "CONNECT" and there
after "Login" and then "Password". its worked with Fax
machine too, I was able to get "CONNECT" from fax
machine.
   but i m still not able to find way to communicate
with normal phone calls (voice calls).
   i have found a set of voice commands on net.

as per this doc i did set modem to voice mode

AT+FCLASS=8 
AT+VSD=128,100
AT+VGT=128
AT+VGR=128
AT+VRA=100
AT+VRN=10
AT+VCID=1
AT+VNH=0
AT+VIT=0
AT+VDR=1
AT+VSM=141,8000
AT+VLS=1
then at last i dialed to a voice phone no.
ATDT238470
and got "OK" reply from modem
still wondering what to do next to start reading data
on phone line

pls help

here is some part of that doc
The AT Voice Command Set 

AT+FCLASS=8  Enter voice mode  
AT+VIP  Initialise voice parameters  
AT+VCID  Caller ID  
AT+VDR  Distinctive ring  
AT+VGT  Speaker volume control  
AT+FMI?  Report manufacturer ID  
AT+FMM?  Report product model information  
AT+FMR?  Report product revision level  
AT+VIT  DTE/DCE inactivity timer  
AT+VNH  Automatic hang-up control  
AT+VTD  Set beep tone duration timer  
AT+VLS  Analog source/destination selection and
DTMF/tone reporting  
AT+VSD  Set silence detection timer  
AT+VRA  Set ringback goes away timer  
AT+VRN  Set ringback never came timer  
AT+VTS  DTMF/tone generation  
AT+VTX  Enter voice transmit state  
AT+VRX  Enter voice receive state  
AT+VSM  Voice compression method  
AT+VEM  Event reporting and masking  
AT+VGR  Receive gain selection  

-Manish Arya
www.LinuxIndia.net
  
--- whitnl73@juno.com wrote:
> On Fri, 21 Mar 2003, Manish Kumar Arya wrote:
> 
> > hi
> >    i m writing a program to read data of an in
> comming
> > phone call using modem
> >    till now i m able to get "RING" in my read
> buffer
> > when an incomming call comes.
> >     after this i tried two answer the call by two
> ways
> > 1) ATA\r
> > 2) setting ATS0=3 (3 rings) register
> >
> > but after answering the calls i dont get any data
> on
> > serial port.
> >    is it really not possible to read data from
> normal
> > phone calls or i m doin some mistake.
> 
> By "normal phone calls", do you mean voice?  If you
> do,
> no, it isn't.  Dependig on your modem, there might
> be a command
> to make the thing answer in voice mode, but ATA is
> not going to do it.
> After a normal modem answers a call, it tries to
> negotiate a data
> connection with a remote modem, then if it is
> successful (I think) sends
> the report CONNECTED to the serial port.  If not, it
> sends NO CARRIER
> and hangs up.
> 
> t > i just want to read raw data from incomming
> calls not
> > in some voice format.
> >
> > help!
> >
> > -Manish Kumar Arya
> > www.LinuxIndia.net
> 
> Lawson
> --
> ---oops---
> 
> 
> 
>
________________________________________________________________
> Sign Up for Juno Platinum Internet Access Today
> Only $9.95 per month!
> Visit www.juno.com
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
http://vger.kernel.org/majordomo-info.html


__________________________________________________
Do you Yahoo!?
Yahoo! Platinum - Watch CBS' NCAA March Madness, live on your desktop!
http://platinum.yahoo.com
