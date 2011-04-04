From: Michal Simek <monstr@monstr.eu>
Subject: Re: Microblaze early console support
Date: Mon, 04 Apr 2011 19:21:58 +0200
Message-ID: <4D99FE36.1070307@monstr.eu>
References: <1301934655-20495-1-git-send-email-monstr@monstr.eu>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1301934655-20495-1-git-send-email-monstr@monstr.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <monstr@monstr.eu>
Cc: linux-kernel@vger.kernel.org, john.williams@petalogix.com, Russell King <linux@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Ingo Molnar <mingo@redhat.com>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-serial@vger.kernel.org

resent.

M

Michal Simek wrote:
> Hi,
> 
> I have one question about early console support on MMU kernel.
> When do you register an early console and what TLB mapping you use?
> 
> For Microblaze I registered it before main memory is setup that's why I was
> hardcoded TLB 63 to 1:1 mapping (virt addr = phys addr). 
> It is output only for early_printk messages but I would like to use it 
> as boot console. There are only some messages that's why TLB 63 was released
> later on.
> That is the current state.
> 
> I have added CON_BOOT flag and register early console by register_console function
> and I allocate TLB 63 for it. But unfortunately I haven't found any function 
> in unregister_console which is called for unregistering to help me to release TLB 63
> when early console is not used. Is there any way how to do it?
> 
> From our experiment in past there is performance degression when kernel can't use
> a TLB that's why I tried to find out a way to release TLB 63.
> This is the reason why I would like to know your opinion if my style is correct 
> or not.
> I created new remap_early_printk function which does ioremap for console space.
> This function is called from setup_arch when memory is setup. Then early mapping of TLB 63
> is automatically released and can be used for Linux purpose.
> Is it correct design how to do it?
> 
> How do you handle it in your arch? Do you register early console before memory initialization
> is done?
> 
> You can also look at my patch I have done.
> 
> Thanks for your suggestions,
> Michal

-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
