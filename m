From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 0/7] serial: exar: Fixes and cleanups
Date: Wed, 8 Feb 2017 18:24:09 +0200
Message-ID: <CAHp75Vez0H6K8gQxOLRS0npCSe9jTXbFUmhTUQEbVuae6nvdig@mail.gmail.com>
References: <cover.1486570149.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1486570149.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
List-Id: linux-serial@vger.kernel.org

On Wed, Feb 8, 2017 at 6:09 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> Changes in v2:
> - line rewrapped in patch 2 [Andy]
> - reordered PCI ID list [Andy]
> - removed obsolete constants from 8250_pci [Andy]
> - added Commtech devices to 8250_pci blacklist [Andy]
>
> Original intro:
>
> Fixes one fall-out from the exar split-up and two longer pending issue
> regarding the correct initialization of exar registers ports > 0.
> Furthermore, it moves remaining exar code over to the new module and
> also cleans up & fixes some registers defines.
>
> This includes the previously posted "Fix EXAR feature control register
> constants".
>
> Note that I have no chance to test the Commtech change on real hardware.

Overall looks good, though I left two patches without tags since I'm
not sure about them (Do we have any user space tool relied on those
bits? Is it a good idea to remove those generic predefined
descriptions? At least I'm okay with both of them, so, feel free to
add my tag if Greg is okay with them)

>  4 files changed, 117 insertions(+), 197 deletions(-)

Yoohoo! That's now realistic! I remember we started with Sudip from
something like +~650 LOC overall, now we have new GPIO driver (+200
LOC) and already -~20 LOC for the rest. And we have separate driver!

-- 
With Best Regards,
Andy Shevchenko
