From: Rob Herring <robh@kernel.org>
Subject: Re: Problem with 761ed4a (tty: serial_core: convert uart_close to use tty_port_close)
Date: Tue, 27 Sep 2016 10:57:56 -0500
Message-ID: <CAL_JsqKWjJ3Qo44=gjqLVJK6utUtrJF5nB=EVEE1wOmFpqw-+A@mail.gmail.com>
References: <20160927110140.GG16263@bigcity.dyn.berto.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160927110140.GG16263@bigcity.dyn.berto.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: Vinod Koul <vinod.koul@intel.com>, "open list:MEDIA DRIVERS FOR RENESAS - FCP" <linux-renesas-soc@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Sep 27, 2016 at 6:01 AM, Niklas Söderlund
<niklas.soderlund@ragnatech.se> wrote:
> Hi Rob and Vinod,
>
> While testing on Renesas Koelsch board Vinods 'next' branch at
>
> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/slave-dma.git
>
> I ran into some problems with Robs patch 761ed4a (tty: serial_core:
> convert uart_close to use tty_port_close) and my systemd based init
> system. The kernel starts fine, mounts the NFS root and starts init but
> then the serial console go silent and I'm not able to communicate with
> the system.

There's a fix later in Greg's tree that's not in this tree. If that
doesn't fix it, can you try reverting the hunk that sets the
tty_port.console flag.

Rob
