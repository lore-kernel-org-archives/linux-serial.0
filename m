From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH] serial: tegra: Map the iir register to default defines
Date: Thu, 30 Mar 2017 15:47:56 +0530
Message-ID: <58DCDB54.5040005@nvidia.com>
References: <20170329184806.6577-1-oliver@schinagl.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170329184806.6577-1-oliver@schinagl.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Olliver Schinagl <oliver@schinagl.nl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Shardar Mohammed <smohammed@nvidia.com>
List-Id: linux-serial@vger.kernel.org


On Thursday 30 March 2017 12:18 AM, Olliver Schinagl wrote:
> The tegra serial IP seems to be following the common layout and the
> interrupt ID's match up nicely. Replace the magic values to match the
> common serial_reg defines, with the addition of the Tegra unique End of
> Data interrupt.
>
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> ---

Adding Shardar for verifications.

Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
