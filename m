From: Michael Westermann <mw@microdata-pos.de>
Subject: Re: Connect with various serial devices
Date: Thu, 11 Dec 2003 10:33:52 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20031211103352.G12637@microdata-pos.de>
References: <33348.192.168.192.123.1071088389.squirrel@www.clientes.sedifa.com> <20031210.203940.8.0.whitnl73@juno.com> <33369.192.168.192.123.1071130475.squirrel@www.clientes.sedifa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from port-212-202-104-142.reverse.qsc.de ([212.202.104.142]:13835
	"EHLO imail.microdata-pos.de") by vger.kernel.org with ESMTP
	id S264887AbTLKJdy (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 11 Dec 2003 04:33:54 -0500
Content-Disposition: inline
In-Reply-To: <33369.192.168.192.123.1071130475.squirrel@www.clientes.sedifa.com>; from informatic@sedifa.com on Thu, Dec 11, 2003 at 09:14:35AM +0100
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello,

On Thu, Dec 11, 2003 at 09:14:35AM +0100, Albert Cervera Areny wrote:


> Thanks for your suggestion, but it doesn't work either. If I set
> O_NONBLOCK it doesn't block in the read statement but it never receives
> anything. The problem must be that data isn't sent correctly either as the
> device would do something if it received it correctly (though I might not
> receive a response).
I think you you will read raw from the device, please set 

	t.c_iflag		= 0;
	t.c_oflag		= 0;
	t.c_cflag 		= B4800 | CS7 | CLOCAL | CREAD | PARENB;
	t.c_cc[VMIN]		= count;
	t.c_cc[VTIME]		= time; 	
	t.c_cc[VSTOP]		= 0;
	t.c_cc[VSTART]		= 0;
	t.c_lflag		= 0;
	t.c_oflag		= 0;

VMIN and VTIM are most probably described in a serial HOWTO

> Any other ideas?

Particulary, I think ICANON is wrong in this context.
Use select(2)  ;-)

Michael
