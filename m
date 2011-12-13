From: Antti Palosaari <crope@iki.fi>
Subject: Re: serial device name for smart card reader that is integrated to
 Anysee DVB USB device
Date: Tue, 13 Dec 2011 18:30:33 +0200
Message-ID: <4EE77DA9.9060102@iki.fi>
References: <4E8B7901.2050700@iki.fi> <4E8BF6DE.1010105@iki.fi> <201110051016.06291.oneukum@suse.de> <201110141932.51378.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <201110141932.51378.oliver@neukum.org>
Sender: linux-media-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Oliver Neukum <oliver@neukum.org>, linux-serial@vger.kernel.org, linux-media@vger.kernel.org, linux-usb@vger.kernel.org, =?ISO-8859-1?Q?Bj=F8rn_Mork?= <bjorn@mork.no>, James Courtier-Dutton <james.dutton@gmail.com>, HoP <jpetrous@gmail.com>, =?ISO-8859-1?Q?Istv=E1n_V=E1radi?= <ivaradi@gmail.com>
List-Id: linux-serial@vger.kernel.org

On 10/14/2011 08:32 PM, Oliver Neukum wrote:
> Am Mittwoch, 5. Oktober 2011, 10:16:06 schrieb Oliver Neukum:
>> Am Mittwoch, 5. Oktober 2011, 08:19:10 schrieb Antti Palosaari:
>>> On 10/05/2011 09:15 AM, Oliver Neukum wrote:
>>
>>>> But, Greg, Antti makes a very valid point here. The generic code assumes that
>>>> it owns intfdata, that is you cannot use it as is for access to anything that lacks
>>>> its own interface. But this is not a fatal flaw. We can alter the generic code to use
>>>> an accessor function the driver can provide and make it default to get/set_intfdata
>>>>
>>>> What do you think?
>>>
>>> Oliver, I looked your old thread reply but I didn't catch how you meant
>>> it to happen. Could you give some small example?
>
> here is the code I come up with at an early, extremely incomplete stage.
> Just for your information because I'll stop working on this for a few days.

I am back with that issue again. I just analysed both Oliver's code and 
usb-serial.c.

Problem are only these functions:
extern int usb_serial_probe(struct usb_interface *iface, const struct 
usb_device_id *id);
extern void usb_serial_disconnect(struct usb_interface *iface);
extern int usb_serial_suspend(struct usb_interface *intf, pm_message_t 
message);
extern int usb_serial_resume(struct usb_interface *intf);

as all those takes struct usb_interface as parameter. For the 
disconnect, suspend and resume it usb_interface param is used just for 
getting pointer to struct usb_serial. That's easy. The probe is more 
complex and needs some deeper changes. Main problem for probe seems to 
be also it saves struct usb_serial pointer to struct usb_interface 
usb_set_intfdata(interface, serial);

Anyhow, I would like now ask how to proceed. Should I export four new 
functions as replacement of those leaving old functionality as 
currently. Or should I change existing ones like adding new pointer for 
struct usb_serial and use it instead of struct usb_interface when not NULL.


regards
Antti

-- 
http://palosaari.fi/
