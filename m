From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 2/3] serial: xuartps: Enable OF earlycon support
Date: Thu, 18 Feb 2016 09:01:36 +0100
Message-ID: <56C57A60.4070600@xilinx.com>
References: <67c9013fc61f53515934b54847a05df8b8e1504a.1455552315.git.michal.simek@xilinx.com>
 <23ab10a19b21df2ef17a5bb6ce2a70d2d3fd3551.1455552315.git.michal.simek@xilinx.com>
 <56C34F65.1040506@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <56C34F65.1040506@hurleysoftware.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Hurley <peter@hurleysoftware.com>, Michal Simek <michal.simek@xilinx.com>, linux-arm-kernel@lists.infradead.org, Arnd
 Bergmann <arnd@arndb.de>, Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: monstr@monstr.eu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>
List-Id: linux-serial@vger.kernel.org

Hi Peter,

On 16.2.2016 17:33, Peter Hurley wrote:
> Hi Michal,
> 
> On 02/15/2016 08:05 AM, Michal Simek wrote:
>> Support early console setup via DT for all listed compatible strings.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>>  drivers/tty/serial/xilinx_uartps.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
>> index 009e0dbc12d2..6f5657766815 100644
>> --- a/drivers/tty/serial/xilinx_uartps.c
>> +++ b/drivers/tty/serial/xilinx_uartps.c
>> @@ -1094,6 +1094,9 @@ static int __init cdns_early_console_setup(struct earlycon_device *device,
>>  	return 0;
>>  }
>>  EARLYCON_DECLARE(cdns, cdns_early_console_setup);
>> +OF_EARLYCON_DECLARE(cdns_a, "xlnx,xuartps", cdns_early_console_setup);
>> +OF_EARLYCON_DECLARE(cdns_b, "cdns,uart-r1p8", cdns_early_console_setup);
>> +OF_EARLYCON_DECLARE(cdns_c, "cdns,uart-r1p12", cdns_early_console_setup);
> 
> Earlycon now shares a common framework in linux-next.
> 
> The EARLYCON_DECLARE() can be deleted and the OF_EARLYCON_DECLARE()
> can all share the same earlycon name. iow,
> 
> -EARLYCON_DECLARE(cdns, cdns_early_console_setup);
> +OF_EARLYCON_DECLARE(cdns, "xlnx,xuartps", cdns_early_console_setup);
> +OF_EARLYCON_DECLARE(cdns, "cdns,uart-r1p8", cdns_early_console_setup);
> +OF_EARLYCON_DECLARE(cdns, "cdns,uart-r1p12", cdns_early_console_setup);

I have sent v2 and I have tested it. All looks good. Thanks for pointing
me to that change.
BTW: Is it normal that when earlycon support is enabled that the bootlog
is copied again? All what was printed before bootconsole [xxx] disabled
is printed twice. Or is this just bug in our driver?

Thanks,
Michal
