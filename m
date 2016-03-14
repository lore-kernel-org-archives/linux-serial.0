From: =?UTF-8?Q?Sean_Nyekj=c3=a6r?= <sean.nyekjaer@prevas.dk>
Subject: Re: [PATCH] tty: serial: sc16is7xx: implemented our own oneshot-like
 handling
Date: Mon, 14 Mar 2016 07:17:51 +0100
Message-ID: <56E6578F.6000907@prevas.dk>
References: <20160313200558.06543fce@kerio.vanmierlo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-rt-users-owner@vger.kernel.org>
In-Reply-To: <20160313200558.06543fce@kerio.vanmierlo.com>
Sender: linux-rt-users-owner@vger.kernel.org
To: Maarten Brock <m.brock@vanmierlo.com>, linux-serial@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Josh Cartwright <joshc@ni.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-rt-users@vger.kernel.org, Jon Ringle <jringle@gridpoint.com>
List-Id: linux-serial@vger.kernel.org



On 2016-03-13 20:05, Maarten Brock wrote:
> I also wonder why this driver doesn't use threaded interrupts, just like the
> MAX310x driver it is based upon.
>
> Maarten
Me too.. :-) But both I and Sebastian Andrzej Siewior have proposed a 
PATCH for that but it was turned down.
>
>
>> This driver should use a threaded interrupt instead of trying to emulate it
>> via dis/enable_irq and a worker thread.
>>
>> Then you simply call c16is7xx_port_irq() right from the interrupt routine
>> and the core code deals with the interrupt mask/unmask automatically.
>>
>> Thanks,
>>
>> 	tglx
Remember not to top post :-) and use a proper mail client that uses 
In-Reply-To...

/Sean
