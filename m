From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] serial: imx: Fix suspend / resume.
Date: Tue, 12 Jan 2016 20:41:50 +0200
Message-ID: <569548EE.8050608@ti.com>
References: <20160104182206.10852.47155.stgit@localhost>
 <20160104191014.GN19062@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160104191014.GN19062@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Martin Fuzzey <mfuzzey@parkeon.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Russell,

On 01/04/2016 09:10 PM, Russell King - ARM Linux wrote:
> On Mon, Jan 04, 2016 at 07:22:06PM +0100, Martin Fuzzey wrote:
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index 016e4be..16a551b 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -2071,13 +2071,13 @@ static int imx_serial_port_suspend_noirq(struct device *dev)
>>   	struct imx_port *sport = platform_get_drvdata(pdev);
>>   	int ret;
>>   
>> -	ret = clk_enable(sport->clk_ipg);
>> +	ret = clk_prepare_enable(sport->clk_ipg);
>>   	if (ret)
>>   		return ret;
>>   
>>   	serial_imx_save_context(sport);
>>   
>> -	clk_disable(sport->clk_ipg);
>> +	clk_disable_unprepare(sport->clk_ipg);
> 
> NAK.  If this is _noirq, then it's a context which can't sleep.  Therefore,
> calling functions that do sleep is not permitted.

That's not not exactly correct. At suspend_noirq time only SPI(device's) IRQs are disabled
while syscore (systimers, scheduler, main irq controllers, nonboot cpus) is still active.

-- 
regards,
-grygorii
