From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: Suggested patch for linux
Date: Thu, 10 Jul 2008 09:59:04 +0100
Message-ID: <20080710095904.16dfdb08@the-village.bc.nu>
References: <487546D5.8050908@freesurf.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <487546D5.8050908-3sKltW3hOZofv37vnLkPlQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Hosemann <axel.hosemann-3sKltW3hOZofv37vnLkPlQ@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

> Stimulated by  the RTS signal, the DCE will then engage the channel for 
> transmission and release it, after the RTS has been deasserted when the 
> buffer had been sent. This behaviour is up to now not supported by the 
> linux serial drivers.

Actually you can drive this behaviour from user space which is what
software like scarabd has done for many years.

> If you see a chance, to add this functionality for future linux kernels, 
> I would be interested in further discussions about this patch.

The big problem is that the kernel does not know what is a "transmission"
it just sees a series of writes to the device. In many cases the
multi-drop or radio systems also need the caller to wait for a
transmission slot either by beacon, by timing or by monitoring the
carrier detect to avoid collisions.

That seems to best be done in user space as the algorithms are quite
variable and some are complex.

Do we really benefit from having this in kernel ?

Alan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
