From: whitnl73@juno.com
Subject: Re: modem help needed
Date: Fri, 21 Mar 2003 15:11:31 -0500 (EST)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030321.151240.8.1.whitnl73@juno.com>
References: <20030321091016.41190.qmail@web12705.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20030321091016.41190.qmail@web12705.mail.yahoo.com>
List-Id: linux-serial@vger.kernel.org
To: manish_ipx@yahoo.com
Cc: linux-serial@vger.kernel.org

On Fri, 21 Mar 2003, Manish Kumar Arya wrote:

> hi
>    i m writing a program to read data of an in comming
> phone call using modem
>    till now i m able to get "RING" in my read buffer
> when an incomming call comes.
>     after this i tried two answer the call by two ways
> 1) ATA\r
> 2) setting ATS0=3 (3 rings) register
>
> but after answering the calls i dont get any data on
> serial port.
>    is it really not possible to read data from normal
> phone calls or i m doin some mistake.

By "normal phone calls", do you mean voice?  If you do,
no, it isn't.  Dependig on your modem, there might be a command
to make the thing answer in voice mode, but ATA is not going to do it.
After a normal modem answers a call, it tries to negotiate a data
connection with a remote modem, then if it is successful (I think) sends
the report CONNECTED to the serial port.  If not, it sends NO CARRIER
and hangs up.

t > i just want to read raw data from incomming calls not
> in some voice format.
>
> help!
>
> -Manish Kumar Arya
> www.LinuxIndia.net

Lawson
--
---oops---



________________________________________________________________
Sign Up for Juno Platinum Internet Access Today
Only $9.95 per month!
Visit www.juno.com
