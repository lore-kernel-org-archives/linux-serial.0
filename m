From: Preston Fick <Preston.Fick-S6d6foEdJf7QT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH] usb: cp210x: Added support for GPIO (CP2103/4/5)
Date: Sat, 28 Apr 2012 16:44:19 -0500
Message-ID: <00374F755A5C474884D69FBCA77349D105219FB335@EXCAUS002.silabs.com>
References: <1335632134-2488-1-git-send-email-preston.fick@silabs.com>
	<20120428190502.32eaf294@pyramind.ukuu.org.uk>
	<00374F755A5C474884D69FBCA77349D105219FB334@EXCAUS002.silabs.com>,<20120428220808.4674a8df@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120428220808.4674a8df-38n7/U1jhRXW96NNrWNlrekiAK3p4hvP@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Preston Fick <pffick-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi Alan -

More in line:

Kind Regards -
Preston
________________________________________
From: Alan Cox [alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org]
Sent: Saturday, April 28, 2012 4:08 PM
To: Preston Fick
Cc: Preston Fick; gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: Re: [PATCH] usb: cp210x: Added support for GPIO (CP2103/4/5)

> I understand that this change is all over the place in this code, so I'm willing to change it back, and just use raw usb functions contained in the ones I modified. This should make it simpler and eliminate this problem.

>>I would suggest you split this into two patches then. The first patch
>>which changes the submission handling but nothing else, and a second
>>patch which adds the GPIO functions.

For the time being I'm going add in the GPIO support using the raw usb_control_msg function, this should make the patch much simpler. Then if needed I can roll everything into a new calling mechanism later. I'll need to test with our devices then I'll resubmit tomorrow or Monday.

> Is there a better way to get this type of support for our devices? The reason I'm adding this here is because our customers need and use this functionality. The way we do this on Windows and Mac is through custom ioctl calls, so I assumed this would be the appropriate way to do this here as well.

>>I've Cc'd the linux-serial list as well to see what people think. I'd
>>like to avoid chip specific custom ioctls in favour of a standardised
>>way of doing it, but I'm not entirely sure how that should look.

>>That is really a minor detail but an important one so I'd like to see
>>what other feedback appears over the next few days (including some
>>weekdays).

Yes - I can see how something like this could be standardized, but my knowledge of the kernel outside of this driver is limited.

Hopefully this patch can get accepted with my modifications, but if a more generic access to this type of feature is available at some point I'd be glad to help get the driver using that feature instead of something so part specific, as it is now.

> >>We could also the agree how that maps onto the extra gpio lines used with
> >>SIM card readers and the like so we can standardise that.
>
> I'm open to suggestions on how to properly get this implemented, so if there is some more feedback you can give to point me in the right direction I'd be glad to consider it and resubmit.

>>For what sort of things are the GPIO lines generally used by customers ?

I would say they are mostly these would be tied to an LED of some sort, but since these are GPIO they could go to anything. I've seen some customers use them to set states from the host as well to notify whatever MCU may be attached to the RS232 side of the device. They are really just raw pins that can be set low or high for whatever is listening on the other side.

Unfortunately the number of pins and way we access them differs from device to device, and some of the CP210x's don't have GPIO at all. This patch supports our complete portfolio of this type of adapter, so this shouldn't need to be modified often, only if we decide to create a new flavor.

>>Alan

Thanks for the feedback, I agree it will be interesting to see if this sparks a more generic discussion on how the GPIO functionality could be added for multiple devices and drivers in the kernel.
This message (including any attachments) is intended only for the use of the individual or entity to which it is addressed and may contain information that is non-public, proprietary, privileged, confidential, and exempt from disclosure under applicable law or may constitute as attorney work product.  If you are not the intended recipient, you are hereby notified that any use, dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this communication in error, notify us immediately by telephone and (i) destroy this message if a facsimile or (ii) delete this message immediately if this is an electronic communication.  

Thank you.


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
