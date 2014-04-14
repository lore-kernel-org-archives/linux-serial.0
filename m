From: =?UTF-8?B?S2lqYW0gTMOzcGV6?= <kijamve@gmail.com>
Subject: Re: Driver CH341 USB Adapter Serial Port not Works in Linux
Date: Mon, 14 Apr 2014 11:55:06 -0430
Message-ID: <CAMkwOQZrJkPOXK92ut06LgKqVH-pW=z+1hLTFrgq=qFoTQuEPA@mail.gmail.com>
References: <CAMkwOQZXVQkQsLfbvZFKSLeqbYJZVVdRUDXT+UYe6As4NTtrMA@mail.gmail.com>
 <20140414012013.GA1882@kroah.com> <CAMkwOQa4Wm9vnyDce_tkf3J=h73A3NfX3oAwTaOUeEVduStC4Q@mail.gmail.com>
 <20140414101320.GA19305@palmtree.beeroclock.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:57897 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755404AbaDNQZ1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 14 Apr 2014 12:25:27 -0400
In-Reply-To: <20140414101320.GA19305@palmtree.beeroclock.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Karl Palsson <karlp@tweak.net.au>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org

Yes! Thank you so much, do not know how many days I had trying to make
it work :D. That patch worked perfectly me, now if I works perfect. I
look forward to mourn :'(.

I do not understand why not even include that patch in the Kernel.



2014-04-14 5:43 GMT-04:30 Karl Palsson <karlp@tweak.net.au>:
>
>
> On Sun, Apr 13, 2014 at 08:51:56PM -0430, Kijam L=C3=B3pez wrote:
>> The following code works for me correctly in Windows, but Linux does
>> not work. I am using the same PC, both operating systems are install=
ed
>> native. I do not use virtual machine. I need to work on Linux. I hav=
e
>> tried in different linux distributions and does not work anywhere.
> [snip]
>>       if(!serial.setParity(QSerialPort::EvenParity))
>>             qCritical()<<"Error in setParity";
>
> the ch34x driver does not (yet) support parities other than None.  It=
 doesn't report a
> failure though, it just simply ignores it altogether.
>
> If you're actually working with an even parity device, you're going t=
o have all sorts of
> not-fun.  I've got a patch here: http://www.spinics.net/lists/linux-u=
sb/msg105238.html
> but I've not (yet) resubmitted it after Johan Hovold's comments
>
> Cheers,
> Karl P
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
