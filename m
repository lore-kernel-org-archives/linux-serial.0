From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Subject: Re: [PATCH v7 3/5] mfd: ioc3: Add driver for SGI IOC3 chip
Date: Fri, 4 Oct 2019 19:25:09 +0200
Message-ID: <20191004192509.98d4bbda4468c6b9407bc370@suse.de>
References: <20191003095235.5158-1-tbogendoerfer@suse.de>
        <20191003095235.5158-4-tbogendoerfer@suse.de>
        <20191004144453.GQ18429@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191004144453.GQ18429@dell>
Sender: netdev-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: Jonathan Corbet <corbet@lwn.net>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, netdev@vger.kernel.org, linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-serial@vger.kernel.org

On Fri, 4 Oct 2019 15:44:53 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> On Thu, 03 Oct 2019, Thomas Bogendoerfer wrote:
> > +	if (mask & BIT(IOC3_IRQ_ETH_DOMAIN))
> > +		/* if eth irq is enabled we need to check in eth irq regs */
> 
> Nit: Comments should be expressive.  Please expand all of the
> short-hand in this sentence.  It would also be nicer if you started
> with an uppercase character.
> 
> Same with all of the other comments in this file.

ok.

> Other than that, it looks like it's really coming together.  Once the
> above is fixed, please re-sumbit with my:

Thanks.

David, 

before re-posting with the english grammer pimp up, is there anything
I should improve for the network part ? If not, could I get a acked-by
from your side ?

Thomas.

-- 
SUSE Software Solutions Germany GmbH
HRB 247165 (AG München)
Geschäftsführer: Felix Imendörffer
