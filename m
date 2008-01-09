From: JZabalza@cemitec.com
Subject: Handling RTS
Date: Wed, 9 Jan 2008 19:17:55 +0100
Message-ID: <OFAF597FC5.42D5FDAE-ONC12573CB.0060EF59-C12573CB.00648213@cemitec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cliente-24411.iberbanda.es ([83.230.159.89]:2510 "EHLO
	Morondo.cemitec.local" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750720AbYAISeo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 9 Jan 2008 13:34:44 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello list

I have a RS485 device connect to a PC serial port.  To handle half dupl=
ex=20
transmision I must activate/deactivate RTS line. I think this is a very=
=20
common practice.To do this I have these functions

int set_to_write( int _port)=20
{=20
int nStatus;=20

    if ( ioctl( _port, TIOCMGET, &nStatus ) < 0)=20
    {=20
        return -1;=20
    }=20
    else=20
    {=20
        nStatus |=3D TIOCM_RTS;=20
        if ( ioctl( _port, TIOCMSET, &nStatus ) < 0)=20
        {=20
            return -2;=20
        }=20
    }=20
=20
    return 0;=20
}=20

int set_to_read( int _port )=20
{=20
int nStatus;=20

    if ( ioctl( _port, TIOCMGET, &nStatus ) < 0)=20
    {=20
        return -1;=20
    }=20
    else=20
    {=20

        nStatus &=3D ~TIOCM_RTS;=20
        if ( ioctl( _port, TIOCMSET, &nStatus ) < 0)=20
        {=20
            return -2;=20
        }=20
    }=20

    return 0;=20
}
=20

To send bytes I have this code

set_to_write(port);
write(port,"bytes to send",len);
tcdrain(port)
set_to_read(port);

All is running succesfully but when I put oscilloscope I can see 10 mS =
(or=20
more) latency time from set_to_write() to write() begin to send=20
characters. I know this is a Linux userland issue but, is there another=
=20
way to do this from driver, similar a cflag CRTSCTS to activate RTS/CTS=
=20
protocol?.

If there is not another way, which shall be the best strategy to implem=
ent=20
this (activate RTS when uart is transmiting data and deactivate when=20
transmision is finish. It would be another protocol different but simil=
ar=20
to RTS/CTS protocol) on linux driver (modifying serial_core.c  to accep=
t a=20
new CFLAG?) ?


thank you very munch for your help.


Jos=E9 Luis Zabalza

-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
