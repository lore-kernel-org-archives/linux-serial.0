From: "Sayang Oin" <sayangoin@hotmail.com>
Subject: result=read(fd,buffer,200);
Date: Tue, 20 Jul 2004 15:12:24 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <BAY15-F17edoJhTahSR0009232d@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from bay15-f17.bay15.hotmail.com ([65.54.185.17]:35339 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S265833AbUGTNMZ
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 20 Jul 2004 09:12:25 -0400
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello,

I would like to read for example 200 bytes from my UART device throught the 
serial port.

I use

result=read(fd,buffer,200);

I don't know why the result always lesser then 200 bytes.

my open_port  is like this:

int open_port ()
{

  struct termios options, oldtio;

  int fd;

  fd = open (COM,O_RDWR | O_NOCTTY );


if (fd < 0)
{
  fprintf(stderr, "Open_port: unable to open %s\n", COM);
  exit (1);
}
else
{
  fcntl (fd, F_SETFL, FNDELAY);
  printf("\nopen_port: 
%s,%s,%d,%d,%s\n",COM,BAUD,stopbits,datenbits,PARITY);
}

bzero(&options, sizeof(options));


if(!strcmp(BAUD,"B9600"))
   {
	cfsetispeed (&options, B9600);
	cfsetospeed (&options, B9600);
   }
if(!strcmp(BAUD,"B19200"))
   {
	cfsetispeed (&options, B19200);
	cfsetospeed (&options, B19200);
   }
if(!strcmp(BAUD,"B38400"))
   {
	cfsetispeed (&options, B38400);
	cfsetospeed (&options, B38400);
   }
if(!strcmp(BAUD,"B57600"))
   {
	cfsetispeed (&options, B57600);
	cfsetospeed (&options, B57600);
   }
if(!strcmp(BAUD,"B115200"))
   {
	cfsetispeed (&options, B115200);
	cfsetospeed (&options, B115200);
   }



switch(stopbits)
{
   case 1:
    options.c_cflag &= ~CSTOPB;
    break;
   case 2:
    options.c_cflag |= CSTOPB;
    break;
}

options.c_cflag &= ~CSIZE;
switch(datenbits)
{
  case 5:
    options.c_cflag |= CS5;
    break;
  case 6:
    options.c_cflag |= CS6;
    break;
  case 7:
    options.c_cflag |= CS7;
    break;
  case 8:
    options.c_cflag |= CS8;
    break;
}

if(!strcmp(PARITY,"even"))
             {
	      options.c_cflag |= PARENB;
	      options.c_cflag &= ~PARODD;
             }
else if(!strcmp(PARITY,"odd"))
             {
	      options.c_cflag |= PARENB;
	      options.c_cflag |= PARODD;
             }
else if(!strcmp(PARITY,"no"))
             {
	      options.c_cflag &= ~PARENB;
             }

options.c_cflag &= ~CRTSCTS;


options.c_cflag |= (CLOCAL | CREAD);

options.c_lflag &= ~(ICANON | ECHO | ECHOE |ISIG);

cfmakeraw (&options);

tcflush(fd, TCIFLUSH);
tcsetattr (fd, TCSAFLUSH, &options);

return fd;
}


Thanks for any advice..

Sayangoin

_________________________________________________________________
MSN Toolbar – kostenloser Pop-Up Blocker – Jetzt herunterladen 
http://toolbar.msn.de Jetzt kostenlos downloaden!

