From: Joe Perches <joe@perches.com>
Subject: Re: [patch v3 1/5] AST2500 DMA UART driver
Date: Wed, 03 Jul 2019 12:16:01 -0700
Message-ID: <2f19693f2f720dcc037465d4ae517fb846c7eb4f.camel@perches.com>
References: <1561459476-14268-1-git-send-email-open.sudheer@gmail.com>
         <1561459476-14268-2-git-send-email-open.sudheer@gmail.com>
         <20190703174926.GA12813@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190703174926.GA12813@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, "sudheer.v" <open.sudheer@gmail.com>
Cc: jslaby@suse.com, joel@jms.id.au, andrew@aj.id.au, benh@kernel.crashing.org, robh+dt@kernel.org, mark.rutland@arm.com, shivahshankar.shankarnarayanrao@aspeedtech.com, shivahshankar@gmail.com, sudheer.veliseti@aspeedtech.com, sudheer veliseti <sudheer.open@gmail.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org

On Wed, 2019-07-03 at 19:49 +0200, Greg KH wrote:
> On Tue, Jun 25, 2019 at 04:14:32PM +0530, sudheer.v wrote:
> > +#define UART_TX_R_POINT(x) (0x40 + (x * 0x20))
> > +#define UART_TX_W_POINT(x) (0x44 + (x * 0x20))
> > +#define UART_TX_SDMA_ADDR(x) (0x48 + (x * 0x20))
> > +#define UART_RX_R_POINT(x) (0x50 + (x * 0x20))
> > +#define UART_RX_W_POINT(x) (0x54 + (x * 0x20))
> > +#define UART_RX_SDMA_ADDR(x) (0x58 + (x * 0x20))
> 
> Please use a tab to line these up.

Also x should be surrounded by parentheses

#define UART_TX_R_POINT(x)	(0x40 + ((x) * 0x20))

etc...
