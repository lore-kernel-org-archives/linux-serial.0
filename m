From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [PATCH v2 2/2] tty/serial: Fix break handling for PORT_TEGRA
Date: Wed, 18 May 2011 09:10:58 +0100
Message-ID: <20110518091058.51807554@lxorguk.ukuu.org.uk>
References: <1305670357-4291-1-git-send-email-swarren@nvidia.com>
	<1305670357-4291-2-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1305670357-4291-2-git-send-email-swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: gregkh-l3A5Bk7waGM@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Tue, 17 May 2011 16:12:37 -0600
Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:

> When a break is received, Tegra's UART apparently fills the FIFO with
> 0 bytes. These must be drained so that they aren't interpreted as actual
> data received. This allows e.g. MAGIC_SYSRQ to work on Tegra's UARTs.
> 
> v2: Added FIXME comment to clear_rx_fifo

Acked-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
--
"I'm sure there were advantages to getting older but I've forgotten them"
