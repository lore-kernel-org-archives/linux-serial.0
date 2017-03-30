From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] serial: tegra: Map the iir register to default defines
Date: Thu, 30 Mar 2017 14:42:19 +0100
Message-ID: <9eed3c8e-a7af-1e1f-659a-a092a89d1679@nvidia.com>
References: <20170329184806.6577-1-oliver@schinagl.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170329184806.6577-1-oliver@schinagl.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Olliver Schinagl <oliver@schinagl.nl>, Laxman Dewangan <ldewangan@nvidia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


On 29/03/17 19:48, Olliver Schinagl wrote:
> The tegra serial IP seems to be following the common layout and the
> interrupt ID's match up nicely. Replace the magic values to match the
> common serial_reg defines, with the addition of the Tegra unique End of
> Data interrupt.
> 
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> ---
> Note I do not own any tegra hardware and just noticed it while working on my
> somewhat related previous patch,
> "serial: Do not treat the IIR register as a bitfield"
> 
> As such, this patch can only be applied after the aforementioned patch or the
> iir variable will not have its mask applied yet.

Nit-pick. If this is the case, then this should really be part of a
patch series so it is obvious to everyone that this should only be
applied after the other patch.

Cheers
Jon

-- 
nvpublic
