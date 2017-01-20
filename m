From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v10 3/3] serial: 8250_pci: remove exar code
Date: Sat, 21 Jan 2017 00:29:31 +0200
Message-ID: <CAHp75VdgtLUY4PRq=k2Yn2zf+WyYt1bVxtJ+zUtywhe4uwj5fw@mail.gmail.com>
References: <1484864602-5266-1-git-send-email-sudipm.mukherjee@gmail.com> <1484864602-5266-3-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484864602-5266-3-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Jan 20, 2017 at 12:23 AM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> From: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
>
> Remove the Exar specific codes from 8250_pci and blacklist those chips
> so that the new Exar serial driver binds to the devices.

> patch4? but those are from different vendor. They are with
> PCI_VENDOR_ID_COMMTECH. Then we should not name the file as 8250_exar.

But it seems it is using Exar behind the scenes. No?

> But if needed I can send a separate patch for that after this series is
> complete.

For me looks like logical continuation to this series. I'm fine with
separate patch later on.

-- 
With Best Regards,
Andy Shevchenko
