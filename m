From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 1/1] xilinx ps uart: Adding a kernel parameter for the
 number of xilinx ps uarts
Date: Mon, 22 May 2017 09:02:34 +0200
Message-ID: <517d864d-d230-3abc-eb3c-4b628dc4625f@xilinx.com>
References: <20170520022154.6766-1-kernel.development@povil.us>
 <20170520172008.5a979e8a@alans-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170520172008.5a979e8a@alans-desktop>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Sam Povilus <kernel.development@povil.us>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Alan,

On 20.5.2017 18:20, Alan Cox wrote:
> On Fri, 19 May 2017 20:21:54 -0600
> Sam Povilus <kernel.development@povil.us> wrote:
> 
>> The number of xilinx ps uart should be set by a kernel parameter instead of
>> using a #define. This allows the user to set the number of xilinx ps uart
>> using only kconfig and not modifying kernel source.
>>
>> The ps uart is used in Xilnx Zynq chips usually in quantities maxing at
>> two, but there may be other chips that use more in the future or that I
>> don't know about. 
> 
> If it maxes at two then just set it to two. If in in future it maxes at
> lots then when it's going to happen change the code to do dynamic
> allocation and test it versus actual hardware. 
> 
> Otherwise you break some of the basic ideas of having one kernel for many
> systems.


We have in soc vendor tree similar patch but the reason is different.

    tty: serial: Added a CONFIG_SERIAL_XILINX_NR_UARTS option.

    This patch Adds CONFIG_SERIAL_XILINX_NR_UARTS option to allow
    the user to provide the Max number of uart ports information.
    If multiple cards (or) PL UARTS are present, the default limit
    of 2 ports should be increased.

I haven't checked all drivers but in our case we have added this as
quick fix for scenarios where you use serial aliases where alias is
pointed to serial2 or more.
In cdns_uart_init() cdns_uart_uart_driver is passed which contains .nr
which is required to be passed.

What's the best driver to look at dynamic allocation?

Thanks,
Michal
