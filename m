From: "Albert Cervera Areny" <informatic@sedifa.com>
Subject: Re: Connect with various serial devices
Date: Thu, 11 Dec 2003 09:14:35 +0100 (CET)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <33369.192.168.192.123.1071130475.squirrel@www.clientes.sedifa.com>
References: <33348.192.168.192.123.1071088389.squirrel@www.clientes.sedifa.com>
    <20031210.203940.8.0.whitnl73@juno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 199.Red-80-26-113.pooles.rima-tde.net ([80.26.113.199]:23937
	"HELO localhost") by vger.kernel.org with SMTP id S264386AbTLKIOh
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 11 Dec 2003 03:14:37 -0500
In-Reply-To: <20031210.203940.8.0.whitnl73@juno.com>
List-Id: linux-serial@vger.kernel.org
To: whitnl73@juno.com
Cc: linux-serial@vger.kernel.org

Thanks for your suggestion, but it doesn't work either. If I set
O_NONBLOCK it doesn't block in the read statement but it never receives
anything. The problem must be that data isn't sent correctly either as =
the
device would do something if it received it correctly (though I might n=
ot
receive a response).

Any other ideas?

Thanks again.

Albert


> On Wed, 10 Dec 2003, Albert Cervera Areny wrote:
>
>> Hi,
>> 	I need to use various external devices which include (just in case
>> somebody has been able to do it already) an omron Card reader (V2X) =
and
>> a
>> note dispenser.
>> The thing is that I've been able to use the note dispenser with the
>> following code:
>>
>> fd =3D open( tty.ascii(), O_RDWR|O_NOCTTY);
>> bzero( &t, sizeof(t) );
>> t.c_cflag =3D B4800 | CS7 | CLOCAL | CREAD | PARENB;
>> t.c_iflag =3D IGNPAR | ICRNL;
>> t.c_oflag =3D 0;
>> t.c_lflag =3D ICANON;
>> tcflush(fd, TCIFLUSH);
>> tcsetattr(fd,TCSANOW,&t);
>>
>> But when I try to connect with the Omron Card Reader (and other devi=
ces)
>> I
>> cant contact them. I've configured CS, parity and speed as they shou=
ld,
>> but there seems to be some other reason for these no to work.
>> The thing is that, those periferals work ok with a program in
>> Windows2000
>> with Visual C++ where the code to initialize looks something like th=
is
>> for
>> one periferal:
>>
>> hCom =3D CreateFile((char *)sCom,GENERIC_READ | GENERIC_WRITE,  0,  =
NULL,
>> OPEN_EXISTING, 0, (long) 0);
>>
>> if(hCom =3D=3D INVALID_HANDLE_VALUE) {
>> 	dwError =3D GetLastError();
>> 	printf(bufrec,"Error:%d\n", dwError);
>> 	Close();
>> }
>>
>> fSuccess =3D GetCommState(hCom, &dcbPort);
>> if(!fSuccess) {
>> 	Close();
>> }
>> dcbPort.BaudRate =3D 9600;
>> dcbPort.ByteSize =3D 8;
>> dcbPort.Parity =3D NOPARITY;
>> dcbPort.StopBits =3D TWOSTOPBITS;
>> fSuccess =3D SetCommState(hCom, &dcbPort);
>> if(!fSuccess) {
>> 	Close();
>> }
>>
>> The same periferal I try to inicialize it with Linux with:
>>
>> bzero( &t, sizeof(t) );
>> t.c_cflag =3D B9600 | CS8 | CLOCAL | CREAD | CSTOPB;
>> t.c_iflag =3D IGNPAR | IGNBRK;
>> t.c_oflag =3D 0;
>> t.c_lflag =3D  ICANON;
>> tcflush( fd, TCIFLUSH );
>> tcsetattr( fd, TCSANOW, &t );
>>
>> Can somebody see a reason why this shouldn't work for Linux or why i=
t is
>> different from the windows code? The device seems to receive somethi=
ng
>> as
>> a led shows it but doesn't do what it should, so it seems as the dat=
a
>> received must be garbage. If the device receives a command it doesn'=
t
>> understand should send a NACK.
>>
>> I send information using (no error returned):
>> write( fd, s.ascii(), s.length() )
>>
>> And receive with (it waits forever):
>> read( fd, c, 1 )
>>
>> Sorry for this long e-mail, but I'm really desperate. Hope somebody =
can
>> help!
>>
>> Thanks in advance!
>>
>> Albert
>> -
> Seems I remember a case on linux-serial or -newbie recently where rea=
d
> would hang waiting for DCD to come up even though CLOCAL was set.  He
> solved it by strapping his carrier-detect line, but I think O_NONBLOC=
K
> or O_NDELEAY in the fd will also work (just feed it to open(), FI).
>
> What, BTW are s.ascii() and s.length() ?
>
> Lawson
> --
> ---oops---
>
>
>
> ________________________________________________________________
> The best thing to hit the internet in years - Juno SpeedBand!
> Surf the web up to FIVE TIMES FASTER!
> Only $14.95/ month - visit www.juno.com to sign up today!
>
>


Albert Cervera Areny
Dept. Inform=E0tica Sedifa, S.L.

Av. Can Bordoll, 149
08202 - Sabadell (Barcelona)
Tel. 93 715 51 11
-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
