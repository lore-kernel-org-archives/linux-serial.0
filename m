From: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] tty: Re-add external interface for tty_set_termios()
Date: Tue, 21 Apr 2015 09:04:18 -0700
Message-ID: <5F75AEFB-A885-465E-9A5E-032B9380D226@holtmann.org>
References: <1428671585-13310-1-git-send-email-frederic.danis@linux.intel.com> <5527CEFB.5070406@hurleysoftware.com> <20150421090640.GB1569@kroah.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150421090640.GB1569-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Frederic Danis <frederic.danis-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "bluez mailin list (linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org)" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, jslaby-AlSwsSmVLrQ@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi Greg,

>>> This is needed by Bluetooth hci_uart module to be able to change speed
>>> of Bluetooth controller and local UART.
>> 
>> Because this is the lesser evil right now,
>> 
>> Reviewed-by: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
> 
> Does this need to be in 4.1-rc1?  Or is this a 4.2 thing?

if you can queue this up for 4.1-rc1, that would be great. We are using it. It is just the driver using it did not make it to 4.0-rc1 yet.

Regards

Marcel
