From: Gerald Emig <gme@emig-software.de>
Subject: Re: result=read(fd,buffer,200);
Date: Tue, 20 Jul 2004 17:41:42 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040720174142.7b8b6525@emig4.heisch.inka.de>
References: <BAY15-F17edoJhTahSR0009232d@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:19189 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265970AbUGTPlw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 20 Jul 2004 11:41:52 -0400
Received: from [212.227.126.205] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1BmwkZ-0004wV-00
	for linux-serial@vger.kernel.org; Tue, 20 Jul 2004 17:41:51 +0200
Received: from [217.247.229.7] (helo=emig4.heisch.inka.de)
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 1BmwkY-0006aH-00
	for linux-serial@vger.kernel.org; Tue, 20 Jul 2004 17:41:50 +0200
In-Reply-To: <BAY15-F17edoJhTahSR0009232d@hotmail.com>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


HI,

According to the documentation provided in info:libc, read=20
returns the number of character it actually has read.
Especially if you are using serial ports, the amount read is often fewe=
r
as you expected.

Additionally, checking errno is stronly recommended.

Use something like the following to read exactly 200 chars:


int read_amount (int iwantread)
{
	int readpointer, fetch;
readpointer=3D0;
while (iwantread>0) {
	fetch=3Dread (fd,&buffer[readpointer],iwantread);
	if (fetch >=3D 0) {
		readpointer +=3D fetch;
		iwantread -=3D fetch;
	} else 	if ((errno!=3DEINTR) && (errno!=3DEAGAIN)) return -1;
	}
	return iwantread; // should be 0 on success
}

	=09
Best regards,

Gerald Emig





On Tue, 20 Jul 2004 15:12:24 +0200
"Sayang Oin" <sayangoin@hotmail.com> wrote:

> Hello,
>=20
> I would like to read for example 200 bytes from my UART device
> throught the serial port.
>=20
> I use
>=20
> result=3Dread(fd,buffer,200);
>=20
> I don't know why the result always lesser then 200 bytes.
>=20
> my open_port  is like this:
>=20
> int open_port ()
> {
>=20
>   struct termios options, oldtio;
>=20
>   int fd;
>=20
>   fd =3D open (COM,O_RDWR | O_NOCTTY );
>=20
>=20
> if (fd < 0)
> {
>   fprintf(stderr, "Open_port: unable to open %s\n", COM);
>   exit (1);
> }
> else
> {
>   fcntl (fd, F_SETFL, FNDELAY);
>   printf("\nopen_port:=20
> %s,%s,%d,%d,%s\n",COM,BAUD,stopbits,datenbits,PARITY);
> }
>=20
> bzero(&options, sizeof(options));
>=20
>=20
> if(!strcmp(BAUD,"B9600"))
>    {
> 	cfsetispeed (&options, B9600);
> 	cfsetospeed (&options, B9600);
>    }
> if(!strcmp(BAUD,"B19200"))
>    {
> 	cfsetispeed (&options, B19200);
> 	cfsetospeed (&options, B19200);
>    }
> if(!strcmp(BAUD,"B38400"))
>    {
> 	cfsetispeed (&options, B38400);
> 	cfsetospeed (&options, B38400);
>    }
> if(!strcmp(BAUD,"B57600"))
>    {
> 	cfsetispeed (&options, B57600);
> 	cfsetospeed (&options, B57600);
>    }
> if(!strcmp(BAUD,"B115200"))
>    {
> 	cfsetispeed (&options, B115200);
> 	cfsetospeed (&options, B115200);
>    }
>=20
>=20
>=20
> switch(stopbits)
> {
>    case 1:
>     options.c_cflag &=3D ~CSTOPB;
>     break;
>    case 2:
>     options.c_cflag |=3D CSTOPB;
>     break;
> }
>=20
> options.c_cflag &=3D ~CSIZE;
> switch(datenbits)
> {
>   case 5:
>     options.c_cflag |=3D CS5;
>     break;
>   case 6:
>     options.c_cflag |=3D CS6;
>     break;
>   case 7:
>     options.c_cflag |=3D CS7;
>     break;
>   case 8:
>     options.c_cflag |=3D CS8;
>     break;
> }
>=20
> if(!strcmp(PARITY,"even"))
>              {
> 	      options.c_cflag |=3D PARENB;
> 	      options.c_cflag &=3D ~PARODD;
>              }
> else if(!strcmp(PARITY,"odd"))
>              {
> 	      options.c_cflag |=3D PARENB;
> 	      options.c_cflag |=3D PARODD;
>              }
> else if(!strcmp(PARITY,"no"))
>              {
> 	      options.c_cflag &=3D ~PARENB;
>              }
>=20
> options.c_cflag &=3D ~CRTSCTS;
>=20
>=20
> options.c_cflag |=3D (CLOCAL | CREAD);
>=20
> options.c_lflag &=3D ~(ICANON | ECHO | ECHOE |ISIG);
>=20
> cfmakeraw (&options);
>=20
> tcflush(fd, TCIFLUSH);
> tcsetattr (fd, TCSAFLUSH, &options);
>=20
> return fd;
> }
>=20
>=20
> Thanks for any advice..
>=20
> Sayangoin
>=20
> _________________________________________________________________
> MSN Toolbar =96 kostenloser Pop-Up Blocker =96 Jetzt herunterladen=20
> http://toolbar.msn.de Jetzt kostenlos downloaden!
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-serial" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
