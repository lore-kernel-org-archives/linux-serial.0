From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC lora-next 5/5] HACK: net: lora: sx130x: Add PicoCell gateway
 shim for cdc-acm
Date: Fri, 4 Jan 2019 11:07:45 -0600
Message-ID: <CAL_Jsq+BMOvRLEbD2Eo2D=n446vSubeXV3-FbkBSHjpfL=LYsg@mail.gmail.com>
References: <20190104112131.14451-1-afaerber@suse.de> <20190104112131.14451-6-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190104112131.14451-6-afaerber@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc: linux-lpwan@lists.infradead.org, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux USB List <linux-usb@vger.kernel.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Johan Hovold <johan@kernel.org>, "David S. Miller" <davem@davemloft.net>, Oliver Neukum <oneukum@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, netdev <netdev@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Jan 4, 2019 at 5:21 AM Andreas F=C3=A4rber <afaerber@suse.de> wrote=
:
>
> Ignore our device in cdc-acm probing and add a new driver for it,
> dispatching to cdc-acm for the actual implementation.
>
> WARNING: It is likely that this VID/PID is in use for unrelated devices.
> Only the Product string hints what this really is in current v0.2.1.
> Previous code v0.2.0 was using a Semtech VID/PID, but no card shipping
> with such firmware is known to me.
>
> While this may seem unorthodox, no internals of the driver are accessed,
> just the set of driver callbacks is duplicated as shim.
>
> Use this shim construct to fake DT nodes for serdev on probe.
> For testing purposes these nodes do not have a parent yet.
> This results in two "Error -2 creating of_node link" warnings on probe.

It looks like the DT is pretty static. Rather than creating the nodes
at run-time, can't you create a dts file and build that into your
module.

Rob
