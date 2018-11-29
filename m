From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH] dmaengine: at_hdmac: fix memory leak in at_dma_xlate()
Date: Thu, 29 Nov 2018 19:50:55 +0530
Message-ID: <20181129142054.GH3175@vkoul-mobl.Dlink>
References: <20181127160635.11836-1-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181127160635.11836-1-richard.genoud@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>, Dan Williams <dan.j.williams@intel.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Mario Forner <m.forner@be4energy.com>, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 27-11-18, 17:06, Richard Genoud wrote:
> The leak was found when opening/closing a serial port a great number of
> time, increasing kmalloc-32 in slabinfo.
> 
> Each time the port was opened, dma_request_slave_channel() was called.
> Then, in at_dma_xlate(), atslave was allocated with devm_kzalloc() and
> never freed. (Well, it was free at module unload, but that's not what we
> want).
> So, here, kzalloc is more suited for the job since it has to be freed in
> atc_free_chan_resources().

Applied, thanks

-- 
~Vinod
