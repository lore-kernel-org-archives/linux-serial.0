From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] TTY/Serial patches for 4.1-rc1
Date: Tue, 21 Apr 2015 09:41:22 -0700
Message-ID: <CA+55aFzeqhQ=oDMoOmw_Mr6rzKRLCWC8bL1LtyXv96f-+_AtXA@mail.gmail.com>
References: <20150421101032.GA4733@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150421101032.GA4733@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>
Cc: Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Apr 21, 2015 at 3:10 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> TTY/Serial patches for 4.1-rc1
>
> Here's the big tty/serial driver update for 4.1-rc1.

This causes Kconfig annoyances:

  High Speed UART DMA support (HSU_DMA) [N/m/y] (NEW)
  High Speed UART DMA PCI driver (HSU_DMA_PCI) [N/m/y/?] (NEW)

I _just_ said "no, I don't want High Speed UART DMA support", so why
did it then ask me "do you want the High Speed UART DMA PCI driver"?

And no, there wasn't even a help-fext for that first question (and the
second one I couldn't be arsed about, at that point I just went "well,
f*ck you too").

So at the very least, the wording doesn't make sense. Or maybe that
PCI driver question should depend on the previous one? And can we
please make sure that there are help text entries for new config
options?

I pulled it, but please people, make sure this gets fixed. Our config
phase is probably _the_ most painful part of trying to get new people
involved in compiling their own kernels, so we should consider good
Kconfig language a priority. Lack of help-texts, and questions that
are annoying and make no sense are *not* helpful.

          Linus
