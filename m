From: "Deepak Gupta" <deepak@cse.iitk.ac.in>
Subject: RE: serial communication problems
Date: Thu, 30 May 2002 08:22:33 +0530
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <NGBBLCPHOLHALDOMDOMNAEEGCAAA.deepak@cse.iitk.ac.in>
References: <005401c20717$6690c0c0$294b82ce@connecttech.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <005401c20717$6690c0c0$294b82ce@connecttech.com>
List-Id: linux-serial@vger.kernel.org
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: linux-serial@vger.kernel.org

The stty settings are OK, I believe.  Here is the output of
"stty -a -F /dev/ttyS0"

speed 9600 baud; rows 0; columns 0; line = 0;
intr = ^C; quit = ^\; erase = ^?; kill = ^U; eof = ^D; eol = <undef>;
eol2 = <undef>; start = ^Q; stop = ^S; susp = ^Z; rprnt = ^R; werase = ^W;
lnext = ^V; flush = ^O; min = 1; time = 0;
-parenb -parodd cs8 -hupcl -cstopb cread clocal -crtscts
-ignbrk -brkint
ignpar -parmrk -inpck -istrip -inlcr -igncr -icrnl -ixon -ixoff
-iuclc -ixany -imaxbel
-opost -olcuc -ocrnl -onlcr -onocr -onlret -ofill -ofdel nl0 cr0 tab0 bs0
vt0
ff0
-isig -icanon -iexten -echo echoe
echok -echonl -noflsh -xcase -tostop -echoprt
echoctl echoke

Any idea what else could be wrong?

Deepak

-----Original Message-----
From: Stuart MacDonald [mailto:stuartm@connecttech.com]
Sent: Wednesday, May 29, 2002 7:18 PM
To: Deepak Gupta
Subject: Re: serial communication problems


From: "Deepak Gupta" <deepak@cse.iitk.ac.in>
> The problem is that when the vendor software sends a command to a lock
> it replies obediently but when my program writes exactly the same sequence
> of bytes to the serial line, I don't get a response (the protocol
> says that the lock will not respond unless it gets a valid command).

Check your tty layer settings with stty when your program has the
port open. You'll need CLOCAL to be set....

> Incidentally I opened up the 232-485 converter box and saw that it
> uses only the TX, RX, SG, RTS and CTS lines on the RS232 side.  So
> it cannot be a matter of DTR or some other signal.

..because 485 doesn't have the same signal set. Also check CREAD.
You'll likely want to set the tty layer into "raw" mode so that
your commands don't get character-processed.

..Stu


