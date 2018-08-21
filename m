From: Johan Hovold <johan@kernel.org>
Subject: Re: serdev: How to attach serdev devices to USB based tty devices?
Date: Tue, 21 Aug 2018 16:29:10 +0200
Message-ID: <20180821142910.GJ14967@localhost>
References: <3639955d-5990-1c82-7158-ac07b33c41f2@suse.de>
 <20180815182150.wsd5oxlucsox2qig@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180815182150.wsd5oxlucsox2qig@earth.universe>
Sender: netdev-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-usb@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>, Xue Liu <liuxuenetmail@gmail.com>, Ben Whitten <ben.whitten@lairdtech.com>, devicetree@vger.kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Oliver Neukum <oneukum@suse.com>, Alexander Graf <agraf@suse.de>, "LoRa_Community_Support@semtech.com" <LoRa_Community_Support@semtech.com>, Jian-Hong Pan <starnight@g.ncu.edu.tw>, Stefan Rehm <rehm@miromico.ch>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Aug 15, 2018 at 08:21:50PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> +cc Johan Hovold <johan@kernel.org>
> 
> Johan told me, that he is working on this at ELCE 2017. Also he is
> the subsystem maintainer of the USB serial subsystem.

I haven't done much work on this; it's more of a low-priority background
task that keeps popping up. ;)

Rob already linked to Ricardo's series in which this was recently
discussed [1][2].

In one of those threads I also posted to some code I've been using to
test serdev with USB-serial devices [3]. There are some known issues
blocking this from being merged (e.g. serdev not supporting hangups and
agreement on DT bindings), but it would otherwise allow you to use
serdev for fixed topologies (i.e. you know beforehand which port you'll
be plugging your USB-serial device into). So that might still be useful
for development purposes as is.

With DT-overlay support this could be extended also to the dynamic case
(e.g. loading overlays from userspace or passing the equivalent data
from a tty driver).

Johan


[1] https://lkml.kernel.org/r/CAPybu_0RRNMsdzv4CKyw922hX3_EF=-LKD_QWZV0DoQmjG0aRQ@mail.gmail.com
[2] https://lkml.kernel.org/r/20180611115240.32606-1-ricardo.ribalda@gmail.com
[3] https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/log/?h=usb-serial-of
