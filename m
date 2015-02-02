From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 1/4] tty: serial: Add 8250 earlycon to support noinit
 option
Date: Mon, 02 Feb 2015 00:43:50 -0500
Message-ID: <54CF0E96.10703@hurleysoftware.com>
References: <1421068104-30463-1-git-send-email-eddie.huang@mediatek.com>	 <1421068104-30463-2-git-send-email-eddie.huang@mediatek.com>	 <54CE53F3.5040709@hurleysoftware.com> <54CE6FD9.5030606@hurleysoftware.com>	 <1422846994.5512.25.camel@mtksdaap41> <54CEF2C8.1050808@hurleysoftware.com>	 <20150202042843.GA24765@kroah.com> <54CF07F3.2040100@hurleysoftware.com>	 <20150202052423.GA3346@kroah.com> <1422855202.26131.31.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1422855202.26131.31.camel@mtksdaap41>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vladimir Murzin <vladimir.murzin-5wv7dgnIgG8@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yh.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Howard Chen <ibanezchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ashwin Chaugule <ashwin.chaugule-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "Joe.C" <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On 02/02/2015 12:33 AM, Eddie Huang wrote:
> Hi Peter,
> 
> On Sun, 2015-02-01 at 21:24 -0800, Greg Kroah-Hartman wrote:
>> On Mon, Feb 02, 2015 at 12:15:31AM -0500, Peter Hurley wrote:
>>> On 02/01/2015 11:28 PM, Greg Kroah-Hartman wrote:
>>>> On Sun, Feb 01, 2015 at 10:45:12PM -0500, Peter Hurley wrote:
>>>>> On 02/01/2015 10:16 PM, Eddie Huang wrote:
>>>
>>>>> I'll respin proper patches on top of Greg's tty-testing branch with reverts
>>>>> for the noinit options. I noticed that one of the noinit patches actually
>>>>> has the linkage for the mtk earlycon, so I'll be sure to preserve that.
>>>>
>>>> I can just drop the patches in the tty-testing branch, that's what it is
>>>> there for :)
>>>>
>>>> Just let me know the specific patches and I will do so, thanks.
>>>
>>> Well that pretty much means dropping the 3 patches that add earlycon to
>>> 8250_mtk and then applying my patch (needs fixed to apply cleanly, which
>>> I can do) and then applying a fixed-up replacement patch to add earlycon
>>> to 8250_mtk (which I can also supply).
>>>
>>> Is that the way you want to go?
>>
>> Sounds good to me, send your patch, and I'll fix it all up tomorrow.
>>
>> thanks,
>>
>> greg k-h
> 
> Actually, your patch is a little different from my original idea.
> Although my use case only care about divisor now, but other hardware
> setting is still hard-code, not from parameter. In init_port()
> function:   
> 	serial8250_early_out(port, UART_LCR, 0x3); /* 8n1 */
> 	serial8250_early_out(port, UART_IER, 0);/* no interrupt */
> 	serial8250_early_out(port, UART_FCR, 0); /* no fifo */
> 	serial8250_early_out(port, UART_MCR, 0x3); /* DTR + RTS */
> 
> This is why I propose a new option "noinit".
> 
> After checking further, in my case, I found that your patch should be
> unnecessary because if skip baudrate, probe_baud() read DLL/DLM register
> and init_port() write the same DLL/DLM value back, no touch any high
> speed register, which means keep uart divisor setting as loader
> 
> Since I don't take "console=uart,mmio32,<addr>,noinit" into
> consideration, it is good to drop my patches in the tty-testing branch.
> For my case, I can send another series without noinit, just 8250_mtk.c
> and its linkage modification in 8250_early.c

Ok.

Greg,

The patches to drop from tty-testing are:
* 405017d Document: Modify 8250 earlycon kernel parameters
* 0dff3a4 tty: serial: 8250_mtk: Add earlycon
* b829735 tty: serial: Add 8250 earlycon to support noinit option

Regards,
Peter Hurley
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
