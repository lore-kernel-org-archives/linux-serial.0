From: Julio Guerra <julio-wf23HAOg02MWenYVfaLwtA@public.gmane.org>
Subject: Re: cdc_acm bug? read buffer bytes shifted
Date: Sun, 21 Aug 2016 14:11:35 +0200
Message-ID: <aac2dc3d-f580-3acd-d7dd-5b415279ac2f@farjump.io>
References: <2c59e268-9fd6-172b-1803-074aa4e11f27@farjump.io>
 <1471692758.29854.0.camel@suse.com>
 <4bffb2dd-de01-8819-cf44-c4fb1357ecd4@farjump.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4bffb2dd-de01-8819-cf44-c4fb1357ecd4-wf23HAOg02MWenYVfaLwtA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

>>> Another example:
>>>> 00 00 00 00 00 00 00 01
>>> ...
>>>> 01 00 00 00 00 00 00 00
>>> ...
>>>> 00 01 00 00 00 00 00 00
>>> ...
>>>> 00 00 01 00 00 00 00 00
>>> after a random number of times, while usbmon shows the usb payload
>>> "00 00 00 00 00 00 00 01".
>>
>> Hi, how many bytes does read() return?
>>
> 
> Exactly 8 bytes, always. I set the tty in raw non-canonical mode with
> vmin = 8 and vtime = 0. I also tried with vmin = 1 and did the copy of
> exactly 8 bytes by looping in userspace, without any improvement.
> 
> I wrote a small workaround for now that detects this problem (because I
> exactly know what the buffer is supposed to look like) to close() and
> re-open() the device. The next read buffer is then correct.
> 

Some more precisions: I just had access to the FTDI version of the
device instead of the Microchip one and the bug did not appear under the
ftdi_sio driver, by running the previous script approx. 5 minutes.

-- 
Julio Guerra
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
