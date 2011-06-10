From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: uart : lost characters when system is busy
Date: Fri, 10 Jun 2011 12:05:55 +0200
Message-ID: <4DF1EC83.5070106@parrot.com>
References: <4DF1DCA9.9060604@parrot.com> <20110610102026.01f7da05@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:36831 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750769Ab1FJKGw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 10 Jun 2011 06:06:52 -0400
In-Reply-To: <20110610102026.01f7da05@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

Alan Cox a =E9crit :
>> uart_throttle/uart_unthrottle is called from a workqueue.
>> If the system is busy, and the uart receive lot's of data, we fill t=
he tty
>> buffer, but the workqueue doesn't run and we never have a chance to =
call
>> uart_throttle. So the uart is never slow down.
>=20
> You should have around 64K of buffering (actually n_tty worst case
> should be 63.5Kbyte) that's a lot of slack so what is holding off the
> work queue for so long on your problem system ? I think that should b=
e
> answered first as it sounds like some other part of your kernel is
> misbehaving.
The uart is connected to a BT chip, and it is configured to 3 Mbps.
64K buffer is 166 ms.

Some task on the system have higher priority than the worker thread (rt=
 priority
or cgroup), and can preempt it more than 166 ms.

Also I believe some virtual usb uart (3G dongle, cdc-acm) that use high=
er rate
(more than 10 Mbps)  will have the same problem. They will fill the buf=
fer very
quickly.

>=20
>> A workaround could be to check the buffer threshold in tty_flip_buff=
er_push and
>> call throttle callback if needed.
>=20
> tty_flip_buffer_push can be called from an IRQ, the throttle callback
> needs to be able to sleep.
>=20
> What might work if it is needed though is to provide a tty_is_throttl=
ed()
> method that a driver can use to check the instantaneous throttle stat=
e.
> Trouble is that will require a lot of care on the drivers part to dea=
l
> with asynchronus throttle/unthrottle events while peering at the stat=
e in
> its IRQ handler as well.
I think tty_is_throttled() is better than checking tty_insert_flip_char=
 status,
because we know earlier that the fifo is becoming full and we don't hav=
e to save
the remaining data somewhere.

=46or example the "USB: cdc-acm: Prevent loss of data when filling tty =
buffer"
patch may be changed to something like :

    /* throttle device if requested by tty */
    spin_lock_irqsave(&acm->read_lock, flags);
    acm->throttled =3D acm->throttle_req;
    if (!acm->throttled && !acm->susp_count && !tty_is_throttled()) {
        spin_unlock_irqrestore(&acm->read_lock, flags);
        acm_submit_read_urb(acm, rb->index, GFP_ATOMIC);
    } else {
        spin_unlock_irqrestore(&acm->read_lock, flags);
    }

Matthieu
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
