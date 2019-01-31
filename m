From: shuah <shuah@kernel.org>
Subject: Re: [PATCH] tty: Fix WARNING in tty_set_termios
Date: Thu, 31 Jan 2019 16:23:02 -0700
Message-ID: <2812690e-d9d6-9755-ecb1-045e2acb4323@kernel.org>
References: <20190125232905.21727-1-shuah@kernel.org>
 <20190126041416.GF2217@ZenIV.linux.org.uk>
 <fe4018a7-19e4-cdd1-3095-bbe88a82788e@kernel.org>
 <20190130103227.GR3691@localhost>
 <D0EE5C33-2930-4286-998C-822DD7898B76@holtmann.org>
 <20190131153306.GT3691@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190131153306.GT3691@localhost>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>, Marcel Holtmann <marcel@holtmann.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, "open list:NFC SUBSYSTEM" <linux-wireless@vger.kernel.org>, chris@the-brannons.com, devel@driverdev.osuosl.org, Rob Herring <robh@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>, santhameena13@gmail.com, kirk@reisers.ca, Johan Hedberg <johan.hedberg@gmail.com>, Arnd Bergmann <arnd@arndb.de>, samuel.thibault@ens-lyon.org, m.maya.nakamura@gmail.com, zhongjiang@huawei.com, Greg KH <gregkh@linuxfoundation.org>, speakup@linux-speakup.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bluez mailing list <linux-bluetooth@vger.kernel.org>, netdev <netdev@vger.kernel.org>, nishka.dasgupta_ug18@ashoka.edu.in, "David S. Miller" <dave>
List-Id: linux-serial@vger.kernel.org

On 1/31/19 8:33 AM, Johan Hovold wrote:
> On Thu, Jan 31, 2019 at 04:18:33PM +0100, Marcel Holtmann wrote:
> 
>>> I agree with Al that this change doesn't make much sense. The WARN_ON
>>> is there to catch any bugs leading to the termios being changed for a
>>> master side pty. Those should bugs should be fixed, and not worked
>>> around in order to silence a WARN_ON.
>>>
>>> The problem started with 7721383f4199 ("Bluetooth: hci_uart: Support
>>> operational speed during setup") which introduced a new way for how
>>> tty_set_termios() could end up being called for a master pty.
>>>
>>> As Al hinted at, setting these ldiscs for a master pty really makes no
>>> sense and perhaps that is what we should prevent unless simply making
>>> sure they do not call tty_set_termios() is sufficient for the time
>>> being.
>>>
>>> Finally, note that serdev never operates on a pty, and that this is only
>>> an issue for (the three) line disciplines.
>>
>> I think for PTYs we should just fail setting the HCI line discipline.
>> Fail early and just move on with life.
> 
> Sounds good to me. At least for the pty master. There may be some people
> trying to use a bluetooth device connected to a remote serial port (I've
> seen descriptions of such setups at least), and maybe we need not prevent
> that.
> 

Thanks for the feedback on the patch. Changes to prevent setting the HCI
line discipline from hci_uart fixes the problem.

I am sending v2 in a just a bit.

thanks,
-- Shuah
