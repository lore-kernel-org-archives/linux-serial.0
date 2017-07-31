From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [RFC PATCH 0/4] serial: uartps: Dynamic allocation
Date: Mon, 31 Jul 2017 09:42:47 +0200
Message-ID: <068fcae4-64ff-b9cd-17ed-2803e6d6ef7b@xilinx.com>
References: <cover.1500629544.git.michal.simek@xilinx.com>
 <20170728193952.1f85073f@alans-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170728193952.1f85073f@alans-desktop>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 28.7.2017 20:39, Alan Cox wrote:
> On Fri, 21 Jul 2017 11:32:23 +0200
> Michal Simek <michal.simek@xilinx.com> wrote:
> 
>> Hi Alan,
>>
>> this is the initial version before next step which is move
>> uart_register_driver to probe function.
>> I was able to get rid of static array with uart_port structures.
>> It was wired with console which is also fixed.
>> And the next step is the most complicated one handle .nr in uart_driver
>> structure in more generic way.
>>
>> Thanks,
>> Michal
> 
> Sorry for the delay been on jury service

np at all.
Do you have any suggestion how to do the last step?


> 
> Series
> 
> Reviewed-by: Alan Cox <alan@linux.intel.com>
> 

Thanks,
Michal
