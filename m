From: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] Revert "serial: 8250_dma: don't bother DMA with small transfers"
Date: Thu, 1 Oct 2015 12:44:55 +0200
Message-ID: <15E8D395-71C7-44D2-82BB-5B6658872F55@holtmann.org>
References: <1443617191-21013-1-git-send-email-frederic.danis@linux.intel.com> <560BE919.9020803@hurleysoftware.com> <1443622344.8361.304.camel@linux.intel.com> <560C420B.4030007@hurleysoftware.com> <1443689736.8361.322.camel@linux.intel.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1443689736.8361.322.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Frederic Danis <frederic.danis-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi Andy,

>>>> It's customary to mail the commit author in patches which revert
>>>> their work.
>>>> 
>>>>> This commit prevents from sending "big" file using Bluetooth.
>>>>> When sending a lot of data quickly through the Bluetooth 
>>>>> interface, 
>>>>> and
>>>>> after a variable amount of data sent, transfer fails with 
>>>>> error:
>>>>>    kernel: [  415.247453] Bluetooth: hci0 hardware error 0x00
> 
> Frederic, I forgot to ask how exactly the hw setup looks like?
> 
> The message above is not present in the kernel (the closest what I
> found is 
> 
> drivers/bluetooth/btintel.c:98: BT_ERR("%s: Hardware error 0x%2.2x",
> hdev->name, code);
> 
> which makes me think you have USB BT adapter attached to the same
> machine. Am I wrong?

the Bluetooth core will generate that error in case the driver does not provide hdev->hw_error callback. We have not hocked that up for the UART driver yet. Look at net/bluetooth/hci_core.c to find the common error message.

Regards

Marcel
