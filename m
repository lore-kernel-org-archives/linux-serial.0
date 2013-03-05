From: Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [Fwd: [PATCH v2 0/4] TTY: port hangup and close fixes]
Date: Tue, 05 Mar 2013 22:56:57 +0100
Message-ID: <51366A29.2060808@suse.cz>
References: <1362085054.3337.20.camel@thor.lan> <51361724.4050107@suse.cz> <1362503170.18799.33.camel@thor.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1362503170.18799.33.camel-AsKIXgLx6sE@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Cc: jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On 03/05/2013 06:06 PM, Peter Hurley wrote:
>>> @@ -225,15 +232,13 @@ void tty_port_hangup(struct tty_port *port)
>>         spin_lock_irqsave(&port->lock, flags);
>>         port->count = 0;
>>         port->flags &= ~ASYNC_NORMAL_ACTIVE;
>> -       if (port->tty) {
>> +       if (port->tty)
>>                 set_bit(TTY_IO_ERROR, &port->tty->flags);
>> -               tty_kref_put(port->tty);
>> -       }
>> -       port->tty = NULL;
>>         spin_unlock_irqrestore(&port->lock, flags);
>>> +       tty_port_shutdown(port, port->tty);
>>
>> What prevents port->tty to be NULL here already?
> 
> Nothing. That's why it's tested in tty_port_shutdown() above.

I know :). But the question is rather don't we want to pass the real
refcounted port->tty (take a snapshot inside the lock) instead?

thanks,
-- 
js
suse labs
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
