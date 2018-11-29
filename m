From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH] dmaengine: at_hdmac: fix module unloading
Date: Thu, 29 Nov 2018 19:51:18 +0530
Message-ID: <20181129142118.GI3175@vkoul-mobl.Dlink>
References: <20181127160635.11836-1-richard.genoud@gmail.com>
 <20181127160635.11836-2-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181127160635.11836-2-richard.genoud@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Mario Forner <m.forner@be4energy.com>, Maxime Ripard <maxime.ripard@bootlin.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org, Ludovic Desroches <ludovic.desroches@microchip.com>, linux-serial@vger.kernel.org, dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 27-11-18, 17:06, Richard Genoud wrote:
> of_dma_controller_free() was not called on module onloading.
> This lead to a soft lockup:
> watchdog: BUG: soft lockup - CPU#0 stuck for 23s!
> Modules linked in: at_hdmac [last unloaded: at_hdmac]
> when of_dma_request_slave_channel() tried to call ofdma->of_dma_xlate().

Applied, thanks

-- 
~Vinod
