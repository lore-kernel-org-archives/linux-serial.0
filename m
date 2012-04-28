From: Preston Fick <Preston.Fick-S6d6foEdJf7QT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH] usb: cp210x: Added support for GPIO (CP2103/4/5)
Date: Sat, 28 Apr 2012 15:30:02 -0500
Message-ID: <00374F755A5C474884D69FBCA77349D105219FB334@EXCAUS002.silabs.com>
References: <1335632134-2488-1-git-send-email-preston.fick@silabs.com>,<20120428190502.32eaf294@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120428190502.32eaf294-38n7/U1jhRXW96NNrWNlrekiAK3p4hvP@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Preston Fick <pffick-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi Alan -

Thanks for the feedback, as only my third (and most intricate) patch I'm still getting used to this process.

Please see responses inline:

Kind Regards -
Preston
________________________________________
From: Alan Cox [alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org]
Sent: Saturday, April 28, 2012 1:05 PM
To: Preston Fick
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Preston Fick; linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: Re: [PATCH] usb: cp210x: Added support for GPIO (CP2103/4/5)

>   */
> @@ -424,8 +430,8 @@ static int cp210x_open(struct tty_struct *tty, struct usb_serial_port *port)
>
>       dbg("%s - port %d", __func__, port->number);
>
> -     result = cp210x_set_config_single(port, CP210X_IFC_ENABLE,
> -                                                             UART_ENABLE);
> +     result = cp210x_set_config(port, REQTYPE_HOST_TO_INTERFACE,
> +                             CP210X_IFC_ENABLE, UART_ENABLE, NULL, 0);

>>These kind of unrelated changes make review hard. Why are they there ?

I believe that this driver was originally developed by reverse engineering our device, and wasn't developed in a way that easily configures and calls the USB specific functions - everything is sent as a device request and certain calls actually need to be interface requests. I changed this so that it fills out the URB in a more complete way than it was before by allowing the call to contain more specific information.

I understand that this change is all over the place in this code, so I'm willing to change it back, and just use raw usb functions contained in the ones I modified. This should make it simpler and eliminate this problem.

> +     case IOCTL_GPIOGET:
> +             if ((port_priv->bPartNumber == CP2103_PARTNUM) ||


>>All the part specific stuff in ifs rapidly gets unmaintainable. Better to
>>set up a port_priv->get_gpio/set_gpio.

Can you elaborate on this a bit - I'm not sure I follow.

>  /*
>   * cp210x_get_termios
>   * Reads the baud rate, data bits, parity, stop bits and flow control mode
> @@ -490,14 +565,16 @@ static void cp210x_get_termios_port(struct usb_serial_port *port,
>
>       dbg("%s - port %d", __func__, port->number);
>
> -     cp210x_get_config(port, CP210X_GET_BAUDRATE, &baud, 4);
> +     cp210x_get_config(port, REQTYPE_INTERFACE_TO_HOST,
> +                     CP210X_GET_BAUDRATE, 0, &baud, 4);


>>And again it disturbs all the rest of the code for no apparent good
>>reason.

>>The large number of changes all over the code for a single localised
>>feature change ought to be flagging up that it's not being done in a
>>clean way.

Understood, I can plan to resubmit.

>>The other question is whether having some custom gpio poking interface is
>>actually a good idea. I suspect probably not. The kernel gpio layer can
>>help a bit but doesn't really solve the problem as there is no way to tie
>>a gpio to a port. Given how many devices seem to have gpios these days I
>>wonder if we need a gpio setting interface via termiox.

Is there a better way to get this type of support for our devices? The reason I'm adding this here is because our customers need and use this functionality. The way we do this on Windows and Mac is through custom ioctl calls, so I assumed this would be the appropriate way to do this here as well.

>>We could also the agree how that maps onto the extra gpio lines used with
>>SIM card readers and the like so we can standardise that.

I'm open to suggestions on how to properly get this implemented, so if there is some more feedback you can give to point me in the right direction I'd be glad to consider it and resubmit.

>>Alan
This message (including any attachments) is intended only for the use of the individual or entity to which it is addressed and may contain information that is non-public, proprietary, privileged, confidential, and exempt from disclosure under applicable law or may constitute as attorney work product.  If you are not the intended recipient, you are hereby notified that any use, dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, notify us immediately by telephone and (i) destroy this message if a facsimile or (ii) delete this message immediately if this is an electronic communication.  

Thank you.


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
