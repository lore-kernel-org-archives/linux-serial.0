From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 1/9] Bluetooth: hci_uart_set_flow_control: Fix NULL
 deref when using serdev
Date: Mon, 9 Oct 2017 17:15:45 +0200
Message-ID: <20171009151545.GE4269@localhost>
References: <20171004184343.7855-1-hdegoede@redhat.com>
 <20171007143645.GG2618@localhost>
 <ce49b622-212a-0e6c-2c05-9cfe3db4bd47@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ce49b622-212a-0e6c-2c05-9cfe3db4bd47@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Johan Hovold <johan@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss@gmail.com>, Sebastian Reichel <sre@kernel.org>, robh@kernel.org, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Oct 09, 2017 at 04:06:02PM +0200, Hans de Goede wrote:

> On 07-10-17 16:36, Johan Hovold wrote:
> > On Wed, Oct 04, 2017 at 08:43:35PM +0200, Hans de Goede wrote:

> >> @@ -298,6 +299,12 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
> >>   	unsigned int set = 0;
> >>   	unsigned int clear = 0;
> >>   
> >> +	if (hu->serdev) {
> >> +		serdev_device_set_flow_control(hu->serdev, !enable);
> >> +		serdev_device_set_rts(hu->serdev, !enable);
> > 
> > The order here may matter; in the non-serdev case, rts is raised before
> > enabling flow control.
> 
> AFAIK it should not matter, if RTS is not set before enabling, then CTS
> may not be set by the other side yet and the hw flow-control will
> wait for CTS to get raised.

That's not necessarily how hardware flow control is implemented. When
using auto-RTS, RTS will simply be asserted whenever there's room in the
receive FIFO.

So in fact it seems the hci_ldisc should be doing this in the reverse
order (e.g. deassert RTS before disabling auto-RTS).

Probably doesn't matter in practice here, but I would at least expect
the enable and disable cases to be each others inverses (and for the
ldisc and serdev implementations to match).

Johan
