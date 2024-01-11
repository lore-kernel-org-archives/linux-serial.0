Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834C056756
	for <linux-serial@vger.kernel.org>; Thu, 11 Jan 2024 19:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="j6Zqg47L"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=//Qc0dCXmzWd8liBskUdDa5XOoPfjUY60q199w0iw+0=; b=j6Zqg47Lj1MPquj+aqm7ogHYGm
	8Or995eZTIxj3vrvjgU+XnPTO0+6JtoVp6NvynKIL/Wc42oDUcEtHqArQ6rR2J2EUJB1QxZjy8ry3
	dj3uBUzSzORzFC8WrHmqOr/oCxKDkGTe+5vBS4wakVDaWmRicNBCopm1T7zBoolWlFKE=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:51014 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rO0Pp-0005Ui-En; Thu, 11 Jan 2024 14:08:34 -0500
Date: Thu, 11 Jan 2024 14:08:33 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: "Srinivasan, Usha" <usha.srinivasan@cornelisnetworks.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Message-Id: <20240111140833.4d312e7e4ae11f1770df8968@hugovil.com>
In-Reply-To: <BY5PR01MB56351BA462070C585273B3909E682@BY5PR01MB5635.prod.exchangelabs.com>
References: <DM4PR01MB75952BAB0B535CF832C89AD99E6B2@DM4PR01MB7595.prod.exchangelabs.com>
	<20240108172934.c457ca06b6543f868d32de46@hugovil.com>
	<DM4PR01MB75959DD41CC90B1B704A05D29E6A2@DM4PR01MB7595.prod.exchangelabs.com>
	<20240110174015.6f20195fde08e5c9e64e5675@hugovil.com>
	<BY5PR01MB5635A9264220404AA6EA5C089E682@BY5PR01MB5635.prod.exchangelabs.com>
	<20240111115239.63d408a688b1b8783de3064f@hugovil.com>
	<BY5PR01MB56351BA462070C585273B3909E682@BY5PR01MB5635.prod.exchangelabs.com>
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
	* -2.0 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: max14830 irq
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Thu, 11 Jan 2024 17:52:18 +0000
"Srinivasan, Usha" <usha.srinivasan@cornelisnetworks.com> wrote:

> Hi, Hugo.
> Sadly, yes, I even tried a ridiculous msleep(1000) but I still get
> [    3.671189] max310x 11-006c: clock is not stable yet
> [    4.791122] max310x 11-0061: clock is not stable yet
> [    5.911719] max310x 11-0062: clock is not stable yet
> [   90.951252] max310x 11-0064: clock is not stable yet
> [  178.631326] max310x 11-0065: clock is not stable yet

Hi Usha,
strange...

But thanks for the feedback.

Hugo Villeneuve


> Thanks,
> Usha
> > -----Original Message-----
> > From: Hugo Villeneuve <hugo@hugovil.com>
> > Sent: Thursday, January 11, 2024 11:53 AM
> > To: Srinivasan, Usha <usha.srinivasan@cornelisnetworks.com>
> > Cc: linux-serial@vger.kernel.org
> > Subject: Re: max14830 irq
> >
> > On Thu, 11 Jan 2024 00:55:57 +0000
> > "Srinivasan, Usha" <usha.srinivasan@cornelisnetworks.com> wrote:
> >
> > > Hi, Hugo.
> > > Thank you. Yes, I have clock source set to xtal and thanks for the tip on the
> > delay you shared. I think my issue may be due to how I defined my interrupts in
> > the dts file for the arm.  Thanks again for your feedback!
> > > Usha
> >
> > Hi Usha,
> > if you have time, I would appreciate if you could confirm if the "stable clock"
> > warning disapears when increasing the delay to 100ms?
> >
> > Thank you,
> > Hugo.
> >
> >
> > >
> > > > -----Original Message-----
> > > > From: Hugo Villeneuve <hugo@hugovil.com>
> > > > Sent: Wednesday, January 10, 2024 5:40 PM
> > > > To: Srinivasan, Usha <usha.srinivasan@cornelisnetworks.com>
> > > > Cc: linux-serial@vger.kernel.org
> > > > Subject: Re: max14830 irq
> > > >
> > > > On Tue, 9 Jan 2024 21:25:03 +0000
> > > > "Srinivasan, Usha" <usha.srinivasan@cornelisnetworks.com> wrote:
> > > >
> > > > > Hi Hugo.
> > > > > Thanks so much for your response.
> > > > >
> > > > > I was building with 6.1 had one patch but not the other.  I
> > > > > brought over the
> > > > 2nd patch as well but made no difference.
> > > > >
> > > > > I switched from 6.1 to 6.6 which has both patches and still the same issue.
> > > > >
> > > > > What do you suggest next?
> > > > > Usha
> > > >
> > > > Hi,
> > > > let's hope that someone with more experience with this IC can help you.
> > > >
> > > > In the meantime, see my comments below...
> > > >
> > > >
> > > > > > -----Original Message-----
> > > > > > From: Hugo Villeneuve <hugo@hugovil.com>
> > > > > > Sent: Monday, January 8, 2024 5:30 PM
> > > > > > To: Srinivasan, Usha <usha.srinivasan@cornelisnetworks.com>
> > > > > > Cc: linux-serial@vger.kernel.org
> > > > > > Subject: Re: max14830 irq
> > > > > >
> > > > > > On Mon, 8 Jan 2024 19:08:08 +0000 "Srinivasan, Usha"
> > > > > > <usha.srinivasan@cornelisnetworks.com> wrote:
> > > > > >
> > > > > > > Hello,
> > > > > > > I am trying to get max14830 working on our platform and I'm
> > > > > > > seeing a stack
> > > > > > trace for each of the UARTs in my device tree.  I'm not sure
> > > > > > what the fix is.  I'm running 6.1.15-580639a (OpenBMC 2.14.0) on
> > > > > > ASPEED ast2600.  Any help appreciated.
> > > > > > > [    2.608620] max310x 11-006c: clock is not stable yet
> > > >
> > > > I assume that your clock source is defined as a crystal (xtal) in
> > > > your device tree. Is it really the case (xtal vs oscillator)?
> > > >
> > > > If yes, do you see this warning message every time? I noticed that
> > > > Boundary devices have a patch in their private repo where they
> > > > increased the delay to detect a stable crystal from 10ms to 100ms (but they
> > do not explain why).
> > > >
> > > > Can you try that:
> > > >
> > > > @@ -610,7 +610,7 @@ static u32 max310x_set_ref_clk(struct device
> > > > *dev, struct max310x_port *s, if (xtal) {
> > > >                 unsigned int val;
> > > >
> > > > -               msleep(10);
> > > > +               msleep(100);
> > > >                 regmap_read(s->regmap, MAX310X_STS_IRQSTS_REG,
> > > > &val);
> > > >
> > > > Hugo Villeneuve
> > > >
> > > >
> > > > > > > [    2.614933] 11-006c: ttyMAX0 at I/O 0x0 (irq = 57, base_baud =
> > > > 3750000) is a
> > > > > > MAX14830
> > > > > > > [    2.625532] 11-006c: ttyMAX1 at I/O 0x1 (irq = 57, base_baud =
> > > > 3750000) is a
> > > > > > MAX14830
> > > > > > > [    2.636061] 11-006c: ttyMAX2 at I/O 0x2 (irq = 57, base_baud =
> > > > 3750000) is a
> > > > > > MAX14830
> > > > > > > [    2.646513] 11-006c: ttyMAX3 at I/O 0x3 (irq = 57, base_baud =
> > > > 3750000) is a
> > > > > > MAX14830
> > > > > >
> > > > > > Hi,
> > > > > > it seems you have I2C communication with your device and the ID
> > > > > > register was read correctly in the probe() function. If it was
> > > > > > not the case, you would have an error message about that.
> > > > > >
> > > > > > > And,
> > > > > > > [   88.430219] irq 57: nobody cared (try booting with the "irqpoll"
> > > > option)
> > > > > >
> > > > > > This is probalbly happening because max310x_ist() was called,
> > > > > > but when it exited the interrupt line was still active, so that
> > > > > > it was not
> > > > handled properly.
> > > > > >
> > > > > > Can you make sure you have the following two patches in your
> > > > > > kernel
> > > > > > version:
> > > > > >
> > > > > > 984a4afdc87a ("regmap: prevent noinc writes from clobbering
> > > > > > cache") c94e5baa989f ("serial: max310x: fix IO data corruption
> > > > > > in batched
> > > > > > operations")
> > > > > >
> > > > > > I do not have hardware to test it, and this is a wild guess, but
> > > > > > they may be relevant to your problem because they enable the
> > > > > > FIFOs to be read/written properly. If Rx FIFO for example cannot
> > > > > > be read, the source of the interrupt cannot be cleared, and
> > > > > > could potentially
> > > > explain your problem.
> > > > > >
> > > > > > Hugo Villeneuve
> > > > > >
> > > > > >
> > > > > > > [   88.437720] CPU: 0 PID: 65 Comm: irq/57-11-006c Not tainted 6.1.15-
> > > > > > 580639a #1
> > > > > > > [   88.445687] Hardware name: Generic DT based system
> > > > > > > [   88.451046]  unwind_backtrace from show_stack+0x18/0x1c
> > > > > > > [   88.456906]  show_stack from dump_stack_lvl+0x40/0x4c
> > > > > > > [   88.462556]  dump_stack_lvl from __report_bad_irq+0x44/0xc8
> > > > > > > [   88.468784]  __report_bad_irq from note_interrupt+0x2c8/0x314
> > > > > > > [   88.475208]  note_interrupt from handle_irq_event+0x90/0x94
> > > > > > > [   88.481436]  handle_irq_event from handle_level_irq+0xbc/0x1b4
> > > > > > > [   88.487952]  handle_level_irq from
> > > > generic_handle_domain_irq+0x30/0x40
> > > > > > > [   88.495253]  generic_handle_domain_irq from
> > > > > > aspeed_gpio_irq_handler+0xac/0x158
> > > > > > > [   88.503326]  aspeed_gpio_irq_handler from
> > > > > > generic_handle_domain_irq+0x30/0x40
> > > > > > > [   88.511305]  generic_handle_domain_irq from
> > > > gic_handle_irq+0x6c/0x80
> > > > > > > [   88.518411]  gic_handle_irq from
> > generic_handle_arch_irq+0x34/0x44
> > > > > > > [   88.525316]  generic_handle_arch_irq from
> > call_with_stack+0x18/0x20
> > > > > > > [   88.532328]  call_with_stack from __irq_svc+0x98/0xb0
> > > > > > > [   88.537973] Exception stack(0xbf925eb0 to 0xbf925ef8)
> > > > > > > [   88.543614] 5ea0:                                     45854088 00000003 00000001
> > > > > > 00000000
> > > > > > > [   88.552742] 5ec0: 00000000 4184ee80 45854088 00000000
> > 45854000
> > > > > > 41a64140 00000000 00000000
> > > > > > > [   88.561870] 5ee0: 00000000 bf925f00 4016bb7c 4016bac0 600f0013
> > > > ffffffff
> > > > > > > [   88.569252]  __irq_svc from __wake_up_common_lock+0x1c/0xb8
> > > > > > > [   88.575483]  __wake_up_common_lock from __wake_up+0x20/0x28
> > > > > > > [   88.581714]  __wake_up from irq_thread+0x118/0x1ec
> > > > > > > [   88.587070]  irq_thread from kthread+0xd8/0xf4
> > > > > > > [   88.592040]  kthread from ret_from_fork+0x14/0x2c
> > > > > > > [   88.597288] Exception stack(0xbf925fb0 to 0xbf925ff8)
> > > > > > > [   88.602923] 5fa0:                                     00000000 00000000 00000000
> > > > > > 00000000
> > > > > > > [   88.612053] 5fc0: 00000000 00000000 00000000 00000000 00000000
> > > > > > 00000000 00000000 00000000
> > > > > > > [   88.621179] 5fe0: 00000000 00000000 00000000 00000000
> > 00000013
> > > > > > 00000000
> > > > > > > [   88.628559] handlers:
> > > > > > > [   88.631088] [<4f379e2c>] irq_default_primary_handler threaded
> > > > > > [<26199d83>] max310x_ist
> > > > > > > [   88.639952] Disabling IRQ #57
> > > > > > >
> > > > > > > __________________________
> > > > > > > Usha Srinivasan
> > > > > External recipient
> > > > >
> > > >
> > > >
> > > > --
> > > External recipient
> > >
> >
> >
> > --
> > Hugo Villeneuve
> External recipient
> 
