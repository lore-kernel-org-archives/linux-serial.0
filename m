From: Antti Palosaari <crope@iki.fi>
Subject: Re: serial device name for smart card reader that is integrated to
 Anysee DVB USB device
Date: Wed, 05 Oct 2011 09:19:10 +0300
Message-ID: <4E8BF6DE.1010105@iki.fi>
References: <4E8B7901.2050700@iki.fi> <20111005045917.GB4700@kroah.com> <4E8BF21B.4010907@iki.fi> <201110050815.17949.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <201110050815.17949.oneukum@suse.de>
Sender: linux-media-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Greg KH <greg@kroah.com>, linux-serial@vger.kernel.org, linux-media@vger.kernel.org, linux-usb@vger.kernel.org, =?ISO-8859-1?Q?Bj=F8rn_Mork?= <bjorn@mork.no>, James Courtier-Dutton <james.dutton@gmail.com>, HoP <jpetrous@gmail.com>, =?ISO-8859-1?Q?Istv=E1n_V=E1radi?= <ivaradi@gmail.com>
List-Id: linux-serial@vger.kernel.org

On 10/05/2011 09:15 AM, Oliver Neukum wrote:
> Am Mittwoch, 5. Oktober 2011, 07:58:51 schrieb Antti Palosaari:
>> On 10/05/2011 07:59 AM, Greg KH wrote:
>
>>> Why not just use the usb-serial core and then you get a ttyUSB* device
>>> node "for free"?  It also should provide a lot of the basic tty
>>> infrastructure and ring buffer logic all ready to use.
>>
>> Since I don't see how I can access same platform data from DVB USB  and
>> USB-serial driver (usb_set_intfdata). I asked that earlier, see:
>> http://www.mail-archive.com/linux-media@vger.kernel.org/msg36027.html
>
> Yes, and I'll have to give you the same answer as then.
>
> But, Greg, Antti makes a very valid point here. The generic code assumes that
> it owns intfdata, that is you cannot use it as is for access to anything that lacks
> its own interface. But this is not a fatal flaw. We can alter the generic code to use
> an accessor function the driver can provide and make it default to get/set_intfdata
>
> What do you think?

Oliver, I looked your old thread reply but I didn't catch how you meant 
it to happen. Could you give some small example?

regards
Antti

-- 
http://palosaari.fi/
