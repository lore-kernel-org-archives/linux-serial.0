Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284EF37704
	for <linux-serial@vger.kernel.org>; Mon, 19 Feb 2024 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359948; cv=none; b=avCj0WIsFCy8oHmPxmVfTjjdu3COaW5fRCLtNlrYBeXCFCME8UV434DkUbtWFADRzQeyAyj4tgSMP7i1dGN3DYrpI9Yk6qTH1cRGOXYuqzA0js8V6wcstXmX7HUIPnFJO4RsUnaHc7KKUhkNZyQ4/l6S4wKuA6BgietRTWYhHGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359948; c=relaxed/simple;
	bh=TtFFrywWrdSh3lvXdTDfdKtEV3KGhptpRqjPyv1EmkM=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=RPxFjcoV5k+IKmeTEIP+fiVcvjkqDPNkZhUSIlnRVM7jB5XXS+Ig7ickGhN1yNI/cVMOibzjtu1zOh95sdFi/Lf0WcJo4RW+xUsXLlFTht8n/H0IyUKHgE9n9IN/HwXUeWHo6cWUqC+n6Af1B1MyrchLu4bL4Nkag1oPYm/iwkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=JQgx5dYl; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="JQgx5dYl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=HDpZpP5Fu4PlY59K1reUsM4SfvwvFnxsxlICWpHiHlw=; b=JQgx5dYlBWqCHyHNAd9jvw51gj
	2UcErXq6jEgBIe1714gLjRW/4JbwJFEvyAKbR52cAALLvI0pFOMN91KiIf/+bzL/NrZoh18HKUbUg
	7qYWm803vOFIJC5HRHjc9P6dfkNRRFBjG77EqpO+tiPx4iD5gW8xe9a7IuMZ8yNJy2FI=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:48914 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rc6Ab-0003qU-N2; Mon, 19 Feb 2024 11:07:06 -0500
Date: Mon, 19 Feb 2024 11:07:05 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: "Nagarajan, Gnaneshwar" <gnaneshwar.nagarajan@cornelisnetworks.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 "Srinivasan, Usha" <usha.srinivasan@cornelisnetworks.com>
Message-Id: <20240219110705.15e25ca2e825546b16b73b7d@hugovil.com>
In-Reply-To: <DM6PR01MB4907F118F7EEDC8DEBFD8FBBF64E2@DM6PR01MB4907.prod.exchangelabs.com>
References: <DM6PR01MB4907F118F7EEDC8DEBFD8FBBF64E2@DM6PR01MB4907.prod.exchangelabs.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	* -1.3 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: max14830 nobody cared Disbling IRQ issue
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Wed, 14 Feb 2024 23:59:15 +0000
"Nagarajan, Gnaneshwar" <gnaneshwar.nagarajan@cornelisnetworks.com>
wrote:

> Hello Hugo
> 
> Thanks for your continued support. As a follow up to the thread: https://lore.kernel.org/all/BY5PR01MB5635C11E9BE2B105FB7B87A09E6C2@BY5PR01MB5635.prod.exchangelabs.com/, I would appreciate some help.

Hi,
see my comments inline below (and please also respond in line)...

> 
> We still see the following error with the max14830 interrupt handling:
> 
> [   88.430219] irq 57: nobody cared (try booting with the "irqpoll" option)
> [   88.437720] CPU: 0 PID: 65 Comm: irq/57-11-006c Not tainted 6.1.15-580639a #1
> [   88.445687] Hardware name: Generic DT based system
> [   88.451046]  unwind_backtrace from show_stack+0x18/0x1c
> [   88.456906]  show_stack from dump_stack_lvl+0x40/0x4c
> [   88.462556]  dump_stack_lvl from __report_bad_irq+0x44/0xc8
> [   88.468784]  __report_bad_irq from note_interrupt+0x2c8/0x314
> [   88.475208]  note_interrupt from handle_irq_event+0x90/0x94
> [   88.481436]  handle_irq_event from handle_level_irq+0xbc/0x1b4
> [   88.487952]  handle_level_irq from generic_handle_domain_irq+0x30/0x40
> [   88.495253]  generic_handle_domain_irq from aspeed_gpio_irq_handler+0xac/0x158
> [   88.503326]  aspeed_gpio_irq_handler from generic_handle_domain_irq+0x30/0x40
> [   88.511305]  generic_handle_domain_irq from gic_handle_irq+0x6c/0x80
> [   88.518411]  gic_handle_irq from generic_handle_arch_irq+0x34/0x44
> [   88.525316]  generic_handle_arch_irq from call_with_stack+0x18/0x20
> [   88.532328]  call_with_stack from __irq_svc+0x98/0xb0
> [   88.537973] Exception stack(0xbf925eb0 to 0xbf925ef8)
> [   88.543614] 5ea0:                                     45854088 00000003 00000001 00000000
> [   88.552742] 5ec0: 00000000 4184ee80 45854088 00000000 45854000 41a64140 00000000 00000000
> [   88.561870] 5ee0: 00000000 bf925f00 4016bb7c 4016bac0 600f0013 ffffffff
> [   88.569252]  __irq_svc from __wake_up_common_lock+0x1c/0xb8
> [   88.575483]  __wake_up_common_lock from __wake_up+0x20/0x28
> [   88.581714]  __wake_up from irq_thread+0x118/0x1ec
> [   88.587070]  irq_thread from kthread+0xd8/0xf4
> [   88.592040]  kthread from ret_from_fork+0x14/0x2c
> [   88.597288] Exception stack(0xbf925fb0 to 0xbf925ff8)
> [   88.602923] 5fa0:                                     00000000 00000000 00000000 00000000
> [   88.612053] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [   88.621179] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [   88.628559] handlers:
> [   88.631088] [<4f379e2c>] irq_default_primary_handler threaded [<26199d83>] max310x_ist
> [   88.639952] Disabling IRQ #57
> 
> 
> 
> *        Based on your comment to add commits 984a4afdc87a and c94e5baa989f, I brought in the two patches and sourced the tree per your suggestion.

It would be best if you test with this tree:

git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git

and use the branch named "tty-next".

> We still see the interrupts not being handled during the power-on
process and causes a system hang for approximately 2 minutes before
disabling the interrupt line. I also verified that the physical
interrupt line stays high with the use of a voltmeter.

Ok, so I assume that the line stays high at all times, not just after 2
minutes?

> 
> *        The Power-Up and IRQ# section in the Max 1830 makes mention of setting the IRQSel bit of MODE_1 register to enable normal IRQ# operation. I tried doing that but did not pay any dividends either.
> 
> o   During power-up or following a reset, IRQ# has a different function. It is held low until the MAX14830 is ready for programming following an initialization delay. Once IRQ# goes high, the MAX14830 is ready to be programmed. The MODE1[7]: IRQSel bit should then be set to enable normal IRQ# interrupt operation.

This is supposed to be done automatically by the driver in
max310x_probe(), so it should have no effect to redo it manually.

> 
> 
> *        We see this issue during the power-up process and the GLOBAL_IRQ register (0x1F) reads a value of 0xf indicating all the 4 ports generate interrupts but the subsequent ISR registers do not indicate any interrupts.
> 
> *         We currently have the 5 UART Multiplexers to operate in synchronized mode as depicted below:
> 
> [cid:image001.png@01DA5F76.05C46E70]
> 
> 
> 
> *        Our associated dts configuration looks as follows:
> 
> 
> 
> clocks {
> 
>         i2c_uart_clk: max14830_clk {
> 
>                 compatible = "fixed-clock";
> 
>                 #clock-cells = <0>;
> 
>                clock-frequency = <3686400>;
> 
>         };
> 
> };
> 
> 
> 
> 
> 
> &i2c11 {
> 
>         status = "okay";
> 
> 
> 
>         max148306c: max14830@6c {
> 
>                 compatible = "maxim,max14830";
> 
>                 reg = <0x6c>;
> 
>                 clocks = <&i2c_uart_clk>;
> 
>                 clock-names = "xtal";

Based on that (and clock-frequency property), I assume that your clock
is a crystal of 3.686400 MHz?

> 
>                 interrupt-parent = <&gpio0>;
> 
>                 interrupts = <ASPEED_GPIO(T, 0) IRQ_TYPE_LEVEL_LOW>;
> 
>                 gpio-controller;
> 
>                 #gpio-cells = <2>;
> 
>         };
> 
> 
> 
>         max1483061: max14830@61 {
> 
>                 compatible = "maxim,max14830";
> 
>                 reg = <0x61>;
> 
>                 clocks = <&i2c_uart_clk>;
> 
>                 clock-names = "osc";
> 
>                 interrupt-parent = <&gpio0>;
> 
>                 interrupts = <ASPEED_GPIO(T, 1) IRQ_TYPE_LEVEL_LOW>;
> 
>                 gpio-controller;
> 
>                 #gpio-cells = <2>;
> 
>         };
> 
> 
> 
>         max1483062: max14830@62 {
> 
>                 compatible = "maxim,max14830";
> 
>                 reg = <0x62>;
> 
>                 clocks = <&i2c_uart_clk>;
> 
>                 clock-names = "osc";
> 
>                 interrupt-parent = <&gpio0>;
> 
>                 interrupts = <ASPEED_GPIO(T, 2) IRQ_TYPE_LEVEL_LOW>;
> 
>                 gpio-controller;
> 
>                 #gpio-cells = <2>;
> 
>         };
> 
> 
> 
>         max1483064: max14830@64 {
> 
>                 compatible = "maxim,max14830";
> 
>                 reg = <0x64>;
> 
>                 clocks = <&i2c_uart_clk>;
> 
>                 clock-names = "osc";
> 
>                 interrupt-parent = <&gpio0>;
> 
>                 interrupts = <ASPEED_GPIO(T, 3) IRQ_TYPE_LEVEL_LOW>;
> 
>                 gpio-controller;
> 
>                 #gpio-cells = <2>;
> 
>         };
> 
> 
> 
>         max1483065: max14830@65 {
> 
>                 compatible = "maxim,max14830";
> 
>                 reg = <0x65>;
> 
>                 clocks = <&i2c_uart_clk>;
> 
>                 clock-names = "osc";
> 
>                 interrupt-parent = <&gpio0>;
> 
>                 interrupts = <ASPEED_GPIO(T, 4) IRQ_TYPE_LEVEL_LOW>;
> 
>                 gpio-controller;
> 
>                 #gpio-cells = <2>;
> 
>         };
> 
> };

Ok, now I see that you are using 5 MAX14830 ICs, and it seems that the
crystal is only connected to the first IC, and the other 4 remaining
ICs are supposed to be clocked from the first?

If it is like this, the driver doesn't currently support this mode of
operation. The driver do not access the register TxSynch at address $20
at all, so the bit 7 CLKtoGPIO is always set to its default value of
0...


> Kindly let me know of any ideas that we could try further.

I think it would be best to focus on making only the first MAX14830
device to work, before trying to have all 5 running at the same time,
since you are using a special mode of interconnecting the chips, and
this mode is 

So I would suggest to temporary remove in your
DTS the entries for the 4 last ICs, and keep only the first one. Then
try to make it work properly.

> 
> On a different note, I noticed something in the code where the comment might need a change.
> 
> 
> 
>         /* Use baudrate 115200 for calculate error */
> 
>         long err = f % (460800 * 16);
> 
> 
> 
> The comment says calculate baudrate 115200 while I believe the formula is implemented for a 460800 baudrate calculation.

Ok, the comment certainly seems a little bit confusing, I will try to
look into it. Thank you.

Hugo Villeneuve.
