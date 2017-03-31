From: Shardar Mohammed <smohammed-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH] serial: tegra: Map the iir register to default defines
Date: Fri, 31 Mar 2017 10:07:15 +0000
Message-ID: <83c51151685d4be7926f7f3982c59db8@bgmail102.nvidia.com>
References: <20170329184806.6577-1-oliver@schinagl.nl>
 <58DCDB54.5040005@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <58DCDB54.5040005-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Verification failed on Tegra.
Fix here is, IIR should be masked with UART_IIR_MASK  after reading the IIR register as on Tegra bit-6 is used for internal usage to know if FIFO mode is enabled.
        while (1) {
                iir = tegra_uart_read(tup, UART_IIR);
	 +iir &= UART_IIR_MASK;

Thanks,
Shardar

-----Original Message-----
From: Laxman Dewangan 
Sent: Thursday, March 30, 2017 3:48 PM
To: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>; Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>; Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>; Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>; Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Shardar Mohammed <smohammed-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] serial: tegra: Map the iir register to default defines


On Thursday 30 March 2017 12:18 AM, Olliver Schinagl wrote:
> The tegra serial IP seems to be following the common layout and the 
> interrupt ID's match up nicely. Replace the magic values to match the 
> common serial_reg defines, with the addition of the Tegra unique End 
> of Data interrupt.
>
> Signed-off-by: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
> ---

Adding Shardar for verifications.

Acked-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
