From: "Albert Cervera Areny" <informatic@sedifa.com>
Subject: Connect with various serial devices
Date: Wed, 10 Dec 2003 21:33:09 +0100 (CET)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <33348.192.168.192.123.1071088389.squirrel@www.clientes.sedifa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 199.Red-80-26-113.pooles.rima-tde.net ([80.26.113.199]:26345
	"HELO localhost") by vger.kernel.org with SMTP id S263918AbTLJUdL
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 10 Dec 2003 15:33:11 -0500
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,
	I need to use various external devices which include (just in case
somebody has been able to do it already) an omron Card reader (V2X) and a
note dispenser.
The thing is that I've been able to use the note dispenser with the
following code:

fd = open( tty.ascii(), O_RDWR|O_NOCTTY);
bzero( &t, sizeof(t) );
t.c_cflag = B4800 | CS7 | CLOCAL | CREAD | PARENB;
t.c_iflag = IGNPAR | ICRNL;
t.c_oflag = 0;
t.c_lflag = ICANON;
tcflush(fd, TCIFLUSH);
tcsetattr(fd,TCSANOW,&t);

But when I try to connect with the Omron Card Reader (and other devices) I
cant contact them. I've configured CS, parity and speed as they should,
but there seems to be some other reason for these no to work.
The thing is that, those periferals work ok with a program in Windows2000
with Visual C++ where the code to initialize looks something like this for
one periferal:

hCom = CreateFile((char *)sCom,GENERIC_READ | GENERIC_WRITE,  0,  NULL,
OPEN_EXISTING, 0, (long) 0);

if(hCom == INVALID_HANDLE_VALUE) {
	dwError = GetLastError();
	printf(bufrec,"Error:%d\n", dwError);
	Close();
}

fSuccess = GetCommState(hCom, &dcbPort);
if(!fSuccess) {
	Close();
}
dcbPort.BaudRate = 9600;
dcbPort.ByteSize = 8;
dcbPort.Parity = NOPARITY;
dcbPort.StopBits = TWOSTOPBITS;
fSuccess = SetCommState(hCom, &dcbPort);
if(!fSuccess) {
	Close();
}

The same periferal I try to inicialize it with Linux with:

bzero( &t, sizeof(t) );
t.c_cflag = B9600 | CS8 | CLOCAL | CREAD | CSTOPB;
t.c_iflag = IGNPAR | IGNBRK;
t.c_oflag = 0;
t.c_lflag =  ICANON;
tcflush( fd, TCIFLUSH );
tcsetattr( fd, TCSANOW, &t );

Can somebody see a reason why this shouldn't work for Linux or why it is
different from the windows code? The device seems to receive something as
a led shows it but doesn't do what it should, so it seems as the data
received must be garbage. If the device receives a command it doesn't
understand should send a NACK.

I send information using (no error returned):
write( fd, s.ascii(), s.length() )

And receive with (it waits forever):
read( fd, c, 1 )

Sorry for this long e-mail, but I'm really desperate. Hope somebody can help!

Thanks in advance!

Albert
