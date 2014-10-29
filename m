From: Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH V3 09/10] tty: serial: of-serial: Allow OF earlycon to
 default to "on"
Date: Tue, 28 Oct 2014 21:12:57 -0700
Message-ID: <CAJiQ=7A8D8SgeRbJMwce=7UD6yLTjhMgQZnPHWysGqFayJrdcg@mail.gmail.com>
References: <1413930186-23168-1-git-send-email-cernekee@gmail.com>
 <1413930186-23168-10-git-send-email-cernekee@gmail.com> <CAL_Jsq+AuqTOU7UFdYi28YGjL1QorY=3zOSccN43Vb1a=q6SHw@mail.gmail.com>
 <CAJiQ=7BrfnyOQYptBCTR8GP8hLq4+q1NQ2H988wHK=8PnkqLkg@mail.gmail.com>
 <CAL_JsqJbva6i5BwDMf9f0TcuToxzP2u9_oe1t92zQXJyS077oA@mail.gmail.com> <CAJiQ=7DVSavXNYBd4yntRS-LKJMHQyxJx8Uim8Oz24rNfADcXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:36118 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbaJ2ENS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 29 Oct 2014 00:13:18 -0400
In-Reply-To: <CAJiQ=7DVSavXNYBd4yntRS-LKJMHQyxJx8Uim8Oz24rNfADcXg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Florian Fainelli <f.fainelli@gmail.com>, Maxime Bizon <mbizon@freebox.fr>, Jonas Gorski <jogo@openwrt.org>, Linux-MIPS <linux-mips@linux-mips.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Thu, Oct 23, 2014 at 7:31 AM, Kevin Cernekee <cernekee@gmail.com> wrote:
>> I think we'd just have to add a noearlycon option instead if we made
>> it the default. It's never been the default before, so I don't think
>> we should change now. There's also an implicit requirement that the
>> bootloader has configured the uart already. You could easily hang if
>> the uart has not been setup.
>
> EARLY_PRINTK is enabled by default on MIPS platforms that support it.
> I have been using this for years and found it very helpful in
> debugging failures in the kernel boot process (especially intermittent
> ones).
>
> But for a new platform it is better to use earlycon as earlycon
> provides a clean way of reading the UART information out of DT.  My
> original bcm3384 (MIPS) port used EARLY_PRINTK but I recently
> converted it to earlycon.  The last remaining goal is to get it
> enabled by default again.

Hi Rob,

Do you think we should just drop this patch for now, and use these
options to append "earlycon" to the bootloader-supplied command line:

CONFIG_CMDLINE_BOOL=y
CONFIG_CMDLINE="earlycon"
CONFIG_CMDLINE_OVERRIDE=n

If you have other suggestions on how to enable earlycon by default, I
would be happy to help implement them.

Thanks!
