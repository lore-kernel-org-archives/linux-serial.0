From: Matthew Locke <mlocke@mvista.com>
Subject: Re: serial.c fix: ELAN fix breaks others
Date: Tue, 17 Dec 2002 18:58:04 -0800
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <3DFFE43C.4040206@mvista.com>
References: <11E89240C407D311958800A0C9ACF7D1A33D01@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: Ed Vance <EdV@macrolink.com>
Cc: 'Rusty Russell' <rusty@rustcorp.com.au>, Russell King <rmk@arm.linux.org.uk>, 'linux-serial' <linux-serial@vger.kernel.org>

Ed Vance wrote:

>On Mon, December 16, 2002 at 6:18 PM, Matthew Locke wrote:
>
>>Ed Vance wrote:
>>
>>>>From: Matthew Locke [mailto:mlocke@mvista.com]
>>>>
>>>On Mon, December 16, 2002 at 4:29 PM, Matthew Locke wrote:
>>>
>>>>Ed Vance wrote:
>>>>
>>>>>[ snip ]
>>>>>
>>>>>I avoided the #ifdef by applying the workaround only to 
>>>>>UARTs detected as the "simple" types. The AMD Elan's UARTs 
>>>>>detect as type 16550A. I don't know (yet) of any "simple" 
>>>>>UARTs that misbehave when exposed to the Elan work-around. 
>>>>>See the comments above the patch.
>>>>>
>>>>Ed,
>>>>
>>>>I think I have one.  In general I would prefer not to include 
>>>>workarounds for unaffected platforms.  In the embedded world, 
>>>>I always seem to run into the platform on which these 
>>>>workarounds cause problems:(  Can we add:
>>>>
>>>>#ifndef CONFIG_MELAN
>>>>define uart_transmit_ready 0
>>>>#endif
>>>>
>>>>to your patch?
>>>>
>>>Hi Matthew,
>>>
>>>Of course, I would prefer not to introduce an #ifdef that is 
>>>not necessary. However, running properly on the Elan platform 
>>>already requires rebuilding the kernel with CONFIG_MELAN 
>>>defined to express Elan specific kernel code. So, use of the 
>>>define in the serial driver would not cause anybody an extra 
>>>build step ... 
>>>
>>>If we have to introduce an #ifdef to get correct function on 
>>>unbroken hardware, then we should. Of course, we would want 
>>>to follow the coding guidelines about where to hide the #ifdef. 
>>>
>>>Please tell me:
>>>
>>>What UART flavor are you jousting with?
>>>
>>The TI OMAP on-chip 16650.
>>
>>>
>>>Which UART type does the serial driver detect?
>>>
>>Typically the serial driver doesn't "detect" the type for 
>>these on-chip devices.  Instead we pass in the type with 
>>the STD_SERIAL_PORT_DEFN defined in the arch code.  This 
>>one is a 16650 with a few special tweaks for OMAP.  So we 
>>setup a PORT_OMAP port type and guarantee the new type is 
>>greater than PORT_16550A.  However, I'm still concerned 
>>about chips that will report < 16550A port types and may 
>>have problems with the work around.
>>
>>>
>>>What is the specific errant behavior?
>>>
>>The same as described in your comments-  dropped xmit data.
>>
>
>Hi Matthew,
>
>I read the TI OMAP UART doc. It says the UART type emulated by the 
>OMAP is 16750 (type 8), instead of 16650. Even 16650 (type 6) is 
>out of the range exposed to the work-around. It does not yet sound 
>like this is a type 1 - 4 UART that the work-around breaks. The 
>issue seems to pivot on the default types defined in 
>STD_SERIAL_PORT_DEFN. 
>
oh, good.

>
>
>I would at least like to preserve the work-around code on the x86 
>architecture so a vanilla x86 distro or rescue disk would boot and 
>be at least minimally usable on the Elan with a serial console.
>
Absolutely.

>
>
>Which kernel source should I download and look at so I would see the 
>same defs that you are working with? 
>
We are still working on moving OMAP to the lastest kernel and cleaning 
up the port.  I believe there a snapshot at ftp://source.mvista.com.

>
>
>(I'm not saying no to an #ifdef. I just don't think I have completed 
>the due diligence yet.)
>
ok.  I'm going to use your fix and see what happens on some of our 
boards with on-chip 16550's.

>
>
>Best regards,
>Ed
>
>---------------------------------------------------------------- 
>Ed Vance              edv (at) macrolink (dot) com
>Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
>----------------------------------------------------------------
>
>



