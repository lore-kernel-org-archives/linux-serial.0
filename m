From: Alan Ott <alan@signal11.us>
Subject: Re: Plug and play for a tty line disciple networking device
Date: Wed, 20 Mar 2013 21:33:25 -0400
Message-ID: <514A6365.4010305@signal11.us>
References: <CAKON4OxNV85-J8C-hodpq9pY5tRCT+7aYa=m4T3Vk04XSGhOrA@mail.gmail.com> <20130320232645.GC19779@kroah.com> <CAKON4Oz+2DfzeOcvmKgi3ADAtyC5ie5-22uUQdfH_gcqeaDSYA@mail.gmail.com> <20130321001424.GA27981@kroah.com> <CAKON4OyB6Tc_NSYjb9HRjpzZJOTEZowoYB8NeJwtO6T42wegBg@mail.gmail.com> <20130321003817.GA28389@kroah.com> <CAKON4OxceqF8LJa9L+QZ_jznFbD0VE+2PejdZWTpOC+gdU2vHg@mail.gmail.com> <20130321005604.GA28671@kroah.com> <CAKON4OzONj=mvaXrj+JdHBwA1ye422heHVu-nFaGdPiz1rHL9A@mail.gmail.com> <514A6039.50200@signal11.us> <CAKON4OxxY8cub9m9_u7Md_0AUvogJdSswvUD2j0X2KgvxOsjQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38498 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752479Ab3CUBdY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 20 Mar 2013 21:33:24 -0400
In-Reply-To: <CAKON4OxxY8cub9m9_u7Md_0AUvogJdSswvUD2j0X2KgvxOsjQw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org

On 03/20/2013 09:28 PM, jonsmirl@gmail.com wrote:
> On Wed, Mar 20, 2013 at 9:19 PM, Alan Ott <alan@signal11.us> wrote:
>> On 03/20/2013 09:12 PM, jonsmirl@gmail.com wrote:
>>> On Wed, Mar 20, 2013 at 8:56 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
>>>> On Wed, Mar 20, 2013 at 08:49:50PM -0400, jonsmirl@gmail.com wrote:
>>>>> On Wed, Mar 20, 2013 at 8:38 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
>>>>>> On Wed, Mar 20, 2013 at 08:25:15PM -0400, jonsmirl@gmail.com wrote:
>>>>>>> On Wed, Mar 20, 2013 at 8:14 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
>>>>>>>> On Wed, Mar 20, 2013 at 08:04:29PM -0400, jonsmirl@gmail.com wrote:
>>>>>>>>> On Wed, Mar 20, 2013 at 7:26 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
>>>>>>>>>> On Tue, Mar 19, 2013 at 11:30:05AM -0400, jonsmirl@gmail.com wrote:
>>>>>>>>>>> How can you achieve plug and play for a ft2232 based USB serial device
>>>>>>>>>>> implementing 802.15.4 networking?
>>>>>>>>>>>
>>>>>>>>>>> The device has a 802.15.4 SOC with a UART attached to a ft2232. With
>>>>>>>>>>> firmware loaded the only thing it can do is talk the 802.15.4 tty line
>>>>>>>>>>> discipline, it is not a general purpose serial port.
>>>>>>>>>>>
>>>>>>>>>>> Right now the device works by plugging it in and it appears as a
>>>>>>>>>>> generic USB serial device like ttyUSB0. You then run a user space app
>>>>>>>>>>> which sets the line discipline, holds the port open and attaches it to
>>>>>>>>>>> the 6lowpan implementation in the networking code. But doing that is
>>>>>>>>>>> inconvenient and users needs to be trained to do it. Much simpler if
>>>>>>>>>>> we could just plug the device in and it worked.
>>>>>>>>>>>
>>>>>>>>>>> We can add a EEPROM to the ft2232 to give it a unique USB ID.  Is it
>>>>>>>>>>> possible to make a kernel driver that see this ID, sets the line
>>>>>>>>>>> discipline and wires the serial port directly into the networking
>>>>>>>>>>> code?
>>>>>>>>>> Yes, you can do that.
>>>>>>>>> Is there an existing driver in the kernel that does this?
>>>>>>>>> So far all of the ones I've checked still need a user space app.
>>>>>>>> Look at the bluetooth drivers, they have their own line dicipline I
>>>>>>>> think.
>>>>>>> Bluetooth drivers use line discipline on UARTs. On USB they have their
>>>>>>> own set of Bluetooth descriptors.
>>>>>>>
>>>>>>> CAN over serial has a line discipline but it needs a user space app.
>>>>>> In your driver, just attach the line discipline directly to the tty
>>>>>> device you create.  You will not be using the "normal" usb-serial logic
>>>>>> at all if you do this, but you should be fine, right?
>>>>> USB serial port is based on the FT2232 so we've been using that driver.
>>>>>
>>>>> Modifying that driver was my plan for doing this. I was hoping that
>>>>> there was a more generic way to achieve the same effect.
>>>> No, sorry, stick with doing this from userspace, it's a simple one-line
>>>> udev rule, right?
>>> It is fairly simple to do from user space. But you have to find and
>>> install the pointless user space app and then get it pointed at the
>>> correct tty.
>> The udev rule would handle calling izattach automatically.
>>
>>> That app is a hold over from the ancient days. When you killed it the
>>> serial line would drop the line discipline and revert back to a
>>> terminal session.
>>>
>>> What you really want is for devices in this class is to not create a
>>> user space tty device at all. They should just make a net-device. But
>>> there is no way to suppress the creation of the user space tty device.
>>> So we get two both devices and the xx-attach app.
>> The udev rule would run when the device gets attached and would call
>> izattach without any need for user interaction. The user would never
>> even need to know what /dev/ttyUSBx ever got assigned to it.
> We can just leave everything the way it is, but I hit this same
> problem on another project a few years ago.
>
> There's just no generic solution in the kernel for handling serially
> connected networking hardware without having a pointless user space
> app.
>
> Maybe we could make a generic pointless app and get rid of hciattach,
> canattach, izattach, etc. The generic app would get the line
> discipline as part of the udev rule.  Even better - put the generic
> xx-attach code inside udev so we don't have pointless processes
> hanging around.

Actually, you could use stty for that in the udev rule. You'd have to
use the line discipline number instead of the name, but those are part
of the userspace ABI, so they won't change.

