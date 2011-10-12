From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [RFC PATCH] tty/serial: atmel_serial: add device tree support
Date: Wed, 12 Oct 2011 17:35:06 +0200
Message-ID: <4E95B3AA.9040603@atmel.com>
References: <1317635502-9430-1-git-send-email-nicolas.ferre@atmel.com>
	<4E8A6858.6020700@gmail.com>
	<20111004165226.GA10919@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20111004165226.GA10919@ponder.secretlab.ca>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alan@linux.intel.com
List-Id: linux-serial@vger.kernel.org

On 10/04/2011 06:52 PM, Grant Likely :
> On Mon, Oct 03, 2011 at 08:58:48PM -0500, Rob Herring wrote:
>> On 10/03/2011 04:51 AM, Nicolas Ferre wrote:
>>>  static int __devinit atmel_serial_probe(struct platform_device *pdev)
>>>  {
>>>  	struct atmel_uart_port *port;
>>> +	struct device_node *np = pdev->dev.of_node;
>>>  	struct atmel_uart_data *pdata = pdev->dev.platform_data;
>>>  	void *data;
>>>  	int ret;
>>>  
>>>  	BUILD_BUG_ON(ATMEL_SERIAL_RINGSIZE & (ATMEL_SERIAL_RINGSIZE - 1));
>>>  
>>> -	port = &atmel_ports[pdata->num];
>>> +	if (np) {
>>> +		ret = of_alias_get_id(np, "serial");
>>> +		if (ret < 0)
>>> +			goto err;
>>
>> I'll defer to Grant on this. There aren't any other drivers using this.
>>
> 
> This is the correct thing to do.
> 
> One note however; I prefer driver to *not* require an alias to be
> present.  By all means, use an alias if it is available, but the
> driver should auto-enumerate if it is not.  There is a patch that
> makes of_alias_get_id() do this for you, but it hasn't been mainlined
> yet and it is still a bit in flux.  There will be something that takes
> care of this for you, but be aware that the function name may change.
> 
> In the mean time, this patch is okay.
> 
> Acked-by: Grant Likely <grant.likely@secretlab.ca>

Grant,

I have reworked this atmel_serial device tree support so I did not add
your "Acked-by" to this new series. I repost it right now.
I hope this new implementation will be even better though ;-)

Bye,
-- 
Nicolas Ferre
