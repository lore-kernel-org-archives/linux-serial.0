From: whitnl73@juno.com
Subject: Re: modem help needed
Date: Sun, 23 Mar 2003 18:44:18 -0500 (EST)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030323.191651.8.4.whitnl73@juno.com>
References: <20030322172947.570.qmail@web12708.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20030322172947.570.qmail@web12708.mail.yahoo.com>
List-Id: linux-serial@vger.kernel.org
To: manish_ipx@yahoo.com
Cc: linux-serial@vger.kernel.org

On Sat, 22 Mar 2003, Manish Kumar Arya wrote:

> hi
>    this is my second mail regarding modem problem.
> i have made lil progress in this
>   Lawson told me that i should recive "CONNECT" from
> remote system(modem/fax machine).I did tested my
> program by dialing to ISP and got "CONNECT" and there
> after "Login" and then "Password". its worked with Fax
> machine too, I was able to get "CONNECT" from fax
> machine.
>    but i m still not able to find way to communicate
> with normal phone calls (voice calls).
>    i have found a set of voice commands on net.
>
> as per this doc i did set modem to voice mode
>
> AT+FCLASS=8
> AT+VSD=128,100
> AT+VGT=128
> AT+VGR=128
> AT+VRA=100
> AT+VRN=10
> AT+VCID=1
> AT+VNH=0
> AT+VIT=0
> AT+VDR=1
> AT+VSM=141,8000
> AT+VLS=1
> then at last i dialed to a voice phone no.
> ATDT238470
> and got "OK" reply from modem
> still wondering what to do next to start reading data
> on phone line
>
> pls help
>
> here is some part of that doc
> The AT Voice Command Set
>
> AT+FCLASS=8  Enter voice mode
> AT+VIP  Initialise voice parameters
> AT+VCID  Caller ID
> AT+VDR  Distinctive ring
> AT+VGT  Speaker volume control
> AT+FMI?  Report manufacturer ID
> AT+FMM?  Report product model information
> AT+FMR?  Report product revision level
> AT+VIT  DTE/DCE inactivity timer
> AT+VNH  Automatic hang-up control
> AT+VTD  Set beep tone duration timer
> AT+VLS  Analog source/destination selection and
> DTMF/tone reporting

IIRC these voice modems have a speaker/headphone jack and a microphone
jack.  I think maybe you only get something on the serial port if
somebody at the other end dials something, and maybe the only way to get
voice data out of the thing is to cross-connect it with a sound card.
Please excuse this wild guess, but that is what the command above
suggests to me.

OTOH Mandrake carries an mgetty-voice package uou might want to look at.
if you install that you can see what commands it uses with FI

strings /usr/bin/vm |gtrp 'AT+V'

> AT+VSD  Set silence detection timer
> AT+VRA  Set ringback goes away timer
> AT+VRN  Set ringback never came timer
> AT+VTS  DTMF/tone generation
> AT+VTX  Enter voice transmit state
> AT+VRX  Enter voice receive state
> AT+VSM  Voice compression method
> AT+VEM  Event reporting and masking
> AT+VGR  Receive gain selection
>
> -Manish Arya
> www.LinuxIndia.net

Lawson
--
---oops---



________________________________________________________________
Sign Up for Juno Platinum Internet Access Today
Only $9.95 per month!
Visit www.juno.com
