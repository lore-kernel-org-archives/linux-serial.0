From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/3] tty/serial: atmel_serial: __devinit_p for probe
	function
Date: Mon, 3 Oct 2011 09:50:29 +0100
Message-ID: <20111003085029.GA11710@n2100.arm.linux.org.uk>
References: <b371e80a96a36d962fb8806c2bd7aa20bb688b88.1317634987.git.nicolas.ferre@atmel.com>
	<cd489c1d28c26624d6b68399d222aec371045e53.1317634987.git.nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <cd489c1d28c26624d6b68399d222aec371045e53.1317634987.git.nicolas.ferre@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-kernel@vger.kernel.org, plagnioj@jcrosoft.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alan@linux.intel.com
List-Id: linux-serial@vger.kernel.org

On Mon, Oct 03, 2011 at 11:46:16AM +0200, Nicolas Ferre wrote:
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  drivers/tty/serial/atmel_serial.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index a652f8f..453cdb5 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -1789,7 +1789,7 @@ static int __devexit atmel_serial_remove(struct platform_device *pdev)
>  }
>  
>  static struct platform_driver atmel_serial_driver = {
> -	.probe		= atmel_serial_probe,
> +	.probe		= __devexit_p(atmel_serial_probe),

That doesn't match the patch description (and is probably wrong.)
