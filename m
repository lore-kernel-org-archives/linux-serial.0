From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] serial: tegra: handle rx race
Date: Fri, 2 Oct 2015 17:26:30 +0100
Message-ID: <560EB036.6030407@nvidia.com>
References: <1443051326-1979-1-git-send-email-cfreeman@nvidia.com>
 <5603C158.4000002@nvidia.com> <20150925065840.GA13750@cfreeman-dt>
 <56059B27.2060902@nvidia.com>
 <CAJ--JmyA+NyTbj3_bSWVcJwsOiMS6ENWmjDvu9YtMjh5jurDqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAJ--JmyA+NyTbj3_bSWVcJwsOiMS6ENWmjDvu9YtMjh5jurDqg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hamza Farooq <hamzahfrq.sub-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Christopher Freeman <cfreeman-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org


On 01/10/15 10:30, Hamza Farooq wrote:
> Hi,
> 
> Sorry if I'm out of context. I saw this thread and found it very
> similar to the problem that we have fixed with the renesas sh-sci
> serial driver. We have made the two handlers (dma packet complete and
> timer expired) mutually exclusive by using spinlocks. Additionally,
> the race condition has been handled by not stopping the dma engine in
> timer expiry handler. If the both happen at the same time, let the dma
> packet complete handler push the data, by simply exiting the timer
> handler. If the interrupts are redirected to CPU in timer expiry
> handler, do it _only_ when you are sure no more data is coming in.

Yes that is the key. I guess if flow-control is used, then you can
prevent more data coming, otherwise I am not sure.

> The development history can be viewed at Geert Uytterhoeven's renesas
> drivers tree:
> https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git
> 
> Interesting files are drivers/tty/serial/sh-sci and drivers/dma/sh/rcar-dmac.c

Which branch are you referring to? Is this not in the mainline yet.

Thanks for the info!

Jon
