From: Dave P Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH 00/10] drivers: PL011: add ARM SBSA Generic UART support
Date: Tue, 20 Jan 2015 14:32:54 +0000
Message-ID: <20150120143254.GB17657@e103592.cambridge.arm.com>
References: <1421428986-11300-1-git-send-email-andre.przywara@arm.com>
 <20150120130832.GA6858@xora-yoga-13.xora.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20150120130832.GA6858@xora-yoga-13.xora.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Graeme Gregory <gg@slimlogic.co.uk>
Cc: "rob.herring@linaro.org" <rob.herring@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "arnd@arndb.de" <arnd@arndb.de>, Andre Przywara <Andre.Przywara@arm.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jslaby@suse.cz" <jslaby@suse.cz>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Jan 20, 2015 at 01:08:32PM +0000, Graeme Gregory wrote:

[...]

> I have tested this series on Juno where it seems to work and also on FVP
> model where there are some issues.
> 
> On the FVP when we enter usespace a couple of 32 character strings are
> printed then nothing else. 32 Characters is a suspicious number.
> 
> This occurs with both OE based FS from linaro and debian ubstable FS.
> 
> My FVP is version 5602

Can you try this:

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index eb397c7..9ca78db 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1291,6 +1291,7 @@ static void pl011_tx_chars(struct uart_amba_port *uap)
 		writew(uap->port.x_char, uap->port.membase + UART01x_DR);
 		uap->port.icount.tx++;
 		uap->port.x_char = 0;
+		BUG_ON(uap->tx_avail < 1);
 		uap->tx_avail--;
 		return;
 	}


If we can hit that BUG_ON, then it's possible tx_avail is wrapping round
here, though I'm not sure if it is likely to occur in practice.

I'll have a look for other potential issues...

Cheers
---Dave
