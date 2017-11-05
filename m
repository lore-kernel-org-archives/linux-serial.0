From: V10lator <v10lator@myway.de>
Subject: Re: [PATCH v4] tty: serial: meson: allow baud-rates lower than 9600
Date: Sun, 05 Nov 2017 20:34:48 +0100
Message-ID: <ed4b1e49-bbff-4d0d-beb8-a0d5843f5be1@myway.de>
References: <bb0a70cc-6cc1-46d2-aa04-046a37c9f516@myway.de>
 <20171105141206.GA31306@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171105141206.GA31306@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Am Sonntag, 5. November 2017 15:12:06 CET schrieb Greg Kroah-Hartman:
> On Sun, Nov 05, 2017 at 05:29:30AM +0100, Thomas Rohloff wrote:
>> Devices like DCF77 receivers need the baud-rate to be as low as 50.
>> 
>> I have tested this on a Meson GXL device with uart_A.
>> 
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Jiri Slaby <jslaby@suse.com>
>> Cc: Carlo Caione <carlo@caione.org> ...
>
> This is line-wrapped and can not be applied :(
>
> It's your email client, look at this setting:
> 	Content-Type: text/plain; charset=utf-8; format=flowed
>
> format=flowed does not work for kernel patches, it corruptes and edits
> them as it thinks this is just a conversation, not a machine-readable
> format.
>
> 5th try?  :)
>
> thanks,
>
> greg k-h

Thanks for explaining. I'll try a v5. :)
