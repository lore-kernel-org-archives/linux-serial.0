From: Jason Wessel <jason.wessel@windriver.com>
Subject: Re: [PATCH] serial: Add CONSOLE_POLL support for
	uartlite
Date: Tue, 10 Aug 2010 06:48:26 -0500
Message-ID: <4C613C8A.1050600@windriver.com>
References: <1281348452-26924-1-git-send-email-monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kgdb-bugreport-bounces@lists.sourceforge.net>
In-Reply-To: <1281348452-26924-1-git-send-email-monstr@monstr.eu>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport>,
	<mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kgdb-bugreport>
List-Post: <mailto:kgdb-bugreport@lists.sourceforge.net>
List-Help: <mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport>,
	<mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=subscribe>
Errors-To: kgdb-bugreport-bounces@lists.sourceforge.net
To: Michal Simek <monstr@monstr.eu>
Cc: grant.likely@secretlab.ca, jacmet@sunsite.dk, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, KGDB Mailing List <kgdb-bugreport@lists.sourceforge.net>
List-Id: linux-serial@vger.kernel.org

On 08/09/2010 05:07 AM, Michal Simek wrote:
> CONSOLE_POLL support for uartlite enables
> KGDB debugging over serial line.
> 
> Signed-off-by: Michal Simek <monstr@monstr.eu>
> ---
>  drivers/serial/uartlite.c |   26 +++++++++++++++++++++++++-
>  1 files changed, 25 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/serial/uartlite.c b/drivers/serial/uartlite.c
> index caf085d..ce1f3e0 100644
> --- a/drivers/serial/uartlite.c
> +++ b/drivers/serial/uartlite.c
> @@ -322,6 +322,26 @@ static int ulite_verify_port(struct uart_port *port, struct serial_struct *ser)
>  	return -EINVAL;
>  }
>  
> +#ifdef CONFIG_CONSOLE_POLL
> +static int ulite_get_poll_char(struct uart_port *port)
> +{
> +	while (!(ioread32be(port->membase + ULITE_STATUS)
> +						& ULITE_STATUS_RXVALID))
> +		cpu_relax();
> +
> +	return ioread32be(port->membase + ULITE_RX);
> +}



After kdb was merged, the CONSOLE_POLL API had a subtle change where
all I/O drivers should return immediately with a return of
NO_POLL_CHAR in order to allow more than one I/O driver to operate in
the same poll loop.


The patch should look like the following for the get_poll_char.

+static int ulite_get_poll_char(struct uart_port *port)
+{
+	if (!(ioread32be(port->membase + ULITE_STATUS)
+	    & ULITE_STATUS_RXVALID))
+		return NO_POLL_CHAR;
+
+	return ioread32be(port->membase + ULITE_RX);
+}


If you agree to the change you can add my SOB.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>

Cheers,
Jason.


------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
