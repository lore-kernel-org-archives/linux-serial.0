From: Michael Westermann <mw@microdata-pos.de>
Subject: Re: Connect with various serial devices
Date: Tue, 16 Dec 2003 08:23:30 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20031216082330.Q12637@microdata-pos.de>
References: <33348.192.168.192.123.1071088389.squirrel@www.clientes.sedifa.com> <20031210.203940.8.0.whitnl73@juno.com> <33369.192.168.192.123.1071130475.squirrel@www.clientes.sedifa.com> <20031211103352.G12637@microdata-pos.de> <32780.192.168.192.123.1071144774.squirrel@www.clientes.sedifa.com> <20031211132914.I12637@microdata-pos.de> <32779.192.168.192.123.1071148124.squirrel@www.clientes.sedifa.com> <20031211142704.J12637@microdata-pos.de> <32783.192.168.192.123.1071514853.squirrel@www.clientes.sedifa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from port-212-202-104-142.reverse.qsc.de ([212.202.104.142]:57613
	"EHLO imail.microdata-pos.de") by vger.kernel.org with ESMTP
	id S264345AbTLPHXb (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 Dec 2003 02:23:31 -0500
Content-Disposition: inline
In-Reply-To: <32783.192.168.192.123.1071514853.squirrel@www.clientes.sedifa.com>; from informatic@sedifa.com on Mon, Dec 15, 2003 at 08:00:53PM +0100
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello,
On Mon, Dec 15, 2003 at 08:00:53PM +0100, Albert Cervera Areny wrote:
> Well, finally thanks to your suggestions we were able to make the most
> important device work. Thanks!
> 
> However, we're now trying to make work an Omron V2XF card reader/writer
> but we're stuck again. Maybe somebody in the list has been able to make
> work one of these. Does somebody have any piece of work (or help) we can
> try with it?
> 
> The device is supposed to autodetect connection speed, but it doesn't
> return a sigle byte :(
> 
> Well, thanks in advance again! ;)
Can i get the doku ?

I've get a short descrition from the omron home-page. The cardreader
has cts but not rts. Please test without CRTSCTS and set RTS  manually
with ioctrl.  

void set_rts(fd, int para) {
    unsigned int c = TIOCM_RTS; 
    if (fd >= 0)
        ioctl(fd, (para) ? TIOCMBIS : TIOCMBIC, &c); 
}

Assemble you a cash dispenser, or a pount of sale ? 

Happy Testing,

Michael



