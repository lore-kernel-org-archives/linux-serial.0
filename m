From: whitnl73@juno.com
Subject: Re: Connect with various serial devices
Date: Wed, 10 Dec 2003 20:38:37 -0500 (EST)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20031210.203940.8.0.whitnl73@juno.com>
References: <33348.192.168.192.123.1071088389.squirrel@www.clientes.sedifa.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from m14.nyc.untd.com ([64.136.22.77]:26245 "HELO m14.nyc.untd.com")
	by vger.kernel.org with SMTP id S264341AbTLKBqF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 10 Dec 2003 20:46:05 -0500
In-Reply-To: <33348.192.168.192.123.1071088389.squirrel@www.clientes.sedifa.com>
List-Id: linux-serial@vger.kernel.org
To: informatic@sedifa.com
Cc: linux-serial@vger.kernel.org

On Wed, 10 Dec 2003, Albert Cervera Areny wrote:

> Hi,
> 	I need to use various external devices which include (just in case
> somebody has been able to do it already) an omron Card reader (V2X) and a
> note dispenser.
> The thing is that I've been able to use the note dispenser with the
> following code:
>
> fd = open( tty.ascii(), O_RDWR|O_NOCTTY);
> bzero( &t, sizeof(t) );
> t.c_cflag = B4800 | CS7 | CLOCAL | CREAD | PARENB;
> t.c_iflag = IGNPAR | ICRNL;
> t.c_oflag = 0;
> t.c_lflag = ICANON;
> tcflush(fd, TCIFLUSH);
> tcsetattr(fd,TCSANOW,&t);
>
> But when I try to connect with the Omron Card Reader (and other devices) I
> cant contact them. I've configured CS, parity and speed as they should,
> but there seems to be some other reason for these no to work.
> The thing is that, those periferals work ok with a program in Windows2000
> with Visual C++ where the code to initialize looks something like this for
> one periferal:
>
> hCom = CreateFile((char *)sCom,GENERIC_READ | GENERIC_WRITE,  0,  NULL,
> OPEN_EXISTING, 0, (long) 0);
>
> if(hCom == INVALID_HANDLE_VALUE) {
> 	dwError = GetLastError();
> 	printf(bufrec,"Error:%d\n", dwError);
> 	Close();
> }
>
> fSuccess = GetCommState(hCom, &dcbPort);
> if(!fSuccess) {
> 	Close();
> }
> dcbPort.BaudRate = 9600;
> dcbPort.ByteSize = 8;
> dcbPort.Parity = NOPARITY;
> dcbPort.StopBits = TWOSTOPBITS;
> fSuccess = SetCommState(hCom, &dcbPort);
> if(!fSuccess) {
> 	Close();
> }
>
> The same periferal I try to inicialize it with Linux with:
>
> bzero( &t, sizeof(t) );
> t.c_cflag = B9600 | CS8 | CLOCAL | CREAD | CSTOPB;
> t.c_iflag = IGNPAR | IGNBRK;
> t.c_oflag = 0;
> t.c_lflag =  ICANON;
> tcflush( fd, TCIFLUSH );
> tcsetattr( fd, TCSANOW, &t );
>
> Can somebody see a reason why this shouldn't work for Linux or why it is
> different from the windows code? The device seems to receive something as
> a led shows it but doesn't do what it should, so it seems as the data
> received must be garbage. If the device receives a command it doesn't
> understand should send a NACK.
>
> I send information using (no error returned):
> write( fd, s.ascii(), s.length() )
>
> And receive with (it waits forever):
> read( fd, c, 1 )
>
> Sorry for this long e-mail, but I'm really desperate. Hope somebody can help!
>
> Thanks in advance!
>
> Albert
> -
Seems I remember a case on linux-serial or -newbie recently where read
would hang waiting for DCD to come up even though CLOCAL was set.  He
solved it by strapping his carrier-detect line, but I think O_NONBLOCK
or O_NDELEAY in the fd will also work (just feed it to open(), FI).

What, BTW are s.ascii() and s.length() ?

Lawson
--
---oops---



________________________________________________________________
The best thing to hit the internet in years - Juno SpeedBand!
Surf the web up to FIVE TIMES FASTER!
Only $14.95/ month - visit www.juno.com to sign up today!
