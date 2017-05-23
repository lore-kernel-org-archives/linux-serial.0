From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 1/1] xilinx ps uart: Adding a kernel parameter for the
 number of xilinx ps uarts
Date: Tue, 23 May 2017 13:44:24 +0200
Message-ID: <1668f36e-f9be-7008-004a-e467a6813e0f@xilinx.com>
References: <20170520022154.6766-1-kernel.development@povil.us>
 <20170520172008.5a979e8a@alans-desktop>
 <517d864d-d230-3abc-eb3c-4b628dc4625f@xilinx.com>
 <20170522192636.5b578d89@alans-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170522192636.5b578d89@alans-desktop>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>
Cc: Sam Povilus <kernel.development@povil.us>, gregkh@linuxfoundation.org, jslaby@suse.com, soren.brinkmann@xilinx.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 22.5.2017 20:26, Alan Cox wrote:
>> We have in soc vendor tree similar patch but the reason is different.
>>
>>     tty: serial: Added a CONFIG_SERIAL_XILINX_NR_UARTS option.
>>
>>     This patch Adds CONFIG_SERIAL_XILINX_NR_UARTS option to allow
>>     the user to provide the Max number of uart ports information.
>>     If multiple cards (or) PL UARTS are present, the default limit
>>     of 2 ports should be increased.
>>
>> I haven't checked all drivers but in our case we have added this as
>> quick fix for scenarios where you use serial aliases where alias is
>> pointed to serial2 or more.
>> In cdns_uart_init() cdns_uart_uart_driver is passed which contains .nr
>> which is required to be passed.
>>
>> What's the best driver to look at dynamic allocation?
> 
> So there are quite a few that dynamically allocate the objects as they
> are enumerated (eg max3100), but have a maximum set that is just pointers
> (so for the max number of ports cheaper than the dynamic code)

yep hardcoded max 4 where in probe first free space is found and used
(range 0-3) but still max3100s statically allocated.
Shouldn't be this also dynamically allocated?


> The other question is why is it a CONFIG_ option. I'm assuming these
> platforms are all ARM and in that case you could just pass the value in
> the device tree, or hard code a safe maximum number of pointers to a
> value which is the worst case and then install them as they are
> enumerated.

I am not quite sure how exactly you want to do this via DT.

Also what do you think is a safe maximum number? This is fpga - hundreds
of pins which can do just uart.

> There are lots of options better than breaking the "one kernel many
> platforms" model.

Another options is also module parameter and dynamically allocated array
in cdns_uart_init.

Thanks,
Michal
