From: Tony Prisk <linux@prisktech.co.nz>
Subject: Re: [PATCH] serial: vt8500: fix possible memory leak in
 vt8500_serial_probe()
Date: Mon, 08 Oct 2012 14:03:17 +1300
Message-ID: <1349658197.19350.5.camel@gitbox>
References: <CAPgLHd9NrFCsp5NhjBJ4tYgY3-SfbTA-ps=rZgpmoywM6tX6KQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPgLHd9NrFCsp5NhjBJ4tYgY3-SfbTA-ps=rZgpmoywM6tX6KQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: gregkh@linuxfoundation.org, devicetree-discuss@lists.ozlabs.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, yongjun_wei@trendmicro.com.cn, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alan@linux.intel.com
List-Id: linux-serial@vger.kernel.org

On Mon, 2012-10-08 at 08:47 +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> vt8500_port is malloced in vt8500_serial_probe() and should be freed
> before leaving from the error handling cases, otherwise it will
> cause memory leak.
> 
> dpatch engine is used to auto generate this patch.
> (https://github.com/weiyj/dpatch)
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/tty/serial/vt8500_serial.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
> index 205d4cf..43fc369 100644
> --- a/drivers/tty/serial/vt8500_serial.c
> +++ b/drivers/tty/serial/vt8500_serial.c
> @@ -584,13 +584,16 @@ static int __devinit vt8500_serial_probe(struct platform_device *pdev)
>  					sizeof(vt8500_ports_in_use));
>  	}
>  
> -	if (port > VT8500_MAX_PORTS)
> -		return -ENODEV;
> +	if (port > VT8500_MAX_PORTS) {
> +		ret = -ENODEV;
> +		goto err;
> +	}
>  
>  	/* reserve the port id */
>  	if (test_and_set_bit(port, &vt8500_ports_in_use)) {
>  		/* port already in use - shouldn't really happen */
> -		return -EBUSY;
> +		ret = -EBUSY;
> +		goto err;
>  	}
>  
>  	vt8500_port->uart.type = PORT_VT8500;
> 

You are correct - this is an error but wouldn't it be better to simply
move the allocation of vt8500_port after these test since it's not used
until later.

It would save two possible instances of having to alloc/release a block
of memory that is never used and possibly create unnecessary memory
fragmentation.

Either way, this patch fixes the problem, so you can add my Ack'd if my
suggestion is considered nit-picky.

Acked-by: Tony Prisk <linux@prisktech.co.nz>


Regards
Tony P
