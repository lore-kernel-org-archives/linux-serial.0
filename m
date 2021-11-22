Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A033C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 22 Nov 2021 22:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbhKVWIc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Nov 2021 17:08:32 -0500
Received: from mailnode.rz.hs-mannheim.de ([141.19.1.96]:44464 "EHLO
        hs-mannheim.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231256AbhKVWIc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Nov 2021 17:08:32 -0500
Received: from [176.199.208.88] (account willenberg@hs-mannheim.de HELO [192.168.0.240])
  by hs-mannheim.de (CommuniGate Pro SMTP 6.2.14)
  with ESMTPSA id 55699902; Mon, 22 Nov 2021 23:05:23 +0100
Message-ID: <91aa574a-c668-ae4b-e560-211b9bd6580f@hs-mannheim.de>
Date:   Mon, 22 Nov 2021 23:05:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2] uartlite: Update the default for the
 SERIAL_UARTLITE_NR_UARTS
To:     Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        linux-serial@vger.kernel.org
Cc:     git@xilinx.com, gregkh@linuxfoundation.org
References: <20211117051635.1316958-1-shubhrajyoti.datta@xilinx.com>
 <edf15265-548a-1315-9175-967dddb38d4b@hs-mannheim.de>
 <82ee1522-da4b-9fc6-bcf5-ceb94e307f96@xilinx.com>
 <e01371cd-de45-cf9d-191a-c088df43566a@hs-mannheim.de>
 <74bba210-dcf9-233b-e700-ffb61f9b5b22@xilinx.com>
From:   Ruediger Willenberg <r.willenberg@hs-mannheim.de>
In-Reply-To: <74bba210-dcf9-233b-e700-ffb61f9b5b22@xilinx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Am 19.11.2021 um 11:21 schrieb Michal Simek:
> 
> 
> On 11/18/21 22:21, Ruediger Willenberg wrote:
>> Am 18.11.2021 um 09:45 schrieb Michal Simek:
>>> On 11/17/21 10:53, Ruediger Willenberg wrote:
>>>> Am 17.11.2021 um 06:16 schrieb Shubhrajyoti Datta:
>>>>> "The uartlite is used by FPGAs that support a basically unlimited number
>>>>> of uarts so limiting it at 16 dosn't make sense as users might need more
>>>>> than that."
>>>>>
>>>>> So change the default number of uarts back to 16.
>>>>
>>>> The DTG should number devices for each driver separately from 0;
>>>> serial_core.c checks for (0 <= uart_port->line < NR_UART_PORTS). As a
>>>> consequence, when a Zynq system has both a PS-UART and a Uartlite,
>>>> setting SERIAL_UARTLITE_NR_UARTS explicitly to 1 in Kconfig means
>>>> probing the uartlite fails, which is confusing to the unsuspecting
>>>> KConfig user. Setting the default to 16 just kicks the can down the
>>>> road because it will fail for more than 15 Uartlites (or less, if there
>>>> are more PS-UARTs or AXI 16550A UARTs).
>>>
>>> I have no problem with your patch and it is correct (I would prefer a message to show for this 
>>> option). But it doesn't mean that default 1 was correct value to setup especially when range was 
>>> setup by Sam from 1-256. And originally number 16 was used.
>>
>>> That's why I think this patch is still valid. If you don't like description it can be changed 
>>> because definitely people are using systems with more then one uartlite and 1 is not reasonable 
>>> default.
>>> We can also take a look at default for others serial drivers
>>> and none of them is using 1 as default. IIRC discussion about UARTPS it was said if number is not 
>>
>>
>> Clarification: I support changing the default up to 16. It will avoid problems for most cases where
>> a) there are only a few Uartlites in the system
>> AND
>> b) the Kconfig user doesn't explictly specify SERIAL_UARTLITE_NR_UARTS
>>
>> I just wanted to point out that trouble ensues when
>> a) somebody wants 16 Uartlites in a system when there is also a PS UART (basically any Zynq)
>> OR
>> b) somebody explicitly sets the SERIAL_UARTLITE_NR_UARTS to the number she built into a Zynq system
>> (when the Uartlite driver is activated in menuconfig, the NR parameters pops right up, so it's 
>> mighty tempting to actually set it to the accurate number)
>>
>> Moving the default up should just not be a band-aid for the cases where a single Uartlite can not 
>> be assigned, when really there is a fundamental inconsistency between how serial_core.c has 
>> limited line numbering since Kernel 2.6 (0 <= line_id < NR_UARTs) and what Xilinx DTG does with 
>> UARTs.
>>
>>
>>  > And using aliases for serial id identification is around for a while and Xilinx DTG is aligned 
>> with
>>  > it because via current dt you can't describe cases where you will have stable numbers for 
>> different
>>  > tty names like
>>  > ttyS0, ttyUL0, ttyPS0, ttyAMA0, etc.
>>  > That's why DTG generates it per all serial IDs.
>>
>> Sincere apologies, I do not quite understand this explanation/argument. Would you be so kind to 
>> rephrase?
>>
>> (As I'm a newbie to this list, I'm not sure how much back-and-forth is appropriate about a topic. 
>> Since my issue here is about the Xilinx DTG, not Linux kernel code per se, I'd also be fine to 
>> continue emailing off-list. There does not seem to be a similar list for device-tree-xlnx)
> 
> A lot of drivers are calling of_alias_get_id() which returns you ID from aliases list. If you don't 
> use it or ID is more then your amount of allocates ports you are choosing different logic how to 
> find proper number.
> 
> In for example arch/arm/boot/dts/at91-kizbox3_common.dtsi
> you can see
> 
>   24         aliases {
>   25                 serial0 = &uart0;
>   26                 serial1 = &uart1;
>   27                 serial2 = &uart2;
>   28                 serial3 = &uart3;
>   29                 serial4 = &uart4;
>   30                 serial5 = &uart5;
>   31                 serial6 = &uart8;
>   32         };
> 
> It means uart0 should become ttyX0 uart1 should become ttyX1, etc
> If you have all uarts the same type then everything is fine.
> 
> But on systems like FPGAs you have different types of uart and via DT you can't really describe 
> things like this
>      aliases {
>              serial0 = &ps_uart; // to become ttyPS0
>              serial0 = &uartlite; // to become ttyUL0
>              serial0 = &uart16550; // to become ttyS0
>              serial0 = &uartAMA; // to become ttyAMA0
>          ...
>      }
> 
> This is not allowed in DT. You can have only one alias with the same ID.
> And if you don't use aliases order depends on probe order which doesn't need to be stable.
> If you have only one instance of IP then you will get just id 0 but if you have multiple instances 
> of the same IP type then order is unpredictable. And you really don't want to assigned console to 
> data uart channel and vice-versa or mix channels, etc.
> 
> That's why Xilinx DTG assigns number to every IP to be stable and predictable. A lot of people think 
> that what you get from DTG doesn't need to be changed but that's not intention of DTG at all. DTG 
> just does the best to describe the system. It is up to user to do whatever changes are required for 
> their system. If you don't like it feel free to change/fix it.
> 
> And in past port-number property was in spec but it not supported by all drivers.
> I think we have also generated it for 16550 xilinx uart in past.
> 
> Thanks,
> Michal

Thank you Michal for kindly taking the time to explain this in detail, that was very helpful.

I've now looked at this more closely and experimented with different combinations of ps_uart, AXI 
Uartlite, mdm_uart and AXI UART16550A. Relevant observations (Michal you'll know most of this):

1. The Xilinx DTG adds the "port-number" property to all Zynq/Zynq-US Cadence UARTs, AXI Uartlite, 
mdm_uart and AXI UART16550A (it's only documented so far in the DT-binding file for uartlite)

2. The current "port-number" mechanism in the Xilinx DTG enumerates in the order in which they are 
listed in the MSS file generated by proprietary Xilinx binaries, be it Vitis/XSCT or 
petalinux-config. The only exception is when the MSS file declares a UART the OS serial_console, 
then that one gets 0 and everyone else follows (this is required because the DTG also always sets 
the kernel bootarg for console to ttyPS_0_ , ttyUL_0_ , etc.)

3. For one type of driver (uartps, uartns, uartlite), the Xilinx binaries list the UARTs in the MSS 
file strictly alphabetically by HW_INSTANCE name (that's even true if I mix AXI Uartlites and 
mdm_uarts, which both use the uartlite driver). So the port-numbers follow strictly (with the 
console exception) and reproducibly.

4. The Xilinx DTG gives "serial" aliases to _all_ said UARTs, however the order is different than 
the port-numbers/the MSS order:

4.1. ps_uarts (and I suppose other cadence uarts) come first; if ps_uart1 is declared console in the 
MSS, it gets "serial0", even if there is ps_uart0, which then gets "serial1".

4.2. other UARTs get higher serial aliases, however the order can mix UARTs of different drivers, 
like Uartlite and AXI16550. This order is not based on MSS, memory addresses, instance names or even 
order added or interconnect ports in the Vivado Block Design. It is intransparent to me even after 
looking at devicetree.tcl and seems to change with different combinations of PL UARTs

4.3. even if I declare a Uartlite as the boot console for both u-boot and the Linux kernel in the 
PetaLinux menuconfig, "serial0" still goes to the ps_uart (that uartlite becomes the first other 
serial*, though). This is unfortunate because the early bootarg is "serial0:115200n8", so all the 
early kernel output still goes out over the ps_uart against the configuration.


Lastly I would like to observe that the patch I sent in to git@xilinx.com for the Xilinx DTG
a) preserves the port-numbering in MSS order for each driver type (uartps, uartns, uartlite)
b) preserves the special port-number=<0> treatment for the UART declared the OS console
but
c) enumerates up consecutively from 0 per driver (uartps,uartns,uartlite), therefore fixing the 
allocation issue brought into focus by the introduction of the SERIAL_UARTLITE_NR_UARTS parameter to 
the kernel. The order is reliable and reproducible because it is dependent on the MSS structure. The 
same is not true for the "serial" alias.

Michal, as you have kindly explained above, there cannot be serial aliases with the same number, and 
in combination with the unpredictable numbering of non-cadence uarts, the "serial" alias mechanism 
is unsuitable right now to properly deal with multiple UART types which will pop up in FPGA systems.


I therefore respectfully urge Xilinx to adopt my DTG patch. It does not break anything and keeps 
numbering as reliable as it is right now, but it fixes the inconsistency with kernel numbering policy.


Since Xilinx tool and Linux kernel development are not synced-up, changes on either side should not 
break the other; the DTG patch does not break the Linux side. The /tty/serial/uartlite.c patch that 
we are discussing in the separate thread
  "[PATCH v2] serial: uartlite: Move out-of-range port-numbers into ULITE_NR_UARTS range"
is a fix for what the DTG does right now, but does not break with either version.

Best wishes and thanks for your time,
Ruediger
