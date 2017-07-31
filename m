From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [RFC PATCH 1/4] serial: uartps: Remove console_initcall from the
 driver
Date: Mon, 31 Jul 2017 09:37:17 +0200
Message-ID: <f239a211-2a9d-f0ab-5295-a87355036877@xilinx.com>
References: <cover.1500629544.git.michal.simek@xilinx.com>
 <bd75a2ab5838ae1cf44af667e24be2f02c2e9f3c.1500629544.git.michal.simek@xilinx.com>
 <20170721154720.ifjsn3og6apqi7mv@xsjsorenbubuntu.xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170721154720.ifjsn3og6apqi7mv@xsjsorenbubuntu.xilinx.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 21.7.2017 17:47, Sören Brinkmann wrote:
> On Fri, 2017-07-21 at 11:32:24 +0200, Michal Simek wrote:
>> register_console() is called from
>> uart_add_one_port()->uart_configure_port()
>> that's why register_console() is called twice.
>>
>> This patch remove console_initcall to call register_console() only from
>> one location.
>>
>> Also based on my tests cdns_uart_console_setup() is not called
>> from the first register_console() call.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>> I am not quite sure about this because console_initcall is called
>> early but I can see any difference in usage.
>> pl011 is not calling this but others are doing it.
> 
> Doesn't this break early console/printk? I would expect that the UART
> initialization may happen later than console init.

as I said. I can't see any issue with it. Definitely please try.

Thanks,
Michal
