From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 3/3] serial: 8250_dw: add fractional divisor support
Date: Mon, 9 Jul 2018 09:15:06 +0300
Message-ID: <CAHp75VcyzV8KmPx=NXe=4s2eOTRups=XU8L4UHP3eWr=1TH7Fg@mail.gmail.com>
References: <20180704165908.4bb8b090@xhacker.debian> <20180704170310.56772d77@xhacker.debian>
 <f2733332a58e7f2d92948e2ff252581f93e5073a.camel@linux.intel.com>
 <20180705143921.6a8aeb50@xhacker.debian> <66eff871bc97f24e7fbcc2494df1bb6fdd98d8da.camel@linux.intel.com>
 <20180709140435.3996588b@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180709140435.3996588b@xhacker.debian>
Sender: linux-kernel-owner@vger.kernel.org
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Jul 9, 2018 at 9:04 AM, Jisheng Zhang
<Jisheng.Zhang@synaptics.com> wrote:
> On Fri, 6 Jul 2018 20:37:09 +0300 Andy Shevchenko wrote:

> yes, makes sense. Will send a new version soon.
Please, be sure you base it on top of tty-next and there is no
warnings added (makes sense to run make W=1 as well),

-- 
With Best Regards,
Andy Shevchenko
