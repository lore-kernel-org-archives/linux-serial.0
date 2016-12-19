From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] serial: 8250: Avoid "too much work" from bogus rx
 timeout interrupt
Date: Mon, 19 Dec 2016 19:35:20 +0200
Message-ID: <1482168920.9552.101.camel@linux.intel.com>
References: <1482110067-5591-1-git-send-email-dianders@chromium.org>
         <1482152376.9552.96.camel@linux.intel.com>
         <CAD=FV=Uzjb9Hcmw462Rr2QG6kpPkuF0ZA1=qoKwxTP4_FdFzrQ@mail.gmail.com>
         <1482168788.9552.100.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1482168788.9552.100.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>, Peter Hurley <peter@hurleysoftware.com>, california.l.sullivan@intel.com, "Liakhovetski, Guennadi" <guennadi.liakhovetski@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jslaby@suse.com, Brian Norris <briannorris@chromium.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, =?UTF-8?Q?=E9=99=88=E6=B8=90=E9=A3=9E?= <jeffy.chen@rock-chips.com>, =?UTF-8?Q?=E9=AB=98=E7=BE=8E=E6=89=8D?= <eric.gao@rock-chips.com>, phillip.raffeck@fau.de, anton.wuerfel@fau.de, yegorslists@googlemail.com, matwey@sai.msu.ru, tthayer@opensource.altera.com, linux-serial@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, 2016-12-19 at 19:33 +0200, Andy Shevchenko wrote:
> On Mon, 2016-12-19 at 09:12 -0800, Doug Anderson wrote:

> What I think is that the root cause of this is still unknown and
> either
> above looks like a hack.

One more link:

http://www.spinics.net/lists/linux-serial/msg22316.html

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
