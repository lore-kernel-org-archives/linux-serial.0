Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48477C433FE
	for <linux-serial@archiver.kernel.org>; Tue,  1 Nov 2022 14:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiKAOQM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Nov 2022 10:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiKAOQK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Nov 2022 10:16:10 -0400
Received: from first.geanix.com (first.geanix.com [116.203.34.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C5A18E37
        for <linux-serial@vger.kernel.org>; Tue,  1 Nov 2022 07:16:09 -0700 (PDT)
Received: from xps.localdomain (85.184.138.169.dynamic.dhcp.aura-net.dk [85.184.138.169])
        by first.geanix.com (Postfix) with ESMTPSA id AA9735790A;
        Tue,  1 Nov 2022 14:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1667312164; bh=bDaV/c3CKErIyQEANf4vztfrbaHR5q+yhT8OxW0D1yc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=SYFj+fzlweusmL71GKAoAesbnuI1Do+CtQ+h/DuLhbgHJM8+ppqyzgA9vgrHeq+TS
         A5Ao5qJ45qXy0rQyI6hGVz1tmDPdq2UDqP0vZsPpML+Y8hz2SCWOVKPkV9FBNfbtHk
         3XokN8j4Q1sYiMnZFjMzy/bcvTT1NfIzsU71cc0tenKl7Ix2RQZwFsfccRQa90Rqfy
         qIMlp2F8zpCD/oYll0nxeTistMB3pk0jtl5ammQj0OnK1bJIdklmHcWAGgmMSqxL/d
         3cel8aCwMRFe+WQGRtkIY7NyPV0lStXn/PRQTNmc9+q4kPwTM0Cn1fmXglhvab4g63
         58AaXBmAkAorA==
Date:   Tue, 1 Nov 2022 15:16:03 +0100
From:   Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] serial: 8250: skip platform device registration
 with no runtime ports
Message-ID: <20221101141603.u4bqn5qx7y7tzzzr@xps.localdomain>
References: <20221025073944.102437-1-martin@geanix.com>
 <20221025073944.102437-3-martin@geanix.com>
 <c1642f35-6270-7155-795d-a3f7324f799c@linux.intel.com>
 <b6619d9-5b91-e06c-f2a0-af92128937d2@linux.intel.com>
 <d27b3f5d-8766-fa1c-c369-31ebe344f87@linux.intel.com>
 <9320837b-1b8a-9ddf-7de8-d75816fb209b@geanix.com>
 <7ba1dd5b-7b9e-50a1-7539-41533c8d4c94@linux.intel.com>
 <b1a1680d-d226-e6b5-ac6e-25e0827dca25@geanix.com>
 <566134f-fd72-d8e6-f5ba-a97062b4189@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <566134f-fd72-d8e6-f5ba-a97062b4189@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Nov 01, 2022 at 03:22:33PM +0200, Ilpo Järvinen wrote:
> On Tue, 1 Nov 2022, Martin Hundebøll wrote:
> > On 01/11/2022 12.44, Ilpo Järvinen wrote:
> > > On Tue, 1 Nov 2022, Martin Hundebøll wrote:
> > > > On 28/10/2022 11.40, Ilpo Järvinen wrote:
> > > > > On Fri, 28 Oct 2022, Ilpo Järvinen wrote:
> > > > > > =0 did work as expected due to this change which I tested and some
> > > > > > other
> > > > > > values >4 but there now seems to be problem of the console not showing
> > > > > > up
> > > > > > like previously when I don't give nr_uarts at all.
> > > > > 
> > > > > NAK from me until the problem is resolved adequately.
> > > > > 
> > > > > Already the patch 1/4 causes an unacceptable reassignment of ttySx
> > > > > targets. This is going to break people's cmdline console setups so you
> > > > > need to find a better way.
> > > > > 
> > > > > Before any of these patches:
> > > > > 
> > > > > [    0.000000] Command line: console=ttyS0,115200n8 8250.nr_uarts=4
> > > > > [    0.021031] Kernel command line: console=ttyS0,115200n8
> > > > > 8250.nr_uarts=4
> > > > > [    0.441924] printk: console [ttyS0] enabled
> > > > > [    2.243165] printk: console [ttyS0] disabled
> > > > > [    2.245682] dw-apb-uart.6: ttyS0 at MMIO 0x4010006000 (irq = 33,
> > > > > base_baud = 115200) is a 16550A
> > > > > [    4.010237] printk: console [ttyS0] enabled
> > > > > [    5.933887] dw-apb-uart.7: ttyS1 at MMIO 0x4010007000 (irq = 16,
> > > > > base_baud = 6250000) is a 16550A
> > > > > [    5.952829] dw-apb-uart.8: ttyS2 at MMIO 0x4010008000 (irq = 17,
> > > > > base_baud = 6250000) is a 16550A
> > > > > 
> > > > > After 1/4 ttyS0 is no longer the same:
> > > > > 
> > > > > [    0.000000] Command line: console=ttyS0,115200n8 8250.nr_uarts=4
> > > > > [    0.021023] Kernel command line: console=ttyS0,115200n8
> > > > > 8250.nr_uarts=4
> > > > > [    0.441872] printk: console [ttyS0] enabled
> > > > > [    2.233584] dw-apb-uart.6: ttyS4 at MMIO 0x4010006000 (irq = 33,
> > > > > base_baud = 115200) is a 16550A
> > > > > [    2.241955] dw-apb-uart.7: ttyS5 at MMIO 0x4010007000 (irq = 16,
> > > > > base_baud = 6250000) is a 16550A
> > > > > [    2.249804] dw-apb-uart.8: ttyS6 at MMIO 0x4010008000 (irq = 17,
> > > > > base_baud = 6250000) is a 16550A
> > > > 
> > > > Thanks for testing this.
> > > > 
> > > > The old behavior is wrong: your designware ports replace the built-in ones
> > > > (0
> > > > to 3) instead of using the unused ones (4 to 31). With these patches, it
> > > > acts
> > > > as I'd expect: the built-in ports are kept, and any later discovered ports
> > > > follow.
> > > > 
> > > > Yes, breaking existing systems in this way is unacceptable. I'm not sure
> > > > how
> > > > to approach this, but I'm inclined to introduce a new config variable to
> > > > keep
> > > > the broken behavior?
> > > 
> > > To me this looks now more an attempt to repurpose the nr_uarts to mean
> > > something it really hasn't. Clearly it hasn't meant non-discoverable
> > > ports earlier but something related to the maximum number ports. This also
> > > explains why we had that misunderstanding about the meaning of nr_uarts
> > > between us earlier.
> > 
> > I was confused about the relation between SERIAL_8250_NR_UARTS and
> > SERIAL_8250_RUNTIME_UARTS, and started digging through the code. The
> > description of NR_UARTS clearly states that it controls the number of
> > *supported* uarts, but I found that it was in fact controlled by RUNTIME_UARTS
> > (8250.nr_uarts).
> >
> > With the current behavior, ever setting NR_UARTS to anything different from
> > RUNTIME_UARTS makes no sense, since the code only loops until RUNTIME_UARTS.
> 
> One is there to size the array (max you can have with a particular build
> of a kernel ever). The other is to control the maximum number of ports per 
> boot. I'd guess the former is there mainly for legacy reason from the era 
> when memory really was scarser resource than it is today.

Oh, I see.

> > Both Arch Linux and Fedora have come to the same conclusion, since they set
> > both configs to 32. So now I have 32 useless /dev/ttyS* nodes on my laptop. If
> > you run ubuntu on a machine with no uart hardware attached, you'll get 48
> > useless ttyS* nodes, of which only the first 32 will ever be available for
> > real hardware.
> 
> Why load the driver then at all, if there's no need/hw for it? Ironically, 
> setting nr_uarts (as it is) to a smaller value would reduce that waste 
> and in case of =0 the driver wouldn't be loaded.

We have some PCIe attached UARTs that doesn't appear until after the
system is up and running (they sit behind an FPGA controlled from
userspace.) Some revisions have built-in UARTs while others don't, and I
would like to run the same kernel, rootfs, and boot configuration on all
of them.

> I know distros will do it but that's their policy decision that doesn't 
> really belong here. If there's hw/need for any users of a distro, they 
> provide the support in the most generic way that makes things easy for 
> them/users, that is, by having sufficient number of ports for (almost) all 
> usecases.
> 
> In addition, to me n useless ports just sitting there doesn't sound that 
> serious issue that it would warrant breaking setups that currently depend 
> on certain ttyS numbers (I suppose you actually agree with this point).

Agreed. Although we have seen races between the DELETE and ADD uevents
mentioned below, leading to non-deterministical device numbers.

> > If you look at uevents from 8250 when the designware ports are discovered,
> > you'll see a DELETE of the built-in ttyS0 first, and then an ADD of the
> > designware ttyS0. My understanding is that we should never have had that
> > built-in ttyS0 in the first place?
> 
> I certainly suspect the built-in one really isn't there (in ACPI) but I 
> don't want to spend my time on confirming the obvious.

From a system booted with these patches, and 8250.nr_uarts=0, I get two
ports from ACPI PNP:

# cat /sys/class/tty/ttyS0/port
0x3F8
# cat /sys/class/tty/ttyS1/port
0x2F8

which matches the SERIAL_PORT_DNFS define in arch/x86/include/asm/serial.h

> > > The code which makes this "wrong behavior" to happen is the last loop in
> > > serial8250_find_match_or_unused(). Given its comment, I think it has been
> > > very much intentional behavior. Pretending that non-discoverable port is
> > > more real/precious than a port that was later _discovered_ and is very
> > > much a real one is what brings you to this renumbering issue.
> > 
> > The serial8250_find_match_or_unused() logic exists to relate non-discoverable
> > ports to those discovered later through ACPI PNP. Some of my systems announces
> > those built-in ports with ACPI, in which case the discovered ports are
> > assigned to their "built-in" numbers.
> > 
> > I believe all systems running today announce these built-in ports through ACPI
> > PNP, but they are still usable as early consoles, so this special logic is
> > still needed?
> 
> Unfortunately, I don't know the answer to whether it is a safe assumption 
> or not.
> 
> > > I'm not anymore sure about your goals really. Now it sounds one of the
> > > goals is preserving the non-discoverable ports, whereas previously it was
> > > just about allowing 0 of them.
> > 
> > My initial goal was to rely on discoverable ports only. Some of our systems
> > have no built-in uarts, so the bash init script failed to even start, because
> > the kernel command line had console=ttyS0, and bash tried to do set terminal
> > attributes on it. I am only trying to fix the code "the right way", but that
> > might not be possible without breaking numbering fo existing systems.
> 
> Again I don't follow the reasoning fully here. What is your end goal here 
> in this scenario. You'd either want to have no ports to appear at all or 
> have a non-discoverable (=bogus) port as ttyS0. Which way it is?
> 
> If you, on the other hand, would have a discoverable port that will take 
> over ttyS0, I don't understand why it fails so it seemingly leaves only 
> those two options I gave.

My endgoal is to avoid a bogus ttyS0, but a working driver (for the PCIe
connected ports).

I still think it seems wrong to have non-working device nodes. They only
confuse both people and software:

% sudo stty -F /dev/ttyS0
stty: /dev/ttyS0: Input/output error

> > > How about you add entirely new CONFIG and/or param for this minimum number
> > > of non-discoverable ports and make the last resort loop (or perhaps all
> > > but the first loop) in serial8250_find_match_or_unused() to honor that
> > > (start looking only from port above that index). If it defaults to 0, I
> > > think this renumbering issue is avoided. Would it work for all the goals
> > > you have?
> > 
> > That would work for me. But shouldn't we clean up the 
> > SERIAL_8250_NR_UARTS vs. SERIAL_8250_RUNTIME_UARTS also?
> 
> I'm not convinced there's something wrong with it. It's legacy yes, but
> the max ports compiled in vs max ports per boot is not wrong/buggy as is.

Your interpretation of those two makes sense, but I don't really see a
usecase for setting 8250.nr_uarts at boot time though.

// Martin
