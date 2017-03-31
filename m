From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] serial: tegra: Map the iir register to default defines
Date: Fri, 31 Mar 2017 11:28:30 +0100
Message-ID: <c904007d-af59-c1fa-d11f-a69c4609ff84@nvidia.com>
References: <20170329184806.6577-1-oliver@schinagl.nl>
 <58DCDB54.5040005@nvidia.com>
 <83c51151685d4be7926f7f3982c59db8@bgmail102.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <83c51151685d4be7926f7f3982c59db8@bgmail102.nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shardar Mohammed <smohammed@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, Olliver Schinagl <oliver@schinagl.nl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org


On 31/03/17 11:07, Shardar Mohammed wrote:
> Verification failed on Tegra.
> Fix here is, IIR should be masked with UART_IIR_MASK  after reading the IIR register as on Tegra bit-6 is used for internal usage to know if FIFO mode is enabled.
>         while (1) {
>                 iir = tegra_uart_read(tup, UART_IIR);
> 	 +iir &= UART_IIR_MASK;

Per Olliver's original email did you pick up the other patch [0] before
applying this because that does apply the mask. I mentioned to Olliver
that this should really be a series, so it is clear that this patch is
dependent upon the other.

> -----Original Message-----
> From: Laxman Dewangan 
> Sent: Thursday, March 30, 2017 3:48 PM
> To: Olliver Schinagl <oliver@schinagl.nl>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Jiri Slaby <jslaby@suse.com>; Stephen Warren <swarren@wwwdotorg.org>; Thierry Reding <thierry.reding@gmail.com>; Alexandre Courbot <gnurou@gmail.com>
> Cc: linux-serial@vger.kernel.org; linux-tegra@vger.kernel.org; linux-kernel@vger.kernel.org; Shardar Mohammed <smohammed@nvidia.com>
> Subject: Re: [PATCH] serial: tegra: Map the iir register to default defines
> 
> 
> On Thursday 30 March 2017 12:18 AM, Olliver Schinagl wrote:
>> The tegra serial IP seems to be following the common layout and the 
>> interrupt ID's match up nicely. Replace the magic values to match the 
>> common serial_reg defines, with the addition of the Tegra unique End 
>> of Data interrupt.
>>
>> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
>> ---
> 
> Adding Shardar for verifications.
> 
> Acked-by: Laxman Dewangan <ldewangan@nvidia.com>

Furthermore does this ACK imply that you have reviewed the other patch
this one is dependent upon?

Cheers
Jon

[0] http://marc.info/?l=linux-serial&m=149081309627392&w=2

-- 
nvpublic
